return {
    -- LSP
    {
        'williamboman/mason.nvim',
    },
    {
        'williamboman/mason-lspconfig.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "cmp-nvim-lsp",
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
        },
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.clangd.setup {}
            lspconfig.basedpyright.setup {}
            lspconfig.nil_ls.setup {}

            -- set the runtime_path for lua-language-server
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")
            lspconfig.lua_ls.setup {
                -- addverties Capabilities from nvim cmp
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Setup your lua path
                            path = runtime_path,
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            local handlers = {
                -- default handler
                function(server_name)
                    lspconfig[server_name].setup {}
                end,
            }

            require("mason").setup() -- TODO this could be cleaner
            require("mason-lspconfig").setup({
                handlers = handlers,
            })
        end
    },
}
