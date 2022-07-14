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

local navic = require("nvim-navic")
navic.setup({
  highlight = true,
})
vim.api.nvim_set_hl(0, "NavicIconsFile",          {default = true, bg = colors.bg, fg = colors.blue})
vim.api.nvim_set_hl(0, "NavicIconsModule",        {default = true, bg = colors.bg, fg = colors.violet})
vim.api.nvim_set_hl(0, "NavicIconsNamespace",     {default = true, bg = colors.bg, fg = colors.magenta})
vim.api.nvim_set_hl(0, "NavicIconsPackage",       {default = true, bg = colors.bg, fg = colors.yellow})
vim.api.nvim_set_hl(0, "NavicIconsClass",         {default = true, bg = colors.bg, fg = colors.green})
vim.api.nvim_set_hl(0, "NavicIconsMethod",        {default = true, bg = colors.bg, fg = colors.blue})
vim.api.nvim_set_hl(0, "NavicIconsProperty",      {default = true, bg = colors.bg, fg = colors.cyan})
vim.api.nvim_set_hl(0, "NavicIconsField",         {default = true, bg = colors.bg, fg = colors.blue})
vim.api.nvim_set_hl(0, "NavicIconsConstructor",   {default = true, bg = colors.bg, fg = colors.green})
vim.api.nvim_set_hl(0, "NavicIconsEnum",          {default = true, bg = colors.bg, fg = colors.yellow})
vim.api.nvim_set_hl(0, "NavicIconsInterface",     {default = true, bg = colors.bg, fg = colors.yellow})
vim.api.nvim_set_hl(0, "NavicIconsFunction",      {default = true, bg = colors.bg, fg = colors.blue})
vim.api.nvim_set_hl(0, "NavicIconsVariable",      {default = true, bg = colors.bg, fg = colors.green})
vim.api.nvim_set_hl(0, "NavicIconsConstant",      {default = true, bg = colors.bg, fg = colors.orange})
vim.api.nvim_set_hl(0, "NavicIconsString",        {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicIconsNumber",        {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicIconsBoolean",       {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicIconsArray",         {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicIconsObject",        {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicIconsKey",           {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicIconsNull",          {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    {default = true, bg = colors.bg, fg = colors.yellow})
vim.api.nvim_set_hl(0, "NavicIconsStruct",        {default = true, bg = colors.bg, fg = colors.yellow})
vim.api.nvim_set_hl(0, "NavicIconsEvent",         {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicIconsOperator",      {default = true, bg = colors.bg, fg = colors.cyan})
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicText",               {default = true, bg = colors.bg, fg = colors.fg})
vim.api.nvim_set_hl(0, "NavicSeparator",          {default = true, bg = colors.bg, fg = colors.fg})

local windows = {
  function ()
    return " " .. vim.api.nvim_win_get_number(0)
  end,
  separator = {left = '', right = ''},
  padding = 0, 
}
local function terminal()
  if vim.o.buftype == "terminal" then
    return " " .. vim.o.channel
  end
  return ""
end

local function tabs()
  local total_tabs = vim.fn.tabpagenr("$")
  local tab_id = vim.fn.tabpagenr()
  return " " ..tab_id .. "/" .. total_tabs
end

local hide_in_width = function()
	return vim.o.columns > 100
end

local diff = { "diff",
    symbols = { added = " ", modified = " ", removed = " " },
    colored = true,
    -- padding = {left=1, right=0}
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end,
  }

local branch = {
  "b:gitsigns_head",
  icon = "",
  color = { gui = "bold," },
  separator = { left = '' , right = '' },
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
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return ""
    end
    local output = " "
    for _, client in pairs(clients) do
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
    -- component_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "TelescopePrompt", "floaterm" },
    always_divide_middle = true,
    globalstatus = true,
  },

  sections = {
    lualine_a = {
      branch,
    },
    lualine_b = {
      python_env,
      {'filetype', icon_only = true, padding = {left=1, right=0}, separator = false,},
      {'filename', path = 1, color = { gui = "italic"} },
    },
    lualine_c = {
      diff,
    },
    lualine_x = {  },
    lualine_y = { lsp, treesitter, },
    lualine_z = {
      terminal,
      tabs,
      { 'hostname', icon = ' ', },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = { terminal, windows }
  },

  winbar = {
    lualine_c = {
      {'filetype', icon_only = true, padding = {left=1, right=0}, separator = false,},
      {'filename', path = 0, separator = ">", color = { gui = "italic"} },
      { navic.get_location, cond = navic.is_available, },
    },

    lualine_x = {
      { "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        colored = true,
        update_in_insert = false,
        -- always_visible = true,
      }
    },
    lualine_y = { spaces,  'progress', 'fileformat' },
    lualine_z = { terminal, windows }
  },
  inactive_winbar = {
    lualine_c = {
      {'filetype', icon_only = true, padding = {left=1, right=0}, separator = false,},
      {'filename', path = 0, separator = ">", color = { gui = "italic"} },
    },
    lualine_z = { terminal, windows },
  },

  tabline = {},
  extensions = { 'quickfix', 'nvim-tree'}
}

-- vim.wo.winbar = " %{winnr()}::%f > %{%v:lua.require'nvim-navic'.get_location()%}"
-- vim.opt.winbar = "%{%v:lua.require'omega.modules.ui.winbar'.eval()%}"
