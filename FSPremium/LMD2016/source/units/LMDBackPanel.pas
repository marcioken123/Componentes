unit LMDBackPanel;
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

LMDBackPanel unit ()
--------------------

Special panel class which can be used as parent component for the transparency effect.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Messages,
  LMDCustomParentPanel, LMDGraph;

type
  {--------------------- TLMDBackPanel ---------------------------------------}
  TLMDBackPanel = class(TLMDCustomParentPanel)
  private
  public
    constructor Create(AOwner: TComponent); override;
    property DockManager;
  published
    property ParentBackground default false;
    // 7.01
    property NoHandleUpdate;
    // 7.0
    property FDSupport;
    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property About;
    property Align;
//    property BackFX;
    property Bevel;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property Locked;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property QuickDraw;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}    
  end;

implementation
{----------------------- public -----------------------------------------------}
constructor TLMDBackPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //ControlStyle:=ControlStyle + [csOpaque]-[csParentBackground];
  ControlStyle:=ControlStyle + [csOpaque]{$IFDEF LMDCOMP7}-[csParentBackground]{$ENDIF};
  {$IFNDEF LMDCOMP7}
  BeginUpdate; 
  ParentBackground := false; 
  EndUpdate;
  {$ENDIF}
end;

end.
