return {
  -- "AckslD/swenv.nvim",
  {
    "nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {
          -- disable hint, which are covered by ruff-lsp
          capabilities = (function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            return capabilities
          end)(),
          settings = {
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportGeneralTypeIssues = "information",
                },
              },
            },
          },
        },
        ruff_lsp = {
          on_attach = function(client, _) client.server_capabilities.hoverProvider = false end,
          init_options = {
            settings = {
              args = {
                "--extend-select",
                "W,ARG,I,UP,B,A,C4,T10,ICN,G,RET,SIM,PD,PL,NPY",
                "--ignore",
                "E501,W291",
              },
            },
          },
        },
      },
    },
  },

  { -- semantic hightlight
    "wookayin/semshi",
    ft = "python",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g["semshi#error_sign"] = false
      vim.g["semshi#simplify_markup"] = false
      vim.g["semshi#mark_selected_nodes"] = false
      vim.g["semshi#update_delay_factor"] = 0.001
    end,
  },
  {
    "goerz/jupytext.vim",
    event = "BufAdd *.ipynb",
    init = function() vim.g.jupytext_fmt = "py" end,
  },
  {
    "lkhphuc/jupyter-kernel.nvim",
    dev = true,
    opts = { timeout = 0.5 },
    build = ":UpdateRemotePlugins",
    cmd = "JupyterAttach",
    keys = { { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" } },
  },
  {
    "WhiteBlackGoose/magma-nvim-goose",
    build = ":UpdateRemotePlugins",
    cmd = "MagmaInit",
    keys = {
      { "<leader>r", "<cmd>MagmaEvaluateOperator<CR>", expr = true },
      { "<leader>rr", "<cmd>MagmaEvaluateLine<CR>" },
      { "<leader>rc", "<cmd>MagmaReevaluateCell<CR>" },
      { "<leader>rd", "<cmd>MagmaDelete<CR>" },
      { "<leader>ro", "<cmd>MagmaShowOutput<CR>" },
      { "<leader>r", ":<C-u>MagmaEvaluateVisual<CR>", mode = "v" },
    },
  },
}
