{***********************************************************
                R&A Library
       Copyright (C) 1996-98 R&A

       description : Language specific constants for Russian

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit RAConst;

interface

const

 {TRADBTreeView}
  SDeleteNode             = '������� %s ?';
  SDeleteNode2            = '������� %s (������ �� ���� ����������) ?';
  SMasterFieldEmpty       = '"MasterField" property must be filled';
  SDetailFieldEmpty       = '"DetailField" property must be filled';
  SItemFieldEmpty         = '"ItemField" property must be filled';
  SMasterDetailFieldError = '"MasterField" and "DetailField" must be of same type';
  SMasterFieldError       = '"MasterField" must be integer type';
  SDetailFieldError       = '"DetailField" must be integer type';
  SItemFieldError         = '"ItemField" must be string, date or integer type';
  SIconFieldError         = '"IconField" must be integer type';
  SMoveToModeError        = '�������� ����� ����������� RADBTreeNode';
  SDataSetNotActive       = 'DataSet not active';

   {RegAutoEditor}
  sRegAutoEditorEdtPropHint    = '��� �������� ����� ������ ����� �����';
  sRegAutoEditorTreeHint       = '��������� ��������';
  sRegAutoEditorListHint       = '������ ����������� �������';
  sRegAutoEditorBtnAddPropHint = '��������/������� ��������';
  sRegAutoEditorSort           = '�������������';

 {RAEditor}
  RAEditorCompletionChars = #8+'_0123456789QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm�������������������������������ި���������������������������������';

{IParser and RAI2Parser}
 {$IFDEF RA_D}
  StIdSymbols      = ['_', '0'..'9', 'A'..'Z', 'a'..'z', '�'..'�', '�'..'�'];
  StIdFirstSymbols = ['_', 'A'..'Z', 'a'..'z', '�'..'�', '�'..'�'];
  StConstSymbols   = ['0'..'9', 'A'..'F', 'a'..'f'];
  StConstSymbols10 = ['0'..'9'];
  StSeparators     = ['(', ')', ',', '.', ';'];
 {$ENDIF RA_D}
 {$IFDEF RA_B}
  StIdSymbols      = '_0123456789QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm�������������������������������ި���������������������������������';
  StIdFirstSymbols = '_QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm�������������������������������ި���������������������������������';
  StConstSymbols   = '0123456789ABCDEFabcdef';
  StConstSymbols10 = '0123456789';
  StSeparators     = '(),.;';
 {$ENDIF RA_B}

{$IFDEF RAINTER}
 {RAInter}
  RAIIdSymbols      = ['0'..'9', 'A'..'Z', 'a'..'z', '�'..'�', '�'..'�', '_'];
  RAIIdFirstSymbols = ['A'..'Z', 'a'..'z', '�'..'�', '�'..'�', '_'];
{$ENDIF RAINTER}

{$IFDEF RA_D2}
  SScrollBarRange = '�������� Scrollbar ����� �� ���������� �������';
{$ENDIF}

 {RADlg}
  SCancel = '������';

 { Menu Designer }
  SMDMenuDesigner       = 'Menu &Designer';
  SMDInsertItem         = '&Insert';
  SMDDeleteItem         = '&Delete';
  SMDCreateSubmenuItem  = 'Create &SubMenu';

  SCantGetShortCut      = 'Target FileName for ShortCut %s not available';


 { RALib 1.23 } 
  SPropertyNotExists    = 'Property "%s" does not exists';
  SInvalidPropertyType  = 'Property "%s" has invalid type';


implementation

end.








