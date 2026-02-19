--- Wing colorscheme — "The Void" Design System
--- Premium, refined, calm. 95% monochrome with intentional accents.
local M = {}

local palettes = require("wing.palettes")
local highlights = require("wing.highlights")

---@param variant? "dark"|"light"|"auto"
function M.load(variant)
  variant = variant or "auto"

  local palette
  if variant == "auto" then
    palette = vim.o.background == "dark" and palettes.dark or palettes.light
  elseif variant == "dark" then
    palette = palettes.dark
  else
    palette = palettes.light
  end

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  highlights.apply(palette)
end

---@param opts? { variant?: "dark"|"light"|"auto" }
function M.setup(opts)
  opts = opts or {}
  M._variant = opts.variant or "auto"
end

return M
