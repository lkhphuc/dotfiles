---@diagnostic disable: missing-fields
return {
  {
    "nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        ---@type lspconfig.options.basedpyright
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
                diagnosticSeverityOverrides = {
                  reportOptionalMemberAccess = "none",
                  reportUnusedVariable = "none",
                  reportUnusedCallResult = "none",
                  reportUnusedExpression = "none",
                  reportUnknownMemberType = "none",
                  reportUnknownLambdaType = "none",
                  reportUnknownParameterType = "none",
                  reportUnknownVariableTypeType = "none",
                  reportMissingParameterType = "none",
                  reportMissingTypeStub = "information",
                  reportUnknownVariableType = "none",
                  reportUnknownArgumentType = "none",
                  reportImplicitOverride = "none",
                  reportAny = "none",
                },
              },
            },
          }
        },
        ---@type lspconfig.options.pyright
        pyright = {
          settings = {
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportGeneralTypeIssues = "information",
                  reportPrivateImportUsage = "information",
                  reportOptionalOperand = "information",
                  reportOptionalSubscript = "information",
                  reportOptionalMemberAccess = "information",
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "venv-selector.nvim",
    enabled = false,
    opts = {
      anaconda_base_path = vim.fn.fnamemodify(os.getenv("CONDA_EXE") or "", ":p:h:h"),
      anaconda_envs_path = vim.fn.fnamemodify(os.getenv("CONDA_EXE") or "", ":p:h:h") .. "/envs",
    }
  },
  {
    -- "numiras/semshi",
    "wookayin/semshi", -- use a maintained fork
    enabled = false,
    ft = "python",
    build = ":UpdateRemotePlugins",
    init = function()
      -- Disabled these features better provided by LSP or other more general plugins
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
      vim.g["semshi#update_delay_factor"] = 0.001

      -- This autocmd must be defined in init to take effect
      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
        callback = function()
          -- Only add style, inherit or link to the LSP's colors
          vim.cmd([[
            highlight! semshiGlobal gui=bold
            highlight! semshiImported gui=italic
            highlight! semshiBuiltin gui=bold,italic
            highlight! link semshiParameter @lsp.type.parameter
            highlight! link semshiParameterUnused DiagnosticUnnecessary
            highlight! link semshiAttribute @variable.member
            highlight! link semshiSelf @lsp.type.selfParameter
            highlight! semshiUnresolved gui=undercurl
            highlight! link semshiFree @lsp.typemod.variable.static
            ]])
        end,
      })
    end,
  },
}
