lvim.plugins = {
  -- require("plugins.user.hop"),
  require("plugins.user.leap"),
  require("plugins.user.numb"),

  -- FIXME: MINIMAP HAS TOO MANY BUGS
  -- require("plugins.user.minimap"),

  -- FIXME: rustaceanvim doesn't work fine with lunarvim
  -- require("plugins.user.rustaceanvim"),

  -- Rust
  require("plugins.user.rust-tools")[1],
  require("plugins.user.rust-tools")[2],
  require("plugins.user.rust-tools")[3],

  require("plugins.user.numb"),
  require("plugins.user.todo-comments"),
  require("plugins.user.nvim-bqf"),
  require("plugins.user.nvim-ts-autotag"),
  require("plugins.user.flatten"),
  require("plugins.user.git-conflict"),

  -- Colorscheme
  -- require("plugins.user.tokyonight"),
  require("plugins.user.catppuccin")
}
