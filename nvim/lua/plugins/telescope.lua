return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      { "<Space>a", "<Cmd>Telescope find_files<CR>", desc = "Telescope find_files" },
      {
        "<Space>A",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Find Files (buffer dir)",
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Telescope find_files (buffer dir)",
      },
      { "<Space>g", "<Cmd>Telescope live_grep<CR>", desc = "Telescope live_grep" },
      {
        "<Space>G",
        function()
          require("telescope.builtin").live_grep({
            prompt_title = "Live Grep (hidden, no-ignore)",
            additional_args = { "--hidden", "--no-ignore" },
          })
        end,
        desc = "Telescope live_grep (hidden, no-ignore)",
      },
      {
        "<Space>n",
        function()
          require("telescope.builtin").live_grep({
            prompt_title = "Live Grep (buffer dir)",
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Telescope live_grep (buffer dir)",
      },
      {
        "<Space>i",
        function()
          require("telescope.builtin").live_grep({
            prompt_title = "Live Grep (case-sensitive)",
            additional_args = { "--case-sensitive" },
          })
        end,
        desc = "Telescope live_grep (case-sensitive)",
      },
      {
        "<Space>I",
        function()
          require("telescope.builtin").live_grep({
            prompt_title = "Live Grep (buffer dir, case-sensitive)",
            cwd = require("telescope.utils").buffer_dir(),
            additional_args = { "--case-sensitive" },
          })
        end,
        desc = "Telescope live_grep (case-sensitive, buffer dir)",
      },
      { "<Space>b", "<Cmd>Telescope buffers<CR>", desc = "Telescope buffers" },
      {
        "<Space>e",
        function()
          require("telescope").extensions.file_browser.file_browser({
            prompt_title = "File Browser (buffer dir)",
            path = require("telescope.utils").buffer_dir(),
            respect_gitignore = false,
          })
        end,
        desc = "Telescope file_browser (buffer dir)",
      },
      {
        "<Space>t",
        function()
          require("telescope").extensions.file_browser.file_browser({
            respect_gitignore = false,
          })
        end,
        desc = "Telescope file_browser",
      },
      { "<Space>T", "<Cmd>Telescope treesitter<CR>", desc = "Telescope treesitter" },
      {
        "<Space>/",
        "<Cmd>Telescope current_buffer_fuzzy_find<CR>",
        desc = "Telescope current_buffer_fuzzy_find",
      },
      { "<Space>o", "<Cmd>Telescope oldfiles<CR>", desc = "Telescope oldfiles" },
      { "<Space>O", "<Cmd>Telescope vim_options<CR>", desc = "Telescope vim_options" },
      { "<Space>s", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "Telescope lsp_document_symbols" },
      {
        "<Space>S",
        "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
        desc = "Telescope lsp_dynamic_workspace_symbols",
      },
      { "<Space>r", "<Cmd>Telescope resume<CR>", desc = "Telescope resume" },
      { "<Space>y", "<Cmd>Telescope registers<CR>", desc = "Telescope registers" },
      {
        "<Space>d",
        function()
          require("telescope.builtin").diagnostics({ bufnr = 0 })
        end,
        desc = "Telescope diagnostics (current file)",
      },
      { "<Space>D", "<Cmd>Telescope diagnostics<CR>", desc = "Telescope diagnostics" },
      {
        "<Space>w",
        "<Cmd>Telescope grep_string<CR>",
        mode = { "n", "v" },
        desc = "Telescope grep_string",
      },
      {
        "<Space>W",
        function()
          require("telescope.builtin").grep_string({
            prompt_title = "Find Word (buffer dir)",
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        mode = { "n", "v" },
        desc = "Telescope grep_string (buffer dir)",
      },
      { "<Space>h", "<Cmd>Telescope help_tags<CR>", desc = "Telescope help_tags" },
      { "<Space>H", "<Cmd>Telescope highlights<CR>", desc = "Telescope highlights" },
      {
        "<Space>f",
        function()
          require("telescope.builtin").git_files({
            use_git_root = false,
          })
        end,
        desc = "Telescope git_files",
      },
      {
        "<Space>F",
        function()
          require("telescope.builtin").git_files({
            prompt_title = "Git Files (others)",
            use_git_root = false,
            git_command = { "git", "ls-files", "--others" },
          })
        end,
        desc = "Telescope git_files (others)",
      },
      { "<Space>c", "<Cmd>Telescope git_files<CR>", desc = "Telescope git_files" },
      {
        "<Space>C",
        function()
          require("telescope.builtin").git_files({
            prompt_title = "Git Files (others)",
            git_command = { "git", "ls-files", "--others" },
          })
        end,
        desc = "Telescope git_files (others)",
      },
      {
        "<Space>v",
        function()
          require("telescope.builtin").git_files({
            prompt_title = "Git Files (buffer dir)",
            use_git_root = false,
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Telescope git_files (buffer dir)",
      },
      {
        "<Space>V",
        function()
          require("telescope.builtin").git_files({
            prompt_title = "Git Files (buffer dir, others)",
            git_command = { "git", "ls-files", "--others" },
            use_git_root = false,
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Telescope git_files (buffer dir, others)",
      },
      {
        "<Space>P",
        function()
          require("telescope.builtin").git_files({
            prompt_title = "Git Files (file path)",
            use_file_path = true,
          })
        end,
        desc = "Telescope git_files (file path)",
      },
      { "<Space>k", "<Cmd>Telescope keymaps<CR>", desc = "Telescope keymaps" },
      { "<Space>u", "<Cmd>Telescope builtin<CR>", desc = "Telescope builtin" },
      { "<Space>m", "<Cmd>Telescope marks<CR>", desc = "Telescope marks" },
      { "<Space>X", "<Cmd>Telescope command_history<CR>", desc = "Telescope command_history" },
      { "<Space>q", "<Cmd>Telescope quickfix<CR>", desc = "Telescope quickfix" },
      { "<Space>Q", "<Cmd>Telescope quickfixhistory<CR>", desc = "Telescope quickfixhistory" },
      { "<Space>j", "<Cmd>Telescope jumplist<CR>", desc = "Telescope jumplist" },
      { "<Space>l", "<Cmd>Telescope loclist<CR>", desc = "Telescope loclist" },
      { "<Space>p", "<Cmd>Telescope pickers<CR>", desc = "Telescope loclist" },
      {
        "gd",
        "<Cmd>Telescope lsp_definitions<CR>",
        desc = "Telescope lsp_definitions",
      },
      {
        "gr",
        "<Cmd>Telescope lsp_references<CR>",
        desc = "Telescope lsp_references",
      },
      {
        "gR",
        "<Cmd>Telescope lsp_references include_current_line=true<CR>",
        desc = "Telescope lsp_references",
      },
      {
        "gt",
        "<Cmd>Telescope lsp_type_definitions<CR>",
        desc = "Telescope lsp_type_definitions",
      },
      {
        "<Leader>gd",
        "<Cmd>Telescope git_status<CR>",
        desc = "Telescope git_status",
      },
      {
        "<Leader>gl",
        function()
          require("telescope.builtin").git_commits({
            git_command = { "git", "log", "-1000", "--pretty=oneline", "--abbrev-commit", "--", "." },
          })
        end,
        desc = "Telescope git_commits",
      },
      {
        "<Leader>gf",
        "<Cmd>Telescope git_bcommits<CR>",
        desc = "Telescope git_bcommits",
      },
      {
        "<Leader>gs",
        "<Cmd>Telescope git_branches<CR>",
        desc = "Telescope git_branches",
      },
      {
        "<Leader>gx",
        "<Cmd>Telescope git_stash<CR>",
        desc = "Telescope git_stash",
      },
      {
        "<Leader>gh",
        function()
          require("telescope.builtin").git_bcommits_range({
            from = vim.fn.line("."),
            to = vim.fn.line("v"),
          })
        end,
        mode = { "v" },
        desc = "Telescope git_bcommits_range",
      },
      {
        "<Leader>gh",
        "<Cmd>Telescope git_bcommits_range operator=true<CR>",
        desc = "Telescope git_bcommits_range operator=true",
      },
      {
        "<Space>.",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "dotfiles",
            cwd = "$HOME/dotfiles",
          })
        end,
        desc = "Telescope dotfiles",
      },
      {
        "<Space>J",
        function()
          vim.ui.input({
            prompt = "Glob> ",
            centered = true,
          }, function(glob)
            if glob == nil then
              return
            end
            require("telescope.builtin").live_grep({
              prompt_title = "Glob> " .. glob,
              glob_pattern = glob,
              additional_args = { "--case-sensitive" },
            })
          end)
        end,
        desc = "Telescope live_grep (glob)",
      },
      {
        "<Space>K",
        function()
          vim.ui.input({
            prompt = "Glob> ",
            centered = true,
          }, function(glob)
            if glob == nil then
              return
            end
            vim.ui.input({
              prompt = "Grep> ",
              centered = true,
            }, function(grep)
              if grep == nil then
                return
              end
              require("telescope.builtin").grep_string({
                prompt_title = "Glob> " .. glob .. ", Grep> " .. grep,
                search = grep,
                use_regex = true,
                additional_args = {
                  "--case-sensitive",
                  "--glob=" .. glob,
                },
              })
            end)
          end)
        end,
        desc = "Telescope grep_string (glob)",
      },
      {
        "<Space>N",
        function()
          vim.ui.input({
            prompt = "Grep> ",
            centered = true,
          }, function(grep)
            if grep == nil then
              return
            end
            require("telescope.builtin").grep_string({
              prompt_title = "Grep> " .. grep,
              search = grep,
              use_regex = true,
              additional_args = { "--case-sensitive" },
            })
          end)
        end,
        desc = "Telescope grep_string",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local layout = require("telescope.actions.layout")
      local builtin = require("telescope.builtin")
      local action_state = require("telescope.actions.state")
      local Path = require("plenary.path")

      local make_select_dir_for_picker = function(picker)
        return function()
          local fb = require("telescope").extensions.file_browser
          local current_line = action_state.get_current_line()

          fb.file_browser({
            files = false,
            depth = false,
            attach_mappings = function()
              require("telescope.actions").select_default:replace(function()
                local entry_path = action_state.get_selected_entry().Path
                local dir = entry_path:is_dir() and entry_path or entry_path:parent()
                local relative = dir:make_relative(vim.fn.getcwd())
                local absolute = dir:absolute()

                picker({
                  results_title = relative .. "/",
                  cwd = absolute,
                  default_text = current_line,
                })
              end)

              return true
            end,
          })
        end
      end

      local open_using = function(finder, overrides)
        return function(prompt_bufnr)
          local current_finder = action_state.get_current_picker(prompt_bufnr).finder
          local entry = action_state.get_selected_entry()

          local entry_path
          if entry.ordinal == ".." then
            entry_path = Path:new(current_finder.path)
          else
            entry_path = action_state.get_selected_entry().Path
          end

          local path = entry_path:is_dir() and entry_path:absolute() or entry_path:parent():absolute()
          actions.close(prompt_bufnr)
          local opts = { cwd = path }
          overrides = overrides or {}
          for k, v in pairs(overrides) do
            opts[k] = v
          end
          finder(opts)
        end
      end

      local show_with_fugitive = function(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry().value
        require("telescope.actions").close(prompt_bufnr)
        vim.cmd("Git show " .. entry)
      end

      local diff_with_fugitive = function(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry().value
        require("telescope.actions").close(prompt_bufnr)
        vim.cmd("Git diff " .. entry)
      end

      local yank_commit = function(_)
        local entry = require("telescope.actions.state").get_selected_entry().value
        print(entry)
        require("osc52").copy(entry)
      end

      return {
        defaults = {
          winblend = 10,
          cache_picker = {
            num_pickers = 10,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-a>"] = actions.toggle_all,
              ["<C-t>"] = layout.toggle_preview,
              ["<M-,>"] = actions.preview_scrolling_left,
              ["<M-.>"] = actions.preview_scrolling_right,
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-a>"] = actions.toggle_all,
              ["<C-t>"] = layout.toggle_preview,
              ["<M-,>"] = actions.preview_scrolling_left,
              ["<M-.>"] = actions.preview_scrolling_right,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = {
              "fd",
              "--type",
              "f",
              "--hidden",
              "--no-ignore",
              "--exclude",
              ".git",
              "--exclude",
              "node_modules",
            },
            mappings = {
              i = {
                ["<C-f>"] = make_select_dir_for_picker(builtin.find_files),
              },
              n = {
                ["<C-f>"] = make_select_dir_for_picker(builtin.find_files),
              },
            },
          },
          live_grep = {
            mappings = {
              i = {
                ["<C-f>"] = make_select_dir_for_picker(builtin.live_grep),
              },
              n = {
                ["<C-f>"] = make_select_dir_for_picker(builtin.live_grep),
              },
            },
          },
          git_files = {
            mappings = {
              i = {
                ["<C-f>"] = make_select_dir_for_picker(builtin.git_files),
              },
              n = {
                ["<C-f>"] = make_select_dir_for_picker(builtin.git_files),
              },
            },
          },
          git_status = {
            mappings = {
              i = {
                ["<C-g>"] = diff_with_fugitive,
              },
              n = {
                ["<C-g>"] = diff_with_fugitive,
              },
            },
          },
          git_commits = {
            mappings = {
              i = {
                ["<C-g>"] = show_with_fugitive,
                ["<C-y>"] = yank_commit,
              },
              n = {
                ["<C-g>"] = show_with_fugitive,
                ["<C-y>"] = yank_commit,
              },
            },
          },
          git_bcommits = {
            mappings = {
              i = {
                ["<C-g>"] = show_with_fugitive,
                ["<C-y>"] = yank_commit,
              },
              n = {
                ["<C-g>"] = show_with_fugitive,
                ["<C-y>"] = yank_commit,
              },
            },
          },
          git_bcommits_range = {
            mappings = {
              i = {
                ["<C-g>"] = show_with_fugitive,
                ["<C-y>"] = yank_commit,
              },
              n = {
                ["<C-g>"] = show_with_fugitive,
                ["<C-y>"] = yank_commit,
              },
            },
          },
          buffers = {
            mappings = {
              i = {
                ["<C-h>"] = actions.delete_buffer,
              },
              n = {
                ["<C-h>"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
          file_browser = {
            hidden = true,
            mappings = {
              i = {
                ["<C-z>"] = open_using(builtin.find_files),
                ["<C-s>"] = open_using(builtin.git_files, { use_git_root = false }),
                ["<C-r>"] = open_using(builtin.live_grep),
              },
              n = {
                ["<C-z>"] = open_using(builtin.find_files),
                ["<C-s>"] = open_using(builtin.git_files, { use_git_root = false }),
                ["<C-r>"] = open_using(builtin.live_grep),
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      require("telescope").setup(opts)

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("harpoon")
      telescope.load_extension("dir")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<Space>M",
        "<Cmd>Telescope harpoon marks<CR>",
        desc = "Telescope harpoon marks",
      },
      {
        "<Leader>ma",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon add_file",
      },
      {
        "<Leader>mr",
        function()
          require("harpoon.mark").rm_file()
        end,
        desc = "Harpoon rm_file",
      },
      {
        "<Leader>mt",
        function()
          require("harpoon.mark").toggle_file()
        end,
        desc = "Harpoon toggle_file",
      },
      {
        "<Leader>mq",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon toggle_quick_menu",
      },
      {
        "<Leader>1",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Harpoon file 1",
      },
      {
        "<Leader>2",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Harpoon file 2",
      },
      {
        "<Leader>3",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Harpoon file 3",
      },
      {
        "<Leader>4",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Harpoon file 4",
      },
      {
        "<Leader>5",
        function()
          require("harpoon.ui").nav_file(5)
        end,
        desc = "Harpoon file 5",
      },
      {
        "<Leader>6",
        function()
          require("harpoon.ui").nav_file(6)
        end,
        desc = "Harpoon file 6",
      },
      {
        "<Leader>7",
        function()
          require("harpoon.ui").nav_file(7)
        end,
        desc = "Harpoon file 7",
      },
      {
        "<Leader>8",
        function()
          require("harpoon.ui").nav_file(8)
        end,
        desc = "Harpoon file 8",
      },
      {
        "<Leader>9",
        function()
          require("harpoon.ui").nav_file(9)
        end,
        desc = "Harpoon file 9",
      },
      {
        "<Leader>0",
        function()
          require("harpoon.ui").nav_file(10)
        end,
        desc = "Harpoon file 10",
      },
      {
        "<Space>1",
        function()
          require("harpoon.term").gotoTerminal(1)
        end,
        desc = "Harpoon terminal 1",
      },
      {
        "<Space>2",
        function()
          require("harpoon.term").gotoTerminal(2)
        end,
        desc = "Harpoon terminal 2",
      },
      {
        "<Space>3",
        function()
          require("harpoon.term").gotoTerminal(3)
        end,
        desc = "Harpoon terminal 3",
      },
      {
        "<Space>4",
        function()
          require("harpoon.term").gotoTerminal(4)
        end,
        desc = "Harpoon terminal 4",
      },
      {
        "<Space>5",
        function()
          require("harpoon.term").gotoTerminal(5)
        end,
        desc = "Harpoon terminal 5",
      },
      {
        "<Space>6",
        function()
          require("harpoon.term").gotoTerminal(6)
        end,
        desc = "Harpoon terminal 6",
      },
      {
        "<Space>7",
        function()
          require("harpoon.term").gotoTerminal(7)
        end,
        desc = "Harpoon terminal 7",
      },
      {
        "<Space>8",
        function()
          require("harpoon.term").gotoTerminal(8)
        end,
        desc = "Harpoon terminal 8",
      },
      {
        "<Space>9",
        function()
          require("harpoon.term").gotoTerminal(9)
        end,
        desc = "Harpoon terminal 9",
      },
      {
        "<Space>0",
        function()
          require("harpoon.term").gotoTerminal(10)
        end,
        desc = "Harpoon terminal 10",
      },
      {
        "['",
        function()
          require("harpoon.ui").nav_prev()
        end,
        desc = "Harpoon prev",
      },
      {
        "]'",
        function()
          require("harpoon.ui").nav_next()
        end,
        desc = "Harpoon next",
      },
    },
    version = "*",
    config = true,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "princejoogie/dir-telescope.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<Space>z", "<Cmd>Telescope dir find_files<CR>", desc = "Telescope dir find_files" },
      { "<Space>x", "<Cmd>Telescope dir live_grep<CR>", desc = "Telescope dir live_grep" },
    },
  },
}
