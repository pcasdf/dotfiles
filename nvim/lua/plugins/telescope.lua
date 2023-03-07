return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
			{
				"<leader>fF",
				function()
					require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
				end,
				desc = "Telescope find_files (cwd)",
			},
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
			{
				"<leader>fG",
				function()
					require("telescope.builtin").live_grep({ cwd = require("telescope.utils").buffer_dir() })
				end,
				desc = "Telescope live_grep (cwd)",
			},
			{
				"<leader>/",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Telescope current_buffer_fuzzy_find",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
				end,
				desc = "Telescope find_files (hidden)",
			},
			{
				"<leader>fH",
				function()
					require("telescope").extensions.file_browser.file_browser({
						hidden = true,
						respect_gitignore = false,
					})
				end,
				desc = "Telescope file_browser (hidden)",
			},
			{ "<leader>fa", "<cmd>Telescope git_files<cr>", desc = "Telescope git_files" },
			{ "<leader>fe", "<cmd>Telescope file_browser file_browser<cr>", desc = "Telescope file_browser" },
			{
				"<leader>fE",
				function()
					require("telescope").extensions.file_browser.file_browser({
						path = require("telescope.utils").buffer_dir(),
					})
				end,
				desc = "Telescope file_browser (cwd)",
			},
			{
				"<leader>fw",
				"<cmd>Telescope grep_string<cr>",
				mode = { "n", "v" },
				desc = "Telescope grep_string",
			},
			{
				"<leader>fW",
				function()
					require("telescope.builtin").grep_string({ cwd = require("telescope.utils").buffer_dir() })
				end,
				desc = "Telescope grep_string (cwd)",
			},
			{ "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Telescope resume" },
			{ "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Telescope registers" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope keymaps" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
			{ "<leader>fB", "<cmd>Telescope builtin<cr>", desc = "Telescope builtin" },
			{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Telescope marks" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Telescope oldfiles" },
			{ "<leader>fx", "<cmd>Telescope command_history<cr>", desc = "Telescope command_history" },
			{
				"<leader>fd",
				function()
					require("telescope.builtin").diagnostics({ bufnr = 0 })
				end,
				desc = "Telescope diagnostics (cwd)",
			},
			{ "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Telescope diagnostics" },
			{ "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Telescope quickfix" },
			{ "<leader>fQ", "<cmd>Telescope quickfixhistory<cr>", desc = "Telescope quickfixhistory" },
			{ "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "Telescope loclist" },
			{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Telescope jumplist" },
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Telescope lsp_definitions" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope lsp_references" },
			{ "gR", "<cmd>Telescope lsp_references include_current_line=true<cr>", desc = "Telescope lsp_references" },
			{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Telescope lsp_type_definitions" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope lsp_document_symbols" },
			{
				"<leader>fS",
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				desc = "Telescope lsp_dynamic_workspace_symbols",
			},
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Telescope git_status" },
			{ "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "Telescope git_commits" },
			{ "<leader>gc", "<cmd>Telescope git_bcommits<cr>", desc = "Telescope git_bcommits" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Telescope git_branches" },
			{ "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "Telescope git_stash" },
			{
				"<leader>f.",
				function()
					require("telescope.builtin").find_files({ cwd = "$HOME/dotfiles/nvim", prompt_title = "dotfiles" })
				end,
				desc = "Telescope dotfiles",
			},
		},
		opts = function()
			local actions = require("telescope.actions")

			return {
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					winblend = 12,
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.smart_send_to_qflist,
							["<C-o>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<C-a>"] = actions.smart_add_to_qflist,
							["<C-l>"] = actions.smart_send_to_loclist,
							["<C-z>"] = actions.smart_add_to_loclist,
							["<M-a>"] = actions.add_selected_to_qflist,
						},
						n = {
							["<C-q>"] = actions.smart_send_to_qflist,
							["<C-o>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<C-a>"] = actions.smart_add_to_qflist,
							["<C-l>"] = actions.smart_send_to_loclist,
							["<C-z>"] = actions.smart_add_to_loclist,
							["<M-a>"] = actions.add_selected_to_qflist,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = { "fd", "--type", "f" },
					},
					buffers = {
						mappings = {
							i = {
								["<C-x>"] = actions.delete_buffer,
							},
							n = {
								["x"] = actions.delete_buffer,
							},
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
					file_browser = {
						hidden = true,
					},
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			require("telescope").setup(opts)

			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
		end,
	},
}
