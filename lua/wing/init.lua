--- Wing colorscheme — Wing OS "Void Scale" design system.
--- The Living Archive / Technical Archivist: 95% monochrome, color is
--- strictly semantic (focus / positive / negative / warn / info).
---
--- Variants (Hendrix tracks):
---   joe          default dark, #0a0a0a soft-lift, IPS-friendly
---   voodoo       AMOLED, true #000000, bumped contrast
---   little_wing  warm parchment #edeaea, high-glare / long-form reading
local M = {}

local palettes = require("wing.palettes")
local highlights = require("wing.highlights")

---@class WingOpts
---@field transparent? boolean     Strip background from Normal, NormalNC, NormalFloat, SignColumn, etc.
---@field italic_comments? boolean Use italic for comments (default true)
---@field bold_keywords? boolean   Use bold for keywords (default true)
---@field bold_functions? boolean  Use bold for functions (default true)
---@field terminal_colors? boolean Set terminal ANSI colors (default true)
---@field on_colors? fun(palette: table): nil  Mutate palette before highlights
---@field on_highlights? fun(hl: table, palette: table): nil  Override highlight groups

---@type WingOpts
M._opts = {
  transparent = false,
  italic_comments = true,
  bold_keywords = true,
  bold_functions = true,
  terminal_colors = true,
}

---@param opts? WingOpts
function M.setup(opts)
  M._opts = vim.tbl_deep_extend("force", M._opts, opts or {})
end

--- Apply terminal ANSI colors from palette
---@param terminal_colors string[]
local function apply_terminal_colors(terminal_colors)
  for i, color in ipairs(terminal_colors) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

--- Apply transparency overrides
---@param transparent_groups table<string, boolean>
local function apply_transparency(transparent_groups)
  for group in pairs(transparent_groups) do
    local existing = vim.api.nvim_get_hl(0, { name = group })
    existing.bg = nil
    vim.api.nvim_set_hl(0, group, existing)
  end
end

--- Map a variant name to a palette table in `palettes`.
--- Accepts canonical Wing OS names (joe/voodoo/little_wing), the legacy
--- dark/light/auto aliases, and the `little-wing` hyphenated spelling used
--- by the colors/ shim filename.
---@param variant string
---@return table
local function resolve_palette(variant)
  if variant == "auto" then
    -- Default dark = joe (the spec-designated daily driver), not voodoo.
    -- Voodoo is opt-in for AMOLED panels.
    variant = vim.o.background == "dark" and "joe" or "little_wing"
  elseif variant == "dark" then
    variant = "joe"
  elseif variant == "light" then
    variant = "little_wing"
  elseif variant == "little-wing" then
    variant = "little_wing"
  end

  local p = palettes[variant]
  if not p then
    vim.notify(
      "wing.nvim: unknown variant '" .. variant .. "', falling back to joe",
      vim.log.levels.WARN
    )
    p = palettes.joe
  end
  return vim.deepcopy(p)
end

---@param variant? "joe"|"voodoo"|"little_wing"|"dark"|"light"|"auto"
function M.load(variant)
  variant = variant or "auto"
  local opts = M._opts

  local palette = resolve_palette(variant)

  -- User palette mutations
  if opts.on_colors then
    opts.on_colors(palette)
  end

  -- Clear and reset
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true

  -- Apply style toggles to palette metadata (used by highlights.apply)
  palette._opts = {
    italic_comments = opts.italic_comments,
    bold_keywords = opts.bold_keywords,
    bold_functions = opts.bold_functions,
  }

  -- Core highlights
  highlights.apply(palette)

  -- User highlight overrides
  if opts.on_highlights then
    local overrides = {}
    opts.on_highlights(overrides, palette)
    for group, hl_opts in pairs(overrides) do
      vim.api.nvim_set_hl(0, group, hl_opts)
    end
  end

  -- Transparency
  if opts.transparent then
    apply_transparency({
      Normal = true,
      NormalNC = true,
      NormalFloat = true,
      SignColumn = true,
      CursorLine = true,
      TabLineFill = true,
      StatusLine = true,
      StatusLineNC = true,
    })
  end

  -- Terminal colors
  if opts.terminal_colors and palette.terminal then
    apply_terminal_colors(palette.terminal)
  end
end

return M
