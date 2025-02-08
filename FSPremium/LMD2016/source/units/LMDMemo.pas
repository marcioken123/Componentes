unit LMDMemo;
{$I lmdcmps.Inc}

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

LMDMemo unit ()
---------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDBaseEdit, LMDCustomMemo;

type
  TLMDMemo = class(TLMDCustomMemo)
  protected
  public
    // readonly
    property Column;
    property Row;
  published
    property About;
    property Align;
    property Alignment;
    property AskForLoop;
    property Bevel;
//    property BevelOnMouseAbove;
    property Caret;
    property Color;
    property Cursor;
    property DragCursor;
    property DraggingAllowed;
    property DragMode;
    property Enabled;
    property Flat;
    property FocusOnMouseAbove;
    property Font;
    property Font3D;
    property Height;
    property HelpContext;
    property HideSelection;
    property HighlightBack;
    property HighlightText;
    property Hint;
    property IgnoreLastEmptyLine;
    property ImageIndex;
    property ImageList;
    property ImeMode;
    property ImeName;
    property Left;
    property Lined;
    property Lines;
    property LineGap;
    property LineStyle;
    property ListIndex;
    property Margin;
    property Name;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
//    property Tabs;
    property TabChars;
    property Tag;
    property Text;
    property Top;
    property Transparent;
    property Visible;
    property WantReturns;
    property WantTabs;
    property Width;
    property WordWrap;
    property HorizScrollBar;
    property VertScrollBar;

    property OnAfterEnter;
    property OnAfterExit;
    property OnChange;
    property OnClick;
    property OnCurrentRowChanged;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMarginRowPaint;
    property OnModified;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnRowCountChanged;
    property OnStartDrag;
    property OnTextChangedAt;
    property OnCursorPosChanged;
  end;

  TLMDLabeledMemo = class(TLMDMemo)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation
{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
