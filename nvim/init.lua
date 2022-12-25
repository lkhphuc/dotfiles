-- Bootstrap plugin manager
local use_dev = false
if use_dev then
  -- use the local project
  vim.opt.runtimepath:prepend(vim.fn.expand("~/projects/lazy.nvim"))
else
  -- bootstrap from github
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "git@github.com:folke/lazy.nvim.git",
      lazypath,
    })
  end
  vim.opt.runtimepath:prepend(lazypath)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugins management
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  dev = { path = "~/repos" },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = true,
})
vim.keymap.set("n", "<leader>P", "<cmd>:Lazy<cr>")

require("options")
require("mappings")

-- vim: ts=2 sts=2 sw=2 fdls=4 et
