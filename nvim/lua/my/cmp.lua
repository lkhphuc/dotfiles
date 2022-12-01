require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local compare = require('cmp.config.compare')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

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
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
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
    ['<C-l>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.complete_common_string()
      end
      fallback()
    end, { 'i', 'c' }),

  }),
  formatting = {
    -- fields = { "kind", "abbr", "menu" },
    format = require('lspkind').cmp_format({
      mode = "symbol_text",
      menu = {
        nvim_lsp = "",
        luasnip = "",
        treesitter = "",
        tags = "",
        buffer = "",
        path = "",
        copilot = "",
        cmp_tabnine = "",
        rg = "",
      },
    }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    { name = 'tags' },
    {
      name = 'fuzzy_buffer',
      option = {
        get_bufnrs = function() -- Get all opened buffers
          local bufs = {}
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
            if buftype ~= 'nofile' and buftype ~= 'prompt' then
              bufs[#bufs + 1] = buf
            end
          end
          return bufs
        end
      },
    },
    { name = 'fuzzy_path' },
    { name = 'copilot', priority=2, },
    -- { name = 'cmp_tabnine' },
    -- { name = 'rg' },
  },
  view = {
    entries = {name = 'custom', selection_order = 'near_cursor' }
  },
  experimental = {
    ghost_text = true,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      require('cmp_fuzzy_buffer.compare'),
      require('cmp_fuzzy_path.compare'),
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    }
  }
}

cmp.setup.cmdline({'/', '?'}, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'fuzzy_buffer'},
    { name = 'nvim_lsp_document_symbol' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline' },
    { name = 'fuzzy_path' },
  }),
})
