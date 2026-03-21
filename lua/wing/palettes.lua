local M = {}

M.dark = {
  -- Background layers (Voodoo — pure black to subtle elevation)
  bg = "#000000",       -- void-0: OLED pure black
  bg_alt = "#0A0A0A",   -- void-05: barely elevated surface
  bg_float = "#111111", -- void-1: floating windows

  -- Text (comfortable contrast)
  fg = "#ebebeb",       -- void-6: primary text
  fg_dim = "#949494",   -- void-5: secondary text
  fg_muted = "#6a6a6a", -- void-4: comments, hints

  -- Accents (Wing OS tokens)
  accent = "#C0C8D0",           -- Focus: cool white
  accent_dim = "#949494",       -- Dimmed focus
  accent_secondary = "#00FF41", -- Positive: neon green (strings, success)

  -- Semantic
  error = "#FF3366", -- Negative: hot pink
  warn = "#C0C8D0",  -- Focus: cool white (warnings)
  info = "#00BFFF",  -- Info: cyan
  hint = "#00BFFF",  -- Info: cyan

  -- Git/diff
  add = "#00FF41",
  change = "#C0C8D0",
  delete = "#FF3366",

  -- UI elements
  selection = "#1A1A1A",  -- void-15
  comment = "#6a6a6a",    -- void-4
  border = "#2a2a2a",     -- void-2
  border_focus = "#C0C8D0",
  cursor_line = "#0A0A0A", -- void-05

  -- Terminal (ANSI 16 colors)
  terminal = {
    "#0A0A0A", -- black (void-05)
    "#FF3366", -- red (negative)
    "#00FF41", -- green (positive)
    "#FFB833", -- yellow
    "#C0C8D0", -- blue (focus)
    "#9070a8", -- magenta
    "#00BFFF", -- cyan (info)
    "#949494", -- white (void-5)
    "#6a6a6a", -- bright black (void-4)
    "#FF5C85", -- bright red
    "#33FF66", -- bright green
    "#FFCC66", -- bright yellow
    "#C0C8D0", -- bright blue (focus)
    "#a888c7", -- bright magenta
    "#33CCFF", -- bright cyan
    "#ebebeb", -- bright white (void-6)
  },
}

M.light = {
  -- Background (LittleWing — warm parchment)
  bg = "#EDEAEA",       -- void-0
  bg_alt = "#E5E2E2",   -- near-bg
  bg_float = "#DDDADA", -- surface

  -- Text (high contrast)
  fg = "#141414",       -- void-6
  fg_dim = "#505050",   -- void-5
  fg_muted = "#787878", -- void-4

  -- Accents (darkened for light backgrounds)
  accent = "#606870",           -- Focus: cool grey
  accent_dim = "#787878",       -- Dimmed focus
  accent_secondary = "#00CC33", -- Positive: dark neon green

  -- Semantic
  error = "#D92D57", -- Negative: dark hot pink
  warn = "#606870",  -- Focus: cool grey
  info = "#009FD4",  -- Info: dark cyan
  hint = "#009FD4",  -- Info: dark cyan

  -- Git/diff
  add = "#00CC33",
  change = "#606870",
  delete = "#D92D57",

  -- UI elements
  selection = "#D5D2D2",
  comment = "#787878",   -- void-4
  border = "#C5C0C0",
  border_focus = "#606870",
  cursor_line = "#E5E2E2",

  -- Terminal (ANSI 16 colors)
  terminal = {
    "#DDDADA", -- black (light surface)
    "#D92D57", -- red (negative)
    "#00CC33", -- green (positive)
    "#B38A00", -- yellow
    "#606870", -- blue (focus)
    "#806098", -- magenta
    "#009FD4", -- cyan (info)
    "#505050", -- white (dim text)
    "#C5C0C0", -- bright black
    "#FF3366", -- bright red
    "#00FF41", -- bright green
    "#FFB833", -- bright yellow
    "#C0C8D0", -- bright blue (focus bright)
    "#9070a8", -- bright magenta
    "#00BFFF", -- bright cyan
    "#141414", -- bright white
  },
}

return M
