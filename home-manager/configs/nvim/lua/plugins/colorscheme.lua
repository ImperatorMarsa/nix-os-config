return {
    -- add dracula
    { "dracula/vim" },

    -- Configure LazyVim to load "dracula"
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "dracula",
        },
    },
}
