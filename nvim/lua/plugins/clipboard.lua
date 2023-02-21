return {
  -- { "EtiamNullam/deferred-clipboard.nvim", opts = { fallback = "unnamedplus", lazy = true } },
  {
    "ojroques/nvim-osc52",
    opts = { silent = true },
    init = function()
      -- the '+' register will copy to system clipboard using OSC52
      local function copy(lines, _) require("osc52").copy(table.concat(lines, "\n")) end
      local function paste() return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") } end
      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
      }
    end,
  },
}
