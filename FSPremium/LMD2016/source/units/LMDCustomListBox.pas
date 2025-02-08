unit LMDCustomListBox;
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

LMDCustomListBox unit (RM)
--------------------------
Base class for all LMD listboxes.

Changes
-------
Release 9.0 (June 2008)
 - ThemeMode introduced

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Controls, Classes, Forms, Messages, Graphics, StdCtrls, ExtCtrls, Themes,
  intfLMDBackground, LMDBoundLabel, LMDClass, LMDCont, LMDGraph,
  LMDVldBase, LMD3DCaption, LMDTypes, LMDBase;

type
  TLMDListBoxEditOptions=set of (lboAllowDelete, lboAllowEdit, lboAllowInsert, lboNo3DFrame, lboSelectText);
  TLMDListBoxLargeTextOptions=(lbltNone, lbltEndEllipsis, lbltPathEllipsis, lbltHorzScrollBar,
                               lbltShowHint);

const
  def_ListBoxEditOptions = [];

type

  TLMDListBoxEditShowEvent    = procedure(Sender: TObject; Index: Integer;
                                          var Cancel: Boolean) of object;
  TLMDListBoxEditMeasureEvent = procedure(Sender: TObject; Index: Integer;
                                          var Height: Integer) of object;
  TLMDListBoxEditChangeEvent  = procedure(Sender: TObject; Index: Integer)
                                          of object;

  TLMDCustomListBoxEdit = class(TMemo);

  {--------------------- TLMDCustomListBox -------------------------------------}
  TLMDCustomListBox=class(TCustomListBox, ILMDBackground, ILMDValidatingMsgControl)
  private
    FAbout:TLMDAboutVar;
    //4.0
    FMultiLine:Boolean;
    FFont3D:TLMD3DCaption;
    FLast:Integer;
    FTransparent:Boolean;
    FOnSelect : TNotifyEvent;

    // 6.1 - Edit Support
    FEditOptions:TLMDListBoxEditOptions;
    FEditIndex:Integer;
    FOnEditShow:TLMDListBoxEditShowEvent;
    FOnEditMeasure:TLMDListBoxEditMeasureEvent;
    FOnEditChange:TLMDListBoxEditChangeEvent;
    FOnEditHide:TNotifyEvent;

    // LMD-Tools 6.0
    FVertical,
    FMouseOver,
    FFlat,
    FHideFocus,
    FHorzGridline:Boolean;
    FDisabledColor,
    FSelectedColor,
    FSelectedFontColor,
    FHorzGridColor:TColor;
    FHorzGridStyle:TPenStyle;
    FHorzWidth:Integer;

    // 6.1
    FHideSelection: Boolean;
    FEdit:TLMDCustomListBoxEdit;
    FLargeTextOptions:TLMDListBoxLargeTextOptions;
    FMargin:Byte;
    FSelectedFontStyle:TFontStyles;
    FHintWindow:THintWindow;
    FVirtual:Boolean;
    FAutoHeight:Boolean;

    // 7.0
    FBeveledFocus:Boolean;
    FBevelFocusLightColor,
    FBevelFocusDarkColor:TColor;

    //support of bound labels, JH April 02
    // ------------------------------------------
    FEditLabel    : TLMDBoundLabel;
    FHasBoundLabel: Boolean;
    FLabelPosition: TLabelPosition;
    FLabelSync    : Boolean;
    FLabelSpacing : Integer;
    FMeasureItem  : Boolean;
    FParentThemeMode: Boolean;
    FThemeMode: TLMDThemeMode;
    FThemeGlobalMode: Boolean;

    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetHasLabel(aValue: Boolean);
    procedure SetLabelSync(const Value: Boolean);
    // 7.0
    procedure ReadEditLabel(Stream: TStream);
    procedure ReadCtlXP(Reader: TReader);
    // ------------------------------------------

    function  GetHintWindow:THintWindow;
    procedure CancelHint;
    procedure FreeHintWindow;
    procedure SetListBoxEditOptions(const aValue:TLMDListBoxEditOptions);
    procedure SetListBoxLargeTextOptions(const aValue:TLMDListBoxLargeTextOptions);
    procedure SetMargin(const aValue:Byte);
    procedure SetMultiline(aValue:Boolean);
    //4.0
    procedure SetAutoHeight(aValue:Boolean);
    //--

    //6.0
    procedure SetHideSelection(const aValue:Boolean);
    procedure SetFlat(const aValue:Boolean);
    procedure SetVerticalScrollBar(const aValue:Boolean);
    procedure SetVirtualMode(const aValue:Boolean);
    procedure SetHorzGridline(const aValue:Boolean);
    procedure SetHorzGridColor(const aValue:TColor);
    procedure SetSelectedFontColor(const aValue:TColor);
    procedure SetSelectedColor(const aValue:TColor);
    procedure SetDisabledColor(const aValue:TColor);
    procedure SetHideFocus(const aValue:Boolean);
    procedure SetHorzGridStyle(const aValue:TPenStyle);
    procedure SetSelectedFontStyle(const aValue:TFontStyles);
    //--
    procedure SetTransparent(aValue:Boolean);
    procedure SetFont3D(aValue:TLMD3DCaption);
    // LMD-Tools 6.0
    procedure DrawBorder;
    procedure SetHorzExtent;
    //---

    // LMD-Tools 6.01, internal edit control
    procedure DoOnEditExit (Sender : TObject);
    procedure DoOnEditKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MeasureListBoxItems;

    // ---
    procedure SetBeveledFocus(const Value: Boolean);
    procedure SetBevelFocusDarkColor(const Value: TColor);
    procedure SetBevelFocusLightColor(const Value: TColor);

    // 6.1
    procedure CMLMDThemeChanged(var Message: TMessage); message CM_LMDTHEMECHANGED;
    procedure WMThemeChanged(var Msg:TMessage); message WM_THEMECHANGED;
    // --

    //7.0
    procedure SetMeasureItem(const Value: Boolean);
    procedure SetListBoxStyle;
    //---

    // CtlXP --> 9.0
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetThemeGlobalMode(const Value: Boolean);
    function get_CtlXP: Boolean;
    procedure set_CtlXP(aValue:Boolean);
    // --
    // 7.0
    procedure CMLMDBOUNDLABELCHANGE(var Message: TMessage); message CM_LMDBOUNDLABELCHANGE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    // --

    procedure CMLMDSCROLLBOXSCROLLEVENT (var Message : TMessage); message CM_LMDSCROLLBOXSCROLLEVENT;
    procedure CMMouseEnter(var Message:TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message:TMessage); message CM_MOUSELEAVE;
    procedure CNDrawItem(var Message:TWMDrawItem); message CN_DRAWITEM;
    procedure LBGetTopIndex(var Message:TMessage); message LB_GETTOPINDEX;
    procedure WMKillFocus(var Message:TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message:TWMPaint); message WM_PAINT;
    procedure WMSize(var Message:TWMSize); message WM_SIZE;
    procedure WMSetFocus(var Message:TWMSetFocus); message WM_SETFOCUS;
    procedure WMSetCursor(var Message:TWMSetCursor); message WM_SETCURSOR;
    procedure WMMove(var Message:TWMMove); message WM_MOVE;
    procedure WMNCHitTest(var Message:TWMNCHitTest); message WM_NCHITTEST;
    procedure WMEraseBkgnd(var Message:TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    // Transparency Support
    function CheckOptimized:Boolean;
    procedure RestoreBack(const tmp:TRect);

     // LMD-Tools 6.0 - functions for specifying width and height of an item
    procedure GetChange(Sender:TObject);virtual;
    procedure InitHorzExtent;
    function GetHorzExtent(index:Integer):Integer; virtual;
    function ItemVisible(index:Integer):Boolean;
    function IsHintWindowActive:Boolean;

    function MeasureItemHeights(aVisibleOnly: boolean; aSetHeight: boolean = true): integer; virtual;

    // overwrite if any settings do not allow edit mode;
    function CanEdit:Boolean;virtual;
    // overwrite for special items in descendant classes
    function GetEditRect(index:Integer):TRect;virtual;
    // returns real string to be drawn
    function GetStringValue(index:Integer):String;virtual;

    // XP Support
    // UseThemeMode returns active theme, depending on global settings etc.
    function UseThemeMode: TLMDThemeMode;
    //handle theme changes
    procedure DoThemeChanged; virtual;
    function  GetThemedBkColor: TColor;
    function  GetThemedTextColor: TColor;

    procedure CreateParams(var Params: TCreateParams);  override;
    procedure CreateWnd;override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure DoSelect; virtual;

    function  GetFieldValue: Integer; virtual;
    procedure KeyDown(var Key:Word;Shift:TShiftState);override;
    procedure Loaded; override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    procedure WndProc(var Message: TMessage);override;

    procedure EnterEditMode(const NewItem:Boolean=false; Index:Integer=-1);virtual;
    procedure CancelEditMode;virtual;

    procedure SetupEditLabel;
    //

    // 7.0 -----------------------------------------------
    //support of bound label, April 02
    procedure SetName(const Value: TComponentName); override;
    procedure SetParent(AParent: TWinControl); override;

    //procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;
    procedure DefineProperties(Filer:TFiler);override;
    // ---
    property EditLabel: TLMDBoundLabel read FEditLabel;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
    property HasBoundLabel: Boolean read FHasBoundLabel write SetHasLabel;
    //----------------------------------------------------
    property Count;
    property VirtualMode:Boolean read FVirtual write SetVirtualMode default false;
  public
    constructor Create(AOwner: TComponent); override;
    function IsThemed: Boolean; // any other than ttmNone
    procedure ClearSelection; override;
    destructor Destroy; override;
    procedure MoveHorz(flag:Word);
    // Edit operations
    procedure DeleteSelected; override;
    // 7.0
    function BackBitmap: TBitmap; virtual;
    function BackBitmapCheck: Boolean; virtual;
    function  BackDrawArea(Canvas: TCanvas; const dest: TRect; const src: TPoint;
                           flags: Word=0): Boolean; virtual;
    function  isTransparentSet: Boolean;
    function  BackMapPoint(const aValue: TPoint): TPoint; virtual;
    function  BackBitmapPalette: HPalette; virtual;
    procedure BackUpdate;
    function  BackControl (index: Integer): TControl; virtual;
    function  BackControlCount: Integer; virtual;
    // ----
    //support of bound label, JH April 02
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    //---
    procedure AddItemByEditor;
    procedure DisplayEditor(const Index:Integer);
    procedure HideEditor;

    property ScrollWidth:Integer read FHorzWidth; // in Delphi 6: Overwrite ScrollWidth
    property StringValue[Index:Integer]:String read GetStringValue;

    property ItemAutoHeight:Boolean read FAutoHeight write SetAutoHeight default false;
    property EditOptions:TLMDListBoxEditOptions read FEditOptions write SetListBoxEditOptions default def_ListBoxEditOptions;
    property LargeTextOptions:TLMDListBoxLargeTextOptions read FLargeTextOptions write SetListBoxLargeTextOptions default lbltNone;
    property MultiLine:Boolean read FMultiline write SetMultiline default false;

      // Event for internal edit control
    property EditControl:TLMDCustomListBoxEdit read FEdit;
    property OnEditShow: TLMDListBoxEditShowEvent read FOnEditShow write FOnEditShow;
    property OnEditMeasure:TLMDListBoxEditMeasureEvent read FOnEditMeasure write FOnEditMeasure;
    property OnEditChange:TLMDListBoxEditChangeEvent read FOnEditChange write FOnEditChange;
    property OnEditHide:TNotifyEvent read FOnEditHide write FOnEditHide;

    property Canvas;
    property Text;

    property CtlXP:Boolean read get_CtlXP write set_CtlXP;  // compatibility only

    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    //new V9
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;

    //bounded label support, April 02, JH
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSync:Boolean read FLabelSync write SetLabelSync default false;

    //Validation support, May 2006, RS
    procedure SetErrorMessage(val : TLMDString; errorLevel: integer);
    function GetLastErrorMessage : TLMDString;
  published
    property MultiSelect;

    // 7.0
    property BeveledFocus:Boolean read FBeveledFocus write SetBeveledFocus default false;
    property BevelFocusShadowColor:TColor read FBevelFocusDarkColor write SetBevelFocusDarkColor default clGray;
    property BevelFocusLightColor:TColor read FBevelFocusLightColor write SetBevelFocusLightColor default clWhite;
    property MeasureItemEvent:Boolean read FMeasureItem write SetMeasureItem default false;
    // ---

    property About:TLMDAboutVar read FAbout write FAbout;
    property Font3D:TLMD3DCaption read FFont3D write SetFont3D;
    property Transparent:Boolean read FTransparent write SetTransparent default false;

    // 6.1
    property HideSelection:Boolean read FHideSelection write SetHideSelection default false;
    property Margin:Byte read FMargin write SetMargin default 1;
    property HorzGridColor:TColor read FHorzGridColor write SetHorzGridColor default clSilver;
    property HorzGridStyle:TPenStyle read FHorzGridStyle write SetHorzGridStyle default psSolid;
    property HorzGridLine:Boolean read FHorzGridline write SetHorzGridline default false;
    property VerticalScrollBar:Boolean read FVertical write SetVerticalScrollBar default true;
    // 6.0
    property Flat:Boolean read FFlat write SetFlat default false;
    property SelectedColor:TColor read FSelectedColor write SetSelectedColor default clHighlight;
    property DisabledColor:TColor read FDisabledColor write SetDisabledColor default clWindow;
    property SelectedFontColor:TColor read FSelectedFontColor write SetSelectedFontColor default clHighlightText;
    property SelectedFontStyle:TFontStyles read FSelectedFontStyle write SetSelectedFontStyle default [];
    property HideFocus:Boolean read FHideFocus write SetHideFocus default false;
    // 4.0
    // ---
    property Align;
    property BorderStyle;
    property Ctl3D;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    //property TabWidth;
    property Visible;

    {Events}
    property OnSelect : TNotifyEvent read FOnSelect write FOnSelect;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
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
    property OnStartDrag;
    property OnContextPopup;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

implementation

uses
  Types, Variants, SysUtils, TypInfo, LMDProcs, LMDUtils, LMDStrings,
  LMDGraphUtils, LMDCustomControl, LMDCustomScrollBox, LMDThemes;

{******************* Class TLMDCustomListBox **********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomListBox.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if not Assigned(FEditLabel) then exit;
  FLabelPosition := Value;
  if [csLoading, csReading]*ComponentState<>[] then exit;

  case Value of
    lpAbove: P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
    lpBelow: P := Point(Left, Top + Height + FLabelSpacing);
    lpLeft : P := Point(Left - FEditLabel.Width - FLabelSpacing, Top);
    lpRight: P := Point(Left + Width + FLabelSpacing, Top);
  end;
  if not FLabelSync then
    FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height)
  else
    if Value in [lpAbove, lpBelow] then
      FEditLabel.SetBounds(P.x, P.y, self.Width, FEditLabel.Height)
    else
      FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, self.Height);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.SetLabelSync(const Value: Boolean);
begin
  if FLabelSync<>Value then
    begin
      FLabelSync := Value;
      if FLabelSync then
        if Assigned(FEditLabel) and FEditLabel.AutoSize then
          FEditLabel.AutoSize:=false;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.SetHasLabel(aValue: Boolean);
begin
  if aValue <> FHasBoundLabel then
    if aValue then
      SetupEditLabel
    else
      begin
        FreeAndNil(FEditLabel);
        FHasBoundLabel:=false;
      end;
end;

  // 7.0
{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.ReadEditLabel(Stream:TStream{Reader});
begin
  Stream.ReadComponent(FEditLabel);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.ReadCtlXP(Reader: TReader);
begin
  Set_CtlXP(Reader.ReadBoolean);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.CMLMDBOUNDLABELCHANGE(var Message: TMessage);
begin
  LabelPosition:=LabelPosition;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  if Assigned (FEditLabel) then
    FEditLabel.Visible := Visible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.CMBiDiModeChanged(var Message: TMessage);
begin
  inherited;
  if Assigned (FEditLabel) then
    FEditLabel.BiDiMode := BiDiMode;
end;

// ----------------------------------------------------------------------------
procedure TLMDCustomListBox.SetFlat(const aValue:Boolean);
begin
  if FFlat<>aValue then
    begin
      FFlat:=aValue;
      RecreateWnd;
    end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetHideSelection(const aValue:Boolean);
begin
  if FHideSelection<>aValue and not MultiSelect then
    begin
      FHideSelection:=aValue;
        Invalidate;
    end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomListBox.set_CtlXP(aValue:Boolean);
begin
  if aValue <> Get_CtlXP then
    ThemeMode := LMDCtlXP[aValue];
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetVerticalScrollBar(const aValue:Boolean);
begin
  if FVertical<>aValue then
    begin
      FVertical:=aValue;
      RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetVirtualMode(const aValue:Boolean);
begin
  if FVirtual<>aValue then
  begin
    FVirtual := aValue;
    if FVirtual then
      Style := lbVirtualOwnerDraw
    else
      if FAutoHeight then
        Style := lbOwnerDrawVariable
      else
        Style := lbOwnerDrawFixed;
    ReCreateWnd;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetHorzGridline(const aValue:Boolean);
begin
  if aValue<>FHorzGridline then
    begin
      FHorzGridline:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetHorzGridColor(const aValue:TColor);
begin
  if aValue<>FHorzGridColor then
    begin
      FHorzGridColor:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetHideFocus(const aValue:Boolean);
begin
  if aValue<>FHideFocus then
    begin
      FHideFocus:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetSelectedColor(const aValue:TColor);
begin
  if aValue<>FSelectedColor then
    begin
      FSelectedColor:=aValue;
      if not (csDesigning in ComponentState) then
        Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetDisabledColor(const aValue:TColor);
begin
  if aValue<>FDisabledColor then
    begin
      FDisabledColor:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetSelectedFontColor(const aValue:TColor);
begin
  if aValue<>FSelectedFontColor then
    begin
      FSelectedFontColor:=aValue;
      if not (csDesigning in ComponentState) then
        Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetSelectedFontStyle(const aValue:TFontStyles);
begin
  if aValue<>FSelectedFontStyle then
    begin
      FSelectedFontStyle:=aValue;
      if not (csDesigning in ComponentState) then
        Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetHorzGridStyle(const aValue:TPenStyle);
begin
  if aValue<>FHorzGridStyle then
    begin
      FHorzGridStyle:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      if UseThemeMode <> FThemeMode then  // if thememode stays the same, no update required
        DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
    begin
      FThemeMode := Value;
      if not FThemeGlobalMode then       // if we are in GlobalThemeMode, no update required
        DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetTransparent(aValue:Boolean);
begin
  if aValue<>FTransparent then
    begin
      FTransparent:=aValue;
      if FTransparent then
        ControlStyle:=ControlStyle-[csOpaque]
      else
        ControlStyle:=ControlStyle+[csOpaque];
      RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetMargin(const aValue:Byte);
begin
  if FMargin<>aValue then
    begin
      FMargin:=aValue;
      Refresh;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.SetMeasureItem(const Value: Boolean);
begin
  if FMeasureItem<>Value then
    begin
      FMeasureItem := Value;
      SetListBoxStyle;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetMultiline(aValue:Boolean);
begin
  if aValue<>FMultiline then
    begin
      FMultiline:=aValue;
      // Mulltiline and Horzscrollbar not possible at same time
      If FMultiline then
        if FLargeTextOptions<>lbltNone then
          FLargeTextOptions:=lbltNone;
      RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetAutoHeight(aValue:Boolean);
begin
  if aValue<>FAutoHeight then
    begin
      FAutoHeight:=aValue;
      SetListBoxStyle;
    end;
end;

// 7.0
{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetBeveledFocus(const Value: Boolean);
begin
  if FBeveledFocus<>Value then
    begin
      FBeveledFocus:=Value;
      if not (csLoading in ComponentState) and Focused then
        Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetBevelFocusDarkColor(const Value: TColor);
begin
  if value<>FBevelFocusDarkColor then
    begin
      FBevelFocusDarkColor := Value;
      if FBeveledFocus and Focused then
        Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetBevelFocusLightColor(const Value: TColor);
begin
  if value<>FBevelFocusLightColor then
    begin
     FBevelFocusLightColor := Value;
     if FBeveledFocus and Focused then
       Invalidate;
    end;
end;

// 6.01
{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetListBoxEditOptions(const aValue:TLMDListBoxEditOptions);
begin
  if aValue<>FEditOptions then
    begin
      FEditOptions:=aValue;
      If (csDesigning in ComponentState) and (FEdit<>nil) then
        CancelEditMode;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetListBoxLargeTextOptions(const aValue:TLMDListBoxLargeTextOptions);
begin
  if aValue<>FLargeTextOptions then
    begin
      FLargeTextOptions:=aValue;
      If (FLargeTextOptions<>lbltNone) and FMultiline then
        FMultiline:=false;
      FHorzWidth:=0;
      RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetListBoxStyle;
begin
  if FAutoHeight or FMeasureItem then
    begin
      if FVirtual then
        Style:=lbVirtualOwnerDraw
      else
        inherited Style:=lbOwnerDrawVariable;
    end
  else
     if FVirtual then
       Style:=lbVirtualOwnerDraw
     else
       inherited Style:=lbOwnerDrawFixed;
  if not (csLoading in ComponentState) then
    RecreateWnd;

end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListBox.get_CtlXP: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.GetHintWindow:THintWindow;
begin
  if FHintWindow=nil then
    begin
      FHintWindow:=HintWindowClass.Create(self);
      FHintWindow.Color:=Application.HintColor;
    end;
  result:=FHintWindow;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CancelHint;
begin
  if Assigned(FHintWindow) then FHintWindow.ReleaseHandle;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.IsHintWindowActive:Boolean;
begin
 result:=Assigned(FHintWindow) and FHintWindow.HandleAllocated;
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomListBox.FreeHintWindow;
begin
  if Assigned(FHintWindow) then
    begin
      FHintWindow.ReleaseHandle;
      FreeAndNil(FHintWindow);
    end;
end;

// 6.0
{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.DrawBorder;
var
  tmp:TRect;
  DC:HDC;
  Rgn, ExRgn:HRgn;
  ctl: Integer;
  lThemeMode : TLMDThemeMode;
  box : TThemedEdit;
begin
  if (BorderStyle=bsNone) then exit;
  lThemeMode := UseThemeMode;
  DC:=GetWindowDC(Handle);
  Canvas.Handle:=DC;
  tmp:=Rect(0,0,Width,Height);
  try
    if lThemeMode <> ttmNone then
    begin
       Rgn:=CreateRectRgn(0,0,Width,Height);
       SelectClipRgn(DC, Rgn);
       ExRgn:=CreateRectRgn(1,1,Width-1,Height-1);
       ExtSelectClipRgn(DC, ExRgn, RGN_DIFF);
       try
         box := teEditTextNormal;
         if Focused then box := teEditTextFocused;
         if FMouseOver then box := teEditTextHot;
         if not Enabled then box := teEditTextDisabled;
         LMDThemeServices.DrawElement(lThemeMode, DC,
          ThemeServices.GetElementDetails(box), tmp);
       finally
         SelectClipRgn(Canvas.Handle,0);
         DeleteObject(Rgn);
         DeleteObject(ExRgn);
       end;
       Exit;
    end
    else if Focused or FMouseOver then
    begin
      LMDDrawStdFrame(Canvas, tmp, lsLoweredExt, 0);
      Exit;
    end;

    // clear border
    if CheckOptimized then  // if transparent and valid background
    begin
      ctl:=LMDGetCtrlBorderWidth(Ctl3D, BorderStyle, IsThemed);
      Rgn:=CreateRectRgn(0,0,Width,Height);
      SelectClipRgn(Canvas.Handle, Rgn);
      ExRgn:=CreateRectRgn(ctl,ctl,Width-ctl,Height-ctl);
      ExtSelectClipRgn(Canvas.Handle, ExRgn, RGN_DIFF);

      with BackMapPoint(Point(-ctl, -ctl)) do
        Canvas.CopyRect(Rect(0,0,Width, Height), BackBitmap.Canvas,
                        Bounds(X,Y, Width, Height));

      SelectClipRgn(Canvas.Handle,0);
      DeleteObject(Rgn);
      DeleteObject(ExRgn);
    end
    else
    begin
      Canvas.Brush.Style:=bsClear;
      if Enabled then
        Canvas.Pen.Color:=Color
      else
        Canvas.Pen.Color:=FDisabledColor;
      Canvas.Pen.Width:=3;
      Canvas.Rectangle(tmp);
    end;
  finally
    Canvas.Handle:=0;
    ReleaseDC(Handle, DC);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CMLMDThemeChanged(var Message: TMessage);
begin
  DoThemeChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMThemeChanged(var Msg:TMessage);
begin
  inherited;
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  DoThemeChanged;
  Msg.result:=1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseOver := true;
  if FFlat and not (Focused or IsThemed) then DrawBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if IsHintWindowActive then CancelHint;
  FMouseOver := false;
  if FFlat and not (Focused or IsThemed) then DrawBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if FFlat and not (FMouseOver or IsThemed) then DrawBorder;
  if Multiselect and FHideSelection then
    RePaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMMOVE(var Message: TWMMove);
begin
  inherited;
  if csDesigning in ComponentState then
    begin
      Flast:=-20;
      Perform(LB_GETTOPINDEX, 0, 0);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMSize(var Message:TWMSize);
begin
  inherited;
  CancelEditMode;
  if (FLargeTextOptions in [lbltEndEllipsis, lbltPathEllipsis]) and
     not (csLoading in ComponentState) and
     HandleAllocated then
       Invalidate;
  if not HandleAllocated then exit;
  if FAutoHeight and FMultiline then
    begin
      MeasureListBoxItems;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if FFlat and not (FMouseOver or IsThemed) then DrawBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMSetCursor(var Message: TWMSetCursor);
var
  pt:TPoint;
  index, w:Integer;
  tmpr, hr:TRect;
  data:String;
begin
  try
    if (csDesigning in ComponentState) or (FLargeTextOptions<>lbltShowHint) or
    (FEdit<>nil) then exit;
    if Message.HitTest=HTClient then
      begin
        // Get Item below mouse cursor
        GetCursorPos(pt);
        pt:=ScreenToClient(pt);
        index:=ItemAtPos(pt, true);
        if (index<0) or (ItemIndex=Index) or (MultiSelect and Selected[index]) then
          begin
            CancelHint;
            exit;
          end;
        w:=GetHorzExtent(index);
        // ToDo: VirtualMode
        tmpr:=ItemRect(index);

        // If with < allowed with then hide Hintwindow
        if w<tmpr.Right-tmpr.Left then
          begin
            CancelHint;
            exit;
          end;

        Data:=GetStringValue(Index);

        tmpr.TopLeft:=ClientToScreen(tmpr.TopLeft);
        if IsHintWindowActive and (FHintWindow.Top=tmpr.Top) then
          begin
            if (FHintWindow.Caption<>Data) then CancelHint;
            exit; // Hintwindow is shown already for current item!
          end;

        // ToDo: VirtualMode
        hr:=GetHintWindow.CalcHintRect(Parent.Width, Data, nil);
        OffSetRect(hr,  tmpr.Left,tmpr.Top);
        GetHintWindow.ActivateHint(hr, Data);
        GetHintWindow.Caption:=Data;
      end
    else
      CancelHint;
  finally
    inherited;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if IsHintWindowActive then CancelHint;
  if Assigned (FEditLabel) then
    FEditLabel.Enabled := Enabled;
  if (FDisabledColor<>Color) and not Transparent then
    Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CMLMDSCROLLBOXSCROLLEVENT(var Message: TMessage);
begin
  if CheckOptimized then
    RePaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CNDrawItem(var Message: TWMDrawItem);
var
  state: TOwnerDrawState;
  tmp:   TRect;
  tmpc:  Tcolor;
  tmph:  Boolean;
  dis:   TDrawItemStruct;
begin
  dis := Message.DrawItemStruct^;

  with dis do
  begin
    state := TOwnerDrawState(LongRec(itemState).Lo);

    Canvas.Handle := hDC;
    Canvas.Font   := Font;
    Canvas.Brush  := Brush;

    if UseThemeMode = ttmPlatform then
    begin
      Canvas.Brush.Color := GetThemedBkColor;
      Canvas.Font.Color  := GetThemedTextColor;
    end;

    if not Enabled then
    begin
      Canvas.Brush.Color := FDisabledColor;
      tmpc               := clNone;
      tmph               := True;
    end
    else
    begin
      tmph := FHideFocus;
      if FHideSelection and not Focused then
        tmpc := clNone
      else
        tmpc := FSelectedColor;
    end;

    if items.Count = 0 then
      ItemID := UINT(-1);

    if not CheckOptimized then
    begin
      if (odSelected in state) and (tmpc <> clNone) then
      begin
        Canvas.Brush.Color := FSelectedColor;
        Canvas.Font.Color  := FSelectedFontColor;
        Canvas.Font.Style  := FSelectedFontStyle;
      end;

      Canvas.FillRect(rcItem);
    end
    else
    begin
      tmp := rcItem;
      {if last item -> extend area to ground of control}
      if (Integer(ItemID) = Pred(Items.Count)) then
      begin
        tmp.Bottom := ClientRect.Bottom;
        RestoreBack(tmp);
      end
      else if not (odSelected in state) then
        RestoreBack(tmp);

      if (odSelected in state) and (tmpc <> clNone) then
      begin
        Canvas.Brush.Color := FSelectedColor;
        Canvas.Font.Color  := FSelectedFontColor;
        Canvas.Font.Style  := FSelectedFontStyle;

        // Todo: Transparency with AlphaBlending
        Canvas.FillRect(rcItem);
      end;
    end;

    if Integer(itemID) >= 0 then
    begin
      if FHorzWidth > Width then
        rcItem.Right := FHorzWidth + 2 * FMargin;
      DrawItem(itemID, rcItem, state);
    end;

    if FHorzGridline then
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Pen.Width   := 1;
      Canvas.Pen.Style   := FHorzGridStyle;
      Canvas.Pen.Color   := FHorzGridColor;
      Canvas.MoveTo(rcItem.Left, rcItem.Bottom - 1);
      Canvas.LineTo(rcItem.Right, rcItem.Bottom - 1);
    end;

    if (odFocused in state) and not tmph then
    begin
      if (rcItem.Bottom - rcItem.Top = 0) then
        rcItem.Bottom := rcItem.Top + ItemHeight;

      if FBeveledFocus then
      begin
        Canvas.Pen.Style := psSolid;
        Canvas.Pen.Color := FBevelFocusDarkColor;
        Canvas.MoveTo(rcItem.Left, rcItem.Bottom - 1);
        Canvas.LineTo(rcItem.Left, rcItem.Top);
        Canvas.LineTo(rcItem.Right - 1, rcItem.Top);
        Canvas.Pen.Color := FBevelFocusLightColor;
        Canvas.MoveTo(rcItem.Right - 1, rcItem.Top);
        Canvas.LineTo(rcItem.Right - 1, rcItem.Bottom - 1);
        Canvas.LineTo(rcItem.Left, rcItem.Bottom - 1);
      end
      else
        DrawFocusRect(hDC, rcItem);
    end;

    Canvas.Handle := 0;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.CheckOptimized:Boolean;
begin
  result := BackBitmapCheck and Transparent;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.RestoreBack;
begin
  if CheckOptimized then
    BackDrawArea (Canvas, tmp, tmp.TopLeft);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMNCHitTest(var Message:TWMNCHitTest);
begin
  if (csDesigning in ComponentState) then
    DefaultHandler(Message)
  else
   inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if CheckOptimized then
    begin
      Canvas.Handle:=Message.DC;
      RestoreBack(ClientRect);
      Canvas.Handle:=0;
      Message.result:=1;
    end
  else
    inherited
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.LBGetTopIndex(var Message: TMessage);
var
  tmp:TRect;
begin
  inherited;
  if CheckOptimized and (FLast<>Message.Result) then
    begin
      tmp:=ClientRect;
      LMDInvalidateRect(Handle, tmp, False);
      FLast:=Message.Result;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if message.NotifyCode = LBN_SELCHANGE then
     DoSelect;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if (BorderStyle=bsNone) or not Ctl3D then exit;
  {If UseXP and not Flat then
    with Message.CalcSize_Params^ do
      InflateRect(rgrc[0], 1, 1);}
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  if (IsThemed and Ctl3D) and not Flat then
    DrawBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
begin
  if CheckOptimized then
  begin
    Perform(LB_GETTOPINDEX, 0, 0);

    //this line causes flickering!!!!!
    inherited;

    if Items.Count=0 then
    begin
      DC := GetDC(Handle);
      try
        Canvas.Handle := DC;
        RestoreBack(ClientRect);
        Canvas.Handle := 0;
      finally
        ReleaseDC(Handle, DC);
      end;
    end
  end
  else
    inherited;
  if Flat {or (UseXP and not Flat)} then
    DrawBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.MeasureListBoxItems;
var
  h: integer;
begin
   h := MeasureItemHeights(true, true);
   if h < Height then
     ShowScrollBar(Handle, SB_VERT, False)
   else
     ShowScrollBar(Handle, SB_VERT, True);
   Invalidate;
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDCustomListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  FLast:=-20;
  with Params do
    begin
      if FLargeTextOptions=lbltHorzScrollBar then
        Style:=Style or WS_HSCROLL
      else
        Style:=Style AND NOT WS_HSCROLL;
      if not FVertical then
        Style:=Style AND NOT WS_VSCROLL;
      // 6.1
      If IsThemed then
        if NewStyleControls and Ctl3D and (BorderStyle = bsSingle) then
          begin
            Style := Style OR WS_BORDER;
            ExStyle := ExStyle AND NOT WS_EX_CLIENTEDGE;
          end;
      // --
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.CreateWnd;
begin
  If MultiSelect and FHideSelection then
    FHideSelection:=false;
  inherited CreateWnd;
  SetHorzExtent;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.DoThemeChanged;
begin
  if (ComponentState * [csLoading, csReading] = []) then
    ReCreateWnd;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.CanEdit:Boolean;
begin
  result:=not VirtualMode;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomListBox.GetEditRect(index:Integer):TRect;
begin
  result:=ItemRect(Index);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.EnterEditMode(const NewItem:Boolean=false; Index:Integer=-1);
var
  aRect : TRect;
  tmp:Boolean;
begin
  if IsHintWindowActive then CancelHint;

  if not CanEdit then exit;

  if FEdit<>nil then CancelEditMode;

  tmp:=False;
  FEdit := TLMDCustomListBoxEdit.Create(self);
  FEdit.Parent := self;
  if lboNo3DFrame in FEditOptions then
    FEdit.Ctl3D:=False;

  if Assigned(FOnEditShow) then
    FOnEditShow(self, ItemIndex, tmp);
  if tmp then
    begin
      FreeAndNIl(FEdit);
      exit;
    end;

  if NewItem then
    begin
      if ((index>-1) and (index<Items.Count)) and not Sorted then
        begin
          FEditIndex:=Index;
          Items.Insert(Index, '');
        end
      else
        FEditIndex:=Items.Add('')
    end
  else
    FEditIndex:=ItemIndex;

  ItemIndex:=-1;
  // Unselect All Items if Sorted/MultiSelect is true
  if {Sorted and} MultiSelect then
    ClearSelection;

  //FEdit := TLMDCustomListBoxEdit.Create(self);

  FEdit.OnExit := DoOnEditExit;
  FEdit.OnKeyDown := DoOnEditKeyDown;
  FEdit.WantTabs:=True;

  // Modify tag, CancelEdit will know which item to remove
  If NewItem then
    FEdit.Tag:=$FF+FEditIndex;

  // ToDo
  if FEditIndex>-1 then
    begin
      FEdit.Text:=Items[FEditIndex];
      // specify position
      if not ItemVisible(FEditIndex) then
        TopIndex:=FEditIndex;
    end;

   if lboSelectText in FEditOptions then
     begin
       FEdit.SelectAll;
       //FEdit.SelStart:=
     end;

  aRect:=GetEditRect(FEditIndex);
  aRect.Bottom:=aRect.Bottom-aRect.Top+1;
  with aRect do
    begin
      if Assigned(FOnEditMeasure) then FOnEditMeasure(self, FEditIndex, aRect.Bottom);
      FEdit.SetBounds(Left,Top-1, Right, Bottom);
    end;

  FEdit.SetFocus;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.CancelEditMode;
begin
  if FEdit = nil then exit;
  FEdit.OnExit := nil;
  FEdit.OnKeyDown := nil;
  FreeAndNil(FEdit);
  if Assigned(FOnEditHide) then
     FOnEditHide(self);
  if FEditIndex<>-1 then
    If MultiSelect then
      Selected[FEditIndex]:=True
    else
      ItemIndex:=FEditIndex;
  FEditIndex:=-1;
  SetFocus;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.GetChange(Sender:TObject);
begin
  Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.GetHorzExtent(index:Integer):Integer;
var
  aRect:TRect;
begin
  aRect:=Rect(0,0,0,0);
  LMDDrawTextCalcExt(Canvas, GetStringValue(Index), FFont3D, aRect, Font, false, false, 0, DT_EXPANDTABS);
  result:=aRect.Right+4;//+GetSystemMetrics(SM_CXVSCROLL);
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.GetStringValue(index:Integer):String;
begin
  if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
    result := DoGetData(Index)
  else
    result := Items[Index];
end;

function TLMDCustomListBox.GetThemedBkColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scListBox)
  else
  {$ENDIF}
    Result := Self.Color;
end;

function TLMDCustomListBox.GetThemedTextColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleFontColor(sfListItemTextNormal)
  else
  {$ENDIF}
    Result := Font.Color;
end;

{------------------------------------------------------------------------------}

function TLMDCustomListBox.ItemVisible(index:Integer):Boolean;
var
  tmp:TRect;
begin
  Perform(LB_GETITEMRECT, Index, LPARAM(@tmp));
  result:=PtInRect(ClientRect, tmp.TopLeft);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.SetHorzExtent;
begin
  if (FLargeTextOptions=lbltHorzScrollBar) and not FMultiline then
    SendMessage(Handle, LB_SETHORIZONTALEXTENT, FHorzWidth, 0)
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.InitHorzExtent;
var
  i:Integer;
begin
  FHorzWidth:=0;
  for i:=0 to Pred(Items.Count) do
    FHorzWidth:=LMDMax([FHorzWidth, GetHorzExtent(i)]);
  SetHorzExtent;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.KeyDown(var Key:Word;Shift:TShiftState);
begin
  if IsHintWindowActive then CancelHint;
  case Key of
    VK_F2:
      if lboAllowEdit in FEditOptions then
        begin
          EnterEditMode;
          exit;
        end;
    VK_DELETE:
      if lboAllowDelete in FEditOptions then
        begin
          DeleteSelected;
          exit;
        end;
    VK_INSERT:
      if lboAllowInsert in FEditOptions then
        begin
          if ssCtrl in Shift then
            EnterEditMode(True, ItemIndex+1)
          else
            EnterEditMode(True, ItemIndex);
          exit;
        end;

  end;
  inherited KeyDown(Key,Shift);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.WndProc(var Message: TMessage);

begin
  if not (FLargeTextOptions=lbltHorzScrollBar) then
    begin
      inherited WndProc(Message);
      exit;
    end;

  case Message.Msg of
    LB_ADDSTRING, LB_INSERTSTRING:
      begin
        inherited WndProc(Message);
        FHorzWidth:=LMDMax([FHorzWidth, GetHorzExtent(Message.Result)]);
        SetHorzExtent;
      end;
    {LB_GETHORIZONTALEXTENT:
      begin
        inherited WndProc(Message);
        Message.Result:=FHorzWidth;
      end;}
    LB_DELETESTRING:
      if GetHorzExtent(Message.wParam)>=FHorzWidth then
        begin
          MoveHorz(SB_TOP);
          inherited WndProc(Message);
          InitHorzExtent;
        end
      else
        inherited WndProc(Message);
    LB_RESETCONTENT:
      begin
        FHorzWidth:=0;
        SetHorzExtent;
        MoveHorz(SB_TOP);
        inherited WndProc(Message);
      end;
    WM_SETFONT:
      begin
        inherited WndProc(Message);
        Canvas.Font.Assign(Font);
        InitHorzExtent;
      end;
    else
      inherited WndProc(Message);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  data:  string;
  flags: LongInt;
begin
  Dec(Rect.Right,FMargin);
  Inc(Rect.Left, FMargin);
  Dec(Rect.Bottom);

  if Assigned(OnDrawItem) then
    OnDrawItem(Self, Index, Rect, State)
  else
    begin
      Flags := DrawTextBiDiModeFlags(DT_VCENTER or DT_NOPREFIX);
      if not MultiLine then
        flags := flags or DT_SINGLELINE else flags:=flags or DT_WORDBREAK;
      Data := GetStringValue(Index);

      case FLargeTextOptions of
        lbltEndEllipsis:  Flags := Flags or DT_END_ELLIPSIS;
        lbltPathEllipsis: Flags := Flags or DT_PATH_ELLIPSIS;
      end;

      LMDDrawTextExt(Canvas, Data, FFont3D, Rect, flags,
                     [TLMDDrawTextStyle(Enabled)], nil);
   end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.GetFieldValue:Integer;
begin
  result:=-1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.Loaded;
begin
  inherited Loaded;
  SetLabelPosition(FLabelPosition);  // Nov 03, otherwise Left position does not work
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.MeasureItem(Index: Integer; var Height: Integer);
var
  cRect:TRect;
begin
  inherited;
  if (Index=-1) or not FAutoHeight then exit;
  if FMultiline then
    begin
      cRect:=Rect(0,0, ClientWidth, 0);
      LMDDrawTextCalc(GetStringValue(Index), FFont3D, cRect, Font, MultiLine, false, 0, DT_EXPANDTABS or DT_WORDBREAK)
    end
  else
    begin
      cRect:=Rect(0,0,0,0);
      LMDDrawTextCalc('Wq', FFont3D, cRect, Font, MultiLine, false, 0, DT_EXPANDTABS);
    end;
  if cRect.Bottom>Height then Height:=cRect.Bottom+1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  If IsHintWindowActive then CancelHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end ;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.SetName(const Value: TComponentName);
begin
  if Assigned (FEditLabel) and (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FEditLabel = nil then exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TLMDCustomListBox.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
  if FHasBoundLabel then
    Filer.DefineBinaryProperty('SubLabel', ReadEditLabel, nil, false);
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomListBox.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  if Assigned(FEditLabel) then
    Proc(FEditLabel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.SetupEditLabel;
begin
  if Assigned(FEditLabel) then exit;
  FHasBoundLabel:=true;
  FEditLabel := TLMDBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.DoSelect;
begin
  if Assigned(FOnSelect) then FOnSelect(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.DoOnEditExit (Sender : TObject);
begin
  CancelEditMode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomListBox.DoOnEditKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
var
  tmp:Integer;
begin
  case Key of
    VK_RETURN:
      begin
        if not Sorted then
          begin
            if FEditIndex<>-1 then
              Items[FEditIndex]:=FEdit.Text
            else
              Items.Add(FEdit.Text);
          end
        else
          begin
            If Items.Count=0 then
              Items.Add(FEdit.Text)
            else
              begin
                tmp:=FEditIndex;
                Items.Delete(tmp);
                FEditIndex:=Items.Add(FEdit.Text);
                if not ItemVisible(FEditIndex) then
                  TopIndex:=FEditIndex;
              end;

          end;
        if Assigned(FOnEditChange) then FOnEditChange(self, FEditIndex);
        CancelEditMode;
        Key := 0;
      end;
    VK_ESCAPE :
      begin
        If FEdit.Tag>=$FF then
          begin
            tmp:=FEdit.Tag-$FF;
            if tmp<Items.Count then
              Items.Delete(tmp);
          end;
        CancelEditMode;
        Key := 0;
      end;
    VK_TAB:
      Key:=0;
  end;
end;

{------------------------- Public----------------------------------------------}
constructor TLMDCustomListBox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  //FFocusRect:=True;
  FHorzGridColor:=clSilver;
  FHorzGridStyle:=psSolid;
  FHideSelection:=false;
  FSelectedColor:=clHighlight;
  FSelectedFontColor:=clHighlightText;
  FLast:=-1;
  FEditOptions:=def_ListBoxEditOptions;
  FLargeTextOptions:=lbltNone;
  FMargin:=1;
  FVertical:=True;
  FDisabledColor:=clWindow;
  FFont3D:=TLMD3DCaption.Create;
  FFont3D.OnChange:=GetChange;
  FParentThemeMode := true;
  FThemeMode := ttmPlatForm;

  Style:=lbOwnerDrawFixed;
  FTransparent:=False;

  FBevelFocusDarkColor := clGray;
  FBevelFocusLightColor := clWhite;

  // Bound label Support
  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  FEditLabel := nil;
  FHasBoundLabel := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.ClearSelection;
begin
  Items.BeginUpdate;
  inherited;
  Items.EndUpdate;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomListBox.Destroy;
begin
  FreeHintWindow;
  FreeAndNil(FFont3D);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.MoveHorz(flag:Word);
begin
  Perform(WM_HSCROLL, flag, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.DeleteSelected;
var
  i:Integer;
begin
  If MultiSelect then
    begin
      Items.BeginUpdate;
      for i:=Items.Count-1 downto 0 do
         if Selected[i] then Items.Delete(i);
      Items.EndUpdate;
    end
  else
    if ItemIndex<>-1 then
      begin
        i:=ItemIndex;
        Items.Delete(i);
        if Items.count>0 then
          if i<Items.Count then
            ItemIndex:=i
          else
            ItemIndex:=i-1;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.BackBitmap: TBitmap;
begin
  result := LMDBackBitmap (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.BackBitmapCheck: Boolean;
begin
  result := LMDBackBitmapCheck (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.BackDrawArea (Canvas: TCanvas; const dest: TRect;
  const src: TPoint; flags: Word): Boolean;
begin
  with BackMapPoint(Point(src.X, src.Y)) do
     Canvas.CopyRect(dest, BackBitmap.Canvas, Bounds(X,Y,
                     dest.Right-dest.Left, dest.Bottom-dest.Top));
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.isTransparentSet: Boolean;
begin
  result := FTransparent;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.BackMapPoint (const aValue: TPoint): TPoint;
var
  tmp:Integer;
begin
  if BackBitmapCheck then
    begin
      result:= LMDBackMapPoint (self, aValue);
      // this is some special behaviour, because
      // Bevel belongs here to NC area
      if (BorderStyle=bsNone) then exit;
      tmp:=LMDGetCtrlBorderWidth(Ctl3D, BorderStyle, IsThemed);
      inc (result.x, tmp);
      inc (result.y, tmp);
    end
  else
    result := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.BackUpdate;
begin
  if (csLoading in ComponentState) or (csDestroying in ComponentState) then exit;
//  if CheckOptimized then
    RePaint;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.BackControl (index: Integer): TControl;
begin
  result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.BackControlCount: Integer;
begin
  result := 0;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.BackBitmapPalette: HPalette;
begin
  result:= LMDBackBitmapPalette (self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.AddItemByEditor;
begin
  EnterEditMode(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.DisplayEditor(const Index:Integer);
begin
  if (Index=-1) or (Index>=Items.Count) then exit;
  ItemIndex:=Index;
  EnterEditMode;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomListBox.HideEditor;
begin
  CancelEditMode;
end;

{------------------------------------------------------------------------------}
function TLMDCustomListBox.MeasureItemHeights(aVisibleOnly: boolean; aSetHeight: boolean): integer;
var
  i,j, h, hi:Integer;
begin
  if aVisibleOnly then
    j := TopIndex
  else
    j := 0;  
  h := 0;
  for i := 0 to Items.Count-1 do
  begin
    hi := ItemHeight;
    MeasureItem(i, hi);
    if aSetHeight then
      SendMessage(Handle,LB_SETITEMHEIGHT, i, hi);
    // visible area
    if (i >= j) then
      Inc(h, hi);
  end;
  result := h;
end;



{------------------------------------------------------------------------------}
//Validation support, May 2006, RS
{------------------------------------------------------------------------------}

function TLMDCustomListBox.GetLastErrorMessage: TLMDString;
begin
  if Self.Items.Count > 0 then
    Result := Self.Items[Self.Items.Count - 1];
end;

procedure TLMDCustomListBox.SetErrorMessage(val: TLMDString;
  errorLevel: integer);
begin
  if val <> '' then
    Self.Items.Add(val);
end;


end.
