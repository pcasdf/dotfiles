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

set("n", "<C-q>", "<Cmd>bd<CR>", { desc = "Quit buffer" })
set("n", "<C-c>", "<Cmd>close<CR>", { desc = "Close window" })
set({ "n", "i", "x" }, "<C-s>", "<Cmd>w<CR>", { desc = "Save buffer" })
set({ "n", "i", "x", "t" }, "<C-Tab>", "<Cmd>bnext<CR>", { desc = "bnext" })
set({ "n", "i", "x", "t" }, "<C-S-Tab>", "<Cmd>bprevious<CR>", { desc = "bprevious" })

set("n", "<S-Tab>", "<C-o>", { desc = "Back" })
set("n", "<Esc>", function()
  return vim.v.hlsearch == 1 and "<Cmd>noh<CR>" or "<Esc>"
end, { expr = true, desc = "noh" })

set("i", "<C-b>", "<Left>", { desc = "Backward char" })
set("i", "<C-f>", "<Right>", { desc = "Forward char" })
set("i", "<M-b>", "<C-Left>", { desc = "Backward word" })
set("i", "<M-f>", "<C-Right>", { desc = "Forward word" })

set("n", "<Leader>q", "<Cmd>copen<CR>", { desc = "Open qflist" })
set("n", "<Leader>Q", "<Cmd>lopen<CR>", { desc = "Open loclist" })

set("n", "[T", "<Cmd>tabfirst<CR>", { desc = "First tab" })
set("n", "]T", "<Cmd>tablast<CR>", { desc = "Last tab" })
set("n", "[t", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
set("n", "]t", "<Cmd>tabnext<CR>", { desc = "Next tab" })

set("n", "X", '"_dd', { desc = "Delete line" })
set("v", "X", '"_d', { desc = "Delete line" })

set("t", "<Esc>", "<C-\\><C-n>", { desc = "Normal mode (terminal)" })

set("n", "<Leader>br", "<Cmd>bd|e#<CR>|'\"", { desc = "Reload buffer" })

set(
  "n",
  "<Leader>yr",
  '<Cmd>let @+=expand("%:~:.")<CR><Cmd>echo expand("%:~:.")<CR>',
  { desc = "Yank relative file path" }
)
set(
  "n",
  "<Leader>ya",
  '<Cmd>let @+=expand("%:p")<CR><Cmd>echo expand("%:p")<CR>',
  { desc = "Yank absolute file path" }
)

set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

set("n", "<Down>", "<Cmd>m .+1<CR>==", { desc = "Move down" })
set("n", "<Up>", "<Cmd>m .-2<CR>==", { desc = "Move up" })
set("x", "<Down>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
set("x", "<Up>", ":m '<-2<CR>gv=gv", { desc = "Move up" })

set("n", "<S-CR>", "<Cmd>put! =repeat(nr2char(10), v:count1)|silent ']+<CR>k", { desc = "Go to line above" })
set("i", "<S-CR>", "<Esc>O", { desc = "Go to line above" })

set("n", "<C-CR>", "<Cmd>put =repeat(nr2char(10), v:count1)|silent '[-<CR>j", { desc = "Go to line below" })
set("i", "<C-CR>", "<Esc>o", { desc = "Go to line below" })

set("n", "<Leader>om", "<Cmd>Mason<CR>", { desc = "Open Mason" })
set("n", "<Leader>ol", "<Cmd>Lazy<CR>", { desc = "Open Lazy" })
set("n", "<Leader>on", "<Cmd>NullLsInfo<CR>", { desc = "Open Null" })
set("n", "<Leader>oi", "<Cmd>LspInfo<CR>", { desc = "Open Lsp" })
set("n", "<Leader>oc", "<Cmd>ConformInfo<CR>", { desc = "Open Conform" })
