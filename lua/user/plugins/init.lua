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
                python = { "isort", "black" },
                html = { "prettier" },
                json = { "prettier" },
                css = { "prettier" },
                markdown = { "prettier" }
            },
            lsp_fallback = true,
            --format_on_save = { timeout_ms = 500, lsp_fallback = true },
        }
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        -- pretty statusline
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {}
    },
    -- TODO nvim-scissors / create custom snippets with lua-snippets
    -- TODO harpoon
    -- TODO colors to see the colors of hex values
}
