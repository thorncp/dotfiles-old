set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'briancollins/vim-jst'
Bundle 'derekwyatt/vim-scala'
Bundle 'godlygeek/tabular'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/Vim-R-plugin'
Bundle 'vim-scripts/golden-ratio'
Bundle 'vim-ruby/vim-ruby'

syntax on
filetype plugin indent on
runtime macros/matchit.vim

set tabstop=2
set shiftwidth=2
set expandtab

autocmd FileType c setlocal shiftwidth=4 tabstop=4
autocmd FileType *.h setlocal shiftwidth=4 tabstop=4

set laststatus=2
set relativenumber
set number
set shell=sh
set ic
set hlsearch
set incsearch

let g:ctrlp_max_height = 25
let g:ctrlp_working_path_mode = 0

if !has("gui_running")
  colorscheme railscasts256
endif

highlight clear SignColumn

set ruler
set list listchars=tab:\ \ ,trail:·
highlight Special guifg=#00FFFF guibg=#00FFFF

set t_Co=256
set spell spellcapcheck=
syn match NoSpell /\u\l\+\%(\u\l\+\)\+/ contains=@NoSpell
syn match CamelCase "\<\%(\u\l*\)\{2,}\>" contains=@NoSpell
syn match CamelCase2 transparent "\<\%(\u\l*\)\{2,}\>" contains=@NoSpell contained
autocmd Syntax * syn match CamelCase "\<\%(\u\l*\)\{2,}\>" transparent containedin=.*Comment.* contains=@NoSpell contained

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*/log/*,*/.DS_Store,*/spec/reports/*,*/public/system/*,*.dSYM/*,*/build/*,*/_site/* " ,*/vendor/*

noremap H ^
noremap L $

:autocmd FileType markdown nmap <leader>zx :call system('open -a Marked.app ' . expand("%:p"))<cr>
:autocmd FileType html nmap <leader>zx :call system('open ' . expand("%:p"))<cr>
:autocmd FileType ruby nmap <leader>zx :!clear; ruby %<cr>

nnoremap <leader>< i<%  %><esc>2hi
inoremap <leader>< <%  %><esc>2hi
nnoremap <leader>= i<%=  %><esc>2hi
inoremap <leader>= <%=  %><esc>2hi
nnoremap <leader>> i<% end %><esc>
inoremap <leader>> <% end %><esc>

nnoremap <leader>: :s/:\(\w\+\) =>/\1:/ge<cr>
vnoremap <leader>: :s/:\(\w\+\) =>/\1:/ge<cr>

nnoremap <leader>v :vs ~/.vimrc<cr>

" alignment
nnoremap <leader>a: :Tabularize /:\zs<cr>
vnoremap <leader>a: :Tabularize /:\zs<cr>
nnoremap <leader>a= :Tabularize /=<cr>
vnoremap <leader>a= :Tabularize /=<cr>
nnoremap <leader>a+ :Tabularize /=\zs<cr>
vnoremap <leader>a+ :Tabularize /=\zs<cr>
nnoremap <leader>a, :Tabularize /,\zs<cr>
vnoremap <leader>a, :Tabularize /,\zs<cr>

function! RSpecSingle ()
  if match(bufname("%"), "_spec.rb") >= 0
    let g:specfile = bufname("%")
    let g:linenum = line(".")
    exec ":wa"
    exec "!clear & rspec " g:specfile " -l " g:linenum
  elseif len(g:specfile) > 0 && len(g:linenum) > 0
    exec ":wa"
    exec "!clear & rspec " g:specfile " -l " g:linenum
  else
    echo "not enough info to run"
  endif
endfunction

function! RSpecFile ()
  if match(bufname("%"), "_spec.rb") >= 0
    let g:specfile = bufname("%")
    " let g:linenum = ""
    exec ":wa"
    exec "!clear & rspec --format documentation --order random " g:specfile
  elseif len(g:specfile) > 0
    exec ":wa"
    exec "!clear & rspec --format documentation --order random " g:specfile
  else
    echo "not enough info to run"
  endif
endfunction

function! RSpecSuite ()
  exec ":wa"
  exec "!clear & rspec --format progress --order random"
endfunction

nnoremap <leader>zs :call RSpecSingle()<cr>
nnoremap <leader>zz :call RSpecFile()<cr>
nnoremap <leader>za :call RSpecSuite()<cr>

:nnoremap <CR> :nohlsearch<cr>

" rspec highlighting outside of rails
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let stub expect
highlight def link rubyRspec Function

" ruby annotations
" plain annotations
map <silent> <leader>4 !xmpfilter -a<cr>
nmap <silent> <leader>4 V<leader>4
imap <silent> <leader>4 <ESC><leader>4

" Annotate the full buffer
nmap <silent> <leader>5 mzggVG!xmpfilter -a<cr>'z
imap <silent> <leader>5 <ESC><leader>5

" Add # => markers
vmap <silent> <leader>3 !xmpfilter -m<cr>
nmap <silent> <leader>3 V<leader>3
imap <silent> <leader>3 <ESC><leader>3

" Remove # => markers
vmap <silent> <leader># ms:call RemoveRubyEval()<CR>
nmap <silent> <leader># V<leader>#
imap <silent> <leader># <ESC><leader>#

function! RemoveRubyEval() range
  let begv = a:firstline
  let endv = a:lastline
  normal! Hmt
  set lz
  execute ":" . begv . "," . endv . 's/\s*# \(=>\|!!\).*$//e'
  execute ":nohlsearch"
  normal! 'tzt`s
  set nolz
  redraw
endfunction

" disable R screen support. TODO: make this work, it sounds awesome
let vimrplugin_screenplugin = 0

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, vim_command)
  try
    silent! exec a:vim_command . " " . system(a:choice_command . " | selecta")
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
  endtry
  redraw!
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
map <leader>f :call SelectaCommand("find * -type f", ":e")<cr>
