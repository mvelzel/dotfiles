return {
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = true,
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true
    },
    {
        "tpope/vim-obsession",
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)

            if vim.fn.has("persistent_undo") then
                local target_path = vim.fn.expand("~/.undodir")

                if not vim.fn.isdirectory(target_path) then
                    vim.fn.mkdir(target_path, "p", 0700)
                end

                vim.opt.undodir = target_path
                vim.opt.undofile = true
            end
        end
    },
    {
        "tpope/vim-sleuth"
    }
}
