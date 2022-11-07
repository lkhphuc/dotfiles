--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--  _____________
-- < Normal Mode >
--  -------------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
-- Better window navigation
vim.keymap.set({"n", "t"}, "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({"n", "t"}, "<C-j>", "<C-\\><C-n><C-w>j" )
vim.keymap.set({"n", "t"}, "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({"n", "t"}, "<C-l>", "<C-\\><C-n><C-w>l")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Tab pages
vim.keymap.set("n", "]<TAB>", ":tabnext<CR>", {silent=true})
vim.keymap.set("n", "[<TAB>", ":tabprev<CR>", {silent=true})

vim.keymap.set("n", "<leader><space>", "za", {desc = "Toggle fold recursively."})
vim.keymap.set("n", "<leader>C", "<cmd>vsplit ~/.config/nvim/init.lua<CR>", {desc = "Open config"})
vim.keymap.set("n", "<leader>q", ":q!<cr>", {desc = "Force Quit"})

vim.keymap.set("n", "<leader>F", ":tabnew term://lf<CR>", {desc = "File manager"})
--  _____________
-- < Visual Mode >
--  -------------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", {silent=true})
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", {silent=true})
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", {silent=true})
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", {silent=true})
vim.keymap.set("v", "p", '"_dP')  -- In selection mode, paste over but don't yank

-- Misc mode
vim.keymap.set({"o", "v"}, "m", "<cmd>lua require('tsht').nodes()<CR>")
vim.keymap.set({"n", "i"}, "<C-s>", "<Esc>:w<CR>", {silent=true}) -- Save in normal/insert
vim.keymap.set({"t"}, "<C-s>", "<C-\\><C-n>", {silent=true}) -- Escape in terminal
vim.keymap.set("t", "<C-^>", "<C-\\><C-N><C-^>")

-- Yank to system clipboard
vim.keymap.set({"n","v"}, "<leader>y", '"+y', {remap=true})
vim.keymap.set({"n","v"}, "<leader>p", '"+p', {remap=true})
-- Don't yank empty line to clipboard
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end
vim.keymap.set( "n", "dd", smart_dd, { noremap = true, expr = true } )
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*',
})

--  ______________
-- < Terminal Mode>
--  --------------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
vim.keymap.set("t", "<PageUp>", "<C-\\><C-n>")
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = " setlocal listchars= nonumber norelativenumber",
})
vim.api.nvim_create_autocmd("TermClose", {
  callback = function ()
    if vim.v.event.status == 0 and vim.bo.filetype ~= "floaterm" then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

local which_key = require("which-key")

which_key.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments", },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
})
which_key.register({
  ["]"] = { name = "Next", },
  ["["] = { name = "Previous", },
  g = { name = "Go ", }
}, {
  mode = "n", -- NORMAL
  prefix = "",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
})

