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
  TurboNvim es una excelente configuración de Neovim con lazy.nvim, que es tan potente como Vscode y lightning fast ⚡
</p>

## 🌟 Vista Previa

![Dashboard Preview Image](https://img.yangsihan.com/nvim_dashboard.png)
![Coding Preview Image](https://img.yangsihan.com/nvim_main.png)
![Float Term Image](https://img.yangsihan.com/nvim_toggleterm.png)
![Find Files Image](https://img.yangsihan.com/nvim_telescope_findfiles.png)
![Live Grep Image](https://img.yangsihan.com/nvim_telescope_live_grep.png)
![Lazy Git Image](https://img.yangsihan.com/nvim_lazygit.png)
![Float Ranger Image](https://img.yangsihan.com/nvim_ranger.png)
![NavBuddy Image](https://img.yangsihan.com/nvim_navbuddy.png)

## ✨ Características

- Explorador de archivos con [Neo-Tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- Autocompletado con [Blink](https://github.com/Saghen/blink.cmp)
- Integración con Git mediante [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- Statusline con [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- Winbar con [Dropbar](https://github.com/Bekaboo/dropbar.nvim)
- Bufferline con [Bufferline](https://github.com/akinsho/bufferline.nvim)
- Terminal y búsqueda difusa (Fuzzy finding) con [Snacks](https://github.com/folke/snacks.nvim)
- Resaltado de sintaxis con [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Formateo con [Conform](https://github.com/stevearc/conform.nvim)
- Linting con [Nvim-Lint](https://github.com/mfussenegger/nvim-lint)
- Language Server Protocol con [Native LSP](https://github.com/neovim/nvim-lspconfig)
- Debug Adapter Protocol con [nvim-dap](https://github.com/mfussenegger/nvim-dap)

## ⚡ Requisitos

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- [Neovim 0.8+ (Incluyendo nightly)](https://github.com/neovim/neovim/releases/tag/stable)
- [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) (_Nota:_ Esto solo es necesario si deseas usar la función `auto_install` con Treesitter)
- Una herramienta de portapapeles es necesaria para la integración con el portapapeles del sistema (consulta [`:help clipboard-tool`](https://neovim.io/doc/user/provider.html#clipboard-tool) para soluciones compatibles)
- Terminal con soporte de colores reales (true color) (para el tema por defecto, de lo contrario dependerá del tema que estés utilizando) <sup>[[2]](#2)</sup>
- Requisitos Opcionales:
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - búsqueda de live grep en telescope (`<leader>fg`)
  - [lazygit](https://github.com/jesseduffield/lazygit) - alternar terminal de interfaz de git (`<leader>tg`)

> <sup id="1">[1]</sup> Todas las Nerd Fonts descargables contienen iconos que son utilizados por TurboNvim. Instala la Nerd Font de tu elección en tu sistema y, en la configuración de tu emulador de terminal, establece la fuente como esa Nerd Font. Si estás usando TurboNvim en un sistema remoto vía SSH, no necesitas instalar la fuente en el sistema remoto.

> <sup id="2">[2]</sup> Nota al usar el tema por defecto: En MacOS, la terminal predeterminada no tiene soporte de colores reales. Necesitarás usar [iTerm2](https://iterm2.com/), [Kitty](https://sw.kovidgoyal.net/kitty/), [WezTerm](https://wezfurlong.org/wezterm/), u otro [emulador de terminal](https://gist.github.com/XVilka/8346728#terminal-emulators) que tenga soporte de colores reales.

## 🛠️ Instalación

### Linux/Mac OS (Unix)

#### Haz una copia de seguridad de tu nvim actual y de la carpeta compartida

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Clona el repositorio

```shell
git clone --depth 1 https://github.com/a1401358759/TurboNvim ~/.config/nvim
nvim
```

### Windows (Powershell)

#### Haz una copia de seguridad de tu nvim actual y de la carpeta nvim-data

```pwsh
Rename-Item -Path $env:LOCALAPPDATA\nvim -NewName $env:LOCALAPPDATA\nvim.bak
Rename-Item -Path $env:LOCALAPPDATA\nvim-data -NewName $env:LOCALAPPDATA\nvim-data.bak
```

#### Clona el repositorio

```pwsh
git clone --depth 1 https://github.com/a1401358759/TurboNvim $env:LOCALAPPDATA\nvim
nvim
```

## 📦 Configuración Básica

#### Instalar LSP

Ingresa `:LspInstall` seguido del nombre del servidor que desees instalar<br>
Ejemplo: `:LspInstall pyright`

#### Instalar parser de lenguaje

Ingresa `:TSInstall` seguido del nombre del lenguaje que desees instalar<br>
Ejemplo: `:TSInstall python`

#### Instalar Debugger

Ingresa `:DapInstall` seguido del nombre del debugger que desees instalar<br>
Ejemplo: `:DapInstall python`

#### Gestionar plugins

Ejecuta `:Lazy check` para buscar actualizaciones de plugins

Ejecuta `:Lazy update` para aplicar cualquier actualización de plugin pendiente

Ejecuta `:Lazy clean` para eliminar plugins deshabilitados o no utilizados

Ejecuta `:Lazy sync` para actualizar y limpiar plugins


## ⭐ Créditos

Sincero agradecimiento a los siguientes repositorios, autores de plugins y a toda la comunidad de neovim que hicieron posible el desarrollo de TurboNvim.

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim/tree/main)
- [NvChad](https://github.com/NvChad/NvChad)

<div align="center" id="madewithlua">

[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)](https://lua.org)

</div>
