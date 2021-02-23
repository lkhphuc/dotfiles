" vim:foldmethod=indent
"Automatically install Vim Plug and plugins
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" General nvim settings
  lang en_US.UTF-8
  let mapleader="\<Space>"
  let maplocalleader="\<Space>"
  set title
  auto BufEnter * let &titlestring = hostname() . ":" . expand("%:f")
  set title titlestring=%<%F%=%l/%L-%P titlelen=70
  set hidden
  set noshowmode
  set completeopt=menuone,noselect
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
  tnoremap <C-^> <C-\><C-n><C-^>

call plug#begin(stdpath('data') . '/plugged')

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

Plug '~/.zsh/fzf'
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
Plug 'gennaro-tedesco/nvim-peekup'

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
Plug 'mattboehm/vim-unstack'
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

Plug 'neovim/nvim-lspconfig'
Plug 'alexaandru/nvim-lspupdate'
Plug 'hrsh7th/nvim-compe'
  inoremap <silent><expr> <C-Space> compe#complete()
  inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
  inoremap <silent><expr> <C-e>     compe#close('<C-e>')
  inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
  inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 }) 
" Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'rhysd/git-messenger.vim'

Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_ctags_tagfile = '.tags'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger = "<nop>"
Plug 'hrsh7th/vim-vsnip'
Plug 'liuchengxu/vista.vim'
  noremap <leader>v :Vista!!<CR>
  let g:vista_echo_cursor_strategy = 'floating_win'
  let g:vista_update_on_text_changed = 1
  let g:vista_close_on_jump = 1
  " let g:vista_fzf_preview = ['right:50%']
  " let g:vista_executive_for = {
  " \ 'py': 'coc',
  " \ 'cpp': 'coc',
  " \ 'json': 'coc',
  " \ 'tex': 'coc',
  " \ 'markdown': 'toc',
  " \ }
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
  let g:indent_blankline_show_first_indent_level = v:false
Plug 'machakann/vim-highlightedyank'
Plug 'romainl/vim-cool'  "Handle highlight search automatically
Plug 'dstein64/nvim-scrollview'
Plug 'glepnir/spaceline.vim'
  let g:spaceline_colorscheme = 'space'
" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'sheerun/vim-polyglot'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/nvim-bufferline.lua'
  nnoremap <silent>[b :BufferLineCycleNext<CR>
  nnoremap <silent>b] :BufferLineCyclePrev<CR>
  nnoremap <silent>be :BufferLineSortByExtension<CR>
  nnoremap <silent>bd :BufferLineSortByDirectory<CR>
  nnoremap <silent> gb :BufferLinePick<CR>
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

require'bufferline'.setup{
  options = {
    view = "multiwindow",
    diagnostic = "nvim_lsp",
    mappings = true,
  }

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver", "sumneko_lua" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

require'compe'.setup {
  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
    tabnine = {
      max_line = 1000;
      max_num_results = 6;
      priority = 5000;
    };
  };
}
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- LSP Snippet
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
}

EOF

