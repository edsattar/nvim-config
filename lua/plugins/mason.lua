return {
  "williamboman/mason.nvim",
  build = function()
    pcall(vim.cmd, 'MasonUpdate')
  end,
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "󰄳",
          package_pending = "󰍶",
          package_uninstalled = "󰅙"
        }
      },
    })
  end
}
