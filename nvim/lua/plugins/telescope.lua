return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-Space>"] = function () require("telescope.actions").to_fuzzy_refine() end,
            ["<C-Tab>"] = function () require("telescope.actions").select_tab_drop() end,
            ["<M-h>"] = function () require("telescope.actions").results_scrolling_left() end,
            ["<M-l>"] = function () require("telescope.actions").results_scrolling_right() end,
          },
        },
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
          horizontal = { preview_width = { 0.55, max = 100, min = 30 } },
          vertical = { preview_cutoff = 20, preview_height = 0.5 },
          cursor = { height = 0.5, width = 0.8 },
        },
        sorting_strategy = "ascending",
        path_display = { filename_first = { reverse_directories = false } },
        dynamic_preview_title = true,
      },
      pickers = {
        buffers = {
          theme = "dropdown",
          mappings = { i = { ["<C-b>"] = function() require("telescope.actions").delete_buffer() end } },
        },
        current_buffer_fuzzy_find = { layout_strategy = "vertical" },
        grep_string = { layout_strategy = "vertical" },
        lsp_references = { layout_strategy = "vertical" },
        lsp_definitions = { layout_strategy = "vertical" },
        lsp_type_definitions = { layout_strategy = "cursor" },
        lsp_implementations = { layout_strategy = "cursor" },
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
    enabled = false,
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
