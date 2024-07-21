return {
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    keys = {
      { "<c-;>", 'v:lua.MiniComment.operator() . "_"', expr = true, desc = "Comment line" },
      {
        "<c-;>",
        function()
          local a = vim.fn.line(".")
          local b = vim.fn.line("v")
          local from = math.min(a, b)
          local to = math.max(a, b)
          require("mini.comment").toggle_lines(from, to)
        end,
        mode = { "i", "x" },
        desc = "Comment line",
      },
    },
    config = true,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gza",
        delete = "gzd",
        replace = "gzr",
        suffix_last = "l",
        suffix_next = "n",
        find = "",
        find_left = "",
        highlight = "",
        update_n_lines = "",
      },
    },
    config = true,
  },
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    opts = {
      comment = { suffix = "" },
      diagnostic = { suffix = "" },
      file = { suffix = "" },
      treesitter = { suffix = "" },
      yank = { suffix = "" },
    },
    config = true,
  },
  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    opts = {
      mappings = {
        toggle = "<leader>j",
      },
    },
    config = true,
  },
  {
    "echasnovski/mini.operators",
    event = "VeryLazy",
    opts = {
      replace = {
        prefix = "gp",
      },
    },
    config = true,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    config = true,
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
    },
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = "User KittyScrollbackLaunch",
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    version = "^5.0.0", -- pin major version, include fixes and features that do not have breaking changes
    config = true,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    keys = {
      {
        "I",
        function()
          require("various-textobjs").restOfIndentation()
        end,
        mode = { "o", "x" },
        desc = "restOfIndentation",
      },
      {
        "P",
        function()
          require("various-textobjs").restOfParagraph()
        end,
        mode = { "o", "x" },
        desc = "restOfParagraph",
      },
      {
        "is",
        function()
          require("various-textobjs").subword("inner")
        end,
        mode = { "o", "x" },
        desc = "subword(inner)",
      },
      {
        "as",
        function()
          require("various-textobjs").subword("outer")
        end,
        mode = { "o", "x" },
        desc = "subword(outer)",
      },
      {
        "L",
        function()
          require("various-textobjs").nearEoL()
        end,
        mode = { "o", "x" },
        desc = "nearEoL",
      },
    },
    opts = {
      useDefaultKeymaps = true,
      disabledKeymaps = {
        "L",
        "R",
        "aC",
        "aS",
        "al",
        "ac",
        "an",
        "aq",
        "iC",
        "iS",
        "ic",
        "il",
        "in",
        "iq",
        "n",
        "r",
      },
    },
    config = true,
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      { "y", "<plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
      { "p", "<plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      { "P", "<plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      { "<c-p>", "<plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
      { "<c-n>", "<plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
      { "]p", "<plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
      { "<leader>p", "<cmd>YankyRingHistory<cr>", mode = { "n", "x" }, desc = "Yanky ring history" },
    },
    opts = {
      highlight = {
        timer = 200,
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
