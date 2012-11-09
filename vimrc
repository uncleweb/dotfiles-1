""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim configuration.
"
" Copyright (C) 2012 Google Inc.
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"    http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
"
" Author: Yesudeep Mangalapilly (yesudeep@google.com)
"
" References:
" 1. http://nvie.com/posts/how-i-boosted-my-vim/
" 2. http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
" 3. http://smalltalk.gnu.org/blog/bonzinip/emacs-ifying-vims-autoindent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Packages:
" gitv - Git version control system integration.
" vundle - package management.
"

set nocompatible         " Don't be compatible with vi.
filetype off             " Required by Vundle.

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle.
Bundle 'gmarik/vundle'

" Git integration.
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'

Bundle 'Lokaltog/vim-powerline'

" Required by Vundle.
filetype plugin indent on


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" ----------------------------------------------------------------------
" Editing.
" ----------------------------------------------------------------------
set history=1000          " Remember these many lines.
set undolevels=1000       " Allow more undo levels.
set encoding=utf8        " UTF-8 as standard encoding.
set ffs=unix,dos,mac     " Use UNIX as standard file type.

" Fast save.
nmap <leader>w :w!<CR>

" Quit window.
nmap <leader>q :q<CR>
" Paste from clipboard.
nmap <leader>p "+p

" Show the gitv log.
nmap <leader>g :Gitv<CR>

" Edit vimrc.
nmap <leader>v :tabedit $MYVIMRC<CR>

" Strip off two keystrokes from almost every Vim command by aliasing this.
nnoremap ; :

" Forgot to use sudo to edit a file? Just use this.
cmap w!! w !sudo tee % >/dev/null


" ----------------------------------------------------------------------
" Clipboard.
" ----------------------------------------------------------------------
set paste                       " Don't automatically indent pastes.
set pastetoggle=<F2>            " Allow toggling paste.
set clipboard+=unnamedplus

" ----------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------
set hidden                      " Hide buffers instead of closing them.

" ----------------------------------------------------------------------
" Autocompletion for VIM commands.
" ----------------------------------------------------------------------
set wildmode=list:longest
" set wildmode=longest:full,full
set wildmenu

" Ignore these files from autocompletion.
set wildignore+=*.o,*~,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" ----------------------------------------------------------------------
" Searching, matching, and navigation.
" ----------------------------------------------------------------------
set ignorecase        " Ignore case when searching
set smartcase         " When searching try to be smart about cases
set hlsearch          " Highlight search results
set incsearch         " Incremental search.
set magic             " Turn on magic for regular expressions.

set showmatch         " Highlight matching parens at point.
set mat=2             " Highlight parens for duration.

set ruler             " Always show current position.
set number            " Always show line numbers.
set cursorline        " Indicate the current line.


" ----------------------------------------------------------------------
" No annoying sound on errors
" ----------------------------------------------------------------------
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" ----------------------------------------------------------------------
" Performance.
" ----------------------------------------------------------------------
set lazyredraw        " Don't redraw while executing macros

" ----------------------------------------------------------------------
" File backups (please use git or mercurial instead).
" We don't want backup files because they also interfere with
" file monitoring programs.
" ----------------------------------------------------------------------
set autoread                 " Automatically reload files that change on disk.
set nobackup                 " Do not create backup files.
set nowb                     " No writeback.
set noswapfile               " No swapfiles.

" ----------------------------------------------------------------------
" Appearance.
" ----------------------------------------------------------------------
syntax enable

set laststatus=2             " Always show the status line.
set cmdheight=2              " Height of the command bar.
set title

if has("gui_running")
  colorscheme desert
  " set guioptions-=m          " Remove the menu bar.
  " set guioptions-=T          " Remove the toolbar.
  set guioptions+=a            " Interact with the system clipboard.
else
  " colorscheme desert
  colorscheme torte
endif

" ----------------------------------------------------------------------
" Indentation and whitespace.
" ----------------------------------------------------------------------
set expandtab                   " Use spaces for indentation.
set smarttab                    " Use tabs intelligently.
set shiftwidth=2                " Use 2 spaces per shift.
set tabstop=2                   " A tab stops after 2 spaces.
set softtabstop=2               " A soft tab stops after 2 spaces.
set shiftround                  " Indenting with < and > is times shiftwidth.

set linebreak
set tw=80                       " Line break on 80 characters.
set colorcolumn=80              " Show a right margin.

set autoindent                  " Automatically indent.
set smartindent                 " Smart indent.
set wrap                        " Wrap lines.

set backspace=eol,start,indent  " Tell backspace to behave.
set whichwrap+=<,>,h,l

" Because Emacs just pwns Vim in this department.
" See: http://smalltalk.gnu.org/blog/bonzinip/emacs-ifying-vims-autoindent
set cinkeys=0{,0},0),0#,!<Tab>,;,:,o,O,e
set indentkeys=!<Tab>,o,O
map <Tab> i<Tab><Esc>^
filetype indent on
" Kernel style.
" set cinoptions=:0,(0,u0,W1s
" GNU style
set cinoptions={1s,>2s,e-1s,^-1s,n-1s,:1s,p5,i4,(0,u0,W1s
" set shiftwidth=2
if has("autocmd")
  autocmd FileType * setlocal indentkeys+=!<Tab>
endif

" Highlight whitespace.
" set list
" set listchars=tab:>.,trail:.,extends:#,nbsp:.


" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Deletes trailing whitespace.
func! DeleteTrailingWhitespace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

if has("autocmd")
  autocmd BufWrite *.py :call DeleteTrailingWhitespace()
  autocmd BufWrite *.coffee :call DeleteTrailingWhitespace()
  autocmd BufWrite *.go :call DeleteTrailingWhitespace()
  autocmd BufWrite .vimrc :call DeleteTrailingWhitespace()
endif


" Automatically reload vimrc.
" Source the vimrc file after saving it
"if has("autocmd")
"  autocmd bufwritepost .vimrc source $MYVIMRC
"  autocmd bufwritepost vimrc source $MYVIMRC
"endif

