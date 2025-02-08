unit LMDSctCst;
{###############################################################################

LMDSctCst unit (YB)
-------------------
Contains resource strings needed in the  LMD Script Pack.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

resourcestring
  SLMDCannotMixDebuggers        = 'Cannot connect ActiveX and Pascal scripts to ' +
                                  'single debugger.';
  SLMDScriptCantCreateEngine    = 'Can''t create script engine ''%s''';

  SLMDTooManyParams             = 'Trop de param�tres.';
  SLMDWrongArgCount             = 'Wrong argument count. Method or property called: %s';
  SLMDUnsupportedSetType        = 'Type non support�.';
  SLMDUnregisteredEventType     = 'Le type d''�venement %s n''est pas enregistr�.';
  SLMDDuplicateNamedItem        = 'Le nom de l''objet %s existe d�j�.';
  SLMDValNamedItemRequired      = 'Value named item required. ''%s'' is an object.';
  SLMDDebuggingNotSupported     = 'Le moteur de Script ne supporte pas le d�buggage.';

  SLMDCantFindConstructor       = 'Can''t find constructor for type %s with parameters: [%s]';

  SLMDWrongFloat                = 'Erreur de syntaxe dans la constante r�elle';
  SLMDWrongInteger              = 'Erreur de syntaxe dans la constante enti�re';
  SLMDUnterminatedStr           = 'Chaine non termin�e.';
  SLMDIllegalChar               = 'Caract�re non autoris�: ''%s'' ($%x)';

  SLMDInvalidDirective          = 'Directive non valide: ''%s''.';
  SLMDTooComplexIfCond          = 'Too complex $IF directive condition.';  
  SLMDDirectiveNotSupported     = 'La directive ''%s'' n''est pas support�e.';
  SLMDUnterminatedDirective     = 'Directive conditionnelle non termin�e.';
  SLMDIncFileNotFound           = 'Le fichier inclus ''%s'' est introuvable.';

  SLMDStrExpected               = '%s expected. Line: %d, Column: %d.';
  SLMDInvalidToken              = 'Invalid token: %s. Line: %d, Column: %d. Data: %s';
  SLMDInvalidTokenShort         = 'Invalid token: %s.';
  SLMDValidClassVis             = 'Valid class visibility token';
  SLMDValidPropSpecifier        = 'Valid property specifier';
  SLMDValidDirective            = 'Directive valide';

  SLMDDocParseError             = '[Erreur] Erreur d''analyse: %s';
  SLMDDocInvalidFileFormat      = 'Format de fichier non valide.';
  SLMDDocUnsuppFileVers         = 'Version de format de fichier non support�e: ''%s''.';

  SLMDCompWarning               = '[Attention] %s';
  SLMDCompError                 = '[Erreur] %s';
  SLMDCompAnalizeResNotFound    = 'Analize results for ''%s'' unit is not found.';
  SLMDCompFioleReadFailed       = 'La lecture de ''%s'' a �chou�e: %s.';
  SLMDCompNotValidIdent         = '''%s'' n''est pas un identifiant Delphi valide.';
  SLMDCompCantAnalizeUntpdCst   = 'Can''t analize untyped constant expression type.';
  SLMDCompOverlProcsNotSupp     = 'Les proc�dures Overloaded ne sont pas support�es.';
  SLMDCompOverlMethodsNotSupp   = 'Les m�thodes Overloaded ne sont pas support�es.';
  SLMDCompOpenArraysNotSupp     = 'Les tableaux ouverts de variants ne sont pas support�s.';
  SLMDCompUntypedParamNotSupp   = 'Untyped const, var ou out parameters ne sont pas support�s.';
  SLMDCompBoundedStrTypeNotSupp = 'Bounded string types are not supported in var ' +
                                  'or out parameters.';
  SLMDCompNObjProcTypesNotSupp  = 'Non-object procedural types ne sont pas ' +
                                  'support�s.';
  SLMDCompRefToTypesNotSupp     = 'Procedure reference types are not ' +
                                  'supported.';
  SLMDCompHelpersNotSupp        = 'Class or record helpers are not supported.';
  SLMDCompPointersNotSupp       = 'Pointer types ne sont pas support�s.';
  SLMDCompFileTypesNotSupp      = 'File types ne sont pas support�s.';
  SLMDCompArraysNotSupp         = 'Array types ne sont pas support�s.';
  SLMDCompInterfacesNotSupp     = 'Interface types ne sont pas support�s.';
  SLMDCompUnnamedTypesNotSupp   = 'Implicit unnamed %s types ne sont pas support�s.';
  SLMDCompDeclHasErrors         = '''%s'' a des erreurs.';
  SLMDCompDeclHasWarnings       = '''%s'' a des avertissements.';
  SLMDCompDeclHasBeenUnchecked  = '''%s'' has been unchecked.';
  SLMDCompDeclNotType           = '''%s'' n''est pas un type.';
  SLMDCompDeclNotSupp           = '''%s'' n''est pas support�.';
  SLMDCompDeclNotFound          = '''%s'' est introuvable.';

  SLMDCompConstantType          = 'Constant type: ';
  SLMDCompVariableType          = 'Variable type: ';
  SLMDCompReturnType            = 'Return type: ';
  SLMDCompFieldType             = 'Field type: ';
  SLMDCompPropertyType          = 'Property type: ';
  SLMDCompParameter             = 'Parameter ''%s'': ';
  SLMDCompTypeAlias             = 'Type alias: ';
  SLMDCompAncestorType          = 'Ancestor type: ';

  SLMDDocFormOk                 = 'Ok';
  SLMDDocFormFailed             = 'Echou�';
  SLMDDocFormNoSelection        = '<Aucun �l�ment s�lectionn�>';
  SLMDDocFormParsing            = 'Parsing...';
  SLMDDocFormAnalizing          = 'Analyse...';
  SLMDDocFormNoIDESourceEditor  = 'L''�diteur du code source pour ''%s'' n'#39'est pas disponible.';

  SLMDInvalidIDEVers            = 'LMD ScriptPack - Assistant d''import: ' +
                                  'Version de Delphi non support�e.';
  SLMDNoIDEConfigKey            = 'LMD ScriptPack - Assistant d''import: ' +
                                  'Impossible de lire la cl� de configuration de l''IDE ''%s'' � partir du registre.';
  SLMDNoOpenedUnit              = 'Pas d'#39'unit� disponible.'#13#10 +
                                  'Ouvrir l''unit� d''import dans l''�diteur de Delphi.';
  SLMDDirNotExists              = 'Le dossier ''%s'' n'#39'existe pas.';
  SLMDRegValueNotExists         = 'La valeur ''%s'' n'#39'existe pas.';
  SLMDBreakpointReached         = 'Breakpoint at %s, line: %d';
  SLMDBreakpointReachedPass     = 'Breakpoint at %s, line: %d. Pass %d of %d';
  SLMDBreakpointMessage         = 'Breakpoint message: %s';
  SLMDBreakpointEvalExpr        = 'Breakpoint expression %s: %s';
  TLMDBreakpointWholeStackHdr   = 'Breakpoint Call Stack: log all stack frames';
  TLMDBreakpointNStackHdr       = 'Breakpoint Call Stack: log %d stack frame(s)';

  { Pascal Script }

  SLMDVMNonInitialize           = 'Virtual machine should be not initialized.';
  SLMDVMInitialize              = 'Virtual machine should be initialized.';
  SLMDVMActive                  = 'Virtual machine should be active.';
  SLMDVMProcRequired            = 'Procedural type required.';
  SLMDVMValObjRequired          = 'Variable or constant required.';
  SLMDVMAborted                 = 'Script execution has been aborted.';
  SLMDInvalidDebugThread        = 'Debug evaluation is only allowed from the breaked thread.';


  SLMDParserTypeExpected        = 'Type identifier expected';
  SLMDParserReRaise             = 'Re-raising an exception only allowed in exception handler';
  SLMDParserIEInvalidOperator   = 'Internal error: Invalid operator type';

  SLMDRuntimeUndeclaredId       = 'Undeclared identifier: ''%s''';
  SLMDRuntimeOutsideOfLoop      = 'BREAK or CONTINUE outside of loop';
  SLMDRuntimeEBCFromFinally     = 'Cannot BREAK, CONTINUE or EXIT out of a FINALLY clause';
  SLMDRuntimeCannotAssign       = 'Left side cannot be assigned to';
  SLMDRuntimeInvalidParamCount  = 'Invalid argument count';
  SLMDRuntimeTypeMismatch       = 'Invalid type cast or type mismatch';
  SLMDRuntimeObjectRequired     = 'Object required but nil found';
  SLMDRuntimeLoopVar            = 'For loop control variable must be simple local variable';
  SLMDRuntimeCannotRaiseNil     = 'Cannot raise nil exception';
  SLMDRuntimeCannotRaiseLocked  = 'Cannot raise locked exception';
  SLMDRuntimeLowOnlyArray       = 'Low can be applied only to an array';
  SLMDRuntimeHighOnlyArray      = 'High can be applied only to an array';
  SLMDRuntimeViolatesBounds     = 'Constant expression violates subrange bounds';
  SLMDRuntimeInvalidDispId      = 'Invalid DispId';
  SLMDRuntimeInvalidException   = 'Internal error: Invalid exception type';
  SLMDRuntimeOleError           = 'OLE error %.8x';
  SLMDRuntimeIEInvalidInstr     = 'Internal error: Invalid instruction code';
  SLMDRuntimeIEInvalidObjKind   = 'Internal error: Invalid object kind';
  SLMDRuntimeIEInvalidBracket   = 'Internal error: Invalid bracket type';
  SLMDRuntimeIENoBreakpointInfo = 'Internal error: No breakpoint info found';

  SLMDCompTemplatesNotSupp      = 'Templates are not supported.';

implementation


end.
