-- vim:foldmethod=indent
lvim.plugins = {
-- Navigating
{"Iron-E/nvim-libmodal"},
{"Iron-E/nvim-tabmode"},
{"ggandor/lightspeed.nvim", event="CursorMoved"},
{"wellle/targets.vim"}, -- More target text objects
{"kevinhwang91/nvim-bqf"},
{"andymass/vim-matchup",
  config = function()
    require("nvim-treesitter.configs").setup {
      matchup = { enable =true }
    }
  end },

-- SideBars
{"simrat39/symbols-outline.nvim",
  config = function() vim.cmd[[nmap <C-m> :SymbolsOutline<CR>]] end},
{"simnalamburt/vim-mundo",
  key = "<leader>u", command = ":MundoToggle",
  config = function() vim.cmd [[nmap <leader>u :MundoToggle<CR>]] end},


-- IDE
{"ray-x/lsp_signature.nvim", event = "InsertEnter",
  config = function() require"lsp_signature".on_attach() end, },
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
{"weilbith/nvim-code-action-menu",
  config = function() vim.cmd [[nmap <leader>la :CodeActionMenu<CR>]] end,
},
{"mattboehm/vim-unstack",
  keys = "<leader>us",
  config = function() vim.g.unstack_mapkey="<leader>us" end},
{"numirias/semshi"},
{"mfussenegger/nvim-dap-python"},

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

-- Misc
{"ojroques/vim-oscyank", event="CursorMoved",
  config = function()
  vim.cmd [[ autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif ]]
  end, },

-- Treesitter
{"nvim-treesitter/nvim-treesitter-refactor", event="BufRead"},
-- {"nvim-treesitter/nvim-treesitter-textobjects"},
{"romgrk/nvim-treesitter-context", event="BufRead"},  --Class, function lines always present
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
{"mg979/vim-visual-multi"},


-- Visual
{ "luukvbaal/stabilize.nvim",
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
    vim.g.indent_blankline_filetype_exclude = {"help", "dashboard"}
    vim.g.indent_blankline_buftype_exclude = {"terminal"}
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_current_context = true
  end },
{"folke/zen-mode.nvim", event="BufEnter"},
{"nacro90/numb.nvim", event = "BufRead",
  config = function()
  require("numb").setup {
    show_numbers = true, -- Enable 'number' for the window while peeking
    show_cursorline = true, -- Enable 'cursorline' for the window while peeking
  }
  end, },
{"kevinhwang91/nvim-hlslens"},
{"romainl/vim-cool"},  -- Handle highlight search automatically
{"folke/lsp-colors.nvim", event = "BufRead" },
{"norcalli/nvim-colorizer.lua", event = "BufRead",
  config = function()
    require("colorizer").setup()
    vim.cmd("ColorizerReloadAllBuffers")
  end },
{"RRethy/nvim-base16"},
{"olimorris/onedarkpro.nvim",
  config = function ()
    local odp = require('onedarkpro')
    odp.setup({
      styles = {
        comments = "italic",
        keywords = "bold,italic",
      },
    })
    odp.load()
  end},
}

local opt = vim.opt
  opt.timeoutlen = 300
  opt.foldmethod = "expr"
  opt.foldexpr = "nvim_treesitter#foldexpr()"
  opt.wrap = true
  opt.breakindent = true
  opt.lbr = true
  opt.breakindentopt = "min:60,shift:2"
  opt.undofile = true
  opt.wildmode = "longest:full,full"
  opt.smartcase = true
  opt.hidden = true
  opt.ignorecase = true
  opt.path = opt.path + "**"
  opt.numberwidth = 2
  opt.relativenumber = true
  vim.g.python3_host_prog = "/usr/bin/python3"

local cmd = vim.cmd
  cmd "au TermOpen * setlocal listchars= nonumber norelativenumber"
  cmd "highlight BufferCurrent gui=bold,italic"

local keys = lvim.keys
  -- keymappings [view all the defaults by pressing <leader>Lk]
  lvim.leader = "space"
  keys.normal_mode["<C-s>"] = ":w<cr>"
  keys.insert_mode["<C-s>"] = "<Esc>:w<cr>"

  -- Terminal
  keys.term_mode["<PageUp>"] = "<C-\\><C-N>"  --Capslock+u exit terminal mode
  keys.term_mode["<C-^>"] ="<C-\\><C-N><C-^>"

  -- Clipboard Yank
  keys.normal_mode["<leader>y"] = "\"+y"
  keys.visual_mode["<leader>y"] = "\"+y"
  keys.normal_mode["<leader>p"] = "\"+p"
  keys.visual_mode["<leader>p"] = "\"+p"
  keys.normal_mode["<leader><space>"] = "za"

  -- Use which-key to add extra bindings with the leader-key prefix
  -- lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
  keys.normal_mode["gb"] = ":BufferPick<CR>"
  -- LSP
  keys.normal_mode["]d"] = "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>"
  keys.normal_mode["[d"] = "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>"
  keys.normal_mode["]g"] = "<cmd>lua require 'gitsigns'.next_hunk()<CR>"
  keys.normal_mode["[g"] = "<cmd>lua require 'gitsigns'.prev_hunk()<CR>"
  -- keys.normal_mode["<leader>lF"] = "<cmd>lua vim.lsp.buf.formatting()<cr>"
  lvim.builtin.which_key.mappings["lF"] = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Formatting"}
  lvim.builtin.which_key.mappings["lf"] = {"<cmd>FloatermNew lf<cr>", "LF"}

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.dap.active = true
-- Treesitter
local ts = lvim.builtin.treesitter
  ts.ensure_installed = "maintained"
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

-- Lualine
local lualine = lvim.builtin.lualine
  lualine.options.section_separators = { left = '', right = ''}
  lualine.options.component_separators = { left = '', right = ''}
  local components = require "lvim.core.lualine.components"
  local gps = require("nvim-gps")
  lualine.sections.lualine_b = {
    components.branch,
    components.filename,
    {gps.get_location, cond=gps.is_available},
  }
