return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim", config = true },
    { "LukasPietzschmann/telescope-tabs", config = true },
    { "molecule-man/telescope-menufacture" },
    {
      "danielfalk/smart-open.nvim",
      branch = "0.1.x",
      dependencies = { "kkharji/sqlite.lua" },
    },
    { "tsakirist/telescope-lazy.nvim" },
  },
  opts = function()
    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",

        mappings = {
          i = {
            ["<C-s>"] = require("telescope.actions").select_horizontal,
            ["<C-v>"] = require("telescope.actions").select_vertical,
            ["<C-t>"] = require("telescope.actions").select_tab,
            ["<C-x>"] = require("trouble.providers.telescope").open_with_trouble,

            ["<C-f>"] = require("telescope.actions").to_fuzzy_refine,
          },
          n = {
            ["<C-s>"] = require("telescope.actions").select_horizontal,
            ["<C-v>"] = require("telescope.actions").select_vertical,
            ["<C-t>"] = require("telescope.actions").select_tab,
            ["<C-x>"] = require("trouble.providers.telescope").open_with_trouble,
          },
        },
        layout_strategies = "flex",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
      },
      pickers = {
        grep_string = { theme = "dropdown" },
        find_files = { theme = "dropdown" },
        git_files = { theme = "dropdown" },
        buffers = {
          theme = "dropdown",
          mappings = {
            i = {
              ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
          },
        },
        current_buffer_fuzzy_find = { theme = "ivy" },
        live_grep = {},
        colorscheme = { theme = "dropdown", enable_preview = true },
        lsp_references = { theme = "dropdown", show_line = false },
        lsp_definitions = { theme = "dropdown" },
      },
      extensions = {
        fzf = {},
        file_browser = { theme = "ivy" },
        menufacture = { mappings = { main_menu = { [{ "i", "n" }] = "<C-o>" } } },
        lazy = {
          theme = "ivy",
          show_icon = true,
          mappings = {
            open_in_browser = "<C-o>",
            open_in_file_browser = "<M-b>",
            open_in_find_files = "<C-f>",
            open_in_live_grep = "<C-g>",
            open_plugins_picker = "<C-b>", -- Works only after having called first another action
            open_lazy_root_find_files = "<C-r>f",
            open_lazy_root_live_grep = "<C-r>g",
          },
        },
      },
    }
  end,
  keys = function()
    local Util = require("lazyvim.util")

    return {
      {
        "<leader>/",
        "Telescope current_buffer_fuzzy_find",
        desc = "Fuzzy search in buffer",
      },
      {
        "<leader>*",
        "<CMD>Telescope menufacture grep_string<CR>",
        desc = "Search word under cursor",
      },

      { "<leader>ff", "<Cmd>Telescope smart_open<CR>", desc = "Open ..." },
      { "<leader>fF", "<Cmd>Telescope file_browser<CR>", desc = "Browse files" },
      { "<leader>sf", "<CMD>Telescope menufacture find_files<CR>", desc = "Find Files (root dir)" },
      { "<leader>sF", Util.telescope("files", { cwd = false }), desc = "Search Files (cwd)" },
      { "<leader>sb", "<Cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>so", "<Cmd>Telescope oldfiles<CR>", desc = "Recent Old files" },
      { "<leader>s<Tab>", "<cmd>Telescope telescope-tabs list_tabs<CR>", desc = "Tabs" },

      { "<leader>sg", "<CMD>Telescope menufacture live_grep<CR>", desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      {
        "<leader>st",
        "<cmd>Telescope grep_string search= theme=ivy <CR>",
        desc = "Fuzzy search workspace",
      },

      { "<leader>sM", "<Cmd>Telescope man_pages<CR>", desc = "[M]an Page" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },

      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>s'", "<Cmd>Telescope registers<CR>", desc = "Registers" },
      { "<leader>sk", "<Cmd>Telescope keymaps<CR>", desc = "Keymaps" },
      { "<leader>sj", "<Cmd>Telescope jumplist<CR>", desc = "Jumplist" },
      { "<leader>sm", "<Cmd>Telescope marks<CR>", desc = "Marks" },
      { "<leader>sp", "<Cmd>Telescope builtin<CR>", desc = "Pickers" },
      { "<leader>s/", "<Cmd>Telescope search_history<CR>", desc = "Search history" },
      { "<leader>s;", "<Cmd>Telescope command_history<CR>", desc = "Command history" },
      { "<leader>sP", "<Cmd>Telescope projects<CR>", desc = "Projects" },
      { "<leader>sO", "<Cmd>Telescope vim_options<CR>", desc = "Vim options" },
      { "<leader>sa", "<Cmd>Telescope autocommands<CR>", desc = "Auto Commands" },

      { "<leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "git commits" },
      { "<leader>gs", "<Cmd>Telescope git_status<CR>", desc = "git status" },
      { "<leader>gf", "<CMD>Telescope menufacture git_files<CR>", desc = "git files" },

      { "<leader>ss", "<Cmd>Telescope resume<CR>", desc = "Resume last search" },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("menufacture")
    telescope.load_extension("smart_open")
    telescope.load_extension("lazy")
  end,
}
