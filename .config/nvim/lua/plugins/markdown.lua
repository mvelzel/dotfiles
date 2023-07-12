return {
    {
        "iamcco/markdown-preview.nvim",
        config = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "junegunn/vim-easy-align",
        config = function()
            vim.keymap.set("v", "<Bar>", ":EasyAlign *<Bar><CR>", { silent = true, noremap = true })
        end
    },
    {
        "mzlogin/vim-markdown-toc",
        config = function()
            vim.g.vmt_auto_update_on_save = false
            vim.g.vmt_dont_insert_fence = true
        end
    }
}
