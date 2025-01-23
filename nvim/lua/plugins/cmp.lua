return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "rafamadriz/friendly-snippets",
      { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
    },
    opts = function(_, opts)
      opts.completion.keyword_length = 2
      opts.window = {
        completion = {
          col_offset = -2, -- to align text when 2 icons are prepended
        },
      }

      table.insert(opts.sources, { name = "snippets" })

      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local kind_icons = require("lazyvim.config").icons.kinds
          local source_icons = {
            nvim_lsp = "",
            luasnip = "",
            snippets = "",
            treesitter = "",
            tags = "",
            buffer = "",
            fuzzy_buffer = "󱔘",
            path = "",
            fuzzy_path = "󰉓",
            omni = "",
            cmp_ai = "",
            copilot = "",
            cmp_tabnine = "󰌒",
            rg = "",
            cmdline = "",
            cmdline_history = "",
            jupyter = "",
          }
          item.menu = source_icons[entry.source.name] or entry.source.name
          item.menu = item.menu .. " " .. item.kind
          item.kind = kind_icons[item.kind]:sub(1, -2) or " "
          return item
        end,
      }
    end,

    config = function(_, opts)
      local cmp = require("cmp")
      for _, source in ipairs(opts.sources) do
        if source.name == "copilot" then
          source.group_index = 2 -- disable copilot on default
        else
          source.group_index = source.group_index or 1
        end
      end
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-l>"] = cmp.mapping.complete({
          config = {
            sources = vim.tbl_filter(
              function(source) return source.group_index == 2 end,
              opts.sources
            ),
          },
        }),
      })
      cmp.setup(opts) -- insert mode completion
      cmp.setup.cmdline({ "/", "?" }, {
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "cmdline_history" },
        }),
      })
    end,
  },
}
