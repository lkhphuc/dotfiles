return {
  {
    "nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                diagnosticSeverityOverrides = { reportGeneralTypeIssues = "warning" },
              },
            },
          },
        },
        ruff_lsp = {
          init_options = {
            settings = {
              args = {
                "--extend-select",
                "W,UP,B,A,T10,ICN,G,SIM,PD,PL,NPY",
                "--ignore",
                "E501,W291,PLR0913",
              },
            },
          },
        },
      },
    },
  },
  {
    "goerz/jupytext.vim",
    event = "BufAdd *.ipynb",
    config = function() vim.g.jupytext_fmt = "py" end,
  },
  {
    "lkhphuc/jupyter-kernel.nvim",
    opts = { timeout = 0.5 },
    build = ":UpdateRemotePlugins",
    cmd = "JupyterAttach",
    keys = { { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" } },
  },
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    cmd = "MagmaInit",
    keys = {
      { "<leader>r",  "<cmd>MagmaEvaluateOperator<CR>", expr = true },
      { "<leader>rr", "<cmd>MagmaEvaluateLine<CR>" },
      { "<leader>rc", "<cmd>MagmaReevaluateCell<CR>" },
      { "<leader>rd", "<cmd>MagmaDelete<CR>" },
      { "<leader>ro", "<cmd>MagmaShowOutput<CR>" },
      { "<leader>r",  ":<C-u>MagmaEvaluateVisual<CR>",  mode = "v" },
    },
  },
}
