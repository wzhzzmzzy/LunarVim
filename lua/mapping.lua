local map = vim.keymap.set
local wk = require('which-key')

-- Hop Motion Mapping
map('n', 'T', function ()
    require('hop').hint_words({
        direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
        current_line_only = true
    })
end)

map('n', 't', function ()
    require('hop').hint_words({
        direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
        current_line_only = true
    })
end)

-- Custom Mapping
wk.register({
    ["<Leader>"] = {
        y = { 'ye/<C-r>"<CR>', 'Yank then Search' },
        u = { ':redo<CR>', 'Redo' }
    },
    ["<C-h>"] = { function() vim.cmd('wincmd h') end, "Go to left panel" },
    ["<C-k>"] = { function() vim.cmd('wincmd k') end, "Go to upside panel" },
    ["<C-j>"] = { function() vim.cmd('wincmd j') end, "Go to downside panel" },
    ["<C-l>"] = { function() vim.cmd('wincmd l') end, "Go to right panel" },
    ["<D-1>"] = { function() require("nvim-tree.api").tree.toggle() end, "Open NvimTree" },
    ["<D-a>"] = { 'gg0vG$', "Select all" }
})


-- Telescope
local telefn = require('telescope.builtin')
local cursor_theme = require('telescope.themes').get_cursor({})

wk.register({
    ["<D-p>"] = {
        function()
            local path = vim.loop.cwd() .. "/.git"
            local ok, err = vim.loop.fs_stat(path)
            if not ok then
                telefn.find_files()
                return
            end
            telefn.git_files()
        end,
        "Fine files"
    },
    ["<D-o>"] = {
        function()
            require'telescope'.extensions.projects.projects{}
        end,
        "Select projects"
    },
    ["<D-S-f>"] = { function() telefn.live_grep() end, "Live grep" },
    ["<D-b>"] = { function() telefn.lsp_definitions(cursor_theme) end, "LSP Definitions"},
    ["<D-S-b>"] = { function() telefn.lsp_references(cursor_theme) end, "LSP References" },
    ["<D-S-h>"] = { function() telefn.diagnostics() end, "LSP Diagnostics" },
    ["<D-g>"] = {
        name = "+Git",
        b = { function () telefn.git_branches() end, "Git branches" },
        s = { function () telefn.git_status() end, "Git status" },
        c = { function () telefn.git_bcommits() end, "Git commits here" },
    }
})

-- Bufferline Mapping
map('', '<D-{>', '<cmd>BufferLineCyclePrev<CR>', { silent = true })
map('', '<D-}>', '<cmd>BufferLineCycleNext<CR>', { silent = true })
map('', '<D-w>', '<cmd>Bdelete<CR>', { silent = true })

-- Debug Adapter Mapping
local dap = require('dap')
wk.register({
    ["<Leader>"] = {
        name = "Debugger",
        ["<F5>"] = {
            function() dap.continue() end,
            "Debug"
        },
        ["<F6>"] = {
            function() require("dapui").toggle() end,
            "Toggle Dapui"
        },
        ["<F9>"] = { function() dap.step_over() end, "Step over" },
        ["<F10>"] = { function() dap.step_into() end, "Step into" },
        ["<F12>"] = { function() dap.step_out() end, "Step out" },
        b = {
            function() dap.toggle_breakpoint() end,
            "Breakpoint"
        },
        d = {
            name = "More",
            l = { function() dap.run_last() end, "Run last" },
            f = { function() require("dapui").float_element('scopes', { enter = true }) end, "Dapui float" }
        }
    },
})

-- Toggleterm Mapping
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "vertical",
    display_name = "Lazygit",
    size = vim.o.columns * 0.4
})

local lazygit_toggle = function ()
    lazygit:toggle()
end

wk.register({
    ["<Leader>"] = {
        name = "Terminal",
        ["G"] = {
            function() lazygit_toggle() end,
            "Lazygit"
        }
    }
})
function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    -- Conflict with lazygit
    -- map('t', '<esc>', [[<C-\><C-n>]], opts)
    map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')