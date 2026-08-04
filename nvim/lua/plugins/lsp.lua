return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "simple",
      hi = {
        error = "DiagnosticVirtualTextError",
        warn = "DiagnosticVirtualTextWarn",
        info = "DiagnosticVirtualTextInfo",
        hint = "DiagnosticVirtualTextHint",
      },
      options = {
        show_source = { enabled = true, if_many = true, },
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@type vim.diagnostic.Opts
    opts = {
      diagnostics = { virtual_text = false },
      servers = {
        ["*"] = {
          -- keys = {
          --   { "<leader>uv", toggle_diag_virtext, has="diagnostics", desc = "Toggle diagnostic virtualtext"}
          -- }
        }
      },
      setup = {
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = true, text = "" },
      action_kinds = { "quickfix", "refactor" },
      ignore = {
        actions_without_kind = true,
      },
    },
  },
  { "saghen/blink.cmp",
    opts = {
      sources = {
        providers = { lsp = { async = true } },
      },
    },
  },
  {
    "felpafel/inlay-hint.nvim",
    event = "LspAttach",
    opts = {},
  },
  { "rcarriga/nvim-dap-ui", enabled = false },
  {
    "MironPascalCaseFan/debugmaster.nvim",
    dependencies = { "mfussenegger/nvim-dap", },
    keys = {
      {"<leader>dd", function() require("debugmaster").mode.toggle() end, mode={"n", "v"}, nowait=true,}
    },
    config = function()
      local dm = require("debugmaster")
      dm.keys.get("U").key = "F"
      dm.keys.get("u").key = "U"
    end,
  },
  { "theHamsta/nvim-dap-virtual-text", 
    opts = {
      display_callback = function(variable, buf, stackframe, node, options)
        -- by default, strip out new line characters
        if options.virt_text_pos == 'inline' then
          if #variable.value > 100 then
            return ' = ' .. variable.value:gsub("%s+", " "):sub(1, 100) .. '...'
          else
            return ' = ' .. variable.value:gsub("%s+", " ")
          end
        else
          return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
        end
      end,
    }
  },
}
