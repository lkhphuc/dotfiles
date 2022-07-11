vim.wo.number = true --Make line numbers default
vim.wo.relativenumber = true
vim.o.mouse = 'a' --Enable mouse mode
vim.o.ignorecase = true --Case insensitive searching
vim.o.smartcase = true -- UNLESS /C or capital in search
vim.o.completeopt = 'menuone,noselect' -- complete to comment string
vim.o.timeoutlen = 300
vim.o.tabstop = 2  -- If not set by sleuth, a tab is 2 space
vim.o.shiftwidth = 2  -- For >>, <<
vim.o.wrap = true
vim.o.breakindent = true  -- to indent on wrap
vim.o.breakindentopt = "min:60,sbr"  -- using these options
vim.o.linebreak = true  -- wrap at specific char rather than last one
vim.o.undofile = true --Save undo history
vim.o.wildmode = "longest:full,full"
vim.o.path = vim.o.path .. "**"
vim.o.list = false
vim.o.listchars = "eol:↲,trail:·,nbsp:␣"
vim.o.scrolloff = 3
vim.o.sidescrolloff = 1
vim.o.signcolumn = "yes"
vim.o.showtabline = 0
vim.o.swapfile = false
vim.o.lazyredraw = true
vim.o.showmode = false

vim.g.python3_host_prog = "/usr/bin/python3"
-- Can not put this inside neomux config for some reason
vim.g.neomux_winjump_map_prefix = "gw"
vim.g.neomux_win_num_status = ""
vim.g.neomux_dont_fix_term_ctrlw_map = 1
