runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible

" error bells
set noerrorbells
set visualbell
set t_vb=		" visual bell without changing the color

set wildmenu
set wildmode=list:longest " longest:full
set wildignore=*.o,*.a,*.so,*.class,*.pyc,*.tar,*.zip,*.gz,*.bz2

set showmode
set ruler


" better search
set incsearch
set hlsearch
set ignorecase  " Ignore the case
set smartcase   " Only if the search pattern is not cased

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
	colorscheme default
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

""""""""""""
" Mappings "
""""""""""""

" sets the leader key, i.e. the modifier
let mapleader = ","

" successive indentation when selecting a text block
vnoremap < <gv 
vnoremap > >gv

" indentation shortcut
noremap ,= gg=G

" nerdtree
noremap ,n :NERDTreeToggle<CR>

" tagbar
nmap ,t :TagbarToggle<CR>

" fugitive
map ,gs :Gstatus<CR>
map ,gd :Gdiff<CR>
map ,gc :Gcommit<CR>
map ,gc :Gpush<CR>

" Fuzzyfinder
map ,ff :FufFile<CR>
map ,fb :FufBuffer<CR>

" FSSwitch
noremap ,sl :FSSplitLeft<CR>
noremap ,sr :FSSplitRight<CR>
noremap ,sa :FSSplitAbove<CR>
noremap ,sb :FSSplitBelow<CR>
noremap ,sh :FSHere<CR>

" vimrc modification
map ,v :sp ~/.vimrc
map <silent> ,V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

map <F1> :set nu!<CR>:set nu?<CR>
map <F2> :nohl<CR>
map <F3> :tabp<CR>
map <F4> :tabnew<CR>
map <F5> :tabn<CR>

" filetypes
autocmd FileType * set tabstop=4|set shiftwidth=4|set noexpandtab
augroup json_autocmd 
	autocmd! 
	autocmd filetype json set autoindent 
	autocmd filetype json set formatoptions=tcq2l 
	autocmd filetype json set textwidth=78 shiftwidth=2 
	autocmd filetype json set softtabstop=2 tabstop=8 
	autocmd filetype json set expandtab 
	autocmd filetype json set foldmethod=syntax 
augroup END 

autocmd FileType c,cpp,slang set cindent
autocmd FileType make set noexpandtab shiftwidth=8
autocmd FileType html,htmldjango,htmldjango.html set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2

augroup python_autocmd
	autocmd!
	autocmd FileType python set tabstop=4
	autocmd FileType python set shiftwidth=4
	autocmd FileType python set expandtab
	autocmd FileType python set softtabstop=4
augroup END


" Reopen the file where left
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

filetype plugin indent on

"""""""""""
" PLUGINS "
"""""""""""

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
let g:syntastic_mode_map = { 'mode': 'active',
			\ 'active_filetypes': ['python', 'sh', 'javascript'],
			\ 'passive_filetypes': ['c', 'objc', 'java']}
let g:syntastic_javascript_checker='jshint'


