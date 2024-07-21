local function map(mode, l, r, desc, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = true
  opts.desc = desc
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<c-j>", "<c-w><c-j>", "Go to window below")
map("n", "<c-k>", "<c-w><c-k>", "Go to window above")
map("n", "<c-l>", "<c-w><c-l>", "Go to window right")
map("n", "<c-h>", "<c-w><c-h>", "Go to window left")

map("n", "<c-q>", "<cmd>bd<cr>", "Quit buffer")
map("n", "<c-c>", "<cmd>close<cr>", "Close window")
map("n", "<m-c>", "<c-w>o", "Close other windows")

map("i", "<S-cr>", "<esc>O", "Insert line above")

map("n", "<esc>", function()
  return vim.v.hlsearch == 1 and "<cmd>noh<cr>" or "<esc>"
end, "noh", { expr = true })

map("n", "<leader>q", "<cmd>copen<cr>", "Open quickfix")

map("n", "[T", "<cmd>tabfirst<cr>", "First tab")
map("n", "]T", "<cmd>tablast<cr>", "Last tab")
map("n", "[t", "<cmd>tabprevious<cr>", "Previous tab")
map("n", "]t", "<cmd>tabnext<cr>", "Next tab")

map("n", "X", '"_dd', "Delete line")
map("v", "X", '"_d', "Delete lines")
map("t", "<esc>", "<c-\\><c-n>", "Normal mode (terminal)")
map("n", "<m-r>", "<cmd>bd|e#<cr>|'\"", "Reload buffer")

map({ "n", "x" }, "<leader>y", '"+y', "Yank to system clipboard")
map("n", "<leader>r", '<cmd>let @+ = @"<cr>', "Yank register to system clipboard")

map("n", "<m-y>", '<cmd>let @+=expand("%:~:.")<cr><cmd>echo expand("%:~:.")<cr>', "Yank relative file path")
map("n", "<m-s-y>", '<cmd>let @+=expand("%:p")<cr><cmd>echo expand("%:p")<cr>', "Yank absolute file path")

map("n", "<c-up>", "<cmd>resize +2<cr>", "Increase window height")
map("n", "<c-down>", "<cmd>resize -2<cr>", "Decrease window height")
map("n", "<c-left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
map("n", "<c-right>", "<cmd>vertical resize +2<cr>", "Increase window width")

map("n", "<down>", "<cmd>m .+1<cr>==", "Move down")
map("n", "<up>", "<cmd>m .-2<cr>==", "Move up")
map("x", "<down>", ":m '>+1<cr>gv=gv", "Move down")
map("x", "<up>", ":m '<-2<cr>gv=gv", "Move up")

map("n", "<leader>z", "<cmd>Lazy<cr>", "Open lazy")
