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
        enabled = true
      }
    },
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  },
  keys = {
    {
      "<leader>we",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      remap = true
    },
    { "<leader>ws", "<cmd>Neotree document_symbols<cr>" },

  }
}
