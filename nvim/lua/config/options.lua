-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.title = true
-- o.titlestring = " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

vim.o.breakindent = false -- Indent wrapped lines to match line start
vim.o.showbreak = "↳" -- character show in front of wrapped lines
vim.o.breakindentopt = "shift:-2" -- dedent showbreak

vim.o.winblend = 10

vim.o.incsearch = true -- Show search results while typing
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion

-- o.virtualedit = "block,onemore" -- Allow going past the end of line in visual block mode
-- o.scrolloff = 10 -- context lines

vim.o.list = false
-- Define which helper symbols to show
vim.opt.listchars = {
  leadmultispace = "│   ",
  tab = "│ ",
  extends = "…",
  precedes = "…",
  trail = "␣",
  eol = "↲",
}

vim.opt.diffopt:append({ "indent-heuristic", "algorithm:patience" })
vim.g.autoformat = false

vim.opt.path:append("**")
vim.opt.shortmess:append({s = true})
vim.opt.mousemoveevent = true

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.sidekick_nes = false

if vim.g.neovide then
  vim.g.minianimate_disable = true
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_corner_radius = 0.5
  vim.g.neovide_opacity = 0.8
  vim.g.experimental_layer_grouping = true
  vim.g.neovide_cursor_hack = false
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set({ "n", "v" }, "<D-v>", '"+P') -- Paste
  vim.keymap.set({ "i", "c" }, "<D-v>", "<C-R>+") -- Paste
  vim.keymap.set("t", "<D-v>", [[<C-\><C-N>"+P]]) -- Paste

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<D-+>", function() change_scale_factor(1.1) end)
  vim.keymap.set("n", "<D-->", function() change_scale_factor(1 / 1.1) end)
  vim.keymap.set("n", "<C-+>", function() change_scale_factor(1.1) end)
  vim.keymap.set("n", "<C-->", function() change_scale_factor(1 / 1.1) end)

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
