--  window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- don't lose copied text on paste
vim.keymap.set("v", "p", [["_dP]])

-- changing tabs
vim.keymap.set("n", "t", "gt")
vim.keymap.set("n", "T", "gT")

-- K and J move text up/down in visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- leader mappings
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic under cursor" })

vim.keymap.set("n", "-", "<cmd>e %:h<CR>")

vim.keymap.set("i", "<C-t>", "<Nop>")
vim.keymap.set("n", "<C-t>", "<Nop>")