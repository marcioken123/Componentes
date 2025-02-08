unit LMDRTLConst;
{###############################################################################

LMDRTLConst unit (AH)
---------------------
This unit contains Resource Strings for the LMD-Tools RTL packages.
Translation by David Le Franc

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

const
  LMDDesignRtlResourceName = 'pLMDEditors';
  LMDDesignSplashResourceName = 'LMDSplash';

resourcestring

  // Component Messages
  IDS_INVALIDOWNER='Propriétaire non valide (<>TForm) ou seconde instance sur la fiche';
  IDS_INTERVALNOTFIT='Intervalle incompatible avec la propriété MinInterval!';

  // LMDXML
  SLMDXmlError1 = 'Erreur élément: Index hors limites';
  SLMDXmlError2 = 'Setting of element isn''t finished';
  SLMDXmlError3 = 'Symbole non valide dans l''élément nom';
  SLMDXmlError4 = 'BinaryXML erreur lecture: type de noeud incorrect';
  SLMDXmlError5 = 'BinaryXML erreur écriture: type de noeud incorrect';
  SLMDXmlError6 = 'Valeur d''attribut non valide "%s" de l''élément "%s".'#13#10 +
                     'Valeurs valides:'#13#10 + '%s';
  SLMDXmlError7 = 'Attribut "%s" introuvable';
  SLMDXmlError8 = 'Attribut "%s" non défini';
  SLMDXmlError9 = 'Cette fonctionnalité n''est pas encore implémentée dans LMDXML';
  SLMDXmlError10 = 'Erreur: élément enfant "%s" introuvable.';
  SLMDXmlError11 = 'Le nom doit commencer avec une lettre ou le caractère "_"';
  SLMDXmlError12 = 'Attente nombre';
  SLMDXmlError13 = 'Attente nombre hexadécimal';
  SLMDXmlError14 = 'Attente "#" ou managing symbol name';
  SLMDXmlError15 = 'Nom incorrect du managing symbol';
  SLMDXmlError16 = 'Attente "%c"';
  SLMDXmlError17 = 'Attente "%s"';
  SLMDXmlError18 = 'Le caractère "<" ne peut pas être utiliser dans un valeur d''attribut';
  SLMDXmlError19 = 'Attente "%s"';
  SLMDXmlError20 = 'Attente valeur attribut';
  SLMDXmlError21 = 'Attente constante chaine';
  SLMDXmlError22 = 'Attente "%s"';
  SLMDXmlError23 = 'Erreur lecture';
  SLMDXmlError24 = 'Erreur lecture: type non valide';
  SLMDXmlError25 = 'Erreur écriture: type non valide';
  SLMDXmlError26 = 'Cet encodage n''est pas supporté';

  //
  SLMDInvalidInteger = '''''%s'''' n''est pas une valeur entière valide';

  // TLMDFileStream
  SLMDFCreateError = 'Impossible de créer le fichier %s';
  SLMDFOpenError = 'Impossibe d''ouvrir le fichier %s';

  // LMDArray.pas
  SLMDListIndexOutOfBounds = 'Index de liste (%d) hors limites ';

  // LMDSYSIN
  // ****************************************************************************
  IDS_ON='On';
  IDS_OFF='Off';
  IDS_FILE='Fichiers';
  IDS_NOROOTDIR='Pas de dossier racine';
  IDS_REMOVABLE='amovible';
  IDS_FIXEDDRIVE='disque dur';
  IDS_REMOTE='remote (network) drive';
  IDS_CDROM='CD-ROM';
  IDS_RAMDISK='ramdisk';
  IDS_USERNAME='Utilisateur';
  IDS_WINDOWSDIR='Dossier Windows';
  IDS_CURRDIR='Dossier courant';
  IDS_FREESPACE='Espace libre sur le disque';
  IDS_DISKSIZE='Taille du disque';
  IDS_SYSTEMDIR='Dossier Système';
  IDS_REGISTEREDOWNER='Registered owner';
  IDS_REGISTEREDCOMPANY='Registered company';
  IDS_VERSION='Version';
  IDS_COLORDEPTH='Profondeur couleur (en bits)';
  IDS_SCREENSAVERDELAY='Délai écran de veille';
  IDS_MEMORYSIZE='Taille mémoire';
  IDS_FREESYSTEMRESOURCES='Ressources système libres';
  IDS_FREEGDIRES='Ressources GDI libres';
  IDS_FREEUSERRES='Ressources utilisateur libres';
  IDS_COMPUTERNAME='Nom de l''ordinateur';
  IDS_MAJORVERSION='Version majeure';
  IDS_BUILD='Build';
  IDS_MEMORYLOADED='Mémoire chargée';
  IDS_MEMORYFREE='Mémoire libre';
  IDS_MEMORYFREEPAGES='Free memory pages';
  IDS_MEMORYTOTALPAGES='Total memory pages';
  IDS_MEMORYVIRTUALFREE='Mémoire virtuelle libre';
  IDS_MEMORYVIRTUALTOTAL='Mémoire virtuelle totale';
  IDS_PLATFORMID='Plateforme ID';
  IDS_PLATFORM='Plateforme';
  IDS_PROCESSORNUMBER='Nombre de processeurs';
  IDS_PROCESSOR='Processeur';
  IDS_TEMPPATH='Dossier Temp';
  IDS_DOSVERSION='DOS version';
  IDS_NUMLOCK='Verr num';
  IDS_CAPSLOCK='Verr maj';
  IDS_SCROLL='Arrêt défil';
  IDS_DATETIME='Date et heure';
  IDS_COMPANYNAME='Compagnie';
  IDS_PRODUCTNAME='Nom du produit';
  IDS_PRODUCTVERSION='Version';
  IDS_LEGALCOPYRIGHT='Copyright';
  IDS_TRADEMARK='LegalTrademark';
  IDS_FILEDESCRIPTION='Description du fichier';
  IDS_COMMENTS='Commentaires';
  IDS_CPUSPEED='Vitesse CPU';

 SLMDOk ='Aucune erreur';
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
 SZLibProcessingError = 'Erreur %d pendant traitement ZLib';
 SZLibInvalidStreamOp = 'Invalid stream operation';
 SZLibTargetBufferTooSmall = 'Target buffer may be too small';

 // Wide strings editor
 SLMDWideStringsEditorLineCount         = '%d lignes';
 SLMDWideStringsEditorCaption           = 'Editeur Wide String List';
 SLMDWideStringsEditorOkBtnCaption      = '&Ok';
 SLMDWideStringsEditorCancelBtnCaption  = 'Annuler';

 // Service provider
 SLMDServiceNotRegistered = 'Le service %s n'#39'est pas enregistré.';
 SLMDDuplicateService     = 'Le service %s déjà enregistré.';
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
