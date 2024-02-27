-- attempts to emulate the aesthetics of GUI text editors
-- https://github.com/akinsho/bufferline.nvim
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
						separator_style = "thick",
					},
				},
        name_formatter = function(buf)  -- buf contains:
          local dir = vim.fn.fnamemodify(buf.path, ":h:t")
          local bufname = dir .. '/' .. buf.name
          if #bufname > 17 then
            return vim.fn.pathshorten(bufname, 2)
          end

          return bufname
        end,
			},
		})
	end,
}
