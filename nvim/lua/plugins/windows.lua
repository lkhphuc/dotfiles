return {
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        wezterm = { enabled = true, font = "+2" },
      },
    },
    cmd = "ZenMode",
    keys = { { "<leader>uz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" } },
    dependencies = { "folke/twilight.nvim", opts = {} },
  },
  {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
    opts = { highlight_moving_win = true },
    keys = { "<leader>wS", "<CMD>WinShift<CR>", desc = "Win Shift/Swap" },
  },
  { "mrjones2014/smart-splits.nvim", lazy=false, },
}
