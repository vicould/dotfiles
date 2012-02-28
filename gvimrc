source ~/.vimrc

" macvim tweaks
set go-=T
set lines=60 
set columns=160

" Resets previous highlight configurations
highlight clear WhitespaceEOL
highlight clear Folded
highlight clear FoldColumn
highlight clear Search
highlight clear Comment
highlight clear Statusline
highlight clear StatusLineNC
highlight clear VertSplit
highlight clear wildmenu
highlight clear spellbad
highlight clear spelllocal
highlight clear spellcap
highlight clear spellrare
highlight clear TabLineSel
highlight clear TabLine
highlight clear TabLineFill

" Prints trailing whitespaces and tabs
highlight WhitespaceEOL ctermbg=blue
match     WhitespaceEOL /\s\+$/


syntax enable
colorscheme slate-mod
set guifont=Monaco



