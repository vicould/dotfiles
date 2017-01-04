set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" fugitive
Plugin 'tpope/vim-fugitive.git'

" controlP
Plugin 'ctrlpvim/ctrlp.vim.git'

" nerdtree/nerdcommenter
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter.git'

" languages stuff
Plugin 'fatih/vim-go.git'
Plugin 'klen/python-mode.git'

" syntastic
Plugin 'scrooloose/syntastic.git'

" tags
Plugin 'xolox/vim-misc.git'
Plugin 'xolox/vim-easytags.git'

" tagbar
Plugin 'majutsushi/tagbar.git'

" completion
Plugin 'Valloric/YouCompleteMe'

" ultisnips
Plugin 'SirVer/ultisnips'

" supertab
Plugin 'ervandew/supertab'

" Optional:
Plugin 'honza/vim-snippets'

" delimitMate
Plugin 'Raimondi/delimitMate.git'

" surrounding
Plugin 'tpope/vim-surround.git'

" todos
Plugin 'vim-scripts/TaskList.vim'

" faster folding
Plugin 'Konfekt/FastFold'

" split/join
Plugin 'AndrewRadev/splitjoin.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"----------------------------------------------------------------
" Basic stuff
"----------------------------------------------------------------
set nocompatible
set modelines=0		" CVE-2007-2438

" error bells
set noerrorbells
set visualbell
set t_vb=		" visual bell without changing the color

" completion of file names
set wildmenu
set wildmode=list:longest " longest:full
set wildignore=*.o,*.a,*.so,*.class,*.pyc,*.tar,*.zip,*.gz,*.bz2

set showmode
set ruler

" completion
set completeopt=menuone,preview

" better search
set incsearch
set hlsearch

" keep the cursor on the same column when changing line
set nostartofline

" allows to handle buffers more efficiently
set hidden

set title

" backspace can go back on the previous line
set backspace=2

"folds
set foldmethod=indent
set foldenable!
set foldlevel=99

" use a central location for the swap files
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" colors
if &t_Co >1
	syntax enable
	colorscheme slate-mod
endif

" statusline
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

" Reopen the file where left
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

filetype plugin indent on

" Saves the files when calling :make
set autowrite

"----------------------------------------------------------------
" Mappings
"----------------------------------------------------------------

" sets the leader key, i.e. the modifier
let mapleader = ","

" make
map <leader>m :make<CR>

" successive indentation when selecting a text block
vnoremap < <gv 
vnoremap > >gv

" tabs and buffers
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
nnoremap <leader>tl :execute 'silent! tabmove ' (tabpagenr() - 2)<CR>
nnoremap <leader>tr :execute 'silent! tabmove ' tabpagenr()<CR>

" indentation shortcut
noremap <leader>= gg=G

" vimrc modification
map <leader>v :sp ~/.vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

map <F1> :set nu!<CR>:set nu?<CR>
map <F2> :nohl<CR>

" nerdtree
" noremap <leader>n :NERDTreeToggle<CR>

" tagbar
nmap <leader>tt :TagbarToggle<CR>

" fugitive
map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>gc :Gcommit<CR>
map <leader>gc :Gpush<CR>
map <leader>ge :Gedit<CR>
map <leader>gb :Gblame<CR>

" Syntastic
noremap <leader>sc :SyntasticCheck<CR>
noremap <leader>st :SyntasticToggleMode<CR>

" vim-go
autocmd FileType go nmap <leader>b  <Plug>(go-build)

"----------------------------------------------------------------
" Plugins
"----------------------------------------------------------------

" latex
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'Preview'

" Use the ctags database when editing a file
set tags=./tags,~/.vimtags
let g:easytags_by_filetype = "~/.vim_language_tags"

" delimitMate
let delimitMate_excluded_ft = "tex"
" allows docstrings for python (triple quotes nesting)
autocmd FileType python let b:delimitMate_nesting_quotes=['"']

" python.vim syntax highlighter
let python_highlight_all=1
let python_print_as_function=1
let python_slow_sync=1

" reload.vim
let g:reload_on_write = 0

" tagbar
let g:tagbar_compact = 1
let g:tagbar_sort = 0

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'passive',
			\ 'active_filetypes': ['sh', 'javascript'],
			\ 'passive_filetypes': ['python', 'c', 'objc', 'java']}
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_python_checkers=['pylint']
let g:syntastic_haskell_checkers=['ghc-mod']
let g:syntastic_go_checkers=['golint']

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_fmt_command = "goimports"

" pythonmode
" folding is sloooow
let g:pymode_folding = 0
let g:pymode_run = 0
let g:pymode_breakpoint = 0
let g:pymode_lint_ignore = "E501,E303"
let g:pymode_options_colorcolumn = 0
let g:pymode_run_bind = '<leader>pr'
"let g:pymode_python = 'python3'

" avoids the conflict with ycm
let g:pymode_rope = 0
"let g:pymode_rope_completion = 0
"let g:pymode_rope_complete_on_dot = 0

" ControlP
nnoremap <leader>p :CtrlPBuffer<CR>
set wildignore+=*/_vendor/*

" TaskList
let g:tlWindowPosition = 1

"snipmate
imap <C-l> <Plug>snipMateNextOrTrigger

" ultisnips
let g:ultisnips_python_quoting_style="single"

" ycm
let g:ycm_server_keep_logfiles = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>""
