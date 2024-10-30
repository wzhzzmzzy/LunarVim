-- Custom configuration for Core plugins of LunarVim
-- Nvim Tree
local open_nvim_tree = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
  
    if directory then
      vim.cmd.cd(data.file)
      require("nvim-tree.api").tree.open()
      return
    end
  
    local real_file = vim.fn.filereadable(data.file) == 1
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
  
    if real_file or no_name then
      require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
      return
    end
  
    require("nvim-tree.api").tree.open()
  
  end
  
  vim.api.nvim_create_autocmd(
    { "VimEnter" },
    { callback = open_nvim_tree }
  )
  