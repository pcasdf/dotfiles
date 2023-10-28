return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "echasnovski/mini.starter",
    version = false,
    event = { "VimEnter" },
    opts = function()
      local pad = string.rep(" ", 22)
      local new_section = function(name, action, section)
        return {
          name = name,
          action = action,
          section = pad .. section,
        }
      end

      local starter = require("mini.starter")
      local config = {
        silent = true,
        evaluate_single = true,
        items = {
          new_section("find", "Telescope git_files use_git_root=false", "search"),
          new_section("recent", "Telescope oldfiles", "search"),
          new_section("grep", "Telescope live_grep", "search"),
          new_section("browse", "Telescope file_browser", "search"),
          new_section("harpoon", "Telescope harpoon marks", "search"),
          new_section("lazy", "Lazy", "config"),
          new_section("mason", "Mason", "config"),
          new_section(
            "dotfiles",
            "Telescope find_files find_command=fd,--type,f,--hidden,--exclude,.git,--exclude,node_modules cwd=~/dotfiles",
            "config"
          ),
          new_section("new", "ene", "buffer"),
          new_section("terminal", "ene | lua require('harpoon.term').gotoTerminal(1)", "buffer"),
          new_section("quit", "qa", "buffer"),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.aligning("center", "center"),
        },
      }
      return config
    end,
    config = function(_, opts)
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 8)
          starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy" },
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 3 } },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
      extensions = {
        "fugitive",
        "lazy",
        "man",
        "nvim-tree",
        "quickfix",
        "symbols-outline",
        "trouble",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    opts = {},
    keys = {
      { "<Leader>no", "<Cmd>NvimTreeOpen<CR>", desc = "NvimTreeOpen" },
      { "<Leader>nc", "<Cmd>NvimTreeClose<CR>", desc = "NvimTreeClose" },
      { "<C-t>", "<Cmd>NvimTreeFindFileToggle<CR>", desc = "NvimTreeFindFileToggle" },
      { "<Leader>nt", "<Cmd>NvimTreeToggle<CR>", desc = "NvimTreeToggle" },
      { "<Leader>nf", "<Cmd>NvimTreeFindFile<CR>", desc = "NvimTreeFindFile" },
    },
    config = true,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      mode = "document_diagnostics",
      padding = false,
    },
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
      { "<Leader>tt", "<Cmd>TroubleToggle<CR>", desc = "TroubleToggle" },
      { "<Leader>tw", "<Cmd>Trouble workspace_diagnostics<CR>", desc = "Trouble workspace_diagnostics" },
      { "<Leader>td", "<Cmd>Trouble document_diagnostics<CR>", desc = "Trouble document_diagnostics" },
      { "<Leader>tq", "<Cmd>Trouble quickfix<CR>", desc = "Trouble quickfix" },
      { "<Leader>tl", "<Cmd>Trouble loclist<CR>", desc = "Trouble loclist" },
      { "<Leader>tr", "<Cmd>Trouble lsp_references<CR>", desc = "Trouble lsp_references" },
    },
  },
  {
    "j-hui/fidget.nvim",
    event = { "LspAttach" },
    tag = "legacy",
    opts = {},
  },
}
