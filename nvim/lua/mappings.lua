local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them
--[[ remove this line

map("n", "dd", [=[ "_dd ]=], opt)
map("v", "dd", [=[ "_dd ]=], opt)
map("v", "x", [=[ "_x ]=], opt)

 this line too ]]
--

-- OPEN TERMINALS --
map("n", "<C-c>", [[<Cmd>vnew term://zsh <CR>]], opt) -- term over right
map("n", "<C-x>", [[<Cmd> split term://zsh | resize 10 <CR>]], opt) --  term bottom
map("n", "<C-t>t", [[<Cmd> tabnew | :term <CR>]], opt) -- term newtab
map("n", "<leader>lf", [[<Cmd> FloatermNew lf <CR>]], opt)
map("n", "<leader>lg", [[<Cmd> FloatermNew lazygit <CR>]], opt)

-- EXIT TERMINAL MODE
map("t", "<C-v>",       "<C-\\><C-N>")  --Capslock+v
map("t", "<PageUp>",    "<C-\\><C-N>")  --Capslock+u

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

-- copy whole file content
map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- toggle numbers
map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

-- Truezen.nvim
map("n", "<leader>z", ":TZAtaraxis<CR>", opt)
map("n", "<leader>m", ":TZMinimalist<CR>", opt)

map("n", "<C-s>", ":w <CR>", opt)
-- vim.cmd("inoremap jh <Esc>")

-- Clipboard Yank
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>p", "\"+p")
map("v", "<leader>p", "\"+p")
map("n", "<leader><space>", "za")
-- Commenter Keybinding
-- map("n", "<leader>/", ":CommentToggle<CR>", opt)
-- map("v", "<leader>/", ":CommentToggle<CR>", opt)

map("n", "<C-q>", ":bp<bar>sp<bar>bn<bar>bd! <CR>", opt)

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

-- nvimtree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)

-- format code
-- map("n", "<Leader>fm", [[<Cmd> Neoformat<CR>]], opt)

-- dashboard stuff
map("n", "<Leader>fw", [[<Cmd> Telescope live_grep<CR>]], opt)
map("n", "<Leader>db", [[<Cmd> Dashboard<CR>]], opt)
map("n", "<Leader>fn", [[<Cmd> DashboardNewFile<CR>]], opt)
map("n", "<Leader>bm", [[<Cmd> DashboardJumpMarks<CR>]], opt)
map("n", "<C-s>l", [[<Cmd> SessionLoad<CR>]], opt)
map("n", "<C-s>s", [[<Cmd> SessionSave<CR>]], opt)

-- Telescope
map("n", "<Leader>gt", [[<Cmd> Telescope git_status <CR>]], opt)
map("n", "<Leader>cm", [[<Cmd> Telescope git_commits <CR>]], opt)
map("n", "<Leader>ff", [[<Cmd> Telescope find_files <CR>]], opt)
map("n", "<Leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opt)
map("n", "<Leader>fb", [[<Cmd>Telescope Buffers<CR>]], opt)
map("n", "<Leader>fh", [[<Cmd>Telescope help_tags<CR>]], opt)
map("n", "<Leader>fo", [[<Cmd>Telescope oldfiles<CR>]], opt)
map("n", "<Leader>fm", [[<Cmd>Telescope marks<CR>]], opt)

-- bufferline tab stuff
map("n", "<S-t>", ":tabnew<CR>", opt) -- new tab
map("n", "<S-x>", ":bd!<CR>", opt) -- close tab

-- move between tabs
map("n", "]b", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "[b", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
map("n", "gb", [[<Cmd>BufferLinePick<CR>]], opt)
