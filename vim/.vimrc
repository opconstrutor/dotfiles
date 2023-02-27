""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" 	Thiago Castro - @0srcode
" Sections:
" 	-> General
" 	-> VIM user interafce
" 	-> Colors and Fonts
" 	-> Files and backups
" 	-> Text, tab and indent related
" 	-> Visual mode related
" 	-> Moving around, tabs and buffere
" 	-> Status line
" 	-> Editing mappings
" 	-> vimgrep searching and cope displaying
" 	-> Spell checking
" 	-> Misc
" 	-> Helper functions
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lines of history
set history=300

" Filetype plugins
filetype plugin on
filetype indent on

" Auto read when a fille is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Map leader to do extra key combinations, <leader>
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :w sudo ssves the file (handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 7 Lines to the cursor
set so=7

" Language and avoid garbled characters
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Line Number
set number
set relativenumber

" Wild Menu
set wildmenu

" Current position
set ruler

" Height of command bar
set cmdheight=1

" A buffer hidden when it is abandoned
set hid

" Backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" Smart case
set smartcase

" Highlight search
set hlsearch

" Modern Search
set incsearch

" Don't redraw while executing macros
set lazyredraw

" Regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" Second to blink matching
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlighting
syntax on

" Regular expressions engine
set regexpengine=0

colo quiet
set background=dark

" utf8 as standard encoding
set encoding=utf8

" Unix as the standard file type
set ffs=unix,dos,mac

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spaces instead of tabs
set expandtab

" Smart tabs
set smarttab

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 chars
set lbr
set tw=500

set ai	 " Auto indent
set si	 " Smart indent
set wrap " Wrap lines

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<CR-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<CR-R>=@/<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :taclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" toggle berween this and the last accessed tab
let g:lastab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lastab = tabpagenr()

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Last edit position
au BufReadPost * if line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show status line
set laststatus=2

" Format
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank char
map 0 ^

" Move lines
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-j> :m'<-2<cr>`>my`>mzgv`yo`z

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap { <esc>`>a}<esc>`<i{<esc>
vnoremap " <esc>`>a"<esc>`<i"<esc>
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap ` <esc>`>a`<esc>`<i`<esc>

" Map auto complete of (, ", ', [
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap ' ''<esc>i
inoremap " ""<esc>i

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Compilation and Run
map <F5> :call CompileRun()<CR>
imap <F5> <Esc>:call CompileRun()<CR>
vmap <F5> <Esc>:call CompileRun()<CR>

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec "!gcc -o % %<"
    exec "!time ./%<"
elseif &filetype == 'asm'
    exec "!make CC=ld %<.o %<; rm %<.o"
    exec "!time ./%<"
elseif &filetype == 'sh'
    exec "!time bash %"
elseif &filetype == 'python'
    exec "!time python3 %"
elseif &filetype == 'html'
    exec "!firefox % &"
endif
endfunc

