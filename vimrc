runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

"----------------------------------------------------------------
" Basic stuff
"----------------------------------------------------------------
set nocompatible

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

"----------------------------------------------------------------
" Mappings
"----------------------------------------------------------------

" sets the leader key, i.e. the modifier
let mapleader = ","

" successive indentation when selecting a text block
vnoremap < <gv 
vnoremap > >gv

" tabs
nnoremap <leader>l :tabp<CR>
nnoremap <leader>r :tabn<CR>
nnoremap <leader>tl :execute 'silent! tabmove ' (tabpagenr() - 2)<CR>
nnoremap <leader>tr :execute 'silent! tabmove ' tabpagenr()<CR>

" indentation shortcut
noremap <leader>= gg=G

" vimrc modification
map <leader>v :sp ~/.vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:source ~/.gvimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

map <F1> :set nu!<CR>:set nu?<CR>
map <F2> :nohl<CR>

" nerdtree
noremap <leader>n :NERDTreeToggle<CR>

" tagbar
nmap <leader>tt :TagbarToggle<CR>

" fugitive
map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>gc :Gcommit<CR>
map <leader>gc :Gpush<CR>

" Fuzzyfinder
map <leader>ff :FufFile<CR>
map <leader>fb :FufBuffer<CR>

" FSSwitch
noremap <leader>sl :FSSplitLeft<CR>
noremap <leader>sr :FSSplitRight<CR>
noremap <leader>sa :FSSplitAbove<CR>
noremap <leader>sb :FSSplitBelow<CR>
noremap <leader>sh :FSHere<CR>

" Syntastic
noremap <leader>sc :SyntasticCheck<CR>
noremap <leader>st :SyntasticToggleMode<CR>


"----------------------------------------------------------------
" Plugins
"----------------------------------------------------------------

" latex
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'Preview'

" Use the ctags database when editing a file
set tags=./tags,~/.vimtags

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
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'passive',
			\ 'active_filetypes': ['sh', 'javascript'],
			\ 'passive_filetypes': ['python', 'c', 'objc', 'java']}
let g:syntastic_javascript_checker='jshint'
let g:syntastic_python_checker='pylint'


