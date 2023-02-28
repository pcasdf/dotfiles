local set = vim.keymap.set

local signs = { Error = " ", Warn = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = false,
	update_in_insert = false,
	severity_sort = false,
})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	local buf = vim.lsp.buf
	local diagnostic = vim.diagnostic
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	set("n", "<C-_>", diagnostic.setloclist, bufopts)
	set("n", "gr", buf.references, bufopts)
	set("i", "<C-l>", buf.signature_help, bufopts)
	set("n", "<leader>F", function()
		buf.format({ async = true })
	end, bufopts)

	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = function()
			lsp_formatting(bufnr)
		end,
	})
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
	denols = { autostart = false },
	dockerls = {},
	elixirls = {},
	gopls = {},
	graphql = {},
	html = {},
	jsonls = {},
	jsonnet_ls = {},
	lua_ls = {},
	pyright = {
		handlers = {
			["textDocument/publishDiagnostics"] = function(...) end,
		},
		settings = {
			python = {
				analysis = { extraPaths = get_extra_paths() },
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

local nvim_lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

for lsp, options in pairs(servers) do
	options["on_attach"] = on_attach
	options["capabilities"] = capabilities
	nvim_lsp[lsp].setup(options)
end
