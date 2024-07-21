local function get_gbrowse_callback(opts)
  opts = opts or {}
  return function()
    local cmd = "GBrowse!"
    if opts.lines then
      cmd = ".GBrowse!"
      if vim.fn.mode() == "V" then
        cmd = vim.fn.line(".") .. "," .. vim.fn.line("v") .. "GBrowse!"
      end
    end
    local success, result, _ = pcall(vim.api.nvim_exec2, cmd, { output = true })
    if success then
      print(result.output)
      vim.fn.setreg("+", result.output)
    end
  end
end

return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    event = "VeryLazy",
    keys = {
      { "\\g", "<cmd>Git<cr>", desc = "Fugitive" },
      { "\\b", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "\\b", ":'<'>Git blame<cr>", mode = "x", desc = "Git blame" },
      { "\\o", "<cmd>GBrowse<cr>", desc = "GBrowse" },
      { "\\o", ":'<'>GBrowse<cr>", mode = "x", desc = "GBrowse" },
      { "\\u", get_gbrowse_callback(), desc = "GBrowse yank" },
      { "\\y", get_gbrowse_callback({ lines = true }), desc = "GBrowse yank" },
      {
        "\\y",
        get_gbrowse_callback({ lines = true }),
        mode = "x",
        desc = "GBrowse yank",
      },
      {
        "\\h",
        function()
          local old_func = vim.go.operatorfunc
          _G.op_func_formatting = function()
            local start = vim.api.nvim_buf_get_mark(0, "[")[1]
            local finish = vim.api.nvim_buf_get_mark(0, "]")[1]
            vim.cmd("Git log -L " .. start .. "," .. finish .. ":" .. vim.fn.expand("%"))
            vim.go.operatorfunc = old_func
            _G.op_func_formatting = nil
          end
          vim.go.operatorfunc = "v:lua.op_func_formatting"
          vim.api.nvim_feedkeys("g@", "n", false)
        end,
        desc = "Git log -L",
      },
      {
        "\\h",
        function()
          local a = vim.fn.line(".")
          local b = vim.fn.line("v")
          local from = math.min(a, b)
          local to = math.max(a, b)
          vim.cmd("Git log -L " .. from .. "," .. to .. ":" .. vim.fn.expand("%"))
        end,
        mode = { "x" },
        desc = "Git log -L",
      },
      { "\\f", "<cmd>Git log %<cr>", desc = "Git log %" },
      { "\\v", "<cmd>Git log --patch %<cr>", desc = "Git log --patch %" },
      { "\\l", "<cmd>Git log -1000<cr>", desc = "Git log -1000" },
      { "\\p", "<cmd>0Gclog<cr>", desc = "0Gclog" },
      { "\\p", ":'<'>Gclog<cr>", mode = "x", desc = "Gclog" },
      { "\\d", "<cmd>Gdiffsplit<cr>", desc = "Gdiffsplit" },
      { "\\q", "<cmd>Git difftool<cr>", desc = "Git difftool" },
      { "\\r", "<cmd>Gread<cr>", desc = "Gread" },
      { "\\e", "<cmd>Gedit<cr> ", desc = "Gedit" },
      { "\\w", "<cmd>Gwrite<cr>", desc = "Gwrite" },
    },
    opts = {},
    config = function() end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      preview_config = {
        border = "solid",
      },
      trouble = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map({"n", "x"}, "<leader>ha", ":Gitsigns stage_hunk<cr>", "Stage hunk")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map({ "n", "x" }, "<leader>hr", ":Gitsigns reset_hunk<cr>", "Reset hunk")
        map("n", "<leader>hB", gs.blame, "Blame buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<cr>", "Preview hunk inline")
        map("n", "<leader>hb", function()
          gs.blame_line({ full = false })
        end, "Blame line")
        map("n", "<leader>hf", function()
          gs.blame_line({ full = true })
        end, "Blame line full")
        map("n", "<leader>hn", "<cmd>Gitsigns toggle_numhl<cr>", "Toggle gitsigns numbers")
        map("n", "<leader>ht", "<cmd>Gitsigns toggle_linehl<cr>", "Toggle gitsigns lines")
        map({ "o", "x" }, "ih", ":<c-u>Gitsigns select_hunk<cr>", "Select hunk")
        map({ "o", "x" }, "ah", ":<c-u>Gitsigns select_hunk<cr>", "Select hunk")
        map("n", "]H", function()
          gs.nav_hunk("last")
        end, "Last hunk")
        map("n", "[H", function()
          gs.nav_hunk("first")
        end, "First hunk")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>d", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
      { "<leader>'c", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
      { "<leader>'f", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffviewFileHistory %" },
      {
        "<leader>'h",
        function()
          local old_func = vim.go.operatorfunc
          _G.op_func_formatting = function()
            local start = vim.api.nvim_buf_get_mark(0, "[")[1]
            local finish = vim.api.nvim_buf_get_mark(0, "]")[1]
            vim.cmd(start .. "," .. finish .. "DiffviewFileHistory")
            vim.go.operatorfunc = old_func
            _G.op_func_formatting = nil
          end
          vim.go.operatorfunc = "v:lua.op_func_formatting"
          vim.api.nvim_feedkeys("g@", "n", false)
        end,
        desc = "DiffviewFileHistory",
      },
      {
        "<leader>'h",
        "<cmd>'<,'>DiffviewFileHistory<cr>",
        mode = { "x" },
        desc = "Line History",
      },
      { "<leader>'l", "<cmd>DiffviewFileHistory<cr>", desc = "DiffviewFileHistory" },
    },
    opts = {},
  },
}
