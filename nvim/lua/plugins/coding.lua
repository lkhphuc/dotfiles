return {
  {
    "nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        markdown = {},
      },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
      {
        "<leader>*",
        function() require("flash").jump({ pattern = vim.fn.expand("<cword>") }) end,
        desc = "Jump with current word.",
      },
      {
        "<leader>k",
        function()
          require("flash").jump({
            action = function(match, state)
              vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                vim.lsp.buf.hover()
              end)
              state:restore()
            end,
          })
        end,
      },
    },
  },
  {
    "nvim-mini/mini.align",
    opts = { mappings = { start = "", start_with_preview = "gA" } },
    keys = { { "gA", desc = "Align with preview", mode = { "n", "x" } } },
  },
  {
    "abecodes/tabout.nvim",
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
  { "tpope/vim-sleuth", event = "VeryLazy" }, --One plugin everything tab indent
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
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = { -- Emulate Tpope's original mapping
        add = "ys",
        delete = "ds",
        find = "]s",
        find_left = "[s",
        highlight = "vs",
        replace = "cs",
        update_n_lines = "gsn",
      },
    },
  },
  { "nvim-mini/mini.operators", opts = {}, keys = { "g=", "gx", "gm", "gr", "gs" } },
  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
  {
    "saghen/blink.cmp",
    dependencies = {"milanglacier/minuet-ai.nvim"},
    opts = {
    keymap = {
        -- Manually invoke minuet completion.
        ['<C-a>'] = require('minuet').make_blink_map(),
    },
        sources = {
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            -- Should match minuet.config.request_timeout * 1000,
            -- since minuet.config.request_timeout is in seconds
            timeout_ms = 3000,
            score_offset = 50, -- Gives minuet higher priority among suggestions
          },
        },
      },
      -- Recommended to avoid unnecessary request
      completion = { trigger = { prefetch_on_insert = false } },
    },
  },
}
