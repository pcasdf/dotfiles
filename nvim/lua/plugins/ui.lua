return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
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
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = "Neotree",
		keys = {
			{
				"<leader>nt",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Neotree (root)",
			},
			{
				"<leader>nf",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Neotree (cwd)",
			},
			{ "<leader>nb", "<cmd>Neotree buffers<cr>", desc = "Neotree buffers" },
			{ "<leader>ng", "<cmd>Neotree git_status<cr>", desc = "Neotree git_status" },
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = true,
			},
			window = {
				width = 30,
				mappings = {
					["<space>"] = "none",
				},
			},
		},
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = { symbol = "│" },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "neo-tree", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "python", "yaml" },
				callback = function()
					vim.b.miniindentscope_config = {
						options = { border = "top" },
					}
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
}
