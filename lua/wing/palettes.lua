--- Wing OS "Void Scale" palettes.
--- Three variants named after Hendrix tracks:
---   - joe          Default dark. Soft-lifted #0a0a0a, IPS-friendly daily driver.
---   - voodoo       AMOLED. True #000000 abyss, bumped contrast for night work.
---   - little_wing  Warm parchment #edeaea, long-form reading and high-glare.
---
--- Every palette carries the canonical void_0..void_6 scale (with half-steps
--- void_05 / void_15 / void_55) plus four semantic accents: focus, positive,
--- negative, info. Plus one derived `warn` per variant that isn't in the
--- design tokens — tuned here so diagnostics don't fall off a cliff. If the
--- Wing OS tokens add an official warn, update `warn` to match.
---
--- Legacy keys (bg, fg, accent, ...) are aliases onto the void scale so
--- highlights.lua can address both the new and old shape. Don't address void
--- steps directly from highlights — go through the semantic alias so a future
--- palette shuffle is a one-file change.
local M = {}

--- Build a palette from a raw void/accent spec.
--- @param spec table
--- @return table
local function build(spec)
  local v = spec.void
  local a = spec.accents
  return {
    -- Canonical void scale (always addressable by tools/tests)
    void_0 = v[1],
    void_05 = v[2],
    void_1 = v[3],
    void_15 = v[4],
    void_2 = v[5],
    void_3 = v[6],
    void_4 = v[7],
    void_5 = v[8],
    void_55 = v[9],
    void_6 = v[10],

    -- Semantic accents (sparingly used)
    focus = a.focus,
    positive = a.positive,
    negative = a.negative,
    info = a.info,
    warn = a.warn,

    -- ── Legacy aliases ───────────────────────────────────────
    -- Backgrounds collapse onto the low end of the scale.
    bg = v[1],        -- void_0    — editor background
    bg_alt = v[3],    -- void_1    — surfaces, statusline
    bg_float = v[4],  -- void_15   — floats, popups
    -- Text progression.
    fg = v[10],       -- void_6    — primary text
    fg_dim = v[9],    -- void_55   — secondary bright
    fg_muted = v[7],  -- void_4    — metadata, hints
    -- Accent aliases (single primary only — no secondary decorative).
    accent = a.focus,
    accent_dim = a.focus_dim,
    -- Intentionally omit accent_secondary: color is semantic, not decorative.
    -- highlights.lua must not reference it.
    -- Semantic error/warn/info/hint map onto the semantic accents.
    error = a.negative,
    hint = a.positive,
    -- UI chrome.
    selection = v[5],        -- void_2
    comment = v[7],          -- void_4 — metadata tier
    border = v[6],           -- void_3
    border_focus = a.focus,
    cursor_line = v[2],      -- void_05
    -- Git/diff collapsed onto semantic tokens.
    add = a.positive,
    change = a.warn,
    delete = a.negative,
    -- Terminal ANSI map.
    terminal = spec.terminal,
  }
end

--- Joe — default dark. The daily driver.
M.joe = build({
  void = {
    "#0a0a0a", -- void_0  background
    "#0f0f0f", -- void_05 near-bg
    "#141414", -- void_1  surface
    "#1c1c1c", -- void_15 elevated / hover
    "#2a2a2a", -- void_2  subtle border
    "#383838", -- void_3  border / divider
    "#6a6a6a", -- void_4  hint / metadata
    "#949494", -- void_5  secondary
    "#b8b8b8", -- void_55 secondary bright
    "#ebebeb", -- void_6  primary text
  },
  accents = {
    focus = "#5b98c0",
    focus_dim = "#3f6e8e",
    positive = "#5aad68",
    negative = "#c45858",
    info = "#00bfff",
    -- Derived: muted amber that sits between positive and negative in
    -- perceptual space without drifting into decorative territory.
    warn = "#c8944d",
  },
  terminal = {
    "#141414", -- 0  black       → void_1
    "#c45858", -- 1  red         → negative
    "#5aad68", -- 2  green       → positive
    "#c8944d", -- 3  yellow      → warn
    "#5b98c0", -- 4  blue        → focus
    "#9b6ea8", -- 5  magenta     (harmonized muted violet)
    "#00bfff", -- 6  cyan        → info
    "#b8b8b8", -- 7  white       → void_55
    "#6a6a6a", -- 8  bright blk  → void_4
    "#d46a6a", -- 9  bright red
    "#6cc17a", -- 10 bright grn
    "#d6a55d", -- 11 bright ylw
    "#7bb0d0", -- 12 bright blu
    "#b084bf", -- 13 bright mag
    "#4dd0ff", -- 14 bright cyn
    "#ebebeb", -- 15 bright wht → void_6
  },
})

--- Voodoo — AMOLED. True black, bumped contrast.
M.voodoo = build({
  void = {
    "#000000", -- void_0
    "#050505", -- void_05
    "#0a0a0a", -- void_1
    "#121212", -- void_15
    "#1c1c1c", -- void_2
    "#2e2e2e", -- void_3
    "#6a6a6a", -- void_4
    "#969696", -- void_5
    "#bcbcbc", -- void_55
    "#e8e8e8", -- void_6
  },
  accents = {
    focus = "#5b98c0",
    focus_dim = "#3f6e8e",
    positive = "#5aad68",
    negative = "#c45858",
    info = "#00bfff",
    warn = "#c8944d",
  },
  terminal = {
    "#0a0a0a",
    "#c45858",
    "#5aad68",
    "#c8944d",
    "#5b98c0",
    "#9b6ea8",
    "#00bfff",
    "#bcbcbc",
    "#6a6a6a",
    "#d46a6a",
    "#6cc17a",
    "#d6a55d",
    "#7bb0d0",
    "#b084bf",
    "#4dd0ff",
    "#e8e8e8",
  },
})

--- Little Wing — warm parchment, inverse monochrome.
M.little_wing = build({
  void = {
    "#edeaea", -- void_0
    "#e8e8e8", -- void_05
    "#dcdcdc", -- void_1
    "#d0d0d0", -- void_15
    "#c0c0c0", -- void_2
    "#a8a8a8", -- void_3
    "#787878", -- void_4
    "#505050", -- void_5
    "#303030", -- void_55
    "#141414", -- void_6
  },
  accents = {
    focus = "#3a7ba8",
    focus_dim = "#275a80",
    positive = "#3f8a4d",
    negative = "#a83e3e",
    info = "#0070a8",
    warn = "#a06a1e",
  },
  terminal = {
    "#dcdcdc",
    "#a83e3e",
    "#3f8a4d",
    "#a06a1e",
    "#3a7ba8",
    "#7a3e90",
    "#0070a8",
    "#303030",
    "#a8a8a8",
    "#c24a4a",
    "#4ea05c",
    "#b57a2a",
    "#4a8cba",
    "#8c4ca3",
    "#0088c8",
    "#141414",
  },
})

-- Legacy keys retained so existing colors/darkwing.lua and colors/lightwing.lua
-- keep working. `dark` → voodoo-equivalent is the wrong mapping — the original
-- darkwing background was #000000 (AMOLED), so `dark` aliases voodoo and
-- `light` aliases little_wing. If the user wants joe, use :colorscheme joe.
M.dark = M.voodoo
M.light = M.little_wing

return M
