local wk = require('which-key')
local tele = require('telescope.builtin')

local M = {}

function M.setup(client, buffer)
  wk.register({["<leader>l"] = { name = "LSP" }})
  local cap = client.server_capabilities
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
  vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { buffer = buffer, desc = "Quickfix" })
  vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

  -- vim.keymap.set('n', '<leader>lo', vim.diagnostic.open_float, { desc="Open diagnostics." })
  vim.keymap.set('n', '<leader>sd', tele.diagnostics, { buffer = buffer, desc = "Documents Diagnostics" })

  -- Diagnsotic jump can use `<c-o>` to jump back
  vim.keymap.set('n', '<leader>ss', tele.lsp_document_symbols, { buffer = buffer, desc="Document symbols" })

  vim.keymap.set('n', 'K', function()
      if not require('ufo').peekFoldedLinesUnderCursor() then vim.lsp.buf.hover() end
    end,
    {buffer = buffer,  desc="Hover" })
  vim.keymap.set('n', 'S', vim.lsp.buf.signature_help, { buffer = buffer, desc="Signature" })
  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = buffer, desc="References" })

  -- Peek Definition
  -- you can edit the definition file in this flaotwindow
  -- also support open/vsplit/etc operation check definition_action_keys
  -- support tagstack C-t jump back
  vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc="peek", silent = true })
  vim.keymap.set('n', 'gd', tele.lsp_definitions, { buffer = buffer, desc="Definition" })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = buffer, desc="Declaration" })
  vim.keymap.set('n', 'gI', tele.lsp_implementations, { buffer = buffer, desc="Implementation" })
  vim.keymap.set('n', 'gt', tele.lsp_type_definitions, { buffer = buffer, desc="Type definition" })

  vim.keymap.set({"n","v"}, "<leader>la", "<cmd>Lspsaga code_action<CR>", { silent = true })
  vim.keymap.set('n', '<leader>li', tele.lsp_incoming_calls, { buffer = buffer, desc="Incoming calls" })
  vim.keymap.set('n', '<leader>lo', tele.lsp_outgoing_calls, { buffer = buffer, desc="Outgoing calls" })
  vim.keymap.set('n', '<leader>lr', ":IncRename ", { buffer = buffer, desc="Rename symbol" })
  vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { buffer = buffer, desc = "Run CodeLens Action"})

  vim.keymap.set( 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = buffer, desc="Add workspace" } )
  vim.keymap.set( 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = buffer, desc="Remove workspace" } )
  vim.keymap.set( 'n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, { buffer = buffer, desc="List workspace folder" } )
  vim.keymap.set('n', '<leader>ws', tele.lsp_dynamic_workspace_symbols, { buffer = buffer, desc="Workspace Symbol" })

  vim.keymap.set("n","<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
  vim.keymap.set({"n", "v"}, "<leader>lf", vim.lsp.buf.format, { silent = true })

end
return M
