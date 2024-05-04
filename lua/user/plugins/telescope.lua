return {
    -- telescope for finding stuff
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim',
            -- native FZF for better and faster fzf results
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            -- Telescope
            -- use native fzf
            require('telescope').setup {
                defaults = {
                    prompt_prefix = "> ",
                },

                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                    }
                }
            }
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require('telescope').load_extension('fzf')



            local opts = { noremap = true, silent = true }
        end
    },
}
