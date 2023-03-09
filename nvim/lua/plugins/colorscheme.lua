return {
	{
		"navarasu/onedark.nvim",
		opts = function()
			local p = require("onedark.palette").dark
			return {
				style = "dark",
				highlights = {
					BqfPreviewBorder = { fg = p.cyan, bg = "none" },
					DiffDelete = { fg = p.diff_delete, bg = p.diff_delete },
					FloatBorder = { fg = p.cyan, bg = "none" },
					NormalFloat = { bg = "none" },
					QuickFixLine = { fg = "none", bg = p.bg2, fmt = "bold,italic" },
					IlluminatedWordText = { bg = p.bg2 },
					IlluminatedWordRead = { bg = p.bg2 },
					IlluminatedWordWrite = { bg = p.bg2 },
					LeapMatch = { fg = p.bg0, bg = p.yellow },
					LeapLabelPrimary = { fg = p.bg0, bg = p.yellow },
					LeapLabelSelected = { fg = p.bg0, bg = p.highlight },
					LeapLabelSecondary = { fg = p.bg0, bg = p.red },
				},
			}
		end,
		config = function(_, opts)
			require("onedark").setup(opts)
			vim.cmd.colorscheme("onedark")
		end,
	},
}
