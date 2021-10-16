local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
  highlight = { enable = true },
  refactor = {
    highlight_definitions = { enable = true }
  },
  ensure_installed = "maintained"
}
