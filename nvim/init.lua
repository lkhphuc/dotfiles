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
require('packer').startup({ function(use)
  use {'wbthomason/packer.nvim',
    config = function ()
      -- require("which-key").register({["<leader>p"] = {name = "Packer"}})
      vim.keymap.set("n", "<leader>pc", "<cmd>PackerCompile<cr>", {desc = "Compile" })
      vim.keymap.set("n", "<leader>pi", "<cmd>PackerInstall<cr>", {desc = "Install" })
      vim.keymap.set("n", "<leader>ps", "<cmd>PackerSync<cr>",    {desc = "Sync" })
      vim.keymap.set("n", "<leader>pS", "<cmd>PackerStatus<cr>",  {desc = "Status" })
      vim.keymap.set("n", "<leader>pu", "<cmd>PackerUpdate<cr>",  {desc = "Update" })
    end
  }
  use 'lewis6991/impatient.nvim'
  use 'mrjones2014/legendary.nvim' -- Command Pallate
  use 'folke/which-key.nvim'
  use 'nvim-lua/plenary.nvim' -- Lua utility helpers
  use 'folke/lua-dev.nvim' -- Dev setup for init.lua and plugin
  use 'neovim/nvim-lspconfig' -- Configs for built-in LSP client
  use 'williamboman/nvim-lsp-installer' -- Auto install language servers
  use 'j-hui/fidget.nvim'  -- LSP status spinner
  use 'jose-elias-alvarez/null-ls.nvim'  -- Create ls from external programs
  use {'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    run = ":TSUpdate",
  }
  use 'yioneko/nvim-yati' -- TODO: Until treesitter fit indent

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
  -- use "Pocco81/dap-buddy.nvim"
  -- use {"theHamsta/nvim-dap-virtual-text",
  --   config = function() require('nvim-dap-virtual-text').setup() end}
  -- use {"rcarriga/nvim-dap-ui",
  --   config = function()
  --     require('dapui').setup()
  --     vim.cmd [[nmap <leader>dy :lua require("dapui").toggle()<CR>]]
  --   end}
  -- use 'github/copilot.vim'
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
  use {'moll/vim-bbye',
    config = function ()
      vim.keymap.set("n", "<leader>c", "<cmd>:Bdelete<cr>", {desc = "Close Buffer"})
    end}
  use {'nvim-lualine/lualine.nvim', }
  use {'vimpostor/vim-tpipeline',
    config = function()
      vim.g.tpipeline_usepane = 1
      vim.g.tpipeline_clearstl = 1
    end
  }
  -- SideBars
  use {'kyazdani42/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        diagnostics = { enable = true }
      })
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {desc = "Explorer" })
    end }
  -- use {"simrat39/symbols-outline.nvim",
  use {"mxsdev/symbols-outline.nvim",
    branch = "folding",
    config = function()
      vim.g.symbols_outline = {
        preview_bg_highlight = "",
        keymaps = {
          hover_symbol = "K",
          toggle_preview = "P",
        }
      }
      vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<CR>")
    end
  }
  use {"simnalamburt/vim-mundo",
    key = "<leader>uu", command = ":MundoToggle",
    config = function() vim.cmd [[nmap <leader>u :MundoToggle<CR>]] end}
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind.nvim' -- Add pictogram to LSP
  use 'stevearc/dressing.nvim'
  use 'rcarriga/nvim-notify'
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
  use { "yamatsum/nvim-cursorline",
    config = function ()
      require('nvim-cursorline').setup()
    end }
  use { "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end }
  use { "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  }
  use 'kevinhwang91/nvim-bqf'
  use "kevinhwang91/nvim-hlslens" -- show number beside search highlight
  use "romainl/vim-cool" -- Handle highlight search automatically
  use { "norcalli/nvim-colorizer.lua", event = "BufRead",
    config = function() require("colorizer").setup() end }


  -- Folding
  use "eddiebergman/nvim-treesitter-pyfold"
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', }
  use { "nacro90/numb.nvim", event = "BufRead", --Peeking line before jump
    config = function() require("numb").setup() end, }
  use { "nvim-treesitter/nvim-treesitter-refactor", event = "BufRead" }
  -- Use treesitter to always show Class, function on top when overscrolled
  use { "romgrk/nvim-treesitter-context", }
  use { "p00f/nvim-ts-rainbow", event = "BufRead" } --Rainbow paranetheses
  use { "ray-x/lsp_signature.nvim",
    config = function() require('lsp_signature').setup() end }
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
    vim.keymap.set("n", "<leader>gg", "<CMD>FloatermNew lazygit<CR>", {desc="LazyGit"})
  end }

  use { "jpalardy/vim-slime",
    config = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1
      vim.b.slime_cell_delimiter = "# %%"
      vim.g.slime_no_mapping = 1
      vim.keymap.set("x", "<S-CR>", "<Plug>SlimeRegionSend '>") -- Send then move last line of selection
      vim.keymap.set("n", "<S-CR>", "<Plug>SlimeParagraphSend")
      vim.keymap.set("n", "<leader><CR>", "<Plug>SlimeSendCell '>")
    end
  }
  use { "ojroques/vim-oscyank", event = "CursorMoved",
    config = function()
      vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        command = "if v:event.regname is '+' | OSCYankReg + | endif"
      })
    end }
  use 'antoinemadec/FixCursorHold.nvim'
  use { "nvim-treesitter/playground", event = "BufRead", }

  -- Text Editting
  use { 'numToStr/Comment.nvim', requires = 'JoosepAlviste/nvim-ts-context-commentstring' }
  use { "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({ fast_wrap = {} }) -- <M-e>
    end }
  use {"ggandor/leap.nvim",
    config = function ()
      require("leap").set_default_keymaps()
    end}
  use{ "kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup({
          highlight_motion = {
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
    config = function() require("my.tabout") end, }

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
    config = function()
        require("bufresize").setup()
    end
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

  if is_bootstrap then
    require('packer').sync()
  end
end,
config = {
  max_jobs = 50, -- bugs, has to specificed a number
  display = { open_fn = require("packer.util").float },
}
})

require('legendary').setup()
require("my.keymaps")
require('impatient')
require("my.comment")
require("my.lsp")
require("my.null-ls")
require('my.cmp')
require("my.lualine")
require("my.telescope")
require("my.treesitter")
require("my.options")
require("my.fold")
require("my.colorscheme")
require("my.windows")

-- vim: ts=2 sts=2 sw=2 fdls=4 et
