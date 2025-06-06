return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')

      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader><space>', builtin.find_files, { nowait = true })
      vim.keymap.set('n', '<leader>ff', builtin.find_files)
      vim.keymap.set('n', '<leader>fh', builtin.help_tags)
      -- vim.keymap.set('n', '<C-p>', builtin.find_files)
      vim.keymap.set('n', '<leader>fc', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
      vim.keymap.set('n', '<C-p>', function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
    end
  }
}
