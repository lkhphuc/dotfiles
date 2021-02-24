" vim:foldmethod=indent
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
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  " au TermEnter * setlocal sidescrolloff=0 scrolloff=0
  " au TermLeave * setlocal sidescroll=1 scrolloff=50
  set breakindent breakindentopt=shift:4,sbr
  set lbr formatoptions+=l " Ensures word-wrap does not split words
  set ignorecase smartcase
  set inccommand=nosplit
  set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
  set shortmess+=c " don't give |ins-completion-menu| messages.
  set undofile " Enable persistent undo so that undo history persists across vim sessions
" Mapping
  nnoremap <leader><space> za
  nnoremap <C-s> :w<CR>
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  nnoremap <leader>p "+p
  vnoremap <leader>p "+p
  map <C-a> <Esc>ggVG<CR>
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
  tnoremap <C-v> <C-\><C-n>
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
Plug 'tpope/vim-rsi'  "Readline keybinding in insert model

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  nnoremap <leader>fh :History<CR>
  nnoremap <leader>fb :Buffers<CR>
  nnoremap <leader>ff :Files<CR>
  nnoremap <leader>fg :GitFiles<CR>
  nnoremap <leader>fs :GitFiles?<CR>
  nnoremap <leader>fl :Lines<CR>
  nnoremap <leader>ft :Tags<CR>
  nnoremap <leader>fm :Marks<CR>
  nnoremap <leader>fw :Windows<CR>
  nnoremap <leader>fC :Commits<CR>
  nnoremap <leader>fc :BCommits<CR>
  nnoremap <leader>fa :Ag<CR>
  nnoremap <leader>fr :Rg<CR>
  let g:fzf_commits_log_options = '--graph --pretty --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

Plug 'cohama/lexima.vim' "Auto close parentheses with repeat
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
  noremap <silent> <PageUp> :call comfortable_motion#flick(-100)<CR>
  noremap <silent> <PageDown> :call comfortable_motion#flick(100)<CR>
Plug 'terryma/vim-expand-region' "Auto adjust selection with + or _
Plug 'wellle/targets.vim' "Text objects
Plug 'michaeljsmith/vim-indent-object'
Plug 'bkad/CamelCaseMotion'
  let g:camelcasemotion_key = '<leader>'

Plug 'ojroques/vim-oscyank'
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
Plug 'szw/vim-maximizer'
  nnoremap <silent><C-w>m :MaximizerToggle<CR>
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
  let g:floaterm_width = 0.9
  let g:floaterm_height = 0.9
  nnoremap <leader>lg :FloatermNew lazygit<CR>
Plug 'ptzz/lf.vim'
  let g:lf_map_keys=0
  map <leader>lf :Lf<CR>
  let g:lf_replace_netrw = 1

Plug 'jpalardy/vim-slime'  "Send text elsewhere
  let g:slime_target = 'neovim'
  let g:slime_python_ipython = 1
  let g:slime_no_mappings = 1
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
" Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = [
    \ "coc-pyright", "coc-json", "coc-vimtex",
    \ "coc-tabnine", "coc-syntax", "coc-snippets",
    \ "coc-explorer", "coc-marketplace"
    \ ]
  nnoremap <leader>ce :CocCommand explorer<CR>
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
  " selections ranges. LS requires 'textDocument/selectionRange'
  nmap <silent> <leader>crs <Plug>(coc-range-select)
  xmap <silent> <leader>crs <Plug>(coc-range-select)
  " Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')
  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
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

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'rhysd/git-messenger.vim'

Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_ctags_tagfile = '.tags'
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
  let g:tex_flavor='latex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
  let g:tex_conceal='abdgm'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Visual
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'romgrk/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  let g:semshi#mark_selected_nodes = 0
Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}
  let g:indent_blankline_char_highlight = 'Folded'
  let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
  " let g:indent_blankline_show_first_indent_level = v:false
Plug 'machakann/vim-highlightedyank'
Plug 'romainl/vim-cool'  "Handle highlight search automatically
Plug 'dstein64/nvim-scrollview'
Plug 'itchyny/lightline.vim'
  let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'component': {
    \ },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified'] ],
    \   'right': [ [ 'percent' ,'lineinfo' ],
    \              [ 'fileencoding', 'filetype' ],
    \              [ 'cocstatus', 'gutentags', 'git'] ]
    \ },
    \ 'component_function': {
    \   'gutentags': 'gutentags#statusline',
    \   'cocstatus': 'LightlineCocStatus',
    \   'readonly': 'LightlineReadonly',
    \   'filename': 'LightlineFilename',
    \   'git': 'GitSign'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \}
  function! LightlineReadonly()
    return &readonly ? '' : ''
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
  function! GitSign()
    return get(b:,'gitsigns_head','') . get(b:,'gitsigns_status','')
  endfunction
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/sonokai'
  let g:sonokai_style = 'atlantis'
Plug 'bluz71/vim-nightfly-guicolors'
  let g:nightflyCursorColor = 1
Plug 'christianchiarulli/nvcode-color-schemes.vim'

call plug#end()

" Theme
  colorscheme snazzy
  highlight FloatermBorder ctermbg=None guibg=None
  highlight Folded         ctermbg=None guibg=None
  highlight Comment        cterm=italic gui=italic
  highlight TSKeyword      cterm=italic gui=italic
  highlight TSType         cterm=italic gui=italic
  highlight TSConditional  cterm=italic gui=italic
  highlight TSException    cterm=italic gui=italic
  highlight TSInclude      cterm=italic gui=italic
  

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = { enable = true, },

  incremental_selection = { enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = { enable = false },

  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = { enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = { enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },

  rainbow = { enable = true },
}

require('gitsigns').setup{
  signs = {
    add = {hl = 'diffAdded'},
    change = {hl = 'Constant'},
    delete = {hl = 'diffRemoved'},
    topdelete = {hl = 'diffRemoved'},
    changedelete = {hl = 'Constant'},
  }
}
EOF
