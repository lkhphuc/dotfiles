-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Plain terminal
vim.api.nvim_create_autocmd("TermOpen", {
  command = [[setlocal listchars= nonumber norelativenumber]],
})

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    if vim.v.event.status == 0 then
      -- Weird behaviors for each of these plugins
      if vim.bo.filetype ~= "floaterm" then vim.api.nvim_buf_delete(0, {}) end
      vim.cmd("ToggleTerm")
    end
  end,
})
