unit LMDRTLConst;
{###############################################################################

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
 IDS_INVALIDOWNER='Неправильный владелей (<>TForm) или второй экзмемпдяр формы.';
 IDS_INTERVALNOTFIT='Интервал не совместим со свойством MinInterval!';


 SLMDInvalidInteger = '''''%s'''' неправильное целдое значение.';

 // TLMDFileStream
 SLMDFCreateError = 'Cannot create file %s';
 SLMDFOpenError = 'Cannot open file %s';

 // LMDArray.pas
 SLMDListIndexOutOfBounds = 'List index (%d) out of bounds ';


 // LMDXML
 SLMDXmlError1 = 'Ошибка получения элемента списка: индекс выходит за пределы';
 SLMDXmlError2 = 'Не завершено определение элемента';
 SLMDXmlError3 = 'Некорретный символ в имени элемента';
 SLMDXmlError4 = 'Ошибка чтения двоичного XML: некорректный тип узла';
 SLMDXmlError5 = 'Ошибка записи двоичного XML: некорректный тип узла';
 SLMDXmlError6 = 'Неверное значение атрибута "%s" элемента "%s".'^M^J +
                    'Допустимые значения:'^M^J + '%s';
 SLMDXmlError7 = 'Не найден атрибут "%s"';
 SLMDXmlError8 = 'Не задан атрибут "%s"';
 SLMDXmlError9 = 'Данная возможность не поддерживается SimpleXML';
 SLMDXmlError10 = 'Ошибка: не найден дочерний элемент "%s".';
 SLMDXmlError11 = 'Имя должно начинаться с буквы или "_"';
 SLMDXmlError12 = 'Ожидается число';
 SLMDXmlError13 = 'Ожидается шестнадцатеричное число';
 SLMDXmlError14 = 'Ожидается "#" или имя упрамляющего символа';
 SLMDXmlError15 = 'Некорректное имя управляющего символа';
 SLMDXmlError16 = 'Ожидается "%c"';
 SLMDXmlError17 = 'Ожидается "%s"';
 SLMDXmlError18 = 'Символ "<" не может использоваться в значениях атрибутов';
 SLMDXmlError19 = 'Ожидается "%s"';
 SLMDXmlError20 = 'Ожидается значение атрибута';
 SLMDXmlError21 = 'Ожидается строковая константа';
 SLMDXmlError22 = 'Ожидается "%s"';
 SLMDXmlError23 = 'Ошибка чтения данных.';
 SLMDXmlError24 = 'Ошибка чтения значения: некорректный тип.';
 SLMDXmlError25 = 'Ошибка записи значения: некорректный тип.';
 SLMDXmlError26 = 'Эта кодировка не поддерживается.';

 // LMDPNG
 SLMDPNGInvalidCRCText = 'This "Portable Network Graphics" image is not valid ' +
     'because it contains invalid pieces of data (crc error)';
 SLMDPNGInvalidIHDRText = 'The "Portable Network Graphics" image could not be ' +
     'loaded because one of its main piece of data (ihdr) might be corrupted';
 SLMDPNGMissingMultipleIDATText = 'This "Portable Network Graphics" image is ' +
   'invalid because it has missing image parts.';
 SLMDPNGZLIBErrorText = 'Could not decompress the image because it contains ' +
   'invalid compressed data.'#13#10 + ' Description: ';
 SLMDPNGInvalidPaletteText = 'The "Portable Network Graphics" image contains ' +
   'an invalid palette.';
 SLMDPNGInvalidFileHeaderText = 'The file being readed is not a valid '+
   '"Portable Network Graphics" image because it contains an invalid header.' +
   ' This file may be corruped, try obtaining it again.';
 SLMDPNGIHDRNotFirstText = 'This "Portable Network Graphics" image is not ' +
   'supported or it might be invalid.'#13#10 + '(IHDR chunk is not the first)';
 SLMDPNGNotExistsText = 'The png file could not be loaded because it does not ' +
   'exists.';
 SLMDPNGSizeExceedsText = 'This "Portable Network Graphics" image is not ' +
   'supported because either it''s width or height exceeds the maximum ' +
   'size, which is 65535 pixels length.';
 SLMDPNGUnknownPalEntryText = 'There is no such palette entry.';
 SLMDPNGMissingPaletteText = 'This "Portable Network Graphics" could not be ' +
   'loaded because it uses a color table which is missing.';
 SLMDPNGUnknownCriticalChunkText = 'This "Portable Network Graphics" image ' +
   'contains an unknown critical part which could not be decoded.';
 SLMDPNGUnknownCompressionText = 'This "Portable Network Graphics" image is ' +
   'encoded with an unknown compression scheme which could not be decoded.';
 SLMDPNGUnknownInterlaceText = 'This "Portable Network Graphics" image uses ' +
   'an unknown interlace scheme which could not be decoded.';
 SLMDPNGCannotAssignChunkText = 'The chunks must be compatible to be assigned.';
 SLMDPNGUnexpectedEndText = 'This "Portable Network Graphics" image is invalid ' +
   'because the decoder found an unexpected end of the file.';
 SLMDPNGNoImageDataText = 'This "Portable Network Graphics" image contains no ' +
   'data.';
 SLMDPNGCannotChangeSizeText = 'The "Portable Network Graphics" image can not ' +
   'be resize by changing width and height properties. Try assigning the ' +
   'image from a bitmap.';
 SLMDPNGCannotAddChunkText = 'The program tried to add a existent critical ' +
   'chunk to the current image which is not allowed.';
 SLMDPNGCannotAddInvalidImageText = 'It''s not allowed to add a new chunk ' +
   'because the current image is invalid.';
 SLMDPNGCouldNotLoadResourceText = 'The png image could not be loaded from the ' +
   'resource ID.';
 SLMDPNGOutMemoryText = 'Some operation could not be performed because the ' +
   'system is out of resources. Close some windows and try again.';
 SLMDPNGCannotChangeTransparentText = 'Setting bit transparency color is not ' +
   'allowed for png images containing alpha value for each pixel ' +
   '(COLOR_RGBALPHA and COLOR_GRAYSCALEALPHA)';
 SLMDPNGHeaderNotPresentText = 'This operation is not valid because the ' +
   'current image contains no valid header.';


 SLMDComplexBracesNotImplementedForLookahead = 'TLMDRegExpr(comp): this construct ( "+?", "*?", "{min, max}" ) is not supported for lookahead group. Use (?= (subgroup){min,max} ) instead of (?= group ){min,max}.';

 SLMDOk ='No errors';
 SLMDCompNullArgument = 'TLMDRegExpr(comp): Null Argument';
 SLMDCompRegexpTooBig = 'TLMDRegExpr(comp): Regexp Too Big';
 SLMDCompParseRegTooManyBrackets = 'TLMDRegExpr(comp): ParseReg Too Many ()';
 SLMDCompParseRegUnmatchedBrackets = 'TLMDRegExpr(comp): ParseReg Unmatched ()';
 SLMDCompParseRegUnmatchedBrackets2 = 'TLMDRegExpr(comp): ParseReg Unmatched ()';
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
 SLMDNoInpitStringSpecified = 'TLMDRegExpr(exec): No Input String Specified';
 SLMDOffsetMustBeGreaterThan0 = 'TLMDRegExpr(exec): Offset Must Be Greater Then 0';
 SLMDExecNextWithoutExec = 'TLMDRegExpr(exec): ExecNext Without Exec[Pos]';
 SLMDGetInputStringWithoutInputString = 'TLMDRegExpr(exec): GetInputString Without InputString';
 SLMDDumpCorruptedOpcode = 'TLMDRegExpr(dump): Corrupted Opcode';
 SLMDLoopStackExceeded = 'TLMDRegExpr(exec): Loop Stack Exceeded';
 SLMDLoopWithoutEntry = 'TLMDRegExpr(exec): Loop Without LoopEntry !';
 SLMDInputSourceIsNotString = 'TLMDRegExpr: Input source is not string. Can''t get InputText.';
 SLMDInputSourceNotSet = 'TLMDRegExpr: InputText or InputSource hes not been set.';
 SLMDBadPCodeImported = 'TLMDRegExpr(misc): Bad p-code imported';
 SLMDNegativeSetNotSupportedInRanges = 'TLMDRegExpr(comp): \S, \D, \W are not supported in ranges operator ([...]) yet. Sorry.';
 SLMDUnicodeCategoriesNotSupportedInAnsi = 'TLMDRegExpr(comp): Unicode categories and properties (\p{Lu} etc) are not supported in ansi. Use LMD_UNICODE compilation flag';
 SLMDMalformedUnicodeCategory = 'TLMDRegExpr(comp): Bad format for Unicode category';
 SLMDUnicodeCharHexCodesNotSupportedInAnsi = 'TLMDRegExpr(comp): Unicode char codes (\uA0FF) are not supported in ansi. Use LMD_UNICODE compilation flag';
 SLMDSubstituteMalformedVariable = 'TLMDRegExpr.Substitute: Bad format for substitution subexpression name. Should be: $1, ${1}, $&, ${&}.';

 SLMDUnknownError = 'TLMDRegExpr: Unknown error';

 SLMDCodesResolverNotAssigned = 'TLMDRegExpr: CodesResolver must be set in Codes-mode. (when ModifierC=true)';
 SLMDMalformedIntCode = 'TLMDRegExpr: Malformed int-code. Expected \s{ code_name }';
 SLMDCannotResolveIntCode = 'TLMDRegExpr: Can''t resolve this int code name to int code';
 SLMDThisConstructRequiresIntCodesMode = 'TLMDRegExpr: This construct requires int-codes mode (ModifierC=true)';
 SLMDThisConstructNotWorkingInIntCodesMode = 'TLMDRegExpr: This construct does not work for int-codes mode (ModifierC=true)';
 SLMDCodesModeIsIncompatibeWithOthers = 'TLMDRegExpr: Int-codes mode is incompatible with current mode set. ModifierC compatible only with ModifierX.';
 SLMDThisOperationNotWorkingInIntCodesMode = 'TLMDRegExpr: This method does not work in int-codes mode (ModifierC=true)';
 SLMDModifierUnsupported = 'This modifier is unsupported';
 SLMDIndexOutOfBounds = 'Index out of bounds: %d';
 SLMDInvalidCount = 'Invalid Count value';
 // LMDMapFile
 SUnableToFind = 'Unable to Find';

 // Wide strings editor
 SLMDWideStringsEditorLineCount         = '%d линий';
 SLMDWideStringsEditorCaption           = 'Редактор списка Юникодных строк.';
 SLMDWideStringsEditorOkBtnCaption      = '&Ок';
 SLMDWideStringsEditorCancelBtnCaption  = 'Отмена';

 //TLMDEncoding
 SLMDRtlEncodingBadName = 'Can''t create TLMDEncoding by name ''%s'': unknown name';
 SLMDRtlEncodingConversionError = 'Windows conversion function returned error: %s';
 SLMDRtlEncodingInsufficientBuffer = 'Buffer given to conversion function is too small';
 SLMDRtlEncodingBadIndex = 'Bad index in array given: %d';
 SLMDRtlEncodingBadRange = 'Bad range in array given: [%d, %d]';

 // Service provider
 SLMDServiceNotRegistered = 'Сервис %s не зарегистрирован.';
 SLMDDuplicateService     = 'Сервис %s уже зарегистрирован.';

 SLMDRtlHashTableShouldNotOwnData = 'Параметр операции должен быть TLMDStringHashTable.OwnItems=false.';
 SLMDRtlHashTableArgShouldNotOwnData = 'Параметр операции должен быть TLMDStringHashTable.OwnItems=false.';

 SLMDPlatformIsNotImplemented = 'Платформа не поддерживается.';


 // ZLib
 SZLibProcessingError = 'Error %d while ZLib processing';
 SZLibInvalidStreamOp = 'Invalid stream operation';
 SZLibTargetBufferTooSmall = 'Target buffer may be too small';


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


implementation

end.