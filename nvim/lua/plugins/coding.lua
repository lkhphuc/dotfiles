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
    "nvim-mini/mini.indentscope",
    opts = {
      mappings = { goto_top = "[ai", goto_bottom = "]ai" },
      draw = { priority = 12 },
    },
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
  { "indent-blankline.nvim", enabled = false },
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
}
