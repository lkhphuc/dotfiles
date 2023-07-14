return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>ge",
        function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end,
        desc = "Git status explorer",
      },
      {
        "<leader>be",
        function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end,
        desc = "Buffer explorer",
      },
    },
  },
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
      },
    },
    cmd = "SymbolsOutline",
    keys = {
      { "<leader>co", "<Cmd>SymbolsOutline<Cr>", "Symbols Outline" },
    },
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
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "References (Trouble)" },
      { "<leader>xd", "<cmd>TroubleToggle lsp_definitions<cr>", desc = "Definitions (Trouble)" },
    },
  },

  {
    "mattboehm/vim-unstack",
    cmd = { "UnstackFromSelection", "UnstackFromClipboard", "Unstack" },
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
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufEnter",
  },
}
