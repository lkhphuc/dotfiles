return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "andymass/vim-matchup", branch = "master" },
      { "nvim-treesitter/nvim-treesitter-context", opts = { multiline_threshold = 2, }, },
      { "LiadOz/nvim-dap-repl-highlights", config=true }
    },
    opts = {
      ensure_installed = { "dap_repl", },
      matchup = { enable = true, include_match_words = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").comment = {
            install_info = {
              url = "https://github.com/OXY2DEV/tree-sitter-comment",
              queries = "queries/",
            },
          }
        end
      })
    end,
  },
}
