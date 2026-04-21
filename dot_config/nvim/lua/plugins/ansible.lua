return {
	{
		"mfussenegger/nvim-ansible",
		ft = { "yaml" },
		keys = {
			{
				"<leader>ta",
				function()
					require("ansible").run()
				end,
				ft = "yaml.ansible",
				desc = "Ansible Run Playbook/Role",
				silent = true,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ansiblels = {},
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "ansible-lint" } },
	},
}
