vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without dirtying current register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to plus register" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank plus register" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete to plus register" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "delete to plus register" })

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-q>", "<cmd>only<CR>")

vim.keymap.set("n", "<C-k>", function()
  if package.loaded["neo-tree"] then
    vim.cmd("Neotree close")
  end
end, { desc = "Hide sidebars and floating windows", noremap = true, silent = true })

vim.keymap.set("t", "<C-k>", function()
  if package.loaded["opencode"] then
    require("opencode").toggle()
  end
end)

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Stay in visual mode when shifting
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })

if vim.g.vscode then
  require("config.vscode-keymaps") -- if you created a separate file
  -- or just include the keymaps directly in this file
end
