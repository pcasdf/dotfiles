local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  -- disable lsp watcher. Too slow on linux
  wf._watchfunc = function()
    return function() end
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    keys = {
      { "<leader>i", "<cmd>LspInfo<cr>", desc = "Open lsp info" },
    },
    config = function()
      local signs = {
        { name = "DiagnosticSignError", text = " " },
        { name = "DiagnosticSignWarn", text = " " },
        { name = "DiagnosticSignInfo", text = " " },
        { name = "DiagnosticSignHint", text = " " },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = true,
        signs = false,
        underline = false,
        update_in_insert = true,
        float = {
          border = "solid",
        },
      })

      local function on_attach(_, bufnr)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map("n", "K", vim.lsp.buf.hover, "Lsp hover")
        map("i", "<c-l>", vim.lsp.buf.signature_help, "Signature help")
        map("n", "<leader>n", vim.lsp.buf.rename, "Rename")
        map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>l", vim.diagnostic.open_float, "Open line diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
        map("n", "[d", vim.diagnostic.goto_prev, "Go to prev diagnostic")
      end

      local servers = {
        bashls = {},
        denols = {
          autostart = false,
        },
        dockerls = {},
        html = {},
        jsonls = {},
        jsonnet_ls = {},
        lua_ls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
              },
            },
          },
        },
        ruff_lsp = {
          init_options = {
            settings = {
              args = { "--line-length", "120" },
            },
          },
        },
        rust_analyzer = {},
        tflint = {},
        terraformls = {},
        tsserver = {},
        yamlls = {},
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      for lsp, options in pairs(servers) do
        options["on_attach"] = on_attach
        options["capabilities"] = capabilities
        require("lspconfig")[lsp].setup(options)
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason" },
    keys = {
      { "<leader>m", "<cmd>Mason<cr>", desc = "Open mason" },
    },
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = true,
  },
  {
    "stevearc/conform.nvim",
    event = "LspAttach",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>c",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format file",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "fixjson" },
        lua = { "stylua" },
        nix = { "nixpkgs_fmt" },
        python = {},
        rust = { "rustfmt" },
        terraform = { "terraform_fmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "yamlfmt" },
        ["*"] = {},
        ["_"] = { "trim_whitespace" },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = true,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "LspAttach",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<m-cr>",
          accept_word = "<m-f>",
          accept_line = "<m-e>",
        },
      },
    },
    config = true,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    config = true,
  },
}
