--  __________________
-- < Bootstrap Packer >
--  ------------------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap ensure_packer()
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
  use 'folke/neodev.nvim' -- Dev setup for init.lua and plugin
  use 'neovim/nvim-lspconfig' -- Configs for built-in LSP client
  use { "williamboman/mason.nvim", }
  use { "williamboman/mason-lspconfig.nvim", }
  use 'jose-elias-alvarez/null-ls.nvim'  -- Create ls from external programs
  use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate", }
  use {"yioneko/nvim-yati"}
  use {"tzachar/fuzzy.nvim"}
  -- Completion
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'rafamadriz/friendly-snippets'
  use 'saadparwaiz1/cmp_luasnip'
  use 'quangnguyen30192/cmp-nvim-tags'
  -- use {'tzachar/cmp-tabnine', run='./install.sh' }
  use { "zbirenbaum/copilot.lua",
    event = {"VimEnter"},
    config = function()
      vim.defer_fn(function() require("copilot").setup() end, 100)
    end,
  }
  use { "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function () require("copilot_cmp").setup() end
  }
  use 'lukas-reineke/cmp-rg'
  use "ray-x/cmp-treesitter"
  use 'tzachar/cmp-fuzzy-buffer'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol' -- For / search command
  use 'tzachar/cmp-fuzzy-path'
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

  use { "ThePrimeagen/refactoring.nvim",
    config = function ()
      require("refactoring").setup() -- Use null-ls code action
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
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {'echasnovski/mini.nvim',
    config = function()
      require('mini.cursorword').setup({})

      require('mini.bufremove').setup({})
      vim.keymap.set("n", "<leader>bd", MiniBufremove.delete, {desc="Delete buffer"})
      vim.keymap.set("n", "<leader>bu", MiniBufremove.unshow, {desc="Unshow buffer"})

      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup({
        custom_textobjects = {
          F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          C = spec_treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          o = spec_treesitter({
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          }, {}),
          t = spec_treesitter({ a = '@block.outer', i = '@block.inner' }, {}),
        }
      })

      require('mini.align').setup({})

      require('mini.comment').setup({
        hooks = {
          pre = function()
            require('ts_context_commentstring.internal').update_commentstring({})
          end
        }
      })

      require('mini.indentscope').setup({
        symbol = "▏", -- '╎', "▏", "│", "┊", "┆",
      })  -- Define ai/ii object
      local map = require('mini.map')
      map.setup({
        symbols = {
          encode = map.gen_encode_symbols.dot('4x2'),
        },
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic(),
        },
        window = {
          show_integration_count = false,
        }
      })
      vim.keymap.set('n', '<Leader>mc', MiniMap.close, {desc="Map close."})
      vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus, {desc="Map focus"})
      vim.keymap.set('n', '<Leader>mr', MiniMap.refresh, {desc="Map refresh"})
      vim.keymap.set('n', '<Leader>ms', MiniMap.toggle_side, {desc="Map switch side"})
      vim.keymap.set('n', '<Leader>mm', MiniMap.toggle, {desc="Map Toggle"})

      require('mini.jump').setup({})

      require('mini.pairs').setup({})

      local starter = require('mini.starter')
      starter.setup({
          items = {
            starter.sections.builtin_actions(),
            starter.sections.telescope(),
            starter.sections.recent_files(),
            starter.sections.sessions(),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning('center', 'center'),
        },
      })

      require('mini.trailspace').setup({})
      vim.keymap.set('n', '<leader>mt', MiniTrailspace.trim, {desc="Trim trailing whitespace."})
    end
  }
  -- UI
  use {"xiyaowong/nvim-transparent",
    config = function()
      require("transparent").setup({
        enable = false,
        -- extra_groups = 'all',
      })
    end
  }
  use {
    "nvim-zh/colorful-winsep.nvim",
    config = function ()
      require('colorful-winsep').setup()
    end
  }
  use 'nvim-lua/popup.nvim'
  use 'stevearc/dressing.nvim'
  use {'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        on_open = function(win)
          vim.api.nvim_win_set_option(win, "winblend", 20)
        end,
      })
    end
  }
  use {
    "smjonas/live-command.nvim",
    config = function()
      require("live-command").setup {
        commands = {
          Norm = { cmd = "norm" },
        },
      }
    end,
  }
  use({ "folke/noice.nvim",
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,  -- use lsp_signature
          }
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "search_count",
            },
            opts = { skip = true },
          },
        },
        smart_move = {
          enabled = true, -- you can disable this behaviour here
          excluded_filetypes = { "notify" },
        },
      })
      vim.keymap.set("n", "<leader>ml", function()
        require("noice").cmd("last")
      end, {desc="Message last"})

      vim.keymap.set("n", "<leader>mh", function()
        require("noice").cmd("history")
      end, {desc="Message history"})
      vim.keymap.set("n", "<leader>md", require("notify").dismiss, {desc="Dimiss notification"})
    end,
  })
  use({ "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").init_lsp_saga({
        code_action_icon ='',
        code_action_lightbulb = {enable_in_insert = false, virtual_text = false,},
        symbol_in_winbar = { in_custom = true, show_file = false},
        definition_action_keys = {
          edit   = '<C-w>o',
          vsplit = '<C-w>v',
          split  = '<C-w>s',
          tabe   = '<C-w><tab>',
          quit   = 'q',
        },
      })
    end,
})
  use {"b0o/incline.nvim"}
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
      vim.keymap.set('n', '<leader>zn', function() truezen.narrow(0, vim.api.nvim_buf_line_count(0)) end, {})
      vim.keymap.set('v', '<leader>zn', function() truezen.narrow(vim.fn.line('v'), vim.fn.line('.')) end, {})
      vim.keymap.set('n', '<leader>zf', truezen.focus, {})
      vim.keymap.set('n', '<leader>zm', truezen.minimalist, {})
      vim.keymap.set('n', '<leader>za', truezen.ataraxis, {})
    end,
  }

  use { "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup { }
      vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", {desc = "TODO" })
    end
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
  use {"simnalamburt/vim-mundo",
    key = "<leader>uu", command = ":MundoToggle",
    config = function() vim.cmd [[nmap <leader>u :MundoToggle<CR>]] end}
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind.nvim' -- Add pictogram to LSP

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use { 'LukasPietzschmann/telescope-tabs',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require'telescope-tabs'.setup{ }
    end
  }
  use { 'nvim-telescope/telescope.nvim' }

  use {"delphinus/auto-cursorline.nvim",
    config=function () require("auto-cursorline").setup() end}
  use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig", }
  use {'kevinhwang91/nvim-bqf', ft="qf"}
  use { "kevinhwang91/nvim-hlslens", -- show number beside search highlight
    config = function()
      local hlslens = require("hlslens")
      hlslens.setup({ calm_down = true, })
      local kopts = {noremap = true, silent = true}
      vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      -- Search selected text with * and #
      vim.keymap.set("n", "*", "", {
        callback = function()
          vim.fn.execute("normal! *N")
          hlslens.start()
        end,
      })
      vim.keymap.set("n", "#", "", {
        callback = function()
          vim.fn.execute("normal! #N")
          hlslens.start()
        end,
      })
    end,
  }
  use {'joeytwiddle/sexy_scroller.vim',}
  use { "NvChad/nvim-colorizer.lua", event = "BufRead",
    config = function() require("colorizer").setup({}) end
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
  use {'m-demare/hlargs.nvim',
    config = function() require("hlargs").setup({
      excluded_filetypes = {"python"},
      excluded_argnames = {
        declarations = {
          python = {"self", "cls"},
        },
        usages = {
          python = { 'self', 'cls' },
          lua = { 'self' }
        }
      },
    }) end
  }
  use { "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  }
  use { "mizlan/iswap.nvim"}
  use { "ray-x/lsp_signature.nvim",
    config = function()
      require('lsp_signature').setup({
        noice = true,
        toggle_key = "<C-e>",  -- Similar to cmp abort
        select_signature_key = "<C-n>",
      })
    end
  }
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
  -- use{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").register_lsp_virtual_lines()
  --   end,
  -- }
  use { "mattboehm/vim-unstack",
    key = "<leader>us", command = ":unstack*",
    config = function() vim.g.unstack_mapkey = "<leader>us" end, }
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
    config = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mapping = 1
      vim.keymap.set("n", "<S-CR>", "<Plug>SlimeSend")
      vim.keymap.set("x", "<S-CR>", "<Plug>SlimeRegionSend")
      -- vim.keymap.set("n", "<S-CR>", "<Plug>SlimeParagraphSend")
      -- vim.keymap.set("n", "<leader><CR>", "<Plug>SlimeSendCell '>")
    end
  }
  use {"hanschen/vim-ipython-cell",
    filetype="python",
    config = function()
      vim.g.slime_python_ipython = 1
      vim.keymap.set("n", "<leader>ri", "<Cmd>SlimeSend1 ipython --matplotlib --ext=autoreload<CR>", {desc = "Run interpreter"})
      vim.keymap.set("n", "<leader>ra", "<Cmd>SlimeSend1 %autoreload 2<CR>", {desc = "Autoreload python module"})
      vim.keymap.set("n", "<leader>rd", "<Cmd>SlimeSend1 %debug<CR>", {desc = "Debug ipython"})
      vim.keymap.set("n", "<leader>re", "<Cmd>SlimeSend1 exit<CR>", {desc = "Exit"})
      vim.keymap.set("n", "<leader>rs", "<Cmd>IPythonCellRun<CR>", {desc = "Run script"})
      vim.keymap.set("n", "<leader>rS", "<Cmd>IPythonCellRunTime<CR>", {desc = "Run script and time it"})
      vim.keymap.set("n", "<leader>rc", "<Cmd>IPythonCellClear<CR>", {desc = "Clear IPython screen"})
      vim.keymap.set("n", "<leader>rx", "<Cmd>IPythonCellClose<CR>", {desc = "Close all matplotlib figure windows"})
      vim.keymap.set("n", "<leader>rp", "<Cmd>IPythonCellPrevCommand<CR>", {desc = "Run Previous command"})
      vim.keymap.set("n", "<leader>rR", "<Cmd>IPythonCellRestart<CR>", {desc = "Restart ipython"})
      vim.keymap.set("n", "<leader>cc", "<Cmd>IPythonCellExecuteCellJump<CR>", {desc = "Execute and jumpt to next cell"})
      vim.keymap.set("n", "<leader>cC", "<Cmd>IPythonCellExecuteCell<CR>", {desc = "Execute cell"})
      vim.keymap.set("n", "<leader>cj", "<Cmd>IPythonCellNextCell<CR>", {desc = "Jump to previous cell"})
      vim.keymap.set("n", "<leader>ck", "<Cmd>IPythonCellNextCell<CR>", {desc = "Jump to next cell"})
      vim.keymap.set("n", "<leader>ci", "<Cmd>IPythonCellInsertAbove<CR>i", {desc = "Insert new cell above"})
      vim.keymap.set("n", "<leader>ca", "<Cmd>IPythonCellNextCell<CR>i", {desc = "Insert new cell below"})
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
  use { "lambdalisue/suda.vim" }
  use { 'antoinemadec/FixCursorHold.nvim' }
  use { "nvim-treesitter/playground", event = "BufRead", }

  -- Text Editting
  use {"rlane/pounce.nvim",
    config = function ()
      vim.keymap.set({"n", "v"}, "s", "<Cmd>Pounce<CR>")
      vim.keymap.set("o", "gs", "<Cmd>Pounce<CR>")
    end
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
  use "AndrewRadev/splitjoin.vim" -- gS and gJ
  use "kana/vim-textobj-user"
  use "chaoren/vim-wordmotion"  -- w handles Snake/camelCase, etc
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'RRethy/nvim-treesitter-textsubjects' -- smart
  use 'mfussenegger/nvim-treehopper'
  use { "abecodes/tabout.nvim", after = { "nvim-cmp", "nvim-treesitter", },
    config = function() require("my.tabout") end,
  }
  use {'monaqa/dial.nvim',
    config = function ()
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal, {noremap = true})
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal, {noremap = true})
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual, {noremap = true})
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual, {noremap = true})
      vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual, {noremap = true})
      vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual, {noremap = true})
    end}

  use {"gbrlsnchs/winpick.nvim",
    config = function()
      local winpick = require("winpick")
      local function filter (winid, bufid)
        return vim.api.nvim_win_get_config(winid).relative == ""
      end
      winpick.setup({filter=filter})
      vim.keymap.set("n", "<C-w>0", function ()
        local winid = winpick.select()
        if winid then vim.api.nvim_set_current_win(winid) end
      end)
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

  if packer_bootstrap then
    require('packer').sync()
  end
end

require('packer').startup({
  packer_plugins,
  config = {
    max_jobs = 50, -- bugs, has to specificed a number
    display = { open_fn = require("packer.util").float },
  }
})
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
