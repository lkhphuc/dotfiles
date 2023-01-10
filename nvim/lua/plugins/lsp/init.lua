local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = {
    'folke/neodev.nvim', -- Dev setup for init.lua and plugin
    'williamboman/mason-lspconfig.nvim',
    { "SmiteshP/nvim-navic", opts = { highlight = true, depth_limit = 5 } },
    'jubnzv/virtual-types.nvim', -- TODO: need codelen
  },
}

function M.config()
  require("plugins.lsp.diagnostics").setup()
  require("neodev").setup()
  require("mason").setup()
  require("mason-lspconfig").setup()
  local lspconfig = require("lspconfig")

  local function on_attach(client, buffer)
    if client.supports_method("textDocument/codeLens") then
      require('virtualtypes').on_attach(client, buffer)
    end
    require('nvim-navic').attach(client, buffer)
    require('plugins.lsp.keys').setup(client, buffer)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  require("mason-lspconfig").setup_handlers {
    -- default handlers for all servers, except listed below
    function(server_name) -- default handler (optional)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    ["jsonls"] = function()
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          json = {
            format = {
              enable = true,
            },
            -- schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end,
  }
end

return M
