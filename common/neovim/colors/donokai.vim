hi clear
syntax reset

hi normal cterm=none ctermfg=7
hi bold cterm=bold

hi statusline cterm=none ctermfg=7 ctermbg=234
hi statuslinenc cterm=none ctermfg=234 ctermbg=0
hi inactivebuffer cterm=none ctermbg=234 ctermfg=7
hi activebuffer cterm=none ctermfg=0 ctermbg=4
hi dirtybuffer cterm=none ctermfg=0 ctermbg=1
hi activedirtybuffer cterm=none ctermfg=0 ctermbg=3
hi pmenu cterm=none ctermfg=7 ctermbg=236
hi pmenusel cterm=none ctermbg=4 ctermfg=0
hi pmenusbar cterm=none ctermbg=236 ctermfg=240
hi pmenuthumb cterm=none ctermbg=240 ctermfg=240
hi linenr cterm=none ctermfg=240
hi indentblanklinechar cterm=none ctermfg=236
hi signcolumn cterm=none ctermfg=234 ctermbg=0
hi matchparen cterm=none ctermbg=5 ctermfg=0
hi search cterm=bold ctermbg=4

hi todo cterm=none ctermfg=7 ctermbg=240
hi comment cterm=none ctermfg=240
hi keyword cterm=none ctermfg=7
hi operator cterm=none ctermfg=7
hi repeat cterm=none ctermfg=1
hi type cterm=none ctermfg=3
hi string cterm=none ctermfg=2
hi noise cterm=none ctermfg=5 ctermbg=0
hi statement cterm=none ctermfg=1 ctermbg=0
hi conditional cterm=none ctermfg=1 ctermbg=0
hi structure cterm=none ctermfg=4 ctermbg=0
hi special cterm=none ctermfg=5 ctermbg=0
hi preproc cterm=none ctermfg=1 ctermbg=0
hi identifier cterm=none ctermfg=4 ctermbg=0
hi constant cterm=none ctermfg=1
hi nontext ctermfg=0 ctermbg=0

" TODO: diagnostics popups, telescope dialogs

hi LspDiagnosticsSignWarning cterm=none ctermfg=1 ctermbg=0
hi lspdiagnosticsvirtualtextwarning cterm=none ctermfg=1 ctermbg=0

hi TelescopeBorder ctermfg=234
hi TelescopePromptBorder ctermfg=234
hi TelescopeResultsBorder ctermfg=234
hi TelescopePreviewBorder ctermfg=234

hi TelescopeSelection ctermbg=236 ctermfg=7
hi TelescopeSelectionCaret ctermfg=7
hi TelescopeMultiSelection ctermfg=7
hi TelescopeNormal ctermfg=7

hi TelescopeMatching ctermfg=0 ctermbg=4
hi TelescopePromptPrefix guifg=red

" vim tui elements
" call <sid>hi('Debug',         s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('Directory',     s:gui0D, '', s:cterm0D, '', '', '')
" call <sid>hi('Error',         s:gui00, s:gui08, s:cterm00, s:cterm08, '', '')
" call <sid>hi('ErrorMsg',      s:gui08, s:gui00, s:cterm08, s:cterm00, '', '')
" call <sid>hi('Exception',     s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('FoldColumn',    s:gui0C, s:gui01, s:cterm0C, s:cterm01, '', '')
" call <sid>hi('Folded',        s:gui03, s:gui01, s:cterm03, s:cterm01, '', '')
" call <sid>hi('IncSearch',     s:gui01, s:gui09, s:cterm01, s:cterm09, 'none', '')
" call <sid>hi('Italic',        '', '', '', '', 'none', '')
" call <sid>hi('Macro',         s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('MatchParen',    s:gui00, s:gui03, s:cterm00, s:cterm03,  '', '')
" call <sid>hi('ModeMsg',       s:gui0B, '', s:cterm0B, '', '', '')
" call <sid>hi('MoreMsg',       s:gui0B, '', s:cterm0B, '', '', '')
" call <sid>hi('Question',      s:gui0D, '', s:cterm0D, '', '', '')
" call <sid>hi('Search',        s:gui03, s:gui0A, s:cterm03, s:cterm0A,  '', '')
" call <sid>hi('SpecialKey',    s:gui03, '', s:cterm03, '', '', '')
" call <sid>hi('TooLong',       s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('Underlined',    s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('Visual',        '', s:gui02, '', s:cterm02, '', '')
" call <sid>hi('VisualNOS',     s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('WarningMsg',    s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('WildMenu',      s:gui08, s:gui0A, s:cterm08, '', '', '')
" call <sid>hi('Title',         s:gui0D, '', s:cterm0D, '', 'none', '')
" call <sid>hi('Conceal',       s:gui0D, s:gui00, s:cterm0D, s:cterm00, '', '')
" call <sid>hi('Cursor',        s:gui00, s:gui05, s:cterm00, s:cterm05, '', '')
" call <sid>hi('NonText',       s:gui03, '', s:cterm03, '', '', '')
" call <sid>hi('Normal',        s:gui05, s:gui00, s:cterm05, s:cterm00, '', '')
" call <sid>hi('VertSplit',     s:gui02, s:gui02, s:cterm02, s:cterm02, 'none', '')
" call <sid>hi('ColorColumn',   '', s:gui01, '', s:cterm01, 'none', '')
" call <sid>hi('CursorColumn',  '', s:gui01, '', s:cterm01, 'none', '')
" call <sid>hi('CursorLine',    '', s:gui01, '', s:cterm01, 'none', '')
" call <sid>hi('CursorLineNr',  s:gui03, s:gui01, s:cterm03, s:cterm01, '', '')
" call <sid>hi('PMenu',         s:gui04, s:gui01, s:cterm04, s:cterm01, 'none', '')
" call <sid>hi('PMenuSel',      s:gui01, s:gui04, s:cterm01, s:cterm04, '', '')
" call <sid>hi('TabLine',       s:gui03, s:gui01, s:cterm03, s:cterm01, 'none', '')
" call <sid>hi('TabLineFill',   s:gui03, s:gui01, s:cterm03, s:cterm01, 'none', '')
" call <sid>hi('TabLineSel',    s:gui0B, s:gui01, s:cterm0B, s:cterm01, 'none', '')

" standard syntax
" call <sid>hi('Boolean',      s:gui09, '', s:cterm09, '', '', '')
" call <sid>hi('Character',    s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('Comment',      s:gui03, '', s:cterm03, '', '', '')
" call <sid>hi('Conditional',  s:gui0E, '', s:cterm0E, '', '', '')
" call <sid>hi('Constant',     s:gui09, '', s:cterm09, '', '', '')
" call <sid>hi('Define',       s:gui0E, '', s:cterm0E, '', 'none', '')
" call <sid>hi('Delimiter',    s:gui0F, '', s:cterm0F, '', '', '')
" call <sid>hi('Float',        s:gui09, '', s:cterm09, '', '', '')
" call <sid>hi('Function',     s:gui0D, '', s:cterm0D, '', '', '')
" call <sid>hi('Identifier',   s:gui08, '', s:cterm08, '', 'none', '')
" call <sid>hi('Include',      s:gui0D, '', s:cterm0D, '', '', '')
" call <sid>hi('Keyword',      s:gui0E, '', s:cterm0E, '', '', '')
" call <sid>hi('Label',        s:gui0A, '', s:cterm0A, '', '', '')
" call <sid>hi('Number',       s:gui09, '', s:cterm09, '', '', '')
" call <sid>hi('Operator',     s:gui05, '', s:cterm05, '', 'none', '')
" call <sid>hi('PreProc',      s:gui0A, '', s:cterm0A, '', '', '')
" call <sid>hi('Repeat',       s:gui0A, '', s:cterm0A, '', '', '')
" call <sid>hi('Special',      s:gui0C, '', s:cterm0C, '', '', '')
" call <sid>hi('SpecialChar',  s:gui0F, '', s:cterm0F, '', '', '')
" call <sid>hi('Statement',    s:gui08, '', s:cterm08, '', '', '')
" call <sid>hi('StorageClass', s:gui0A, '', s:cterm0A, '', '', '')
" call <sid>hi('String',       s:gui0B, '', s:cterm0B, '', '', '')
" call <sid>hi('Structure',    s:gui0E, '', s:cterm0E, '', '', '')
" call <sid>hi('Tag',          s:gui0A, '', s:cterm0A, '', '', '')
" call <sid>hi('Todo',         s:gui0A, s:gui01, s:cterm0A, s:cterm01, '', '')
" call <sid>hi('Type',         s:gui0A, '', s:cterm0A, '', 'none', '')
" call <sid>hi('Typedef',      s:gui0A, '', s:cterm0A, '', '', '')
" call <sid>hi('DiffAdd',      s:gui0B, s:gui01,  s:cterm0B, s:cterm01, '', '')
" call <sid>hi('DiffChange',   s:gui03, s:gui01,  s:cterm03, s:cterm01, '', '')
" call <sid>hi('DiffDelete',   s:gui08, s:gui01,  s:cterm08, s:cterm01, '', '')
" call <sid>hi('DiffText',     s:gui0D, s:gui01,  s:cterm0D, s:cterm01, '', '')
" call <sid>hi('DiffAdded',    s:gui0B, s:gui00,  s:cterm0B, s:cterm00, '', '')
" call <sid>hi('DiffFile',     s:gui08, s:gui00,  s:cterm08, s:cterm00, '', '')
" call <sid>hi('DiffNewFile',  s:gui0B, s:gui00,  s:cterm0B, s:cterm00, '', '')
" call <sid>hi('DiffLine',     s:gui0D, s:gui00,  s:cterm0D, s:cterm00, '', '')
" call <sid>hi('DiffRemoved',  s:gui08, s:gui00,  s:cterm08, s:cterm00, '', '')
" call <sid>hi('SpellBad',     '', s:gui00, '', s:cterm00, 'undercurl', s:gui08)
" call <sid>hi('SpellLocal',   '', s:gui00, '', s:cterm00, 'undercurl', s:gui0C)
" call <sid>hi('SpellCap',     '', s:gui00, '', s:cterm00, 'undercurl', s:gui0D)
" call <sid>hi('SpellRare',    '', s:gui00, '', s:cterm00, 'undercurl', s:gui0E)
