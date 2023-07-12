local window = {}

function window.make_float(buffer, opts)
    vim.bo[buffer].swapfile = false
    vim.bo[buffer].bufhidden = "wipe"
    vim.bo[buffer].modifiable = false

    vim.keymap.set("n", "<Esc>", ":bd<CR>", { silent = true, noremap = true, buffer = buffer })
    vim.keymap.set("n", "q", ":bd<CR>", { silent = true, noremap = true, buffer = buffer })

    local width
    local height
    if opts.autoscale then
        local padding_y = 10
        local padding_x = 20
        local min_width = 100

        local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)

        width = math.max(math.min(string.len(lines[1]), vim.o.columns - padding_x * 2), min_width)
        height = math.min(#lines, vim.o.lines - padding_y * 2)
    else
        width = opts.width or 100
        height = opts.height or 20
    end

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local winopt = {
        relative = "editor",
        anchor = "NW",
        row = row,
        col = col,
        border = "rounded",
        width = width,
        height = height,
        zindex = 150,
        style = "minimal",
        title = opts.title or "",
        title_pos = "center"
    }
    local win_options = {
        winblend = 0,
        cursorline = true,
        cursorlineopt = "both"
    }
    if opts.wrap ~= nil then
        win_options.wrap = opts.wrap
    else
        win_options.wrap = true
    end

    local float = vim.api.nvim_open_win(buffer, true, winopt)
    for option, value in pairs(win_options) do
        vim.api.nvim_set_option_value(option, value, { scope = "local", win = float })
    end
end

return window
