return {
  "nvimtools/none-ls.nvim",
  opts = {
    sources = {
      require("null-ls").builtins.formatting.yapf.with({
        extra_args = function(params)
          return params
            and {
              "--style={indent_width:" .. vim.fn.shiftwidth() .. "}",
            }
        end,
      }),

      require("null-ls").builtins.formatting.stylua.with({
        extra_args = function(params)
          return params
            and {
              "indent-type=Spaces, indent-width=" .. vim.fn.shiftwidth(),
            }
        end,
      }),

      require("null-ls").builtins.code_actions.shellcheck,

      require("null-ls").builtins.hover.dictionary,
      require("null-ls").builtins.hover.printenv,
    },
  },
}
