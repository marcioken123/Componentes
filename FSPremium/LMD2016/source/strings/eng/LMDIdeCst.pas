unit LMDIdeCst;
{$I LMDCmps.inc}

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
  
  SLMDCompClassAlradyRegistered = 'Component class %s already registered.';
  SLMDStdPage                   = 'Standard';

  { Sprigs }

  SLMDUnnamedComponent = '<Components[%d]>';

  { Project manager }

  SLMDProjNodeClassHasNoIdent    = 'Ident for class %s is not set.';
  SLMDProjNodeClassNotRegistered = 'Node class with ''%s'' ident is ' +
                                   'not registered.';
  SLMDProjNodeDefaultDisplayName = '<Unnamed>';
  SLMDNoOpenedDocFound           = 'No TLMDOpenedDocument found on the ' +
                                   'specified editor frame.';

  { Aling palette }

  SLMDAlignPaletteCaption = 'Align';

  SLMDAlignLeftHint = 'Align left edges';
  SLMDAlignHCenterHint = 'Align horizontal centers';
  SLMDAlignHCenterInWindowHint = 'Center horizontally in window';
  SLMDAlignHSpaceEqHint = 'Space equally, horizontally';
  SLMDAlignRightHint = 'Align right edges';
  SLMDAlignTopHint = 'Align tops';
  SLMDAlignVCenterHint = 'Align vertical centers';
  SLMDAlignVCenterInWindowHint = 'Center vertically in window';
  SLMDAlignVSpaceEqHint = 'Space equally, vertically';
  SLMDAlignBottomHint = 'Align bottoms';

  { Tab order dialog }

  SLMDTabOrderDlgCaption     = 'Edit Tab Order';
  SLMDTabOrderDlgListCaption = 'Controls listed in tab order:';
  SLMDTabOrderDlgNone        = '(None)';
  SLMDTabOrderDlgOk          = 'Ok';
  SLMDTabOrderDlgCancel      = 'Cancel';

  { Creation order dialog }

  SLMDCreationOrderDlgCaption     = 'Edit Creation Order';
  SLMDCreationOrderDlgListCaption = 'Creation order of non-visual components:';
  SLMDCreationOrderDlgNone        = '(None)';
  SLMDCreationOrderDlgOk          = 'Ok';
  SLMDCreationOrderDlgCancel      = 'Cancel';

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

  SLMDProcessNotAccessible = 'Process is not accessible';

implementation

end.
