return {
  {
    "folke/sidekick.nvim",
    opts = { nes = { enabled = false } },
    keys = {
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "cursor", focus = true }) end,
        desc = "Sidekick Cursor Toggle",
        mode = { "n", "v" },
      },
    },
  },
  {
    "milanglacier/minuet-ai.nvim",
    lazy = false,
    opts = {
      n_completions = 1, -- recommend for local model for resource saving
      provider = "openai_fim_compatible",
      provider_options = {
        openai_fim_compatible = {
          name = "LMStudio FIM",
          model = "qwen/qwen3-coder-30b",
          api_key = "TERM",
          end_point = "http://127.0.0.1:1234/v1/completions",
          streaming = true,
          template = {
            prompt = function(context_before_cursor, context_after_cursor, opts)
              return "<|fim_prefix|>"
                .. context_before_cursor
                .. "<|fim_suffix|>"
                .. context_after_cursor
                .. "<|fim_middle|>"
            end,
            suffixe = false,
          },
        },
        openai_compatible = {
          name = "LMStudio",
          model = "openai/gpt-oss-20b",
          api_key = "TERM",
          end_point = "http://127.0.0.1:1234/v1/chat/completions",
          streaming = true,
          context_window = 2048,
          optional = {
            max_tokens = 1024,
          },
        },
      },
    },
  },
}
