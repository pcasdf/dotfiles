call plug#begin()

Plug 'ghifarit53/tokyonight-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'

call plug#end()

set background=dark
set cursorline
set hidden
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set signcolumn=yes
set ignorecase
set smartcase
set smartindent
set splitbelow
set splitright
set incsearch
set hlsearch
set number
set showcmd
set relativenumber
set undofile
set undodir=~/.vim/undo-dir
set encoding=utf-8
set updatetime=300
set cmdheight=1
set showmatch
set nowrap
set noerrorbells
set wildmenu
set scrolloff=5
set termguicolors
set clipboard+=unnamed
set foldmethod=indent
set foldlevel=99
set laststatus=2

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType json       setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html       setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType vim        setlocal shiftwidth=2 tabstop=2 softtabstop=2

syntax on
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

nnoremap <expr> <Esc> {-> v:hlsearch ? ":nohl\<CR>" : "\<Esc>"}()
nnoremap gq <Cmd>copen<CR>
nnoremap gl <Cmd>lopen<CR>

inoremap <C-CR> <Esc>O
inoremap <S-CR> <Esc>o

nnoremap <silent> <Space>f :Files<CR>
nnoremap <silent> <Space>F :Files %:h<CR>
nnoremap <silent> <Space>b :Buffers<CR>
nnoremap <silent> <Space>g :RG<CR>
nnoremap <silent> <Space>/ :BLines<CR>
nnoremap <silent> <Space>h :Helptags<CR>
nnoremap <silent> <Space>o :History<CR>
nnoremap <silent> <Space>m :Marks<CR>
nnoremap <silent> <Leader>gc :Commits<CR>
nnoremap <silent> <Leader>gf :BCommits<CR>
nnoremap <silent> <Leader>ga :GFiles<CR>
nnoremap <silent> <Leader>gs :GFiles?<CR>

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_preview_window = ['hidden,right,50%', 'ctrl-/']
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'LineNr'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
