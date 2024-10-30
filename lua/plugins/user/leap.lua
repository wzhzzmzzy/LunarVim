return {
  "ggandor/leap.nvim",
  name = "leap",
  config = function()
    require('leap').create_default_mappings()
  end,
}
