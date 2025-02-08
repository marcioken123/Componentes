unit ElFontListBox;
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

ElFontListBox unit
------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Printers, StdCtrls, SysUtils, Classes, Types,
  LMDTypes, LMDThemes, Themes,LMDProcs, LMDClass, LMDDebugUnit, LMDGraphUtils, LMDGraph,
  ElVCLUtils, ElListBox, ElCombos;

type
    TElFontListBox = class(TCustomElListBox)
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
      {procedure Paint; override;}
//      procedure SetEditRect(Value : TRect); override;
      function GetItemIndex: Integer;
    public
      procedure RebuildFontList;
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
//      procedure DoChange; override;
      property UseXPThemes;
    published
      property FontName: TFontName read GetFontName write SetFontName;
      property Options: TElFontComboOptions read FOptions write SetOptions;
      property SampleText: TLMDString read FSampleText write SetSampleText;
      property FontPitch: TFontPitch read FFontPitch write SetFontPitch;
      property SampleMode: TElFontSampleMode read FSampleMode write SetSampleMode;
      property FontDevice: TElFontDevice read FFontDevice write SetFontDevice;
      property ManualEdit: Boolean read FManualEdit write SetManualEdit default false;
      property ItemIndex: Integer read GetItemIndex write FItemIndex;

      //Begin From TElListBox
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
      //property ItemIndex;
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
      //property Images;
      //property AlphaForImages;

      property ImageForm;

      property InactiveBorderType;
      property InvertSelection;
      property LineBorderActiveColor;
      property LineBorderInactiveColor;

      property SelectedFont;
      property ShowLineHint;
      property Transparent;
      //property TransparentSelection;
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
      property OnDrawItem;
      property OnMeasureItem;
      {< ELSCROLLBAR}
      property UseCustomScrollBars;
      property HorzScrollBarStyles;
      property VertScrollBarStyles;
      {> ELSCROLLBAR}
      property RightAlignedView;
      //End   From TElListBox

      property AutoSize;
      property DockOrientation;
      property Floating;
      property DoubleBuffered;
  end;

implementation
uses
  ElXPThemedControl, ElEdits
  ;

var FDeviceBmp,
    FTrueTypeBmp: TBitmap;

procedure TElFontListBox.SetFontName(Value: TFontName);
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

procedure TElFontListBox.SetOptions(Value: TElFontComboOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end
end;

procedure TElFontListBox.SetSampleText(Value: TLMDString);
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
end;

function EnumFontsProc(var EnumLogFont: TEnumLogFont;
  var TextMetric: TNewTextMetric; FontType: Integer; Data: LPARAM): Integer; stdcall;

begin
  with TElFontListBox(Pointer(Data)) do
    if IsValidFont(Options, FontPitch, EnumLogFont.elfLogFont, FontType) then
      AddFont(StrPas({$ifdef lmdcomp12}PWideChar{$endif}(@EnumLogFont.elfLogFont.lfFaceName)), FontType);
  Result := 1;
end;

procedure TElFontListBox.RebuildFontList;
var
  DC: HDC;
  S : string;
begin
  if not HandleAllocated then Exit;
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

procedure TElFontListBox.SetFontPitch(Value: TFontPitch);
begin
  if FFontPitch <> Value then
  begin
    FFontPitch := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end;
end;

procedure TElFontListBox.SetSampleMode(Value: TElFontSampleMode);
begin
  if FSampleMode <> Value then
  begin
    FSampleMode := Value;
    Invalidate;
  end;
end;

function TElFontListBox.GetItemText(index : integer): TLMDString;
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

procedure TElFontListBox.CreateWnd;
begin
  inherited;
  if (ComponentState * [csLoading, csReading] = []) then
  begin
    RebuildFontList;
    if FFontName <> '' then
      FontName := FFontName;
  end;
end;

function TElFontListBox.GetItemWidth(Index: Integer): Integer;
var
  S   : TLMDString;
  R, R2: TRect;
  LThemeMode: TLMDThemeMode;
  LDetail: TThemedEdit;
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
    if not Enabled then
      LDetail := teEditTextDisabled
    else
      LDetail := teEditTextNormal;

    LMDThemeServices.GetThemeTextExtent(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), S, Length(WideString(S)), DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_CALCRECT, @R2, R);
    Result := R.Right - R.Left + 24;
    exit;
  end;
  LMDDrawText(Canvas.Handle, S, Length(S), R, DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_CALCRECT);
  Result := R.Right - R.Left + 24;
end;

procedure TElFontListBox.MeasureItem(Index: Integer; var Height:
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

procedure TElFontListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);

var Bitmap : TBitmap;
    R,R1: TRect;
    //sid    : integer;
    S      : TLMDString;
    Sz       : TSize;
    i        : integer;
    Flags, TextColor, BackColor: longint;
    AColor  : TColor;
    BgRect  : TRect;
    P       : TPoint;
    ax, ay  : integer;
    LDetail: TThemedButton;
    LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  Canvas.Font.Assign(Font);

  if (Index = -1) or (SampleMode = fsmNoSample) then
    Canvas.Font.Name := Font.Name
  else
    Canvas.Font.Name := Items[Index];
  if (FStyle <> lbStandard) and Assigned(FOnDrawItem) then
  begin
    FOnDrawItem(Self, Index, Rect, State);
    exit;
  end;
  TextColor := GetTextColor(Canvas.Handle);
  BackColor := GetBkColor(Canvas.Handle);
  AColor    := BackColor;

  if (odSelected in State) and (not FInvertSelection) and FTransparentSelection then
    Canvas.Font.Color := Font.Color;

  if (odSelected in State) and (not FInvertSelection) and (not FTransparentSelection) then
  begin
    if Focused then
      AColor := FocusedSelectColor
    else
    if not HideSelection then
      AColor := HideSelectColor
    else
      AColor := Color;

    if HighlightAlphaLevel = 255 then
    begin
      Canvas.Brush.Color := AColor;
      Canvas.FillRect(Rect);
    end;
    BgRect := Rect;
  end
  else
  begin

    if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
      (not (csDesigning in Componentstate)) then
    begin
      // if (FImgForm.Control <> Self) then
      begin
        R1 := Rect;
        BgRect := Rect;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := ClientToScreen(ClientRect.TopLeft);
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);

        BgRect.TopLeft := RealScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := RealScreenToClient(BgRect.BottomRight);
        FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
      end;
      if (BgRect.Bottom > GetParentCtlHeight) or
         (BgRect.Right  > GetParentCtlWidth) or
         (BgRect.Left < 0) or (BgRect.Top < 0) then
        Canvas.FillRect(Rect);
    end
    else
    if FTransparent then
      DrawParentControlEx(Canvas.Handle, Rect)
    else
    if FUseBackground and not Background.Empty then
      DrawBackgroundEx(Canvas.Handle, ClientRect, Rect)
    else
    if not FTransparentSelection then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(Rect);
    end;
  end;
  if (odSelected in State) and FInvertSelection then
    InvertRect(Canvas.Handle, Rect);
  if (odSelected in State) then
  begin
    if (not FTransparentSelection) and (UseSelectedFont) then
      Canvas.Font.Assign(FSelectedFont)
    else
    begin
      if Focused then
        Canvas.Font.Color := FocusedSelectTextColor
      else
      if not HideSelection then
        Canvas.Font.Color := HideSelectTextColor
      else
        Canvas.Font.Color := Font.Color;
    end;
  end;

  //Canvas.Brush.Style := bsClear;

  if ShowCheckBox then
    begin
      R1 := Rect;
      sz := GetCheckBoxSize;

      if RightAlignedText then
      begin
        dec(R1.Right, 2);
        R1.Left := R1.Right - Sz.cx;
      end
      else
      begin
        inc(R1.Left, 2);
        R1.Right := R1.Left + Sz.cx;
      end;
      R1.Top := R1.Top + (R1.Bottom - R1.Top - Sz.cy) div 2;
      R1.Bottom := R1.Top + Sz.cy;
      if LThemeMode <> ttmNone then
      begin
        LDetail := tbCheckBoxCheckedNormal;
        case GetState(Index) of
          cbUnchecked :
            if not Enabled then
              LDetail := tbCheckBoxUncheckedDisabled
            else
              LDetail := tbCheckBoxUncheckedNormal;

          cbChecked :
            if not Enabled then
              LDetail := tbCheckBoxCheckedDisabled
            else
              LDetail := tbCheckBoxCheckedNormal;

          cbGrayed :
            if not Enabled then
              LDetail := tbCheckBoxMixedDisabled
            else
              LDetail := tbCheckBoxMixedNormal;
        end;
        LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, R1, LMDRectToPtr(Rect));
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
(*
  Canvas.Brush.Style := bsClear;
  LMDDrawText(Canvas.Handle, S, Length(S), Rect, DT_SINGLELINE or DT_VCENTER or DT_LEFT);

  if (odSelected in State) and (HighlightAlphaLevel < 255) then
  begin
    LMDAlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
  end;
*)

    //TextRect := R;
    Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
    if RightAlignedText then
      Flags := Flags or DT_RTLREADING;
    if RightAlignedText then
      Inc(Rect.Left, 2)
    else
      Dec(Rect.Right, 2);

    if Assigned(FOnDrawText) then
      FOnDrawText(Self, Canvas, Index, {Text}Rect, Flags)
    else
      DoDrawText(Self, Canvas, s {Items[Index]}, {Text}Rect, Flags);

  if (odSelected in State) and (not FInvertSelection) and
    (not FTransparentSelection) and (HighlightAlphaLevel < 255) then
  begin
    LMDAlphaFillRect(Canvas, BgRect, AColor, HighlightAlphaLevel);
  end;

  SetTextColor(Canvas.Handle, TextColor);
  SetBkColor(Canvas.Handle, BackColor);
end;

procedure TElFontListBox.SetFontDevice(Value: TElFontDevice);
begin
  if FFontDevice <> Value then
  begin
    FFontDevice := Value;
    if ComponentState * [csReading, csLoading, csDestroying] = [] then
      RebuildFontList;
  end;
end;

{$O-}
procedure TElFontListBox.AddFont(Font : TFontName; FontType : integer);
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

function TElFontListBox.GetFontName: TFontName;
begin
  if Items.Count= 0 then
    Result := FFontName
  else
  if ItemIndex = -1 then
    Result := Text
  else
    Result := Items[ItemIndex];
end;

constructor TElFontListBox.Create(AOwner : TComponent);
{ Creates an object of type TElHTMLComboBox, and initializes properties. }
begin
  inherited Create(AOwner);
  FFontDevice := efdBoth;
  FOptions := [foIncludeOEMFonts, foIncludeSymbolFonts];
//  Style := csOwnerDrawFixed;
//  FReadOnly := true;
end;  { Create }

destructor TElFontListBox.Destroy;
begin
  inherited Destroy;
end;  { Destroy }

procedure TElFontListBox.Loaded;
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

procedure TElFontListBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
end;

procedure TElFontListBox.SetManualEdit(Value: Boolean);
begin
  if FManualEdit <> Value then
  begin
    FManualEdit := Value;
//    ReadOnly := not FManualEdit;
  end;
end;

function TElFontListBox.GetItemIndex: Integer;
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
      LMDDebug('ERROR finalization FontList: ' + e.Message);
    end;
  end;

end.
