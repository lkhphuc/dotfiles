return {
  { "rmehri01/onenord.nvim", lazy = true, },
  { "rebelot/kanagawa.nvim",
    config = {
      globalStatus = true, dimInactive = true,
    }
  },
  { "navarasu/onedark.nvim", lazy = true},
  { "projekt0n/github-nvim-theme", lazy = true },
  { "cpea2506/one_monokai.nvim", lazy = true},
  { "folke/tokyonight.nvim",
    priority = 1000,
    config = { dim_inactive = true, }
  },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "catppuccin/nvim", lazy = true,
    init = function()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    end,
  },
  { "marko-cerovac/material.nvim", lazy = true,
    init = function()
      vim.g.material_style = "deep ocean" -- darker lighter oceanic palenight deep ocean
    end,
  },
  { "bluz71/vim-moonfly-colors", lazy = true },
  { "Yazeed1s/minimal.nvim", lazy = true },
  { "pappasam/papercolor-theme-slim", lazy = true },
  { "sainnhe/everforest", lazy = true,
    init = function()
      vim.g.everforest_background = "hard"
    end,
  },
  { "sainnhe/sonokai" },
  { "ray-x/starry.nvim",
    init = function()
      vim.g.starry_daylight_switch = false --this allow using brighter color
    end,
  },
  { "folke/styler.nvim", lazy = false,
    config = function()
      require("styler").setup({
        themes = {
          markdown = { colorscheme = "kanagawa" },
          help = { colorscheme = "kanagawa", background = "dark" },
        },
      })

      -- Due to the way different colorschemes configure different highlights group,
      -- there is no universal way to add gui options to all the desired components.
      -- Findout the final highlight group being linked to and update gui option.
      local function mod_hl(opts, hl_name)
        local hl_def = vim.api.nvim_get_hl_by_name(hl_name, true)
        for k, v in pairs(opts) do hl_def[k] = v end
        local ok, _ = pcall(vim.api.nvim_set_hl, 0, hl_name, hl_def)
        if not ok then print("Failed to set highlight " .. hl_name) end
      end


      vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
        group = vim.api.nvim_create_augroup("Color", {}),
        callback = function()
          mod_hl({ bold = true, italic = true }, "@keyword.return")
          mod_hl({ bold = true, italic = true }, "@constant.builtin")
          mod_hl({ bold = true, italic = true }, "@function.builtin")
          mod_hl({ bold = true, italic = true }, "@type.builtin")
          mod_hl({ bold = true, italic = true }, "@boolean")

          mod_hl({ bold = true }, "@type")
          mod_hl({ bold = true }, "@constructor")
          mod_hl({ bold = true }, "@operator")
          mod_hl({ bold = true }, "@keyword")

          mod_hl({ italic = true }, "@include")
          mod_hl({ italic = true }, "@variable.builtin")
          mod_hl({ italic = true }, "@conditional")
          mod_hl({ italic = true }, "@keyword.function")
          mod_hl({ italic = true }, "@comment")
          mod_hl({ italic = true }, "@parameter")
          mod_hl({ italic = true }, "@method.call")

          -- Semshi  #TODO: semshi not loaded yet
          -- mod_hl({ gui = 'combine'}, "semshiGlobal")


          vim.cmd([[highlight! Folded guibg=NONE]]) --Folded line don't have background, ever
          vim.cmd([[highlight! link MiniIndentscopeSymbol IndentBlanklineChar]])
          vim.cmd([[highlight! MiniCursorwordCurrent gui=nocombine guibg=NONE]])
          vim.cmd([[autocmd FileType floaterm setlocal winblend=10]])
        end,
      })
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },
}
