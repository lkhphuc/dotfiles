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
vim.keymap.set({ "o", "v" }, "m", "<cmd>lua require('tsht').nodes()<CR>")
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:w<CR>", { silent = true }) -- Save in normal/insert
vim.keymap.set({ "t" }, "<C-s>", "<C-\\><C-n>", { silent = true }) -- Escape in terminal
vim.keymap.set("t", "<C-^>", "<C-\\><C-N><C-^>")

vim.keymap.set("t", "<PageUp>", "<C-\\><C-n>") -- Exit terminal when scroll up
vim.api.nvim_create_autocmd("TermOpen", {
	command = " setlocal listchars= nonumber norelativenumber",
})
vim.api.nvim_create_autocmd("TermClose", {
	callback = function()
		if vim.v.event.status == 0 and vim.bo.filetype ~= "floaterm" then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
    "dap-hover",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Return to last cursor position on buffer open
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
