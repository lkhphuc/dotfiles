require("leap").set_default_keymaps()

function leap_to_window()
  target_windows = require('leap.util').get_enterable_windows()
  local targets = {}
  for _, win in ipairs(target_windows) do
    local wininfo = vim.fn.getwininfo(win)[1]
    local pos = { wininfo.topline, 1 }  -- top/left corner
    table.insert(targets, { pos = pos, wininfo = wininfo })
  end

  require('leap').leap {
    target_windows = target_windows, targets = targets,
    action = function (target)
      vim.api.nvim_set_current_win(target.wininfo.winid)
    end
  }
end
vim.keymap.set("n", "<leader>ww", leap_to_window, {desc = "Jump to window"})

local function leap_any()
  require('leap').leap { target_windows = vim.tbl_filter(
    function (win) return vim.api.nvim_win_get_config(win).focusable end,
    vim.api.nvim_tabpage_list_wins(0)
  )}
end
vim.keymap.set("n", "s", leap_any, {desc = "Anywhere visible"})
