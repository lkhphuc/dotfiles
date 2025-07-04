return {
  { "nvim-notify", opts = { background_colour = "NormalFloat" } },
  {
    "noice.nvim",
    opts = {
      presets = {
        bottom_search = false, -- a classic bottom cmdline for search
      },
      views = {
        hover = {
          win_options = { winblend = 20 },
        },
      },
      routes = {
        {
          filter = {
            any = {
              { find = "No information available" },
              { find = "E486" },
              { find = "E490" },
              { find = "osc52" },
              { find = "more line" },
              { find = "line less" },
              { find = "fewer line" },
              { find = "lines? yanked" },
              { find = " changes?;" },
              { find = "Already at newest change" },
              { event = "msg_show", find = "No more valid diagnostics to move to" },
              { event = "msg_show", find = "^E486: Pattern not found" },
              { event = "msg_show", find = "^Hunk " },
            },
          },
          view = "mini",
        },
        {
          filter = {
            any = {
              { event = "msg_show", find = "^[/?]." },
            },
          },
          skip = true,
        },
      },
    },
  },
  {
    "folke/edgy.nvim",
    enabled = true,
    opts = {
      animate = { enabled = not vim.g.neovide },
      keys = {
        ["<M-Right>"] = function(win) win:resize("width", 2) end,
        ["<M-Left>"] = function(win) win:resize("width", -2) end,
        ["<M-Down>"] = function(win) win:resize("height", 2) end,
        ["<M-Up>"] = function(win) win:resize("height", -2) end,
      },
    },
    keys = {
      {
        "<localleader>e",
        function()
          vim.b.edgy_disable = not vim.b.edgy_disable
          LazyVim.notify((vim.b.edgy_disable and "Disable" or "Enable") .. " Edgy for buffer")
        end,
        desc = "Edgy (un)attach",
      },
    },
  },
  {
    "which-key.nvim",
    opts = { preset = "helix" },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = {
        component_separators = "", -- ┊ |        
        section_separators = "", -- { left = "", right = "" },
      }
      opts.sections.lualine_a = {
        {
          "mode",
          icon = "", --   
          fmt = function(str) return str:sub(1, 3) end,
          color = { gui = "bold" },
        },
      }
      table.insert(opts.sections.lualine_b, {
        function() return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") end,
        color = { gui = "italic", fg = require("snacks").util.color("Operator") },
      })
      opts.sections.lualine_c[1] = require("lazyvim.util").lualine.root_dir({ cwd = true })
      opts.sections.lualine_c[2] = "" -- no diagnostic in statusline
      opts.sections.lualine_c[4] = LazyVim.lualine.pretty_path({ length = 7 })

      -- Remove some LazyVim's default
      for _, component in ipairs(opts.sections.lualine_x) do
        if component[1] == "diff" then component[1] = "" end
      end
      vim.list_extend(opts.sections.lualine_x, {
        {
          function() return require("noice").api.status.search.get() end,
          cond = function()
            return package.loaded["noice"] and require("noice").api.status.search.has()
          end,
          color = { fg = require("snacks").util.color("DiagnosticOk") },
        },
        { --python venv
          function()
            local venv = os.getenv("VIRTUAL_ENV_PROMPT") or os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV") or "No Env"
            return " " .. venv
          end,
          cond = function() return vim.bo.filetype == "python" end,
          color = { fg = require("snacks").util.color("Operator"), gui = "italic" },
        },
      })

       opts.sections.lualine_y[2] = { "location", padding = { left = 0, right = 1 }, icon = "" }
       table.insert(opts.sections.lualine_y, 1, {
         function() -- lsp
           local num_clients = #vim.lsp.get_clients({ bufnr = 0 })
           if num_clients > 0 then return " " .. num_clients end
           return ""
         end,
         color = { fg = require("snacks").util.color("Type") },
       })
      table.insert(opts.sections.lualine_y, 1, { --terminal
        function() return " " .. vim.o.channel end,
        cond = function() return vim.o.buftype == "terminal" end,
        color = {fg =  require("snacks").util.color("Type")},
      })

      opts.sections.lualine_z = {
        { -- tabs
          function() return " " .. vim.fn.tabpagenr() .. "/" .. vim.fn.tabpagenr("$") end,
          cond = function() return vim.fn.tabpagenr("$") > 1 end,
          color = { gui = "bold" },
          separator = "|",
        },
        { "hostname", icon = "󰢹" },
      }

    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "BufEnter",
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
      render = function(props)
        local helpers = require("incline.helpers")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"

        local function get_git_diff()
          local icons = require("lazyvim.config").icons.git
          icons["changed"] = icons.modified
          local summary = vim.b.minidiff_summary
          summary = summary
              and {
                added = summary.add,
                modified = summary.change,
                removed = summary.delete,
              }
            or vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if summary == nil then return labels end
          for name, icon in pairs(icons) do
            if tonumber(summary[name]) and summary[name] > 0 then
              table.insert(labels, { icon .. summary[name] .. " ", group = "Diff" .. name })
            end
          end
          -- if #labels > 0 then table.insert(labels, { "┊ " }) end
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
          ft_icon and {
            " " .. ft_icon .. " ",
            guibg = ft_color,
            guifg = helpers.contrast_color(ft_color),
          } or "",
          { " " .. filename, gui = modified },
          { " 󰕮 " .. vim.api.nvim_win_get_number(props.win), group = "lualine_b_visual" },
        }
        return buffer
      end,
    },
  },
  {
    "echasnovski/mini.animate",
    vscode = false,
    opts = {
      open = { enable = false },
      close = { enable = false },
      resize = { enable = false },
    },
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        matcher = { frecency = true },
        formatters = { file = { truncate = 120 }},
      },
      statuscolumn = {
        folds = {
          open = true,
          git_hl = true,
        }
      }
    }
  }
}
