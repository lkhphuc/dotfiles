vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true

vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.formatoptions = "jcroqlnt" -- tcqj

vim.opt.grepprg = "rg --vimgrep"
vim.wo.number = true --Make line numbers default
vim.wo.relativenumber = true
vim.opt.mouse = 'a' --Enable mouse mode
vim.opt.ignorecase = true --Case insensitive searching
vim.opt.smartcase = true -- UNLESS /C or capital in search
vim.opt.timeoutlen = 300

vim.opt.tabstop = 2  -- If not set by sleuth, a tab is 2 space
vim.opt.shiftwidth = 2  -- For >>, <<
vim.opt.expandtab = true -- Use spaces instead of tabs

vim.opt.wrap = false
vim.opt.linebreak = true  -- wrap at specific char rather than last one
vim.opt.breakat = " ^I!@*;:,./?(="
vim.opt.showbreak = "|>"
vim.opt.breakindent = true  -- to indent on wrap
vim.opt.breakindentopt = "min:60"

vim.opt.undofile = true --Save undo history
vim.opt.swapfile = false

vim.opt.completeopt = 'menu,menuone,noselect' -- complete to comment string
vim.opt.wildmode = "longest:full,full"
vim.opt.path:append("**")
vim.opt.list = false
vim.opt.listchars = { eol = "↲", trail = "·", nbsp = "␣" }
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 0
vim.opt.showmode = false
vim.opt.virtualedit = "block,onemore" -- cursor can move anywhere
vim.opt.pumblend = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.o.shortmess = "filnxtToOFWIc"

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.o.shortmess = "filnxtToOFWIcC"
end

vim.g.python3_host_prog = "/usr/bin/python3" -- pynvim is only needed for this
