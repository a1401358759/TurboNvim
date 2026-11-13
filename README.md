<div align="center" id="madewithlua">
  <img src="https://img.yangsihan.com/TurboNvim.svg" width="150", height="130">
</div>

<h1 align="center">TurboNvim</h1>

<p align="center">
  <a href="https://github.com/neovim/neovim">
    <img src="https://img.shields.io/badge/Neovim-0.9.0-blueviolet.svg?style=for-the-badge&logo=neovim&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41">
  </a>
  <a href="https://github.com/a1401358759/TurboNvim/pulse">
    <img src="https://img.shields.io/github/last-commit/a1401358759/TurboNvim?style=for-the-badge&logo=github&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
  <a href="https://github.com/a1401358759/TurboNvim/stargazers">
    <img src="https://img.shields.io/github/stars/a1401358759/TurboNvim?style=for-the-badge&logo=apachespark&color=eed49f&logoColor=D9E0EE&labelColor=302D41"/>
  </a>
</p>

<p align="center">
  TurboNvim is an excellent Neovim configuration with vim.pack, which is as powerful as Vscode, is lightning fast ⚡
</p>

## 🌟 Preview

![Dashboard Preview Image](https://img.yangsihan.com/nvim_dashboard.png)
![Coding Preview Image](https://img.yangsihan.com/nvim_main.png)
![Float Term Image](https://img.yangsihan.com/nvim_toggleterm.png)
![Find Files Image](https://img.yangsihan.com/nvim_telescope_findfiles.png)
![Live Grep Image](https://img.yangsihan.com/nvim_telescope_live_grep.png)
![Lazy Git Image](https://img.yangsihan.com/nvim_lazygit.png)
![Float Ranger Image](https://img.yangsihan.com/nvim_ranger.png)
![NavBuddy Image](https://img.yangsihan.com/nvim_navbuddy.png)

## ✨ Features

- File explorer with [Neo-Tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- Autocompletion with [Blink](https://github.com/Saghen/blink.cmp)
- Git integration with [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- Statusline with [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- Winbar with [Dropbar](https://github.com/Bekaboo/dropbar.nvim)
- Bufferline with [Bufferline](https://github.com/akinsho/bufferline.nvim)
- Terminal and Fuzzy finding with [Snacks](https://github.com/folke/snacks.nvim)
- Syntax highlighting with [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Formatting with [Conform](https://github.com/stevearc/conform.nvim)
- Linting with [Nvim-Lint](https://github.com/mfussenegger/nvim-lint)
- Language Server Protocol with [Native LSP](https://github.com/neovim/nvim-lspconfig)
- Debug Adapter Protocol with [nvim-dap](https://github.com/mfussenegger/nvim-dap)

## ⚡ Requirements

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- [Neovim 0.12+](https://github.com/neovim/neovim/releases/tag/stable) (`vim.pack`)
- [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) (_Note:_ This is only necessary if you want to use `auto_install` feature with Treesitter)
- A clipboard tool is necessary for the integration with the system clipboard (see [`:help clipboard-tool`](https://neovim.io/doc/user/provider.html#clipboard-tool) for supported solutions)
- Terminal with true color support (for the default theme, otherwise it is dependent on the theme you are using) <sup>[[2]](#2)</sup>
- Optional Requirements:
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - live grep telescope search (`<leader>fg`)
  - [lazygit](https://github.com/jesseduffield/lazygit) - git ui toggle terminal (`<leader>tg`)

> <sup id="1">[1]</sup> All downloadable Nerd Fonts contain icons which are used by TurboNvim. Install the Nerd Font of your choice to your system and in your terminal emulator settings, set its font face to that Nerd Font. If you are using TurboNvim on a remote system via SSH, you do not need to install the font on the remote system.

> <sup id="2">[2]</sup> Note when using default theme: For MacOS, the default terminal does not have true color support. You will need to use [iTerm2](https://iterm2.com/), [Kitty](https://sw.kovidgoyal.net/kitty/), [WezTerm](https://wezfurlong.org/wezterm/), or another [terminal emulator](https://gist.github.com/XVilka/8346728#terminal-emulators) that has true color support.

## 🛠️ Installation

### Linux/Mac OS (Unix)

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Clone the repository

```shell
git clone --depth 1 https://github.com/a1401358759/TurboNvim ~/.config/nvim
nvim
```

### Windows (Powershell)

#### Make a backup of your current nvim and nvim-data folder

```pwsh
Rename-Item -Path $env:LOCALAPPDATA\nvim -NewName $env:LOCALAPPDATA\nvim.bak
Rename-Item -Path $env:LOCALAPPDATA\nvim-data -NewName $env:LOCALAPPDATA\nvim-data.bak
```

#### Clone the repository

```pwsh
git clone --depth 1 https://github.com/a1401358759/TurboNvim $env:LOCALAPPDATA\nvim
nvim
```

## 📦 Basic Setup

#### Install LSP

Enter `:LspInstall` followed by the name of the server you want to install<br>
Example: `:LspInstall pyright`

#### Install language parser

Enter `:TSInstall` followed by the name of the language you want to install<br>
Example: `:TSInstall python`

#### Install Debugger

Enter `:DapInstall` followed by the name of the debugger you want to install<br>
Example: `:DapInstall python`

#### Manage plugins

Plugins are grouped by kind in `lua/plugins/` (`lib`, `colorscheme`, `ui`, `edit`, `lang`, `debug`, `blink-cmp`, `ai`). `lua/config/pack.lua` installs that list with `vim.pack` and loads each spec from its fields: `on = "start"` at startup, `on = "ui"` on `UIEnter`, `on = "file"` when a buffer opens, and anything else on its `keys`, `cmd`, `ft`, or `event`. Pinned revisions live in `nvim-pack-lock.json`.

The list UI is [pack-ui.nvim](https://github.com/jtprogru/pack-ui.nvim). Run `:PackStatus` or press `<leader>ps` to open it. `<leader>pU` updates every plugin that has changes.

Inside the window, `<Space>` marks a row, `u` updates the marked rows, `U` updates every available update, `r` checks remotes, and `q` closes the window.

`:PackUpdate` updates from the command line. `:PackClean` deletes installed plugins that are not declared in `lua/plugins/`.


## ⭐ Credits

Sincere appreciation to the following repositories, plugin authors and the entire neovim community out there that made the development of TurboNvim possible.

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim/tree/main)
- [NvChad](https://github.com/NvChad/NvChad)

<div align="center" id="madewithlua">

[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)](https://lua.org)

</div>
