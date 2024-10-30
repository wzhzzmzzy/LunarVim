local lspconfig = require('lspconfig')
local lsputil = require('lspconfig.util')

lspconfig.volar.setup {
  root_dir = function ()
    return nil
  end
}

lspconfig.vuels.setup {
  root_dir = lsputil.root_pattern('fire.config.js', 'vue.config.js', 'package.json')
}
