---@type LazySpec
return {
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod",                     lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
        keys = {
            { "<Leader>db", "<cmd>DBUIToggle<cr>", desc = "Open Dadbod UI" },
            {
                "<leader>fq",
                function()
                    local pickers = require("telescope.pickers")
                    local finders = require("telescope.finders")
                    local conf = require("telescope.config").values
                    local actions = require("telescope.actions")
                    local action_state = require("telescope.actions.state")

                    local query_dir = vim.g.db_ui_save_location

                    pickers.new({}, {
                        prompt_title = "Dadbod Saved Queries",
                        finder = finders.new_oneshot_job(
                            { "rg", "--files", "--glob", "!connections.json" },
                            { cwd = query_dir }
                        ),
                        sorter = conf.generic_sorter({}),
                    }):find()
                end,
                desc = "Dadbod saved queries",
            },
        },
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    sql = { "snippets", "dadbod", "buffer" },
                    mysql = { "snippets", "dadbod", "buffer" },
                },
                -- add vim-dadbod-completion to your completion providers
                providers = {
                    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                },
            },
        },
    },
}
