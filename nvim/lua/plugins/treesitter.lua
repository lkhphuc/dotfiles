return {
  {
    "nvim-treesitter/nvim-treesitter",
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
          -- scope_incremental = "`-",  -- or per scope TODO disable this to nomapping
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
            -- scope_incremental = "`-",  -- or per scope TODO disable this to nomapping
          },
        },
        textsubjects = {
          enable = true,
          -- prev_selection = "-", -- (Optional) keymap to select the previous selection
          keymaps = {
            [";"] = "textsubjects-smart",
            ["a;"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
          },
        },

        indent = { enabled = false },
        yati = { enable = true, default_lazy = true },

        rainbow = { enable = true },
        matchup = { enable = true, include_match_words = true },

        pyfold = { enable = true, custom_foldtext = true },
      },
    },
  },
  { "mrjones2014/nvim-ts-rainbow", event = "BufReadPost" }, --paranetheses,
  { "romgrk/nvim-treesitter-context", event = "BufReadPost", opts = {} },
  {
    "nvim-treesitter/playground",
    name = "ts-playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
  },
  -- {
  --   "mfussenegger/nvim-treehopper",
  --   keys = {
  --     { "m", ":<C-U>lua require('tsht').nodes()<CR>", mode = "o", silent = true, remap = true },
  --     { "m", function() require("tsht").nodes() end, mode = "x", silent = true, remap = false },
  --   },
  -- },
  { "andymass/vim-matchup", branch = "master", event = "BufReadPost" },
  { "yioneko/nvim-yati" },
  { "RRethy/nvim-treesitter-textsubjects" },
}
