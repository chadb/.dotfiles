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
Bundle 'kchmck/vim-coffee-script'

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
" replace all multiple spaces with one space
vmap ,gq :s/\s\+/ /g  gvgq
nmap ,gq :%s/\s\+/ /g  gq1G
" shortcut for html tags
nmap ,hx wbF <df>f <df>
nmap ,ht wbi <tt>  ea </tt>  bb
nmap ,hp wi <p>  
nmap ,hP wbi <pre>  $a </pre>  bb
nmap ,hs wbi <strong>  ea </strong>  bb
nmap ,hu wbi <u>  ea </u>  bb
nmap ,hi wbi <i>  ea </i>  bb
nmap ,he wbi <em>  ea </em>  bb
nmap ,hb wbi <b>  ea </b>  bb
nmap ,h6 _i <h6>  A </h6>  
nmap ,h5 _i <h5>  A </h5>  
nmap ,h4 _i <h4>  A </h4>  
nmap ,h3 _i <h3>  A </h3>  
nmap ,h2 _i <h2>  A </h2>  
nmap ,h1 _i <h1>  A </h1>  
nmap ,mh wbgueyei <  ea> </  pa>  bba
map Q gq
vmap [%   [%m'gv``
vmap ]%   ]%m'gv``
vmap _j :call Justify('tw',4)  
nmap _j :%call Justify('tw',4)  
map <xHome> <Home>
map <xEnd> <End>
map <S-xF4> <S-F4>
map <S-xF3> <S-F3>
map <S-xF2> <S-F2>
map <S-xF1> <S-F1>
map <xF4> <F4>
map <xF3> <F3>
map <xF2> <F2>
map <xF1> <F1>
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=2
set expandtab
set softtabstop=4
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
set textwidth=78
set smartindent
set shiftwidth=4
set viminfo='1000,f1,\"50,:100,@100,/100
set visualbell

" skip the default mapping of the apple key in
" /Applications/MacVim.app/Contents/Resources/vim/gvimrc
let macvim_skip_cmd_opt_movement = 1

" Make tab switching use normal mac keys
map  <D-Left>   :tabp<CR>
imap <D-Left>   <Esc>:tabp<CR>i
map  <D-Right>  :tabn<CR>
imap <D-Right>  <Esc>:tabn<CR>i 


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
let Tlist_Sort_Type = "name"
let Tlist_Auto_Open = 1
let Tlist_WinWidth = 20
let Tlist_Exit_OnlyWindow = 1
let tlist_vhdl_settings = 'vhdl;e:entity;a:architecture;c:constant;p:package;b:package_body;t:type;s:signal;r:process;u:subroutines;y:subtypes'

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

" Window resizing mappings (functions.vim plugin)/*{{{*/
nnoremap <S-Up>     :normal <c-r>=Resize('+')<cr><cr>
nnoremap <S-Down>   :normal <c-r>=Resize('-')<cr><cr>
nnoremap <S-Left>   :normal <c-r>=Resize('<')<cr><cr>
nnoremap <S-Right>  :normal <c-r>=Resize('>')<cr><cr>


function! Resize(dir)
    let this = winnr()

    if '+' == a:dir || '-' == a:dir
        execute "normal \<c-w>k"
        let up = winnr()
        if up != this
            execute "normal \<c-w>j"
            let x = 'bottom'
        else
            let x = 'top'
        endif
    elseif '>' == a:dir || '<' == a:dir
        execute "normal \<c-w>h"
        let left = winnr()
        if left != this
            execute "normal \<c-w>l"
            let x = 'right'
        else
            let x = 'left'
        endif
    endif

    if ('+' == a:dir && 'bottom' == x) || ('-' == a:dir && 'top' == x)
        return "5\<c-v>\<c-w>+"
    elseif ('-' == a:dir && 'bottom' == x) || ('+' == a:dir && 'top' == x)
        return "5\<c-v>\<c-w>-"
    elseif ('<' == a:dir && 'left' == x) || ('>' == a:dir && 'right' == x)
        return "5\<c-v>\<c-w><"
    elseif ('>' == a:dir && 'left' == x) || ('<' == a:dir && 'right' == x)
        return "5\<c-v>\<c-w>>"
    else
        echo "oops. check your ~/.vimrc"
        return ""
    endif
endfunction

" not quite working yet...
function! RmNonPrint() range
    execute a:firstline . "," . a:lastline . 's/[^[:print:]]/ /'
endfunction


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


"treat .tpl files as c code
:autocmd BufNewFile,BufRead *.tpl set filetype=smarty 
":autocmd BufNewFile,BufRead *.tpl source ~/.vim/syntax/Aspex_tpl.vim

:autocmd BufNewFile,BufRead *.module set filetype=php 

" ruby and eruby 
au BufNewFile,BufRead *.rhtml				set filetype=eruby
:autocmd BufNewFile,BufRead *.rjs,*.rb,*rbw,*.gem,*.gemspec,[rR]akefile* set filetype=ruby tabstop=2 softtabstop=2 shiftwidth=2

" abbreviations

:abbr hte the
" VHDL abbreviations
:abbr sl; STD_LOGIC;
:abbr slv; STD_LOGIC_VECTOR( downto );
:abbr un; UNSIGNED( downto );
:abbr s; SIGNED( downto );
:abbr entity; library IEEE;use IEEE.STD_LOGIC_1164.all;entity name is    generic();    port();end name;
:abbr arch; architecture rtl of name isbeginend rtl;

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
