-- vim.keymap.set('v', 'g/', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])

-- Better window navigation
vim.keymap.set({ "n", "t" }, "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set({ "n", "t" }, "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set({ "n", "t" }, "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set({ "n", "t" }, "<C-l>", "<C-\\><C-n><C-w>l")

--Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Tab pages
vim.keymap.set("n", "]<TAB>", ":tabnext<CR>", { silent = true })
vim.keymap.set("n", "[<TAB>", ":tabprev<CR>", { silent = true })

vim.keymap.set("n", "<leader><space>", "za", { desc = "Toggle fold recursively." })
vim.keymap.set("n", "<leader>C", "<cmd>vsplit ~/.config/nvim/init.lua<CR>", { desc = "Open config" })
vim.keymap.set("n", "<leader>q", ":q!<cr>", { desc = "Force Quit" })

vim.keymap.set("n", "<leader>F", ":tabnew term://lf<CR>", { desc = "File manager" })

vim.keymap.set("n", "H", "_", { desc = "First character of line" })
vim.keymap.set("n", "L", "$", { desc = "Last character of line" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line w/o cursor moing" })

vim.keymap.set("v", "<", "<gv", { desc = "Dedent and stay in visual mode." })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and stay in visual mode." })
-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move text and align" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text and align" })

-- Misc mode
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:w<CR>", { silent = true }) -- Save in normal/insert/terminal
vim.keymap.set({ "t" }, "<C-^>", "<C-\\><C-N><C-^>")

vim.keymap.set("t", "<PageUp>", "<C-\\><C-n>") -- Exit terminal when scroll up
