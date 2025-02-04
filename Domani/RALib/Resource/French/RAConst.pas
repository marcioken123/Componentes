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
  SMasterFieldEmpty       = 'La propriété "MasterField" doit être renseigné';
  SDetailFieldEmpty       = 'La propriété "DetailField" doit être renseigné';
  SItemFieldEmpty         = 'La propriété "ItemField" doit être renseigné';
  SMasterDetailFieldError = '"MasterField" et "DetailField" doivent être du même type';
  SMasterFieldError       = '"MasterField" doit être un entier';
  SDetailFieldError       = '"DetailField" doit être un entier';
  SItemFieldError         = '"ItemField" doit être une chaîne, une date ou un entier';
  SIconFieldError         = '"IconField" doit être un entier';
  SMoveToModeError        = 'Mode de déplacement invalide pour un RADBTreeNode';
  SDataSetNotActive       = 'Ensemble de données inactif';

 {RegAutoEditor}
  sRegAutoEditorEdtPropHint    = 'Saisissez le type de la propriété';
  sRegAutoEditorTreeHint       = 'Propriété disponible';
  sRegAutoEditorListHint       = 'Propriété stockées';
  sRegAutoEditorBtnAddPropHint = 'Ajouter/supprimer une propriété';
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
  SScrollBarRange = 'Indice de barre de défilement hors limite';
{$ENDIF}

 {RADlg}
  SCancel = 'Annulé';

 { Menu Designer }
  SMDMenuDesigner       = 'Editeur &de menu';
  SMDInsertItem         = '&Insérer';
  SMDDeleteItem         = '&Supprimer';
  SMDCreateSubmenuItem  = 'Créer un &Sous-Menu';

  SCantGetShortCut      = 'Fichier cible du raccourci %s non disponible';

implementation

end.
