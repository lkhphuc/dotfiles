return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false, -- a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = { -- add a border to hover docs and signature help
          views = { hover = { border = { style = "shadow" } } },
        },
      },
      routes = {
        { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "E486" }, opts = { skip = true } },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        -- border = "rounded", -- none, single, double, shadow, rounded
        -- position = "bottom", -- bottom, top
        -- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        -- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 10,
      },
      layout = {
        align = "center", -- align columns left, center or right
      },
    },
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set("", key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")

      animate.setup({
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      })
    end,
  },
  { "nvim-zh/colorful-winsep.nvim", config = true, event = "WinNew" },
  { "NvChad/nvim-colorizer.lua", event = "BufReadPost", config = true },

  -- {'vimpostor/vim-tpipeline', -- tmux + nvim global statusline
  --   init = function()
  --     vim.g.tpipeline_usepane = 1
  --     vim.g.tpipeline_clearstl = 1
  --   end
  -- },

  {
    "folke/zen-mode.nvim",
    config = true,
    cmd = "ZenMode",
    keys = { { "<leader>uz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" } },
    dependencies = { "folke/twilight.nvim", config = true },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  { "nacro90/numb.nvim", event = "CmdlineEnter", config = true }, --Peeking line before jump
  { "smjonas/inc-rename.nvim", config = true, cmd = "IncRename" },
  {
    "m-demare/hlargs.nvim",
    opts = {
      -- excluded_filetypes = { "python" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    dependencies = { "kwkarlwang/bufresize.nvim", config = true },
    opts = {
      resize_mode = {
        hooks = { on_leave = function() require("bufresize").register() end },
      },
    },
  },
  { "sindrets/winshift.nvim", cmd = "WinShift", opts = { highlight_moving_win = true } },

  -- use{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").register_lsp_virtual_lines()
  --   end,
  -- }
  --
}
