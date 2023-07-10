-- yanked from astronvim.utils 9-Jun-2023
-- This module can be loaded with `local utils = require "utils"`

local M = {}

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

--- Create a button entity to use with the alpha dashboard
---@param sc string The keybinding string to convert to a button
---@param txt string The explanation text of what the keybinding does
---@return table # A button entity table for an alpha configuration
function M.alpha_button(sc, txt)
  -- replace <leader> in shortcut text with LDR for nicer printing
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<leader>")
  -- if the leader is set, replace the text with the actual leader key for nicer printing
  if vim.g.mapleader then sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader) end
  -- return the button entity to display the correct text and send the correct keybinding on press
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 36,
      align_shortcut = "right",
      hl = "DashboardCenter",
      hl_shortcut = "DashboardShortcut",
    },
  }
end

--- Toggle a user terminal if it exists, if not then create a new one and save it
---@param opts string|table A terminal command string or a table of options for Terminal:new() (Check toggleterm.nvim documentation for table format)
function M.toggle_term_cmd(opts)
  local terms = user_terminals
  -- if a command string is provided, create a basic table for Terminal:new() options
  if type(opts) == "string" then opts = { cmd = opts, hidden = true } end
  local num = vim.v.count > 0 and vim.v.count or 1
  -- if terminal doesn't exist yet, create it
  if not terms[opts.cmd] then terms[opts.cmd] = {} end
  if not terms[opts.cmd][num] then
    if not opts.count then opts.count = vim.tbl_count(terms) * 100 + num end
    if not opts.on_exit then opts.on_exit = function() terms[opts.cmd][num] = nil end end
    terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
  end
  -- toggle the terminal
  terms[opts.cmd][num]:toggle()
end

--- Create a keymap function for a specific mode
---@param mode string | table The mode to create the keymap for
---@return function # A function to create keymaps for the specified mode
function M.mapper(mode)
  ---@param lhs string The keybinding to map
  ---@param rhs string The command to run
  ---@param opts table The options to pass to the keymap
  return function(lhs, rhs, opts)
    -- if opts is a string then set it to opts.desc
    if type(opts) == 'string' then
      opts = { desc = opts }
    end
    opts = opts or {}
    opts.noremap = opts.noremap or true
    opts.silent = opts.silent or true
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

M.map = {
  n = M.mapper('n'),
  v = M.mapper('v'),
  i = M.mapper('i'),
  x = M.mapper('x'),
  t = M.mapper('t'),
  ni = M.mapper({'n', 'i'}),
  nv = M.mapper({'n', 'v'}),
  niv = M.mapper({'n', 'i', 'v'}),
}

function M.run_file()
  local filetype = vim.bo.filetype
  local file_dir = vim.fn.expand('%:p:h')
  local curr_dir = vim.fn.getcwd()
  local file_name = vim.fn.expand('%:t')
  local file_ext = vim.fn.expand('%:e')

  if filetype == "python" then
    if vim.fn.filereadable(file_dir .. "/Pipfile") == 1 then
      if file_dir ~= curr_dir then
        vim.cmd("w | !cd %:p:h && pipenv run python3 %:t")
      else
        vim.cmd("w | !pipenv run python3 %")
      end
    else
      vim.cmd("w | !python3 %")
    end
  end
end

return M
