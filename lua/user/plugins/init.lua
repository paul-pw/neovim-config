return {
    -- semantic Highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        event = { "BufReadPre", "BufNewFile" },
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'org' }
                },
                ensure_installed = { 'org' }
            })
        end
    },

    -- Autosave
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup(
                {
                    enabled = true,
                    debounce_delay = 3,
                }
            )
        end
    },

    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = true
        --[[function()
            require('gitsigns').setup()
        end--]]
    },

    {
        "lervag/vimtex",
        config = function()
            vim.g.vimtex_view_method = "zathura"
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                nix = { "nixpkgs-fmt" },
            },
            lsp_fallback = true,
            --format_on_save = { timeout_ms = 500, lsp_fallback = true },
        }
    }

    -- TODO Comments.nvim
    -- TODO nvim-scissors / create custom snippets with lua-snippets
    -- TODO harpoon
    -- TODO trouble.nvim
    -- TODO Setup Whichkey
    -- TODO colors to see the colors of hex values
}
