return {
  { "rebelot/kanagawa.nvim",
    opts = {
      dimInactive = true,
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      overrides = function(colors)
        local theme = colors.theme
        local makeDiagnosticColor = function(color)
          local c = require("kanagawa.lib.color")
          return { fg = c(color):saturate(-0.2):to_hex(), bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
          DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
          LspInlayHint = makeDiagnosticColor(theme.ui.nontext),
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
      },
      overrides = function(colors)
        local theme = colors.theme
        local blendBG = function(color)
          local c = require("kanso.lib.color")
          return { fg = c(color):to_hex(), bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
          LspInlayHint = blendBG(theme.ui.nontext),
        }
      end
    },
  },
  { "navarasu/onedark.nvim", opts = { style = "warmer" } },
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
