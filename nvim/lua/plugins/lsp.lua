return {
  { "smjonas/inc-rename.nvim", opts = {} },
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
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] =
        { "<leader>chi", "<CMD>Telescope lsp_incoming_calls<CR>", desc = "Hierarchy/Incoming" }
      keys[#keys + 1] =
        { "<leader>cho", "<CMD>Telescope lsp_outgoing_calls<CR>", desc = "Hierarchy/Outgoing" }
      keys[#keys + 1] = { "<leader>cL", vim.lsp.codelens.run, desc = "CodeLens" }

      -- disable keymaps
      keys[#keys + 1] = { "gy", false } -- For gy, gp to system clipboard
      keys[#keys + 1] = { "gt", "<CMD>Telescope lsp_type_definitions<CR>" }
    end,
    ---@class PluginLspOpts
    opts = {
      autoformat = false,
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      ---@type lspconfig.options
      servers = {},
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- fallback for all
        -- ["*"] = function(server, opts) end,
      },
    },
    dependencies = {
      {
        "jubnzv/virtual-types.nvim",
        init = function()
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.server_capabilities.codeLensProvider ~= nil then
              require("virtualtypes").on_attach(client, buffer)
            end
          end)
        end,
      },
      {
        "kosayoda/nvim-lightbulb",
        opts = {
          autocmd = { enabled = true },
          sign = { enabled = true, text = "" },
          action_kinds = { "quickfix", "refactor" },
          ignore = {
            actions_without_kind = true,
          },
        },
      },
    },
  },
}
