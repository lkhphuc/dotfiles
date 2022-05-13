--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({"o", "v"}, "m", "<cmd>lua require('tsht').nodes()<CR>")

-- Normal --
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
-- Move text up and down
vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==gi")

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- Mov.sete text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({"n", "i"}, "<C-s>", "<Esc>:w<CR>")
vim.keymap.set("t", "<PageUp>", "<C-\\><C-n>")
--vim.keymap.set("t", "<C-^>", "<C-\\><C-N><C-^>")
-- Yank to system clipboard
vim.keymap.set({"n","v"}, "<leader>y", "\"+y")
vim.keymap.set({"n","v"}, "<leader>p", "\"+p")
vim.keymap.set("n", "<leader><space>", "zA")
-- Tab pages
vim.keymap.set("n", "]<TAB>", ":tabnext<CR>")
vim.keymap.set("n", "[<TAB>", ":tabprev<CR>")


-- vim.keymap.set('n', '<leader>so', "lua require('telescope.builtin').lsp_document_symbols", opts)
vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})

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

local mappings = {
  ["]"] = { name = "Next",
    g = {"<CMD>Gitsigns next_hunk<CR>", "git hunk"},
    d = {"<CMD>lua vim.diagnostic.goto_next()<CR>", "diagnostic"},
  },
  ["["] = { name = "Previous",
    g = {"<CMD>Gitsigns prev_hunk<CR>", "Previous git hunk"},
    d = {"<CMD>lua vim.diagnostic.goto_prev()<CR>", "diagnostic"},
  },
  g = { name = "Go ",
    p = {"<cmd>BufferLinePick<CR>", "buffer"},
  }
}
which_key.register(mappings, {
  mode = "n", -- NORMAL
  prefix = "",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
})

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local leader_mappings = {
  ["*"] = {"<cmd>Telescope grep_string<CR>"},  -- extend * to search current word in project
  -- ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  C = { "<cmd>vsplit ~/.config/nvim/init.lua<CR>", "Open config."},
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>FloatermNew lazygit<CR>", "Lazygit" },
    j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
    l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk", },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff", },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  },

  l = {
    name = "LSP",
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer fuzzy find" },
    C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    j = { "<cmd>Telescope jumplist<cr>", "Jumplist" },
    n = { "<cmd>Telescope resume<cr>", "Continue" },
    s = { "<cmd>Telescope<cr>", "Telescope" },
  },

  x = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<CR>", "Trouble Toggle" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
    f = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Diagnosticss" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "LocationList" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Diagnosticss" },
  }
}
which_key.register(leader_mappings, opts)
