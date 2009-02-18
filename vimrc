" Jonny Lamb <jonnylamb@jonnylamb.com>

set autoindent wildmenu number smartindent
set showcmd
set wrap

if has("autocmd")
    filetype plugin indent on
endif

" Linebreaks
set linebreak
set showbreak=>>

set spell spelllang=en_gb

" Default (tabs)
autocmd FileType *      set tabstop=8|set shiftwidth=4|set noexpandtab
"autocmd FileType c,cpp      set cindent|set tabstop=8|set shiftwidth=8|set expandtab|set listchars=tab:>-,trail:_ list|set cinoptions=(0|set softtabstop=8|set textwidth=79|match Error /\%>79v.\+/
autocmd FileType tex    set tabstop=4|set shiftwidth=4|set expandtab|set listchars=tab:>-,trail:_ list
autocmd FileType python set softtabstop=4|set shiftwidth=4|set expandtab|set listchars=tab:>-,trail:_ list|match Error /\%>79v.\+/
autocmd FileType xhtml   set softtabstop=2|set shiftwidth=2|set expandtab|set listchars=tab:>-,trail:_ list
autocmd FileType debcopyright set expandtab|set tabstop=4|set softtabstop=4

" Collabora
autocmd FileType c,cpp      set listchars=tab:>-,trail:_ list|setl tw=78 ts=2 sts=2 sw=2 et|set cino=>2s,{1s,n-s,^-s|match Error /\%>79v.\+/

"New
autocmd FileType java      set listchars=tab:>-,trail:_ list|setl tw=78 ts=8 sts=8 sw=8 et|set cino=:0(sj1|match Error /\%>79v.\+/
"autocmd FileType java      set cindent|set tabstop=8|set shiftwidth=8|set expandtab|set listchars=tab:>-,trail:_ list|set cinoptions=:0(sj1|set softtabstop=8

" ctags
map <F4> :TlistToggle<CR>
map <F5> :TlistUpdate<CR>:TlistHighlightTag<CR>
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 40
let Tlist_Inc_Winwidth = 0
let Tlist_Exit_OnlyWindow = 1

" Shiny
syntax on
highlight comment ctermfg=grey
set mouse=a
set cmdheight=2
colorscheme ron

" Because I can't use a keyboard properly
command -bang Q q
command -bang W w
command -bang Wq wq
command -bang WQ wq

" make searches case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase

set incsearch

" Don't litter the working dir with swapfiles
set backupdir=.backup,/tmp,.
set directory=.backup,/tmp,.

" Shortcuts
inoremap <buffer> ``me   <space>-- Jonny Lamb <jonnylamb@jonnylamb.com><space><space><Esc>:r! date -R<CR>i<backspace><end>

" Python stuff
"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
"    if os.path.isdir(p):
"        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF
set tags+=$HOME/.vim/tags/python.ctags
map <silent><C-S-Left> <C-T>
map <silent><C-S-Right> <C-]>
inoremap <Nul> <C-x><C-o>
