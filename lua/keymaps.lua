-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings

local utils = require("utils")
local is_available = utils.is_available
local map = utils.map

local sections = {
	b = { name = " 󰓩 Buffers" },
	g = { name = " 󰊢 Git" },
	l = { name = " 󰏖 Lazy" },
	w = { name = "󰜉 Windows" },
}

map.n("<Leader>e", "<cmd>Neotree toggle<cr>", "Toggle file explorer", "neo-tree.nvim")
map.n("<Leader>e", "<cmd>NvimTreeToggle<cr>", "Toggle file explorer", "nvim-tree.lua")
map.n("[e", vim.diagnostic.goto_prev, "Previous diagnostic", "nvim-lspconfig")
map.n("]e", vim.diagnostic.goto_next, "Next diagnostic", "nvim-lspconfig")
-- Lazy Package Manager
map.n("<Leader>li", function() require("lazy").install() end, "Plugins Install")
map.n("<Leader>ll", function() require("lazy").home() end, "Plugins Status")
map.n("<Leader>lS", function() require("lazy").sync() end, "Plugins Sync")
map.n("<Leader>lu", function() require("lazy").check() end, "Plugins Check Updates")
map.n("<Leader>lU", function() require("lazy").update() end, "Plugins Update")
map.n("<Leader>lm", "<cmd>Mason<cr>", "Mason Installer", "mason.nvim")
map.n("<Leader>lp", "<cmd>LspInfo<cr>", "LSP Info", "nvim-lspconfig")
map.n("<Leader>u", vim.cmd.UndotreeToggle, "Toggle undo tree", "undotree")

-- Telescope
if is_available("telescope.nvim") then
	sections.f = { name = " 󰍉 Find" }
	local tsc = require("telescope.builtin")
  local function tsc_find_git_files()
    if not pcall(tsc.git_files) then
      tsc.find_files()
    end
  end
  local function tsc_find_all_files()
    tsc.find_files({ hidden = true, no_ignore = true })
  end
  local function tsc_find_all_words()
	tsc.live_grep({
			additional_args = function(args)
				return vim.list_extend(args, { "--hidden", "--no-ignore" })
			end,
		})
  end
  local function tsc_color_scheme()
		tsc.colorscheme({ enable_preview = true })
	end
	map.n("<Leader>gb", tsc.git_branches, "Git branches", "telescope.nvim")
	map.n("<Leader>gc", tsc.git_commits, "Git commits", "telescope.nvim")
	map.n("<Leader>gt", tsc.git_status, "Git status", "telescope.nvim")
	map.n("<Leader>f<CR>", tsc.resume, "Resume previous search", "telescope.nvim")
	map.n("<Leader>f'", tsc.marks, "Find marks", "telescope.nvim")
	map.n("<Leader>fb", tsc.buffers, "Find buffers", "telescope.nvim")
	map.n("<Leader>fc", tsc.grep_string, "Find word under cursor", "telescope.nvim")
	map.n("<Leader>fC", tsc.commands, "Find commands", "telescope.nvim")
	map.n("<Leader>ff", tsc_find_git_files, "Find git files", "telescope.nvim")
	map.n("<Leader>fF", tsc_find_all_files, "Find files", "telescope.nvim")
	map.n("<Leader>fh", tsc.help_tags, "Find help", "telescope.nvim")
	map.n("<Leader>fk", tsc.keymaps, "Find keymaps", "telescope.nvim")
	map.n("<Leader>fm", tsc.man_pages, "Find man(manual) pages", "telescope.nvim")
	map.n("<Leader>fo", tsc.oldfiles, "Find opened(recently opened) files", "telescope.nvim")
	map.n("<Leader>fr", tsc.registers, "Find registers", "telescope.nvim")
	map.n("<Leader>ft", tsc_color_scheme, "Find themes", "telescope.nvim")
	map.n("<Leader>fw", tsc.live_grep, "Find word", "telescope.nvim")
	map.n("<Leader>fW", tsc_find_all_words, "Find word in all files", "telescope.nvim")
end

-- toggleTerminal
if is_available("toggleterm.nvim") then
	sections.t = { name = "  Terminal" }
	function _G.set_terminal_keymaps()
		local opts = { buffer = 0 }
		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
	end

	-- if you only want these mappings for
	-- toggle term use term://*toggleterm#* instead
	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

	map.n("<Leader>tf", ":ToggleTerm direction=float<cr>", "ToggleTerm float")
	map.n("<Leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm ── split")
	map.n("<Leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm │ split")
	local tt = utils.toggle_term_cmd

	if vim.fn.executable("node") == 1 then
		map.n("<Leader>tn", function()
			tt("node")
		end, "ToggleTerm 󰎙 node")
	end

	local python = vim.fn.executable("python") == 1 and "python" or vim.fn.executable("python3") == 1 and "python3"
	if python then
		map.n("<Leader>tp", function()
			tt(python)
		end, "ToggleTerm 󰌠 python")
	end

	if vim.fn.executable("lazygit") == 1 then
		map.n("<Leader>tg", function()
			tt({ cmd = "lazygit", hidden = true, direction = "float" })
		end, "ToggleTerm 󰊢 lazygit")
	end

	if vim.fn.executable("htop") == 1 then
		map.n("<Leader>to", function()
			tt({ cmd = "htop", hidden = true, direction = "float" })
		end, "ToggleTerm htop")
	end
end

-- Comment.nvim
if is_available("Comment.nvim") then
	map.n("<C-_>", "<Plug>(comment_toggle_linewise_current)", "Toggle comment")
	map.x("<C-_>", "<Plug>(comment_toggle_linewise_visual)", "Toggle comment")
	map.i("<C-_>", "<Esc><Plug>(comment_toggle_linewise_current)a", "Toggle comment")
	map.n("<A-/>", "<Plug>(comment_toggle_blockwise_current)", "Toggle blockwise comment")
	map.x("<A-/>", "<Plug>(comment_toggle_blockwise_visual)", "Toggle blockwise comment")
	map.i("<A-/>", "<Esc><Plug>(comment_toggle_blockwise_current)a", "Toggle blockwise comment")
end

map.n("<Leader>R", utils.run_file, "Run file")

-- MOVEMENT --
-- disable arrow keys
map.niv("<Up>", "")
map.niv("<Down>", "")
map.niv("<Right>", "")
map.niv("<Left>", "")
-- Move through wrapped lines
map.n("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map.n("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- Move improvements
map.nv("H", "0", "Move to the beginning of the line")
map.nv("L", "$", "Move to the end of the line")
map.n("J", "<C-d>zz", "Move down half page")
map.n("K", "<C-u>zz", "Move up half page")
map.n('n', 'nzz', 'Center next match')
map.n('N', 'Nzz', 'Center previous match')
-- BUFFER --
map.n("]b", "<cmd>bn<cr>", "Next buffer")
map.n("[b", "<cmd>bp<cr>", "Previous buffer")
map.n("<Leader>bb", "<cmd>bd<cr>", "Delete buffer")
map.n("<Leader>bn", "<cmd>bn<cr>", "Next buffer")
map.n("<Leader>bv", "<cmd>bp<cr>", "Prev buffer")
-- navigate tabs
map.n("]t", "<cmd>tabnext<cr>", "Next tab")
map.n("[t", "<cmd>tabprevious<cr>", "Previous tab")

-- select/copy/paste
map.n("vv", "V", "Select whole line")
map.n("V", "v$", "Select to end of line")
map.n("vaf", "ggVG", "Select whole file")
map.n("yaf", "ggVGy", "Yank whole file")
map.nv("<Leader>y", '"+y', "Yank to system clipboard")
map.nv("<Leader>pp", '"+p', "Paste from system clipboard")
map.nv("<Leader>po", '"*p', "Paste from selection clipboard")
-- Don't copy the replaced text after pasting in visual mode
map.v("p", 'p:let @+=@0<CR>:let @"=@0<CR>')
-- search-replace word under cursor
map.n("<Leader>/", ":%s/<C-r><C-w>/", "Search and replace word under cursor")
-- visual mode search and replace selected text
map.v("<Leader>/", '"hy:%s/<C-r>h//gc<left><left><left>', "Search and replace selected text")
-- resize windows
map.n("<C-Up>", ":hori res +1<CR>", "Increase Window Height")
map.n("<C-Down>", ":hori res -2<CR>", "Decrease Window Height")
map.n("<C-Right>", ":vert res +2<CR>", "Increase Window Width")
map.n("<C-Left>", ":vert res -2<CR>", "Decrease Window Width")
-- save/quit
map.n("<C-s>", "<cmd>w<CR>", "Save file")
map.i("<C-s>", "<Esc><cmd>w<CR>a", "Save file")
map.n("<Leader>qq", "<cmd>q<cr>", "Quit")
map.n("<Leader>qa", "<cmd>q<cr>", "Quit All")

-- Shift line up or down
map.n("<A-j>", "<cmd>m+1<cr>", "Move line down")
map.n("<A-k>", "<cmd>m-2<cr>", "Move line up")
map.v("<A-j>", ":m'>+1<cr>gv=gv", "Move line down")
map.v("<A-k>", ":m'<-2<cr>gv=gv", "Move line up")
map.v("<A-h>", "xhP`[v`]", "Move selection left")
map.v("<A-l>", "xp`[v`]", "Move selection left")
-- Join lines
-- map.n('<A-a>', 'mzJ`z', 'Join lines')
map.n("<A-a>", "J", "Join lines")
map.n("<A-s>", "mzgJ`z", "Join lines without space")
-- Toggle wrap
map.n("<A-z>", function()
	vim.wo.wrap = not vim.wo.wrap
end, "Toggle Wrap")

-- Clear highlights

map.n("<Esc>", ":noh <cr>")

-- -- Save and run Python file for Python buffers only
-- vim.cmd([[
--   autocmd FileType python nnoremap <buffer> <Leader>r :lua RunPython()
--   ]])
if is_available("which-key.nvim") then
	local wk = require("which-key")
  vim.cmd[[nmap ; <C-w>]]
	wk.register(sections, { prefix = "<Leader>" })
end
