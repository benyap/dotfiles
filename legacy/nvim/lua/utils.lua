local M = {}
local DEFAULT_OPTS = { noremap = true, silent = true }

-- Global key map
M.keymap = function(mode, lhs, rhs, opts)
  local has_opts = opts ~= nil and not vim.tbl_isempty(opts)
  if has_opts then
    vim.api.nvim_set_keymap(mode, lhs, rhs, vim.tbl_extend("force", DEFAULT_OPTS, opts))
  else
    vim.api.nvim_set_keymap(mode, lhs, rhs, DEFAULT_OPTS)
  end
end

return M
