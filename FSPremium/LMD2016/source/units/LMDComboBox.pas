unit LMDComboBox;
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

LMDComboBox unit ()
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, LMDCustomComboBox;

type
  TLMDComboBox = class(TLMDCustomComboBox)
  public
    property CtlXP; // compatibility
  published
    property About;
    property Color;
    property Ctl3D;
    property Cursor;
    property DragCursor;
    property DragMode;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Flat;
    property FocusControl;
    property Font;
    property Height;
    property HelpContext;
    property Hint;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property Items;
    property Interval;
    property Left;
    property MaxLength;
    property MRUList;
    property MRUMax;
    property Name;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property ParentThemeMode default true;
    property PopupMenu;
    property Search;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property Tag;
    property Text;
    property ThemeMode;  // 9.0
    property ThemeGlobalMode;
    property Top;
    property UseGlobalTimer;
    property Visible;
    property Width;

    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnCloseUp;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEditClick;
    property OnEndDrag;

    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnSelect;
    property OnStartDrag;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

  TLMDLabeledComboBox = class(TLMDComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ItemIndex;
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

{ TLMDLabeledComboBox }

constructor TLMDLabeledComboBox.Create(AOwner: TComponent);
begin
  inherited;
  HasBoundLabel := True;
end;

end.
