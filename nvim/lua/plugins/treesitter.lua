return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "RRethy/nvim-treesitter-textsubjects" },
      { "andymass/vim-matchup", branch = "master" },
      { "romgrk/nvim-treesitter-context", opts = {} },
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
        textsubjects = { -- FIX: doesn't work
          enable = true,
          prev_selection = ",", -- (Optional) keymap to select the previous selection
          keymaps = {
            ["<CR>"] = "textsubjects-smart",
            ["a<CR>"] = "textsubjects-container-outer",
            ["i<CR>"] = "textsubjects-container-inner",
          },
        },

        rainbow = { enable = true }, -- BUG: doesn't work, need autocmd to reenabled
        matchup = { enable = true, include_match_words = true },

        pyfold = { enable = true, custom_foldtext = true },
      },
    },
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
  },
  { "mrjones2014/nvim-ts-rainbow", config = function() vim.cmd("TSEnable rainbow") end, event = "BufReadPost" }, --paranetheses,
  -- {
  --   "mfussenegger/nvim-treehopper",
  --   keys = {
  --     { "m", ":<C-U>lua require('tsht').nodes()<CR>", mode = "o", silent = true, remap = true },
  --     { "m", function() require("tsht").nodes() end, mode = "x", silent = true, remap = false },
  --   },
  -- },
}
