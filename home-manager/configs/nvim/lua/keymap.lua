function KeyMap(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Coping file headr\path
KeyMap("n", "<leader>hr", ":let @+ = expand('%')<CR>", { desc = "Copy relative path for current buffer" })
KeyMap("n", "<leader>hf", ":let @+ = expand('%:p')<CR>", { desc = "Copy full path for current buffer" })
KeyMap("n", "<leader>hn", ":let @+ = expand('%:t')<CR>", { desc = "Copy just filename for current buffer" })

-- general maping
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

if vim.g.neovide then
    KeyMap('n', '<C-s>', ':w<CR>') -- Save
    KeyMap('v', '<C-c>', '"+y') -- Copy
    KeyMap('n', '<C-v>', '"+P') -- Paste normal mode
    KeyMap('v', '<C-v>', '"+P') -- Paste visual mode
    KeyMap('c', '<C-v>', '<C-R>+') -- Paste command mode
    KeyMap('i', '<C-v>', '<ESC>l"+Pli') -- Paste insert mode
end

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
