unit ElFontCombo;
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

ElFontCombo unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Printers, StdCtrls, SysUtils, Classes,Themes,Types,
  LMDTypes, LMDProcs, LMDThemes, LMDClass, LMDDebugUnit, LMDGraphUtils,
  ElVCLUtils, ElFontListBox, ElCombos;

type
    TElFontComboBox = class(TCustomElComboBox)
    protected
      FOptions: TElFontComboOptions;
      FSampleText: TLMDString;
      FFontPitch : TFontPitch;
      FSampleMode: TElFontSampleMode;
      FFontDevice: TElFontDevice;
      FFontName  : string;
      ListFilled : boolean;
      FManualEdit: Boolean;
      FItemIndex: Integer;

      procedure SetFontName(Value: TFontName);
      procedure SetOptions(Value: TElFontComboOptions);
      procedure SetSampleText(Value: TLMDString);
      procedure SetFontPitch(Value: TFontPitch);
      procedure SetSampleMode(Value: TElFontSampleMode);
      procedure CreateWnd; override;
      function GetItemText(index : integer): TLMDString;
      function GetItemWidth(Index: Integer): Integer; override;

      procedure MeasureItem(Index: Integer; var Height: Integer); override;
      procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
      procedure SetFontDevice(Value: TElFontDevice);

      procedure AddFont(Font : TFontName; FontType : integer);
      function GetFontName: TFontName;
      procedure Loaded; override;
      procedure DefineProperties(Filer: TFiler); override;
      procedure SetManualEdit(Value: Boolean);
      procedure Paint; override;
      procedure SetEditRect(Value : TRect); override;
      function GetItemIndex: Integer;
      public
      procedure RebuildFontList;
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure DoChange; override;
      function FontIndex(AFontName : TFontName):integer;
      function FontNameByIndex(AFontIndex : integer):TFontName;
    published
      property FontName: TFontName read GetFontName write SetFontName;
      property Options: TElFontComboOptions read FOptions write SetOptions;
      property SampleText: TLMDString read FSampleText write SetSampleText;
      property FontPitch: TFontPitch read FFontPitch write SetFontPitch;
      property SampleMode: TElFontSampleMode read FSampleMode write SetSampleMode;
      property FontDevice: TElFontDevice read FFontDevice write SetFontDevice;
      property ManualEdit: Boolean read FManualEdit write SetManualEdit default false;
      property ItemIndex: Integer read GetItemIndex write FItemIndex;

      property ReadOnly;
      property ShowGripper;
      property ButtonArrowColor;

      property CanDrop;
      property DropDownCount;
      property DropDownWidth;
      property ListTransparentSelection;
      property ListColor;
      property ListImageForm;
      property ListInvertSelection;
      property Sorted;
      property UseBackground;
      property OnDropDown;
      property AdjustDropDownPos;
      property ShowLineHint;
      property HorizontalScroll;
      property DropDownAlignment;

      // inherited from TCustomElButtonEdit
      property AlignBottom;
      property TopMargin;
      property LeftMargin;
      property RightMargin;
      property AutoSize;
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

implementation

uses
  ElXPThemedControl, LMDStrings, ElEdits, LMDElConst
  ;

var
  FDeviceBmp,
  FTrueTypeBmp: TBitmap;

function TElFontComboBox.FontIndex(AFontName: TFontName): integer;
var
  i : integer;
begin
  Result := -1;
  for i := 0 to Items.Count - 1 do
  begin
    if Items[i] = AFontName then
    begin
      Result := i;
      exit;
    end;
  end;
end;

function TElFontComboBox.FontNameByIndex(AFontIndex: integer): TFontName;
begin
  Result := '';
  if LMDInRange(AFontIndex, 0, Items.Count - 1) then
    Result := Items[AFontIndex];
end;

procedure TElFontComboBox.SetFontName(Value: TFontName);
var i : integer;
    s : string;
begin
  s := Uppercase(Value);
  if (csLoading in ComponentState) or (Items.count = 0) then
    FFontName := Value
  else
  begin
    FFontName := '';
    for i := 0 to Items.Count - 1 do
    begin
      if Uppercase(Items[i]) = s then
      begin
        inherited ItemIndex := i;
        exit;
      end;
    end;
  end;
end;

procedure TElFontComboBox.SetOptions(Value: TElFontComboOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end
end;

procedure TElFontComboBox.SetSampleText(Value: TLMDString);
begin
  if FSampleText <> Value then
  begin
    FSampleText := Value;
    if SampleMode <> fsmFontName then
      Invalidate;
  end;
end;

function IsValidFont(Options : TElFontComboOptions; Pitch : TFontPitch; LogFont: TLogFont;
  FontType: Integer): Boolean;
begin
  Result := True;
  if (foAnsiOnly in Options) then
    Result := Result and (LogFont.lfCharSet = ANSI_CHARSET);
  if (foTrueTypeOnly in Options) then
    Result := Result and (FontType and TRUETYPE_FONTTYPE = TRUETYPE_FONTTYPE);

  if (Pitch = fpFixed) then
    Result := Result and (LogFont.lfPitchAndFamily and FIXED_PITCH = FIXED_PITCH)
  else
  if (Pitch = fpVariable) then
    Result := Result and (LogFont.lfPitchAndFamily and VARIABLE_PITCH = VARIABLE_PITCH);

  if (foOEMFontsOnly in Options) then
    Result := Result and (LogFont.lfCharSet = OEM_CHARSET);
  if (not (foIncludeOEMFonts in Options)) then
    Result := Result and (LogFont.lfCharSet <> OEM_CHARSET);
  if (not (foIncludeSymbolFonts in Options)) then
    Result := Result and (LogFont.lfCharSet <> SYMBOL_CHARSET);
  if (foScalableOnly in Options) then
    Result := Result and (FontType and RASTER_FONTTYPE = 0);
  if (foExcludeAtPrefixedFonts in Options) then
    Result := Result and not (LogFont.lfFaceName[0]='@');
end;

function EnumFontsProc(var EnumLogFont: TEnumLogFont;  var TextMetric: TNewTextMetric;
                       FontType: Integer; Data: LPARAM): Integer; stdcall;

begin
  with TElFontComboBox(Pointer(Data)) do
  if IsValidFont(Options, FontPitch, EnumLogFont.elfLogFont, FontType) then
      AddFont(StrPas({$ifdef lmdcomp12}PWideChar{$endif}(@EnumLogFont.elfLogFont.lfFaceName)), FontType);
    Result := 1;
end;

procedure TElFontComboBox.RebuildFontList;
var
  DC: HDC;
  S : string;
begin
//  if not HandleAllocated then Exit;
  ListFilled := true;
  DC := GetDC(0);
  S := FontName;
  Items.Clear;
  Items.BeginUpdate;
  try
    if (FFontDevice = efdScreen) or (FFontDevice = efdBoth) then
        EnumFontFamilies(DC, nil, @EnumFontsProc, TLMDPtrUInt(Self));
        if (FFontDevice = efdPrinter) or (FFontDevice = efdBoth) then
    try
      EnumFontFamilies(Printer.Handle, nil, @EnumFontsProc, TLMDPtrUInt(Self));
      except
      { skip any errors }
    end;
  finally
    Items.EndUpdate;
    ReleaseDC(0, DC);
  end;
  FontName := S;
end;

procedure TElFontComboBox.SetFontPitch(Value: TFontPitch);
begin
  if FFontPitch <> Value then
  begin
    FFontPitch := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end;
end;

procedure TElFontComboBox.SetSampleMode(Value: TElFontSampleMode);
begin
  if FSampleMode <> Value then
  begin
    FSampleMode := Value;
    Invalidate;
  end;
end;

function TElFontComboBox.GetItemText(index : integer): TLMDString;
begin
  if SampleMode = fsmFontName then
    result := Items[Index]
  else
  if SampleMode = fsmFontSample then
    result := SampleText
  else
  if Length(SampleText) > 0 then
    result := TLMDString(Items[Index] + ' - ') + SampleText
  else
    result := TLMDString(Items[Index]);
end;

procedure TElFontComboBox.CreateWnd;
begin
  inherited;
  if (ComponentState * [csLoading, csReading] = []) then
  begin
    RebuildFontList;
    if FFontName <> '' then
      FontName := FFontName;
  end;
end;

function TElFontComboBox.GetItemWidth(Index: Integer): Integer;
var
  S   : TLMDString;
  R, R2: TRect;
  LDetail: TThemedEdit;
  LThemeMode: TLMDThemeMode;
begin
  if Index = -1 then
    Canvas.Font.Name := Font.Name
  else
    Canvas.Font.Name := Items[Index];

  S := GetItemText(Index);
  SetRectEmpty(R);
  SetRectEmpty(R2);
  LThemeMode := UseThemeMode;
  if LThemeMode <> ttmNone then
  begin
    begin
      if not Enabled then
        LDetail := teEditTextDisabled
      else
        LDetail := teEditTextNormal;

      LMDThemeServices.GetThemeTextExtent(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), S, Length(WideString(S)), DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_CALCRECT, @R2, R);
      Result := R.Right - R.Left + 24;
      exit;
    end;
  end;
  LMDDrawText(Canvas.Handle, S, Length(S), R, DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_CALCRECT);
  Result := R.Right - R.Left + 24;
end;

procedure TElFontComboBox.MeasureItem(Index: Integer; var Height:
    Integer);

var S : TLMDString;
    R : TRect;
    Metrics : TLMDTextMetric;
    //ATheme  : HTheme;
    //sid     : integer;
begin
  if (Index = -1) or (SampleMode = fsmNoSample) then
    Canvas.Font.Name := Font.Name
  else
    Canvas.Font.Name := Items[Index];

  if (Index <> -1) and (Index < Items.Count) then
  begin
    S := GetItemText(Index);
    SetRectEmpty(R);
    LMDDrawText(Canvas.Handle, S, Length(S), R, DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_CALCRECT);
    Height := R.Bottom - R.Top + 2;
  end
  else
  begin
    LMDGetTextMetrics(Canvas.Handle, Metrics);
    Height := Abs(Metrics.tmHeight) + 2;
    end;
end;

procedure TElFontComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);

var Bitmap : TBitmap;
    R      : TRect;
    S      : TLMDString;
    fillback : boolean;
    LDetail: TThemedEdit;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  Canvas.Font.Assign(Font);

  if (Index = -1) or (SampleMode = fsmNoSample) then
    Canvas.Font.Name := Font.Name
  else
    Canvas.Font.Name := Items[Index];

  if (odSelected in State) or ((odComboboxEdit in State) and Focused) then
  begin
    Canvas.Brush.Color := FocusedSelectColor;
    Canvas.Font.Color := FocusedSelectTextColor;
  end
  else
    if (odComboboxEdit in State) and (ReadOnly and FDisplayReadOnlyOptions.Enabled) then
    begin
      if LThemeMode <> ttmNone then
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
              (UseBackground = false) and
              ((ImageForm = nil) or (csDesigning in ComponentState)) or
              (not IsAnyBitsInOwnerDrawState(State, ODS_COMBOBOXEDIT) );

  if {not ((XPThemesAvailable and IsThemed) and UseXPThemes)) and} (((not (odSelected in State)) and FillBack) or ((odSelected in State) and (HighlightAlphaLevel = 255))) then
  begin
    Canvas.FillRect(Rect);
  end;
    if (odSelected in State) or ((odComboboxEdit in State) and Focused) then
      Canvas.Font.Color := FocusedSelectTextColor
    else
      Canvas.Font.Color := Font.Color;
    if (odComboboxEdit in State) and (ReadOnly and FDisplayReadOnlyOptions.Enabled) then
      Canvas.Font.Color := FDisplayReadOnlyOptions.TextColor;
    if (odComboboxEdit in State) and not Enabled and UseDisabledColors then
      Canvas.Font.Color := DisabledFontColor;

  Canvas.Brush.Style := bsClear;

  if (TLMDPtrInt(Items.Objects[Index]) and TRUETYPE_FONTTYPE) <> 0 then
    Bitmap := FTrueTypeBmp
  else
  if (TLMDPtrInt(Items.Objects[Index]) and DEVICE_FONTTYPE) <> 0 then
    Bitmap := FDeviceBmp
  else
    Bitmap := nil;
  if Bitmap <> nil then
  begin
    R.Left := Rect.Left;
    R.Right := R.Left + 20;
    R.Top := Rect.Top + (Rect.Bottom - Rect.Top - 12) div 2;
    R.Bottom := R.Top + 12;
    Canvas.BrushCopy(R, Bitmap, Classes.Rect(0, 0, 20, 12), clFuchsia);
  end;
  s := GetItemText(Index);

  Inc(Rect.Left, 20);

  Canvas.Brush.Style := bsClear;
  if (LThemeMode <> ttmNone) and not (ReadOnly and not FIgnoreReadOnlyState) and not (odSelected in State) and not ((odComboboxEdit in State) and Focused) and (Enabled or not UseDisabledColors) then
  begin
    if FMouseOver then
      LDetail := teEditTextHot
    else
      LDetail := teEditTextNormal;
    LMDThemeServices.DrawThemeText(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), S, Length(WideString(s)), DT_VCENTER or DT_NOPREFIX or DT_LEFT or DT_SINGLELINE, 0, Rect);
  end
  else
    LMDDrawText(Canvas.Handle, S, Length(s), Rect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);

  if (odSelected in State) and (HighlightAlphaLevel < 255) then
  begin
    LMDAlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
  end;
end;

procedure TElFontComboBox.SetFontDevice(Value: TElFontDevice);
begin
  if FFontDevice <> Value then
  begin
    FFontDevice := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end;
end;

{$O-}
procedure TElFontComboBox.AddFont(Font : TFontName; FontType : integer);
var i : integer;
begin
  if Items.IndexOf(Font) = -1 then
  begin
    if Sorted then
      Items.AddObject(Font, TObject(Pointer(FontType)))
    else
    for i := 0 to Items.Count do
    begin
      if (i = Items.Count) or (AnsiCompareStr(Font, Items[i]) < 0) then
      begin
        Items.InsertObject(i, Font, TObject(Pointer(FontType)));
        exit;
      end;
    end;
  end
end;

function TElFontComboBox.GetFontName: TFontName;
begin
  if Items.Count= 0 then
    Result := FFontName
  else
  if ItemIndex = -1 then
    Result := Text
  else
    Result := Items[ItemIndex];
end;

constructor TElFontComboBox.Create(AOwner : TComponent);
{ Creates an object of type TElHTMLComboBox, and initializes properties. }
begin
  inherited Create(AOwner);
  FFontDevice := efdBoth;
  FOptions := [foIncludeOEMFonts, foIncludeSymbolFonts];
  Style := csOwnerDrawFixed;
  FReadOnly := true;
end;  { Create }

destructor TElFontComboBox.Destroy;
begin
  inherited Destroy;
end;  { Destroy }

procedure TElFontComboBox.Loaded;
begin
  inherited;
  // if not ListFilled then
  if HandleAllocated then
  begin
    RebuildFontList;
    if FFontName <> '' then
      FontName := FFontName;
  end;
end;

procedure TElFontComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
end;

procedure TElFontComboBox.SetManualEdit(Value: Boolean);
begin
  if FManualEdit <> Value then
  begin
    FManualEdit := Value;
    ReadOnly := not FManualEdit;
  end;
end;

procedure TElFontComboBox.Paint;
var R : TRect;
    Bitmap : TBitmap;
    Canvas : TCanvas;
    i : integer;
begin
  if ManualEdit then
  begin
    i := FItemIndex;
    FItemIndex := -1;
    inherited;
    FItemIndex := i;
  end
  else
    inherited;

  if ManualEdit and (ItemIndex <> -1) then
  begin
    Canvas := TCanvas.Create;
    Canvas.Handle := GetDC(Handle);

    if (TLMDPtrInt(Items.Objects[ItemIndex]) and TRUETYPE_FONTTYPE) <> 0 then
      Bitmap := FTrueTypeBmp
    else
    if (TLMDPtrInt(Items.Objects[ItemIndex]) and DEVICE_FONTTYPE) <> 0 then
      Bitmap := FDeviceBmp
    else
      Bitmap := nil;
    if Bitmap <> nil then
    begin
      R.Left := 0;
      R.Right := 20;
      R.Top := (ClientHeight - 12) div 2;
      R.Bottom := R.Top + 12;

      DrawTransparentBitmapEx(Canvas.Handle, Bitmap, R.Left, R.Top, Classes.Rect(0, 0, 20, 12), clFuchsia);
      // Canvas.BrushCopy(R, Bitmap, Classes.Rect(0, 0, 20, 12), clFuchsia);
    end;
    ReleaseDC(Handle, Canvas.Handle);
    Canvas.Handle := 0;
    Canvas.Free;
  end;
end;

procedure TElFontComboBox.SetEditRect(Value : TRect);
begin
  LeftMargin := 20;
  inherited SetEditRect(Value);
end;

procedure TElFontComboBox.DoChange;
var i : integer;
    b : boolean;
    s : TLMDString;
begin
  b := false;
  i := Items.IndexOf(Text);
  if i <> -1 then
    b := true
  else
  begin
    {$ifdef LMD_UNICODE}
    s := LMDWideLowercase(Text);
    {$else}
    s := lowercase(Text);
    {$endif}
    for i := 0 to Items.Count - 1 do
    begin
      {$ifdef LMD_UNICODE}
      if s = LMDWideLowercase(Items[i]) then
      {$else}
      if s = lowercase(Items[i]) then
      {$endif}
      begin
        b := true;
        break;
      end;
    end;
  end;
  if b and (ItemIndex <> i) then
    ItemIndex := i
  else
  if (not b) and (ItemIndex <> -1) then
    inherited ItemIndex := -1;
  inherited;
end;

function TElFontComboBox.GetItemIndex: Integer;
begin
  Result := inherited ItemIndex;
end;

initialization

  FTrueTypeBmp := TBitmap.Create;
  FDeviceBmp := TBitmap.Create;

  FTrueTypeBmp.LoadFromResourceName(HInstance, 'ELFONTCOMBOTRUETYPEBITMAP');
  FDeviceBmp.LoadFromResourceName(HInstance, 'ELFONTCOMBODEVICEBITMAP');
  finalization

  try
    FTrueTypeBmp.Free;
    FDeviceBmp.Free;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElFontCombo: ' + e.Message);
    end;
  end;

end.
