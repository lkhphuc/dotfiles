return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "andymass/vim-matchup", branch = "master" },
      { "romgrk/nvim-treesitter-context", opts = {} },
      { "HiPhish/nvim-ts-rainbow2"},
    },
    opts = {
      ensure_installed = {
        "haskell", "make", "rust", "rst", "toml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "v",
          node_incremental = "v",
          node_decremental = "V",
          scope_incremental = "<M-v>",
        },
      },
      rainbow = { enable = true },
      matchup = { enable = true, include_match_words = true },
    },
  },
}
