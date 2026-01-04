return {
  on_attach = function(_, bufnr)
    print("rust_analyzer attached! bufnr" .. bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
}
