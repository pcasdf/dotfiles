local set = vim.keymap.set
local options = { noremap = true, silent = true }

set("n", "<C-j>", "<C-w><C-j>", options)
set("n", "<C-k>", "<C-w><C-k>", options)
set("n", "<C-l>", "<C-w><C-l>", options)
set("n", "<C-h>", "<C-w><C-h>", options)
set("n", "<C-c>", "<C-w>c", options)
set("n", "<C-v>", "<C-w>o", options)

set("i", "<C-j>", "<esc>o", options)
set("i", "<C-k>", "<esc>O", options)
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

set("n", "<leader><leader>x", ":%bd|e#|bd#<cr>|'\"", options) -- Close other buffers
set("n", "<leader><leader>b", ":bd|e#<cr>|'\"", options) -- Reload current buffer
set("n", "<leader><leader>f", ':let @+=expand("%:~:.")<cr>', options) -- Copy relative file path
set("n", "<leader><leader>F", ':let @+=expand("%:p")<cr>', options) -- Copy absolute file path

set("n", "<leader>v", ":DiffviewOpen<cr>", options)
set("n", "<leader>V", ":DiffviewClose<cr>", options)
set("n", "<leader>h", ":DiffviewFileHistory %<cr>", options)
set("n", "<leader>H", ":DiffviewFileHistory<cr>", options)
set("v", "<leader>h", ":'<,'>DiffviewFileHistory<cr>", options)

set("n", "<leader><leader>U", ":UndotreeToggle<cr>", options)

set("n", "<leader>Y", "<Plug>OSCYank", options)
set("v", "<leader>Y", ":OSCYank<cr>", options)
set("n", "<leader>y", ":OSCYankReg +<cr>", options)
set("v", "<leader>y", ":OSCYankReg +<cr>", options)

set("n", "<leader>o", ":SymbolsOutline<cr>", options)

set("n", "<leader>t", ":NvimTreeToggle<cr>", options)
set("n", "<leader>T", ":NvimTreeFindFile<cr>", options)
