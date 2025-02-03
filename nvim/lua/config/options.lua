-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g, o, opt = vim.g, vim.o, vim.opt

g.mapleader = " "

o.title = true
o.titlestring = " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
o.clipboard = "" -- use gy and gp to interact with osc52-system clipbard
-- Copy/paste with system clipboard
local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end
g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}
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
o.scrolloff = 10 -- context lines

o.list = false
-- Define which helper symbols to show
opt.listchars = {
  leadmultispace = "│   ",
  tab = "│ ",
  extends = "…",
  precedes = "…",
  trail = "␣",
  -- eol = "↲",
}
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  diff = "╱",
  eob = " ",
}

opt.diffopt:append({ "indent-heuristic", "algorithm:patience" })
opt.foldlevel = 1
g.autoformat = false

opt.path:append("**")
opt.shortmess:append("s")
opt.mousemoveevent = true

g.lazyvim_python_lsp = "basedpyright"
g.lazyvim_python_ruff = "ruff"
g.python3_host_prog = vim.fn.fnamemodify(os.getenv("CONDA_EXE") or "", ":p:h:h").. "/envs/neovim/bin/python"

if vim.g.neovide then
  vim.g.minianimate_disable = true
  vim.g.neovide_window_blurred = true
  vim.g.neovide_transparency = 0.8
  -- vim.g.neovide_show_border = true
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
  vim.g.neovide_cursor_animate_command_line = false -- noice incompat
  vim.g.neovide_cursor_smooth_blink = true
  -- vim.g.neovide_cursor_vfx_mode = "ripple"
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
  -- https://github.com/neovide/neovide/issues/1771
  -- Prevent scrolling animation when changing buffer
  vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
      vim.g.neovide_scroll_animation_length = 0
    end,
  })
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      vim.fn.timer_start(70, function()
        vim.g.neovide_scroll_animation_length = 0.3
      end)
    end,
  })
end
