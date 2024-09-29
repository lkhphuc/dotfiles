return {
  { -- Undo tree
    "simnalamburt/vim-mundo",
    cmd = "MundoToggle",
    keys = { { "<leader>uu", "<cmd>MundoToggle<CR>", desc = "Undo" } },
  },
  {
    "echasnovski/mini.visits",
    event = "BufEnter",
    opts = {},
    keys = {
      { "<leader>va", function() require("mini.visits").add_label() end, desc = "Add label" },
      { "<leader>vr", function() require("mini.visits").remove_label() end, desc = "Remove label" },
      {
        "<leader>vl",
        function() require("mini.visits").select_label("", nil) end,
        desc = "Select label (cwd)",
      },
      {
        "<leader>vL",
        function() require("mini.visits").select_label("", "") end,
        desc = "Select label (all)",
      },
      {
        "<leader>vv",
        function() require("mini.visits").select_path() end,
        desc = "Visited path (cwd)",
      },
      {
        "<leader>vV",
        function() require("mini.visits").select_path("") end,
        desc = "Visited path (all)",
      },
      {
        "]v",
        function() require("mini.visits").iterate_paths("forward") end,
        desc = "Next visited path",
      },
      {
        "[v",
        function() require("mini.visits").iterate_paths("backward") end,
        desc = "Previous visited path",
      },
      {
        "]V",
        function() require("mini.visits").iterate_paths("last") end,
        desc = "Last visited path",
      },
      {
        "[V",
        function() require("mini.visits").iterate_paths("first") end,
        desc = "First visited path",
      },
    },
  },
  {
    "echasnovski/mini.map",
    opts = function()
      local map = require("mini.map")
      return {
        symbols = { encode = require("mini.map").gen_encode_symbols.dot("3x2") },
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diff(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic(),
        },
        window = {
          show_integration_count = false,
        },
      }
    end,
    keys = {
      { "<leader>mm", "<Cmd>lua MiniMap.toggle()<CR>", desc = "MiniMap" },
      { "<leader>mf", "<Cmd>lua MiniMap.toggle_focus()<CR>", desc = "MiniMap" },
      { "<leader>ms", "<Cmd>lua MiniMap.toggle_side()<CR>", desc = "MiniMap" },
    },
  },
  {
    "mattboehm/vim-unstack",
    cmd = { "UnstackFromSelection", "UnstackFromClipboard", "UnstackFromText" },
    keys = { { "<leader>dS", "<Cmd>UnstackFromClipboard<CR>", desc = "Un-stack trace" } },
  },
  { "HiPhish/rainbow-delimiters.nvim", event = "BufEnter" },
  { "tiagovla/scope.nvim", opts = {}, event = "VeryLazy" },
  { "soulis-1256/eagle.nvim", lazy = false },
  {
    "3rd/image.nvim",
    enabled = false,
    ft = { "markdown", "vimwiki", "quarto", "python" },
    opts = {
      integrations = {
        markdown = { filetypes = { "markdown", "vimwiki", "quarto", "python" } },
      },
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge, -- this is necessary for a good experience
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = { { "headlines.nvim", enabled = false } },
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    ft = { "markdown", "python", "quarto", "rmd", "vimwiki", "norg", "org", "octo" },
    opts = {
      file_types = { "markdown", "python", "quarto", "rmd", "vimwiki", "norg", "org", "octo" },
    },
  },
  { "stevearc/oil.nvim", opts = {}, keys = { { "-", "<CMD>Oil<CR>", desc = "Open parent directory" } } },
  { ---@type LazySpec
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>-", "<cmd>Yazi<cr>", desc = "Open yazi at the current file", },
      { "<leader>_", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory", },
      { "<leader>fy", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session", },
    },
    opts = {
      open_for_directories = false,
      keymaps = { show_help = "<f1>", },
    },
  },
}
