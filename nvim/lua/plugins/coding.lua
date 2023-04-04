return {
  -- Configured by from LazyVim
  -- mini.comment & ts-commentstring
  -- mini.bufremove
  -- mini.pairs
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
        x = function(ai_mode, _, _) -- Code Cell objects
          local buf_nlines = vim.api.nvim_buf_line_count(0)
          local begin_cell = 1 -- First cell from first line to first cell delimeter
          local res = {}
          for i = 1, buf_nlines do
            local cur_line = vim.fn.getline(i)
            if cur_line:sub(1, 4) == "# %%" then -- NOTE: Cell delimeter
              local end_cell = i - 1
              local region = {
                from = { line = begin_cell, col = 1 },
                to = { line = end_cell, col = vim.fn.getline(end_cell):len() },
              }
              table.insert(res, region)
              begin_cell = i
              if ai_mode == "i" then begin_cell = begin_cell + 1 end
            end
          end
          table.insert(res, { -- Last cell from last delimeter to end of file
            from = { line = begin_cell, col = 1 },
            to = { line = buf_nlines, col = vim.fn.getline(buf_nlines):len() },
          })
          return res
        end,
      },
    },
  },
  { "chrisgrieser/nvim-spider", lazy = true,
    keys = {
      { "w",  "<Cmd>lua require('spider').motion('w')<CR>",  mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "e",  "<Cmd>lua require('spider').motion('e')<CR>",  mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b",  "<Cmd>lua require('spider').motion('b')<CR>",  mode = { "n", "o", "x" }, desc = "Spider-b" },
      { "ge", "<Cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Spider-ge" },
    }
  },
  {
    "echasnovski/mini.align",
    opts = { mappings = { start = "", start_with_preview = "gA" } },
    config = function(_, opts) require("mini.align").setup(opts) end,
    keys = { "gA", desc = "Align with preview", mode = {"n", "v"}, },
  },
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
        update_n_lines = "",
      },
    },
  },
  {
    "echasnovski/mini.trailspace",
    keys = {
      {
        "<leader>mt",
        function() require("mini.trailspace").trim() end,
        desc = "Trim white space",
      },
    },
  },

  { "ggandor/leap.nvim", enabled = false },
  { "ggandor/flit.nvim", enabled = false },
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
  {
    "mini.indentscope",
    opts = {
      mappings = { goto_top = "[ai", goto_bottom = "]ai" },
      draw = { priority = 12 },
    },
  },
  { "tpope/vim-sleuth", event = "VeryLazy" }, --One plugin everything tab indent
  -- { "tpope/vim-unimpaired", event = "VeryLazy" },
  {
    "CKolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    config = true,
    keys = {
      {
        "ga",
        function() require("ts-node-action").node_action() end,
        desc = "Node Action",
      },
    },
  },
  -- { "chaoren/vim-wordmotion", event = "VeryLazy" }, -- w handles Snake/camelCase, etc
  { "ThePrimeagen/refactoring.nvim", config = true },
  {
    "Wansmer/sibling-swap.nvim",
    opts = { use_default_keymaps = false },
    keys = {
      {
        "gs[",
        function() require("sibling-swap").swap_with_left() end,
        desc = "Swap with previous sibling",
      },
      {
        "gs]",
        function() require("sibling-swap").swap_with_right() end,
        desc = "Swap with next sibling",
      },
      {
        "gS[",
        function() require("sibling-swap").swap_with_left_with_opp() end,
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
    keys = {
      { "<M-j>", mode = "x" },
      { "<M-k>", mode = "x" },
      { "<M-h>", mode = "x" },
      { "<M-l>", mode = "x" },
    },
  },
  {"lervag/vimtex", lazy=false},

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
