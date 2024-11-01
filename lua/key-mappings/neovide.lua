local utils = require("key-mappings.utils")

local remap = utils.common
local lsp_remap = utils.lsp

-- Buffer
remap("n", "<D-{>", "<cmd>bprevious<CR>")
remap("n", "<D-}>", "<cmd>bnext<CR>")
remap("n", "<D-w>", "<cmd>BufferKill<CR>")
remap("n", "<D-s>", "<cmd>w<CR>")

-- Clipboard
remap("v", "<D-c>", '"+y')
remap("v", "<D-v>", '"+p')
remap("n", "<D-v>", '"+p')
remap("i", "<D-v>", '<ESC>"+pi')
remap("n", "<D-f>", 'ye/\\c<C-r>0<CR>')
remap("v", "<D-f>", 'y/\\c<C-r>0<CR>')
remap("n", "<D-a>", 'ggVG')

-- LSP
lsp_remap("n", "<D-b>", { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" })

-- Telescope 
---@return string
local get_visual_selection = function ()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

---@param fn_name string
local search_in_visual_mode = function (fn_name)
  local text = get_visual_selection()
  require'telescope.builtin'[fn_name]({
    default_text = text
  })
end

remap("n", "<D-p>", { require'telescope.builtin'.find_files })

remap("n", "<D-F>", { require'telescope.builtin'.live_grep })
remap("v", "<D-F>", { function() search_in_visual_mode('live_grep') end })

remap("n", "<D-o>", { require'telescope.builtin'.lsp_document_symbols })
remap("v", "<D-o>", { function() search_in_visual_mode('lsp_document_symbols ') end })

remap("n", "<D-O>", { require'telescope.builtin'.lsp_dynamic_workspace_symbols })
remap("v", "<D-O>", { function() search_in_visual_mode('lsp_dynamic_workspace_symbols') end })
