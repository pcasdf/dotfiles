require("lspsaga").setup({
	lightbulb = { enable = false },
	symbol_in_winbar = { separator = "  " },
	beacon = { frequency = 10 },
	definition = {
		edit = "<C-w>o",
		vsplit = "<C-w>v",
		split = "<C-w>s",
		tabe = "<C-t>",
		quit = "q",
	},
	finder = {
		keys = { vsplit = "v", split = "s" },
	},
	ui = { winblend = 12 },
})

local set = vim.keymap.set
local options = { noremap = true, silent = true }

set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", options)
set({ "n", "v" }, "<leader>x", "<cmd>Lspsaga code_action<CR>", options)
set("n", "gR", "<cmd>Lspsaga rename<CR>", options)
set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", options)
set("n", "<leader>j", "<cmd>Lspsaga peek_definition<CR>", options)
set("n", "<leader>i", "<cmd>Lspsaga peek_type_definition<CR>", options)
set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", options)
set("n", "<leader>l", "<cmd>Lspsaga show_line_diagnostics<CR>", options)
set("n", "<leader>I", "<cmd>Lspsaga show_cursor_diagnostics<CR>", options)
set("n", "<leader>w", "<cmd>Lspsaga show_buf_diagnostics<CR>", options)
set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", options)
set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", options)
set("n", "[D", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
set("n", "]D", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
set("n", "<leader>O", "<cmd>Lspsaga outline<CR>", options)
set("n", "K", "<cmd>Lspsaga hover_doc<CR>", options)
