local remap = function (mode, key, command)
  if mode == "n" then
    lvim.keys.normal_mode[key] = command
  elseif mode == "i" then
    lvim.keys.insert_mode[key] = command
  elseif mode == "v" then
    lvim.keys.visual_mode[key] = command
  elseif mode == "t" then
    lvim.keys.term_mode[key] = command
  end
end

local lsp_remap = function (mode, key, command)
  if mode == "n" then
    lvim.lsp.buffer_mappings.normal_mode[key] = command
  elseif mode == "i" then
    lvim.lsp.buffer_mappings.insert_mode[key] = command
  elseif mode == "v" then
    lvim.lsp.buffer_mappings.visual_mode[key] = command
  end
end

local leader_remap = function (key, command, desc)
  lvim.builtin.which_key.mappings[key] = {
    command,
    desc
  }
end

local do_remap = true
if do_remap then
  do_remap = false

  if vim.g.neovide then
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
  end

  -- Terminal
  leader_remap("t", {
    name = "+Terminal",
    t = { "<cmd>term<cr>", "New terminal tab" },
  })
  remap("t", "<ESC>", "<C-\\><C-n>")
end

return {
  common = remap,
  lsp = lsp_remap,
  leader = leader_remap
}
