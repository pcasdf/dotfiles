return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "dockerfile",
        "javascript",
        "json",
        "jsonnet",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]s"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]S"] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[s"] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[S"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>]a"] = "@parameter.inner",
            ["<leader>]f"] = "@function.outer",
            ["<leader>]s"] = "@class.outer",
          },
          swap_previous = {
            ["<leader>[a"] = "@parameter.inner",
            ["<leader>[f"] = "@function.outer",
            ["<leader>[s"] = "@class.outer",
          },
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "<m-]>",
          node_decremental = "<m-[>",
        },
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
  },
  {
    "kiyoon/treesitter-indent-object.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
    keys = {
      {
        "ai",
        function()
          require("treesitter_indent_object.textobj").select_indent_outer()
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer)",
      },
      {
        "aI",
        function()
          require("treesitter_indent_object.textobj").select_indent_outer(true)
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer, line-wise)",
      },
      {
        "ii",
        function()
          require("treesitter_indent_object.textobj").select_indent_inner()
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, partial range)",
      },
      {
        "iI",
        function()
          require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 300,
        custom_textobjects = {
          c = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }),
          C = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          F = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
          L = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
          r = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }),
          S = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        },
      }
    end,
    config = true,
  },
}
