local lspconfig = require('lspconfig')

-- Enable deno on-deamon
lspconfig.denols.setup {
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

