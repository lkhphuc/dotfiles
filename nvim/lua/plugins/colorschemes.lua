return {
  { "rebelot/kanagawa.nvim",
    opts = {
      dimInactive = true,
      colors = { theme = { all = { ui = { bg_gutter = "none" }}}}
    }
  },
  { "navarasu/onedark.nvim" },
  { "folke/tokyonight.nvim", opts = { dim_inactive = true } },
  { "EdenEast/nightfox.nvim" }, -- dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
  { "catppuccin/nvim", name = "catppuccin", opts = { dim_inactive = { enabled = true } } },
  { "rose-pine/neovim", name = "rose-pine" },
  { "loctvl842/monokai-pro.nvim" },
  { "sainnhe/gruvbox-material" },
  { "ribru17/bamboo.nvim", opts = { highlights = { ["@comment"] = { fg = "$grey" }}}},
  { "xiyaowong/nvim-transparent",
    opts = { extra_groups = { "NormalFloat" } },
    keys = { { "\\t", "<Cmd>TransparentToggle<CR>", desc = "Toggle Transparent" } },
  },
  { "folke/styler.nvim",
    event = "VeryLazy",
    opts = {
      themes = {
        markdown = { colorscheme = "catppuccin" },
        json = { colorscheme = "nordfox" },
        toml = { colorscheme = "terafox" },
        yaml = { colorscheme = "carbonfox" },
        help = { colorscheme = "rose-pine" },
      },
    },
  },
}
