"Copyright (c) 2014-2018, Gautier DI FOLCO <gautier.difolco@gmail.com>
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
set scrolloff=5

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
nmap >C [n
nmap <c ]n
nmap dgu :diffg RE
nmap dgb :diffg BA
nmap dgl :diffg LO

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
" syntax
Plugin 'tpope/vim-markdown'
Plugin 'hspec/hspec.vim'
Plugin 'dag/vim2hs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'
Plugin 'Shougo/unite.vim'
Plugin 'ujihisa/unite-haskellimport'
Plugin 'kongo2002/fsharp-vim'
Plugin 'AndrewRadev/inline_edit.vim'
" textobj/move
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'wellle/targets.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'glts/vim-textobj-comment'
Plugin 'vimtaku/vim-textobj-keyvalue'
Plugin 'sgur/vim-textobj-parameter'
Plugin 'machakann/vim-textobj-functioncall'
Plugin 'thalesmello/vim-textobj-methodcall'
" visual
Plugin 'Yggdroot/indentLine'
Plugin 'ivyl/vim-bling'
Plugin 'RRethy/vim-illuminate'
" search
Plugin 'haya14busa/incsearch.vim'
Plugin 'junegunn/fzf', {'rtp':  '~/.fzf' }
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-abolish'
" vcs
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
" commands/codegen
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-endwise'
Plugin 'machakann/vim-swap'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'romainl/vim-qf'
Plugin 'w0rp/ale'
Plugin 'mbbill/undotree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'kana/vim-smartinput'
" passive/config
Plugin 'tpope/vim-repeat'
Plugin 'kopischke/vim-fetch'
Plugin 'drmikehenry/vim-fixkey'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'octref/RootIgnore'


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
nmap f <Plug>(easymotion-f)
nmap F <Plug>(easymotion-F)
nmap t <Plug>(easymotion-t)
nmap T <Plug>(easymotion-T)

" vim-swap
let g:swap_no_default_key_mappings = 1
nmap <C-Left> <Plug>(swap-prev)
nmap <C-Right> <Plug>(swap-next)

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

" vim-abolish
map crl guaW

" vim utlisnips
let g:UltiSnipsExpandTrigger="<S-Tab>"
let g:UltiSnipsJumpForwardTrigger="<S-Tab>"
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

" bling
let g:bling_time = 2
let g:bling_count = 2

" vim-easy-align
vmap A <Plug>(EasyAlign)
nmap gA <Plug>(EasyAlign)

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
