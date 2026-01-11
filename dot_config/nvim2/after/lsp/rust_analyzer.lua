return {
	on_attach = function(_, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
}
