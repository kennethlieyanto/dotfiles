return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader><space>", builtin.find_files)
			vim.keymap.set("n", "<C-p>", builtin.find_files)
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true })
			end)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
			vim.keymap.set("n", "<leader>fC", builtin.commands)
			vim.keymap.set("n", "<leader>fc", function()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end)
			vim.keymap.set("n", "<leader>fg", function()
				builtin.git_files({ show_untracked = true })
			end)
			vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps)
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols)
			vim.keymap.set("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols)
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
		end,
	},
}
