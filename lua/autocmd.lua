-- Copy from https://github.com/ecosse3/nvim
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
{ callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 }) end })

-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.tex" },
command = "setlocal spell" })

-- Show `` in specific files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.json" },
command = "setlocal conceallevel=0" })

-- Specific options for different FileType
local intent_4 = 4
local intent_4_file_type = { "rust", "c", "cpp", "python", "lua" }
for _, file_type in ipairs(intent_4_file_type) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = file_type,
        callback = function()
            vim.opt_local.shiftwidth = intent_4
            vim.opt_local.tabstop = intent_4
        end
    })
end
