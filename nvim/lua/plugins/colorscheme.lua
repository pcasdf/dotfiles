return {
	{
		"navarasu/onedark.nvim",
		opts = function()
			local p = require("onedark.palette").darker
			return {
				style = "darker",
				highlights = {
					FloatBorder = { bg = "none" },
					NormalFloat = { bg = "none" },
					QuickFixLine = { bg = p.bg2, fmt = "bold,italic" },
					IlluminatedWordText = { bg = p.bg2 },
					IlluminatedWordRead = { bg = p.bg2 },
					IlluminatedWordWrite = { bg = p.bg2 },
				},
			}
		end,
		config = function(_, opts)
			require("onedark").setup(opts)
			vim.cmd.colorscheme("onedark")
		end,
	},
}
