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
                "W,ARG,I,UP,ANN,B,A,C4,T10,ICN,G,RET,SIM,PTH,PD,PL,NPY",
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
    -- enabled = false,
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
    "hanschen/vim-ipython-cell",
    enabled = false,
    ft = "python",
    init = function()
      vim.g.slime_python_ipython = 1
      vim.keymap.set(
        "n",
        "<leader>ri",
        "<Cmd>SlimeSend1 ipython --matplotlib --ext=autoreload<CR>",
        { desc = "Run interpreter" }
      )
      vim.keymap.set(
        "n",
        "<leader>ra",
        "<Cmd>SlimeSend1 %autoreload 2<CR>",
        { desc = "Autoreload python module" }
      )
      vim.keymap.set("n", "<leader>rd", "<Cmd>SlimeSend1 %debug<CR>", { desc = "Debug ipython" })
      vim.keymap.set("n", "<leader>re", "<Cmd>SlimeSend1 exit<CR>", { desc = "Exit" })
      vim.keymap.set("n", "<leader>rs", "<Cmd>IPythonCellRun<CR>", { desc = "Run script" })
      vim.keymap.set(
        "n",
        "<leader>rS",
        "<Cmd>IPythonCellRunTime<CR>",
        { desc = "Run script and time it" }
      )
      vim.keymap.set(
        "n",
        "<leader>rc",
        "<Cmd>IPythonCellClear<CR>",
        { desc = "Clear IPython screen" }
      )
      vim.keymap.set(
        "n",
        "<leader>rx",
        "<Cmd>IPythonCellClose<CR>",
        { desc = "Close all matplotlib figure windows" }
      )
      vim.keymap.set(
        "n",
        "<leader>rp",
        "<Cmd>IPythonCellPrevCommand<CR>",
        { desc = "Run Previous command" }
      )
      vim.keymap.set("n", "<leader>rR", "<Cmd>IPythonCellRestart<CR>", { desc = "Restart ipython" })
      vim.keymap.set(
        "n",
        "<leader>cc",
        "<Cmd>IPythonCellExecuteCellJump<CR>",
        { desc = "Execute and jumpt to next cell" }
      )
      vim.keymap.set(
        "n",
        "<leader>cC",
        "<Cmd>IPythonCellExecuteCell<CR>",
        { desc = "Execute cell" }
      )
      vim.keymap.set(
        "n",
        "<leader>cj",
        "<Cmd>IPythonCellNextCell<CR>",
        { desc = "Jump to previous cell" }
      )
      vim.keymap.set(
        "n",
        "<leader>ck",
        "<Cmd>IPythonCellNextCell<CR>",
        { desc = "Jump to next cell" }
      )
      vim.keymap.set(
        "n",
        "<leader>ci",
        "<Cmd>IPythonCellInsertAbove<CR>i",
        { desc = "Insert new cell above" }
      )
      vim.keymap.set(
        "n",
        "<leader>ca",
        "<Cmd>IPythonCellNextCell<CR>i",
        { desc = "Insert new cell below" }
      )
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
    opts = { timeout = 5 },
    build = ":UpdateRemotePlugins",
    cmd = "JupyterAttach",
    keys = { { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" } },
    dependencies = { "stsewd/sphinx.nvim" },
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
