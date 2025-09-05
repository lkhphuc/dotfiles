return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "nvim-telescope/telescope.nvim", -- Optional
      {
        "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    opts = {
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            url = "localhost:8080/v1/chat/completions",
          })
        end,
      },
    },
    cmd = { "CodeCompanion" },
    keys = {
      { "<leader>aa", "<CMD>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "AI Actions" },
      { "<C-,>", "<CMD>CodeCompanionToggle<CR>", mode = { "n", "v" }, desc = "AI chat Toggle" },
      { "<leader>ac", "<CMD>CodeCompanionAdd<CR>", mode = { "v" }, desc = "AI add to Chat" },
      { "<leader>ap", "<CMD>'<,'>CodeCompanion<CR>", mode = { "n", "v" }, desc = "AI Prompt" },
    },
  },
}
