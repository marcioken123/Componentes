{***********************************************************
                R&A Library
       Copyright (C) 1996-99 R&A

       description : Language specific constant for French
French translation : KNIPPER John (knipjo@altavista.net)

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib.htm
************************************************************}

{$INCLUDE RA.INC}

unit RAConst;

interface

const

 {TRADBTreeView}
  SDeleteNode             = 'Effacer %s ?';
  SDeleteNode2            = 'Effacer %s (avec tous les fils) ?';
  SMasterFieldEmpty       = 'La propri�t� "MasterField" doit �tre renseign�';
  SDetailFieldEmpty       = 'La propri�t� "DetailField" doit �tre renseign�';
  SItemFieldEmpty         = 'La propri�t� "ItemField" doit �tre renseign�';
  SMasterDetailFieldError = '"MasterField" et "DetailField" doivent �tre du m�me type';
  SMasterFieldError       = '"MasterField" doit �tre un entier';
  SDetailFieldError       = '"DetailField" doit �tre un entier';
  SItemFieldError         = '"ItemField" doit �tre une cha�ne, une date ou un entier';
  SIconFieldError         = '"IconField" doit �tre un entier';
  SMoveToModeError        = 'Mode de d�placement invalide pour un RADBTreeNode';
  SDataSetNotActive       = 'Ensemble de donn�es inactif';

 {RegAutoEditor}
  sRegAutoEditorEdtPropHint    = 'Saisissez le type de la propri�t�';
  sRegAutoEditorTreeHint       = 'Propri�t� disponible';
  sRegAutoEditorListHint       = 'Propri�t� stock�es';
  sRegAutoEditorBtnAddPropHint = 'Ajouter/supprimer une propri�t�';
  sRegAutoEditorSort           = 'Trier';

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
  SScrollBarRange = 'Indice de barre de d�filement hors limite';
{$ENDIF}

 {RADlg}
  SCancel = 'Annul�';

 { Menu Designer }
  SMDMenuDesigner       = 'Editeur &de menu';
  SMDInsertItem         = '&Ins�rer';
  SMDDeleteItem         = '&Supprimer';
  SMDCreateSubmenuItem  = 'Cr�er un &Sous-Menu';

  SCantGetShortCut      = 'Fichier cible du raccourci %s non disponible';

implementation

end.
