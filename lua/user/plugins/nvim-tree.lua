return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
        -- Tree setup
        local function my_on_attach(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', '+', api.tree.change_root_to_node, opts('CD'))

            vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
        end

        require('nvim-tree').setup({
            on_attach = my_on_attach
        })
    end
}
