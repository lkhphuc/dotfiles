return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "andymass/vim-matchup", branch = "master" },
      { "romgrk/nvim-treesitter-context", opts = {} },
    },
    opts = {
      ensure_installed = {
        "haskell", "make", "rust", "rst", "toml",
      },
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
