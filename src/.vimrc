" Plugins
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'davidhalter/jedi-vim'
Plugin 'chaimleib/vim-renpy'
call vundle#end()

filetype plugin indent on
syntax on

" Variables
let mapleader = ","

let g:NERDTreeWinSize = 80
let g:NERDTreeMinimalUI=1
let g:airline_theme = 'hybridline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline_focuslost_inactive = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 0
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_width = 80
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
let g:hybrid_custom_term_colors = 1

colorscheme hybrid

" Settings
autocmd StdinReadPre * let s:std_in=1

" Appearance
set background=dark
set colorcolumn=81
set laststatus=2
set noshowmode

" Formatting
set number relativenumber
set nowrap
set list

" Characters
set lcs=tab:>.,trail:.,extends:#,precedes:#,nbsp:.
set fcs+=vert:│

" Indentation
set tabstop=4
set shiftwidth=4
set expandtab

" Backups and swaps
set nobackup
set nowritebackup
set noswapfile

" File handling
set hidden
set autoread
set autochdir

" Searching
set ignorecase smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

" Editing
set virtualedit=block
set backspace=2
set nojoinspaces
set iskeyword-=_-

" Mappings
nnoremap ; :
vnoremap ; :

" Buffers
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>d :bp\|bd#<CR>

" Splits
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>= <C-w>=

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

nnoremap <leader>W :wa<CR>
nnoremap <leader>Q :qa<CR>
nnoremap <leader>X :xa<CR>

" Line insertion
nnoremap <leader>o :set paste<CR>m`o<ESC>``:set nopaste<CR>
nnoremap <leader>O :set paste<CR>m`O<ESC>``:set nopaste<CR>

" Plugins
nnoremap <leader><CR> :NERDTreeToggle<CR><C-w>=
nnoremap <leader><TAB> :TagbarToggle<CR><C-w>=
nnoremap <leader>e :CtrlP<CR>
nnoremap <leader>E :CtrlPMUR<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" Other
nnoremap <CR> :!<SPACE>
nnoremap <leader><SPACE> :noh<CR>
