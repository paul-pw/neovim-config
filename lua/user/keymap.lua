-- Regular Keymap
-- saving files
local wk = require("which-key")
local opts = { noremap = true, silent = true }



wk.register({
    ["<C-s>"] = { ":w<cr>", "save file" },
    ["<C-b>"] = { ":NvimTreeToggle<CR>", "toggle nvim tree" },
    ["<C-n>"] = { ":NvimTreeFocus<CR>", "focus nvim tree" },
    ["<space>wk"] = {":WhichKey<cr>", "show all mappings"},
})
wk.register({
    ["<C-n>"] = { "<Esc>:NvimTreeFocus<CR>", "focus nvim tree" },
    ["<C-s>"] = { "<Esc>:w<cr>i<Right>", "save file" },
}, { mode = 'i' })

-- VScode like moving of lines and selections
wk.register({
    ['<A-j>'] = { ':m .+1<CR>==', "move line down" },
    ['<A-k>'] = { ':m .-2<CR>==', "move line up" }
}, { mode = "n" })
wk.register({
    ['<A-j>'] = { '<esc>:m .+1<CR>==', "move line down" },
    ['<A-k>'] = { '<esc>:m .-2<CR>==', "move line up" }
}, { mode = "i" })
wk.register({
    ['<A-j>'] = { ":m '>+1<CR>gv=gv", "move lines down" },
    ['<A-k>'] = { ":m '<-2<CR>gv=gv", "move lines up" }
}, { mode = "v" })

-- set keymap on lsp attach
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        vim.api.nvim_buf_set_option(ev.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        wk.register({
            g = {
                name = "Go To",
                D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "goto declaration" },
                d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "go to definition" },
                r = { '<cmd>lua vim.lsp.buf.references()<CR>', "go to reference" },
                i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', "go to implementation" },
            },
            ['K'] = { '<cmd>lua vim.lsp.buf.hover()<CR>', "hover" },
            ['<C-k>'] = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', "signature help" },
            ['<F2>'] = { '<cmd>lua vim.lsp.buf.rename()<CR>', "rename symbol" },
            ['<space>ca'] = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "code action" },
            ['ff'] = { '<cmd>lua vim.lsp.buf.format({async = true})<CR>', "format file" },
        }, { buffer = ev.buf })
    end,
})


-- DAP
wk.register({
    ['<F5>'] = { function() require "dap".continue() end, "start debugging session" },
    ['<F6>'] = { function() require "dap".terminate() end, "terminate debugging session" },
    ['<'] = {
        function()
            require "dap".step_into({ stepping_granularity = "line", ask_for_targets = true })
        end, "step into" },
    ['>'] = { function() require "dap".step_over() end, "step over" },
    ['<F9>'] = { function() require "dap".toggle_breakpoint() end, "toggle breakpoint" },
    ['<F10>'] = {
        function()
            local w = require "dap.ui.widgets".hover()
            vim.keymap.set('n', '<Esc>', function() w.close() end, { buffer = true })
            vim.keymap.set('n', 'q', function() w.close() end, { buffer = true })
        end, "hover widget" },
    ['<C-F10>'] = {
        function()
            local widgets = require("dap.ui.widgets")
            local w = widgets.centered_float(widgets.scopes)
            vim.keymap.set('n', '<Esc>', function() w.close() end, { buffer = true })
            vim.keymap.set('n', 'q', function() w.close() end, { buffer = true })
        end, "DAP scopes" }
})


-- Finding stuff with Telescope
wk.register({
    ["<C-f>"] = { ":Telescope live_grep<cr>", "find file" },
    f = {
        name = "Find",
        F = { ":Telescope find_files<cr>", "find files" },
        g = { ":Telescope live_grep<cr>", "live grep" },
        s = { ":Telescope lsp_dynamic_workspace_symbols<cr>", "workspace symbols" },
    },
})

local M = require("user.json_config")

if M.build.build then
    vim.api.nvim_set_keymap('n', '<F8>', ":!" .. M.build.build .. "<CR>", opts)
end

if M.build.generate then
    vim.api.nvim_set_keymap('n', '<C-F8>', ":!" .. M.build.generate .. '<CR>', opts)
end
