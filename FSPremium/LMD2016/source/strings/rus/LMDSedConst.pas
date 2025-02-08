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
  SLMDBadSegment = '�������� ������� ������� �������';
  
  //Parser
  SLMDSedIntAttirbuteRequired = '����� ��������� ������� %s ���� Int';
  SLMDSedIntAttrRangeRequired = '����� ��������� ������� %s ���� Int � ��������� (� �� ���: %d ): [%d, %d]';
  SLMDSedBadIntAttribute = '����� �������� ������ Int-��������: %s';
  SLMDSedBoolAttributeRequired = '����� ��������� ������� %s ���� Boolean';
  SLMDSedBadBoolAttribute = '����� �������� ������ Boolean-��������: %s. ���������� ������: 0/1 ��� "true"/"false"';
  SLMDSedEmptyRegexAttribute = '����� ������ Regex-������� ''%s'' � ���� ''%s''. ����� ��������.';
  SLMDSedEmptyRegexSubNode = '����� ������ Regex-������� ''%s'' � ���� ''%s''. ����� ��������.';

  SLMDSedEmptyRegexNodeText = '������ ������ Regex-������� ''%s'' � ��������������� ������� � ����''%s''. ������� Regexp � ���� ��� �������.';
  SLMDSedBadRegexAttribute = '������ � �������� ''%s'' ���� %s: regex: %s, ������: %s';
  SLMDSedBadRegexSubNode = '������ � �������''%s'' ���� %s: regex: %s, ������: %s';
  SLMDSedBadRegexNodeText = '������ � Regex-���� ''%s'': regex: %s, ������: %s';

  SLMDSedEmptyInheritAttribute = '������� ''inherit'' ������ ���� �������� ������� �� �����';
  SLMDSedUnnamedScheme = '�� ������ ��� ��� �����';
  SLMDSedEmptyKeywordNode = '���� ''Keyword'' �� ������ ���� ������';
  SLMDSedEmptyKeywordsList = '���� ''Keywords'' ������ ��������� �������� ������ �������� ����';
  SLMDSedBadSkipTokenName = '� SkipSyntaxTokens ������ ����� ''%s'', �� ������������ �� � �����, �� � � �������. ������� �����-������ ����� �� �����';  
  SLMDSedStartGroupUsedBadIndex = '������� startGroupUsed ������ ���� � ���������: >=0  and < (regex groups count: %d)';

  SLMDSedEndGroupUsedBadIndex = '������� endGroupUsed ������ ���� � ���������: >=0  � < (����� ����� � regexp-�: %d)';
  SLMDSedInvalidFontStyle = '�������� ������ �������� ''fontStyle'': ';
  SLMDSedTokenShouldHaveNameAttr = '�� ������ ��� ��� ���� <Token>';
  SLMDSedInvalidBgColor = '����� �������� ������ ����� ��� �������� ''backgroundColor''';
  SLMDSedInvalidTextColor = '����� �������� ������ ����� ��� �������� ''textColor''';
  SLMDSedErrorLoadingSyntaxScheme = '������ %s �� �������� �������������� �����. ������ �����: %s';
  SLMDSedDocumentShouldHaveSchemeList = '� ��������� ������ ���� �������� �������� SchemeList!';
  SLMDSedSchemeListShouldNameRoot = '���� SchemeList ������ ��������� ������� ''root'' � ������ ��������� �����!';
  SLMDSedRootSchemeNotFound = '� ��������� �� ��������� ��������� ����� ''%s''!';
  SLMDSedCantFindSchemeDocument = '�� ��������� �������� ��� ����� ''%s''';
  SLMDSedCantFindSchemeByRef = '�� ��������� ����� �� �����: ''%s''!';
  SLMDSedCyclicInheritance = '����������� ������ � ������� ������������ ����! ==> �������: ';
  SLMDSedSchemeLoadError = '������ �������� �����: ';
  SLMDSedCurrentDocIs = '������� ��������: %s, %s';
  SLMDSedCurrentSchemeNameIs = '��� ������� �����: %s';
  SLMDSedCurrentRuleCodeIs = '��� �������� ���� � �������� (RegexRule/RegexBlock etc): ';

  SLMDSedCurrentBlockCodeIs = '��� �������� ���� <SyntaxBlock>: ';
  SLMDSedDocumentLoadingError = '������ �������� XML-��������� �� �������: ';
  SLMDSedBadIntCodeName = '��������� ��� ������: ';
  SLMDSedAttributesDocIs = '�������� � �������� ������: %s';
  SLMDSedErrorLoadingColorScheme = '������ ''%s'' �� �������� �������� �����. ������ �����: %s';
  SLMDSedAttributesDocNoRootNode = '�������� ����� ������ ��������� �������� ������� <Attributes>.';
  SLMDSedUniqueTokenName = '������� ''name'' � ���� <Token> ������ ���� �������� �� ���� �������� �����. ������� ������������� ���: %s';
  SLMDSedEmptyTokenName = 'Attribute ''name'' of node <Token> should exist and be non-empty';
  SLMDSedTokenNodeReadingError = '������ �������� ���� <Token>: %s';
  SLMDSedInvalidTokenReference = '������� ''%s'' ���� <Token> ������ ���� ������� �� ������������ <Token>!';
  SLMDSedRegexNodeInnerSchemeTokenBoth = '���� <Regex> �� ����� ��������� �������� ''innerScheme'' � ''token'' ������������';
  SLMDSedInvalidInnerScheme = '������� ''innerScheme'' ������ ��������� �� �����-������ �����';
  SLMDSedStartTokenInRegexBlock = '���� <RegexBlock> �� ����� ��������� �������� ''start_token'' ��� ''token*'' � ������� ''Start''';
  SLMDSedInnerContentGoupBadIndex = '������� ''innerContentGroup'' ������ ���� ������ %d (����� ������������ � ��������� Regexp-�)';
  SLMDSedChainBlockShouldHaveUniqueNameInScheme = '������� ''name'' ���� <ChainBlock> ������ ���� �������� ��� ���� ����� <ChainBlock> � �����';
  SLMDSedChainBlockNotFound = '�� ��������� ���� <ChainBlock> �� �����:''%s''';
  SLMDSedEmptyTokenLine = 'This line does not have any tokens';
  SLMDSedBadTokenIdx = 'Bad index for token: %d. Valid range: [%d, %d]';  

  SLMDSedDecodeAttributesBadArgument = 'Bad argument for LMDDecodeTokenXML: CustomAttributes field should be nil';

  //Document
  SLMDSedDocInvalidMarkUsed = '������ �������� � ���������� ��������� �������. Mark.Valid=false.';
  SLMDSedDocDisposedMarkersUsed = '��� ��������� �������� ���� ������� �� ���������. ������ �� ������������ ������.';
  SLMDSedDocCantRemoveInvalidMarker = '������ ������� ������ �� ��������� Valid=false';
  SLMDSedDocInvalidCharIndex = '�������� ������ �������: %d. ���������� ��������: [%d, %d].';
  SLMDSedDocInvalidCharInsIndex = '�������� ������ �������: %d. ���������� ��������: [%d, %d].';
  SLMDSedDocInvalidSegment = '������ Segment ����� ���������� ������ ���������';
  SLMDSedDocSyntaxSchemeNotFound = '�� ��������� �������������� ����� �� �����: ';
  SLMDSedDocColorSchemeNotFound = '�� ��������� �������� ����� �� �����: ';
  SLMDSedInvalidSchemeName = '��� �������� � ��������� ������ ���� ���������� � ��������';
  SLMDSedInvalidRangeOrder = '������ ��������� ������ ���� ������ ��� ����� ��� �����: ��������: [%d, %d]';
  SLMDSedDocMethodInUpdatingState = '���� ����� ������ ��������, ���� �������� � �������� ������ (Doc.InsideCompoundEdit=true)';
  SLMDSedDocChangesLocked = '������ ��������� � ������ ��������� ���������';
  SLMDSedDocMarkersLocked = '������ ��������� ��������� �������� ���������';
  SLMDSedDocCantUndoForAuthor = '������ ��� ������ � ID=%d ����������';
  SLMDSedDocCantRedoForAuthor = '������� ��� ������ � ID=%d ����������';
  SLMDSedDocCantUndo = '������ ����������. ���� ����� ����.';
  SLMDSedDocCantRedo = '������� ����������. ���� ��������� ����.';
  SLMDSedDocNotInCompoundEdit = '�������� ������ ���� � �������� ������ ��� ���� ��������. (Doc.InsideCompoundEdit=true)';
  SLMDSedDocInvalidCustomMarkers = '�������� ������� �� ����������� ����� ���������';
  SLMDSedDocCantDetachDocumentMarkers = 'Document.Bookmarks or Document.Breakpoints can''t be detached from Document';
  SLMDSedInvalidLineIdx = '������ ������ ��� �������: %d. ���������� ��������: [%d, %d]';
  SLMDSedDocInvalidOffsetToSearch = '������ ������ ��� ������ � ���������: %d. ���������� ��������: [%d, %d]';
  SLMDSedDocInvalidOffset = '������ ������ ������� � ���������: %d. ���������� ��������: [%d, %d]';
  SLMDSedDocBreakpointExpectedByMethod = '������ ��� ����� ������ ������ ������������ ��������� Breakpoints';
  SLMDSedDocReadOnly = '��������� ��������� � ��������� (ReadOnly=true)';
  SLMDSedDocInternalClassCreate = '���� ������ �� ����� ���� ������ �������������. ��� ��� �������� ��� ���� ������.';  

  //View
  SLMDSedViewBadPhysScreenLineIdx = '������ ������ ���������� �������: %d. ���������� ��������: [%d, %d]';
  SLMDSedViewBadPhysLineIdx = '������ ������ ���������� ������� � �������� ������: %d. ���������� ��������: [%d, %d]';
  SLMDSedViewBadScreenWidth = 'Invalid screen width given: [%d]. Valid range: [1..MAXINT]';
  SLMDSedViewBadScreenHeight = 'Invalid screen height given: [%d]. Valid range: [1..MAXINT]';
  SLMDSedViewBadNegativeScrollY = 'Bad scroll line index: [y < 0].';
  SLMDSedViewBadNegativeScrollYInPos = 'Bad scroll position: [y < 0].';
  SLMDSedViewBadNegativeScrollXInPos = 'Bad scroll position: [x < 0].';
  SLMDSedViewBadScrollPosForOffset = '������ �������� ������� ��� ��������� � ������� �������: [x=%d, y=%d]. ���������� ��������: [x=%d, y=%d]-[x=%d, y=%d]';
  SLMDSedViewBadScrollRangeOrder = '������������ ������� � �������� ���������: [x=%d, y=%d]-[x=%d, y=%d]';
  SLMDSedViewCollapsedLineOp = '������ ��������� ��� �������� �� �������� ���������� ��������: %d';
  SLMDSedViewNotCollapsedLineOp = '������ ��������� ��� �������� � ���������� ���������� ��������: %d';
  SLMDSedViewOpWithFoldOnly = '��� ���� �������� ���������, ����� ������� ���� ������� ������: %d';
  SLMDSedViewBadTabWidth = 'Bad tab width: %d. It should be in bounds: [%d, %d]';  
  SLMDSedViewBadScrollLine = '������ ������ �������� �������: %d. ���������� ��������: [%d, %d]';
  SLMDSedViewBadScreenLine = '������ ������ ���������� �������: %d. ���������� ��������: [%d, %d]';
  SLMDSedViewBadScreenLineRange = '�������� �������� ���������� �������: [%d, %d]';
  SLMDSedViewBadOffsetForScroll = '������ �������� �������� ��������� ������� �� ����� �������: %d. ��������, �� ��������� �� �������� ������� ��� ������ �������� ������ (CRLF).';
  SLMDSedViewBadOffsetRange = 'Bad offset range: [start: %d, count: %d]. Its bounds should be inside some scroll line.';
  SLMDSedViewBadScrollLineToScrConvert = '������ ������ �������� ������� ��� ��������� � � ����������: %d. ���������� ��������: [%d, %d]';
  SLMDSedViewBadScrollColToScrConvert = 'Bad scroll column index to convert to screen: %d, for line: %d. Valid index: [%d, %d]';  
  SLMDSedViewInvisibleOffset = '��� ���� �������� ���������, ����� ������ �������� �������� ��� �������. ������: %d';
  SLMDSedViewInvisibleLine = 'This operation requires given physical line to be visible. Line: %d';
  SLMDSedViewFixedFontRequired = 'Syntax Edit �������� ������ �� fixed-with ��������';
  SLMDSedViewDocNotSet = '��� ���� �������� ���������, ����� �������� Document ���� ������';
  SLMDSedViewChangesLocked = '�� ����� ����� ������� ��������� � ���� ���������';
  SLMDSedViewGutterBarInvalid = '���� Gutter bar ��������� ��� �� ����������� ����� ����';
  SLMDSedViewBadSpecialChar = '����. ������ ������ ���� ��� �������� Ansi-��������, ��� ����� ������� � �������, ���������� ��� StrToInt';
  SLMDSedViewNotInSearchMode = '����� ������� SearchNext ����� ������� BeginSearch';
  SLMDSedViewNotInReplaceMode = '����� ������� ReplaceNext ����� ������� BeginReplace';
  SLMDSedViewIsReadOnly = '��������� ��������� � ��������� ����� ���� (View.Document.ReadOnly=true)';
  SLMDSedViewUniqueCommand = '������� � ��������� ������ ���� ��������� �� �������� Command';
  SLMDSedViewUniqueCommandBinding = '��������� ������ (Shortcut+Shortcut2) � ������� TLMDEditCommandBinding ������ ���� ���������� �� ���� ��������� ������.';
  SLMDSedViewInternalClassCreate = '���� ������ �� ����� ���� ������ �������������. ��� ��� ��� ��� ���� ������.';
  SLMDSedViewInvalidGutterBarWidth = '�������� �������� "Width" ������� TLMDGutterBar ������ ���� ������ ����';
  SLMDSedViewInvalidGutterBarPadding = '�������� ������� "LeftPadding, RightPadding" ������� TLMDGutterBar ������ ���� ������ ��� ����� ����';
  SLMDSedViewIncrementalSearchModeRequired = 'View should be in incremental search mode for this command (or method)';
  SLMDSedViewNoIncrementalSearchModeRequired = 'View should NOT be in incremental search mode for this command (or method)';
  SLMDSedViewComplListShownRequired = 'Completion list should be shown for this command (or method)';
  SLMDSedViewNoComplListShownRequired = 'Completion list should NOT be shown for this command (or method)';

  //Dialogs
  SLMDSedDlgGotoLine = '������� �� ������';

  SLMDSedDlgSearchCancel = '������';
  SLMDSedDlgSearchOk = 'OK';
  SLMDSedDlgReplaceAll = '�������� &��';
  SLMDSedDlgSearchText = '����&�';
  SLMDSedDlgReplaceText = '��&������ ��';
  SLMDSedDlgSearchOptions = '���������';
  SLMDSedDlgSearchDirection = '����������� ������';
  SLMDSedDlgSearchBounds = '������� ��� ������ ������';
  SLMDSedDlgSearchStartFrom = '������ ��';
  SLMDSedDlgSearchRegexps = '������&���� ���������';
  SLMDSedDlgSearchWholeWords = '������ ����� &�������';
  SLMDSedDlgSearchCaseSensitive = '�&�������� �������';
  SLMDSedDlgSearchConfirmReplace = '���������&��� ������';
  SLMDSedDlgSearchBackward = '��&���';
  SLMDSedDlgSearchForward = '����&�';
  SLMDSedDlgSearchAllText = '���� &�����';
  SLMDSedDlgSearchSelection = '�&���������';
  SLMDSedDlgSearchFromCursor = '�� �&������';
  SLMDSedDlgSearchFromTextStart = '�� ������/&����� ������';

  SLMDSedDlgSearchBadRegex = '������ � ���������� ��������� ��� � �������������� �������: %s';
  SLMDSedDlgReplaceConfirm = '�������� ��� ��������� ''%s''?';
  SLMDSedDlgContinueSearchFromStart = '��������� ����� ���������. ���������� � ������?';
  SLMDSedDlgContinueSearchFromEnd = '���������� ������ ���������. ���������� � �����?';

  SLMDSedLoadSyntaxSchemes = '��������� �������������� ����� �� ��������...';
  SLMDSedLoadColorSchemes = '��������� �������� ����� �� ��������...';

  SLMDSedColorSchemeNotFound = 'Can''t find color scheme ''%s''';  
  SLMDSedColorSchemeCustomColor = '����������������...';
  SLMDSedColorSchemeAddToken = '������� ��� ������ ������';
  SLMDSedColorSchemeAddCustomAttr = 'Enter new custom attribute name';
  SLMDSedColorSchemeDuplicateCustomAttr = 'Custom attribute name should be unique';
  SLMDSedColorSchemeDuplicateToken = 'Token name should be unique';
  SLMDSedColorSchemeLoadError = '������ �� �������� �������� ����� ''%s'': %s';
  SLMDSedColorSchemeCaption = '�������� �������� ����';
  SLMDSedColorSchemeTokens = '������';
  SLMDSedColorSchemeTokensPlusHint = '�������� ����� �����';
  SLMDSedColorSchemeTokensMinusHint = '������� ������� �����';
  SLMDSedColorSchemeColors = '�����';
  SLMDSedColorSchemeColor = '&����:';
  SLMDSedColorSchemeBgColor = '���� &����:';
  SLMDSedColorSchemeAttributes = '��������';
  SLMDSedColorSchemeItalic = '&������';
  SLMDSedColorSchemeBold = '&������';
  SLMDSedColorSchemeUnderline = '&������������';
  SLMDSedColorSchemeStrikeout = '&�����������';
  SLMDSedColorSchemeFontAttributesDefined = '&�������� ����������';
  SLMDSedColorSchemeExample = '�������';
  SLMDSedColorSchemeCancel = '������';
  SLMDSedColorSchemeOk = 'OK';
SLMDSedColorSchemeMainAttrs = 'Main attributes';
  SLMDSedColorSchemeCustomAttrs = 'Custom attributes';
  SLMDSedColorSchemeCustomAttrName = 'Name';
  SLMDSedColorSchemeCustomAttrValue = 'Value';
  SLMDSedColorSchemeRemoveCustomAttrHint = 'Remove this custom attribute';
  SLMDSedColorSchemeAddCustomAttrHint = 'Add new custom attribute';
  SLMDSedColorSchemeRemoveTokenHint = 'Remove this token';
  SLMDSedColorSchemeAddTokenHint = 'Add new token';  

  SLMDSedCmdLeft = '����� �� ������';
  SLMDSedCmdRight = '����� �� ������';
  SLMDSedCmdUp = '����� �� �������';
  SLMDSedCmdDown = '���� �� �������';
  SLMDSedCmdLineHome = '� ������ �������';
  SLMDSedCmdLineEnd = '� ����� �������';
  SLMDSedCmdNextWord = '����� �� �����';
  SLMDSedCmdPrevWord = '����� �� �����';
  SLMDSedCmdPageUp = '����� �� ��������';
  SLMDSedCmdPageDown = '���� �� ��������';
  SLMDSedCmdPageHome = '� ������ ��������';
  SLMDSedCmdPageEnd = '� ����� ��������';
  SLMDSedCmdTextHome = '� ������ ������';
  SLMDSedCmdTextEnd = '� ����� ������';

  SLMDSedCmdUndo = '������';
  SLMDSedCmdRedo = '������';
  SLMDSedCmdCut = '�������� ����������';
  SLMDSedCmdCopy = '����������� ����������';
  SLMDSedCmdPaste = '��������';

  SLMDSedCmdDeletePrevChar = '������� ������ �����';
  SLMDSedCmdDeleteChar  = '������� ������ ������';
  SLMDSedCmdDeletePrevWord  = '������� ����� �����';
  SLMDSedCmdDeleteWord  = '������� ����� ������';
  SLMDSedCmdDeleteToLineEnd  = 'Delete to line end';
  SLMDSedCmdDeleteToLineWrap  = 'Delete to line wrap';  
  SLMDSedCmdDeleteLine  = 'Delete line';  
  SLMDSedCmdChar = '�������� ������';
  SLMDSedCmdNewLine  = '�������� ������� ������';
  SLMDSedCmdTab = '�������� ���������';
  SLMDSedCmdTabOrIndent = 'Move to prev line indent or insert tab';  
  SLMDSedCmdIndent = '�������� ���������� ������';
  SLMDSedCmdUnIndent = '�������� ���������� �����';
  SLMDSedCmdIndentToPrev = 'Indent selection to prev indent';
  SLMDSedCmdUnIndentToPrev = 'Unindent selection to prev indent';
  SLMDSedCmdBackspaceOrUnindent = 'Delete char backward or unindent';
  SLMDSedCmdIncSearchStart = 'Start incremental search';
  SLMDSedCmdIncSearchBack = 'Move to previous result';
  SLMDSedCmdIncSearchFwd = 'Move to next result';
  SLMDSedCmdSearchNext = 'Move to next search result';
  SLMDSedCmdScrollUp = '���������� ����� ����� �� �������';
  SLMDSedCmdScrollDown = '���������� ����� ���� �� �������';

  SLMDSedCmdSelectLeft = '�������� �� ������ �����';
  SLMDSedCmdSelectRight = '�������� �� ������ ������';
  SLMDSedCmdSelectPrevWord = '�������� �� ����� �����';
  SLMDSedCmdSelectNextWord = '�������� �� ����� ������';
  SLMDSedCmdSelectUp = '�������� �� ������� �����';
  SLMDSedCmdSelectDown = '�������� �� ������� ����';
  SLMDSedCmdSelectPageUp = '�������� �� �������� �����';
  SLMDSedCmdSelectPageDown = '�������� �� �������� ����';
  SLMDSedCmdSelectPageHome = '�������� �� ������ ��������';
  SLMDSedCmdSelectPageEnd = '�������� �� ����� ��������';
  SLMDSedCmdSelectLineHome = '�������� �� ������ �������';
  SLMDSedCmdSelectLineEnd = '�������� �� ����� �������';
  SLMDSedCmdSelectTextHome = '�������� �� ������ ������';
  SLMDSedCmdSelectTextEnd = '�������� �� ����� ������';

  SLMDSedCmdSelectAll = '�������� ��';
  SLMDSedCmdSelectNone = '�������� ���������';

  SLMDSedCmdToggleOwerwrite = '����������� ����� �������/������';
  SLMDSedCmdCompletionShow = 'Show completion list for current word';

  SLMDSedCmdCatMovement = '�����������';
  SLMDSedCmdCatSelection = '���������';
  SLMDSedCmdCatDeletion = '��������';
  SLMDSedCmdCatClipboard = '����� ������';
  SLMDSedCmdCatOther = '������';
  SLMDSedCmdCatIncSearch = 'Incremental search';
  SLMDSedCmdCatIndent = 'Indentation';
  SLMDSedKeyDlgCaption = '�������� ������������ ���������';
  SLMDSedKeyDlgCancel = '������';
  SLMDSedKeyDlgOk = '��';
  SLMDSedKeyDlgDeleteBinding = '�&������ ���������';
  SLMDSedKeyDlgResetBinding = '&������������ �� ���������';
  SLMDSedKeyDlgResetAllBinding = '������������ ��&�';
  SLMDSedKeyDlgAddBinding = '��&������ ���������';
  SLMDSedKeyDlgClearBinding = '�&�������';  

  SLMDSedKeyDlgReplaceBinding = '��������� ''%s'' ����� ��������� ��������:'+
                                #13+#10+'%s'+#13+#10+'����������?';

  SLMDSedKeyDlgResetAlert = '�������������� ��������� ��� ����� ������ ��������:'+
                            #13+#10+'%s'+#13+#10+'����������?';

  SLMDSedTaskPagesNotPrepared = '�� ������ ������� ��������� PreparePages';
  SLMDSedTaskPagesNotFinalized = '�� ������ ������� ��������� FinalizePages';
  SLMDSedTaskPrinterNotAssigned = '�� ������ ������� ���������� �������� "Printer"';
  SLMDSedTaskViewNotAssigned = '�� ������ ������� ���������� �������� "View"';  
  SLMDSedbadEncodingName = '�������� ��� ���������: ''%s''. ��������� ������������� ��� ���� ��� ��������� (����� � MDSN), ������������� � �������';
  SLMDSedDialogViewNotSet = 'View property should be assigned for this method';
  SLMDSedDialogDocumentNotSet = 'Document property should be assigned for this method';
  SLMDSedDialogFindCaption = 'Find text';
  SLMDSedDialogReplaceCaption = 'Find text';
  SLMDSedDialogFindBadState = 'You must call Execute method first. View SearchState should be stInSearch';
  SLMDSedDialogReplaceBadState = 'You must call Execute method first. View SearchState should be stInReplace';
  SLMDSedDialogColorSchemeNotFound = 'Color scheme %s not found in Document.ColorSchemes collection';
  SLMDSedDialogSyntaxSchemeNotFound = 'Syntax scheme %s not found in Document.SyntaxSchemes collection';  
  SLMDSedDialogSchemeNotSet = 'Scheme property should be set for this method';

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

  SLMDSedCmdCatSelectionBlock = 'Selection (block mode)';

  SLMDSedInvalidLineColIdx = 'Invalid line column: %d. Valid range: [0, %d]';  

  SLMDSedDocDbgStackExpectedByMethod = 'This method expects passed marker belongs to DebuggerStackLines document collection';
  SLMDSedDocReadOnly = 'Document is read-only';
  SLMDSedDocInternalClassCreate = 'This internal Document class should not be created manually.';  

  SLMDSedCmdToggleOverwrite = 'Toggle overwrite mode';
  SLMDSedCmdCompletionShow = 'Show completion list for current word';


{------------------------------------------------------------------------------}

implementation

end.
