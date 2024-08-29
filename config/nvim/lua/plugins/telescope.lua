return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      {
        "<leader>;f",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Find Files (buffer dir)",
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Find files (buffer dir)",
      },
      { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
      {
        "<leader>;g",
        function()
          require("telescope.builtin").live_grep({
            prompt_title = "Live Grep (buffer dir)",
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Live grep (buffer dir)",
      },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>;o", "<cmd>Telescope oldfiles<cr>", desc = "Find old files" },
      { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find buffer symbols" },
      {
        "<leader>;s",
        "<cmd>Telescope lsp_workspace_symbols<cr>",
        desc = "Find workspace symbols",
      },
      { "<leader>.", "<cmd>Telescope resume<cr>", desc = "Resume telescope" },
      { "<leader>;y", "<cmd>Telescope registers<cr>", desc = "find registers" },
      {
        "<leader>;d",
        function()
          require("telescope.builtin").diagnostics({ bufnr = 0 })
        end,
        desc = "Find diagnostics",
      },
      { "<leader>;D", "<cmd>Telescope diagnostics<cr>", desc = "Find workspace diagnostics" },
      {
        "<leader>w",
        "<cmd>Telescope grep_string<cr>",
        mode = { "n", "x" },
        desc = "Find word",
      },
      {
        "<leader>;w",
        function()
          require("telescope.builtin").grep_string({
            prompt_title = "Find Word (buffer dir)",
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        mode = { "n", "x" },
        desc = "Find word (buffer dir)",
      },
      { "<leader>;h", "<cmd>Telescope help_tags<cr>", desc = "Find help tags" },
      { "<leader>;H", "<cmd>Telescope highlights<cr>", desc = "Find highlights" },
      { "<leader>k", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
      { "<leader>;m", "<cmd>Telescope marks<cr>", desc = "Find marks" },
      { "<leader>;x", "<cmd>Telescope command_history<cr>", desc = "Find command history" },
      { "<leader>;q", "<cmd>Telescope quickfix<cr>", desc = "Find quickfix" },
      { "<leader>;Q", "<cmd>Telescope quickfixhistory<cr>", desc = "Find quickfix history" },
      { "<leader>;j", "<cmd>Telescope jumplist<cr>", desc = "Find jumps" },
      { "<leader>;p", "<cmd>Telescope pickers<cr>", desc = "Find pickers" },
      { "<leader>,f", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
      {
        "<leader>,i",
        function()
          require("telescope.builtin").git_files({
            prompt_title = "Git Files (others)",
            git_command = { "git", "ls-files", "--others" },
          })
        end,
        desc = "Find gitignored",
      },
      {
        "<leader>;r",
        "<cmd>Telescope lsp_references<cr>",
        desc = "Find references",
      },
      {
        "<leader>,s",
        "<cmd>Telescope git_status<cr>",
        desc = "Git status",
      },
      {
        "<leader>,l",
        function()
          require("telescope.builtin").git_commits({
            git_command = { "git", "log", "-1000", "--pretty=oneline", "--abbrev-commit", "--", "." },
          })
        end,
        desc = "Git log",
      },
      {
        "<leader>,c",
        "<cmd>Telescope git_bcommits<cr>",
        desc = "Buffer commits",
      },
      {
        "<leader>,b",
        "<cmd>Telescope git_branches<cr>",
        desc = "Git branches",
      },
      {
        "<leader>,x",
        "<cmd>Telescope git_stash<cr>",
        desc = "Git stash",
      },
      {
        "<leader>,h",
        function()
          require("telescope.builtin").git_bcommits_range({
            from = vim.fn.line("."),
            to = vim.fn.line("v"),
          })
        end,
        mode = "x",
        desc = "Git history",
      },
      {
        "<leader>,h",
        "<cmd>Telescope git_bcommits_range operator=true<cr>",
        desc = "Git history range",
      },
      {
        "<leader>;.",
        "<cmd>Telescope find_files prompt_title=dotfiles cwd=$HOME/dotfiles<cr>",
        desc = "dotfiles",
      },
      {
        "<leader>;e",
        function()
          vim.ui.input({ prompt = "rg" }, function(grep)
            if grep == nil then
              return
            end
            require("telescope.builtin").grep_string({
              prompt_title = "rg " .. grep,
              search = grep,
              use_regex = true,
              additional_args = { "--case-sensitive" },
            })
          end)
        end,
        desc = "rg",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local layout = require("telescope.actions.layout")
      local trouble = require("trouble.sources.telescope")
      local state = require("telescope.actions.state")

      local function show_with_fugitive(prompt_bufnr)
        local entry = state.get_selected_entry().value
        actions.close(prompt_bufnr)
        vim.cmd("Git show " .. entry)
      end

      local function show_with_diffview(prompt_bufnr)
        local entry = state.get_selected_entry().value
        actions.close(prompt_bufnr)
        vim.cmd("DiffviewOpen " .. entry .. "^!")
      end

      local function yank_commit()
        local entry = state.get_selected_entry().value
        print(entry)
        vim.fn.setreg("+", entry)
      end

      local function git_mappings()
        return {
          i = {
            ["<c-g>"] = show_with_fugitive,
            ["<c-v>"] = show_with_diffview,
            ["<c-y>"] = yank_commit,
          },
        }
      end

      return {
        defaults = {
          cache_picker = {
            num_pickers = 10,
          },
          mappings = {
            i = {
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
              ["<c-o>"] = actions.toggle_all,
              ["<c-p>"] = layout.toggle_preview,
              ["<c-u>"] = actions.results_scrolling_up,
              ["<c-d>"] = actions.results_scrolling_down,
              ["<m-h>"] = actions.preview_scrolling_left,
              ["<m-l>"] = actions.preview_scrolling_right,
              ["<m-u>"] = actions.preview_scrolling_up,
              ["<m-d>"] = actions.preview_scrolling_down,
              ["<m-a>"] = actions.add_selected_to_qflist,
              ["<c-t>"] = trouble.open,
              ["<c-a>"] = trouble.add,
              ["<m-n>"] = layout.cycle_layout_next,
              ["<m-p>"] = layout.cycle_layout_prev,
            },
          },
          multi_icon = "┃",
          prompt_prefix = "❯ ",
          selection_caret = "▌ ",
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
          },
          git_commits = {
            mappings = git_mappings(),
          },
          git_bcommits = {
            mappings = git_mappings(),
          },
          git_bcommits_range = {
            mappings = git_mappings(),
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
