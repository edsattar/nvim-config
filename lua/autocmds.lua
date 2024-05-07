vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

vim.api.nvim_create_autocmd({"LspAttach"}, {
  callback = function()
    local wk = require("which-key")
    local tsc = require("telescope.builtin")

    wk.register({
      g = {
        name = "Goto",
        a = { vim.lsp.buf.code_action, "LSP Code Actions" },
        d = { tsc.lsp_definitions, "LSP definition" },
        D = { vim.lsp.buf.declaration, "LSP Declaration" },
        e = { vim.diagnostic.open_float, "LSP Error under cursor" },
        E = { function() tsc.diagnostics({ buffer = 0 }) end, "LSP Errors in buffer" },
        f = { vim.lsp.buf.format, "LSP Format buffer" },
        h = { vim.lsp.buf.hover, "LSP Hover Info" },
        t = { tsc.lsp_type_definitions, "LSP Type Definition" },
        i = { tsc.lsp_implementations, "LSP Implementations" },
        m = { tsc.lsp_references, "LSP Mentions" },
        r = { vim.lsp.buf.rename, "LSP Rename under cursor" },
      },
    }, { buffer = 0 })
  end
})
