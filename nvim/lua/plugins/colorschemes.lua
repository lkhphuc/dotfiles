return {
  { "rebelot/kanagawa.nvim",
    opts = {
      dimInactive = true,
      colors = { theme = { all = { ui = { bg_gutter = "none" }}}}
    }
  },
  { "navarasu/onedark.nvim", opts = {style= 'warmer'} },
  { "folke/tokyonight.nvim", opts = { dim_inactive = true } },
  { "EdenEast/nightfox.nvim", opts = {options = {dim_inactive = true}} }, -- dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
  { "catppuccin/nvim", name = "catppuccin", opts = { dim_inactive = { enabled = true } } },
  { "loctvl842/monokai-pro.nvim" },
  { "marko-cerovac/material.nvim" },
  {
    "ribru17/bamboo.nvim",
    opts = {
      highlights = { ["@comment"] = { fg = "$grey" }},
      dim_inactive = true,
    }
  },
  { "xiyaowong/nvim-transparent",
    opts = { extra_groups = { "NormalFloat" } },
    keys = { { "\\t", "<Cmd>TransparentToggle<CR>", desc = "Toggle Transparent" } },
  },
  { "folke/styler.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      themes = {
        -- markdown = { colorscheme = "catppuccin" },
        json = { colorscheme = "nordfox" },
        toml = { colorscheme = "terafox" },
        yaml = { colorscheme = "carbonfox" },
        help = { colorscheme = "rose-pine" },
      },
    },
  },
}
