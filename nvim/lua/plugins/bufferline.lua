local M = {
  "akinsho/nvim-bufferline.lua",
  event = "BufAdd",
}

function M.config()
  local signs = require("plugins.lsp.diagnostics").signs

  signs = {
    error = signs.Error,
    warning = signs.Warn,
    info = signs.Info,
    hint = signs.Hint,
  }

  local severities = {
    "error",
    "warning",
    -- "info",
    -- "hint",
  }

  require("bufferline").setup({
    options = {
      show_close_icon = true,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      separator_style = "slant",
      diagnostics_indicator = function(_, _, diag)
        local s = {}
        for _, severity in ipairs(severities) do
          if diag[severity] then
            table.insert(s, signs[severity] .. " " .. diag[severity])
          end
        end
        return table.concat(s, " ")
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo Tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
  groups = {
    options = {
      toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
    },
    items = {
      {
        name = "Tests", -- Mandatory
        highlight = {underline = true, sp = "blue"}, -- Optional
        priority = 2, -- determines where it will appear relative to other groups (Optional)
        icon = "", -- Optional
        matcher = function(buf) -- Mandatory
          return buf.filename:match('%_test') or buf.filename:match('%_spec')
        end,
      },
      {
        name = "Docs",
        highlight = {undercurl = true, sp = "green"},
        auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
        matcher = function(buf)
          return buf.filename:match('%.md') or buf.filename:match('%.txt')
        end,
        separator = { -- Optional
          style = require('bufferline.groups').separator.tab
        },
      }
    }
  }
    },

  })

  vim.keymap.set("n", "<leader>bse", "<Cmd>BufferLineSortByExtension<CR>", { desc = "Sort by extension" })
  vim.keymap.set("n", "<leader>bsd", "<Cmd>BufferLineSortByExtension<CR>", { desc = "Sort by extension" })
  vim.keymap.set("n", "<leader>bD", "<Cmd>BufferLinePickClose<CR>", { desc = "Sort by extension" })
  vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", { desc = "Sort by extension" })

end

return M

