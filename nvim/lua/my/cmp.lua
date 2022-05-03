require("luasnip/loaders/from_vscode").lazy_load()
local luasnip = require 'luasnip'
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = require('lspkind').cmp_format(),
    menu = {
      nvim_lsp = "[LSP]",
      luasnip = "[Snippet]",
      buffer = "[Buffer]",
      path = "[Path]",
    }
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'treesitter' },
    { name = 'tags' },
    --{ name = 'cmp_tabnine' },
    { name = 'buffer' },
    { name = 'path' },
  },
  view = {
    entries = {name = 'custom', selection_order = 'near_cursor' }
  },
}
cmp.setup.cmdline('/', {
  sources = {
    { name = 'nvim_lsp_document_symbol' },
    { name = 'cmdline' },
  }, {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
