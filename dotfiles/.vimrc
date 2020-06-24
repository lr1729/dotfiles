set encoding=utf-8

" Spacing
set autoindent " Automatically indents lines
filetype indent plugin on " 
set list listchars=tab:»·,trail:·,nbsp:·  " Show extra whitespace
set tabstop=2
set shiftwidth=2 " Set tabs to 4 spaces
set expandtab

" Searching
set number relativenumber " Relative line numbers are nice
set hlsearch " Highlight searches
set incsearch " Incremental Search
set ignorecase 
set smartcase " Smart case-insensitive searching

" Syntax
syntax on
let g:airline#extensions#ale#enabled = 1
let g:OmniSharp_server_stdio = 1
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

" Keymaps
" Switch j and k for better colemak navigation
inoremap jj <ESC>
tnoremap <Esc> <C-\><C-n>
noremap j k
noremap k j
" space inserts a single character
nnoremap <Space> i_<Esc>r
" Control o opens nerdtree
map <C-o> :NERDTreeToggle<CR>
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" Appearance
colorscheme apprentice
let g:airline_powerline_fonts = 1
set termguicolors " True 24 bit colors for nvim
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("Substitute", 200)
augroup END " Highlight yanked text

" Other
set clipboard+=unnamedplus " Uses System clipboard instead of vim buffer
set nocompatible
set mouse=a " Can use mouse for yanking
set backspace=2   " Backspace deletes like most programs in insert mode

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
autocmd VimResized * wincmd =

" Quicker window movement (j and k switched for colemak)
nnoremap <C-k> <C-w>j
nnoremap <C-j> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

set nojoinspaces
set whichwrap+=<,>,h,l,[,] " Wrap lines with arrow keys and hl
set scrolloff=4 " Keeps 4 lines on edges visible when scrolling
set title

" Lose the arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use j"<CR>
nnoremap <Down> :echoe "Use k"<CR>

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
augroup END

"Add Vundle to runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"""""""""""""""""""""""
"" Add new plugins here
"""""""""""""""""""""""
Plugin 'Shougo/vimproc.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/nerdtree'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'dense-analysis/ale'
Plugin 'inside/vim-search-pulse'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes' 
Plugin 'neovim/nvim-lsp'
"""""""""""""""""""""""
"" End of plugin list
"""""""""""""""""""""""
call vundle#end()

" Post Vundle Configuration

" Transparent background
hi Normal guibg=NONE ctermbg=NONE 
