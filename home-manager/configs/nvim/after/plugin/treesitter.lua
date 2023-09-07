require('nvim-treesitter.configs').setup {
    sync_installed = true,
    ensure_installed = {
        'css',
        'html',
        'javascript',
        'lua',
        'nix',
        'php',
        'python',
        'sql',
        'vim',
        'vimdoc',
    },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}
