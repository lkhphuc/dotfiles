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
          init_selection = "+",
          node_incremental = "+",
          node_decremental = "-",
          scope_incremental = "_",
        },
      },
      matchup = { enable = true, include_match_words = true },
    },
  },
}
