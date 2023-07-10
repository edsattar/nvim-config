-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings

local wk = require "which-key"
local sections = {
  b = { name = " 󰓩 Buffers" },
  g = { name = " 󰊢 Git" },
  l = { name = " 󰏖 Lazy" },
}

local utils = require("utils")
local is_available = utils.is_available
local map = utils.map

-- Telescope
if is_available "telescope.nvim" then
  sections.f = { name = " 󰍉 Find" }
  local tsc = require('telescope.builtin')
  map.n("<leader>gb", tsc.git_branches, "Git branches")
  map.n("<leader>gc", tsc.git_commits, "Git commits")
  map.n("<leader>gt", tsc.git_status, "Git status")
  map.n("<leader>f<CR>", tsc.resume, "Resume previous search")
  map.n("<leader>f'", tsc.marks, "Find marks")
  map.n('<Leader>fb', tsc.buffers, 'Find buffers')
  map.n('<Leader>fc', tsc.grep_string, 'Find word under cursor')
  map.n('<Leader>fC', tsc.commands, 'Find commands')
  map.n('<Leader>ff', function() if not pcall(tsc.git_files) then tsc.find_files() end end, 'Find git files')
  map.n('<Leader>fF', function() tsc.find_files { hidden = true, no_ignore = true } end, 'Find files')
  map.n('<Leader>fh', tsc.help_tags, 'Find help')
  map.n('<Leader>fk', tsc.keymaps, 'Find keymaps')
  map.n('<Leader>fm', tsc.man_pages, 'Find man(manual) pages')
  map.n('<Leader>fo', tsc.oldfiles, 'Find opened(recently opened) files')
  map.n('<Leader>fr', tsc.registers, 'Find registers')
  map.n('<Leader>ft', function() tsc.colorscheme { enable_preview = true } end, 'Find themes')
  map.n('<Leader>fw', tsc.live_grep, 'Find word')
  map.n('<Leader>fW', function()
    tsc.live_grep {
      additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
    }
  end, 'Find word in all file')
end

-- Terminal
if is_available "toggleterm.nvim" then
  sections.t = { name = "  Terminal" }
  function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  end

  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  map.n("<leader>tf", ":ToggleTerm direction=float<cr>", "ToggleTerm float")
  map.n("<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm ── split")
  map.n("<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm │ split")

  local tt = utils.toggle_term_cmd

  if vim.fn.executable "node" == 1 then
    map.n("<leader>tn", function() tt "node" end, "ToggleTerm 󰎙 node")
  end

  local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
  if python then
    map.n("<leader>tp", function() tt(python) end, "ToggleTerm 󰌠 python")
  end

  if vim.fn.executable "lazygit" == 1 then
    map.n("<leader>tg", function() tt { cmd = "lazygit", hidden = true, direction = "float" } end, "ToggleTerm 󰊢 lazygit")
  end

  if vim.fn.executable "htop" == 1 then
    map.n("<leader>to", function() tt { cmd = "htop", hidden = true, direction = "float" } end, "ToggleTerm htop")
  end
end

-- NeoTree
if is_available "nvim-tree.lua" then
  map.n('<Leader>e', vim.cmd.NvimTreeToggle, 'Toggle file explorer')
end

-- UndoTree
if is_available "undotree" then
  map.n('<Leader>u', vim.cmd.UndotreeToggle, 'Toggle undo tree')
end

-- Lazy Package Manager
map.n("<leader>li", function() require("lazy").install() end, "Plugins Install")
map.n("<leader>ls", function() require("lazy").home() end, "Plugins Status")
map.n("<leader>lS", function() require("lazy").sync() end, "Plugins Sync")
map.n("<leader>lu", function() require("lazy").check() end, "Plugins Check Updates")
map.n("<leader>lU", function() require("lazy").update() end, "Plugins Update")

if is_available "mason.nvim" then
  map.n("<leader>lm", "<cmd>Mason<cr>", "Mason Installer")
  map.n("<leader>lM", "<cmd>MasonUpdateAll<cr>", "Mason Update")
end

map.n('<Leader>R', utils.run_file, 'Run file')

-- MOVEMENT -- 
-- disable arrow keys
map.niv('<Up>', "")
map.niv('<Down>', "")
map.niv('<Right>', "")
map.niv('<Left>', "")
-- Move through wrapped lines
map.n('k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map.n('j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- Move improvements
map.n('H', '^', 'Move to the beginning of the line')
map.n('L', '$', 'Move to the end of the line')
map.n('J', '<C-d>', 'Move down half page')
map.n('K', '<C-u>', 'Move up half page')
-- map.n('n', 'nzzzv', 'Center next match')
-- map.n('N', 'Nzzzv', 'Center previous match')

-- BUFFER --
map.n(']b', '<cmd>bn<cr>', 'Next buffer')
map.n('[p', '<cmd>bp<cr>', 'Previous buffer')
map.n('<Leader>bd', '<cmd>bd<cr>', 'Delete buffer')

-- select/copy/paste
map.n('vv', 'V', 'Select whole line')
map.n('vaf', 'ggVG', 'Select whole file')
map.n('yaf', 'ggVGy', 'Yank whole file')
-- Don't copy the replaced text after pasting in visual mode
map.v('p', 'p:let @+=@0<CR>:let @"=@0<CR>')
map.nv('<Leader>y', '\"+y', "Yank to system clipboard")
map.nv('<Leader>p', '\"+p', "Paste from system clipboard")
-- search-replace word under cursor
map.n('<Leader>/', ':%s/<C-r><C-w>/', 'Search and replace word under cursor')
-- navigate tabs
map.n(']t', '<cmd>tabnext<cr>', 'Next tab')
map.n('[t', '<cmd>tabprevious<cr>', 'Previous tab')
-- navigate windows
map.n('<C-h>', '<C-w>h', 'jump to left window')
map.n('<C-l>', '<C-w>l', 'jump to right window')
map.n('<C-j>', '<C-w>j', 'jump to window below')
map.n('<C-k>', '<C-w>k', 'jump to window above')
-- split windows
map.n("|", '<C-w>v', 'split window vertically')
map.n("_", '<C-w>s', 'split window horizontally')
-- resize windows
map.n('<C-Up>', ':hori res +1<CR>', 'Increase Window Height')
map.n('<C-Down>', ':hori res -2<CR>', 'Decrease Window Height')
map.n('<C-Right>', ':vert res +2<CR>', 'Increase Window Width')
map.n('<C-Left>', ':vert res -2<CR>', 'Decrease Window Width')
-- save/quit
map.n('<C-s>', '<cmd>w<CR>', 'Save file')
map.i('<C-s>', '<Esc><cmd>w<CR>a', 'Save file')
map.n('<C-q>', '<cmd>bd<cr>', 'Quit')
-- comment
map.n('<C-_>', '<Plug>(comment_toggle_linewise_current)', 'Toggle comment')
map.x('<C-_>', '<Plug>(comment_toggle_linewise_visual)', 'Toggle comment')
map.i('<C-_>', '<Esc><Plug>(comment_toggle_linewise_current)a', 'Toggle comment')
map.n('<A-/>', '<Plug>(comment_toggle_blockwise_current)', 'Toggle blockwise comment')
map.x('<A-/>', '<Plug>(comment_toggle_blockwise_visual)', 'Toggle blockwise comment')
map.i('<A-/>', '<Esc><Plug>(comment_toggle_blockwise_current)a', 'Toggle blockwise comment')
-- Shift line up or down
map.n('<A-j>', '<cmd>m+1<cr>', 'Move line down')
map.n('<A-k>', '<cmd>m-2<cr>', 'Move line up')
map.v('<A-j>', ":m'>+1<cr>gv=gv", 'Move line down')
map.v('<A-k>', ":m'<-2<cr>gv=gv", 'Move line up')
-- Join lines
-- map.n('<A-a>', 'mzJ`z', 'Join lines')
map.n('<A-a>', 'J', 'Join lines')
map.n('<A-s>', 'mzgJ`z', 'Join lines without space')
-- Toggle wrap
map.n('<A-z>', function() vim.wo.wrap = not vim.wo.wrap end, 'Toggle Wrap')
-- Indent with Shift
map.n('<S-Tab>', 'v<', 'Indent left')
map.n('<Tab>', 'v>', 'Indent right')
map.v('<S-Tab>', '<gv', 'Indent left')
map.v('<Tab>', '>gv', 'Indent right')


-- Clear highlights

map.n('<Esc>', ':noh <cr>')

-- -- Save and run Python file for Python buffers only
-- vim.cmd([[
--   autocmd FileType python nnoremap <buffer> <Leader>r :lua RunPython()
--   ]])

wk.register(sections, { prefix = "<Leader>" })
