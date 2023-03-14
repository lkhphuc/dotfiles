return {
  { "rmehri01/onenord.nvim" },
  { "rebelot/kanagawa.nvim", opts = { dimInactive = true } },
  { "navarasu/onedark.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "cpea2506/one_monokai.nvim" },
  { "folke/tokyonight.nvim", opts = { dim_inactive = true } },
  { "EdenEast/nightfox.nvim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      dim_inactive = { enabled = true },
    },
  },
  {
    "marko-cerovac/material.nvim",
    init = function()
      vim.g.material_style = "deep ocean" -- darker lighter oceanic palenight deep ocean
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
    event = "VeryLazy",
    opts = {
      themes = {
        markdown = { colorscheme = "catppuccin" },
        json = { colorscheme = "kanagawa" },
        toml = { colorscheme = "kanagawa" },
        yaml = { colorscheme = "kanagawa" },
        help = { colorscheme = "one_monokai" },
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

            highlight! semshiImported gui=bold,italic
            highlight! semshiGlobal gui=bold
            highlight! link semshiParameter @parameter
            highlight! link semshiParameterUnused @parameter
            highlight!      semshiParameterUnused gui=undercurl
            highlight! link semshiAttribute @attribute
            highlight! link semshiBuiltin @function.builtin
            highlight! link semshiUnresolved @text.warning
          ]])
        end,
      })
    end,
  },
}
