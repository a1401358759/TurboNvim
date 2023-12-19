local M = {}

M.icons = {
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
    untracked = " ",
    ignored = " ",
    -- unstaged = "󰄱",
    unstaged = "",
    staged = " ",
    conflict = " ",
  },
  lspkind = {
    Array = "󰅪 ",
    Boolean = " ",
    BreakStatement = "󰙧 ",
    Call = "󰃷 ",
    CaseStatement = "󱃙 ",
    Calendar = " ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = "󰏘 ",
    Constant = "󰏿 ",
    Constructor = " ",
    ContinueStatement = "→ ",
    Copilot = " ",
    Declaration = "󰙠 ",
    Delete = "󰩺 ",
    DoStatement = "󰑖 ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = "󰈔 ",
    Folder = "󰉋 ",
    ForStatement = "󰑖 ",
    Function = "󰊕 ",
    H1Marker = "󰉫 ", -- Used by markdown treesitter parser
    H2Marker = "󰉬 ",
    H3Marker = "󰉭 ",
    H4Marker = "󰉮 ",
    H5Marker = "󰉯 ",
    H6Marker = "󰉰 ",
    Identifier = "󰀫 ",
    IfStatement = "󰇉 ",
    Interface = " ",
    Keyword = "󰌋 ",
    List = "󰅪 ",
    Log = "󰦪 ",
    Lsp = " ",
    Macro = "󰁌 ",
    MarkdownH1 = "󰉫 ", -- Used by builtin markdown source
    MarkdownH2 = "󰉬 ",
    MarkdownH3 = "󰉭 ",
    MarkdownH4 = "󰉮 ",
    MarkdownH5 = "󰉯 ",
    MarkdownH6 = "󰉰 ",
    Method = "󰆧 ",
    Module = "󰏗 ",
    Namespace = "󰅩 ",
    Null = "󰢤 ",
    Number = "󰎠 ",
    Object = "󰅩 ",
    Operator = "󰆕 ",
    Package = "󰆦 ",
    Pair = "󰅪 ",
    Property = "󰜢 ",
    Reference = "󰦾 ",
    Regex = " ",
    Repeat = "󰑖 ",
    Scope = "󰅩 ",
    Snippet = " ",
    Specifier = "󰦪 ",
    Statement = "󰅩 ",
    String = "󰉾 ",
    Struct = " ",
    SwitchStatement = "󰺟 ",
    Table = " ",
    TabNine = "󱚦 ",
    Tag = " ",
    Terminal = " ",
    Text = "󰉿 ",
    Type = " ",
    TypeParameter = "󰆩 ",
    Unit = " ",
    Value = "󰎠 ",
    Variable = "󰀫 ",
    WhileStatement = "󰑖 ",
  },
  ui = {
    Arrow = "➜ ",
    ArrowClosed = " ",
    ArrowLeft = " ",
    ArrowOpen = " ",
    ArrowRight = " ",
    Bluetooth = " ",
    Bookmark = " ",
    Bug = " ",
    Calendar = " ",
    Camera = " ",
    Check = " ",
    ChevronRight = "",
    Circle = " ",
    CircleSmall = "● ",
    CircleSmallEmpty = "○ ",
    Clipboard = " ",
    Close = " ",
    Code = " ",
    Collection = " ",
    Color = " ",
    Command = " ",
    Comment = " ",
    Corner = "└ ",
    Dashboard = " ",
    Database = " ",
    Download = " ",
    Edge = "│ ",
    Electric = " ",
    Fire = " ",
    Firefox = " ",
    Game = " ",
    Gear = " ",
    GitHub = " ",
    Heart = " ",
    History = " ",
    Home = " ",
    Incoming = " ",
    Keyboard = "  ",
    List = "",
    Lock = " ",
    Minus = "‒ ",
    Music = " ",
    NeoVim = " ",
    NewFile = " ",
    None = " ",
    Note = " ",
    Outgoing = " ",
    Package = " ",
    Paint = " ",
    Pause = " ",
    Pencil = " ",
    Person = " ",
    Pin = "車 ",
    Play = " ",
    Plug = " ",
    Plus = " ",
    Power = " ",
    PowerlineArrowLeft = "",
    PowerlineArrowRight = "",
    PowerlineLeftRound = "",
    PowerlineRightRound = "",
    Project = " ",
    Question = " ",
    Reload = " ",
    Rocket = " ",
    Search = " ",
    Separator = "▊ ",
    SignIn = " ",
    SignOut = " ",
    Sleep = "󰒲 ",
    Star = " ",
    Table = " ",
    Telescope = " ",
    Terminal = " ",
    Test = " ",
    Time = " ",
    Trash = " ",
    Vim = " ",
    Wifi = " ",
    Windows = " ",
  },
}

M.devicons = {
  default_icon = {
    icon = "",
    name = "Default",
  },

  c = {
    icon = "",
    name = "c",
  },

  css = {
    icon = "",
    name = "css",
  },

  deb = {
    icon = "",
    name = "deb",
  },

  Dockerfile = {
    icon = "",
    name = "Dockerfile",
  },

  html = {
    icon = "",
    name = "html",
  },

  jpeg = {
    icon = "",
    name = "jpeg",
  },

  jpg = {
    icon = "",
    name = "jpg",
  },

  js = {
    icon = "",
    name = "js",
  },

  kt = {
    icon = "󱈙",
    name = "kt",
  },

  lock = {
    icon = "",
    name = "lock",
  },

  lua = {
    icon = "",
    name = "lua",
  },

  mp3 = {
    icon = "",
    name = "mp3",
  },

  mp4 = {
    icon = "",
    name = "mp4",
  },

  out = {
    icon = "",
    name = "out",
  },

  png = {
    icon = "",
    name = "png",
  },

  ["robots.txt"] = {
    icon = "ﮧ",
    name = "robots",
  },

  toml = {
    icon = "",
    name = "toml",
  },

  ts = {
    icon = "ﯤ",
    name = "ts",
  },

  ttf = {
    icon = "",
    name = "TrueTypeFont",
  },

  rb = {
    icon = "",
    name = "rb",
  },

  rpm = {
    icon = "",
    name = "rpm",
  },

  vue = {
    icon = "﵂",
    name = "vue",
  },

  woff = {
    icon = "",
    name = "WebOpenFontFormat",
  },

  woff2 = {
    icon = "",
    name = "WebOpenFontFormat2",
  },

  xz = {
    icon = "",
    name = "xz",
  },

  zip = {
    icon = "",
    name = "zip",
  },
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh",
  },
}

return M
