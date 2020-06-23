set number relativenumber
set autoindent
set clipboard+=unnamedplus
tnoremap <Esc> <C-\><C-n>
filetype off
colorscheme apprentice
let g:airline_powerline_fonts = 1
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("Substitute", 200)
augroup END
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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes' 
Plugin 'neovim/nvim-lsp'
"""""""""""""""""""""""
"" End of plugin list
"""""""""""""""""""""""
call vundle#end()
syntax on
filetype plugin indent on
map <C-o> :NERDTreeToggle<CR>
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
\ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
