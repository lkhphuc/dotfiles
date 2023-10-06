local M_lz = require("lazyvim.util.ui")

M = {}
M.statuscolumn = function()
  local win = vim.g.statusline_winid
  if vim.wo[win].signcolumn == "no" then
    return ""
  end
  local buf = vim.api.nvim_win_get_buf(win)

  ---@type Sign?,Sign?,Sign?
  local left, right, fold
  for _, s in ipairs(M_lz.get_signs(buf, vim.v.lnum)) do
    if s.name:find("GitSign") then
      right = s
    else
      left = s
    end
  end

  vim.api.nvim_win_call(win, function()
    if vim.fn.foldclosed(vim.v.lnum) >= 0 then
      fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
    elseif vim.fn.foldlevel(vim.v.lnum) > vim.fn.foldlevel(vim.v.lnum - 1) then
      fold = { text = vim.opt.fillchars:get().foldopen or "", texthl = "Folded" }
    end
  end)

  local nu = ""
  if vim.wo[win].number and vim.v.virtnum == 0 then
    nu = vim.wo[win].relativenumber and vim.v.relnum ~= 0 and vim.v.relnum or vim.v.lnum
  end

  return table.concat({
    M_lz.icon(M_lz.get_mark(buf, vim.v.lnum) or left),
    [[%=]],
    nu .. " ",
    M_lz.icon(fold or right),
  }, "")
end

return M
