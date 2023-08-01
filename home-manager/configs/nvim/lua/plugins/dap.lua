return {
    {
        "mfussenegger/nvim-dap",
        config = function(_, _)
            local dap = require("dap")
            local home = os.getenv("HOME")
            local os_name = vim.loop.os_uname().sysname

            local meson_path
            if os_name == "Windows" then
                meson_path = home .. "/AppData/Local/nvim-data/mason"
            elseif os_name == "Linux" then
                meson_path = home .. "/.local/share/nvim/mason"
            else
                meson_path = "other"
            end

            dap.adapters.php = {
                type = "executable",
                command = "node",
                args = {
                    meson_path .. "/packages/php-debug-adapter/extension/out/phpDebug.js",
                },
            }
            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9000,
                    pathMappings = {
                        ["/var/www/html"] = "${workspaceFolder}",
                    },
                },
            }
        end,
    },
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },
}
