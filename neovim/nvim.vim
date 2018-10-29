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
	set colorcolumn=100
	" Indents word-wrapped lines as much as the 'parent' line
	set breakindent
	set breakindentopt=shift:4,sbr
	" Ensures word-wrap does not split words
	set formatoptions+=l
	set lbr
	set background=dark

" Mapping
	" NERDTree mapping to C-n
	map <C-n> :NERDTreeToggle<CR>
	" Fzf.vim
	nnoremap <leader>r :History<CR>
	nnoremap <leader>b :Buffers<CR>
	nnoremap <leader>t :Files<CR>
	" Folding
	nnoremap <space> za
	vnoremap <space> zf
	" Center cursor
	nnoremap n nzzzv
	nnoremap N Nzzzv
	nnoremap <leader>z zMzvzz
	" Copy
	nnoremap <leader>y "+y
	vnoremap <leader>y "+y
	nnoremap <leader>p "+p
	vnoremap <leader>p "+p

	nnoremap <CR> :nohl<CR><C-l>:echo "Search Cleared"<CR>

	noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
	noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" Plugins
	call plug#begin('~/.local/share/nvim/plugged')
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-commentary'
	Plug 'mhinz/vim-signify'
	Plug 'junegunn/fzf', {'dir': '~/.fzf/', 'do': './install -all'}
	Plug 'junegunn/fzf.vim'
	Plug 'itchyny/lightline.vim'
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
	" Python 
	Plug 'davidhalter/jedi-vim'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zchee/deoplete-jedi'
	Plug 'w0rp/ale'
	Plug 'julienr/vim-cellmode'
	Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}


	Plug 'Shougo/echodoc.vim'
	Plug 'ervandew/supertab'
	Plug 'wellle/tmux-complete.vim'
	Plug 'raimondi/delimitmate'
	Plug 'yggdroot/indentline'
	Plug 'sirver/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'christoomey/vim-tmux-navigator'
	" Visual
	Plug 'flazz/vim-colorschemes'
	Plug 'sheerun/vim-polyglot'
	Plug 'tmhedberg/SimpylFold'
	Plug 'yuttie/comfortable-motion.vim'
	" Tmux 
	Plug 'tmux-plugins/vim-tmux'
	call plug#end()

" Plugins config
	let g:SuperTabDefaultCompletionType = "<c-n>"
	let g:jedi#completions_enabled = 0
	let g:jedi#use_tabs_not_buffers = 1
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#sources#jedi#show_docstring = 1
	let g:SimpylFold_docstring_preview = 1
	let g:ale_linters = {'python': ['pylint', 'pyls']}
	let g:ale_fix_on_save = 0
	let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],
	\ 					'python': ['isort', 'yapf']}
	let g:ale_completion_enabled = 1
	let g:cellmode_tmux_panenumber='2'
	let g:comfortable_motion_scroll_down_key = "j"
	let g:comfortable_motion_scroll_up_key = "k"
	let g:indentLine_enabled = 1
	let g:indentLine_setColors = 1
	colo dracula 
