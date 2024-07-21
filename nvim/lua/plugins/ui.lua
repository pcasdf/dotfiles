return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    keys = {
      { "gd", "<cmd>Trouble lsp_definitions<cr>", desc = "Go to definition" },
      { "gr", "<cmd>Trouble lsp_references<cr>", desc = "Go to references" },
      { "<leader>x", "<cmd>Trouble diagnostics filter.buf=0<cr>", desc = "Trouble buffer diagnostics" },
      { "\\x", "<cmd>Trouble diagnostics<cr>", desc = "Trouble workspace diagnostics" },
      { "\\s", "<cmd>Trouble symbols<cr>", desc = "Trouble symbols" },
      { "\\t", "<cmd>Trouble qflist<cr>", desc = "Trouble quickfix" },
      {
        "\\c",
        function()
          require("trouble").close()
        end,
        desc = "Close trouble",
      },
      { "\\j", "<cmd>Trouble telescope<cr>", desc = "Trouble telescope" },
      { "\\k", "<cmd>Trouble telescope_files<cr>", desc = "Trouble telescope files" },
    },
    opts = {
      focus = true,
    },
  },
  {
    "echasnovski/mini.files",
    event = "VeryLazy",
    version = "*",
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open()
        end,
        desc = "Open mini.files",
      },
      {
        "-",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0))
        end,
        desc = "Open mini.files buffer",
      },
    },
    opts = {
      options = {
        use_as_default_explorer = false,
      },
    },
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "hedyhli/outline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>o", "<cmd>Outline<cr>", desc = "Toggle Outline" },
    },
    config = true
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    keys = {
      { "<leader>t", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle NvimTree" },
    },
    opts = {},
    config = true,
  },
}
