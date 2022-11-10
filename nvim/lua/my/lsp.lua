local tele = require('telescope.builtin')
local lspconfig = require 'lspconfig'

local on_attach = function(client, bufnr)
  require('which-key').register({["<leader>l"] = { name = "LSP" }})
  -- local  opts = { buffer = bufnr, }
  -- Diagnsotic jump can use `<c-o>` to jump back
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
  vim.keymap.set("n", "[D", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  vim.keymap.set("n", "]D", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, { silent = true })
  -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr,desc="next diagnostic" })
  -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc="previous diagnostic" })
  vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { buffer = bufnr, desc="Quickfix" })
  vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

  -- vim.keymap.set('n', '<leader>lo', vim.diagnostic.open_float, { desc="Open diagnostics." })
  vim.keymap.set('n', '<leader>sd', tele.diagnostics, { buffer = bufnr, desc = "Documents Diagnostics"} )

  vim.keymap.set('n', '<leader>ss', tele.lsp_document_symbols, { buffer = bufnr, desc="Document symbols" })

  vim.keymap.set('n', 'K', function()
      if not require('ufo').peekFoldedLinesUnderCursor() then vim.lsp.buf.hover() end
    end,
    {buffer = bufnr,  desc="Hover" })
  vim.keymap.set('n', 'S', vim.lsp.buf.signature_help, { buffer = bufnr, desc="Signature" })
  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
  -- vim.keymap.set('n', 'gr', tele.lsp_references, { buffer = bufnr, desc="References" })

  -- Peek Definition
  -- you can edit the definition file in this flaotwindow
  -- also support open/vsplit/etc operation check definition_action_keys
  -- support tagstack C-t jump back
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
  -- vim.keymap.set('n', 'gd', tele.lsp_definitions, { buffer = bufnr, desc="Definition" })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc="Declaration" })
  vim.keymap.set('n', 'gI', tele.lsp_implementations, { buffer = bufnr, desc="Implementation" })
  vim.keymap.set('n', 'gt', tele.lsp_type_definitions, { buffer = bufnr, desc="Type definition" })

  vim.keymap.set({"n","v"}, "<leader>la", "<cmd>Lspsaga code_action<CR>", { silent = true })
  vim.keymap.set('n', '<leader>lci', tele.lsp_incoming_calls, { buffer = bufnr, desc="Incoming calls" })
  vim.keymap.set('n', '<leader>lco', tele.lsp_outgoing_calls, { buffer = bufnr, desc="Outgoing calls" })
  vim.keymap.set('n', '<leader>lr', ":IncRename ", { buffer = bufnr, desc="Rename symbol" })
  vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { buffer = bufnr, desc = "Run CodeLens Action"})

  vim.keymap.set( 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc="Add workspace" } )
  vim.keymap.set( 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc="Remove workspace" } )
  vim.keymap.set( 'n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, { buffer = bufnr, desc="List workspace folder" } )
  vim.keymap.set('n', '<leader>ws', tele.lsp_dynamic_workspace_symbols, { buffer = bufnr, desc="Workspace Symbol" })

  -- Outline
  vim.keymap.set("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })

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
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
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
