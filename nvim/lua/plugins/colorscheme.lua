return {
	{
		"rmehri01/onenord.nvim",
		opts = function()
			local c = require("onenord.colors").load()
			return {
				custom_highlights = {
					DiffDelete = { fg = c.diff_remove_bg },
					FloatBorder = { bg = "none" },
					FocusedSymbol = { fg = c.yellow, style = "italic" },
					IlluminatedWordText = { bg = c.highlight },
					IlluminatedWordRead = { bg = c.highlight },
					IlluminatedWordWrite = { bg = c.highlight },
					LeapMatch = { fg = c.bg, bg = c.yellow },
					LeapLabelPrimary = { fg = c.bg, bg = c.yellow },
					LeapLabelSelected = { fg = c.bg, bg = c.highlight },
					LeapLabelSecondary = { fg = c.bg, bg = c.blue },
					MiniIndentScopeSymbol = { fg = c.light_gray },
					NvimTreeNormal = { bg = "none" },
					LspDiagnosticsVirtualTextHint = { style = "italic" },
					LspDiagnosticsVirtualTextError = { style = "italic" },
					LspDiagnosticsVirtualTextWarning = { style = "italic" },
					LspDiagnosticsVirtualTextInformation = { style = "italic" },
					TelescopeSelection = { fg = c.fg, bg = c.float },
				},
			}
		end,
		config = function(_, opts)
			require("onenord").setup(opts)
		end,
	},
}
