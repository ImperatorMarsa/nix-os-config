return {
    {
        "mfussenegger/nvim-dap",
        config = function(_, _)
            local dap = require("dap")
            local os_name = vim.loop.os_uname().sysname

            local meson_path
            if os_name == "Windows" or os_name == "Windows_NT" then
                meson_path = "~/AppData/Local/nvim-data/mason"
            elseif os_name == "Linux" then
                meson_path = "~/.local/share/nvim/mason"
            else
                meson_path = "other"
            end

            print(meson_path)

            dap.adapters.php = {
                type = "executable",
                command = "node",
                args = {
                    meson_path .. "/packages/php-debug-adapter/extension/out/phpDebug.js",
                },
            }
            dap.configurations.php = {
                {
                    name = "Listen for XDebug",
                    type = "php",
                    request = "launch",
                    port = 9000,
                },
                {
                    name = "Launch currently open script",
                    type = "php",
                    request = "launch",
                    program = "${file}",
                    cwd = "${fileDirname}",
                    port = 9000,
                },
                -- {
                --     type = "php",
                --     request = "launch",
                --     name = "Listen for Xdebug",
                --     port = 9000,
                --     pathMappings = {
                --         ["/var/www/html"] = "${workspaceFolder}",
                --     },
                -- },
            }
        end,
    },
    -- { "rcarriga/nvim-dap-ui" },
    -- { "theHamsta/nvim-dap-virtual-text" },
    -- { "nvim-telescope/telescope-dap.nvim" },
}
