unit HTMLLbx;
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

HTMLLbx unit
------------
TElHTMLListBox, TElHTMLComboBox components

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Controls, Forms, Messages, Dialogs, Menus, StdCtrls, ExtCtrls,
  Types, SysUtils, Classes,
  ElCombos, ElListBox, LMDGraphUtils, ElVCLUtils, LMDHTMLUnit, LMDTypes, ElHintWnd, ElImgFrm,
  LMDThemes, Themes, LMDClass, LMDProcs
  // UxTheme
  ;

type

  //en
  //{$IFNDEF BCB}
  //TOwnerDrawState = ElVCLUtils.TOwnerDrawState;
  //{$ENDIF}

  TCustomElHTMLListBox = class(TCustomElListBox)
  private
    { Private declarations }
  //  FDummyEvent : TNotifyEvent;  { Dummy field for hiding events. }

    FRender : TLMDHTMLRender;
    FOnLinkClick : TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;

    FIsHTML: Boolean;
    FCursor: TCursor;
    procedure SetWordWrap(const Value: Boolean);
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    // function GetItemHeight(Index: Integer): Integer; virtual;
  protected
    FStyle: TListBoxStyle;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    FWordWrap: Boolean;
    function GetItemWidth(Index: Integer): Integer; override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure TriggerLinkClickEvent(Sender : TObject; HRef : TLMDString); virtual;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image :
        TBitmap); virtual;
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString); virtual;
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean);virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetCursor(newValue : TCursor); virtual;
    function CreateHintWindow: TElHintWindow; override;
    procedure SetStyle(Value: TListBoxStyle);
    procedure SetIsHTML(Value: Boolean); virtual;
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    procedure Loaded; override;
    destructor Destroy; override;
  published
    { Published properties and events }
    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
//    property OnDrawItem : TNotifyEvent read FDummyEvent;  { Hidden Event }
//    property OnMeasureItem : TNotifyEvent read FDummyEvent;  { Hidden Event }
    property IsHTML: Boolean read FIsHTML write SetIsHTML default true;
    property Cursor: TCursor read FCursor write SetCursor;
    property Style: TListBoxStyle read FStyle write SetStyle default lbOwnerDrawVariable;
    property LinkColor: TColor read FLinkColor write SetLinkColor default def_LMDLinkColor;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
  end;  { TElHTMLListBox }

  TCustomElHTMLComboBox = class(TCustomElComboBox)
  private
    { Private declarations }
    FWordWrap: Boolean;
//    FDummyEvent: TNotifyEvent;  { Dummy field for hiding events. }
    FDrawItem: TDrawItemEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;

    FIsHTML: Boolean;
  protected
    FRender: TLMDHTMLRender;
    FStyle: TComboBoxStyle;
    FLinkColor: TColor;
    FLinkStyle: TFontStyles;
    function GetCurrentStyle: TComboBoxStyle; override;
    function GetDropDownHeight: Integer; override;
    procedure SetWordWrap(Value: Boolean);
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure TriggerLinkClickEvent(Sender : TObject; HRef : TLMDString); virtual;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image : TBitmap); virtual;
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString); virtual;
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean);

    {$warnings off}
    procedure SetStyle(Value: TComboBoxStyle); reintroduce;
    {$warnings on}
    procedure SetIsHTML(Value: Boolean); virtual;
    function GetTextFromItem(Index : integer): TLMDString; override;
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;

    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property OnTagFound: TLMDHTMLTagFoundEvent read FOnTagFound write FOnTagFound;
    
//    property OnDrawItem : TNotifyEvent read FDummyEvent;  { Hidden Event }
//    property OnMeasureItem : TNotifyEvent read FDummyEvent;  { Hidden Event }
    property OnDrawItem: TDrawItemEvent read FDrawItem write FDrawItem;
    property IsHTML: Boolean read FIsHTML write SetIsHTML default true;
    property Style: TComboBoxStyle read FStyle write SetStyle default csDropDown;
    property LinkColor: TColor read FLinkColor write SetLinkColor default def_LMDLinkColor;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    published
    { Published properties and events }
  end;

  TElHTMLListBox = class(TCustomElHTMLListBox)
  published
    property OnMultiCheck;
    property OnChange;
    property AllowGrayed;
    property BorderStyle;
    property Columns;
    property ExtendedSelect;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property IntegralHeight;
    property IncrementalSearchTimeout;
    property ItemHeight;
    property MultiSelect;
    property ParentColor;
    property Sorted;
    property TabWidth;
    property ItemIndex;
    property Items;
    property SelCount;
    property TopIndex;
    property ShowCheckBox;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property ActiveBorderType;
    property Background;
    property BorderSides;
    property Flat;
    property Ctl3D;
    property ParentCtl3D;
    property Font;
    property FlatFocusedScrollBars;
    property HighlightAlphaLevel;
    property HorizontalScroll;
    property Images;
    property AlphaForImages;

    property ImageForm;

    property InactiveBorderType;
    property InvertSelection;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property SelectedFont;
    property ShowLineHint;
    property Transparent;
    property TransparentSelection;
    property UseBackground;
    property UseSelectedFont;
    property TabStop;
    property ParentFont;

    property OnClick;
    property OnCheckStateChange;
    //@+ 2/5/03
    property OnCheckBoxChange;
    //@- 2/5/03
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
    property OnResize;
    property OnStartDock;
    property OnStartDrag;

    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property Style;
//    property OnDrawItem;
//    property OnMeasureItem;
    {< ELSCROLLBAR}
    property UseCustomScrollBars;
    property HorzScrollBarStyles;
    property VertScrollBarStyles;
    {> ELSCROLLBAR}
    property RightAlignedView;
  end;

  TElHTMLComboBox = class(TCustomElHTMLComboBox)
  published
    property ShowGripper;
    property OnLinkClick;
    property OnImageNeeded;
    property OnVariableNeeded;
    property OnDrawItem;
    property OnMeasureItem;
    property IsHTML;
    property Style;
    property LinkColor;
    property LinkStyle;

    property ButtonArrowColor;

    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property AutoCompletion;
    property Items;
    property ListColor;

    property ListImageForm;

    property ListInvertSelection;
    property Sorted;
    property UseBackground;
    property OnDropDown;
    property OnCloseUp;
    property AdjustDropDownPos;
    property ItemIndex;
    property ShowLineHint;
    property HorizontalScroll;
    property ItemHeight;
    property DropDownAlignment;

    property AutoHistory;
    property AutoHistoryDirection;
    property AutoHistoryLimit;
    // property OnAutoCompletion;
    property OnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property ReadOnly;
    property MaxLength;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

    property ImageForm;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property Text;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    // inherited from TCustomElEdit
    property StressShortCut;
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;
    property AutoSelect;

    property Background;
    property ButtonCaption;

    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;

    property ButtonColor;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonHint;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonShowBorder;
    property ButtonVisible;
    property ButtonWidth;

    property AltButtonCaption;

    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;

    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShowBorder;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;

    property OnEndDock;

    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnStartDock;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
    property WordWrap;
    {< ELSCROLLBAR}
    property UseCustomScrollBars;
    property HorzScrollBarStyles;
    property VertScrollBarStyles;
    {> ELSCROLLBAR}
  end;

implementation

uses
  ElEdits, ElXPThemedControl;

const SideOffset = 2;

procedure TCustomElHTMLListBox.MeasureItem(Index: Integer; var Height: Integer);

var R : TRect;

begin
  if IsHTML then
  begin
    if Index >= Items.Count then
    begin
      Height := ItemHeight;
      Width := 0;
      end
    else
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight:= Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;

      if FWordWrap then
        FRender.PrepareText(Items[Index], ClientWidth, True)
      else
        FRender.PrepareText(Items[Index], 0, False);
      Height := FRender.Data.TextSize.cy;
    end;
  end
  else
  begin
    R := Rect(0, 0, MaxInt, MaxInt);
    LMDDrawText(Canvas.Handle, Items[Index], Length(Items[Index]), R,
             DT_LEFT or DT_TOP or DT_NOPREFIX or DT_CALCRECT);
    Height := R.Bottom;
  end;
end;

procedure TCustomElHTMLListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  fillback : boolean;
  R1: TRect;
  LWholeRect: TRect;
  S: TSize;
//  sid: integer;
//  pid: integer;
  i: integer;
  LUseThemeMode: TLMDThemeMode;
  LDetail: TThemedButton;
begin
  LUseThemeMode := UseThemeMode;
  if (IsHTML) and (Items.Count > Index) then
  begin
    if (odSelected in State) then
    begin
      if (odFocused in State) then
      begin
        Canvas.Brush.Color := FocusedSelectColor;
        FRender.Data.DefaultColor := FocusedSelectTextColor;
      end
      else
      if not HideSelection then
      begin
        Canvas.Brush.Color := HideSelectColor;
        FRender.Data.DefaultColor := HideSelectTextColor;
      end
      else
      begin
        Canvas.Brush.Color := Color;
        FRender.Data.DefaultColor := Font.Color;
      end;
    end
    else
      if ([odGrayed, odDisabled] * State) <> [] then
      begin
        Canvas.Brush.Color := clBtnFace;
        FRender.Data.DefaultColor := clBtnShadow;
      end
      else
      begin
        Canvas.Brush.Color := Color;
        FRender.Data.DefaultColor := Font.Color;
      end;

    FillBack := (not Self.Transparent) and
                (UseBackground = false) and
                ((ImageForm = nil) or (csDesigning in ComponentState)) and // or
                (not
                  (odComboBoxEdit in State)
                  );
    if ((((odSelected in State)) or FillBack) or ((HighlightAlphaLevel = 255) and (not Transparent))) and (not TransparentSelection) then
      Canvas.FillRect(Rect)
    else
      if ((not UseBackground) and (ImageForm = nil)) or (ImageForm.Control <> Self) then
      DrawParentControlEx(Canvas.Handle, Rect)
      else
        FImgForm.PaintBkgnd(Canvas.Handle, Rect, Point(0, 0), false);
      Canvas.Brush.Style := bsClear;

    LWholeRect := Rect;

    if ShowCheckBox then
    begin
      R1 := Rect;
      s := GetCheckBoxSize;

      if RightAlignedText then
      begin
        dec(R1.Right, 2);
        R1.Left := R1.Right - S.cx;
      end
      else
      begin
        inc(R1.Left, 2);
        R1.Right := R1.Left + S.cx;
      end;
      R1.Top := R1.Top + (R1.Bottom - R1.Top - S.cy) div 2;
      R1.Bottom := R1.Top + S.cy;
      if LUseThemeMode <> ttmNone then
      begin
        // pid := BP_CHECKBOX;
        // sid := 0;
        LDetail := tbCheckBoxUncheckedNormal;
        case GetState(Index) of
          cbUnchecked :
            if not Enabled then
              // sid := CBS_UNCHECKEDDISABLED
               LDetail := tbCheckBoxUncheckedDisabled
            else
              // sid := CBS_UNCHECKEDNORMAL;
              LDetail := tbCheckBoxUncheckedNormal;

          cbChecked :
            if not Enabled then
              // sid := CBS_CHECKEDDISABLED
              LDetail := tbCheckBoxCheckedDisabled
            else
              LDetail := tbCheckBoxCheckedNormal;

          cbGrayed :
            if not Enabled then
              // sid := CBS_MIXEDDISABLED
              LDetail := tbCheckBoxMixedDisabled
            else
              // sid := CBS_MIXEDNORMAL;
              LDetail := tbCheckBoxMixedNormal;
        end;
        LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetail, R1, LMDRectToPtr(Rect));
      end
      else
      begin
        i := 0;
        case GetState(Index) of
          cbChecked : i := DFCS_BUTTONCHECK or DFCS_CHECKED;
          cbUnchecked : i := DFCS_BUTTONCHECK;
          cbGrayed : i := DFCS_BUTTON3STATE or DFCS_CHECKED;
        end; // case
        DrawFrameControl(Canvas.Handle, R1, DFC_BUTTON, i);
        if Flat then
          DrawFlatFrame(Canvas, R1);
      end;
      if RightAlignedText then
        Rect.Right := R1.Left - 3
      else
        Rect.Left := R1.Right + 3;
    end;

    FRender.Data.DefaultBgColor := clNone;

    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight:= Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.LinkColor := LinkColor;
    FRender.Data.LinkStyle := LinkStyle;
    if FWordWrap then
      FRender.PrepareText(Items[Index], ClientWidth, True)
    else
      FRender.PrepareText(Items[Index], 0, false);
    FRender.DrawText(Canvas, Point(0, 0), Rect, FRender.Data.DefaultBgColor);
    if (odSelected in State) and (HighlightAlphaLevel < 255) then
    begin
      LMDAlphaFillRect(Canvas, LWholeRect, FocusedSelectColor, HighlightAlphaLevel);
    end;
    if ((odFocused in State) or (odSelected in State)) and not FHideFocusRect then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.FrameRect(LWholeRect);
    end;
  end
  else
    inherited;
end;

{ Event triggers: }
procedure TCustomElHTMLListBox.TriggerLinkClickEvent(Sender : TObject; HRef :TLMDString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TCustomElHTMLListBox.TriggerImageNeededEvent(Sender : TObject; Src :TLMDString; var Image : TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;  { TriggerImageNeededEvent }

procedure TCustomElHTMLListBox.DoLinkPopup(MousePos : TPoint);
begin
  if (FLinkPopupMenu <> nil) and FLinkPopupMenu.AutoPopup then
  begin
    SendCancelMode(nil);
    FLinkPopupMenu.PopupComponent := Self;
    if MousePos.X < 0 then
      MousePos := ClientToScreen(Point(0,0));
    FLinkPopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;

procedure TCustomElHTMLListBox.Loaded;
begin
  inherited;
  if HandleAllocated then
    RecreateWnd;
end;

destructor TCustomElHTMLListBox.Destroy;
begin
  FRender.Free;
  inherited Destroy;
end;  { Destroy }

constructor TCustomElHTMLListBox.Create(AOwner : TComponent);
{ Creates an object of type TElHTMLListBox, and initializes properties. }
begin
  inherited Create(AOwner);
  inherited Style := lbOwnerDrawVariable;  { New default. }
  FStyle := lbOwnerDrawVariable;
  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;  
  FRender.OnTagFound := TriggerTagFoundEvent;
  FIsHTML := true;
  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;
  FWordWrap := False;
end;  { Create }

procedure TCustomElHTMLListBox.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
    begin
      FIsHTML := Value;
      if FIsHTML then
        inherited Style := lbOwnerDrawVariable
      else
        inherited Style := FStyle;
      RecreateWnd;
    end;
end;

procedure TCustomElHTMLListBox.CMMouseLeave(var Msg : TMessage);
begin
  inherited Cursor := FCursor;
  inherited;
end;  { CMMouseLeave }

procedure TCustomElHTMLListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  href : TLMDString;
  i : integer;
  R : TRect;
begin
  begin
    i := SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(X,Y));
    SendMessage(Handle, LB_GETITEMRECT, i, LPARAM(@R));
    if PtInRect(R, Point(X,Y)) and (i >= 0) and (i < Items.Count) then
    begin
      with FRender.Data do
      begin
        DefaultStyle := Font.Style;
        DefaultHeight := Font.Height;
        DefaultFont := Font.Name;
        Charset := Font.Charset;
        LinkColor := FLinkColor;
        LinkStyle := FLinkStyle;
      end;
      if FWordWrap then
        FRender.PrepareText(Items[i], ClientWidth, True)
      else
        FRender.PrepareText(Items[i], 0, false);
      if FRender.IsCursorOverLink(Point(X, Y - R.Top), Point(0, 0), Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), href) then
      begin
        if (Button = mbRight) and (FLinkPopupMenu <> nil) then
          DoLinkPopup(ClientToScreen(Point(X, Y)))
        else
          TriggerLinkClickEvent(Self, href);
        exit;
      end;
    end;
  end;
  inherited;
end;

procedure TCustomElHTMLListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  href : TLMDString;
  i : integer;
  R : TRect;
begin
  inherited;
  if IsHTML then
  begin
    i := SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(X,Y));
    SendMessage(Handle, LB_GETITEMRECT, i, LPARAM(@R));
    if PtInRect(R, Point(X,Y)) and (i >= 0) and (i < Items.Count) then
    begin
      with FRender.Data do
      begin
        DefaultStyle := Font.Style;
        DefaultHeight := Font.Height;
        DefaultFont := Font.Name;
        Charset := Font.Charset;
        LinkColor := FLinkColor;
        LinkStyle := FLinkStyle;
      end;
      if FWordWrap then
        FRender.PrepareText(Items[i], ClientWidth, True)
      else
        FRender.PrepareText(Items[i], 0, false);
      if FRender.IsCursorOverLink(Point(X, Y - R.Top), Point(0, 0), Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), href) then
         inherited Cursor := crHandPoint
      else
         inherited Cursor := FCursor;
    end;
  end;
end;  { MouseMove }

procedure TCustomElHTMLListBox.SetCursor(newValue : TCursor);
var P : TPoint;
begin
  if (FCursor <> newValue) then
  begin
    FCursor := newValue;
    GetCursorPos(P);
    P := ScreenToClient(P);
    SendMessage(Handle, WM_MOUSEMOVE, 0, MakeLParam(P.X, P.Y));
  end;  { if }
end;  { SetCursor }

function TCustomElHTMLListBox.GetItemWidth(Index: Integer): Integer;
begin
  if not IsHTML then
    result := inherited GetItemWidth(Index)
  else
  begin
    if Index >= Items.Count then
      Result := 0
    else
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;
      FRender.PrepareText(Items[Index], 0, false);

      Result := FRender.Data.TextSize.cx + 4;
    end;
  end;
end;

function TCustomElHTMLListBox.CreateHintWindow: TElHintWindow;
begin
  Result := TElHintWindow.Create(nil);
  TElHintWindow(Result).IsHTML := IsHTML;
  TElHintWindow(Result).OnLinkClick := TriggerLinkClickEvent;
end;

procedure TCustomElHTMLListBox.SetStyle(Value: TListBoxStyle);
begin
  if (FStyle <> Value) and (Value in [Low(TListBoxStyle)..High(TListBoxStyle)]) then
  begin
    FStyle := Value;
    if not IsHTML then
    begin
      inherited Style := Value;
    end;
  end;
end;

procedure TCustomElHTMLListBox.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkColor }

procedure TCustomElHTMLListBox.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    if FLinkPopupMenu <> nil then
      if not (csDestroying in FLinkPopupMenu.ComponentState) then
        FLinkPopupMenu.RemoveFreeNotification(Self);
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TCustomElHTMLListBox.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkStyle }

procedure TCustomElHTMLListBox.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
  //Invalidate;
end;

procedure TCustomElHTMLListBox.WMSize(var Message: TWMSize);
var
  i: Integer;
  LHeight: Integer;
  LOldHeight: Integer;
  LModified: Boolean;
begin
  inherited;
  LModified := False;
  if WordWrap then
  begin
    for i := 0 to Items.Count - 1 do
    begin
      LOldHeight := SendMessage(Handle, LB_GETITEMHEIGHT, i, 0);
      MeasureItem(i, LHeight);
      if LOldHeight <> LHeight then
      begin
        SendMessage(Handle, LB_SETITEMHEIGHT, i, LHeight);
        LModified := True;
      end;
    end;
    if LModified then
      Invalidate;
  end;
end;

(*
function TCustomElHTMLListBox.GetItemHeight(Index: Integer): Integer;
begin
  if not IsHTML then
    Result := ItemHeight
  else
  begin
    if Index >= Items.Count then
      Result := ItemHeight
    else
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultSize := Font.Size;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.PrepareText(Items[Index], 0, false);
      Result := FRender.Data.TextSize.cy;
    end;
  end;
end;
*)
{ TCustomElHTMLComboBox }

constructor TCustomElHTMLComboBox.Create(AOwner : TComponent);
{ Creates an object of type TElHTMLComboBox, and initializes properties. }
begin
  inherited Create(AOwner);
  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;
  FIsHTML := true;
  inherited Style := csOwnerDrawVariable;
  FStyle := csDropDown;
  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;
end;  { Create }

destructor TCustomElHTMLComboBox.Destroy;
begin
  FRender.Free;
  inherited Destroy;
end;  { Destroy }

procedure TCustomElHTMLComboBox.MeasureItem(Index: Integer; var Height: Integer);
var
  R : TRect;
begin
  if Index = -1 then
    Height := ItemHeight
  else
  if IsHTML then
  begin
    if Index >= Items.Count then
    begin
      Height := ItemHeight;
      Width := 0;
    end
    else
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;
      if WordWrap then
        FRender.PrepareText(Items[Index], FListBox.Width, True)
      else
        FRender.PrepareText(Items[Index], 0, false);
      Height := FRender.Data.TextSize.cy;
    end;
  end
  else
  begin
    R := Rect(0, 0, MaxInt, MaxInt);
    LMDDrawText(Canvas.Handle, Items[Index], Length(Items[Index]), R,
             DT_LEFT or DT_TOP or DT_NOPREFIX or DT_CALCRECT);
    Height := R.Bottom;
  end;
end;

procedure TCustomElHTMLComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  fillback : boolean;
begin
  if (FStyle in [csOwnerDrawFixed, csOwnerDrawVariable]) and Assigned(FDrawItem) then
  begin
    FDrawItem(Self, Index, Rect, State);
  end
  else
    if IsHTML then
    begin
      if ([odComboBoxEdit] * State <> []) and Focused then
      begin
        Canvas.Brush.Color := FocusedSelectColor;
        FRender.Data.DefaultColor := FocusedSelectTextColor;
      end
      else
      if ([odFocused, odSelected] * State) <> [] then
      begin
        Canvas.Brush.Color := FocusedSelectColor;
        FRender.Data.DefaultColor := FocusedSelectTextColor;
      end
      else
      if ([odGrayed, odDisabled] * State) <> [] then
      begin
        Canvas.Brush.Color := clBtnFace;
        FRender.Data.DefaultColor := clBtnShadow;
      end
      else
      if ([odComboBoxEdit] * State <> []) and ReadOnly and DisplayReadOnlyOptions.Enabled then
      begin
        if IsThemed {(XPThemesAvailable and IsThemeActive) and UseXPThemes} then
          Canvas.Brush.Style := bsClear
        else
          Canvas.Brush.Color := DisplayReadOnlyOptions.BkColor;
        FRender.Data.DefaultColor := DisplayReadOnlyOptions.TextColor;
      end
      else
      if ([odComboBoxEdit] * State <> []) and not Enabled and UseDisabledColors then
      begin
        Canvas.Brush.Color := DisabledColor;
        FRender.Data.DefaultColor := DisabledFontColor;
      end
      else
      begin
        Canvas.Brush.Color := Color;
        FRender.Data.DefaultColor := Font.Color;
      end;

      FillBack := (not Self.Transparent) and
                  (UseBackground = false) and
                  ((ImageForm = nil) or (csDesigning in ComponentState)) or
                  (not
                    (odComboBoxEdit in State)
                    );

      if {not ((XPThemesAvailable and IsThemeActive) and UseXPThemes) and} (((not (odSelected in State)) and FillBack) or (HighlightAlphaLevel = 255) ) then
        Canvas.FillRect(Rect);

      Canvas.Brush.Style := bsClear;
      FRender.Data.DefaultBgColor := clNone;

      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;

      InflateRect(Rect, -SideOffset div 2, 0);
      if WordWrap then
        FRender.PrepareText(Items[Index], FListBox.Width, True)
      else
        FRender.PrepareText(Items[Index], 0, false);
      FRender.DrawText(Canvas, Point(0, 0), Rect, clNone);
      if (odSelected in State) and (HighlightAlphaLevel < 255) then
      begin
        LMDAlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
      end;
    end
    else
      inherited;
end;

function TCustomElHTMLComboBox.GetDropDownHeight: Integer;
var
  vBrdr :Integer;

  function GetHeightOfGivenItemsCount(Count: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 0 to Count - 1 do
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := FLinkColor;
      FRender.Data.LinkStyle := FLinkStyle;

      if WordWrap then
        FRender.PrepareText(Items[i], FListBox.Width, True)
      else
        FRender.PrepareText(Items[i], 0, false);
      Result := Result + FRender.Data.TextSize.cy;
    end;
  end;

begin
  vBrdr := 0; // GetSystemMetrics(SM_CYBORDER);
  if FListBox.Items.Count = 0 then
    Result := FListBox.ItemHeight + vBrdr * 2
  else
    if FListBox.Items.Count < FDropDownCount then
      Result := GetHeightOfGivenItemsCount(FListBox.Items.Count) + vBrdr * 2
    else
      Result := GetHeightOfGivenItemsCount(FDropDownCount) + vBrdr * 2;
end;

procedure TCustomElHTMLComboBox.SetWordWrap(Value: Boolean);
begin
  FWordWrap := Value;
  Invalidate;
end;

{ Event triggers: }
procedure TCustomElHTMLComboBox.TriggerLinkClickEvent(Sender : TObject; HRef : TLMDString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TCustomElHTMLComboBox.TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image : TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;  { TriggerImageNeededEvent }

procedure TCustomElHTMLComboBox.Loaded;
begin
  inherited;
  if IsHTML then
    inherited Style := csOwnerDrawVariable
  else
    inherited Style := Style;
  if HandleAllocated then
    RecreateWnd;
end;

procedure TCustomElHTMLComboBox.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
      inherited Style := csOwnerDrawVariable
    else
      inherited Style := FStyle;
    if ComponentState * [csLoading, csReading, csDestroying] = [] then
      RecreateWnd;
  end;
end;

procedure TCustomElHTMLComboBox.SetStyle(Value: TComboBoxStyle);
begin
  if (FStyle <> Value) and (Value in [Low(TComboBoxStyle)..High(TComboBoxStyle)]) then
  begin
    FStyle := Value;
    if not IsHTML then
    begin
      inherited Style := Value;
      if ComponentState * [csLoading, csReading, csDestroying] = [] then
        RecreateWnd;
    end;
  end;
end;

function TCustomElHTMLComboBox.GetTextFromItem(Index : integer): TLMDString;
begin
  if IsHTML then
  begin
    FRender.PrepareText(Items[Index], 0, false);
    Result := FRender.AsText;
  end
  else
    Result := Items[Index];
end;

procedure TCustomElHTMLComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if IsHTML and (Key in [VK_Back, VK_Delete]) and (FStyle in [csDropDown, csSimple]) and (not ReadOnly) then
  begin
    ItemIndex := -1;
    Text := '';
    Change;
  end
  else
    inherited;
end;

procedure TCustomElHTMLComboBox.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
    begin
      FLinkColor := newValue;
      if IsHTML then
        begin
          FIsHTML := false;
          IsHTML := true;
        end;
    end;  { if }
end;  { SetLinkColor }

procedure TCustomElHTMLComboBox.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
    begin
      FLinkStyle := newValue;
      if IsHTML then
        begin
          FIsHTML := false;
          IsHTML := true;
        end;
    end;  { if }
end;  { SetLinkStyle }

function TCustomElHTMLComboBox.GetCurrentStyle: TComboBoxStyle;
begin
  Result := FStyle;
end;

procedure TCustomElHTMLListBox.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

procedure TCustomElHTMLComboBox.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

procedure TCustomElHTMLListBox.TriggerTagFoundEvent(Sender: TObject;
  var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing,
  aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

procedure TCustomElHTMLComboBox.TriggerTagFoundEvent(Sender: TObject;
  var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing,
  aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

end.
