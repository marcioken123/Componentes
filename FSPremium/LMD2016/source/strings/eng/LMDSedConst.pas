unit LMDSedConst;
{$I LMDCmps.inc}

{###############################################################################

LMDSedConst unit (VT)
---------------------
This unit contains Resource Strings for the LMD-Tools Syntax Edit packages.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

{------------------------------------------------------------------------------}

resourcestring
  //Utils
  SLMDBadSegment = 'Bad segment passed to function';

  //Parser
  SLMDSedIntAttirbuteRequired = 'Int attribute %s required';
  SLMDSedIntAttrRangeRequired = 'Int attribute %s should be in range (%d given instead): [%d, %d]';
  SLMDSedBadIntAttribute = 'Malformed int attribute %s';
  SLMDSedBoolAttributeRequired = 'Boolean attribute %s required';
  SLMDSedBadBoolAttribute = 'Malformed boolean attribute %s. 0/1 of "true"/"false" required';
  SLMDSedEmptyRegexAttribute = 'Regex attribute ''%s'' is empty in node ''%s''';
  SLMDSedEmptyRegexSubNode = 'Regex subnode ''%s'' is empty in node ''%s''';

  SLMDSedEmptyRegexNodeText = 'Regex attribute ''%s'' and node text is empty in regex node ''%s''';
  SLMDSedBadRegexAttribute = 'Error in ''%s'' attribute in %s node: regex: %s, error: %s';
  SLMDSedBadRegexSubNode = 'Error in ''%s'' subnode in %s node: regex: %s, error: %s';
  SLMDSedBadRegexNodeText = 'Error in regex node text in regex node ''%s'': regex: %s, error: %s';

  SLMDSedEmptyInheritAttribute = 'Empty ''inherit'' attribute! Should be valid scheme reference!';
  SLMDSedUnnamedScheme = 'Scheme has no name!';
  SLMDSedEmptyKeywordNode = 'Empty ''Keyword'' node!';
  SLMDSedEmptyKeywordsList = 'Empty keywords list in ''Keywords'' node!';
  SLMDSedStartGroupUsedBadIndex = 'startGroupUsed should be >=0  and < (regex groups count: %d)';

  SLMDSedEndGroupUsedBadIndex = 'endGroupUsed should be >=0  and < (regex groups count: %d)';
  SLMDSedInvalidFontStyle = 'Invalid ''fontStyle'' attribute value: ';
  SLMDSedTokenShouldHaveNameAttr = '<Token> node should have ''name'' attribute';
  SLMDSedInvalidBgColor = 'Invalid color format for attribute ''backgroundColor''';
  SLMDSedInvalidTextColor = 'Invalid color format for attribute ''textColor''';
  SLMDSedErrorLoadingSyntaxScheme = 'Error %s on loading syntax scheme contents. Original message: %s';
  SLMDSedDocumentShouldHaveSchemeList = 'Document should have SchemeList element!';
  SLMDSedSchemeListShouldNameRoot = 'SchemeList element in document should have non-empty ''root'' attribute!';
  SLMDSedRootSchemeNotFound = 'Can''t find root Scheme element with name ''%s'' in document!';
  SLMDSedCantFindSchemeDocument = 'Scheme reference <%s> does not have corresponding document';
  SLMDSedCantFindSchemeByRef = 'Can''t find referrent scheme for name ''%s''!';
  SLMDSedCyclicInheritance = 'Cyclic reference in inherit chain! ==> Chain: ';
  SLMDSedSchemeLoadError = 'Scheme loading error: ';
  SLMDSedCurrentDocIs = 'Current document: %s, %s';
  SLMDSedCurrentSchemeNameIs = 'Current scheme name: %s';
  SLMDSedCurrentRuleCodeIs = 'Current rule code: ';

  SLMDSedCurrentBlockCodeIs = 'Current block code: ';
  SLMDSedDocumentLoadingError = 'Schemes document loading error: ';
  SLMDSedBadIntCodeName = 'Malformed int-code name: ';
  SLMDSedAttributesDocIs = 'Attributes document: %s';
  SLMDSedErrorLoadingColorScheme = 'Error %s on loading color scheme contents. Original message: %s';
  SLMDSedAttributesDocNoRootNode = 'Can''t find root <Attributes> node.';
  SLMDSedUniqueTokenName = 'Attribute ''name'' of node <Token> or <TokenAlias> should be unique. Found duplicate: %s';
  SLMDSedEmptyTokenName = 'Attribute ''name'' of node <Token> should exist and be non-empty';
  SLMDSedTokenNodeReadingError = '<Token> node reading error: %s';
  SLMDSedInvalidTokenReference = 'Token attribute ''%s'' should be valid token reference!';
  SLMDSedRegexNodeInnerSchemeTokenBoth = 'Regex node can''t contain both ''innerScheme'' and ''token'' attributes!';
  SLMDSedInvalidInnerScheme = 'innerScheme should be set and be valid scheme reference!';
  SLMDSedStartTokenInRegexBlock = 'RegexBlock can''t contain ''start_token'' attribuites inside or ''token*'' attributes in ''Start'' subnode';
  SLMDSedInnerContentGoupBadIndex = 'innerContentGroup should be < %d (start regex sub-expressions count)!';
  SLMDSedChainBlockShouldHaveUniqueNameInScheme = 'Chain block should have unique name in scheme';
  SLMDSedChainBlockNotFound = 'Can''t find chain block by name ''%s''';

  SLMDSedEmptyTokenLine = 'This line does not have any tokens';
  SLMDSedBadTokenIdx = 'Bad index for token: %d. Valid range: [%d, %d]';  

  SLMDSedDecodeAttributesBadArgument = 'Bad argument for LMDDecodeTokenXML: CustomAttributes field should be nil';

  //Document
  SLMDSedDocInvalidMarkUsed = 'Can''t get/set attributes for invalid marker. Mark.Valid=false.';
  SLMDSedDocDisposedMarkersUsed = 'This markers collection was deleted from Document. Can''t use it.';
  SLMDSedDocCantRemoveInvalidMarker = 'Can''t delete marker with Valid=false';
  SLMDSedDocInvalidCharIndex = 'Invalid char index: %d. Valid range: [%d, %d].';
  SLMDSedDocInvalidCharInsIndex = 'Invalid char index for insert: %d. Valid range: [%d, %d].';
  SLMDSedDocInvalidSegment = 'Invalid segment passed to document method';
  SLMDSedDocSyntaxSchemeNotFound = 'Can''t find syntax scheme by name: ';
  SLMDSedDocColorSchemeNotFound = 'Can''t find color scheme by name: ';
  SLMDSedInvalidSchemeName = 'Scheme collection item name should be nonempty and unique';
  SLMDSedInvalidRangeOrder = 'Range start should be less or equal to range end: range: [%d, %d]';
  SLMDSedDocMethodInUpdatingState = 'This method is prohibited while document in compound edit';
  SLMDSedDocChangesLocked = 'Document is locked for changes';
  SLMDSedDocMarkersLocked = 'Document markers are locked for changes';
  SLMDSedDocCantUndoForAuthor = 'Can''t undo for author %d';
  SLMDSedDocCantRedoForAuthor = 'Can''t redo for author %d';
  SLMDSedDocCantUndo = 'Undo stack is empty';
  SLMDSedDocCantRedo = 'Redo stack is empty';
  SLMDSedDocNotInCompoundEdit = 'Document should be in compound edit mode here';
  SLMDSedDocInvalidCustomMarkers = 'Custom markers are nil or not belongs to this document';
  SLMDSedDocCantDetachDocumentMarkers = 'This markers collection (Bookmarks, Breakpoints etc) can''t be detached from Document';
  SLMDSedInvalidLineIdx = 'Invalid line index: %d. Valid range: [%d, %d]';
  SLMDSedInvalidLineColIdx = 'Invalid line column: %d. Valid range: [0, %d]';  
  SLMDSedDocInvalidOffsetToSearch = 'Invalid offset given for search in document: %d. Valid range: [%d, %d]';
  SLMDSedDocInvalidOffset = 'Invalid offset given to document: %d. Valid range: [%d, %d]';
  SLMDSedDocBreakpointExpectedByMethod = 'This method expects passed marker belongs to Breakpoints document collection';
  SLMDSedDocDbgStackExpectedByMethod = 'This method expects passed marker belongs to DebuggerStackLines document collection';
  SLMDSedDocReadOnly = 'Document is read-only';
  SLMDSedDocInternalClassCreate = 'This internal Document class should not be created manually.';  

  //View
  SLMDSedViewBadPhysScreenLineIdx = 'Invalid physical line index: %d. Valid range: [%d, %d]';
  SLMDSedViewBadPhysLineIdx = 'Invalid physical line on screen index: %d. Valid range: [%d, %d]';
  SLMDSedViewBadScreenWidth = 'Invalid screen width given: [%d]. Valid range: [1..MAXINT]';
  SLMDSedViewBadScreenHeight = 'Invalid screen height given: [%d]. Valid range: [1..MAXINT]';
  SLMDSedViewBadNegativeScrollY = 'Bad scroll line index: [y < 0].';
  SLMDSedViewBadNegativeScrollYInPos = 'Bad scroll position: [y < 0].';
  SLMDSedViewBadNegativeScrollXInPos = 'Bad scroll position: [x < 0].';
  SLMDSedViewBadScrollPosForOffset = 'Bad scroll position: [y=%d]. Valid range: [y=%d]-[y=%d]';
  SLMDSedViewBadScrollRangeOrder = 'Bad scroll range order: [x=%d, y=%d]-[x=%d, y=%d]';
  SLMDSedViewCollapsedLineOp = 'Can''t do this operation with collapsed fold line: line: %d';
  SLMDSedViewNotCollapsedLineOp = 'Can''t do this operation with non-collapsed fold line: line: %d';
  SLMDSedViewOpWithFoldOnly = 'This operation requires argument line to be fold start: line: %d';
  SLMDSedViewBadTabWidth = 'Bad tab width: %d. It should be in bounds: [%d, %d]';  
  SLMDSedViewBadScrollLine = 'Bad scroll line index: %d. Valid index: [%d, %d]';
  SLMDSedViewBadScreenLine = 'Bad screen line index: %d. Valid index: [%d, %d]';
  SLMDSedViewBadScreenLineRange = 'Bad screen line range order: [%d, %d]';
  SLMDSedViewBadOffsetForScroll = 'Bad offset to get its scroll position: %d. It should be inside some scroll line.';
  SLMDSedViewBadOffsetRange = 'Bad offset range: [start: %d, count: %d]. Its bounds should be inside some scroll line.';
  SLMDSedViewBadScrollLineToScrConvert = 'Bad scroll line index to convert to screen: %d. Valid index: [%d, %d]';
  SLMDSedViewBadScrollColToScrConvert = 'Bad scroll column index to convert to screen: %d, for line: %d. Valid index: [%d, %d]';
  SLMDSedViewInvisibleOffset = 'This operation requires given offset to be visible. Offset: %d';
  SLMDSedViewInvisibleLine = 'This operation requires given physical line to be visible. Line: %d';
  SLMDSedViewFixedFontRequired = 'Only fixed-width fonts are accepted by Syntax Edit';
  SLMDSedViewDocNotSet = 'Document must be attached to View for this operation';
  SLMDSedViewChangesLocked = 'View is locked for changes';
  SLMDSedViewGutterBarInvalid = 'Gutter bar is invisible or not belongs to this view';
  SLMDSedViewBadSpecialChar = 'Special char should be non-empty string with single char, or Delphi-like encoded char';
  SLMDSedViewNotInSearchMode = 'You should call BeginSearch before SearchNext';
  SLMDSedViewNotInReplaceMode = 'You should call BeginReplace before ReplaceNext';
  SLMDSedViewIsReadOnly = 'This View or its Document is read-only.';
  SLMDSedViewUniqueCommand = 'Command items in collection should have unique Command property.';
  SLMDSedViewUniqueCommandBinding = 'Keybindings should be unique in Command items';
  SLMDSedViewInternalClassCreate = 'This internal View class should not be created manually.';
  SLMDSedViewInvalidGutterBarWidth = 'Gutter bar width should be greater than zero';
  SLMDSedViewInvalidGutterBarPadding = 'Gutter bar padding should be greater or equal to zero';
  SLMDSedViewIncrementalSearchModeRequired = 'View should be in incremental search mode for this command (or method)';
  SLMDSedViewNoIncrementalSearchModeRequired = 'View should NOT be in incremental search mode for this command (or method)';
  SLMDSedViewComplListShownRequired = 'Completion list should be shown for this command (or method)';
  SLMDSedViewNoComplListShownRequired = 'Completion list should NOT be shown for this command (or method)';

  //Dialogs
  SLMDSedDlgGotoLine = 'Go to line';

  SLMDSedDlgSearchCancel = 'Cancel';
  SLMDSedDlgSearchOk = 'OK';
  SLMDSedDlgReplaceAll = 'Replace &All';
  SLMDSedDlgSearchText = '&Text to search';
  SLMDSedDlgReplaceText = '&Replace with';
  SLMDSedDlgSearchOptions = 'Options';
  SLMDSedDlgSearchDirection = 'Direction';
  SLMDSedDlgSearchBounds = 'Bounds for replace all';
  SLMDSedDlgSearchStartFrom = 'Start from';
  SLMDSedDlgSearchRegexps = 'Regular e&xpressions';
  SLMDSedDlgSearchWholeWords = '&Whole words only';
  SLMDSedDlgSearchCaseSensitive = '&Case sensitive';
  SLMDSedDlgSearchConfirmReplace = '&Prompt on replace';
  SLMDSedDlgSearchBackward = '&Backward';
  SLMDSedDlgSearchForward = 'Forwar&d';
  SLMDSedDlgSearchAllText = '&Global';
  SLMDSedDlgSearchSelection = '&Selection';
  SLMDSedDlgSearchFromCursor = '&From cursor';
  SLMDSedDlgSearchFromTextStart = 'From text &start/end';

  SLMDSedDlgSearchBadRegex = 'Error in search expression or substitution string: %s';
  SLMDSedDlgReplaceConfirm = 'Replace this occurrence of %s?';
  SLMDSedDlgContinueSearchFromStart = 'End of document reached. Continue search/replace from start?';
  SLMDSedDlgContinueSearchFromEnd = 'Start of document reached. Continue search/replace from end?';

  SLMDSedLoadSyntaxSchemes = 'Load syntax schemes...';
  SLMDSedLoadColorSchemes = 'Load color schemes...';

  SLMDSedColorSchemeNotFound = 'Can''t find color scheme ''%s''';  
  SLMDSedColorSchemeCustomColor = 'Custom...';
  SLMDSedColorSchemeAddToken = 'Enter new token name';
  SLMDSedColorSchemeAddCustomAttr = 'Enter new custom attribute name';
  SLMDSedColorSchemeDuplicateCustomAttr = 'Custom attribute name should be unique';
  SLMDSedColorSchemeDuplicateToken = 'Token name should be unique';
  SLMDSedColorSchemeLoadError = 'Error while loading color scheme ''%s'': %s';
  SLMDSedColorSchemeCaption = 'Color scheme editor';
  SLMDSedColorSchemeTokens = 'Tokens';
  SLMDSedColorSchemeTokensPlusHint = 'Add new token';
  SLMDSedColorSchemeTokensMinusHint = 'Remove current token';
  SLMDSedColorSchemeColors = 'Colors';
  SLMDSedColorSchemeColor = '&Color:';
  SLMDSedColorSchemeBgColor = '&Background color:';
  SLMDSedColorSchemeAttributes = 'Attributes';
  SLMDSedColorSchemeItalic = '&Italic';
  SLMDSedColorSchemeBold = 'Bol&d';
  SLMDSedColorSchemeUnderline = '&Underline';
  SLMDSedColorSchemeStrikeout = '&StrikeOut';
  SLMDSedColorSchemeFontAttributesDefined = '&Attributes defined';
  SLMDSedColorSchemeExample = 'Example';
  SLMDSedColorSchemeCancel = 'Cancel';
  SLMDSedColorSchemeOk = 'OK';
  SLMDSedColorSchemeMainAttrs = 'Main attributes';
  SLMDSedColorSchemeCustomAttrs = 'Custom attributes';
  SLMDSedColorSchemeCustomAttrName = 'Name';
  SLMDSedColorSchemeCustomAttrValue = 'Value';
  SLMDSedColorSchemeRemoveCustomAttrHint = 'Remove this custom attribute';
  SLMDSedColorSchemeAddCustomAttrHint = 'Add new custom attribute';
  SLMDSedColorSchemeRemoveTokenHint = 'Remove this token';
  SLMDSedColorSchemeAddTokenHint = 'Add new token';

  SLMDSedCmdLeft = 'Move left';
  SLMDSedCmdRight = 'Move right';
  SLMDSedCmdUp = 'Move up';
  SLMDSedCmdDown = 'Move down';
  SLMDSedCmdLineHome = 'Move to line start';
  SLMDSedCmdLineEnd = 'Move to line end';
  SLMDSedCmdNextWord = 'Move to next word';
  SLMDSedCmdPrevWord = 'Move to prev word';
  SLMDSedCmdPageUp = 'Move to prev page';
  SLMDSedCmdPageDown = 'Move to next page';
  SLMDSedCmdPageHome = 'Move to page start';
  SLMDSedCmdPageEnd = 'Move to page end';
  SLMDSedCmdTextHome = 'Move to text start';
  SLMDSedCmdTextEnd = 'Move to text end';

  SLMDSedCmdUndo = 'Undo';
  SLMDSedCmdRedo = 'Redo';
  SLMDSedCmdCut = 'Cut selection';
  SLMDSedCmdCopy = 'Copy selection';
  SLMDSedCmdPaste = 'Paste selection';

  SLMDSedCmdDeletePrevChar = 'Delete char left';
  SLMDSedCmdDeleteChar  = 'Delete char right';
  SLMDSedCmdDeletePrevWord  = 'Delete word left';
  SLMDSedCmdDeleteWord  = 'Delete word right';
  SLMDSedCmdDeleteToLineEnd  = 'Delete to line end';
  SLMDSedCmdDeleteToLineWrap  = 'Delete to line wrap';  
  SLMDSedCmdDeleteLine  = 'Delete line';  
  SLMDSedCmdChar = 'Insert any char';
  SLMDSedCmdNewLine  = 'Insert new line';
  SLMDSedCmdTab = 'Insert tab';
  SLMDSedCmdTabOrIndent = 'Move to prev line indent or insert tab';  
  SLMDSedCmdIndent = 'Indent selection';
  SLMDSedCmdUnIndent = 'Unindent selection';
  SLMDSedCmdIndentToPrev = 'Indent selection to prev indent';
  SLMDSedCmdUnIndentToPrev = 'Unindent selection to prev indent';
  SLMDSedCmdBackspaceOrUnindent = 'Delete char backward or unindent';

  SLMDSedCmdIncSearchStart = 'Start incremental search';
  SLMDSedCmdIncSearchBack = 'Move to previous result';
  SLMDSedCmdIncSearchFwd = 'Move to next result';

  SLMDSedCmdSearchNext = 'Move to next search result';

  SLMDSedCmdScrollUp = 'Scroll screen up by line';
  SLMDSedCmdScrollDown = 'Scroll screen down by line';

  SLMDSedCmdSelectLeft = 'Widen selection left by char';
  SLMDSedCmdSelectRight = 'Widen selection right by char';
  SLMDSedCmdSelectPrevWord = 'Widen selection left by word';
  SLMDSedCmdSelectNextWord = 'Widen selection right by word';
  SLMDSedCmdSelectUp = 'Widen selection up by line';
  SLMDSedCmdSelectDown = 'Widen selection down by line';
  SLMDSedCmdSelectPageUp = 'Widen selection up by page';
  SLMDSedCmdSelectPageDown = 'Widen selection down by page';
  SLMDSedCmdSelectPageHome = 'Widen selection up to page start';
  SLMDSedCmdSelectPageEnd = 'Widen selection up to page end';
  SLMDSedCmdSelectLineHome = 'Widen selection up to line start';
  SLMDSedCmdSelectLineEnd = 'Widen selection up to line end';
  SLMDSedCmdSelectTextHome = 'Widen selection up to text start';
  SLMDSedCmdSelectTextEnd = 'Widen selection up to text end';

  SLMDSedCmdSelectLeftBlock      = 'Widen sel left by char (block mode)';
  SLMDSedCmdSelectRightBlock     = 'Widen sel right by char (block mode)';
  SLMDSedCmdSelectPrevWordBlock  = 'Widen sel left by word (block mode)';
  SLMDSedCmdSelectNextWordBlock  = 'Widen sel right by word (block mode)';
  SLMDSedCmdSelectUpBlock        = 'Widen sel up by line (block mode)';
  SLMDSedCmdSelectDownBlock      = 'Widen sel down by line (block mode)';
  SLMDSedCmdSelectPageUpBlock    = 'Widen sel up by page (block mode)';
  SLMDSedCmdSelectPageDownBlock  = 'Widen sel down by page (block mode)';
  SLMDSedCmdSelectPageHomeBlock  = 'Widen sel up to page start (block mode)';
  SLMDSedCmdSelectPageEndBlock   = 'Widen sel up to page end (block mode)';
  SLMDSedCmdSelectLineHomeBlock  = 'Widen sel up to line start (block mode)';
  SLMDSedCmdSelectLineEndBlock   = 'Widen sel up to line end (block mode)';
  SLMDSedCmdSelectTextHomeBlock  = 'Widen sel up to text start (block mode)';
  SLMDSedCmdSelectTextEndBlock   = 'Widen sel up to text end (block mode)';

  SLMDSedCmdSelectAll = 'Select all';
  SLMDSedCmdSelectNone = 'Cancel selection';

  SLMDSedCmdToggleOverwrite = 'Toggle overwrite mode';
  SLMDSedCmdCompletionShow = 'Show completion list for current word';


  SLMDSedCmdCatMovement = 'Movement';
  SLMDSedCmdCatSelection = 'Selection';
  SLMDSedCmdCatSelectionBlock = 'Selection (block mode)';
  SLMDSedCmdCatDeletion = 'Deletion';
  SLMDSedCmdCatClipboard = 'Clipboard';
  SLMDSedCmdCatOther = 'Other';
  SLMDSedCmdCatIncSearch = 'Incremental search';
  SLMDSedCmdCatIndent = 'Indentation';

  SLMDSedKeyDlgCaption = 'Keybindings editor';
  SLMDSedKeyDlgCancel = 'Cancel';
  SLMDSedKeyDlgOk = 'Ok';
  SLMDSedKeyDlgDeleteBinding = '&Delete binding';
  SLMDSedKeyDlgResetBinding = '&Reset to defaults';
  SLMDSedKeyDlgResetAllBinding = 'Reset a&ll to defaults';
  SLMDSedKeyDlgAddBinding = '&Add binding';
  SLMDSedKeyDlgClearBinding = '&Clear';  

  SLMDSedKeyDlgReplaceBinding = 'Keybinding ''%s'' will override actions:'+
                                #13+#10+'%s'+#13+#10+'Continue?';

  SLMDSedKeyDlgResetAlert = 'After reset those actions will be overriden:'+
                            #13+#10+'%s'+#13+#10+'Continue?';

  SLMDSedTaskPagesNotPrepared = 'You should call PreparePages before this method';
  SLMDSedTaskPagesNotFinalized = 'You should call FinalizePages before this method';
  SLMDSedTaskPrinterNotAssigned = 'Printer property should be assigned for this method';
  SLMDSedTaskViewNotAssigned = 'View property should be assigned for this method';

  SLMDSedBadEncodingName = 'Bad encoding name ''%s''. You should write valid system encoding integer-code or valid name';

  SLMDSedDialogViewNotSet = 'View property should be assigned for this method';
  SLMDSedDialogDocumentNotSet = 'Document property should be assigned for this method';
  SLMDSedDialogFindCaption = 'Find text';
  SLMDSedDialogReplaceCaption = 'Find text';
  SLMDSedDialogFindBadState = 'You must call Execute method first. View SearchState should be stInSearch';
  SLMDSedDialogReplaceBadState = 'You must call Execute method first. View SearchState should be stInReplace';
  SLMDSedDialogColorSchemeNotFound = 'Color scheme %s not found in Document.ColorSchemes collection';
  SLMDSedDialogSyntaxSchemeNotFound = 'Syntax scheme %s not found in Document.SyntaxSchemes collection';  
  SLMDSedDialogSchemeNotSet = 'Scheme property should be set for this method';
{------------------------------------------------------------------------------}

implementation

end.