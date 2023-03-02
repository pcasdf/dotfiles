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
			{ "<leader>r", "<cmd>Telescope resume<cr>", desc = "Telescope resume" },
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
			{
				"<leader><leader>f",
				function()
					require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
				end,
				desc = "Telescope find_files from current buffer",
			},
			{
				"<leader><leader>g",
				function()
					require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
				end,
				desc = "Telescope find_files hidden ignored",
			},
			{ "<leader>a", "<cmd>Telescope git_files<cr>", desc = "Telescope git_files" },
			{ "<leader>e", "<cmd>Telescope file_browser file_browser<cr>", desc = "Telescope file_browser" },
			{
				"<leader><leader>e",
				function()
					require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true })
				end,
				desc = "Telescope file_browser from current buffer",
			},
			{
				"<M-e>",
				function()
					require("telescope").extensions.file_browser.file_browser({
						hidden = true,
						respect_gitignore = false,
					})
				end,
				desc = "Telescope file_browser hidden and ignored",
			},
			{
				"gw",
				"<cmd>Telescope grep_string<cr>",
				mode = { "n", "v" },
				desc = "Telescope grep_string",
			},
			{ "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
			{
				"<leader>/",
				"<cmd> Telescope current_buffer_fuzzy_find<cr>",
				desc = "Telescope current_buffer_fuzzy_find",
			},
			{ "<leader>k", "<cmd> Telescope keymaps<cr>", desc = "Telescope keymaps" },
			{ "<leader>u", "<cmd> Telescope builtin<cr>", desc = "Telescope builtin" },
			{ "<leader>b", "<cmd> Telescope buffers<cr>", desc = "Telescope buffers" },
			{ "<leader><leader>m", "<cmd> Telescope marks<cr>", desc = "Telescope marks" },
			{ "<leader>m", "<cmd> Telescope oldfiles<cr>", desc = "Telescope oldfiles" },
			{ "<leader><leader>x", "<cmd> Telescope command_history<cr>", desc = "Telescope command_history" },
			{
				"<leader>d",
				function()
					require("telescope.builtin").diagnostics({ bufnr = 0 })
				end,
				desc = "Telescope diagnostics current buffer",
			},
			{ "<leader><leader>d", "<cmd> Telescope diagnostics<cr>", desc = "Telescope diagnostics" },
			{ "<leader>q", "<cmd> Telescope quickfix<cr>", desc = "Telescope quickfix" },
			{ "<leader><leader>q", "<cmd> Telescope quickfixhistory<cr>", desc = "Telescope quickfixhistory" },
			{ "gD", "<cmd> Telescope lsp_definitions<cr>", desc = "Telescope lsp_definitions" },
			{ "gr", "<cmd> Telescope lsp_references<cr>", desc = "Telescope lsp_references" },
			{
				"<leader>s",
				"<cmd> Telescope lsp_document_symbols<cr>",
				desc = "Telescope lsp_document_symbols",
			},
			{
				"<leader><leader>s",
				"<cmd> Telescope lsp_workspace_symbols<cr>",
				desc = "Telescope lsp_workspace_symbols",
			},
			{
				"<leader><leader>u",
				"<cmd> Telescope lsp_type_definitions<cr>",
				desc = "Telescope lsp_type_definitions",
			},
			{ "<leader><leader>a", "<cmd> Telescope git_status<cr>", desc = "Telescope git_status" },
			{ "<leader><leader>c", "<cmd> Telescope git_commits<cr>", desc = "Telescope git_commits" },
			{ "<leader>c", "<cmd> Telescope git_bcommits<cr>", desc = "Telescope git_bcommits" },
			{ "<leader><leader>b", "<cmd> Telescope git_branches<cr>", desc = "telescope git_branches" },
			{
				"<leader><leader>k",
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
					winblend = 12,
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
							["<C-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
							["<C-z>"] = actions.smart_add_to_loclist + actions.open_loclist,
							["<M-a>"] = actions.add_selected_to_qflist,
						},
						n = {
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
							["<C-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
							["<C-z>"] = actions.smart_add_to_loclist + actions.open_loclist,
							["<M-a>"] = actions.add_selected_to_qflist,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = { "fd", "--type", "f" },
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
