{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       description : R&A implemetation of
                     Delphi design-time packages

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit packconst;

interface
                                   
const
  SOK               = 'OK';
  SCancel           = '������';

 { Dataset Editor }
  SDEDatasetDesigner = '&�������� �����...';

  SDEAddItem          = '&�������� ����...';
  SDEDeleteItem       = '&�������';
  SDESelectAllItem    = '&�������� ���';
  SDENewItem          = '&����� ����...';

  SDEAddFieldsCaption = '���������� �����';
  SDEAvailableFields  = '��������� ����';

  SDENewFieldCaption    = '����� ����';
  SDEFieldProperties    = ' �������� ���� ';
  SDEFieldNameLabel     = '&���:';
  SDEFieldTypeLabel     = '&���:';
  SDEComponentNameLabel = '&���������:';
  SDEFieldSizeLabel     = '&������:';
  SDEFieldKind          = ' ��� ���� ';
  SDELookupGroup        = ' ��������� ���� ';
  SDEKeyFieldsLabel     = '&Key Fields:';
  SDEDatasetLabel       = 'D&ataset:';
  SDELookupKeysLabel    = 'Look&up Keys:';
  SDEResultFieldLabel   = '&Result Field:';
  SDEFieldKindItems     = '&������'#13'&�����������'#13'&���������';
  SDEFieldTypeMustBeSpecified = '��� ���� ������ ���� ������';

  SDBGridColEditor    = '&�������� �������...';

 { Collection Editor }
  SCEEditCollection     = '����������� %s';
  SCEAdd                = '&��������';
  SCEDelete             = '&�������';
  SCEMoveUp             = '�&����';
  SCEMoveDown           = '�&���';
  SCESelectAllItem      = '�������� ��&�';

 { Picture Editor }
  SPELoad               = '&���������...';
  SPESave               = '&���������...';
  SPEClear              = '&��������';
  SPECopy               = '&����������';
  SPEPaste              = '&��������';

 { Menu Designer }
  SMDMenuDesigner       = '&�������� ����';
  SMDInsertItem         = '&��������';
  SMDDeleteItem         = '&�������';
  SMDCreateSubmenuItem  = '������� &�������';

implementation

end.
