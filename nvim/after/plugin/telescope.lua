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
			},
			n = {
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<C-a>"] = actions.smart_add_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
				["<C-z>"] = actions.smart_add_to_loclist + actions.open_loclist,
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
set("n", "<leader>a", function()
	builtin.find_files({ hidden = true, no_ignore = true })
end, options)
set("n", "<leader>G", builtin.git_files, options)
set("n", "<leader>e", extensions.file_browser.file_browser, options)
set("n", "<leader>E", function()
	extensions.file_browser.file_browser({ hidden = true, respect_gitignore = false })
end, options)
set({ "n", "v" }, "gw", builtin.grep_string, options)
set("n", "<leader>g", builtin.live_grep, options)
set("n", "<leader>/", builtin.current_buffer_fuzzy_find, options)
set("n", "<leader>k", builtin.keymaps, options)
set("n", "<leader>u", builtin.builtin, options)
set("n", "<leader>b", builtin.buffers, options)
set("n", "<leader>M", builtin.marks, options)
set("n", "<leader>m", builtin.oldfiles, options)
set("n", "<leader>X", builtin.command_history, options)
set("n", "<leader>d", function()
	builtin.diagnostics({ bufnr = 0 })
end, options)
set("n", "<leader>D", builtin.diagnostics, options)
set("n", "<leader>q", builtin.quickfix, options)
set("n", "<leader>Q", builtin.quickfixhistory, options)
set("n", "gD", builtin.lsp_definitions, options)
set("n", "<leader>R", builtin.lsp_references, options)
set("n", "<leader>s", builtin.lsp_document_symbols, options)
set("n", "<leader>S", builtin.lsp_workspace_symbols, options)
set("n", "<leader>U", builtin.lsp_type_definitions, options)
set("n", "<leader>A", builtin.git_status, options)
set("n", "<leader>C", builtin.git_commits, options)
set("n", "<leader>c", builtin.git_bcommits, options)
set("n", "<leader>B", builtin.git_branches, options)
set("n", "<leader><leader>d", function()
	builtin.find_files({ cwd = "$HOME/dotfiles/nvim", prompt_title = "dotfiles" })
end, options)
