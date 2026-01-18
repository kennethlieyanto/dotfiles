---@type LazySpec
return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local dotnet = require("easy-dotnet")
		dotnet.setup({
			test_runner = {
				mappings = {
					go_to_file = { lhs = "g", desc = "go to file" },
					run_test_from_buffer = { lhs = "r", desc = "run test from buffer" },
					run = { lhs = "r", desc = "run test" },
					run_all = { lhs = "R", desc = "run all tests" },
					filter_failed_tests = { lhs = "e", desc = "filter failed tests" },
					peek_stacktrace = { lhs = "<CR>", desc = "peek stacktrace of failed test" },
					expand = { lhs = "l", desc = "expand" },
					expand_all = { lhs = "L", desc = "expand all" },
					collapse_all = { lhs = "H", desc = "collapse all" },
					close = { lhs = "q", desc = "close testrunner" },
					refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
				},
			},
		})

		vim.keymap.set("n", "<leader>wt", function()
			dotnet.testrunner()
		end)
	end,
	cond = not vim.g.vscode,
}
