unit ElCaption;
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

ElCaption unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

{Custom form caption}

interface

uses

  Windows,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Menus,
  Buttons,
  Math,
  Types,
  Themes,
  ImgList,

  LMDTypes,
  LMDSysIn,
  LMDGlyphs,
  LMDGraphUtils,
  LMDThemes,
  LMDClass,
  LMDUtils,
  LMDGraph,

  ElStyleMan,
  ElComponent,
  ElVCLUtils,
  ElHook;

type

  TElFormCaption = class;
  TElCaptionButtons = class;
  TElCaptionTexts = class;

(*  TElMeasureCaptionPartEvent = procedure(Sender : TObject; Canvas : TCanvas;
                               var Height : integer; var Width : integer) of object;
*)
  TElCaptionText = class(TCollectionItem)
  private
    FActiveColor: TColor;
    FInactiveColor: TColor;
    FFont: TFont;
    FVisible: Boolean;
    FCaption: TLMDString;
    FOwnerStyle: boolean;
    FLayout: TButtonLayout;
    FGlyph: TLMDButtonGlyph;
    FAlign: TAlignment;
    FFormCaption: TElFormCaption;
    procedure SetOwnerStyle(newValue: boolean);
    procedure SetActiveColor(newValue: TColor);
    procedure SetInactiveColor(newValue: TColor);
    procedure SetFont(newValue: TFont);
    procedure SetVisible(newValue: Boolean);
    procedure SetCaption(newValue: TLMDString);
    procedure FontChange(Sender: TObject);
    function GetGlyph: TBitmap;
    procedure SetGlyph(newValue: TBitmap);
    procedure SetLayout(newValue: TButtonLayout);
    procedure GlyphChanged(Sender: TObject);
    procedure SetAlign(newValue: TAlignment);
  protected
    procedure Paint(Canvas: TCanvas; R: TRect); virtual;
    function GetWidth(Canvas: TCanvas; Height : integer): Integer;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property ActiveColor: TColor read FActiveColor write SetActiveColor default clCaptionText;
    property InactiveColor: TColor read FInactiveColor write SetInactiveColor default clInactiveCaptionText;
    property Font: TFont read FFont write SetFont;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Caption: TLMDString read FCaption write SetCaption;
    property OwnerStyle: boolean read FOwnerStyle write SetOwnerStyle default true;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Layout: TButtonLayout read FLayout write SetLayout;
    property Align: TAlignment read FAlign write SetAlign;
  end;

  TElCaptionTexts = class(TCollection)
  private
    FCaption: TElFormCaption;
  protected
    function GetItems(Index: integer): TElCaptionText;
    procedure SetItems(Index: integer; newValue: TElCaptionText);
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    function Add: TElCaptionText;
    property Items[index: integer]: TElCaptionText read GetItems write SetItems; default;
  end;

  TElPaintBkgndType = (pbtActive, pbtInactive, pbtAlways);

  TElCaptionButton = class(TCollectionItem)
  private
    FAlign: TAlignment;
    FCaption: TLMDString;
    FGlyph: TLMDButtonGlyph;
    FGlyphWidth: integer;
    FButtons: TElCaptionButtons;
    FEnabled: Boolean;
    FFixClick: Boolean;
    FDown: Boolean;
    FVisible: Boolean;
    FOwnerStyle: Boolean;
    FActiveColor: TColor;
    FInactiveColor: TColor;
    FFont: TFont;
    FLayout: TButtonLayout;
    FBtnRect: TRect;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FGlyphMaskUsage: TLMDGlyphListMaskUsage;

    procedure SetLayout(newValue: TButtonLayout);
    procedure SetFont(newValue: TFont);
    procedure SetOwnerStyle(newValue: Boolean);
    procedure SetActiveColor(newValue: TColor);
    procedure SetInactiveColor(newValue: TColor);
    procedure SetVisible(newValue: Boolean);
    procedure SetEnabled(newValue: Boolean);
    procedure SetDown(newValue: Boolean);
    procedure SetAlign(newValue: TAlignment);
    procedure SetCaption(newValue: TLMDString);
    function GetGlyph: TBitmap;
    procedure SetGlyph(newValue: TBitmap);
    procedure GlyphChanged(Sender: TObject);
    procedure FontChange(Sender: TObject);
    function GetImageIndex: Integer;
    function GetUseImageList: Boolean;
    procedure SetImageIndex(const Value: Integer);
    procedure SetUseImageList(const Value: Boolean);
  protected
    FFlat: Boolean;
    procedure Paint(Canvas: TCanvas; R: TRect); virtual;
    function GetWidth(Canvas: TCanvas; Height : integer): Integer;
    procedure SetFlat(Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Align: TAlignment read FAlign write SetAlign default taRightJustify;
    property Caption: TLMDString read FCaption write SetCaption;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property FixClick: Boolean read FFixClick write FFixClick;
    property Down: Boolean read FDown write SetDown default False;
    property Visible: Boolean read FVisible write SetVisible default True;
    property OwnerStyle: Boolean read FOwnerStyle write SetOwnerStyle default True;
    property ActiveColor: TColor read FActiveColor write SetActiveColor default clBtnText;
    property InactiveColor: TColor read FInactiveColor write SetInactiveColor default clBtnText;
    property ImageIndex : Integer read GetImageIndex write SetImageIndex default -1;
    property Font: TFont read FFont write SetFont;

    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property Flat: Boolean read FFlat write SetFlat default false;
    property GlyphMaskUsage: TLMDGlyphListMaskUsage read FGlyphMaskUsage write FGlyphMaskUsage default muGlyphList;
    property UseImageList : Boolean read GetUseImageList write SetUseImageList default false; { Protected }
  end;

  TElCaptionButtons = class(TCollection)
  private
    FCaption: TElFormCaption;
  protected
    function GetItems(Index: integer): TElCaptionButton;
    procedure SetItems(Index: integer; newValue: TElCaptionButton);
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    function Add: TElCaptionButton;
    property Items[index: integer]: TElCaptionButton read GetItems write SetItems; default;
  end;

  TElCaptionDrawEvent = procedure(Sender: TObject; Canvas: TCanvas; var Rect: TRect) of object;
  TCaptionButtonEvent = procedure(Sender: TObject; Button: TElCaptionButton) of object;

  TElFormCaption = class(TElComponent)
  private
    FDownChLink,
    FDisabledChLink,
    FChLink: TChangeLink;
    FUseImageList : Boolean;

    FDownImages,
    FDisabledImages,
    FImages : TCustomImageList;

    FTexts: TElCaptionTexts;
    FInactiveBitmap: TBitmap;
    FButtons: TElCaptionButtons;
    FPaintBkgnd: TElPaintBkgndType;
    FPopupMenu: TPopupMenu;
    FBitmap: TBitmap;
    FHook: TElHook;
    FActive: Boolean;
    FActiveLeftColor: TColor;
    FActiveRightColor: TColor;
    FInactiveLeftColor: TColor;
    FInactiveRightColor: TColor;
    FBackgroundType: TLMDBackgroundType;
    FNumColors: Integer;
    FAlignment: TAlignment;
    FForm: TForm;
    FCaptionHeight: Integer;
    FSystemFont: Boolean;
    FFont,
      Font2: TFont;
    FWndActive: boolean;
    FRegion,
      FSaveRegion: HRGN;
    FActiveForm: boolean;
    FClicked: boolean;
    FInBtn: boolean;
    FBtnPressed: TElCaptionButton;
    FBtnsRect: TRect;
    FOnDrawCaption: TElCaptionDrawEvent;
    FOnButtonClick: TCaptionButtonEvent;
    FOnButtonDblClick: TCaptionButtonEvent;
    FPreventUpdate: Boolean;
    FRepaintCaption: boolean;

    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    (*FOnMeasureCaptionPart: TElMeasureCaptionPartEvent;*)

    procedure SetActive(newValue: Boolean);
    procedure SetActiveLeftColor(newValue: TColor);
    procedure SetActiveRightColor(newValue: TColor);
    procedure SetInactiveLeftColor(newValue: TColor);
    procedure SetBackgroundType(newValue: TLMDBackgroundType);
    procedure SetPopupMenu(newValue: TPopupMenu);
    procedure SetNumColors(newValue: Integer);
    procedure SetAlignment(newValue: TAlignment);
    procedure SetBitmap(newValue: TBitmap);
    procedure BitmapChange(Sender: TObject);
    procedure OnBeforeHook(Sender: TObject; var Msg: TMessage; var Handled: boolean);
    procedure OnAfterHook(Sender: TObject; var Msg: TMessage; var Handled: boolean);
    procedure SetPaintBkgnd(newValue: TElPaintBkgndType);
    procedure SetInactiveRightColor(newValue: TColor);
    procedure SetButtons(newValue: TElCaptionButtons);
    procedure SetInactiveBitmap(newValue: TBitmap);
    procedure SetSystemFont(newValue: Boolean);
    procedure SetFont(newValue: TFont);
    procedure FontChange(Sender: TObject);
    procedure GetSystemFont;
    procedure SetTexts(newValue: TElCaptionTexts);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetUseImageList(const Value: Boolean);
    procedure SetDisabledImages(const Value: TCustomImageList);
    procedure SetDownImages(const Value: TCustomImageList);
  protected
    FThemeMode : TLMDThemeMode;
    FThemeGlobalMode: Boolean;

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);
    procedure DefineProperties(Filer:TFiler);override;
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;
    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;

    procedure ImagesChanged(Sender: TObject);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; operation: TOperation); override;
    procedure Update;
    procedure PaintCaption(var Msg: TMessage; Step: integer); virtual;
    procedure TriggerDrawCaptionEvent(Canvas: TCanvas; var Rect: TRect); virtual;
    procedure TriggerButtonClickEvent(Button: TElCaptionButton); virtual;
    procedure TriggerButtonDblClickEvent(Button: TElCaptionButton); virtual;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;

    (*procedure TriggerMeasureCaptionPart(Sender : TObject; Canvas : TCanvas; var
        Height : integer; var Width : integer);*)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ButtonAtPos(X, Y: integer): TElCaptionButton;
    procedure Assign(Source : TPersistent); override;
    function IsThemed: Boolean;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
  published
    property Active: Boolean read FActive write SetActive;
    property ActiveLeftColor: TColor read FActiveLeftColor write SetActiveLeftColor default clBlack;
    property ActiveRightColor: TColor read FActiveRightColor write SetActiveRightColor default clActiveCaption;
    property InactiveLeftColor: TColor read FInactiveLeftColor write SetInactiveLeftColor default clBlack;
    property InactiveRightColor: TColor read FInactiveRightColor write SetInactiveRightColor default clInactiveCaption;
    property DisabledImages : TCustomImageList read FDisabledImages write SetDisabledImages;
    property DownImages     : TCustomImageList read FDownImages write SetDownImages;
    property Images : TCustomImageList read FImages write SetImages;
    property UseImageList : Boolean read FUseImageList write SetUseImageList default False;

    property BackgroundType: TLMDBackgroundType read FBackgroundType write SetBackgroundType default bgtColorFill;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property NumColors: Integer read FNumColors write SetNumColors default 64;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property ActiveBitmap: TBitmap read FBitmap write SetBitmap;
    property PaintBkgnd: TElPaintBkgndType read FPaintBkgnd write SetPaintBkgnd default pbtAlways;
    property Buttons: TElCaptionButtons read FButtons write SetButtons;
    property InactiveBitmap: TBitmap read FInactiveBitmap write SetInactiveBitmap;
    property OnDrawCaption: TElCaptionDrawEvent read FOnDrawCaption write FOnDrawCaption;
    property OnButtonClick: TCaptionButtonEvent read FOnButtonClick write FOnButtonClick;
    property OnButtonDblClick: TCaptionButtonEvent read FOnButtonDblClick write FOnButtonDblClick;
    (*property OnMeasureCaptionPart: TElMeasureCaptionPartEvent read
        FOnMeasureCaptionPart write FOnMeasureCaptionPart;*)
    property SystemFont: Boolean read FSystemFont write SetSystemFont default true;
    property Font: TFont read FFont write SetFont;
    property Texts: TElCaptionTexts read FTexts write SetTexts;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
  end;

implementation

uses
  UxTheme;

const
  EmptyCaption : PChar = #0;

type
  TProxyGlyph = class(TLMDButtonGlyph);

function TElCaptionTexts.GetItems(Index: integer): TElCaptionText;
begin
  result := TElCaptionText(inherited GetItem(Index));
end;

procedure TElCaptionTexts.SetItems(Index: integer; newValue: TElCaptionText);
begin
  inherited SetItem(Index, newValue);
end;

function TElCaptionTexts.GetOwner: TPersistent;
begin
  result := FCaption;
end;

procedure TElCaptionTexts.Update(Item: TCollectionItem);
begin
  if not FCaption.FPreventUpdate then
    FCaption.Update;
end;

function TElCaptionTexts.Add: TElCaptionText;
begin
  result := TElCaptionText(inherited Add);
end;

procedure TElCaptionText.SetActiveColor(newValue: TColor);
begin
  if (FActiveColor <> newValue) then
  begin
    FActiveColor := newValue;
    if visible then Changed(false);
  end; {if}
end; {SetActiveColor}

procedure TElCaptionText.SetInactiveColor(newValue: TColor);
begin
  if (FInactiveColor <> newValue) then
  begin
    FInactiveColor := newValue;
    if visible then Changed(false);
  end; {if}
end; {SetInactiveColor}

procedure TElCaptionText.SetFont(newValue: TFont);
begin
  FFont.Assign(newValue);
end; {SetFont}

procedure TElCaptionText.SetVisible(newValue: Boolean);
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    Changed(true);
  end; {if}
end; {SetVisible}

procedure TElCaptionText.Assign(Source: TPersistent);
begin
  if Source is TElCaptionText then
    with Source as TElCaptionText do
    begin
      Self.FActiveColor := FActiveColor;
      Self.FInactiveColor := FInactiveColor;
      Self.FFont.Assign(Font);
      Self.FVisible := FVisible;
      Self.FCaption := FCaption;
      Self.FOwnerStyle := FOwnerStyle;
      Self.Layout := FLayout;
      Self.Glyph := Glyph;
    end
  else
    inherited;
end;

procedure TElCaptionText.FontChange(Sender: TObject);
begin
  if visible then Changed(true);
end;

procedure TElCaptionText.SetCaption(newValue: TLMDString);
begin
  if (FCaption <> newValue) then
  begin
    FCaption := newValue;
    if Visible then
      Changed(true);
  end; {if}
end; {SetCaption}

procedure TElCaptionText.SetOwnerStyle(newValue: boolean);
begin
  if (FOwnerStyle <> newValue) then
  begin
    FOwnerStyle := newValue;
    Changed(true);
  end; {if}
end;

destructor TElCaptionText.Destroy;
begin
  inherited;
  FFont.Free;
  FGlyph.Free;
end; {Destroy}

constructor TElCaptionText.Create;
begin
  FGlyph := TLMDButtonGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  FLayout := blGlyphLeft;
  inherited;

  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  FActiveColor := clCaptionText;
  FInactiveColor := clInactiveCaptionText;
  FVisible := True;
  FOwnerStyle := true;
  if Collection <> nil then
    FFormCaption := TElCaptionTexts(Collection).FCaption;
end; {Create}

function TElCaptionText.GetGlyph: TBitmap;
begin
  Result := FGlyph.Glyph;
end; {GetGlyph}

procedure TElCaptionText.SetGlyph(newValue: TBitmap);
begin
  FGlyph.Glyph := newValue;
  Changed(true);
end; {SetGlyph}

procedure TElCaptionText.SetLayout(newValue: TButtonLayout);
begin
  if (FLayout <> newValue) then
  begin
    FLayout := newValue;
    if Visible then Changed(false);
  end; {if}
end;

procedure TElCaptionText.GlyphChanged(Sender: TObject);
begin
  Changed(false);
end;

procedure TElCaptionText.SetAlign(newValue: TAlignment);
begin
  if (FAlign <> newValue) then
  begin
    FAlign := newValue;
    Changed(true);
  end; {if}
end; {SetAlign}

procedure TElCaptionText.Paint(Canvas: TCanvas; R: TRect);
var
  FRegion : HRGN;
  FRect   : TRect;
  LThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
begin
  LThemeMode := ttmNone;

  FRegion := CreateRectRgnIndirect(R);
  FRect := Canvas.ClipRect;
  SelectClipRgn(Canvas.Handle, FRegion);
  FGlyph.Draw(Canvas, R, Point(0, 0), Caption, FLayout, 0, 1, ebsUp, ebsUp, taLeftJustify, false,
    False, false, not Glyph.Empty, true, 0, tdtNormal, clNone, LThemeMode, LDetails, false, false, false, nil, true);
  with FRect do
    SetRectRgn(FRegion, Left, Top, Right, Bottom);
  SelectClipRgn(Canvas.Handle, FRegion);
  DeleteObject(FRegion);
end; {Paint}

function TElCaptionText.GetWidth(Canvas: TCanvas; Height : integer): Integer;
var
  ACaption: TElFormCaption;
  SrcRect : TRect;
  PP      : TPoint;
  R       : TRect;
begin
  FillMemory(@SrcRect, SizeOf(TRect), 0);
  SrcRect.Bottom := Height;

  ACaption := FFormCaption;
  if OwnerStyle then
  begin
    with ACaption do
    begin
      if FSystemFont then
      begin
        Canvas.Font.Assign(Font2)
      end
      else
      begin
        Canvas.Font.Assign(FFont);
      end;
    end;
  end
  else
  begin
    Canvas.Font.Assign(Self.Font);
    if ACaption.FWndActive then
      Canvas.Font.Color := Self.FActiveColor
    else
      Canvas.Font.Color := Self.FInactiveColor;
  end;

  with ACaption do
  begin
    if FWndActive then
      Canvas.Font.Color := Self.FActiveColor
    else
      Canvas.Font.Color := Self.FInActiveColor;
    if not Self.Glyph.Empty then
    begin
      SrcRect.Right := SrcRect.Bottom - SrcRect.Top;
      Self.FGlyph.GetPaintGlyphSize(SrcRect, PP);
      SrcRect.Right := Math.Max(PP.X + 2, SrcRect.Right);
    end
    else
      if (Self.FCaption = '') then
        SrcRect.Right := SrcRect.Left + (SrcRect.Bottom - SrcRect.Top);
    if (Self.FCaption <> '') then
    begin
      SetRectEmpty(R);
      LMDDrawText(Canvas.Handle, Self.Caption, Length(Self.FCaption), R, DT_SINGLELINE or DT_CALCRECT or DT_NOPREFIX);

      Inc(SrcRect.Right, R.Right - R.Left);
    end;
  end;
  result := SrcRect.Right - SrcRect.Left + 1;
end;

procedure TElCaptionButton.SetAlign(newValue: TAlignment);
begin
  if (FAlign <> newValue) then
  begin
    FAlign := newValue;
    Changed(true);
  end; {if}
end; {SetAlign}

procedure TElCaptionButton.SetCaption(newValue: TLMDString);
begin
  if (FCaption <> newValue) then
  begin
    FCaption := newValue;
    Changed(true);
  end; {if}
end; {SetCaption}

function TElCaptionButton.GetGlyph: TBitmap;
begin
  Result := FGlyph.Glyph;
end; {GetGlyph}

procedure TElCaptionButton.FontChange(Sender: TObject);
begin
  if Visible then Changed(false);
end;

procedure TElCaptionButton.GlyphChanged(Sender: TObject);
begin
  Changed(false);
end;

procedure TElCaptionButton.SetGlyph(newValue: TBitmap);
begin
  FGlyph.Glyph := newValue;
  Changed(true);
end; {SetGlyph}

procedure TElCaptionButton.SetEnabled(newValue: Boolean);
begin
  if (FEnabled <> newValue) then
  begin
    FEnabled := newValue;
    Changed(false);
  end; {if}
end; {SetEnabled}

procedure TElCaptionButton.SetDown(newValue: Boolean);
begin
  if (FDown <> newValue) then
  begin
    FDown := newValue;
    Changed(false);
  end; {if}
end; {SetDown}

procedure TElCaptionButton.Assign(Source: TPersistent);
begin
  if Source is TElCaptionButton then
    with Source as TElCaptionButton do
    begin
      Self.FAlign := FAlign;
      Self.FCaption := FCaption;
      Self.Glyph := Glyph;
      Self.FEnabled := FEnabled;
      Self.FFixClick := FixClick;
      Self.FDown := Down;
      Self.FVisible := Visible;
      Self.FOwnerStyle := OwnerStyle;
      Self.FActiveColor := FActiveColor;
      Self.FInactiveColor := FInactiveColor;
      Self.FFont.Assign(FFont);
      Self.FLayout := FLayout;
    end
  else
    inherited;
end;

procedure TElCaptionButton.Paint(Canvas: TCanvas; R: TRect);
var
  DrawFlags: Integer;
  LState, LGState: TLMDExButtonState;
  R1: TRect;
  LDetail: TThemedButton;
  LThemeMode: TLMDThemeMode;
begin
  if UseImageList and TElFormCaption(Collection.Owner).UseImageList then
  begin
    if not Enabled then
      TProxyGlyph(FGlyph).FImageList := TElFormCaption(Collection.Owner).DisabledImages
    else
    begin
      if FDown then
        TProxyGlyph(FGlyph).FImageList := TElFormCaption(Collection.Owner).DownImages
      else
        TProxyGlyph(FGlyph).FImageList := TElFormCaption(Collection.Owner).Images;
    end
  end
  else
    TProxyGlyph(FGlyph).FImageList :=nil;

  DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
  LThemeMode := TElCaptionButtons(Collection).FCaption.UseThemeMode;
  LDetail := tbPushButtonNormal;
  if (FDown) then
    DrawFlags := DrawFlags or DFCS_PUSHED;
  if not FButtons.FCaption.IsThemed then
  begin
    if (not Flat) or FDown then
    begin
      DrawFrameControl(Canvas.Handle, R, DFC_BUTTON, DrawFlags);
      InflateRect(R, 1, 1);
    end
  end
  else
  begin
    if FDown then
      LDetail := tbPushButtonPressed
    else
      LDetail := tbPushButtonNormal;
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, R);
    R := LMDThemeServices.ContentRect(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), R);
  end;
  if not FEnabled then
    LState := ebsDisabled
  else
    if FDown then
    begin
      LState := ebsDown;
      OffsetRect(R, 1, 1);
    end
    else
      LState := ebsUp;

  LGState := LState;
  if (ImageIndex >= 0) and Assigned(TProxyGlyph(FGlyph).FImageList) and (LGState = ebsDisabled) then
    LGState := ebsUp;

  R1 := R;
  inc(R1.Left, 2);
  if not Glyph.Empty or ((ImageIndex >= 0) and Assigned(TProxyGlyph(FGlyph).FImageList)) then
  begin
    if Length(Caption) > 0 then
      R1.Right := R1.Left + FGlyphWidth
    else
      R1 := R;
    FGlyph.Draw(Canvas, R1, Point(0, 0), '', FLayout, 0, 0, LState, LGState, taCenter, false,
      false, false, true, false, 0, tdtNormal, clBtnFace, ttmNone, ThemeServices.GetElementDetails(LDetail), false, false, false, nil, true, GlyphMaskUsage);
    R1.Left := R1.Right + 2;
  end;
  if Length(Caption) > 0 then
  begin
    R1.Right := R.Right;
    FGlyph.Draw(Canvas, R1, Point(0, 0), Caption, FLayout, 0, 0, LState, LGState, taCenter, false,
      (Pos(#13#10, FCaption) = -1), false, false, true, 0, tdtNormal, clBtnFace, ttmNone, ThemeServices.GetElementDetails(LDetail), false, false, false, nil, true, GlyphMaskUsage);
  end;
end; {Paint}

procedure TElCaptionButton.SetVisible(newValue: Boolean);
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    if not newValue then FBtnRect := Rect(0, 0, 0, 0);
    Changed(true);
  end; {if}
end;

procedure TElCaptionButton.SetOwnerStyle(newValue: Boolean);
begin
  if (FOwnerStyle <> newValue) then
  begin
    FOwnerStyle := newValue;
    if Visible then Changed(true);
  end; {if}
end;

procedure TElCaptionButton.SetActiveColor(newValue: TColor);
begin
  if (FActiveColor <> newValue) then
  begin
    FActiveColor := newValue;
    if Visible then Changed(false);
  end; {if}
end;

procedure TElCaptionButton.SetInactiveColor(newValue: TColor);
begin
  if (FInactiveColor <> newValue) then
  begin
    FInactiveColor := newValue;
    if Visible then Changed(false);
  end; {if}
end;

procedure TElCaptionButton.SetFont(newValue: TFont);
begin
  FFont.Assign(newValue);
end;

procedure TElCaptionButton.SetLayout(newValue: TButtonLayout);
begin
  if (FLayout <> newValue) then
  begin
    FLayout := newValue;
    if Visible then Changed(false);
  end; {if}
end;

destructor TElCaptionButton.Destroy;
begin
  Dec(ButtonCount);
  if ButtonCount <= 0 then
  begin
    Pattern.Free;
    Pattern := nil;
  end;
  FFont.Free;
  FGlyph.Free;
  inherited;
end;

constructor TElCaptionButton.Create;
begin

  FButtons := TElCaptionButtons(Collection);
  FGlyph := TLMDButtonGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  FLayout := blGlyphLeft;
  FVisible := True;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  FAlign := taRightJustify;
  FEnabled := True;
  FDown := False;
  FOwnerStyle := True;
  FActiveColor := clBtnText;
  FInActiveColor := clBtnText;

  FGlyphMaskUsage := muGlyphList;
  inherited;

  Inc(ButtonCount);
end; {Create}

function TElCaptionButton.GetWidth(Canvas: TCanvas; Height : integer): Integer;
var
  ACaption: TElFormCaption;
  SrcRect : TRect;
  PP      : TPoint;
  R       : TRect;
  dx: integer;
  LThemeMode: TLMDThemeMode;
begin
  FillMemory(@SrcRect, SizeOf(TRect), 0);
  LThemeMode := TElCaptionButtons(Collection).FCaption.UseThemeMode;
  SrcRect.Bottom := Height;
  dx := max(GetSystemMetrics(SM_CXSIZE) - 2, SrcRect.Bottom - SrcRect.Top);

  ACaption := TElCaptionButtons(Collection).FCaption;
  if OwnerStyle then
  begin
    with ACaption do
      if FSystemFont then
        Canvas.Font.Assign(Font2)
      else
        Canvas.Font.Assign(FFont);
  end
  else
    with ACaption do
      Canvas.Font.Assign(Self.Font);
  with ACaption do
  begin
    if FWndActive then
      Canvas.Font.Color := Self.FActiveColor
    else
      Canvas.Font.Color := Self.FInActiveColor;
    if not Self.Glyph.Empty then
    begin
      SrcRect.Right := SrcRect.Left + dx;
      Self.FGlyph.GetPaintGlyphSize(SrcRect, PP);
      SrcRect.Right := Max(PP.X + 4, SrcRect.Right);
//      FGlyphWidth := SrcRect.Right - SrcRect.Left - 2;
      FGlyphWidth := PP.X;
    end
    else
      if (Self.FCaption = '') then
        SrcRect.Right := SrcRect.Left + dx;
    if (Self.FCaption <> '') then
    begin
      SetRectEmpty(R);
      LMDDrawText(Canvas.Handle, Self.Caption, Length(Self.FCaption), R, DT_SINGLELINE or DT_CALCRECT or DT_NOPREFIX);
      if not Self.Glyph.Empty then
        SrcRect.Right := R.Right - R.Left + FGlyphWidth
      else
        Inc(SrcRect.Right, R.Right - R.Left);
      Inc(SrcRect.Right, 4);
      if not ACaption.IsThemed then
        Inc(SrcRect.Right, 4)
      else
      begin
        LMDThemeServices.GetThemeBackgroundExtent(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tbPushButtonNormal), SrcRect, SrcRect);
      end;
    end;
  end;
  result := max(dx, SrcRect.Right - SrcRect.Left);
end;

procedure TElCaptionButton.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    Changed(False);
  end;
end;

function TElCaptionButtons.GetItems(Index: integer): TElCaptionButton;
begin
  result := TElCaptionButton(inherited GetItem(Index));
end;

procedure TElCaptionButtons.SetItems(Index: integer; newValue: TElCaptionButton);
begin
  inherited SetItem(Index, newValue);
end;

function TElCaptionButtons.GetOwner: TPersistent;
begin
  result := FCaption;
end;

procedure TElCaptionButtons.Update(Item: TCollectionItem);
begin
  if (FCaption.FForm <> nil) and (FCaption.FForm.HandleAllocated) then FCaption.Update;
end;

function TElCaptionButtons.Add: TElCaptionButton;
begin
  result := TElCaptionButton(inherited Add);
end; {Add}

procedure TElFormCaption.SetActive(newValue: Boolean);
begin
  if (FActive <> newValue) then
  begin
    FActive := newValue;
    FWndActive := FForm.HandleAllocated and (GetForegroundWindow = FForm.Handle);
    begin
      FHook.Active := FActive;
      Update;
    end;
    if Active and (not (csLoading in ComponentState)) then
    begin
      FRepaintCaption := true;
      if IsThemed then
        FForm.Caption := '';
    end;
  end; {if}
end; {SetActive}

procedure TElFormCaption.SetActiveLeftColor(newValue: TColor);
begin
  if (FActiveLeftColor <> newValue) then
  begin
    FActiveLeftColor := newValue;
    Update;
  end; {if}
end; {SetActiveLeftColor}

procedure TElFormCaption.SetActiveRightColor(newValue: TColor);
begin
  if (FActiveRightColor <> newValue) then
  begin
    FActiveRightColor := newValue;
    Update;
  end; {if}
end; {SetActiveRightColor}

procedure TElFormCaption.SetInactiveLeftColor(newValue: TColor);
begin
  if (FInactiveLeftColor <> newValue) then
  begin
    FInactiveLeftColor := newValue;
    Update;
  end; {if}
end; {SetInactiveLeftColor}

procedure TElFormCaption.SetBackgroundType(newValue: TLMDBackgroundType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    Update;
  end; {if}
end; {SetBackgroundType}

procedure TElFormCaption.SetPopupMenu(newValue: TPopupMenu);
begin
  if (FPopupMenu <> newValue) then
  begin
    if (FPopupMenu <> nil) then
      if not (csDestroying in FPopupMenu.ComponentState) then
       FPopupMenu.RemoveFreeNotification(Self);
    FPopupMenu := newValue;
    if FPopupMenu <> nil then FPopupMenu.FreeNotification(Self);
  end; {if}
end; {SetPopupMenu}

procedure TElFormCaption.SetNumColors(newValue: Integer);
begin
  if (FNumColors <> newValue) then
  begin
    FNumColors := newValue;
    Update;
  end; {if}
end; {SetNumColors}

procedure TElFormCaption.SetAlignment(newValue: TAlignment);
begin
end; {SetAlignment}

procedure TElFormCaption.BitmapChange(Sender: TObject);
begin
  if Active then Update;
end;

procedure TElFormCaption.SetBitmap(newValue: TBitmap);
begin
  FBitmap.Assign(newValue);
end; {SetBitmap}

procedure TElFormCaption.Loaded;
begin
  inherited;
  if Active then
  begin
    FRepaintCaption := true;
    if IsThemed then
      FForm.Caption := '';
  end;
  UpdateStyle;
  if Active then Update;
end; {Loaded}

procedure TElFormCaption.OnAfterHook(Sender: TObject; var Msg: TMessage; var Handled: boolean);
var
  S : String;
  i : integer;
  begin
  case Msg.Msg of //
    WM_CREATE: ;
    WM_NCMOUSEMOVE:
      if FRepaintCaption then
      begin
        FRepaintCaption := false;
        //Update;
      end;
    WM_NCPAINT:
      begin
        if not FPreventUpdate then
          PaintCaption(Msg, 2);
      end;
    WM_NCACTIVATE:
      begin
        FActiveForm := LongBool(Msg.WParam);
        if not FActiveForm then
          PaintCaption(Msg, 2)
        else
          if not (csDesigning in ComponentState) then Update;
      end;
    WM_SETICON,
      WM_WINDOWPOSCHANGED,
      WM_INITMENU,
      WM_NCLBUTTONDOWN
    //,WM_SYSCOMMAND
    :
      begin
        RedrawWindow(FForm.Handle, nil, 0, RDW_FRAME or {RDW_INVALIDATE or }RDW_UPDATENOW);
      end;
    WM_GETTEXTLENGTH:
      begin
        if not IsThemed then
        begin
          if (not FPreventUpdate) and (FTexts.Count > 0) then
          begin
            S := '';
            for i := 0 to FTexts.Count -1 do
            begin
              if FTexts[i].Visible then
                S := S + FTexts[i].Caption;
            end;
            Msg.Result := Length(S);
          end
        end
        else
        begin
          Msg.Result := 0;
        end;
      end;
    WM_GETTEXT:
      begin
        if not IsThemed then
        begin
          if (not FPreventUpdate) and (FTexts.Count > 0) then
          begin
            S := '';
            for i := 0 to FTexts.Count -1 do
            begin
              if FTexts[i].Visible then
                S := S + FTexts[i].Caption;
            end;

            StrLCopy(PChar(Msg.LParam), PChar(S), Msg.WParam - 1);
            {$IFNDEF LMD_NATIVEUNICODE}
            //Overloaded StrLCopy for PWideChar writes #0 at the end of the dest itself
            //Note: this line causes AV in D2009 and problems in IDE
            (PChar(Msg.LParam) + Msg.WParam - 1)^ := #0;
            {$ENDIF}
          end;
        end
        else
        begin
          PChar(Msg.LParam)^ := #0;
          end;
        (*if (FTexts.Count > 0) and not (FPreventUpdate) then
        begin
          FillMemory(PChar(Msg.LParam), Msg.WParam, 0);
          Msg.Result := 0;
        end;
        *)
      end;
    WM_SETTEXT:
      Update;
    WM_SETTINGCHANGE:
      begin
        if Msg.WParam = SPI_SETNONCLIENTMETRICS then
        begin
          if SystemFont then GetSystemFont;
          Update;
        end;
      end;
  end; // case
end;

procedure TElFormCaption.OnBeforeHook(Sender: TObject; var Msg: TMessage; var Handled: boolean);
var
//  b: boolean;
  Btn: TElCaptionButton;
  P: TPoint;
  R: TRect;
  begin
  case Msg.Msg of //
    WM_THEMECHANGED: ;// EL_THEMETHANGED
    WM_NCACTIVATE:
      begin
        FWndActive := TWMNCActivate(Msg).Active;
        begin
          Msg.Result := 1;
          // Handled := true;
        end;
        end;
    WM_SETTEXT:
      begin
        if IsThemed then
          Msg.lParam := TLMDPtrInt(EmptyCaption);
      end;
    WM_WINDOWPOSCHANGING:
      with TWMWindowPosChanging(Msg).WindowPos^ do
        if (csCreating in FForm.ControlState) and ((Flags and SWP_HIDEWINDOW) <> 0) then
          Flags := Flags or SWP_NOREDRAW;
      WM_SYSCOMMAND:
      begin
        if not (csDesigning in ComponentState) then
          Update;
      end;
    WM_NCLBUTTONDOWN:
      begin
        if not (csDesigning in ComponentState) then
        begin
          Btn := ButtonAtPos(SmallInt(Msg.lParamLo), Smallint(Msg.lParamHi));
          if Btn <> nil then
          begin
            if Btn.Enabled then
            begin
              FBtnPressed := Btn;
              if Btn.FixClick then
                Btn.FDown := not Btn.FDown
              else
                Btn.FDown := true;
              SetCapture(FForm.Handle);
              FInBtn := true;
              R := Btn.FBtnRect;
              RedrawWindow(FForm.Handle, @R, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
            end;
            Msg.Result := 1;
            Msg.Msg := WM_NULL;
            Handled := true;
          end;
        end;
      end;
    WM_MOUSEMOVE:
      begin
        if not (csDesigning in ComponentState) then
        begin
          if FBtnPressed <> nil then
          begin
            P := Point(TWMLBUTTONUP(Msg).XPos, TWMLBUTTONUP(Msg).YPos);
            ClientToScreen(FForm.Handle, P);
            Btn := ButtonAtPos(P.X, P.Y);
            if Btn <> FBtnPressed then
            begin
              if (FBtnPressed <> nil) and (FInBtn) then
                with FBtnPressed do
                  if not FixClick then
                  begin
                    FDown := false; // else Update;
                    R := FBtnPressed.FBtnRect;
                    RedrawWindow(FForm.Handle, @R, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
                  end;
              FInBtn := false;
            end
            else
              if (not FInBtn) and (Btn <> nil) then
              begin
                if not Btn.FFixClick then
                begin
                  Btn.FDown := true;
                  R := Btn.FBtnRect;
                  RedrawWindow(FForm.Handle, @R, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
                end;
                FInBtn := true;
              end;
            Msg.Result := 1;
            Msg.Msg := WM_NULL;
            Handled := true;
          end;
        end;
      end;
    WM_NCLBUTTONDBLCLK:
      begin
        if not (csDesigning in ComponentState) then
        begin
          Btn := ButtonAtPos(Msg.lParamLo, Smallint(Msg.lParamHi));
          if Btn <> nil then
          begin
            TriggerButtonDblClickEvent(Btn);
            Msg.Result := 1;
            Msg.Msg := WM_NULL;
            Handled := true;
          end;
        end;
      end;
    WM_LBUTTONUP, WM_LBUTTONDBLCLK:
      begin
        if not (csDesigning in ComponentState) then
        begin
          if FBtnPressed <> nil then
          begin
            P := Point(TWMLBUTTONUP(Msg).XPos, TWMLBUTTONUP(Msg).YPos);
            ClientToScreen(FForm.Handle, P);
            Btn := ButtonAtPos(P.X, P.Y);
            if Btn <> FBtnPressed then
            begin
              with FBtnPressed do
              begin
                if not FixClick then
                  Down := false
                else
                  Down := not Down;
                R := FBtnRect;
                RedrawWindow(FForm.Handle, @R, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
              end;
            end
            else
            begin
              with FBtnPressed do
                if not FixClick then
                begin
                  if Down then
                    FDown := false
                  else
                    ;
                  R := FBtnRect;
                  RedrawWindow(FForm.Handle, @R, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
                end;
              if not (csDesigning in ComponentState) then TriggerButtonClickEvent(FBtnPressed);
            end;
            Msg.Result := 1;
            Msg.Msg := WM_NULL;
            Handled := true;
            ReleaseCapture;
          end;
          FBtnPressed := nil;
        end;
      end;
    WM_NCPAINT:
      begin
        if not FPreventUpdate then
          PaintCaption(Msg, 1);
      end;
    WM_NCRBUTTONDOWN:
      if not (csDesigning in ComponentState) then
      begin
        if Assigned(FPopupMenu) then
          if FPopupMenu.AutoPopup then
          begin
            FClicked := True;
            Msg.Result := 0;
            Handled := True;
          end
          else
        else
        if Assigned(FForm.PopupMenu) and (FForm.PopupMenu.AutoPopup) then
        begin
          FClicked := True;
          Msg.Result := 0;
          Handled := True;
        end;
      end;
    WM_NCRBUTTONUP:
      if not (csDesigning in ComponentState) then
      begin
        if FClicked then
          with TWMMouse(Msg) do
          begin
            FClicked := False;
            if Assigned(FPopupMenu) then
              if (FPopupMenu.AutoPopup) then
              begin
                FPopupMenu.Popup(XPos, YPos);
                Result := 0;
                Handled := True;
              end
              else
            else
              if Assigned(FForm.PopupMenu) and (FForm.PopupMenu.AutoPopup) then
              begin
                FForm.PopupMenu.Popup(XPos, YPos);
                Result := 0;
                Handled := True;
              end;
          end;
      end;
  end; // case
end; {WndProc}

procedure TElFormCaption.Notification(AComponent: TComponent; operation: TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if (AComponent = FPopupMenu) then FPopupMenu := nil;
    if (AComponent = FForm) then FForm := nil;
  end
  else
  begin
    if (FForm <> AComponent) then FForm := LMDGetOwnerForm(self);
  end;
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
end; {Notification}

procedure TElFormCaption.Update;
var S : String;
    i : integer;
begin
  if not (csLoading in ComponentState) then
    SetWindowPos(FForm.Handle, 0, 0, 0, 0, 0,
      SWP_DRAWFRAME or SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);

  if Active and (FTexts.Count > 0) and (not (csDesigning in ComponentState)) then
  begin
    if not IsThemed then
    begin
      S := '';
      for i := 0 to FTexts.Count -1 do
      begin
        if FTexts[i].Visible then
          S := S + FTexts[i].Caption;
      end;
      FForm.Caption := S;
    end
    else
      FForm.Caption := '';
  end;
end;

procedure TElFormCaption.PaintCaption(var Msg: TMessage; Step: integer);
  procedure PaintButtons(Canvas: TCanvas; var R: TRect; CalcOnly: boolean);
  var
    ID: boolean;
    IHandle,
      IHandle2: HICON;
    IconX,
      IconY: integer;
    BtnWidth: integer;
    Flag: DWORD;
    SrcRect: TRect;
    i: integer;
    Btns: TBorderIcons;
    Button: TElCaptionButton;
  begin
    if (((biSystemMenu in FForm.BorderIcons) and (FForm.BorderStyle in [bsSingle, bsSizeable]))
      or (csDesigning in ComponentState)) then
    begin
      Inc(R.Left, 1);
      dec(R.Right);
      ID := false;
      if FForm.Icon.Handle <> 0 then
        IHandle := FForm.Icon.Handle
      else
        if Application.Icon.Handle <> 0 then
          IHandle := Application.Icon.Handle
        else
        begin
          IHandle := LoadIcon(0, IDI_APPLICATION);
          ID := true;
        end;
      IconX := GetSystemMetrics(SM_CXSMICON);
      if IconX = 0 then
        IconX := GetSystemMetrics(SM_CXSIZE);
      IconY := GetSystemMetrics(SM_CYSMICON);
      if IconY = 0 then
        IconY := GetSystemMetrics(SM_CYSIZE);
      IHandle2 := CopyImage(IHandle, IMAGE_ICON, IconX, IconY, LR_COPYFROMRESOURCE);
      if not IsThemed then
        DrawIconEx(Canvas.Handle, R.Left + 1, R.Top + 1, IHandle2, 0, 0, 0, 0, DI_NORMAL);
      DestroyIcon(IHandle2);
      if ID then DestroyIcon(IHandle);
      Inc(R.Left, GetSystemMetrics(SM_CXSMICON) + 3);
    end;

    if (FForm.FormStyle = fsMDIChild) and ((FForm.BorderStyle = bsDialog) or (FForm.BorderStyle = bsToolWindow) or (FForm.BorderStyle = bsSizeToolWin)) then
      Inc(R.Left, GetSystemMetrics(SM_CXSMICON) + 3);

    SrcRect := R;
    InflateRect(SrcRect, -2, -2);
    if (csDesigning in ComponentState) then
      Btns := [biSystemMenu, biMinimize, biMaximize]
    else
    begin
      Btns := [];
      if (biSystemMenu in FForm.BorderIcons) then
      begin
        Btns := [biSystemMenu];
        if (not (FForm.BorderStyle in [bsToolWindow, bsSizeToolWin])) or (FForm.FormStyle = fsMDIChild) then
        begin
          if (FForm.BorderStyle = bsDialog) and (biHelp in FForm.BorderIcons) then
            Include(Btns, biHelp);
          if (((FForm.BorderStyle = bsSingle) or
            (FForm.BorderStyle = bsSizeable)) and
            (biHelp in FForm.BorderIcons) and
            (not (biMinimize in FForm.BorderIcons)) and
            (not (biMaximize in FForm.BorderIcons))) then
            Include(Btns, biHelp);
          if not (FForm.BorderStyle in [bsToolwindow, bsSizeToolWin, bsDialog]) then
          begin
            if ((biMinimize in FForm.BorderIcons) or
              (biMaximize in FForm.BorderIcons)) then
              Btns := Btns + [biMinimize, biMaximize];
          end;
        end;
      end;
    end;
    BtnWidth := GetSystemMetrics(SM_CXSIZE) - 2;
    if ((FForm.BorderStyle in [bsToolWindow, bsSizeToolWin]) and (FForm.FormStyle <> fsMDIChild) and
      (not (csDesigning in ComponentState))) then
      BtnWidth := GetSystemMetrics(SM_CXSMSIZE) - 2;
    SrcRect.Left := SrcRect.Right - BtnWidth;
    if Btns <> [] then
      FBtnsRect := Rect(-1, R.Top, -1, R.Bottom);
    if biSystemMenu in Btns then
    begin
      FBtnsRect.Right := SrcRect.Right;
      FBtnsRect.Left := SrcRect.Left;
      if not CalcOnly then
        if not IsThemed then
          DrawFrameControl(Canvas.Handle, SrcRect, DFC_CAPTION, DFCS_CAPTIONCLOSE);
      OffsetRect(SrcRect, -BtnWidth - 2, 0);
      Dec(R.Right, BtnWidth + 2);
    end;
    if biMaximize in Btns then
    begin
      if IsZoomed(FForm.Handle) then
        Flag := DFCS_CAPTIONRESTORE
      else
        Flag := DFCS_CAPTIONMAX;
      if not (biMaximize in FForm.BorderIcons) then
        Flag := Flag or DFCS_INACTIVE;
      if FBtnsRect.Left = -1 then
        FBtnsRect.Left := SrcRect.Left;
      if FBtnsRect.Right = -1 then
        FBtnsRect.Left := SrcRect.Right;
      if not CalcOnly then
        if not IsThemed then
          DrawFrameControl(Canvas.Handle, SrcRect, DFC_CAPTION, Flag);
      OffsetRect(SrcRect, -BtnWidth, 0);
      Dec(R.Right, BtnWidth);
    end;
    if biMinimize in Btns then
    begin
      if IsIconic(FForm.Handle) then
        Flag := DFCS_CAPTIONRESTORE
      else
        Flag := DFCS_CAPTIONMIN;
      if not (biMinimize in FForm.BorderIcons) then
        Flag := Flag or DFCS_INACTIVE;
      if FBtnsRect.Left = -1 then
        FBtnsRect.Left := SrcRect.Left;
      if FBtnsRect.Right = -1 then
        FBtnsRect.Left := SrcRect.Right;
      if not CalcOnly then
        if not IsThemed then
          DrawFrameControl(Canvas.Handle, SrcRect, DFC_CAPTION, Flag);
      OffsetRect(SrcRect, -BtnWidth, 0);
      Dec(R.Right, BtnWidth);
    end;
    if (biHelp in Btns) then
    begin
      if FBtnsRect.Left = -1 then
        FBtnsRect.Left := SrcRect.Left;
      if FBtnsRect.Right = -1 then
        FBtnsRect.Left := SrcRect.Right;
      if not CalcOnly then
        if not IsThemed then
          DrawFrameControl(Canvas.Handle, SrcRect, DFC_CAPTION, DFCS_CAPTIONHELP);
      Dec(R.Right, BtnWidth);
    end;
    if IsThemed then
      dec(SrcRect.Top)
    else
      Dec(R.Right, 2);
    if LMDSIWindowsVistaUp then
      inc(SrcRect.Bottom);
    for i := 0 to FButtons.Count - 1 do // Iterate
    begin
      Button := FButtons[i];
      if (not Button.Visible) or (Button.Align = taCenter) then Continue;
      SrcRect.Left := 0;
      SrcRect.Right := Button.GetWidth(Canvas, SrcRect.Bottom - SrcRect.Top);
      if SrcRect.Right >= R.Right - R.Left then
        break
      else
      begin
        if Button.FAlign = taLeftJustify then
          OffsetRect(SrcRect, R.Left, 0)
        else
          OffsetRect(SrcRect, R.Right - SrcRect.Right, 0);
      end;
      Button.FBtnRect := SrcRect;
      Button.Paint(Canvas, SrcRect);
      if Button.FAlign = taLeftJustify then
        inc(R.Left, SrcRect.Right - SrcRect.Left)
      else
        dec(R.Right, SrcRect.Right - SrcRect.Left);
      if R.Left >= R.Right then
        break;
    end; // for
  end;

  procedure PaintText(Canvas: TCanvas; var R: TRect);
  var
    SrcRect: TRect;
    i, X   : integer;
    FOldStyle: TBrushStyle;
    Text: TElCaptionText;
    S : String;
  begin
    FOldStyle := Canvas.Brush.Style;
    Canvas.Brush.Style := bsClear;
    SrcRect := R;
    Inc(R.Left, 2);
    InflateRect(SrcRect, -2, -2);

    if (FForm.BorderStyle in [bsDialog]) and
       (not (csDesigning in ComponentState)) and (FForm.FormStyle <> fsMDIChild) then
      R.Left := R.Left + GetSystemMetrics(SM_CXFIXEDFRAME);

    // draw left-aligned ones
    if Texts.Count = 0 then
    begin
      FPreventUpdate := true;
      Text := TElCaptionText.Create(nil);
      Text.FFormCaption := Self;

      if (csDesigning in ComponentState) then
      begin
        SetLength(S, 1024);
        SendMessage(LMDGetOwnerForm(Self).Handle, WM_GETTEXT, 1023, TLMDPtrInt(PChar(S)));
        SetLength(S, StrLen(PChar(S)));
        Text.FCaption := S;
      end
      else
        Text.FCaption := LMDGetOwnerForm(Self).Caption;
      SrcRect.Left := 0;
      SrcRect.Right := Min(Text.GetWidth(Canvas, R.Bottom - R.Top), R.Right - R.Left);
      OffsetRect(SrcRect, R.Left, 0);
      Text.Paint(Canvas, SrcRect);
      Text.Free;
      FPreventUpdate := false;
    end
    else
    begin
      for i := 0 to Texts.Count - 1 do
      begin
        Text := Texts[i];
        if (not Text.Visible) or (Text.Align <> taLeftJustify) then
          Continue;
        SrcRect.Left := 0;
//        if not IsThemed then
        SrcRect.Right := Min(Text.GetWidth(Canvas, R.Bottom - R.Top), R.Right - R.Left);

        if (IsThemed) and (LMDSIWindowsVistaUp) then  //it's Vista and Themes
        begin
          if (FForm.BorderStyle in [bsSizeable, bsSizeToolWin]) then //it's a sizeable form
            OffsetRect(SrcRect, R.Left +3, -3)
          else
            OffsetRect(SrcRect, R.Left +3, 0);
        end
        else
          OffsetRect(SrcRect, R.Left, 0);

        Text.Paint(Canvas, SrcRect);

        R.Left := SrcRect.Right{ + 1};
        if R.Left >= R.Right then
          break;
      end;

      if R.Left < R.Right then
        // draw right-aligned ones
        for i := 0 to Texts.Count - 1 do
        begin
          Text := Texts[i];
          if (not Text.Visible) or (Text.Align <> taRightJustify) then
            Continue;
          SrcRect.Left := 0;
          X := Min(Text.GetWidth(Canvas, R.Bottom - R.Top), R.Right - R.Left);
          SrcRect.Right := R.Right;
          SrcRect.Left := Max(SrcRect.Right - X, R.Left);

          if (IsThemed) and (LMDSIWindowsVistaUp) then  //it's Vista and Themes
          begin
            if (FForm.BorderStyle in [bsSizeable, bsSizeToolWin]) then //it's a sizeable form
              OffsetRect(SrcRect, 0, -3);
          end;
          Text.Paint(Canvas, SrcRect);
          //DrawText(Canvas.Handle, PChar(Text.Caption), -1, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS);
          R.Right := SrcRect.Left - 1;
          if R.Left >= R.Right then
            break;
        end;

      if R.Left < R.Right then
      begin
        // draw centered ones
        X := 0;
        for i := 0 to Texts.Count - 1 do
        begin
          Text := Texts[i];
          if (not Text.Visible) or (Text.Align <> taCenter) then
            Continue;
          Inc(X, Text.GetWidth(Canvas, R.Bottom - R.Top));
        end;
        if (X > 0) and (X < R.Right - R.Left) then
        begin
          R.Left  := (R.Right - R.Left - X) div 2 + R.Left;
          R.Right := R.Left + X;
          for i := 0 to Texts.Count - 1 do
          begin
            Text := Texts[i];
            if (not Text.Visible) or (Text.Align <> taCenter) then
              Continue;
            SrcRect.Left := 0;
            SrcRect.Right := Min(Text.GetWidth(Canvas, R.Bottom - R.Top), R.Right - R.Left);
            if (IsThemed) and (LMDSIWindowsVistaUp) then  //it's Vista and Themes
            begin
              if (FForm.BorderStyle in [bsSizeable, bsSizeToolWin]) then //it's a sizeable form
                OffsetRect(SrcRect, R.Left +3, -3)
              else
                OffsetRect(SrcRect, R.Left +3, 0);
            end
            else
              OffsetRect(SrcRect, R.Left, 0);
            Text.Paint(Canvas, SrcRect);
            //DrawText(Canvas.Handle, PChar(Text.Caption), -1, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS);
            R.Left := SrcRect.Right + 1;
          end;
        end;
      end;
    end;

    Canvas.Brush.Style := FOldStyle;
  end;

  procedure PaintBackground(Canvas: TCanvas; var R: TRect);

    procedure FillTitle(R: TRect);
    var
      StartColor,
        EndColor: TColor;
      IsGrad: BOOL;
    begin
      if BackgroundType = bgtColorFill then
      begin
        if LMDSIWindows98 or LMDSIWindows2000 then
        begin
          SystemParametersInfo(SPI_GETGRADIENTCAPTIONS, 0, @IsGrad, 0);
          if IsGrad then
          begin
            if FWndActive then
            begin
              StartColor := GetSysColor(COLOR_ACTIVECAPTION);
              EndColor := GetSysColor(COLOR_GRADIENTACTIVECAPTION);
            end
            else
            begin
              StartColor := GetSysColor(COLOR_INACTIVECAPTION);
              EndColor := GetSysColor(COLOR_GRADIENTINACTIVECAPTION);
            end;
          end
          else
          begin
            if FWndActive then
            begin
              StartColor := clActiveCaption;
              EndColor := clActiveCaption;
            end
            else
            begin
              StartColor := clInActiveCaption;
              EndColor := clInActiveCaption;
            end;
          end;
        end
        else
        begin
          if FWndActive then
          begin
            StartColor := clActiveCaption;
            EndColor := clActiveCaption;
          end
          else
          begin
            StartColor := clInActiveCaption;
            EndColor := clInActiveCaption;
          end;
        end;
      end
      else
        if (((PaintBkgnd = pbtActive) or (PaintBkgnd = pbtAlways)) and (FWndActive))
          and (NumColors <> 1) then
        begin
          StartColor := FActiveLeftColor;
          EndColor := FActiveRightColor;
        end
        else
          if (((PaintBkgnd = pbtInactive) or (PaintBkgnd = pbtAlways)) and (not FWndActive))
            and (NumColors <> 1) then
          begin
            StartColor := FInActiveLeftColor;
            EndColor := FInActiveRightColor;
          end
          else
          begin
            if FWndActive then
            begin
              StartColor := clActiveCaption;
              EndColor := clActiveCaption;
            end
            else
            begin
              StartColor := clInActiveCaption;
              EndColor := clInActiveCaption;
            end;
          end;
      if StartColor = EndColor then
      begin
        Canvas.Brush.Color := StartColor;
        Canvas.FillRect(R);
      end
      else
        LMDGradientPaint(Canvas, R, StartColor, EndColor, FNumColors, LMDBackgroundType2GradientStyle[BackgroundType], 0, 0);
    end;

  begin
    if IsThemed then
      exit;
    if (BackgroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap]) and
      ((FWndActive and FBitmap.Empty) or ((not FWndActive) and FInactiveBitmap.Empty)) then
      FillTitle(R)
    else
      case BackgroundType of
        bgtColorFill,
          bgtCenterBitmap:
          //if not (UseXPThemes and XPThemesAvailable and (FThe.me <> 0)) then
            FillTitle(R);
        bgtTileBitmap:
          begin
            if FWndActive then
              TiledPaint(Canvas, FBitmap, R)
            else
              TiledPaint(Canvas, FInactiveBitmap, R);
          end;
      {bgtCenterBitmap:
        begin
          Canvas.FillRect(R);
          if FWndActive then
          begin
            CenterRects(FBitmap.Width, R.Right - R.Left,
                        FBitmap.Height, R.Bottom - R.Top, SrcRect);
            OffsetRect(SrcRect, R.Left, R.Top);
            Canvas.CopyRect(SrcRect, FInactiveBitmap.Canvas, Rect(SrcRect.Left, ));
          end else
          begin
            CenterRects(FInactiveBitmap.Width, R.Right - R.Left,
                        FInactiveBitmap.Height, R.Bottom - R.Top, SrcRect);
          end;
          Canvas.CopyRect(SrcRect, FInactiveBitmap.Canvas,
            Rect(0, 0, FInactiveBitmap.Width, FInactiveBitmap.Height));
        end;}
        bgtStretchBitmap:
          if FWndActive then
            Canvas.CopyRect(R, FBitmap.Canvas, Rect(0, 0, FBitmap.Width, FBitmap.Height))
          else
            Canvas.CopyRect(R, FInactiveBitmap.Canvas,
              Rect(0, 0, FInactiveBitmap.Width, FInactiveBitmap.Height));
      else
        FillTitle(R);
      end;
  end;

  function CalcCaptionRect: TRect;
  begin
    GetWindowRect(FForm.Handle, Result);
    OffsetRect(Result, -Result.Left, -Result.Top);
    begin
//      if IsIconic(FForm.Handle) then
//        InflateRect(Result, -GetSystemMetrics(SM_CXFIXEDFRAME), -GetSystemMetrics(SM_CYFIXEDFRAME))
//      else
      begin
        if (not (csDesigning in ComponentState)) then
          case FForm.BorderStyle of
            bsToolWindow,
              bsSingle,
              bsDialog:
              InflateRect(Result, -GetSystemMetrics(SM_CXFIXEDFRAME), -GetSystemMetrics(SM_CYFIXEDFRAME));
            bsSizeToolWin,
              bsSizeable:
              InflateRect(Result, -GetSystemMetrics(SM_CXSIZEFRAME), -GetSystemMetrics(SM_CYSIZEFRAME));
          end
        else
          InflateRect(Result, -GetSystemMetrics(SM_CXSIZEFRAME), -GetSystemMetrics(SM_CYSIZEFRAME));
      end;
      if (FForm.BorderStyle in [bsToolWindow, bsSizeToolWin]) and
         (not (csDesigning in ComponentState)) and (FForm.FormStyle <> fsMDIChild) then
        Result.Bottom := Result.Top + GetSystemMetrics(SM_CYSMCAPTION) - 1
      else
        Result.Bottom := Result.Top + GetSystemMetrics(SM_CYCAPTION) - 1;
    end;
  end;

  function CalcButtonsRect: TRect;
  begin
    Result := CalcCaptionRect;

    // Just a frame
    Result.Left := Result.Right;
    if not IsIconic(FForm.Handle) then
      Result.Right := FForm.Width;

    // We haven't any system buttons on caption
    If not (biSystemMenu in FForm.BorderIcons) or (FForm.BorderStyle = bsNone) then
//      exit
    else // We have "close button" as minimum
    begin
      if not (csDesigning in ComponentState) then
      case FForm.BorderStyle of
        bsToolWindow,
        bsSizeToolWin:
          if (FForm.FormStyle = fsMDIChild) then
            Dec(Result.Left, GetSystemMetrics(SM_CXSIZE) + GetSystemMetrics(SM_CXBORDER))
          else
            Dec(Result.Left, GetSystemMetrics(SM_CXSMSIZE) + GetSystemMetrics(SM_CXBORDER));
        bsDialog:
        begin
          Dec(Result.Left, GetSystemMetrics(SM_CXSIZE) + GetSystemMetrics(SM_CXBORDER));
          if (biHelp in FForm.BorderIcons) then
            Dec(Result.Left, GetSystemMetrics(SM_CXSIZE) + GetSystemMetrics(SM_CXBORDER));
          if (FForm.FormStyle = fsMDIChild) then
            if (biMinimize in FForm.BorderIcons) or (biMaximize in FForm.BorderIcons) then
              Dec(Result.Left, (GetSystemMetrics(SM_CXSIZE) * 2))
        end;
      else
        Dec(Result.Left, GetSystemMetrics(SM_CXSIZE));
        // If we have only one of minimize
        if (biMinimize in FForm.BorderIcons) or (biMaximize in FForm.BorderIcons) then
          Dec(Result.Left, (GetSystemMetrics(SM_CXSIZE) * 2))
        else
          if (biHelp in FForm.BorderIcons) then
            Dec(Result.Left, GetSystemMetrics(SM_CXSIZE));
      end;
    end;

    OffsetRect(Result, -Result.Left, -Result.Top);
  end;

var
  Rect,
    Rect1: TRect;
  BmpDC: HDC;
  i: integer;
  BMP: TBitmap;
  WR: TRect;
  DC0, DCex: HDC;
  LRgnButtons, LRgnIcon: HRGN;
  LButtonsWidth: integer;
  LIconIdent: Integer;
  LDetail: TThemedWindow;
  LThemeMode: TLMDThemeMode;
  lCaptionID, lStateID: cardinal;
  tmps: TSize;
  LBorders: set of TFormBorderStyle;
  LFrame: Integer;
  LDPIY: Integer;
begin
  LThemeMode := UseThemeMode;
  if (FForm.BorderStyle = bsNone) and (not (csdesigning in ComponentState)) then exit;

  DCEx := GetWindowDC(FForm.Handle);

  LButtonsWidth := CalcButtonsRect.Right;

  Rect := CalcCaptionRect;
  if Step = 2 then
  begin
    FCaptionHeight := 0;
    GetWindowRect(FForm.Handle, WR);
    GetClientRect(FForm.Handle, Rect1);
    MapWindowPoints(HWND_DESKTOP, FForm.Handle, WR, 2);
    OffsetRect(Rect1, -Rect1.Left, -Rect1.Top);
    WR.Bottom := WR.Bottom - Rect1.Bottom;

    Bmp := TBitmap.Create;
    Rect1 := Rect;
    if LThemeMode <> ttmNone then
    begin
      if FActiveForm then
        lStateID := FS_ACTIVE
      else
        lStateID := FS_INACTIVE;

      LBorders := [bsToolWindow, bsSizeToolWin];
      if LMDSIWindowsVistaUp then
        LBorders := LBorders + [bsSingle, bsDialog];
      if FForm.BorderStyle in LBorders then
        lCaptionID := WP_SMALLCAPTION
      else
        lCaptionID := WP_CAPTION;

      LMDThemeServices.GetThemePartSize(ThemeMode, DCEx, teWindow, lCaptionID, lStateID, tmps);
      DC0 := GetDC(0);
      LDPIY := MulDiv(GetDeviceCaps(DC0, LOGPIXELSY), 100, 96);
      ReleaseDC(0, DC0);
      FCaptionHeight := MulDiv(tmps.cy, LDPIY, 100);

      if LMDSIWindowsVistaUp and (lCaptionID = WP_SMALLCAPTION) then
      begin
        LMDThemeServices.GetThemePartSize(ThemeMode, DCEx, teWindow, WP_FRAMEBOTTOM, lStateID, tmps);
        if LMDSIWindowsWindows7Up then
          LFrame := tmps.cy * 2
        else
          LFrame := tmps.cy;
        FCaptionHeight := FCaptionHeight + LFrame;
      end;

      if FCaptionHeight <= 0 then
        if lCaptionID = WP_CAPTION then
          FCaptionHeight := LMDNCCAPTIONHEIGHT
        else
          FCaptionHeight := LMDNCSMALLCAPTIONHEIGHT;

      //if (FForm.BorderStyle in [bsToolWindow, bsSizeToolWin]) and (FForm.FormStyle <> fsMDIChild) then
      //  FCaptionHeight := GetSystemMetrics(SM_CYSMCAPTION) + GetSystemMetrics(SM_CYBORDER)
      //else
      //  FCaptionHeight := GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYBORDER);

      //if FForm.WindowState = wsMaximized then
        //Inc(FCaptionHeight, GetSystemMetrics(SM_CYBORDER))
      //else
      //  Dec(FCaptionHeight, 2);

      if LMDSIWindowsVistaUp then
        dec(FCaptionHeight, 1);

      BmpDC := CreateCompatibleBitmap(DCEx, (WR.Right - WR.Left) - (LButtonsWidth - 2), FCaptionHeight);
    end
    else
    begin
      OffsetRect(Rect1, -Rect1.Left, -Rect1.Top);
      BmpDC := CreateCompatibleBitmap(DCEx, Rect1.Right, Rect1.Bottom);
    end;
    Bmp.Handle := BmpDC;
    if FRegion <> 0 then
    begin
      Msg.WParam := TLMDPtrInt(FSaveRegion);
      DeleteObject(FRegion);
      FRegion := 0;
    end;
    if LThemeMode <> ttmNone then
    begin
      OffsetRect(WR, -WR.Left, -WR.Top);
      WR.Bottom := FCaptionHeight + 1;
      if FForm.WindowState = wsMaximized then
        WR.Top := WR.Top + GetSystemMetrics(SM_CYFRAME);
      if (FForm.BorderStyle in LBorders) and (FForm.FormStyle <> fsMDIChild) then
        begin
          if FActiveForm then
            begin
              if FForm.WindowState = wsMaximized then
                LDetail := twSmallMaxCaptionActive
              else
                LDetail := twSmallCaptionActive;
            end
          else
            begin
              if FForm.WindowState = wsMaximized then
                LDetail := twSmallMaxCaptionInActive
              else
                LDetail := twSmallCaptionInActive;
            end
         end
      else
        begin
          if FActiveForm then
             begin
               if FForm.WindowState = wsMaximized then
                 LDetail := twMaxCaptionActive
               else
                 LDetail := twCaptionActive;
             end
           else
             begin
               if FForm.WindowState = wsMaximized then
                 LDetail := twMaxCaptionInActive
               else
                 LDetail := twCaptionInActive;
             end;

         end;
      LMDThemeServices.DrawElement(LThemeMode, Bmp.Canvas.Handle, LDetail, WR);
    end;
    PaintBackGround(Bmp.Canvas, Rect1);
    PaintButtons(Bmp.Canvas, Rect1, false);
    for i := 0 to Buttons.Count - 1 do
    begin
      //      OffsetRect(Buttons[i].FBtnRect, Rect.Left, Rect.Top);
      end;
    PaintText(Bmp.Canvas, Rect1);
    TriggerDrawCaptionEvent(Bmp.Canvas, Rect1);
    if IsThemed then
    begin
      LIconIdent := 0;
      if (biSystemMenu in FForm.BorderIcons) then
      begin
        if (FForm.BorderStyle = bsSingle) or (FForm.BorderStyle = bsSizeable) then
          LIconIdent := GetSystemMetrics(SM_CXSMICON) + GetSystemMetrics(SM_CXFRAME);
        // For dialog as mdi child
        if (FForm.FormStyle = fsMDIChild) and ((FForm.BorderStyle = bsDialog) or (FForm.BorderStyle = bsToolWindow) or (FForm.BorderStyle = bsSizeToolWin)) then
          LIconIdent := GetSystemMetrics(SM_CXSMICON) + GetSystemMetrics(SM_CXFRAME);
      end;
      case FForm.BorderStyle of
        bsToolWindow,
        bsDialog,
        bsSingle:
          BitBlt(DCEx, Rect.Left + LIconIdent, Rect.Top - GetSystemMetrics(SM_CYFIXEDFRAME), Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, LIconIdent + GetSystemMetrics(SM_CXFIXEDFRAME), 0, SRCCOPY);
      else
        BitBlt(DCEx, Rect.Left + LIconIdent, Rect.Top - GetSystemMetrics(SM_CYFRAME), Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, LIconIdent + GetSystemMetrics(SM_CXFRAME), 0, SRCCOPY);
      end;
    end
    else
      BitBlt(DCEx, Rect.Left, Rect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    Bmp.Free;
  end
  else
  begin
    GetWindowRect(FForm.Handle, WR);
    if FRegion <> 0 then
      DeleteObject(FRegion);
    if not IsThemed then
    begin
      FRegion := CreateRectRgnIndirect(WR);
      if SelectClipRgn(DCEx, HRGN(Msg.wParam)) = error then
        SelectClipRgn(DCEx, FRegion);
      OffsetClipRgn(DCEx, -WR.Left, -WR.Top);
      ExcludeClipRect(DCEx, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
      OffsetClipRgn(DCEx, WR.Left, WR.Top);
      GetClipRgn(DCEx, FRegion);
      FSaveRegion := HRGN(Msg.WParam);
      Msg.WParam := TLMDPtrInt(FRegion);
    end
    else
    begin
      if (FForm.BorderStyle in [bsToolWindow, bsSizeToolWin]) and (FForm.FormStyle <> fsMDIChild) then
        FCaptionHeight := GetSystemMetrics(SM_CYSMCAPTION)
      else
        FCaptionHeight := GetSystemMetrics(SM_CYCAPTION);
      LRgnButtons := CreateRectRgn(WR.Right - LButtonsWidth, WR.Top,
                                   WR.Right, WR.Top + FCaptionHeight +
                                  GetSystemMetrics(SM_CYBORDER));
      case FForm.BorderStyle of
        bsSingle,
        bsSizeable:
          LRgnIcon := CreateRectRgn(WR.Left, WR.Top, WR.Left + (GetSystemMetrics(SM_CXFRAME) * 2) +
                                    GetSystemMetrics(SM_CXSMICON), WR.Top + FCaptionHeight +
                                    GetSystemMetrics(SM_CYBORDER));
        bsDialog,
        bsToolWindow,
        bsSizeToolWin:
          begin
            if FForm.FormStyle = fsMDIChild then
              LRgnIcon := CreateRectRgn(WR.Left, WR.Top, WR.Left + (GetSystemMetrics(SM_CXFRAME) * 2) +
                                        GetSystemMetrics(SM_CXSMICON), WR.Top + FCaptionHeight +
                                        GetSystemMetrics(SM_CYBORDER))
            else
              LRgnIcon := CreateRectRgn(WR.Left, WR.Top, WR.Left + GetSystemMetrics(SM_CXFRAME),
                                        WR.Top + FCaptionHeight + GetSystemMetrics(SM_CYBORDER));
          end;
      else
        LRgnIcon := CreateRectRgn(WR.Left, WR.Top, WR.Left + GetSystemMetrics(SM_CXFRAME),
                                  WR.Top + FCaptionHeight + GetSystemMetrics(SM_CYBORDER));
      end;

      WR.Top := WR.Top + FCaptionHeight + GetSystemMetrics(SM_CYBORDER);
      FRegion := CreateRectRgnIndirect(WR);
      CombineRgn(FRegion, FRegion, LRgnButtons, RGN_XOR);
      CombineRgn(FRegion, FRegion, LRgnIcon, RGN_XOR);

      DeleteObject(LRgnIcon);
      DeleteObject(LRgnButtons);

      FSaveRegion := Msg.WParam;
      Msg.WParam := FRegion;
    end;
  end;
  ReleaseDC(FForm.Handle, DCEx);
end; {PaintCaption}

procedure TElFormCaption.SetPaintBkgnd(newValue: TElPaintBkgndType);
begin
  if (FPaintBkgnd <> newValue) then
  begin
    FPaintBkgnd := newValue;
    Update;
  end; {if}
end; {SetPaintBkgnd}

procedure TElFormCaption.SetInactiveRightColor(newValue: TColor);
begin
  if (FInactiveRightColor <> newValue) then
  begin
    FInactiveRightColor := newValue;
    Update;
  end; {if}
end; {SetInactiveRightColor}

procedure TElFormCaption.SetButtons(newValue: TElCaptionButtons);
begin
  FButtons.Assign(newValue);
end; {SetButtons}

procedure TElFormCaption.SetInactiveBitmap(newValue: TBitmap);
begin
  FInactiveBitmap.Assign(newValue);
end; {SetInactiveBitmap}

procedure TElFormCaption.FontChange(Sender: TObject);
begin
  Update;
end;

procedure TElFormCaption.GetSystemFont;
var
  NCM: TNonClientMetrics;
  FFontHandle: HFont;
begin
  {$IFDEF LMDCOMP14}
  NCM.cbSize := TNonClientMetrics.SizeOf;
  {$ELSE}
  NCM.cbSize := SizeOf(TNonClientMetrics);
  {$ENDIF}
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NCM, 0) then
  begin
    if (FForm.BorderStyle in [bsToolWindow, bsSizeToolWin]) and (not (csDesigning in ComponentState)) then
      FFontHandle := CreateFontIndirect(NCM.lfSmCaptionFont)
    else
      FFontHandle := CreateFontIndirect(NCM.lfCaptionFont);
  end
  else
    FFontHandle := 0;
  Font2.Handle := FFontHandle;
end;

procedure TElFormCaption.SetFont;
begin
  FFont.Assign(newValue);
end;

procedure TElFormCaption.TriggerDrawCaptionEvent(Canvas: TCanvas; var Rect:
  TRect);
begin
  if (assigned(FOnDrawCaption)) then FOnDrawCaption(Self, Canvas, Rect);
end;

function TElFormCaption.ButtonAtPos(X, Y: integer): TElCaptionButton;
var
  i: integer;
  P, P1: TPoint;
begin
  result := nil;
  P := Point(X, Y);
  for i := 0 to Buttons.Count - 1 do // Iterate
  begin
    P1 := P;
    if (FForm.FormStyle = fsMDIChild) then
    begin
      if Assigned(Application.MainForm) then
        P1 := Application.MainForm.ScreenToClient(P1);
    end;
    Dec(P1.X, FForm.Left);
    Dec(P1.Y, FForm.Top);
    if PtInRect(Buttons[i].FBtnRect, P1) then
    begin
      result := Buttons[i];
      exit;
    end;
  end; // for
end; {ButtonAtPos}

procedure TElFormCaption.TriggerButtonClickEvent(Button: TElCaptionButton);
begin
  if (assigned(FOnButtonClick)) then FOnButtonClick(Self, Button);
  if (assigned(Button.FOnClick)) then Button.FOnClick(Button);
end;

procedure TElFormCaption.TriggerButtonDblClickEvent(Button: TElCaptionButton);
begin
  if (assigned(FOnButtonDblClick)) then FOnButtonDblClick(Self, Button);
  if (assigned(Button.FOnDblClick)) then Button.FOnDblClick(Button);
end;

procedure TElFormCaption.SetSystemFont(newValue: Boolean);
begin
  if (FSystemFont <> newValue) then
  begin
    FSystemFont := newValue;
    Update;
  end; {if}
end;

procedure TElFormCaption.SetTexts(newValue: TElCaptionTexts);
begin
  if (FTexts <> newValue) then
    FTexts.Assign(newValue);
end;

destructor TElFormCaption.Destroy;
begin
  FTexts.Free;
  FButtons.Free;
  FBitmap.Free;
  FFont.Free;
  Font2.Free;
  FInactiveBitmap.Free;
  FHook.Free;
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  FreeAndNil(FChLink);
  FreeAndNil(FDownChLink);
  FreeAndNil(FDisabledChLink);
  inherited Destroy;
end; {Destroy}

constructor TElFormCaption.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHook := TElHook.Create(Self);
  FForm := LMDGetOwnerForm(Self);
  FRegion := 0;
  with FHook do
  begin
    Control := FForm;
    Active := false;
    DesignActive := true;
    OnBeforeProcess := OnBeforeHook;
    OnAfterProcess := OnAfterHook;
  end; {FHook}
  FNumColors := 64;
  FBitmap := TBitmap.Create;
  FBitmap.OnChange := BitmapChange;
  FActiveRightColor := clActiveCaption;
  FInactiveRightColor := clInactiveCaption;
  FBackgroundType := bgtColorFill;
  FAlignment := taLeftJustify;
  FPaintBkgnd := pbtAlways;
  FInactiveRightColor := clInactiveCaption;
  FButtons := TElCaptionButtons.Create(TElCaptionButton);
  FButtons.FCaption := Self;
  FTexts := TElCaptionTexts.Create(TElCaptionText);
  FTexts.FCaption := Self;
  FInactiveBitmap := TBitmap.Create;
  FInactiveBitmap.OnChange := BitmapChange;
  FSystemFont := true;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  Font2 := TFont.Create;
  GetSystemFont;
  FThemeMode := ttmPlatform;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  if not (csDesigning in ComponentState) then
    StyleManager := DefaultStyleManager;
  FChLink  := TChangeLink.Create;
  FDownChLink  := TChangeLink.Create;
  FDisabledChLink  := TChangeLink.Create;

  FChLink.OnChange := ImagesChanged;
  FDownChLink.OnChange := ImagesChanged;
  FDisabledChLink.OnChange := ImagesChanged;
end; {Create}

procedure TElFormCaption.Assign(Source : TPersistent);
begin
  if Source is TElformCaption then
  begin
    Self.FTexts.Assign(TElformCaption(Source).FTexts);
    Self.FInactiveBitmap.Assign(TElformCaption(Source).FInactiveBitmap);
    Self.FButtons.Assign(TElformCaption(Source).FButtons);
    Self.FPaintBkgnd := TElformCaption(Source).FPaintBkgnd;
    Self.FBitmap.Assign(TElFormCaption(Source).FBitmap);
    Self.FInactiveBitmap.Assign(TElFormCaption(Source).FInactiveBitmap);
    Self.FActiveLeftColor := TElFormCaption(Source).FActiveLeftColor;
    Self.FInActiveLeftColor := TElFormCaption(Source).FInActiveLeftColor;
    Self.FActiveRightColor := TElFormCaption(Source).FActiveRightColor;
    Self.FInActiveRightColor := TElFormCaption(Source).FInActiveRightColor;
    Self.FBackgroundType := TElFormCaption(Source).FBackgroundType;
    Self.FNumColors := TElFormCaption(Source).FNumColors;
    Self.FAlignment := TElFormCaption(Source).FAlignment;
    Self.FSystemFont:= TElFormCaption(Source).SystemFont;
    Self.Font.Assign(TElFormCaption(Source).Font);
    Self.Images.Assign(TElFormCaption(Source).Images);
    Self.DownImages.Assign(TElFormCaption(Source).DownImages);
    Self.DisabledImages.Assign(TElFormCaption(Source).DisabledImages);
  end
  else
    inherited;
end;

procedure TElFormCaption.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
  end;
end;

function TElFormCaption.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

procedure TElFormCaption.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

procedure TElFormCaption.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TElFormCaption.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

procedure TElFormCaption.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

procedure TElFormCaption.DoThemeChanged;
begin
  FForm.Perform(CM_RECREATEWND, 0, 0);
end;

function TElFormCaption.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
  result := LMDThemeServices.UseTheme(result);
end;

function TElFormCaption.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

procedure TElFormCaption.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    if FStyleManager <> nil then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TElFormCaption.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TElFormCaption.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TElFormCaption.UpdateStyle;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if FStyleManager <> nil then
  begin
    if FForm.HandleAllocated and FForm.Visible then
      SendMessage(FForm.Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if FForm.HandleAllocated and FForm.Visible then
    begin
      SendMessage(FForm.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(FForm.Handle, nil, 0, RDW_FRAME);
    end;
  end;
end;

procedure TElFormCaption.SetImages(const Value: TCustomImageList);
begin
  if (FImages <> Value) then
  begin
    if FImages <> nil then
    begin
      if (not (csDestroying in FImages.ComponentState)) then
        FImages.RemoveFreeNotification(Self);
      FImages.UnregisterChanges(FChLink);
    end;
    FImages := Value;
    if FImages <> nil then
      FImages.FreeNotification(Self);
    if FImages <> nil then
      FImages.RegisterChanges(FChLink);
    Update;
  end;
end;

procedure TElFormCaption.SetUseImageList(const Value: Boolean);
begin
  if FUseImageList <> Value then
    begin
      FUseImageList := Value;
      Update;
    end;
end;

function TElCaptionButton.GetImageIndex: Integer;
begin
  result := TProxyGlyph(FGlyph).ImageIndex;
end;

procedure TElCaptionButton.SetImageIndex(const Value: Integer);
begin
  TProxyGlyph(FGlyph).ImageIndex := Value;
  Changed(true);
end;

procedure TElCaptionButton.SetUseImageList(const Value: Boolean);
begin
  TProxyGlyph(FGlyph).ImageList := TElFormCaption(Collection.Owner).Images;
  TProxyGlyph(FGlyph).FUseImageList := Value;

  Changed(true);
end;

procedure TElFormCaption.ImagesChanged(Sender: TObject);
begin
  if FUseImageList and (Sender = FImages) then
    Update;
end;

function TElCaptionButton.GetUseImageList: Boolean;
begin
  Result := TProxyGlyph(FGlyph).UseImageList;
end;

procedure TElFormCaption.SetDisabledImages(const Value: TCustomImageList);
begin
  if (FDisabledImages <> Value) then
  begin
    if FDisabledImages <> nil then
    begin
      if (not (csDestroying in FDisabledImages.ComponentState)) then
        FDisabledImages.RemoveFreeNotification(Self);
      FDisabledImages.UnregisterChanges(FDisabledChLink);
    end;
    FDisabledImages := Value;
    if FDisabledImages <> nil then
      FDisabledImages.FreeNotification(Self);
    if FDisabledImages <> nil then
      FDisabledImages.RegisterChanges(FDisabledChLink);
    Update;
  end;
end;

procedure TElFormCaption.SetDownImages(const Value: TCustomImageList);
begin
  if (FDownImages <> Value) then
  begin
    if FDownImages <> nil then
    begin
      if (not (csDestroying in FDownImages.ComponentState)) then
        FDownImages.RemoveFreeNotification(Self);
      FDownImages.UnregisterChanges(FDownChLink);
    end;
    FDownImages := Value;
    if FDownImages <> nil then
      FDownImages.FreeNotification(Self);
    if FDownImages <> nil then
      FDownImages.RegisterChanges(FDownChLink);
    Update;
  end;
end;

end.
