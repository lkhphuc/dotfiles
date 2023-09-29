return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "andymass/vim-matchup", branch = "master" },
      { "romgrk/nvim-treesitter-context", opts = { multiline_threshold = 2, }, },
    },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "<BS>",
          scope_incremental = "<M-v>",
        },
      },
      matchup = { enable = true, include_match_words = true },
    },
  },
}
