return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "localhost",
        },
        inline = {
          adapter = "localhost",
        },
      },
      adapters = {
        localhost = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "http://localhost:1234",
            },
          })
        end,
      },
    },
    cmd = { "CodeCompanion" },
    keys = {
      { "<leader>aa", "<CMD>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "AI Actions" },
      { "<leader>at", "<CMD>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "Toggle AI chat" },
      { "<leader>ac", "<CMD>'<,'>CodeCompanion<CR>", mode = { "v" }, desc = "Add to AI chat" },
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
