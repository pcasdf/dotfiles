return {
	{
		"echasnovski/mini.starter",
		version = false,
		event = "VimEnter",
		opts = function()
			local pad = string.rep(" ", 22)
			local new_section = function(name, action, section)
				return { name = name, action = action, section = pad .. section }
			end

			local starter = require("mini.starter")
			local config = {
				evaluate_single = true,
				items = {
					new_section("Find file", "Telescope find_files", "Telescope"),
					new_section("Recent files", "Telescope oldfiles", "Telescope"),
					new_section("Grep text", "Telescope live_grep", "Telescope"),
					new_section("init.lua", "e $HOME/.config/nvim/init.lua", "Config"),
					new_section("Lazy", "Lazy", "Config"),
					new_section("New file", "ene | startinsert", "Built-in"),
					new_section("Quit", "qa", "Built-in"),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(pad .. "░ ", false),
					starter.gen_hook.aligning("center", "center"),
				},
			}
			return config
		end,
		config = function(_, config)
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "MiniStarterOpened",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			local starter = require("mini.starter")
			starter.setup(config)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					local pad_footer = string.rep(" ", 8)
					starter.config.footer = pad_footer
						.. "⚡ Neovim loaded "
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(starter.refresh)
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				theme = "auto",
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		},
	},
	{
		"glepnir/lspsaga.nvim",
		event = { "BufReadPre", "BufNewFile" },
		branch = "main",
		dependencies = {
			"nvim-web-devicons",
			"nvim-treesitter",
		},
		keys = {
			{ "gh", "<cmd>Lspsaga lsp_finder<CR>", desc = "Lspsaga lsp_finder" },
			{
				"<leader>x",
				"<cmd>Lspsaga code_action<CR>",
				mode = { "n", "v" },
				desc = "Lspsaga code_action",
			},
			{ "<leader><leader>r", "<cmd>Lspsaga rename<CR>", desc = "Lspsaga rename" },
			{ "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Lspsaga goto_definition" },
			{ "<M-d>", "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga peek_definition" },
			{ "<M-t>", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Lspsaga peek_type_definition" },
			{ "gt", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Lspsaga goto_type_definition" },
			{ "<leader>l", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Lspsaga show_line_diagnostics" },
			{
				"<leader><leader>i",
				"<cmd>Lspsaga show_cursor_diagnostics<CR>",
				desc = "Lspsaga show_cursor_diagnostics",
			},
			{ "<leader>w", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Lspsaga show_buf_diagnostics" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Lspsaga diagnostic_jump_prev" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Lspsaga diagnostic_jump_next" },
			{
				"[D",
				function()
					require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
				desc = "Lspsaga goto_prev error",
			},
			{
				"]D",
				function()
					require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
				desc = "Lspsaga goto_next error",
			},
			{ "<leader><leader>o", "<cmd>Lspsaga outline<CR>", desc = "Lspsaga outline" },
			{ "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga hover_doc" },
		},
		opts = {
			lightbulb = { enable = false },
			symbol_in_winbar = { separator = "  " },
			beacon = { frequency = 10 },
			definition = {
				edit = "<C-w>o",
				vsplit = "<C-w>v",
				split = "<C-w>s",
				tabe = "<C-t>",
				quit = "q",
			},
			finder = {
				keys = { vsplit = "v", split = "s" },
			},
			ui = { winblend = 12 },
		},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
}
