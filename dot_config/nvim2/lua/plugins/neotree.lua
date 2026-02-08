return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			source_selector = {
				winbar = true,
				statusline = true,
				truncation_character = "...",
			},
			filesystem = {
				filtered_items = {
					visible = true,
				},
				follow_current_file = {
					enabled = true,
				},
			},
			sources = { "filesystem" },
			window = {
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["H"] = "close_all_nodes",
					["v"] = "open_vsplit",
					["."] = "toggle_hidden",
					["O"] = function(state)
						---@diagnostic disable-next-line: undefined-field
						local node = state.tree:get_node()
						local path = node:get_id()
						if node.type == "directory" then
							vim.cmd("Oil " .. path)
						else
							vim.cmd("Oil " .. vim.fn.fnamemodify(path, ":h"))
						end
					end,
					["<C-q>"] = function(state)
						---@diagnostic disable-next-line: undefined-field
						local node = state.tree:get_node()
						if node.type ~= "directory" then
							vim.cmd("caddfile " .. vim.fn.fnameescape(node:get_id()))
						end
					end,
					["/"] = "filter_on_submit",
					["z"] = "fuzzy_finder",
					["<C-c>"] = "clear_filter",
				},
			},
		})

		-- Close popup on escape/ctrl-c in normal mode
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "neo-tree-popup",
			callback = function(args)
				vim.keymap.set("i", "<Esc>", function()
					vim.api.nvim_win_close(0, true)
				end, { buffer = args.buf, nowait = true })

				vim.keymap.set("i", "<C-c>", function()
					vim.api.nvim_win_close(0, true)
				end, { buffer = args.buf, nowait = true })
			end,
		})
	end,
	keys = {
		{
			"<leader>we",
			function()
				require("neo-tree.command").execute({ toggle = true })
			end,
			remap = true,
		},
		{ "<leader>ws", "<cmd>Neotree document_symbols<cr>" },
	},
	enabled = true,
}
