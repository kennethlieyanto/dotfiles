return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "rust_analyzer", "csharpier", "omnisharp", "prettier", "rust_analyzer", "tailwindcss", "ts_ls", "yamlls" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      -- vim.keymap.set("n", "K", function()
      --   vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
      -- end, { desc = "Show diagnostics under cursor" })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>wQ",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>wq",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      -- {
      --   "<leader>cs",
      --   "<cmd>Trouble symbols toggle focus=false<cr>",
      --   desc = "Symbols (Trouble)",
      -- },
      -- {
      --   "<leader>cl",
      --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      --   desc = "LSP Definitions / references / ... (Trouble)",
      -- },
      -- {
      --   "<leader>xL",
      --   "<cmd>Trouble loclist toggle<cr>",
      --   desc = "Location List (Trouble)",
      -- },
      {
        "<leader>wf",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
