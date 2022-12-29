return {
  'nvim-lua/plenary.nvim', -- Lua utility helpers
  {'williamboman/mason.nvim', config = true, lazy = false },

  { "ThePrimeagen/refactoring.nvim", config = true, },

  { "aduros/ai.vim",
    init = function()
      vim.g.ai_no_mappings = 1
    end
  },
  {"blueyed/semshi",
    branch="handle-ColorScheme",
    build="UpdateRemotePlugin",
    config = function()
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
    end
  },
  -- 'AckslD/swenv.nvim',

  -- UI
  {"xiyaowong/nvim-transparent",
    config = {
      enable = false,
      -- extra_groups = 'all',
    }
  },
  { "nvim-zh/colorful-winsep.nvim", config = true },
  'nvim-lua/popup.nvim',
  'stevearc/dressing.nvim',
  "MunifTanjim/nui.nvim",
  {'rcarriga/nvim-notify',
    event = "VeryLazy",
    config = {
      timeout = 3000,
      level = vim.log.levels.INFO,
      fps = 20,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_option(win, "winblend", 20)
      end,
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>ls", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  'kyazdani42/nvim-web-devicons',

  { "smjonas/live-command.nvim",
    config = {
      commands = {
        Norm = { cmd = "norm" },
      }
    }
  },
  {'vimpostor/vim-tpipeline',
    init = function()
      vim.g.tpipeline_usepane = 1
      vim.g.tpipeline_clearstl = 1
    end
  },
  { "Pocco81/true-zen.nvim",
    config = function()
      local truezen = require('true-zen')
      truezen.setup()
      vim.keymap.set('n', '<leader>zn', function() truezen.narrow(0, vim.api.nvim_buf_line_count(0)) end, {})
      vim.keymap.set('v', '<leader>zn', function() truezen.narrow(vim.fn.line('v'), vim.fn.line('.')) end, {})
      vim.keymap.set('n', '<leader>zf', truezen.focus, {})
      vim.keymap.set('n', '<leader>zm', truezen.minimalist, {})
      vim.keymap.set('n', '<leader>za', truezen.ataraxis, {})
    end,
  },

  { "folke/todo-comments.nvim",
    event = "BufReadPost",
    cmd = { "TodoTrouble", "TodoTelescope" },
    keys = {
      "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODO",
    },
  },
  { "folke/twilight.nvim", config = true },

  -- SideBars
  {'kyazdani42/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        diagnostics = { enable = true }
      })
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {desc = "Explorer" })
    end },
  {"simnalamburt/vim-mundo",
    keys = {{"<leader>uu", "<cmd>MundoToggle<CR>", desc = "Mundo"}},
  },


  {'kevinhwang91/nvim-bqf', ft="qf"},
  { "kevinhwang91/nvim-hlslens", -- show number beside search highlight
    config = function()
      local hlslens = require("hlslens")
      hlslens.setup({ calm_down = true, })
      vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
      vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
      vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
      vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
      vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
      vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])
      -- run `:nohlsearch` and export results to quickfix
      -- if Neovim is 0.8.0 before, remap yourself.
      vim.keymap.set({'n', 'x'}, '<leader>L', function()
        vim.schedule(function()
          if require('hlslens').exportLastSearchToQuickfix() then
            vim.cmd('cw')
          end
        end)
        return ':noh<CR>'
      end, {expr = true})
    end,
  },

  { "nacro90/numb.nvim", event = "BufRead", config = true, }, --Peeking line before jump
  {'m-demare/hlargs.nvim',
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
  },
  { "smjonas/inc-rename.nvim", config = true, },
  { "mizlan/iswap.nvim"},
  { "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
      require("which-key").register({["<leader>x"] = {name = "Trouble"}})
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", {desc="Trouble Toggle"})
      vim.keymap.set("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", {desc = "References" })
      vim.keymap.set("n", "<leader>xf", "<cmd>TroubleToggle lsp_definitions<cr>", {desc = "Definitions" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {desc = "Diagnosticss" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {desc = "QuickFix" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {desc="LocationList" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {desc = "Diagnosticss" })
    end
  },
  { "weilbith/nvim-code-action-menu" },
  -- use{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").register_lsp_virtual_lines()
  --   end,
  -- }
  { "mattboehm/vim-unstack",
    init = function() vim.g.unstack_mapkey = "<leader>us" end,
    keys = "<leader>us",
  },

  -- Git
  'tpope/vim-fugitive', -- Git commands in nvim
  -- 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  { "sindrets/diffview.nvim", event = "CmdlineEnter" },

  -- Terminal
  { 'numToStr/Navigator.nvim',
    init = function()
      vim.keymap.set('n', '<C-h>', '<CMD>NavigatorLeft<CR>')
      vim.keymap.set('n', '<C-l>', '<CMD>NavigatorRight<CR>')
      vim.keymap.set('n', '<C-k>', '<CMD>NavigatorUp<CR>')
      vim.keymap.set('n', '<C-j>', '<CMD>NavigatorDown<CR>')
      vim.keymap.set('n', '<C-p>', '<CMD>NavigatorPrevious<CR>')
    end,
    config = true,
  },
  { "nikvdp/neomux",
    init = function()
      vim.g.neomux_win_num_status = ""
    end
  },
  { "voldikss/vim-floaterm",
    init = function()
      vim.g.floaterm_keymap_next   = '<End>' -- Hyper+o
      vim.g.floaterm_keymap_prev   = '<S-End>' -- Hyper+Command+o
      vim.g.floaterm_keymap_new    = '<S-Home>' -- Hyper+Command+i
      vim.g.floaterm_keymap_toggle = '<Home>' -- Hyper+i
      vim.g.floaterm_position      = 'center'
      vim.g.floaterm_width         = 0.9
      vim.g.floaterm_height        = 0.9
    end
  },
  -- {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
  --   require("toggleterm").setup()
  -- end},

  { "jpalardy/vim-slime",
    event = "TermOpen",
    config = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mapping = 1
      vim.keymap.set("n", "<S-CR>", "<Plug>SlimeSend")
      vim.keymap.set("x", "<S-CR>", "<Plug>SlimeRegionSend")
      -- vim.keymap.set("n", "<S-CR>", "<Plug>SlimeParagraphSend")
      -- vim.keymap.set("n", "<leader><CR>", "<Plug>SlimeSendCell '>")
    end
  },
  {"hanschen/vim-ipython-cell",
    ft="python",
    init = function()
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
  },
  { "goerz/jupytext.vim" },
  {'ojroques/nvim-osc52',
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
  },
  { "lambdalisue/suda.vim" },
  { "nvim-treesitter/playground", event = "BufRead", },

  -- Text Editting
  -- {"Dkendal/nvim-treeclimber",
  --   requires = 'rktjmp/lush.nvim',
  --   config = function()
  --     require('nvim-treeclimber').setup()
  --   end
  -- },
  {  -- TODO: learn how to use
    "cshuaimin/ssr.nvim",
    module = "ssr",
    -- Calling setup is optional.
    config = function()
      require("ssr").setup {
        min_width = 50,
        min_height = 5,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_all = "<leader><cr>",
        },
      }
      vim.keymap.set({ "n", "x" }, "<leader>sR", require("ssr").open, {desc = "Structural Search and Replace"})
    end
  },
  {"rlane/pounce.nvim",
    config = function ()
      vim.keymap.set({"n", "v"}, "s", "<Cmd>Pounce<CR>")
      vim.keymap.set("o", "gs", "<Cmd>Pounce<CR>")
    end
  },
  "tpope/vim-repeat",
  "tpope/vim-sleuth", --One plugin everything tab indent
  "tpope/vim-unimpaired",
  "AndrewRadev/splitjoin.vim", -- gS and gJ
  { 'Wansmer/treesj', config = true },
  "kana/vim-textobj-user",
  "chaoren/vim-wordmotion",  -- w handles Snake/camelCase, etc
  'nvim-treesitter/nvim-treesitter-textobjects',
  'RRethy/nvim-treesitter-textsubjects', -- smart
  'mfussenegger/nvim-treehopper',
  { 'monaqa/dial.nvim',
    config = function ()
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
      vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), {noremap = true})
      vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), {noremap = true})
    end
  },

  {"gbrlsnchs/winpick.nvim",
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
  },
  { 'mrjones2014/smart-splits.nvim',
    dependencies = {"kwkarlwang/bufresize.nvim", config = true, },
    config = function()
      require('smart-splits').setup({
        resize_mode = {
          hooks = { on_leave = require('bufresize').register, },
        },
      })
    end
  },
  {'sindrets/winshift.nvim',
    config = { highlight_moving_win = true }
  },
{'anuvyklack/hydra.nvim', },

}
