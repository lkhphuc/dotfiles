return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        hls = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        ["*"] = function(server, opts) -- fallback for all
          require("lazyvim.util").on_attach(function(client, buffer)
            -- TODO: Keymap for workspace
            -- vim.keymap.set('n', '<leader>li', tele.lsp_incoming_calls, { buffer = buffer, desc="Incoming calls" })
            -- vim.keymap.set('n', '<leader>lo', tele.lsp_outgoing_calls, { buffer = buffer, desc="Outgoing calls" })
            -- vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { buffer = buffer, desc = "Run CodeLens Action"})
            --
            -- vim.keymap.set( 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = buffer, desc="Add workspace" } )
            -- vim.keymap.set( 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = buffer, desc="Remove workspace" } )
            -- vim.keymap.set( 'n', '<leader>wl', function()
            --   vim.inspect(vim.lsp.buf.list_workspace_folders())
            -- end, { buffer = buffer, desc="List workspace folder" } )
            -- vim.keymap.set('n', '<leader>ws', tele.lsp_dynamic_workspace_symbols, { buffer = buffer, desc="Workspace Symbol" })
          end)
        end,
      },
    },
  },
  {
    "jubnzv/virtual-types.nvim",
    init = function()
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.supports_method("textDocument/codeLens") then require("virtualtypes").on_attach(client, buffer) end
      end)
    end,
  },
  { "smjonas/inc-rename.nvim", opts = {}, cmd = "IncRename" },
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    init = function()
      require("lazyvim.util").on_attach(
        function(client, buffer)
          vim.keymap.set(
            { "n", "v" },
            "<leader>ca",
            "<Cmd>CodeActionMenu<CR>",
            { buffer = buffer, desc = "Code Action" }
          )
        end
      )
    end,
  },
  -- {
  --   "kosayoda/nvim-lightbulb",
  --   event = "LspAttach",
  --   init = function()
  --     vim.fn.sign_define("LightBulbSign", { text = " ", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
  --   end,
  --   opts = { autocmd = { enabled = true }, sign = { enabled = true, priority = 50 } },
  -- },
  {
    "m-demare/hlargs.nvim",
    event = "LspAttach",
    opts = {
      -- excluded_filetypes = { "python" },
    },
  },
}
