return {
	{
		"navarasu/onedark.nvim",
		opts = {
			highlights = {
				FloatBorder = { bg = "none" },
				NormalFloat = { bg = "none" },
			},
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			vim.cmd.colorscheme("onedark")
		end,
	},
}
