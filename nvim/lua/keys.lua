local set = vim.keymap.set
local options = { noremap = true, silent = true }

local with = function(opts)
	opts.noremap = true
	opts.silent = true
	return opts
end

set("n", "<C-j>", "<C-w><C-j>", options)
set("n", "<C-k>", "<C-w><C-k>", options)
set("n", "<C-l>", "<C-w><C-l>", options)
set("n", "<C-h>", "<C-w><C-h>", options)

set("n", "<C-c>", "<C-w>c", options)
set("n", "<C-v>", "<C-w>o", options)

set("i", "<C-f>", "<right>", options)
set("i", "<C-b>", "<left>", options)

set("n", "[q", "<cmd>cprevious<cr>", options)
set("n", "]q", "<cmd>cnext<cr>", options)
set("n", "[l", "<cmd>lprevious<cr>", options)
set("n", "]l", "<cmd>lnext<cr>", options)
set("n", "[b", "<cmd>bprevious<cr>", options)
set("n", "]b", "<cmd>bnext<cr>", options)
set("n", "[t", "<cmd>tabprevious<cr>", options)
set("n", "]t", "<cmd>tabnext<cr>", options)

set("n", "<leader>hl", "<cmd>nohl<cr>", options)

set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>|'\"", with({ desc = "Close other buffers" }))
set("n", "<leader>bd", "<cmd>bd<cr>", with({ desc = "Close buffer" }))
set("n", "<leader>br", "<cmd>bd|e#<cr>|'\"", with({ desc = "Reload buffer" }))

set("n", "<leader>yf", '<cmd>let @+=expand("%:~:.")<cr>', with({ desc = "Yank relative file path" }))
set("n", "<leader>ya", '<cmd>let @+=expand("%:p")<cr>', with({ desc = "Yank absolute file path" }))

set("n", "<leader>oq", "<cmd>copen<cr>", with({ desc = "Open qflist" }))
set("n", "<leader>ol", "<cmd>lopen<cr>", with({ desc = "Open loclist" }))
set("n", "<leader>om", "<cmd>Mason<cr>", with({ desc = "Open Mason" }))
set("n", "<leader>oz", "<cmd>Lazy<cr>", with({ desc = "Open Lazy" }))
set("n", "<leader>on", "<cmd>NullLsInfo<cr>", with({ desc = "Open Null" }))
set("n", "<leader>oi", "<cmd>LspInfo<cr>", with({ desc = "Open Lsp" }))

set("n", "<leader>qq", "<cmd>qa<cr>", with({ desc = "Quit all" }))

set("n", "<leader>ww", "<cmd>w<cr>", with({ desc = "Write" }))
set("n", "<leader>wa", "<cmd>wa<cr>", with({ desc = "Write all" }))
