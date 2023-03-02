return {
  { "rmehri01/onenord.nvim" },
  { "rebelot/kanagawa.nvim", opts = {
    globalStatus = true,
    dimInactive = true,
  } },
  { "navarasu/onedark.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "cpea2506/one_monokai.nvim" },
  { "folke/tokyonight.nvim", priority = 1000, opts = { dim_inactive = true } },
  { "EdenEast/nightfox.nvim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    init = function()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    end,
  },
  {
    "marko-cerovac/material.nvim",
    init = function()
      vim.g.material_style = "deep ocean" -- darker lighter oceanic palenight deep ocean
    end,
  },
  { "bluz71/vim-moonfly-colors", lazy = true },
  { "Yazeed1s/minimal.nvim", lazy = true },
  { "pappasam/papercolor-theme-slim", lazy = true },
  {
    "sainnhe/everforest",
    init = function() vim.g.everforest_background = "hard" end,
  },
  { "sainnhe/sonokai" },
  {
    "ray-x/starry.nvim",
    init = function()
      vim.g.starry_daylight_switch = false --this allow using brighter color
    end,
  },
  {
    "xiyaowong/nvim-transparent",
    cmd = "TransparentToggle",
    opts = {
      enable = false,
      -- extra_groups = 'all',
    },
  },
  {
    "folke/styler.nvim",
    lazy = "VeryLazy",
    opts = {
      themes = {
        markdown = { colorscheme = "kanagawa" },
        help = { colorscheme = "kanagawa", background = "dark" },
      },
    },
    init = function()
      -- Due to the way different colorschemes configure different highlights group,
      -- there is no universal way to add gui options to all the desired components.
      -- Findout the final highlight group being linked to and update gui option.
      local function mod_hl(opts, hl_names)
        for _, hl in ipairs(hl_names) do
          local hl_def = vim.api.nvim_get_hl_by_name(hl, true)
          for k, v in pairs(opts) do
            hl_def[k] = v
          end
          local ok, _ = pcall(vim.api.nvim_set_hl, 0, hl, hl_def)
          if not ok then vim.pretty_print("Failed to set highlight " .. hl) end
        end
      end

      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        group = vim.api.nvim_create_augroup("Color", {}),
        callback = function()
          mod_hl({ bold = true, italic = true }, {
            "@keyword.return",
            "@constant.builtin",
            "@function.builtin",
            "@type.builtin",
            "@boolean",
          })
          mod_hl({ bold = true }, {
            "@type",
            "@constructor",
            "@operator",
            "@keyword",
          })
          mod_hl({ italic = true }, {
            "@include",
            "@variable.builtin",
            "@conditional",
            "@keyword.function",
            "@comment",
            "@parameter",
            "@method.call",
          })

          vim.cmd([[
            highlight! Folded guibg=NONE
          ]])
        end,
      })
    end,
  },
}
