local set = vim.keymap.set
local options = { noremap = true, silent = true }

set("n", "<C-j>", "<C-w><C-j>", options)
set("n", "<C-k>", "<C-w><C-k>", options)
set("n", "<C-l>", "<C-w><C-l>", options)
set("n", "<C-h>", "<C-w><C-h>", options)
set("n", "<C-c>", "<C-w>c", options)
set("n", "<C-v>", "<C-w>o", options)

set("i", "<C-f>", "<right>", options)
set("i", "<C-b>", "<left>", options)

set("n", "gn", ":nohl<cr>", options)
set("n", "gq", ":copen<cr>", options)
set("n", "gl", ":lopen<cr>", options)

set("n", "[q", ":cprevious<cr>", options)
set("n", "]q", ":cnext<cr>", options)
set("n", "[l", ":lprevious<cr>", options)
set("n", "]l", ":lnext<cr>", options)
set("n", "[b", ":bprevious<cr>", options)
set("n", "]b", ":bnext<cr>", options)
set("n", "[t", ":tabprevious<cr>", options)
set("n", "]t", ":tabnext<cr>", options)

set("n", "<M-x>", ":%bd|e#|bd#<cr>|'\"", options) -- Close other buffers
set("n", "<M-n>", ":bd|e#<cr>|'\"", options) -- Reload current buffer
set("n", "<M-p>", ':let @+=expand("%:~:.")<cr>', options) -- Copy relative file path
set("n", "<M-y>", ':let @+=expand("%:p")<cr>', options) -- Copy absolute file path
