return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "danielfalk/smart-open.nvim", dependencies = { "kkharji/sqlite.lua" } },
    { "tsakirist/telescope-lazy.nvim" },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<C-g>"] = require("telescope.actions").to_fuzzy_refine,
          ["<C-d>"] = require("telescope.actions").delete_buffer,
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
      buffers = { theme = "dropdown" },
      -- current_buffer_fuzzy_find = { layout = "vertical" },
      lsp_references = {
        theme = "cursor",
        show_line = false,
        layout_config = { height = 0.5, width = 0.9 },
      },
      lsp_definitions = {
        theme = "cursor",
        show_line = false,
        layout_config = { height = 0.5, width = 0.9 },
      },
      lsp_type_definitions = {
        theme = "cursor",
        show_line = false,
        layout_config = { height = 0.5, width = 0.9 },
      },
      lsp_implementations = {
        theme = "cursor",
        show_line = false,
        layout_config = { height = 0.5, width = 0.9 },
      },
    },
    extensions = {
      file_browser = { theme = "ivy" },
      smart_open = { match_algorithm = "fzf" },
    },
  },
  keys = {
    { "<leader>/", "<Cmd>Telescope grep_string search= theme=ivy<CR>", desc = "Fuzzy workspace" },
    {
      "<leader>#",
      function()
        require("telescope.builtin").grep_string({
          theme = "cursor",
          layout_config = { height = 0.5, width = 0.9 },
        })
      end,
      desc = "Search word under cursor",
    },
    { "<leader>'", "<Cmd>Telescope registers<CR>", desc = "Registers" },
    { "<leader><CR>", "<Cmd>Telescope resume<CR>", desc = "Resume last search" },
    { "<leader>s/", "<Cmd>Telescope search_history<CR>", desc = "Search history" },
    { "<leader>sj", "<Cmd>Telescope jumplist<CR>", desc = "Jumplist" },
    { "<leader>sp", "<Cmd>Telescope builtin<CR>", desc = "Pickers" },
    { "<leader>F", "<Cmd>Telescope file_browser<CR>", desc = "Browse files" },
    { "<leader><space>", "<Cmd>Telescope smart_open theme=dropdown<CR>", desc = "Open ..." },
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
