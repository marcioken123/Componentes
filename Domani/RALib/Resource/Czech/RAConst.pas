{***********************************************************
                R&A Library
       Copyright (C) 1996-99 R&A

       description : Language specific constant for Czech

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib.htm

       translated by : Jaromir Solar
       e-mail        : jarda@foresta.cz
************************************************************}

{$INCLUDE RA.INC}

unit RAConst;

interface

const

 {TRADBTreeView}
  SDeleteNode             = 'Smazat %s ?';
  SDeleteNode2            = 'Smazat %s (se v�emi n�sledn�ky)?';
  SMasterFieldEmpty       = '"MasterField" property mus� b�t vypln�no';
  SDetailFieldEmpty       = '"DetailField" property mus� b�t vypln�no';
  SItemFieldEmpty         = '"ItemField" property mus� b�t vypln�no';
  SMasterDetailFieldError = '"MasterField" a "DetailField" mus� b�t stejn�ho typu';
  SMasterFieldError       = '"MasterField" mus� b�t celo��seln�ho typu';
  SDetailFieldError       = '"DetailField" mus� b�t celo��seln�ho typu';
  SItemFieldError         = '"ItemField" mus� b�t �et�zec, datum nebo cel� ��slo';
  SIconFieldError         = '"IconField" mus� b�t cel� ��slo';
  SMoveToModeError        = 'Chybn� p�esun uzlu v RADBTreeNode';
  SDataSetNotActive       = 'DataSet nen� aktivn�';

 {RegAutoEditor}
  sRegAutoEditorEdtPropHint    = 'Vepi�te sem jm�no vlastnosti';
  sRegAutoEditorTreeHint       = 'Dostupn� vlastnosti';
  sRegAutoEditorListHint       = 'Ulo�en� vlastnosti';
  sRegAutoEditorBtnAddPropHint = 'P�idat/odstranit vlastnost';
  sRegAutoEditorSort           = 'Set��dit';

 {RAEditor}
  RAEditorCompletionChars = #8+'0123456789QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm';

{IParser}
 {$IFDEF RA_D}
  StIdSymbols      = ['_', '0'..'9', 'A'..'Z', 'a'..'z'];
  StIdFirstSymbols = ['_', 'A'..'Z', 'a'..'z'];
  StConstSymbols   = ['0'..'9', 'A'..'F', 'a'..'f'];
  StConstSymbols10 = ['0'..'9'];
  StSeparators     = ['(', ')', ',', '.', ';'];
 {$ENDIF RA_D}
 {$IFDEF RA_B}
  StIdSymbols      = '_0123456789QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm';
  StIdFirstSymbols = '_QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm';
  StConstSymbols   = '0123456789ABCDEFabcdef';
  StConstSymbols10 = '0123456789';
  StSeparators     = '(),.;';
 {$ENDIF RA_B}

{$IFDEF RAINTER}
 {RAInter}
  RAIIdSymbols      = ['0'..'9', 'A'..'Z', 'a'..'z',  '_'];
  RAIIdFirstSymbols = ['A'..'Z', 'a'..'z', '_'];
{$ENDIF RAINTER}

{$IFDEF RA_D2}
  SScrollBarRange = 'Hodnota �oup�tka je mimo rozsah';
{$ENDIF}

 {RADlg}
  SCancel = 'Zru�it';

 { Menu Designer }
  SMDMenuDesigner       = 'Menu &Designer';
  SMDInsertItem         = '&Vlo�it';
  SMDDeleteItem         = '&Smazat';
  SMDCreateSubmenuItem  = 'Vytvo�it &SubMenu';

  SCantGetShortCut      = 'Nemohu zjistit vazbu na soubor %s';


 { RALib 1.23 } 
  SPropertyNotExists    = 'Property "%s" does not exists';
  SInvalidPropertyType  = 'Property "%s" has invalid type';

implementation

end.
