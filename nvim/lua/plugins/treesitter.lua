return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					local opts = require("lazy.core.plugin").values(plugin, "opts", false)
					local enabled = false
					if opts.textobjects then
						for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
							if opts.textobjects[mod] and opts.textobjects[mod].enable then
								enabled = true
								break
							end
						end
					end
					if not enabled then
						require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					end
				end,
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
						["an"] = "@comment.outer",
						["in"] = "@comment.inner",
						["ax"] = "@call.outer",
						["ix"] = "@call.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]n"] = "@comment.outer",
						["]x"] = "@call.outer",
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
						["[n"] = "@comment.outer",
						["[x"] = "@call.outer",
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
