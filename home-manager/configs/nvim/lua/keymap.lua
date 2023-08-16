local opts = { noremap = true, silent = true }
local expr = { noremap = true, silent = true, expr = true }


function KeyMap(mode, lhs, rhs, Opts)
    vim.keymap.set(mode, lhs, rhs, Opts)
end

-- Coping file header\path
KeyMap("n", "<leader>hr", ":let @+ = expand('%')<CR>", { desc = "Copy relative path for current buffer" })
KeyMap("n", "<leader>hf", ":let @+ = expand('%:p')<CR>", { desc = "Copy full path for current buffer" })
KeyMap("n", "<leader>hn", ":let @+ = expand('%:t')<CR>", { desc = "Copy just filename for current buffer" })

-- general mapping
KeyMap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better up/down
KeyMap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
KeyMap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
KeyMap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
KeyMap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
KeyMap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
KeyMap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Move Lines
KeyMap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
KeyMap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
KeyMap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
KeyMap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
KeyMap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
KeyMap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

-- Modify j and k when a line is wrapped. Jump to next VISUAL line
KeyMap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr)
KeyMap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr)

-- Copy/Cut/Paste into the system clipboard
KeyMap('n', '<A-P>', '"+P')
KeyMap('n', '<A-p>', '"+p')
KeyMap('n', '<A-x>', '"+x')
KeyMap('n', '<A-y>', '"+y')
KeyMap('v', '<A-P>', '"+P')
KeyMap('v', '<A-p>', '"+p')
KeyMap('v', '<A-x>', '"+x')
KeyMap('v', '<A-y>', '"+y')

-- telescope general
local builtin = require('telescope.builtin')
KeyMap(
    'n',
    '<leader>ff',
    function()
        builtin.find_files(
            require('telescope.themes').get_ivy({ winblend = 10 })
        )
    end,
    {}
)
KeyMap('n', '<leader>fg', builtin.live_grep, {})
KeyMap('n', '<leader>fb', builtin.buffers, {})
KeyMap('n', '<leader>fh', builtin.help_tags, {})
KeyMap('n', '<leader>fj', builtin.jumplist, {})
KeyMap(
    'n',
    '<leader>fS',
    function()
        builtin.spell_suggest(
            require('telescope.themes').get_cursor()
        )
    end,
    {}
)

-- Don't jump when using *
KeyMap("n", "*", "*<C-o>", opts)

-- Keep search matches in the middle of the window
KeyMap("n", "n", "nzzzv", opts)
KeyMap("n", "N", "Nzzzv", opts)
