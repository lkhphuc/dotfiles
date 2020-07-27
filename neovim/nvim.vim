if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  "Automatically install Vim Plug
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" General nvim settings
  lang en_US.UTF-8
  let mapleader="\<Space>"
  let maplocalleader="\<Space>"
  set hidden
  set noshowmode
  set mouse=a
  set dir='/tmp/,~/tmp,/var/tmp,.'
  set path+=**
  set wildmode=longest:full,full
  " Visual
  set relativenumber number
  set signcolumn=yes
  set cursorline
  set termguicolors
  set foldmethod=indent
  " au TermEnter * setlocal sidescrolloff=0 scrolloff=0
  " au TermLeave * setlocal sidescroll=1 scrolloff=50
  set colorcolumn=80
  set breakindent breakindentopt=shift:4,sbr
  set lbr formatoptions+=l " Ensures word-wrap does not split words
  set ignorecase smartcase
  set inccommand=nosplit
  set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
  set shortmess+=c " don't give |ins-completion-menu| messages.
  " Enable persistent undo so that undo history persists across vim sessions
  set undofile undodir=~/.vim/undo
" Mapping
  nnoremap <leader><space> za
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  nnoremap <leader>p "+p
  vnoremap <leader>p "+p
  " Windows
  tnoremap <C-w><C-w> <C-\><C-n><C-w>w
  nnoremap <C-h> <C-W>h
  tnoremap <C-h> <C-\><C-n><C-w>h
  nnoremap <C-j> <C-W>j
  tnoremap <C-j> <C-\><C-n><C-w>j
  nnoremap <C-k> <C-W>k
  tnoremap <C-k> <C-\><C-n><C-w>k
  nnoremap <C-l> <C-W>l
  tnoremap <C-l> <C-\><C-n><C-w>l
  tnoremap <C-w>v <C-\><C-n><C-w>v
  tnoremap <C-w>s <C-\><C-n><C-w>s
  " Terminal mode
  tnoremap <C-b> <C-\><C-n>
  tnoremap <PageUp> <C-\><C-n>
  tnoremap ]b <C-\><C-n>:bnext<CR>
  tnoremap [b <C-\><C-n>:bprev<CR>
  tnoremap <C-^> <C-\><C-n><C-^>

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'  "One plugin everything tab indent

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  " Using floating windows of Neovim to start fzf
  if has('nvim')
    function! FloatingFZF()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.8)
    let opts = { 'relative': 'editor',
           \ 'row': (&lines - height) / 2,
           \ 'col': (&columns - width) / 2,
           \ 'width': width,
           \ 'height': height }
    let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
    endfunction
    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
  endif
  nnoremap <leader>fh :History<CR>
  nnoremap <leader>fb :Buffers<CR>
  nnoremap <leader>ff :Files<CR>
  nnoremap <leader>fg :GitFiles<CR>
  nnoremap <leader>fs :GitFiles?<CR>
  nnoremap <leader>fl :Lines<CR>
  nnoremap <leader>ft :Tags<CR>
  nnoremap <leader>fm :Marks<CR>
  nnoremap <leader>fw :Windows<CR>
  nnoremap <leader>fc :Commits<CR>
  nnoremap <leader>fcb :BCommits<CR>
  nnoremap <leader>fa :Ag<CR>
  nnoremap <leader>fr :Rg<CR>
  let g:fzf_preview_window = 'right:60%'
  let g:fzf_commits_log_options = '--graph --pretty --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

Plug 'justinmk/vim-sneak'
  let g:sneak#use_ic_scs = 1
  let g:sneak#label = 1
  let g:sneak#s_next = 1
  map f <Plug>Sneak_f
  map F <Plug>Sneak_F
  map t <Plug>Sneak_t
  map T <Plug>Sneak_T
Plug 'yuttie/comfortable-motion.vim'
  noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
  noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
Plug 'terryma/vim-expand-region'
" Plug 'gcmt/wildfire.vim' "Smart selection of the closest text object
Plug 'wellle/targets.vim' "Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
Plug 'bkad/CamelCaseMotion'
  let g:camelcasemotion_key = '<leader>'


Plug 'szw/vim-maximizer'
  nnoremap <silent><C-w>m :MaximizerToggle<CR>
  vnoremap <silent><C-w>m :MaximizerToggle<CR>gv
  inoremap <silent><C-w>m <C-o>:MaximizerToggle<CR>
Plug 'mhinz/vim-sayonara', {'on': 'Sayonara'} "Sane buffer/windows close
  nnoremap <C-w>c :Sayonara<CR>
  tnoremap <C-w>c <C-\><C-n>:Sayonara<CR>

Plug 'kassio/neoterm'  "TODO Config shortcut
Plug 'voldikss/vim-floaterm'
  let g:floaterm_keymap_next   = '<End>'   "Hyper+o
  let g:floaterm_keymap_prev   = '<S-End>' "Hyper+Command+o
  let g:floaterm_keymap_new    = '<S-Home>' "Hyper+Command+i
  let g:floaterm_keymap_toggle = '<Home>'   "Hyper+b
  let g:floaterm_position = 'center'
  nnoremap <leader>lf :FloatermNew lf<CR>
  let g:floaterm_width = 0.8
  let g:floaterm_height = 0.8

Plug 'jpalardy/vim-slime'  "Send text elsewhere
  let g:slime_target = 'neovim'
  let g:slime_python_ipython = 1
  let g:slime_no_mappings = 1
  let g:slime_dont_ask_default = 1
  let g:slime_preserve_curpos = 0
  let g:slime_cell_delimiter = "#%%"
  nmap <S-CR> <Plug>SlimeSendCell
  xmap <S-CR> <Plug>SlimeRegionSend
  nmap <leader>s <Plug>SlimeParagraphSend}j

Plug 'janko/vim-test'
  nmap <silent> t<C-n> :TestNearest<CR>
  nmap <silent> t<C-f> :TestFile<CR>
  nmap <silent> t<C-s> :TestSuite<CR>
  nmap <silent> t<C-l> :TestLast<CR>
  nmap <silent> t<C-g> :TestVisit<CR>
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-python'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = [
    \ "coc-python", "coc-json", "coc-vimtex",
    \ "coc-tabnine", "coc-git", "coc-syntax", "coc-snippets", "coc-emoji",
    \ "coc-highlight", "coc-pairs", "coc-explorer",
    \ "coc-marketplace"
    \ ]
  nnoremap <leader>e :CocCommand explorer<CR>
  nnoremap <leader>CC :CocConfig<CR>
  nnoremap <leader>CR :CocRestart<CR>
  " <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    let g:coc_snippet_next = '<tab>'
  " Coc K, shift-tab to show documentation
    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
        call CocActionAsync('showSignatureHelp')
      endif
    endfunction
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    inoremap <silent> <S-Tab> <C-o>:call<SID>show_documentation()<CR>
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
  " Map function and class text objects. LS requires 'textDocument.documentSymbol'
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)
  "CTRL-S for selections ranges. LS requires 'textDocument/selectionRange'
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)
  " Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')
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
Plug 'antoinemadec/coc-fzf'
  let g:coc_fzf_preview = ''
  let g:coc_fzf_opts = []
  nnoremap <leader>cl :CocFzfList<CR>
  nnoremap <leader>cr :CocFzfListResume<CR>
  nnoremap <leader>ca :CocFzfList actions<CR>
  nnoremap <leader>cc :CocFzfList commands<CR>
  nnoremap <leader>cd :CocFzfList diagnostics<CR>
  nnoremap <leader>co :CocFzfList outline<CR>
  nnoremap <leader>cs :CocFzfList symbols<CR>

Plug 'ludovicchabant/vim-gutentags'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger = "<nop>"
Plug 'liuchengxu/vista.vim'
  noremap <leader>v :Vista!!<CR>
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
Plug 'pechorin/any-jump.vim'

Plug 'simnalamburt/vim-mundo'
  let g:mundo_right = 1
  noremap <leader>u :MundoToggle<CR>

Plug 'goerz/jupytext.vim'
  let g:jupytext_fmt = 'py'
Plug 'hanschen/vim-ipython-cell', {'for': 'python'}  "TODO: config shortcuts
Plug 'jph00/swift-apple'
Plug 'lervag/vimtex'
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_fold_enabled = 1
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Visual
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  let g:semshi#mark_selected_nodes = 0
Plug 'Yggdroot/indentLine'
  let g:indentLine_concealcursor = 'c'
Plug 'machakann/vim-highlightedyank'
Plug 'romainl/vim-cool'  "Handle highlight search automatically
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
  let g:tex_conceal='abdmg'

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
  " :highlight ExtraWhitespace ctermbg=Yellow guibg=Yellow
  " :au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  " :au InsertLeave * match ExtraWhitespace /\s\+$/
