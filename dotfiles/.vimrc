set number
set autoindent
set nocompatible
filetype off
syntax on
colorscheme apprentice
let g:airline_powerline_fonts = 1
"Add Vundle to runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"""""""""""""""""""""""
"" Add new plugins here
"""""""""""""""""""""""
Plugin 'scrooloose/nerdtree'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'inside/vim-search-pulse'
Plugin 'RRethy/vim-illuminate'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes' 
"""""""""""""""""""""""
"" End of plugin list
"""""""""""""""""""""""
call vundle#end()
filetype plugin indent on
map <C-o> :NERDTreeToggle<CR>
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
