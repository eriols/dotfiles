set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  let c.log_to_buf = 0
  let c.auto_install = 1
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    let cmd = '/usr/bin/git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
    let cmd .= shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
    call system(cmd)
  endif
  call vam#ActivateAddons([], {'auto_install' : 1})
  " git
  VAMActivate github:tpope/vim-fugitive
  VAMActivate github:gregsexton/gitv
  VAMActivate github:int3/vim-extradite
endfun

call SetupVAM()
VAMActivate matchit.zip vim-addon-commenting

set history=1000
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set nowrap
set textwidth=79
set formatoptions=qrn1tco

syntax on
set background=dark
colorscheme pablo
