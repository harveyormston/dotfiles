" vundle _____________________________________________________________________

let os = substitute(system('uname'), "\n", "", "")

if has("win32")
    set rtp+=%HOME%/vimfiles/bundle/Vundle.vim/
    call vundle#begin('%USERPROFILE%/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'w0rp/ale'
Plugin 'sickill/vim-monokai'
Plugin 'Yavor-Ivanov/airline-monokai-subtle.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'TroyFletcher/vim-colors-synthwave'
Plugin 'AndrewRadev/switch.vim'
Plugin 'fidian/hexmode'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dietsche/vim-lastplace'
Plugin 'jiangmiao/auto-pairs'
Plugin 'yegappan/mru'
Plugin 'junegunn/vim-easy-align'
Plugin 'will133/vim-dirdiff'
Plugin 'vim-python/python-syntax'
Plugin 'PeterRincker/vim-argumentative'
Plugin 'plasticboy/vim-markdown'
Plugin 'rust-lang/rust.vim'
Plugin 'Valloric/ListToggle'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'samsaga2/vim-z80'
Plugin 'chrisbra/csv.vim'
Plugin 'sotte/presenting.vim'
Plugin 'majutsushi/tagbar'
Plugin 'davidhalter/jedi-vim'
Plugin 'SirVer/ultisnips'
Plugin 'harveyormston/vim-snippets'
Plugin 'chriskempson/base16-vim'
Plugin 'unblevable/quick-scope'
call vundle#end()
filetype plugin indent on

" defaults ___________________________________________________________________

if v:version >= 800 && !has('nvim')
    source $VIMRUNTIME/defaults.vim
endif
set nocompatible
filetype off

set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif " binary images
set wildignore+=*.wav,*.mp3,*.raw " binary audio
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.sw? " Vim swap files
set completeopt+=menuone,noinsert,noselect,preview
set diffopt+=vertical

let g:netrw_liststyle = 3     " tree
let g:netrw_banner = 0        " no banner
let g:netrw_altv = 1          " open files on right
let g:netrw_preview = 1       " open previews vertically
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

" keymap _____________________________________________________________________

map <space> <leader>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap * *Nzz
nnoremap # #Nzz
nmap <leader>e :call ToggleVex()<CR>
nmap <leader>d :call DiffMode()<CR>

" Go to tab by number
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

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

" plugin_config ______________________________________________________________

let g:switch_mapping = "+"
let g:airline_theme = 'base16'
let g:airline_inactive_collapse=0
let g:airline_powerline_fonts = 0
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_mode_map = {
    \'__' : '-', 'n'  : 'N', 'i'  : 'I', 'R'  : 'R',
    \'c'  : 'C', 'v'  : 'V', 'V'  : 'V', '^V' : 'V',
    \ 's'  : 'S', 'S'  : 'S', '^S' : 'S',}
let g:vim_markdown_folding_disabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_python_pylint_options = '--rcfile=.pylintrc'
let g:ale_python_pylint_use_global = 0
let g:ale_python_flake8_use_global = 0
let g:ale_python_mypy_use_global = 0
let g:python_highlight_all = 1
let g:ale_set_loclist = 1
let g:presenting_top_margin = 2
let g:jedi#popup_on_dot = 0
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsSnippetDirectories=["mysnippets"]
let g:snips_author="Harvey Ormston"
let g:snips_email="harveyormston@me.com"

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nmap <leader>t :TagbarToggle<CR>
xmap <leader>t :TagbarToggle<CR>
nmap <leader>a :AirlineToggle<CR>

" whitespace _________________________________________________________________

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap

" filetype-specific _________________________________________________________

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

" python
autocmd Filetype python setlocal ts=4 sts=4 sw=4 tw=79 cc=79 expandtab
autocmd Filetype python setlocal makeprg=pylint\ --reports=n\ --output-format=parseable\ %
autocmd Filetype python setlocal errorformat=%f:%l:\ %m
autocmd Filetype python autocmd QuickFixCmdPost [^l]* nested cwindow

" other
autocmd Filetype unknown setlocal ts=4 sts=4 sw=4 tw=79 cc=79 expandtab
autocmd Filetype markdown setlocal ts=2 sts=2 sw=2 tw=0
autocmd Filetype markdown setlocal expandtab spell wrap linebreak breakindent
autocmd Filetype markdown setlocal makeprg=grip\ %\ 80\ --user-content\ -b\ &&\
autocmd Filetype make setlocal ts=4 sts=0 sw=4 noexpandtab
autocmd Filetype tex setlocal ts=2 sts=2 sw=2 tw=79 cc=79 expandtab spell
autocmd Filetype plaintex setlocal ts=2 sts=2 sw=2 tw=79 cc=79 expandtab spell

" general ____________________________________________________________________

set nocompatible
set autoread
set wildmenu
set backspace=indent,eol,start
set autoindent
set incsearch
set ignorecase
set smartcase
set hlsearch
set lazyredraw
set ruler
syntax on
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

set tags=./tags;/
autocmd CursorHold * checktime

" colorscheme ________________________________________________________________

 try
     colorscheme base16
 catch
     colorscheme default
 endtry

hi clear SignColumn
hi ColorColumn ctermbg=18
hi LineNr ctermfg=darkgrey
hi VertSplit ctermbg=darkgrey ctermfg=black
hi TabLineFill ctermfg=black ctermbg=black
hi TabLine ctermfg=Blue ctermbg=black
hi TabLineSel ctermfg=Red ctermbg=black
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=black ctermbg=red


" os-specific ________________________________________________________________

if has("win32")
    set directory=%HOME%/vimfiles/swapfiles//
    set backupdir=%HOME%/vimfiles/swapfiles//
else
    set directory=$HOME/.vim/swapfiles//
    set backupdir=$HOME/.vim/swapfiles//
    hi Normal ctermbg=none
    hi nonText ctermbg=NONE
    hi Search cterm=NONE ctermfg=black ctermbg=white

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

" set style for presenting ___________________________________________________

fu! Present()
    set background=light
    colorscheme papercolor
    AirlineTheme = papercolor
    PresentingStart
    set cc=0
    set nospell
endfunction

fu! EndPresent()
    set background=dark
    colorscheme base16
    AirlineTheme base16color
endfunction

fu! DiffMode()
    set background=light
    colorscheme papercolor
    AirlineTheme ayu_mirage
    set cc=0
    set nospell
endfunction

" end ________________________________________________________________________

set exrc
