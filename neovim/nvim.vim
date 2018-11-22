" Automatically install Vim Plug
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" General nvim settings
	let mapleader=","
	set tabstop=4
	set shiftwidth=4
	set dir='/tmp/,~/tmp,/var/tmp,.'
	set relativenumber number
	set foldmethod=indent
	set hidden
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
	set background=dark

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

	" Signify - Git sign bar
    nnoremap <leader>gt :SignifyToggle<CR>
    nnoremap <leader>gh :SignifyToggleHighlight<CR>
    nnoremap <leader>gr :SignifyRefresh<CR>
    nnoremap <leader>gd :SignifyDebug<CR>
    nmap <leader>gj <plug>(signify-next-hunk)
    nmap <leader>gk <plug>(signify-prev-hunk)
	map <C-n> :NERDTreeToggle<CR>
	" Fzf.vim
	nnoremap <leader>r :History<CR>
	nnoremap <leader>b :Buffers<CR>
	nnoremap <leader>t :Files<CR>
	" Semshi
	nmap <silent> <leader>c :Semshi goto class next<CR>
	nmap <silent> <leader>C :Semshi goto class prev<CR>
	nmap <silent> <leader>f :Semshi goto function next<CR>
	nmap <silent> <leader>F :Semshi goto function prev<CR>
	nmap <silent> <leader>ee :Semshi error<CR>
	nmap <silent> <leader>ge :Semshi goto error<CR>

	noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
	noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" Plugins
	call plug#begin('~/.local/share/nvim/plugged')
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-commentary'
	Plug 'mhinz/vim-signify'

	Plug 'junegunn/fzf', {'dir': '~/.fzf/', 'do': './install -all'}
	Plug 'junegunn/fzf.vim'
	Plug 'itchyny/lightline.vim'
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'wellle/tmux-complete.vim'
	Plug 'ervandew/supertab'

	" Python 
	Plug 'davidhalter/jedi-vim'
	Plug 'zchee/deoplete-jedi'
	Plug 'w0rp/ale'
	Plug 'julienr/vim-cellmode'
	Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
	Plug 'tmhedberg/SimpylFold'

	Plug 'Shougo/echodoc.vim'
	Plug 'raimondi/delimitmate'
	Plug 'sirver/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tmux-plugins/vim-tmux'

	" Visual
	Plug 'yggdroot/indentline'
	Plug 'flazz/vim-colorschemes'
	Plug 'sheerun/vim-polyglot'
	Plug 'yuttie/comfortable-motion.vim'

	call plug#end()

" Plugins config
	let g:SuperTabDefaultCompletionType = "<c-n>"
	let g:signify_vcs_list = ['git']
	let g:signify_update_on_focusgained = 1
    let g:signify_cursorhold_insert     = 1
    let g:signify_cursorhold_normal     = 1

	let g:jedi#completions_enabled = 0
	let g:jedi#use_split_not_buffers = "bottom"
	let g:jedi#show_call_signatures = 1
	let g:show_call_signatures_delay = 0

	let g:deoplete#enable_at_startup = 1
	let g:deoplete#sources#jedi#show_docstring = 0

	let g:SimpylFold_docstring_preview = 1

	let g:ale_linters = {'python': ['pylint', 'pyls']}
	let g:ale_completion_enabled = 1
	let g:ale_set_highlights = 0
	let g:ale_fix_on_save = 0
	let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],
	\ 					'python': ['isort', 'yapf']}

	let g:cellmode_tmux_panenumber='1'

	let g:comfortable_motion_scroll_down_key = "j"
	let g:comfortable_motion_scroll_up_key = "k"

	let g:indentLine_enabled = 1
	let g:indentLine_setColors = 1
	colo dracula 
