local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local trouble = require("trouble.providers.telescope")
local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim", config = true },
    { "LukasPietzschmann/telescope-tabs", config = true },
  },
  opts = function()
    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",

        mappings = {
          i = {
            ["<C-s>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-x>"] = trouble.open_with_trouble,

            ["<C-f>"] = actions.to_fuzzy_refine,
          },
          n = {
            ["<C-s>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-x>"] = trouble.open_with_trouble,
          },
        },
        layout_strategies = "flex",
        layout_config = {},
      },
      pickers = {
        grep_string = { theme = "dropdown" },
        find_files = { theme = "dropdown" },
        git_files = { theme = "dropdown" },
        buffers = {
          theme = "dropdown",
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer,
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
      },
    }
  end,
  keys = function()
    return {
      { "<leader>/", builtin.current_buffer_fuzzy_find, desc = "Fuzzy search in buffer" },
      { "<leader>*", builtin.grep_string, desc = "Search word under cursor" },

      { "<leader>sf", Util.telescope("files"), desc = "Search Files (root dir)" },
      { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" }, -- FIX: old habit
      { "<leader>sF", Util.telescope("files", { cwd = false }), desc = "Search Files (cwd)" },
      { "<leader>fF", "<Cmd>Telescope file_browser<CR>", desc = "Browse files" },
      { "<leader>sb", builtin.buffers, desc = "Buffers" },
      { "<leader>so", builtin.oldfiles, desc = "Recent Old files" },
      { "<leader>s<Tab>", require("telescope-tabs").list_tabs, desc = "Tabs" },

      { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>st", "<cmd>Telescope grep_string search= theme=ivy <CR>", desc = "Fuzzy search workspace" },

      { "<leader>sM", builtin.man_pages, desc = "[M]an Page" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },

      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>s'", builtin.registers, desc = "Registers" },
      { "<leader>sk", builtin.keymaps, desc = "Keymaps" },
      { "<leader>sj", builtin.jumplist, desc = "Jumplist" },
      { "<leader>sm", builtin.marks, desc = "Marks" },
      { "<leader>sp", builtin.builtin, desc = "Pickers" },
      { "<leader>s/", builtin.search_history, desc = "Search history" },
      { "<leader>s;", builtin.command_history, desc = "Command history" },
      { "<leader>sP", builtin.projects, desc = "Projects" },
      { "<leader>sO", builtin.vim_options, desc = "Vim options" },
      { "<leader>sa", builtin.autocommands, desc = "Auto Commands" },

      { "<leader>gc", builtin.git_commits, desc = "git commits" },
      { "<leader>gs", builtin.git_status, desc = "git status" },

      { "<leader>ss", builtin.resume, desc = "Resume last search" },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
  end,
}