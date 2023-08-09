function KeyMap(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- telescope general
local builtin = require('telescope.builtin')
KeyMap(
    'n',
    '<leader>ff',
    function()
        builtin.find_files(
            require('telescope.themes').get_ivy({ winblend = 10 })
        )
    end,
    {}
)
KeyMap('n', '<leader>fg', builtin.live_grep, {})
KeyMap('n', '<leader>fb', builtin.buffers, {})
KeyMap('n', '<leader>fh', builtin.help_tags, {})
KeyMap('n', '<leader>fj', builtin.jumplist, {})
KeyMap('n', '<leader>fS', builtin.spell_suggest, {})
