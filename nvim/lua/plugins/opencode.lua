return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        {
            ---@module "snacks"
            "folke/snacks.nvim",
            opts = {
                input = {

                    win = {
                        keys = {
                            i_tab = {
                                "<tab>",
                                function()
                                    local opencode = require("opencode")
                                    opencode.command("agent.cycle")
                                end,
                                mode = "i",
                            },
                            cx_n = {
                                "<C-x>n",
                                function()
                                    local opencode = require("opencode")
                                    opencode.command("session.new")
                                end,
                                mode = "i",
                            },
                            cx_l = {
                                "<C-x>l",
                                function()
                                    local opencode = require("opencode")
                                    opencode.command("session.list")

                                    -- Focus the opencode terminal window
                                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                                        local buf = vim.api.nvim_win_get_buf(win)
                                        if vim.bo[buf].buftype == "terminal" then
                                            vim.api.nvim_set_current_win(win)
                                            break
                                        end
                                    end
                                end,
                                mode = "i",
                            },
                        },
                    },
                },
                picker = {},
            },
        },
    },
    config = function()
        local opencode_cmd = 'opencode --port'
        ---@type snacks.terminal.Opts
        local snacks_terminal_opts = {
            win = {
                position = 'right',
                enter = false,
                width = 0.45,
                on_win = function(win)
                    -- Set up keymaps and cleanup for an arbitrary terminal
                    require('opencode.terminal').setup(win.win)
                end,
            },
        }

        ---@type opencode.Opts
        vim.g.opencode_opts = {
            server = {
                start = function()
                    require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
                end,
                stop = function()
                    require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts):close()
                end,
                toggle = function()
                    require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
                end,
            },
        }

        local opencode = require("opencode")

        vim.o.autoread = true

        vim.keymap.set({ "n", "x" }, "<leader>cc", function()
            local found = false
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "terminal" then
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
            if vim.bo.buftype == "terminal" then
                vim.cmd("wincmd h")
            end
        end)

        vim.keymap.set("t", "<C-k>", function()
            if vim.bo.buftype == "terminal" then
                opencode.toggle()
            end
        end)

        vim.keymap.set("n", "<c-tab>", function()
            opencode.command("agent.cycle")
        end)

        vim.keymap.set({ "n" }, "<leader>ar", function()
            local current_win = vim.api.nvim_get_current_win()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "terminal" then
                    opencode.command("session.list")
                    vim.api.nvim_set_current_win(win)
                    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "t", false)
                    -- return to original window after keys are processed
                    vim.schedule(function()
                        vim.api.nvim_set_current_win(current_win)
                    end)
                    break
                end
            end
        end, { desc = "Opencode refresh (visual bug)" })
    end,
}
