-- Regular Keymap
-- saving files
local wk = require("which-key")
local opts = { noremap = true, silent = true }

wk.add({ {
    mode = { "n" },
    { "<C-s>",     ":w<cr>",                                                              desc = "save file" },
    { "<C-b>",     ":NvimTreeToggle<CR>",                                                 desc = "toggle nvim tree" },
    { "<C-n>",     ":NvimTreeFocus<CR>",                                                  desc = "focus nvim tree" },
    { "<space>wk", ":WhichKey<cr>",                                                       desc = "show all mappings" },
    { 'ff',        function() require("conform").format({ lsp_fallback = "always" }) end, desc = "format file" },
}, {
    mode = { 'i' },
    { "<C-n>", "<Esc>:NvimTreeFocus<CR>", desc = "focus nvim tree" },
    { "<C-s>", "<Esc>:w<cr>i<Right>",     desc = "save file" },
}, {
    -- VScode like moving of lines and selections
    mode = { "n" },
    { '<A-j>', ':m .+1<CR>==', desc = "move line down" },
    { '<A-k>', ':m .-2<CR>==', desc = "move line up" },
}, {
    mode = { "i" },
    { '<A-j>', '<esc>:m .+1<CR>==', desc = "move line down" },
    { '<A-k>', '<esc>:m .-2<CR>==', desc = "move line up" },
}, {
    mode = { "v" },
    { '<A-j>', ":m '>+1<CR>gv=gv", desc = "move lines down" },
    { '<A-k>', ":m '<-2<CR>gv=gv", desc = "move lines up" },
}, {
    -- DAP
    { '<F5>', function() require "dap".continue() end,  desc = "start debugging session" },
    { '<F6>', function() require "dap".terminate() end, desc = "terminate debugging session" },
    {
        '<',
        function()
            require "dap".step_into({ stepping_granularity = "line", ask_for_targets = true })
        end,
        desc = "step into"
    },
    { '>',    function() require "dap".step_over() end,         desc = "step over" },
    { '<F9>', function() require "dap".toggle_breakpoint() end, desc = "toggle breakpoint" },
    {
        '<F10>',
        function()
            local w = require "dap.ui.widgets".hover()
            vim.keymap.set('n', '<Esc>', function() w.close() end, { buffer = true })
            vim.keymap.set('n', 'q', function() w.close() end, { buffer = true })
        end,
        desc = "hover widget"
    },
    {
        '<C-F10>',
        function()
            local widgets = require("dap.ui.widgets")
            local w = widgets.centered_float(widgets.scopes)
            vim.keymap.set('n', '<Esc>', function() w.close() end, { buffer = true })
            vim.keymap.set('n', 'q', function() w.close() end, { buffer = true })
        end,
        desc = "DAP scopes"
    }
}, {
    -- Finding stuff with Telescope
    { "<space>f",     group = "Find and Format" },
    { "<C-f>", ":Telescope live_grep<cr>",                     desc = "find file" },
    { "<space>fc",    ":Telescope find_files<cr>",                    desc = "find files" },
    { "<space>fg",    ":Telescope live_grep<cr>",                     desc = "live grep" },
    { "<space>fs",    ":Telescope lsp_dynamic_workspace_symbols<cr>", desc = "workspace symbols" },
}, {
    { "<space>x",  group = "Trouble" },
    { "<space>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "toggle trouble" },
} })


-- set keymap on lsp attach
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        vim.api.nvim_buf_set_option(ev.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        wk.add({
            { "g",         group = "Go To" },
            { "gD",        '<cmd>lua vim.lsp.buf.declaration()<CR>',    desc = "goto declaration" },
            { "gd",        '<cmd>lua vim.lsp.buf.definition()<CR>',     desc = "go to definition" },
            { "gr",        '<cmd>lua vim.lsp.buf.references()<CR>',     desc = "go to reference" },
            { "gi",        '<cmd>lua vim.lsp.buf.implementation()<CR>', desc = "go to implementation" },
            { 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>',          desc = "hover" },
            { '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', desc = "signature help" },
            { '<F2>',      '<cmd>lua vim.lsp.buf.rename()<CR>',         desc = "rename symbol" },
            { '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',    desc = "code action" },
        }, { buffer = ev.buf })
    end,
})
local M = require("user.json_config")

if M.build.build then
    vim.api.nvim_set_keymap('n', '<F8>', ":!" .. M.build.build .. "<CR>", opts)
end

if M.build.generate then
    vim.api.nvim_set_keymap('n', '<C-F8>', ":!" .. M.build.generate .. '<CR>', opts)
end
