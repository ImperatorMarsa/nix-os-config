local os_name = vim.loop.os_uname().sysname
local fzf_native_make_comand = 'make'

if os_name == "Windows" or os_name == "Windows_NT" then
    fzf_native_make_comand =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
end

return {
    -- -- --

    -- Comment
    ,
    -- -- --
    --
    --
    --

    --
    -- Coding
    --
    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    'folke/neodev.nvim',
    -- -- --

    -- code completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-nvim-lsp',
        },
    },
    -- -- --

    -- Git integration
    -- -- --

    -- tree sitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    -- -- --

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = fzf_native_make_comand,
    },
    -- -- --
    --
    --
    --
}
