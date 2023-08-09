return {
    --
    -- UI
    --
    -- Color Theme
    {
        "Mofiqul/dracula.nvim",
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
                    theme = 'dracula-nvim',
                    icons_enabled = true,
                    section_separators = '',
                    component_separators = '⸽',
                },
            })
        end,
    },

    -- Indent Hightlite
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append "space:•"

            vim.opt.termguicolors = true
            vim.cmd [[highlight IndentBlanklineIndent1 guibg=#2d2f3d gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guibg=#282a36 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent3 guibg=#22242e gui=nocombine]]

            require("indent_blankline").setup ({
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,

                char = "",
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                },
                space_char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                },
                show_trailing_blankline_indent = false,
            })
        end,
    },
    -- -- --
    --
    --

    --
    -- Utils
    --
    -- Nvim tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    -- -- --
    --
    --

    --
    -- Coding
    --
    -- Comnent
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },
}
