unit LMD_RegDocking;
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

_LMD_RegDocking unit (YB)
------------------------
Registration unit for LMD DockingPack.

Changes
-------
Release 4.0 (January 2009)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, DesignIntf, DesignEditors, TreeIntf, ImgList, LMDDckClass,
  LMDDckCst, LMDDckSite, LMDDckStyles, pLMDDckPE, LMDDckAlphaImages, ExtCtrls,
  Forms;

procedure Register;

implementation

{ ---------------------------------------------------------------------------- }
procedure Register;
begin
  RegisterClassAlias(TLMDDockManager, 'TLMDDockPersister'); // Should be before
                                                            // components
                                                            // registration in
                                                            // old IDE versions.


  GroupDescendentsWith(TLMDDockSite, TWinControl);
  RegisterComponents('LMD Docking', [TLMDDockSite, TLMDDockManager, TLMDAlphaImageList]);
  RegisterNoIcon([TLMDDockPanel]); // Disables Cut/Copy IDE menu items, like
                                   // with TTabSheet, TAction, TMenuItem, ect.
                                   // Also panels will be shown as "hidden" in
                                   // IDE's Object-TreeView.
  RegisterClass(TLMDDockPanel);

  RegisterComponentEditor(TLMDDockSite, TLMDDockSiteCompEditor);
  RegisterComponentEditor(TLMDDockPanel, TLMDDockSiteCompEditor);

  RegisterPropertyEditor(TypeInfo(TImageIndex), TLMDDockPanel,
                         'ImageIndex', TLMDDockImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TLMDStyleName), nil, '',
                         TLMDDockStyleNameProperty);

  (*!!!RegisterPropertyEditor(TypeInfo(TImageIndex), TLMDDockPanelHeaderStyle,
                         'MenuImageIndex', TLMDHeaderButtonImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TLMDDockPanelHeaderStyle,
                         'PinImageIndex', TLMDHeaderButtonImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TLMDDockPanelHeaderStyle,
                         'UnpinImageIndex', TLMDHeaderButtonImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(TImageIndex), TLMDDockPanelHeaderStyle,
                         'CloseImageIndex', TLMDHeaderButtonImageIndexProperty);*)

  RegisterSprigType(TLMDDockPanel, TLMDDockPanelSprig);

  {$IFDEF LMDCOMP9}
  TLMDNewDockPanelItem.Register('LMD Docking');
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }

initialization
  // Do nothing.

finalization
  {$IFDEF LMDCOMP9}
  TLMDNewDockPanelItem.Unregister;
  {$ENDIF}

end.


