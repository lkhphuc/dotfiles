return {
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
  { "RRethy/vim-illuminate", enabled = false },
  {
    "echasnovski/mini.cursorword",
    opts = {},
    event = "BufEnter",
  },
  {
    "echasnovski/mini.map",
    opts = function()
      local map = require("mini.map")
      return {
        symbols = {
          encode = require("mini.map").gen_encode_symbols.dot("4x2"),
        },
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic(),
        },
        window = {
          show_integration_count = false,
        },
      }
    end,
    keys = {
      { "<leader>mm", "<Cmd>lua MiniMap.toggle()<CR>", desc = "MiniMap" },
      { "<leader>mf", "<Cmd>lua MiniMap.toggle_focus()<CR>", desc = "MiniMap" },
      { "<leader>ms", "<Cmd>lua MiniMap.toggle_side()<CR>", desc = "MiniMap" },
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
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufEnter",
  },
}
