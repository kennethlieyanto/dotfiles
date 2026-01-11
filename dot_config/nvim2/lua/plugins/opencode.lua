return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	},
	config = function()
		vim.g.opencode_opts = {}
		vim.o.autoread = true

		vim.keymap.set({ "n", "x" }, "<leader>cc", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode" })
		vim.keymap.set({ "n", "x" }, "<leader>ca", function()
			require("opencode").select()
		end, { desc = "Execute opencode action…" })
		vim.keymap.set({ "n", "t" }, "<leader>wc", function()
			require("opencode").toggle()
			vim.cmd("wincmd l")
		end, { desc = "Toggle opencode" })

		vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
		vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
	end,
}
