return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
