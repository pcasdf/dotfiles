local opt = vim.opt

vim.g.mapleader = " "

opt.autoindent = true
opt.belloff = "all"
opt.cursorline = true
opt.expandtab = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.grepprg = "rg --vimgrep"
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.linebreak = true
opt.matchtime = 0
opt.mousescroll = "ver:1,hor:1"
opt.number = true
opt.pumblend = 10
opt.pumheight = 20
opt.relativenumber = true
opt.shiftwidth = 4
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.updatetime = 200
opt.winblend = 10
opt.wrap = false

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}
