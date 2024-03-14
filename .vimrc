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

set number " Relative line numbers are nice
set numberwidth=4 " Increases line number margins
set hlsearch " Highlight searches
set incsearch " Incremental Search
set ignorecase " Ignores case when searching 
set smartcase " Unless it starts with a capital
" Use ag instead of ack for searching
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" ==========
" = Syntax =
" ==========

syntax on " Turns on syntax highlighting
filetype on " Automatic file type detection
set conceallevel=1 " Hides unneeded syntax
set omnifunc=ale#completion#OmniFunc " Let ALE handle omnicompletion
let g:ale_disable_lsp = 1 " Let Coc handle lsp
let g:airline#extensions#ale#enabled = 1 " Integrate ALE linting with airline
let g:tex_flavor='latex' " Set default filetype to LaTeX
let g:vimtex_view_method='zathura' " Use zathura as the viewer
let g:vimtex_quickfix_mode=0 " Allows quickfixes
let g:tex_conceal='abdmg' " idk
" Treat .h files as c++
let g:ale_cpp_clangtidy_options = '-Wall -std=c++11 -x c++'
let g:ale_cpp_clangcheck_options = '-- -Wall -std=c++11 -x c++'
au BufEnter * set fo-=c fo-=r fo-=o " Disable automatic comment continuation
let g:copilot_node_command = "/usr/share/nvm/versions/node/v17.9.1/bin/node"

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

  inoremap <silent><expr> <M-C-A>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

let g:UltiSnipsExpandTrigger = '<tab>' " Tab triggers Ultisnips
let g:UltiSnipsJumpForwardTrigger = '<tab>' " Tab cycles snips
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>' "Shift-Tab cycles snips in reverse

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
autocmd FileType latex,tex,md,markdown,text setlocal spell
" Remap copliot for tex files
autocmd FileType latex,tex imap <silent><script><expr> <C-J> copilot#Accept("")
autocmd FileType latex,tex let g:copilot_no_tab_map = v:true
set spelllang=en
" Autocorrect with control l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" One key compile
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ -Wall -g '.shellescape('%').' -o '.shellescape('%:r').'' <CR>
" One key debug for c++
packadd termdebug
autocmd filetype cpp nnoremap <F5> :w <bar> exec '!g++ -Wall -Werror -g '.shellescape('%').' -o '.shellescape('%:r').'' <CR> :Termdebug %:r<CR><C-\><C-n>:set filetype=gdb<CR><C-w>t<C-w>H

" One key compile
autocmd filetype c nnoremap <F4> :w <bar> exec '!make' <CR>
" One key debug for c++
autocmd filetype c nnoremap <F5> :w <bar> exec '!make' <CR> :Termdebug %:r<CR><C-\><C-n>:set filetype=gdb<CR><C-w>t<C-w>H

" One key compile for assembly
autocmd filetype asm nnoremap <F4> :w <bar> exec '!as --gstabs --32 -o '.shellescape('%:r').'.o '.shellescape('%').'' <CR>

" One key debug for assembly
autocmd filetype asm nnoremap <F5> :w <bar> exec '!as --gstabs --32 -o '.shellescape('%:r').'.o '.shellescape('%').'' <CR> :exec '!ld -m elf_i386 -o '.shellescape('%:r').'.out '.shellescape('%:r').'.o' <CR> :Termdebug %:r.out<CR><C-\><C-n>:set filetype=gdb<CR><C-w>t<C-w>H

" Debug shortcuts for c++
autocmd FileType cpp nnoremap <F6> :Run<CR>
autocmd FileType cpp nnoremap <F7> :Over<CR>
autocmd FileType cpp nnoremap <F8> :Continue<CR>
autocmd FileType cpp nnoremap <A-s> :Break<CR>
autocmd FileType cpp nnoremap <A-c> :Clear<CR>
" autocmd FileType gdb tnoremap <F9> <C-\><C-n><C-w>t:let sourcefile=expand('%:r') <CR>:w <bar> exec '!g++ -Wall -g '.shellescape('%').' -o '.shellescape('%:r').''<CR><CR><C-w>bfile <C-\><C-n>:put =sourcefile<CR>i<CR>y<CR>y<CR>r<CR>y<CR>dv<CR>

autocmd FileType gdb tnoremap <F9> <C-\><C-n><C-w>t:let sourcefile=expand('%:r') <CR>:w <bar> exec '!make'<CR><CR><C-w>b<C-\><C-n>:put ='file '.sourcefile.'.out'<CR>i<CR>y<CR>


autocmd filetype rust nnoremap <F4> :w <bar> exec '!rustc -g '.shellescape('%').' -o '.shellescape('%:r').'' <CR>
" Tab switching shortcuts
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Disable copilot for certain filetypes
let g:copilot_filetypes = {
  \ 'tex' : v:false,
  \ 'text' : v:false,
\}

let g:copilot_enabled = v:false

" ==============
" = Appearance =
" ==============

let g:airline_powerline_fonts = 1 " Adds cool arrows to airline
let g:airline#extensions#tabline#enabled = 1 " One line to rule them all
set termguicolors " True 24 bit colors for nvim
" Flash yanked text
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Substitute", timeout=150, on_visual=false}
" Disable line numbers in terminal
let g:termdebug_wide=1 " Use side by side layout for termdebug
set lbr
au TermOpen * setlocal nonumber norelativenumber


" =========
" = Other =
" =========

" set mouse=a " Can use mouse for yanking
set mouse= " Disable mouse popup menu in nvim
set splitbelow " Opens new buffers below5341704
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

let g:python_recommended_style = 0 " Use two spaces for tabs in python
filetype plugin indent on
syntax on

let g:ale_rust_rls_toolchain = 'stable'

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex' " LaTeX utils
Plug 'junegunn/vim-peekaboo' " Buffer preview
Plug 'arcticicestudio/nord-vim' " Nord colorscheme
Plug 'easymotion/vim-easymotion' " Faster movement
Plug 'mileszs/ack.vim' " Multiple file search
Plug 'fidian/hexmode' " Hex files
Plug 'ConradIrwin/vim-bracketed-paste' " Better paste indents
Plug 'editorconfig/editorconfig-vim' " Configure project standards
Plug 'tpope/vim-surround' " Better interaction with surrounds
Plug 'github/copilot.vim' " Better interaction with surrounds
Plug 'tpope/vim-commentary' " Comment faster
Plug 'sirver/ultisnips' " LaTeX snippets
Plug 'rust-lang/rust.vim' " Better rust support

" ======================
" = End of plugin list =
" ======================

call plug#end()

" =============================
" = Post plugin Configuration =
" =============================

colorscheme nord " Apply nord color scheme
" Enable transparent backgrounds
hi! Normal ctermbg=NONE guibg=NONE
" Fix colors for concealed text
hi clear Conceal
