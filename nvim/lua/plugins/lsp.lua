return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] =
        { "<leader>chi", "<CMD>Telescope lsp_incoming_calls<CR>", desc = "Hierarchy/Incoming" }
      keys[#keys + 1] =
        { "<leader>lo", "<CMD>Telescope lsp_outgoing_calls<CR>", desc = "Hierarchy/Outgoing" }
      keys[#keys + 1] = { "<leader>cL", vim.lsp.codelens.run, desc = "CodeLens" }

      keys[#keys + 1] = { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace" }
      keys[#keys + 1] =
        { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace" }
      keys[#keys + 1] = {
        "<leader>wl",
        function() vim.pretty_print(vim.lsp.buf.list_workspace_folders()) end,
        desc = "List workspace folder",
      }
    end,
    ---@class PluginLspOpts
    opts = {
      autoformat = false,
      ---@type lspconfig.options
      servers = {},

      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        ["*"] = function(server, opts) -- fallback for all
          opts.capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          }
        end,
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
      -- {
      --   "kosayoda/nvim-lightbulb",
      --   init = function()
      --     vim.fn.sign_define("LightBulbSign", { text = " ", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
      --   end,
      --   opts = { autocmd = { enabled = true }, sign = { enabled = true, priority = 50 } },
      -- },
    },
  },
}
