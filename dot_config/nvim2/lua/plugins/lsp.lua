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
    config = function()
      local lspconfig = require("lspconfig")

      -- Extend default client capabilities
      lspconfig.util.default_config = vim.tbl_extend(
        "force",
        lspconfig.util.default_config,
        {
          capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            require("lsp-file-operations").default_capabilities()
          ),
        }
      )

      -- Example: configure a language server
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "rust_analyzer", "rust_analyzer", "tailwindcss", "ts_ls", "yamlls" },
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
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Uncomment whichever supported plugin(s) you use
      -- "nvim-tree/nvim-tree.lua",
      -- "nvim-neo-tree/neo-tree.nvim",
      -- "simonmclean/triptych.nvim"
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
