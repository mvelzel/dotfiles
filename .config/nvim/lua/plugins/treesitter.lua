return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                },
            })

            vim.treesitter.query.set("sql", "injections", "")
        end
    }
}
