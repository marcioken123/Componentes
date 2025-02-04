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
  SDeleteNode2            = 'Smazat %s (se všemi následníky)?';
  SMasterFieldEmpty       = '"MasterField" property musí být vyplnìno';
  SDetailFieldEmpty       = '"DetailField" property musí být vyplnìno';
  SItemFieldEmpty         = '"ItemField" property musí být vyplnìno';
  SMasterDetailFieldError = '"MasterField" a "DetailField" musí být stejného typu';
  SMasterFieldError       = '"MasterField" musí být celoèíselného typu';
  SDetailFieldError       = '"DetailField" musí být celoèíselného typu';
  SItemFieldError         = '"ItemField" musí být øetìzec, datum nebo celé èíslo';
  SIconFieldError         = '"IconField" musí být celé èíslo';
  SMoveToModeError        = 'Chybný pøesun uzlu v RADBTreeNode';
  SDataSetNotActive       = 'DataSet není aktivní';

 {RegAutoEditor}
  sRegAutoEditorEdtPropHint    = 'Vepište sem jméno vlastnosti';
  sRegAutoEditorTreeHint       = 'Dostupné vlastnosti';
  sRegAutoEditorListHint       = 'Uložené vlastnosti';
  sRegAutoEditorBtnAddPropHint = 'Pøidat/odstranit vlastnost';
  sRegAutoEditorSort           = 'Setøídit';

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
  SScrollBarRange = 'Hodnota šoupátka je mimo rozsah';
{$ENDIF}

 {RADlg}
  SCancel = 'Zrušit';

 { Menu Designer }
  SMDMenuDesigner       = 'Menu &Designer';
  SMDInsertItem         = '&Vložit';
  SMDDeleteItem         = '&Smazat';
  SMDCreateSubmenuItem  = 'Vytvoøit &SubMenu';

  SCantGetShortCut      = 'Nemohu zjistit vazbu na soubor %s';


 { RALib 1.23 } 
  SPropertyNotExists    = 'Property "%s" does not exists';
  SInvalidPropertyType  = 'Property "%s" has invalid type';

implementation

end.
