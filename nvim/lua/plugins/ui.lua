return {
  { "nvim-notify", opts = { background_colour = "NormalFloat" } },
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
        {
          filter = {
            event = "notify",
            any = {
              { find = "No information available"}
            }
          },
          view = "mini",
        }
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
    "aerial.nvim",
    init = function ()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "aerial*",
        callback = function () vim.b.minicursorword_disable = true end
      })
    end,
    opts = {
      nav = { preview = true, keymaps = { q = "actions.close", } },
    },
    keys = { { "<leader>cn", "<Cmd>AerialNavToggle<CR>", desc = "Code navigation" }, }
  },
}
