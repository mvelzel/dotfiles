vim.api.nvim_create_augroup("TermEscape", {})
vim.api.nvim_create_autocmd("TermOpen", {
    group = "TermEscape",
    callback = function(ev)
        if vim.bo[ev.buf].filetype ~= "lazygit" then
            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
                noremap = true,
                silent = true,
                buffer = ev.buf
            })
        end
    end,
    desc = "Map <Esc> to normal mode in normal terminals"
})

local function calc_colorcolumn()
    local range = "80"
    for i = 120, 9999 do
        range = range .. "," .. tostring(i)
    end
    return range
end

local function dim_inactive_windows()
    for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
        if vim.api.nvim_tabpage_is_valid(tabpage) then
            for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
                if vim.api.nvim_win_is_valid(winid) then
                    local buf = vim.fn.winbufnr(winid)
                    if winid == vim.api.nvim_get_current_win() then
                        if vim.bo[buf].modifiable then
                            vim.fn.setwinvar(winid, "&colorcolumn", calc_colorcolumn())
                        else
                            vim.fn.setwinvar(winid, "&colorcolumn", "")
                        end
                        vim.api.nvim_win_set_hl_ns(winid, 1)
                        vim.wo[winid].cursorline = true
                    else
                        vim.fn.setwinvar(winid, "&colorcolumn", "")
                        vim.api.nvim_win_set_hl_ns(winid, 0)
                        vim.wo[winid].cursorline = false
                    end
                end
            end
        end
    end
end

vim.opt.colorcolumn = calc_colorcolumn()

vim.api.nvim_create_augroup("DimInactiveWindows", {})
vim.api.nvim_create_autocmd("WinEnter", {
    group = "DimInactiveWindows",
    callback = function()
        dim_inactive_windows()
    end,
    desc = "Enable local cursorline and move the colorcolumn to the active window"
})

vim.api.nvim_create_augroup("NumberToggle", {})
vim.api.nvim_create_autocmd("BufEnter,FocusGained,InsertLeave", {
    group = "NumberToggle",
    callback = function()
        if vim.wo.number then
            vim.wo.relativenumber = true
        end
    end,
    desc = "Enable relativenumber for active buffers in normal mode"
})
vim.api.nvim_create_autocmd("BufLeave,FocusLost,InsertEnter", {
    group = "NumberToggle",
    callback = function()
        vim.wo.relativenumber = false
    end,
    desc = "Disable relativenumber for non-active buffers or insert mode"
})

vim.api.nvim_create_augroup("ObsessionGroup", {})
vim.api.nvim_create_autocmd("VimEnter", {
    group = "ObsessionGroup",
    nested = true,
    callback = function()
        local buf_modified = vim.api.nvim_buf_get_option(0, "modified")
        if not buf_modified then
            if vim.fn.argc() == 0 and vim.fn.filereadable("Session.vim") then
                vim.cmd("source Session.vim")
                vim.notify("Existing session sourced, recording session")
            elseif vim.fn.empty(vim.v.this_session) then
                vim.cmd("Obsession")
                vim.notify("Started new session")
            end
        end
    end,
    desc = "Automatically load session and start obsession on start"
})
