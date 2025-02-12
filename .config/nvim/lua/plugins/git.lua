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
    },
    {
        "f-person/git-blame.nvim",
        opts = {
            enabled = false,
            message_template = " <summary> • <date> • <author> • <<sha>>",
            date_format = "%d-%m-%Y %H:%M:%S",
            virtual_text_column = 1,
        },
    }
}
