return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
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
