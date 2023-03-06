return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		dependencies = {
			{
				"junegunn/fzf",
				build = function()
					vim.fn["fzf#install"]()
				end,
			},
		},
		opts = {
			auto_resize_height = true,
		},
	},
	{
		"ggandor/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
	{
		"ggandor/flit.nvim",
		keys = function()
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gza",
				delete = "gzd",
				find = "gzf",
				find_left = "gzF",
				highlight = "gzh",
				replace = "gzr",
				update_n_lines = "gzn",
			},
		},
		config = function(_, opts)
			require("mini.surround").setup(opts)
		end,
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					f = ai.gen_spec.treesitter(
						{ a = { "@call.outer", "@function.outer" }, i = { "@call.inner", "@function.inner" } },
						{}
					),
					C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},
	{
		"ojroques/vim-oscyank",
		cmd = { "OSCYank", "OSCYankReg" },
		keys = {
			{ "<leader>yy", "<Plug>OSCYank", desc = "OSCYank" },
			{ "<leader>yy", "<cmd>OSCYank<cr>", mode = { "v" }, desc = "OSCYank" },
			{ "<leader>yr", "<cmd>OSCYankReg +<cr>", desc = "OSCYankReg" },
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
			{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
			{ "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffviewFileHistory (current file)" },
			{
				"<leader>dr",
				"<cmd>'<,'>DiffviewFileHistory<cr>",
				mode = { "v" },
				desc = "DiffviewFileHistory",
			},
			{ "<leader>da", "<cmd>DiffviewFileHistory<cr>", desc = "DiffviewFileHistory (all)" },
		},
	},
	{
		"ruifm/gitlinker.nvim",
		keys = function()
			return {
				{ "<leader>gl", desc = "Gitlinker get_github_type_url" },
				{
					"<leader>go",
					function()
						require("gitlinker").get_buf_range_url(
							"n",
							{ action_callback = require("gitlinker.actions").open_in_browser }
						)
					end,
					desc = "Gitlinker open_in_browser",
				},
				{
					"<leader>go",
					function()
						require("gitlinker").get_buf_range_url(
							"v",
							{ action_callback = require("gitlinker.actions").open_in_browser }
						)
					end,
					mode = { "v" },
					desc = "Gitlinker open_in_browser",
				},
			}
		end,
		opts = function()
			return {
				opts = {
					remote = nil,
					add_current_line_on_normal_mode = true,
					action_callback = require("gitlinker.actions").copy_to_clipboard,
					print_url = true,
				},
				callbacks = {
					["github.com"] = require("gitlinker.hosts").get_github_type_url,
				},
				mappings = "<leader>gl",
			}
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			preview_config = { border = "single" },
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function set(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				set("n", "]h", function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Next hunk" })
				set("n", "[h", function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Prev hunk" })
				set({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Gitsigns stage_hunk" })
				set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Gitsigns undo_stage_hunk" })
				set({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Gitsigns reset_hunk" })
				set("n", "<leader>hS", gs.stage_buffer, { desc = "Gitsigns stage_buffer" })
				set("n", "<leader>hR", gs.reset_buffer, { desc = "Gitsigns reset_buffer" })
				set("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns preview_hunk" })
				set(
					"n",
					"<leader>hi",
					"<cmd>Gitsigns preview_hunk_inline<cr>",
					{ desc = "Gitsigns preview_hunk_inline" }
				)
				set("n", "<leader>hb", function()
					gs.blame_line({ full = false })
				end, { desc = "Gitsigns blame_line" })
				set("n", "<leader>hB", function()
					gs.blame_line({ full = true })
				end, { desc = "Gitsigns blame_line full" })
				set({ "o", "x" }, "ih", "<cmd>Gitsigns select_hunk<cr>", { desc = "Gitsigns select_hunk" })
				set("n", "<leader>hq", "<cmd>Gitsigns setqflist<cr>", { desc = "Gitsigns setqflist" })
				set(
					"n",
					"<leader>ht",
					"<cmd>Gitsigns toggle_current_line_blame<cr>",
					{ desc = "Gitsigns toggle_current_line_blame" }
				)
			end,
		},
	},
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		opts = {
			comment = { suffix = "m" },
			diagnostic = { suffix = "" },
			indent = { suffix = "" },
			file = { suffix = "" },
			treesitter = { suffix = "n" },
		},
		config = function(_, opts)
			local bracketed = require("mini.bracketed")

			local function put(cmd, regtype)
				local body = vim.fn.getreg(vim.v.register)
				local type = vim.fn.getregtype(vim.v.register)
				vim.fn.setreg(vim.v.register, body, regtype or "l")
				bracketed.register_put_region()
				vim.cmd(('normal! "%s%s'):format(vim.v.register, cmd:lower()))
				vim.fn.setreg(vim.v.register, body, type)
			end

			for _, cmd in ipairs({ "]p", "[p" }) do
				vim.keymap.set("n", cmd, function()
					put(cmd)
				end)
			end
			for _, cmd in ipairs({ "]P", "[P" }) do
				vim.keymap.set("n", cmd, function()
					put(cmd, "c")
				end)
			end

			local put_keys = { "p", "P" }
			for _, lhs in ipairs(put_keys) do
				vim.keymap.set({ "n", "x" }, lhs, function()
					return bracketed.register_put_region(lhs)
				end, { expr = true })
			end

			bracketed.setup(opts)
		end,
	},
}
