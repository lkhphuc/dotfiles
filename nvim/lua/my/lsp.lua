local tele = require('telescope.builtin')
local lspconfig = require 'lspconfig'
local preview = require('goto-preview')

local on_attach = function(client, bufnr)
  require('which-key').register({["<leader>l"] = { name = "LSP" }})
  -- local  opts = { buffer = bufnr, }
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr,desc="next diagnostic" })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc="previous diagnostic" })
  vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { buffer = bufnr, desc="Quickfix" })
  vim.keymap.set('n', '<leader>lo', vim.diagnostic.open_float, { desc="Open diagnostics." })
  vim.keymap.set('n', '<leader>sd', tele.diagnostics, { buffer = bufnr, desc = "Documents Diagnostics"} )

  vim.keymap.set('n', '<leader>ss', tele.lsp_document_symbols, { buffer = bufnr, desc="Document symbols" })

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = bufnr,  desc="Hover" })
  vim.keymap.set('n', 'S', vim.lsp.buf.signature_help, { buffer = bufnr, desc="Signature" })
  vim.keymap.set('n', 'gr', tele.lsp_references, { buffer = bufnr, desc="References" })
  vim.keymap.set('n', 'gpd', preview.goto_preview_definition, { buffer = bufnr, desc="Definition" })
  vim.keymap.set('n', 'gd', tele.lsp_definitions, { buffer = bufnr, desc="Definition" })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc="Declaration" })
  vim.keymap.set('n', 'gi', preview.goto_preview_implementation, { buffer = bufnr, desc="Implementation" })
  vim.keymap.set('n', 'gI', tele.lsp_implementations, { buffer = bufnr, desc="Implementation" })
  vim.keymap.set('n', 'gpt', preview.goto_preview_type_definition, { buffer = bufnr, desc="Type definition" })
  vim.keymap.set('n', 'gt', tele.lsp_type_definitions, { buffer = bufnr, desc="Type definition" })

  vim.keymap.set('n', '<leader>lci', tele.lsp_incoming_calls, { buffer = bufnr, desc="Incoming calls" })
  vim.keymap.set('n', '<leader>lco', tele.lsp_outgoing_calls, { buffer = bufnr, desc="Outgoing calls" })
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc="Rename symbol under cursor" })
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc="Code Action" })
  vim.keymap.set('n', '<leader>li', "<cmd>LspInfo<CR>", { buffer = bufnr, desc = "Lsp Info"})
  vim.keymap.set('n', '<leader>lI', "<cmd>LspInstallInfo<CR>", { buffer = bufnr, desc = "Lsp Install Info"})
  vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { buffer = bufnr, desc = "Run CodeLens Action"})

  vim.keymap.set( 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc="Add workspace" } )
  vim.keymap.set( 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc="Remove workspace" } )
  vim.keymap.set( 'n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, { buffer = bufnr, desc="List workspace folder" } )
  vim.keymap.set('n', '<leader>ws', tele.lsp_dynamic_workspace_symbols, { buffer = bufnr, desc="Workspace Symbol" })

  require('virtualtypes').on_attach()
  require('nvim-navic').attach(client, bufnr)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Enable the following language servers
local servers = { 'sumneko_lua', 'pyright', 'bashls', }

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})
require("neodev").setup({})
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

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
  virtual_text = true,
  signs = { active = signs, },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    -- prefix = "",
  },
})


-- Noice intergration doc hover scrolling
vim.keymap.set("n", "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })

vim.keymap.set("n", "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })
