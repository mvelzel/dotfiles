return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "j-hui/fidget.nvim",
                tag = "legacy"
            },
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            "Decodetalkers/csharpls-extended-lsp.nvim",
            "nanotee/sqls.nvim"
        },
        lazy = false,
        config = function()
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers["signature_help"], {
                    border = "rounded"
                }
            )

            vim.diagnostic.config {
                float = { border = "rounded" },
            }

            require("fidget").setup()

            require("mason").setup({
                ui = {
                    border = "rounded"
                },
                registries = {
                    "lua:mason_registry",
                    "github:mason-org/mason-registry",
                }
            })
            require("mason-lspconfig").setup()

            require("neodev").setup()

            require("lspconfig.ui.windows").default_options.border = "rounded"

            local lspconfig = require("lspconfig")
            local make_config = require("lsp").make_config
            for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/lsp/servers", [[v:val =~ '\.lua$']])) do
                local conf = require("lsp.servers." .. file:gsub("%.lua$", ""))

                -- Prevent the deprecation warning for sqls
                local vim_deprecate = vim.deprecate
                if conf.name == "sqls" then
                    vim.deprecate = function(_, _, _, _, _) end
                end

                lspconfig[conf.name].setup(conf.setup(make_config()))

                vim.deprecate = vim_deprecate
            end
        end
    }
}
