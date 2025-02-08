unit LMDRTLConst;

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

LMDRTLConst unit (AH)
---------------------
This unit contains Resource Strings for the LMD-Tools RTL packages.

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

resourcestring

  // Component Messages
  IDS_INVALIDOWNER='Invalid owner (<>TForm) or second instance on a form';
  IDS_INTERVALNOTFIT='Interval not compatible with MinInterval property!';

  // LMDXML
  SLMDXmlError1 = 'Getting element error: Index is out of range';
  SLMDXmlError2 = 'Setting of element isn''t finished';
  SLMDXmlError3 = 'Invalid symbol in the element name';
  SLMDXmlError4 = 'BinaryXML read error: incorrect node type';
  SLMDXmlError5 = 'BinaryXML write error: incorrect node type';
  SLMDXmlError6 = 'Invalid attribute vaalue "%s" of element "%s".'#13#10 +
                     'Valid values:'#13#10 + '%s';
  SLMDXmlError7 = 'Attribute "%s" not found';
  SLMDXmlError8 = 'Attribute "%s" not set';
  SLMDXmlError9 = 'This feature isn''t implemented yet in LMDXML';
  SLMDXmlError10 = 'Error: child element "%s" not found.';
  SLMDXmlError11 = 'Name should began with the letter or symbol "_"';
  SLMDXmlError12 = 'Waiting number';
  SLMDXmlError13 = 'Waiting hexadecimal number';
  SLMDXmlError14 = 'Waiting "#" or managing symbol name';
  SLMDXmlError15 = 'Incorrect name of a managing symbol';
  SLMDXmlError16 = 'Waiting "%c"';
  SLMDXmlError17 = 'Waiting "%s"';
  SLMDXmlError18 = 'Symbol "<" cannot used in attribute values';
  SLMDXmlError19 = 'Waiting "%s"';
  SLMDXmlError20 = 'Waiting attribute value';
  SLMDXmlError21 = 'Waiting string constant';
  SLMDXmlError22 = 'Waiting "%s"';
  SLMDXmlError23 = 'Read data error';
  SLMDXmlError24 = 'Read value error: Invalid type';
  SLMDXmlError25 = 'Write value error: Invalid type';
  SLMDXmlError26 = 'This encoding isn''t supported';

  //
  SLMDInvalidInteger = '''''%s'''' is not a valid integer value';

  // TLMDFileStream
  SLMDFCreateError = 'Cannot create file %s';
  SLMDFOpenError = 'Cannot open file %s';

  // LMDArray.pas
  SLMDListIndexOutOfBounds = 'List index (%d) out of bounds ';

  // LMDSYSIN
  // ****************************************************************************
  IDS_ON='On';
  IDS_OFF='Off';
  IDS_FILE='Files';
  IDS_NOROOTDIR='no root directory';
  IDS_REMOVABLE='removable';
  IDS_FIXEDDRIVE='fixed drive';
  IDS_REMOTE='remote (network) drive';
  IDS_CDROM='CD-ROM';
  IDS_RAMDISK='ramdisk';
  IDS_USERNAME='Username';
  IDS_WINDOWSDIR='Windows directory';
  IDS_CURRDIR='Current directory';
  IDS_FREESPACE='Free space on current disk';
  IDS_DISKSIZE='Disk size of current Disk';
  IDS_SYSTEMDIR='System directory';
  IDS_REGISTEREDOWNER='Registered owner';
  IDS_REGISTEREDCOMPANY='Registered company';
  IDS_VERSION='Version';
  IDS_COLORDEPTH='Colordepth (in bits)';
  IDS_SCREENSAVERDELAY='Screensaver delay';
  IDS_MEMORYSIZE='Memory size';
  IDS_FREESYSTEMRESOURCES='Free system resources';
  IDS_FREEGDIRES='Free GDI resources';
  IDS_FREEUSERRES='Free user resources';
  IDS_COMPUTERNAME='Computername';
  IDS_MAJORVERSION='Major version';
  IDS_BUILD='Build';
  IDS_MEMORYLOADED='Memory loaded';
  IDS_MEMORYFREE='Memory free';
  IDS_MEMORYFREEPAGES='Free memory pages';
  IDS_MEMORYTOTALPAGES='Total memory pages';
  IDS_MEMORYVIRTUALFREE='Free virtual memory';
  IDS_MEMORYVIRTUALTOTAL='Total virtual memory';
  IDS_PLATFORMID='Platform ID';
  IDS_PLATFORM='Platform';
  IDS_PROCESSORNUMBER='Number of processors';
  IDS_PROCESSOR='Processor';
  IDS_TEMPPATH='Temp path';
  IDS_DOSVERSION='DOS version';
  IDS_NUMLOCK='NumLock';
  IDS_CAPSLOCK='CapsLock';
  IDS_SCROLL='ScrollLock';
  IDS_DATETIME='Date and time';
  IDS_COMPANYNAME='CompanyName';
  IDS_PRODUCTNAME='ProductName';
  IDS_PRODUCTVERSION='Version';
  IDS_LEGALCOPYRIGHT='Copyright';
  IDS_TRADEMARK='LegalTrademark';
  IDS_FILEDESCRIPTION='FileDescription';
  IDS_COMMENTS='Comments';
  IDS_CPUSPEED='CPU Speed';

  SLMDOk ='No errors';
  SLMDCompNullArgument = 'TLMDRegExpr(comp): Null Argument';
  SLMDCompRegexpTooBig = 'TLMDRegExpr(comp): Regexp Too Big';
  SLMDCompParseRegTooManyBrackets = 'TLMDRegExpr(comp): ParseReg Too Many ()';
  SLMDCompParseRegUnmatchedBrackets = 'TLMDRegExpr(comp): ParseReg Unmatched ()';
  SLMDCompParseRegUnmatchedBrackets2 = 'TLMDRegExpr(comp): ParseReg Unmatched () (case 2)';
  SLMDCompParseRegJunkOnEnd = 'TLMDRegExpr(comp): ParseReg Junk On End';
  SLMDPlusStarOperandCouldBeEmpty = 'TLMDRegExpr(comp): *+ Operand Could Be Empty';
  SLMDNestedSQP = 'TLMDRegExpr(comp): Nested *?+';
  SLMDBadHexDigit = 'TLMDRegExpr(comp): Bad Hex Digit';
  SLMDInvalidRange = 'TLMDRegExpr(comp): Invalid [] Range';
  SLMDParseAtomTrailingBackSlash = 'TLMDRegExpr(comp): Parse Atom Trailing \';
  SLMDNoHexCodeAfterBSlashX = 'TLMDRegExpr(comp): No Hex Code After \x or \u or \U';
  SLMDHexCodeAfterBSlashXTooBig = 'TLMDRegExpr(comp): Hex Code After \x or \u or \U Is Too Big';
  SLMDUnmatchedSqBrackets = 'TLMDRegExpr(comp): Unmatched []';
  SLMDInternalUrp = 'TLMDRegExpr(comp): Internal Urp';
  SLMDQPSBFollowsNothing = 'TLMDRegExpr(comp): ?+*{ Follows Nothing';
  SLMDTrailingBackSlash = 'TLMDRegExpr(comp): Trailing \';
  SLMDRarseAtomInternalDisaster = 'TLMDRegExpr(comp): RarseAtom Internal Disaster';
  SLMDBRACESArgTooBig = 'TLMDRegExpr(comp): BRACES Argument Too Big';
  SLMDBracesMinParamGreaterMax = 'TLMDRegExpr(comp): BRACE Min Param Greater then Max';
  SLMDBracesNotBalanced = 'TLMDRegExpr(comp): BRACEs are not balansed';
  SLMDUnclosedComment = 'TLMDRegExpr(comp): Unclosed (?#Comment)';

  SLMDUrecognizedModifier = 'TLMDRegExpr(comp): Urecognized Modifier';
  SLMDBadLinePairedSeparator = 'TLMDRegExpr(comp): LinePairedSeparator must countain two different chars or no chars at all';

  SLMDRegRepeatCalledInappropriately = 'TLMDRegExpr(exec): RegRepeat Called Inappropriately';
  SLMDMatchPrimMemoryCorruption = 'TLMDRegExpr(exec): MatchPrim Memory Corruption';
  SLMDMatchPrimCorruptedPointers = 'TLMDRegExpr(exec): MatchPrim Corrupted Pointers';
  SLMDNoExpression = 'TLMDRegExpr(exec): Not Assigned Expression Property';
  SLMDCorruptedProgram = 'TLMDRegExpr(exec): Corrupted Program';
  SLMDOffsetMustBeGreaterThan0 = 'TLMDRegExpr(exec): Offset Must Be Greater Then 0';
  SLMDExecNextWithoutExec = 'TLMDRegExpr(exec): ExecNext Without Exec[Pos]';
  SLMDGetInputStringWithoutInputString = 'TLMDRegExpr(exec): GetInputString Without InputString';
  SLMDDumpCorruptedOpcode = 'TLMDRegExpr(dump): Corrupted Opcode';
  SLMDLoopStackExceeded = 'TLMDRegExpr(exec): Loop Stack Exceeded';
  SLMDLoopWithoutEntry = 'TLMDRegExpr(exec): Loop Without LoopEntry !';

  SLMDBadPCodeImported = 'TLMDRegExpr(misc): Bad p-code imported';
  SLMDNegativeSetNotSupportedInRanges = 'TLMDRegExpr(comp): \S, \D, \W are not supported in ranges operator ([...]) yet. Sorry.';
  SLMDUnicodeCategoriesNotSupportedInAnsi = 'TLMDRegExpr(comp): Unicode categories and properties (\p{Lu} etc) are not supported in ansi. Use LMD_UNICODE compilation flag';
  SLMDMalformedUnicodeCategory = 'TLMDRegExpr(comp): Bad format for Unicode category';
  SLMDUnicodeCharHexCodesNotSupportedInAnsi = 'TLMDRegExpr(comp): Unicode char codes (\uA0FF) are not supported in ansi. Use LMD_UNICODE compilation flag';
  SLMDSubstituteMalformedVariable = 'TLMDRegExpr.Substitute: Bad format for substitution subexpression name. Should be: $1, ${1}, $&, ${&}.';

  SLMDComplexBracesNotImplementedForLookahead = 'TLMDRegExpr(comp): this construct ( "+?", "*?", "{min, max}" ) is not supported for lookahead group. Use (?= (subgroup){min,max} ) instead of (?= group ){min,max}.';

  SLMDUnknownError = 'TLMDRegExpr: Unknown error';

  SLMDCodesResolverNotAssigned = 'TLMDRegExpr: CodesResolver must be set in Codes-mode. (when ModifierC=true)';
  SLMDMalformedIntCode = 'TLMDRegExpr: Malformed int-code. Expected { code_name with spaces } or code_name (without spaces)';
  SLMDCannotResolveIntCode = 'TLMDRegExpr: Can''t resolve this int code name to int code';
  SLMDThisConstructRequiresIntCodesMode = 'TLMDRegExpr: This construct requires int-codes mode (ModifierC=true)';
  SLMDThisConstructNotWorkingInIntCodesMode = 'TLMDRegExpr: This construct does not work for int-codes mode (ModifierC=true)';
  SLMDCodesModeIsIncompatibeWithOthers = 'TLMDRegExpr: Int-codes mode is incompatible with current mode set. ModifierC compatible only with ModifierX, ModifierA, ModifierG.';
  SLMDThisOperationNotWorkingInIntCodesMode = 'TLMDRegExpr: This method does not work in int-codes mode (ModifierC=true)';
  SLMDInputSourceIsNotString = 'TLMDRegExpr: Input source is not string. Can''t get InputText.';
  SLMDInputSourceNotSet = 'TLMDRegExpr: InputText or InputSource hes not been set.';

  SLMDModifierUnsupported = 'This modifier is unsupported';
  SLMDIndexOutOfBounds = 'Index out of bounds: %d';
  SLMDInvalidCount = 'Invalid Count value';
  // LMDMapFile
  SUnableToFind = 'Unable to Find';

  // ZLib
  SZLibProcessingError = 'Error %d while ZLib processing';
  SZLibInvalidStreamOp = 'Invalid stream operation';
  SZLibTargetBufferTooSmall = 'Target buffer may be too small';

  // Wide strings editor
  SLMDWideStringsEditorLineCount         = '%d lines';
  SLMDWideStringsEditorCaption           = 'Wide String List Editor';
  SLMDWideStringsEditorOkBtnCaption      = '&Ok';
  SLMDWideStringsEditorCancelBtnCaption  = 'Cancel';

  // Service provider
  SLMDServiceNotRegistered = 'Service %s is not registered.';
  SLMDDuplicateService     = 'Service %s already registered.';

  //TLMDEncoding
  SLMDRtlEncodingBadName = 'Can''t create TLMDEncoding by name ''%s'': unknown name';
  SLMDRtlEncodingConversionError = 'Windows conversion function returned error: %s';
  SLMDRtlEncodingInsufficientBuffer = 'Buffer given to conversion function is too small';
  SLMDRtlEncodingBadIndex = 'Bad index in array given: %d';
  SLMDRtlEncodingBadRange = 'Bad range in array given: [%d, %d]';

  SLMDRtlHashTableShouldNotOwnData = 'This operation requires TLMDStringHashTable.OwnItems=false.';
  SLMDRtlHashTableArgShouldNotOwnData = 'This operation requires that its argument should have TLMDStringHashTable.OwnItems=false.';

  SLMDPlatformIsNotImplemented = 'Platform is not implemented';

implementation

end.
