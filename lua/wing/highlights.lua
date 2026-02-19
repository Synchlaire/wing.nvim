local M = {}

--- Apply all highlight groups for the given palette
---@param p table palette colors (includes p._opts for style toggles)
function M.apply(p)
  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Style toggles (from setup opts, attached by init.lua)
  local o = p._opts or {}
  local italic_comments = o.italic_comments ~= false
  local bold_keywords = o.bold_keywords ~= false
  local bold_functions = o.bold_functions ~= false

  -- ── Editor UI ──────────────────────────────────────────────

  hi("Normal", { fg = p.fg, bg = p.bg })
  hi("NormalNC", { fg = p.fg_dim, bg = p.bg })
  hi("NormalFloat", { fg = p.fg, bg = p.bg_float })
  hi("FloatBorder", { fg = p.border, bg = p.bg_float })
  hi("FloatTitle", { fg = p.accent, bg = p.bg_float, bold = true })

  hi("Cursor", { fg = p.bg, bg = p.fg })
  hi("CursorLine", { bg = p.cursor_line })
  hi("CursorLineNr", { fg = p.accent, bold = true })
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

  hi("Search", { fg = p.bg, bg = p.accent })
  hi("IncSearch", { fg = p.bg, bg = p.accent, bold = true })
  hi("CurSearch", { fg = p.bg, bg = p.accent, bold = true })
  hi("Substitute", { fg = p.bg, bg = p.warn })

  hi("MatchParen", { fg = p.accent, bold = true, underline = true })

  hi("NonText", { fg = p.border })
  hi("SpecialKey", { fg = p.border })
  hi("Whitespace", { fg = p.border })
  hi("EndOfBuffer", { fg = p.bg })

  hi("Pmenu", { fg = p.fg, bg = p.bg_float })
  hi("PmenuSel", { fg = p.fg, bg = p.selection, bold = true })
  hi("PmenuSbar", { bg = p.bg_alt })
  hi("PmenuThumb", { bg = p.border })

  hi("ErrorMsg", { fg = p.error, bold = true })
  hi("WarningMsg", { fg = p.warn, bold = true })
  hi("MoreMsg", { fg = p.info })
  hi("ModeMsg", { fg = p.fg_dim, bold = true })
  hi("Question", { fg = p.info })
  hi("Title", { fg = p.accent, bold = true })
  hi("Directory", { fg = p.accent_secondary })
  hi("Conceal", { fg = p.fg_muted })
  hi("SpellBad", { undercurl = true, sp = p.error })
  hi("SpellCap", { undercurl = true, sp = p.warn })
  hi("SpellLocal", { undercurl = true, sp = p.info })
  hi("SpellRare", { undercurl = true, sp = p.hint })

  -- ── Syntax ─────────────────────────────────────────────────

  hi("Comment", { fg = p.comment, italic = italic_comments })

  hi("Constant", { fg = p.fg })
  hi("String", { fg = p.accent_secondary })
  hi("Character", { fg = p.accent_secondary })
  hi("Number", { fg = p.fg })
  hi("Boolean", { fg = p.fg, bold = true })
  hi("Float", { fg = p.fg })

  hi("Identifier", { fg = p.fg })
  hi("Function", { fg = p.fg, bold = bold_functions })

  hi("Statement", { fg = p.accent })
  hi("Conditional", { fg = p.accent })
  hi("Repeat", { fg = p.accent })
  hi("Label", { fg = p.accent })
  hi("Operator", { fg = p.fg_dim })
  hi("Keyword", { fg = p.accent, bold = bold_keywords })
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

  hi("DiagnosticVirtualTextError", { fg = p.error, bg = p.bg_alt, italic = true })
  hi("DiagnosticVirtualTextWarn", { fg = p.warn, bg = p.bg_alt, italic = true })
  hi("DiagnosticVirtualTextInfo", { fg = p.info, bg = p.bg_alt, italic = true })
  hi("DiagnosticVirtualTextHint", { fg = p.hint, bg = p.bg_alt, italic = true })

  hi("DiagnosticFloatingError", { fg = p.error })
  hi("DiagnosticFloatingWarn", { fg = p.warn })
  hi("DiagnosticFloatingInfo", { fg = p.info })
  hi("DiagnosticFloatingHint", { fg = p.hint })

  hi("DiagnosticSignError", { fg = p.error })
  hi("DiagnosticSignWarn", { fg = p.warn })
  hi("DiagnosticSignInfo", { fg = p.info })
  hi("DiagnosticSignHint", { fg = p.hint })

  -- ── LSP ────────────────────────────────────────────────────

  hi("LspReferenceText", { bg = p.selection })
  hi("LspReferenceRead", { bg = p.selection })
  hi("LspReferenceWrite", { bg = p.selection })
  hi("LspSignatureActiveParameter", { fg = p.accent, bold = true })
  hi("LspCodeLens", { fg = p.fg_muted })
  hi("LspCodeLensSeparator", { fg = p.border })
  hi("LspInlayHint", { fg = p.fg_muted, bg = p.bg_alt, italic = true })

  -- ── Treesitter ─────────────────────────────────────────────

  hi("@comment", { link = "Comment" })
  hi("@punctuation", { fg = p.fg_dim })
  hi("@punctuation.bracket", { fg = p.fg_dim })
  hi("@punctuation.delimiter", { fg = p.fg_dim })
  hi("@punctuation.special", { fg = p.accent })
  hi("@constant", { link = "Constant" })
  hi("@constant.builtin", { fg = p.fg, bold = true })
  hi("@constant.macro", { fg = p.fg })
  hi("@string", { link = "String" })
  hi("@string.documentation", { fg = p.accent_secondary, italic = true })
  hi("@string.regex", { fg = p.accent_dim })
  hi("@string.escape", { fg = p.accent_dim })
  hi("@character", { link = "Character" })
  hi("@number", { link = "Number" })
  hi("@boolean", { link = "Boolean" })
  hi("@float", { link = "Float" })
  hi("@function", { link = "Function" })
  hi("@function.builtin", { fg = p.fg, bold = bold_functions })
  hi("@function.macro", { fg = p.accent_dim })
  hi("@function.call", { fg = p.fg, bold = bold_functions })
  hi("@method", { fg = p.fg, bold = bold_functions })
  hi("@method.call", { fg = p.fg, bold = bold_functions })
  hi("@parameter", { fg = p.fg })
  hi("@keyword", { link = "Keyword" })
  hi("@keyword.function", { fg = p.accent })
  hi("@keyword.operator", { fg = p.accent })
  hi("@keyword.return", { fg = p.accent, bold = bold_keywords })
  hi("@conditional", { link = "Conditional" })
  hi("@repeat", { link = "Repeat" })
  hi("@label", { link = "Label" })
  hi("@operator", { link = "Operator" })
  hi("@exception", { link = "Exception" })
  hi("@type", { link = "Type" })
  hi("@type.builtin", { fg = p.fg })
  hi("@type.qualifier", { fg = p.accent })
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
  hi("@text.title", { fg = p.accent, bold = true })
  hi("@text.literal", { fg = p.accent_secondary })
  hi("@text.uri", { fg = p.accent_secondary, underline = true })
  hi("@text.reference", { fg = p.accent_secondary })
  hi("@text.todo", { link = "Todo" })
  hi("@text.note", { fg = p.info, bold = true })
  hi("@text.warning", { fg = p.warn, bold = true })
  hi("@text.danger", { fg = p.error, bold = true })
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
  hi("markdownListMarker", { fg = p.accent })
  hi("markdownOrderedListMarker", { fg = p.accent })

  -- ── Git ────────────────────────────────────────────────────

  hi("GitSignsAdd", { fg = p.add })
  hi("GitSignsChange", { fg = p.change })
  hi("GitSignsDelete", { fg = p.delete })
  hi("GitSignsCurrentLineBlame", { fg = p.fg_muted, italic = true })

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
  hi("TelescopeMultiSelection", { fg = p.accent_secondary, bold = true })
  hi("TelescopePromptPrefix", { fg = p.accent })

  -- ── Which-Key ──────────────────────────────────────────────

  hi("WhichKey", { fg = p.accent })
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
  hi("CmpItemAbbrMatch", { fg = p.accent, bold = true })
  hi("CmpItemAbbrMatchFuzzy", { fg = p.accent, bold = true })
  hi("CmpItemKind", { fg = p.accent_secondary })
  hi("CmpItemMenu", { fg = p.fg_dim })
  hi("CmpItemKindFunction", { fg = p.accent })
  hi("CmpItemKindMethod", { fg = p.accent })
  hi("CmpItemKindVariable", { fg = p.fg })
  hi("CmpItemKindKeyword", { fg = p.accent })
  hi("CmpItemKindText", { fg = p.fg_dim })
  hi("CmpItemKindSnippet", { fg = p.accent_secondary })
  hi("CmpItemKindField", { fg = p.fg })
  hi("CmpItemKindProperty", { fg = p.fg })
  hi("CmpItemKindClass", { fg = p.accent })
  hi("CmpItemKindModule", { fg = p.fg_dim })

  -- ── Lazy.nvim ──────────────────────────────────────────────

  hi("LazyButton", { fg = p.fg, bg = p.bg_alt })
  hi("LazyButtonActive", { fg = p.bg, bg = p.accent, bold = true })
  hi("LazyComment", { fg = p.comment })
  hi("LazyCommit", { fg = p.fg_muted })
  hi("LazyCommitIssue", { fg = p.accent_secondary })
  hi("LazyCommitScope", { fg = p.fg_dim, italic = true })
  hi("LazyCommitType", { fg = p.accent, bold = true })
  hi("LazyDir", { fg = p.fg_dim })
  hi("LazyH1", { fg = p.bg, bg = p.accent, bold = true })
  hi("LazyH2", { fg = p.accent, bold = true })
  hi("LazyNoCond", { fg = p.warn })
  hi("LazyNormal", { fg = p.fg, bg = p.bg_float })
  hi("LazyProgressDone", { fg = p.accent })
  hi("LazyProgressTodo", { fg = p.border })
  hi("LazyProp", { fg = p.fg_dim })
  hi("LazyReasonCmd", { fg = p.accent })
  hi("LazyReasonEvent", { fg = p.accent_secondary })
  hi("LazyReasonFt", { fg = p.info })
  hi("LazyReasonKeys", { fg = p.warn })
  hi("LazyReasonPlugin", { fg = p.accent })
  hi("LazyReasonStart", { fg = p.accent_secondary })
  hi("LazySpecial", { fg = p.accent })
  hi("LazyUrl", { fg = p.accent_secondary, underline = true })

  -- ── Snacks.nvim ────────────────────────────────────────────

  hi("SnacksNormal", { fg = p.fg, bg = p.bg_float })
  hi("SnacksBorder", { fg = p.border, bg = p.bg_float })
  hi("SnacksTitle", { fg = p.accent, bold = true })
  hi("SnacksFooter", { fg = p.fg_muted })
  hi("SnacksPickerMatch", { fg = p.accent, bold = true })
  hi("SnacksPickerDir", { fg = p.fg_dim })
  hi("SnacksPickerFile", { fg = p.fg })
  hi("SnacksPickerSelected", { fg = p.accent_secondary, bold = true })
  hi("SnacksNotifierInfo", { fg = p.info })
  hi("SnacksNotifierWarn", { fg = p.warn })
  hi("SnacksNotifierError", { fg = p.error })
  hi("SnacksNotifierDebug", { fg = p.fg_muted })
  hi("SnacksNotifierTrace", { fg = p.hint })
  hi("SnacksDashboardHeader", { fg = p.accent })
  hi("SnacksDashboardFooter", { fg = p.fg_muted, italic = true })
  hi("SnacksDashboardKey", { fg = p.accent, bold = true })
  hi("SnacksDashboardDesc", { fg = p.fg_dim })
  hi("SnacksDashboardIcon", { fg = p.accent_secondary })
  hi("SnacksDashboardSpecial", { fg = p.accent })
  hi("SnacksIndent", { fg = p.border })
  hi("SnacksIndentScope", { fg = p.accent })
  hi("SnacksZen", { bg = p.bg })

  -- ── Oil.nvim ───────────────────────────────────────────────

  hi("OilDir", { fg = p.accent_secondary, bold = true })
  hi("OilDirIcon", { fg = p.accent_secondary })
  hi("OilSocket", { fg = p.accent })
  hi("OilLink", { fg = p.info })
  hi("OilLinkTarget", { fg = p.fg_dim, italic = true })
  hi("OilFile", { fg = p.fg })
  hi("OilCreate", { fg = p.add })
  hi("OilDelete", { fg = p.delete })
  hi("OilMove", { fg = p.change })
  hi("OilCopy", { fg = p.info })
  hi("OilChange", { fg = p.change })

  -- ── Noice.nvim ─────────────────────────────────────────────

  hi("NoiceCmdline", { fg = p.fg, bg = p.bg_float })
  hi("NoiceCmdlineIcon", { fg = p.accent })
  hi("NoiceCmdlineIconSearch", { fg = p.warn })
  hi("NoiceCmdlinePopup", { fg = p.fg, bg = p.bg_float })
  hi("NoiceCmdlinePopupBorder", { fg = p.border })
  hi("NoiceConfirm", { fg = p.fg, bg = p.bg_float })
  hi("NoiceConfirmBorder", { fg = p.border })
  hi("NoiceMini", { fg = p.fg_dim, bg = p.bg_alt })
  hi("NoicePopup", { fg = p.fg, bg = p.bg_float })
  hi("NoicePopupBorder", { fg = p.border })
  hi("NoiceFormatProgressDone", { fg = p.bg, bg = p.accent })
  hi("NoiceFormatProgressTodo", { fg = p.fg_muted, bg = p.bg_alt })

  -- ── Notify ─────────────────────────────────────────────────

  hi("NotifyERRORBorder", { fg = p.error })
  hi("NotifyWARNBorder", { fg = p.warn })
  hi("NotifyINFOBorder", { fg = p.info })
  hi("NotifyDEBUGBorder", { fg = p.fg_muted })
  hi("NotifyTRACEBorder", { fg = p.hint })
  hi("NotifyERRORIcon", { fg = p.error })
  hi("NotifyWARNIcon", { fg = p.warn })
  hi("NotifyINFOIcon", { fg = p.info })
  hi("NotifyDEBUGIcon", { fg = p.fg_muted })
  hi("NotifyTRACEIcon", { fg = p.hint })
  hi("NotifyERRORTitle", { fg = p.error, bold = true })
  hi("NotifyWARNTitle", { fg = p.warn, bold = true })
  hi("NotifyINFOTitle", { fg = p.info, bold = true })
  hi("NotifyDEBUGTitle", { fg = p.fg_muted, bold = true })
  hi("NotifyTRACETitle", { fg = p.hint, bold = true })

  -- ── Indent-blankline / Mini.indentscope ────────────────────

  hi("IblIndent", { fg = p.border })
  hi("IblScope", { fg = p.accent })
  hi("MiniIndentscopeSymbol", { fg = p.accent })

  -- ── Mini.* ─────────────────────────────────────────────────

  hi("MiniStatuslineDevinfo", { fg = p.fg_dim, bg = p.bg_alt })
  hi("MiniStatuslineFileinfo", { fg = p.fg_dim, bg = p.bg_alt })
  hi("MiniStatuslineFilename", { fg = p.fg, bg = p.bg_alt })
  hi("MiniStatuslineInactive", { fg = p.fg_muted, bg = p.bg_alt })
  hi("MiniStatuslineModeNormal", { fg = p.bg, bg = p.accent, bold = true })
  hi("MiniStatuslineModeInsert", { fg = p.bg, bg = p.accent_secondary, bold = true })
  hi("MiniStatuslineModeVisual", { fg = p.bg, bg = p.info, bold = true })
  hi("MiniStatuslineModeCommand", { fg = p.bg, bg = p.warn, bold = true })
  hi("MiniStatuslineModeReplace", { fg = p.bg, bg = p.error, bold = true })
  hi("MiniCursorword", { underline = true })
  hi("MiniSurround", { fg = p.bg, bg = p.accent })
  hi("MiniJump", { fg = p.accent, bold = true, underline = true })
  hi("MiniPickNormal", { fg = p.fg, bg = p.bg_float })
  hi("MiniPickBorder", { fg = p.border, bg = p.bg_float })
  hi("MiniPickMatchCurrent", { bg = p.selection })
  hi("MiniPickMatchRanges", { fg = p.accent, bold = true })

  -- ── NeoTree ────────────────────────────────────────────────

  hi("NeoTreeNormal", { fg = p.fg, bg = p.bg_alt })
  hi("NeoTreeNormalNC", { fg = p.fg_dim, bg = p.bg_alt })
  hi("NeoTreeDirectoryName", { fg = p.accent_secondary })
  hi("NeoTreeDirectoryIcon", { fg = p.accent_secondary })
  hi("NeoTreeFileName", { fg = p.fg })
  hi("NeoTreeGitAdded", { fg = p.add })
  hi("NeoTreeGitModified", { fg = p.change })
  hi("NeoTreeGitDeleted", { fg = p.delete })
  hi("NeoTreeGitConflict", { fg = p.error, bold = true })
  hi("NeoTreeGitUntracked", { fg = p.fg_muted })
  hi("NeoTreeIndentMarker", { fg = p.border })
  hi("NeoTreeRootName", { fg = p.accent, bold = true })
  hi("NeoTreeTitleBar", { fg = p.accent, bg = p.bg_alt, bold = true })

  -- ── Navic (breadcrumbs) ────────────────────────────────────

  hi("NavicText", { fg = p.fg_dim })
  hi("NavicSeparator", { fg = p.border })
  hi("NavicIconsFile", { fg = p.fg })
  hi("NavicIconsModule", { fg = p.fg_dim })
  hi("NavicIconsNamespace", { fg = p.fg_dim })
  hi("NavicIconsPackage", { fg = p.fg_dim })
  hi("NavicIconsClass", { fg = p.accent })
  hi("NavicIconsMethod", { fg = p.accent })
  hi("NavicIconsProperty", { fg = p.fg })
  hi("NavicIconsField", { fg = p.fg })
  hi("NavicIconsConstructor", { fg = p.accent })
  hi("NavicIconsEnum", { fg = p.accent })
  hi("NavicIconsInterface", { fg = p.accent_secondary })
  hi("NavicIconsFunction", { fg = p.accent })
  hi("NavicIconsVariable", { fg = p.fg })
  hi("NavicIconsConstant", { fg = p.fg })
  hi("NavicIconsString", { fg = p.accent_secondary })
  hi("NavicIconsNumber", { fg = p.fg })
  hi("NavicIconsBoolean", { fg = p.fg })
  hi("NavicIconsArray", { fg = p.fg })
  hi("NavicIconsObject", { fg = p.fg })
  hi("NavicIconsKey", { fg = p.accent })
  hi("NavicIconsKeyword", { fg = p.accent })

  -- ── render-markdown.nvim ───────────────────────────────────

  hi("RenderMarkdownH1Bg", { bg = p.bg_alt, bold = true })
  hi("RenderMarkdownH2Bg", { bg = p.bg_alt, bold = true })
  hi("RenderMarkdownH3Bg", { bg = p.bg_alt })
  hi("RenderMarkdownH4Bg", { bg = p.bg_alt })
  hi("RenderMarkdownH1", { fg = p.accent, bold = true })
  hi("RenderMarkdownH2", { fg = p.accent, bold = true })
  hi("RenderMarkdownH3", { fg = p.fg, bold = true })
  hi("RenderMarkdownH4", { fg = p.fg, bold = true })
  hi("RenderMarkdownCode", { bg = p.bg_alt })
  hi("RenderMarkdownCodeInline", { fg = p.accent_secondary, bg = p.bg_alt })
  hi("RenderMarkdownBullet", { fg = p.accent })
  hi("RenderMarkdownQuote", { fg = p.fg_muted, italic = true })
  hi("RenderMarkdownDash", { fg = p.border })
  hi("RenderMarkdownLink", { fg = p.accent_secondary, underline = true })
  hi("RenderMarkdownTableHead", { fg = p.accent, bold = true })
  hi("RenderMarkdownTableRow", { fg = p.fg })
  hi("RenderMarkdownCheckedBox", { fg = p.accent_secondary })
  hi("RenderMarkdownUncheckedBox", { fg = p.fg_muted })

  -- ── Slimline / Lualine ─────────────────────────────────────

  hi("SlimlineModeNormal", { fg = p.accent, bold = true })
  hi("SlimlineModeInsert", { fg = p.accent_secondary, bold = true })
  hi("SlimlineModeVisual", { fg = p.info, bold = true })
  hi("SlimlineModeCommand", { fg = p.warn, bold = true })

  -- ── Trouble.nvim ───────────────────────────────────────────

  hi("TroubleNormal", { fg = p.fg, bg = p.bg_float })
  hi("TroubleText", { fg = p.fg })
  hi("TroubleCount", { fg = p.accent, bold = true })
  hi("TroubleFile", { fg = p.fg })
  hi("TroubleLocation", { fg = p.fg_muted })
  hi("TroubleCode", { fg = p.fg_muted })

  -- ── Flash.nvim ─────────────────────────────────────────────

  hi("FlashBackdrop", { fg = p.fg_muted })
  hi("FlashLabel", { fg = p.bg, bg = p.accent, bold = true })
  hi("FlashMatch", { fg = p.accent_secondary })
  hi("FlashCurrent", { fg = p.accent, bold = true })
end

return M
