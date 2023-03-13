return {
	{
		"folke/tokyonight.nvim",
		opts = {
			on_highlights = function(hl, c)
				hl.BqfPreviewBorder = { fg = c.border_highlight, bg = "none" }
				hl.DiffDelete = { fg = c.diff.delete, bg = c.diff.delete }
				hl.FloatBorder = { fg = c.border_highlight, bg = "none" }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
