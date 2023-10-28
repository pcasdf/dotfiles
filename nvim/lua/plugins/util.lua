return {
  {
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<C-_>", 'v:lua.MiniComment.operator() . "_"', expr = true, desc = "Comment line" },
      { "<C-_>", [[:<c-u>lua MiniComment.operator('visual')<CR>]], mode = "x", desc = "Comment line" },
    },
    config = true,
  },
  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        add = "gza",
        delete = "gzd",
        find = "gzf",
        find_left = "gzF",
        highlight = "gzh",
        replace = "gzr",
        update_n_lines = "gzn",
        suffix_last = "l",
        suffix_next = "n",
      },
    },
    config = true,
  },
  {
    "echasnovski/mini.ai",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 300,
        custom_textobjects = {
          s = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          f = ai.gen_spec.treesitter({
            a = { "@function.outer" },
            i = { "@function.inner" },
          }),
          c = ai.gen_spec.treesitter({
            a = {  "@call.outer" },
            i = {  "@call.inner" },
          }),
          C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
        },
      }
    end,
    config = true,
  },
  {
    "echasnovski/mini.bracketed",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      comment = { suffix = "k" },
      diagnostic = { suffix = "" },
      file = { suffix = "e" },
      indent = { suffix = "" },
      treesitter = { suffix = "n" },
    },
    config = function(_, opts)
      local bracketed = require("mini.bracketed")

      local function put(cmd, regtype)
        local body = vim.fn.getreg(vim.v.register)
        local type = vim.fn.getregtype(vim.v.register)
        vim.fn.setreg(vim.v.register, body, regtype or "l")
        bracketed.register_put_region()
        vim.cmd(('normal! "%s%s'):format(vim.v.register, cmd:lower()))
        vim.fn.setreg(vim.v.register, body, type)
      end

      for _, cmd in ipairs({ "]p", "[p" }) do
        vim.keymap.set("n", cmd, function()
          put(cmd)
        end)
      end
      for _, cmd in ipairs({ "]P", "[P" }) do
        vim.keymap.set("n", cmd, function()
          put(cmd, "c")
        end)
      end

      local put_keys = { "p", "P" }
      for _, lhs in ipairs(put_keys) do
        vim.keymap.set({ "n", "x" }, lhs, function()
          return bracketed.register_put_region(lhs)
        end, { expr = true })
      end

      bracketed.setup(opts)
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        toggle = "gx",
      },
    },
    config = true,
  },
  {
    "ojroques/nvim-osc52",
    event = { "BufReadPre", "BufNewFile", "TermOpen" },
    opts = { silent = true },
    keys = {
      {
        "<Leader>yy",
        function()
          require("osc52").copy_register("+")
        end,
        desc = "osc52 yank_register",
      },
    },
    config = true,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-Space>",
          accept_word = "<M-f>",
          accept_line = "<M-e>",
        },
      },
    },
    config = true,
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    keys = {
      { "<Leader>sr", "<Cmd>lua require('spectre').toggle()<CR>", desc = "Spectre toggle" },
      {
        "<Leader>sw",
        "<Cmd>lua require('spectre').open_visual({ select_word = true })<CR>",
        desc = "Spectre open_visual",
      },
      {
        "<Leader>sw",
        "<Esc><Cmd>lua require('spectre').open_visual()<CR>",
        mode = { "x" },
        desc = "Spectre open_visual",
      },
      {
        "<Leader>sf",
        "<Cmd>lua require('spectre').open_file_search({ select_word = true })<CR>",
        mode = { "x" },
        desc = "Spectre open_visual",
      },
    },
    config = true,
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = { "VeryLazy" },
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
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
        "gs",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({ continue = true })
        end,
        desc = "Flash (continue)",
      },
      {
        "<C-s>",
        mode = "c",
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
    keys = {
      { "<Leader>ut", "<Cmd>UndotreeToggle<CR>", { desc = "UndotreeToggle" } },
      { "<Leader>us", "<Cmd>UndotreeShow<CR>", { desc = "UndotreeShow" } },
      { "<Leader>uc", "<Cmd>UndotreeHide<CR>", { desc = "UndotreeHide" } },
      { "<Leader>uf", "<Cmd>UndotreeFocus<CR>", { desc = "UndotreeFocus" } },
    },
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
}
