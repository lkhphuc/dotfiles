" Automatically install Vim Plug
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" General nvim settings
    lang en_US.UTF-8
	let mapleader=" "
	set hidden
	set noshowmode
	set mouse=a
	set dir='/tmp/,~/tmp,/var/tmp,.'
    set path+=**
	" Tab and indent
	set expandtab tabstop=4
	set shiftwidth=4
	set foldmethod=indent
	set relativenumber number
    set signcolumn=yes
	set cursorline
	set sidescroll=1
	set conceallevel=0
	set colorcolumn=88
	set breakindent
	set breakindentopt=shift:2,sbr
	set lbr formatoptions+=l " Ensures word-wrap does not split words
	set ignorecase smartcase
    set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
    set shortmess+=c " don't give |ins-completion-menu| messages.
    " Show trailing whitepace and spaces before a tab:
    :highlight ExtraWhitespace ctermbg=red guibg=red
    :autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
    " Enable persistent undo so that undo history persists across vim sessions
    set undofile
    set undodir=~/.vim/undo

call plug#begin('~/.local/share/nvim/plugged')
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-eunuch'
	Plug 'junegunn/fzf', {'dir': '~/.fzf/', 'do': './install -all'}
	Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'machakann/vim-sandwich'
	Plug 'yuttie/comfortable-motion.vim'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'metakirby5/codi.vim'
    Plug 'romainl/vim-cool'  "Handle highlight search automatically
    Plug 'simnalamburt/vim-mundo'
    " Tmux
	Plug 'christoomey/vim-tmux-navigator'
    Plug 'tmux-plugins/vim-tmux-focus-events'
	Plug 'wellle/tmux-complete.vim'  "Completion suggest from adjacent tmux-panes
    " Completion
    Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
	Plug 'honza/vim-snippets'
    Plug 'liuchengxu/vista.vim'
    Plug 'jpalardy/vim-slime'
    Plug 'jph00/swift-apple'
    Plug 'lervag/vimtex'
	" Visual
	Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    Plug 'Yggdroot/indentLine'
    Plug 'szw/vim-maximizer'
	Plug 'itchyny/lightline.vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'ryanoasis/vim-devicons'
	Plug 'arcticicestudio/nord-vim'
    Plug 'junegunn/seoul256.vim'
    Plug 'dracula/vim', {'name':'dracula'}
call plug#end()

" Fzf.vim
	nnoremap <leader>h :History<CR>
	nnoremap <leader>b :Buffers<CR>
	nnoremap <leader>t :Files<CR>
    nnoremap <leader>gf :GitFiles<CR>
    nnoremap <leader>l :Lines<CR>
	nnoremap <leader>a :Ag<CR>
    nnoremap <leader>rg :Rg<CR>
" Comfortable motion
	let g:comfortable_motion_scroll_down_key = "j"
	let g:comfortable_motion_scroll_up_key = "k"
	noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
	noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
" Coc
    let g:coc_global_extensions = [
                \ "coc-python", "coc-ccls", "coc-json", "coc-vimtex", 
                \ "coc-tabnine", "coc-git", "coc-syntax", "coc-snippets", "coc-emoji",
                \ "coc-highlight", "coc-pairs", "coc-smartf", "coc-explorer",
                \ "coc-marketplace"]
    nmap <leader>CC :CocCommand<CR>
    nmap <leader>CL :CocList<CR>
    nmap <leader>CF :CocConfig<CR>
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)
    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> g[ <Plug>(coc-declaration)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> ge :CocCommand explorer<CR>
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)
    " Remap for format selected region
    vmap <leader>cf  <Plug>(coc-format-selected)
    nmap <leader>cf  <Plug>(coc-format-selected)
    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end
    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    vmap <leader>ca  <Plug>(coc-codeaction-selected)
    nmap <leader>ca  <Plug>(coc-codeaction-selected)
    " Remap for do codeAction of current line
    nmap <leader>caa  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>cqf  <Plug>(coc-fix-current)
    " Use `:Format` for format current buffer
    command! -nargs=0 Format :call CocAction('format')
    " Coc K to show documentation
        function! s:show_documentation()
          if &filetype == 'vim'
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction
        nnoremap <silent> K :call <SID>show_documentation()<CR>
    " Use tab for trigger completion, completion confirm, snippets expand and jump
        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction
        inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
        inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
        let g:coc_snippet_next = '<tab>'
        " imap <C-j> <Plug>(coc-snippets-expand-jump)
    " Smart f, press <esc> to cancel.
        nmap f <Plug>(coc-smartf-forward)
        nmap F <Plug>(coc-smartf-backward)
        nmap ; <Plug>(coc-smartf-repeat)
        nmap , <Plug>(coc-smartf-repeat-opposite)

        augroup Smartf
          autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
          autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
        augroup end
    "Git
        nmap [g <plug>(coc-git-prevchunk)
        nmap ]g <plug>(coc-git-nextchunk)
        nmap gs <plug>(coc-git-chunkinfo)
        nmap gC <plug>(coc-git-commit)
        " create text object for git chunks
        omap ig <Plug>(coc-git-chunk-inner)
        xmap ig <Plug>(coc-git-chunk-inner)
        omap ag <Plug>(coc-git-chunk-outer)
        xmap ag <Plug>(coc-git-chunk-outer)
" Vim Slime
    let g:slime_target = 'tmux'
    let g:slime_python_ipython = 1
" Tex
    let g:vimtex_compiler_progname = 'nvr'
" Lightline
	let g:lightline = {
        \ 'colorscheme': 'nord',
		\ 'component': {
		\ },
		\ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'readonly', 'filename', 'modified'] ],
		\   'right': [ [ 'percent' ,'lineinfo' ],
		\              [ 'fileencoding', 'filetype', 'fugitive' ],
        \              [ 'cocstatus'] ]
		\ },
		\ 'component_function': {
        \   'cocstatus': 'LightlineCocStatus',
		\   'readonly': 'LightlineReadonly',
		\   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
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
    function! LightlineCocStatus()
        let status = coc#status()
        let env = matchstr(status, "(\'.*\':")[2:-3]
        return winwidth(0) > 120 ? status : env
    endfunction
" Theme
	set background=dark
	colorscheme nord
    highlight Comment cterm=italic
" Mundo
    let g:mundo_right = 1
" Mapping
    noremap <F9> :CocCommand explorer<CR>
    noremap <F8> :Vista!!<CR>
    noremap <F7> :MundoToggle<CR>
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
    nnoremap <silent><C-w>m :MaximizerToggle<CR>
    vnoremap <silent><C-w>m :MaximizerToggle<CR>gv
    inoremap <silent><C-w>m <C-o>:MaximizerToggle<CR>
	nnoremap <leader>z za
    " Copy
	nnoremap <leader>y "+y
	vnoremap <leader>y "+y
	nnoremap <leader>p "+p
	vnoremap <leader>p "+p
    tnoremap <Esc> <C-\><C-n>
