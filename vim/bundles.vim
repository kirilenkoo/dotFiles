" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif


" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', { 'build': {
      \   'windows': 'make -f make_mingw32.mak',
      \   'cygwin': 'make -f make_cygwin.mak',
      \   'mac': 'make -f make_mac.mak',
      \   'unix': 'make -f make_unix.mak',
      \ } }

" My bundles here
NeoBundle 'bling/vim-airline'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tangledhelix/vim-octopress'
NeoBundle 'amix/vim-zenroom2'
NeoBundle 'junegunn/goyo.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'vim-scripts/netrw.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'jstemmer/gotags'
NeoBundle 'zenorocha/dracula-theme', {'rtp': 'vim/'}

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
