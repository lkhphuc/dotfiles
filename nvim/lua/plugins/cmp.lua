return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    { "abecodes/tabout.nvim", opts = {} },
    {
      "L3MON4D3/LuaSnip",
      keys = function() return {} end, -- override LazyVim to configure suptertab
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    },
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
  },
  opts = function(_, opts)
    local luasnip = require("luasnip")
    local cmp = require("cmp")

    opts.window = {
      completion = {
        col_offset = -2, -- to align text when 2 icons are prepended
      },
    }
    opts.view = { entries = { name = "custom", selection_order = "near_cursor" } }

    -- Super tab completion
    local has_words_before = function()
      if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
          and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-Space>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end),
    })

    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, item)
        local kind_icons = require("lazyvim.config").icons.kinds
        local source_icons = {
          nvim_lsp = "",
          luasnip = "",
          treesitter = "",
          tags = "",
          buffer = "",
          fuzzy_buffer = "󱔘",
          path = "",
          fuzzy_path = "󰉓",
          omni = "",
          copilot = "",
          cmp_tabnine = "󰌒",
          rg = "",
          cmdline = "",
          cmdline_history = "",
          jupyter = "",
        }
        item.menu = source_icons[entry.source.name] or entry.source.name
        item.menu = item.menu .. " " .. item.kind
        item.kind = kind_icons[item.kind]:sub(1, -2) or " "
        return item
      end,
    }
    opts.sources = cmp.config.sources(
      {
        { name = "jupyter", priority = 750 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
      {
        name = "buffer",
        option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end },
      },
      { name = "path" },
    })
  end,

  config = function(_, opts)
    local cmp = require("cmp")
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
}
