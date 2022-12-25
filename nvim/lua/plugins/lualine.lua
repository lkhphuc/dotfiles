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

local windows_idx = {
  function()
    return " " .. vim.api.nvim_win_get_number(0)
  end,
}
local function terminal_idx()
  if vim.o.buftype == "terminal" then
    return " " .. vim.o.channel
  end
  return ""
end

local function tabs_count()
  local total_tabs = vim.fn.tabpagenr("$")
  local tab_id = vim.fn.tabpagenr()
  return " " .. tab_id .. "/" .. total_tabs
end

local width_gt_than = function(width)
  return vim.o.columns > width
end

local diff = { "diff",
  symbols = { added = " ", modified = " ", removed = " " },
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
      return " " .. venv
    end
  end,
  -- cond = width_gt_than(120),
}

local treesitter = {
  function()
    local b = vim.api.nvim_get_current_buf()
    if next(vim.treesitter.highlighter.active[b]) then
      return ""
    end
  end,
  color = { fg = colors.green },
  -- cond = width_gt_than(120),
}

local lsp = {
  function(_)
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    if next(clients) == nil then
      return ""
    end
    local output = " " .. #clients
    -- for _, client in pairs(clients) do
    --   output = output .. ":" .. client.name
    -- end
    return output
  end,
  -- cond = width_gt_than(120),
}

local dap = {
  function()
    local stat = require("dap").status()
    if stat == "" then
      return ""
    end
    return " " .. stat
  end
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { 'error', 'warn', 'info', 'hint' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ', },
  colored = true,
  update_in_insert = false,
}

local spaces = {
  function()
    if not vim.api.nvim_buf_get_option(0, "expandtab") then
      return vim.api.nvim_buf_get_option(0, "tabstop") .. " "
    end
    local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
    if size == 0 then
      size = vim.api.nvim_buf_get_option(0, "tabstop")
    end
    return size .. ""
  end,
  -- cond = width_gt_than(120),
}

local M = {
  'nvim-lualine/lualine.nvim',
}

function M.config()
  local custom_fname = require('lualine.components.filename'):extend()
  local highlight = require 'lualine.highlight'

  function custom_fname:init(options)
    custom_fname.super.init(self, options)
    self.status_colors = {
      saved = highlight.create_component_highlight_group(
        { gui = "bold" }, 'filename_status_saved', self.options),
      modified = highlight.create_component_highlight_group(
        { gui = "bold,italic" }, 'filename_status_modified', self.options),
    }
    if self.options.color == nil then self.options.color = '' end
  end

  function custom_fname:update_status()
    local data = custom_fname.super.update_status(self)
    data = highlight.component_format_highlight(vim.bo.modified
      and self.status_colors.modified
      or self.status_colors.saved) .. data
    return data
  end

  local noice = require("noice").api.status


  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = '|',
      -- component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      -- section_separators = { left = '', right = '' },
      disabled_filetypes = {
        winbar = { "dashboard", "NvimTree", "Outline", "TelescopePrompt", "Mundo", "MundoDiff", },
      },
      always_divide_middle = false,
      globalstatus = true,
    },

    sections = {
      lualine_a = {
        { 'mode',
          separator = { left = '', right = '' },
          fmt = function(str) return str:sub(1, 1) end,
        },
        { noice.mode.get, cond = noice.mode.has, },
        { 'branch', color = { gui = "italic" } },
      },
      lualine_b = {
        { 'filetype', icon_only = true, },
        { custom_fname, path = 1, padding = 0, separator = { right = '', } },
      },
      lualine_c = {
        { require('nvim-navic').get_location, cond = require('nvim-navic').is_available, },
      },
      lualine_x = {
        { noice.command.get_hl, cond = noice.command.has, },
      },
      lualine_y = { dap, lsp, spaces, 'progress', 'fileformat', },
      lualine_z = {
        python_env,
        tabs_count,
        { 'hostname', icon = ' ', separator = { right = '' }, },
      },
    },
    -- tabline = {
    --   lualine_a = {
    --     windows_idx,
    --     terminal_idx,
    --   },
    --   lualine_b = {
    --     {'windows', mode = 2, },
    --   },
    --   lualine_y = {
    --     {'tabs',
    --       max_length = vim.o.columns,
    --       mode = 3,
    --     },
    --   },
    --   lualine_z = { tabs_count, },
    -- },
    extensions = { 'quickfix', 'nvim-tree' }
  }
end

return M
