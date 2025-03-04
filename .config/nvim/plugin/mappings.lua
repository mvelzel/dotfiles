vim.g.mapleader = ","
vim.g.localleader = "\\"

vim.keymap.set("n", "<C-e>", "3<C-e>");
vim.keymap.set("n", "<C-y>", "3<C-y>");

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>vc", ":tabe ~/.config/nvim/init.lua<CR> <BAR> :tabmove<CR> <BAR> :tcd ~/.config/nvim<CR>")

vim.keymap.set("n", "<C-n>", ":cnext<CR>");
vim.keymap.set("n", "<C-p>", ":cprev<CR>");
vim.keymap.set("n", "<C-c>", ":cclose<CR>");

--vim.keymap.set("n", "q:", "<nop>", { noremap = true, silent = true })
