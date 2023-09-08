return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<leader>eb",
            function()
                require("neo-tree.command").execute({
                    toggle = true,
                    dir = vim.loop.cwd(),
                    reveal = true,
                    source = "buffers"
                }) end,
            desc = "Buffers NeoTree",
        },
        {
            "<leader>eg",
            function()
                require("neo-tree.command").execute({
                    toggle = true,
                    dir = vim.loop.cwd(),
                    reveal = true,
                    source = "git_status"
                }) end,
            desc = "GitStatus NeoTree",
        },
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({
                    toggle = true,
                    dir = vim.loop.cwd(), 
                    eveal = true
                })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
    },
}
