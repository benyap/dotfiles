return {
  -- Set the theme
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  -- Disable inlay hints by default
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
  },
  -- Use prettier for formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
    },
  },
  -- Customise the dashboard screen
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      picker = {
        hidden = true,
        ignored = true,
        exclude = {
          "**/.git",
          "**/.git/*",
          "**/node_modules/*",
          "**/.turbo/*",
          "**/.next/*",
        },
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = {
              "**/.git",
              "**/.git/*",
              "**/node_modules/*",
              "**/.turbo/*",
              "**/.next/*",
            },
          },
        },
      },
    },
  },
}
