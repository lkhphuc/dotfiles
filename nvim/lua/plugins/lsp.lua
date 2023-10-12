local function toggle_diag_virtext()
  local virtual_text = {  -- Default virtual_text opts from Lazy.Nvim
    spacing = 4,
    source = "if_many",
    prefix = "●",
  }
  local config = vim.diagnostic.config()
  if type(config.virtual_text) == "table" then
    config.virtual_text = false
    vim.diagnostic.config(config)
    vim.notify("Disable diagnostics virtualtext", 5, { title = "Diagnostics" })
  else
    config.virtual_text = virtual_text
    vim.diagnostic.config(config)
    vim.notify("Enabled diagnostics virtualtext", 5, { title = "Diagnostics" })
  end
end

return {
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
      keys[#keys + 1] = { "gT", "<CMD>Telescope lsp_type_definitions<CR>" }
      keys[#keys + 1] = { "<leader>uv", toggle_diag_virtext, desc = "Toggle diagnostic virtualtext"}
    end,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {},
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- fallback for all
        -- ["*"] = function(server, opts) end,
      },
    },
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = true, text = "" },
      action_kinds = { "quickfix", "refactor" },
      ignore = {
        actions_without_kind = true,
      },
    },
  },
}
