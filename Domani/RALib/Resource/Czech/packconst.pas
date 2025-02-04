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
  SCancel           = 'Zru�it';

 { Dataset Editor }
  SDEDatasetDesigner = '&Editor pol�...';

  SDEAddItem          = '&P�idat polo�ku...';
  SDEDeleteItem       = '&Smazat';
  SDESelectAllItem    = '&Vybrat v�e';
  SDENewItem          = '&Nov� polo�ka...';

  SDEAddFieldsCaption = 'P�idat pole';
  SDEAvailableFields  = 'Dostupn� pole';

  SDENewFieldCaption    = 'Nov� pole';
  SDEFieldProperties    = 'Vlastnosti pole';
  SDEFieldNameLabel     = '&Jm�no:';
  SDEFieldTypeLabel     = '&Typ:';
  SDEComponentNameLabel = 'K&omponenta:';
  SDEFieldSizeLabel     = '&Velikost:';
  SDEFieldKind          = 'Typ pole';
  SDELookupGroup        = 'Definice &n�hledu';
  SDEKeyFieldsLabel     = '&Kl��ov� pole:';
  SDEDatasetLabel       = 'D&ataset:';
  SDELookupKeysLabel    = 'Kl�� n�hledu:';
  SDEResultFieldLabel   = '&V�sledn� pole:';
  SDEFieldKindItems     = '&Data'#13'&Dopo��t�vat'#13'&N�hled';
  SDEFieldTypeMustBeSpecified = 'Typ pole mus� b�t specifikov�n';

  SDBGridColEditor    = 'Editor &sloupc�...';

 { Collection Editor }
  SCEEditCollection     = 'Editace %s';
  SCEAdd                = '&P�idat';
  SCEDelete             = '&Smazat';
  SCEMoveUp             = 'P�esun &nahoru';
  SCEMoveDown           = 'P�esun &dol�';
  SCESelectAllItem      = '&Vybrat v�e';

 { Picture Editor }
  SPELoad               = '&Na�ten�...';
  SPESave               = '&Ulo�en�...';
  SPEClear              = '&Smaz�n�';
  SPECopy               = 'K&op�rovat';
  SPEPaste              = '&Vlo�it';

 { Menu Designer }
  SMDMenuDesigner       = 'Menu &Designer';
  SMDInsertItem         = '&Vlo�it';
  SMDDeleteItem         = '&Smazat';
  SMDCreateSubmenuItem  = 'Vytvo�it &podmenu';

implementation

end.
