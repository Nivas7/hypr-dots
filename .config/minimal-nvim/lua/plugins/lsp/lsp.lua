
-- language servers
	-- see config examples: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

			require"mason".setup{}
			require"mason-lspconfig".setup{
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"ts_ls",
					"eslint",
					"zls",
					"clangd",
				},
			}

			local lspconf = require"lspconfig"
			lspconf.lua_ls.setup{}
			lspconf.rust_analyzer.setup{}
			lspconf.ts_ls.setup{}
			lspconf.eslint.setup{
				on_attach = function(_, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			}
			lspconf.zls.setup{}
			lspconf.clangd.setup{}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		-- enable completion when available
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
-- see `:h completeopt`
vim.opt.completeopt="menuone,noselect,popup"
-- map <c-space> to activate completion
vim.keymap.set("i", "<c-space>", function() vim.lsp.completion.get() end)
-- map <cr> to <c-y> when the popup menu is visible
vim.keymap.set("i", "<cr>", "pumvisible() ? '<c-y>' : '<cr>'", { expr = true })
