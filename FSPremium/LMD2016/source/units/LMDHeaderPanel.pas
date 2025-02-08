unit LMDHeaderPanel;
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

LMDHeaderPanel unit (JH)
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDCustomHeaderPanel;

type
  TLMDHeaderPanel = class(TLMDCustomHeaderPanel)
  public
    property CtlXP;  // compatibility
  published
    property About;
    property AllowMoving;
    property AllowSizing;
    property BackFX;
    property Bevel;
    property FillObject;
    property Caption;
    property HeaderHeight;
    property Font;
    property HeaderDropMenu;
    property HeaderOptions;
    property SysButtonMode;
    property ImageIndex;
    property ImageList;
    property ButtonStyle;
    property ThemeMode;
    property ThemeGlobalMode;    
    property Transparent;
///    property HeaderTransparent;

    //8.0
    property ParentBackground default false;
    property Align;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
//    property FullRepaint;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;

    property Anchors;
    property BiDiMode;
    property Constraints;
    property DockSite;
    property DragKind;
    property ParentBiDiMode;
    property UseDockManager default false;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property OnOpen;
    property OnOpenFixed;    
    property OnClose;
    property OnHeaderButtonClick;
    property OnSystemButtonClick;

    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}

  end;

implementation

end.
