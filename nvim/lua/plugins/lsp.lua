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
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = { "Mason" },
        config = true,
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name, numhl = "" })
      end
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = false,
        update_in_insert = true,
        severity_sort = false,
        float = {
          focusable = true,
          severity_sort = true,
          header = "",
          prefix = "",
          style = "minimal",
        },
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("neodev").setup()

      local on_attach = function(_, bufnr)
        local buf = vim.lsp.buf
        local diagnostic = vim.diagnostic
        local function set(mode, l, r, opts)
          opts = opts or {}
          opts.noremap = true
          opts.silent = true
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        vim.keymap.set("n", "<Leader>k", diagnostic.open_float, { desc = "Open Float" })
        set("n", "K", buf.hover, { desc = "LSP Hover" })
        set("n", "<Leader>ll", diagnostic.setloclist, { desc = "vim.diagnostic.setloclist" })
        set("n", "<Leader>lq", diagnostic.setqflist, { desc = "vim.diagnostic.setqflist" })
        set("i", "<C-k>", buf.signature_help, { desc = "vim.lsp.buf.signature_help" })
        set("n", "<Leader>lf", buf.format, { desc = "vim.lsp.buf.format" })
        set("n", "<Leader>li", buf.implementation, { desc = "vim.lsp.buf.implementation" })
        set("n", "<Leader>lr", buf.rename, { desc = "vim.lsp.buf.rename" })
        set({ "n", "v" }, "<Leader>la", buf.code_action, { desc = "vim.lsp.buf.code_action" })
      end

      local servers = {
        bashls = {
          autostart = false,
        },
        denols = {
          autostart = false,
          filetypes = { "typescript" },
          root_dir = require("lspconfig").util.root_pattern("deno.json"),
        },
        dockerls = {
          autostart = false,
        },
        gopls = {},
        html = {},
        jsonls = {
          autostart = false,
        },
        jsonnet_ls = {
          autostart = false,
        },
        lua_ls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                extraPaths = (function()
                  local cwd = vim.fn.getcwd()
                  local home = os.getenv("HOME")
                  if string.find(cwd, home .. "/discord") then
                    return { home .. "/discord/discord_common/py" }
                  end

                  return {}
                end)(),
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
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
            },
          },
        },
        tflint = {
          autostart = false,
        },
        terraformls = {
          autostart = false,
        },
        tsserver = {},
        yamlls = {
          autostart = false,
        },
      }

      for lsp, options in pairs(servers) do
        options["on_attach"] = on_attach
        options["capabilities"] = capabilities
        require("lspconfig")[lsp].setup(options)
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local diagnostics = require("null-ls").builtins.diagnostics

      return {
        sources = {
          diagnostics.mypy,
        },
      }
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    keys = {
      { "<Leader>so", "<Cmd>SymbolsOutline<CR>", desc = "SymbolsOutline" },
    },
    opts = {
      symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
      },
    },
    config = true,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    opts = {},
    keys = {
      {
        "<Leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "x" },
        desc = "Conform",
      },
    },
    config = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      require("conform").setup({
        formatters_by_ft = {
          javascript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          json = { "fixjson" },
          lua = { "stylua" },
          python = { "isort", "black" },
          rust = { "rustfmt" },
          terraform = { "terraform_fmt" },
          typescript = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          yaml = { "yamlfmt" },
          ["*"] = {},
          ["_"] = { "trim_whitespace" },
        },
      })
      require("conform.formatters.black").args = {
        "--stdin-filename",
        "$FILENAME",
        "--quiet",
        "--line-length",
        "120",
        "--skip-string-normalization",
        "-",
      }
    end,
  },
}
