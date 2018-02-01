"Copyright (c) 2014, Gautier DI FOLCO <gautier.difolco@gmail.com>
"All rights reserved.
"
"Redistribution and use in source and binary forms, with or without
"modification, are permitted provided that the following conditions are met:
"
"Redistributions of source code must retain the above copyright notice,
"this list of conditions and the following disclaimer.
"Redistributions in binary form must reproduce the above copyright
"notice, this list of conditions and the following disclaimer in the
"documentation and/or other materials provided with the distribution.
"
"THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
""AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
"LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
"A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
"HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
"INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
"BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
"OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
"AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
"LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
"WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
"POSSIBILITY OF SUCH DAMAGE.


" Aspects visuels
filetype plugin on
filetype indent on
set noexrc
set nocompatible
syntax on
set shell=zsh
set ttyfast
set number
set showcmd
set showmatch
set cursorline
set nocursorcolumn
set completeopt=menu,preview
set keymodel=startsel
set list
set ruler

" Clavier
set backspace=start,indent,eol
" Combinaisons
let maplocalleader=','
let mapleader=','
let g:mapleader= ','
" Raccouris
" noremap <C-[> <C-o>
imap <C-Space> <C-X><C-O>
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv
nmap U <C-r>
imap <F12> ~
nmap <F12> ~
cmap <F12> ~
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" diff
nmap >C [c
nmap <c ]c

set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set title
set titleold=""
set wildmenu
set wildmode=full
set wildchar=<Tab>
set selection=inclusive
set wildignore=*.o,*.obj,*.exe,*.dll,*.com,*.class,*.au,*.wav,*.mp[23g],*.jar,*.rar,*.zip,*.gz,*.tgz,*.jpg,*.png,*.gif,*.avi,*.wmv,*.flv,*.djvu,*.pdf,*.chm,*.ps,*.dvi,tags,descript.ion,desktop.ini,*/CVS/,*/.hg/,*.~*,*~,*.svn,*.hg,*.git,.*,*.beam
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set mousehide
set restorescreen
set splitright
set splitbelow
set noconfirm
set lazyredraw
command! -nargs=1 Silent
            \ | execute ':silent !'.<q-args>
            \ | execute ':redraw!'
set complete=.,b,u,U,i,d,t,w
set cpoptions+=$
set listchars=eol:$,tab:\|\ ,trail:⋅,precedes:←,extends:➜,nbsp:˽
" set listchars=eol:$,tab:\|,trail:⋅,precedes:←,extends:➜,nbsp:˽

" Pas de son
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Recherche
set ignorecase
set hlsearch

" Encodage
if has("multi_byte")
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set nobomb
    set termencoding=utf-8
    set fileencodings=utf-8
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

try
    " set t_Co=256
    colorscheme desert
    set termguicolors
    " highlight Normal guifg=white guibg=black
catch
endtry

try
    lang fr_FR
catch
endtry

" Coloration à plus de 80 caractères
" highlight ColorColumn ctermbg=red ctermfg=black
" call matchadd('ColorColumn', '\%81v', 100)


" Sauvegardes
set history=200
set backupcopy=no
set nobackup
set nowb
set noswapfile
set noautowrite

" Défaires persistents
try
    if !isdirectory($HOME . "/.vim_runtime/undodir")
        mkdir($HOME . "/.vim_runtime/undodir", "p", 0700)
    endif
    set undodir=~/.vim_runtime/undodir
    set undofile
catch
endtry

" Retour à l'endroit de la fermeture lors de l'ouverture
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Corps du fichier
set encoding=utf-8
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartcase
set smarttab
set wrap                      " Wrap long lines

" folding (masquage automatique)
set foldenable
set foldmethod=syntax
set foldminlines=30
set foldlevelstart=3
"set foldopen=all
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" Indentation
"set autoindent
"set smartindent
set cindent
set nopaste

" Search
"" Visual '*' search
function! s:VSetSearch(cmd)
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    normal! gvy
    let pat = escape(@@, a:cmd.'\')
    let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
    let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
    let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
    let @/ = '\V'.pat
    normal! gV
    call setreg('"', old_reg, old_regtype)
endfunction

vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<CR>/<C-R>/<CR>v//e<CR>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<CR>?<C-R>/<CR>v??e<CR>
vmap <kMultiply> *

function! HLNext (blinktime)
    highlight RedOnRed ctermfg=red guibg=red ctermfg=red guibg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    echo matchlen
    let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'
                \ . max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
                \ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
                \ . '\|'
                \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1])
                \ . 'v\%<'.(col+matchlen+3).'v.'
                \ . '\|'
                \ . '\%'.(lnum+1).'l\%>'.max([col-4,1])
                \ . 'v\%<'.(col+matchlen+3).'v.'
    let ring = matchadd('RedOnRed', ring_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
    call matchdelete(ring)
    redraw
endfunction

nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

" Sélection des dernières lignes modifiées
nmap gV `[v`]

" Espaces
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    retab
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nnoremap <silent> <F8> :call <SID>StripTrailingWhitespaces()<CR>

" Vundle
filetype off

" fzf
set rtp+=~/.fzf

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-markdown'
Plugin 'neilhwatson/vim_cf3'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'kana/vim-smartinput'
Plugin 'tpope/vim-unimpaired'
Plugin 'Yggdroot/indentLine'
Plugin 'vim-scripts/gcov.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-endwise'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'AndrewRadev/inline_edit.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'drmikehenry/vim-fixkey'
Plugin 'hspec/hspec.vim'
Plugin 'dag/vim2hs'
Plugin 'ujihisa/neco-ghc'
Plugin 'Twinside/vim-hoogle'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'
Plugin 'wellle/targets.vim'
Plugin 'Shougo/unite.vim'
Plugin 'ujihisa/unite-haskellimport'
Plugin 'bogado/file-line'
Plugin 'tpope/vim-fugitive'
Plugin 'kongo2002/fsharp-vim'
Plugin 'lambdatoast/elm.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'w0rp/ale'
Plugin 'haya14busa/incsearch.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'octref/RootIgnore'
Plugin 'mbbill/undotree'
" Plugin 'haya14busa/incsearch-fuzzy.vim'
" Plugin 'junegunn/vim-easy-align'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/fzf', {'rtp':  '~/.fzf' }
Plugin 'junegunn/fzf.vim'
Plugin 'romainl/vim-qf'

call vundle#end()
filetype plugin indent on

" fzf
nnoremap <C-o> :Files<cr>
nnoremap <C-t> :Tags<cr>
nnoremap <C-b> :pop<cr>
let g:fzf_action = {
  \ 'CTRL-E':       'edit',
  \ 'ENTER':        'split',
  \ 'ALT-ENTER':    'vsplit' }

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>'

" Sideways
nnoremap <C-Left> :SidewaysLeft<CR>
nnoremap <C-Right> :SidewaysRight<CR>

" SplitJoin
let g:splitjoin_split_mapping = 'ss'
let g:splitjoin_join_mapping  = 'sj'

" Switch
nnoremap - :Switch<CR>

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" map z/ <Plug>(incsearch-fuzzyspell-/)
" map z? <Plug>(incsearch-fuzzyspell-?)
" map zg/ <Plug>(incsearch-fuzzyspell-stay)

" vim-commentary
xmap <Leader>: gcc
nmap <Leader>: gcc
vmap <Leader>: gc

map crl guaW

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"

" unimpaired
" Déplacer un ligne
nmap <C-Up> [e
nmap <C-Down> ]e
" Déplacer plusieurs lignes
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Powerline
" pip3 install --user powerline-status
" pip3 install --user pygit2 
" pip3 install --user pyuv
" pip3 install --user psutil
set rtp+=~/.local/lib/python3.6/site-packages/powerline/bindings/vim

" Undotree
nnoremap <C-u> :UndotreeToggle<CR>

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" vim-qf
let g:qf_mapping_ack_style = 1
nmap <n :cnext<CR>
nmap >N :cprevious<CR>
nmap <l <Plug>qf_qf_stay_toggle
nmap >L <Plug>qf_qf_toggle

autocmd FileType haskell nnoremap <Leader>h :Unite -start-insert haskellimport <CR>
autocmd FileType haskell nnoremap <Leader>d :UniteWithCursorWord haskellimport <CR>

" Convert expressions to pointfree on pressing gq
autocmd BufEnter *.hs set formatprg=xargs\ -0\ pointfree

autocmd BufRead,BufNewFile *.zsh*   set filetype=zsh
autocmd BufRead,BufNewFile *.ru     set filetype=ruby
autocmd BufRead,BufNewFile *.cf     set filetype=cf3
autocmd BufRead,BufNewFile *.gcov   set filetype=gcov
autocmd BufRead,BufNewFile *.pl     set filetype=prolog
autocmd FileType ruby               set omnifunc=rubycomplete#Complete
autocmd FileType ruby               setlocal shiftwidth=2
autocmd FileType ruby               setlocal softtabstop=2
autocmd FileType ruby               setlocal tabstop=2 
autocmd FileType javascript         set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript         setlocal shiftwidth=2
autocmd FileType javascript         setlocal softtabstop=2
autocmd FileType javascript         setlocal tabstop=2
autocmd FileType html               set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css                set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml                set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php                set omnifunc=phpcomplete#CompletePHP
autocmd FileType sql                set omnifunc=sqlcomplete#CompleteSQL
autocmd FileType c                  set omnifunc=ccomplete#Complete
autocmd FileType cpp                set omnifunc=cppcomplete#Complete
autocmd FileType haskell            setlocal omnifunc=necoghc#omnifunc
autocmd FileType haskell            setlocal shiftwidth=2
autocmd FileType haskell            setlocal softtabstop=2
autocmd FileType haskell            setlocal tabstop=2
" autocmd FileType tex                set makeprg=latex\ %
" autocmd BufWritePost *.tex          exec 'make'
autocmd BufWritePost *.tex          exec ':!make'
autocmd FileType prolog             set makeprg=swipl\ -O\ --goal=main\ --stand_alone=true\ -c\ %;\ ./a.out
autocmd BufWritePost *.pl           exec 'make'
