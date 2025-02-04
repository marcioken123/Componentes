{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       description : R&A implemetation of
                     Delphi design-time packages

       programer   : Jaromir Solar
       e-mail      : jarda@foresta.cz
************************************************************}

{$INCLUDE RA.INC}

unit packconst;

interface

const
  SOK               = 'OK';
  SCancel           = 'Zrušit';

 { Dataset Editor }
  SDEDatasetDesigner = '&Editor polí...';

  SDEAddItem          = '&Pøidat položku...';
  SDEDeleteItem       = '&Smazat';
  SDESelectAllItem    = '&Vybrat vše';
  SDENewItem          = '&Nová položka...';

  SDEAddFieldsCaption = 'Pøidat pole';
  SDEAvailableFields  = 'Dostupná pole';

  SDENewFieldCaption    = 'Nové pole';
  SDEFieldProperties    = 'Vlastnosti pole';
  SDEFieldNameLabel     = '&Jméno:';
  SDEFieldTypeLabel     = '&Typ:';
  SDEComponentNameLabel = 'K&omponenta:';
  SDEFieldSizeLabel     = '&Velikost:';
  SDEFieldKind          = 'Typ pole';
  SDELookupGroup        = 'Definice &náhledu';
  SDEKeyFieldsLabel     = '&Klíèová pole:';
  SDEDatasetLabel       = 'D&ataset:';
  SDELookupKeysLabel    = 'Klíè náhledu:';
  SDEResultFieldLabel   = '&Výsledné pole:';
  SDEFieldKindItems     = '&Data'#13'&Dopoèítávat'#13'&Náhled';
  SDEFieldTypeMustBeSpecified = 'Typ pole musí být specifikován';

  SDBGridColEditor    = 'Editor &sloupcù...';

 { Collection Editor }
  SCEEditCollection     = 'Editace %s';
  SCEAdd                = '&Pøidat';
  SCEDelete             = '&Smazat';
  SCEMoveUp             = 'Pøesun &nahoru';
  SCEMoveDown           = 'Pøesun &dolù';
  SCESelectAllItem      = '&Vybrat vše';

 { Picture Editor }
  SPELoad               = '&Naètení...';
  SPESave               = '&Uložení...';
  SPEClear              = '&Smazání';
  SPECopy               = 'K&opírovat';
  SPEPaste              = '&Vložit';

 { Menu Designer }
  SMDMenuDesigner       = 'Menu &Designer';
  SMDInsertItem         = '&Vložit';
  SMDDeleteItem         = '&Smazat';
  SMDCreateSubmenuItem  = 'Vytvoøit &podmenu';

implementation

end.
