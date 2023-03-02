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

			local on_attach = function(client, bufnr)
				local buf = vim.lsp.buf
				local diagnostic = vim.diagnostic
				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				set("n", "<leader><leader>l", diagnostic.setloclist, bufopts)
				set("n", "gR", buf.references, bufopts)
				set("i", "<C-l>", buf.signature_help, bufopts)
				set("n", "<C-_>", function()
					buf.format({ async = true })
				end, bufopts)
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
				starlark_rust = {},
				sqlls = {},
				svelte = {},
				terraformls = {},
				tflint = {},
				tsserver = {},
				yamlls = {},
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		keys = {
			{ "<leader>o", "<cmd>SymbolsOutline<cr>", desc = "SymbolsOutline" },
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
