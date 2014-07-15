" {{{
"シンタックスハイライト
	filetype indent plugin on
	syntax on "depend on 'filetype indent plugin on'
"バックアップファイルを作るディレクトリ
	set backupdir=$HOME/.vimbackup
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
	set browsedir=buffer
"クリップボードをWindowsと連携
	set clipboard=unnamed
	set clipboard+=autoselect
"Vi互換をオフ
	set nocompatible
"スワップファイル用のディレクトリ
	set directory=$HOME/.vimbackup
"タブの代わりに空白文字を挿入しない
	set noexpandtab
"インクリメンタルサーチを行う
	set incsearch
"タブ文字、行末など不可視文字を表示する
	"set list
"listで表示される文字のフォーマットを指定する
	"set listchars=tab:>\ ,extends:<
"シフト移動幅
	set shiftwidth=4
"ファイル内の <Tab> が対応する空白の数
	set tabstop=4
"カーソルを行頭、行末で止まらないようにする
	set whichwrap=b,s,h,l,<,>,[,]
" バッファを保存しなくても他のバッファを表示できるようにする
	set hidden
" コマンドライン補完を便利に
	set wildmenu
" タイプ途中のコマンドを画面最下行に表示
	set showcmd
" 検索時に大文字・小文字を区別しない
	set ignorecase
" ただし混在しているときは区別する
	set smartcase
" 検索時に最後まで行ったら最初に戻る
	set wrapscan
" オートインデント、改行、インサートモード開始直後にバックスペースキーで削除できるようにする
	set backspace=indent,eol,start
" オートインデント
	"set smartindent
	"set autoindent
	set cindent
" 移動コマンドを使ったとき、行頭に移動しない
	set nostartofline
" 画面最下行にルーラーを表示する
	set ruler
" ステータスラインを常に表示する
	set laststatus=2
" バッファが変更されているとき、コマンドをエラーにするのでなく、保存するかどうか確認を求める
	set confirm
" コマンドラインの高さを2行に
	set cmdheight=2
" 行番号を表示
	set number
"括弧入力時の対応する括弧を表示
	set showmatch
"編集中の内容を保ったまま別の画面に切替えられるようにする(デフォルトだと一度保存しないと切り替えられない)
	set hid
"折りたたみ
	set foldmethod=marker
"MacVim(KaoriyaVim)でテキストファイルを開いた時に自動改行されないようにする
	autocmd FileType text setlocal textwidth=0
"}}}

" my keymap {{{
	" Yの動作をDやCと同じにする
		map Y y$
	"C-Pでペーストモードトグル
		set pastetoggle=<C-C><C-P>
	" C-C無効化 (unite-colorのマッピングのため）
		map <C-C> <NOP>
	"範囲選択+Tabでインデント
		xmap <TAB> >
		xmap <S-TAB> <
"}}}

" my command {{{
	"文字コードを変えて開きなおす
		command ReopenInEuc :e ++enc=euc-jp-ms
		command ReopenInJis :e ++enc=iso-2022-jp-3
		command ReopenInSjis :e ++enc=cp932
		command ReopenInUtf8 :e ++enc=utf-8
		command Wsudo :w !sudo tee % > /dev/null
	"wcのラッパー
		command WordsChecker !wc -w %
		command LinesChecker !wc -l %
		command BytesChecker !wc -c %
		command CharsChecker !wc -m %
	"DiffOrig
		if has('unix')
			command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
		endif
	"保存時に行末の空白を除去する
		autocmd BufWritePre * :%s/\s\+$//ge
	"バッファ内のファイルをリネーム
		command! -nargs=+ -bang -complete=file Rename let pbnr=fnamemodify(bufname('%'), ':p')|exec 'f '.escape(<q-args>, ' ')|w<bang>|call delete(pbnr)
"}}}

" my syntax {{{
	au BufRead,BufNewFile .tmux.conf set filetype=tmuxconf
" }}}

" ステータスライン {{{
	"set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P
	set statusline=%<     " 行が長すぎるときに切り詰める位置
	set statusline+=[%n]  " バッファ番号
	set statusline+=%m    " %m 修正フラグ
	set statusline+=%r    " %r 読み込み専用フラグ
	set statusline+=%h    " %h ヘルプバッファフラグ
	set statusline+=%w    " %w プレビューウィンドウフラグ
	set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
	set statusline+=%y    " バッファ内のファイルのタイプ
	set statusline+=\     " 空白スペース
	if winwidth(0) >= 130
		set statusline+=%F    " バッファ内のファイルのフルパス
	else
		set statusline+=%t    " ファイル名のみ
	endif
	set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
	set statusline+=%{anzu#search_status()} " ステータス情報を statusline へと表示する
	set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
	set statusline+=\ \   " 空白スペース2個
	set statusline+=%1l   " 何行目にカーソルがあるか
	set statusline+=/
	set statusline+=%L    " バッファ内の総行数
	set statusline+=,
	set statusline+=%c    " 何列目にカーソルがあるか
	set statusline+=%V    " 画面上の何列目にカーソルがあるか
	set statusline+=\ \   " 空白スペース2個
	set statusline+=%P    " ファイル内の何％の位置にあるか
"}}}

" 文字コードの自動認識 {{{
	if &encoding !=# 'utf-8'
		set encoding=japan
		set fileencoding=japan
	endif
	if has('iconv')
		let s:enc_euc = 'euc-jp'
		let s:enc_jis = 'iso-2022-jp'
		" iconvがeucJP-msに対応しているかをチェック
		if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
			let s:enc_euc = 'eucjp-ms'
			let s:enc_jis = 'iso-2022-jp-3'
		" iconvがJISX0213に対応しているかをチェック
		elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
			let s:enc_euc = 'euc-jisx0213'
			let s:enc_jis = 'iso-2022-jp-3'
		endif
		" fileencodingsを構築
		if &encoding ==# 'utf-8'
			let s:fileencodings_default = &fileencodings
			let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
			let &fileencodings = &fileencodings .','. s:fileencodings_default
			unlet s:fileencodings_default
		else
			let &fileencodings = &fileencodings .','. s:enc_jis
			set fileencodings+=utf-8,ucs-2le,ucs-2
			if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
				set fileencodings+=cp932
				set fileencodings-=euc-jp
				set fileencodings-=euc-jisx0213
				set fileencodings-=eucjp-ms
				let &encoding = s:enc_euc
				let &fileencoding = s:enc_euc
			else
				let &fileencodings = &fileencodings .','. s:enc_euc
			endif
		endif
		" 定数を処分
		unlet s:enc_euc
		unlet s:enc_jis
	endif
	" 日本語を含まない場合は fileencoding に encoding を使うようにする
	if has('autocmd')
		function! AU_ReCheck_FENC()
			if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
				let &fileencoding=&encoding
			endif
		endfunction
		autocmd BufReadPost * call AU_ReCheck_FENC()
	endif
	" 改行コードの自動認識
	set fileformats=unix,dos,mac
	" □とか○の文字があってもカーソル位置がずれないようにする
	if exists('&ambiwidth')
		set ambiwidth=double
	endif
"}}}

"NeoBundle {{{
	"おまじない
		if has('vim_starting')
			set nocompatible               " Be iMproved
			set runtimepath+=~/.vim/bundle/neobundle.vim/
		endif
		call neobundle#rc(expand('~/.vim/bundle/'))
	"自動でリポジトリと同期するプラグイン
		NeoBundle 'Shougo/neobundle.vim.git'
		NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'make -f make_mingw32.mak',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make -f make_mac.mak',
			\     'unix' : 'make -Bf make_unix.mak',
			\    },
			\ }
		NeoBundle 'Shougo/neocomplete.vim'
		NeoBundle 'supermomonga/neocomplete-rsense.vim'
		NeoBundle 'Shougo/neosnippet.vim'
		NeoBundle 'Shougo/neosnippet-snippets'
		NeoBundle 'kien/ctrlp.vim', {'depends' : 'haya14busa/vim-migemo'}
		NeoBundle 'Shougo/unite.vim'
		NeoBundle 'Shougo/neomru.vim'
		NeoBundle 'ujihisa/unite-colorscheme'
		NeoBundle 'Shougo/unite-outline'
		NeoBundle 'sgur/unite-git_grep'
		NeoBundle 'ujihisa/quicklearn'
		NeoBundle 'ujihisa/unite-launch'
		NeoBundle "y-uuki/unite-perl-module.vim" "-----あとでなんとか
		"NeoBundle 'mattn/unite-remotefile'
			"require has('clientserver')

		NeoBundle 'thinca/vim-quickrun'
		NeoBundle 'osyo-manga/shabadou.vim'
		NeoBundle 'osyo-manga/quickrun-hook-u-nya-'
		NeoBundle 'osyo-manga/vim-watchdogs'
		NeoBundle 'Yggdroot/indentLine'
		NeoBundle 'mattn/gist-vim', {'depends' : 'mattn/webapi-vim'}
		NeoBundle 'mattn/unite-gist'
		NeoBundle 'davidhalter/jedi-vim'
		NeoBundle 'vim-ruby/vim-ruby'

		NeoBundle 'Shougo/vimshell.git'
		NeoBundle 'Shougo/vimfiler.git'

		NeoBundle 'tpope/vim-fugitive'
			"git
		NeoBundle 'Shougo/vinarise.git'
		NeoBundle 's-yukikaze/vinarise-plugin-peanalysis'
			"ex.)`:Vinarise binary.bin`,`:VinariseDump object.obj`
		NeoBundle 'tyru/capture.vim'
			"Vim のコマンドの結果を新規バッファへと出力するプラグインです。
			"ex.) `:Capture map`,`:Capture !git --help'
		"NeoBundle 'tyru/restart.vim'
			"Vim の再起動を行うプラグインです
			"no useful on terminal
		NeoBundle 'thinca/vim-prettyprint'
			"辞書の整形
			"ex.)`:PP g:neocomplete#force_omni_input_patterns`
		NeoBundle 't9md/vim-quickhl'
			"単語のハイライト
			"-----あとで調べる
		NeoBundle 'thinca/vim-ref'
		NeoBundle 'yuku-t/vim-ref-ri'
			"ex.)`:Ref perldoc -f pack`
		NeoBundle 'osyo-manga/vim-over'
			"ハイライトしつつ置換用
		NeoBundle 'LeafCage/yankround.vim'
			"ペースト後にC-N,C-Pでヤンクの履歴を辿る
		NeoBundle "osyo-manga/vim-anzu"
			"検索からのn,Nでステータスラインに現在の位置表示
		NeoBundle 'tyru/caw.vim'
		NeoBundle 'kana/vim-altr'
		NeoBundle 'changed'
		NeoBundle 'mattn/emmet-vim'
			"zencodingみたいなやつ
	"for text-obj
		NeoBundle 'tpope/vim-surround'
		NeoBundle 'kana/vim-textobj-user'
		NeoBundle 'rhysd/vim-textobj-ruby'
			"ruby(r)
		NeoBundle 'kana/vim-textobj-function'
			"function(f)
		NeoBundle 'kana/vim-textobj-indent'
			"indent(l)
			"ex.)>iiや>iaで現在行のインデントと同じインデント数の続いた行に対してインデント/デインデント
		NeoBundle 'kana/vim-textobj-underscore'
			"underscore(_)
		NeoBundleLazy 'thinca/vim-textobj-between' "デフォのキーマップを無効化するために後で読み込む
			"任意の文字(f->i)
		NeoBundle 'mattn/vim-textobj-url'
			"URL(u)
		NeoBundle 'saihoooooooo/vim-textobj-space'
			"連続したスペース(S) "-----<Space>とかsにリマップするかも
	"for vim-operator
		NeoBundle 'kana/vim-operator-replace.git'
		NeoBundle 'kana/vim-operator-user.git'
		NeoBundle 'emonkak/vim-operator-sort'
	"for C++
		NeoBundle 'osyo-manga/vim-stargate'
			"include文の補助
		NeoBundleLazy 'vim-jp/cpp-vim', {
		\	'autoload' : {'filetypes' : 'cpp'}
		\}
		NeoBundleLazy 'Rip-Rip/clang_complete', {
		\	'autoload' : {'filetypes' : ['c', 'cpp']}
		\}
		NeoBundleLazy 'rhysd/vim-clang-format', {
        \	'autoload' : {'filetypes' : ['c', 'cpp', 'objc']}
        \}
		NeoBundle 'jceb/vim-hier'
			"quickfixの該当箇所に破線
		NeoBundle 'tpope/vim-rails'
		NeoBundle 'vim-scripts/ruby-matchit'
		NeoBundle 'todesking/ruby_hl_lvar.vim'
		NeoBundle 'alpaca-tc/alpaca_english.git'
		NeoBundle 'scrooloose/syntastic'
	"カラースキーム
		NeoBundle 'tomasr/molokai'
		NeoBundle 'nanotech/jellybeans.vim'
		NeoBundle 'altercation/vim-colors-solarized'
		NeoBundle 'vim-scripts/newspaper.vim'
	"おまじない
		filetype indent plugin on
"}}}

" for cpp {{{
	augroup cpp-path
		autocmd!
		autocmd FileType cpp setlocal path=.,/usr/local/include,/usr/include/x86_64-linux-gnu,/usr/include,/usr/include/clang/3.3/include/
	"-----あとでなんとかする
	augroup END

	command Gdb !clang++ -g4 -O0 -std=c++11 -ID:/home/cpp/boost/boost_1_55_0 % && gdb a.out
" }}}

" for python {{{
	autocmd FileType python call s:python_tabsetting()
	function! s:python_tabsetting()
	    "setlocal shiftwidth=4
		setlocal tabstop=8
		"setlocal softtabstop=4
		"setlocal expandtab
	endfunction
" }}}

"for colorscheme {{{
	set background=dark
	colorscheme solarized
"}}}

"for vinarise.vim {{{
	"バイナリファイルオープン時に自動で有効化
		let g:vinarise_enable_auto_detect = 1
"}}}

"for Unite.vim {{{
	" 入力モードで開始する
		let g:unite_enable_start_insert=1

	" fuzzy-matchを有効に
	call unite#filters#matcher_default#use(['matcher_fuzzy'])
	let g:unite_matcher_fuzzy_max_input_length = 1/0

	" バッファ一覧
		noremap <C-U><C-B> :Unite buffer<CR>
	" ファイル一覧
		noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
	" 最近使ったファイルの一覧
		noremap <C-U><C-R> :Unite file_mru<CR>
	" ファイル一覧(再帰)
		noremap <C-U><C-R><C-R> :Unite -start-insert file_rec/async<CR>
	" レジスタ一覧
		noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
	" ファイルとバッファ
		noremap <C-U><C-U> :Unite buffer file_mru<CR>
	" 全部
		noremap <C-U><C-A> :UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
	" アウトライン
		noremap <C-U><C-O> :Unite outline<CR>
	" カラースキーム
		noremap <C-U><C-C> :Unite colorscheme -auto-preview<CR>
	" git grep
		noremap <C-U><C-G><C-G> :Unite vcs_grep<CR>
	" gist
		noremap <C-U><C-G><C-H> :Unite gist<CR>
	" quicklearn
		noremap <C-U>q :Unite quicklearn -immediately<CR>
	" Included files on cpp code
		noremap <C-U><C-I> :Unite file_include<CR>
	" snipet edit
		noremap <C-U><C-S><C-E> :NeoSnippetEdit -split -vertical<CR>
	" snipet edit
		noremap <C-U><C-S><C-E><C-L> :Unite neosnippet/user<CR>
	" snipet edit
		noremap <C-U><C-S><C-G><C-E> :NeoSnippetEdit -runtime -split -vertical<CR>
	" snipet edit
		noremap <C-U><C-S><C-G><C-E><C-L> :Unite neosnippet/runtime<CR>
	" snippet
		noremap <C-U><C-S> :Unite neosnippet<CR>
	" english_dictionary
		noremap <C-U><C-D><C-E> :Unite english_dictionary<CR>
	" english_example
		noremap <C-U><C-D><C-E><C-E> :Unite english_example<CR>
	" english_thesaurus
		noremap <C-U><C-D><C-E><C-R> :Unite english_thesaurus<CR>

	" Unite内でのマッピング
		autocmd FileType unite call s:unite_my_settings()
		function! s:unite_my_settings()
			" ESCキーを2回押すと終了する
				nmap <buffer> <ESC><ESC> <Plug>(unite_exit)
				imap <buffer> <ESC><ESC> <ESC><Plug>(unite_exit)
			" C-Wで一階層上に
				imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
				nmap <buffer> <C-w> <Plug>(unite_delete_backward_path)
		endfunction
"}}}

"for indentline.vim {{{
	let g:indentLine_color_term = 111
	let g:indentLine_color_gui = '#708090'
	let g:indentLine_char = '¦'
	set list listchars=tab:\¦\
"}}}

" for gist.vim {{{
	"If you want to manipulate multiple files in a gist:
		let g:gist_get_multiplefile = 1
	"If you want your gist to be private by default:
		let g:gist_post_private = 1
	"If you want to show your private gists with ":Gist -l":
		let g:gist_show_privates = 1
	"If you want to detect filetype from the filename:
		let g:gist_detect_filetype = 1
"}}}

" for over.vim {{{
	" カーソル下の単語をハイライト付きで置換
		nnoremap <C-F> :OverCommandLine<CR>/<C-r><C-w>
	" カーソル下の単語をハイライト付きで置換
		nnoremap <C-H> :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
	" コピーした文字列をハイライト付きで置換
		nnoremap <C-H><C-P> y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>
	" 0 以外が設定されていれば :/ or :? 時にそのパータンをハイライトする。
		let g:over#command_line#search#enable_incsearch = 1
	" 0 以外が設定されていれば :/ or :? 時にそのパータンへカーソルを移動する。
		let g:over#command_line#search#enable_move_cursor = 1
" }}}

" for quickhl.vim {{{
	nmap <C-M> <Plug>(quickhl-manual-this)
	xmap <C-M> <Plug>(quickhl-manual-this)
	nmap <C-M><C-R> <Plug>(quickhl-manual-reset)
	xmap <C-M><C-R> <Plug>(quickhl-manual-reset)
"}}}

" underline the word is under the cursor (http://d.hatena.ne.jp/osyo-manga/20140121/1390309901) {{{
	"-----機能してない。謎。gvimじゃないから？
	" 1 が設定されていれば有効になる
	let g:enable_highlight_cursor_word = 1
	" let g:enable_highlight_cursor_word = 1

	augroup highlight-cursor-word
		autocmd!
		autocmd CursorMoved * call s:hl_cword()
		" カーソル移動が重くなったと感じるようであれば
		" CursorMoved ではなくて
		" CursorHold を使用する
		" autocmd CursorHold * call s:hl_cword()
		" 単語のハイライト設定
		autocmd ColorScheme * highlight CursorWord guifg=Red
		" アンダーラインでハイライトを行う場合
		"autocmd ColorScheme * highlight CursorWord gui=underline guifg=NONE
		autocmd BufLeave * call s:hl_clear()
		autocmd WinLeave * call s:hl_clear()
		autocmd InsertEnter * call s:hl_clear()
	augroup END

	function! s:hl_clear()
		if exists("b:highlight_cursor_word_id") && exists("b:highlight_cursor_word")
		silent! call matchdelete(b:highlight_cursor_word_id)
		unlet b:highlight_cursor_word_id
		unlet b:highlight_cursor_word
		endif
	endfunction

	function! s:hl_cword()
		let word = expand("<cword>")
		if    word == ""
		return
		endif
		if get(b:, "highlight_cursor_word", "") ==# word
		return
		endif

		call s:hl_clear()
		if !g:enable_highlight_cursor_word
		return
		endif

		if !empty(filter(split(word, '\zs'), "strlen(v:val) > 1"))
		return
		endif

		let pattern = printf("\\<%s\\>", expand("<cword>"))
		silent! let b:highlight_cursor_word_id = matchadd("CursorWord", pattern)
		let b:highlight_cursor_word = word
	endfunction
" }}}

" for yankround.vim {{{
	"" キーマップ
	nmap p <Plug>(yankround-p)
	nmap P <Plug>(yankround-P)
	nmap <C-n> <Plug>(yankround-prev)
	nmap <C-p> <Plug>(yankround-next)
	"" 履歴取得数
	let g:yankround_max_history = 50
"}}}

" for anzu.vim {{{
	" n や N の代わりに使用します。
	nmap n <Plug>(anzu-n)
	nmap N <Plug>(anzu-N)
	nmap * <Plug>(anzu-star)
	nmap # <Plug>(anzu-sharp)
	" ステータス情報を statusline へと表示する
	" set statusline=%{anzu#search_status()}
	"上で定義済み

	" こっちを使用すると
	" 移動後にステータス情報をコマンドラインへと出力を行います。
	" statusline を使用したくない場合はこっちを使用して下さい。
	" nmap n <Plug>(anzu-n-with-echo)
	" nmap N <Plug>(anzu-N-with-echo)
	" nmap * <Plug>(anzu-star-with-echo)
	" nmap # <Plug>(anzu-sharp-with-echo)
"}}}

" for stargate.vim {{{
let g:stargate#include_paths = {
\   "cpp" : [
\   ]
\}
"}}}

" for snowdrop.vim {{{
	" Enable code completion in neocomplete.vim.
	let g:neocomplete#sources#snowdrop#enable = 1
	" Not skip
	let g:neocomplete#skip_auto_completion_time = ""
	if has('balloon_eval')
		function! s:cpp()
		    setlocal balloonexpr=snowdrop#ballonexpr_typeof()
		    setlocal ballooneval
		endfunction

		augroup my-cpp
		    autocmd!
		    autocmd FileType cpp call s:cpp()
		augroup END
	endif
" }}}

" for caw.vim {{{
	nmap gcw <Plug>(caw:wrap:comment)
	vmap gcw <Plug>(caw:wrap:comment)
" }}}

" for neocomplete and clang_complete {{{
	" 補完を有効にする
	let g:neocomplete#enable_at_startup = 1
	" 補完に時間がかかってもスキップしない
	let g:neocomplete#skip_auto_completion_time = ""
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
	"補完候補の共通文字列を補完する(シェル補完のような動作)
		inoremap <expr><C-l> neocomplete#complete_common_string()

	if !exists('g:neocomplete#force_omni_input_patterns')
		let g:neocomplete#force_omni_input_patterns = {}
	endif
	let g:neocomplete#force_overwrite_completefunc = 1
	let g:neocomplete#force_omni_input_patterns.c =
	\    '[^.[:digit:] *\t]\%(\.\|->\)\w*'
	let g:neocomplete#force_omni_input_patterns.cpp =
	\    '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
	let g:neocomplete#force_omni_input_patterns.objc =
	\    '[^.[:digit:] *\t]\%(\.\|->\)\w*'
	let g:neocomplete#force_omni_input_patterns.objcpp =
	\    '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

	autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	let g:neocomplete#force_omni_input_patterns.ruby =
	\ '[^. *\t]\.\w*\|\h\w*::'

	autocmd FileType python setlocal omnifunc=jedi#completions
	let g:jedi#completions_enabled = 0
	let g:jedi#auto_vim_configuration = 0
	let g:neocomplete#force_omni_input_patterns.python =
	\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

	" コマンドオプション
	let g:clang_user_options = '-std=c++11'
	" clang_complete では自動補完を行わない用に設定
	let g:clang_complete_auto = 0
	let g:clang_auto_select = 0
	let g:clang_use_library = 1
	"-----this need to be updated on llvm update
	"let g:clang_library_path = '/usr/lib/llvm-3.0/lib'

	" Plugin key-mappings.
	imap <C-k>     <Plug>(neosnippet_expand_or_jump)
	smap <C-k>     <Plug>(neosnippet_expand_or_jump)

	" スニペットを展開するキーマッピング
	" <Tab> で選択されているスニペットの展開を行う
	" 選択されている候補がスニペットであれば展開し、
	" それ以外であれば次の候補を選択する
	" また、既にスニペットが展開されている場合は次のマークへと移動する
	imap <expr><Tab> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)"
	\: pumvisible() ? "\<C-n>" : "\<TAB>"
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)"
	\: "\<TAB>"
	imap <expr><S-Tab>  pumvisible() ? "\<C-P>" : "\<S-TAB>"

	imap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
	smap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
	imap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
	smap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"

	" オムニ補完の手動呼び出し
		inoremap <expr><C-Space> neocomplete#start_manual_complete()
	" 補完候補の共通文字列補完
		inoremap <expr><C-l> neocomplete#complete_common_string()

	" For snippet_complete marker.
	if has('conceal')
	  set conceallevel=2 concealcursor=i
	endif
	" スニペットファイルの保存ディレクトリを設定
	let g:neosnippet#snippets_directory = "~/.neosnippet"
" }}}

" for quickrun.vim {{{
	" 出力先
	" 成功した場合：quickrun 専用の出力バッファ
	" 失敗した場合：quickfix を :copen で開く
	" バッファの開き方：botright 8sp
	"
	" cpp.type にて使用するコンパイラなどを設定する
	" cpp.cmdopt にコマンドラインオプションを設定
	let g:quickrun_config = {
	\   "_" : {
	\       "outputter" : "error",
	\       "outputter/error/success" : "buffer",
	\       "outputter/error/error"   : "quickfix",
	\       "outputter/buffer/split" : ":botright 8sp",
	\       "outputter/quickfix/open_cmd" : "copen",
	\       "runner" : "vimproc",
	\       "runner/vimproc/updatetime" : 500,
	\       'hook/u_nya_/enable' : 1,
	\   },
	\   "cpp" : {
	\       "type" : "cpp/clang++",
	\       "cmdopt" : "-std=c++11 --stdlib=libc++ -ID:/home/cpp/boost/boost_1_55_0",
	\   },
	\   "watchdogs_checker/_" : {
	\       "hook/close_quickfix/enable_success" : 1,
	\   },
	\}

	" :QuickRun 時に quickfix の中身をクリアする
	" こうしておかないと quickfix の中身が残ったままになってしまうため
	let s:hook = {
	\   "name" : "clear_quickfix",
	\   "kind" : "hook",
	\}

	function! s:hook.on_normalized(session, context)
	    call setqflist([])
	endfunction

	call quickrun#module#register(s:hook, 1)
	unlet s:hook
" }}}

" for watchdogs.vim {{{
" http://d.hatena.ne.jp/osyo-manga/20120924/1348473304
	" g:quickrun_config に設定を追加
	call watchdogs#setup(g:quickrun_config)

	" 保存後にシンタックスチェックを行う
	let g:watchdogs_check_BufWritePost_enable = 1
" }}}

" for vim-altr {{{
	nmap <C-J>  <Plug>(altr-forward)
" }}}

" for ctrlp.vim {{{
	let g:ctrlp_use_migemo = 1
	let g:ctrlp_map = '<C-U><C-P>'
	let g:ctrlp_show_hidden = 1 "Set this to 1 if you want CtrlP to scan for dotfiles and dotdirs
	let g:ctrlp_jump_to_buffer      = 2 " タブで開かれていた場合はそのタブに切り替える
	"let g:ctrlp_clear_cache_on_exit = 0 " 終了時キャッシュをクリアしない
	let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
	let g:ctrlp_highlight_match     = [1, 'IncSearch'] " 絞り込みで一致した部分のハイライト
	let g:ctrlp_open_multi          = '10t' " 複数ファイルを開く時にタブで最大10まで開く
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_custom_ignore = {
	\	'dir':  '\v[\/]\.?(extlib|git|hg|svn)$',
	\}
" }}}

" for vim-operator {{{
	map <C-C><C-R>  <Plug>(operator-replace)
	map <C-C><C-S>  <Plug>(operator-sort)
" }}}

" for vim-textobj-between.vim {{{
	let g:textobj_between_no_default_key_mappings = 1
	NeoBundleSource 'vim-textobj-between'
	vmap ai <Plug>(textobj-between-a)
	vmap ii <Plug>(textobj-between-i)
	omap ai <Plug>(textobj-between-a)
	omap ii <Plug>(textobj-between-i)
" }}}

" for syntastic {{{
	let g:syntastic_enable_signs=1
	let g:syntastic_auto_loc_list=2
	if executable("clang++")
		let g:syntastic_cpp_compiler = 'clang++'
		let g:syntastic_cpp_compiler_options = '--std=c++11 -stdlib=libc++'
	endif
" }}}

" for vim-ref {{{
	let g:ref_use_vimproc=1
	let g:ref_refe_version=2
	let g:ref_refe_encoding = 'utf-8'
" }}}

"http://rhysd.hatenablog.com/entry/2013/12/10/233201
"vim-powerlineとかsmartchrとか
"unite-rails,AlpacaTags辺りは後々考える
