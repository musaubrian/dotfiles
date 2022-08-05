set syntax
set clipboard=unnamedplus
set cursorline
set number
set relativenumber

call plug#begin()

Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sainnhe/gruvbox-material'
Plug 'jiangmiao/auto-pairs'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
call plug#end()

colorscheme gruvbox-material
let g:airline_theme='raven'

" prettier formatting
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
