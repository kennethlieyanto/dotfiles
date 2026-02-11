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
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-vstest"),
                },
            })
        end,
        keys = {
            { "<leader>wt", "<cmd>Neotest summary<cr>", desc = "Neotest summary" },
            {
                "<leader>tr",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "Neotest summary"
            },
            {
                "<leader>tR",
                function()
                    require("neotest").run.run(vim.loop.cwd())
                end,
                desc = "Neotest summary"
            },
        },
    },
}
