call plug#begin()
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pearofducks/ansible-vim'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

"       seoul256
colo seoul256
set background=dark

"       vim-airline-themes
let g:airline_theme='zenburn'

" Show line number for current line and relative numbering for other lines
:set nu rnu

nnoremap Y y$
