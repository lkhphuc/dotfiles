local virt_text = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d 󰇘 "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth) end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "UfoPreviewThumb" })
  return newVirtText
end

local ftMap = {
  vim = { "treesitter", "indent" },
  python = { "treesitter", "indent" },
  bash = { "treesitter", "indent" },
  git = "",
  ["neo-tree"] = "",
}

return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  dependencies = { "kevinhwang91/promise-async" },
  init = function()
    vim.o.foldcolumn = "0"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  opts = {
    fold_virt_text_handler = virt_text,
    provider_selector = function(bufnr, filetype, buftype) return ftMap[filetype] end,
    preview = {
      win_config = {
        border = "shadow",
      },
    },
  },
  keys = {
    { "zR", function() require("ufo").openAllFolds() end },
    { "zM", function() require("ufo").closeAllFolds() end },
    { "zr", function() require("ufo").openFoldsExceptKinds() end },
    { "zm", function() require("ufo").closeFoldsWith() end },

    { -- h to peek fold, because l will usually expand fold
      "h",
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          local curpos = vim.api.nvim_win_get_cursor(0)
          curpos[2] = math.max(0, curpos[2] - 1)
          vim.api.nvim_win_set_cursor(0, curpos)
        end
      end,
    },
  },
  -- NOTE: Not sure how to add capabilities in LazyVim yet, but it seems not needed for UFO anymore
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  -- capabilities.textDocument.foldingRange = {
  -- 	dynamicRegistration = false,
  -- 	lineFoldingOnly = true,
  -- }
}
