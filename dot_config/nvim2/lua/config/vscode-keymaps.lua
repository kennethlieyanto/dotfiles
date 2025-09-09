if not vim.g.vscode then
  return
end

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
vim.keymap.set(
  "n",
  "<leader>wx",
  "<Cmd>lua require('vscode').call('workbench.extensions.action.focusExtensionsView')<CR>"
)
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
vim.keymap.set("n", "<leader>/", "<Cmd>lua require('vscode').call('workbench.view.search')<CR>")
vim.keymap.set("n", "<leader><leader>", "<Cmd>lua require('vscode').call('workbench.action.quickOpen')<CR>")
vim.keymap.set("n", "gd", "<Cmd>lua require('vscode').call('editor.action.revealDefinition')<CR>")
vim.keymap.set("n", "<leader>fs", "<Cmd>lua require('vscode').call('workbench.action.gotoSymbol')<CR>")
vim.keymap.set("n", "<leader>fS", "<Cmd>lua require('vscode').call('workbench.action.showAllSymbols')<CR>")
vim.keymap.set("n", "gD", "<Cmd>lua require('vscode').call('editor.action.revealDefinitionAside')<CR>")
vim.keymap.set("i", "<C-s>", "<Cmd>lua require('vscode').call('editor.action.triggerParameterHints')<CR>")
