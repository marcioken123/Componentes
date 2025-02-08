unit ElImgCombo;
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

ElImgCombo unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  Classes,
  ImgList,
  Controls,
  StdCtrls,
  CommCtrl,
  Types,
  Themes,

  LMDThemes,
  LMDTypes,
  LMDProcs,
  LMDUnicodeStrings,
  LMDGraphUtils,

  ElEdits,
  ElCombos,
  ELVCLUtils;

type
  TElImageNameEvent = procedure(Sender : TObject; Index : integer; var Text: TElFString) of object;

  //en
  //{$IFNDEF BCB}
  //TOwnerDrawState = ElVCLUtils.TOwnerDrawState;
  //{$ENDIF}

  TElImageComboBox = class(TCustomElComboBox)
  private
    FChLink   : TChangeLink;
    FImages   : TCustomImageList;
    FAChLink   : TChangeLink;
    FAlphaImages   : TCustomImageList;
    FModified : Boolean;
    FImageNames: TLMDStrings;
    IOffs: Integer;
    FUseImageNames: Boolean;
    procedure ImagesChanged(Sender : TObject);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetAlphaImages(const Value: TCustomImageList);
    procedure Remake;
    function GetImageIndex: Integer;
    procedure SetImageIndex(const Value: Integer);
    procedure SetModified(const Value: Boolean);
    procedure SetImageNames(Value: TLMDStrings);
    procedure SetUseImageNames(Value: Boolean);
  protected
    FOnImageName: TElImageNameEvent;
    FManualEdit: Boolean;
    FEmptyValueText: string;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoDropDown; override;
    procedure DblClick; override;
    procedure DoChange; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure TriggerImageNameEvent(Index : Integer; var Text : TLMDString); virtual;
    procedure SetManualEdit(Value: Boolean);
    function GetShowEmptyValue: Boolean;
    procedure SetShowEmptyValue(Value: Boolean);
    procedure Loaded; override;
    procedure SetEmptyValueText(const Value: string);
    procedure RebuildList;
    function GetItemWidth(Index: Integer): Integer; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetEditRect(Value : TRect); override;
    procedure Paint; override;
    procedure KeyPress(var Key : char); override;
    procedure DisplayOptionsChange(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // property ItemIndex : integer read GetImageIndex write SetImageIndex;
  published

    property Images: TCustomImageList read FImages write SetImages;
    property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex default -1;
    property Modified: Boolean read FModified write SetModified;
    property ManualEdit: Boolean read FManualEdit write SetManualEdit default true;
    property ShowEmptyValue: Boolean read GetShowEmptyValue write SetShowEmptyValue
        default true;
    property EmptyValueText: string read FEmptyValueText write SetEmptyValueText;

    property OnImageName: TElImageNameEvent read FOnImageName write FOnImageName;
    property ImageNames: TLMDStrings read FImageNames write SetImageNames;
    property UseImageNames: Boolean read FUseImageNames write SetUseImageNames default false;

    property ButtonArrowColor;

    property ReadOnly;
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

    // inherited from TCustomElButtonEdit
    property AlignBottom;
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
  Graphics,
  SysUtils;

{ TElImageIndexEdit }

procedure TElImageComboBox.DoChange;
var i : integer;
begin
  if ManualEdit then
  begin
    if UseImageNames then
    begin
      i := FImageNames.IndexOf(Text);
      if i <> -1 then
      begin
        FItemIndex := i + 1;
        FListBox.ItemIndex := i + 1;
      end
      else
      begin
        FItemIndex := -1;
        FListBox.ItemIndex := 0;
      end;
    end
    else
    begin
      i := StrToIntDef(Text, -2);
      if ((i = -2) and (Text <> '-2')) or (FImages = nil) or (not (LMDInRange(i, 0, FImages.Count - 1))) then
      begin
        Text := IntToStr(ImageIndex);
      end
      else
      begin
        ItemIndex := i - IOffs;
      end;
    end;
  end;
  SetModified(True);
  Invalidate;
end;

constructor TElImageComboBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csDoubleClicks];
  ControlStyle := ControlStyle - [csSetCaption];
  FChLink  := TChangeLink.Create;
  FChLink.OnChange := ImagesChanged;
  FAChLink  := TChangeLink.Create;
  FAChLink.OnChange := ImagesChanged;
  IOffs := -1;
  FEmptyValueText := '-1';
  FImageNames := TLMDMemoryStrings.Create;
  FUseImageNames := false;
  FManualEdit := true;
  Style := csOwnerDrawFixed;
  ReadOnly := false;
end;

procedure TElImageComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.style := Params.style or CBS_OWNERDRAWFIXED;
end;

procedure TElImageComboBox.CreateWnd;
var
  S : TLMDString;
  i: integer;
begin
  i := ItemIndex;
  inherited CreateWnd;
  RebuildList;
  if I > 0 then
    ItemIndex := i;
  if ShowEmptyValue and (inherited Items[0] = '') and (IOffs = -1) then
  begin
    TriggerImageNameEvent(-1, S);
    Text := S;
  end;
end;

procedure TElImageComboBox.DblClick;
var
  NewImageIndex: Integer;
begin
  if Assigned(Images) and (Images.Count > 0) then
  begin
    NewImageIndex := ImageIndex;
    if NewImageIndex < -1 then
    begin
      NewImageIndex := -1;
    end;
    if (NewImageIndex >= -1) and (Succ(NewImageIndex) < Images.Count) then
    begin
      Inc(NewImageIndex);
    end
    else
    begin
      NewImageIndex := -1;
    end;
    if ImageIndex <> NewImageIndex then
    begin
      ImageIndex := NewImageIndex;
      SetModified(True);
    end;
  end;
  SelectAll;
end;

destructor TElImageComboBox.Destroy;
begin
  FChLink.Free;
  FAChLink.Free;
  FImageNames.Free;
  inherited;
end;

procedure TElImageComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  R, ATextRect: TRect;
  PrevBrushColor: TColor;
  AText     : TLMDString;
  TextColor,
  BackColor,
  AColor    : longint;
  FillBack  : boolean;
  BMP, amBMP : TBitmap;
  bSelOrComboEdit: Boolean;
  {$IFDEF LMD_UNICODE}
  Flags: Integer;
  {$ENDIF}
begin
  TControlCanvas(Canvas).UpdateTextFlags;
  ATextRect := Rect;
  // AText := inherited Items[Index];
  TriggerImageNameEvent(Index + IOffs, AText);

  R := Rect;
  if Assigned(Images) then
    R.Left := 1 + Images.Width + 1;

  AColor := clNone;
  TextColor := GetTextColor;
  BackColor := GetBkColor;
{  TextColor := Windows.GetTextColor(Canvas.Handle);
  BackColor := Windows.GetBkColor(Canvas.Handle);}
  if (odComboboxEdit in State) and (ReadOnly and FDisplayReadOnlyOptions.Enabled) and IsThemed then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Color := TextColor;
    FillBack := False;
  end
  else
  begin
    AColor := BackColor;
    FillBack := true;
  end;

  bSelOrComboEdit :=
    (State * [odSelected, odComboBoxEdit] <> [])
    ;

  // FillBack := not (odComboBoxEdit in State);
  if FillBack then
  begin
    Canvas.Brush.Color := BackColor;
    Canvas.FillRect(R);
    if (odSelected in State) and (not FListBox.InvertSelection) and FListBox.TransparentSelection then
      Canvas.Font.Color := Font.Color;

    if bSelOrComboEdit and (not FListBox.InvertSelection) and (not FListBox.TransparentSelection)
    then
    begin
      if Focused then
        AColor := FocusedSelectColor
      else
      if not HideSelection then
        AColor := HideSelectColor
      else
        AColor := GetBkColor;
//        AColor := Color;
      if HighlightAlphaLevel = 255 then
      begin
        Canvas.Brush.Color := AColor;
        Canvas.FillRect(R);
      end;
    end;

    if bSelOrComboEdit then
    begin
      begin
        if Focused then
          Canvas.Font.Color := FocusedSelectTextColor
        else
        if not HideSelection then
          Canvas.Font.Color := HideSelectTextColor
        else
          Canvas.Font.Color := TextColor;
//          Canvas.Font.Color := Font.Color;
      end;
    end;
  end;

  if Images <> nil then
  begin
    Inc(ATextRect.Left, 1 + Images.Width + 1);
    with Rect do
    begin
      PrevBrushColor := Canvas.Brush.Color;
      Canvas.Brush.Color := clWindow;
      Canvas.FillRect(Classes.Rect(Left, Top, ATextRect.Left, Bottom));
      Canvas.Brush.Color := PrevBrushColor;
    end;

    if (FAlphaImages <> nil) and (Index + IOffs < FAlphaImages.Count) then
    begin
      BMP := TBitmap.Create;
      BMP.Width := Images.Width;
      BMP.Height := Images.Height;
      ImageList_DrawEx(Images.Handle, Index + IOffs, BMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      amBMP := TBitmap.Create;
      amBMP.Width := FAlphaImages.Width;
      amBMP.Height := FAlphaImages.Height;
      ImageList_DrawEx(FAlphaImages.Handle, Index + IOffs, amBMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      AlphaCopyRect2(Canvas.Handle,Classes.Rect(Rect.Left+1, Rect.Top, Rect.Left+BMP.Width+1,
                     Rect.Top+BMP.Height), BMP.Canvas.Handle,
                     Classes.Rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

      BMP.Free;
      amBMP.Free;
    end
    else
      Images.Draw(Canvas, Rect.Left + 1, Rect.Top + (Rect.Bottom - Rect.Top - Images.Height) div 2, Index + IOffs);
  end;
  with ATextRect, Canvas do
    {$IFDEF LMD_UNICODE}
    begin
      Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
      if RightAlignedText then
        Flags := Flags or DT_RTLREADING;
      if not RightAlignedText then
        Inc(ATextRect.Left, 4)
      else
        Dec(ATextRect.Right, 4);
      LMDDrawText(Canvas.Handle, AText, Length(AText), ATextRect, Flags);
    end;
    {$ELSE}
    TextRect(ATextRect, Left + 4, (Top + Bottom - TextHeight(AText)) div 2, AText);
    {$ENDIF}

  if FillBack then
  begin
    if bSelOrComboEdit and (not FListBox.InvertSelection) and
       (not FListBox.TransparentSelection) and (HighlightAlphaLevel < 255) then
    begin
      LMDAlphaFillRect(Canvas, R, AColor, HighlightAlphaLevel);
    end;

    SetTextColor(Canvas.Handle, TextColor);
    SetBkColor(Canvas.Handle, BackColor);
    end;

  if Focused  and
     (odComboBoxEdit in State)
    then
  begin
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

procedure TElImageComboBox.DoDropDown;
begin
  //if Self.DroppedDown then
  //  RebuildList;
  inherited;
end;

function TElImageComboBox.GetImageIndex: Integer;
var i : integer;
    // S : TLMDString;
begin
  i := (inherited ItemIndex) + ioffs;
  if i = -2 then
    i := -1;
  result := i;
end;

procedure TElImageComboBox.ImagesChanged(Sender: TObject);
begin
  Remake;
end;

procedure TElImageComboBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if (AComponent = Images) and (Operation = opRemove) then Images := nil;
  if (AComponent = FAlphaImages) and (Operation = opRemove) then AlphaForImages := nil;
end;

procedure TElImageComboBox.Remake;
var
  FSavedImageIndex: integer;
begin
  SendCancelMode(Self);
  FSavedImageIndex := ImageIndex;
  if (Images <> nil) and (ItemHeight < Images.Height + GetSystemMetrics(SM_CYEDGE) * 2) then
    ItemHeight := Images.Height + GetSystemMetrics(SM_CYEDGE) * 2;
  RebuildList;
  SetEditRect(ClientRect);
  if (FSavedImageIndex < 0) or (Assigned(FImages) and (FSavedImageIndex < FImages.Count)) then
    ImageIndex := FSavedImageIndex;
end;

procedure TElImageComboBox.SetImageIndex(const Value: Integer);
var
  s : TLMDString;
  i : integer;
begin
  i := Value - IOffs;
  inherited ItemIndex := i;
  if (Value = -1) and ShowEmptyValue then
    s := Self.EmptyValueText
  else
    s := IntToStr(Value);
  TriggerImageNameEvent(Value, S);
  Text := S;

  if HandleAllocated then
    Invalidate;
end;

procedure TElImageComboBox.SetImages(const Value: TCustomImageList);
begin
  if FImages <> Value then
  begin
    if Assigned(FImages) then
    begin
      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);
      FImages.UnregisterChanges(FChLink);
    end;
    FImages := Value;
    if Assigned(FImages) then
    begin
      FImages.RegisterChanges(FChLink);
      FImages.FreeNotification(Self);
    end;
    Remake;
  end;
end;

procedure TElImageComboBox.SetAlphaImages(const Value: TCustomImageList);
begin
  if FAlphaImages <> Value then
  begin
    if Assigned(FAlphaImages) then
    begin
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
      FAlphaImages.UnregisterChanges(FAChLink);
    end;
    FAlphaImages := Value;
    if Assigned(FAlphaImages) then
    begin
      FAlphaImages.RegisterChanges(FAChLink);
      FAlphaImages.FreeNotification(Self);
    end;
    Remake;
  end;
end;

procedure TElImageComboBox.SetModified(const Value: Boolean);
begin
  if not (csLoading in ComponentState) then
  begin
    FModified := Value;
    if Modified then
    begin
      Inherited Change;
    end;
  end;
end;

procedure TElImageComboBox.TriggerImageNameEvent(Index : Integer; var Text :
    TLMDString);
begin
  if (FUseImageNames) and LMDInRange(Index, 0, FImageNames.Count - 1) then
    Text := FImageNames.Strings[Index]
  else
  if Index = -1 then
    Text := EmptyValueText
  else
    Text := IntToStr(Index{ + IOffs});

  if Assigned(FOnImageName) then
    FOnImageName(Self, Index, Text);
end;

procedure TElImageComboBox.SetManualEdit(Value: Boolean);
begin
  if FManualEdit <> Value then
  begin
    FManualEdit := Value;
    FReadOnly := not FManualEdit;
    AutoCompletion := Value and FUseImageNames;
  end;
end;

function TElImageComboBox.GetShowEmptyValue: Boolean;
begin
  Result := IOffs = -1;
end;

procedure TElImageComboBox.SetShowEmptyValue(Value: Boolean);
begin
  if Value then
    IOffs := -1
  else
    IOffs := 0;
  Invalidate;
end;

procedure TElImageComboBox.Loaded;
begin
  inherited;
  FReadOnly := not FManualEdit;
  Remake;
end;

procedure TElImageComboBox.SetEmptyValueText(const Value: string);
begin
  if FEmptyValueText <> Value then
  begin
    FEmptyValueText := Value;
    if ShowEmptyValue then
    begin
     // inherited Items[0] := FEmptyValueText;
      Items.Insert(0, FEmptyValueText);
      if ItemIndex = 0 then
        Text := FEmptyValueText;
    end;
  end;
end;

procedure TElImageComboBox.SetImageNames(Value: TLMDStrings);
begin
  FImageNames.Assign(Value);
end;

procedure TElImageComboBox.RebuildList;
var
  I   : Integer;
  AText : TLMDString;
begin
  with inherited Items do
  begin
    Clear;
    if IOffs <> 0 then
      inherited Items.Add(EmptyValueText);
    if Images = nil then Exit;
    for I := 0 to Images.Count - 1 do
    begin
      AText := IntToStr(i);
      TriggerImageNameEvent(i, AText);
      inherited Items.Add(AText);
    end;
    if (ItemIndex = - 1) or (ShowEmptyValue) then
    begin
      inherited ItemIndex := 0;
    end;
  end;
end;

function TElImageComboBox.GetItemWidth(Index: Integer): Integer;
var
  S: TLMDString;
begin
  TriggerImageNameEvent(Index + IOffs, S);
  Result := Canvas.TextWidth(S);
  if Images <> nil then
    inc(Result, Images.Width + 2);
end;

procedure TElImageComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('AutoCompletion', FakeBoolean, nil, false);
    Filer.DefineProperty('HorizontalScroll', FakeBoolean, nil, false);
    Filer.DefineProperty('ItemIndex', FakeInteger, nil, false);
    Filer.DefineProperty('ItemHeight', FakeInteger, nil, false);
    Filer.DefineProperty('Text', FakeStr, nil, false);
  end;
  // Filer.DefineProperty('ReadOnly', ReadReadOnly, nil, false);
end;

procedure TElImageComboBox.SetEditRect(Value : TRect);
begin
  if Images <> nil then
    LeftMargin := Images.Width + 2
  else
    LeftMargin := 1;

  inherited SetEditRect(Value);
end;

procedure TElImageComboBox.Paint;
var i  : integer;
    R,
    R1 : TRect;

    BMP,
    amBMP : TBitmap;

    Canvas : TCanvas;
begin
  if ManualEdit then
  begin
    i := FItemIndex;
    if (i > -1) and Assigned(Images) then
      FEditRect.Left := Images.Width + 4;
    FItemIndex := -1;
    inherited;
    FItemIndex := i;
  end
  else
  begin
    inherited;
    i := FItemIndex;
  end;
  if (i > -1) and Assigned(Images) then
  begin
    Canvas := TCanvas.Create;
    Canvas.Handle := GetDC(Handle);

    R := Classes.Rect(0, 0, Images.Width, ClientHeight);
    LMDCenterRects(Images.Width, R.Right - R.Left, Images.Height, R.Bottom - R.Top, R1);
    OffsetRect(R1, R.Left + 1, R.Top);

    i := ImageIndex;

    if (FAlphaImages <> nil) and (I < FAlphaImages.Count) then
    begin
      BMP := TBitmap.Create;
      BMP.Width := Images.Width;
      BMP.Height := Images.Height;
      ImageList_DrawEx(Images.Handle, I, BMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      amBMP := TBitmap.Create;
      amBMP.Width := FAlphaImages.Width;
      amBMP.Height := FAlphaImages.Height;
      ImageList_DrawEx(FAlphaImages.Handle, I, amBMP.Canvas.Handle, 0, 0, 0, 0,
        clNone, clNone, ILD_Normal);

      AlphaCopyRect2(Canvas.Handle, R1, BMP.Canvas.Handle, rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

      BMP.Free;
      amBMP.Free;
    end
    else
      Images.Draw(Canvas, R1.Left, R1.Top, I, True);
//      ImageList_Draw(Images.Handle, I, Canvas.Handle, R1.Left, R1.Top, ILD_NORMAL);
    ReleaseDC(Handle, Canvas.Handle);
    Canvas.Handle := 0;
    Canvas.Free;
  end;

end;

procedure TElImageComboBox.KeyPress(var Key : char);
const
  AllowedKeys = ['0'..'9', '-', #8];
begin
  if not (ManualEdit and UseImageNames) then
    if (not (AnsiChar(Key) in AllowedKeys)) or ((Key = '-') and (SelStart > 0) and (SelLength < Length(Text))) or (not ManualEdit) then
      Key := #0;
  inherited KeyPress(Key);
end; {KeyPress}

procedure TElImageComboBox.SetUseImageNames(Value: Boolean);
begin
  FUseImageNames := Value;
  AutoCompletion := Value and FManualEdit;
end;

procedure TElImageComboBox.DisplayOptionsChange(Sender: TObject);
begin
  inherited;
  Invalidate;
end;

end.
