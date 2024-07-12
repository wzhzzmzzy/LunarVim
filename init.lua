require('plugin')
require('opts')
require('mapping')
require('autocmd')

if vim.g.neovide then
    require('neovide')
end

local vim = vim
vim.cmd('runtime! plugin/sensible.vim')

-- Color Theme
-- require('monokai').setup {}
vim.cmd[[colorscheme tokyonight]]

-- Setup Nvim Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require('nvim-tree').setup ( {
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true
    },
} )

-- Setup LSP
require('lsp.config')

-- Setup nvim-cmp
local cmp = require( 'cmp' )

require('cmp-npm').setup({})
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'calc' },
        { name = 'buffer' },
        {
            name = 'nvim_lsp',
            entry_filter = function(entry, ctx)
                if ctx.filetype ~= 'vue' then
                    return true
                end

                local cursor_before_line = ctx.cursor_before_line
                -- For events
                if cursor_before_line:sub(-1) == '@' then
                    return entry.completion_item.label:match('^@')
                    -- For props also exclude events with `:on-` prefix
                elseif cursor_before_line:sub(-1) == ':' then
                    return entry.completion_item.label:match('^:')
                    and not entry.completion_item.label:match('^:on%-')
                else
                    return true
                end
            end
        },
        { name = 'nvim_lua' },
        { name = 'vsnip' }, -- For vsnip users.
        { name = 'npm', keyword_length = 4 }
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }),
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'Ω',
                path = 'å',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    }
})

-- TreeSitter Plugin Setup
require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "python", "rust", "toml" },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting=false,
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

-- Setup Quick Jump
require("hop").setup({})

-- Setup Intent Hint 
require('ibl').setup({})

-- Setup Bufferline
require('bufferline').setup({
    options = {
        mode = 'buffers',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        always_show_bufferline = false,
        hover = {
            enabled = true,
            delay = 100,
            reveal = {'close'}
        }
    }
})

-- Setup Lualine
require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'tokyonight'
    }
})

-- Setup Autopairs
require('nvim-autopairs').setup({})

-- Setup surround
require('nvim-surround').setup({})

-- Setup Telescope
local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        }
    }
})
require("project_nvim").setup({})
require("telescope").load_extension('projects')

-- Setup comment
require('Comment').setup({
    toggler = {
        line = '<D-/>',
        block = '<C-/>'
    },
    opleader = {
        line = '<D-S-/>',
        block = '<C-S-/>'
    }
})

-- Setup Colorizer
--[[
require( 'colorizer' ).setup({
    filetypes = {
        'lua'
    },
    user_default_options = {
        mode = "background",
        tailwind = false, -- Enable tailwind colors
    }
})
]]--

-- Setup ToggleTerm
require("toggleterm").setup({
    open_mapping = [[<C-`>]],
    direction = 'vertical',
    size = vim.o.columns * 0.3
})