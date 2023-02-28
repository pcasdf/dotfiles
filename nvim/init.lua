vim.g.mapleader = " "

require("disable_builtins")
require("impatient")
require("plugins")
require("options")
require("keys")

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "plugins.lua",
	callback = function()
		vim.cmd([[source <afile> | PackerCompile]])
	end,
})
