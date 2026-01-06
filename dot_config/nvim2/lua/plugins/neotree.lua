return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	opts = {
		source_selector = {
			winbar = true,
			statusline = true,
		},
		filesystem = {
			filtered_items = {
				visible = true,
			},
			follow_current_file = {
				enabled = true,
			},
		},
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["H"] = "close_all_nodes",
				["v"] = "open_vsplit",
				["."] = "toggle_hidden",
				["O"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						if node.type == "directory" then
							vim.cmd("Oil " .. path)
						else
							vim.cmd("Oil " .. vim.fn.fnamemodify(path, ":h"))
						end
					end,
					desc = "Open in Oil",
				},
				["w"] = "null",
				["s"] = "null",
				["<C-q>"] = {
					function(state)
						local node = state.tree:get_node()
						if node.type ~= "directory" then
							vim.cmd("caddfile " .. vim.fn.fnameescape(node:get_id()))
						end
					end,
					desc = "Add file to quickfix",
				},
				["S"] = "null",
				["/"] = "filter_on_submit",
				["z"] = "fuzzy_finder",
			},
		},
	},
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
