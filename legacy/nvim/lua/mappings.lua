local keymap = require "utils".keymap

-- Leader key
vim.g.mapleader = " "

-- Unbind default bindings for arrow keys
keymap("v", "<up>", "<nop>")
keymap("v", "<down>", "<nop>")
keymap("v", "<left>", "<nop>")
keymap("v", "<right>", "<nop>")
keymap("i", "<up>", "<nop>")
keymap("i", "<down>", "<nop>")
keymap("i", "<left>", "<nop>")
keymap("i", "<right>", "<nop>")

-- Quick switching from Insert mode to Normal mode
keymap("i", "jk", "<ESC>")

-- Terminal
keymap("n", "<leader>tt", "<cmd>terminal<CR>")
keymap("t", "<ESC>", [[<C-\><C-n>]])

-- File explorer
keymap("n", "<F3>", "<cmd>Np<CR>")

-- Buffers
keymap("n", "<leader>bl", [[<cmd>lua require('config.telescope').buffers()<CR>]])
keymap("n", "<C-l>", "<cmd>bnext<CR>") -- next buffer
keymap("n", "<C-h>", "<cmd>bprevious<CR>") -- previous buffer

-- Resize 
keymap("n", "<up>", "<cmd>resize +2<CR>")
keymap("n", "<down>", "<cmd>resize -2<CR>")
keymap("n", "<left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<right>", "<cmd>vertical resize +2<CR>")

-- TEXT --

-- Move a line of text Alt+[j/k]
keymap("n", "<M-j>", [[mz:m+<CR>`z]])
keymap("n", "<M-k>", [[mz:m-2<CR>`z]])
keymap("v", "<M-j>", [[:m'>+<CR>`<my`>mzgv`yo`z]])
keymap("v", "<M-k>", [[:m'<-2<CR>`>my`<mzgv`yo`z]])

-- Reload file
keymap("n", "<leader>r", "<cmd>edit!<CR>")

-- PLUGINS --

-- Telescope
keymap("n", "<leader>ff", "<cmd>lua require('config.telescope').search_files()<CR>")
keymap("n", "<leader>fg", "<cmd>lua require('config.telescope').live_grep()<CR>")
keymap("n", "<leader>fl", "<cmd>lua require('config.telescope').file_browser()<CR>")
keymap("n", "<C-f>", "<cmd>lua require('config.telescope').search_current_buffer()<CR>")
keymap("n", "<leader>fd", "<cmd>lua require('config.telescope').search_dotfiles()<CR>")
keymap("n", "<leader>fn", "<cmd>lua require('config.telescope').search_nvim()<CR>")

-- Nvim Tree
keymap("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")
