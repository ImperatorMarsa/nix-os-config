return {
    --
    -- UI
    --
    -- Color Theme
    {
        "dracula/vim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme dracula")
        end
    },
    -- -- --

    -- Status bar
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("lualine").setup({
                options = {
                    theme = 'dracula',
                    icons_enabled = true,
                    section_separators = '',
                    component_separators = '⸽',
                },
            })
        end,
    },
    -- -- --
    --
    --
    --
}
