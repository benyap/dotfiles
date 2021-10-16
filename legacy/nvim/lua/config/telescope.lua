local telescope = require("telescope")
local builtins = require("telescope.builtin")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

telescope.setup {
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,

    file_ignore_patterns = {
      ".git/",
      "node_modules/",
      "yarn.lock",
      "package-lock.json"
    }
  },

  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

telescope.load_extension("fzy_native")

-- Custom functions

local M = {}

M.search_files = function()
  builtins.find_files {
    find_command = { "rg", "--files", "--hidden" },
  }
end

M.live_grep = function()
  builtins.live_grep {}
end

M.file_browser = function()
  builtins.file_browser {}
end

M.buffers= function()
  builtins.buffers {}
end

M.search_current_buffer = function()
  builtins.current_buffer_fuzzy_find {}
end

M.search_nvim = function()
  local directory = vim.env.HOME .. "/.config/nvim"
  builtins.find_files {
    find_command = { "rg", "--files", "--hidden", directory },
  }
end

M.search_dotfiles = function()
  local directory = vim.env.HOME .. "/.dotfiles"
  builtins.find_files {
    find_command = { "rg", "--files", "--hidden", directory },
  }
end


return M
