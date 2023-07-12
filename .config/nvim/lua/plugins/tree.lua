return {
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "catppuccin/nvim"
        },
        config = function()
            local mocha = require("catppuccin.palettes").get_palette("mocha")

            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#FFFFFF", fg = "#FFFFFF" })
            vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = "#FFFFFF", fg = "#FFFFFF" })

            require("nvim-tree").setup({
                sync_root_with_cwd = true,
                renderer = {
                    indent_markers = {
                        enable = true
                    },
                    icons = {
                        glyphs = {
                            folder = {
                                arrow_closed = "",
                                arrow_open = ""
                            }
                        }
                    },
                },
                on_attach = function(bufnr)
                    local api = require("nvim-tree.api")

                    local function opts(desc)
                        return {
                            desc = "nvim-tree: " .. desc,
                            buffer = bufnr,
                            noremap = true,
                            silent = true,
                            nowait = true
                        }
                    end

                    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
                    vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = "NONE" })
                    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = mocha.surface1 })

                    -- default mappings
                    api.config.mappings.default_on_attach(bufnr)

                    vim.keymap.set("n", "<CR>", api.node.open.no_window_picker, opts("Open"))
                end,
            })

            vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = mocha.surface1 })

            vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { silent = true, noremap = true })
        end
    }
}
