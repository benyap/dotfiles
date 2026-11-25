return {
  "carderne/pi-nvim",
  lazy = true,
  cmd = { "Pi", "PiSend", "PiSendFile", "PiSendSelection", "PiSendBuffer", "PiPing", "PiSessions" },
  keys = {
    { "<leader>ap", ":Pi<CR>", desc = "Send to Pi", mode = { "n", "v" } },
  },
  opts = {
    set_default_keymaps = false,
  },
}
