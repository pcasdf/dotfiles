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
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"ojroques/vim-oscyank",
		cmd = { "OSCYank", "OSCYankReg" },
		keys = {
			{ "<leader><leader>y", "<Plug>OSCYank", desc = "OSCYank" },
			{ "<leader>y", "<cmd>OSCYank<cr>", mode = { "v" }, desc = "OSCYank" },
			{ "<leader>y", "<cmd>OSCYankReg +<cr>", desc = "OSCYankReg" },
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		config = true,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>v", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
			{ "<leader><leader>v", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
			{ "<leader>h", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffviewFileHistory" },
			{
				"<leader>h",
				"<cmd>'<,'>DiffviewFileHistory<cr>",
				mode = { "v" },
				desc = "DiffviewFileHistory",
			},
			{ "<leader><leader>h", "<cmd>DiffviewFileHistory<cr>", desc = "DiffviewFileHistory" },
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
		keys = {
			{ "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "NvimTreeToggle" },
			{ "<leader><leader>t", "<cmd>NvimTreeFindFile<cr>", desc = "NvimTreeFindFile" },
		},
		config = true,
	},
	{
		"ruifm/gitlinker.nvim",
		keys = function()
			return {
				{ "<M-l>", desc = "Gitlinker" },
				{
					"<M-o>",
					function()
						require("gitlinker").get_buf_range_url(
							"n",
							{ action_callback = require("gitlinker.actions").open_in_browser }
						)
					end,
					desc = "Gitlinker open_in_browser",
				},
				{
					"<M-o>",
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
				mappings = "<M-l>",
			}
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
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
				set({ "n", "v" }, "<M-s>", ":Gitsigns stage_hunk<cr>", { desc = "Gitsigns stage_hunk" })
				set("n", "<M-u>", gs.undo_stage_hunk, { desc = "Gitsigns undo_stage_hunk" })
				set({ "n", "v" }, "<M-r>", ":Gitsigns reset_hunk<cr>", { desc = "Gitsigns reset_hunk" })
				set("n", "<M-a>", gs.stage_buffer, { desc = "Gitsigns stage_buffer" })
				set("n", "<M-b>", gs.reset_buffer, { desc = "Gitsigns reset_buffer" })
				set("n", "<leader>p", gs.preview_hunk, { desc = "Gitsigns preview_hunk" })
				set("n", "<leader>z", function()
					gs.blame_line({ full = false })
				end, { desc = "Gitsigns blame_line" })
				set("n", "<leader><leader>z", function()
					gs.blame_line({ full = true })
				end, { desc = "Gitsigns blame_line full" })
				set({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>", { desc = "Gitsigns select_hunk" })
			end,
		},
	},
}
