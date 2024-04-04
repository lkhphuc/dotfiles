-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<C-,>", "<C-^>", { desc = "Alternate buffer" })
map("n", "<C-.>", function() LazyVim.terminal.open(nil, { ft = "", border = "rounded" }) end, {})
map("t", "<C-.>", "<Cmd>close<cr>", { desc = "Toggle float terminal" })
map("n", "<leader>fl", function() LazyVim.terminal.open("lf") end, { desc = "LF file manager" })

map("t", "<C-p>", "<Up>")
map("t", "<C-n>", "<Down>")
map("t", "<C-e>", "<Right>")

-- map("n", "z<space>", "za", { desc = "Toggle fold" })

map({ "n", "v" }, "gf", "gF", { desc = "Go to file at line" })

map("n", "H", "_", { desc = "First character of line" })
map("n", "L", "$", { desc = "Last character of line" })
map("n", "J", function()
  vim.cmd("normal! mzJ")
  local col = vim.fn.col(".")
  ---@diagnostic disable-next-line: param-type-mismatch
  local context = string.sub(vim.fn.getline("."), col - 1, col + 1)
  if
    context == ") ."
    or context == ") :"
    or context:match("%( .")
    or context:match(". ,")
    or context:match("%w %.")
  then
    vim.cmd("undojoin | normal! x")
  elseif context == ",)" then
    vim.cmd("undojoin | normal! hx")
  end
  vim.cmd("normal! `z")
  vim.cmd("delmarks z")
end, { desc = "Join line with smart whitespace removal" })

map("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

-- Don't remap <TAB> as that is the same as <C-i}
-- map("n", "gb", "<C-^>", { silent = true, desc = "Alternate file" })
map("n", "<S-Tab>", "g<Tab>", { silent = true, desc = "Alternate tab" })
map("n", "]<TAB>", ":tabnext<CR>", { silent = true, desc = "Next tab" })
map("n", "[<TAB>", ":tabprev<CR>", { silent = true, desc = "Prev tab" })

map("n", "dd", function()
  local is_empty_line = vim.api.nvim_get_current_line():match("^%s*$")
  if is_empty_line then
    return '"_dd'
  else
    return "dd"
  end
end, { noremap = true, expr = true, desc = "Don't yank empty line to clipboard" })

map("n", "dm", function()
  local cur_line = vim.fn.line(".")
  -- Delete buffer local mark
  for _, mark in ipairs(vim.fn.getmarklist("%")) do
    if mark.pos[2] == cur_line and mark.mark:match("[a-zA-Z]") then
      vim.api.nvim_buf_del_mark(0, string.sub(mark.mark, 2, #mark.mark))
      return
    end
  end
  -- Delete global marks
  local cur_buf = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
  for _, mark in ipairs(vim.fn.getmarklist()) do
    if mark.pos[1] == cur_buf and mark.pos[2] == cur_line and mark.mark:match("[a-zA-Z]") then
      vim.api.nvim_buf_del_mark(0, string.sub(mark.mark, 2, #mark.mark))
      return
    end
  end
end, { noremap = true, desc = "Delete mark on the current line" })

-- mini.basic mappings
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

map(
  "n",
  "gO",
  "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
  { desc = "Put empty line above" }
)
map(
  "n",
  "go",
  "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>",
  { desc = "Put empty line below" }
)

-- Copy/paste with system clipboard
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
map({ "n" }, "gY", '"+y$', { desc = "Copy to system clipboard" })
map({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })
-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
map({ "n", "x" }, "gP", '"+P', { desc = "Paste from system (without yanking text)" })

-- gv: Reselect visual selection by default
-- Reselect latest changed, put, or yanked text
map(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, desc = "Select changed" }
)

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
map("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
map("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])

-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
map(
  { "n", "i", "x" },
  "<C-S>",
  "<Esc><Cmd>silent! update | redraw<CR>",
  { desc = "Save and go to Normal mode" }
)

-- mini.basics toggles
local toggle_prefix = [[\]]
local map_toggle = function(lhs, rhs, desc) map("n", toggle_prefix .. lhs, rhs, { desc = desc }) end
map_toggle(
  "b",
  '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
  "Toggle 'background'"
)
map_toggle("c", "<Cmd>setlocal cursorline! cursorline?<CR>", "Toggle 'cursorline'")
map_toggle("C", "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>", "Toggle 'cursorcolumn'")
map_toggle("d", function()
  if vim.o.diff then
    vim.cmd.diffoff()
  else
    vim.cmd.diffthis()
  end
end, "Toggle diff mode")
map_toggle(
  "h",
  '<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
  "Toggle search highlight"
)
map_toggle("i", "<Cmd>setlocal ignorecase! ignorecase?<CR>", "Toggle 'ignorecase'")
map_toggle("l", "<Cmd>setlocal list! list?<CR>", "Toggle 'list'")
map_toggle("n", "<Cmd>setlocal number! number?<CR>", "Toggle 'number'")
map_toggle("r", "<Cmd>setlocal relativenumber! relativenumber?<CR>", "Toggle 'relativenumber'")
map_toggle("s", "<Cmd>setlocal spell! spell?<CR>", "Toggle 'spell'")
map_toggle("w", "<Cmd>setlocal wrap! wrap?<CR>", "Toggle 'wrap'")

vim.api.nvim_create_user_command("DiffOrig", function()
  -- Get start buffer
  local start = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_get_option_value("filetype", { buf = start })

  -- `vnew` - Create empty vertical split window
  -- `set buftype=nofile` - Buffer is not related to a file, will not be written
  -- `0d_` - Remove an extra empty start row
  -- `diffthis` - Set diff mode to a new vertical split
  vim.cmd("vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis")

  -- Get scratch buffer
  local scratch = vim.api.nvim_get_current_buf()
  vim.api.nvim_set_option_value("filetype", ft, { buf = scratch })
  -- `wincmd p` - Go to the start window
  -- `diffthis` - Set diff mode to a start window
  vim.cmd("wincmd p | diffthis")

  -- Map `q` for both buffers to exit diff view and delete scratch buffer
  for _, buf in ipairs({ scratch, start }) do
    vim.keymap.set("n", "q", function()
      vim.api.nvim_buf_delete(scratch, { force = true })
      vim.keymap.del("n", "q", { buffer = start })
    end, { buffer = buf })
  end
end, { desc = "Diff with last saved." })

vim.keymap.set({ "c", "i", "t" }, "<M-BS>", "<C-w>", { desc = "Alt-BS delete word in insert mode" })

vim.keymap.set("n", "<leader><TAB>n", "<Cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader><TAB><TAB>", function()
  vim.ui.select(vim.api.nvim_list_tabpages(), {
    prompt = "Select tab:",
    format_item = function(tabid)
      local wins = vim.api.nvim_tabpage_list_wins(tabid)
      local not_floating_win = function(winid)
        return vim.api.nvim_win_get_config(winid).relative == ""
      end
      wins = vim.tbl_filter(not_floating_win, wins)
      local bufs = {}
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
        if buftype ~= "nofile" then
          local fname = vim.api.nvim_buf_get_name(buf)
          table.insert(bufs, vim.fn.fnamemodify(fname, ":t"))
        end
      end
      local tabnr = vim.api.nvim_tabpage_get_number(tabid)
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(-1, tabnr), ":t")
      return "Tab " .. tabnr  .. " (" .. cwd ..  "): " .. table.concat(bufs, ",")
    end,
  }, function(tabid)
    if tabid ~= nil then vim.cmd(tabid .. "tabnext") end
  end)
end, { desc = "Select tab" })
