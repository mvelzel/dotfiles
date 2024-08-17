return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    file_ignore_patterns = { ".git/", "node_modules/", "vendor/", ".terraform/" },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    },
                },
            })

            telescope.load_extension("fzf")

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>cf', function() builtin.find_files({ cwd = "~/.config" }) end)
            vim.keymap.set('n', '<leader>f', builtin.find_files)
            vim.keymap.set('n', '<leader>g', builtin.live_grep)
            vim.keymap.set('n', '<leader>b', builtin.buffers)
        end,
    }
}
