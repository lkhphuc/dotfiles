return {
  {
    "folke/sidekick.nvim",
    opts = { nes = { enabled = false }, },
    keys = {
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "cursor", focus = true }) end,
        desc = "Sidekick Cursor Toggle",
        mode = { "n", "v" },
      },
    },
  },
}
