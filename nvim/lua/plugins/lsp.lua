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

      local function on_attach(client, bufnr)
        local buf = vim.lsp.buf
        local diagnostic = vim.diagnostic

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map("n", "K", buf.hover, "Lsp hover")
        map("i", "<c-l>", buf.signature_help, "Signature help")
        map("n", "<leader>n", buf.rename, "Rename")
        map({ "n", "v" }, "<leader>a", buf.code_action, "Code action")
        map("n", "<leader>lf", buf.format, "Lsp format")
        map("n", "<leader>li", buf.implementation, "Lsp implementation")
        map("n", "<leader>lq", diagnostic.setqflist, "Diagnostic quickfix")
        map("n", "<leader>ll", diagnostic.open_float, "Open line diagnostic")

        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false,
          })
          vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = "lsp_document_highlight",
          })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
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
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "n",
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
    config = function(_, opts)
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      require("conform").setup(opts)
    end,
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
