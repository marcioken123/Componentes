{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       description : R&A implemetation of
                     Delphi design-time packages

       programer   : black
       e-mail      : blacknbs@chat.ru
       www         : www.chat.ru\~blacknbs\ralib
French translation : KNIPPER John (knipjo@altavista.net)
************************************************************}

{$INCLUDE RA.INC}

unit packconst;

interface

const
  SOK               = 'OK';
  SCancel           = 'Annuler';

 { Dataset Editor }
  SDEDatasetDesigner = 'Editeur de &champs...';

  SDEAddItem          = '&Ajouter des champs...';
  SDEDeleteItem       = '&Supprimer';
  SDESelectAllItem    = 'Tous s�&lectionner';
  SDENewItem          = '&Nouveau champ...';

  SDEAddFieldsCaption = 'Ajouter des champs';
  SDEAvailableFields  = 'Champs disponible';

  SDENewFieldCaption    = 'Nouveau champ';
  SDEFieldProperties    = 'Propri�t�s du champs';
  SDEFieldNameLabel     = '&Nom:';
  SDEFieldTypeLabel     = '&Type:';
  SDEComponentNameLabel = 'C&omposant:';
  SDEFieldSizeLabel     = 'Ta&ille:';
  SDEFieldKind          = 'Type du champ';
  SDELookupGroup        = 'Lookup definition';
  SDEKeyFieldsLabel     = 'Champs Cl�s:';
  SDEDatasetLabel       = 'D&ataset:';
  SDELookupKeysLabel    = 'Look&up Keys:';
  SDEResultFieldLabel   = 'Champ r�sultat:';
  SDEFieldKindItems     = '&Donn�es'#13'&Calcul�'#13'&Lookup';
  SDEFieldTypeMustBeSpecified = 'Le type du champs doit �tre sp�cifi�';

  SDBGridColEditor    = 'Editeur de colonnes...';

 { Collection Editor }
  SCEEditCollection     = 'Edition de %s';
  SCEAdd                = '&Ajouter';
  SCEDelete             = 'Effacer';
  SCEMoveUp             = 'Monter';
  SCEMoveDown           = 'Descendre';
  SCESelectAllItem      = 'Tous s�&lectionner';

 { Picture Editor }
  SPELoad               = '&Charger...';
  SPESave               = '&Sauvegarder...';
  SPEClear              = '&Effacer';
  SPECopy               = 'C&opier';
  SPEPaste              = 'Coller';

 { Menu Designer }
  SMDMenuDesigner       = 'Editeur &de menu';
  SMDInsertItem         = '&Ins�rer';
  SMDDeleteItem         = '&Effacer';
  SMDCreateSubmenuItem  = 'Cr�er un &sous-menu';

implementation

end.
