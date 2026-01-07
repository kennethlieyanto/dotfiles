return {
  on_attach = function(_, bufnr)
    print("rust_analyzer attached! bufnr" .. bufnr)
    -- Inlay hints are now controlled by autocmds based on mode
    if vim.fn.mode() == "n" then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
}
