local fg = require("lazyvim.util").fg

local function is_wide_term(width)
  width = width or 150
  return vim.o.columns > width
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = '', -- ┊ |        
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          winbar = { "dashboard", "NeoTree", "Outline", "TelescopePrompt", "Mundo", "MundoDiff" },
        },
        -- always_divide_middle = false,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",
            fmt = function(str) return str:sub(1, 1) end,
            separator = { left = "", right = "" },
            padding = 0,
          },
        },
        lualine_b = {
          { "branch", color = fg("Special"), cond = is_wide_term },
          {
            function() return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") end,
            color = { gui = "italic", fg=fg("Constant").fg},
          },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "" },
          {
            "filename",
            path = 1,
            symbols = { modified = "●", readonly = "", unnamed = "" },
            separator = false,
            padding = 0,
          },
          {
            function() return require("nvim-navic").get_location() end,
            cond = function()
              return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
            end,
            color = { guibg = "none" },
          },
        },
        lualine_x = {
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = fg("Debug"),
          },
          {
            function() return require("noice").api.status.search.get() end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.search.has()
            end,
            color = fg("DiagnosticVirtualTextInfo"),
          },
          {
            function() return require("noice").api.status.command.get() end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = fg("Statement"),
          },
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = fg("Constant"),
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = fg("Special"),
          },
          { "location", separator = false},
          { "progress", icon = "", },
        },
        lualine_y = {
          {
            function() return " " .. vim.api.nvim_get_option_value("tabstop", { buf = 0 }) end,
            cond = is_wide_term,
          },
          {
            function()
              local num_clients = #vim.lsp.get_clients({ bufnr = 0 })
              if num_clients > 0 then return " " .. num_clients end
              return ""
            end,
            color = fg("Constant"),
          },
          { --terminal
            function() return " " .. vim.o.channel end,
            cond = function() return vim.o.buftype == "terminal" end,
          },
        },
        lualine_z = {
          { "hostname", icon = "", separator = { left = "", right = "" }, padding = 0 },
        },
      },
      extensions = { "neo-tree", "lazy", "quickfix", "nvim-tree" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      {
        "tiagovla/scope.nvim",
        opts = {},
        init = function()
          require("lazyvim.util").on_load(
            "telescope",
            function() require("telescope").load_extension("scope") end
          )
        end,
        keys = {
          { "<leader>.",  "<Cmd>Telescope scope buffers<CR>", desc = "Search buffers from all tabs" },
          { "<leader>bm",  "<Cmd>ScopeMoveBuf<CR>", desc = "Move buffer to another tab" },
        }
      },
    },
    keys = {
      { "gb", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
    },
    opts = {
      options = {
        always_show_bufferline = true,
        diagnostics = false,
        -- separator_style = "slope",
      },
    },
  },
  {
    "b0o/incline.nvim",
    branch = "main",
    event = "BufReadPost",
    opts = {
      window = { zindex = 40, margin = { horizontal = 0, vertical = 0 } },
      hide = { cursorline = true },
      -- ignore = { buftypes = function(bufnr, buftype) return false end },
      render = function(props)
        if vim.bo[props.buf].buftype == "terminal" then
          return {
            { " " .. vim.bo[props.buf].channel .. " ", group = "DevIconTerminal" },
            { " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
          }
        end

        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.api.nvim_get_option_value("modified", { buf = 0 }) and "bold,italic"
          or "bold"

        local function get_git_diff()
          local icons = require("lazyvim.config").icons.git
          icons["changed"] = icons.modified
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then return labels end
          for name, icon in pairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
            end
          end
          if #labels > 0 then table.insert(labels, { "┊ " }) end
          return labels
        end
        local function get_diagnostic_label()
          local icons = require("lazyvim.config").icons.diagnostics
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(
              props.buf,
              { severity = vim.diagnostic.severity[string.upper(severity)] }
            )
            if n > 0 then
              table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then table.insert(label, { "┊ " }) end
          return label
        end

        local buffer = {
          { get_diagnostic_label() },
          { get_git_diff() },
          { ft_icon .. " ", guifg = ft_color, guibg = "none" },
          { filename .. " ", gui = modified },
          -- { " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
        }
        return buffer
      end,
    },
  },
}
