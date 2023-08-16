require('nvim-treesitter.configs').setup {
    sync_installed = true,
    ensure_installed = {
        'vim',
        'vimdoc',
        'lua',
        'php',
        'javascript',
        'css',
        'html',
        'nix',
        'sql',
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
