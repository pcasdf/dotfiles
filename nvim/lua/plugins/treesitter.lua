return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "bash",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "tsx",
        "typescript",
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
          swap_next = { ["],"] = "@parameter.inner" },
          swap_previous = { ["[,"] = "@parameter.inner" },
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Leader>is",
          node_incremental = "<M-]>",
          node_decremental = "<M-[>",
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
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      vim.keymap.set({ "n", "x" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x" }, "T", ts_repeat_move.builtin_T)

      local gs = require("gitsigns")
      local next_hunk, prev_hunk = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
      vim.keymap.set({ "n", "x", "o" }, "]c", next_hunk)
      vim.keymap.set({ "n", "x", "o" }, "[c", prev_hunk)

      local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(function()
        vim.diagnostic.goto_next()
      end, function()
        vim.diagnostic.goto_prev()
      end)
      vim.keymap.set({ "n", "x", "o" }, "]d", next_diagnostic)
      vim.keymap.set({ "n", "x", "o" }, "[d", prev_diagnostic)

      local MiniBracketed = require("mini.bracketed")
      local next_indentation, prev_indentation = ts_repeat_move.make_repeatable_move_pair(function()
        MiniBracketed.indent("forward")
      end, function()
        MiniBracketed.indent("backward")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]i", next_indentation)
      vim.keymap.set({ "n", "x", "o" }, "[i", prev_indentation)
    end,
  },
}
