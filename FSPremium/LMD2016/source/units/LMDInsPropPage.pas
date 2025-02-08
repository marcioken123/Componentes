unit LMDInsPropPage;
{$I LmdCmps.inc}

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

LMDInsPropPage unit (YB)
------------------------
TLMDPropsPage unit

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Grids, Windows, Graphics, GraphUtil, Messages, Forms,
  StdCtrls, SysUtils, Clipbrd, Dialogs, Themes, Math, LMDUnicode,
  LMDUnicodeControl, LMDTypes, intfLMDBase, LMDInsClass, LMDInsCst;

type
  ELMDPropsPage       = class(Exception);
  TLMDCustomPropsPage = class;
  TLMDPropsPageItems  = class;

  { ********************** TLMDPropsPageInplaceEdit ************************** }

  TLMDPropsPageInplaceEdit = class(TLMDGridBaseInplaceEditList)
  private
    FChangingBounds: Boolean;
    FReadOnlyStyle:  Boolean;

    procedure WMLButtonDblClk(var Message: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure PickListMeasureItem(Control: TWinControl; Index: Integer;
                                  var Height: Integer);
    procedure PickListDrawItem(Control: TWinControl; Index: Integer;
                               Rect: TRect; State: TOwnerDrawState);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DropDown; override;
    procedure UpdateContents; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoEditButtonClick; override;
    procedure DoGetPickListItems; override;
    procedure CloseUp(Accept: Boolean); override;
    procedure DblClick; override;
    procedure BoundsChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    property    ReadOnlyStyle: Boolean read FReadOnlyStyle;
  end;

  TLMDPropsPageItemExpandable = (ieAuto, ieYes, ieNo);

  { ************************* TLMDPropsPageItem ****************************** }

  TLMDPropsPageItem = class(TLMDObjectList)
  private
    FParent           : TLMDPropsPageItem;
    FOwner            : TLMDCustomPropsPage;
    FExpandable       : TLMDPropsPageItemExpandable;
    FCaption          : TLMDString;
    FExpanded         : Boolean;
    FDisplayValue     : TLMDString;
    FEditStyle        : TLMDEditStyle;
    FRow              : Integer;
    FReadOnly         : Boolean;
    FAutoUpdate       : Boolean;
    FOwnerDrawPickList: Boolean;
    FIsCategory       : Boolean;
    FData             : TLMDDataTag;
    FHighlighted      : Boolean;
    function  CanExpand: Boolean;
    function  Ident: Integer;
    function  IsOnExpandButton(AX: Integer): Boolean;
    function  GetItems(AIndex: Integer): TLMDPropsPageItem;
    procedure SetExpandable(const Value: TLMDPropsPageItemExpandable);
    procedure SetCaption(const Value: TLMDString);
    function  GetLevel: Integer;
    procedure SetEditStyle(const Value: TLMDEditStyle);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetAutoUpdate(const Value: Boolean);
    procedure SetOwnerDrawPickList(const Value: Boolean);
    function  GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetIsCategory(const Value: Boolean);
    function  GetNonCategoryParent: TLMDPropsPageItem;
    function  GetParentCategory: TLMDPropsPageItem;
    procedure SetHighlighted(const Value: Boolean);
  protected
    function  CreateItem: TObject; override;
    procedure Change; override;
    procedure Deleted; override;
    function  GetDisplayValue: TLMDString; virtual;
    function  GetEditValue: TLMDString; virtual;
    procedure SetEditValue(const Value: TLMDString; AForce: Boolean); virtual;
    procedure EditButtonClick; dynamic;
    procedure EditDblClick; dynamic;
    procedure GetEditPickList(APickList: TLMDStrings); virtual;
    procedure PickListMeasureHeight(const AValue: TLMDString; ACanvas: TCanvas; var AHeight: Integer); virtual;
    procedure PickListMeasureWidth(const AValue: TLMDString; ACanvas: TCanvas; var AWidth: Integer); virtual;
    procedure PickListDrawValue(const AValue: TLMDString; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean); virtual;
  public
    constructor Create(AOwner: TLMDCustomPropsPage; AParent: TLMDPropsPageItem); virtual;
    destructor Destroy; override;

    function  Find(const ACaption: TLMDString): TLMDPropsPageItem;
    procedure Expand;
    procedure Collapse;
    function  DisplayRect(ACaption, AValue: Boolean): TRect;
    function  Index: Integer;
    function  IsFirst: Boolean;
    function  IsLast: Boolean;
    function  ShowEditor: Boolean;
    property  Owner: TLMDCustomPropsPage read FOwner;
    property  Parent: TLMDPropsPageItem read FParent;
    property  NonCategoryParent: TLMDPropsPageItem read GetNonCategoryParent;
    property  ParentCategory: TLMDPropsPageItem read GetParentCategory;
    property  Active: Boolean read GetActive write SetActive;
    property  Expandable: TLMDPropsPageItemExpandable read FExpandable write SetExpandable;
    property  Expanded: Boolean read FExpanded;
    property  Level: Integer read GetLevel;
    property  Caption: TLMDString read FCaption write SetCaption;
    property  DisplayValue: TLMDString read GetDisplayValue;
    property  EditStyle: TLMDEditStyle read FEditStyle write SetEditStyle;
    property  ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property  AutoUpdate: Boolean read FAutoUpdate write SetAutoUpdate;
    property  Highlighted: Boolean read FHighlighted write SetHighlighted;
    property  IsCategory: Boolean read FIsCategory write SetIsCategory;
    property  OwnerDrawPickList: Boolean read FOwnerDrawPickList write SetOwnerDrawPickList;
    property  Data: TLMDDataTag read FData write FData;
    property  Items[AIndex: Integer]: TLMDPropsPageItem read GetItems; default;
  end;

  { ************************* TLMDPropsPageItems ***************************** }

  TLMDPropsPageItems = class(TLMDObjectList)
  private
    FOwner: TLMDCustomPropsPage;

    function GetItems(AIndex: Integer): TLMDPropsPageItem;
  protected
    function  CreateItem: TObject; override;
    procedure Change; override;
  public
    constructor Create(AOwner: TLMDCustomPropsPage);

    function Find(const ACaption: TLMDString): TLMDPropsPageItem;
    property Owner: TLMDCustomPropsPage read FOwner;
    property Items[AIndex: Integer]: TLMDPropsPageItem read GetItems; default;
  end;

  TLMDRestoreItem = record
    Caption: TLMDString;
    Items:   Pointer; // PLMDRestoreItems.
  end;

  PLMDRestoreItems = ^TLMDRestoreItems;
  TLMDRestoreItems = array of TLMDRestoreItem;

  TLMDPropPageStateObject = class
  private
    FActiveItemInfo: TLMDRestoreItems; // TRestoreItem.Items field is not used.
    FExpandedInfo:   TLMDRestoreItems;
    
    procedure FreeExpandInfo(ARItems: PLMDRestoreItems);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TLMDPropsPageState = set of (ppsMovingSplitter, ppsScrollingByMouse,
    ppsChanged, ppsDestroying, ppsUpdatingEditorContent, ppsChangingActiveItem,
    ppsSettingAutoUpdateItemValue);
  TLMDPropsPageHitTest = (htOnItem, htOnExpandButton, htOnCaption, htOnValue, htOnSplitter);
  TLMDPropsPageHitTests = set of TLMDPropsPageHitTest;
  TLMDPropsPageItemEvent = procedure(Sender: TObject; AItem: TLMDPropsPageItem) of object;
  TLMDPropsPageSelectionStyle = (ssClassic, ssFlat);

  { ************************* TLMDCustomPropsPage **************************** }
  TLMDCustomPropsPage = class(TLMDGridBase, ILMDComponent)
  private
    FAbout             : TLMDAboutVar;
    FState             : TLMDPropsPageState;
    FOldRow            : Integer;
    FSplitterOffset    : Integer;
    FEditText          : TLMDString;
    FEditTextItem      : TLMDPropsPageItem;
    FItems             : TLMDPropsPageItems;
    FRows              : array of TLMDPropsPageItem;
    FUpdateCount       : Integer;
    FValuesColor       : TColor;
    FGridPattern       : Graphics.TBitmap;
    FGridPatternColor  : TColor;
    FGridPatternBkColor: TColor;
    FBrush             : HBRUSH;
    FCellBitmap        : Graphics.TBitmap;
    FOnExpanded        : TLMDPropsPageItemEvent;
    FOnCollapsed       : TLMDPropsPageItemEvent;
    FToolTips          : Boolean;
    FToolTipWindow     : TLMDHintWindow;
    LCurrentToolTipPos : TPoint;
    LCurrentToolTip    : TLMDString;
    FGridVisible       : Boolean;
    FGridColor         : TColor;
    FCursorBitmap      : Graphics.TBitmap; // Lazy inited.
    FCursorColor       : TColor;           //
    FGutterVisible     : Boolean;
    FGutterColor       : TColor;
    FCursorVisible     : Boolean;
    FSelectionStyle    : TLMDPropsPageSelectionStyle;
    FFlatSelectionBackgroundColor: TColor;
    FFlatSelectionColor: TColor;
    FGutterLineColor   : TColor;
    FCatergoryBackgroundColor: TColor;
    FDefaultPropName   : TLMDString;
    FCategoryFont      : TFont;
    FFlatSplitterColor: TColor;

    procedure SetEditTextBuf(const AValue: TLMDString;
                             AItem: TLMDPropsPageItem);
    function  GetEditTextBuf(AItem: TLMDPropsPageItem): TLMDString;
    procedure CancelEditTextBuf;
    procedure FlushEditTextBuf;

    procedure ItemsChange;
    function  IsOnSplitter(AX: Integer): Boolean;
    procedure UpdateColWidths;
    procedure UpdateScrollBar;
    procedure AdjustTopRow;
    function  ItemByRow(ARow: Integer): TLMDPropsPageItem;
    procedure UpdatePattern(AForce: Boolean = False);
    procedure IsToolTipMsg(var AMsg: TMsg);
    procedure UpdateToolTip;
    procedure ActivateToolTip(const LP: TPoint; const ATip: TLMDString);
    procedure CancelToolTip;
    procedure CategoryFontChanged(Sender: TObject);
    procedure UpdateRowHeight;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    function  GetActiveItem: TLMDPropsPageItem;
    function  GetSplitter: Integer;
    procedure SetSplitter(const Value: Integer);
    procedure SetValuesColor(const Value: TColor);
    procedure SetToolTips(const Value: Boolean);
    procedure SetGridVisible(const Value: Boolean);
    procedure SetGridColor(const Value: TColor);
    procedure SetGutterVisible(const Value: Boolean);
    procedure SetGutterColor(const Value: TColor);
    procedure SetCursorVisible(const Value: Boolean);
    procedure SetSelectionStyle(const Value: TLMDPropsPageSelectionStyle);
    procedure SetFlatSelectionBackgroundColor(const Value: TColor);
    procedure SetFlatSelectionColor(const Value: TColor);
    procedure SetGutterLineColor(const Value: TColor);
    procedure SetCatergoryBackgroundColor(const Value: TColor);
    procedure SetCategoryFont(const Value: TFont);
    procedure SetFlatSplitterColor(const Value: TColor);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    function  GetThemedBackColor: TColor;
    function  GetThemedCaptionTextColor(ADefault: TColor): TColor;
    function  GetThemedValueTextColor: TColor;
    function  GetThemedCategoryBackColor: TColor;
    function  GetThemedCategoryTextColor: TColor;
    function  GetThemedGutterColor: TColor;
    function  GetThemedGutterLineColor: TColor;
    function  GetThemedCursor: TBitmap;
    function  GetThemedSplitterColor(AShift: Integer): TColor;
    function  GetThemedGridColor: TColor;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
                       AState: TGridDrawState); override;
    procedure DrawGutter(ACanvas: TCanvas; ARect: TRect; AGutterLeft: Integer;
                         AIsFirst: Boolean; AFirstParentGutterLeft: Integer;
                         AIsLast: Boolean; ALastParentGutterLeft: Integer);
    procedure DoDrawCell(ACanvas: TCanvas; AWidth, AHeight: Integer;
                         AItem: TLMDPropsPageItem; ACol, ARow: Longint;
                         AState: TGridDrawState); virtual;
    function  CanEditShow: Boolean; override;
    function  SelectCell(ACol, ARow: Longint): Boolean; override;
    function  CreateEditor: TInplaceEdit; override;
    procedure Paint; override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  GetEditStyle(ACol, ARow: Longint): TLMDEditStyle; override;
    function  CanEditModify: Boolean; override;
    function  GetEditText(ACol, ARow: Longint): {$IFDEF _LMD_UNICODEIMPL}TLMDString{$ELSE}string{$ENDIF}; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: {$IFDEF _LMD_UNICODEIMPL}TLMDString{$ELSE}string{$ENDIF}); override;
    procedure CreateHandle; override;
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                      X, Y: Integer); override;
    procedure TopLeftChanged; override;
    procedure SizeChanged(OldColCount, OldRowCount: Longint); override;
    procedure DoExit; override;
    procedure BeginDestruction;
    function  CreateItem(AParent: TLMDPropsPageItem): TLMDPropsPageItem; virtual;
    procedure ItemDestroying(AItem: TLMDPropsPageItem); virtual;
    procedure ItemExpanded(AItem: TLMDPropsPageItem); virtual;
    procedure ItemCollapsed(AItem: TLMDPropsPageItem); virtual;
    function  GetItemCaptionColor(AItem: TLMDPropsPageItem): TColor; virtual;
    property  Items: TLMDPropsPageItems read FItems;
    property  ActiveItem: TLMDPropsPageItem read GetActiveItem;
    property  Splitter: Integer read GetSplitter write SetSplitter;
    property  ValuesColor: TColor read FValuesColor write SetValuesColor default clNavy;
    property  Color default clBtnFace;
    property  ToolTips: Boolean read FToolTips write SetToolTips default True;
    property  GridColor: TColor read FGridColor write SetGridColor default clBtnShadow;
    property  GridVisible: Boolean read FGridVisible write SetGridVisible default True;
    property  GutterVisible: Boolean read FGutterVisible write SetGutterVisible default False;
    property  GutterColor: TColor read FGutterColor write SetGutterColor default clCream;
    property  GutterLineColor: TColor read FGutterLineColor write SetGutterLineColor default clBtnShadow;
    property  CursorVisible: Boolean read FCursorVisible write SetCursorVisible default False;
    property  SelectionStyle: TLMDPropsPageSelectionStyle read FSelectionStyle write SetSelectionStyle default ssClassic;
    property  FlatSelectionBackgroundColor: TColor read FFlatSelectionBackgroundColor write SetFlatSelectionBackgroundColor default clHighlight;
    property  FlatSelectionColor: TColor read FFlatSelectionColor write SetFlatSelectionColor default clHighlightText;
    property  FlatSplitterColor: TColor read FFlatSplitterColor write SetFlatSplitterColor default clGray;
    property  CategoryBackgroundColor: TColor read FCatergoryBackgroundColor write SetCatergoryBackgroundColor default clHighlight;
    property  CategoryFont: TFont read FCategoryFont write SetCategoryFont;
    property  DefaultPropName: TLMDString read FDefaultPropName write FDefaultPropName;
    property  OnExpanded: TLMDPropsPageItemEvent read FOnExpanded write FOnExpanded;
    property  OnCollapsed: TLMDPropsPageItemEvent read FOnCollapsed write FOnCollapsed;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure EndUpdate;
    function  CanCopyToClipboard: Boolean;
    function  CanCutToClipboard: Boolean;
    function  CanPasteFromClipboard: Boolean;
    procedure CutToClipboard;
    procedure CopyToClipboard;
    procedure PasteFromClipboard;
    function  SaveState: TLMDPropPageStateObject;
    procedure RestoreState(AStateObject: TLMDPropPageStateObject; AFreeStateObject: Boolean = True);
    function  ItemAtPos(AX, AY: Integer): TLMDPropsPageItem;
    function  GetHitTestInfoAt(AX, AY: Integer): TLMDPropsPageHitTests;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  TLMDPropsPage = class(TLMDCustomPropsPage)
  public
    property Items;
    property ActiveItem;
  published
    property Splitter;
    property ValuesColor;
    property ToolTips;
    property GridColor;
    property GridVisible;
    property GutterVisible;
    property GutterColor;
    property GutterLineColor;
    property CursorVisible;
    property SelectionStyle;
    property FlatSelectionBackgroundColor;
    property FlatSelectionColor;
    property FlatSplitterColor;
    property CategoryBackgroundColor;
    property CategoryFont;
    property DefaultPropName;
    property OnExpanded;
    property OnCollapsed;
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  LMDStrings, LMDProcs;

type
  TLMDCustomListBoxAccess = class(TCustomListBox);

const
  LMDPPTextIdent = 14;
  LMDPPExpandButtonX = 2;
  LMDPPExpandButtonY = 3;

{ **************************** Global procedures ***************************** }
{ ---------------------------------------------------------------------------- }

procedure LMDKillMessage(AWnd: HWnd; AMsg: Integer);
var
  LM: TMsg;
begin
  LM.Message := 0;
  if PeekMessage(LM, AWnd, AMsg, AMsg, pm_Remove) and (LM.Message = WM_QUIT) then
    PostQuitMessage(LM.wparam);
end;

function LMDBlend(ABase, C: TColor; Alpha: Integer): TColor;
var
  bq, cq: TRGBQuad;
  rq:     TRGBQuad;
  alp:    Double;
begin
  bq  := TRGBQuad(ColorToRGB(ABase));
  cq  := TRGBQuad(ColorToRGB(C));
  alp := Alpha / 100;

  if alp > 1 then
    alp := 1
  else if alp < 0 then
    alp := 0;

  rq.rgbBlue     := Round(bq.rgbBlue * (1 - alp) + cq.rgbBlue * alp);
  rq.rgbGreen    := Round(bq.rgbGreen * (1 - alp) + cq.rgbGreen * alp);
  rq.rgbRed      := Round(bq.rgbRed * (1 - alp) + cq.rgbRed * alp);
  rq.rgbReserved := Round(bq.rgbReserved * (1 - alp) + cq.rgbReserved * alp);

  Result := TColor(rq);
end;

{ ******************** class TLMDPropsPageInplaceEdit ************************ }
{ ------------------------------ private ------------------------------------- }
procedure TLMDPropsPageInplaceEdit.PickListMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
var
  LItem: TLMDPropsPageItem;
begin
  LItem := TLMDCustomPropsPage(Grid).ActiveItem;
  if (LItem <> nil) and LItem.OwnerDrawPickList then
    LItem.PickListMeasureHeight(PickList.Items[Index], PickList.Canvas, Height);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.PickListDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  LItem: TLMDPropsPageItem;
begin
  LItem := TLMDCustomPropsPage(Grid).ActiveItem;
  if (LItem <> nil) and LItem.OwnerDrawPickList then
    LItem.PickListDrawValue(PickList.Items[Index], PickList.Canvas, Rect, odSelected in State);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.WMLButtonDblClk(var Message: TWMMouse);
begin
  if OverButton(Point(Message.XPos, Message.YPos)) then
    PostMessage(Handle, WM_LBUTTONDOWN, TMessage(Message).WParam,
                TMessage(Message).LParam)
  else
    inherited;
    SelectAll;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDPropsPageInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style and not ES_MULTILINE;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.DropDown;
var
  LP:    TPoint;
  LI,    LVisItemCount, LItemHW, LHW: Integer;
  LItem: TLMDPropsPageItem;
begin
  LItem := TLMDCustomPropsPage(Grid).ActiveItem;
  if not ListVisible and (LItem <> nil) then
  begin
    if LItem.OwnerDrawPickList then
    begin
      TLMDCustomListBoxAccess(PickList).Style         := lbOwnerDrawVariable;
      TLMDCustomListBoxAccess(PickList).OnMeasureItem := PickListMeasureItem;
      TLMDCustomListBoxAccess(PickList).OnDrawItem    := PickListDrawItem;
    end
    else
    begin
      TLMDCustomListBoxAccess(PickList).Style := lbStandard;
      TLMDCustomListBoxAccess(PickList).OnMeasureItem := nil;
      TLMDCustomListBoxAccess(PickList).OnDrawItem := nil;
    end;

    ActiveList.Width := Width;
    if ActiveList = PickList then
    begin
      { Get values }

      DoGetPickListItems;
      TLMDCustomListBoxAccess(PickList).Color := Color;
      TLMDCustomListBoxAccess(PickList).Font  := Font;

      { Calc initial visible item count }

      if (DropDownRows > 0) and (PickList.Items.Count >= DropDownRows) then
        LVisItemCount := DropDownRows
      else
        LVisItemCount := PickList.Items.Count;

      { Calc PickList height }

      if LItem.OwnerDrawPickList then
      begin
        LHW := 4;
        for LI := 0 to LVisItemCount - 1 do
        begin
          LItemHW := TLMDCustomListBoxAccess(PickList).ItemHeight;
          LItem.PickListMeasureHeight(PickList.Items[LI],
                                      PickList.Canvas, LItemHW);
          Inc(LHW, LItemHW);
        end;
      end
      else
        LHW := LVisItemCount * TLMDCustomListBoxAccess(PickList).ItemHeight + 4;
      if PickList.Items.Count > 0 then
        PickList.Height := LHW
      else
        PickList.Height := 20;

      { Set PickList selected item }

      if Text = '' then
        PickList.ItemIndex := -1
      else
        PickList.ItemIndex := PickList.Items.IndexOf(Text);

      { Calc PickList width }

      LHW := PickList.ClientWidth;
      for LI := 0 to PickList.Items.Count - 1 do
      begin
        LItemHW := PickList.Canvas.TextWidth(PickList.Items[LI]);
        if LItem.OwnerDrawPickList then
          LItem.PickListMeasureWidth(PickList.Items[LI], PickList.Canvas, LItemHW);
        if LItemHW > LHW then LHW := LItemHW;
      end;
      PickList.ClientWidth := LHW;
    end;

    LP := Parent.ClientToScreen(Point(Left, Top + Height));
    if LP.Y + ActiveList.Height > Screen.Height then
      LP.Y := LP.Y - Height - ActiveList.Height;
    if LP.X + ActiveList.Width > Screen.Width then
      LP.X := LP.X + Width - ActiveList.Width;

    SetWindowPos(ActiveList.Handle, HWND_TOP, LP.X, LP.Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);

    ListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.UpdateContents;
begin
  Include(TLMDCustomPropsPage(Grid).FState, ppsUpdatingEditorContent);
  try
    inherited;

    if not EditCanModify then
    begin
      Color      := TLMDCustomPropsPage(Owner).Color;
      Font.Color := TLMDCustomPropsPage(Owner).ValuesColor;
    end
    else
    begin
      Color      := clWindow;
      Font.Color := clWindowText;
    end;
    FReadOnlyStyle := not EditCanModify;
  finally
    Exclude(TLMDCustomPropsPage(Grid).FState, ppsUpdatingEditorContent);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:  begin
                  TLMDCustomPropsPage(Grid).FlushEditTextBuf;
                  TLMDCustomPropsPage(Grid).ActiveItem.SetEditValue(Text, True);

                  if Shift = [ssCtrl] then
                  begin
                    LMDKillMessage(Handle, WM_CHAR);
                    DblClick;
                  end;

                  SelectAll;
                  Key := 0;
                end;
    VK_ESCAPE:  if TLMDCustomPropsPage(Grid).ActiveItem <> nil then
                begin
                  Text := TLMDCustomPropsPage(Grid).ActiveItem.GetEditValue;
                  SelectAll;
                  Key := 0;
                end;
    VK_HOME:    if (SelStart = 0) and (SelLength > 0) then
                  SelLength := 0;
    VK_END:     if (SelStart + SelLength = Length(Text)) and (SelLength > 0) then
                  SelLength := 0;
  end;

  if Key <> 0 then
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.DoEditButtonClick;
begin
  if TLMDCustomPropsPage(Grid).ActiveItem <> nil then
    TLMDCustomPropsPage(Grid).ActiveItem.EditButtonClick;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.DoGetPickListItems;
begin
  if TLMDCustomPropsPage(Grid).ActiveItem <> nil then
  begin
    PickList.Items.Clear;
    TLMDCustomPropsPage(Grid).ActiveItem.GetEditPickList(PickList.Items);
    PickList.ItemIndex := PickList.Items.IndexOf(Text);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.CloseUp(Accept: Boolean);
begin
  inherited;
  if not Accept then
    Exit;
  with TLMDCustomPropsPage(Owner) do
  begin
    FlushEditTextBuf;
    SelectAll;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.DblClick;
begin
  if TLMDCustomPropsPage(Grid).ActiveItem <> nil then
    TLMDCustomPropsPage(Grid).ActiveItem.EditDblClick;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageInplaceEdit.BoundsChanged;
var
  page:  TLMDCustomPropsPage;
  style: TLMDPropsPageSelectionStyle;
begin
  if FChangingBounds then
    Exit;
  FChangingBounds := True;
  try
    page := TLMDCustomPropsPage(Grid);
    if page <> nil then
      style := page.FSelectionStyle
    else
      style := ssClassic;

    UpdateLoc(Rect(Left, Top + 2 * Ord(style = ssFlat),
                   Left + Width, Top + Height - 2));

    LMDSendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN,
                   MakeLong(1, ButtonWidth * Ord(EditStyle <> esSimple) + 2));
  finally
    FChangingBounds := False;
  end;
  inherited;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDPropsPageInplaceEdit.Create(AOwner: TComponent);
begin
  inherited;
  DropDownRows := 8;
  ButtonWidth  := 16;
end;

{ *********************** class TLMDPropsPageItem **************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDPropsPageItem.CanExpand: Boolean;
begin
  Result := (Expandable = ieYes) or ((Expandable = ieAuto) and (Count > 0));
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.Ident: Integer;
begin
  Result := Level * 10;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.IsOnExpandButton(AX: Integer): Boolean;
begin
  Result := (AX >= Ident) and (AX <= Ident + 13);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.GetItems(AIndex: Integer): TLMDPropsPageItem;
begin
  Result := TLMDPropsPageItem(inherited Items[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetExpandable(const Value: TLMDPropsPageItemExpandable);
begin
  if FExpandable <> Value then
    begin
      FExpandable := Value;
      FExpanded := FExpanded and CanExpand;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
    begin
      FCaption := Value;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.GetLevel: Integer;
var
  LParent: TLMDPropsPageItem;
begin
  Result := 0;
  LParent := Parent;
  while LParent <> nil do
    begin
      if not LParent.IsCategory then
        Inc(Result);
      LParent := LParent.Parent;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetEditStyle(const Value: TLMDEditStyle);
begin
  if FEditStyle <> Value then
  begin
    FEditStyle := Value;
    Change;
  end;
end;

procedure TLMDPropsPageItem.SetEditValue(const Value: TLMDString;
  AForce: Boolean);
begin
  if not FIsCategory and (FDisplayValue <> Value) then
  begin
    FDisplayValue := Value;
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetAutoUpdate(const Value: Boolean);
begin
  if FAutoUpdate <> Value then
  begin
    FAutoUpdate := Value;
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetOwnerDrawPickList(const Value: Boolean);
begin
  if FOwnerDrawPickList <> Value then
  begin
    FOwnerDrawPickList := Value;
    Change;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.GetActive: Boolean;
begin
  Result := (FOwner.ActiveItem = Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetActive(const Value: Boolean);
var
  LParent: TLMDPropsPageItem;
begin
  if (Owner.ActiveItem <> Self) then
    begin
      { Check activating availability }
      LParent := Parent;
      while LParent <> nil do
        begin
          if not LParent.CanExpand then
            raise ELMDPropsPage.Create(SLMDPropPageUnableActivateItem);
          LParent := LParent.Parent;
        end;
      Owner.BeginUpdate;
      try
        { Expand parent items }
        LParent := Parent;
        while LParent <> nil do
          begin
            LParent.Expand;
            LParent := LParent.Parent;
          end;
        { Activate item }
        Include(Owner.FState, ppsChangingActiveItem);
        try
          Owner.ItemsChange; // To set Owner.Row all rows
                             // mast already exists
        finally
          Exclude(Owner.FState, ppsChangingActiveItem);
        end;
        Owner.Row := FRow;
      finally
        Owner.EndUpdate;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetIsCategory(const Value: Boolean);
begin
  if FIsCategory <> Value then
    begin
      FIsCategory := Value;
      Change;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.GetNonCategoryParent: TLMDPropsPageItem;
begin
  Result := FParent;
  while (Result <> nil) and Result.IsCategory do
    Result := Result.Parent;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.GetParentCategory: TLMDPropsPageItem;
begin
  Result := FParent;
  while (Result <> nil) and not Result.IsCategory do
    Result := Result.Parent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.SetHighlighted(const Value: Boolean);
begin
  if FHighlighted <> Value then
    begin
      FHighlighted := Value;
      Change;
    end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDPropsPageItem.CreateItem: TObject;
begin
  Result := FOwner.CreateItem(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.Change;
begin
  FOwner.ItemsChange;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.Deleted;
begin
  FExpanded := FExpanded and CanExpand;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.GetDisplayValue: TLMDString;
begin
  if not FIsCategory then
    Result := FDisplayValue
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.EditButtonClick;
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.EditDblClick;
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.GetEditPickList(APickList: TLMDStrings);
begin
  // Do nothing
end;

function TLMDPropsPageItem.GetEditValue: TLMDString;
begin
  Result := GetDisplayValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.PickListMeasureHeight(const AValue: TLMDString;
  ACanvas: TCanvas; var AHeight: Integer);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.PickListMeasureWidth(const AValue: TLMDString;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.PickListDrawValue(const AValue: TLMDString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  // Do nothing
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDPropsPageItem.Create(AOwner: TLMDCustomPropsPage;
  AParent: TLMDPropsPageItem);
begin
  inherited Create;
  FOwner := AOwner;
  FParent := AParent;
  FRow := -1;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPropsPageItem.Destroy;
begin
  Clear;
  FOwner.ItemDestroying(Self);
  if FRow <> -1 then
  begin
    FOwner.FRows[FRow] := nil;
    FRow := -1;
  end;
  if FOwner.FEditTextItem = Self then
  begin
    FOwner.FEditText     := '';
    FOwner.FEditTextItem := nil;
  end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.Find(const ACaption: TLMDString): TLMDPropsPageItem;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to Count - 1 do
    if LMDSameText(ACaption, Items[LI].Caption) then
    begin
      Result := Items[LI];
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.Expand;
begin
  if not FExpanded and CanExpand then
    begin
      Owner.BeginUpdate;
      try
        FExpanded := True;
        Owner.ItemExpanded(Self);
        Change;
      finally
        Owner.EndUpdate;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItem.Collapse;
begin
  if FExpanded then
    begin
      Owner.BeginUpdate;
      try
        FExpanded := False;
        Owner.ItemCollapsed(Self);
        Change;
      finally
        Owner.EndUpdate;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.DisplayRect(ACaption, AValue: Boolean): TRect;
begin
  Result := Rect(0, 0, 0, 0);
  if FRow <> -1 then
    if ACaption and AValue then
      begin
        Result.TopLeft := FOwner.CellRect(0, FRow).TopLeft;
        Result.BottomRight := FOwner.CellRect(1, FRow).BottomRight;
      end
    else if ACaption then
      Result := FOwner.CellRect(0, FRow)
    else if AValue then
      Result := FOwner.CellRect(1, FRow);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.Index: Integer;
begin
  if FParent <> nil then
    Result := FParent.IndexOf(Self)
  else
    Result := FOwner.FItems.IndexOf(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.IsFirst: Boolean;
begin
  Result := (Index = 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.IsLast: Boolean;
begin
  if FParent <> nil then
    Result := (Index = FParent.Count - 1)
  else
    Result := (Index = FOwner.FItems.Count - 1);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItem.ShowEditor: Boolean;
begin
  Result := not IsCategory;
end;

{ *********************** class TLMDPropsPageItems *************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDPropsPageItems.GetItems(AIndex: Integer): TLMDPropsPageItem;
begin
  Result := TLMDPropsPageItem(inherited Items[AIndex]);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDPropsPageItems.CreateItem: TObject;
begin
  Result := FOwner.CreateItem(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropsPageItems.Change;
begin
  Owner.ItemsChange;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDPropsPageItems.Create(AOwner: TLMDCustomPropsPage);
begin
  inherited Create;
  FOwner := AOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropsPageItems.Find(
  const ACaption: TLMDString): TLMDPropsPageItem;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to Count - 1 do
    if LMDSameText(ACaption, Items[LI].Caption) then
    begin
      Result := Items[LI];
      Break;
    end;
end;

{ ********************* class TLMDPropPageStateObject ************************ }
{ ------------------------------ private ------------------------------------- }
procedure TLMDPropPageStateObject.FreeExpandInfo(ARItems: PLMDRestoreItems);
var
  LI: Integer;
begin
  for LI := 0 to High(ARItems^) do
    if ARItems^[LI].Items <> nil then
      begin
        FreeExpandInfo(ARItems^[LI].Items);
        Dispose(PLMDRestoreItems(ARItems^[LI].Items));
      end;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDPropPageStateObject.Create;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPropPageStateObject.Destroy;
begin
  FreeExpandInfo(@FExpandedInfo);
  inherited;
end;

{ *********************** class TLMDCustomPropsPage ************************** }
{ -------------------------------- private ----------------------------------- }

procedure TLMDCustomPropsPage.SetEditTextBuf(const AValue: TLMDString;
  AItem: TLMDPropsPageItem);
begin
  if (AItem <> nil) and AItem.AutoUpdate then
  begin
    Include(FState, ppsSettingAutoUpdateItemValue);
    try
      AItem.SetEditValue(AValue, True);
    finally
      Exclude(FState, ppsSettingAutoUpdateItemValue);
    end;

    FEditText          := '';
    FEditTextItem      := nil;
  end
  else
  begin
    if AItem <> FEditTextItem then
      FlushEditTextBuf;

    FEditText     := AValue;
    FEditTextItem := AItem;
  end;
end;

function TLMDCustomPropsPage.GetEditTextBuf(
  AItem: TLMDPropsPageItem): TLMDString;
begin
  if AItem <> nil then
  begin
    if FEditTextItem = AItem then
      Result := FEditText
    else
      Result := AItem.GetEditValue;
  end
  else
    Result := '';
end;

procedure TLMDCustomPropsPage.CancelEditTextBuf;
begin
  FEditText     := '';
  FEditTextItem := nil;

  if not (ppsSettingAutoUpdateItemValue in FState) and
     (InplaceEditor <> nil) then
    TLMDPropsPageInplaceEdit(InplaceEditor).UpdateContents;
end;

procedure TLMDCustomPropsPage.FlushEditTextBuf;
var
  LItem: TLMDPropsPageItem;
  LText: TLMDString;
begin
  if (FEditTextItem <> nil) and not (ppsDestroying in FState) then
  begin
    LItem         := FEditTextItem;
    LText         := FEditText;
    FEditText     := '';
    FEditTextItem := nil;

    if not LItem.IsCategory then
    begin
      LItem.SetEditValue(LText, False);
      if (InplaceEditor <> nil) then
        TLMDPropsPageInplaceEdit(InplaceEditor).UpdateContents;
    end;
  end;
end;

procedure TLMDCustomPropsPage.ItemsChange;

  procedure _FillRows(AList: TLMDObjectList);
  var
    LI: Integer;
  begin
    for LI := 0 to AList.Count - 1 do
    begin
      SetLength(FRows, Length(FRows) + 1);
      FRows[High(FRows)] := TLMDPropsPageItem(AList[LI]);
      TLMDPropsPageItem(AList[LI]).FRow := High(FRows);
      if TLMDPropsPageItem(AList[LI]).Expanded then
        _FillRows(TLMDObjectList(AList[LI]));
    end;
  end;

var
  LI:          Integer;
  LActiveItem: TLMDPropsPageItem;
begin
  if ((FUpdateCount <= 0) and not (ppsDestroying in FState)) or
     (ppsChangingActiveItem in FState) then
  begin
    CancelToolTip;

    LActiveItem := ActiveItem;
    for LI := 0 to High(FRows) do
      if FRows[LI] <> nil then
        FRows[LI].FRow := -1;

    SetLength(FRows, 0);
    _FillRows(Items);

    RowCount := Length(FRows);

    while LActiveItem <> nil do
    begin
      if LActiveItem.FRow <> -1 then
      begin
        if Row <> LActiveItem.FRow then
          Row := LActiveItem.FRow;
        Break;
      end;
      LActiveItem := LActiveItem.Parent;
    end;

    Invalidate;
    LActiveItem := ActiveItem;
    if InplaceEditor <> nil then
    begin
      if (LActiveItem <> nil) and not LActiveItem.IsCategory then
      begin
        if (TLMDPropsPageInplaceEdit(InplaceEditor).ReadOnlyStyle <> LActiveItem.ReadOnly) or
          (TLMDPropsPageInplaceEdit(InplaceEditor).EditStyle <> LActiveItem.EditStyle) then
          InvalidateEditor;
      end
      else
      begin
        if not TLMDPropsPageInplaceEdit(InplaceEditor).ReadOnlyStyle or
          (TLMDPropsPageInplaceEdit(InplaceEditor).EditStyle <> esSimple) then
          InvalidateEditor;
      end;

      if (LActiveItem = nil) or LActiveItem.IsCategory then
        HideEditor;
      CancelEditTextBuf;
    end;

    if not (ppsChangingActiveItem in FState) then
    begin
      Update;
      Exclude(FState, ppsChanged);
    end;
  end
  else
    Include(FState, ppsChanged);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.GetThemedCursor: TBitmap;
var
  clr:  TColor;
  x, y: Integer;
  crtd: Boolean;
begin
  crtd := (FCursorBitmap = nil);
  if crtd then
    FCursorBitmap := Graphics.TBitmap.Create;

  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    clr := LMDBlend(GetThemedValueTextColor, GetThemedGutterColor, 30)
  else
  {$ENDIF}
    clr := clBlack;

  if (FCursorColor <> clr) or crtd then
  begin
    FCursorBitmap.LoadFromResourceName(HInstance, 'LMDPICURSOR');
    FCursorBitmap.Transparent := True;

    for y := 0 to FCursorBitmap.Height - 1 do
      for x := 0 to FCursorBitmap.Width - 1 do
      begin
        if FCursorBitmap.Canvas.Pixels[x, y] = clBlack then
          FCursorBitmap.Canvas.Pixels[x, y] := clr;
      end;
    FCursorColor := clr;
  end;

  Result := FCursorBitmap;
end;

function TLMDCustomPropsPage.IsOnSplitter(AX: Integer): Boolean;
begin
  Result := (AX >= ColWidths[0] - 4) and (AX <= ColWidths[0]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.UpdateColWidths;
var
  LWidth: Integer;
begin
  LWidth := Width - ColWidths[0];
  if LWidth < 0 then
    LWidth := 0;

  ColWidths[1] := LWidth;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.UpdateScrollBar;
var
  LSI: TScrollInfo;
begin
  if HandleAllocated then
    begin
      LSI.cbSize := SizeOf(LSI);
      LSI.fMask := SIF_ALL;
      GetScrollInfo(Self.Handle, SB_VERT, LSI);
      LSI.nPage := VisibleRowCount;
      LSI.nMin := 0;
      LSI.nMax := RowCount - 1;
      LSI.nPos := TopRow;
      SetScrollInfo(Self.Handle, SB_VERT, LSI, True);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.AdjustTopRow;
var
  LI: Integer;
begin
  if HandleAllocated then
    begin
      LI := ClientHeight div DefaultRowHeight;
      if RowCount - TopRow < LI then
        begin
          LI := RowCount - LI;
          if LI < 0 then LI := 0;
          TopRow := LI;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.ItemByRow(ARow: Integer): TLMDPropsPageItem;
begin
  if (ARow >= 0) and (ARow <= High(FRows)) then
    Result := FRows[ARow]
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.UpdatePattern(AForce: Boolean);
var
  LI:     Integer;
  bk, pt: TColor;
begin
  bk := GetThemedBackColor;
  pt := GetThemedGridColor;

  if AForce or (FGridPatternBkColor <> bk) or (FGridPatternColor <> pt) then
  begin
    FGridPatternColor   := pt;
    FGridPatternBkColor := bk;

    with FGridPattern do
    begin
      Width  := 8;
      Height := 8;

      Canvas.Brush.Color := FGridPatternBkColor;
      Canvas.Brush.Style := bsSolid;
      Canvas.FillRect(Rect(0, 0, FGridPattern.Width, FGridPattern.Height));
      Canvas.Pen.Color := FGridPatternColor;

      LI := 0;
      while LI < Width do
      begin
        Canvas.Polyline([Point(LI, 0), Point(LI, FGridPattern.Height)]);
        Inc(LI, 2);
      end;
    end;

    if FBrush <> 0 then
      DeleteObject(FBrush);
    FBrush := CreatePatternBrush(FGridPattern.Handle);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.IsToolTipMsg(var AMsg: TMsg);
begin
  with AMsg do
    if (Message = CM_ACTIVATE) or (Message = CM_DEACTIVATE) or
       (Message = CM_APPKEYDOWN) or (Message = CM_APPSYSCOMMAND) or
       (Message = WM_COMMAND) or (Message = WM_NCMOUSEMOVE) then
      CancelToolTip;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.UpdateToolTip;
var
  LGridCoord: TGridCoord;
  LItem: TLMDPropsPageItem;
  LTipPos, LCursorPos: TPoint;
  LRect: TRect;
  LStr: TLMDString;
  LIdent, LTextWidth: Integer;
begin
  if HandleAllocated then
    begin
      GetCursorPos(LCursorPos);
      with ScreenToClient(LCursorPos) do LGridCoord := MouseCoord(X, Y);
      if ToolTips and Application.Active and
        (FindDragTarget(LCursorPos, True) = Self) and
        PtInRect(ClientRect, ScreenToClient(LCursorPos)) and
        not ((LGridCoord.Y = Row) and (LGridCoord.X = 1)) and
        (LGridCoord.Y <> -1) and (LGridCoord.X <> -1) then
        begin
          LItem := ItemByRow(LGridCoord.Y);
          if (LItem <> nil) and not LItem.IsCategory then
            begin
              LRect := CellRect(LGridCoord.X, LGridCoord.Y);
              LTipPos := ClientToScreen(LRect.TopLeft);
              Dec(LTipPos.Y, 2);
              if LGridCoord.X = 0 then
                begin
                  LIdent := LItem.Ident + LMDPPTextIdent;
                  LTextWidth := LRect.Right - LRect.Left - LIdent - 3;
                  LStr := LItem.Caption;
                end
              else
                begin
                  LIdent := 0;
                  LTextWidth := LRect.Right - LRect.Left - LIdent - 1;
                  LStr := LItem.DisplayValue;
                end;
              Inc(LTipPos.X, LIdent - 2);
              if Canvas.TextWidth(LStr) > LTextWidth then
                begin
                  if (FToolTipWindow = nil) or (LTipPos.X <> LCurrentToolTipPos.X) or
                    (LTipPos.Y <> LCurrentToolTipPos.Y) or (LStr <> LCurrentToolTip) then
                      begin
                        ActivateToolTip(LTipPos, LStr);
                        LCurrentToolTipPos := LTipPos;
                        LCurrentToolTip := LStr;
                      end;
                end
              else
                CancelToolTip;
            end
          else
            CancelToolTip;
        end
        else
          CancelToolTip;
      end
  else
    CancelToolTip;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.ActivateToolTip(const LP: TPoint;
  const ATip: TLMDString);
var
  LR: TRect;
begin
  Update;
  if FToolTipWindow = nil then
    begin
      FToolTipWindow := TLMDHintWindow.Create(Self);
      LMDHookHint(IsToolTipMsg);
    end;
  FToolTipWindow.Color := Application.HintColor;
  FToolTipWindow.Canvas.Font := Font;
  LR := FToolTipWindow.CalcHintRect(MaxInt, ATip, nil);
  OffsetRect(LR, LP.X, LP.Y);
  FToolTipWindow.ActivateHint(LR, ATip);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CancelToolTip;
begin
  if FToolTipWindow <> nil then
    begin
      ShowWindow(FToolTipWindow.Handle, SW_HIDE);
      FToolTipWindow.Free;
      FToolTipWindow := nil;
      LMDUnhookHint(IsToolTipMsg);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CategoryFontChanged(Sender: TObject);
begin
  UpdateRowHeight;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.UpdateRowHeight;
var
  LH1, LH2, LMaxH: Integer;
begin
  Canvas.Font := FCategoryFont;
  LH1 := Canvas.TextHeight('Wg');
  Canvas.Font := Font;
  LH2 := Canvas.TextHeight('Wg');
  LMaxH := LH1;
  if LH2 > LH1 then
    LMaxH := LH2;
  DefaultRowHeight := Max(16, LMaxH) + 2;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.WMVScroll(var Message: TWMVScroll);
var
  LTopRow: Integer;
  LSI: TScrollInfo;
begin
  LTopRow := TopRow;
  with Message do
    case ScrollCode of
      SB_LINEUP: LTopRow := LTopRow - 1;
      SB_LINEDOWN: LTopRow := LTopRow + 1;
      SB_PAGEUP: LTopRow := LTopRow - VisibleRowCount;
      SB_PAGEDOWN: LTopRow := LTopRow + VisibleRowCount;
      SB_THUMBPOSITION, SB_THUMBTRACK:
        begin
          LSI.cbSize := SizeOf(LSI);
          LSI.fMask := SIF_ALL;
          GetScrollInfo(Self.Handle, SB_VERT, LSI);
          LTopRow := LSI.nTrackPos;
        end;
      SB_BOTTOM: LTopRow := RowCount - 1;
      SB_TOP: LTopRow := 0;
    end;
  if LTopRow < 0 then LTopRow := 0;
  if LTopRow > RowCount - VisibleRowCount then LTopRow := RowCount - VisibleRowCount;
  TopRow := LTopRow;
  Message.Result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.WMSize(var Message: TWMSize);
begin
  inherited;
  AdjustTopRow;
  UpdateScrollBar;
  UpdateToolTip;
  Splitter := Splitter; // Force UpdateColWidths;
  InvalidateEditor;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.WMSetCursor(var Message: TWMSetCursor);
var
  LP: TPoint;
begin
  GetCursorPos(LP);
  LP := ScreenToClient(LP);
  if IsOnSplitter(LP.X) then
    Windows.SetCursor(Screen.Cursors[crHSplit])
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  {$IFDEF LMDCOMP7}
  if csParentBackground in ControlStyle then // Remove some flickers.
    inherited;
  {$ENDIF}    
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.Result := Ord(IsOnSplitter(Msg.XPos) or (ppsMovingSplitter in FState));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CMFontChanged(var Message: TMessage);
begin
  Canvas.Font := Font;
  FCellBitmap.Canvas.Font := Canvas.Font;
  UpdateRowHeight;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CMExit(var Message: TMessage);
begin
  FlushEditTextBuf;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  CancelToolTip;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
  CancelToolTip;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.GetActiveItem: TLMDPropsPageItem;
begin
  Result := ItemByRow(Row);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.GetSplitter: Integer;
begin
  Result := ColWidths[0];
end;

function TLMDCustomPropsPage.GetThemedBackColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scGrid)
  else
  {$ENDIF}
    Result := Color;
end;

function TLMDCustomPropsPage.GetThemedCaptionTextColor(
  ADefault: TColor): TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleFontColor(sfGridItemNormal)
  else
  {$ENDIF}
    Result := ADefault;
end;

function TLMDCustomPropsPage.GetThemedCategoryBackColor: TColor;
{$IFDEF LMDCOMP16}
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
  begin
    dtls := StyleServices.GetElementDetails(tgFixedCellNormal);
    if not StyleServices.GetElementColor(dtls, ecBorderColor, Result) then
      Result := GetShadowColor(GetThemedBackColor);
  end
  else
  {$ENDIF}
    Result := FCatergoryBackgroundColor;
end;

function TLMDCustomPropsPage.GetThemedCategoryTextColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleFontColor(sfGridItemFixedNormal)
  else
  {$ENDIF}
    Result := FCategoryFont.Color;
end;

function TLMDCustomPropsPage.GetThemedGridColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := LMDBlend(GetThemedValueTextColor,
                       GetThemedBackColor, 90)
  else
  {$ENDIF}
    Result := FGridColor;
end;

function TLMDCustomPropsPage.GetThemedGutterColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := LMDBlend(GetThemedBackColor,
                       GetThemedCategoryBackColor,
                       20)
  else
  {$ENDIF}
    Result := FGutterColor;
end;

function TLMDCustomPropsPage.GetThemedGutterLineColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := LMDBlend(GetThemedBackColor,
                       GetThemedCategoryBackColor,
                       80)
  else
  {$ENDIF}
    Result := FGutterLineColor;
end;

function TLMDCustomPropsPage.GetThemedSplitterColor(
  AShift: Integer): TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := LMDBlend(GetThemedValueTextColor,
                       GetThemedBackColor, 80 + AShift)
  else
  {$ENDIF}
  begin
    if AShift > 0 then
      Result := clBtnHighlight
    else if AShift > 0 then
      Result := clBtnShadow
    else
      Result := FlatSplitterColor;
  end;
end;

function TLMDCustomPropsPage.GetThemedValueTextColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleFontColor(sfGridItemNormal)
  else
  {$ENDIF}
    Result := ValuesColor;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetSplitter(const Value: Integer);
var
  LNewVal: Integer;
begin
  LNewVal := Value;
  if LNewVal > Width - 40 then
    LNewVal := Width - 40;
  if LNewVal < 40 then
    LNewVal := 40;

  ColWidths[0] := LNewVal;
  UpdateColWidths;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetValuesColor(const Value: TColor);
begin
  if FValuesColor <> Value then
  begin
    FValuesColor := Value;
    Invalidate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetToolTips(const Value: Boolean);
begin
  FToolTips := Value;
  if not Value then CancelToolTip;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetGridVisible(const Value: Boolean);
begin
  FGridVisible := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetGridColor(const Value: TColor);
begin
  FGridColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetGutterVisible(const Value: Boolean);
begin
  FGutterVisible := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetGutterColor(const Value: TColor);
begin
  FGutterColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetCursorVisible(const Value: Boolean);
begin
  FCursorVisible := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetSelectionStyle(
  const Value: TLMDPropsPageSelectionStyle);
begin
  FSelectionStyle := Value;
  if (InplaceEditor <> nil) and InplaceEditor.Visible then
    InvalidateEditor;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetFlatSelectionBackgroundColor(
  const Value: TColor);
begin
  FFlatSelectionBackgroundColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetFlatSelectionColor(const Value: TColor);
begin
  FFlatSelectionColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetFlatSplitterColor(const Value: TColor);
begin
  FFlatSplitterColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetGutterLineColor(const Value: TColor);
begin
  FGutterLineColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetCatergoryBackgroundColor(
  const Value: TColor);
begin
  FCatergoryBackgroundColor := Value;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetCategoryFont(const Value: TFont);
begin
  FCategoryFont.Assign(Value);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDCustomPropsPage.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_INSPECTOR;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDCustomPropsPage.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  LItem: TLMDPropsPageItem;
begin
  FCellBitmap.Width  := ARect.Right - ARect.Left;
  FCellBitmap.Height := ARect.Bottom - ARect.Top;

  LItem := ItemByRow(ARow);
  if LItem <> nil then
    DoDrawCell(FCellBitmap.Canvas, FCellBitmap.Width,
               FCellBitmap.Height, LItem, ACol, ARow,
               AState)
  else
  begin
    FCellBitmap.Canvas.Brush.Color := GetThemedBackColor;
    FCellBitmap.Canvas.FillRect(Rect(0, 0, FCellBitmap.Width,
                                FCellBitmap.Height));
  end;

  if (ACol = Col) and (ARow = Row) and
    (InplaceEditor <> nil) and InplaceEditor.Visible
  then
    ExcludeClipRect(Canvas.Handle, InplaceEditor.Left,
                    InplaceEditor.Top, InplaceEditor.Left +
                    InplaceEditor.Width, InplaceEditor.Top +
                    InplaceEditor.Height);

  Canvas.Draw(ARect.Left, ARect.Top, FCellBitmap);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.DrawGutter(ACanvas: TCanvas; ARect: TRect;
  AGutterLeft: Integer; AIsFirst: Boolean; AFirstParentGutterLeft: Integer;
  AIsLast: Boolean; ALastParentGutterLeft: Integer);
begin
  ACanvas.Brush.Color := GetThemedGutterColor;
  ACanvas.FillRect(Rect(ARect.Left, ARect.Top + 2 * Ord(AIsFirst),
    ARect.Left + AGutterLeft, ARect.Bottom - 3 * Ord(AIsLast)));

  if AIsFirst then
    ACanvas.FillRect(Rect(ARect.Left, ARect.Top,
      ARect.Left + AFirstParentGutterLeft + 2, ARect.Top + 2));

  if AIsLast then
  begin
    ACanvas.FillRect(Rect(ARect.Left + 0, ARect.Bottom - 1,
      ARect.Left + ALastParentGutterLeft + 2, ARect.Bottom - 3));
    ACanvas.FillRect(Rect(ARect.Left, ARect.Bottom,
      ARect.Left + ALastParentGutterLeft + 1, ARect.Bottom - 1));
  end;

  ACanvas.Pen.Color := GetThemedGutterLineColor;
  ACanvas.MoveTo(ARect.Left + AGutterLeft, ARect.Top + 3 * Ord(AIsFirst));
  ACanvas.LineTo(ARect.Left + AGutterLeft, ARect.Bottom - 4 * Ord(AIsLast));
  if AIsFirst then
  begin
    ACanvas.Pixels[ARect.Left + AFirstParentGutterLeft + 1, ARect.Top] := ACanvas.Pen.Color;
    ACanvas.MoveTo(ARect.Left + AFirstParentGutterLeft + 2, ARect.Top + 1);
    ACanvas.LineTo(ARect.Left + AGutterLeft - 1, ARect.Top + 1);
    ACanvas.Pixels[ARect.Left + AGutterLeft - 1, ARect.Top + 2] := ACanvas.Pen.Color;
  end;
  if AIsLast then
  begin
    ACanvas.Pixels[ARect.Left + ALastParentGutterLeft, ARect.Bottom - 1] := ACanvas.Pen.Color;
    ACanvas.Pixels[ARect.Left + ALastParentGutterLeft + 1, ARect.Bottom - 2] := ACanvas.Pen.Color;
    ACanvas.MoveTo(ARect.Left + ALastParentGutterLeft + 2, ARect.Bottom - 3);
    ACanvas.LineTo(ARect.Left + AGutterLeft - 1, ARect.Bottom - 3);
    ACanvas.Pixels[ARect.Left + AGutterLeft - 1, ARect.Bottom - 4] := ACanvas.Pen.Color;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.DoDrawCell(ACanvas: TCanvas;
  AWidth, AHeight: Integer; AItem: TLMDPropsPageItem; ACol, ARow: Longint;
  AState: TGridDrawState);

  procedure _DrawExpandButton(AX, AY: Integer; AExpanded: Boolean);
  const
    BTN_STYLE: array[Boolean] of TThemedTreeview = (ttGlyphClosed,
                                                    ttGlyphOpened);
  var
    LDetails: TThemedElementDetails;
  begin
    with ACanvas do
    begin
      if ThemeServices.ThemesEnabled then
      begin
        LDetails := ThemeServices.GetElementDetails(BTN_STYLE[AExpanded]);
        ThemeServices.DrawElement(Handle, LDetails, Rect(AX, AY, AX + 9,
                                                         AY + 9));
      end
      else
      begin
        Pen.Color   := clBlack;
        Brush.Color := clWhite;
        Rectangle(AX, AY, AX + 9, AY + 9);
        Polyline([Point(AX + 2, AY + 4), Point(AX + 7, AY + 4)]);
        if not AExpanded then
          Polyline([Point(AX + 4, AY + 2), Point(AX + 4, AY + 7)]);
      end;
    end;
  end;

  procedure _DrawCursor(AX, AY: Integer);
  begin
    with ACanvas do
      Draw(AX, AY, GetThemedCursor);
  end;

  procedure _GetFirstParentInfo(AItem: TLMDPropsPageItem; var AIsFirst: Boolean;
    var AFirstParentIdent: Integer);
  begin
    if AItem.IsFirst and (AItem.Parent <> nil) and
      not AItem.Parent.IsCategory then
      AFirstParentIdent := AItem.Parent.Ident
    else
      AFirstParentIdent := AItem.Ident;

    AIsFirst := (AFirstParentIdent <> AItem.Ident);
  end;

  procedure _GetLastParentInfo(AItem: TLMDPropsPageItem; var AIsLast: Boolean;
    var ALastParentIdent: Integer);
  begin
    if AItem.IsLast and (AItem.Parent <> nil) and not AItem.Expanded then
    begin
      ALastParentIdent := AItem.Ident;
      while AItem.Parent <> nil do
      begin
        ALastParentIdent := AItem.Parent.Ident;
        if not AItem.Parent.IsLast then
          Break;
        AItem := AItem.Parent;
      end;
    end
    else
      ALastParentIdent := AItem.Ident;

    AIsLast := (ALastParentIdent <> AItem.Ident);
  end;

var
  LS: TLMDString;
  LFirstParentIdent,
  LLastParentIdent,
  LGutterLeft,
  LFirstParentGutterLeft,
  LLastParentGutterLeft: Integer;
  LIsFirst,
  LIsLast: Boolean;
  LCaptionColor: TColor;

begin
  { Calculate draw info }

  if (ACol = 0) or AItem.IsCategory then
    LS := AItem.Caption
  else
    LS := AItem.DisplayValue;

  LCaptionColor := GetItemCaptionColor(AItem);
  _GetFirstParentInfo(AItem, LIsFirst, LFirstParentIdent);
  _GetLastParentInfo(AItem, LIsLast, LLastParentIdent);

  LGutterLeft := LMDPPTextIdent + AItem.Ident - 1;
  LFirstParentGutterLeft := LMDPPTextIdent + LFirstParentIdent - 1;
  LLastParentGutterLeft := LMDPPTextIdent + LLastParentIdent - 1;

  { Fill cell rect }

  ACanvas.Brush.Color := GetThemedBackColor;
  ACanvas.FillRect(Rect(0, 0, AWidth, AHeight));

  { Text rect }

  if AItem.IsCategory then
    ACanvas.Brush.Color := GetThemedCategoryBackColor
  else
    ACanvas.Brush.Color := GetThemedBackColor;

  ACanvas.Font := Self.Font;
  if AItem.IsCategory then
  begin
    ACanvas.Font       := FCategoryFont;
    ACanvas.Font.Color := GetThemedCategoryTextColor;
  end
  else if ACol = 0 then
    ACanvas.Font.Color := GetThemedCaptionTextColor(LCaptionColor)
  else
  begin
    ACanvas.Font.Color := GetThemedValueTextColor;
    if AItem.Highlighted then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
  end;

  if (ARow = Row) and (ACol = 0) and (FSelectionStyle = ssFlat) and
    not AItem.IsCategory then
  begin
    ACanvas.Brush.Color := FFlatSelectionBackgroundColor;
    ACanvas.Font.Color  := FFlatSelectionColor;
  end;

  LMDTextRect(ACanvas, Rect(0, 0, AWidth, AHeight - 1), 1 + (LMDPPTextIdent +
              AItem.Ident) * Ord(ACol = 0) - (ColWidths[0] - (LMDPPTextIdent +
              AItem.Ident)) * Ord((ACol = 1) and AItem.IsCategory), 1, LS);
  ACanvas.Font := Self.Font; // Restore font

  { Gutter }

  if FGutterVisible and (ACol = 0) then
    DrawGutter(ACanvas, Rect(0, 0, AWidth, AHeight), LGutterLeft, LIsFirst,
      LFirstParentGutterLeft, LIsLast, LLastParentGutterLeft);

  { Expand button }

  if AItem.CanExpand and (ACol = 0) then
    _DrawExpandButton(LMDPPExpandButtonX + AItem.Ident,
                      LMDPPExpandButtonY, AItem.Expanded);

  { Cursor }

  if FCursorVisible and not AItem.CanExpand and
     (ACol = 0) and (ARow = Row) then
    _DrawCursor(LMDPPExpandButtonX + AItem.Ident,
                LMDPPExpandButtonY);

  { Splitter }

  if (ACol = 0) and not AItem.IsCategory then
  begin
    if (FSelectionStyle = ssClassic) then
    begin
      ACanvas.Pen.Color := GetThemedSplitterColor(-5);//!!!clBtnShadow;
      ACanvas.Polyline([Point(AWidth - 2, 0), Point(AWidth - 2, AHeight)]);
      ACanvas.Pen.Color := GetThemedSplitterColor(+5);//!!!clBtnHighlight;
      ACanvas.Polyline([Point(AWidth - 1, 0), Point(AWidth - 1, AHeight)]);
    end
    else
    begin
      ACanvas.Pen.Color := GetThemedSplitterColor(0);
      ACanvas.Polyline([Point(AWidth - 1, 0), Point(AWidth - 1, AHeight)]);
    end;
  end;

  { Grid }

  if FGridVisible then
  begin
    UpdatePattern;
    if ACol = 0 then
      Windows.FillRect(ACanvas.Handle, Rect(((LGutterLeft + 1) *
                       Ord(not LIsLast) + (LLastParentGutterLeft + 1) *
                       Ord(LIsLast)) * Ord(FGutterVisible), AHeight - 1,
                       AWidth, AHeight), FBrush)
    else
      Windows.FillRect(ACanvas.Handle, Rect(0, AHeight - 1,
                       AWidth, AHeight), FBrush);
  end;

  { Selection }

  if FSelectionStyle = ssClassic then
  begin
    { Classic selection }

    if ARow = Row - 1 then
    begin
      ACanvas.Pen.Color := GetThemedSplitterColor(-10);// cl3DDkShadow
      ACanvas.Polyline([Point(0, AHeight - 2), Point(AWidth, AHeight - 2)]);
      ACanvas.Pen.Color := GetThemedSplitterColor(-5);// clBtnShadow
      ACanvas.Polyline([Point(0, AHeight - 1), Point(AWidth, AHeight - 1)]);
    end
    else if ARow = Row then
    begin
      if ACol = 0 then
      begin
        ACanvas.Pen.Color := GetThemedSplitterColor(-10);// cl3DDkShadow
        ACanvas.Polyline([Point(0, 0), Point(0, AHeight)]);
        ACanvas.Pen.Color := GetThemedSplitterColor(-5);// clBtnShadow
        ACanvas.Polyline([Point(1, 0), Point(1, AHeight)]);
      end;
      ACanvas.Pen.Color := GetThemedSplitterColor(+10);// clBtnHighlight
      ACanvas.Polyline([Point(0, AHeight - 2), Point(AWidth, AHeight - 2)]);
      ACanvas.Pen.Color := GetThemedSplitterColor(+5);// cl3DLight
      ACanvas.Polyline([Point(0, AHeight - 1), Point(AWidth, AHeight - 1)]);
    end;
  end
  else
  begin
    { Flat selection }

    if (ARow = Row) and (ACol = 1) and not AItem.IsCategory and
       not FGridVisible then
    begin
      ACanvas.Pen.Color := clBtnFace;
      UpdatePattern;
      Windows.FillRect(ACanvas.Handle, Rect(0, 0, AWidth, 1), FBrush);
      Windows.FillRect(ACanvas.Handle, Rect(0, AHeight - 2, AWidth,
                       AHeight - 1), FBrush);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.CanEditShow: Boolean;
begin
  Result := HandleAllocated and
    (ActiveItem <> nil) and (ActiveItem.ShowEditor);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.SelectCell(ACol, ARow: Integer): Boolean;
begin
  FlushEditTextBuf;
  Result := inherited SelectCell(ACol, ARow);
  InvalidateRow(FOldRow - 1);
  InvalidateRow(FOldRow);
  InvalidateRow(FOldRow + 1);
  InvalidateRow(ARow - 1);
  InvalidateRow(ARow);
  InvalidateRow(ARow + 1);
  FOldRow := ARow;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.CreateEditor: TInplaceEdit;
begin
  Result := TLMDPropsPageInplaceEdit.Create(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.Paint;
var
  LGutterLeft, LY: Integer;
  LNeedPaint:      Boolean;
  LCellRect:       TRect;
begin
  inherited;

  LCellRect := CellRect(Col, Row);
  if LCellRect.Left <= LCellRect.Right then // For low prop-page width.
    DrawCell(Col, Row, LCellRect, []);

  if FGutterVisible then
  begin
    LNeedPaint := True;
    if (RowCount > 0) and (ItemByRow(RowCount - 1) <> nil) then
    begin
      LY := CellRect(0, RowCount - 1).Bottom;
      LNeedPaint := (LY > 0) and (LY < Height);
    end
    else
      LY := 0;

    if LNeedPaint then
    begin
      LGutterLeft := LMDPPTextIdent - 1;
      DrawGutter(Canvas, Rect(0, LY, Width, Height),
        LGutterLeft, False, 0, False, 0);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := True;
  if TopRow < RowCount - VisibleRowCount then
    TopRow := TopRow + 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := True;
  if TopRow > FixedRows then
    TopRow := TopRow - 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.GetEditStyle(
  ACol, ARow: Integer): TLMDEditStyle;
var
  LItem: TLMDPropsPageItem;
begin
  LItem := ItemByRow(ARow);
  if LItem <> nil then
    Result := LItem.EditStyle
  else
    Result := esSimple;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.CanEditModify: Boolean;
begin
  Result := (ActiveItem <> nil) and not ActiveItem.ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.GetEditText(ACol,
  ARow: Integer): {$IFDEF _LMD_UNICODEIMPL}TLMDString{$ELSE}string{$ENDIF};
var
  LItem: TLMDPropsPageItem;
begin
  LItem  := ItemByRow(ARow);
  Result := '';

  if (ACol = 1) and (LItem <> nil) then
    Result := GetEditTextBuf(LItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SetEditText(ACol, ARow: Integer;
  const Value: {$IFDEF _LMD_UNICODEIMPL}TLMDString{$ELSE}string{$ENDIF});
var
  LItem: TLMDPropsPageItem;
begin
  LItem := ItemByRow(ARow);

  if (ACol = 1) and (LItem <> nil) and
     not (ppsUpdatingEditorContent in FState) then
    SetEditTextBuf(Value, LItem)
  else
    SetEditTextBuf('', nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CreateHandle;
begin
  inherited;
  UpdateScrollBar;
  InvalidateEditor;
  UpdateColWidths;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.DblClick;
var
  LGridCoord: TGridCoord;
  LItem: TLMDPropsPageItem;
  LP: TPoint;
begin
  GetCursorPos(LP);
  LP := ScreenToClient(LP);
  LGridCoord := MouseCoord(LP.X, LP.Y);
  if PtInRect(ClientRect, LP) and
    (LGridCoord.X = 0) and (LGridCoord.Y <> -1) then
    begin
      LItem := ItemByRow(LGridCoord.Y);
      if (LItem <> nil) then
        begin
          Row := LGridCoord.Y;
          if LItem.Expanded then
            LItem.Collapse
          else
            LItem.Expand;
        end;
    end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  LGridCoord: TGridCoord;
  LCellRect: TRect;
  LItem: TLMDPropsPageItem;
begin
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
    begin
      SetFocus;
      if (GetParentForm(Self) = nil) or
        (GetParentForm(Self).ActiveControl <> Self) then
        begin
          MouseCapture := False;
          Exit;
        end;
    end;

  if ssDouble in Shift then
    begin
      DblClick;
      if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);
    end
  else if Button = mbLeft then
    begin
      if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);
      if IsOnSplitter(X) then
        begin
          Include(FState, ppsMovingSplitter);
          FSplitterOffset := X - ColWidths[0];
        end
      else
        begin
          LGridCoord := MouseCoord(X, Y);
          if (LGridCoord.X <> -1) and (LGridCoord.Y <> -1) and
            PtInRect(ClientRect, Point(X, Y)) then
            begin
              Row := LGridCoord.Y;
              if LGridCoord.X = 0 then
                begin
                  LCellRect := CellRect(LGridCoord.X, LGridCoord.Y);
                  LItem := ItemByRow(LGridCoord.Y);
                  if (LItem <> nil) and LItem.CanExpand and LItem.IsOnExpandButton(X) then
                    begin
                      if LItem.Expanded then
                        LItem.Collapse
                      else
                        LItem.Expand;
                    end
                  else
                    Include(FState, ppsScrollingByMouse);
                end
              else
                Include(FState, ppsScrollingByMouse);
            end;
        end;
    end
  else
    if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  LGridCoord: TGridCoord;
begin
  inherited;
  if ppsMovingSplitter in FState then
    begin
      CancelToolTip;
      Splitter := X - FSplitterOffset;
    end
  else
    begin
      LGridCoord := MouseCoord(0, Y); // X coordinate is not used. This
                                      // allows to move mouse (with left
                                      // button down) outside the client
                                      // rectangle
      if MouseCapture and (ppsScrollingByMouse in FState) and
        (LGridCoord.Y >= 0) and (LGridCoord.Y < TopRow + VisibleRowCount) then
        Row := LGridCoord.Y;
      UpdateToolTip;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  LForm: TCustomForm;
begin
  inherited;
  if ppsMovingSplitter in FState then
    if csDesigning in ComponentState then
      begin
        LForm := GetParentForm(Self);
        if (LForm <> nil) and (LForm.Designer <> nil) then LForm.Designer.Modified;
      end;
  Exclude(FState, ppsMovingSplitter);
  Exclude(FState, ppsScrollingByMouse);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.TopLeftChanged;
begin
  inherited;
  UpdateScrollBar;
  UpdateToolTip;
  InvalidateEditor;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.SizeChanged(OldColCount, OldRowCount: Integer);
begin
  inherited;
  AdjustTopRow;
  UpdateScrollBar;
  UpdateToolTip;
  InvalidateEditor;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.DoExit;
begin
  // Do not call inherited.
  if Assigned(OnExit) then OnExit(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.BeginDestruction;
begin
  Include(FState, ppsDestroying);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.CreateItem(AParent: TLMDPropsPageItem): TLMDPropsPageItem;
begin
  Result := TLMDPropsPageItem.Create(Self, AParent);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.ItemDestroying(AItem: TLMDPropsPageItem);
begin
  // Do nothing.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.ItemExpanded(AItem: TLMDPropsPageItem);
begin
  if Assigned(OnExpanded) then OnExpanded(Self, AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.ItemCollapsed(AItem: TLMDPropsPageItem);
begin
  if Assigned(OnCollapsed) then OnCollapsed(Self, AItem);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.GetItemCaptionColor(
  AItem: TLMDPropsPageItem): TColor;
begin
  Result := Font.Color;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDCustomPropsPage.Create(AOwner: TComponent);
begin
  inherited;
  Width := 188;
  Height := 193;
  DefaultColWidth := 84;
  DefaultRowHeight := 16;
  ColCount := 2;
  RowCount := 0;
  FixedRows := 0;
  FixedCols := 1;
  Color := clBtnFace;
  Options := [goEditing, goThumbTracking];
  DesignOptionsBoost := [];
  FSaveCellExtents := False;
  ScrollBars := ssNone;
  DefaultDrawing := False;
  FCategoryFont := TFont.Create;
  FCategoryFont.Style := [fsBold];
  FCategoryFont.Color := clHighlightText;
  FCategoryFont.OnChange := CategoryFontChanged;
  FItems := TLMDPropsPageItems.Create(Self);
  FValuesColor := clNavy;
  FGridPattern := Graphics.TBitmap.Create;
  UpdatePattern(True);
  FCellBitmap := Graphics.TBitmap.Create;
  FCellBitmap.Canvas.Font := Canvas.Font;
  FToolTips := True;
  FGridVisible := True;
  FGridColor := clBtnShadow;
  FGutterColor := clCream;
  FGutterLineColor := clBtnShadow;
  FFlatSelectionBackgroundColor := clHighlight;
  FFlatSelectionColor := clHighlightText;
  FFlatSplitterColor := clGray;
  FCatergoryBackgroundColor := clHighlight;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomPropsPage.Destroy;
begin
  BeginDestruction;
  CancelToolTip;
  FItems.Free;
  FGridPattern.Free;
  FCellBitmap.Free;
  FCursorBitmap.Free;
  FCategoryFont.Free;
  if FBrush <> 0 then
    DeleteObject(FBrush);
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.EndUpdate;
begin
  Dec(FUpdateCount);
  if (FUpdateCount <= 0) and (ppsChanged in FState) then
    ItemsChange;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.CanCopyToClipboard: Boolean;
begin
  Result := (InplaceEditor <> nil) and (InplaceEditor.SelText <> '') and
            (ItemByRow(Row) <> nil) and not ItemByRow(Row).IsCategory;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.CanCutToClipboard: Boolean;
begin
  Result := (InplaceEditor <> nil) and (InplaceEditor.SelText <> '') and
            (ItemByRow(Row) <> nil) and not ItemByRow(Row).IsCategory
            and not ItemByRow(Row).ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.CanPasteFromClipboard: Boolean;
begin
  Result := (InplaceEditor <> nil) and (ItemByRow(Row) <> nil) and
            not ItemByRow(Row).IsCategory and not ItemByRow(Row).ReadOnly and
            Clipboard.HasFormat(CF_TEXT);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CutToClipboard;
begin
  if CanCutToClipboard then
    InplaceEditor.CutToClipboard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.CopyToClipboard;
begin
  if CanCopyToClipboard then
    InplaceEditor.CopyToClipboard;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.PasteFromClipboard;
begin
  if CanPasteFromClipboard then
    InplaceEditor.PasteFromClipboard;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.SaveState: TLMDPropPageStateObject;

  procedure _SaveExpanded(AParent: TLMDPropsPageItem;
                          ARItems: PLMDRestoreItems);
  var
    LI: Integer;
  begin
    for LI := 0 to AParent.Count - 1 do
      if AParent[LI].Expanded then
        begin
          SetLength(ARItems^, Length(ARItems^) + 1);
          with ARItems^[High(ARItems^)] do
            begin
              Caption := AParent[LI].Caption;
              New(PLMDRestoreItems(Items));
              _SaveExpanded(AParent[LI], Items);
            end;
        end;
  end;

var
  LI: Integer;
  LItem: TLMDPropsPageItem;

begin
  Result := TLMDPropPageStateObject.Create;
  try

    { Save expanded items }

    for LI := 0 to Items.Count - 1 do
      if Items[LI].Expanded then
        begin
          SetLength(Result.FExpandedInfo, Length(Result.FExpandedInfo) + 1);
          with Result.FExpandedInfo[High(Result.FExpandedInfo)] do
            begin
              Caption := Self.Items[LI].Caption;
              New(PLMDRestoreItems(Items));
              _SaveExpanded(Self.Items[LI], Items);
            end;
        end;

    { Save active item }

    LItem := ActiveItem;
    while LItem <> nil do
      begin
        SetLength(Result.FActiveItemInfo, Length(Result.FActiveItemInfo) + 1);
        with Result.FActiveItemInfo[High(Result.FActiveItemInfo)] do
          Caption := LItem.Caption;
        LItem := LItem.Parent;
      end;
  except
    Result.Free;
    raise;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropsPage.RestoreState(
  AStateObject: TLMDPropPageStateObject; AFreeStateObject: Boolean);

  procedure _Expand(AParent: TLMDPropsPageItem; ARItems: PLMDRestoreItems);
  var
    LI: Integer;
    LItem: TLMDPropsPageItem;
  begin
    for LI := 0 to High(ARItems^) do
      begin
        LItem := AParent.Find(ARItems^[LI].Caption);
        if LItem <> nil then
          begin
            LItem.Expand;
            if ARItems^[LI].Items <> nil then
              _Expand(LItem, ARItems^[LI].Items);
          end;
      end;
  end;

var
  LI: Integer;
  LItem, LTmpItem: TLMDPropsPageItem;

begin
  { Try restore expanded items }

  for LI := 0 to High(AStateObject.FExpandedInfo) do
    begin
      LItem := Items.Find(AStateObject.FExpandedInfo[LI].Caption);
      if LItem <> nil then
        begin
          LItem.Expand;
          if AStateObject.FExpandedInfo[LI].Items <> nil then
            _Expand(LItem, AStateObject.FExpandedInfo[LI].Items);
        end;
    end;

  { Try restore active item }

  LItem := nil;
  for LI := High(AStateObject.FActiveItemInfo) downto 0 do
    begin
      if LI = High(AStateObject.FActiveItemInfo) then
        LTmpItem := Items.Find(AStateObject.FActiveItemInfo[LI].Caption)
      else
        LTmpItem := LItem.Find(AStateObject.FActiveItemInfo[LI].Caption);
      if LTmpItem <> nil then
        LItem := LTmpItem
      else
        Break;
    end;

  { Try to find default property item }

  if (LItem = nil) and (DefaultPropName <> '') then
    LItem := Items.Find(DefaultPropName);
  if LItem <> nil then
    LItem.Active := True
  else if Items.Count > 0 then
    Items[0].Active := True;

  { Free state object }

  if AFreeStateObject then
    AStateObject.Free;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.ItemAtPos(AX, AY: Integer): TLMDPropsPageItem;
var
  LGridCoord: TGridCoord;
begin
  if PtInRect(ClientRect, Point(AX, AY)) then
    begin
      LGridCoord := MouseCoord(AX, AY);
      if (LGridCoord.X <> -1) and (LGridCoord.Y <> -1) then
        Result := ItemByRow(LGridCoord.Y)
      else
        Result := nil;
    end
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropsPage.GetHitTestInfoAt(AX,
  AY: Integer): TLMDPropsPageHitTests;
var
  LGridCoord: TGridCoord;
  LItem: TLMDPropsPageItem;
  LOnSplitter: Boolean;
begin
  Result := [];
  if PtInRect(ClientRect, Point(AX, AY)) then
    begin
      LOnSplitter := IsOnSplitter(AX);
      LGridCoord := MouseCoord(AX, AY);
      if (LGridCoord.X <> -1) and (LGridCoord.Y <> -1) then
        begin
          LItem := ItemByRow(LGridCoord.Y);
          if LItem <> nil then
            begin
              Include(Result, htOnItem);
              if LItem.CanExpand and LItem.IsOnExpandButton(AX) then
                Include(Result, htOnExpandButton);
              if not LOnSplitter then
                begin
                  if LGridCoord.X = 0 then
                    Include(Result, htOnCaption)
                  else if LGridCoord.X = 1 then
                    Include(Result, htOnValue);
                end;
            end;
        end;
      if LOnSplitter then
        Include(Result, htOnSplitter);
    end;
end;

end.
