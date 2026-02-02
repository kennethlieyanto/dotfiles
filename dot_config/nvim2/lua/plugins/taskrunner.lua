return {
  'stevearc/overseer.nvim',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  keys = {
    { "<leader>wr", "<cmd>OverseerToggle<cr>" },
    { "<leader>r",  "<cmd>OverseerRun<cr>" },
  },
}
