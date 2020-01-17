if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  "Automatically install Vim Plug
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
  " Visual
  set relativenumber number
  set signcolumn=yes
  set cursorline
  set termguicolors
  " set expandtab
  " set tabstop=2
  " set shiftwidth=2
  set foldmethod=indent
  set sidescroll=1
  set conceallevel=0
  set colorcolumn=80
  set breakindent
  set breakindentopt=shift:4,sbr
  set lbr formatoptions+=l " Ensures word-wrap does not split words
  set ignorecase smartcase
    set inccommand=nosplit
    set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
    set shortmess+=c " don't give |ins-completion-menu| messages.
    " Enable persistent undo so that undo history persists across vim sessions
    set undofile
    set undodir=~/.vim/undo
" Mapping
  nnoremap <leader><space> za
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  nnoremap <leader>p "+p
  vnoremap <leader>p "+p
    " Windows
    nnoremap <leader>ww <C-W>w
    nnoremap <leader>wq <C-W>q
    nnoremap <leader>ws <C-W>s
    nnoremap <leader>wv <C-W>v
    tnoremap <leader>ww <C-\><C-n><C-w>w
    tnoremap <leader>wq <C-\><C-n><C-w>q
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    tnoremap <C-w><C-w> <C-\><C-n><C-w>w
    " Buffers
    tnoremap <leader>bb <C-\><C-n><C-^>
    nnoremap <leader>bb <C-^>
    nnoremap <leader>bn :bnext<CR>
    nnoremap <leader>bp :bprevious<CR>
    nnoremap <leader>bd :bdelete<CR>
    " Tabs
    if !exists('g:lasttab')
      let g:lasttab = 1
    endif
    au TabLeave * let g:lasttab = tabpagenr()
    tnoremap <leader><Tab> <C-\><C-n> :exe "tabn ".g:lasttab<CR>
    nmap <Leader><TAB> :exe "tabn ".g:lasttab<CR>
    " Terminal mode
    tnoremap <leader><Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
    tnoremap kj <C-\><C-n>

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'  "One plugin everything tab indent

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
    nnoremap <leader>fgf :GitFiles?<CR>
    nnoremap <leader>fgs :GitFiles?<CR>
    nnoremap <leader>fl :Lines<CR>
    nnoremap <leader>ft :Tags<CR>
    nnoremap <leader>fm :Marks<CR>
    nnoremap <leader>fw :Windows<CR>
    nnoremap <leader>fc :Commits<CR>
    nnoremap <leader>fcb :BCommits<CR>
    nnoremap <leader>fa :Ag<CR>
    nnoremap <leader>fr :Rg<CR>
    let g:fzf_commits_log_options = '--graph --pretty --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

    command! -bang -nargs=* History
      \ call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))
    " with preview window
    command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
    command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)
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
Plug 'voldikss/vim-floaterm'
    let g:floaterm_keymap_next   = '<F3>'
    let g:floaterm_keymap_prev   = '<F4>'
    let g:floaterm_keymap_toggle = '<F5>'
    let g:floaterm_keymap_new    = '<F6>'
    let g:floaterm_position = 'center'

Plug 'jpalardy/vim-slime'  "Send to tmux
    let g:slime_target = 'neovim'
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
    nmap <leader>cc :CocCommand<CR>
    nmap <leader>CC :CocConfig<CR>
    nmap <leader>CR :CocRestart<CR>
    nmap <leader>cl :CocList<CR>
    nmap <leader>cm :CocList<CR>
  " Use tab for trigger completion, completion confirm
        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
        inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
        " Confirm completeion
		inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        imap <C-j> <Plug>(coc-snippets-expand-jump)
    " Coc K to show documentation
        function! s:show_documentation()
          if &filetype == 'vim'
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction
        nnoremap <silent> K :call <SID>show_documentation()<CR>
    " Remap keys for gotos
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> g[ <Plug>(coc-declaration)
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Remap for rename current word
    nmap <leader>crn <Plug>(coc-rename)
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
	" Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)
    " Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    " nmap <silent> <TAB> <Plug>(coc-range-select)
    " xmap <silent> <TAB> <Plug>(coc-range-select)
    " Use `:Format` for format current buffer
    command! -nargs=0 Format :call CocAction('format')
    " Smart f, press <esc> to cancel.
    nmap f <Plug>(coc-smartf-forward)
    nmap F <Plug>(coc-smartf-backward)
    nmap ; <Plug>(coc-smartf-repeat)
    nmap , <Plug>(coc-smartf-repeat-opposite)
        augroup Smartf
          autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
          autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
        augroup end
    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
    "Git
    nmap <silent> <expr> [c &diff ? '[c' : '<Plug>(coc-git-prevchunk)'
    nmap <silent> <expr> ]c &diff ? ']c' : '<Plug>(coc-git-nextchunk)'
    nmap gs <plug>(coc-git-chunkinfo)
    nmap gC <plug>(coc-git-commit)
    " create text object for git chunks
    omap ig <Plug>(coc-git-chunk-inner)
    xmap ig <Plug>(coc-git-chunk-inner)
    omap ag <Plug>(coc-git-chunk-outer)
    xmap ag <Plug>(coc-git-chunk-outer)
    noremap <F9> :CocCommand explorer<CR>

Plug 'ludovicchabant/vim-gutentags'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger = "<nop>"
Plug 'liuchengxu/vista.vim'
    noremap <F8> :Vista!!<CR>
    let g:vista_echo_cursor_strategy = 'floating_win'
    let g:vista_update_on_text_changed = 1
    let g:vista_close_on_jump = 1
    " let g:vista_fzf_preview = ['right:50%']
    let g:vista_executive_for = {
    \ 'py': 'coc',
    \ 'cpp': 'coc',
    \ 'json': 'coc',
    \ 'tex': 'coc',
    \ 'markdown': 'toc',
    \ }
  autocmd FileType vista,vista_kind nnoremap <buffer> <silent>
        \ / :<c-u>call vista#finder#fzf#Run()<CR>

Plug 'simnalamburt/vim-mundo'
    let g:mundo_right = 1
    noremap <F7> :MundoToggle<CR>

Plug 'jph00/swift-apple'
Plug 'lervag/vimtex'
    let g:vimtex_compiler_progname = 'nvr'

" Visual
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  let g:semshi#mark_selected_nodes = 0
Plug 'Yggdroot/indentLine'
Plug 'machakann/vim-highlightedyank'
Plug 'romainl/vim-cool'  "Handle highlight search automatically

Plug 'itchyny/lightline.vim'
    let g:lightline = {
        \ 'colorscheme': 'one',
        \ 'component': {
        \ },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'readonly', 'filename', 'modified'] ],
        \   'right': [ [ 'percent' ,'lineinfo' ],
        \              [ 'fileencoding', 'filetype', 'fugitive' ],
        \              [ 'cocstatus', 'gutentags'] ]
        \ },
        \ 'component_function': {
        \   'gutentags': 'gutentags#statusline',
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
Plug 'rakr/vim-one'

call plug#end()

" Theme
let g:one_allow_italics = 1
colorscheme one
autocmd BufNewFile,BufRead *.gin set syntax=toml
highlight Comment cterm=italic
highlight Folded ctermbg=None guibg=None
:highlight ExtraWhitespace ctermbg=Yellow guibg=Yellow
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:au InsertLeave * match ExtraWhitespace /\s\+$/
