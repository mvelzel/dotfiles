return {
    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            local nvim_tmux_nav = require("nvim-tmux-navigation")
            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, opts)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, opts)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, opts)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, opts)

            vim.keymap.set("t", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, opts)
            vim.keymap.set("t", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, opts)
            vim.keymap.set("t", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, opts)
            vim.keymap.set("t", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, opts)
        end
    },
    {
        "benmills/vimux",
        config = function()
            vim.keymap.set("n", "<leader>vp", ":VimuxPromptCommand<CR>", { noremap = true, silent = true })
        end
    }
}
