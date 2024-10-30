# LunarVim Configuration

> Development configuration for personal use.

Neovide + macOS + LunarVim, and you will get awesome fluent development experience.

## Requirements

- Neovim@^0.9
- LunarVim@^1.4

### Optional

- macOS
- Neovide

## Usage

```sh
cd ~/.config
git clone https://github.com/wzhzzmzzy/nvim.git lvim
```

## Feature

### Neovide & MacOS Key mappings

> In `lua/universal/key-mappings.lua`
> Add the common shortcut key in macOS
> [Neovide](https://github.com/neovide/neovide) is a standalone NeoVim GUI Client writen in Rust

- `Command + a`: `ggVG`(select all)
- `Command + F`: telescope live_grep (will bring selected text in visual mode)
- `Command + {`: `<cmd>b#<cr>`(previous buffer, use commonly used shortcut key for switching to previous tab in macos)
- `Command + }`: `<cmd>bnext<cr>`(next buffer)
- `Command + w`: `<cmd>BufferKill<cr>`(kill current buffer)

...and more

### Support Framework & Languages

- Vue@2(`vetur`)
- Vue@3(`volar`)
- JavaScript/TypeScript(`tsserver`, not `ts_ls` because lunarvim use Mason@1.0)
    - DenoJS(`deno_ls`, only launch when `deno.jsonc?` is present)
    - ESlint(`eslint_d`)
    - Prettier(`prettier`)
- CSS
    - UnoCSS
    - TailwindCSS
- Rust

#### About Vue & Neovide

I didn't find a way to support Vue@2 and Vue@3 in the same config, so vue@3 is default support, vue@2 need one more action.

Here is alias example for **fish**

```sh
# neovide
alias nvim="set -x LVIM_VETUR_ENABLE 0 && neovide --neovim-bin lvim"
alias nvim-vue2="set -x LVIM_VETUR_ENABLE 1 && neovide --neovim-bin lvim"

# Lvim
alias lvim="set -x LVIM_VETUR_ENABLE 0 && lvim"
alias lvim-vue2="set -x LVIM_VETUR_ENABLE 1 && lvim"
```

### Plugins

> See all additional plugins in `lua/plugins/user/`

- [catppuccin](https://github.com/catppuccin/nvim)(as default colorscheme)
- [flatten.nvim](https://github.com/willothy/flatten.nvim)

...and more

