local M = {}

M.config = function()
    require("nvim-treesitter.configs").setup {
        highlight = {
            enable = true,
            use_languagetree = true
        },
        incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            },
        },
        indent = {
            enable = false,  -- very buggy atm
        },
        rainbow = { enable = true },
        refactor = {
            highlight_definitions = { enable = true},
            highlight_current_scope = { enable = false},
            smart_rename = {
                enable = true,
                keymaps = { smart_rename = "<leader>rn"}
            }
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "gd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
            }
        },
        textobjects = {
            select = {
              enable = true,
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                }
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
            lsp_interop = {
                enable = true,
                peek_definition_code = {
                    ["<leader>k"] = "@function.outer",
                    ["<leader>k"] = "@class.outer",
                },
            },
            matchup = { enable = true, },
            context_commentstring = { enable = true},
        },
    }
end

return M
