return {
    {
        'navarasu/onedark.nvim',
        config = function()
            --setup colorscheme
            require('onedark').setup {
                style = 'darker',                                                                    -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                transparent = true,                                                                  -- Show/hide background
                term_colors = true,                                                                  -- Change terminal color as per the selected theme style
                ending_tildes = false,                                                               -- Show the end-of-buffer tildes. By default they are hidden
                toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between with

                -- Change code style ---
                -- Options are italic, bold, underline, none
                -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
                code_style = {
                    comments = 'italic',
                    keywords = 'none',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none'
                },
                -- Plugins Config --
                diagnostics = {
                    darker = false,     -- darker colors for diagnostic
                    undercurl = true,   -- use undercurl instead of underline for diagnostics
                    background = false, -- use background color for virtual text
                },

                -- TODO maybe remove this and make the terminal background darkeg
                colors = {
                    grey = "#6f7889"
                },
                highlights = {
                    -- lsp colors
                    ["@lsp.type.variable"] = { fg = "$red" },
                    ["lsp.typemod.variable.injected"] = { fg = "$red" },
                    -- treesitter colors
                    -- ["@variable"] = {fg = "$red"},
                    -- ["@variable.builtin"] = {fg = "$red" }
                }
            }
            -- Set colorscheme
            require('onedark').load()
        end
    },

    {
        'folke/tokyonight.nvim',
        config = function()
            vim.g.tokyonight_style = "day"
        end
    },

}
