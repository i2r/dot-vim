" Init (Vundle is used because vim-plug requires Ruby)
" ****************************************************
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'altercation/vim-colors-solarized'
let g:solarized_visibility = 'low'

Plugin 'i2r/EnhCommentify.vim'
" function! EnhCommentifyCallback(ft)
    " if a:ft == 'stylus'
        " let b:ECcommentOpen = '/*'
        " let b:ECcommentClose = '*/'
    " endif
" endfunction
" let g:EnhCommentifyCallbackExists = 'yes'
let g:EnhCommentifyMultiPartBlocks = 'yes' 
let g:EnhCommentifyRespectIndent = 'yes'
let g:EnhCommentifyPretty = 'yes'
let g:EnhCommentifyUseSyntax = 'yes'

Plugin 'i2r/yate-syntax'
au BufRead,BufNewFile *.yate setf yate
"au BufRead *.yate set filetype=javascript | set filetype=html

Plugin 'pangloss/vim-javascript'
let g:javascript_enable_domhtmlcss=1

Plugin 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
set backspace=indent,eol,start

Plugin 'romainl/flattened'

Plugin 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['css']
let g:jsx_ext_required = 0

" Actual version don't work with vim 7.3
" Plugin 'SirVer/ultisnips'
" so there is 3.0
Plugin 'i2r/ultisnips'
Plugin 'i2r/vim-snippets-css'

Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-commentary'

Plugin 'tpope/vim-fugitive'
function! StatuslineFugitive()
    if exists('*fugitive#head')
        let _ = fugitive#head(7)
        return strlen(_) ? 'Դ '._ : ''
    endif
    return ''
endfunction

call vundle#end()            " required
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
" *****************************************

" Use english if available
silent! lan en_US.utf8

" Show line numbers
set number

" Statusline
" ************************************************************************
set statusline=\                " Begin Padding
set statusline+=%F\ %m%r%h%w    " Path to the File
set statusline+=\ 
set statusline+=%=              " Push to Right
set statusline+=%{StatuslineFugitive()}
set statusline+=\ \ \ 
set statusline+=%{&ff}          " Format
set statusline+=\ \ \ 
set statusline+=%Y              " File Type
set statusline+=\ \ \           " Separator

" set statusline+=ASCII…\%03.3b
" set statusline+=\ 

set statusline+=%-9(&#\%b;%)
set statusline+=\ 

set statusline+=%04l:%04v       " Cursor Position
set statusline+=\ 
set statusline+=%3p%%           " Persent Position
set statusline+=\ \ \ 
set statusline+=Σ\ %L           " Buffer Length
set statusline+=\ \ \ 
set statusline+=β\              " Buffer Title
set statusline+=%n              " Buffer Number
set statusline+=\               " End Padding
set laststatus=2

" Buffers
" ******************************************
" AutoWrite on buffer change (see autowrite)
" set autowrite
" Don't close buffer on buffer change
set hidden

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
" **********************************************
set notimeout
set ttimeout
set ttimeoutlen=10


" Scroll & Select with mouse
" **************************
set mouse=a

" Improved paste in visual mode
" *****************************
vnoremap p "_dp
vnoremap P "_dP

" Turn off netrw window split
" ***************************
let g:netrw_browse_split = 0

" Backups
" *****************************************
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

" Persistent file history. WARNING: VIM 7.3+
" ********************************************
set undodir=~/.vim/tmp/undo//
set undofile

" Restore last cursor position
set viewdir=~/.vim/tmp/view//
au BufWinLeave * mkview
au BufReadPost * loadview " do it on BufReadPost to make vim file +lineNumber work


" Highlight VCS conflict markers
" **********************************************
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Tabs
" *********************************************************
"set sta " a <Tab> in an indent inserts 'shiftwidth' spaces

function! Tabstyle_tabs()
	" Using 4 column tabs
    set softtabstop=4
    set shiftwidth=4
    set tabstop=4
    set noexpandtab
endfunction

function! Tabstyle_spaces()
	" Use 2 spaces
	set softtabstop=2
	set shiftwidth=2
	set tabstop=2
	set expandtab
endfunction

function! Tabstyle_spaces_4()
	" Use 4 spaces
    set softtabstop=4
    set shiftwidth=4
    set tabstop=4
    set expandtab
endfunction

" call Tabstyle_tabs()
" call Tabstyle_spaces()
call Tabstyle_spaces_4()

" Colors
" **********************************************************************
set t_Co=256 " 256 colors
syntax on " syntax highlighting
" set background=dark 
set background=light
silent! colorscheme solarized
" colorscheme flattened_light

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au BufLeave * set nocursorline
    au BufEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END
 

" Indenting
" *******************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)
set cindent
au BufRead,BufNewFile *.css setlocal nocindent " off cindent in CSS files
au BufLeave *.css set cindent " on cindent in other files

" LESS
au BufRead,BufNewFile *.less setlocal nocindent " off cindent in LESS files
au BufRead,BufNewFile *.less call Tabstyle_spaces() 
au BufLeave *.less set cindent " on cindent in other files
au BufLeave *.less call Tabstyle_spaces_4() 

" Stylus
au BufRead,BufNewFile *.styl setlocal nocindent " off cindent in STYLUS files
au BufRead,BufNewFile *.styl call Tabstyle_spaces() 
au BufLeave *.styl set cindent
au BufLeave *.styl call Tabstyle_spaces_4() 

" Jade
au BufRead,BufNewFile *.jade setlocal nocindent
au BufRead,BufNewFile *.jade call Tabstyle_spaces() 
au BufLeave *.jade set cindent
au BufLeave *.jade call Tabstyle_spaces_4() 

filetype indent on

" Searching
" ******************************
set hlsearch  " highlight search
set incsearch  " Incremental search, search as you type
set ignorecase " Ignore case when searching 
set smartcase " Ignore case when searching lowercase 
noremap / :noh<RETURN>/
noremap ? :noh<RETURN>?

" Invisible characters
" ******************************************************
set listchars=trail:.,tab:▸\ ,eol:¬,extends:❯,precedes:❮
set nolist
noremap <Leader>i :set list!<CR> " Toggle invisible chars

" Russian key mappings
" ********************
noremap —ë `
noremap –π q
noremap —Ü w
noremap —É e
noremap –∫ r
noremap –µ t
noremap –Ω y
noremap –≥ u
noremap —à i
noremap —â o
noremap –∑ p
noremap —Ö [
noremap —ä ]
noremap —Ñ a
noremap —ã s
noremap –≤ d
noremap –∞ f
noremap –ø g
noremap —Ä h
noremap –æ j
noremap –ª k
noremap –¥ l
noremap –∂ ;
noremap —ç '
noremap —è z
noremap —á x
noremap —Å c
noremap –º v
noremap –∏ b
noremap —Ç n
noremap —å m
noremap –± ,
noremap —é .
noremap –Å ~
noremap –ô Q
noremap –¶ W
noremap –£ E
noremap –ö R
noremap –ï T
noremap –ù Y
noremap –ì U
noremap –® I
noremap –© O
noremap –ó P
noremap –• {
noremap –™ }
noremap –§ A
noremap –´ S
noremap –í D
noremap –ê F
noremap –ü G
noremap –† H
noremap –û J
noremap –õ K
noremap –î L
noremap –ñ :
noremap –≠ "
noremap –Ø Z
noremap –ß X
noremap –° C
noremap –ú V
noremap –ò B
noremap –¢ N
noremap –¨ M
noremap –ë <
noremap –Æ >
noremap ё `
noremap й q
noremap ц w
noremap у e
noremap к r
noremap е t
noremap н y
noremap г u
noremap ш i
noremap щ o
noremap з p
noremap х [
noremap ъ ]
noremap ф a
noremap ы s
noremap в d
noremap а f
noremap п g
noremap р h
noremap о j
noremap л k
noremap д l
noremap ж ;
noremap э '
noremap я z
noremap ч x
noremap с c
noremap м v
noremap и b
noremap т n
noremap ь m
noremap б ,
noremap ю .
noremap Ё ~
noremap Й Q
noremap Ц W
noremap У E
noremap К R
noremap Е T
noremap Н Y
noremap Г U
noremap Ш I
noremap Щ O
noremap З P
noremap Х {
noremap Ъ }
noremap Ф A
noremap Ы S
noremap В D
noremap А F
noremap П G
noremap Р H
noremap О J
noremap Л K
noremap Д L
noremap Ж :
noremap Э "
noremap Я Z
noremap Ч X
noremap С C
noremap М V
noremap И B
noremap Т N
noremap Ь M
noremap Б <
noremap Ю >

" Terminal helpers 
" ****************

" Paste Mode Switcher
inoremap <leader>p <esc>:setlocal paste!<cr> :setlocal paste?<cr>i
nnoremap <leader>p :setlocal paste!<cr> :setlocal paste?<cr><left>

" Numbers Switcher
inoremap <leader>n <esc>:setlocal number!<cr> :set number?<cr>i
nnoremap <leader>n :setlocal number!<cr> :set number?<cr><left>

" Go Next/Prev Buffer
nnoremap gb :bn<cr>
nnoremap gB :bp<cr>

" Paste Mode Switcher
command! -bang -nargs=? -complete=file E e<bang> <args>
command! -bang -nargs=? -complete=file W w<bang> <args>
command! -bang -nargs=? -complete=file Wq wq<bang> <args>
command! -bang -nargs=? -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>


" Learn VIM The Hard Way tips ===================================
noremap <leader>ev :vs $MYVIMRC<cr>
noremap <leader>sv :source $MYVIMRC<cr>
noremap <leader>sc :source $VIMRUNTIME/syntax/hitest.vim<cr>

nnoremap - ddp
nnoremap _ dd<up>P

nnoremap ; :
inoremap jk <esc>
inoremap kj <esc>
" inoremap <esc> <nop>
