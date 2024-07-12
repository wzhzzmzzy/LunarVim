local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Default Vim Configuration
Plug('tpope/vim-sensible')

-- File Explorer
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-tree/nvim-tree.lua')

-- Tab Manager
Plug('moll/vim-bbye')
Plug('akinsho/bufferline.nvim')

-- Status Line
Plug('nvim-lualine/lualine.nvim')

-- File Picker
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })

-- Telescope Addons
-- Project Manager
Plug('ahmedkhalf/project.nvim')

-- LSP Manager
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')

-- Rust LSP Integration
Plug('neovim/nvim-lspconfig')
Plug('mrcjkb/rustaceanvim')

-- TypeScript LSP Integration
Plug('pmizio/typescript-tools.nvim')

-- Lint
Plug('mfussenegger/nvim-lint', {
    ["on"] = { "BufReadPre", "BufNewFile" }
})

-- Completion
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
