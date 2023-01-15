-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Plain terminal
vim.api.nvim_create_autocmd("TermOpen", {
  command = [[setlocal listchars= nonumber norelativenumber]],
})
