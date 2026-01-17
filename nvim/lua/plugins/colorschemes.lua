return {
  { "rebelot/kanagawa.nvim",
    opts = {
      dimInactive = true,
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      overrides = function(colors)
        local theme = colors.theme
        local saturate_blend = function(color, saturate, blend)
          local c = require("kanagawa.lib.color")
          return { fg = c(color):saturate(saturate):to_hex(), bg = c(color):blend(theme.ui.bg, blend):to_hex() }
        end

        return {
          DiagnosticVirtualTextHint  = saturate_blend(theme.diag.hint, -0.2, 0.95),
          DiagnosticVirtualTextInfo  = saturate_blend(theme.diag.info, -0.2, 0.95),
          DiagnosticVirtualTextWarn  = saturate_blend(theme.diag.warning, -0.2, 0.95),
          DiagnosticVirtualTextError = saturate_blend(theme.diag.error, -0.3, 0.90),
          LspInlayHint = saturate_blend(theme.ui.nontext, 0.0, 0.95),
          NvimDapVirtualText = saturate_blend(theme.syn.comment, 0.0, 0.95)
        }
      end
    },
  },
  {
    "webhooked/kanso.nvim",
    opts = {
      dimInactive = true,
      foreground = {
        dark = "saturated",
        light = "saturated",
      },
      overrides = function(colors)
        local theme = colors.theme
        local saturate_blend = function(color, saturate, blend)
          local c = require("kanagawa.lib.color")
          return { fg = c(color):saturate(saturate):to_hex(), bg = c(color):blend(theme.ui.bg, blend):to_hex() }
        end

        return {
          LspInlayHint = saturate_blend(theme.ui.nontext, 0.0, 0.95),
          NvimDapVirtualText = saturate_blend(theme.syn.comment, 0.0, 0.95)
        }
      end
    },
  },
  { "folke/tokyonight.nvim", opts = { dim_inactive = true } },
  { "EdenEast/nightfox.nvim", opts = { options = { dim_inactive = true } } }, -- dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
  { 'AlexvZyl/nordic.nvim'},
  { "catppuccin/nvim", name = "catppuccin", opts = { dim_inactive = { enabled = true } } },
  { "loctvl842/monokai-pro.nvim" },
  {
    "ribru17/bamboo.nvim",
    opts = {
      highlights = { ["@comment"] = { fg = "$grey" } },
      dim_inactive = true,
    },
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
        python = { colorscheme = "bamboo" },
        markdown = { colorscheme = "catppuccin" },
        json = { colorscheme = "monokai-pro" },
        toml = { colorscheme = "monokai-pro-spectrum" },
        yaml = { colorscheme = "monokai-pro-machine" },
        help = { colorscheme = "material-deep-ocean" },
      },
    },
  },
}
