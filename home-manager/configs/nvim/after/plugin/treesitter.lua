require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'vim',
        'vimdoc',
        'lua',
        'php',
        'javascript',
        'css',
        'html',
        'sql',
    },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
}
