return {
  -- amongst your other plugins
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local utils = require("utils")
    local map = utils.map
    local toggle_term_cmd = utils.toggle_term_cmd

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for
    -- toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    map.n("<Leader>tt", ":ToggleTerm <CR>", "ToggleTerm")
    map.n("<Leader>tf", ":ToggleTerm direction=float<CR>", "ToggleTerm float")
    map.n("<Leader>ts", ":ToggleTerm size=10 direction=horizontal<CR>", "ToggleTerm ── horizontal split")
    map.n("<Leader>tv", ":ToggleTerm size=80 direction=vertical<CR>", "ToggleTerm │ vertical split")

    if vim.fn.executable("git") == 1 and vim.fn.executable("lazygit") == 1 then
      map.n("<Leader>tg", function()
        toggle_term_cmd({ cmd = "lazygit", direction = "float" })
      end, "ToggleTerm 󰊢 lazygit")
    end

    if vim.fn.executable("node") == 1 then
      map.n("<Leader>tn", function()
        toggle_term_cmd("node")
      end, "ToggleTerm 󰎙 node")
    end

    local python = vim.fn.executable("python") == 1 and "python" or vim.fn.executable("python3") == 1 and "python3"
    if python then
      map.n("<Leader>tp", function()
        toggle_term_cmd(python)
      end, "ToggleTerm 󰌠 python")
    end

    if vim.fn.executable("htop") == 1 then
      map.n("<Leader>to", function()
        toggle_term_cmd({ cmd = "htop", direction = "float" })
      end, "ToggleTerm htop")
    end

    require("toggleterm").setup({
      --   size = 20,
      open_mapping = [[<C-\>]],
      -- insert_mappings = true, -- mappings enabled in insert mode
      start_in_insert = true,
      shell = "pwsh",      -- use powershell
      float_opts = { border = "rounded" },
    })
  end,
}
