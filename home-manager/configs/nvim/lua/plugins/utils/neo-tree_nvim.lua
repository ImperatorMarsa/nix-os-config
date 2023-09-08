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
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("neo-tree")
            end
        end
    end,
    opts = {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        window = { mappings = { ["<space>"] = "none" } },
        default_component_configs = {
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
        },
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)
        vim.api.nvim_create_autocmd("TermClose", {
            pattern = "*lazygit",
            callback = function()
                if package.loaded["neo-tree.sources.git_status"] then
                    require("neo-tree.sources.git_status").refresh()
                end
            end,
        })
    end,
}
