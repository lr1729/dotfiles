set encoding=utf-8

" ===========
" = Spacing =
" ===========

set autoindent " Automatically indents lines
set list listchars=tab:»·,trail:·,nbsp:· " Show extra whitespace and differentiate tabs from spaces
set tabstop=2 " Set tabs to 2 spaces
set shiftwidth=2 " Set tabs to 2 spaces
set expandtab " Expand tabs to spaces

" =============
" = Searching =
" =============

set number relativenumber " Relative line numbers are nice
set numberwidth=4 " Increases line number margins
set hlsearch " Highlight searches
set incsearch " Incremental Search
set ignorecase " Ignores case when searching 
set smartcase " Unless it starts with a capital

" ==========
" = Syntax =
" ==========

syntax on " Turns on syntax highlighting
filetype on " Automatic file type detection
set omnifunc=ale#completion#OmniFunc " Let ALE hangle omnicompletion
let g:airline#extensions#ale#enabled = 1 " Integrate ALE linting with airline
let g:ale_completion_tsserver_autoimport = 1 " Handle imports

" ===========
" = KEYMAPS =
" ===========

" Switch j and k for better colemak navigation
noremap j k
noremap k j
" Easier keybinds to move terminals (j and k switched)
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-k> <C-\><C-N><C-w>j
tnoremap <A-j> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-k> <C-\><C-N><C-w>j
inoremap <A-j> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-k> <C-w>j
nnoremap <A-j> <C-w>k
nnoremap <A-l> <C-w>l
" use jj instead of esc
inoremap jj <ESC>
" Esc also eximts terminal mode
tnoremap <Esc> <C-\><C-n>
" can use \y and \p and \d to yank and paste from clipboard instead of vim buffer,
" capital is for on select middle button clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>d "+d
noremap <Leader>Y "*y
noremap <Leader>P "*p
noremap <Leader>D "*d
" space inserts a single character
nnoremap <Space> i_<Esc>r
" Control o opens nerdtree
map <C-o> :NERDTreeToggle<CR>
" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>
" Lose the arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe> "Use j"<CR>
nnoremap <Down> :echoe "Use k"<CR>

" ==============
" = Appearance =
" ==============

colorscheme apprentice " Cool color scheme
let g:airline_powerline_fonts = 1 " Adds cool arrows to airline
set termguicolors " True 24 bit colors for nvim
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Substitute", timeout=150} " Highlight yanks

" =========
" = Other =
" =========

set mouse=a " Can use mouse for yanking
set backspace=2   " Backspace deletes like most programs in insert mode
set splitbelow " Opens new buffers below
set splitright " Opens new buffers to the right
set nojoinspaces " Something about joining lines and spaces
set whichwrap+=<,>,h,l,[,] " Wrap lines with arrow keys and hl
set scrolloff=5 " Keeps 4 lines on edges visible when scrolling
set title " Sets title of terminal
set hidden " When opening a new buffer it hides old one
autocmd TermOpen * startinsert " Automatically enter insert mode when entering a terminal window in nvim
autocmd VimResized * wincmd = " Automatcally resizes buffers on main window resize
autocmd BufEnter,BufEnter term://* startinsert " Same as above but it actually works
let g:hardtime_default_on = 1 " Run hardtime in all buffers by default
let g:hardtime_ignore_buffer_patterns = [ "CustomPatt[ae]rn", "NERD.*" ] " Don't run in NERDtree
let g:hardtime_ignore_quickfix = 1 " Ignore quickfix window
let g:hardtime_allow_different_key = 1 " Allow consecutive different keys
let g:hardtime_maxcount = 2 " Allows 2 consecutive key presses
" When editing a file, always jump to the last known cursor position.
augroup vimrcEx
  autocmd!
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

" Loads Vundle
source ~/.vim/bundle/bclose.vim
"Add Vundle to runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" ========================
" = Add new plugins here =
" ========================

Plugin 'scrooloose/nerdtree' " Provides IDE-like file hierarchy browser
Plugin 'inside/vim-search-pulse' " Pulses search results
Plugin 'vim-airline/vim-airline' " Provides Airline bar
Plugin 'vim-airline/vim-airline-themes' " Provides Airline themes
Plugin 'flazz/vim-colorschemes' " Provides themes for vim
Plugin 'dense-analysis/ale' " Provides linting
Plugin 'junegunn/fzf.vim' " Providez fuzzy file finding
Plugin 'takac/vim-hardtime' " Disables hjkl overuse
Plugin 'valloric/youcompleteme' " Autocompletion and completion manager

" ======================
" = End of plugin list =
" ======================

call vundle#end()

" =============================
" = Post Vundle Configuration =
" =============================

" Enable transparent backgrounds
hi! Normal ctermbg=NONE guibg=NONE
