return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            transparent_background = true,
        },
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
        enabled = false
    },
    {
        "Shatur/neovim-ayu",
        priority = 1000,
        opts = {
            overrides = {
                Normal = { bg = "None" },
                NormalFloat = { bg = "none" },
                ColorColumn = { bg = "None" },
                SignColumn = { bg = "None" },
                Folded = { bg = "None" },
                FoldColumn = { bg = "None" },
                CursorLine = { bg = "None" },
                CursorColumn = { bg = "None" },
                VertSplit = { bg = "None" },
            }
        },
        config = function()
            vim.cmd.colorscheme("ayu")
        end,
    }
}
