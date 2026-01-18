---@type LazySpec
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@module 'snacks'
	---@type snacks.Config
	opts = {
		indent = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		input = {
			win = {
				keys = {
					i_ctrl_c = { "<C-c>", "cancel", mode = "i" },
					n_ctrl_c = { "<C-c>", "cancel", mode = "n" },
				},
			},
		},
	},
}
