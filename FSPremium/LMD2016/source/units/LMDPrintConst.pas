unit LMDPrintConst;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDPrintConst unit (RM)
-----------------------
This unit contains Resource Strings for LMD PrintPack

Changes
-------
Release 8.0 (February 2007)
 - Initial Release

###############################################################################}

interface

resourcestring
  // TLMDPrinter
  IDS_CANTCHANGEMARGINS='Can''t change margins while printing.';

  // MLGen
  SCanNotFindValueNameS = 'Can not find ValueName "%s"';
  SDuplicateTranslationTableName = 'Duplicate translation table name.';
  SCanNotSetDefaultTranslationTableIndexOutOfRange = 'Can not set default Translation Table. Index out of range.';
  SNameOfCommentTagMustBeSpecified = 'Name of ''comment'' tag must be specified.';
  SErrorInCommentTagDeclaration = 'Error in ''/comment'' tag declaration.';
  SConditionWasNotDeclaredOrClosingTagForInnerConditionIsSkipped = 'Condition was not declared, or closing tag for inner condition is skipped.';
  SErrorInElseTagDeclaration = 'Error in ''else'' tag declaration.';
  SNameOfElseTagMustBeSpecified = 'Name of ''else'' tag must be specified.';
  SErrorInIfTagDeclaration = 'Error in ''if'' tag declaration.';
  SNameOfIfTagMustBeSpecified = 'Name of ''if'' tag must be specified.';
  SErrorInMacroDeclaration = 'Error in macro declaration.';
  SNameOfMacroMustBeSpecified = 'Name of macro must be specified.';
  SNameOfParamTagMustBeSpecified = 'Name of ''param'' tag must be specified.';
  SErrorInParamTagDeclaration1 = 'Error in ''/param'' tag declaration.';
  SErrorInParamsTagDeclaration1 = 'Error in ''/params'' tag declaration.';
  SErrorInRepeatTagDeclaration = 'Error in ''repeat'' tag declaration.';
  SNameOfRepeatTagMustBeSpecified = 'Name of ''repeat'' tag must be specified.';
  SDuplicateLoopNameS = 'Duplicate loop name ''%s''.';
  STryingToCloseNotOpenedLoopInternalError = 'Trying to close not opened loop. Internal error.';
  SStringInReplaceTagMustBeSpecified = 'String in ''replace'' tag must be specified.';
  SEmbeddedTranslationTablesAreNotAllowed = 'Embedded translation tables are not allowed.';
  SNameOfTranslationTagMustBeSpecified = 'Name of ''translation'' tag must be specified.';
  SErrorInTranslationTagDeclaration1 = 'Error in ''/translation'' tag declaration.';
  SNameOfTranslationTagMustBeSpecified1 = 'Name of ''/translation'' tag must be specified.';
  STryingToCloseNotPreviouslyOpenedTranslationTableSS = 'Trying to close not previously opened translation table "%s". Wait for closing: "%s".';
  SErrorInTemplateDLoopsWereNotClosed = 'Error in template: %d loops were not closed.';
  SErrorInTemplateDConditionsWereNotClosed = 'Error in template: %d conditions were not closed.';
  SErrorInTemplateNotAllTagsHaveBeenClosed = 'Error in template. Not all tags have been closed.';
  SCanNotAnalyzeTag = 'Can not analyze tag';
  SAttemptToCloseTheLoopThatHasNotBeenOpenedBefore = 'Attempt to close the loop that has not been opened before.';
  SRepeatedRequestForNewPageIsNotAllowed = 'Repeated request for new page is not allowed.';
  SErrorInTemplateParamsDeclaration = 'Error in template params declaration.';
  SInvalidCharDSInTagPrefixString = 'Invalid char %d (%s) in tag prefix string';
  SCanTChangeTemplateDuringExecution = 'Can''t change template during execution.';
  SErrorInIfTagDeclaration1 = 'Error in ''/if'' tag declaration.';
  SNameOfIfTagMustBeSpecified1 = 'Name of ''/if'' tag must be specified.';
  SErrorInRepeatTagDeclaration1 = 'Error in ''/repeat'' tag declaration.';
  SRepeatTagDoesnTHaveMatchingRepeatTag1 = '''/repeat'' tag doesn''t have matching ''repeat'' tag';
  SErrorInReplaceTagDeclaration1 = 'Error in ''/replace'' tag declaration.';
  SErrorWhileDetectingPositionInLineIndexOutOfRange = 'Error while detecting position in line. Index (%d) out of range (%d).';
  SCanNotAssignObjectToTranslationTableList = 'Can not assign object to translation table list';
  SIndexOutOfRange = 'Index out of range.';
  SLoopNameIsNotFound = 'Loop name is not found.';
  SErrorInCodeTagDeclaration = 'Error in ''/code'' tag declaration';
  SSessionLineChar = '%s Session: %s, Line: %d, Char: %d.';
  SError = 'Error.';
  SCanNotAssignToTranslationTable = 'Can not assign to Translation Table.';
  SUnableToFindPointToReturn = 'Unable to find point to return.';
  SUnableToFindPointToReturnPossibleReasonIsDuplicatedLoopName = 'Unable to find point to return. Possible reason is duplicated loop name.';
  SNameOfBlockTagMustBeSpecified = 'Name of ''block'' tag must be specified.';
  SBeginningOfConditionIsNotFound = 'Beginning of condition is not found';

  SLMDPrintBadPrinterArg = 'Bad printer argument given';
  SLMDPrintPrinterNotAssigned = 'PrintHelper property of TLMDPrintPreviewPanel should be assigned for this method';

  SLMDPrinterNotAssigned = 'Printer property must be assigned before a call to this method';
  SLMDPrintTaskNotAssigned = 'PrintTask property of TLMDPrintPreviewDialog must be assigned before a call to ShowModal method';

  SLMDPrintTaskPagesNotPrepared = 'You must PreparePages before this method';
  SLMDPrintTaskPagesNotFinalized = 'You must call FinalizePages before this method';

  SLMDPrintInvalidSystemPrinter = 'Invalid (or not set) default system printer';
  SLMDPrintListenerNotFound = 'Given listener not found';
  SLMDPrintDuplicateListener = 'Given listener already exists in listeners collection';
  SLMDPrintActiveRequired = 'Active printer state required for this operation';
  SLMDPrintInActiveRequired = 'Inactive printer state required for this operation';
  SLMDPrintBadUnitsSyntem = 'Bad units value: only unAuto, unMillimeters, unInches alowed';
  SLMDPrintBadMarginsValue = 'Bad margins rectangle given';
  SLMDPrintTryManualMarginsCreate = 'Not allowed to create margins manually';

  SLMDPrintTbPrint = 'Print';
  SLMDPrintTbPrintSetup = 'Print setup';
  SLMDPrintTbPageSettings = 'Page settings';
  SLMDPrintTbSave = 'Save page';
  SLMDPrintTbZoom100 = 'Scale to 100%';
  SLMDPrintTbTextWidth = 'Text width';
  SLMDPrintTbWholePage = 'Whole Page';
  SLMDPrintTbTwoPages = 'Two pages';
  SLMDPrintTbMultiplePages = 'Multiple pages';
  SLMDPrintTbZoomIn = 'Zoom in';
  SLMDPrintTbZoomOut = 'Zoom out';
  SLMDPrintTbPageFirst = 'To first page';
  SLMDPrintTbPagePrev = 'To prev page';
  SLMDPrintTbPageNext = 'To next page';
  SLMDPrintTbPageLast = 'To last page';
  SLMDPrintTbPageSpin = 'Page number';
  SLMDPrintTbScaleCombo = 'Scale';
  SLMDPrintTbClose = 'Close';

  SLMDPrintSbPage = 'Page %d of %d';
  SLMDPrintSbScale = 'Scale: %d';
  SLMDPrintSbPageSizeMm = '%d mm x %d mm';
  SLMDPrintSbPageSizeInch = '%f x %f';

  SLMDPrintSbPortrait = 'Portrait';
  SLMDPrintSbLandscape = 'Landscape';

  SLMDPrintPmPages = 'Pages: %d x %d';
  SLMDPrintPmCancel = 'Cancel';

  SLMDPrintPvBadScaleArg = 'Scale should be greater than zero';
  SLMDPrintPvBadCurrentPageArg = 'Current page should be in bounds: [0..%d].'+
                                 ' Printer does''nt have such page: %d';

  SLMDPrintPvBadMarginArg = 'Margin should be more than zero';

  SLMDPrintSaveDlgFilter = 'Enhanced Windows Metafiles (*.emf)|*.emf|All files (*.*)|*.*';
  SLMDPrintMethodNotImplemeted = 'This method has not implemented';

  SLMDPrintEditPrinterPageSettings = 'Page settings...';

  SLMDPrintPrinterPagesNotPrepared = 'You should call PreparePages before this method';
  SLMDPrintPrinterPagesNotFinalized = 'You should call FinalizePages before this method';
  SLMDPrintPrinterBadPagesRange = 'Bad pages range: [%d, %d]. Valid range: [0, %d]';
  SLMDPrintPrinterDocNotStarted = 'You should call BeginDoc before this method';
  SLMDPrintPrinterDocNotFinished = 'You should call EndDoc before this method';
  SLMDPrintToolbarSaveFilter = 'Wmf files (*.wmf)|*.wmf';
  SLMDPrintToolbarSaveOverwrite = 'File %s already exists. Overwrite?';

  SLMDPrintPageSetupTitle = 'Page settings';

  SLMDPrintPageSetupHeaderBtn = 'Header...';
  SLMDPrintPageSetupFooterBtn = 'Footer...';
  SLMDPrintPageSetupPaperGroup = 'Paper';
  SLMDPrintPageSetupSizeLabel = '&Size';
  SLMDPrintPageSetupPaperFeedLabel = '&Feed';
  SLMDPrintPageSetupOrientGroup = 'Orientation';
  SLMDPrintPageSetupPortraitRadio = 'P&ortrait';
  SLMDPrintPageSetupLandscapeRadio = '&Landscape';
  SLMDPrintPageSetupMarginsGroup = 'Margins';
  SLMDPrintPageSetupLeftMarginLabel = 'L&eft:';
  SLMDPrintPageSetupRightMarginLabel = '&Right:';
  SLMDPrintPageSetupTopMarginLabel = '&Top:';
  SLMDPrintPageSetupBottomMarginLabel = '&Bottom:';
  SLMDPrintPageSetupOkButton = 'OK';
  SLMDPrintPageSetupCancelButton = 'Cancel';
  SLMDPrintPageSetupPrinterButton = '&Printer';
  SLMDPrintPageSetupHelpButton = 'Help';
  SLMDPrintPageSetupHeaderButton = '&Header';
  SLMDPrintPageSetupFooterButton = 'Foo&ter';
  SLMDPrintPageSetupPrinterNotAssigned = 'Printer property should be assigned for this operation';
  SLMDPrintNilArgument = 'Argument can not be nil';
  SLMDPrintBadArgument = 'Bad argument given';  

  SLMDPrintHeaderEdit = 'Edit page header';
  SLMDPrintFooterEdit = 'Edit page footer';
  SLMDPrintTemplateEdit = 'Edit page template block';  

  SLMDPrintTemplateEditOk = 'Ok';
  SLMDPrintTemplateEditCancel = 'Cancel';
  SLMDPrintTemplateEditUndo = '&Undo';
  SLMDPrintTemplateEditFileOpen = '&Open';
  SLMDPrintTemplateEditFileSaveAs = 'Save &As';
  SLMDPrintTemplateEditBold = '&Bold';
  SLMDPrintTemplateEditItalic = '&Italic';
  SLMDPrintTemplateEditUndeline = 'Un&derline';
  SLMDPrintTemplateEditAlignLeft = 'Align &Left';
  SLMDPrintTemplateEditAlignCenter = '&Center';
  SLMDPrintTemplateEditAlignRight = 'Align &Right';
  SLMDPrintTemplateEditFont = 'Select &Font...';
  SLMDPrintTemplateEditTemplPage = 'Current page';
  SLMDPrintTemplateEditTemplPagesCount = 'Total pages';
  SLMDPrintTemplateEditTemplDocName = 'Document title';

  SLMDPrintRendererWrongType = 'Doc element renderer does not support the element type';
  SLMDPrintBadLayout = 'Bad page layout: incorrect number of page areas';     

implementation

end.
