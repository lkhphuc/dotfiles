-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g, o, opt = vim.g, vim.o, vim.opt

g.mapleader = " "

o.title = true
o.titlestring = " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
o.clipboard = "" -- use gy and gp to interact with osc52-system clipbard
o.splitright = true

o.breakindent = true -- Indent wrapped lines to match line start
o.showbreak = "↳" -- character show in front of wrapped lines
-- o.breakindentopt = "shift:-2" -- dedent showbreak
o.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)

o.number = true
o.relativenumber = true
o.numberwidth = 3
o.cursorline = true
o.showtabline = 0 --never
o.winblend = 10

o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
o.incsearch = true -- Show search results while typing
o.infercase = true -- Infer letter cases for a richer built-in keyword completion
o.smartcase = true -- Don't ignore case when searching if pattern has upper case
o.smartindent = true -- Make indenting smart

o.virtualedit = "block,onemore" -- Allow going past the end of line in visual block mode

o.list = false
-- Define which helper symbols to show
opt.listchars = {
  leadmultispace = "│ ",
  tab = "│ ",
  extends = "…",
  precedes = "…",
  nbsp = "␣",
  eol = "↲",
}
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

opt.foldlevel = 3
opt.statuscolumn = [[%!v:lua.require'config.util'.statuscolumn()]]
g.autoformat = false

opt.path:append("**")
opt.shortmess:append("s")
o.mousemoveevent = true

g.lazyvim_python_lsp = "basedpyright"
g.python3_host_prog = vim.fn.stdpath("data") .. "/python/.pixi/envs/default/bin/python"

if vim.g.neovide then
  vim.g.minianimate_disable = true
  vim.g.neovide_window_blurred = true
  vim.g.neovide_transparency = 0.8
  -- vim.g.neovide_show_border = true
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_cursor_animate_command_line = false -- noice incompat
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_vfx_mode = "ripple"
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set({ "n", "v" }, "<D-v>", '"+P') -- Paste
  vim.keymap.set({ "i", "c" }, "<D-v>", "<C-R>+") -- Paste
  vim.keymap.set("t", "<D-v>", [[<C-\><C-N>"+P]]) -- Paste
  vim.keymap.set(
    "n",
    "<D-+>",
    function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1 end
  )
  vim.keymap.set(
    "n",
    "<D-->",
    function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1 end
  )
  vim.g.neovide_scale_factor = 1.0
  vim.keymap.set({ "n", "v", "t", "i" }, "<D-}>", [[<C-\><C-N><Cmd>tabnext<CR>]])
  vim.keymap.set({ "n", "v", "t", "i" }, "<D-{>", [[<C-\><C-N><Cmd>tabprev<CR>]])
  vim.keymap.set({ "n", "v", "t", "i" }, "<D-l>", [[<C-\><C-N><Cmd>tabnext #<CR>]])
  vim.keymap.set({ "n", "v", "t", "i" }, "<D-t>", [[<C-\><C-N><Cmd>tabnew<CR>]])
  vim.keymap.set({ "n", "v", "t", "i" }, "<D-w>", [[<C-\><C-N><Cmd>tabclose<CR>]])
end
