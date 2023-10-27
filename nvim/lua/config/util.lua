local M_lz = require("lazyvim.util.ui")

M = {}
M.statuscolumn = function()
  local win = vim.g.statusline_winid
  local buf = vim.api.nvim_win_get_buf(win)
  local is_file = vim.bo[buf].buftype == ""
  local show_signs = vim.wo[win].signcolumn ~= "no"

  local components = { "", "", "" } -- left, middle, right

  if show_signs then
  ---@type Sign?,Sign?,Sign?
    local sign, gitsign, fold
    for _, s in ipairs(M_lz.get_signs(buf, vim.v.lnum)) do
      if s.name and s.name:find("GitSign") then
        gitsign = s
      else
        sign = s
      end
    end

    vim.api.nvim_win_call(win, function()
      if vim.fn.foldclosed(vim.v.lnum) >= 0 then
        fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
      elseif vim.fn.foldlevel(vim.v.lnum) > vim.fn.foldlevel(vim.v.lnum - 1) then
        fold = { text = vim.opt.fillchars:get().foldopen or "" }
      end
    end)

    local mark = M_lz.get_mark(buf, vim.v.lnum)
    if vim.v.virtnum ~= 0 then
      -- Don't duplicate sign on virtual line
      sign = nil
    else
      sign = sign or mark or fold
    end
    -- except for gitsign's indicator line
    components[2] = M_lz.icon(sign or gitsign)
  end

  -- Numbers in Neovim are weird
  -- They show when either number or relativenumber is true
  local is_num = vim.wo[win].number
  local is_relnum = vim.wo[win].relativenumber
  if (is_num or is_relnum) and vim.v.virtnum == 0 then
    if vim.v.relnum == 0 then
      components[1] = is_num and "%l" or "%r" -- the current line
    else
      components[1] = is_relnum and "%r" or "%l" -- other lines
    end
  end
  components[1] = "%=" .. components[1] .. " " -- right align

  return table.concat(components, "")
end

return M
