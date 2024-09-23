return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "andymass/vim-matchup", branch = "master" },
      { "nvim-treesitter/nvim-treesitter-context", opts = { multiline_threshold = 2, }, },
    },
    opts = {
      incremental_selection = {
        keymaps = { node_incremental = "v", },
      },
      matchup = { enable = true, include_match_words = true },
    },
  },
}
