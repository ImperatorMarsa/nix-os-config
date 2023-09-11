return {
    "neoclide/coc.nvim",
    lazy = false,
    branch = "release",
    config = function()
        -- Extensions need to be installed at first startup
        vim.g.coc_global_extensions = {
            "coc-css",
            "coc-html",
            "coc-json",
            "coc-phpls",
            "coc-snippets",
            "coc-sumneko-lua",
            "coc-tsserver",
            "coc-vimlsp",
        }

        -- Tweak insert mode completion
        --   noinsert: Do not insert text before accepting the completion
        --   menuone:  Use the popup menu even if there is only one match
        --   noselect: Do not select a match in the menu, force manual selection
        vim.o.completeopt = "noinsert,menuone,noselect"

        -- Snippet expand and additional edit feature of LSP requires confirm completion to work.
        vim.o.confirm = true

        -- Do not show in-completion-menu messages, e.g. 'match 1 of 2'
        vim.o.shortmess = vim.o.shortmess .. "c"

        -- Do not write "<PATH> <LINES>L, <BYTES>B written" messages when writing buffers
        vim.o.shortmess = vim.o.shortmess .. "W"

        -- Update sign column every quarter second
        vim.o.updatetime = 300

        -- Highlight symbol under cursor on CursorHold
        vim.api.nvim_create_autocmd(
            { "CursorHold" },
            {
                pattern = "*",
                callback = function()
                    vim.fn.CocActionAsync("highlight")
                end,
            }
        )
        -- :Format command
        vim.api.nvim_create_user_command(
            "Format",
            function()
                vim.fn.CocAction("format")
            end,
            {
                nargs = 0,
            }
        )
        -- :Fold command
        vim.api.nvim_create_user_command(
            "Fold",
            function(arg)
                vim.fn.CocAction("fold", arg.fargs)
            end,
            {
                nargs = "?",
            }
        )
        -- :OR command
        vim.api.nvim_create_user_command(
            "OR",
            function()
                vim.fn.CocAction("runCommand", "editor.action.organizeImport")
            end,
            {
                nargs = 0,
            }
        )

        -- coc-snippets
        -- Use tab for snippets and trigger completion with characters ahead and navigate.
        -- Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
        local function check_back_space()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s") ~= nil
        end
        local function autocomplete()
            if vim.fn["coc#pum#visible"]() then
                return vim.fn["coc#_select_confirm"]()
            elseif vim.fn["coc#expandableOrJumpable"]() then
                return vim.fn["coc#rpc#request"]("doKeymap", { "snippets-expand-jump", "" })
            elseif check_back_space() then
                return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
            else
                return vim.fn["coc#refresh"]()
            end
        end
        vim.api.nvim_create_user_command(
            "CocAutocomplete",
            autocomplete,
            {
                nargs = 0,
            }
        )
        vim.g.coc_snippet_next = "<tab>"

        -- Use K to show documentation in preview window
        function _G.show_docs()
            local cw = vim.fn.expand('<cword>')
            if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
                vim.api.nvim_command('h ' .. cw)
            elseif vim.api.nvim_eval('coc#rpc#ready()') then
                vim.fn.CocActionAsync('doHover')
            else
                vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
            end
        end
    end,
    keys = {
        -- Remap for format selected region
        {
            "<F3>",
            ":Format<CR>",
            desc = "Format selected region",
        },

        -- Navigate diagnostics
        {
            "[d",
            "<Plug>(coc-diagnostic-prev)",
            desc = "Goto prev diagnostic",
        },
        {
            "]d",
            "<Plug>(coc-diagnostic-next)",
            desc = "Goto next diagnostic",
        },

        -- GoTo code navigation
        {
            "gd",
            "<Plug>(coc-definition)",
            desc = "Goto definition",
        },
        {
            "gy",
            "<Plug>(coc-type-definition)",
            desc = "Goto type definition",
        },
        {
            "gi",
            "<Plug>(coc-implementation)",
            desc = "Goto implementation",
        },
        {
            "gr",
            "<Plug>(coc-references)",
            desc = "Goto references",
        },

        {
            "K",
            "<CMD>lua _G.show_docs()<CR>",
            desc = "Show documentation",
        },

        {
            "<CR>",
            [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
            desc = "Trigger snippets",
        },
        {
            "<C-j>",
            "<Plug>(coc-snippets-expand-jump)",
            desc = "Trigger snippets",
        },
        {
            "<C-space>",
            "coc#refresh()",
            desc = "Trigger completion",
            silent = true,
            expr = true,
        },
    }
}
