if vim.env.LVIM_VETUR_ENABLE == "1" then
  require('languages.vue2')
else
  require('languages.vue3')
end

