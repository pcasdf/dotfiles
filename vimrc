call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/ReplaceWithRegister'

call plug#end()

syntax on
set autoindent
set background=dark
set clipboard+=unnamed
set cmdheight=1
set cursorline
set encoding=utf-8
set expandtab
set foldlevel=99
set foldmethod=indent
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set noerrorbells
set noswapfile
set nowrap
set relativenumber
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set smartindent
set softtabstop=4
set tabstop=4
set termguicolors
set undodir=~/.vim/undo
set undofile
set updatetime=300
set fillchars=vert:\ " Blank

set rtp+=~/.config/vim/tokyonight.nvim/extras/vim
colorscheme tokyonight
hi link Sneak None
hi CursorLine cterm=NONE
hi CursorLineNr cterm=NONE
hi Folded cterm=NONE

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
