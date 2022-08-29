--  __________________
-- < Bootstrap Packer >
--  ------------------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. install_path)
end
-- Autocommand that reloads neovim whenever you save this file
local config_group = vim.api.nvim_create_augroup('Config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = config_group,
  pattern = 'init.lua',
  nested = true,
})
--  _________
-- < Plugins >
--  ---------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
local function packer_plugins(use)
  use 'folke/which-key.nvim'
  use {'wbthomason/packer.nvim',
    config = function ()
      require("which-key").register({["<leader>p"] = {name = "Packer"}})
      vim.keymap.set("n", "<leader>pc", "<cmd>PackerCompile<cr>", {desc = "Compile" })
      vim.keymap.set("n", "<leader>pi", "<cmd>PackerInstall<cr>", {desc = "Install" })
      vim.keymap.set("n", "<leader>ps", "<cmd>PackerSync<cr>",    {desc = "Sync" })
      vim.keymap.set("n", "<leader>pS", "<cmd>PackerStatus<cr>",  {desc = "Status" })
      vim.keymap.set("n", "<leader>pu", "<cmd>PackerUpdate<cr>",  {desc = "Update" })
    end
  }
  use 'lewis6991/impatient.nvim'
  use 'nvim-lua/plenary.nvim' -- Lua utility helpers
  use 'folke/lua-dev.nvim' -- Dev setup for init.lua and plugin
  use 'neovim/nvim-lspconfig' -- Configs for built-in LSP client
  -- use 'williamboman/nvim-lsp-installer' -- Auto install language servers
  use { "williamboman/mason.nvim", }
  use { "williamboman/mason-lspconfig.nvim", }
  use { 'j-hui/fidget.nvim',   -- LSP status spinner
    config = function() require("fidget").setup() end
  }
  use 'jose-elias-alvarez/null-ls.nvim'  -- Create ls from external programs
  use {'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    run = ":TSUpdate",
  }
  use {"yioneko/nvim-yati"}

  -- Completion
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'rafamadriz/friendly-snippets'
  use 'saadparwaiz1/cmp_luasnip'
  use 'quangnguyen30192/cmp-nvim-tags'
  -- use {'tzachar/cmp-tabnine', run='./install.sh' }
  use 'zbirenbaum/copilot-cmp'
  use 'lukas-reineke/cmp-rg'
  use "ray-x/cmp-treesitter"
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol' -- For / search command
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'

  -- Debug Adapters
  --
  use {"mfussenegger/nvim-dap"}
  use { "rcarriga/nvim-dap-ui",
    config = function() require('dapui').setup() end
  }
  use {"theHamsta/nvim-dap-virtual-text",
    config = function() require('nvim-dap-virtual-text').setup({}) end}
  use {"mfussenegger/nvim-dap-python"}

  use { "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function ()
      vim.schedule(function() require("copilot").setup() end)
    end,
  }

  use {"blueyed/semshi",
    branch="handle-ColorScheme",
    run=":UpdateRemotePlugin",
    config = function()
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
    end
  }

  -- UI
  use 'nvim-lua/popup.nvim'
  use 'stevearc/dressing.nvim'
  use 'rcarriga/nvim-notify'
  use { 'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup({})
    end,
  }
  use {'moll/vim-bbye',
    config = function ()
      vim.keymap.set("n", "<leader>c", "<cmd>:Bdelete<cr>", {desc = "Close Buffer"})
    end}
  use {'nvim-lualine/lualine.nvim',}
  use {'vimpostor/vim-tpipeline',
    config = function()
      vim.g.tpipeline_usepane = 1
      vim.g.tpipeline_clearstl = 1
    end
  }
  use { "Pocco81/true-zen.nvim",
    config = function()
      local truezen = require('true-zen')
      truezen.setup()
      vim.keymap.set('n', '<leader>zn', function() truezen.narrow(0, vim.api.nvim_buf_line_count(0)) end)
      vim.keymap.set('v', '<leader>zn', function() truezen.narrow(vim.fn.line('v'), vim.fn.line('.')) end)
      vim.keymap.set('n', '<leader>zf', truezen.focus)
      vim.keymap.set('n', '<leader>zm', truezen.minimalist)
      vim.keymap.set('n', '<leader>za', truezen.ataraxis)
    end,
  }
  use { "folke/twilight.nvim",
    config = function() require("twilight").setup { } end
  }

  -- SideBars
  use {'kyazdani42/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        diagnostics = { enable = true }
      })
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {desc = "Explorer" })
    end }
  use {"simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        width = 5,
        preview_bg_highlight = "",
        keymaps = {
          hover_symbol = "S",
        }
      })
      vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<CR>")
    end
  }
  use {"simnalamburt/vim-mundo",
    key = "<leader>uu", command = ":MundoToggle",
    config = function() vim.cmd [[nmap <leader>u :MundoToggle<CR>]] end}
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind.nvim' -- Add pictogram to LSP

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope.nvim'
  use { "lukas-reineke/indent-blankline.nvim", event = "BufRead",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
        use_treesitter       = true,
      })
    end }

  use { "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
      require('neoscroll.config').set_mappings({
        ['<PageUp>']   = { 'scroll', { '-vim.wo.scroll', 'false', '250' } },
        ['<PageDown>'] = { 'scroll', { 'vim.wo.scroll', 'false', '250' } },
      })
    end }
  use {"RRethy/vim-illuminate"}
  use {"delphinus/auto-cursorline.nvim",
    config=function () require("auto-cursorline").setup() end}
  use { "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end }
  use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig", }
  use {'kevinhwang91/nvim-bqf', ft="qf"}
  use "kevinhwang91/nvim-hlslens" -- show number beside search highlight
  use "romainl/vim-cool" -- Handle highlight search automatically
  use { "norcalli/nvim-colorizer.lua", event = "BufRead",
    config = function() require("colorizer").setup() end
  }


  -- Folding
  use "lkhphuc/nvim-treesitter-pyfold"
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', }
  use { "nacro90/numb.nvim", event = "BufRead", --Peeking line before jump
    config = function() require("numb").setup() end,
  }
  -- Use treesitter to always show Class, function on top when overscrolled
  use { "romgrk/nvim-treesitter-context", }
  use { "p00f/nvim-ts-rainbow", event = "BufRead" } --Rainbow paranetheses
  use { "ray-x/lsp_signature.nvim",
    config = function() require('lsp_signature').setup({
        toggle_key = "<C-e>",  -- Similar to cmp abort
        select_signature_key = "<C-n>",
      })
    end }
  use { "folke/trouble.nvim", event = "BufEnter",
    config = function()
      require("trouble").setup()
      -- require("which-key").register({["<leader>x"] = {name = "Trouble"}})
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", {desc="Trouble Toggle"})
      vim.keymap.set("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", {desc = "References" })
      vim.keymap.set("n", "<leader>xf", "<cmd>TroubleToggle lsp_definitions<cr>", {desc = "Definitions" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {desc = "Diagnosticss" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {desc = "QuickFix" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {desc="LocationList" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {desc = "Diagnosticss" })
    end
  }
  use { "weilbith/nvim-code-action-menu" }
  use{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      -- require("lsp_lines").register_lsp_virtual_lines()
    end,
  }
  use { "mattboehm/vim-unstack",
    key = "<leader>us", command = ":unstack*",
    config = function() vim.g.unstack_mapkey = "<leader>us" end, }
  use { "kosayoda/nvim-lightbulb", event = "InsertLeave",
    config = function()
      vim.api.nvim_create_autocmd( {"CursorHold", "CursorHoldI"},
        { pattern = "*",
          callback = require'nvim-lightbulb'.update_lightbulb,
        }
      )
    end
  }
  use 'jubnzv/virtual-types.nvim' -- TODO: need codelen

  -- Git
  use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use { "sindrets/diffview.nvim", event = "CmdlineEnter" }
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function() require('my.gitsigns') end }


  -- Terminal
  use 'christoomey/vim-tmux-navigator'
  use { "nikvdp/neomux", }
  use { "voldikss/vim-floaterm", config = function()
    vim.g.floaterm_keymap_next   = '<End>' -- Hyper+o
    vim.g.floaterm_keymap_prev   = '<S-End>' -- Hyper+Command+o
    vim.g.floaterm_keymap_new    = '<S-Home>' -- Hyper+Command+i
    vim.g.floaterm_keymap_toggle = '<Home>' -- Hyper+i
    vim.g.floaterm_position      = 'center'
    vim.g.floaterm_width         = 0.9
    vim.g.floaterm_height        = 0.9
  end }
  -- use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
  --   require("toggleterm").setup()
  -- end}

  use { "jpalardy/vim-slime",
    requires = "hanschen/vim-ipython-cell",
    config = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mapping = 1
      vim.keymap.set("x", "<leader>r", "<Plug>SlimeRegionSend '>") -- Send then move last line of selection
      vim.keymap.set("n", "<leader>rr", "<Plug>SlimeSend")
      -- vim.keymap.set("n", "<S-CR>", "<Plug>SlimeParagraphSend")
      -- vim.keymap.set("n", "<leader><CR>", "<Plug>SlimeSendCell '>")
      -- python
      vim.g.slime_python_ipython = 1
      vim.keymap.set("n", "<S-CR>", "<Cmd>IPythonCellExecuteCellJump<CR>", {desc = "Execute and jumpt to next cell"})
      vim.keymap.set("n", "<leader><CR>", "<Cmd>IPythonCellExecuteCell<CR>", {desc = "Execute cell"})
      vim.keymap.set("n", "<leader>rs", "<Cmd>IPythonCellRun<CR>", {desc = "Run script"})
      vim.keymap.set("n", "<leader>rS", "<Cmd>IPythonCellRunTime<CR>", {desc = "Run script and time it"})
      vim.keymap.set("n", "<leader>rc", "<Cmd>IPythonCellClear<CR>", {desc = "Clear IPython screen"})
      vim.keymap.set("n", "<leader>rx", "<Cmd>IPythonCellClose<CR>", {desc = "Close all matplotlib figure windows"})
      vim.keymap.set("n", "<leader>rr", "<Cmd>IPythonCellPrevCommand<CR>", {desc = "ReRun previous command"})
      vim.keymap.set("n", "<leader>ri", "<Cmd>SlimeSend1 ipython --matplotlib<CR>", {desc = "Run ipython"})
      vim.keymap.set("n", "<leader>rR", "<Cmd>IPythonCellRestart<CR>", {desc = "Restart ipython"})
      vim.keymap.set("n", "<leader>rd", "<Cmd>SlimeSend1 %debug<CR>", {desc = "Debug ipython"})
      vim.keymap.set("n", "<leader>rq", "<Cmd>SlimeSend1 exit<CR>", {desc = "Exit"})
      vim.keymap.set("n", "[c", "<Cmd>IPythonCellNextCell<CR>", {desc = "Jump to previous cell"})
      vim.keymap.set("n", "]c", "<Cmd>IPythonCellNextCell<CR>", {desc = "Jump to next cell"})
      vim.keymap.set("n", "[i", "<Cmd>IPythonCellInsertAbove<CR>i", {desc = "Insert new cell above"})
      vim.keymap.set("n", "]i", "<Cmd>IPythonCellNextCell<CR>i", {desc = "Insert new cell below"})
    end
  }
  use { "goerz/jupytext.vim" }
  use {'ojroques/nvim-osc52',
    config = function ()
      local function copy(lines, _)
        require('osc52').copy(table.concat(lines, '\n'))
      end
      local function paste()
        return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
      end
      vim.g.clipboard = {
        name = 'osc52',
        copy = {['+'] = copy, ['*'] = copy},
        paste = {['+'] = paste, ['*'] = paste},
      }
      -- Now the '+' register will copy to system clipboard using OSC52
    end
  }
  use 'antoinemadec/FixCursorHold.nvim'
  use { "nvim-treesitter/playground", event = "BufRead", }

  -- Text Editting
  use { 'numToStr/Comment.nvim',
    requires = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function() require("my.comment") end,
  }
  use { "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({ fast_wrap = {} }) -- <M-e>
    end
  }
  use { "ggandor/leap.nvim",
    requires = 'ggandor/leap-ast.nvim',
    config = function () require("my.leap") end
  }
  use { "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        highlight = {
          duration = 1000,
        }
      })
    end
  }
  use "tpope/vim-repeat"
  use "tpope/vim-sleuth" --One plugin everything tab indent
  use "tpope/vim-unimpaired"
  use {"andymass/vim-matchup",
    config = function ()
      vim.g.matchup_matchparen_offscreen = {method= 'popup', position='cursor'}
      vim.g.matchup_matchparen_deferred = 1
    end
  }
  use {"junegunn/vim-easy-align",
    config = function()
      vim.keymap.set({"n", "x"}, "ga", "<Plug>(EasyAlign)")
    end}
  use "AndrewRadev/splitjoin.vim" -- gS and gJ
  -- use {"mg979/vim-visual-multi"},
  use "wellle/targets.vim" -- Text objects qoute,block,argument,delimiter
  use "kana/vim-textobj-user"
  use "chaoren/vim-wordmotion"  -- w handles Snake/camelCase, etc
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'RRethy/nvim-treesitter-textsubjects' -- smart
  use 'mfussenegger/nvim-treehopper'
  use { "abecodes/tabout.nvim", after = { "nvim-cmp", "nvim-treesitter", },
    config = function() require("my.tabout") end,
  }

  use {"gbrlsnchs/winpick.nvim",
    config = function()
      local winpick = require("winpick")
      local function pick()
        local winid = winpick.select()
        if winid then
          vim.api.nvim_set_current_win(winid)
        end
      end
      vim.keymap.set("n", "<C-w>0", pick)
    end
  }
  use { "kwkarlwang/bufresize.nvim",
    config = function()
      require("bufresize").setup()
    end
  }
  use {'mrjones2014/smart-splits.nvim',
    requires = "bufresize.nvim",
    config = function ()
      require("smart-splits").setup({
        resize_mode = {
          hooks = {
            on_leave = require("bufresize").register
          }
        }
      })
    end
  }
  use "szw/vim-maximizer"
  use {'sindrets/winshift.nvim',
    config = function()
      require("winshift").setup({
        highlight_moving_win = true
      })
    end
  }
  use {'anuvyklack/hydra.nvim', }

  -- Colorscheme
  use { "rmehri01/onenord.nvim"}
  use { "rebelot/kanagawa.nvim" }
  use { "navarasu/onedark.nvim" }
  use { "projekt0n/github-nvim-theme" }
  use { "cpea2506/one_monokai.nvim", }
  use { "folke/tokyonight.nvim"}
  use { "EdenEast/nightfox.nvim", }
  use { "catppuccin/nvim", as = "catppuccin", }
  use { "marko-cerovac/material.nvim", }
  use { "bluz71/vim-moonfly-colors"}
  use { "Yazeed1s/minimal.nvim" }
  use { "pappasam/papercolor-theme-slim" }
  use { "sainnhe/everforest" }
  use { "sainnhe/sonokai" }
  use { 'ray-x/starry.nvim'}

  if is_bootstrap then
    require('packer').sync()
  end
end

require('packer').startup(
  { packer_plugins,
    config = {
      max_jobs = 50, -- bugs, has to specificed a number
      display = { open_fn = require("packer.util").float },
    }
  }
)
require("my.keymaps")
require("impatient")
require("my.lsp")
require("my.dap")
require("my.null-ls")
require('my.cmp')
require("my.lualine")
require("my.telescope")
require("my.treesitter")
require("my.options")
require("my.fold")
require("my.windows")
require("my.colorscheme")

-- vim: ts=2 sts=2 sw=2 fdls=4 et
