return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter-textobjects",
    },
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
    config = function()
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
      local function map_repeat(key, func, desc, opts)
        opts = opts or {}
        opts.desc = desc
        vim.keymap.set({ "n", "x", "o" }, key, func, opts)
      end

      map_repeat(";", ts_repeat_move.repeat_last_move, "Repeat last textobject move")
      map_repeat(",", ts_repeat_move.repeat_last_move_opposite, "Repeat last textobject move opposite")

      local next_hunk, prev_hunk = ts_repeat_move.make_repeatable_move_pair(function()
        require("gitsigns").nav_hunk("next")
      end, function()
        require("gitsigns").nav_hunk("prev")
      end)

      map_repeat("]h", next_hunk, "Go to next hunk")
      map_repeat("[h", prev_hunk, "Go to prev hunk")

      local next_diagnostic, prev_diagnostic =
        ts_repeat_move.make_repeatable_move_pair(vim.diagnostic.goto_next, vim.diagnostic.goto_prev)

      map_repeat("]d", next_diagnostic, "Go to next diagnostic")
      map_repeat("[d", prev_diagnostic, "Go to prev diagnostic")
    end,
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
