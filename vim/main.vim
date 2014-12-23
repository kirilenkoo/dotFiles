" Cross-platform Vim Configuration goes in this file
"
" Contents
" Main configuration
" Visual Configuration
" Shortcut Key Configuration
" Plugin Configuration
" Private Configuration

" ----------- Main Configuration ----------------------------------
set nocompatible                         "don't need to keep compatibility with Vi
filetype plugin indent on                "enable detection, plugins and indenting in one step
syntax on                                "Turn on syntax highlighting
set ruler                                "Turn on the ruler
set number                               "Show line numbers
set cursorline                           "underline the current line in the file
set cursorcolumn                         "highlight the current column. Visible in GUI mode only.
"set colorcolumn=80

set background=dark                      "make vim use colors that look good on a dark background

set showcmd                              "show incomplete cmds down the bottom
set showmode                             "show current mode down the bottom
set foldenable                           "enable folding
set showmatch                            "set show matching parenthesis
set noexrc                               "don't use the local config
"set virtualedit=all                      "allow the cursor to go in to "invalid" places

set incsearch                            "find the next match as we type the search
set hlsearch                             "hilight searches by default
set ignorecase                           "ignore case when searching

set shiftwidth=2                         "number of spaces to use in each autoindent step
set tabstop=2                            "two tab spaces
set softtabstop=2                        "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                            "spaces instead of tabs for better cross-editor compatibility
set smarttab                             "use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set shiftround                           "when at 3 spaces, and I hit > ... go to 4, not 5
"set nowrap                               "no wrapping

set backspace=indent,eol,start           "allow backspacing over everything in insert mode
set cindent                              "recommended seting for automatic C-style indentation
set autoindent                           "automatic indentation in non-C files
set copyindent                           "copy the previous indentation on autoindenting

set noerrorbells                         "don't make noise
set wildmenu                             "make tab completion act more like bash
set wildmode=list:longest                "tab complete to longest common string, like bash

"set mouse-=a                             "disable mouse automatically entering visual mode
set mouse=a                              "enable mouse automatically entering visual mode
set hidden                               "allow hiding buffers with unsaved changes
set cmdheight=2                          "make the command line a little taller to hide 'press enter to viem more' text

set clipboard=unnamed                    "Use system clipboard by default

set splitright                           "splits open on the right.
set splitbelow       

" Set up the backup directories to a central place.
set backupdir=$HOME/.vim/backup//        
set directory=$HOME/.vim/backup//

" ----------- Visual Configuration ----------------------------------
colorscheme rainbow_neon
set t_Co=256

" set up gui font
if has("gui_running")
  set guifont=Source\ Code\ Pro\ for\ Powerline:h15 
endif

" set up status bar
set laststatus=2
set statusline=%f%m%r%h%w[%l][%{&ff}]%y[%p%%][%04l,%04v][%n]
"              | | | | |  |   |      |  |     |    |     |
"              | | | | |  |   |      |  |     |    |     + current
"              | | | | |  |   |      |  |     |    |       buffer
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer

" Use a bar-shaped cursor for insert mode, even through tmux.
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" ----------- Shortcut Key Configuration ----------------------------------
let mapleader = ","                      "remap leader to ',' which is much easier than '\'

"Switch to previous file with ',spacebar'
nmap <leader><SPACE> <C-^> 

" Open Taglist with [,s]
map <Leader>s :TlistToggle<CR>

" Use leader x to remove the current line but not erase buffer
map <Leader>x "_dd

" Use leader l to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Exit insert mode with jk                                                              
imap jk <Esc>

" reload configuration file
map <Leader>r :so $MYVIMRC<CR>  

" Exit insert mode and save with jj
imap jj <Esc>:w<CR>

"CTags
map <Leader>ct :!ctags -R --exclude=.git --exclude=log --exclude=.svn --verbose=yes * <CR>

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" Supports pasting in from the clipboard
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()


" Navigate tabs
map <F3> :tabp<CR>                       
map <F4> :tabn<CR>

" Turn text search highlight on/off with F5 key
map <F5> :set hls!<bar>set hls?<CR> 

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" insert blank line above in Normal mode
nnoremap <Leader>O  mzO<esc>`z

" insert blank line below in Normal mode
nnoremap <Leader>o mzo<esc>`z

" Sort CSS properties alphabetically
nnoremap <leader>css :g#\({\n\)\@<=#.,/}/sort<cr>

" -- Number toggling
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <F6> :call NumberToggle()<cr>

" Spell check toggle
map <leader>sp :setlocal spell! spelllang=en_us<CR>


" ----------- Plugin Configuration ----------------------------------

