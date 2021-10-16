-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua

local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/plugged")
  -- Telescope
  Plug("nvim-lua/plenary.nvim")
  Plug("nvim-telescope/telescope.nvim")
  Plug("nvim-telescope/telescope-fzy-native.nvim")
  Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})

  -- File tree
  Plug("kyazdani42/nvim-tree.lua")

  -- Theme
  Plug("navarasu/onedark.nvim")
  Plug("kyazdani42/nvim-web-devicons")
  Plug("hoob3rt/lualine.nvim")
vim.call("plug#end")

-- Plugin setup

require("config/onedark")
require("config/lualine")
require("config/telescope")
require("config/treesitter")
require("config/tree")
