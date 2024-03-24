return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-Space>"] = require("telescope.actions").to_fuzzy_refine,
          },
        },
        layout_strategies = "flex",
        layout_config = {
          prompt_position = "top",
          horizontal = { preview_width = { 0.55, max = 100, min = 30 } },
          vertical = { preview_cutoff = 20, preview_height = 0.5 },
        },
        sorting_strategy = "ascending",
        path_display = { "truncate" },
      },
      pickers = {
        find_files = { theme = "dropdown" },
        git_files = { theme = "dropdown" },
        buffers = {
          theme = "dropdown",
          mappings = { i = { ["<C-d>"] = require("telescope.actions").delete_buffer } },
        },
        current_buffer_fuzzy_find = { theme = "ivy" },
        grep_string = { theme = "cursor", layout_config = { height = 0.5, width = 0.8 } },
        lsp_references = {
          theme = "cursor",
          show_line = false,
          layout_config = { height = 0.5, width = 0.8 },
        },
        lsp_definitions = {
          theme = "cursor",
          show_line = false,
          layout_config = { height = 0.5, width = 0.8 },
        },
        lsp_type_definitions = {
          theme = "cursor",
          show_line = false,
          layout_config = { height = 0.5, width = 0.8 },
        },
        lsp_implementations = {
          theme = "cursor",
          show_line = false,
          layout_config = { height = 0.5, width = 0.8 },
        },
      },
    },
    keys = {
      { "<leader>/", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy workspace" },
      { "<leader>#", "<Cmd>Telescope grep_string<Cr>", desc = "Search word under cursor" },
      { "<leader><CR>", "<Cmd>Telescope resume<CR>", desc = "Resume last search" },
      { "<leader>s/", "<Cmd>Telescope search_history<CR>", desc = "Search history" },
      { "<leader>sj", "<Cmd>Telescope jumplist<CR>", desc = "Jumplist" },
      { "<leader>sP", "<Cmd>Telescope builtin<CR>", desc = "Pickers" },
      { "<leader>gfc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gfs", "<cmd>Telescope git_status<CR>", desc = "status" },
      { "<leader>gfb", "<cmd>Telescope git_branches<CR>", desc = "branch" },
      { "<leader>gfh", "<cmd>Telescope git_stash<CR>", desc = "stashs" },
    },
  },
  {
    "polirritmico/telescope-lazy-plugins.nvim",
    dependencies = {
      {
        "telescope.nvim",
        opts = {
          extensions = {
            lazy_plugins = {
              custom_entries = {
                {
                  name = "LazyVim",
                  filepath = vim.fn.stdpath("data") .. "/lazy/LazyVim/lua/lazyvim/config/init.lua",
                  repo_url = "https://github.com/LazyVim/LazyVim",
                  repo_dir = vim.fn.stdpath("data") .. "/lazy/LazyVim",
                },
              },
            },
          },
        },
      },
    },
    keys = { { "<leader>sp", "<Cmd>Telescope lazy_plugins<CR>", desc = "Plugins" } },
  },
}
