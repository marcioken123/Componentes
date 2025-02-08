unit LMDElDBConst;
{###############################################################################

LMDElDBConst unit
-----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils;

{$R LMDElPackDB.res}

type
  TElUpdateStylesType = (stPattern, stFontAndStyles, stHint, stCheckBox, stImages, stCaption, stShowCaption);
  TElTableName = type string;

  EOnUndefinedGridColumnsDataSet = class (Exception)
  end;

  ENoValidDataSetName = class (Exception)
  end;

  EIncorrectFieldName = class (Exception)
  end;
  EIncorrectColumnIndex = class (Exception)
  end;

  EErrorInPattern = class (Exception)
  end;

  EOnGoToBookmark = class (Exception)
  end;

  EOnMoveError = class (Exception)
  end;

  EOnErrorInRelation = class (Exception)
  end;

  TElDBUnicodeMode = (umFieldType, umForceUTF8, umForceUnicode);

resourcestring
  SErrorInMTree = '������ � MTree : ������� �� ������.';
  SDeleteFromDenyDataSet = '������ ������� �� ������ ������ � ���������� ������ DenyLookSetPosition.';
  SMasterDetailIncompatible = '��������! ���� ����� MasterField � DetailField �����������. ��� ���������� ������ ����� ����������� ������� �������������� ����� � ������.';
  SOnErrorInRelation = '�� ������� ���������� ����� � ��������� %d. ��������� ���� � ������ ����� MasterField � DetailField.';
  SNoSetInstall = '�������� ������ DataSource �� ��������� - ������ �������������.';
  SNoDSetInstall = '����� ������ Dataset �� ��������� � ��������� DataSource - ������ �������������.';
  SOnMoveError = '������ �����������';
  SOnGoToBookmark = '�� ������� ����� ������ � ������ ������ %s. ���� �� ����������� � �������� ������ ������ ������ � �����������, ���������� ������ DenyLookSetPosition ��� ��������������� �����.';
  SErrorInPattern = '������ � �������! ��������� ����� ����� � ���������.';
  SErrorPrebuildLevel = '����������� ��������� �������� ����� ��������� ����� 2.';
  SNoColumnSetAssigned = '����� ������ ��� �������� TreeGrid �����������.';
  SNoValidDataSetName = '��� ������ ������ %s ��� �������� TreeGrid �������. ���������, ��������� �� ��������� ����� ������ � ���������� ������.';
  SIncorrectColumnIndex = '������������ ������ �������.';
  SIncorrectFieldName = '������������ ��� %s.';

  SLMDNbrFirst = '������ ������';
  SLMDNbrPrior = '���������� ������';
  SLMDNbrNext = '��������� ������';
  SLMDNbrLast = '��������� ������';
  SLMDNbrInsert = '�������� ������';
  SLMDNbrDelete = '������� ������';
  SLMDNbrEdit = '������������� ������';
  SLMDNbrPost = '���������';
  SLMDNbrCancel = '��������';
  SLMDNbrRefresh = '��������';
  SLMDNbrSearch = '�����';
  SLMDNbrSetFilter = '���������� ������';
  SLMDNbrRemoveFilter = '������� ������';
  SLMDNbrClear = '��������';
  SLMDNbrOpen = '�������';
  SLMDNbrClose = '�������';
  SLMDNbrFindFirst = '����� ������';
  SLMDNbrFindPrior = '����� ����������';
  SLMDNbrFindNext = '����� ���������';
  SLMDNbrFindLast = '����� ���������';

  SLMDTnbrFirstRoot = '������ ���� � �����';
  SLMDTnbrFirst = '������ ����';
  SLMDTnbrPrior = '���������� ����';
  SLMDTnbrNext = '��������� ����';
  SLMDTnbrLast = '��������� ����';
  SLMDTnbrLastRoot = '��������� ���� � �����';
  SLMDTnbrInsert = '�������� ����';
  SLMDTnbrInsertSubItem = '�������� �������� ����';
  SLMDTnbrDelete = '������� ����';
  SLMDTnbrEdit = '������������� ����';
  SLMDTnbrRefresh = '��������';


implementation

end.
