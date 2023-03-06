return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				config = function()
					local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
					vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
					vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
				end,
			},
		},
		opts = {
			ensure_installed = {
				"bash",
				"javascript",
				"json",
				"lua",
				"markdown",
				"python",
				"rust",
				"tsx",
				"typescript",
				"yaml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]e"] = "@parameter.inner",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[e"] = "@parameter.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["]s"] = "@parameter.inner",
					},
					swap_previous = {
						["[s"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
