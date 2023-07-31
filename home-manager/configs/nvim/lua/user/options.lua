O = vim.opt

O.backup = true                            -- creates a backup file
O.cmdheight = 1                            -- more space in the neovim command line for displaying messages
O.completeopt = { "menuone", "noselect" }  -- mostly just for cmp
O.conceallevel = 0                         -- so that `` is visible in markdown files
O.fileencoding = "utf-8"                   -- the encoding written to a file
O.hlsearch = true                          -- highlight all matches on previous search pattern
O.ignorecase = true                        -- ignore case in search patterns
O.mouse = "a"                              -- allow the mouse to be used in neovim
O.pumheight = 10                           -- pop up menu height
O.showmode = true                          -- we don't need to see things like -- INSERT -- anymore
O.showtabline = 4                          -- always show tabs
O.smartcase = true                         -- smart case
O.smartindent = true                       -- make indenting smarter again
O.splitbelow = true                        -- force all horizontal splits to go below current window
O.splitright = true                        -- force all vertical splits to go to the right of current window
O.swapfile = false                         -- creates a swapfile
O.termguicolors = true                     -- set term gui colors (most terminals support this)
O.timeoutlen = 1000                        -- time to wait for a mapped sequence to complete (in milliseconds)
O.undofile = true                          -- enable persistent undo
O.updatetime = 300                         -- faster completion (4000ms default)
O.writebackup = false                      -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
O.cursorline = true                        -- highlight the current line
O.number = true                            -- set numbered lines
O.relativenumber = false                   -- set relative numbered lines
O.numberwidth = 4                          -- set number column width to 2 {default 4}
O.signcolumn = "yes"                       -- always show the sign column, otherwise it would shift the text each time
O.wrap = false                             -- display lines as one long line
O.smartindent = true                       -- display lines as one long line
O.scrolloff = 8                            -- is one of my fav
O.sidescrolloff = 8
O.guifont = "JetBrains Nerd Font Mono:h17" -- the font used in graphical neovim applications
O.spell         = true
O.spellcapcheck = ''
O.spelllang     = 'ru_ru,en_us,cjk'
O.spelloptions  = 'camel'
O.spellsuggest  = 'best,9'
O.colorcolumn   = '100'
O.complete:append('kspell')

O.shortmess:append "c"


vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

-- ### Set `tab` = 4 spaces ###
O.tabstop = 4      -- insert 2 spaces for a tab
O.shiftwidth = 4   -- the number of spaces inserted for each indentation
O.expandtab = true -- convert tabs to spaces

-- # --
-- # setup plugins --
-- # --
-- ### lualine --
local status_ok, lualine = pcall(require, "lualine")
if status_ok then
    lualine.setup {
        options = {
            icons_enabled = true,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
        }
    }
end

-- ### telescope --
local status_ok, telescope = pcall(require, "telescope")
if status_ok then
    telescope.setup()
end

-- ### gitsigns --
local status_ok, gitsigns = pcall(require, "gitsigns")
if status_ok then
    gitsigns.setup()
end

-- ### Comment --
local status_ok, Comment = pcall(require, "Comment")
if status_ok then
    Comment.setup()
end

-- ### LSP --
local status_ok, lspzero = pcall(require, "lsp-zero")
if status_ok then
    local lsp = lspzero.preset({})

    lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({ buffer = bufnr })
    end)

    -- (Optional) Configure lua language server for neovim
    local status_ok, lspconfig = pcall(require, "lspconfig")
    if status_ok then
        lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
    end

    lsp.setup()
end

-- ### tree-sitter --
local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if status_ok then
    treesitter.setup {
        prefer_git = false,
        compilers = { "clang" },

        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
            "css",
            "lua",
            "php",
            "sql",
            "html",
            "query",
            "vimdoc",
            "javascript",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
end

-- # --
-- # colorscheme --
-- # --
vim.cmd('colorscheme dracula')
