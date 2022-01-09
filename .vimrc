" vundle _____________________________________________________________________

" add Vundle to path and start
if has("win32")
    set rtp+=$HOME/.vim/bundle/Vundle.vim/
    call vundle#begin('$HOME/.vim/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif


" plugins ____________________________________________________________________

Plugin 'VundleVim/Vundle.vim'            " plugin manager
Plugin 'tpope/vim-surround'              " deal with pairs of surroundings
Plugin 'tpope/vim-commentary'            " comment stuff out/in
Plugin 'tpope/vim-repeat'                " dot operator tools
Plugin 'tpope/vim-fugitive'              " git client
Plugin 'tpope/vim-dispatch'              " build and test
Plugin 'alfredodeza/pytest.vim'          " pytest
Plugin '5long/pytest-vim-compiler'       " pytest compiler plugin for dispatch
Plugin 'ntpeters/vim-better-whitespace'  " highlight trailing whitespace characters
Plugin 'w0rp/ale'                        " asynchronous linting engine
Plugin 'AndrewRadev/switch.vim'          " true<->false, etc
Plugin 'fidian/hexmode'                  " improved hex editing
Plugin 'vim-airline/vim-airline'         " draw a nice statusline at the bottom of each window
Plugin 'vim-airline/vim-airline-themes'  " airline themes
Plugin 'dietsche/vim-lastplace'          " intelligently reopen files where you left off
Plugin 'jiangmiao/auto-pairs'            " insert or delete brackets, parens, quotes in pair
Plugin 'yegappan/mru'                    " access most recently used files
Plugin 'PeterRincker/vim-argumentative'  " aids with manipulating and moving between function arguments
Plugin 'plasticboy/vim-markdown'         " markdown syntax
Plugin 'chrisbra/csv.vim'                " handling column separated data
Plugin 'majutsushi/tagbar'               " browsing the tags of source code files
Plugin 'davidhalter/jedi-vim'            " jedi python autocompletion
Plugin 'SirVer/ultisnips'                " snippet management
Plugin 'harveyormston/vim-snippets'      " my snippets
Plugin 'chriskempson/base16-vim'         " base16 colorschemes
Plugin 'unblevable/quick-scope'          " highlight a unique character in every word on a line
Plugin 'vimwiki/vimwiki'                 " a personal wiki
Plugin 'vim-python/python-syntax'        " python syntax
Plugin 'TaDaa/vimade'                    " dim inactive split panes
Plugin 'justinj/vim-pico8-syntax'        " Pico8 Lua syntax


call vundle#end()
filetype plugin indent on

" plugin_config ______________________________________________________________

" Airline
let g:switch_mapping = "+"
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline_inactive_collapse=0
let g:airline_powerline_fonts = 0

" ALE
let g:ale_linters = {'python': ['pylint']}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_python_pylint_use_global = 1
let g:ale_set_loclist = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:snips_author="Harvey Ormston"
let g:snips_email="harveyormston@me.com"

" Others
let g:python_highlight_all = 1
let g:jedi#popup_on_dot = 0
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:vimwiki_list = [{'path': '$HOME/.wiki', 'path_html': '$HOME/.wiki_html', 'syntax': 'markdown', 'ext': '.md'}]
let g:vim_markdown_folding_disabled = 1
let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o,*.wav'

" defaults ___________________________________________________________________

" ensure sensible defaults for vim8
if v:version >= 800 && !has('nvim')
    source $VIMRUNTIME/defaults.vim
endif
set nocompatible
filetype off

" ignore non-text files when wildcard matching
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif " binary images
set wildignore+=*.wav,*.mp3,*.raw " binary audio
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.sw? " Vim swap files
set wildignore+=**/build/** " Python build files
set wildignore+=**/dist/** " Python dist files
set wildmode=list:longest,full

" set options of completion
set completeopt=menuone,preview
set complete-=i
set complete-=d

" use vertical diff split by default
set diffopt+=vertical

" set nicer diff options
if has('nvim-0.3.2') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:patience,indent-heuristic
endif

" set netrw options
let g:netrw_liststyle = 3     " tree
let g:netrw_banner = 0        " no banner
let g:netrw_altv = 1          " open files on right
let g:netrw_preview = 1       " open previews vertically
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

" use system clipboard, but not for x/X
if has('clipboard')
    set clipboard=unnamedplus
    noremap x "_x
    noremap X "_X
endif

syntax on

set nocompatible
set autoread
set path+=**
set wildmenu
set hidden
set backspace=indent,eol,start
set autoindent
set incsearch
set ignorecase
set smartcase
set hlsearch
set lazyredraw
set ruler
set number
set relativenumber
set showcmd
set laststatus=2
set swapfile

if has('mouse')
    set mouse=n
endif

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

set tags=~/.tags
autocmd CursorHold * checktime


" key mappings ________________________________________________________________

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
inoremap jk <esc>
if has('nvim')
    " map jk for terminal in neovim
    tnoremap jk <C-\><C-n>
endif
nnoremap * *Nzz
nnoremap # #Nzz


" leader mappings _____________________________________________________________

map <space> <leader>

" splits
nmap <leader>\| :vsp<CR>
nmap <leader>- :sp<CR>

" toggles
nmap <leader>e :call ToggleVex()<CR>
nmap <leader>d :call ToggleDiff()<CR>
nmap <leader>w :ToggleWhitespace<CR>
nmap <leader>m :MRU<CR>
nmap <leader>r :set wrap!<CR>

set pastetoggle=<leader>p

" tabs and buffers
nmap <leader>o :tabnew<CR>
nnoremap <leader>b :buffers<CR>:buffer<Space>

" use l, h to go back and forward through tabs
nnoremap <leader>l :tabnext<CR>
nnoremap <leader>h :tabprevious<CR>

" use j, k to go back and forward through buffers
nnoremap <leader>j :bn<CR>
nnoremap <leader>k :bp<CR>

nmap <leader>t :TagbarToggle<CR>
xmap <leader>t :TagbarToggle<CR>
nmap <leader>a :AirlineToggle<CR>

" cd to directory of current file
nnoremap <leader>cd :cd %:p:h

nmap <leader>c :set cursorline!<CR>
nmap <leader>n :set number! relativenumber!<CR>

" commands ___________________________________________________________________

" vimgrep recusively for current word in files of the same type
cabbrev gg
      \ noautocmd vimgrep /\<lt><C-R><C-W>\>/gj
      \ ./**/*<C-R>=(expand("%:e")=="" ? "" : ".".expand("%:e"))<CR>
      \ <Bar> copen
      \ <C-Left><C-Left><C-Left>

" cd to directory of current file
:command! CD cd %:p:h

" fancy git log
:command! -nargs=* Glg Git! log --graph --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>

" close all buffers except the current one
command! BufOnly silent! execute "%bd|e#|bd#"

" format json
command! JSONtool execute '%!python -m json.tool' | w


" calculator
if has('python3')
    :command! -nargs=+ Calc :py3 print(<args>)
    :py3 from math import *
else
    :command! -nargs=+ Calc :py from __future__ import division, print_function; print(<args>)
    :py from math import *
endif

" convert to/from hex
:command! -nargs=1 FromHex :echo <args>
:command! -nargs=1 ToHex :echo printf('%x', <args>)

" convert to/from log domain
:command! -nargs=1 FromLog :Calc 10**(<args>/20.0)
:command! -nargs=1 ToLog :Calc 20*log10(<args>)

" tabnew
:command -nargs=* T tabnew <args>

" whitespace defaults _________________________________________________________

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap


" filetype-specific ___________________________________________________________

" unknown
autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set ft=unknown | endif

" single-line commentstring for c-flavoured languages
autocmd FileType c,cpp,cs,objc,objcpp,java setlocal commentstring=//\ %s

" Makefile
augroup MakefileGroup
  au! BufRead,BufNewFile,BufEnter Makefile set ft=make
augroup END

" Jenkinsfile
augroup JenkinsfileGroup
  au! BufRead,BufNewFile,BufEnter Jenkinsfile set ft=groovy
augroup END

" Binary
augroup BinaryfileGroup
  au! BufRead,BufNewFile,BufEnter *.bin set nofixendofline
augroup END

" python
autocmd Filetype python setlocal ts=4 sts=4 sw=4 tw=79 cc=79 expandtab
autocmd Filetype python setlocal makeprg=pylint\ --reports=n\ --output-format=parseable\ %
autocmd Filetype python setlocal errorformat=%f:%l:\ %m
autocmd Filetype python autocmd QuickFixCmdPost [^l]* nested cwindow

" markdown
autocmd Filetype markdown setlocal ts=2 sts=2 sw=2 tw=0
autocmd Filetype markdown setlocal expandtab spell wrap linebreak breakindent
autocmd Filetype markdown setlocal makeprg=grip\ \"%\"\ --user-content\ -b\ &&\

" asm
autocmd BufNewFile,BufRead *.asm set ft=perl

" other
autocmd Filetype unknown setlocal ts=4 sts=4 sw=4 tw=79 cc=79 expandtab
autocmd Filetype make setlocal ts=4 sts=0 sw=4 noexpandtab
autocmd Filetype tex setlocal ts=2 sts=2 sw=2 tw=79 cc=79 expandtab spell
autocmd Filetype plaintex setlocal ts=2 sts=2 sw=2 tw=79 cc=79 expandtab spell

" terminal
if has('nvim')
    au TermOpen * setlocal nonumber norelativenumber
endif


" colorscheme ________________________________________________________________

let base16colorspace=256
try
    colorscheme base16
catch
    colorscheme default
endtry

" set light background if 'light' is in the current base16 theme name
let base16_theme = resolve(expand("$HOME/.base16_theme"))
if filereadable(base16_theme)
    if base16_theme =~ 'light'
        set bg=light
    else
        set bg=dark
    endif
else
    set bg=dark
endif

hi clear SignColumn
hi clear SpellBad

hi ColorColumn ctermbg=white
hi ColorColumn ctermfg=black
hi LineNr ctermfg=darkgrey
hi VertSplit ctermbg=darkgrey ctermfg=black
hi TabLineFill ctermfg=black ctermbg=black
hi TabLine ctermfg=Blue ctermbg=black
hi TabLineSel ctermfg=Red ctermbg=black
hi SpellBad cterm=underline ctermfg=black ctermbg=red
hi Visual cterm=none ctermbg=blue ctermfg=black
hi Search cterm=none ctermbg=red ctermfg=black


" os/terminal specific _______________________________________________________

if has("win32")
    set directory=$HOME/.vim/swapfiles//
    set backupdir=$HOME/.vim/swapfiles//
else
    set directory=$HOME/.vim/swapfiles//
    set backupdir=$HOME/.vim/swapfiles//
    hi Normal ctermbg=none
    hi nonText ctermbg=NONE

    if &term =~ "screen"
        let &t_ti.="\eP\e[2 q\e\\"
        let &t_SI.="\eP\e[4 q\e\\"
        let &t_EI.="\eP\e[2 q\e\\"
        let &t_te.="\eP\e[4 q\e\\"
        set t_Co=256
    else
        let &t_ti.="\e[2 q"
        let &t_SI.="\e[4 q"
        let &t_EI.="\e[2 q"
        let &t_te.="\e[4 q"
    endif

endif

if has("win32unix")
    let g:ale_python_pylint_executable = '/usr/bin/pylint'
    let g:ale_python_flake8_executable = '/usr/bin/flake8'
endif


" functions __________________________________________________________________

" save/load session __________________________________________________________

fu! SaveSess()
    if filereadable(getcwd() . '/.session.vim')
        execute 'mksession! ' . getcwd() . '/.session.vim'
    endif
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()

" vertical netrw  ____________________________________________________________

fu! ToggleVex()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        exec expl_win_num . 'wincmd w'
        close
        unlet t:expl_buf_num
    else
        exec '1wincmd w'
        Vexplore
        let t:expl_buf_num = bufnr("%")
    endif
endfunction

" diff mode  _________________________________________________________________

fu! ToggleDiff()
    if exists("g:diffmode")
        :diffoff
        unlet g:diffmode
    else
        :windo diffthis
        let g:diffmode = 'true'
    endif
endfunction

" end ________________________________________________________________________

set exrc
