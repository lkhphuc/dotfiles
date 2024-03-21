vim.g.lazyvim_python_lsp = "basedpyright"
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
                diagnosticSeverityOverrides = {
                  reportUnusedCallResult = "information",
                  reportUnusedExpression = "information",
                  reportUnknownMemberType = "none",
                  reportUnknownLambdaType = "none",
                  reportUnknownParameterType = "none",
                  reportMissingParameterType = "none",
                  reportUnknownVariableType = "none",
                  reportUnknownArgumentType = "none",
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
        ruff_lsp = {
          init_options = {
            settings = {
              args = {
                "--extend-select",
                "W,C90,UP,ASYNC,S,B,A,COM,C4,DTZ,T10,EXE,ISC,ICN,G,INP,PIE,PYI,PT,RET,SIM,TID,TCH,PL,TRY,PD,NPY,PERF",
                "--ignore",
                "E402,E501,W291,PLR0913,W293,S101,RET504,RET505,C901,TRY003,F401,PLR0915,COM812,PLR2004,S301,S311,PIE808,B007,UP039,SIM300,PLR5501",
              },
            },
          },
        },
      },
    },
  },
  {
    "venv-selector.nvim",
    opts = {
      anaconda_base_path = vim.fn.fnamemodify(os.getenv("CONDA_EXE"), ":p:h:h"),
      anaconda_envs_path = vim.fn.fnamemodify(os.getenv("CONDA_EXE"), ":p:h:h") .. "/envs",
    }
  },
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "yapf" },
      },
    },
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
            highlight! semshiGlobal gui=italic
            highlight! semshiImported gui=bold
            highlight! semshiBuiltin gui=bold,italic
            highlight! link semshiParameter @lsp.variable.parameter
            highlight! link semshiParameterUnused DiagnosticUnnecessary
            highlight! link semshiAttribute @variable.member
            highlight! link semshiSelf @lsp.type.selfKeyword
            highlight! link semshiUnresolved @lsp.type.unresolvedReference
            highlight! link semshiFree @keyword.import
            ]])
        end,
      })
    end,
  },
}
