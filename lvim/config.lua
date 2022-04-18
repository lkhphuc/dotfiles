-- vim:foldmethod=indent
lvim.plugins = {
-- Navigating
-- {"nanozuki/tabby.nvim",
--   config = function() require("tabby").setup() end, },
{"Iron-E/nvim-libmodal"},
{"Iron-E/nvim-tabmode"},
{"ggandor/lightspeed.nvim", event="CursorMoved"},
{"kevinhwang91/nvim-bqf"},
{"andymass/vim-matchup"},

-- SideBars
{"simrat39/symbols-outline.nvim",
  config = function() vim.cmd[[nmap <C-m> :SymbolsOutline<CR>]] end},
{"simnalamburt/vim-mundo",
  key = "<leader>uu", command = ":MundoToggle",
  config = function() vim.cmd [[nmap <leader>u :MundoToggle<CR>]] end},

-- IDE
{"ray-x/lsp_signature.nvim", event = "InsertEnter",
  config = function() require"lsp_signature".setup() end, },
{"folke/trouble.nvim", event="BufEnter",
  config = function()
    lvim.builtin.which_key.mappings["x"] = {
      name = "+Trouble",
      x = { "<cmd>TroubleToggle<CR>", "Trouble Toggle" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
      f = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definitions" },
      d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Diagnosticss" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "LocationList" },
      w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Diagnosticss" },
    }
  end },
{"weilbith/nvim-code-action-menu"},
{"mattboehm/vim-unstack",
  key = "<leader>us", command = ":Unstack*",
  config = function() vim.g.unstack_mapkey="<leader>us" end, },
{"kosayoda/nvim-lightbulb", event = "InsertLeave"},

-- Languages
{'m-demare/hlargs.nvim', config = function() require('hlargs').setup() end},
{"eddiebergman/nvim-treesitter-pyfold"},
{"blueyed/semshi", branch="handle-ColorScheme"},
-- {"mfussenegger/nvim-dap-python", ft="python"},
{"lkhphuc/nvim-dap-python", ft="python",
  config = function()
    require('dap-python').setup('/usr/local/Caskroom/miniconda/base/envs/simone/bin/python')
    vim.cmd [[nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>]]
    vim.cmd [[nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>]]
    vim.cmd [[vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>]]
  end, },
{"lervag/vimtex"},

-- Git
{"tpope/vim-fugitive", event="CmdlineEnter"},
{"sindrets/diffview.nvim", event="CmdlineEnter"},

-- Terminal
{"nikvdp/neomux", event="BufEnter",
  config = function()
    vim.cmd [[au BufEnter term://* set nonumber norelativenumber  ]]
  end },
{"voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_keymap_next   = '<End>'   -- Hyper+o
    vim.g.floaterm_keymap_prev   = '<S-End>' -- Hyper+Command+o
    vim.g.floaterm_keymap_new    = '<S-Home>'-- Hyper+Command+i
    vim.g.floaterm_keymap_toggle = '<Home>'  -- Hyper+i
    vim.g.floaterm_position = 'center'
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.cmd [[nnoremap <leader>gg <Cmd>FloatermNew lazygit <CR>]]
    vim.cmd [[nnoremap <leader>lg <Cmd>FloatermNew lazygit <CR>]]
    -- vim.cmd [[nnoremap <leader>lf <Cmd>FloatermNew lf <CR>]]
  end },
{"jpalardy/vim-slime",
  config = function()
    vim.g.slime_target = "neovim"
    vim.g.slime_python_ipython = 1
  end},
{"klafyvel/vim-slime-cells",
  requires = {{'jpalardy/vim-slime', opt=true}},
  ft = {'julia', 'python'},
  config=function ()
    vim.g.slime_cell_delimiter = "^\\s*##\\s*"
    vim.cmd([[
    nmap <C-c><CR> <Plug>SlimeCellsSendAndGoToNext
    nmap <C-c>j <Plug>SlimeCellsNext
    nmap <C-c>k <Plug>SlimeCellsPrev
    ]])
  end
},

-- Misc
{"ojroques/vim-oscyank", event="CursorMoved",
  config = function()
  vim.cmd [[ autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif ]]
  end, },

-- Text Objects
{"wellle/targets.vim"}, -- More target text objects
{"kana/vim-textobj-user"},
{"Julian/vim-textobj-variable-segment"},
{"nvim-treesitter/nvim-treesitter-textobjects", event="BufRead"},

-- Treesitter
{"nvim-treesitter/nvim-treesitter-refactor", event="BufRead" },
{"romgrk/nvim-treesitter-context", event="BufRead" },  --Class, function lines always present
{"p00f/nvim-ts-rainbow", event="BufRead"},  --Rainbow paranetheses
{"nvim-treesitter/playground", event = "BufRead", },
{'David-Kunz/treesitter-unit', event="BufRead",
  config = function()
    vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
    vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
    vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
    vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})

    end },
{"SmiteshP/nvim-gps",
  config = function() require('nvim-gps').setup() end},
{"ray-x/cmp-treesitter"},

-- Editting
{"abecodes/tabout.nvim",
  config = function() require('tabout').setup({
    tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
    act_as_tab = true, -- shift content if tab out is not possible
    act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    enable_backwards = true, -- well ...
    completion = true, -- if the tabkey is used in a completion pum
    tabouts = {
      {open = "'", close = "'"},
      {open = '"', close = '"'},
      {open = '`', close = '`'},
      {open = '(', close = ')'},
      {open = '[', close = ']'},
      {open = '{', close = '}'}
    },
    ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {} -- tabout will ignore these filetypes
  }) end,
  after = {"nvim-cmp"}},
{"tpope/vim-surround"},
{"tpope/vim-repeat"},
{"tpope/vim-sleuth"},  --One plugin everything tab indent
{"tpope/vim-unimpaired"},
{"junegunn/vim-easy-align", keys="ga",
  config = function()
    vim.cmd [[xmap ga <Plug>(EasyAlign)]]
    vim.cmd [[nmap ga <Plug>(EasyAlign)]]
  end, },
{"AndrewRadev/splitjoin.vim", event="CursorMoved"}, -- gS and gJ
-- {"mg979/vim-visual-multi"},


-- Visual
{"luukvbaal/stabilize.nvim",
  config = function() require("stabilize").setup() end },
{"karb94/neoscroll.nvim", event = "WinScrolled",
  config = function()
    require("neoscroll").setup()
    local t = {}
    t['<PageUp>'] = {'scroll', {'-vim.wo.scroll', 'false', '250'}}
    t['<PageDown>'] = {'scroll', {'vim.wo.scroll', 'false', '250'}}
    require('neoscroll.config').set_mappings(t)
  end },
{"yamatsum/nvim-cursorline", event="BufRead"}, -- Highlight words and lines on the cursor
{"lukas-reineke/indent-blankline.nvim", event = "BufRead",
  config = function()
    require("indent_blankline").setup {
      show_current_context = true,
      use_treesitter = true,
      show_end_of_line = true,
      buftype_exclude = {'nofile', 'terminal'},
      filetype_exclude = {'help', 'dashboard'},
    }
  end },
{"folke/zen-mode.nvim", event="BufEnter"},
{"nacro90/numb.nvim", event = "BufRead", config = function() require("numb").setup() end, },
{"kevinhwang91/nvim-hlslens"},  -- show number beside search highlight
{ 'anuvyklack/pretty-fold.nvim',
   config = function()
      require('pretty-fold').setup{}
      require('pretty-fold.preview').setup({
        key = 'l',
      })
   end
},
{"romainl/vim-cool"},  -- Handle highlight search automatically
{"norcalli/nvim-colorizer.lua", event = "BufRead",
  config = function()
    require("colorizer").setup()
  end },

-- COLORSCHEMES
{"RRethy/nvim-base16"},
{"rmehri01/onenord.nvim",
  config = function() require('onenord').setup({
      italic = { comments = true, keywords = true }
    })
  end},
{"rebelot/kanagawa.nvim"},
{"olimorris/onedarkpro.nvim",
  config = function()
    vim.g.edge_better_performance = 1
    vim.g.edge_enable_italic = 1
  end},
{"cpea2506/one_monokai.nvim"},

}

-- local colorscheme = "onedarkpro"
lvim.colorscheme = colorscheme

local opt = vim.opt
  opt.timeoutlen = 300
  opt.foldmethod = "expr"
  opt.foldexpr = "nvim_treesitter#foldexpr()"
  opt.shiftwidth = 2
  opt.wrap = true
  opt.breakindent = true
  opt.linebreak = true
  opt.breakindentopt = "min:60,sbr"
  opt.undofile = true
  opt.wildmode = "longest:full,full"
  opt.smartcase = true
  opt.hidden = true
  opt.ignorecase = true
  opt.path = opt.path + "**"
  opt.numberwidth = 2
  opt.relativenumber = true
  vim.g.python3_host_prog = "/usr/bin/python3"
  opt.list = true
  opt.listchars = "eol:↲,trail:·,nbsp:␣"
  opt.laststatus = 3

local cmd = vim.cmd
  cmd "au TermOpen * setlocal listchars= nonumber norelativenumber"
  cmd "au ColorScheme * highlight BufferCurrent gui=bold,italic"
  cmd "au ColorScheme * highlight TSKeyword gui=bold,italic"
  cmd "au ColorScheme * highlight TSKeywordFunction gui=bold,italic"
  cmd "au ColorScheme * highlight TSVariableBuiltin gui=italic"
  cmd "au ColorScheme * highlight TSInclude gui=bold,italic"

local k = lvim.keys
local wk = lvim.builtin.which_key
  -- keymappings [view all the defaults by pressing <leader>Lk]
  lvim.leader = "space"
  k.normal_mode["<C-s>"] = ":w<cr>"
  k.insert_mode["<C-s>"] = "<Esc>:w<cr>"

  k.normal_mode["gb"] = "<cmd> BufferLinePick<CR>"

  -- Terminal
  k.term_mode["<PageUp>"] = "<C-\\><C-N>"  --Capslock+u exit terminal mode
  k.term_mode["<C-^>"] ="<C-\\><C-N><C-^>"

  -- Clipboard Yank
  k.normal_mode["<leader>y"] = "\"+y"
  k.visual_mode["<leader>y"] = "\"+y"
  k.normal_mode["<leader>p"] = "\"+p"
  k.visual_mode["<leader>p"] = "\"+p"
  k.normal_mode["<leader><space>"] = "zA"
  k.normal_mode["]<Tab>"] = ":tabnext<CR>"
  k.normal_mode["[<Tab>"] = ":tabprev<CR>"

  -- LSP
  k.normal_mode["]d"] = "<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>"
  k.normal_mode["[d"] = "<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>"
  k.normal_mode["]g"] = "<cmd>lua require 'gitsigns'.next_hunk()<CR>"
  k.normal_mode["[g"] = "<cmd>lua require 'gitsigns'.prev_hunk()<CR>"
  wk.mappings["ss"] = {"<cmd>Telescope<CR>", "Telescope"}
  wk.mappings["lF"] = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Formatting"}
  wk.mappings["lf"] = {"<cmd>FloatermNew lf<cr>", "LF manager"}
  wk.mappings["la"] = {"<cmd>CodeActionMenu<CR>", "Code Action"}

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.dap.active = true
lvim.builtin.project.active = false

local ts = lvim.builtin.treesitter
  ts.ensure_installed = {"python", "lua", "bash", "vim", "comment"}
  -- ts.highlight.enabled = true
  ts.highlight.use_languagetree = true
  ts.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "+",
      node_incremental = "+",
      scope_incremental = "=",
      node_decremental = "_",
    }
  }
  ts.indent.enable = false
  ts.rainbow.enable = true
  ts.refactor = {
    highlight_definitions= { enable = true},
    -- highlight_current_scope = { enable = true},
    smart_rename = {
      enable = true,
      keymaps = { smart_rename = "<leader>Tn"}
    }
  }
  ts.refactor.navigation = {
    enable = true,
    keymaps = {
      goto_definition_lsp_fallback = "gd",
      list_definitions = "go",
      list_definitions_toc = "gO",
      goto_next_usage = "]u",
      goto_previous_usage = "[u",
    }
  }
  ts.textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ai"] = "@block.outer",
        ["ii"] = "@block.inner",
        ["c"] = "@comment.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sA"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>kf"] = "@function.outer",
        ["<leader>kc"] = "@class.outer",
      },
    },
  }
  require("nvim-treesitter.configs").setup {
    matchup = { enable = true },
    pyfold = {
      enable = true,
      custom_foldtext = true,
    }
  }

local lualine = lvim.builtin.lualine
  lualine.options.theme = colorscheme
  lualine.options.section_separators = { left = '', right = ''}
  lualine.options.component_separators = { left = '', right = ''}
  local components = require "lvim.core.lualine.components"
  local gps = require("nvim-gps")
  lualine.sections.lualine_b = {
    components.filename,
    {gps.get_location, cond=gps.is_available},
  }
  lualine.sections.lualine_c = {
    components.diff,
    components.branch,
  }

local formatters = require "lvim.lsp.null-ls.formatters"
  formatters.setup {
    { exe = "black", filetypes = { "python" } },
    { exe = "isort", filetypes = { "python" } },
  }

lvim.builtin.comment.toggler.block = "gcb"
-- local linters = require "lvim.lsp.null-ls.linters"
--   linters.setup {
--     { exe = "pylint", filetypes = {"python"} }
--   }
