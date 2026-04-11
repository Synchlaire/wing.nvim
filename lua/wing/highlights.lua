local M = {}

--- Apply all highlight groups for the given palette.
---
--- Color policy (Wing OS strict semantic):
---   • Color is ONLY semantic — never decorative. Strings, numbers, types,
---     functions, identifiers all read from the void scale.
---   • Hierarchy comes from weight (bold), style (italic), and the void scale
---     (fg / fg_dim / fg_muted / comment).
---   • The single accent is `focus` (cool blue). It marks keywords, the active
---     cursor-line number, search matches, and focused borders. That's it.
---   • Semantic accents (positive/negative/warn/info) appear only on
---     diagnostics, git state, and mode indicators.
---
--- If you're reaching for color on a syntax group, stop. Use void_55 / fg_dim
--- / italic / bold instead.
---@param p table palette colors (includes p._opts for style toggles)
function M.apply(p)
  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  local o = p._opts or {}
  local italic_comments = o.italic_comments ~= false
  local bold_keywords = o.bold_keywords ~= false
  local bold_functions = o.bold_functions ~= false

  -- ── Editor UI ──────────────────────────────────────────────

  hi("Normal", { fg = p.fg, bg = p.bg })
  hi("NormalNC", { fg = p.fg_dim, bg = p.bg })
  hi("NormalFloat", { fg = p.fg, bg = p.bg_float })
  hi("FloatBorder", { fg = p.border, bg = p.bg_float })
  hi("FloatTitle", { fg = p.fg, bg = p.bg_float, bold = true })

  hi("Cursor", { fg = p.bg, bg = p.fg })
  hi("CursorLine", { bg = p.cursor_line })
  hi("CursorLineNr", { fg = p.focus, bold = true })
  hi("CursorColumn", { bg = p.cursor_line })
  hi("ColorColumn", { bg = p.bg_alt })
  hi("LineNr", { fg = p.fg_muted })
  hi("SignColumn", { bg = p.bg })
  hi("FoldColumn", { fg = p.fg_muted, bg = p.bg })
  hi("Folded", { fg = p.fg_muted, bg = p.bg_alt })

  hi("StatusLine", { fg = p.fg, bg = p.bg_alt })
  hi("StatusLineNC", { fg = p.fg_dim, bg = p.bg_alt })

  hi("TabLine", { fg = p.fg_dim, bg = p.bg_alt })
  hi("TabLineFill", { bg = p.bg_alt })
  hi("TabLineSel", { fg = p.fg, bg = p.bg, bold = true })

  hi("WinSeparator", { fg = p.border })
  hi("VertSplit", { fg = p.border })
  hi("WinBar", { fg = p.fg_dim, bg = p.bg })
  hi("WinBarNC", { fg = p.fg_muted, bg = p.bg })

  hi("Visual", { bg = p.selection })
  hi("VisualNOS", { bg = p.selection })

  hi("Search", { fg = p.bg, bg = p.focus })
  hi("IncSearch", { fg = p.bg, bg = p.focus, bold = true })
  hi("CurSearch", { fg = p.bg, bg = p.focus, bold = true })
  hi("Substitute", { fg = p.bg, bg = p.warn })

  hi("MatchParen", { fg = p.focus, bold = true, underline = true })

  hi("NonText", { fg = p.border })
  hi("SpecialKey", { fg = p.border })
  hi("Whitespace", { fg = p.border })
  hi("EndOfBuffer", { fg = p.bg })

  hi("Pmenu", { fg = p.fg, bg = p.bg_float })
  hi("PmenuSel", { fg = p.fg, bg = p.selection, bold = true })
  hi("PmenuSbar", { bg = p.bg_alt })
  hi("PmenuThumb", { bg = p.border })

  hi("ErrorMsg", { fg = p.negative, bold = true })
  hi("WarningMsg", { fg = p.warn, bold = true })
  hi("MoreMsg", { fg = p.fg_dim })
  hi("ModeMsg", { fg = p.fg_dim, bold = true })
  hi("Question", { fg = p.fg_dim })
  hi("Title", { fg = p.fg, bold = true })
  hi("Directory", { fg = p.fg, bold = true })
  hi("Conceal", { fg = p.fg_muted })
  hi("SpellBad", { undercurl = true, sp = p.negative })
  hi("SpellCap", { undercurl = true, sp = p.warn })
  hi("SpellLocal", { undercurl = true, sp = p.info })
  hi("SpellRare", { undercurl = true, sp = p.positive })

  -- ── Syntax (strict semantic: color is reserved) ────────────
  --
  -- Everything non-keyword reads from the void scale. Identifiers,
  -- functions, types, strings, numbers, booleans — all p.fg. Hierarchy
  -- is carried by bold and italic, not hue.

  hi("Comment", { fg = p.comment, italic = italic_comments })

  hi("Constant", { fg = p.fg })
  hi("String", { fg = p.fg })
  hi("Character", { fg = p.fg })
  -- Numerics read as italic to distinguish literals-of-distinction from
  -- identifiers without spending a color on them.
  hi("Number", { fg = p.fg, italic = true })
  hi("Boolean", { fg = p.fg, italic = true, bold = true })
  hi("Float", { fg = p.fg, italic = true })

  hi("Identifier", { fg = p.fg })
  -- Function definitions get weight; call sites stay plain. Discrimination
  -- through weight, not hue.
  hi("Function", { fg = p.fg, bold = bold_functions })

  hi("Statement", { fg = p.focus })
  hi("Conditional", { fg = p.focus })
  hi("Repeat", { fg = p.focus })
  hi("Label", { fg = p.focus })
  hi("Operator", { fg = p.fg_dim })
  hi("Keyword", { fg = p.focus, bold = bold_keywords })
  hi("Exception", { fg = p.focus })

  hi("PreProc", { fg = p.fg_dim })
  hi("Include", { fg = p.fg_dim })
  hi("Define", { fg = p.fg_dim })
  hi("Macro", { fg = p.fg_dim })
  hi("PreCondit", { fg = p.fg_dim })

  -- Types share the focus accent with keywords: structural declarations
  -- are the same semantic category as class/struct/fn keywords.
  hi("Type", { fg = p.focus })
  hi("StorageClass", { fg = p.focus })
  hi("Structure", { fg = p.focus })
  hi("Typedef", { fg = p.focus })

  hi("Special", { fg = p.fg_dim })
  hi("SpecialChar", { fg = p.fg_dim })
  hi("Tag", { fg = p.fg_dim })
  hi("Delimiter", { fg = p.fg_dim })
  hi("SpecialComment", { fg = p.comment, bold = true })
  hi("Debug", { fg = p.warn })

  hi("Underlined", { underline = true })
  hi("Ignore", { fg = p.fg_muted })
  hi("Error", { fg = p.negative, bold = true })
  hi("Todo", { fg = p.warn, bold = true })

  -- ── Diagnostics ────────────────────────────────────────────

  hi("DiagnosticError", { fg = p.negative })
  hi("DiagnosticWarn", { fg = p.warn })
  hi("DiagnosticInfo", { fg = p.info })
  hi("DiagnosticHint", { fg = p.positive })
  hi("DiagnosticOk", { fg = p.positive })

  hi("DiagnosticUnderlineError", { undercurl = true, sp = p.negative })
  hi("DiagnosticUnderlineWarn", { undercurl = true, sp = p.warn })
  hi("DiagnosticUnderlineInfo", { undercurl = true, sp = p.info })
  hi("DiagnosticUnderlineHint", { undercurl = true, sp = p.positive })

  hi("DiagnosticVirtualTextError", { fg = p.negative, bg = p.bg_alt, italic = true })
  hi("DiagnosticVirtualTextWarn", { fg = p.warn, bg = p.bg_alt, italic = true })
  hi("DiagnosticVirtualTextInfo", { fg = p.info, bg = p.bg_alt, italic = true })
  hi("DiagnosticVirtualTextHint", { fg = p.positive, bg = p.bg_alt, italic = true })

  hi("DiagnosticFloatingError", { fg = p.negative })
  hi("DiagnosticFloatingWarn", { fg = p.warn })
  hi("DiagnosticFloatingInfo", { fg = p.info })
  hi("DiagnosticFloatingHint", { fg = p.positive })

  hi("DiagnosticSignError", { fg = p.negative })
  hi("DiagnosticSignWarn", { fg = p.warn })
  hi("DiagnosticSignInfo", { fg = p.info })
  hi("DiagnosticSignHint", { fg = p.positive })

  -- ── LSP ────────────────────────────────────────────────────

  hi("LspReferenceText", { bg = p.selection })
  hi("LspReferenceRead", { bg = p.selection })
  hi("LspReferenceWrite", { bg = p.selection })
  hi("LspSignatureActiveParameter", { fg = p.focus, bold = true })
  hi("LspCodeLens", { fg = p.fg_muted })
  hi("LspCodeLensSeparator", { fg = p.border })
  hi("LspInlayHint", { fg = p.fg_muted, bg = p.bg_alt, italic = true })

  -- ── Treesitter ─────────────────────────────────────────────

  hi("@comment", { link = "Comment" })
  hi("@punctuation", { fg = p.fg_dim })
  hi("@punctuation.bracket", { fg = p.fg_dim })
  hi("@punctuation.delimiter", { fg = p.fg_dim })
  hi("@punctuation.special", { fg = p.fg_dim })
  hi("@constant", { link = "Constant" })
  hi("@constant.builtin", { fg = p.fg, italic = true, bold = true })
  hi("@constant.macro", { fg = p.fg })
  hi("@string", { link = "String" })
  hi("@string.documentation", { fg = p.fg_dim, italic = true })
  hi("@string.regex", { fg = p.fg_dim })
  hi("@string.escape", { fg = p.fg_dim, bold = true })
  hi("@character", { link = "Character" })
  hi("@number", { link = "Number" })
  hi("@boolean", { link = "Boolean" })
  hi("@float", { link = "Float" })
  hi("@function", { link = "Function" })
  hi("@function.builtin", { fg = p.fg, bold = bold_functions })
  hi("@function.macro", { fg = p.fg_dim })
  -- Call sites: no bold. Keeps definitions visually louder than invocations.
  hi("@function.call", { fg = p.fg })
  hi("@method", { fg = p.fg, bold = bold_functions })
  hi("@method.call", { fg = p.fg })
  hi("@parameter", { fg = p.fg })
  hi("@keyword", { link = "Keyword" })
  hi("@keyword.function", { fg = p.focus })
  hi("@keyword.operator", { fg = p.focus })
  hi("@keyword.return", { fg = p.focus, bold = bold_keywords })
  hi("@conditional", { link = "Conditional" })
  hi("@repeat", { link = "Repeat" })
  hi("@label", { link = "Label" })
  hi("@operator", { link = "Operator" })
  hi("@exception", { link = "Exception" })
  hi("@type", { link = "Type" })
  hi("@type.builtin", { fg = p.focus })
  hi("@type.qualifier", { fg = p.focus })
  hi("@namespace", { fg = p.fg_dim })
  hi("@include", { link = "Include" })
  hi("@variable", { fg = p.fg })
  hi("@variable.builtin", { fg = p.fg, italic = true })
  hi("@property", { fg = p.fg })
  hi("@field", { fg = p.fg })
  hi("@constructor", { fg = p.fg })
  hi("@text", { fg = p.fg })
  hi("@text.strong", { bold = true })
  hi("@text.emphasis", { italic = true })
  hi("@text.underline", { underline = true })
  hi("@text.strike", { strikethrough = true })
  hi("@text.title", { fg = p.fg, bold = true })
  hi("@text.literal", { fg = p.fg_dim })
  hi("@text.uri", { fg = p.focus, underline = true })
  hi("@text.reference", { fg = p.fg_dim })
  hi("@text.todo", { link = "Todo" })
  hi("@text.note", { fg = p.info, bold = true })
  hi("@text.warning", { fg = p.warn, bold = true })
  hi("@text.danger", { fg = p.negative, bold = true })
  hi("@tag", { fg = p.focus })
  hi("@tag.attribute", { fg = p.fg })
  hi("@tag.delimiter", { fg = p.fg_dim })

  -- ── Markdown ───────────────────────────────────────────────
  --
  -- Headings carry weight via bold + the void scale stepping down. No
  -- color — the Wing OS spec explicitly rejects decorative heading color.

  hi("markdownHeadingDelimiter", { fg = p.fg_muted })
  hi("markdownH1", { fg = p.fg, bold = true })
  hi("markdownH2", { fg = p.fg, bold = true })
  hi("markdownH3", { fg = p.fg_dim, bold = true })
  hi("markdownH4", { fg = p.fg_dim, bold = true })
  hi("markdownH5", { fg = p.fg_dim })
  hi("markdownH6", { fg = p.fg_dim })
  hi("markdownBold", { bold = true })
  hi("markdownItalic", { italic = true })
  hi("markdownCode", { fg = p.fg, bg = p.bg_alt })
  hi("markdownCodeBlock", { fg = p.fg })
  hi("markdownLinkText", { fg = p.focus, underline = true })
  hi("markdownUrl", { fg = p.fg_muted, underline = true })
  hi("markdownListMarker", { fg = p.fg_muted })
  hi("markdownOrderedListMarker", { fg = p.fg_muted })

  -- ── Git ────────────────────────────────────────────────────

  hi("GitSignsAdd", { fg = p.positive })
  hi("GitSignsChange", { fg = p.warn })
  hi("GitSignsDelete", { fg = p.negative })
  hi("GitSignsCurrentLineBlame", { fg = p.fg_muted, italic = true })

  hi("DiffAdd", { fg = p.positive, bg = p.bg_alt })
  hi("DiffChange", { fg = p.warn, bg = p.bg_alt })
  hi("DiffDelete", { fg = p.negative, bg = p.bg_alt })
  hi("DiffText", { fg = p.focus, bg = p.bg_alt, bold = true })

  -- ── Telescope / FZF ────────────────────────────────────────

  hi("TelescopeNormal", { fg = p.fg, bg = p.bg })
  hi("TelescopeBorder", { fg = p.border, bg = p.bg })
  hi("TelescopePromptNormal", { fg = p.fg, bg = p.bg_alt })
  hi("TelescopePromptBorder", { fg = p.border, bg = p.bg_alt })
  hi("TelescopePromptTitle", { fg = p.fg, bg = p.bg_alt, bold = true })
  hi("TelescopePreviewTitle", { fg = p.fg, bold = true })
  hi("TelescopeResultsTitle", { fg = p.fg, bold = true })
  hi("TelescopeSelection", { bg = p.selection })
  hi("TelescopeMatching", { fg = p.focus, bold = true })
  hi("TelescopeMultiSelection", { fg = p.fg, bold = true })
  hi("TelescopePromptPrefix", { fg = p.focus })

  -- ── Which-Key ──────────────────────────────────────────────

  hi("WhichKey", { fg = p.focus })
  hi("WhichKeyGroup", { fg = p.fg })
  hi("WhichKeyDesc", { fg = p.fg_dim })
  hi("WhichKeySeperator", { fg = p.border })
  hi("WhichKeySeparator", { fg = p.border })
  hi("WhichKeyFloat", { bg = p.bg_float })
  hi("WhichKeyValue", { fg = p.fg_muted })
  hi("WhichKeyBorder", { fg = p.border, bg = p.bg_float })

  -- ── Completion (nvim-cmp / blink) ──────────────────────────

  hi("CmpItemAbbr", { fg = p.fg })
  hi("CmpItemAbbrDeprecated", { fg = p.fg_muted, strikethrough = true })
  hi("CmpItemAbbrMatch", { fg = p.focus, bold = true })
  hi("CmpItemAbbrMatchFuzzy", { fg = p.focus, bold = true })
  hi("CmpItemKind", { fg = p.fg_dim })
  hi("CmpItemMenu", { fg = p.fg_dim })
  hi("CmpItemKindFunction", { fg = p.fg, bold = true })
  hi("CmpItemKindMethod", { fg = p.fg, bold = true })
  hi("CmpItemKindVariable", { fg = p.fg })
  hi("CmpItemKindKeyword", { fg = p.focus })
  hi("CmpItemKindText", { fg = p.fg_dim })
  hi("CmpItemKindSnippet", { fg = p.fg_dim })
  hi("CmpItemKindField", { fg = p.fg })
  hi("CmpItemKindProperty", { fg = p.fg })
  hi("CmpItemKindClass", { fg = p.fg, bold = true })
  hi("CmpItemKindModule", { fg = p.fg_dim })

  -- ── Lazy.nvim ──────────────────────────────────────────────

  hi("LazyButton", { fg = p.fg, bg = p.bg_alt })
  hi("LazyButtonActive", { fg = p.bg, bg = p.focus, bold = true })
  hi("LazyComment", { fg = p.comment })
  hi("LazyCommit", { fg = p.fg_muted })
  hi("LazyCommitIssue", { fg = p.focus })
  hi("LazyCommitScope", { fg = p.fg_dim, italic = true })
  hi("LazyCommitType", { fg = p.fg, bold = true })
  hi("LazyDir", { fg = p.fg_dim })
  hi("LazyH1", { fg = p.bg, bg = p.focus, bold = true })
  hi("LazyH2", { fg = p.fg, bold = true })
  hi("LazyNoCond", { fg = p.warn })
  hi("LazyNormal", { fg = p.fg, bg = p.bg_float })
  hi("LazyProgressDone", { fg = p.positive })
  hi("LazyProgressTodo", { fg = p.border })
  hi("LazyProp", { fg = p.fg_dim })
  hi("LazyReasonCmd", { fg = p.fg_dim })
  hi("LazyReasonEvent", { fg = p.fg_dim })
  hi("LazyReasonFt", { fg = p.fg_dim })
  hi("LazyReasonKeys", { fg = p.fg_dim })
  hi("LazyReasonPlugin", { fg = p.fg_dim })
  hi("LazyReasonStart", { fg = p.fg_dim })
  hi("LazySpecial", { fg = p.focus })
  hi("LazyUrl", { fg = p.focus, underline = true })

  -- ── Snacks.nvim ────────────────────────────────────────────

  hi("SnacksNormal", { fg = p.fg, bg = p.bg_float })
  hi("SnacksBorder", { fg = p.border, bg = p.bg_float })
  hi("SnacksTitle", { fg = p.fg, bold = true })
  hi("SnacksFooter", { fg = p.fg_muted })
  hi("SnacksPickerMatch", { fg = p.focus, bold = true })
  hi("SnacksPickerDir", { fg = p.fg_dim })
  hi("SnacksPickerFile", { fg = p.fg })
  hi("SnacksPickerSelected", { fg = p.fg, bold = true })
  hi("SnacksNotifierInfo", { fg = p.info })
  hi("SnacksNotifierWarn", { fg = p.warn })
  hi("SnacksNotifierError", { fg = p.negative })
  hi("SnacksNotifierDebug", { fg = p.fg_muted })
  hi("SnacksNotifierTrace", { fg = p.positive })
  hi("SnacksDashboardHeader", { fg = p.fg, bold = true })
  hi("SnacksDashboardFooter", { fg = p.fg_muted, italic = true })
  hi("SnacksDashboardKey", { fg = p.focus, bold = true })
  hi("SnacksDashboardDesc", { fg = p.fg_dim })
  hi("SnacksDashboardIcon", { fg = p.fg_dim })
  hi("SnacksDashboardSpecial", { fg = p.fg, bold = true })
  hi("SnacksIndent", { fg = p.border })
  hi("SnacksIndentScope", { fg = p.focus })
  hi("SnacksZen", { bg = p.bg })

  -- ── Oil.nvim ───────────────────────────────────────────────

  hi("OilDir", { fg = p.fg, bold = true })
  hi("OilDirIcon", { fg = p.fg_dim })
  hi("OilSocket", { fg = p.fg_dim })
  hi("OilLink", { fg = p.focus })
  hi("OilLinkTarget", { fg = p.fg_dim, italic = true })
  hi("OilFile", { fg = p.fg })
  hi("OilCreate", { fg = p.positive })
  hi("OilDelete", { fg = p.negative })
  hi("OilMove", { fg = p.warn })
  hi("OilCopy", { fg = p.info })
  hi("OilChange", { fg = p.warn })

  -- ── Noice.nvim ─────────────────────────────────────────────

  hi("NoiceCmdline", { fg = p.fg, bg = p.bg_float })
  hi("NoiceCmdlineIcon", { fg = p.focus })
  hi("NoiceCmdlineIconSearch", { fg = p.warn })
  hi("NoiceCmdlinePopup", { fg = p.fg, bg = p.bg_float })
  hi("NoiceCmdlinePopupBorder", { fg = p.border })
  hi("NoiceConfirm", { fg = p.fg, bg = p.bg_float })
  hi("NoiceConfirmBorder", { fg = p.border })
  hi("NoiceMini", { fg = p.fg_dim, bg = p.bg_alt })
  hi("NoicePopup", { fg = p.fg, bg = p.bg_float })
  hi("NoicePopupBorder", { fg = p.border })
  hi("NoiceFormatProgressDone", { fg = p.bg, bg = p.focus })
  hi("NoiceFormatProgressTodo", { fg = p.fg_muted, bg = p.bg_alt })

  -- ── Notify ─────────────────────────────────────────────────

  hi("NotifyERRORBorder", { fg = p.negative })
  hi("NotifyWARNBorder", { fg = p.warn })
  hi("NotifyINFOBorder", { fg = p.info })
  hi("NotifyDEBUGBorder", { fg = p.fg_muted })
  hi("NotifyTRACEBorder", { fg = p.positive })
  hi("NotifyERRORIcon", { fg = p.negative })
  hi("NotifyWARNIcon", { fg = p.warn })
  hi("NotifyINFOIcon", { fg = p.info })
  hi("NotifyDEBUGIcon", { fg = p.fg_muted })
  hi("NotifyTRACEIcon", { fg = p.positive })
  hi("NotifyERRORTitle", { fg = p.negative, bold = true })
  hi("NotifyWARNTitle", { fg = p.warn, bold = true })
  hi("NotifyINFOTitle", { fg = p.info, bold = true })
  hi("NotifyDEBUGTitle", { fg = p.fg_muted, bold = true })
  hi("NotifyTRACETitle", { fg = p.positive, bold = true })

  -- ── Indent-blankline / Mini.indentscope ────────────────────

  hi("IblIndent", { fg = p.border })
  hi("IblScope", { fg = p.focus })
  hi("MiniIndentscopeSymbol", { fg = p.focus })

  -- ── Mini.* ─────────────────────────────────────────────────
  --
  -- Mode indicators are the one place we stretch the semantic budget:
  -- Normal is focus (active), Insert is positive (writing/creating),
  -- Visual is info (observation), Command is warn (pending action),
  -- Replace is negative (destructive).

  hi("MiniStatuslineDevinfo", { fg = p.fg_dim, bg = p.bg_alt })
  hi("MiniStatuslineFileinfo", { fg = p.fg_dim, bg = p.bg_alt })
  hi("MiniStatuslineFilename", { fg = p.fg, bg = p.bg_alt })
  hi("MiniStatuslineInactive", { fg = p.fg_muted, bg = p.bg_alt })
  hi("MiniStatuslineModeNormal", { fg = p.bg, bg = p.focus, bold = true })
  hi("MiniStatuslineModeInsert", { fg = p.bg, bg = p.positive, bold = true })
  hi("MiniStatuslineModeVisual", { fg = p.bg, bg = p.info, bold = true })
  hi("MiniStatuslineModeCommand", { fg = p.bg, bg = p.warn, bold = true })
  hi("MiniStatuslineModeReplace", { fg = p.bg, bg = p.negative, bold = true })
  hi("MiniCursorword", { underline = true })
  hi("MiniSurround", { fg = p.bg, bg = p.focus })
  hi("MiniJump", { fg = p.focus, bold = true, underline = true })
  hi("MiniPickNormal", { fg = p.fg, bg = p.bg_float })
  hi("MiniPickBorder", { fg = p.border, bg = p.bg_float })
  hi("MiniPickMatchCurrent", { bg = p.selection })
  hi("MiniPickMatchRanges", { fg = p.focus, bold = true })

  -- ── NeoTree ────────────────────────────────────────────────

  hi("NeoTreeNormal", { fg = p.fg, bg = p.bg_alt })
  hi("NeoTreeNormalNC", { fg = p.fg_dim, bg = p.bg_alt })
  hi("NeoTreeDirectoryName", { fg = p.fg, bold = true })
  hi("NeoTreeDirectoryIcon", { fg = p.fg_dim })
  hi("NeoTreeFileName", { fg = p.fg })
  hi("NeoTreeGitAdded", { fg = p.positive })
  hi("NeoTreeGitModified", { fg = p.warn })
  hi("NeoTreeGitDeleted", { fg = p.negative })
  hi("NeoTreeGitConflict", { fg = p.negative, bold = true })
  hi("NeoTreeGitUntracked", { fg = p.fg_muted })
  hi("NeoTreeIndentMarker", { fg = p.border })
  hi("NeoTreeRootName", { fg = p.fg, bold = true })
  hi("NeoTreeTitleBar", { fg = p.fg, bg = p.bg_alt, bold = true })

  -- ── Navic (breadcrumbs) ────────────────────────────────────

  hi("NavicText", { fg = p.fg_dim })
  hi("NavicSeparator", { fg = p.border })
  hi("NavicIconsFile", { fg = p.fg })
  hi("NavicIconsModule", { fg = p.fg_dim })
  hi("NavicIconsNamespace", { fg = p.fg_dim })
  hi("NavicIconsPackage", { fg = p.fg_dim })
  hi("NavicIconsClass", { fg = p.fg, bold = true })
  hi("NavicIconsMethod", { fg = p.fg, bold = true })
  hi("NavicIconsProperty", { fg = p.fg })
  hi("NavicIconsField", { fg = p.fg })
  hi("NavicIconsConstructor", { fg = p.fg, bold = true })
  hi("NavicIconsEnum", { fg = p.fg, bold = true })
  hi("NavicIconsInterface", { fg = p.fg, bold = true })
  hi("NavicIconsFunction", { fg = p.fg, bold = true })
  hi("NavicIconsVariable", { fg = p.fg })
  hi("NavicIconsConstant", { fg = p.fg })
  hi("NavicIconsString", { fg = p.fg })
  hi("NavicIconsNumber", { fg = p.fg })
  hi("NavicIconsBoolean", { fg = p.fg })
  hi("NavicIconsArray", { fg = p.fg })
  hi("NavicIconsObject", { fg = p.fg })
  hi("NavicIconsKey", { fg = p.focus })
  hi("NavicIconsKeyword", { fg = p.focus })

  -- ── render-markdown.nvim ───────────────────────────────────

  hi("RenderMarkdownH1Bg", { bg = p.bg_alt, bold = true })
  hi("RenderMarkdownH2Bg", { bg = p.bg_alt, bold = true })
  hi("RenderMarkdownH3Bg", { bg = p.bg_alt })
  hi("RenderMarkdownH4Bg", { bg = p.bg_alt })
  hi("RenderMarkdownH1", { fg = p.fg, bold = true })
  hi("RenderMarkdownH2", { fg = p.fg, bold = true })
  hi("RenderMarkdownH3", { fg = p.fg_dim, bold = true })
  hi("RenderMarkdownH4", { fg = p.fg_dim, bold = true })
  hi("RenderMarkdownCode", { bg = p.bg_alt })
  hi("RenderMarkdownCodeInline", { fg = p.fg, bg = p.bg_alt })
  hi("RenderMarkdownBullet", { fg = p.fg_muted })
  hi("RenderMarkdownQuote", { fg = p.fg_muted, italic = true })
  hi("RenderMarkdownDash", { fg = p.border })
  hi("RenderMarkdownLink", { fg = p.focus, underline = true })
  hi("RenderMarkdownTableHead", { fg = p.fg, bold = true })
  hi("RenderMarkdownTableRow", { fg = p.fg })
  hi("RenderMarkdownCheckedBox", { fg = p.positive })
  hi("RenderMarkdownUncheckedBox", { fg = p.fg_muted })

  -- ── Slimline / Lualine ─────────────────────────────────────

  hi("SlimlineModeNormal", { fg = p.focus, bold = true })
  hi("SlimlineModeInsert", { fg = p.positive, bold = true })
  hi("SlimlineModeVisual", { fg = p.info, bold = true })
  hi("SlimlineModeCommand", { fg = p.warn, bold = true })

  -- ── Trouble.nvim ───────────────────────────────────────────

  hi("TroubleNormal", { fg = p.fg, bg = p.bg_float })
  hi("TroubleText", { fg = p.fg })
  hi("TroubleCount", { fg = p.focus, bold = true })
  hi("TroubleFile", { fg = p.fg })
  hi("TroubleLocation", { fg = p.fg_muted })
  hi("TroubleCode", { fg = p.fg_muted })

  -- ── Flash.nvim ─────────────────────────────────────────────

  hi("FlashBackdrop", { fg = p.fg_muted })
  hi("FlashLabel", { fg = p.bg, bg = p.focus, bold = true })
  hi("FlashMatch", { fg = p.focus })
  hi("FlashCurrent", { fg = p.focus, bold = true })
end

return M
