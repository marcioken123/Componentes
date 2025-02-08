unit LMDStatusBar;
{$I lmdcmps.INC}

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

LMDStatusBar unit (JH)
----------------------

extended status bar control

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDCustomStatusBar;

type

  { ----------------------------- TLMDStatusBar ------------------------------ }
  TLMDStatusBar = class(TLMDCustomStatusBar)
  public
    property CtlXP; // compatibility
  published
    property Alignment;
    property Font3D;
    property SimpleText;
    property SimplePanel;
    property SizeGrip;
    property OldStyle;
    property AutoSizeLastPanel;
    property ControlGap;
    property Panels;
    property OnOwnerDrawPanel;
    property OnPanelClick;
    //Validation support, May 2006, RS
    property ValidationPanelNumber;
    property Bevel;
    property Align;
    property Color;
    property Cursor;
    property DragMode;
    property DragCursor;
    property Font;
    property Height;
    property HelpContext;
    property Hint;
    property Left;
    property ParentColor;
    property ParentFont;
    property PopupMenu;
    property ShowHint;
    property ThemeMode;
    property ThemeGlobalMode;    
    property Top;
    property Visible;
    property Width;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;

    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

end.
