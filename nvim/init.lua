--  __________________
-- < Bootstrap Packer >
--  ------------------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end
-- Autocommand that reloads neovim whenever you save this file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua', })
--  _________
-- < Plugins >
--  ---------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'nvim-lua/plenary.nvim' -- Lua utility helpers
  -- use 'folke/lua-dev.nvim' -- Dev setup for init.lua and plugin
  use 'neovim/nvim-lspconfig' -- Configs for built-in LSP client
  use 'williamboman/nvim-lsp-installer' -- Auto install language servers
  -- use 'jose-elias-alvarez/null-ls.nvim'  -- Create ls from external programs
  use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management

  -- Completion
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'rafamadriz/friendly-snippets'
  use 'saadparwaiz1/cmp_luasnip'
  use 'quangnguyen30192/cmp-nvim-tags'
  --use {'tzachar/cmp-tabnine', run='./install.sh' }
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
  -- Languages
  use "eddiebergman/nvim-treesitter-pyfold"
  use {"blueyed/semshi", branch="handle-ColorScheme",
    run="<cmd>UpdateRemotePlugin<cr>"}

  -- UI
  use 'nvim-lua/popup.nvim'
  use 'moll/vim-bbye'
  use 'nvim-lualine/lualine.nvim'
-- SideBars
  use {'kyazdani42/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        diagnostics = { enable = true }
      })
    end }
  use {"simrat39/symbols-outline.nvim",
    config = function() vim.cmd[[nmap <C-m> :SymbolsOutline<CR>]] end}
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
        show_end_of_line     = true,
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
  use { "yamatsum/nvim-cursorline", event = "BufRead",
    config = function ()
      require('nvim-cursorline').setup()
    end }
  use { "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end }
  use "SmiteshP/nvim-gps"
  use 'kevinhwang91/nvim-bqf'
  use "kevinhwang91/nvim-hlslens" -- show number beside search highlight
  use "romainl/vim-cool" -- Handle highlight search automatically
  use { "norcalli/nvim-colorizer.lua", event = "BufRead",
    config = function() require("colorizer").setup() end }
  use { 'anuvyklack/pretty-fold.nvim', requires = 'anuvyklack/nvim-keymap-amend',
   config = function()
      require('pretty-fold').setup {}
      require('pretty-fold.preview').setup({border = "shadow"})
   end }
  use { "nacro90/numb.nvim", event = "BufRead", --Peeking line before jump
    config = function() require("numb").setup() end, }
  use { "nvim-treesitter/nvim-treesitter-refactor", event = "BufRead" }
  -- Use treesitter to always show Class, function on top when overscrolled
  use { "romgrk/nvim-treesitter-context", event = "BufRead" }
  use { "p00f/nvim-ts-rainbow", event = "BufRead" } --Rainbow paranetheses
  use { "ray-x/lsp_signature.nvim",
    config = function() require('lsp_signature').setup() end }
  use { "folke/trouble.nvim", event = "BufEnter",
    config = function()
      require("trouble").setup()
    end
  }
  use { "weilbith/nvim-code-action-menu" }
  use { "mattboehm/vim-unstack",
    key = "<leader>us", command = ":unstack*",
    config = function() vim.g.unstack_mapkey = "<leader>us" end, }
  use { "kosayoda/nvim-lightbulb", event = "InsertLeave" }

  -- Git
  use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use { "sindrets/diffview.nvim", event = "CmdlineEnter" }
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function() require('my.gitsigns') end }


  -- Terminal
  use 'christoomey/vim-tmux-navigator'
  use { "nikvdp/neomux", event = "BufEnter", }
  use { "voldikss/vim-floaterm", config = function()
    vim.g.floaterm_keymap_next   = '<End>' -- Hyper+o
    vim.g.floaterm_keymap_prev   = '<S-End>' -- Hyper+Command+o
    vim.g.floaterm_keymap_new    = '<S-Home>' -- Hyper+Command+i
    vim.g.floaterm_keymap_toggle = '<Home>' -- Hyper+i
    vim.g.floaterm_position      = 'center'
    vim.g.floaterm_width         = 0.9
    vim.g.floaterm_height        = 0.9
    vim.keymap.set("n", "<leader>lg", "<CMD>FloatermNew lazygit<CR>")
    vim.keymap.set("n", "<leader>lf", "<Cmd>FloatermNew lf <CR>")
    -- vim.cmd [[nnoremap <leader>lg <Cmd>FloatermNew lazygit <CR>]]
    -- vim.cmd [[nnoremap <leader>lf <Cmd>FloatermNew lf <CR>]]
  end }

  use { "jpalardy/vim-slime",
    config = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1
    end }
  use { "klafyvel/vim-slime-cells",
    requires = { { 'jpalardy/vim-slime', opt = true } },
    ft = { 'julia', 'python' },
    config = function()
      vim.g.slime_cell_delimiter = "^\\s*##\\s*"
      vim.cmd([[
      nmap <C-c><CR> <Plug>SlimeCellsSendAndGoToNext
      nmap <C-c>j <Plug>SlimeCellsNext
      nmap <C-c>k <Plug>SlimeCellsPrev
      ]])
    end
  }
  use { "ojroques/vim-oscyank", event = "CursorMoved",
    config = function()
      vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        command = "if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif"
      })
    end }
  use 'antoinemadec/FixCursorHold.nvim'
  -- use { "nvim-treesitter/playground", event = "BufRead", }

  -- Text Editting
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
         pre_hook = function(ctx)
          local U = require 'Comment.utils'

          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
          end

          return require('ts_context_commentstring.internal').calculate_commentstring {
            key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
            location = location,
    }
  end,
      })
    end,
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use { "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({ fast_wrap = {} }) -- <M-e>
    end }
  use {"ggandor/leap.nvim",
    config = function ()
      require("leap").set_default_keymaps()
    end}
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-sleuth" --One plugin everything tab indent
  use "tpope/vim-unimpaired"
  use "andymass/vim-matchup"
  use "junegunn/vim-easy-align"
  use "AndrewRadev/splitjoin.vim" -- gS and gJ
  -- {"mg979/vim-visual-multi"},
  use "wellle/targets.vim" -- Text objects qoute,block,argument,delimiter
  use "kana/vim-textobj-user"
  use "chaoren/vim-wordmotion"  -- w handles Snake/camelCase, etc
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- use 'mfussenegger/nvim-treehopper'
  use { "abecodes/tabout.nvim", after = { "nvim-cmp", "nvim-treesitter", },
    config = function() require("my.tabout") end, }

  use 'mrjones2014/legendary.nvim' -- Command Pallate
  use 'folke/which-key.nvim'

  -- Colorscheme
  use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
  use { "RRethy/nvim-base16" }
  -- use { "rmehri01/onenord.nvim",
  --   config = require('onenord').setup({
  --     italic = { comments = true, keywords = true }
  --   }) }
  use { "rebelot/kanagawa.nvim" }
  use { "olimorris/onedarkpro.nvim",
    config = function()
      require("onedarkpro").setup({
        options = { bold = true, italic = true, underline = true, undercurl = true, }
      })
    end }
  use "projekt0n/github-nvim-theme"
  use { "sainnhe/edge",
    config = function()
      vim.g.edge_better_performance = 1
      vim.g.edge_enable_italic = 1
    end }
  use "cpea2506/one_monokai.nvim"

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end,
config = {
  max_jobs = 69, -- bugs, has to specificed a number
  display = { open_fn = require("packer.util").float },
} })

require('legendary').setup()
require('impatient')
require("my.lsp")
require('my.cmp')
require("my.lualine")
require("my.telescope")
require("my.treesitter")
require("my.options")
require("my.keymaps")

-- Visual command
vim.cmd [[
  colorscheme kanagawa |
  highlight BufferCurrent gui=bold,italic |
  highlight TSKeyword gui=bold,italic |
  highlight TSKeywordFunction gui=bold,italic |
  highlight TSVariableBuiltin gui=italic |
  highlight TSInclude gui=bold,italic
]]
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = " setlocal listchars= nonumber norelativenumber",
})
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim: ts=2 sts=2 sw=2 et
