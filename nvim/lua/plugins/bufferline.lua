return {
  "akinsho/nvim-bufferline.lua",
  event = "BufAdd",
  opts = {
    options = {
      separator_style = "slant",
      groups = {
        options = {
          toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        },
        items = {
          {
            name = "Tests", -- Mandatory
            highlight = { underline = true, sp = "blue" }, -- Optional
            priority = 2, -- determines where it will appear relative to other groups (Optional)
            icon = "", -- Optional
            matcher = function(buf) -- Mandatory
              return buf.filename:match("%_test") or buf.filename:match("%_spec")
            end,
          },
          {
            name = "Docs",
            highlight = { undercurl = true, sp = "green" },
            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
            matcher = function(buf) return buf.filename:match("%.md") or buf.filename:match("%.txt") end,
            separator = { -- Optional
              style = require("bufferline.groups").separator.tab,
            },
          },
        },
      },
    },
  },
  keys = {
    { "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "Pick buffer close" },
    { "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
    { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>" },
    { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>" },
    { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>" },
    { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>" },
    { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>" },
    { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>" },
    { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>" },
    { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>" },
    { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>" },
    { "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>" },
  },
}
