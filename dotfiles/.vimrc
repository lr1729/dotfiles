set encoding=utf-8

" ===========
" = Spacing =
" ===========

set autoindent " Automatically indents lines
set list listchars=tab:»·,trail:·,nbsp:· " Show extra whitespace and differentiate tabs from spaces
set tabstop=2 " Set tabs to 2 spaces
set shiftwidth=2 " Also set tabs to 2 spaces
set expandtab " Tabs turn into spaces

" =============
" = Searching =
" =============

set number relativenumber " Relative line numbers are nice
set numberwidth=5 " Increases line number margins
set hlsearch " Highlight searches
set incsearch " Incremental Searchlet g:OmniSharp_loglevel = 'debug'
set ignorecase " Ignores case when searching 
set smartcase " Unless it starts with a capital

" ==========
" = Syntax =
" ==========

let g:OmniSharp_server_use_mono = 1 " Use system mono instead
let g:OmniSharp_highlighting = 2 " Use OmniSharp highlighting for c# files
let g:OmniSharp_server_stdio = 1 " Use the async Roslyn server
let g:SuperTabDefaultCompletionType = '<c-x><c-o>' "Use basic autocomplete as supertab default
let g:SuperTabClosePreviewOnPopupClose = 1 " Not sure
set omnifunc=ale#completion#OmniFunc
let g:airline#extensions#ale#enabled = 1 " Integrate ALE linting with airline
set wildmode=list:longest,list:full " Completion type
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif " Close preview window when completion is done
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
" can use \y and \p to yank and paste from clipboard instead of vim buffer,
" capital is for on select middle button clipboard
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>Y "*y
noremap <Leader>P "*p
" space inserts a single character
nnoremap <Space> i_<Esc>r
" Control o opens nerdtree
map <C-o> :NERDTreeToggle<CR>
" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
" Uses tab and enter to select completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<C-x><C-o>"
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
augroup highlight_yank " Flash yanked text
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("Substitute", 200)
augroup END 

" =========
" = Other =
" =========

set mouse=a " Can use mouse for yanking
set backspace=2   " Backspace deletes like most programs in insert mode
" Open new split panes to right and bottom, which feels more natural
set splitbelow " Opens new buffers below
set splitright " Opens new buffers to the right
set nojoinspaces " Something about joining lines and spaces
set whichwrap+=<,>,h,l,[,] " Wrap lines with arrow keys and hl
set scrolloff=4 " Keeps 4 lines on edges visible when scrolling
set title " Sets title of terminal
set hidden " When opening a new buffer it hides old one
autocmd TermOpen * startinsert " Automatically enter insert mode when entering a terminal window in nvim
autocmd VimResized * wincmd = " Automatcally resizes buffers on main window resize
autocmd BufEnter,BufEnter term://* startinsert " Same as above but it actually works
let g:hardtime_default_on = 1 " Run hardtime in all buffers by default
let g:hardtime_ignore_buffer_patterns = [ "CustomPatt[ae]rn", "NERD.*" ] " Don't run in NERDtree
let g:hardtime_ignore_quickfix = 1 " Ignore quickfix window
let g:hardtime_allow_different_key = 1 " Allow consecutive different keys
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
set nocompatible " Not sure about this
filetype off " Omnisharp breaks without this for some reason
source ~/.vim/bundle/bclose.vim
"Add Vundle to runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" ========================
" = Add new plugins here =
" ========================
"
Plugin 'scrooloose/nerdtree'
Plugin 'inside/vim-search-pulse'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes' 
Plugin 'dense-analysis/ale'
Plugin 'junegunn/fzf.vim'
Plugin 'takac/vim-hardtime'
Plugin 'sheerun/vim-polyglot'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'ervandew/supertab'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" ======================
" = End of plugin list =
" ======================

call vundle#end()

" =============================
" = Post Vundle Configuration =
" =============================

" Transparent background
hi Normal guibg=NONE ctermbg=NONE 
syntax on " Turns on syntax highlighting
filetype indent plugin on " Not sure why this is needed
