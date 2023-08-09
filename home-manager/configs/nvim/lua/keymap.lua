-- telescope general
local builtin = require('telescope.builtin')
vim.keymap.set(
    'n',
    '<leader>ff',
    function()
        builtin.find_files(
            require('telescope.themes').get_ivy({ winblend = 10 })
        )
    end,
    {}
)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fS', builtin.spell_suggest, {})
