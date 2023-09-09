return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
    keys = {
        {
            "<leader>er",
            "<cmd> NvimTreeRefresh <CR>",
            desc = "Refresh nvimtree",
        },
        {
            "<leader>ef",
            "<cmd> NvimTreeFocus <CR>",
            desc = "Focus nvimtree",
        },
        {
            "<leader>e",
            "<cmd> NvimTreeFindFileToggle <CR>",
            desc = "Open nvimtree",
        },
    },
}
