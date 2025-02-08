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
  
  SLMDCompClassAlradyRegistered = '����� ���������� %s ��� ���������������.';
  SLMDStdPage                   = '�����������';

  { Sprigs }

  SLMDUnnamedComponent = '<���������[%d]>';

  { Project manager }

  SLMDProjNodeClassHasNoIdent    = '������������� ��� ������ %s �� ����������.';
  SLMDProjNodeClassNotRegistered = '������������� ������ ���� ''%s'' �� ' +
                                   '���������������.';
  SLMDProjNodeDefaultDisplayName = '<����������>';
  SLMDNoOpenedDocFound           = 'No TLMDOpenedDocument found on the ' +
                                   'specified editor frame.';


  { Aling palette }

  SLMDAlignPaletteCaption = '������������';

  SLMDAlignLeftHint = '��������� �� ����� �������';
  SLMDAlignHCenterHint = '��������� �������� �� �����������';
  SLMDAlignHCenterInWindowHint = '������������ � ����, �������������';
  SLMDAlignHSpaceEqHint = '���������� �������������, �������������';
  SLMDAlignRightHint = '��������� �� ������ �������';
  SLMDAlignTopHint = '��������� �� ������� �������';
  SLMDAlignVCenterHint = '��������� �������� �� ���������';
  SLMDAlignVCenterInWindowHint = '������������ � ����, �����������';
  SLMDAlignVSpaceEqHint = '���������� �������������, �����������';
  SLMDAlignBottomHint = '��������� �� ������ �������';

  { Tab order dialog }

  SLMDTabOrderDlgCaption     = '������� ������ (Tab Order)';
  SLMDTabOrderDlgListCaption = '���������� ����������� � ������� ������:';
  SLMDTabOrderDlgNone        = '(��� ���������)';
  SLMDTabOrderDlgOk          = '��';
  SLMDTabOrderDlgCancel      = '������';

  { Creation order dialog }

  SLMDCreationOrderDlgCaption     = '������� ��������';
  SLMDCreationOrderDlgListCaption = '������� �������� ������������ �����������:';
  SLMDCreationOrderDlgNone        = '(��� ���������)';
  SLMDCreationOrderDlgOk          = '��';
  SLMDCreationOrderDlgCancel      = '������';

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

  SLMDProcessNotAccessible = '������� ����������';

implementation

end.
