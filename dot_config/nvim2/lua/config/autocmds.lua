vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Enable inlay hints only in normal mode
local inlay_hint_group = vim.api.nvim_create_augroup("InlayHintsModeControl", { clear = true })

local function toggle_inlay_hints()
  local mode = vim.fn.mode()
  local enabled = mode == "n" or mode == "v" or mode == "V" or mode == "" or mode == "s" or mode == "S" or mode == ""

  vim.lsp.inlay_hint.enable(enabled, { bufnr = 0 })
end

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  group = inlay_hint_group,
  callback = function()
    vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave", "ModeChanged" }, {
  group = inlay_hint_group,
  callback = function()
    local mode = vim.fn.mode()
    if mode == "n" or mode == "v" or mode == "V" or mode == "" or mode == "s" or mode == "S" or mode == "" then
      vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
    end
  end,
})
