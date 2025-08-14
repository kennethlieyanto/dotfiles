return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        cs = { "csharpier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters = {
        csharpier = function()
          local useDotnet = not vim.fn.executable("csharpier")

          local command = useDotnet and "dotnet csharpier" or "csharpier"

          local version_out = vim.fn.system(command .. " --version")

          vim.notify(version_out)

          --NOTE: system command returns the command as the first line of the result, need to get the version number on the final line
          local version_result = version_out[#version_out]
          local major_version = tonumber((version_out or ""):match("^(%d+)")) or 0
          local is_new = major_version >= 1

          vim.notify(tostring(is_new))

          local args = is_new and { "format", "$FILENAME" } or { "--write-stdout" }

          return {
            command = command,
            args = args,
            stdin = not is_new,
            require_cwd = false,
          }
        end,
      },
    })
  end,
}
