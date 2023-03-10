local opt = vim.opt

opt.autoindent = true
opt.belloff = "all"
opt.breakindent = true
opt.cindent = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.cursorline = true
opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
opt.expandtab = true
opt.fillchars = { eob = " " }
opt.foldcolumn = "0"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep --smart-case"
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.incsearch = true
opt.joinspaces = false
opt.linebreak = true
opt.matchtime = 0
opt.modelines = 1
opt.mouse = "n"
opt.number = true
opt.pumblend = 12
opt.pumheight = 20
opt.relativenumber = true
opt.scrolloff = 5
opt.shada = { "!", "'1000", "<50", "s10", "h" }
opt.shiftwidth = 4
opt.showcmd = true
opt.showmatch = true
opt.showmode = false
opt.sidescrolloff = 10
opt.signcolumn = "yes"
opt.smartcase = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.ttimeout = false
opt.updatetime = 1000
opt.wildignore = { "*.o", "*~", "*.pyc", "*pycache*" }
opt.winblend = 12
opt.wrap = false
