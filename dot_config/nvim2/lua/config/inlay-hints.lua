local M = {}

vim.g.inlay_hints_manually_disabled = false

function M.toggle()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	local new_state = not enabled

	vim.lsp.inlay_hint.enable(new_state, { bufnr = 0 })
	vim.g.inlay_hints_manually_disabled = not new_state
end

function M.setup()
	local inlay_hint_group = vim.api.nvim_create_augroup("InlayHintsModeControl", { clear = true })

	vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
		group = inlay_hint_group,
		callback = function()
			if vim.g.inlay_hints_manually_disabled then
				return
			end
			vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
		end,
	})

	vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave", "ModeChanged" }, {
		group = inlay_hint_group,
		callback = function()
			if vim.g.inlay_hints_manually_disabled then
				return
			end

			local mode = vim.fn.mode()
			if mode == "n" or mode == "v" or mode == "V" or mode == "s" or mode == "S" then
				vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
			end
		end,
	})
end

return M
