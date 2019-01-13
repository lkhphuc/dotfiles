" Automatically install Vim Plug
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" General nvim settings
	let mapleader=","
	set hidden
	set dir='/tmp/,~/tmp,/var/tmp,.'
	set tabstop=4
	set shiftwidth=4
	set foldmethod=indent
	set relativenumber number
	set cursorline
	set sidescroll=1
	set noshowmode 
	set conceallevel=0
	set colorcolumn=80
	" Indents word-wrapped lines as much as the 'parent' line
	set breakindent
	set breakindentopt=shift:4,sbr
	" Ensures word-wrap does not split words
	set formatoptions+=l
	set lbr

" Plugins
	call plug#begin('~/.local/share/nvim/plugged')
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-abolish'

	Plug 'junegunn/fzf', {'dir': '~/.fzf/', 'do': './install -all'}
	Plug 'junegunn/fzf.vim'
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
	Plug 'yuttie/comfortable-motion.vim'

	Plug 'ervandew/supertab'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'wellle/tmux-complete.vim'
	Plug 'Shougo/echodoc.vim'
	Plug 'sirver/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'raimondi/delimitmate'
	
	Plug 'gabrielelana/vim-markdown'

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

	call plug#end()

" Plugins config
	" Fzf.vim
		nnoremap <leader>r :History<CR>
		nnoremap <leader>b :Buffers<CR>
		nnoremap <leader>t :Files<CR>

	map <C-n> :NERDTreeToggle<CR>
	let g:SuperTabDefaultCompletionType = "<c-n>"

	" Comfortable motion
		let g:comfortable_motion_scroll_down_key = "j"
		let g:comfortable_motion_scroll_up_key = "k"
		noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
		noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

	" Completion
		let g:deoplete#enable_at_startup = 1
		let g:deoplete#sources#jedi#show_docstring = 0
		let g:jedi#completions_enabled = 0
		let g:jedi#use_split_not_buffers = "bottom"
		" let g:jedi#show_call_signatures = 1
		let g:echodoc#enable_at_startup = 1

	" ALE
		let g:ale_linters = {'python': ['pylint', 'pyls']}
		let g:ale_set_highlights = 0
		let g:ale_fix_on_save = 0
		let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['isort', 'yapf']}

	" Python
		let g:cellmode_tmux_panenumber='1'
		let g:SimpylFold_docstring_preview = 1
		nmap <silent> <leader>c :Semshi goto class next<CR>
		nmap <silent> <leader>C :Semshi goto class prev<CR>
		nmap <silent> <leader>f :Semshi goto function next<CR>
		nmap <silent> <leader>F :Semshi goto function prev<CR>
		nmap <silent> <leader>ee :Semshi error<CR>
		nmap <silent> <leader>ge :Semshi goto error<CR>

	" Signify - Git sign bar
		let g:signify_vcs_list = ['git']
		let g:signify_update_on_focusgained = 1
		let g:signify_cursorhold_insert     = 500
		let g:signify_cursorhold_normal     = 500
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
			\              [ 'fileformat', 'fileencoding', 'filetype', 'fugitive' ] ]
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
	autocmd FileType python setlocal completeopt-=preview
	" Folding
	nnoremap <space> za
	vnoremap <space> zf
	nnoremap <leader>z zMzvzz
	" Center cursor
	nnoremap n nzzzv
	nnoremap N Nzzzv
	" Copy
	nnoremap <leader>y "+y
	vnoremap <leader>y "+y
	nnoremap <leader>p "+p
	vnoremap <leader>p "+p

	nnoremap <esc> :noh<return><esc>
