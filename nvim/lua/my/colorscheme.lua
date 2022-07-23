vim.g.termguicolors = 1

-- Confusingly these options cannot be set in the config section of their respective plugins
vim.g.material_style = 'deep ocean'-- darker lighter oceanic palenight deep ocean
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

-- Due to the way different colorschemes configure different highlights group,
-- there is no universal way to add gui options to all the desired components.
-- Findout the final highlight group being linked to and update gui option.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup('Color', {}),
  pattern = "*",
  callback = function ()
    vim.cmd "highlight Include gui=bold,italic"
    vim.cmd "highlight TSKeywordReturn gui=bold,italic"
    vim.cmd "highlight TSConstBuiltin gui=bold,italic"
    vim.cmd "highlight TSFuncBuiltin gui=bold,italic"
    vim.cmd "highlight TSTypeBuiltin gui=bold,italic"
    vim.cmd "highlight TSVariableBuiltin gui=bold,italic"

    vim.cmd "highlight TSType gui=bold"
    vim.cmd "highlight TSConstructor gui=bold"
    vim.cmd "highlight TSOperator gui=bold"

    vim.cmd "highlight TSConditional gui=italic"
    -- vim.cmd "highlight Statement gui=italic"
    vim.cmd "highlight TSKeyword gui=italic"
    vim.cmd "highlight TSKeywordFunction gui=italic"
    vim.cmd "highlight Comment gui=italic"
    vim.cmd "highlight TSParameter gui=italic"

    -- vim.cmd "highlight TSVariable gui=none"
    -- vim.cmd "highlight Folded guibg=None"
  end
})

vim.cmd "colorscheme one_monokai "
