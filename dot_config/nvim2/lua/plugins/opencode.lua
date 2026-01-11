return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		{ "folke/snacks.nvim", opts = {
			input = {},
			picker = {},
			terminal = {},
		} },
	},
	config = function()
		local opencode = require("opencode")

		---@type opencode.Opts
		vim.g.opencode_opts = {}
		vim.o.autoread = true

		vim.keymap.set({ "n", "x" }, "<leader>cc", function()
			local target_filetype = "opencode_terminal"

			local found = false
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].filetype == target_filetype then
					found = true
					break
				end
			end

			if not found then
				opencode.toggle()
			end
			opencode.ask("@this: ", { submit = true })
		end, { desc = "Ask opencode" })

		vim.keymap.set({ "n", "x" }, "<leader>ca", function()
			opencode.select()
		end, { desc = "Execute opencode action…" })

		vim.keymap.set({ "n", "t" }, "<leader>wc", function()
			opencode.toggle()
		end, { desc = "Toggle opencode" })

		vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
		vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })

		vim.keymap.set("t", "<C-c>", function()
			if vim.bo.filetype == "opencode_terminal" then
				vim.cmd("wincmd h")
			end
		end)

		vim.keymap.set("t", "<C-k>", function()
			if vim.bo.filetype == "opencode_terminal" then
				opencode.toggle()
			end
		end)
	end,
}
