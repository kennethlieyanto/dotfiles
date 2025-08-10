return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufWritePre" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters = {},
    })
  end,
}
