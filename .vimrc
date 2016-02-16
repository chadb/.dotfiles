"version 6.0
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-vividchalk.git'
Plugin 'tpope/vim-surround.git'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'rizzatti/dash.vim'
Plugin 'stefanoverna/vim-i18n'
Plugin 'ngmy/vim-rubocop.git'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'kchmck/vim-coffee-script'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
set laststatus=2
" When the "unnamed" string is included in the 'clipboard' option, the unnamed
" register is the same as the "* register.  Thus you can yank to and paste the
" selection without prepending "* to commands.
set clipboard="unnamed"
set statusline=%<%f%h%m%r%=%l,%c%V\ %P
let s:cpo_save=&cpo
set cpo&vim
set fileformats=unix,dos
set fileformat=unix
map! <xHome> <Home>
map! <xEnd> <End>
map! <S-xF4> <S-F4>
map! <S-xF3> <S-F3>
map! <S-xF2> <S-F2>
map! <S-xF1> <S-F1>
map! <xF4> <F4>
map! <xF3> <F3>
map! <xF2> <F2>
map! <xF1> <F1>

let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=2
set expandtab
set softtabstop=2
set tabstop=4
set fileencodings=utf-8,latin1
set formatoptions=croq
set winminheight=0
set history=50
set hlsearch
set ignorecase
set incsearch
set mouse=a
set ruler
set smartcase
if &syntax != 'help'
set syntax=help
endif
set textwidth=80
set smartindent
set shiftwidth=2
set viminfo='1000,f1,\"50,:100,@100,/100
set visualbell
set tabpagemax=100
set number
set norelativenumber

" skip the default mapping of the apple key in
" /Applications/MacVim.app/Contents/Resources/vim/gvimrc
let macvim_skip_cmd_opt_movement = 1

" Make tab switching use normal mac keys
" this is alt-h
nnoremap ˙ :tabprevious<CR>
inoremap ˙ <Esc>:tabprevious<CR>i
" this is alt-l
nnoremap ¬ :tabnext<CR>
inoremap ¬ <Esc>:tabnext<CR>i 


" use tab in visual mode to indent
:vnoremap <Tab> >>
:vnoremap <S-Tab> <<

" Now just type ctrl-Up arrow to go to next buffer
" Now just type ctrl-Down arrow to go to previous buffer
map <c-Up>     :bn<cr>
map <c-Down>   :bp<cr>

" use cntl-j,k,h,l to move around window
map <c-J> <C-W>j<C-W>_
map <c-K> <C-W>k<C-W>_
map <c-L> <C-W>l<C-W>_
map <c-H> <C-W>h<C-W>_

"let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
"let Tlist_Sort_Type = "name"
"let Tlist_Auto_Open = 1
"let Tlist_WinWidth = 20
"let Tlist_Exit_OnlyWindow = 1
"let tlist_vhdl_settings = 'vhdl;e:entity;a:architecture;c:constant;p:package;b:package_body;t:type;s:signal;r:process;u:subroutines;y:subtypes'

function! VisualSelection()
" Save register content and type.
if version >= 602
    let old_reg     = getreg('"')
    let old_regmode = getregtype('"')
else
    let old_reg     = @"
endif

" Calling this function has ended visual mode, so it must be started again
" before the selection can be yanked into the unnamed register.
normal gvy
let selection = @"

" Restore register content and type.
if version >= 602
    call setreg('"', old_reg, old_regmode)
else
    let @" = old_reg
endif

return selection
endfunction

function! Escaped(text)
return substitute(escape(a:text, '\\/.*$^~[]'), "\n$", "", "")
endfunction

" Search on visual selected text
vnoremap <silent> * :<C-U><cr>/<C-R><C-R>=Escaped(VisualSelection())<cr><cr>
vnoremap <silent> # :<C-U><cr>?<C-R><C-R>=Escaped(VisualSelection())<cr><cr>

"from http://vim.wikia.com/wiki/Load_multiple_files_with_a_single_command
command! -complete=file -nargs=+ Etabs call s:ETW('tabnew', <f-args>)
command! -complete=file -nargs=+ Ewindows call s:ETW('new', <f-args>)
command! -complete=file -nargs=+ Evwindows call s:ETW('vnew', <f-args>)

function! s:ETW(what, ...)
  for f1 in a:000
    let files = glob(f1)
    if files == ''
      execute a:what . ' ' . escape(f1, '\ "')
    else
      for f2 in split(files, "\n")
        execute a:what . ' ' . escape(f2, '\ "')
      endfor
    endif
  endfor
endfunction

:abbr hte the

let g:treeExplVertical=1 
set spell

map tl :tabnext<CR>
map th :tabprev<CR>
map tn :tabnew<CR>
map td :tabclose<CR>

call pathogen#infect()
set t_Co=256
" Easy on the eyes...
colorscheme vividchalk

so ~/.vim/regexp_list.vim

let g:rails_projections = {
      \ "app/decorators/*_decorator.rb": {
      \   "command": "decorator",
      \   "template":
      \     "class %SDecorator < SimpleDelegator\nend",
      \   "test": [
      \     "test/unit/%s_decorator_test.rb",
      \     "spec/decorators/%s_decorator_spec.rb"
      \   ],
      \  "affinity": "model"
      \ }}

if has('gui_running')
  set guifont=Osaka-Mono:h15
endif

" Set line numbers based on what we are doing
":au FocusLost * :set number
":au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber
