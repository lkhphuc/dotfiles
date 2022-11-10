local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover

null_ls.setup({
  sources = {
    diagnostics.ruff.with({
      extra_args = function(params)
        return params and {
          "--extend-ignore", "E111, E114,E501,F722",
          -- "--indent-size", vim.fn.shiftwidth(),
        }
      end
    }),

    formatting.yapf.with({
      extra_args = function(params)
        return params and {
          "--style={indent_width:"..vim.fn.shiftwidth().."}",
        }
      end
    }),
    formatting.usort,
    formatting.stylua,

    code_actions.shellcheck,

    hover.dictionary,
    hover.printenv,
  }
})
