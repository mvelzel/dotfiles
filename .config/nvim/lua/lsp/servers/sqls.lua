local sqls = {
    name = "sqls",
    disable = true
}

local query_time = ""

local function format_time_diff(milliseconds)
    local hours = math.floor((milliseconds / (1000 * 60 * 60)) % 24)
    local minutes = math.floor((milliseconds / (1000 * 60)) % 60)
    local seconds = math.floor((milliseconds / 1000) % 60)

    local hours_text = hours > 0 and tostring(hours) .. "h " or ""
    local minutes_text = minutes > 0 and tostring(minutes) .. "m " or ""
    local seconds_text = tostring(seconds) .. "s"

    return hours_text .. minutes_text .. seconds_text
end

local function start_query_timer()
    local query_start = vim.loop.now()
    local query_time_update = vim.loop.new_timer()

    query_time = "0s"
    if query_time_update == nil then return end
    query_time_update:start(1000, 1000, vim.schedule_wrap(function()
        if query_time == "" then
            if query_time_update ~= nil then
                query_time_update:close()
            end
            return
        end
        local query_time_diff = vim.loop.now() - query_start
        query_time = format_time_diff(query_time_diff)
    end))
end

local function sqls_execute_query(client_id, range, callback)
    local lspclient = vim.lsp.get_client_by_id(client_id)
    lspclient.request(
        "workspace/executeCommand",
        {
            command = "executeQuery",
            arguments = { vim.uri_from_bufnr(0), nil },
            range = range
        },
        callback
    )
end

local function get_existing_query_result_window()
    for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
        if vim.api.nvim_tabpage_is_valid(tabpage) then
            for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
                if vim.api.nvim_win_is_valid(winid) then
                    local winbufnr = vim.api.nvim_win_get_buf(winid)
                    if vim.bo[winbufnr].filetype == "TabQueryResult" then
                        return winid
                    end
                end
            end
        end
    end

    return nil
end

local function open_query_result_in_tab()
    local tab_buffer = vim.api.nvim_create_buf(true, true)
    vim.bo[tab_buffer].swapfile = false
    vim.bo[tab_buffer].bufhidden = "wipe"
    vim.bo[tab_buffer].filetype = "TabQueryResult"

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    vim.api.nvim_buf_set_lines(tab_buffer, 0, -1, true, lines)
    vim.bo[tab_buffer].modifiable = false

    local existing_result_window = get_existing_query_result_window()
    if existing_result_window then
        vim.api.nvim_set_current_win(existing_result_window)
        vim.cmd("vsp")
        local new_result_window = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(new_result_window, tab_buffer)
    else
        vim.cmd("-tab sb " .. tostring(tab_buffer))
    end
    vim.wo.wrap = false;
end

local function on_query_result(err, result)
    query_time = ""
    if err then
        vim.notify("sqls: " .. err.message, vim.log.levels.ERROR)
        return
    end
    if not result then
        return
    end

    local lines = vim.split(result, "\n")

    local result_buffer = vim.api.nvim_create_buf(false, true)
    vim.bo[result_buffer].filetype = "FloatQueryResult"
    vim.api.nvim_buf_set_lines(result_buffer, 0, -1, true, lines)

    vim.keymap.set("n", "t", open_query_result_in_tab, { silent = true, noremap = true, buffer = result_buffer })

    require("util.window").make_float(result_buffer, {
        autoscale = true,
        wrap = false,
        title = "Query Result (press 't' to open in new tab)"
    })
end

local function execute_query(client_id)
    return function(args)
        start_query_timer()

        local range
        if args.range ~= 0 then
            range = vim.lsp.util.make_given_range_params({ args.line1, 0 }, { args.line2, math.huge }).range
            range["end"].character = range["end"].character - 1
        end
        sqls_execute_query(client_id, range, on_query_result)
    end
end

function sqls.get_query_time()
    return query_time
end

local current_database = ""

local function request_current_database()
    local clients = vim.lsp.get_active_clients({ bufnr = 0, name = "sqls" })
    local client = #clients > 0 and clients[1] or nil
    if client == nil then
        return ""
    end
    local res = client.request_sync(
        "workspace/executeCommand",
        {
            command = "showCurrentDatabase",
            arguments = { vim.uri_from_bufnr(0) }
        }
    )
    if res == nil then
        return ""
    end
    if res.err then
        vim.notify("sqls: " .. res.err.message, vim.log.levels.ERROR)
        return ""
    end
    if not res.result then
        return ""
    end
    return res.result
end

function sqls.get_current_database()
    if vim.bo.filetype ~= "sql" then
        return ""
    end

    if current_database == "" then
        current_database = request_current_database()
    end

    return current_database
end

function sqls.setup(config)
    config.filetypes = { "sql" }

    local default_on_attach = config.on_attach
    config.on_attach = function(client, bufnr)
        require("sqls").on_attach(client, bufnr)

        vim.api.nvim_buf_create_user_command(bufnr, "SqlsExecuteQuery", execute_query(client.id), { range = true })

        vim.api.nvim_create_autocmd("User", {
            pattern = "SqlsConnectionChoice",
            callback = function(event)
                local conn = vim.split(event.data.choice, " ")[3]
                for _, sett in pairs(vim.split(conn, ";")) do
                    if string.sub(sett, 1, string.len("database=")) == "database=" then
                        current_database = vim.split(sett, "=")[2]
                    end
                end
            end,
        })

        vim.api.nvim_create_autocmd("WinLeave", {
            callback = function(ev)
                if vim.api.nvim_buf_is_valid(ev.buf) and vim.bo[ev.buf].filetype == "FloatQueryResult" then
                    vim.cmd("bd! " .. tostring(ev.buf))
                end
            end,
            desc = "Exit floating query result on leave buffer"
        })

        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("v", "<localleader>e", ":SqlsExecuteQuery<CR>", opts)
        vim.keymap.set("n", "<localleader>e", ":SqlsExecuteQuery<CR>", opts)
        vim.keymap.set("n", "<localleader>c", ":SqlsSwitchConnection<CR>", opts)

        default_on_attach(client, bufnr)
    end

    return config
end

return sqls
