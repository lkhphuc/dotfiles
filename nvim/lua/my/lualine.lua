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
vim.api.nvim_set_hl(0, "NavicIconsObject",        {default = true, bg = colors.bg, fg = colors.green})
vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    {default = true, bg = colors.bg, fg = colors.yellow})
vim.api.nvim_set_hl(0, "NavicIconsStruct",        {default = true, bg = colors.bg, fg = colors.yellow})
vim.api.nvim_set_hl(0, "NavicIconsOperator",      {default = true, bg = colors.bg, fg = colors.cyan})

local windows = {
  function ()
    return " " .. vim.api.nvim_win_get_number(0)
  end,
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
    local venv = os.getenv("CONDA_DEFAULT_ENV") or _env_cleanup(os.getenv("VIRTUAL_ENV"))
    if venv then
      return " "..venv
    end
  end,
  cond = hide_in_width,
}

local treesitter = {
  function()
    local b = vim.api.nvim_get_current_buf()
    if next(vim.treesitter.highlighter.active[b]) then
      return ""
    end
  end,
  color = { fg = colors.green },
  cond = hide_in_width,
}

local lsp = {
  function(_)
    local clients = vim.lsp.get_active_clients({bufnr = 0})
    if next(clients) == nil then
      return ""
    end
    local output = " "
    for _, client in pairs(clients) do
      output = output .. ":" .. client.name
    end
    return output
  end,
  cond = hide_in_width,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { 'error', 'warn', 'info', 'hint' },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
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
  }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = { left = '𑗅', right = '𑗅' },
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    disabled_filetypes = {
      winbar = {"dashboard", "NvimTree", "Outline", "TelescopePrompt", "Mundo", "MundoDiff", },
    },
    always_divide_middle = false,
    globalstatus = true,
  },

  sections = {
    lualine_a = { branch, terminal, },
    lualine_b = {
      diff,
      {'filetype', icon_only = true, padding = {left=1, right=0}, separator = false,},
      {'filename', path = 1, color = { gui = "italic"}, separator = false },
    },
    lualine_c = {
      { navic.get_location, cond = navic.is_available, },
    },
    lualine_x = { diagnostics, lsp, treesitter, },
    lualine_y = { spaces, 'progress', 'fileformat', },
    lualine_z = { python_env, { 'hostname', icon = ' ',} },
  },
  tabline = {
    lualine_a = {
      windows,
    },
    lualine_c = {
      {'windows',
        mode = 2,
        windows_color = {
          active = 'lualine_c_normal',
          inactive = 'lualine_c_inactive',
        }
      },
    },
    lualine_y = {
      {'tabs',
        max_length = vim.o.columns,
        mode = 3,
        tabs_color = {
          active = 'lualine_b_normal',
          inactive = 'lualine_b_inactive',
        },
      },
    },
    lualine_z = { tabs, },
  },
  extensions = { 'quickfix', 'nvim-tree'}
}
