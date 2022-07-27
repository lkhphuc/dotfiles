local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    -- Python
    -- diagnostics.pylama,
    diagnostics.flake8.with({
      extra_args = function(params)
        return params
        and {
          "--extend-ignore", "E111,E114,E501,F722",
          "--indent-size", vim.fn.shiftwidth(),
        }
      end,
    }),
    -- diagnostics.mypy.with({
    --   extra_args = {
    --     "--ignore-missing-imports",
    --   }
    -- }),
    formatting.yapf,
    formatting.isort,

    -- Lua
    formatting.stylua,
    -- sh
    code_actions.shellcheck,
  }
})
