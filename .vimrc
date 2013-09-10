" NeoBundle setting ---start
filetype off 

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#rc(expand('~/.vim/.bundle'))
endif

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'rbgrouleff/bclose.vim'
NeoBundle 'vim-jp/vimdoc-ja'
" NeoBundle setting ---end

filetype plugin on
filetype indent on

" conditioning variables
let g:is_gui = has('gui_running')

" basic settings
inoremap <C-j> <ESC>
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp
set autoindent

" searching
set incsearch
set hlsearch

" tab setting
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=0

" use clipboard
set clipboard+=unnamed
set clipboard+=autoselect

" show buffer list
nnoremap <Space>b :ls<CR>:buffer

" show line number
set number

" move cursor up/down depending on displayed line
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" complemente type
set wildmode=list,full

" complemente window setting
set completeopt=menuone

" edit setting file
command! Myrc :edit $MYVIMRC
command! Mygrc :edit $MYGVIMRC

command! ReloadRc :call ReloadRc_Func()
if has('vim_starting')
  function! ReloadRc_Func()
    if g:is_gui
      silent execute ":source $MYVIMRC"
      silent execute ":source $MYGVIMRC"
    else
      silent execute ":source $MYVIMRC"
    endif
  endfunction
endif

" open current file on new tab window
" based on m1204080's script from http://d.hatena.ne.jp/m1204080/20101025/1288028786
" Modifid: get not to quit, vim when apply on the last window
nnoremap <C-n> :call OpenNewTabWindow()<CR>
function! OpenNewTabWindow()
    let l:f = expand("%:p")
    if winnr('$') != 1 || tabpagenr('$') != 1
        execute ":q"
    endif
    execute ":tabnew ".l:f
endfunction

" insert on visual mode
xnoremap <expr> I  <SID>force_blockwise_visual('I')
xnoremap <expr> A  <SID>force_blockwise_visual('A')
function! s:force_blockwise_visual(next_key)
  if mode() ==# 'v'
    return "\<C-v>" . a:next_key
  elseif mode() ==# 'V'
    return "\<C-v>0o$" . a:next_key
  else
    return a:next_key
  endif
endfunction

" brace complemente
xnoremap { "zdi{<C-R>z}<ESC>
xnoremap [ "zdi[<C-R>z]<ESC>
xnoremap ( "zdi(<C-R>z)<ESC>
xnoremap " "zdi"<C-R>z"<ESC>
xnoremap ' "zdi'<C-R>z'<ESC>
xnoremap ` "zdi`<C-R>z`<ESC>

" tab window operation
nnoremap tf :<c-u>tabfirst<cr>
nnoremap tl :<c-u>tablast<cr>
nnoremap tn :<c-u>tabnext<cr>
nnoremap tN :<c-u>tabNext<cr>
nnoremap tp :<c-u>tabprevious<cr>
nnoremap te :<c-u>tabedit<cr>
nnoremap tc :<c-u>tabclose<cr>
nnoremap to :<c-u>tabonly<cr>
nnoremap ts :<c-u>tabs<cr>

" locate cursor on the center of page on searching
nnoremap n nzz
nnoremap N Nzz

" addtional match pair
set mps+=<:>

" You can chage buffer wihtout save
set hidden

" replace 
nnoremap <Space>s :%s/
xnoremap <Space>s :s/

" delete
nnoremap x "_x
nnoremap X "_X

" yank
nnoremap Y y$

" Rename
command! -nargs=+ -bang -complete=file Rename exec 'f '.escape(<q-args>, ' ')|w<bang>

" open-browser settings
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"------------------------------
" vim-powerline {{{
"------------------------------
set laststatus=2
" don't use special symbols
let g:Powerline_symbols = 'compatible'
" override symbols
let g:Powerline_symbols_override = {
\ 'LINE': 'Caret'
\ }
" override mode name
let g:Powerline_mode_n = 'Normal'
let g:Powerline_mode_i = 'Insert'
let g:Powerline_mode_R = 'Replace'
let g:Powerline_mode_v = 'Visual'
let g:Powerline_mode_V = 'V-Line'
let g:Powerline_mode_cv = 'V-Block'
let g:Powerline_mode_s = 'Select'
let g:Powerline_mode_S = 'Sel-Line'
let g:Powerline_mode_cs = 'Sel-Block'
" display relational path for file
let g:Powerline_stl_path_style = 'relative'
set t_Co=256

" }}}

"-----------------------
"unite {{{
"----------------------
 
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]
 
"インサートモードで開始
let g:unite_enable_start_insert = 1
 
" For ack.
if executable('ack-grep')
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt = ''
endif
 
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''
 
"data_directory
if has('win32')
  let g:unite_data_directory = 'E:\vimtmp\.unite'
elseif  has('macunix')
  let g:unite_data_directory = '/.unite'
endif
 
"bookmarkだけホームディレクトリに保存
let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'
 
 
"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"key mapping
nnoremap <silent> [unite]k :<C-u>Unite mapping<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
augroup vimrc
  autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときctrl+jでノーマルモードに移動
  imap <buffer> <C-j> <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "sでsplit
  nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
  "vでvsplit
  nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
  "fでvimfiler
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
endfunction
 
"}}}
 
"-----------------------
"vimfiler {{{
"-----------------------
"data_directory
if has('win32')
  let g:vimfiler_data_directory = 'E:\vimtmp'
elseif  has('macunix')
  let g:unite_data_directory = '/.vimfiler'
endif
 
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
 
"}}}


"-----------------------
" neocomplache {{{
"----------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" }}}

"-----------------------
" neosnippet {{{
"----------------------
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)
" }}}

