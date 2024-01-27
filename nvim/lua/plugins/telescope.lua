return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "tsakirist/telescope-lazy.nvim",
      config = function()
        require("lazyvim.util").on_load("telescope.nvim", function() require("telescope").load_extension("lazy") end)
      end,
    },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-Space>"] = require("telescope.actions").to_fuzzy_refine,
        },
      },
      layout_strategies = "flex",
      layout_config = { prompt_position = "top" },
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
    extensions = {
      smart_open = { match_algorithm = "fzf" },
    },
  },
  keys = {
    { "<leader>/", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy workspace" },
    { "<leader>#", "<Cmd>Telescope grep_string<Cr>", desc = "Search word under cursor" },
    { "<leader>'", "<Cmd>Telescope registers<CR>", desc = "Registers" },
    { "<leader><CR>", "<Cmd>Telescope resume<CR>", desc = "Resume last search" },
    { "<leader>s/", "<Cmd>Telescope search_history<CR>", desc = "Search history" },
    { "<leader>sj", "<Cmd>Telescope jumplist<CR>", desc = "Jumplist" },
    { "<leader>sp", "<Cmd>Telescope builtin<CR>", desc = "Pickers" },
    { "<leader>sP", "<Cmd>Telescope lazy<CR>", desc = "Plugins" },
  },
}
