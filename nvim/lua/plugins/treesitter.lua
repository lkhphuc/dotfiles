return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "yioneko/nvim-yati",
      "RRethy/nvim-treesitter-textsubjects",
    },
    opts = {
      ensure_installed = { "python", "lua", "bash", "vim", "make", "regex", "yaml", "toml", "haskell", "rust" },
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
      indent = { enable = false },
      yati = { enable = true, default_lazy = true },
      rainbow = { enable = true },

      textobjects = {
        -- swap = {
        --   enable = true,
        --   swap_next = { ["]a"] = "@parameter.inner" },
        --   swap_previous = { ["[a"] = "@parameter.inner" },
        -- },
        -- lsp_interop = {
        --   enable = true,
        --   border = "double",
        --   peek_definition_code = {
        --     ["<leader>k"] = "@function.outer",
        --     ["<leader>K"] = "@class.outer",
        --   },
        -- },
      },

      matchup = {
        enable = true,
        include_match_words = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false, -- Let comment plugin handles it
      },
      pyfold = {
        enable = true,
        custom_foldtext = true,
      },
    },
  },
  { "mrjones2014/nvim-ts-rainbow", event = "BufReadPost" }, --paranetheses,
  { "romgrk/nvim-treesitter-context", event = "BufReadPost", config = true },
  {
    "nvim-treesitter/playground",
    name = "ts-playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
  },
  {
    "mfussenegger/nvim-treehopper",
    keys = {
      { "m", ":<C-U>lua require('tsht').nodes()<CR>", mode = "o", silent = true, remap = true },
      { "m", function() require("tsht").nodes() end, mode = "x", silent = true, remap = false },
    },
  },
  { "andymass/vim-matchup", branch = "master", event = "BufReadPost" },
}
