-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup({
--       transparent_background = true,
--     })
--
--     vim.cmd.colorscheme("catppuccin")
--   end,
-- }

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    transparent_background = true,
  },
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
