-- require("leap").set_default_keymaps()

local function leap_any()
  require('leap').leap { target_windows = vim.tbl_filter(
    function (win) return vim.api.nvim_win_get_config(win).focusable end,
    vim.api.nvim_tabpage_list_wins(0)
  )}
end

vim.keymap.set({'n', 'x', 'o'}, "s", leap_any, {desc = "Anywhere visible"})
vim.keymap.set({'n', 'x', 'o'}, 'gs', function() require'leap-ast'.leap() end, {})
