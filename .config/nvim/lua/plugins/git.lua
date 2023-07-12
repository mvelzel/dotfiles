return {
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            vim.keymap.set('n', '<leader>lg', ':LazyGitCurrentFile<CR>', { noremap = true, silent = true })
        end
    },
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    }
}
