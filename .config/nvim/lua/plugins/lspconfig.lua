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
            "nanotee/sqls.nvim",
            "nvim-telescope/telescope.nvim"
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

                if not conf.disable then
                    -- Prevent the deprecation warning for sqls
                    local vim_deprecate = vim.deprecate
                    if conf.name == "sqls" then
                        vim.deprecate = function(_, _, _, _, _) end
                    end

                    lspconfig[conf.name].setup(conf.setup(make_config()))

                    vim.deprecate = vim_deprecate
                end
            end
        end
    },
    {
        "elixir-tools/elixir-tools.nvim",
        version = "*",
        lazy = false,
        config = function()
            local elixir = require("elixir")
            local elixirls = require("elixir.elixirls")

            local conf = require("lsp.servers.elixirls")
            local make_config = require("lsp").make_config
            local config = conf.setup(make_config())

            elixir.setup {
                nextls = {
                    enable = false,
                    cmd = "/home/mvelzel/.local/share/nvim/mason/bin/nextls"
                },
                elixirls = {
                    enable = false,
                    cmd = "/home/mvelzel/.local/share/nvim/mason/bin/elixir-ls",
                    settings = elixirls.settings {
                        dialyzerEnabled = false,
                        enableTestLenses = true,
                    },
                    on_attach = function(client, bufnr)
                        config.on_attach(client, bufnr)

                        local opts = { buffer = true, noremap = true }

                        vim.keymap.set("n", "<localleader>fp", ":ElixirFromPipe<cr>", opts)
                        vim.keymap.set("n", "<localleader>tp", ":ElixirToPipe<cr>", opts)
                        vim.keymap.set("v", "<localleader>em", ":ElixirExpandMacro<cr>", opts)
                        vim.keymap.set("n", "<localleader>rt", ":execute 'Mix test ' . expand('%') . ':' . line('.')<cr>",
                            opts)

                        vim.keymap.set("n", "<localleader>ct", ":Mix test --cover<CR>", opts)
                        vim.keymap.set("n", "<localleader>t", ":Mix test<CR>", opts)
                    end,
                },
                projectionist = {
                    enable = false
                }
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "scalameta/nvim-metals",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "j-hui/fidget.nvim",
                opts = {},
            }
        },
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()
            local config = require("lsp").make_config()

            metals_config.init_options.statusBarProvider = "off"

            metals_config.capabilities = config.capabilities
            metals_config.on_attach = config.on_attach

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end
    }
}
