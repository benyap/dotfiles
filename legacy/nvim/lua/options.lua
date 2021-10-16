local opt = vim.opt

-- SPACING AND INDENTATION
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.wrap = false
opt.linebreak = true

-- UI CONFIG
opt.termguicolors = true
opt.encoding = "utf8"
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.scrolloff = 8
opt.hlsearch = false
opt.incsearch = true

-- BACKUP/SWAP
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"
