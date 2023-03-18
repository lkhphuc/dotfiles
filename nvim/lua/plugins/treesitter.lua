return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- { "RRethy/nvim-treesitter-textsubjects" },
      { "andymass/vim-matchup", branch = "master" },
      { "romgrk/nvim-treesitter-context", opts = {} },
      { "mrjones2014/nvim-ts-rainbow" },
      { "m-demare/hlargs.nvim", opts = { excluded_filetypes = { "python" } } },
    },
    opts = {
      ensure_installed = {
        "bash",
        "haskell",
        "help",
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
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "+", -- Hold Shift with 2 keys next to Del
          node_incremental = "+", -- to start and increase selection
          node_decremental = "_", -- or decrease selection per node,
          scope_incremental = "<nop>", -- or per scope TODO disable this to nomapping
        },
      },
      rainbow = { enable = true },
      matchup = { enable = true, include_match_words = true },
      pyfold = { enable = true, custom_foldtext = true },
      -- textsubjects = { -- FIX: doesn't work
      --   enable = false,
      --   prev_selection = ",", -- (Optional) keymap to select the previous selection
      --   keymaps = {
      --     ["<CR>"] = "textsubjects-smart",
      --     ["a<CR>"] = "textsubjects-container-outer",
      --     ["i<CR>"] = "textsubjects-container-inner",
      --   },
      -- },
    },
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
  },
  -- {
  --   "mfussenegger/nvim-treehopper",
  --   keys = {
  --     { "m", ":<C-U>lua require('tsht').nodes()<CR>", mode = "o", silent = true, remap = true },
  --     { "m", function() require("tsht").nodes() end, mode = "x", silent = true, remap = false },
  --   },
  -- },
}
