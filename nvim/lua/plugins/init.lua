return {
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.lang.json" },
  { import = "plugins.extras.rust" },
  { import = "plugins.extras.python" },

  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

  { "aduros/ai.vim", keys = "<C-a>" }, -- OpenAI's GPT
  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
}
