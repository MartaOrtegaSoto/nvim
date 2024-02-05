local cmp = require "cmp"

local options = {
  completion =  {
    completeopt = "menu,menuone"
  },

  window = {},
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
    ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
    ['<C-e>'] = cmp.mapping.abort(), -- close completion window
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-i>'] = cmp.mapping.confirm({select = false}),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  }
}

return options
