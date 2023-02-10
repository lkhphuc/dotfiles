return {
  -- Configured by from LazyVim
  -- mini.comment & ts-commentstring
  -- mini.bufremove
  -- mini.pairs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  {
    "echasnovski/mini.ai",
    opts = {
      custom_textobjects = {
        N = { "%f[%d]%d+" }, -- Numbers
        e = { -- Word with camel case
          {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
      },
    },
  },
  { "echasnovski/mini.align", config = true },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = { -- Emulate Tpope's original mapping
        add = "ys",
        delete = "ds",
        find = "]s",
        find_left = "[s",
        highlight = "vs",
        replace = "cs",
      },
    },
  },
  {
    "echasnovski/mini.trailspace",
    keys = {
      { "<leader>mt", function() require("mini.trailspace").trim() end, desc = "Trim white space" },
    },
  },

  { "ggandor/leap.nvim", enabled = false },
  { -- Jump as search, as many character as you like
    "rlane/pounce.nvim",
    keys = {
      { "s", "<Cmd>Pounce<CR>", mode = { "n", "v" } },
      { "S", "<Cmd>PounceRepeat<CR>", mode = { "n", "v" } },
      { "gs", "<Cmd>Pounce<CR>", mode = "o" },
      { "gS", "<Cmd>PounceRepeat<CR>", mode = "o" },
    },
  },
  {
    "echasnovski/mini.jump",
    keys = { "f", "F", "t", "T", ";" },
    config = function(_, opts) require("mini.jump").setup(opts) end,
  },
  { "tpope/vim-sleuth", event = "VeryLazy" }, --One plugin everything tab indent
  -- { "tpope/vim-unimpaired", event = "VeryLazy" },
  {
    "CKolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    config = true,
    keys = {
      {
        "U",
        function() require("ts-node-action").node_action() end,
        desc = "Node Action",
      },
    },
  },
  "chaoren/vim-wordmotion", -- w handles Snake/camelCase, etc
  { "ThePrimeagen/refactoring.nvim", config = true },
  {
    "Wansmer/sibling-swap.nvim",
    opts = { use_default_keymaps = false },
    keys = {
      { "gs[", function() require("sibling-swap").swap_with_left() end, desc = "Swap with previous sibling" },
      { "gs]", function() require("sibling-swap").swap_with_right() end, desc = "Swap with next sibling" },
      {
        "gS[",
        function() require("sibling-swap").swap_with_left() end,
        desc = "Swap with previous sibling and operator",
      },
      {
        "gS]",
        function() require("sibling-swap").swap_with_right_with_opp() end,
        desc = "Swap with next sibling and operator",
      },
    },
  },
  {
    "echasnovski/mini.move",
    config = function(_, opts) require("mini.move").setup(opts) end,
    keys = { { "<M-j>", mode = "x" }, { "<M-k>", mode = "x" }, { "<M-h>", mode = "x" }, { "<M-l>", mode = "x" } },
  },

  -- {"Dkendal/nvim-treeclimber",
  --   requires = 'rktjmp/lush.nvim',
  --   config = function()
  --     require('nvim-treeclimber').setup()
  --   end
  -- },
  -- {
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
}
