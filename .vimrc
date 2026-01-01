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
Plug 'itchyny/lightline.vim'
" utility
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" does not solve the symlink issue in tree view but hey, it's a later version
Plug 'eiginn/netrw'
" generic programming support
" languages
Plug 'justinmk/vim-syntax-extra'
Plug 'hdima/python-syntax'
Plug 'luochen1990/rainbow'
Plug 'Valloric/YouCompleteMe'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" All of your Plugins must be added before the following line
call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
let g:linuxsty_patterns = [ "/esdk/", "/git/" ]
"
" show linenumbers
" set relativenumber
set nu
set ruler

" fugitive stopped updating the tags
set tags+=.git/tags

" always show the status line
set laststatus=2
" elite mode, no arrows
let g:elite_mode=1

set guifont=Terminus

set showcmd
" set guifont=Inconsolata\ for\ Powerline:h15
" lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'gitstatus', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'gitstatus': 'FugitiveHead'
      \ },
      \ }

let g:rainbow_active = 1 " :RainbowToggle

set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set backspace=indent,eol,start
let g:monochrome_italic_comments = 1
colorscheme monochrome

if exists("$TMUX")
    set t_Co=256
    set notermguicolors
else
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

let g:markdown_fenced_languages = ['c', 'python', 'sql', 'sh', 'perl', 'ruby', 'awk']

"buffer stuff
:nnoremap <Leader>b :ls<CR>
:nnoremap <Leader>en :e ~/notes.txt<CR>
:nnoremap <Leader>ev :e ~/.vimrc<CR>

"turn off search highlight with enter
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <leader>pdb Oimport pdb; pdb.set_trace()<Esc>
" visually select previously yanked or changed
nnoremap <leader>vps `[v`]
"visuals
vnoremap // y/<C-R>"<CR>

"highlight line we're on
:hi CursorLine term=NONE ctermbg=lightgray ctermfg=black guibg=lightgray guifg=black
nnoremap <leader>c :set cursorline! cursorcolumn!<CR>

" save session when exiting
au VimLeavePre * if v:this_session != '' | exec "mks! " . v:this_session | endif
"
" markdown preview
nmap <leader>s <Plug>MarkdownPreview
nmap <leader>t <Plug>MarkdownPreviewStop
nmap <leader>to <Plug>MarkdownPreviewToggle
" Add format option 'w' to add trailing white space, indicating that paragraph
" continues on next line. This is to be used with mutt's 'text_flowed' option.
augroup mail_trailing_whitespace " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w
augroup END " }

fun! ShowFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun
:map <leader>f :call ShowFuncName()<CR>

" setup
if has("cscope")
    " set cscopetag
    " check scope for def before checking ctags
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
endif

" Use GNU Global instead of ctags
set cscopeprg=gtags-cscope
set cscopetag
" " jump to a function declaration
" nmap <silent> <C-\> :cs find s <C-R>=expand("<cword>")<CR><CR>
" " show a list of where function is called
" nmap <silent> <C-_> :cs find c <C-R>=expand("<cword>")<CR><CR>
