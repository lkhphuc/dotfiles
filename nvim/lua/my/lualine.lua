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
--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

local gps = require("nvim-gps")
gps.setup()

local function window()
  return " " .. vim.api.nvim_win_get_number(0)
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
  -- always_visible = true,
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    }
  end
end
local diff = {
  "diff",
  source = diff_source,
  symbols = { added = " ", modified = " ", removed = " " },
  colored = true,
}

local branch = {
  "b:gitsigns_head",
  icon = " ",
  colored = true,
  color = { gui = "bold" },
  cond = hide_in_width,
}

local function env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch "([^/]+)" do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end

python_env = {
  function()
    if vim.bo.filetype == "python" then
      local venv = os.getenv "CONDA_DEFAULT_ENV"
      if venv then
        return string.format("  %s", env_cleanup(venv))
      end
      venv = os.getenv "VIRTUAL_ENV"
      if venv then
        return string.format("  %s", env_cleanup(venv))
      end
      return ""
    end
    return ""
  end,
  color = { fg = colors.cyan },
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
  function(msg)
    msg = msg or "No LS"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == "boolean" or #msg == 0 then
	      return "No LS"
      end
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
	      table.insert(buf_client_names, client.name)
      end
    end

    -- add formatter
    local formatters = require "lvim.lsp.null-ls.formatters"
    local supported_formatters = formatters.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- add linter
    local linters = require "lvim.lsp.null-ls.linters"
    local supported_linters = linters.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)

    return "[" .. table.concat(buf_client_names, ", ") .. "]"
  end,
  color = { gui = "bold" },
  cond = hide_in_width,
}
local spaces = {
    function()
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        return "Tab size: " .. vim.api.nvim_buf_get_option(0, "tabstop") .. " "
      end
      local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
      if size == 0 then
        size = vim.api.nvim_buf_get_option(0, "tabstop")
      end
      return "Spaces: " .. size .. " "
    end,
    cond = hide_in_width,
    color = {},
  }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { { function() return " " end, padding = 0 } },
    lualine_b = { branch, diff } ,
    lualine_c = {
      { 'filename', fmt = trunc(90, 30, 50, false) },
      { gps.get_location, cond = gps.is_available },
    },
    lualine_x = { diagnostics, python_env, treesitter },
    lualine_y = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = { 'progress', 'location' , window }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
