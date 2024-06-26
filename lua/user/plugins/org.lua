return {
    {
        'nvim-orgmode/orgmode',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Load custom tree-sitter grammar for org filetype
            require('orgmode').setup({
                --org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
                --org_default_notes_file = '~/Dropbox/org/refile.org',
                org_hide_leading_stars = true,
                mappings = {
                    org = {
                        org_cycle = '<CR>',
                    }
                }
            })
        end
    }
}
