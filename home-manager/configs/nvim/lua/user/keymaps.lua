local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>ca", ":w|%bd|e#|bd#<CR>", opts)

keymap("n", "<leader>e", ":Lex 30<CR>", opts)

keymap("n", "<esc><esc>", ":noh<CR>", opts)

keymap("n", "<F11>", ":set spell!<CR>", opts)

-- Resize with arrows
keymap("n", "<A-k>", ":resize +2<CR>", opts)
keymap("n", "<A-j>", ":resize -2<CR>", opts)
keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- YY/XX Copy/Cut into the system clipboard
vim.cmd([[
    noremap YY "+y<CR>
    noremap XX "+x<CR>
]])

-- Visual --
-- Stay in indent mode
keymap("v", "<A-h>", "<gv", opts)
keymap("v", "<A-l>", ">gv", opts)

keymap("v", "<F8>", ":sort i<CR>", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- # --
-- # plugins --
-- # --
-- ### telescope --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fG', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})

-- ### gitsigns --
local gs = require('gitsigns')
-- Stage/reset individual hunks under cursor in a file
vim.keymap.set('n', '<leader>gs', gs.stage_hunk, {})
vim.keymap.set('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, {})
vim.keymap.set('n', '<leader>gr', gs.reset_hunk, {})
vim.keymap.set('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, {})
vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, {})

-- Stage/reset all hunks in a file
vim.keymap.set('n', '<leader>gS', gs.stage_buffer, {})
vim.keymap.set('n', '<leader>gR', gs.reset_buffer, {})
vim.keymap.set('n', '<leader>gU', gs.reset_buffer_index, {})

-- Jump between hunks
vim.keymap.set('n', '<leader>gn', gs.next_hunk, {})
vim.keymap.set('n', ']g', "&diff ? ']g' : ':Gitsigns next_hunk<CR>'", { noremap = true, silent = true, expr = true })
vim.keymap.set('n', '<leader>gp', gs.prev_hunk, {})
vim.keymap.set('n', '[g', "&diff ? '[g' : ':Gitsigns prev_hunk<CR>'", { noremap = true, silent = true, expr = true })

-- Popup what's changed in a hunk under cursor
vim.keymap.set('n', '<leader>gP', gs.preview_hunk, {})

-- Git blame
vim.keymap.set('n', '<leader>gb', function() gs.blame_line { full = true } end, {})
vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, {})

vim.keymap.set('n', '<leader>gd', gs.diffthis, {})
vim.keymap.set('n', '<leader>gD', function() gs.diffthis('~') end, {})
vim.keymap.set('n', '<leader>td', gs.toggle_deleted, {})

-- ### vim-fugitive --
-- Open git status in interative window (similar to lazygit)
keymap("n", "<Leader>gg", ":Git<CR>", opts)

-- Open commit window (creates commit after writing and saving commit msg)
keymap("n", "<Leader>gc", ":Git commit | startinsert<CR>", opts)

-- Other tools from fugitive
keymap("n", '<Leader>gfd', ':Git difftool<CR>', opts)
keymap("n", '<Leader>gm', ':Git mergetool<CR>', opts)
keymap("n", '<Leader>g|', ':Gvdiffsplit<CR>', opts)
keymap("n", '<Leader>g_', ':Gdiffsplit<CR>', opts)
