set nocompatible              " vim, not vi. required
set autoread
set autowrite " autosave before eg :next and :make
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hlsearch
filetype off                  " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
Plug 'flazz/vim-colorschemes'
Plug 'fxn/vim-monochrome'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" utility
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" does not solve the symlink issue in tree view but hey, it's a later version
Plug 'eiginn/netrw'
" generic programming support
" languages
Plug 'justinmk/vim-syntax-extra'
Plug 'hdima/python-syntax'
Plug 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call plug#end()
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
let g:linuxsty_patterns = [ "/esdk/", "/git/" ]
"
" show linenumbers
set number
set ruler

" fugitive stopped updating the tags
set tags+=.git/tags

" always show the status line
set laststatus=2
" elite mode, no arrows
let g:elite_mode=1

set guifont=Terminus
" set guifont=Inconsolata\ for\ Powerline:h15
" airline
let g:airline_powerline_fonts = 1
let g:airline_section_x = ''
let g:airline_theme='monochrome'
let g:airline#extensions#tabline#enabled = 1

set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set backspace=indent,eol,start
colorscheme monochrome

" macvim
if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Terminus
    endif
endif

if (has("termguicolors"))
    set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let mapleader = ','

" old own stuff
set history=1000
" global settings for file not overriden in ftplugin
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap
set formatoptions=qrn1tco
set textwidth =0 wrapmargin=0
set hidden
set shortmess+=A
" strip trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" netrw things
" https://github.com/tpope/vim-vinegar/issues/13
autocmd FileType netrw setl bufhidden=delete
let g:netrw_list_hide='^.*\.swp$,^.*\.pyc$'

let g:markdown_fenced_languages = ['c', 'python', 'scala', 'sql', 'sh', 'perl', 'ruby', 'awk']

"buffer stuff
:nnoremap <Leader>b :ls<CR>
:nnoremap <Leader>en :e ~/notes.md<CR>
:nnoremap <Leader>ev :e ~/.vimrc<CR>

"turn off search highlight with enter
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <leader>pdb Oimport pdb; pdb.set_trace()<Esc>
"visuals
vnoremap // y/<C-R>"<CR>

"highlight line we're on
:hi CursorLine term=NONE ctermbg=lightgray ctermfg=black guibg=lightgray guifg=black
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" save session when exiting
au VimLeavePre * if v:this_session != '' | exec "mks! " . v:this_session | endif

