vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("osc52", {}),
  pattern = "*",
  callback = function()
    if vim.v.event.operator == "y" and vim.v.event.regname == "+" or vim.v.event.regname == "" then
      require("osc52").copy_register("+")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", {}),
  pattern = {
    "help",
    "man",
    "qf",
    "fugitiveblame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("disable_terminal_line_numbers", {}),
  pattern = "*",
  callback = function()
    vim.cmd("setlocal nonumber norelativenumber signcolumn=no")
  end,
})
