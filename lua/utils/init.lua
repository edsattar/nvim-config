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

--- A table to manage ToggleTerm terminals created by the user, indexed by the command run and then the instance number
---@type table<string,table<integer,table>>
M.user_terminals = {}

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Toggle a user terminal if it exists, if not then create a new one and save it
---@param opts string|table A terminal command string or a table of options for Terminal:new() (Check toggleterm.nvim documentation for table format)
function M.toggle_term_cmd(opts)
  local terms = M.user_terminals
  -- if a command string is provided, create a basic table for Terminal:new() options
  if type(opts) == "string" then opts = { cmd = opts } end
  opts = M.extend_tbl({ hidden = true }, opts)
  local num = vim.v.count > 0 and vim.v.count or 1
  -- if terminal doesn't exist yet, create it
  if not terms[opts.cmd] then terms[opts.cmd] = {} end
  if not terms[opts.cmd][num] then
    if not opts.count then opts.count = vim.tbl_count(terms) * 100 + num end
    local on_exit = opts.on_exit
    opts.on_exit = function(...)
      terms[opts.cmd][num] = nil
      if on_exit then on_exit(...) end
    end
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
  return function(lhs, rhs, opts, plugin)
    -- if a plugin is provided, check if it's available before creating the keymap
    if plugin then
      if not M.is_available(plugin) then return end
    end
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
  n = M.mapper('n'), -- normal mode
  v = M.mapper('v'), -- visual mode
  i = M.mapper('i'), -- insert mode
  x = M.mapper('x'), -- visual block mode
  t = M.mapper('t'), -- terminal mode
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

function M.toggle_wrap()
  if vim.wo.wrap then
    vim.wo.wrap = false
    vim.wo.linebreak = false
  else
    vim.wo.wrap = true
    vim.wo.linebreak = true
  end
end

return M
