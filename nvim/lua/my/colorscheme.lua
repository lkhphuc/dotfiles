-- Confusingly these options cannot be set in the config section of their respective plugins
vim.g.tokyonight_style = 'storm'  -- storm | night | day
vim.g.material_style = 'deep ocean'-- darker lighter oceanic palenight deep ocean
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.g.everforest_background = 'hard'
vim.g.starry_daylight_switch = false  --this allow using brighter color

-- Due to the way different colorschemes configure different highlights group,
-- there is no universal way to add gui options to all the desired components.
-- Findout the final highlight group being linked to and update gui option.
local function mod_hl(hl_name, opts)
  local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
  if is_ok then
    for k,v in pairs(opts) do hl_def[k] = v end
    vim.api.nvim_set_hl(0, hl_name, hl_def)
  end
end

vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
  group = vim.api.nvim_create_augroup('Color', {}),
  pattern = "*",
  callback = function ()
    mod_hl("TSKeywordReturn", { bold=true, italic=true })
    mod_hl("TSConstBuiltin", { bold=true, italic=true })
    mod_hl("TSFuncBuiltin", { bold=true, italic=true })
    mod_hl("TSTypeBuiltin", { bold=true, italic=true })
    mod_hl("TSBoolean", { bold=true, italic=true })

    mod_hl("TSType", { bold=true })
    mod_hl("TSConstructor", { bold=true })
    mod_hl("TSOperator", { bold=true })

    mod_hl("TSInclude", { italic=true, })
    mod_hl("TSVariableBuiltin",{ italic=true })
    mod_hl("TSConditional", { italic=true })
    mod_hl("TSKeyword", { italic=true })
    mod_hl("TSKeywordFunction", { italic=true })
    mod_hl("TSComment", { italic=true })
    mod_hl("TSParameter", { italic=true })

    mod_hl("semshiBuiltin", { italic=true, })
    vim.api.nvim_set_hl(0, "semshiAttribute", {link="TSAttribute"})

    mod_hl("Folded", { bg="" })
  end
})

vim.cmd "set termguicolors"
vim.cmd "colorscheme catppuccin"
