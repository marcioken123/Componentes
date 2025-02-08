unit LMDIdeCst;

{###############################################################################

LMDIdeCst unit (YB)
-------------------
Contains resource strings needed in LMD IDE-Tools pack.

Changes
-------

###############################################################################}

interface

resourcestring
  { Component palette }
  
  SLMDCompClassAlradyRegistered = 'Класс компонента %s уже зарегистрирован.';
  SLMDStdPage                   = 'Стандартные';

  { Sprigs }

  SLMDUnnamedComponent = '<Компонент[%d]>';

  { Project manager }

  SLMDProjNodeClassHasNoIdent    = 'Идентификатор для класса %s не установлен.';
  SLMDProjNodeClassNotRegistered = 'Идентификатор класса узла ''%s'' не ' +
                                   'зарегистрирован.';
  SLMDProjNodeDefaultDisplayName = '<Безымянный>';
  SLMDNoOpenedDocFound           = 'No TLMDOpenedDocument found on the ' +
                                   'specified editor frame.';


  { Aling palette }

  SLMDAlignPaletteCaption = 'Выравнивание';

  SLMDAlignLeftHint = 'Выровнять по левой границе';
  SLMDAlignHCenterHint = 'Выровнять середины по горизонтали';
  SLMDAlignHCenterInWindowHint = 'Центрировать в окне, горизонтально';
  SLMDAlignHSpaceEqHint = 'Разместить равноудаленно, горизонтально';
  SLMDAlignRightHint = 'Выровнять по правой границе';
  SLMDAlignTopHint = 'Выровнять по верхней границе';
  SLMDAlignVCenterHint = 'Выровнять середины по вертикали';
  SLMDAlignVCenterInWindowHint = 'Центрировать в окне, вертикально';
  SLMDAlignVSpaceEqHint = 'Разместить равноудаленно, вертикально';
  SLMDAlignBottomHint = 'Выровнять по нижней границе';

  { Tab order dialog }

  SLMDTabOrderDlgCaption     = 'Порядок обхода (Tab Order)';
  SLMDTabOrderDlgListCaption = 'Компоненты перечислены в порядке обхода:';
  SLMDTabOrderDlgNone        = '(Нет элементов)';
  SLMDTabOrderDlgOk          = 'Ок';
  SLMDTabOrderDlgCancel      = 'Отмена';

  { Creation order dialog }

  SLMDCreationOrderDlgCaption     = 'Порядок создания';
  SLMDCreationOrderDlgListCaption = 'Порядок создания невизуальных компонентов:';
  SLMDCreationOrderDlgNone        = '(Нет элементов)';
  SLMDCreationOrderDlgOk          = 'Ок';
  SLMDCreationOrderDlgCancel      = 'Отмена';

  { Actions }

  SLMDActnAlignToGrid = 'Align to grid';
  SLMDActnAlignLeft = 'Align left edges';
  SLMDActnAlignRight = 'Align right edges';
  SLMDActnAlignHSpaceEqually = 'Space equally, horizontally';
  SLMDActnAlignHCenter = 'Align horizontal centers';
  SLMDActnAlignHCenterInWindow = 'Center horizontally in window';
  SLMDActnAlignTop = 'Align tops';
  SLMDActnAlignBottom = 'Align bottoms';
  SLMDActnAlignVSpaceEqually = 'Space equally, vertically';
  SLMDActnAlignVCenter = 'Align vertical centers';
  SLMDActnAlignVCenterInWindow = 'Center vertically in window';
  SLMDActnDsgCut = 'Cut';
  SLMDActnDsgCopy = 'Copy';
  SLMDActnDsgPaste = 'Paste';
  SLMDActnDsgSelectAll = 'Select all';
  SLMDActnDsgDelSelected = 'Delete selected';
  SLMDActnDsgClearLocks = 'Clear locks';
  SLMDActnDsgLockSelected = 'Lock selection';
  SLMDActnDsgBringToFront = 'Bring to front';
  SLMDActnDsgSendToBack = 'Send to back';
  SLMDActnDsgTabOrderDlg = 'Tab order...';
  SLMDActnDsgCreationOrderDlg = 'Creation order...';

  { Debug controls }

  SLMDProcessNotAccessible = 'Процесс недоступен';

implementation

end.
