return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "LukasPietzschmann/telescope-tabs", config = true },
    { "danielfalk/smart-open.nvim", dependencies = { "kkharji/sqlite.lua" } },
    { "tsakirist/telescope-lazy.nvim" },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<C-Space>"] = require("telescope.actions").to_fuzzy_refine,
          ["<C-d>"] = require("telescope.actions").delete_buffer,
        },
      },
      layout_strategies = "flex",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      path_display = { "smart", shorten = 10 },
    },
    pickers = {
      find_files = { theme = "dropdown" },
      git_files = { theme = "dropdown" },
      buffers = { theme = "dropdown" },
      current_buffer_fuzzy_find = { theme = "ivy" },
      lsp_references = {
        theme = "cursor",
        show_line = false,
        layout_config = { height = 20, width = 100 },
      },
      lsp_definitions = {
        theme = "cursor",
        show_line = false,
        layout_config = { height = 20, width = 100 },
      },
      lsp_type_definitions = {
        theme = "cursor",
        show_line = false,
        layout_config = { height = 20, width = 100 },
      },
      lsp_implementations = {
        theme = "cursor",
        show_line = false,
        layout_config = { height = 20, width = 100 },
      },
    },
    extensions = {
      file_browser = { theme = "ivy" },
      smart_open = { match_algorithm = "fzf" },
    },
  },
  keys = {
    { "<leader>/", "<Cmd>Telescope grep_string search= theme=ivy<CR>", desc = "Fuzzy workspace" },
    { "<leader>s/", "<Cmd>Telescope search_history<CR>", desc = "Search history" },
    { "<leader>s'", "<Cmd>Telescope registers<CR>", desc = "Registers" },
    { "<leader>sj", "<Cmd>Telescope jumplist<CR>", desc = "Jumplist" },
    { "<leader>sp", "<Cmd>Telescope builtin<CR>", desc = "Pickers" },
    { "<leader><CR>", "<Cmd>Telescope resume<CR>", desc = "Resume last search" },

    { "<leader>F", "<Cmd>Telescope file_browser<CR>", desc = "Browse files" },
    { "<leader><space>", "<Cmd>Telescope smart_open<CR>", desc = "Open ..." },
    { "<leader>s<Tab>", "<Cmd>Telescope telescope-tabs list_tabs<CR>", desc = "Tabs" },
    { "<leader>sP", "<Cmd>Telescope lazy<CR>", desc = "Plugins" },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("smart_open")
    telescope.load_extension("lazy")
  end,
}
