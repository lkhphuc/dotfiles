local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    -- Python
    diagnostics.pylama,
    -- diagnostics.flake8,
    -- diagnostics.pylint,
    -- diagnostics.mypy, -- mostly already covered by Pyright
    formatting.black,
    formatting.isort,
    -- Lua
    formatting.stylua,
  }
})
