return {
	{
		"rmehri01/onenord.nvim",
		opts = function()
			local c = require("onenord.colors").load()
			return {
				custom_highlights = {
					DiffDelete = { fg = c.diff_remove_bg },
					FloatBorder = { bg = "none" },
					IlluminatedWordText = { bg = c.highlight },
					IlluminatedWordRead = { bg = c.highlight },
					IlluminatedWordWrite = { bg = c.highlight },
					IncSearch = { fg = c.yellow, bg = c.selection, style = "bold" },
					LeapMatch = { fg = c.bg, bg = c.yellow },
					LeapLabelPrimary = { fg = c.bg, bg = c.yellow },
					LeapLabelSelected = { fg = c.bg, bg = c.highlight },
					LeapLabelSecondary = { fg = c.bg, bg = c.light_red },
					MiniIndentScopeSymbol = { fg = c.light_gray },
					NvimTreeNormal = { bg = "none" },
					TelescopeSelection = { fg = c.fg, bg = c.selection },
				},
			}
		end,
		config = function(_, opts)
			require("onenord").setup(opts)
		end,
	},
}
