local M = {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
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

function M.config()
  local noice = require("noice").api.status

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = '┊', --        
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        winbar = { "dashboard", "NvimTree", "Outline", "TelescopePrompt", "Mundo", "MundoDiff", },
      },
      always_divide_middle = false,
      globalstatus = true,
    },

    sections = {
      lualine_a = {
        { 'mode', separator = { left = '' }, padding = {left = 0, right = 1} },
      },
      lualine_b = {
        { noice.mode.get, cond = noice.mode.has, },
        { 'branch', color = { gui = "italic" } },
      },
      lualine_c = {
        { terminal_idx },
        { 'filetype', icon_only = true, separator = "", padding = { left = 1, right = 0}},
        { "filename", path = 1, symbols = { modified = "●", readonly = "", unnamed = "" } },
        { require('nvim-navic').get_location, cond = require('nvim-navic').is_available, separator = { left = ">"} },
      },
      lualine_x = {
        { noice.command.get_hl, cond = noice.command.has, },
        'progress',
      },
      lualine_y = {  dap, lsp, spaces, },
      lualine_z = {
        python_env,
        -- tabs_count,
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
