unit ElClrCmb;
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

ElClrCmb unit
-------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Forms,
  Classes,
  Graphics,
  Controls,
  ExtCtrls,
  Dialogs,
  StdCtrls,
  Themes,
  Types,

  LMDClass,
  LMDTypes,
  LMDElConst,
  LMDUnicodeStrings,
  LMDThemes,
  LMDGraphUtils,

  ElListBox,
  ElCombos,
  ElVCLUtils;

type
  TColorComboOption = (ccoNoColor, cco4BitColors, ccoSystemColors, ccoCustomChoice, ccoShowNames);
  TColorComboOptions = set of TColorComboOption;

  TTranslateColorNameEvent = procedure(Sender: TObject; Color: TColor; var ColorName: TElFString) of object;
  TColorComboAddMoreColorsEvent = procedure(Sender: TObject; Items: TLMDStrings) of object;
  TColorDialogShowEvent = procedure(Sender : TObject; AfterShow : boolean) of object;

  //en
  //{$IFNDEF BCB}
  //TOwnerDrawState = ElVCLUtils.TOwnerDrawState;
  //{$ENDIF}

  TElColorCombo = class(TCustomElComboBox)
  private
    //internally used
    FDown : Boolean;
    FMouseInControl : boolean;
    //storage for properties
    FDialogOptions : TColorDialogOptions;
    FSelectedColor : TColor;
    FCustomColor : TColor;
    FOptions: TColorComboOptions;
    FOnTranslateColorName: TTranslateColorNameEvent;
    FOnAddMoreColors: TColorComboAddMoreColorsEvent;
    FOnColorDialogShow : TColorDialogShowEvent;
    FInDialog: boolean;
    FIgnoreCustomValue : boolean;
    //msg handlers
    procedure CMMouseEnter(var Message : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message : TMessage); message CM_MOUSELEAVE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetOptions(Value: TColorComboOptions);
  protected
    procedure SetSelectedColor(aColor : TColor);
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure FillItems;
    procedure DoChange; override;
    procedure TriggerTranslateColorName(Color : TColor; var ColorName : TLMDString); virtual;
    procedure Loaded; override;
    procedure DoAddMoreColors(Items : TLMDStrings); virtual;
    procedure TriggerColorDialogShow(AfterShow : boolean); virtual;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure CloseUp(AcceptValue: Boolean); override;
  published
    property Options: TColorComboOptions read FOptions write SetOptions;
    property DialogOptions : TColorDialogOptions read FDialogOptions write FDialogOptions default [cdFullOpen];
    property SelectedColor : TColor read FSelectedColor write SetSelectedColor default clLime;
    property OnTranslateColorName: TTranslateColorNameEvent read FOnTranslateColorName
                                                            write FOnTranslateColorName;
    property OnAddMoreColors: TColorComboAddMoreColorsEvent read FOnAddMoreColors write FOnAddMoreColors;
    property OnColorDialogShow : TColorDialogShowEvent read FOnColorDialogShow write FOnColorDialogShow;

    property ShowGripper;
    property ButtonArrowColor;
    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ShowLineHint;
    property HorizontalScroll;
    property OnDrawItem;
    property OnMeasureItem;
    property DropDownAlignment;

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
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    // inherited from TCustomElEdit
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;

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
    property ButtonOldStyled;
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
    property AltButtonOldStyled;
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
    property AltButtonPngGlyph;
    property AltButtonUsePng;
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

  end;

var
  s_Custom : string;

implementation

uses ElEdits, ElXPThemedControl;

constructor TElColorCombo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FDown := false;
  FMouseInControl := false;
  Width := 50;
  Height := 21;
  inherited Style := csOwnerDrawFixed;
  inherited ItemHeight := Abs(Font.Height) + GetSystemMetrics(SM_CXEDGE) * 2;
  FReadOnly := True;
  FSelectedColor := clLime;
  FCustomColor := clBlack;
  FDialogOptions := [cdFullOpen];
  FOptions := [ccoNoColor, cco4BitColors, ccoSystemColors, ccoShowNames, ccoCustomChoice];
  TabStop := true;
end;

procedure TElColorCombo.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var C : TColor;
    CName, S : TLMDString;
    SaveRect : TRect;
    fillback : boolean;
    LDetail: TThemedEdit;
    LThemeMode: TLMDThemeMode;
begin
  Canvas.Brush.Style := bsSolid;
  LThemeMode := UseThemeMode;
  if (odSelected in State) or (Focused and (odComboBoxEdit in State)) then
    Canvas.Brush.Color := FocusedSelectColor
  else
    if (odComboboxEdit in State) and (ReadOnly and FDisplayReadOnlyOptions.Enabled) then
    begin
      if IsThemed then
        Canvas.Brush.Style := bsClear
      else
        Canvas.Brush.Color := FDisplayReadOnlyOptions.BkColor
    end
    else
      if not Enabled and UseDisabledColors then
        Canvas.Brush.Color := DisabledColor
      else
        Canvas.Brush.Color := Color;

  FillBack := (not Self.Transparent) and
              (UseBackground = false)
              and ((ImageForm = nil) or (csDesigning in ComponentState)) or
              (not
                (odComboBoxEdit in State)
                );

  if FillBack and (LThemeMode <> ttmNone) and (odComboBoxEdit in State) and not Focused then
  begin
//
  end
  else
    if (((not (odSelected in State)) and FillBack) or ((odSelected in State) and (HighlightAlphaLevel = 255))) then
      Canvas.FillRect(Rect);

  //InflateRect(Rect, -1, -1);
  if (ccoCustomChoice in Options) and (Index = inherited Items.Count - 1) then
//    C := SelectedColor
    C := FCustomColor
  else
  try
    C := StringToColor(inherited Items[Index]);
  except
    C := SelectedColor;
  end;
  if ccoShowNames in Options then
  begin
    SaveRect := Rect;
    Rect.Right := Rect.Left + (Rect.Bottom - Rect.Top);
    SaveRect.Left := Rect.Right + 2;
  end;
  with Canvas do
  if C = clNone then
  begin
    Brush.Color := Color;
    FillRect(Rect);
    Brush.Color := clWindowText;
    Pen.Color := clWindowText;
    InflateRect(Rect, -1, -1);
    FrameRect(Rect);
    MoveTo(Rect.Left, Rect.Top);
    LineTo(Rect.Right - 1, Rect.Bottom - 1);
    MoveTo(Rect.Left, Rect.Bottom - 1);
    LineTo(Rect.Right - 1, Rect.Top);
    InflateRect(Rect, 1, 1);
  end
  else
  begin
    Brush.Color := C;
    InflateRect(Rect, -1, -1);
    FillRect(Rect);
    Brush.Color := clWindowText;
    Pen.Color := clWindowText;
    FrameRect(Rect);
    InflateRect(Rect, 1, 1);
  end;

  if ccoShowNames in Options then
  begin
    if (ccoCustomChoice in Options) and (Index = inherited Items.Count - 1) then
    begin
      CName := s_Custom
    end
    else
      CName := inherited Items[Index];

    if Uppercase(Copy(CName, 1, 2)) = 'CL' then
      CName := Copy(CName, 3, Length(CName) - 2);

    TriggerTranslateColorName(C, CName);
    Canvas.Font.Assign(Font);
    Canvas.Brush.Style := bsClear;
    Rect := SaveRect;
    Canvas.Font.Color := GetTextColor;
    if (odSelected in State) or (Focused and (odComboBoxEdit in State)) then
      Canvas.Font.Color := FocusedSelectTextColor
    else
      if (odComboboxEdit in State) and (ReadOnly and FDisplayReadOnlyOptions.Enabled) then
        Canvas.Font.Color := FDisplayReadOnlyOptions.TextColor
      else
        if not Enabled and UseDisabledColors then
          Canvas.Font.Color := DisabledFontColor;

    if (LThemeMode <> ttmNone) and not (ReadOnly and not FIgnoreReadOnlyState) and not (odSelected in State) and not ((odComboboxEdit in State) and Focused) and (Enabled or not UseDisabledColors) then
    begin
      if not Enabled then
        LDetail := teEditTextDisabled
      else
//      if odSelected in State then
//        LDetail := teEditTextSELECTED
//      else
      if FMouseOver then
        LDetail := teEditTextHot
//      else
//      if ReadOnly then
//      begin
//        if FIgnoreReadOnlyState then
//          LDetail := teEditTextNORMAL
//        else
//          LDetail := teEditTextREADONLY;
//      end
      else
        LDetail := teEditTextNormal;
      s := CName;
      LMDThemeServices.DrawThemeText(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail),
                      s, Length(WideString(s)), DT_VCENTER or DT_NOPREFIX or DT_LEFT or DT_SINGLELINE, 0, Rect);
    end
    else
    begin
      s := CName;
      LMDDrawText(Canvas.Handle, S, Length(S), Rect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);
      // Canvas.TextRect(Rect, Rect.Left, Rect.Top, CName);
    end;
  end;

  if (odSelected in State) and (HighlightAlphaLevel < 255) then
  begin
    LMDAlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
  end;

  (*
  if odFocused in State then
  begin
    InflateRect(Rect, 2, 2);
    DrawFocusRect(Canvas.Handle, Rect);
  end;
  *)
  end;

procedure TElColorCombo.CMMouseEnter(var Message : TMessage);
begin
  inherited;
  if FMouseInControl or (not Enabled) then exit;
  FMouseInControl := True;
end;

procedure TElColorCombo.CMMouseLeave(var Message : TMessage);
begin
  inherited;
  if (not FMouseInControl) or (not Enabled) then exit;
  FMouseInControl := False;
end;

procedure TElColorCombo.SetSelectedColor(aColor : TColor);
var S  : String;
    idx: integer;
    SC : TColor;
begin
  if (aColor = FSelectedColor) and (inherited ItemIndex >= 0) then exit;
  sc := FSelectedColor;

  S := ColorToString(aColor);
  idx := inherited Items.IndexOf(S);
  if idx <> -1 then
  begin
    FSelectedColor := aColor;
    inherited ItemIndex := idx;
    Invalidate;
  end
  else
  if (ccoCustomChoice in FOptions) or (csLoading in ComponentState) then
  begin
    FIgnoreCustomValue := true;
    inherited ItemIndex := inherited Items.Count - 1;
    FIgnoreCustomValue := false;
    FSelectedColor := StrToIntDef(S, aColor);
    FCustomColor := StrToIntDef(S, aColor);
    Invalidate;
  end
  else
    FSelectedColor := SC;
end;

destructor TElColorCombo.Destroy;  { public }
begin
  inherited;
end;  { Destroy }

procedure TElColorCombo.FillItems;
const
  c4BitColors : array[0..15] of TColor =
    (clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clDkGray,
    clLtGray, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);
  cSystemColors : array[0..24] of TColor =
    (clScrollBar, clBackground, clActiveCaption, clInactiveCaption, clMenu,
     clWindow, clWindowFrame, clMenuText, clWindowText, clCaptionText,
     clActiveBorder, clInactiveBorder, clAppWorkSpace, clHighlight,
     clHighlightText, clBtnFace, clBtnShadow, clGrayText, clBtnText,
     clInactiveCaptionText, clBtnHighlight, cl3DDkShadow, cl3DLight,
     clInfoText, clInfoBk);

var i : integer;
    s : string;
    SC: TColor;
begin
  SC := FSelectedColor;
  FIgnoreCustomValue := true;
  inherited Items.Clear;
  FIgnoreCustomValue := false;
  if ccoNoColor in FOptions then
    inherited Items.AddObject('clNone', TObject(Pointer(clNone)));
  if cco4BitColors in FOptions then
  begin
    for i := 0 to 16 - 1 do
    begin
      if ColorToIdent(c4BitColors[i], s) then
        inherited Items.AddObject(s, TObject(Pointer(c4BitColors[i])))
      else
        inherited Items.AddObject(ColorToString(c4BitColors[i]), TObject(Pointer(c4BitColors[i])));
    end;
  end;
  if ccoSystemColors in FOptions then
  begin
    for i := 0 to 25 - 1 do
    begin
      if ColorToIdent(cSystemColors[i], s) then
        inherited Items.AddObject(s, TObject(Pointer(cSystemColors[i])))
      else
        inherited Items.AddObject(ColorToString(cSystemColors[i]), TObject(Pointer(cSystemColors[i])));
    end;
  end;
  DoAddMoreColors(inherited Items);
  if ccoCustomChoice in FOptions then
  begin
    inherited Items.AddObject(s_Custom, TObject(Pointer(SC)));
  end;
  FSelectedColor := SC;
end;

procedure TElColorCombo.CreateWnd;
var SC : TColor;
begin
  inherited;
  SC := FSelectedColor;
  FillItems;
  SetSelectedColor(SC);
end;

procedure TElColorCombo.CloseUp(AcceptValue: Boolean);
var
  LOldItemIndex: Integer;
  SC: Tcolor;
begin
  LOldItemIndex := FItemIndex;
  inherited;
  // Workaround - for case when "Custom..." already selected,
  // but we need to dialog anyway
  if (LOldItemIndex = FItemIndex) then
  begin
    if (not ReadOnly) and (ccoCustomChoice in Options) and (inherited Items.Count > 0) and (inherited ItemIndex = inherited Items.Count - 1) and (not FIgnoreCustomValue) then
    begin
      if (not FInDialog) and (not (csLoading in ComponentState)) and AcceptValue then
      begin
        FInDialog := true;
        with TColorDialog.Create(self) do
        begin
          try
            Options := FDialogOptions;
            Color := FSelectedColor;
            if FCustomColor <> clBlack then
            begin
              CustomColors.Insert(0, 'Color' + Char(Ord('A')));
              CustomColors.Values['Color' + Char(Ord('A'))] := IntToHex(FCustomColor, 8);
            end;
            TriggerColorDialogShow(false);
            if Execute and (Color <> FSelectedColor) then
            begin
              SetSelectedColor(Color);
              Change;
            end
            else
            begin
              SC := FSelectedColor;
              FSelectedColor := TColor(-2);
              SetSelectedColor(SC);
            end;
            TriggerColorDialogShow(true);
          finally
            Free;
          end;
        end;
        FInDialog := false;
      end;
    end
  end;
end;

procedure TElColorCombo.SetOptions(Value: TColorComboOptions);
var SC : TColor;
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    if csLoading in ComponentState then exit;
    inherited Items.Clear;
    SC := FSelectedColor;
    FillItems;
    SetSelectedColor(SC);
  end;
end;

procedure TElColorCombo.TriggerTranslateColorName(Color : TColor; var ColorName : TLMDString);
begin
  if assigned(FOnTranslateColorName) then
    FOnTranslateColorName(Self, Color, ColorName);
end;

procedure TElColorCombo.DoChange;
var SC : TColor;
begin
  if not ReadOnly and not FIgnoreCustomValue then
  begin
    if (ccoCustomChoice in Options) and (inherited Items.Count > 0) and (inherited ItemIndex = inherited Items.Count - 1) and (not FIgnoreCustomValue) then
    begin
      if (not FInDialog) and (not (csLoading in ComponentState)) and DroppedDown then
      begin
        FInDialog := true;
        with TColorDialog.Create(self) do
        begin
          try
            Options := FDialogOptions;
            Color := FSelectedColor;
            if FCustomColor <> clBlack then
            begin
              CustomColors.Insert(0, 'Color' + Char(Ord('A')));
              CustomColors.Values['Color' + Char(Ord('A'))] := IntToHex(FCustomColor, 8);
            end;
            TriggerColorDialogShow(false);
            if Execute and (Color <> FSelectedColor) then
            begin
              SetSelectedColor(Color);
              Change;
            end
            else
            begin
              SC := FSelectedColor;
              FSelectedColor := TColor(-2);
              SetSelectedColor(SC);
            end;
            TriggerColorDialogShow(true);
          finally
            Free;
          end;
        end;
        FInDialog := false;
      end;
    end
    else
    begin
      if ItemIndex = -1 then
      begin
        FSelectedColor := -1;
      end
      else
      try
        SetSelectedColor(
                         TLMDPtrInt(Pointer(inherited Items.Objects[inherited ItemIndex]))
                         );
      except
        on E : EConvertError do ;
      end;
    end;
  end;
  inherited;
end;

procedure TElColorCombo.Loaded;
var SC : TColor;
begin
  FInDialog := true;
  SC := FSelectedColor;
  FSelectedColor := sc - 1;
  inherited;
  FillItems;
  SetSelectedColor(SC);
  FInDialog := false;
end;

procedure TElColorCombo.CMFontChanged(var Message: TMessage);
begin
  inherited;
  inherited ItemHeight := Abs(Font.Height) + GetSystemMetrics(SM_CXEDGE) * 2;
end;

procedure TElColorCombo.DoAddMoreColors(Items : TLMDStrings);
begin
  if assigned(FOnAddMoreColors) then FOnAddMoreColors(Self, Items);
end;

procedure TElColorCombo.TriggerColorDialogShow(AfterShow : boolean);
begin
  if assigned(FOnColorDialogShow) then
  begin
    FOnColorDialogShow(Self, AfterShow);
  end;
end;

procedure TElColorCombo.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('AutoSelect', FakeBoolean, nil, false);
    Filer.DefineProperty('Style', FakeIdent, nil, false);
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('ItemIndex', FakeInteger, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
end;

initialization

  s_Custom := SLMDCustom;

end.
