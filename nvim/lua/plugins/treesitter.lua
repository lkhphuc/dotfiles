return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- { "RRethy/nvim-treesitter-textsubjects" },
      { "andymass/vim-matchup", branch = "master" },
      { "romgrk/nvim-treesitter-context", opts = {} },
      { "mrjones2014/nvim-ts-rainbow" },
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
          init_selection = "+",
          node_incremental = "+",
          node_decremental = "_",
          scope_incremental = "<S-CR>",
        },
      },
      rainbow = { enable = true },
      matchup = { enable = true, include_match_words = true },
    },
  },
  -- {
  --   "mfussenegger/nvim-treehopper",
  --   keys = {
  --     { "m", ":<C-U>lua require('tsht').nodes()<CR>", mode = "o", silent = true, remap = true },
  --     { "m", function() require("tsht").nodes() end, mode = "x", silent = true, remap = false },
  --   },
  -- },
}
