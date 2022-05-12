local tele = require('telescope.builtin')
local lspconfig = require 'lspconfig'

local on_attach = function(_, bufnr)
  -- local  opts = { buffer = bufnr, }
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr,desc="next diagnostic" })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc="previous diagnostic" })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = bufnr,  desc="Hover" })
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc="Signature" })

  vim.keymap.set('n', 'gr', tele.lsp_references, { buffer = bufnr, desc="References" })
  vim.keymap.set('n', 'gd', tele.lsp_definitions, { buffer = bufnr, desc="Definition" })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc="Declaration" })
  vim.keymap.set('n', 'gi', tele.lsp_implementations, { buffer = bufnr, desc="Implementation" })

  vim.keymap.set('n', '<leader>D', tele.lsp_type_definitions, { buffer = bufnr, desc="Type definition" })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc="Rename symbol under cursor" })
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc="Code Action" })
  vim.keymap.set('n', '<leader>ls', tele.lsp_document_symbols, { buffer = bufnr, desc="Document symbols" })
  vim.keymap.set({'n', 'x'}, '<leader>lF', vim.lsp.buf.range_formatting, { buffer = bufnr, desc="Formatting" })
  vim.keymap.set('n', '<leader>ld', tele.diagnostics, { buffer = bufnr, desc = "Documents Diagnostics"} )
  vim.keymap.set('n', '<leader>li', "<cmd>LspInfo", { buffer = bufnr, desc = "Lsp Info"})
  vim.keymap.set('n', '<leader>lI', "<cmd>LspInstallInfo", { buffer = bufnr, desc = "Lsp Install Info"})
  vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { buffer = bufnr, desc = "Run CodeLens Action"})
  vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { buffer = bufnr, desc="Quickfix" })
  -- vim.keymap.set('n', '<leader>lo', vim.diagnostic.open_float, desc("Open diagnostics."))

  vim.keymap.set( 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc="Add workspace" } )
  vim.keymap.set( 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc="Remove workspace" } )
  vim.keymap.set( 'n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, { buffer = bufnr, desc="List workspace folder" } )
  vim.keymap.set('n', '<leader>ws', tele.lsp_dynamic_workspace_symbols, { buffer = bufnr, desc="Workspace Symbol" })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'sumneko_lua', 'pyright',  }
require("nvim-lsp-installer").setup({
  ensure_installed = servers,
})
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local luadev = require("lua-dev").setup({
  lspconfig = { on_attach=on_attach }
})
lspconfig.sumneko_lua.setup(luadev)

-- _________________
-- < vim.diagnostics >
--  -----------------
--         \   ^__^
--          \  (oo)\_______
--             (__)\       )\/\
--                 ||----w |
--                 ||     ||
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    -- header = "",
    -- prefix = "",
  },
})


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "shadow",
})

