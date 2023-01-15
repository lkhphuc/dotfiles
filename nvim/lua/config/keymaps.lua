-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-h>", function() require("smart-splits").move_cursor_left() end)
vim.keymap.set("n", "<C-j>", function() require("smart-splits").move_cursor_down() end)
vim.keymap.set("n", "<C-k>", function() require("smart-splits").move_cursor_up() end)
vim.keymap.set("n", "<C-l>", function() require("smart-splits").move_cursor_right() end)
vim.keymap.set("n", "<A-h>", function() require("smart-splits").resize_left() end)
vim.keymap.set("n", "<A-j>", function() require("smart-splits").resize_down() end)
vim.keymap.set("n", "<A-k>", function() require("smart-splits").resize_up() end)
vim.keymap.set("n", "<A-l>", function() require("smart-splits").resize_right() end)

-- Fold
vim.keymap.set("n", "<leader><space>", "za", { desc = "Toggle fold" })

-- Open Shortcuts
-- vim.keymap.set("n", "<leader>C", "<cmd>vsplit ~/.config/nvim/init.lua<CR>", { desc = "Open config" })
vim.keymap.set("n", "<leader>fm", ":tabnew term://lf<CR>", { desc = "File manager" })
vim.keymap.set({ "n", "v" }, "gf", "gF", { desc = "Go to file at line" })

vim.keymap.set("n", "H", "_", { desc = "First character of line" })
vim.keymap.set("n", "L", "$", { desc = "Last character of line" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line w/o cursor moing" })

-- Move text up and down, also <A-j> <A-k>
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move text and align" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text and align" })

-- select last pasted text
vim.cmd([[nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]']])

-- Tab pages
-- there are also LazyVim's default keymap with leader
vim.keymap.set("n", "]<TAB>", ":tabnext<CR>", { silent = true })
vim.keymap.set("n", "[<TAB>", ":tabprev<CR>", { silent = true })

-- Buffers
vim.keymap.set("n", "]b", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "[b", ":BufferLineCyclePrev<CR>", { silent = true })

-- Terminal
-- vim.keymap.set({ "t" }, "<C-^>", "<C-\\><C-N><C-^>")
vim.keymap.set("t", "<PageUp>", "<C-\\><C-n>") -- Exit terminal when scroll up

-- Yank
vim.keymap.set("v", "p", '"_dP', { desc = "Paste over selection without yanking" })
-- Don't yank empty line to clipboard
vim.keymap.set("n", "dd", function()
  local is_empty_line = vim.api.nvim_get_current_line():match("^%s*$")
  if is_empty_line then
    return '"_dd'
  else
    return "dd"
  end
end, { noremap = true, expr = true })
