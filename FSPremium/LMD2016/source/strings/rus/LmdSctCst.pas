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
 
  SLMDTooManyParams             = '��������� ������������ ���������� ����������.';
  SLMDWrongArgCount             = '�������� ���������� ����������. ����� ��� ��������: %s';
  SLMDUnsupportedSetType        = '���������������� ��� ��������� (set).';
  SLMDUnregisteredEventType     = '�������������������� ��� �������: %s.';
  SLMDDuplicateNamedItem        = '������ %s ��� ����������.';
  SLMDDebuggingNotSupported     = '����������� ������ ������� �� ������������ �������.';
  SLMDValNamedItemRequired      = 'Value named item required. ''%s'' is an object.';
  SLMDCantFindConstructor       = '����������� ���� %s � ����������� [%s] �� ������.';

  SLMDWrongFloat                = '�������������� ������ � �������� ���������.';
  SLMDWrongInteger              = '�������������� ������ � ������������� ���������.';
  SLMDUnterminatedStr           = '������������� ��������� �������.';
  SLMDIllegalChar               = '�������� ������: ''%s'' ($%x)';

  SLMDInvalidDirective          = '�������� ���������: ''%s''.';
  SLMDTooComplexIfCond          = 'Too complex $IF directive condition.';
  SLMDDirectiveNotSupported     = '��������� ''%s'' �� ��������������.';
  SLMDUnterminatedDirective     = '������������� ��������� �������� ����������.';
  SLMDIncFileNotFound           = '���������� ���� ''%s'' �� ������.';


  SLMDStrExpected               = '��������� %s. ������: %d, �������: %d.';
  SLMDInvalidToken              = '�������� �����: %s. ������: %d, �������: %d. ������: %s';
  SLMDInvalidTokenShort         = '�������� �����: %s.';
  SLMDValidClassVis             = '����� ��������� ������';
  SLMDValidPropSpecifier        = '������������ ��������';
  SLMDValidDirective            = '���������';

  SLMDDocParseError             = '[������] �������������� ������: %s';
  SLMDDocInvalidFileFormat      = '�������� ������ �����.';
  SLMDDocUnsuppFileVers         = '���������������� ������ ������� �����.';

  SLMDCompWarning               = '[��������������] %s';
  SLMDCompError                 = '[������] %s';
  SLMDCompAnalizeResNotFound    = '�� ������� ���������� ������� ������ ''%s''.';
  SLMDCompFioleReadFailed       = '���� ��� ������ ����� ''%s'': %s.';
  SLMDCompNotValidIdent         = '�������� ������������� ''%s''.';
  SLMDCompCantAnalizeUntpdCst   = '������ ���� ���������������� ��������� �� ��������������.';
  SLMDCompOverlProcsNotSupp     = '������������� (overloaded) ��������� �� ��������������.';
  SLMDCompOverlMethodsNotSupp   = '������������� (overloaded) ������ �� ��������������.';
  SLMDCompOpenArraysNotSupp     = '���������� ''open arrays'' �� ��������������.';
  SLMDCompUntypedParamNotSupp   = '���������������� const, var ��� out ��������� �� ��������������.';
  SLMDCompBoundedStrTypeNotSupp = '������������ ��������� ���� �� �������������� � var ' +
                                  '� out ����������.';
  SLMDCompNObjProcTypesNotSupp  = '�� ��������� ����������� ���� �� ' +
                                  '��������������.';
  SLMDCompPointersNotSupp       = '��������� �� ��������������.';
  SLMDCompFileTypesNotSupp      = '�������� ���� �� ��������������.';
  SLMDCompArraysNotSupp         = '������� �� ��������������.';
  SLMDCompInterfacesNotSupp     = '������������ ���� �� ��������������.';
  SLMDCompUnnamedTypesNotSupp   = '������� ������������� %s ���� �� ��������������.';
  SLMDCompDeclHasErrors         = '''%s'' ����� ������.';
  SLMDCompDeclHasWarnings       = '''%s'' ����� ��������������.';
  SLMDCompDeclHasBeenUnchecked  = '''%s'' ��� �������� �������������.';
  SLMDCompDeclNotType           = '''%s'' �� �������� �����.';
  SLMDCompDeclNotSupp           = '''%s'' �� ��������������.';
  SLMDCompDeclNotFound          = '''%s'' �� ������.';

  SLMDCompConstantType          = '��� ���������: ';
  SLMDCompVariableType          = '��� ����������: ';
  SLMDCompReturnType            = '��� ������������� ��������: ';
  SLMDCompFieldType             = '��� ����: ';
  SLMDCompPropertyType          = '��� ��������: ';
  SLMDCompParameter             = '�������� ''%s'': ';
  SLMDCompTypeAlias             = '����� ����: ';
  SLMDCompAncestorType          = '��� ������-������: ';

  SLMDDocFormOk                 = 'Ok';
  SLMDDocFormFailed             = '������';
  SLMDDocFormNoSelection        = '<��� ���������>';
  SLMDDocFormParsing            = '���� �������������� ������...';
  SLMDDocFormAnalizing          = '���� ������...';
  SLMDDocFormNoIDESourceEditor  = '�� ������ �������� ���� ��� ������ ''%s''.';

  SLMDInvalidIDEVers            = 'LMD ScriptPack ImportWizard: ' +
                                  '���������������� ������ Delphi IDE.';
  SLMDNoIDEConfigKey            = 'LMD ScriptPack ImportWizard: ' +
                                  '�� ������� ��������� ���� ������������ ' +
                                  'IDE ''%s'' �� �������.';
  SLMDNoOpenedUnit              = '��� �������� �������.'#13#10 +
                                  '����������, �������� ������������� ������ � ' +
                                  '��������� Delphi IDE.';
  SLMDDirNotExists              = '������� ''%s'' �� ���������.';
  SLMDRegValueNotExists         = '�������� ''%s'' �� ������� � �������.';

  SLMDBreakpointReached         = 'Breakpoint at %s, line: %d';
  SLMDBreakpointReachedPass     = 'Breakpoint at %s, line: %d. Pass %d of %d';
  SLMDBreakpointMessage         = 'Breakpoint message: %s';
  SLMDBreakpointEvalExpr        = 'Breakpoint expression %s: %s';
  TLMDBreakpointWholeStackHdr   = 'Breakpoint Call Stack: log all stack frames';
  TLMDBreakpointNStackHdr       = 'Breakpoint Call Stack: log %d stack frame(s)';


  { Pascal Script }

  SLMDVMNonInitialize           = '����������� ������ ������ ���� �� ����������������.';
  SLMDVMInitialize              = '����������� ������ ������ ���� ����������������.';
  SLMDVMActive                  = '����������� ������ ������ ���� �������.';
  SLMDVMProcRequired            = '��������� ��������� �� �������.';
  SLMDVMValObjRequired          = '��������� ���������� ��� ���������.';
  SLMDVMAborted                 = '���������� ������� ���� ��������.';
  SLMDInvalidDebugThread        = 'Debug evaluation is only allowed from the breaked thread.';


  SLMDParserTypeExpected        = '��������� ������������� ����';
  SLMDParserReRaise             = '���������� raise ��� ���������� ��������� ������ ' +
                                  '������ ����������� �������������� ��������';
  SLMDParserIEInvalidOperator   = '���������� ������: �������� ��� ���������';

  SLMDRuntimeUndeclaredId       = '������������� �������������: ''%s''';
  SLMDRuntimeOutsideOfLoop      = 'BREAK ��� CONTINUE �� ��������� �����';
  SLMDRuntimeEBCFromFinally     = '���������� ��������� BREAK, CONTINUE ��� EXIT ������� ��� �������� FINALLY';
  SLMDRuntimeCannotAssign       = '������������ ����������';
  SLMDRuntimeInvalidParamCount  = '�������� ���������� ����������';
  SLMDRuntimeTypeMismatch       = '������������ ��� ��� �������� ���������� �����';
  SLMDRuntimeObjectRequired     = '�������� ��������� ������ �� ������';
  SLMDRuntimeLoopVar            = '���������� � ����� for ������ ���� ������� ��������� ����������';
  SLMDRuntimeCannotRaiseNil     = '���������� ��������� (raise) nil ����������';
  SLMDRuntimeCannotRaiseLocked  = '���������� ��������� (raise) ����������: ���������� ������������� ������������';
  SLMDRuntimeLowOnlyArray       = '������� Low: ��������� ������';
  SLMDRuntimeHighOnlyArray      = '������� High: ��������� ������';
  SLMDRuntimeViolatesBounds     = '�������� ��������� ������� �� ������� ����������� ���������';
  SLMDRuntimeInvalidDispId      = '�������� DispId';
  SLMDRuntimeInvalidException   = '���������� ������: �������� ��� �������������� ��������';
  SLMDRuntimeOleError           = '������ OLE %.8x';
  SLMDRuntimeIEInvalidInstr     = '���������� ������: �������� ��� ����������';
  SLMDRuntimeIEInvalidObjKind   = '���������� ������: �������� ��� �������';
  SLMDRuntimeIEInvalidBracket   = '���������� ������: �������� ��� ������';
  SLMDRuntimeIENoBreakpointInfo = '���������� ������: �� ������� ���������� � �����������';

  SLMDCompTemplatesNotSupp      = 'Templates are not supported.';

  SLMDCompOverlGroupIsEmpty     = 'Overload group is empty.';
  SLMDCompOverlGroupNotSupp     = 'Overload group not supported.';
  SLMDCompHelpersNotSupp        = 'Class or record helpers are not supported.';
  SLMDCompRefToTypesNotSupp     = 'Procedure reference types are not ' +
                                  'supported.';


implementation

end.
