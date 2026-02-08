return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")

			-- Core
			vim.keymap.set("n", "<C-p>", "<CMD>lua require'config.telescope-config'.project_files()<CR>")
			vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols)
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles)

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true })
			end)

			-- VIM specific
			vim.keymap.set("n", "<leader>fc", function()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end)
			vim.keymap.set("n", "<leader>fH", builtin.help_tags)
			vim.keymap.set("n", "<leader>fC", builtin.commands)
			vim.keymap.set("n", "<leader>fK", builtin.keymaps)
		end,
	},
}
