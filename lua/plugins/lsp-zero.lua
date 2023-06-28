return {
  "VonHeikemen/lsp-zero.nvim",
  -- branch = "v2.x",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    
  },
  config = function()
    local lsp = require("lsp-zero").preset({})
    local lspconfig = require("lspconfig")

    lsp.on_attach(function(client, bufnr)
      lsp.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false,
        omit = { 'K' },
      })

      ---------- Custom Key Bindings ----------
      local bufmap = function(mode, lhs, rhs, desc)
        local opts = { buffer = bufnr, desc = desc }
        vim.keymap.set(mode, lhs, function() rhs() end, opts)
      end

      bufmap('n', "gh", vim.lsp.buf.hover, "LSP Hover Info")
      bufmap('n', "gi", vim.lsp.buf.implementation, "LSP Implementation")
      bufmap('n', "go", vim.lsp.buf.type_definition, "LSP Type Definition")
      bufmap('n', "gr", vim.lsp.buf.references, "LSP References")
      bufmap('n', "gs", vim.lsp.buf.signature_help, "LSP Signature Help")
      bufmap({ 'n', 'x' }, "gq", function()
        vim.lsp.buf.format({
          async = false, timeout_ms = 10000, })
      end, "LSP Format File/Selection")
    end)

    lsp.set_server_config({
      -- single_file_support = false,
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
          } } } })

    lsp.ensure_installed({
      "lua_ls",
      "eslint",
      "tsserver",
      "rust_analyzer",
    })

    lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

    -- lspconfig.tsserver.setup({
    --   on_attach = function(client, bufnr)
    --     client.resolved_capabilities.document_formatting = false
    --     lsp.default_keymaps({ buffer = bufnr })
    --   end
    -- })

    lspconfig.pylsp.setup({
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
      -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
      settings = {
        pylsp = {
          plugins = {
            yapf = { enabled = false },     -- use ruff black
            autopep8 = { enabled = false }, -- use ruff black
            pyflakes = { enabled = false }, -- use ruff pyflakes
            -- E501 line too long
            pycodestyle = { ignore = { "E501", "E241" } },
          }
        }
      }
    })

    lsp.setup()
  end,
}
