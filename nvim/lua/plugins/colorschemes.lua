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
  { 'loctvl842/monokai-pro.nvim', opts = {} },
  { 'ellisonleao/gruvbox.nvim', opts={}},
  {
    'ribru17/bamboo.nvim',
    opts = {
      highlights = {
        ["@comment"] = { fg = '$grey' },
        ["@lsp.type.selfKeyword"] = { link = '@variable.static' }
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
    init = function()
      -- NOTE: Due to the way different colorschemes configure different highlights group,
      -- there is no universal way to add gui options to all the desired components.
      -- Findout the final highlight group being linked to and update gui option.
      local function mod_hl(opts, hl_names)
        for _, hl in ipairs(hl_names) do
          local hl_def = vim.api.nvim_get_hl(0, { name = hl })
          for k, v in pairs(opts) do
            hl_def[k] = v
          end
          local ok, _ = pcall(vim.api.nvim_set_hl, 0, hl, hl_def)
          if not ok then vim.pretty_print("Failed to set highlight " .. hl) end
        end
      end

      vim.api.nvim_create_autocmd({ "BufReadPre", "ColorScheme" }, {
        group = vim.api.nvim_create_augroup("Color", {}),
        callback = function()
          mod_hl({ bold = true, italic = true }, {
            "@constant.builtin",
            "@function.builtin",
            "@type.builtin",
            "@boolean",
          })
          mod_hl({ bold = true }, {
            "@type",
            "@constructor",
          })
          mod_hl({ italic = true }, {
            "@variable.builtin",
            "@comment",
            "@parameter",
          })

          vim.cmd([[
            highlight! Folded guibg=NONE
            highlight! MiniCursorword guibg=#3b4261 gui=NONE cterm=NONE
            highlight! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE
          ]])
        end,
      })
    end,
  },
}
