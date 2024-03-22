return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>ce",
        "<Cmd>Neotree document_symbols toggle=true<CR>",
        desc = "Code symbol Explorer",
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
    event = "BufReadPost",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"aerial-*",},
        callback = function()
          vim.b.minicursorword_disable = true
        end,
      })
    end,
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
    cmd = { "UnstackFromSelection", "UnstackFromClipboard", "UnstackFromText" },
    keys = { { "<leader>uS", "<Cmd>UnstackFromClipboard<CR>", desc = "Un-stack trace" } },
  },
  { "HiPhish/rainbow-delimiters.nvim", event = "BufEnter" },
  { "tiagovla/scope.nvim", opts = {}, event = "VeryLazy" },
}
