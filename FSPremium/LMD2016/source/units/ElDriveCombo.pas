unit ElDriveCombo;
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

ElDriveCombo unit
-----------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses

  Controls,
  Messages,
  Windows,
  Graphics,
  ShellApi,
  StdCtrls,
  Forms,
  SysUtils,
  Classes,
  Math,
  Types,
  Themes,

  LMDTypes,
  LMDProcs,
  LMDStrings,
  LMDGraphUtils,
  LMDShUtils,
  LMDThemes,

  ElShellUtils,
  ElVCLUtils,
  ElCombos;

type

  TElDriveComboOption = (dcoDisplayFloppy,
                         dcoDisplayNetwork,
                         dcoDisplayHard,
                         dcoDisplayCD,
                         dcoDisplayRAM);

  TElDriveComboOptions = set of TElDriveComboOption;

  //en
  //{$IFNDEF BCB}
  //TOwnerDrawState = ElVCLUtils.TOwnerDrawState;
  //{$ENDIF}

  TElDriveComboBox = class(TCustomElComboBox)
  private
    FDummyChar  : char;
  protected
    FDrive: Char;
    FTextCase: TElTextCase;
    FOptions: TElDriveComboOptions;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure FillItems;
    procedure SetDrive(Value: Char);
    procedure CreateWnd; override;
    procedure SetTextCase(Value: TElTextCase);
    procedure SetOptions(Value: TElDriveComboOptions);
    procedure DoChange; override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner :TComponent); override;
    property Drive: Char read FDrive write SetDrive;
    property ItemIndex: Char read FDummyChar;
  published
    property TextCase: TElTextCase read FTextCase write SetTextCase default etcLowercase;
    property Options: TElDriveComboOptions read FOptions write SetOptions;

    property ButtonArrowColor;

    property ShowGripper;
    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property ListColor;
    property ListImageForm;
    property ListInvertSelection;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ShowLineHint;
    property HorizontalScroll;
    property OnDrawItem;
    property OnMeasureItem;
    property DropDownAlignment;
    property ReadOnly;
    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
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

implementation

uses
  ElEdits, ElXPThemedControl, LMDClass;

procedure TElDriveComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);

var
  S : string;
  {$ifdef LMD_UNICODE}
  fi : TSHFileInfoW;
  {$else}
  fi : TSHFileInfo;
  {$endif}
  iw,
  ih : integer;
  fillback : boolean;
  LDetail: TThemedEdit;
  LUseThemeMode: TLMDThemeMode;
begin
  LUseThemeMode := UseThemeMode;
  Canvas.Brush.Style := bsSolid;

  if (odSelected in State) or (Focused and (odComboBoxEdit in State)) then
    Canvas.Brush.Color := FocusedSelectColor
  else
    if (odComboboxEdit in State) and (ReadOnly and FDisplayReadOnlyOptions.Enabled) then
    begin
      if (LUseThemeMode <> ttmNone) then
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

  if {not ((XPThemesAvailable and IsThemeActive) and UseXPThemes) and} ((((not (odSelected in State)) and FillBack) or ((odSelected in State) and (HighlightAlphaLevel = 255)))) then
  begin
    Canvas.FillRect(Rect);
  end;
  if (odSelected in State) or (Focused and (odComboBoxEdit in State)) then
    Canvas.Font.Color := FocusedSelectTextColor
  else
    if (odComboboxEdit in State) and (ReadOnly and FDisplayReadOnlyOptions.Enabled) then
      Canvas.Font.Color := FDisplayReadOnlyOptions.TextColor
    else
      if not Enabled and UseDisabledColors then
        Canvas.Font.Color := DisabledFontColor
      else
        Canvas.Font.Color := Font.Color;
  Canvas.Brush.Style := bsClear;

  if ItemHeight < GetSystemMetrics(SM_CXICON) then
    begin
      {$ifdef LMD_UNICODE}
      SHGetFileInfoW(PWideChar(inherited Items[Index][1] + WideString(':\')), 0, fi, sizeof(fi), SHGFI_ICON or SHGFI_SMALLICON);
      {$else}
      SHGetFileInfo(PChar(inherited Items[Index][1] + ':\'), 0, fi, sizeof(fi), SHGFI_ICON or SHGFI_SMALLICON);
      {$endif}
      iw := GetSystemMetrics(SM_CXSMICON);
      ih := GetSystemMetrics(SM_CYSMICON);
    end
  else
    begin
      {$ifdef LMD_UNICODE}
      SHGetFileInfoW(PWideChar(inherited Items[Index][1] + WideString(':\')), 0, fi, sizeof(fi), SHGFI_ICON or SHGFI_LARGEICON);
      {$else}
      SHGetFileInfo(PChar(inherited Items[Index][1] + ':\'), 0, fi, sizeof(fi), SHGFI_ICON or SHGFI_LARGEICON);
      {$endif}
      iw := GetSystemMetrics(SM_CXICON);
      ih := GetSystemMetrics(SM_CYICON);
    end;

  DrawIconEx(Canvas.Handle, Rect.Left, Rect.Top + (Rect.Bottom - Rect.Top - ih) div 2, fi.hIcon, Min(ItemHeight, ih), Min(ItemHeight, iw), 0, 0, DI_NORMAL);

  Inc(Rect.Left, iw + iw div 4);

  S := inherited Items[Index];
  case TextCase of
    etcLowercase: S := Lowercase(S);
    etcUppercase: S := Uppercase(S);
  end;
  if (LUseThemeMode <> ttmNone) and not (ReadOnly and not FIgnoreReadOnlyState) and not (odSelected in State) and not ((odComboboxEdit in State) and Focused) and (Enabled or not UseDisabledColors) then
  begin
//    if not Enabled then
//      LDetail := teEditTextDISABLED
//    else
//    if odSelected in State then
//      LDetail := teEditTextSELECTED
//    else
    if FMouseOver then
      LDetail := teEditTextHot
    else
    if ReadOnly then
    begin
      if FIgnoreReadOnlyState then
        LDetail := teEditTextNormal
      else
        LDetail := teEditTextReadOnly;
    end
    else
      LDetail := teEditTextNormal;
    LMDThemeServices.DrawThemeText(UseThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), s, Length(WideString(s)), DT_VCENTER or DT_NOPREFIX or DT_LEFT or DT_SINGLELINE, 0, Rect);
  end
  else
    DrawText(Canvas.Handle, PChar(S), Length(S), Rect, DT_VCENTER or DT_NOPREFIX or DT_LEFT or DT_SINGLELINE);

  if (odSelected in State) and (HighlightAlphaLevel < 255) then
  begin
    LMDAlphaFillRect(Canvas, Rect, FocusedSelectColor, HighlightAlphaLevel);
  end;

  end;

procedure TElDriveComboBox.FillItems;
type
  TDriverBits = set of 0..25;

var
    i : Cardinal;
    c : char;
    sv: integer;
    Drives: TDriverBits;
    Name  : string;
    dt : DWORD;

    function GetVolumeName(Volume : string) : string;
    var
      NameBuf: array[0..255] of char;
      begin

      NameBuf[0] := #0;
      GetVolumeInformation(PChar(Volume), NameBuf, 255, @i, i, i, nil, 0);
      SetString(Result, NameBuf, StrLen(NameBuf));

    end;

    function GetNetworkVolumeName(Volume : string) : string;
    var
      Buf : array [0..MAX_PATH] of Char;
      Drv : array [0..3] of Char;
      BufSize: Cardinal;

    begin
      BufSize := sizeof(buf);
      StrPCopy(Drv, Volume);
      if WNetGetConnection(Drv, Buf, BufSize) = WN_SUCCESS then
        result := StrPas(Buf)
        else
        result := '';
    end;

begin
  inherited Items.Clear;
  sv := Windows.SetErrorMode(SEM_FAILCRITICALERRORS);
  Drives := TDriverBits(GetLogicalDrives());
  for c := 'A' to 'Z' do
  begin
    if Ord(C) - Ord('A') in Drives then
    begin
      dt := GetDriveType(Int_Ref(C + ':\'));
      if (dt = DRIVE_REMOVABLE) and not (dcoDisplayFloppy in Options) then
        Continue;
      if (dt = DRIVE_REMOTE) and not (dcoDisplayNetwork in Options) then
        Continue;
      if (dt = DRIVE_CDROM) and not (dcoDisplayCD in Options) then
        Continue;
      if (dt = DRIVE_FIXED) and not (dcoDisplayHard in Options) then
        Continue;
      if (dt = DRIVE_RAMDISK) and not (dcoDisplayRAM in Options) then
        Continue;
      if dt = DRIVE_REMOVABLE then
        Name := ''
      else
      if dt = DRIVE_REMOTE then
        Name := GetNetworkVolumeName(C + ':')
      else
        Name := GetVolumeName(C + ':\');

      inherited Items.Add(Format('%s: [%s]', [C, Name]));
    end;
  end;
  Windows.SetErrorMode(sv);
end;

procedure TElDriveComboBox.SetDrive(Value: Char);
var i, j : integer;
begin
  if FDrive <> Value then
  begin
    Value := Upcase(Value);
    if AnsiChar(Value) in ['A'..'Z'] then
    begin
      j := inherited Items.Count - 1;
      for i := 0 to j do
      begin
        if (inherited Items[i])[1] = TLMDChar(Value) then
        begin
          FDrive := Value;
          inherited ItemIndex := i;
          exit;
        end;
      end;
    end;
  end;
end;

constructor TElDriveComboBox.Create(AOwner :TComponent);
begin
  inherited;
  FDrive := 'C';
  inherited Style := csOwnerDrawFixed;
  FTextCase  := etcLowercase;
  FOptions := [dcoDisplayFloppy, dcoDisplayNetwork, dcoDisplayHard, dcoDisplayCD, dcoDisplayRAM];
  inherited ItemHeight := Max(Abs(Font.Height) + 2 + GetSystemMetrics(SM_CXEDGE) * 2, Max(ItemHeight, GetSystemMetrics(SM_CYSMICON)));
end;

procedure TElDriveComboBox.CreateWnd;
var D : Char;
    b : array[0..MAX_PATH] of char;
    ro: boolean;
begin
  ro := ReadOnly;
  ReadOnly := false;
  inherited;
  FillItems;
  D := FDrive;
  GetCurrentDirectory(MAX_PATH, b);
  FDrive := B[0];  // should it be [1]?
  SetDrive(D);     // and now we use D again??
  ReadOnly := ro;
end;

procedure TElDriveComboBox.SetTextCase(Value: TElTextCase);
begin
  if FTextCase <> Value then
  begin
    FTextCase := Value;
    FillItems;
  end;
end;

procedure TElDriveComboBox.SetOptions(Value: TElDriveComboOptions);
var D : Char;
    b : array[0..MAX_PATH] of char;
    begin
  if FOptions <> Value then
    begin
      FOptions := Value;
      D := FDrive;
      FillItems;
      GetCurrentDirectory(MAX_PATH, b);
      FDrive := B[0];  // should it be [1]?
      SetDrive(D);
    end;
end;

procedure TElDriveComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  inherited ItemHeight := Max(Abs(Font.Height) + 2 + GetSystemMetrics(SM_CXEDGE) * 2, Max(ItemHeight, GetSystemMetrics(SM_CYSMICON)));
end;

procedure TElDriveComboBox.DoChange;
begin
  inherited;
  if inherited ItemIndex = -1 then
    FDrive := #0
  else
    FDrive := Char(inherited Items[inherited ItemIndex][1]);
end;

procedure TElDriveComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('ItemIndex', FakeInteger, nil, false);
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
end;

end.
