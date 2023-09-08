return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
    keys = {
        {
            "<leader>e",
            "<cmd> NvimTreeFindFileToggle <CR>",
            desc = "Focus nvimtree",
        },
    },
}
