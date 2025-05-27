return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<leader><space>', builtin.find_files, { nowait = true })
    vim.keymap.set('n', '<leader>ff', builtin.find_files)
    vim.keymap.set('n', '<C-p>', builtin.find_files)
  end
}
