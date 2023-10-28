local get_gbrowse_callback = function(opts)
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
      require("osc52").copy(result.output)
    end
  end
end

return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = { "Git", "G", "GBrowse", "Gwrite", "Gw", "Gedit", "Ge", "Ggrep", "Gclog", "Gread", "Gr", "Gdiffsplit" },
    keys = {
      { "<C-g><C-g>", "<Cmd>Git<CR>", desc = "Git" },
      { "<C-g><C-b>", "<Cmd>Git blame<CR>", desc = "Git blame" },
      { "<C-g><C-b>", ":'<'>Git blame<CR>", mode = "x", desc = "Git blame" },
      { "<C-g><C-c>", "<Cmd>Git commit<CR>", desc = "Git commit" },
      { "<C-g><C-s>", ":Git checkout ", desc = "Git checkout" },
      { "<C-g><C-o>", "<Cmd>GBrowse<CR>", desc = "GBrowse" },
      { "<C-g><C-o>", ":'<'>GBrowse<CR>", mode = "x", desc = "GBrowse" },
      { "<C-g><C-u>", get_gbrowse_callback({}), desc = "GBrowse yank" },
      { "<C-g><C-y>", get_gbrowse_callback({ lines = true }), desc = "GBrowse yank" },
      {
        "<C-g><C-y>",
        get_gbrowse_callback({ lines = true }),
        mode = "x",
        desc = "GBrowse yank",
      },
      {
        "<C-g><C-h>",
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
        "<C-g><C-h>",
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
      { "<C-g><C-f>", "<Cmd>Git log %<CR>", desc = "Git log %" },
      { "<C-g><C-p>", "<Cmd>Git log --patch %<CR>", desc = "Git log --patch %" },
      { "<C-g><C-j>", "<Cmd>Git log --oneline %<CR>", desc = "Git commit --oneline %" },
      { "<C-g><C-k>", "<Cmd>Git log --oneline -1000<CR>", desc = "Git log --oneline -1000" },
      { "<C-g><C-l>", "<Cmd>Git log -1000<CR>", desc = "Git log -1000" },
      { "<C-g><C-n>", "<Cmd>0Gclog<CR>", desc = "0Gclog" },
      { "<C-g><C-n>", ":'<'>Gclog<CR>", mode = "x", desc = "Gclog" },
      { "<C-g><C-d>", "<Cmd>Gdiffsplit<CR>", desc = "Gdiffsplit" },
      { "<C-g><C-q>", "<Cmd>Git difftool<CR>", desc = "Git difftool" },
      { "<C-g><C-r>", "<Cmd>Git reset %<CR>", desc = "Git reset %" },
      { "<C-g><C-x>", "<Cmd>Gread<CR>", desc = "Gread" },
      { "<C-g><C-t>", "<Cmd>Gedit @:%<CR>", desc = "Gedit @:%" },
      { "<C-g><C-e>", "<Cmd>Gedit<CR> ", desc = "Gedit" },
      { "<C-g><C-w>", "<Cmd>Gwrite<CR>", desc = "Gwrite" },
      { "<C-g><C-a>", "<Cmd>Git fetch --all<CR>", desc = "Git fetch --all" },
      { "<C-g><C-i>", "<Cmd>Git pull<CR>", desc = "Git pull" },
    },
    opts = {},
    config = function() end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      preview_config = {
        border = "none",
      },
      trouble = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function set(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        set({ "o", "x" }, "ih", "<Cmd>Gitsigns select_hunk<CR>", { desc = "Gitsigns select_hunk" })
        set("n", "<C-g>s", "<Cmd>Gitsigns stage_hunk<CR>", { desc = "Gitsigns stage_hunk" })
        set("x", "<C-g>s", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Gitsigns stage_hunk" })
        set("n", "<C-g>S", gs.undo_stage_hunk, { desc = "Gitsigns undo_stage_hunk" })
        set("n", "<C-g>u", "<Cmd>Gitsigns reset_hunk<CR>", { desc = "Gitsigns reset_hunk" })
        set("x", "<C-g>u", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Gitsigns reset_hunk" })
        set("n", "<C-g>r", gs.reset_buffer, { desc = "Gitsigns reset_buffer" })
        set("n", "<C-g>a", gs.stage_buffer, { desc = "Gitsigns stage_buffer" })
        set("n", "<C-g>p", gs.preview_hunk, { desc = "Gitsigns preview_hunk" })
        set("n", "<C-g>i", "<Cmd>Gitsigns preview_hunk_inline<CR>", { desc = "Gitsigns preview_hunk_inline" })
        set("n", "<C-g>b", function()
          gs.blame_line({ full = false })
        end, { desc = "Gitsigns blame_line" })
        set("n", "<C-g>B", function()
          gs.blame_line({ full = true })
        end, { desc = "Gitsigns blame_line full" })
        set("n", "<C-g>q", "<Cmd>Gitsigns setqflist<CR>", { desc = "Gitsigns setqflist" })
        set("n", "<C-g>n", "<Cmd>Gitsigns toggle_numhl<CR>", { desc = "Gitsigns toggle_numhl" })
        set("n", "<C-g>t", "<Cmd>Gitsigns toggle_linehl<CR>", { desc = "Gitsigns toggle_linehl" })
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<C-g>o", "<Cmd>DiffviewOpen<CR>", desc = "DiffviewOpen" },
      { "<C-g>c", "<Cmd>DiffviewClose<CR>", desc = "DiffviewClose" },
      { "<C-g>f", "<Cmd>DiffviewFileHistory %<CR>", desc = "DiffviewFileHistory %" },
      {
        "<C-g>h",
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
        desc = "DiffviewFileHistory (range)",
      },
      {
        "<C-g>h",
        "<Cmd>'<,'>DiffviewFileHistory<CR>",
        mode = { "x" },
        desc = "DiffviewFileHistory (range)",
      },
      { "<C-g>l", "<Cmd>DiffviewFileHistory<CR>", desc = "DiffviewFileHistory" },
    },
    opts = {},
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    keys = {
      { "<Leader>pr", "<Cmd>Octo pr search author:pcasdf<CR>", { desc = "Octo pr search author:pcasdf" } },
      {
        "<Leader>po",
        "<Cmd>Octo pr search author:pcasdf state:open<CR>",
        { desc = "Octo pr search author:pcasdf state:open" },
      },
      {
        "<Leader>pc",
        "<Cmd>Octo pr search author:pcasdf state:closed<CR>",
        { desc = "Octo pr search author:pcasdf state:closed" },
      },
      {
        "<Leader>rr",
        "<Cmd>Octo pr search review-requested:pcasdf<CR>",
        { desc = "Octo pr search review-requested:pcasdf" },
      },
      {
        "<Leader>ro",
        "<Cmd>Octo pr search review-requested:pcasdf state:open<CR>",
        { desc = "Octo pr search review-requested:pcasdf state:open" },
      },
      {
        "<Leader>rc",
        "<Cmd>Octo pr search review-requested:pcasdf state:closed<CR>",
        { desc = "Octo pr search review-requested:pcasdf state:closed" },
      },
      { "<Leader>pn", "<Cmd>Octo pr create<CR>", { desc = "Octo pr create" } },
      { "<Leader>gi", "<Cmd>Octo gist list<CR>", { desc = "Octo gist list" } },
      { "<Leader>rs", "<Cmd>Octo review start<CR>", { desc = "Octo review start" } },
      { "<Leader>rh", "<Cmd>Octo review close<CR>", { desc = "Octo review close" } },
      { "<Leader>re", "<Cmd>Octo review resume<CR>", { desc = "Octo review resume" } },
      { "<Leader>rd", "<Cmd>Octo review discard<CR>", { desc = "Octo review discard" } },
      { "<Leader>ra", ":Octo reviewer add ", { desc = "Octo reviewer add" } },
    },
    opts = {},
    config = true,
  },
}
