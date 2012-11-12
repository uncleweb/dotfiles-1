"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible         " Don't be compatible with vi.
filetype off             " Required by Vundle.


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle.
Bundle 'gmarik/vundle'

" Version control integration.
Bundle 'tpope/vim-fugitive'
Bundle 'gregsexton/gitv'

" Appearance, status, and navigation.
Bundle 'Lokaltog/vim-powerline'
Bundle 'wincent/Command-T'
Bundle 'scrooloose/nerdtree'

" Power editing.
Bundle 'Shougo/neocomplcache'
Bundle 'sjl/gundo.vim'
Bundle 'Raimondi/delimitMate'
" Bundle 'vim-scripts/paredit.vim'
Bundle "kana/vim-arpeggio"

" The main msanders snipmate repository has been abandoned. garbas is now
" maintaining the snipmate plugin. The following are the extensions required
" for snipmate to work.
" Bundle 'garbas/vim-snipmate'
" Bundle 'MarcWeber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'

" This snippet expansion extension is better.
" Bundle 'SirVer/ultisnips'

" Programming languages.
Bundle "pangloss/vim-javascript"
" Requires nodejs.
Bundle 'maksimr/vim-jsbeautify'
" requires `sudo pip install jedi`.
" breaks autocompletion and completes without me pressing tab.
" Bundle "davidhalter/jedi-vim"

set rtp+=$GOROOT/misc/vim

" Required by Vundle.
filetype plugin indent on


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" ----------------------------------------------------------------------
" Paredit mode.
" ----------------------------------------------------------------------
" au BufNewFile,BufRead *.go call PareditInitBuffer()
" let delimitMate_autoclose = 0       " Disables delimMate.

" ----------------------------------------------------------------------
" Editing.
" ----------------------------------------------------------------------
set encoding=utf8        " UTF-8 as standard encoding.
set ffs=unix,dos,mac     " Use UNIX as standard file type.
set history=1000          " Remember these many lines.
set mouse=a               " On OS X press Option and click.
set undolevels=1000       " Allow more undo levels.

" ----------------------------------------------------------------------
" Keyboard bindings and arpeggios (keychords).
" ----------------------------------------------------------------------

"Arpeggio inoremap ;'  :CommandT
"call arpeggio#map('i', '', 0, ';\'', '<Esc>')


" Fast save.
nmap <leader>w :w!<CR>

" Quit window.
nmap <leader>q :q<CR>

" Paste from clipboard.
nmap <leader>p "+p

" Show the gitv log.
nmap <leader>G :Gitv<CR>

" Undo tree toggle.
nmap <leader>u :GundoToggle<CR>

" Edit and reload vim configuration.
nmap <leader>ve :tabedit $MYVIMRC<CR>
nmap <leader>vr :source $MYVIMRC<CR>

" Package management.
nmap <leader>vi :BundleInstall<CR>
nmap <leader>vc :BundleClean!<CR>
nmap <leader>vv :BundleClean!<CR>q:BundleInstall<CR>q

" Strip off 2 keystrokes from almost every Vim command by aliasing this.
nnoremap ; :

" Forgot to use sudo to edit a file? Just use this.
cmap w!! w !sudo tee % >/dev/null

" Directory navigation.
nmap <leader>e :NERDTreeToggle<CR>
" autocmd vimenter * NERDTree

" Tab navigation.
map <leader>n <ESC>:tabprevious<CR>
map <leader>m <ESC>:tabnext<CR>

" Window navigation.
map <leader>j <c-w>j
map <leader>h <c-w>h
map <leader>k <c-w>k
map <leader>l <c-w>l

" Sort lines.
vnoremap <leader>s :sort<CR>

" Indentation.
vnoremap < <gv  " Better outdent.
vnoremap > >gv  " Better indent.

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" ----------------------------------------------------------------------
" Clipboard.
" ----------------------------------------------------------------------
" set paste                       " Don't automatically indent pastes.
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

set ofu=syntaxcomplete#Complete

" let g:acp_completeoptPreview=1
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

" Programming language specific autocompletion.
if has('autocmd')
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType python setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
  autocmd FileType go setlocal omnifunc=gocomplete#Complete

  " Javascript beautification.
  autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  " for html
  autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  " for css or scss
  autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
endif

" ----------------------------------------------------------------------
" Autocompletion popup for text.
" ----------------------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Language specific patterns.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

" Go lang completion. https://github.com/Shougo/neocomplcache/issues/134
let g:neocomplcache_omni_patterns['go'] = '\%(\.\|->\)\w*'

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


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
set modeline                 " Allow vim modelines in files.
set modelines=5              " Lines within which modelines can be found.

" ----------------------------------------------------------------------
" Appearance.
" ----------------------------------------------------------------------
syntax enable

set confirm                  " Y-N-C prompt if closing with unsaved changes.
set showcmd                  " Show incomplete normal mode commands as I type.
set laststatus=2             " Always show the status line.
set cmdheight=2              " Height of the command bar.
set title

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
set nowrap                      " Don't wrap lines.

set backspace=2                 " Make backspace behave.
" set backspace=eol,start,indent  " Tell backspace to behave.
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

" Show trailing whitespace.
if has("autocmd")
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  au InsertLeave * match ExtraWhitespace /\s\+$/
endif

" Remove trailing whitespace automatically for these files.
"if has("autocmd")
"  autocmd FileType c,cpp,java,php,python,javascript,go autocmd BufWritePre <buffer> :%s/\s\+$//e
"endif

" Deletes trailing whitespace.
func! DeleteTrailingWhitespace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

if has("autocmd")
  autocmd BufWritePre *.py :call DeleteTrailingWhitespace()
  autocmd BufWritePre *.js :call DeleteTrailingWhitespace()
  autocmd BufWritePre *.coffee :call DeleteTrailingWhitespace()
  autocmd BufWritePre *.go :call DeleteTrailingWhitespace()
  autocmd BufWritePre .vimrc :call DeleteTrailingWhitespace()
  autocmd BufWritePre vimrc :call DeleteTrailingWhitespace()
endif

" Highlight lines that are longer than the right margin.
function! HighlightTooLongLines()
  highlight def link RightMargin Error
  if &textwidth != 0
    exec ('match RightMargin /\%>' . &textwidth . 'v.\+/')
  endif
endfunction

augroup filetypedetect
  au WinEnter,BufNewFile,BufRead * call HighlightTooLongLines()
augroup END

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



" -------------------------------------------------------------------
" Programming language specific.
" -------------------------------------------------------------------
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" -------------------------------------------------------------------
" Color schemes. Apply this last.
" -------------------------------------------------------------------
if has("gui_running")
  colorscheme desert
  " set guioptions-=m          " Remove the menu bar.
  " set guioptions-=T          " Remove the toolbar.
  set guioptions+=a            " Interact with the system clipboard.
  set lines=50 columns=120
  if has("gui_macvim")
    set guifont=Monaco:h13
  endif
else
  " colorscheme desert
  colorscheme torte
endif

" Automatically reload vimrc.
" Source the vimrc file after saving it
"if has("autocmd")
  "autocmd bufwritepost .vimrc source %
  " autocmd bufwritepost *vimrc source %
"endif
