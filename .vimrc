set nocompatible              " vim, not vi. required
set autoread
set autowrite " autosave before eg :next and :make
filetype off                  " required

call plug#begin('~/.vim/plugged')

" more lightweight than Powerline
Plug 'bling/vim-airline'
"Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'flazz/vim-colorschemes'
" utility
"Plug 'Shougo/neocomplete.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
" does not solve the symlink issue in tree view but hey, it's a later version
Plug 'eiginn/netrw'
" generic programming support
" languages
Plug 'justinmk/vim-syntax-extra'
Plug 'hdima/python-syntax'

" All of your Plugins must be added before the following line
call plug#end()
"call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" show linenumbers
set number
set ruler

" always show the status line
set laststatus=2
" elite mode, no arrows
"let g:elite_mode=1
" enable highlighting of current line
set cursorline

set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set backspace=indent,eol,start

" macvim
if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Inconsolata\ for\ Powerline:h15
    endif
endif

if (has("termguicolors"))
    set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable
colorscheme molokai

let mapleader = ' '

" old own stuff
set history=1000
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap
set formatoptions=qrn1tco
set textwidth =0 wrapmargin=0
set hidden
 

" netrw things
let g:netrw_liststyle=3
" https://github.com/tpope/vim-vinegar/issues/13
autocmd FileType netrw setl bufhidden=delete 
let g:netrw_list_hide='.*\.swp$,^.*\.pyc$'

let g:markdown_fenced_languages = ['c', 'python', 'scala', 'sql', 'sh', 'perl', 'ruby', 'awk']
" comment code
autocmd FileType python,sh noremap <Leader>c :normal U# <Esc>
autocmd FileType vim noremap <Leader>c :normal U" <Esc>

"buffer stuff 
:nnoremap <Leader>b :ls<CR>
:nnoremap <Leader>en :e ~/notes.md<CR>
:nnoremap <Leader>ev :e ~/.vimrc<CR>

