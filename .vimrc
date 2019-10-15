colorscheme torte
set t_ti= t_te=

execute pathogen#infect()
call pathogen#helptags()
"set runtimepath-=~/.vim/bundle/tagbar
"set runtimepath-=~/.vim/bundle/vim-go
"

"let g:ctrlp_custom_ignore = "vendor\|jspm_packages\|node_modules\|c-deps"
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|node_modules$\|jspm_packages$\|vendor$\|c-deps\|sql/parser/gen$',
    \ 'file': '\.so$\|\.pyc$' }
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_root_markers = ['pkg']
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*' " MacOSX/Linux

set completeopt-=preview

syntax on
filetype plugin indent on

set nonumber

set notitle

set scrolloff=5

autocmd BufNewFile,BufRead *.tex set filetype=tex
autocmd FileType c,cpp set cindent tw=0
autocmd Filetype tex set makeprg=latex\ %
"set tw=80
set tabstop=2
set shiftwidth=2
set cino=:0,g0,u0,(0
set expandtab
" syntax folding is slow with vim-go
set foldmethod=indent
set foldlevel=20
set backspace=indent,eol,start
set showmatch
set ruler
set ignorecase
set smartcase
set winheight=35
set wildmode=longest,list
"set noincsearch
set incsearch
set nohlsearch
set nobackup
set dir=~/.vimbak
set backupdir=~/.vimbak
"set mouse=ir
set mouse=

highlight SpellBad ctermbg=Black ctermfg=Red guibg=Black guifg=Red cterm=underline gui=underline term=underline
highlight SpellCap ctermbg=Black ctermfg=Yellow guibg=Black guifg=Red cterm=underline gui=underline term=underline
highlight VertSplit cterm=NONE
highlight LineNr ctermfg=darkgray

set fillchars+=vert:│

let spell_auto_type = "tex,mail,text,html"
"map <F2> :w<CR>:!latex %<CR>
map <F2> :w<CR>:make<CR>
"map <F2> :w<CR>:!gofmt % >/dev/null<CR>
nmap <F3> :TagbarToggle<CR>
nmap <F4> :call TimeLapse()<CR>
nmap <F5> :%s/  *$//g<CR>
"nmap <F7> :let @/ = "<C-R><C-W>"<CR>:grep <C-R><C-W> *<CR>:cope<CR>
nmap <F6> :cd %:p:h<CR>
nmap <F7> :let @/ = "<C-R><C-W>"<CR>:Ag -U -a -s -w <C-R><C-W><CR>
"nmap <F8> :let @/ = "<C-R><C-W>"<CR>:!grep <C-R><C-W> *<CR>
nmap <F8> :let @/ = "<C-R><C-W>"<CR>:!ag -U -a -s -w <C-R><C-W><CR>
nmap <S-F8> :let @/ = "<C-R><C-W>"<CR>:!ag --ignore "*_test.go" -s -w <C-R><C-W><CR>
nmap <F9> :GoReferrers<CR>
nmap <F10> :qa<CR>
nmap <C-N> :cn<CR>
nmap <C-S-P> :cp<CR>
nmap <C-]> :exec("stselect ".expand("<cword>"))<CR>
"nmap gt :exec("tselect ".expand("<cword>"))<CR>

"map <C-h> <C-W>h
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-l> <C-W>l

"highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=black guibg=LightGreen
"highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black guibg=#FFFF80
"highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black gui=NONE guibg=#FFFF20
"highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black gui=NONE guifg=Blue guibg=LightRed

highlight DiffAdd ctermbg=22 ctermfg=white guibg=LightGreen
highlight DiffChange ctermbg=58 ctermfg=white guibg=#FFFF80
highlight DiffText ctermbg=59 ctermfg=white gui=NONE guibg=#FFFF20
highlight DiffDelete ctermbg=88 ctermfg=white gui=NONE guifg=Blue guibg=LightRed

hi MatchParen cterm=none ctermbg=none ctermfg=white

"set diffopt=filler,context:3,iwhite
set diffopt=filler,context:3
set diffexpr=MyDiff()
function MyDiff()
   let opt = ""
   if &diffopt =~ "icase"
      let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
      let opt = opt . "-b "
   endif
   silent execute "!diff -a -d --binary " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out
endfunction

autocmd BufNewFile,BufRead *.sc set filetype=python
autocmd BufNewFile,BufRead *.sc.BASE set filetype=python
autocmd BufNewFile,BufRead SConstruct set filetype=python
autocmd BufNewFile,BufRead *.py.BASE set filetype=python
autocmd BufNewFile,BufRead *.tex set filetype=tex tw=80 makeprg=make spell
autocmd BufNewFile,BufRead *.c.BASE set filetype=c
autocmd BufNewFile,BufRead *.cpp.BASE set filetype=cpp
autocmd BufNewFile,BufRead *.h.BASE set filetype=cpp
autocmd BufNewFile,BufRead *.java.BASE set filetype=java
autocmd BufNewFile,BufRead NOTES_EDITMSG set tw=70 ai spell

"autocmd BufNewFile,BufRead */sql/testdata/* set filetype=sh tw=0
autocmd BufNewFile,BufRead */sql/logictest/testdata/* set filetype=crlogictest tw=0 ai "number
autocmd BufNewFile,BufRead */ccl/logictestccl/testdata/* set filetype=crlogictest tw=0 ai "number
autocmd BufNewFile,BufRead */sql/opt/*/testdata/* set filetype=cropttest foldmethod=syntax tw=0 ai "number
autocmd BufNewFile,BufRead */opt-private-tests/xform/* set filetype=cropttest foldmethod=syntax tw=0 ai "number
autocmd BufNewFile,BufRead */sql/opt/exec/*/testdata/* set filetype=crlogictest tw=0 ai "number

autocmd BufNewFile,BufRead *.opt setlocal filetype=cropt tw=80 ai number shiftwidth=4 expandtab

autocmd FileType cropttest,crlogictest,cropt highlight Tabs ctermbg=darkred ctermfg=white
autocmd FileType cropttest,crlogictest,cropt match Tabs /\t/

autocmd BufNewFile,BufRead sql.y nmap gd /^<C-R><C-W>:<C-M>
autocmd BufNewFile,BufRead sql.y highlight Tabs ctermbg=darkred ctermfg=white
autocmd BufNewFile,BufRead sql.y match Tabs /\t/

autocmd FileType c,cpp syn keyword cType vmk_uint8 vmk_int8 vmk_uint16 vmk_int16 vmk_uint32 vmk_int32 vmk_uint64 vmk_int64 vmk_uintptr_t vmk_Bool VMK_ReturnStatus vmk_ListLinks vmk_atomic64
autocmd FileType c,cpp syn keyword cType uint8 int8 uint16 int16 uint32 int32 uint64 int64 uintptr_t Bool
autocmd FileType c,cpp syn keyword cConstant VMK_TRUE VMK_FALSE TRUE FALSE

autocmd FileType go setlocal number fo+=croq tw=80
autocmd FileType go DefineTagFinder Typ t,type
autocmd FileType c,cpp,java,asm,make,proto,javascript setlocal cindent tw=80 fo+=croq number
autocmd FileType c,cpp,java,sh,python,make,go highlight OverLength ctermbg=darkred ctermfg=white
autocmd FileType c,cpp,java,sh,python,make,go match OverLength /\%101v.\+/
"autocmd FileType c,cpp,java,sh,python,make,go highlight ExtraWhitespace ctermbg=darkred ctermfg=white
"autocmd FileType c,cpp,java,sh,python,make,go 2match ExtraWhitespace /\s\+$/
"autocmd FileType c,cpp,java call matchadd('ExtraWhitespace', '\s\+$')
"autocmd FileType c,cpp,java match ExtraWhitespace /\s\+$/
autocmd FileType sh,python setlocal nocindent cindent fo+=croq number
autocmd FileType conf setlocal smartindent fo=croqt number
autocmd FileType messages set nowrap

autocmd BufNewFile,BufRead /tmp/log* setlocal filetype=crlog nonumber
autocmd BufNewFile,BufRead *ERROR* setlocal filetype=crlog nonumber
autocmd BufNewFile,BufRead *INFO* setlocal filetype=crlog nonumber
autocmd BufNewFile,BufRead *WARNING* setlocal filetype=crlog nonumber


" This fixes the full-pathed files opened by tags
autocmd BufRead * cd .


" Go stuff
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_structs = 1
"let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_def_mapping_enabled = 0


"let g:go_def_mode = 'godef'
"let g:go_info_mode = 'godef'

let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'


" Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"

" By default vim-go shows errors for the fmt command, to disable it:
let g:go_fmt_fail_silently = 1

" Disable auto fmt on save:
let g:go_fmt_autosave = 0
let g:go_fmt_autofmt = 0
let g:go_asmfmt_autosave = 0

let g:crlfmt_autosave = 1
"let g:crlfmt_options = ' -ignore ".*.pb(.gw)?.go" -tab 2 -fast'

" Disable opening browser after posting your snippet to play.golang.org:
"let g:go_play_open_browser = 0

"Show type info under cursor.
"let g:go_auto_type_info = 1

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_width = 50

set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags,./../../../../../../tags,./../../../../../../../tags

autocmd Filetype sql set makeprg=runsql\ %\ 2>&1
autocmd Filetype sql nmap <buffer> <F2> :!cat % \| ~/roach/cockroach sql --insecure<CR>
autocmd Filetype markdown nmap <buffer> <F2> :!git amend && git push-current<CR>

"autocmd Filetype go set makeprg=go\ build\ .
"autocmd Filetype go set makeprg=go\ test\ -v\ -run\ -\ .
autocmd Filetype go set makeprg=build\ %
autocmd Filetype go nmap <C-]> :exec("stselect ".expand("<cword>"))<CR>

autocmd Filetype go nmap gd <Plug>(go-def)
"autocmd Filetype go nmap gD <Plug>(go-doc)
autocmd Filetype go nmap <C-\> :split<CR><Plug>(go-def)
"autocmd FileType go nmap gd :YcmCompleter GoTo<CR>
"autocmd Filetype go nmap <C-\> :split<CR>:YcmCompleter GoTo<CR>

autocmd Filetype go nmap <Space> <Plug>(go-info)
autocmd Filetype go nmap <C-t> :<C-U>call go#def#StackPop(v:count1)<cr>
autocmd Filetype go setlocal spell

"autocmd Filetype go highlight Comment cterm=italic
autocmd Filetype go highlight Pmenu ctermbg=black ctermfg=red

autocmd Filetype gitcommit set tw=70 spell ai
"Always start on the first line.
autocmd Filetype gitcommit 1
autocmd Filetype gitcommit let g:ycm_auto_trigger=0
autocmd Filetype markdown set tw=80 spell ai
autocmd Filetype proto setlocal shiftwidth=2 spell
autocmd Filetype yacc set ai

let g:vimshell_vimshrc_path = '~/.bashrc'
" TERM=linux fixes
"set <F2>=OQ
"set <F3>=OR
"set <Home>=[H
"set <End>=[F

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

"Always show status line.
set laststatus=2

if !has('nvim')
  set clipboard=autoselectplus,exclude:cons\|linux
endif

noremap ,s :!/home/radu/roach/cockroach sqlfmt --print-width 110 --use-spaces --tab-width 2<cr><cr>

let g:airline_powerline_fonts = 1

"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="minimalist"

let g:airline_section_a = airline#section#create(['mode', 'crypt', 'paste', 'iminsert'])
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" or copy paste the following into your vimrc for shortform text
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ 't'  : 'T',
    \ }

let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 110,
    \ 'x': 90,
    \ 'y': 100,
    \ 'z': 80,
    \ 'warning': 80,
    \ 'error': 80,
    \ }

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary="/go/bin/gocode"

" Restore last position for nvim.
if has('nvim')
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line("'\"") <= line("$") |
              \   exe "normal g`\"" |
              \ endif
endif

let g:gh_open_command = 'xdg-open '
let g:gh_git_remote = 'origin'

set maxmempattern=5000
