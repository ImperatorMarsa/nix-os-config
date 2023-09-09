local os_name = vim.loop.os_uname().sysname
local fzf_native_make_comand = 'make'

if os_name == "Windows" or os_name == "Windows_NT" then
    fzf_native_make_comand =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
end

return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = fzf_native_make_comand,
    },
    keys = {
        {
            "<leader>fS",
            function()
                require('telescope.builtin')
                .spell_suggest(
                    require('telescope.themes')
                    .get_cursor({ winblend = 10 })
                )
            end,
            desc = "Spell suggestions"
        },
        {
            "<leader>fk",
            function()
                require('telescope.builtin')
                .keymaps(
                    require('telescope.themes')
                    .get_ivy({ winblend = 10 })
                )
            end,
            desc = "Kay maps"
        },
        {
            "<leader>fG",
            function()
                require('telescope.builtin')
                .git_status(
                    require('telescope.themes')
                    .get_ivy({ winblend = 10 })
                )
            end,
            desc = "Git status"
        },
        {
            "<leader>fb",
            function()
                require('telescope.builtin')
                .buffers(
                    require('telescope.themes')
                    .get_ivy({ winblend = 10 })
                )
            end,
            desc = "Buffers"
        },
        {
            "<leader>fg",
            function()
                require('telescope.builtin')
                .live_grep(
                    require('telescope.themes')
                    .get_ivy({ winblend = 10 })
                )
            end,
            desc = "Grep (root dir)"
        },
        {
            "<leader>ff",
            function()
                require('telescope.builtin')
                .find_files(
                    require('telescope.themes')
                    .get_ivy({ winblend = 10 })
                )
            end,
            desc = "Find Files (root dir)"
        },
    },
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
        },
    },
    config = function(_, opts)
        require('telescope').setup({
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                                                    -- the default case_mode is "smart_case"
                }
            }
        })

        require('telescope').load_extension('fzf')
    end,
}
