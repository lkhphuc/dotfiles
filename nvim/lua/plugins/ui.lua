return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false, -- a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = { -- add a border to hover docs and signature help
          views = { hover = { border = { style = "shadow" }, position = { row = 1, col = 1 } } },
        },
      },
      routes = {
        { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "E486" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "%d+L, %d+B" }, view = "mini" },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      window = { winblend = 10 },
      layout = {
        align = "center", -- align columns left, center or right
      },
    },
  },
  { "NvChad/nvim-colorizer.lua", event = "BufReadPost", config = true },

  { "kevinhwang91/nvim-bqf", ft = "qf" },
  { "nacro90/numb.nvim", event = "CmdlineEnter", config = true }, --Peeking line before jump

  -- use{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").register_lsp_virtual_lines()
  --   end,
  -- }
  --
  {
    "hydra.nvim",
    opts = {
      {
        name = "UI Options",
        hint = [[
  ^ ^        UI Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]],
        config = {
          color = "amaranth",
          invoke_on_body = true,
          hint = {
            border = "rounded",
            position = "middle",
          },
        },
        mode = { "n", "x" },
        body = "<leader>U",
        heads = {
          { "n", function() vim.o.number = not vim.o.number end, { desc = "number" } },
          { "r", function() vim.o.relativenumber = not vim.o.relativenumber end, { desc = "relativenumber" } },
          {
            "v",
            function()
              if vim.o.virtualedit == "all" then
                vim.o.virtualedit = "block"
              else
                vim.o.virtualedit = "all"
              end
            end,
            { desc = "virtualedit" },
          },
          { "i", function() vim.o.list = not vim.o.list end, { desc = "show invisible" } },
          { "s", function() vim.o.spell = not vim.o.spell end, { exit = true, desc = "spell" } },
          { "w", function() vim.o.wrap = not vim.o.wrap end, { desc = "wrap" } },
          { "c", function() vim.o.cursorline = not vim.o.cursorline end, { desc = "cursor line" } },
          { "<Esc>", nil, { exit = true } },
        },
      },
    },
  },
  { "nvim-zh/colorful-winsep.nvim", config = true, event = "WinNew" },
  { "m4xshen/smartcolumn.nvim", opts = {}, event = "BufReadPost" }, -- vertical
  {
    "tummetott/reticle.nvim",
    event = "VeryLazy", -- one cursorline per tab
    opts = {
      always = { cursorline = { "neo-tree" } },
    },
  },
}
