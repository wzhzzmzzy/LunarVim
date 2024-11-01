---remap keys to any actions
---@param mode 'v' | 'n' | 'i' | 't'
---@param key string
---@param command any
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
  
  --- remap keys to lsp functions
  ---@param mode 'v' | 'n' | 'i'
  ---@param key string
  ---@param command any
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
  
  return {
    common = remap,
    lsp = lsp_remap,
    leader = leader_remap
  }
  