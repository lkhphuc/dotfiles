local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    -- Python
    -- diagnostics.pylama,
    diagnostics.flake8.with({
      extra_args = {
        "--extend-ignore", "E111,E114,E501",
        "--indent-size", vim.o.shiftwidth,
      }
    }),
    -- diagnostics.pylint,
    -- diagnostics.mypy, -- mostly already covered by Pyright
    formatting.black,
    formatting.isort,
    -- Lua
    formatting.stylua,
    -- sh
    code_actions.shellcheck,
  }
})
