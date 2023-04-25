return {
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.lang.json" },
  { import = "plugins.extras.rust" },
  { import = "plugins.extras.python" },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

  { "aduros/ai.vim", keys = "<C-a>" }, -- OpenAI's GPT
  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
  -- { "EtiamNullam/deferred-clipboard.nvim", opts = { fallback = "unnamedplus", lazy = true } },
  {
    "ojroques/nvim-osc52",
    opts = { silent = false },
    init = function()
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
            require("osc52").copy_register("+")
          end
        end,
      })
    end,
  },
}
