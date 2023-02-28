local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
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
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")

local set = vim.keymap.set
local options = { noremap = true, silent = true }
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions

set("n", "<leader>r", builtin.resume, options)
set("n", "<leader>f", builtin.find_files, options)
set("n", "<leader><leader>f", function()
	builtin.find_files({ cwd = require("telescope.utils").buffer_dir() })
end, options)
set("n", "<leader><leader>g", function()
	builtin.find_files({ hidden = true, no_ignore = true })
end, options)
set("n", "<leader>a", builtin.git_files, options)
set("n", "<leader>e", extensions.file_browser.file_browser, options)
set("n", "<leader><leader>e", function()
	extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true })
end, options)
set("n", "<M-e>", function()
	extensions.file_browser.file_browser({ hidden = true, respect_gitignore = false })
end, options)
set({ "n", "v" }, "gw", builtin.grep_string, options)
set("n", "<leader>g", builtin.live_grep, options)
set("n", "<leader>/", builtin.current_buffer_fuzzy_find, options)
set("n", "<leader>k", builtin.keymaps, options)
set("n", "<leader>u", builtin.builtin, options)
set("n", "<leader>b", builtin.buffers, options)
set("n", "<leader><leader>m", builtin.marks, options)
set("n", "<leader>m", builtin.oldfiles, options)
set("n", "<leader><leader>x", builtin.command_history, options)
set("n", "<leader>d", function()
	builtin.diagnostics({ bufnr = 0 })
end, options)
set("n", "<leader><leader>d", builtin.diagnostics, options)
set("n", "<leader>q", builtin.quickfix, options)
set("n", "<leader><leader>q", builtin.quickfixhistory, options)
set("n", "gD", builtin.lsp_definitions, options)
set("n", "gr", builtin.lsp_references, options)
set("n", "<leader>s", builtin.lsp_document_symbols, options)
set("n", "<leader><leader>s", builtin.lsp_workspace_symbols, options)
set("n", "<leader><leader>u", builtin.lsp_type_definitions, options)
set("n", "<leader><leader>a", builtin.git_status, options)
set("n", "<leader><leader>c", builtin.git_commits, options)
set("n", "<leader>c", builtin.git_bcommits, options)
set("n", "<leader><leader>b", builtin.git_branches, options)
set("n", "<leader><leader>k", function()
	builtin.find_files({ cwd = "$HOME/dotfiles/nvim", prompt_title = "dotfiles" })
end, options)
