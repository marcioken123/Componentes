unit LMDSysTreeView;
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

LMDSysTreeView unit (RM)
-----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, ComCtrls, Classes, Controls,
  LMDSysBase,  LMDControl, LMDTypes;

type

  TLMDSysTreeView = class(TLMDBaseTreeView)
  public
   constructor Create(AOwner: TComponent); override;
    function getLMDPackage:TLMDPackageID;override;
  published
    property About;

    // default properties
    property Align;
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Constraints;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    //property Images;
    property Indent;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RightClickSelect;
    property RowSelect;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property TabOrder;
    property TabStop default True;
    property ToolTips;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnCompare;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

implementation
{ ****************************** TLMDSysTreeView ***************************** }
{ ------------------------------- public ------------------------------------- }
constructor TLMDSysTreeView.Create(AOwner: TComponent);
begin
  inherited;
  DragMode := dmManual;
  ReadOnly := True;
  ShowHint := True;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysTreeView.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_SYS;
end;

end.
