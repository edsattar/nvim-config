-- alpha is a fast and fully programmable greeter for neovim.
-- https://github.com/goolord/alpha-nvim
return {
  'goolord/alpha-nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    ---------- Keymaps ----------
    local map = require('utils').map
    map.n('<Leader>a', vim.cmd.Alpha, 'Launch Alpha')

    local alpha = require("alpha")
    local startify = require("alpha.themes.startify")

    startify.section.top_buttons.val = {
      startify.button("e", " New File", ":ene <BAR> startinsert <CR>"),
      startify.button("r", "󰈙 Recent Files", ":Telescope oldfiles<CR>"),
      startify.button("f", " Find File", ":Telescope find_files<CR>"),
      startify.button("s", " Last Session", "<CMD>SessionManager load_last_session<CR>"),

    }
    startify.opts.layout = {
      { type = "padding", val = 1 },
      -- startify.section.header,
      -- { type = "padding", val = 2 },
      startify.section.top_buttons,
      startify.section.bottom_buttons,
      startify.section.mru_cwd,
      startify.section.mru,
      startify.section.footer,
    }

    alpha.setup(startify.config)

  end
}
