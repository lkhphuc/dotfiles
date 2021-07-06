-- vim:foldmethod=indent
local g = vim.g
local fn = vim.fn
local map = vim.api.nvim_set_keymap
local execute = vim.api.nvim_command
local map_opt = {noremap = true, silent = true}

vim.g.mapleader = " "

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

require "mappings"

local packer = require("packer")
local use = packer.use

packer.startup({function()
use "wbthomason/packer.nvim"
use "famiu/nvim-reload"

-- text editing
use "tpope/vim-surround"
use "tpope/vim-repeat"
use "tpope/vim-sleuth"  --One plugin everything tab indent
use "tpope/vim-unimpaired"
use "junegunn/vim-easy-align"
  vim.cmd [[xmap ga <Plug>(EasyAlign)]]
  vim.cmd [[nmap ga <Plug>(EasyAlign)]]
use "ggandor/lightspeed.nvim"
use "AndrewRadev/splitjoin.vim" -- gS and gJ
use "wellle/targets.vim"
use "simnalamburt/vim-mundo"
  vim.g.mundo_right = 1
  map("n", "<leader>u", ":MundoToggle<CR>", map_opt)

use { "neovim/nvim-lspconfig",
  config = function()
    require"nvim-lspconfig".config()
  end, }
use "kabouzeid/nvim-lspinstall"
-- use { "glepnir/lspsaga.nvim", config = require'lspsaga'.init_lsp_saga() }
-- use {'ray-x/navigator.lua',
--   config = function() require'navigator'.setup() end,
--   requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}
use "ray-x/lsp_signature.nvim"

use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
use { "mfussenegger/nvim-dap-python",
  config = function()
    require('dap-python').setup('/usr/local/Caskroom/miniconda/base/envs/debugpy/bin/python')
  end}
use "mattboehm/vim-unstack"


use { "hrsh7th/nvim-compe",
  event = "InsertEnter", -- load compe in insert mode only
  config = function()
    require "compe".setup {
      enabled = true,
      autocomplete = true,
      debug = false,
      min_length = 1,
      preselect = "enable",
      throttle_time = 80,
      source_timeout = 200,
      incomplete_delay = 400,
      max_abbr_width = 100,
      max_kind_width = 100,
      max_menu_width = 100,
      documentation = true,
      source = {
        buffer = {kind = "﬘", true},
        luasnip = {kind = "﬌", true},
        nvim_lsp = true,
        nvim_lua = true,
        tabnine = {
          priority = 0,
        }
      }
  }
  end ,
  wants = {"LuaSnip"}, }
use {"tzachar/compe-tabnine", run="./install.sh"}
use "rafamadriz/friendly-snippets"
use { "L3MON4D3/LuaSnip",
  wants = "friendly-snippets",
  event = "InsertCharPre",
  config = function()
    require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI"
    })
    require("luasnip/loaders/from_vscode").load()
  end }

use { "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = require("treesitter-nvim").config(), }
use "nvim-treesitter/nvim-treesitter-refactor"
use "nvim-treesitter/nvim-treesitter-textobjects"
use "romgrk/nvim-treesitter-context"
use "p00f/nvim-ts-rainbow"
use 'JoosepAlviste/nvim-ts-context-commentstring'

use {"sbdchd/neoformat", cmd = "Neoformat"}

use "folke/which-key.nvim"
use "simrat39/symbols-outline.nvim"
use "sindrets/diffview.nvim"

use "kyazdani42/nvim-web-devicons"
use "glepnir/galaxyline.nvim"
use { "akinsho/nvim-bufferline.lua",
  config = require("bufferline").setup() }
  map("n", "]b", [[<Cmd>BufferLineCycleNext<CR>]], map_opt)
  map("n", "[b", [[<Cmd>BufferLineCyclePrev<CR>]], map_opt)
  map("n", "gb", [[<Cmd>BufferLinePick<CR>]], map_opt)
use "kyazdani42/nvim-tree.lua"
  map("n", "<C-n>", ":NvimTreeToggle<CR>", map_opt)
use "liuchengxu/vista.vim"
  map("n", "<C-m>", ":Vista<CR>", map_opt)
use { "nvim-telescope/telescope.nvim",
  requires = {
    {"nvim-lua/popup.nvim"},
    {"nvim-lua/plenary.nvim"},
    {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
    {"nvim-telescope/telescope-media-files.nvim"}
  },
  cmd = "Telescope",
  config = function()
    require("telescope-nvim").config()
  end }
  map("n", "<Leader>t",  [[<Cmd>Telescope<CR>]],                           map_opt)
  map("n", "<Leader>ff", [[<Cmd> Telescope find_files <CR>]],              map_opt)
  map("n", "<Leader>fo", [[<Cmd>Telescope oldfiles<CR>]],                  map_opt)
  map("n", "<Leader>fg", [[<Cmd> Telescope live_grep<CR>]],                map_opt)
  map("n", "<Leader>fw", [[<Cmd> Telescope grep_string<CR>]],              map_opt)
  map("n", "<Leader>fb", [[<Cmd>Telescope buffers<CR>]],                   map_opt)
  map("n", "<Leader>fh", [[<Cmd>Telescope help_tags<CR>]],                 map_opt)
  map("n", "<Leader>fm", [[<Cmd>Telescope marks<CR>]],                     map_opt)
  map("n", "<Leader>fc", [[<Cmd>Telescope commands<CR>]],                  map_opt)
  map("n", "<Leader>fz", [[<Cmd>Telescope current_buffer_fuzzy_find<CR>]], map_opt)

  map("n", "<Leader>gs", [[<Cmd> Telescope git_status <CR>]], map_opt)
  map("n", "<Leader>gb", [[<Cmd> Telescope git_bcommits <CR>]], map_opt)
  map("n", "<Leader>gc", [[<Cmd> Telescope git_commits <CR>]], map_opt)

  map("n", "gr", [[<Cmd>Telescope lsp_references<CR>]], map_opt)
  map("n", "<Leader>ts", [[<Cmd>Telescope treesitter<CR>]], map_opt)

  map("n", "<Leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], map_opt)

use { "lewis6991/gitsigns.nvim",
  event = "BufRead",
  config = function()
    require("gitsigns-nvim").config()
  end }
use {'pwntester/octo.nvim', config=function() require"octo".setup() end}

use "nikvdp/neomux"
  vim.cmd([[au BufEnter term://* set nonumber norelativenumber  ]])
use "voldikss/vim-floaterm"
  vim.g.floaterm_keymap_next   = '<End>'   -- Hyper+o
  vim.g.floaterm_keymap_prev   = '<S-End>' -- Hyper+Command+o
  vim.g.floaterm_keymap_new    = '<S-Home>'-- Hyper+Command+i
  vim.g.floaterm_keymap_toggle = '<Home>'  -- Hyper+i
  vim.g.floaterm_position = 'center'
  vim.g.floaterm_width = 0.9
  vim.g.floaterm_height = 0.9
  map("n", "<leader>lf", [[<Cmd> FloatermNew lf <CR>]], map_opt)
  map("n", "<leader>lg", [[<Cmd> FloatermNew lazygit <CR>]], map_opt)
use "jpalardy/vim-slime"
  vim.g.slime_target = "neovim"
  vim.g.slime_no_mappings = 1
  vim.g.slime_python_ipython = 1
  vim.api.nvim_set_keymap("x", "<S-Enter>", [[<Plug>SlimeRegionSend<CR>]], {})
  vim.api.nvim_set_keymap("n", "<S-Enter>", [[<Plug>SlimeParagraphSend<CR>]], {})
  vim.api.nvim_set_keymap("n", "<leader>sc", [[<Plug>SlimeConfig<CR>]], {})
  -- vim.api.nvim_set_keymap("n", "<S-Enter>", [[<Plug>(SlimeMotionSend)]], {})

use "rmagatti/auto-session"
use { "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup()
  end }

use {"andymass/vim-matchup", event = "CursorMoved"}

use { "terrortylor/nvim-comment",
  event = "BufRead",
  config = function()
    require("nvim_comment").setup()
  end }

use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}
use "Iron-E/nvim-libmodal"
use "Iron-E/nvim-tabmode"
use "famiu/bufdelete.nvim"

use { "karb94/neoscroll.nvim",
  event = "WinScrolled",
  config = function() require("neoscroll").setup() end }
use { "kdav5758/TrueZen.nvim",
  cmd = {"TZAtaraxis", "TZMinimalist"},
  config = function()
    require("zenmode").config()
  end }
use { "lukas-reineke/indent-blankline.nvim", event = "BufRead" }
  vim.g.indent_blankline_char = "▏"
  vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
  vim.g.indent_blankline_buftype_exclude = {"terminal"}
  vim.g.indent_blankline_use_treesitter = true
  vim.g.indent_blankline_show_current_context = true

use "ojroques/vim-oscyank"
  execute( [[ autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif ]])
use "yamatsum/nvim-cursorline" -- Highlight words and lines on the cursor
use { "norcalli/nvim-colorizer.lua",
  event = "BufRead",
  config = function()
    require("colorizer").setup()
    vim.cmd("ColorizerReloadAllBuffers")
  end }
use "machakann/vim-highlightedyank"
use "romainl/vim-cool"  -- Handle highlight search automatically

use "christianchiarulli/nvcode-color-schemes.vim"
use "RRethy/nvim-base16"


end,
  config = {
    display = { open_fn = require('packer.util').float }
  } })

local opt = vim.opt
  opt.title = true
  opt.titlestring = "%<%F%=%l/%L-%P"
  opt.titlelen = 70
  vim.cmd([[auto BufEnter * let &titlestring =  substitute(hostname(), '^.*\.', '', '').":".expand("%:f")]])

  opt.foldmethod = "expr"
  opt.foldexpr = "nvim_treesitter#foldexpr()"
  opt.breakindent = true
  opt.lbr = true
  opt.breakindentopt = "shift:1"
  opt.undofile = true
  opt.wildmode = "longest:full,full"
  opt.smartcase = true

  opt.ruler = false
  opt.hidden = true
  opt.ignorecase = true
  opt.splitbelow = true
  opt.splitright = true
  opt.termguicolors = true
  opt.cul = true
  opt.mouse = "a"
  opt.signcolumn = "yes"
  opt.cmdheight = 1
  opt.updatetime = 250 -- update interval for gitsigns
  opt.clipboard = "unnamedplus"
  opt.path = opt.path + "**"

  -- Numbers
  opt.number = true
  opt.numberwidth = 2
  opt.relativenumber = true

  -- for indenline
  opt.expandtab = true
  opt.shiftwidth = 2
  opt.smartindent = true

-- Provider
g.python3_host_prog = "/usr/bin/python3"

g.theme = "onedark"
require "statusline"
require "file-icons"
require "highlights"
