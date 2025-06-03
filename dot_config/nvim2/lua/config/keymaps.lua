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

if vim.g.vscode then
	vim.keymap.set("n", "<leader>`", "<Cmd>lua require('vscode').call('vscode-harpoon.addEditor')<CR>")
	vim.keymap.set("n", "<leader>1", "<Cmd>lua require('vscode').call('vscode-harpoon.gotoEditor1')<CR>")
	vim.keymap.set("n", "<leader>2", "<Cmd>lua require('vscode').call('vscode-harpoon.gotoEditor2')<CR>")
	vim.keymap.set("n", "<leader>3", "<Cmd>lua require('vscode').call('vscode-harpoon.gotoEditor3')<CR>")
	vim.keymap.set("n", "<leader>4", "<Cmd>lua require('vscode').call('vscode-harpoon.gotoEditor4')<CR>")
	vim.keymap.set("n", "<leader>5", "<Cmd>lua require('vscode').call('vscode-harpoon.gotoEditor5')<CR>")
	vim.keymap.set("n", "<leader>hh", "<Cmd>lua require('vscode').call('vscode-harpoon.editEditors')<CR>")
	vim.keymap.set("n", "<leader>we", "<Cmd>lua require('vscode').call('workbench.view.explorer')<CR>")
	vim.keymap.set("n", "<leader>ws", "<Cmd>lua require('vscode').call('outline.focus')<CR>")
	vim.keymap.set("n", "<leader>wt", "<Cmd>lua require('vscode').call('workbench.view.testing.focus')<CR>")
	vim.keymap.set("n", "<leader>wx",
		"<Cmd>lua require('vscode').call('workbench.extensions.action.focusExtensionsView')<CR>")
	vim.keymap.set("n", "<leader>wq", "<Cmd>lua require('vscode').call('workbench.panel.markers.view.focus')<CR>")
	vim.keymap.set("n", "<leader>ta", "<Cmd>lua require('vscode').call('testing.runAll')<CR>")
	vim.keymap.set("n", "<leader>tf", "<Cmd>lua require('vscode').call('testing.reRunFailTests')<CR>")
	vim.keymap.set("n", "<leader>tr", "<Cmd>lua require('vscode').call('testing.runAtCursor')<CR>")
	vim.keymap.set("n", "]q", "<Cmd>lua require('vscode').call('editor.action.marker.next')<CR>")
	vim.keymap.set("n", "[q", "<Cmd>lua require('vscode').call('editor.action.marker.next')<CR>")
	vim.keymap.set("n", "<leader>ss", "<Cmd>lua require('vscode').call('workbench.action.showAllSymbols')<CR>")
	vim.keymap.set("n", "<leader>F", "<Cmd>lua require('vscode').call('workbench.action.toggleZenMode')<CR>")
	vim.keymap.set("n", "<leader>llm", "<Cmd>lua require('vscode').call('composer.newAgentChat')<CR>")
	vim.keymap.set("n", "gra", "<Cmd>lua require('vscode').call('editor.action.quickFix')<CR>")
	vim.keymap.set("n", "<leader>ar", "<Cmd>lua require('vscode').call('flutter.runProfileMode')<CR>")
else
end
