local M = {}

--- Apply all highlight groups for the given palette
---@param p table palette colors
function M.apply(p)
  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- ── Editor UI ──────────────────────────────────────────────

  -- Base
  hi("Normal", { fg = p.fg, bg = p.bg })
  hi("NormalNC", { fg = p.fg_dim, bg = p.bg })
  hi("NormalFloat", { fg = p.fg, bg = p.bg_float })
  hi("FloatBorder", { fg = p.border, bg = p.bg_float })
  hi("FloatTitle", { fg = p.accent, bg = p.bg_float, bold = true })

  -- Cursor
  hi("Cursor", { fg = p.bg, bg = p.fg })
  hi("CursorLine", { bg = p.cursor_line })
  hi("CursorLineNr", { fg = p.accent, bold = true })
  hi("LineNr", { fg = p.fg_muted })
  hi("SignColumn", { bg = p.bg })
  hi("FoldColumn", { fg = p.fg_muted, bg = p.bg })
  hi("Folded", { fg = p.fg_muted, bg = p.bg_alt })

  -- Status line
  hi("StatusLine", { fg = p.fg, bg = p.bg_alt })
  hi("StatusLineNC", { fg = p.fg_dim, bg = p.bg_alt })

  -- Tab line
  hi("TabLine", { fg = p.fg_dim, bg = p.bg_alt })
  hi("TabLineFill", { bg = p.bg_alt })
  hi("TabLineSel", { fg = p.fg, bg = p.bg, bold = true })

  -- Separators
  hi("WinSeparator", { fg = p.border })
  hi("VertSplit", { fg = p.border })

  -- Selection
  hi("Visual", { bg = p.selection })
  hi("VisualNOS", { bg = p.selection })

  -- Search
  hi("Search", { fg = p.bg, bg = p.accent })
  hi("IncSearch", { fg = p.bg, bg = p.accent, bold = true })
  hi("CurSearch", { fg = p.bg, bg = p.accent, bold = true })
  hi("Substitute", { fg = p.bg, bg = p.warn })

  -- Matching
  hi("MatchParen", { fg = p.accent, bold = true, underline = true })

  -- Non-text
  hi("NonText", { fg = p.border })
  hi("SpecialKey", { fg = p.border })
  hi("Whitespace", { fg = p.border })
  hi("EndOfBuffer", { fg = p.bg })

  -- Popups
  hi("Pmenu", { fg = p.fg, bg = p.bg_float })
  hi("PmenuSel", { fg = p.fg, bg = p.selection, bold = true })
  hi("PmenuSbar", { bg = p.bg_alt })
  hi("PmenuThumb", { bg = p.border })

  -- Messages
  hi("ErrorMsg", { fg = p.error, bold = true })
  hi("WarningMsg", { fg = p.warn, bold = true })
  hi("MoreMsg", { fg = p.info })
  hi("ModeMsg", { fg = p.fg_dim, bold = true })
  hi("Question", { fg = p.info })

  -- ── Syntax ─────────────────────────────────────────────────

  hi("Comment", { fg = p.comment, italic = true })

  hi("Constant", { fg = p.fg })
  hi("String", { fg = p.accent_secondary })
  hi("Character", { fg = p.accent_secondary })
  hi("Number", { fg = p.fg })
  hi("Boolean", { fg = p.fg, bold = true })
  hi("Float", { fg = p.fg })

  hi("Identifier", { fg = p.fg })
  hi("Function", { fg = p.fg, bold = true })

  hi("Statement", { fg = p.accent })
  hi("Conditional", { fg = p.accent })
  hi("Repeat", { fg = p.accent })
  hi("Label", { fg = p.accent })
  hi("Operator", { fg = p.fg_dim })
  hi("Keyword", { fg = p.accent, bold = true })
  hi("Exception", { fg = p.accent })

  hi("PreProc", { fg = p.fg_dim })
  hi("Include", { fg = p.fg_dim })
  hi("Define", { fg = p.fg_dim })
  hi("Macro", { fg = p.fg_dim })
  hi("PreCondit", { fg = p.fg_dim })

  hi("Type", { fg = p.fg })
  hi("StorageClass", { fg = p.accent })
  hi("Structure", { fg = p.fg })
  hi("Typedef", { fg = p.fg })

  hi("Special", { fg = p.fg })
  hi("SpecialChar", { fg = p.accent_secondary })
  hi("Tag", { fg = p.accent })
  hi("Delimiter", { fg = p.fg_dim })
  hi("SpecialComment", { fg = p.comment, bold = true })
  hi("Debug", { fg = p.warn })

  hi("Underlined", { underline = true })
  hi("Ignore", { fg = p.fg_muted })
  hi("Error", { fg = p.error, bold = true })
  hi("Todo", { fg = p.warn, bold = true })

  -- ── Diagnostics ────────────────────────────────────────────

  hi("DiagnosticError", { fg = p.error })
  hi("DiagnosticWarn", { fg = p.warn })
  hi("DiagnosticInfo", { fg = p.info })
  hi("DiagnosticHint", { fg = p.hint })
  hi("DiagnosticOk", { fg = p.accent_secondary })

  hi("DiagnosticUnderlineError", { undercurl = true, sp = p.error })
  hi("DiagnosticUnderlineWarn", { undercurl = true, sp = p.warn })
  hi("DiagnosticUnderlineInfo", { undercurl = true, sp = p.info })
  hi("DiagnosticUnderlineHint", { undercurl = true, sp = p.hint })

  hi("DiagnosticVirtualTextError", { fg = p.error, italic = true })
  hi("DiagnosticVirtualTextWarn", { fg = p.warn, italic = true })
  hi("DiagnosticVirtualTextInfo", { fg = p.info, italic = true })
  hi("DiagnosticVirtualTextHint", { fg = p.hint, italic = true })

  -- ── LSP ────────────────────────────────────────────────────

  hi("LspReferenceText", { bg = p.selection })
  hi("LspReferenceRead", { bg = p.selection })
  hi("LspReferenceWrite", { bg = p.selection })
  hi("LspSignatureActiveParameter", { fg = p.accent, bold = true })

  -- ── Treesitter ─────────────────────────────────────────────

  hi("@comment", { link = "Comment" })
  hi("@punctuation", { fg = p.fg_dim })
  hi("@constant", { link = "Constant" })
  hi("@constant.builtin", { fg = p.fg, bold = true })
  hi("@string", { link = "String" })
  hi("@string.documentation", { fg = p.accent_secondary, italic = true })
  hi("@character", { link = "Character" })
  hi("@number", { link = "Number" })
  hi("@boolean", { link = "Boolean" })
  hi("@float", { link = "Float" })
  hi("@function", { link = "Function" })
  hi("@function.builtin", { fg = p.fg, bold = true })
  hi("@function.macro", { fg = p.accent_dim })
  hi("@parameter", { fg = p.fg })
  hi("@keyword", { link = "Keyword" })
  hi("@keyword.return", { fg = p.accent, bold = true })
  hi("@conditional", { link = "Conditional" })
  hi("@repeat", { link = "Repeat" })
  hi("@label", { link = "Label" })
  hi("@operator", { link = "Operator" })
  hi("@exception", { link = "Exception" })
  hi("@type", { link = "Type" })
  hi("@type.builtin", { fg = p.fg })
  hi("@namespace", { fg = p.fg_dim })
  hi("@variable", { fg = p.fg })
  hi("@variable.builtin", { fg = p.fg, italic = true })
  hi("@text", { fg = p.fg })
  hi("@text.strong", { bold = true })
  hi("@text.emphasis", { italic = true })
  hi("@text.underline", { underline = true })
  hi("@text.title", { fg = p.accent, bold = true })
  hi("@text.uri", { fg = p.accent_secondary, underline = true })
  hi("@tag", { fg = p.accent })
  hi("@tag.attribute", { fg = p.fg })
  hi("@tag.delimiter", { fg = p.fg_dim })

  -- ── Markdown ───────────────────────────────────────────────

  hi("markdownHeadingDelimiter", { fg = p.accent, bold = true })
  hi("markdownH1", { fg = p.accent, bold = true })
  hi("markdownH2", { fg = p.accent, bold = true })
  hi("markdownH3", { fg = p.fg, bold = true })
  hi("markdownH4", { fg = p.fg, bold = true })
  hi("markdownH5", { fg = p.fg })
  hi("markdownH6", { fg = p.fg })
  hi("markdownBold", { bold = true })
  hi("markdownItalic", { italic = true })
  hi("markdownCode", { fg = p.accent_secondary, bg = p.bg_alt })
  hi("markdownCodeBlock", { fg = p.accent_secondary })
  hi("markdownLinkText", { fg = p.accent_secondary, underline = true })
  hi("markdownUrl", { fg = p.fg_muted, underline = true })

  -- ── Git ────────────────────────────────────────────────────

  hi("GitSignsAdd", { fg = p.add })
  hi("GitSignsChange", { fg = p.change })
  hi("GitSignsDelete", { fg = p.delete })

  hi("DiffAdd", { fg = p.add, bg = p.bg_alt })
  hi("DiffChange", { fg = p.change, bg = p.bg_alt })
  hi("DiffDelete", { fg = p.delete, bg = p.bg_alt })
  hi("DiffText", { fg = p.warn, bg = p.bg_alt, bold = true })

  -- ── Telescope / FZF ────────────────────────────────────────

  hi("TelescopeNormal", { fg = p.fg, bg = p.bg })
  hi("TelescopeBorder", { fg = p.border, bg = p.bg })
  hi("TelescopePromptNormal", { fg = p.fg, bg = p.bg_alt })
  hi("TelescopePromptBorder", { fg = p.border, bg = p.bg_alt })
  hi("TelescopePromptTitle", { fg = p.accent, bg = p.bg_alt, bold = true })
  hi("TelescopePreviewTitle", { fg = p.accent, bold = true })
  hi("TelescopeResultsTitle", { fg = p.accent, bold = true })
  hi("TelescopeSelection", { bg = p.selection })
  hi("TelescopeMatching", { fg = p.accent, bold = true })

  -- ── Which-Key ──────────────────────────────────────────────

  hi("WhichKey", { fg = p.accent })
  hi("WhichKeyGroup", { fg = p.fg })
  hi("WhichKeyDesc", { fg = p.fg_dim })
  hi("WhichKeySeperator", { fg = p.border })
  hi("WhichKeySeparator", { fg = p.border })
  hi("WhichKeyFloat", { bg = p.bg_float })
  hi("WhichKeyValue", { fg = p.fg_muted })

  -- ── Completion ─────────────────────────────────────────────

  hi("CmpItemAbbr", { fg = p.fg })
  hi("CmpItemAbbrDeprecated", { fg = p.fg_muted, strikethrough = true })
  hi("CmpItemAbbrMatch", { fg = p.accent, bold = true })
  hi("CmpItemAbbrMatchFuzzy", { fg = p.accent, bold = true })
  hi("CmpItemKind", { fg = p.accent_secondary })
  hi("CmpItemMenu", { fg = p.fg_dim })
end

return M
