local function get_venv(variable)
  local venv = os.getenv(variable)
  if venv ~= nil and string.find(venv, "/") then
    local orig_venv = venv
    for w in orig_venv:gmatch("([^/]+)") do
      venv = w
    end
    venv = string.format("%s", venv)
  end
  return venv
end

return {
  {
    "lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          local venv = get_venv("CONDA_DEFAULT_ENV") or get_venv("VIRTUAL_ENV") or "NO ENV"
          return " " .. venv
        end,
        cond = function() return vim.bo.filetype == "python" end,
        color = require("lazyvim.util.ui").fg("Operator")
      })
    end,
  },
  { "venv-selector.nvim", enabled = false },
  {
    "nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      ---@diagnostic disable-next-line: missing-fields
      servers = {
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
                "E402,E501,W291,PLR0913,W293,S101,RET504,RET505,C901,TRY003,F401,PLR0915,COM812,PLR2004,S301,S311,PIE808,B007s,UP039,SIM300,PLR5501",
              },
            },
          },
        },
      },
    },
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
    "goerz/jupytext.vim",
    event = "BufAdd *.ipynb",
    config = function() vim.g.jupytext_fmt = "py" end,
  },
  {
    "lkhphuc/jupyter-kernel.nvim",
    opts = { timeout = 0.5 },
    build = ":UpdateRemotePlugins",
    cmd = "JupyterAttach",
    keys = {
      { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel", ft = "python" },
    },
  },
  {
    "nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "jupyter",
        group_index = 1,
        priority = 100,
      })
    end,
  },
  {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    cmd = "MoltenInit",
    keys = {
      { "<leader>r", "<cmd>MoltenEvaluateOperator<CR>", expr = true },
      { "<leader>rr", "<cmd>MoltenEvaluateLine<CR>" },
      { "<leader>rc", "<cmd>MoltenReevaluateCell<CR>" },
      { "<leader>rd", "<cmd>MoltenDelete<CR>" },
      { "<leader>ro", "<cmd>MoltenShowOutput<CR>" },
      { "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v" },
    },
  },
}
