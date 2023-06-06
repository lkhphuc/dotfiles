return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = { width = 30 },
      -- source_selector = { winbar = true },
    },
  },
  { "stevearc/oil.nvim", cmd = "Oil", opts = {} },

  { -- Undo tree
    "simnalamburt/vim-mundo",
    cmd = "MundoToggle",
    keys = { { "<leader>uu", "<cmd>MundoToggle<CR>", desc = "Undo" } },
  },
  
  {
    "simrat39/symbols-outline.nvim",
    opts = {
      keymaps = {
        fold_all = "H",
        unfold_all = "L",
      }
    },
    keys = {
      { "<leader>co", "<Cmd>SymbolsOutline<Cr>", "Symbols Outline" } }
  },

  {
    "echasnovski/mini.map",
    config = function()
      local map = require("mini.map")
      map.setup({
        symbols = {
          encode = require("mini.map").gen_encode_symbols.dot("4x2"),
        },
        integrations = {
          require("mini.map").gen_integration.builtin_search(),
          require("mini.map").gen_integration.gitsigns(),
          require("mini.map").gen_integration.diagnostic(),
        },
        window = {
          show_integration_count = false,
        },
      })
    end,
    keys = {
      { "<leader>mm", "<Cmd>lua MiniMap.toggle()<CR>", desc = "MiniMap" },
      { "<leader>mf", "<Cmd>lua MiniMap.toggle_focus()<CR>", desc = "MiniMap" },
      { "<leader>ms", "<Cmd>lua MiniMap.toggle_side()<CR>", desc = "MiniMap" },
    },
  },
  -- { "smjonas/live-command.nvim",
  --   opts = { commands = { Norm = { cmd = "norm" }, } }
  -- },

  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Trouble Toggle" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "References (Trouble)" },
      { "<leader>xf", "<cmd>TroubleToggle lsp_definitions<cr>", desc = "Definitions (Trouble)" },
      {
        "<leader>xd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics (Trouble)",
      },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "QuickFix (Trouble)" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "LocationList (Trouble)" },
    },
  },

  {
    "mattboehm/vim-unstack",
    init = function() vim.g.unstack_mapkey = "<leader>uS" end,
    keys = { { "<leader>uS", "<Cmd>Unstack<CR>", desc = "Un-stack trace" } },
  },
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    opts = {
      comment = { suffix = "gc" }, -- ]c is for git/diff change
      indent = { options = { change_type = "diff" } },
      treesitter = { suffix = "n" },
    },
    config = function(_, opts) require("mini.bracketed").setup(opts) end,
  },
  { "RRethy/vim-illuminate", enabled = false },
  {
    "echasnovski/mini.cursorword",
    config = function(_, opts) require("mini.cursorword").setup(opts) end,
    event = "VeryLazy",
  },
}
