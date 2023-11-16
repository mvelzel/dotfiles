return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "lua",
                highlight = {
                    enable = true,
                    disable = { "sql" },
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                },
            })
        end
    }
}
