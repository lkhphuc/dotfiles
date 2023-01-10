return {
  {'williamboman/mason.nvim', config = true, lazy = false },

  { "ThePrimeagen/refactoring.nvim", config = true, },

  { "aduros/ai.vim",
    init = function()
      vim.g.ai_no_mappings = 1
    end
  },
  {"blueyed/semshi",
    branch="handle-ColorScheme",
    ft = "python",
    build="UpdateRemotePlugins",
    init = function()
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
    end
  },
  -- 'AckslD/swenv.nvim',

  -- UI
  {"xiyaowong/nvim-transparent",
    cmd = "TransparentToggle",
    opts = {
      enable = false,
      -- extra_groups = 'all',
    }
  },
  { "nvim-zh/colorful-winsep.nvim", config = true },
  -- { "smjonas/live-command.nvim",
  --   opts = {
  --     commands = {
  --       Norm = { cmd = "norm" },
  --     }
  --   }
  -- },
  {'vimpostor/vim-tpipeline',
    init = function()
      vim.g.tpipeline_usepane = 1
      vim.g.tpipeline_clearstl = 1
    end
  },
  { "folke/zen-mode.nvim", config = true, cmd="ZenMode" },
  { "folke/todo-comments.nvim",
    config = true,
    event = "BufReadPost",
    cmd = { "TodoTrouble", "TodoTelescope" },
    keys = {
      "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODO",
    },
  },
  { "folke/twilight.nvim", config = true },

  {'kevinhwang91/nvim-bqf', ft="qf"},

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
  { "smjonas/inc-rename.nvim", config = true, cmd = "IncRename" },
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
  { "weilbith/nvim-code-action-menu" , cmd = "CodeActionMenu"},
  { 'kosayoda/nvim-lightbulb', opts = { autocmd = { enabled = true } } },
  -- use{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").register_lsp_virtual_lines()
  --   end,
  -- }
  { "mattboehm/vim-unstack",
    init = function() vim.g.unstack_mapkey = "<leader>us" end,
    keys = {"<leader>us", "<Cmd> Unstack<CR>"},
  },

  -- Git
  'tpope/vim-fugitive', -- Git commands in nvim
  -- 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  { "sindrets/diffview.nvim", event = "CmdlineEnter" },

  -- Terminal
  { 'numToStr/Navigator.nvim',
    keys = {
      {'<C-h>', '<CMD>NavigatorLeft<CR>'},
      {'<C-l>', '<CMD>NavigatorRight<CR>'},
      {'<C-k>', '<CMD>NavigatorUp<CR>'  },
      {'<C-j>', '<CMD>NavigatorDown<CR>'},
      {'<C-p>', '<CMD>NavigatorPrevious<CR>'},
    },
    config = true,
  },
  -- { "nikvdp/neomux", event = "VeryLazy",
  --   init = function()
  --     vim.g.neomux_win_num_status = ""
  --   end
  -- },
  { "voldikss/vim-floaterm",
    event = "VeryLazy",
    init = function()
      vim.g.floaterm_keymap_next   = '<End>' -- Hyper+o
      vim.g.floaterm_keymap_prev   = '<S-End>' -- Hyper+Command+o
      vim.g.floaterm_keymap_new    = '<S-Home>' -- Hyper+Command+i
      vim.g.floaterm_keymap_toggle = '<Home>' -- Hyper+i
      vim.g.floaterm_position      = 'center'
      vim.g.floaterm_width         = 0.9
      vim.g.floaterm_height        = 0.9
      vim.g.floaterm_autoinsert = false
    end
  },
  -- {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
  --   require("toggleterm").setup()
  -- end},
  { "romainchapou/nostalgic-term.nvim",
    event = "TermOpen",
    opts = {
      mappings = {
        {"<C-l>", "l"}, {"<C-h>", "h"}, {"<C-j>", "j"}, {"<C-k>", "k"},
      }
    },
  },

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
  { "lambdalisue/suda.vim" },

  -- Text Editting
  -- {"Dkendal/nvim-treeclimber",
  --   requires = 'rktjmp/lush.nvim',
  --   config = function()
  --     require('nvim-treeclimber').setup()
  --   end
  -- },
  -- {  -- TODO: learn how to use
  --   "cshuaimin/ssr.nvim",
  --   module = "ssr",
  --   -- Calling setup is optional.
  --   config = function()
  --     require("ssr").setup {
  --       min_width = 50,
  --       min_height = 5,
  --       keymaps = {
  --         close = "q",
  --         next_match = "n",
  --         prev_match = "N",
  --         replace_all = "<leader><cr>",
  --       },
  --     }
  --     vim.keymap.set({ "n", "x" }, "<leader>sR", require("ssr").open, {desc = "Structural Search and Replace"})
  --   end
  -- },
  {"rlane/pounce.nvim",
    cmd = "Pounce",
    keys = {
      {"s", "<Cmd>Pounce<CR>", mode={"n", "v"}},
      {"S", "<Cmd>PounceRepeat<CR>", mode={"n", "v"}},
      {"gs", "<Cmd>Pounce<CR>", mode="o"},
      {"gS", "<Cmd>PounceRepeat<CR>", mode="o"},
    },
  },
  "tpope/vim-repeat",
  "tpope/vim-sleuth", --One plugin everything tab indent
  "tpope/vim-unimpaired",
  { 'CKolkey/ts-node-action',
    dependencies = { 'nvim-treesitter' },
    config = true,
    keys = {
      { "U", function()require("ts-node-action").node_action()end, desc = "Trigger Node Action",  },
    },
  },
  "chaoren/vim-wordmotion",  -- w handles Snake/camelCase, etc
  { 'monaqa/dial.nvim',
    config = function ()
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
      vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
      vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
      vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
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
    opts = { highlight_moving_win = true }
  },

}
