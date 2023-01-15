-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

vim.opt.linebreak = true -- wrap at specific char rather than last one
vim.opt.breakat = " ^I!@*;:,./?(="
vim.opt.showbreak = "|>"
vim.opt.breakindent = true -- to indent on wrap
vim.opt.breakindentopt = "min:60"

vim.opt.path:append("**")

vim.opt.list = false
vim.opt.listchars = { eol = "↲", trail = "·", nbsp = "␣" }

vim.opt.virtualedit = "block,onemore" -- cursor can move anywhere
vim.opt.pumblend = 0 -- FIX: bug in neovim, small icons due to blending

vim.g.python3_host_prog = "/usr/bin/python3" -- pynvim is only needed for this
