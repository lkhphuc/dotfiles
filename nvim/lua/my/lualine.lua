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

local dap = {
  function ()
    local stat = require("dap").status()
    if stat == "" then
      return ""
    end
    return " ".. stat
  end
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
        return  vim.api.nvim_buf_get_option(0, "tabstop").." "
      end
      local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
      if size == 0 then
        size = vim.api.nvim_buf_get_option(0, "tabstop")
      end
      return  size..""
    end,
    cond = hide_in_width,
  }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '|',
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      winbar = {"dashboard", "NvimTree", "Outline", "TelescopePrompt", "Mundo", "MundoDiff", },
    },
    always_divide_middle = false,
    globalstatus = true,
  },

  sections = {
    lualine_a = {
      "mode",
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
      },
    },
    lualine_b = {
      'branch',
      diff,
      {'filetype', icon_only = true, padding = {left=1, right=0}, separator = false,},
      {'filename', path = 1, color = { gui = "italic"}, separator = false },
    },
    lualine_c = {
      { navic.get_location, cond = navic.is_available, },
    },
    lualine_x = { diagnostics, dap, lsp, treesitter, },
    lualine_y = { spaces, 'progress', 'fileformat', },
    lualine_z = { python_env, { 'hostname', icon = ' ', left_padding = 2 } },
  },
  tabline = {
    lualine_a = {
      windows,
      terminal,
    },
    lualine_b = {
      {'windows', mode = 2, },
    },
    lualine_y = {
      {'tabs',
        max_length = vim.o.columns,
        mode = 3,
      },
    },
    lualine_z = { tabs, },
  },
  extensions = { 'quickfix', 'nvim-tree'}
}
