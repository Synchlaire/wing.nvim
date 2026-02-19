local M = {}

M.dark = {
  -- Background layers (pure black to subtle elevation)
  bg = "#000000",       -- OLED pure black
  bg_alt = "#0A0A0A",   -- Barely elevated surface
  bg_float = "#111111", -- Floating windows

  -- Text (comfortable contrast)
  fg = "#E8E8E8",       -- Primary: softened white
  fg_dim = "#888888",   -- Secondary: muted gray
  fg_muted = "#555555", -- Muted: comments, hints

  -- Accents (refined, not neon)
  accent = "#FF6B35",           -- Primary: warm orange
  accent_dim = "#CC4A1E",       -- Darker for hover states
  accent_secondary = "#4EC9B0", -- Teal-green: strings, success

  -- Semantic
  error = "#E06C75", -- Soft red
  warn = "#D19A66",  -- Warm amber
  info = "#61AFEF",  -- Soft blue
  hint = "#4EC9B0",  -- Teal

  -- Git/diff
  add = "#4EC9B0",
  change = "#FF6B35",
  delete = "#E06C75",

  -- UI elements
  selection = "#1A1A1A",
  comment = "#555555",
  border = "#222222",
  border_focus = "#FF6B35",
  cursor_line = "#0A0A0A",

  -- Terminal (ANSI 16 colors)
  terminal = {
    "#0A0A0A", -- black
    "#E06C75", -- red
    "#4EC9B0", -- green
    "#D19A66", -- yellow
    "#61AFEF", -- blue
    "#C678DD", -- magenta
    "#56B6C2", -- cyan
    "#888888", -- white (dim)
    "#555555", -- bright black
    "#FF6B35", -- bright red (accent)
    "#5AD4C0", -- bright green
    "#E5C07B", -- bright yellow
    "#7EC8F2", -- bright blue
    "#D8A0E8", -- bright magenta
    "#6CC9D4", -- bright cyan
    "#E8E8E8", -- bright white
  },
}

M.light = {
  -- Background (warm off-white)
  bg = "#EDEAEA",
  bg_alt = "#E5E2E2",
  bg_float = "#DDDADA",

  -- Text (high contrast)
  fg = "#1A1A1A",
  fg_dim = "#444444",
  fg_muted = "#777777",

  -- Accents (saturated but controlled)
  accent = "#E85D04",
  accent_dim = "#C44D00",
  accent_secondary = "#2A9D8F",

  -- Semantic
  error = "#E63946",
  warn = "#F4A261",
  info = "#4361EE",
  hint = "#2A9D8F",

  -- Git/diff
  add = "#2A9D8F",
  change = "#E85D04",
  delete = "#E63946",

  -- UI elements
  selection = "#D5D2D2",
  comment = "#8B8686",
  border = "#C5C0C0",
  border_focus = "#E85D04",
  cursor_line = "#E5E2E2",

  -- Terminal (ANSI 16 colors)
  terminal = {
    "#DDDADA", -- black (light bg surface)
    "#E63946", -- red
    "#2A9D8F", -- green
    "#F4A261", -- yellow
    "#4361EE", -- blue
    "#9B59B6", -- magenta
    "#2A9D8F", -- cyan
    "#444444", -- white (dim text)
    "#C5C0C0", -- bright black
    "#E85D04", -- bright red (accent)
    "#35B8A6", -- bright green
    "#F5B77A", -- bright yellow
    "#5A7DF7", -- bright blue
    "#B07CC8", -- bright magenta
    "#35B8A6", -- bright cyan
    "#1A1A1A", -- bright white
  },
}

return M
