-- Cursor Options
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_animation_length = 0

-- Window Options
vim.g.neovide_transparency = "0.8"
vim.g.neovide_window_blurred = true

-- Paste with Command + C/V
vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
vim.keymap.set('v', '<D-c>', '"+y') -- Copy
vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
vim.keymap.set('i', '<D-v>', '<ESC>"+pli') -- Paste insert mod
