unit LMDIdeCst;
{$I LMDCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

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
