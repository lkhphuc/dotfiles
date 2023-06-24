return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- { "RRethy/nvim-treesitter-textsubjects" },
      { "andymass/vim-matchup", branch = "master" },
      { "romgrk/nvim-treesitter-context", opts = {} },
      { "HiPhish/nvim-ts-rainbow2"},
    },
    opts = {
      ensure_installed = {
        "bash",
        "haskell",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "rst",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = { -- Consistent syntax highlighting
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
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
