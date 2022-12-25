local M = {
  "folke/styler.nvim",
  lazy = false,
  dependencies = {
    "rmehri01/onenord.nvim",
    "rebelot/kanagawa.nvim",
    "navarasu/onedark.nvim",
    "projekt0n/github-nvim-theme",
    "cpea2506/one_monokai.nvim",
    { "folke/tokyonight.nvim", lazy = false },
    "EdenEast/nightfox.nvim",
    "catppuccin/nvim",
    "marko-cerovac/material.nvim",
    "bluz71/vim-moonfly-colors",
    "Yazeed1s/minimal.nvim",
    "pappasam/papercolor-theme-slim",
    "sainnhe/everforest",
    "sainnhe/sonokai",
    'ray-x/starry.nvim',
  }
}

function M.config()
  vim.g.tokyonight_style = "night"
  vim.g.tokyonight_dim_inactive = true
  vim.g.material_style = 'deep ocean' -- darker lighter oceanic palenight deep ocean
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
  vim.g.everforest_background = 'hard'
  vim.g.starry_daylight_switch = false --this allow using brighter color

  -- Due to the way different colorschemes configure different highlights group,
  -- there is no universal way to add gui options to all the desired components.
  -- Findout the final highlight group being linked to and update gui option.
  local function mod_hl(hl_name, opts)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
    if is_ok then
      for k, v in pairs(opts) do hl_def[k] = v end
      vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
  end

  vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    group = vim.api.nvim_create_augroup('Color', {}),
    pattern = "*",
    callback = function()
      mod_hl("@keyword.return", { bold = true, italic = true })
      mod_hl("@constant.builtin", { bold = true, italic = true })
      mod_hl("@function.builtin", { bold = true, italic = true })
      mod_hl("@type.builtin", { bold = true, italic = true })
      mod_hl("@boolean", { bold = true, italic = true })

      mod_hl("@type", { bold = true })
      mod_hl("@constructor", { bold = true })
      mod_hl("@operator", { bold = true })
      mod_hl("@keyword", { bold = true })

      mod_hl("@include", { italic = true, })
      mod_hl("@variable.builtin", { italic = true })
      mod_hl("@conditional", { italic = true })
      mod_hl("@keyword.function", { italic = true })
      -- mod_hl("Function", { italic = true, nocombine = true })
      mod_hl("@comment", { italic = true })
      mod_hl("@parameter", { italic = true })

      mod_hl("semshiBuiltin", { italic = true, })

      mod_hl("Folded", { bg = "" }) --Folded line don't have background, ever
      vim.cmd [[highlight! link MiniIndentscopeSymbol IndentBlanklineChar]]
    end
  })

  vim.cmd "autocmd FileType floaterm setlocal winblend=10"
  vim.cmd "colorscheme tokyonight"

  require('styler').setup({
    themes = {
      markdown = { colorscheme = "kanagawa" },
      help = { colorscheme = "catppuccin-mocha", background = "dark" },
    },

  })
end

return M
