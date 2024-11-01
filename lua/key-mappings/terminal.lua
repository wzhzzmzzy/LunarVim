local utils = require("key-mappings.utils")

local remap = utils.common
local leader_remap = utils.leader

leader_remap("t", {
  name = "+Terminal",
  t = { "<cmd>term<cr>", "New terminal tab" },
})
remap("t", "<ESC>", "<C-\\><C-n>")
