return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				keys = function()
					local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
					return {
						{
							";",
							ts_repeat_move.repeat_last_move,
							mode = { "n", "x", "o" },
							desc = "ts_repeat_move repeat_last_move",
						},
						{
							",",
							ts_repeat_move.repeat_last_move_opposite,
							mode = { "n", "x", "o" },
							desc = "ts_repeat_move repeat_last_move_opposite",
						},
						{
							"f",
							ts_repeat_move.builtin_f,
							mode = { "n", "x", "o" },
							desc = "ts_repeat_move builtin_f",
						},
						{
							"F",
							ts_repeat_move.builtin_F,
							mode = { "n", "x", "o" },
							desc = "ts_repeat_move builtin_F",
						},
						{
							"t",
							ts_repeat_move.builtin_t,
							mode = { "n", "x", "o" },
							desc = "ts_repeat_move builtin_t",
						},
						{
							"T",
							ts_repeat_move.builtin_T,
							mode = { "n", "x", "o" },
							desc = "ts_repeat_move builtin_T",
						},
					}
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
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["aC"] = "@comment.outer",
						["iC"] = "@comment.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["ax"] = "@call.outer",
						["ix"] = "@call.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]]"] = "@class.outer",
						["]C"] = "@comment.outer",
						["]B"] = "@block.outer",
						["]x"] = "@call.outer",
						["]i"] = "@conditional.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]["] = "@class.outer",
						["]I"] = "@conditional.outer",
						["]e"] = "@parameter.inner",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[["] = "@class.outer",
						["[C"] = "@comment.outer",
						["[B"] = "@block.outer",
						["[x"] = "@call.outer",
						["[i"] = "@conditional.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[]"] = "@class.outer",
						["[I"] = "@conditional.outer",
						["[e"] = "@parameter.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>n"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader><leader>n"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
