-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g, o, opt = vim.g, vim.o, vim.opt

g.mapleader = " "

o.title = true
o.titlestring = " " .. vim.fn.fnamemodify(vim.loop.cwd(), ":t")
o.clipboard = "" -- use gy and gp to interact with osc52-system clipbard
o.splitright = true

o.breakindent = true -- Indent wrapped lines to match line start
o.showbreak = "↳" -- character show in front of wrapped lines
-- o.breakindentopt = "shift:-2" -- dedent showbreak
o.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.wrap = true

o.number = true
o.relativenumber = true
o.numberwidth = 3
o.cursorline = true

o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
o.incsearch = true -- Show search results while typing
o.infercase = true -- Infer letter cases for a richer built-in keyword completion
o.smartcase = true -- Don't ignore case when searching if pattern has upper case
o.smartindent = true -- Make indenting smart

o.virtualedit = "block,onemore" -- Allow going past the end of line in visual block mode

o.list = false
o.listchars = "tab:->,extends:…,precedes:…,nbsp:␣,eol:↲" -- Define which helper symbols to show
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

opt.path:append("**")
opt.shortmess:append("s")

g.python3_host_prog = vim.fn.fnamemodify(os.getenv("CONDA_EXE"), ":p:h:h")
  .. "/envs/neovim/bin/python"
