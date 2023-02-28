local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

require("nvim-treesitter.configs").setup({
	ensure_installed = {},
	sync_install = false,
	ignore_install = {},
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
				["]A"] = "@parameter.inner",
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
				["[A"] = "@parameter.inner",
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
})
