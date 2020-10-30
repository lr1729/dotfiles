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
set conceallevel=2 " Hides unneeded syntax
set omnifunc=ale#completion#OmniFunc " Let ALE hangle omnicompletion
let g:SuperTabDefaultCompletionType = "<c-x><c-o>" " Use full completion by default
let g:airline#extensions#ale#enabled = 1 " Integrate ALE linting with airline
let g:ale_completion_tsserver_autoimport = 1 " Handle imports
let g:tex_flavor='latex' " Set default filetype to LaTeX
let g:vimtex_view_method='zathura' " Use zathura as the viewer
let g:vimtex_quickfix_mode=0 " Allows quickfixes
let g:tex_conceal='abdmg' " idk
let g:UltiSnipsExpandTrigger = '<tab>' " Tab triggers Ultisnips
let g:UltiSnipsJumpForwardTrigger = '<tab>' " Tab cycles snips
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>' "Shift-Tab cycles snips in reverse
" Start a continuous compilation on file open
augroup vimtex_config
  if filereadable(@%)
    autocmd User VimtexEventInitPost VimtexCompile
  endif
augroup END

" ===========
" = KEYMAPS =
" ===========

" Easier keybinds to move terminals
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-k> <C-w>k
nnoremap <A-j> <C-w>j
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
noremap <Leader>s :w<CR> " \s for quicksave
inoremap <C-s> <C-o>:w<CR>
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
" Enable spellcheck
autocmd FileType latex,tex,md,markdown setlocal spell
set spelllang=en
" Autocorrect
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" One key compile and run for c++
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ -O2 -Wall -g '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
" One key debug for c++
packadd termdebug
autocmd filetype cpp nnoremap <F5> :w <bar> exec '!g++ -O2 -Wall -g '.shellescape('%').' -o '.shellescape('%:r').'' <CR> :Termdebug %:r<CR><C-\><C-n>:set filetype=gdb<CR><C-w>k<C-\><C-n>:q<CR>
" Debug shortcuts for c++
autocmd FileType cpp nnoremap <F6> :Run<CR>
autocmd FileType cpp nnoremap <F7> :Over<CR>
autocmd FileType cpp nnoremap <F8> :Continue<CR>
autocmd FileType cpp nnoremap <A-s> :Break<CR>
autocmd FileType cpp nnoremap <A-c> :Clear<CR>
autocmd FileType gdb tnoremap <F9> <C-\><C-n><C-w>k:let sourcefile=expand('%:r') <CR>:w <bar> exec '!g++ -O2 -Wall -g '.shellescape('%').' -o '.shellescape('%:r').''<CR><C-\><C-n><C-w>jfile <C-\><C-n>:put =sourcefile<CR>i<CR>y<CR>y<CR>r<CR>y<CR>dv<CR>

" ==============
" = Appearance =
" ==============

let g:airline_powerline_fonts = 1 " Adds cool arrows to airline
let g:airline#extensions#tabline#enabled = 1 " One line to rule them all
set termguicolors " True 24 bit colors for nvim
" Flash yanked text
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Substitute", timeout=150, on_visual=false}
" Disable line numbers in terminal
au TermOpen * setlocal nonumber norelativenumber
colorscheme nord " Apply nord color scheme


" =========
" = Other =
" =========

" set mouse=a " Can use mouse for yanking
set splitbelow " Opens new buffers below
set splitright " Opens new buffers to the right
set nojoinspaces " Something about joining lines and spaces
set whichwrap+=<,>,h,l,[,] " Wrap lines with arrow keys and hl
set scrolloff=5 " Keeps 4 lines on edges visible when scrolling
set title " Sets title of terminal
set hidden " When opening a new buffer it hides old one
autocmd TermOpen * startinsert " Automatically enter insert mode when entering a terminal window in nvim
autocmd VimResized * wincmd = " Automatically resizes buffers on main window resize
autocmd BufEnter,BufEnter term://* startinsert " Same as above but it actually works
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
autocmd FileType tex let b:coc_suggest_disable = 1
" Check for file updates every second
if ! exists("g:CheckUpdateStarted")
let g:CheckUpdateStarted=1
  call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
silent! checktime
  call timer_start(1000,'CheckUpdate')
endfunction
" Loads buffer script
source ~/.vim/scripts/bclose.vim

" Start loading plugins
call plug#begin()

" ===========
" = Plugins =
" ===========

Plug 'scrooloose/nerdtree' " Provides IDE-like file hierarchy browser
Plug 'inside/vim-search-pulse' " Pulses search results
Plug 'vim-airline/vim-airline' " Provides Airline bar
Plug 'dense-analysis/ale' " Provides linting
Plug 'junegunn/fzf.vim' " Providez fuzzy file finding
Plug 'hugolgst/vimsence' " Rich precense Plug for Discord
Plug 'ervandew/supertab' " Intelligent tab autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex' " LaTeX utils
Plug 'sirver/ultisnips' " LaTeX snippets
Plug 'junegunn/vim-peekaboo' " Buffer preview
Plug 'arcticicestudio/nord-vim' " Nord colorscheme
Plug 'mhinz/vim-startify' " Vim start screen

" ======================
" = End of plugin list =
" ======================

call plug#end()

" =============================
" = Post plugin Configuration =
" =============================

" Enable transparent backgrounds
hi! Normal ctermbg=NONE guibg=NONE
