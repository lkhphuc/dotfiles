local M = {}

M.signs = { Error = "", Warn = "", Hint = "", Info = "", }

function M.setup()
  vim.diagnostic.config({
    virtual_text = { spacing = 4, prefix = "●" },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    -- float = {
    --   focusable = false,
    --   style = "minimal",
    --   border = "rounded",
    --   source = "if_many",
    --   header = "",
    --   -- prefix = "",
    -- },
  })
  vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
    local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
    pcall(vim.diagnostic.reset, ns)
    return true
  end

  for type, icon in pairs(M.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

end

return M
