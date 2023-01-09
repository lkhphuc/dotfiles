local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
}

function M.config()
  local noice = require("noice")
  noice.setup({
    presets = {
      -- bottom_search = true, -- a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = { -- add a border to hover docs and signature help
        views = {
          hover = {
            border = { style = "shadow", },
            position = { row = 1, col = 0 },
          },
        },
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = { enabled = true, },
    },
    routes = {
      { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "E486" }, opts = { skip = true } },
    },
  })
  vim.keymap.set("n", "<leader>ml", function() noice.cmd("last") end, { desc = "Message last" })
  vim.keymap.set("n", "<leader>mh", function() noice.cmd("history") end, { desc = "Message history" })
  vim.keymap.set("n", "<leader>md", require("notify").dismiss, { desc = "Dimiss notification" })
  -- Noice intergration lsp doc hover scrolling
  vim.keymap.set("n", "<c-f>", function()
    if not require("noice.lsp").scroll(4) then return "<c-f>" end
  end, { silent = true, expr = true })
  vim.keymap.set("n", "<c-b>", function()
    if not require("noice.lsp").scroll(-4) then return "<c-b>" end
  end, { silent = true, expr = true })
end

return M
