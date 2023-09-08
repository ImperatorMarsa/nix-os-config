return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        vim.opt.list = true
        vim.opt.listchars:append "space:•"

        vim.opt.termguicolors = true
        vim.cmd [[highlight IndentBlanklineIndent1 guibg=#2d2f3d gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent2 guibg=#282a36 gui=nocombine]]
        vim.cmd [[highlight IndentBlanklineIndent3 guibg=#22242e gui=nocombine]]

        require("indent_blankline").setup({
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
}
