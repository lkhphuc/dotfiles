" Automatically install Vim Plug
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" General nvim settings
	let mapleader=","
	set hidden
	set noshowmode 
	set mouse=a
	set dir='/tmp/,~/tmp,/var/tmp,.'
	" Tab and indent
	set expandtab
	set tabstop=4
	set shiftwidth=4
	set foldmethod=indent

	set relativenumber number
	set cursorline
	set sidescroll=1
	set conceallevel=0
	set colorcolumn=80
	" Indents word-wrapped lines as much as the 'parent' line
	set breakindent
	set breakindentopt=shift:4,sbr
	" Ensures word-wrap does not split words
	set formatoptions+=l
	set lbr
	" Search config
	set ignorecase smartcase

    " Show trailing whitepace and spaces before a tab:
    :highlight ExtraWhitespace ctermbg=red guibg=red
    :autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
	

call plug#begin('~/.local/share/nvim/plugged')
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'

	Plug 'junegunn/fzf', {'dir': '~/.fzf/', 'do': './install -all'}
	Plug 'junegunn/fzf.vim'
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
	Plug 'yuttie/comfortable-motion.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-fuzzy.vim'
    Plug 'michaeljsmith/vim-indent-object'

	Plug 'ervandew/supertab'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'wellle/tmux-complete.vim'
	Plug 'Shougo/echodoc.vim'
	Plug 'sirver/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'raimondi/delimitmate'
	
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
    Plug 'rhysd/vim-grammarous'

	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tmux-plugins/vim-tmux'

	" Python 
	Plug 'davidhalter/jedi-vim'
	Plug 'zchee/deoplete-jedi'
	Plug 'w0rp/ale'
	Plug 'julienr/vim-cellmode'
	Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
	Plug 'tmhedberg/SimpylFold'

	" Visual
	Plug 'itchyny/lightline.vim'
	Plug 'maximbaz/lightline-ale'
	Plug 'mhinz/vim-signify'
	Plug 'yggdroot/indentline'
	Plug 'sheerun/vim-polyglot'
	Plug 'dracula/vim', {'as': 'dracula'}
	Plug 'ryanoasis/vim-devicons'
call plug#end()

" Fzf.vim
	nnoremap <leader>h :History<CR>
	nnoremap <leader>b :Buffers<CR>
	nnoremap <leader>t :Files<CR>
	nnoremap <leader>a :Ag<CR>

map <C-n> :NERDTreeToggle<CR>
let g:SuperTabDefaultCompletionType = "<c-n>"

" Comfortable motion
	let g:comfortable_motion_scroll_down_key = "j"
	let g:comfortable_motion_scroll_up_key = "k"
	noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
	noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" EasyMotion
    let g:EasyMotion_do_mapping = 0
    map <Leader> <Plug>(easymotion-prefix)
    nmap f <Plug>(easymotion-overwin-f2)
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_use_smartsign_us = 1 " US layout
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
    map <Leader>l <Plug>(easymotion-lineforward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>h <Plug>(easymotion-linebackward)

" Incsearch + Fuzzy
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    " :h g:incsearch#auto_nohlsearch
    set hlsearch
    let g:incsearch#auto_nohlsearch = 1
    map n  <Plug>(incsearch-nohl-n) zv
    map N  <Plug>(incsearch-nohl-N) zv
    map *  <Plug>(incsearch-nohl-*) zv
    map #  <Plug>(incsearch-nohl-#) zv
    map g* <Plug>(incsearch-nohl-g*) zv
    map g# <Plug>(incsearch-nohl-g#) zv
    " Fuzzy
    map z/ <Plug>(incsearch-fuzzyspell-/)
    map z? <Plug>(incsearch-fuzzyspell-?)
    map zg/ <Plug>(incsearch-fuzzyspell-stay)

" Completion
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#sources#jedi#show_docstring = 0
	" to not block semshi
	let g:deoplete#auto_complete_delay = 100
	let g:echodoc#enable_at_startup = 1

	let g:jedi#completions_enabled = 0
	let g:jedi#show_call_signatures = "1"
	let g:jedi#use_split_not_buffers = "bottom"

" ALE
    " let g:loaded_python_provider = 1
    let g:ale_python_auto_pipenv = 1
	let g:ale_linters = {'python': ['flake8', 'mypy']}
	let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],
                \       'python': ['isort', 'black']}
    nmap <silent> <leader>ek <Plug>(ale_previous_wrap)
    nmap <silent> <leader>ej <Plug>(ale_next_wrap)

" Python
	let g:cellmode_tmux_panenumber='1'
	let g:SimpylFold_docstring_preview = 1
	autocmd FileType python nmap <silent> <leader>sr :Semshi rename<CR>
	autocmd FileType python nmap <silent> <leader>ss :Semshi goto name next<CR>
	autocmd FileType python nmap <silent> <leader>sS :Semshi goto name prev<CR>
	autocmd FileType python nmap <silent> <leader>sc :Semshi goto class next<CR>
	autocmd FileType python nmap <silent> <leader>sC :Semshi goto class prev<CR>
	autocmd FileType python nmap <silent> <leader>sf :Semshi goto function next<CR> zv
	autocmd FileType python nmap <silent> <leader>sF :Semshi goto function prev<CR> zv
	autocmd FileType python nmap <silent> <leader>se :Semshi goto error<CR>

" Signify - Git sign bar
	let g:signify_vcs_list = ['git']
	nnoremap <leader>gt :SignifyToggle<CR>
	nnoremap <leader>gh :SignifyToggleHighlight<CR>
	nnoremap <leader>gr :SignifyRefresh<CR>
	nnoremap <leader>gd :SignifyDebug<CR>
	nmap <leader>gj <plug>(signify-next-hunk)
	nmap <leader>gk <plug>(signify-prev-hunk)

" Lightline
	let g:lightline = {
		\ 'component': {
		\ },
		\ 'active': {
		\   'right': [ [ 'lineinfo' ],
		\              [ 'percent' ],
		 \             [ 'fileencoding', 'filetype', 'fugitive' ] ]
		\ },
		\ 'component_function': {
		\   'readonly': 'LightlineReadonly',
		\   'fugitive': 'LightlineFugitive',
		\ 	'filename': 'LightlineFilename',
		\ },
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' },
		\}

	function! LightlineReadonly()
		return &readonly ? '' : ''
	endfunction
	function! LightlineFugitive()
		if exists('*fugitive#head')
			let branch = fugitive#head()
			return branch !=# '' ? ''.branch : ''
		endif
		return ''
	endfunction
	function! LightlineFilename()
		let name = ""
		let subs = split(expand('%'), "/") 
		let i = 1
		for s in subs
			let parent = name
			if  i == len(subs)
				let name = parent . '/' . s
			elseif i == 1
				let name = s
			else
				let name = parent . '/' . strpart(s, 0, 2)
			endif
			let i += 1
		endfor
	  return name
	endfunction

" Indent Line
	let g:indentLine_enabled = 1
	let g:indentLine_setColors = 1
	let g:indentLine_setConceal = 0

" Theme
	colo dracula 
	set background=dark
	hi Normal guibg=NONE ctermbg=NONE

" Mapping
" autocmd FileType python setlocal completeopt-=preview

" Folding and cursors
	nnoremap <space> za
	vnoremap <space> zf
	nnoremap <leader>z zMzvzz
	nnoremap n nzzzv
	nnoremap N Nzzzv

" Copy
	nnoremap <leader>y "+y
	vnoremap <leader>y "+y
	nnoremap <leader>p "+p
	vnoremap <leader>p "+p

nnoremap <esc> :noh<return><esc>
