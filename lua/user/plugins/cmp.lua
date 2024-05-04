return {
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            -- different complectionengines
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua',
            {
                -- Snippets
                'saadparwaiz1/cmp_luasnip',
                dependencies = { 'L3MON4D3/Luasnip' }
            }
        },
        config = function()
            -- Setup nvim-cmp.
            --
            local cmp = require('cmp')

            cmp.setup {

                -- snippets (required for cmp to function)
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },

                -- keymaps for compltion
                mapping = {
                    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ['<C-e>'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert, -- TODO maybe change this to replace
                        select = true
                    }),                                        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                },

                -- completion sources
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' }, -- für vim.api... in der config
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer',  keyword_length = 5 },
                    { name = 'orgmode' },
                },
            }

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer', keyword_length = 5 }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline', keyword_length = 2 }
                })
            })
        end
    },
}
