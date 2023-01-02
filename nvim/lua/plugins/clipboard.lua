return {
  { "EtiamNullam/deferred-clipboard.nvim", config = true, lazy = true, },
  { "ojroques/nvim-osc52",
    config = { silent = true,},
    init = function ()
      -- Leader yank to `+` register system clipboard
      vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { remap = true })
      vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y', { remap = true })
      vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { remap = true })
      -- the '+' register will copy to system clipboard using OSC52
      local function copy(lines, _)
        require('osc52').copy(table.concat(lines, '\n'))
      end
      local function paste()
        return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
      end
      vim.g.clipboard = {
        name = 'osc52',
        copy = {['+'] = copy, ['*'] = copy},
        paste = {['+'] = paste, ['*'] = paste},
      }
      -- Don't yank empty line to clipboard
      vim.keymap.set("n", "dd", function()
        local is_empty_line = vim.api.nvim_get_current_line():match("^%s*$")
        if is_empty_line then return '"_dd' else return "dd" end
      end, { noremap = true, expr = true })
      vim.keymap.set("v", "p", '"_dP', { desc = "Paste over selection without yanking"})
      vim.api.nvim_create_autocmd("TextYankPost", { callback = vim.highlight.on_yank })
    end
  },
}
