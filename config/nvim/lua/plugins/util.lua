return {
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    keys = {
      { "<c-_>", 'v:lua.MiniComment.operator() . "_"', expr = true, desc = "Comment line" },
      {
        "<c-_>",
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
        desc = "Flash treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter search",
      },
      {
        "<c-s>",
        mode = "c",
        function()
          require("flash").toggle()
        end,
        desc = "Toggle flash search",
      },
    },
    opts = {},
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = "User KittyScrollbackLaunch",
    version = "*",
    config = true,
  },
}
