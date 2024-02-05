local M = {}

local servers = {
  'lua_ls'
}

M.mason_opts = {
  ensured_installed = servers
}

M.lsp_config = function()
  local lspconfig = require("lspconfig")
  local mappings = require("core.mappings")

  local on_attach = function(client, bufnr)
    require("core.utils").load_mapping("lspconfig", {buffer = bufnr})

  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- General language setup
  for _, server in ipairs(servers) do
    lspconfig[server].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end

  lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          },
        }
      }
  }
end


return M
