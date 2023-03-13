return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				cmd = "Mason",
				opts = {
					ensure_installed = {
						"black",
						"flake8",
						"isort",
						"mypy",
						"pyright",
						"rust-anlyzer",
						"rustfmt",
						"shellcheck",
						"shfmt",
						"stylua",
						"tsserver",
					},
				},
			},
			"onsails/lspkind.nvim",
		},
		opts = {
			diagnostics = {
				virtual_text = true,
				signs = true,
				underline = false,
				update_in_insert = false,
				severity_sort = false,
			},
		},
		config = function(_, opts)
			local set = vim.keymap.set
			local nvim_lsp = require("lspconfig")

			local signs = { Error = " ", Warn = " ", Hint = " ", Information = " " }

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config(opts.diagnostics)

			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					filter = function(client)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			local on_attach = function(client, bufnr)
				local buf = vim.lsp.buf
				local diagnostic = vim.diagnostic
				local with = function(options)
					options.noremap = true
					options.silent = true
					options.buffer = bufnr
					return options
				end

				set("n", "<leader>ls", diagnostic.setloclist, with({ desc = "Lsp diagnostic setloclist" }))
				set("i", "<C-l>", buf.signature_help, with({ desc = "Lsp signature_help" }))
				set("n", "<leader>lf", function()
					lsp_formatting(bufnr)
				end, with({ desc = "Lsp format" }))
			end

			local function get_extra_paths()
				local cwd = vim.fn.getcwd()
				local home = os.getenv("HOME")
				if string.find(cwd, home .. "/discord") then
					return { home .. "/discord/discord_common/py" }
				end

				return {}
			end

			local servers = {
				bufls = {},
				bashls = {},
				denols = {
					filetypes = { "typescript" },
					root_dir = nvim_lsp.util.root_pattern("deno.json"),
				},
				dockerls = {},
				elixirls = {},
				gopls = {},
				graphql = {},
				html = {},
				jsonls = {},
				jsonnet_ls = {},
				lua_ls = {},
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "off",
								extraPaths = get_extra_paths(),
							},
						},
					},
				},
				rnix = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = { command = "clippy" },
						},
					},
				},
				sqlls = {},
				svelte = {},
				terraformls = {},
				tflint = {},
				tsserver = {},
				yamlls = {},
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			for lsp, options in pairs(servers) do
				options["on_attach"] = on_attach
				options["capabilities"] = capabilities
				nvim_lsp[lsp].setup(options)
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local null_ls = require("null-ls")
			local utils = require("null-ls.utils")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions

			local function get_clyde_venv()
				return os.getenv("CODER_AGENT_URL") ~= nil and "clyde-env-8a5b4a17b55a10f793780068a584b7d5"
					or "clyde-env-be409fc97ce6f0677bb3cec0acf36281"
			end

			local function get_config(type, name)
				local root = utils.get_root()
				local home = os.getenv("HOME")

				local options = {}

				if string.find(root, home .. "/discord") then
					options["command"] = home .. "/.virtualenvs/" .. get_clyde_venv() .. "/bin/" .. name
				end

				return type[name].with(options)
			end

			return {
				sources = {
					formatting.buf,
					formatting.buildifier,
					formatting.black.with({
						extra_args = {
							"--line-length",
							"120",
							"--skip-string-normalization",
							"--skip-magic-trailing-comma",
							"--fast",
						},
					}),
					formatting.fixjson,
					formatting.gofmt,
					formatting.isort,
					formatting.nixfmt,
					formatting.prettierd,
					formatting.protolint,
					formatting.rustfmt,
					formatting.shfmt,
					formatting.sqlfluff,
					formatting.stylua,
					formatting.terraform_fmt,
					formatting.yamlfmt,

					diagnostics.buildifier,
					diagnostics.flake8.with({ extra_args = { "--max-line-length", "120" } }),
					diagnostics.jsonlint,
					get_config(diagnostics, "mypy"),
					diagnostics.protolint,
					diagnostics.sqlfluff,
					diagnostics.terraform_validate,
					diagnostics.yamllint,

					code_actions.gitsigns,
				},
			}
		end,
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
				"<leader>la",
				"<cmd>Lspsaga code_action<CR>",
				mode = { "n", "v" },
				desc = "Lspsaga code_action",
			},
			{ "<leader>lr", "<cmd>Lspsaga rename<CR>", desc = "Lspsaga rename" },
			{ "<leader>ld", "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga peek_definition" },
			{ "<leader>lt", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Lspsaga peek_type_definition" },
			{ "<leader>lS", "<cmd>Lspsaga term_toggle<CR>", desc = "Lspsaga term_toggle" },
			{ "<leader>ll", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Lspsaga show_line_diagnostics" },
			{
				"<leader>lc",
				"<cmd>Lspsaga show_cursor_diagnostics<CR>",
				desc = "Lspsaga show_cursor_diagnostics",
			},
			{ "<leader>lb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Lspsaga show_buf_diagnostics" },
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
			{ "<leader>lo", "<cmd>Lspsaga outline<CR>", desc = "Lspsaga outline" },
			-- { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Lspsaga hover_doc" },
		},
		opts = {
			ui = {
				winblend = 12,
				border = "rounded",
			},
			lightbulb = { enable = false },
			symbol_in_winbar = { separator = "  " },
			beacon = { enable = false },
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
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		keys = {
			{ "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "SymbolsOutline" },
		},
		config = true,
	},
	{
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			window = { blend = 0 },
		},
	},
}
