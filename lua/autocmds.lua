vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

vim.api.nvim_create_autocmd({"LspAttach"}, {
  callback = function()
    local wk = require("which-key")
    wk.register({
      g = {
        name = "Goto",
        d = { vim.lsp.buf.definition, "Go to definition" },
        m = { require("telescope.builtin").lsp_references,
          "Open a telescope window with references" },
      },
    }, { buffer = 0 })
  end
})
