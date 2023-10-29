return {
  {
    "rebelot/kanagawa.nvim",
    opts = { dimInactive = true, colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
    }
  },
  { "navarasu/onedark.nvim" },
  { "folke/tokyonight.nvim", opts = {
    transparent = vim.g.transparent_enabled,
    dim_inactive = true,
    styles = { sidebars = "transparent", floats = "transparent"}
  } },
  { "EdenEast/nightfox.nvim" }, -- dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
  { "catppuccin/nvim", name = "catppuccin",
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      transparent_background = vim.g.transparent_enabled,
      dim_inactive = { enabled = true },
    },
  },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'loctvl842/monokai-pro.nvim' },
  { 'ellisonleao/gruvbox.nvim'},
  {
    'ribru17/bamboo.nvim',
    opts = {
      highlights = {
        ["@comment"] = { fg = '$grey' },
      }
    }
  },
  { "xiyaowong/nvim-transparent",
    lazy = false,
    opts = {
      -- extra_groups = { "CursorLine"}
    },
    keys = { {"\\t", "<Cmd>TransparentToggle<CR>", desc = "Toggle Transparent"} },
  },
  { "folke/styler.nvim",
    event = "VeryLazy",
    opts = {
      themes = {
        markdown = { colorscheme = "catppuccin" },
        json = { colorscheme = "kanagawa" },
        toml = { colorscheme = "kanagawa" },
        yaml = { colorscheme = "kanagawa" },
        help = { colorscheme = "carbonfox" },
      },
    },
  },
}
