local set = vim.keymap.set
local nvim_lsp = require("lspconfig")

local signs = { Error = " ", Warn = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = false,
	update_in_insert = false,
	severity_sort = false,
})

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
