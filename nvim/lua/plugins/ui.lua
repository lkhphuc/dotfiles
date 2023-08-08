return {
  { "nvim-notify", opts = {background_colour = "#1a1b26"}},
  { "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false, -- a classic bottom cmdline for search
        lsp_doc_border = { -- add a border to hover docs and signature help
          views = { hover = { border = { style = "shadow" }, position = { row = 1, col = 0 } } },
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "E486" },
              { find = "osc52" }
            }
          },
          view = "mini"
        },
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
  {
    "SmiteshP/nvim-navbuddy",
    event = "LspAttach",
    opts = { lsp = { auto_attach = true }, },
    keys = { {"<leader>cn", "<Cmd>Navbuddy<CR>", desc = "Code breadcrumbs Navigation"}, },
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      vim.o.foldcolumn = "1"
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        setopt = true,
        segments = {
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = { "%s" }, click = "v:lua.ScSa" },
        },
      })
    end,
    event = "VeryLazy",
  },
}
