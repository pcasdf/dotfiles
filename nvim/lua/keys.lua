local function set(mode, l, r, opts)
	opts = opts or {}
	opts.noremap = true
	opts.silent = true
	vim.keymap.set(mode, l, r, opts)
end

set("n", "<C-j>", "<C-w><C-j>", { desc = "Go to window below" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Go to window above" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Go to window left" })
set("n", "<C-h>", "<C-w><C-h>", { desc = "Go to window right" })

set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
set("n", "<C-c>", "<C-w>c", { desc = "Close window" })
set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })

set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

set("i", "<C-b>", "<left>", { desc = "Previous char" })
set("i", "<C-f>", "<right>", { desc = "Next char" })

set("n", "gq", "<cmd>copen<cr>", { desc = "Open qflist" })
set("n", "gl", "<cmd>lopen<cr>", { desc = "Open loclist" })

set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })

set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>|'\"", { desc = "Close other buffers" })
set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer" })
set("n", "<leader>br", "<cmd>bd|e#<cr>|'\"", { desc = "Reload buffer" })

set("n", "<leader>yf", '<cmd>let @+=expand("%:~:.")<cr>', { desc = "Yank relative file path" })
set("n", "<leader>ya", '<cmd>let @+=expand("%:p")<cr>', { desc = "Yank absolute file path" })

set("n", "<leader>om", "<cmd>Mason<cr>", { desc = "Open Mason" })
set("n", "<leader>ol", "<cmd>Lazy<cr>", { desc = "Open Lazy" })
set("n", "<leader>on", "<cmd>NullLsInfo<cr>", { desc = "Open Null" })
set("n", "<leader>oi", "<cmd>LspInfo<cr>", { desc = "Open Lsp" })

set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

set("n", "<leader>ww", "<cmd>w<cr>", { desc = "Write" })
set("n", "<leader>wa", "<cmd>wa<cr>", { desc = "Write all" })

set("n", "[<space>", function()
	vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
end, { desc = "Space above" })

set("n", "]<space>", function()
	vim.cmd("put =repeat(nr2char(10), v:count1)|silent '[-")
end, { desc = "Space below" })
