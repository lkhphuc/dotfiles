local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  purple = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local gps = require("nvim-gps")
gps.setup()

local function windows()
  return " " .. vim.api.nvim_win_get_number(0)
end
local function terminal()
  if vim.o.buftype == "terminal" then
    return " " .. vim.o.channel
  end
  return ""
end

local function tabs()
  local total_tabs = vim.fn.tabpagenr("$")
  if total_tabs == 1 then
    return ""
  end
  local tab_id = vim.fn.tabpagenr()
  return " " ..tab_id .. "/" .. total_tabs
end


local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { 'error', 'warn', 'info', 'hint' },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
  -- always_visible = true,
}

local hide_in_width = function()
	return vim.o.columns > 100
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end
local diff = {
  "diff",
  source = diff_source,
  symbols = { added = " ", modified = " ", removed = " " },
  colored = true,
  padding = {left=1, right=0}
}

local branch = {
  "b:gitsigns_head",
  icon = "",
  color = { gui = "bold," },
  cond = hide_in_width,
}

local function _env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch "([^/]+)" do
      final_venv = w
    end
    venv = final_venv
  end
  return string.format("%s", venv)
end

local python_env = {
  function()
    if vim.bo.filetype ~= "python" then
      return ""
    end
    local venv = os.getenv "CONDA_DEFAULT_ENV"
    if venv then
      return  _env_cleanup(venv)
    end
    venv = os.getenv "VIRTUAL_ENV"
    if venv then
      return _env_cleanup(venv)
    end
    return ""
  end,
  separator = false,
  color = { fg = colors.cyan, gui="italic" },
  cond = hide_in_width,
}

local treesitter = {
  function()
    local b = vim.api.nvim_get_current_buf()
    if next(vim.treesitter.highlighter.active[b]) then
      return ""
    end
    return ""
  end,
  color = { fg = colors.green },
  cond = hide_in_width,
}

local lsp = {
  function(_)
    if next(vim.lsp.buf_get_clients(0)) == nil then
      return ""
    end
    local output = " "
    for _, client in pairs(vim.lsp.buf_get_clients(0)) do
      output = output .. ":" .. client.name
    end
    return output
  end,
  color = { fg = colors.blue, },
  cond = hide_in_width,
}

local spaces = {
    function()
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        return  " "..vim.api.nvim_buf_get_option(0, "tabstop")
      end
      local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
      if size == 0 then
        size = vim.api.nvim_buf_get_option(0, "tabstop")
      end
      return  ""..size
    end,
    cond = hide_in_width,
    color = {},
  }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      { 'hostname', icon = ' ',
        separator = { left = '' , right = '' },
        cond=hide_in_width },
    },
    lualine_b = {
      branch,
      diff,
    },
    lualine_c = {
      python_env,
      {'filetype', icon_only = true, padding = {left=1, right=0}, separator = false,},
      {'filename', path = 1, separator = ">", color = { gui = "italic"} },
      { gps.get_location, cond = gps.is_available, },
    },
    lualine_x = { diagnostics, lsp, treesitter, },
    lualine_y = { spaces,  'progress', 'fileformat' },
    lualine_z = { terminal, tabs, {windows, separator = {left = '', right = ''} }  },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {terminal, windows}
  },
  tabline = {},
  extensions = { 'quickfix', 'nvim-tree'}
}
