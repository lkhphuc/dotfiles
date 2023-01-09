-- bootstrap from github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--single-branch",
    "git@github.com:folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(vim.env.LAZY or lazypath)

require("options")

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  dev = { path = "~/repos" },
  install = { colorscheme = { "tokyonight-moon" } },
  checker = { enabled = false },
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
  -- debug = true,
  concurrency = 50,
})
vim.keymap.set("n", "<leader>P", "<cmd>:Lazy<cr>", { desc = "Plugins" })

require("mappings")
require("autocmds")
