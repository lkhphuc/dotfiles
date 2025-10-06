return {
  {
    "folke/sidekick.nvim",
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
