unit LMDElConst;
{###############################################################################

LMDElConst unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}
interface

uses
  Graphics;

{$R 'LMDElPack.res'}

resourcestring
  SLMDDay  = '���� ';
  SLMDWeek = '������ ';
  SLMDHintNextYear = '��������� ���';
  SLMDHintPrevYear = '���������� ���';
  SLMDHintNextMonth = '��������� �����';
  SLMDHintPrevMonth = '���������� �����';
  SLMDCapClear      = '��������';
  SLMDCapToday      = '�������';
  SLMDCapOk      = 'OK';
  SLMDCapCancel      = '������';
  SLMDCapCalendar   = '���������';
  SLMDCapCalendarGB = '����';
  SLMDCapClockGB = '�����';

  SLMDCustom = '���������������� ...';

  SLMDUndo = '&��������';
  SLMDCut = '&��������';
  SLMDCopy = '&����������';
  SLMDPaste = '���&�����';
  SLMDDelete = '&�������';
  SLMDSelectAll = '�&������� ���';

  SLMDShiftP = 'Shift+';
  SLMDAltP = 'Alt+';
  SLMDCtrlP = 'Ctrl+';
  SLMDLeftP = 'Left+';
  SLMDRightP = 'Right+';
  SLMDMiddleP = 'Middle+';
  SLMDDoubleP = 'Double+';
  SLMDLWinP = 'Win+';
  SLMDRWinP = 'Win+';

  SLMDElCantSetThisEntryAs = '������ ���������� �������� �������������  %s';
  SLMDElCantGetThisPropAs = '������ �������� ��� �������� ��� %s';
  SLMDElCantSetThisPropAs = '������ ���������� ��� �������� ��� %s';

  SLMDListIndexOutOfBounds = '������ [%d] ������� �� ���������� ������� � ������';

  SLMDBitmapInvalid = '����������� ����� ������������ ������.';
  SLMDSyntaxError = '�������������� ������';
  SLMDCloseBracketExpected = '��������� ")"';
  SLMDExpressionEmpty = '��������� �����';
  SLMDOpenBracketExpected = '��������� "("';
  SLMDInvalidArgument = '������������ ��������';
  SLMDMathFunctions = '�������������� �������';

  SLMDShowNextTime = '�������� � ��������� ���';
  SLMDDSecondsLeft = '�������� %d ������(�)';

  SElNotIdent = '������ ����� �� ����� ��������������';
  SElInstanceIsNotDefined = '��������� �� ���������';
  SElRequiredPropertyIsNotDefined = '����������� �������� %s �� ����������';
  SElCantGetThisPropAs = '������ �������� ��� �������� ��� %s';
  SElCantSetThisPropAs = '������ ���������� ��� �������� ��� %s';
  SElIsNotEnum = '�������� %s �� ����� ������������� ��������';
  SElReadonly = '�������� %s �� ����� ���� ��������';
  SElInvalidType = '������������ �������������� ���� ��� %s';
  SElNotFound = '%s %s �� �������';
  SElCompUnassignedValue = '';
  SElClassUnassignedValue = '';

  SLMDNoControl = '�� ������ ��������� ��� ������� �������� ���������� ������ TElScrollBarStyles';

  SLMDNoMoreTokensMessage = '�������� ������ �� ��������';

  SInvalidThemeFileName = '������������ ��� ����� ���� [%s]';
  SUnknownTheme = '����������� ���� [%s]';
  SUnknownThemePart = '����������� ������� [%d] � ����';
  SUnknownThemeColorScheme = '����������� �������� ����� [%s] � ����';
  SUnknownThemeBool = '����������� ��������� ������� - ��������� [%d]';
  SUnknownThemeColor = '����������� ��������� ������� - ���� [%d]';
  SUnknownThemeFont = '����������� ��������� ������� - ����� [%d]';
  SUnknownThemeInt = '����������� ��������� ������� - ����� [%d]';
  SUnknownThemeSize = '����������� ��������� ������� - ������ [%d]';
  SUnknownThemeString = '����������� ��������� ������� - ������ [%d]';
  SInvalidRefCount = '������������ �������� RefCount � [%s]';

  SWinXPThemeNoDisplayName = '�� ������� ������������ ��� ��� ������ ����';
  SWinXPThemeInvalidParameter = '������������ �������� �������';
  SWinXPThemeNoDocProp = '�������� [%s] �� ����������';
  SWinXPThemeNoSchemeSection = '�� ������� ����� ���������� ����� ����';
  SWinXPThemeNoMetricsProp = '�������� [%d] ��������� ������� �� ����������';
  SWinXPThemeNoSchemeProp = '�������� ���� [%d] �� ����������';
  SWinXPThemeTextMetricFailed = '�� ������� �������� ��������� �������';

  SUnkOSError = '�� ������� ������� ������� ��';
  SOSError = '��������� ������.  ���: %d.'#13#10'%s';

  STExOutOfBounds = '������ �������� ElTree ������� �� �������.';
  STexInvItem = '�� ������ ������� ElTree';
  STexRecursiveMove = '������ ����������� ������� � ���� �� ��� ������������';

  SInvalidPropertyValue = '������������ �������� ��������';

  SLMDCaption = '�������� ������ �����������';

  SLMDQuestion = '�������� ������ ��������� ������� �����������';

  SLMDTipOfTheDay = '����� ���...';
  SLMDDidYouKnow = '  ������ �� ��, ���...';
  SLMDShowTipsAtStartup = '���������� ��� �������';
  SLMDNextTip = '&�����...';
  SLMDClose = '&������';

  SLMDStyleInstanceNotAssigned  = '����� �� ��������������� ��� %s';

const
  LMDElHideSelectTextColor = clBtnShadow;
implementation
end.
