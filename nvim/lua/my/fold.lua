local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d ...'):format(endLnum - lnum)
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
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'Folded'})
    return newVirtText
end

require('ufo').setup({
  fold_virt_text_handler = handler,
  preview = {
    win_config = {
      border = 'shadow',
    }
  },
  provider_selector = function(bufnr, filtype)
    return {'treesitter', 'indent'}
  end,
})

-- buffer scope handler
-- will override global handler if it is existed
local bufnr = vim.api.nvim_get_current_buf()
require('ufo').setFoldVirtTextHandler(bufnr, handler)

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'h', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    local curpos = vim.api.nvim_win_get_cursor(0)
    curpos[2] = math.max(0, curpos[2]-1)
    vim.api.nvim_win_set_cursor(0, curpos)
  end
end)

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- vim.o.foldcolumn = '1'
-- vim.wo.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
