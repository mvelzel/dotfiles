return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            local mocha = require("catppuccin.palettes").get_palette("mocha")
            vim.api.nvim_set_hl(0, "VertSplit", { fg = mocha.surface1 })
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = mocha.surface1 })
            vim.api.nvim_set_hl(0, "LineNr", { fg = mocha.surface1 })
            vim.api.nvim_set_hl(1, "LineNr", { fg = mocha.surface3 })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "catppuccin/nvim"
        },
        lazy = false,
        priority = 1000,
        config = function()
            local lualine = require("lualine")
            local custom_theme = require("lualine.themes.catppuccin-mocha")
            local mocha = require("catppuccin.palettes").get_palette("mocha")

            custom_theme.normal.c.bg = "None"
            custom_theme.inactive.c.bg = "None"
            custom_theme.inactive.c.fg = mocha.surface1;

            local sqls = require("lsp.servers.sqls")

            lualine.setup({
                options = {
                    disabled_filetypes = { "NvimTree" },
                    theme = custom_theme,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" }
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { sqls.get_current_database }, { sqls.get_query_time }, "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {}
                },
            })
        end
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "catppuccin/nvim",
        },
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup({
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
                options = {
                    themable = true,
                    mode = "tabs",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true
                        }
                    },
                    buffer_close_icon = "✕",
                    separator_style = "slant",
                    name_formatter = function(args)
                        local n = args.tabnr
                        local bufnr = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(n))
                        local fname = vim.fn.expand("#" .. bufnr .. ":t")
                        if vim.bo[bufnr].filetype == "TabQueryResult" then
                            return "Query Results"
                        elseif fname ~= "" then
                            return fname
                        else
                            return "[No Name]"
                        end
                    end
                },
            })
        end
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            select = {
                backend = { "builtin" }
            },
        }
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function()
            local devicons = require("nvim-web-devicons")
            devicons.setup({
                override = {
                    cs = {
                        icon = "",
                        color = "#596706",
                        cterm_color = "58",
                        name = "Cs",
                    },
                    tf = {
                        icon = "",
                        color = "#5F43E9",
                        cterm_color = "93",
                        name = "Terraform",
                    },
                    html = {
                        icon = "󰌝",
                        color = "#e44d26",
                        cterm_color = "196",
                        name = "Html",
                    },
                }
            })
            devicons.set_default_icon("?", "#6d8086", 66)
        end
    }
}
