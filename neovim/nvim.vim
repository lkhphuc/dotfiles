"Automatically install Vim Plug
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
    set inccommand=nosplit
    set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
    set shortmess+=c " don't give |ins-completion-menu| messages.
    " Show trailing whitepace and spaces before a tab:
    :highlight ExtraWhitespace ctermbg=red guibg=red
    :autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
    " Enable persistent undo so that undo history persists across vim sessions
    set undofile
    set undodir=~/.vim/undo
" Mapping
	nnoremap <leader>z za
    nnoremap <leader><Tab> <C-^>
	nnoremap <leader>y "+y
	vnoremap <leader>y "+y
	nnoremap <leader>p "+p
	vnoremap <leader>p "+p

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'

Plug 'junegunn/fzf', {'dir': '~/.fzf/', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
    " Using floating windows of Neovim to start fzf
    if has('nvim')
      function! FloatingFZF()
        let width = float2nr(&columns * 0.9)
        let height = float2nr(&lines * 0.6)
        let opts = { 'relative': 'editor',
                   \ 'row': (&lines - height) / 2,
                   \ 'col': (&columns - width) / 2,
                   \ 'width': width,
                   \ 'height': height }

        let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
      endfunction
      let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'
      let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    endif
    nnoremap <leader>fh :History<CR>
    nnoremap <leader>fb :Buffers<CR>
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fg :GitFiles?<CR>
    nnoremap <leader>fl :Lines<CR>
    nnoremap <leader>ft :Tags<CR>
    nnoremap <leader>fm :Marks<CR>
    nnoremap <leader>fw :Windows<CR>
    nnoremap <leader>fc :Commits<CR>
    nnoremap <leader>fa :Ag<CR>
    nnoremap <leader>fr :Rg<CR>
    let g:fzf_commits_log_options = '--graph --color=always --pretty --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

Plug 'junegunn/vim-easy-align'
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

Plug 'machakann/vim-sandwich'
Plug 'yuttie/comfortable-motion.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'metakirby5/codi.vim'
Plug 'szw/vim-maximizer'
    nnoremap <silent><C-w>m :MaximizerToggle<CR>
    vnoremap <silent><C-w>m :MaximizerToggle<CR>gv
    inoremap <silent><C-w>m <C-o>:MaximizerToggle<CR>

Plug 'kassio/neoterm'  "TODO Config shortcut
    " Terminal mode
    tnoremap <leader><Esc> <C-\><C-n>
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l
    tnoremap <leader><Tab> <C-\><C-n><C-^>

Plug 'jpalardy/vim-slime'  "Send to tmux
    let g:slime_target = 'tmux'
    let g:slime_python_ipython = 1

Plug 'janko/vim-test'
    " these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
    nmap <silent> t<C-n> :TestNearest<CR>
    nmap <silent> t<C-f> :TestFile<CR>
    nmap <silent> t<C-s> :TestSuite<CR>
    nmap <silent> t<C-l> :TestLast<CR>
    nmap <silent> t<C-g> :TestVisit<CR>

Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'wellle/tmux-complete.vim'  "Completion suggest from adjacent tmux-panes

Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
    " Use tab for trigger completion, completion confirm
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
        imap <C-j> <Plug>(coc-snippets-expand-jump)
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
    noremap <F9> :CocCommand explorer<CR>

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'liuchengxu/vista.vim'
    noremap <F8> :Vista!!<CR>

Plug 'simnalamburt/vim-mundo'
    let g:mundo_right = 1
    noremap <F7> :MundoToggle<CR>

Plug 'jph00/swift-apple'

Plug 'lervag/vimtex'
    let g:vimtex_compiler_progname = 'nvr'

" Visual
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Yggdroot/indentLine'
Plug 'machakann/vim-highlightedyank'
Plug 'romainl/vim-cool'  "Handle highlight search automatically

Plug 'itchyny/lightline.vim'
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

Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/seoul256.vim'
Plug 'dracula/vim', {'name':'dracula'}

call plug#end()

" Theme
    set background=dark
    colorscheme nord
    highlight Comment cterm=italic
