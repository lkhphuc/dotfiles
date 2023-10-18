-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Plain terminal
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  command = [[setlocal listchars= nonumber norelativenumber | startinsert]],
})

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- show cursor line only in active window, i.e reticle.nvim
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- auto wrap on text-based file
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"text", "tex", "markdown", "rst"},
  callback = function() vim.wo.wrap = true end,
})

----------------- python -----------------
-- From nvim-puppetteer
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = { "*.py" },
  callback = function()  -- Auto f-string on typing {
    local function replaceNodeText(node, text)
      local start_row, start_col, end_row, end_col = node:range()
      local lines = vim.split(text, "\n")
      vim.cmd.undojoin() -- make undos ignore the next change, see issue #8
      vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, lines)
    end

    local node = vim.treesitter.get_node()
    if not node then return end

    local str_node
    if node:type() == "string" then
      str_node = node
    elseif node:type():find("^string_") then
      str_node = node:parent()
    elseif node:type() == "escape_sequence" then
      str_node = node:parent():parent()
    else
      return
    end

    local text = vim.treesitter.get_node_text(str_node, 0)
    if text == "" then return end -- don't convert empty strings, user might want to enter sth

    local isFString = text:find("^f")
    local hasBraces = text:find("{.-}")

    if not isFString and hasBraces then
      replaceNodeText(str_node, "f" .. text)
    elseif isFString and not hasBraces then
      text = text:sub(2)
      replaceNodeText(str_node, text)
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.ipynb" },
  command = "set commentstring=# %s",
})
