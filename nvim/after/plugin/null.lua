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

null_ls.setup({
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
})
