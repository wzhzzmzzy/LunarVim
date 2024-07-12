-- Vim & Plugin Options
local debug_helper = require("utils.debug")

-- Nvim Tree Options
-- FIXME: Nvim Tree won't auto start when open Nvim in some wired folder or single file,
--        However nvim-tree.api.tree.open was called.
local function open_nvim_tree(data)
    -- buffer is a real file on the disk
    local real_file = vim.fn.filereadable(data.file) == 1
    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if not real_file and not no_name then
        require("nvim-tree.api").tree.open({ path = data.file })
        return
    end
    -- open the tree, find the file but don't focus it
    require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Setup Editor 
local set = vim.opt
local TabWidth = 2

set.tabstop = TabWidth
set.softtabstop = TabWidth
set.shiftwidth = TabWidth
set.expandtab = true
set.number = true
set.termguicolors = true

-- Setup Rust LSP 
vim.g.rustaceanvim = function()
    local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb'
    liblldb_path = liblldb_path .. ".dylib"

    local cfg = require('rustaceanvim.config')

    return {
        tools = {
            hover_actions = {
                replace_builtin_hover = false
            },
            float_win_config = {
                auto_focus = true,
                open_split = "vertical"
            }
        },
        dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
            on_attach = function(client, bufnr)
                -- LSP Command Alias
                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, { focusable = false }
                )

                local map = vim.keymap.set
                -- Use Telescope LSP Function Instead
                -- map("n", "<D-b>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                -- map("n", "<D-S-b>", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                local opts = { silent = true }
                map("n", "<Leader><Space>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                map("n", "<F5>", function() vim.cmd.RustLsp('run') end, opts)
                map("n", "<S-F5>", function() vim.cmd.RustLsp('debug') end, opts)
            end,
            default_settings = {
                -- rust-analyzer language server configuration
                ['rust-analyzer'] = {
                },
            },
        },
    }
end

-- Setup LSP Diagnostics Options
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = '󱜺'})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
        format = function(diagnostic)
            local code = diagnostic and diagnostic.user_data and diagnostic.user_data.lsp.code
            if diagnostic.source == 'eslint' then
                for _, table in pairs(require('lsp.eslint').config) do
                    if vim.tbl_contains(table, code) then
                        return string.format('%s [%s]', table.icon .. diagnostic.message, code)
                    end
                end

                return string.format('%s [%s]', diagnostic.message, code)
            end

            return string.format('%s [%s]', diagnostic.message, diagnostic.source)
        end
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Completion Options
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Debug Adaptor
local dap = require("dap")

dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = '/Users/amber/.local/share/codelldb/extension/adapter/codelldb',
        args = { "--port", "${port}" },
    }
}

dap.configurations.rust = {
    {
        request = "launch",
        cwd = "${workspaceFolder}",
        type = "codelldb",
        name = "Launch file",
        stopOnEntry = false,
        host = "arm64",
        program = function()
            -- Input target binary manually
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end
    }
}

require("dapui").setup({})

-- Lint Options
local lint = require("lint")

--[[
lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    svelte = { "eslint_d" },
    python = { "pylint" },
}
]]--

vim.keymap.set("n", "<leader>l", function()
    lint.try_lint()
end, { desc = "lint file" })