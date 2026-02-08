return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nsidorenco/neotest-vstest",
		},
		opts = {
			adapters = {
				require("neotest-vstest"),
			},
		},
		keys = {
			{ "<leader>wt", "<cmd>Neotest summary<cr>", desc = "Neotest summary" },
		},
	},
}
