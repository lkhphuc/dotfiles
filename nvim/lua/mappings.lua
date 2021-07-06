local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

map("t", "<PageUp>",    "<C-\\><C-N>")  --Capslock+u
vim.cmd[[au TermOpen * setlocal listchars= nonumber norelativenumber]]
vim.cmd[[au TermOpen * startinsert]]
vim.cmd[[au BufEnter,BufWinEnter,WinEnter term://* startinsert]]
vim.cmd[[au BufLeave term://* stopinsert]]

-- NAVIGATE WINDOWS
map("t", "<C-^>",       "<C-\\><C-N><C-^>")
map("t", "<C-w>", "<C-\\><C-N><C-w>w", opt)
map("t", "<C-h>", "<C-\\><C-N><C-w>h", opt)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", opt)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", opt)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", opt)
map("n", "<C-h>", "<C-w>h"          , opt)
map("n", "<C-j>", "<C-w>j"          , opt)
map("n", "<C-k>", "<C-w>k"          , opt)
map("n", "<C-l>", "<C-w>l"          , opt)

map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)
map("n", "<C-s>", ":w <CR>", opt)

map("n", "<leader>z", ":TZAtaraxis<CR>", opt)
map("n", "<leader>m", ":TZMinimalist<CR>", opt)

-- Clipboard Yank
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>p", "\"+p")
map("v", "<leader>p", "\"+p")
map("n", "<leader><space>", "za")

-- compe stuff
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

function _G.completions()
    local npairs = require("nvim-autopairs")
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

--  compe mappings
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("i", "<CR>", "v:lua.completions()", {expr = true})
