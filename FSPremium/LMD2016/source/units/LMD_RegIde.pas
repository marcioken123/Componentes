unit LMD_RegIde;
{$I lmdcmps.inc}

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

_LMD_RegIde unit (YB)
------------------------
Registration unit for LMD IDE-Tools pack.

Changes
-------

###############################################################################}

interface

uses
  DesignIntf, Classes, Controls, StdCtrls, {$IFDEF LMDCOMP17}Actions,{$ENDIF}
  ActnList, ImgList, LMDSvcPvdr, LMDIdeManager, LMDIdeCompPltte, LMDIdeCompBar,
  LMDIdeAlignPltte, LMDIdeObjEdrMgr, LMDIdeCompTree, LMDIdeProjMgr, LMDIdeActns,
  LMDIdeDebugCtrls, pLMDIdePE;

procedure Register;

implementation

{ ---------------------------------------------------------------------------- }

procedure Register;
begin
  LMDSvcPvdr._RegisterOnce;
  RegisterComponents('LMD IDE-Tools', [TLMDIdeManager,
                                       TLMDProjectManager,
                                       TLMDProjectManagerView,
                                       TLMDOpenedDocument,
                                       TLMDDocEditorsView,
                                       TLMDComponentTree,
                                       TLMDComponentPalette,
                                       TLMDComponentBar,
                                       TLMDObjectEditorManager,
                                       TLMDAlignPalette,
                                       TLMDDebuggerSource,
                                       TLMDCallStackView,
                                       TLMDCallStackComboBox,
                                       TLMDVariablesView,
                                       TLMDWatchView,
                                       TLMDEventLogView,
                                       TLMDBreakpointsView]);

  RegisterPropertyEditor(TypeInfo(TImageIndex), TLMDCallStackView,
                         'ItemImageIndex', TLMDIdeImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TLMDCallStackView,
                         'TopImageIndex', TLMDIdeImageIndexProperty);

  RegisterActions('LMDDesigner', [TLMDAlignToGrid,
                                  TLMDAlignLeft,
                                  TLMDAlignRight,
                                  TLMDAlignHSpaceEqually,
                                  TLMDAlignHCenter,
                                  TLMDAlignHCenterInWindow,
                                  TLMDAlignTop,
                                  TLMDAlignBottom,
                                  TLMDAlignVSpaceEqually,
                                  TLMDAlignVCenter,
                                  TLMDAlignVCenterInWindow,
                                  TLMDDsgCut,
                                  TLMDDsgCopy,
                                  TLMDDsgPaste,
                                  TLMDDsgSelectAll,
                                  TLMDDsgDelSelected,
                                  TLMDDsgClearLocks,
                                  TLMDDsgLockSelected,
                                  TLMDDsgBringToFront,
                                  TLMDDsgSendToBack,
                                  TLMDDsgTabOrderDlg,
                                  TLMDDsgCreationOrderDlg],
                  nil);
end;

{ ---------------------------------------------------------------------------- }

end.


