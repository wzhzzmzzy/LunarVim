vim.o.guifont = 'Monaco:h15'
vim.g.neovide_window_blurred = true
vim.g.neovide_transparency = 0.86

-- Disable most cursor animation
vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.25

reload("key-mappings.neovide")