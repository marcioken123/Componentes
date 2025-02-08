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

  SLMDTooManyParams             = 'Too many parameters.';
  SLMDWrongArgCount             = 'Wrong argument count. Method or property called: %s';
  SLMDUnsupportedSetType        = 'Unsupported set type.';
  SLMDUnregisteredEventType     = 'Event type %s is not registered.';
  SLMDDuplicateNamedItem        = 'Object or value named ''%s'' already exists.';
  SLMDValNamedItemRequired      = 'Value named item required. ''%s'' is an object.';
  SLMDDebuggingNotSupported     = 'Script engine does not support debugging.'; 
  SLMDCantFindConstructor       = 'Can''t find constructor for type %s with parameters: [%s]';

  SLMDWrongFloat                = 'Syntax error in float constant';
  SLMDWrongInteger              = 'Syntax error in integer constant';
  SLMDUnterminatedStr           = 'Unterminated string';
  SLMDIllegalChar               = 'Illegal character: ''%s'' ($%x)';

  SLMDInvalidDirective          = 'Invalid directive: ''%s''.';
  SLMDTooComplexIfCond          = 'Too complex $IF directive condition.';
  SLMDDirectiveNotSupported     = '''%s'' directive is not supported.';
  SLMDUnterminatedDirective     = 'Unterminated conditional directive.';
  SLMDIncFileNotFound           = 'Included file ''%s'' is not found.';

  SLMDStrExpected               = '%s expected.';
  SLMDInvalidToken              = 'Invalid token: %s.';
  SLMDInvalidTokenShort         = 'Invalid token: %s.';
  SLMDValidClassVis             = 'Valid class visibility token';
  SLMDValidPropSpecifier        = 'Valid property specifier';
  SLMDValidDirective            = 'Valid directive';

  SLMDDocParseError             = '[Error] Parse error: %s';
  SLMDDocInvalidFileFormat      = 'Invalid file format.';
  SLMDDocUnsuppFileVers         = 'Unsupported file format version: ''%s''.';

  SLMDCompWarning               = '[Warning] %s';
  SLMDCompError                 = '[Error] %s';
  SLMDCompAnalizeResNotFound    = 'Analize results for ''%s'' unit is not found.';
  SLMDCompFioleReadFailed       = 'Reading ''%s'' failed: %s.';
  SLMDCompNotValidIdent         = '''%s'' is not a valid Delphi identifier.';
  SLMDCompCantAnalizeUntpdCst   = 'Can''t analize untyped constant expression type.';
  SLMDCompOverlProcsNotSupp     = 'Overloaded procedures are not supported.';
  SLMDCompOverlMethodsNotSupp   = 'Overloaded methods are not supported.';
  SLMDCompOverlGroupNotSupp     = 'Overload group not supported.';
  SLMDCompOverlGroupIsEmpty     = 'Overload group is empty.';
  SLMDCompOpenArraysNotSupp     = 'Variant open arrays are not supported.';
  SLMDCompUntypedParamNotSupp   = 'Untyped const, var or out parameters are not supported.';
  SLMDCompBoundedStrTypeNotSupp = 'Bounded string types are not supported in var ' +
                                  'or out parameters.';
  SLMDCompNObjProcTypesNotSupp  = 'Non-object procedural types are not ' +
                                  'supported.';
  SLMDCompRefToTypesNotSupp     = 'Procedure reference types are not ' +
                                  'supported.';
  SLMDCompHelpersNotSupp        = 'Class or record helpers are not supported.';
  SLMDCompPointersNotSupp       = 'Pointer types are not supported.';
  SLMDCompFileTypesNotSupp      = 'File types are not supported.';
  SLMDCompArraysNotSupp         = 'Array types are not supported.';
  SLMDCompInterfacesNotSupp     = 'Interface types are not supported.';
  SLMDCompUnnamedTypesNotSupp   = 'Implicit unnamed %s types are not supported.';
  SLMDCompTemplatesNotSupp      = 'Templates are not supported.';
  SLMDCompDeclHasErrors         = '''%s'' has errors.';
  SLMDCompDeclHasWarnings       = '''%s'' has warnings.';
  SLMDCompDeclHasBeenUnchecked  = '''%s'' has been unchecked.';
  SLMDCompDeclNotType           = '''%s'' is not a type.';
  SLMDCompDeclNotSupp           = '''%s'' is not supported.';
  SLMDCompDeclNotFound          = '''%s'' is not found.';

  SLMDCompConstantType          = 'Constant type: ';
  SLMDCompVariableType          = 'Variable type: ';
  SLMDCompReturnType            = 'Return type: ';
  SLMDCompFieldType             = 'Field type: ';
  SLMDCompPropertyType          = 'Property type: ';
  SLMDCompParameter             = 'Parameter ''%s'': ';
  SLMDCompTypeAlias             = 'Type alias: ';
  SLMDCompAncestorType          = 'Ancestor type: ';

  SLMDDocFormOk                 = 'Ok';
  SLMDDocFormFailed             = 'Failed';
  SLMDDocFormNoSelection        = '<No item selected>';
  SLMDDocFormParsing            = 'Parsing...';
  SLMDDocFormAnalizing          = 'Analizing...';
  SLMDDocFormNoIDESourceEditor  = 'Source code editor for ''%s'' is not available.';

  SLMDInvalidIDEVers            = 'LMD ScriptPack ImportWizard: ' +
                                  'Unsupported Delphi IDE version.';
  SLMDNoIDEConfigKey            = 'LMD ScriptPack ImportWizard: ' +
                                  'Cannot read IDE configuration key ''%s'' from registry.';
  SLMDNoOpenedUnit              = 'No unit available.'#13#10 +
                                  'Please open importing unit in Delphi IDE editor.';
  SLMDDirNotExists              = 'Directory ''%s'' does not exists.';
  SLMDRegValueNotExists         = 'Value ''%s'' does not exists.';

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
  SLMDRuntimeCannotAssign       = 'Invalid assignment';
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

implementation

end.
