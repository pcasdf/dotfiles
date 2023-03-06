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
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
		opts = {
			update_focused_file = { enable = true },
		},
		keys = {
			{
				"<leader>nt",
				function()
					require("nvim-tree.api").tree.toggle(false, true)
				end,
				desc = "NvimTree (root)",
			},
			{ "<leader>nf", "<cmd>NvimTreeFindFileToggle<cr>", desc = "NvimTree (cwd)" },
		},
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = { symbol = "│" },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "qf", "lazy", "mason", "NvimTree", "DiffviewFiles", "Outline", "lspsagaoutline" },
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
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "BufReadPost",
		opts = {},
		init = function()
			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end)
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end)
			vim.keymap.set("n", "K", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.cmd("Lspsaga hover_doc")
				end
			end)
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			delay = 200,
			filetypes_denylist = {
				"help",
				"qf",
				"lazy",
				"mason",
				"NvimTree",
				"DiffviewFiles",
				"Outline",
				"lspsagaoutline",
			},
			modes_denylist = { "v" },
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]r", "next")
			map("[r", "prev")
		end,
		keys = {
			{ "]r", desc = "Next Reference" },
			{ "[r", desc = "Prev Reference" },
		},
	},
}
