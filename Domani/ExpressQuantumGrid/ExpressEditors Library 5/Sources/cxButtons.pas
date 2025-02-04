{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxButtons;

{$I cxVer.inc}

interface

uses
{$IFDEF VCL}
  Windows, Messages, dxThemeManager,
{$ELSE}
  Qt, QTypes,
{$ENDIF}
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Classes, Controls, Graphics, StdCtrls, Forms, Menus,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Buttons, cxControls,
  cxContainer;

const
{$IFDEF VCL}
  CM_DROPDOWNPOPUPMENU = WM_APP + 300;
  CM_CLOSEUPPOPUPMENU = WM_APP + 301;
{$ELSE}
  QEventType_CMDropDownPopupMenu = QEventType(Integer(QEventType_ClxUser) + 301);
  QEventType_CMCloseUpPopupMenu = QEventType(Integer(QEventType_ClxUser) + 302);
{$ENDIF}
  cxDropDownButtonWidth = 15;

type
  TcxCustomButton = class;
  TcxButtonKind = (cxbkStandard, cxbkDropDown, cxbkDropDownButton);
  TcxButtonAssignedColors = set of TcxButtonState;
  TcxButtonGetDrawParamsEvent = procedure(Sender: TcxCustomButton;
    AState: TcxButtonState; var AColor: TColor; AFont: TFont) of object;

  { TcxButtonColors }

  TcxButtonColors = class(TPersistent)
  private
    FButton: TcxCustomButton;
    FAssignedColors: TcxButtonAssignedColors;
    FColors: array[TcxButtonState] of TColor;
    function GetBackgroundColor(AState: TcxButtonState): TColor;
    function GetColor(const Index: Integer): TColor;
    function IsStored(const Index: Integer): Boolean;
    procedure SetAssignedColors(Value: TcxButtonAssignedColors);
    procedure SetColor(const Index: Integer; const Value: TColor);
  public
    constructor Create(AOwner: TcxCustomButton);
    procedure Assign(Source: TPersistent); override;
  published
    property AssignedColors: TcxButtonAssignedColors read FAssignedColors write SetAssignedColors stored False;
    property Default: TColor index Ord(cxbsDefault) read GetColor write SetColor stored IsStored;
    property Normal: TColor index Ord(cxbsNormal) read GetColor write SetColor stored IsStored;
    property Hot: TColor index Ord(cxbsHot) read GetColor write SetColor stored IsStored;
    property Pressed: TColor index Ord(cxbsPressed) read GetColor write SetColor stored IsStored;
    property Disabled: TColor index Ord(cxbsDisabled) read GetColor write SetColor stored IsStored;
  end;

  { TcxGlyphList }

  TcxGlyphList = class(TImageList)
  private
    FUsed: TBits;
    FCount: Integer;
    function AllocateIndex(ABitmap: TBitmap): Integer;
  public
    constructor CreateSize(AWidth, AHeight: Integer);
    destructor Destroy; override;
    function AddMasked(AImage: TBitmap; AMaskColor: TColor): Integer; reintroduce;
    procedure Delete(AIndex: Integer);
    property Count: Integer read FCount;
  end;

  { TcxButtonGlyph }

  TcxButtonGlyph = class
  private
    FOriginal: TBitmap;
    FGlyphList: TcxGlyphList;
    FIndexs: array[TButtonState] of Integer;
    FTransparentColor: TColor;
    FNumGlyphs: TNumGlyphs;
    FOnChange: TNotifyEvent;
    procedure GlyphChanged(Sender: TObject);
    procedure SetGlyph(Value: TBitmap);
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure Invalidate;
    function CreateButtonGlyph(AState: TcxButtonState): Integer; virtual;
    procedure DrawButtonGlyph(ACanvas: TCanvas; const AGlyphPos: TPoint;
      AState: TcxButtonState);
    procedure DrawButtonText(ACanvas: TCanvas; const ACaption: TCaption;
      ATextBounds: TRect; AState: TcxButtonState{$IFDEF VCL}; ABiDiFlags: LongInt;
      ANativeStyle: Boolean{$IFDEF DELPHI7}; AWordWrap: Boolean{$ENDIF}{$ENDIF});
    procedure CalcButtonLayout(ACanvas: TCanvas; const AClient: TRect;
      const AOffset: TPoint; const ACaption: TCaption; ALayout: TButtonLayout;
      AMargin, ASpacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect
      {$IFDEF VCL}; ABiDiFlags: LongInt{$IFDEF DELPHI7}; AWordWrap: Boolean{$ENDIF}{$ENDIF});
  protected
    function CanWordWrapText{$IFDEF DELPHI7}(AWordWrap: Boolean){$ENDIF}: Boolean;
    function GetTextOffsets(ALayout: TButtonLayout): TRect; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Draw(ACanvas: TCanvas; const AClient: TRect; const AOffset: TPoint;
      const ACaption: TCaption; ALayout: TButtonLayout; AMargin, ASpacing: Integer;
      AState: TcxButtonState {$IFDEF VCL}; ABiDiFlags: LongInt;
      ANativeStyle: Boolean{$IFDEF DELPHI7}; AWordWrap: Boolean{$ENDIF}{$ENDIF});
    property Glyph: TBitmap read FOriginal write SetGlyph;
    property NumGlyphs: TNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TcxButtonGlyphClass = class of TcxButtonGlyph;

  { TcxCustomButton }

  TcxButtonDropDownMenuPopupEvent = procedure(Sender: TObject;
    var APopupMenu: TPopupMenu; var AHandled: Boolean) of object;

  TcxCustomButton = class(TButton, IcxMouseTrackingCaller, IcxLookAndFeelContainer)
  private
    FAutoSize: Boolean;
    FIsDown, FIsDefault: Boolean;
    FCanvas: TcxCanvas;
    FColors: TcxButtonColors;
    FControlCanvas: TControlCanvas;
    FLockDown: Boolean;
{$IFNDEF VCL}
    FClosing: Boolean;
{$ENDIF}
{$IFDEF LINUX}
    FDblClick: Boolean;
{$ENDIF}
    FDoPopup: Boolean;
    FDropDownMenu: TPopupMenu;
    FIsFocused: Boolean;
    FIsMouseClick: Boolean;
    FKind: TcxButtonKind;
    FLookAndFeel: TcxLookAndFeel;
    FPopupAlignment: TPopupAlignment;
    FPopupMenu: TComponent;
    FUseSystemPaint: Boolean; // deprecated

    // glyph support
    FGlyph: TcxButtonGlyph;
    FLayout: TButtonLayout;
    FModifiedGlyph: Boolean;
    FMargin: Integer;
    FMenuVisible: Boolean;
    FMouseInControl: Boolean;
    FSpacing: Integer;
    // events
    FOnDropDownMenuPopup: TcxButtonDropDownMenuPopupEvent;
    FOnGetDrawParams: TcxButtonGetDrawParamsEvent;

    // glyph support
    procedure SetGlyph(Value: TBitmap);
    function GetGlyph: TBitmap;
    function GetNumGlyphs: TNumGlyphs;
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure GlyphChanged(Sender: TObject);
    procedure SetLayout(Value: TButtonLayout);
    procedure SetSpacing(Value: Integer);
    procedure SetMargin(Value: Integer);
{$IFDEF VCL}
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct);
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMCloseupPopupMenu(var Message: TMessage); message CM_CLOSEUPPOPUPMENU;
    procedure CMDropDownPopupMenu(var Message: TMessage); message CM_DROPDOWNPOPUPMENU;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure CNSysKeyDown(var Message: TWMSysKeyDown); message CN_SYSKEYDOWN;
{$ENDIF}
    procedure ExcludeDropDownButtonRect(var R: TRect);
    procedure DoDropDownMenu;
    function GetBorderRect(AState: TcxButtonState): TRect;
    function GetContentRect: TRect;
    function GetDropDownMenuAlignment(APopupPoint: TPoint;
      AEstimatedAlignment: TPopupAlignment): TPopupAlignment;
    function GetDropDownMenuPopupPoint(ADropDownMenu: TPopupMenu): TPoint;
    procedure InternalPaint;
    procedure InternalRecreateWindow;
    function IsColorsStored: Boolean;
    function IsHotTrack: Boolean;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues);
    procedure SetButtonAutoSize(Value: Boolean);
    procedure SetColors(const Value: TcxButtonColors);
    procedure SetKind(const Value: TcxButtonKind);
    procedure SetLookAndFeel(Value: TcxLookAndFeel);
    procedure SetPopupMenu(Value: TComponent);
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  {$IFDEF VCL}
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DestroyWindowHandle; override;
    function GetPalette: HPALETTE; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetButtonStyle(ADefault: Boolean); override;
  {$ELSE}
    procedure EnabledChanged; override;
    procedure FontChanged; override;
    procedure InitWidget; override;
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
    function NeedKey(Key: Integer; Shift: TShiftState;
      const KeyText: WideString): Boolean; override;
    procedure Painting(Sender: QObjectH; EventRegion: QRegionH); override;
    function WidgetFlags: Integer; override;
  {$ENDIF}
    procedure DoContextPopup({$IFNDEF VCL}const {$ENDIF}MousePos: TPoint;
      var Handled: Boolean); {$IFNDEF DELPHI5}virtual{$ELSE}override{$ENDIF};
    function DoOnDropDownMenuPopup(var APopupMenu: TPopupMenu): Boolean; virtual;
    function DoShowPopupMenu(APopupMenu: TComponent;
      X, Y: Integer): Boolean; virtual;
    function GetGlyphClass: TcxButtonGlyphClass; virtual;
    function GetPainterClass: TcxCustomLookAndFeelPainterClass; virtual;
    function StandardButton: Boolean; virtual;
    procedure UpdateSize;

    //IcxMouseTrackingCaller
    procedure IcxMouseTrackingCaller.MouseLeave = ButtonMouseLeave;
    procedure ButtonMouseLeave;

    // IcxLookAndFeelContainer
    function GetLookAndFeel: TcxLookAndFeel;

    property AutoSize: Boolean read FAutoSize write SetButtonAutoSize default False;
    property Colors: TcxButtonColors read FColors write SetColors stored IsColorsStored;
    property DropDownMenu: TPopupMenu read FDropDownMenu write FDropDownMenu;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Kind: TcxButtonKind read FKind write SetKind default cxbkStandard;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read FMargin write SetMargin default -1;
    property NumGlyphs: TNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property PopupAlignment: TPopupAlignment read FPopupAlignment
      write FPopupAlignment default paLeft;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property UseSystemPaint: Boolean read FUseSystemPaint
      write FUseSystemPaint default False; // deprecated
    property OnDropDownMenuPopup: TcxButtonDropDownMenuPopupEvent
      read FOnDropDownMenuPopup write FOnDropDownMenuPopup;
    property OnGetDrawParams: TcxButtonGetDrawParamsEvent
      read FOnGetDrawParams write FOnGetDrawParams;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    function GetOptimalSize: TSize; virtual;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel write SetLookAndFeel;
  published
    property PopupMenu: TComponent read FPopupMenu write SetPopupMenu;
  end;

  { TcxButton }

  TcxButton = class(TcxCustomButton)
  published
//    property AutoSize;
    property Action;
    property Anchors;
    property BiDiMode;
    property Cancel;
    property Caption;
    property Colors;
    property Constraints;
    property Default;
    property DropDownMenu;
    property Enabled;
    property Glyph;
    property Kind;
    property Layout;
    property LookAndFeel;
    property Margin;
    property ModalResult;
    property NumGlyphs;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupAlignment;
    property ShowHint;
    property Spacing;
    property TabOrder;
    property TabStop;
    property UseSystemPaint; // deprecated
    property Visible;
    property OnDropDownMenuPopup;
    property OnEnter;
    property OnExit;
    property OnGetDrawParams;
  end;

function GetButtonPainterClass(ALookAndFeel: TcxLookAndFeel): TcxCustomLookAndFeelPainterClass;

implementation

uses
{$IFDEF VCL}
  dxUxTheme, CommCtrl, dxThemeConsts,
{$ENDIF}
  cxClasses, cxGeometry, SysUtils, Consts, Dialogs, ActnList, ImgList;

const
  EmptyPoint: TPoint = (X: 0; Y: 0);
  EmptyRect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
  cxBtnStdVertTextOffsetCorrection = -1;
  TextRectCorrection: TRect = (Left: 1; Top: 0; Right: 2; Bottom: 0);

function GetButtonPainterClass(ALookAndFeel: TcxLookAndFeel): TcxCustomLookAndFeelPainterClass;
begin
  if ALookAndFeel.SkinPainter <> nil then
    Result := ALookAndFeel.SkinPainter
  else
  begin
    Result := ALookAndFeel.Painter;
    if Result.LookAndFeelStyle = lfsOffice11 then
      if AreVisualStylesAvailable(totButton) then
        Result := TcxWinXPLookAndFeelPainter
      else
        Result := TcxStandardLookAndFeelPainter;
  end;      
end;

{ TcxButtonColors }

constructor TcxButtonColors.Create(AOwner: TcxCustomButton);
var
  AState: TcxButtonState;
begin
  inherited Create;
  FButton := AOwner;
  for AState := cxbsDefault to cxbsDisabled do
    FColors[AState] := clDefault;
end;

function TcxButtonColors.GetBackgroundColor(AState: TcxButtonState): TColor;
begin
  if AState in AssignedColors then
    Result := FColors[AState]
  else
    if AState = cxbsNormal then
      Result := FColors[cxbsDefault]
    else
      Result := FColors[cxbsNormal];
end;

function TcxButtonColors.GetColor(const Index: Integer): TColor;
begin
  Result := FColors[TcxButtonState(Index)];
end;

function TcxButtonColors.IsStored(const Index: Integer): Boolean;
begin
  Result := TcxButtonState(Index) in FAssignedColors;
end;

procedure TcxButtonColors.SetAssignedColors(
  Value: TcxButtonAssignedColors);
var
  AState: TcxButtonState;
begin
  if (FAssignedColors <> Value) and (csDesigning in FButton.ComponentState) then
  begin
    for AState := cxbsDefault to cxbsDisabled do
      if not (AState in Value) then
        FColors[AState] := clDefault
      else
        if FColors[AState] = clDefault then Exclude(Value, AState);
    FAssignedColors := Value;
    FButton.Invalidate;
  end;
end;

procedure TcxButtonColors.SetColor(const Index: Integer;
  const Value: TColor);
begin
  if (Value = clNone) or (Value = clDefault) then
  begin
    FColors[TcxButtonState(Index)] := clDefault;
    Exclude(FAssignedColors, TcxButtonState(Index));
    FButton.Invalidate;
  end
  else if GetColor(Index) <> Value then
  begin
    FColors[TcxButtonState(Index)] := Value;
    Include(FAssignedColors, TcxButtonState(Index));
    FButton.Invalidate;
  end;
end;

procedure TcxButtonColors.Assign(Source: TPersistent);
begin
  if Source is TcxButtonColors then
    with TcxButtonColors(Source) do
    begin
      Self.FColors := FColors;
      Self.FAssignedColors := FAssignedColors;
      Self.FButton.Invalidate;
    end
    else
      inherited Assign(Source);
end;

{ TcxGlyphList }

constructor TcxGlyphList.CreateSize(AWidth, AHeight: Integer);
begin
  inherited CreateSize(AWidth, AHeight);
  FUsed := TBits.Create;
end;

destructor TcxGlyphList.Destroy;
begin
  FUsed.Free;
  inherited Destroy;
end;

function TcxGlyphList.AllocateIndex(ABitmap: TBitmap): Integer;
begin
  Result := FUsed.OpenBit;
  if Result >= FUsed.Size then
  begin
    Result := inherited Add(ABitmap, nil);
    FUsed.Size := Result + 1;
  end;
  FUsed[Result] := True;
end;

function TcxGlyphList.AddMasked(AImage: TBitmap; AMaskColor: TColor): Integer;
begin
  Result := AllocateIndex(AImage);
  ReplaceMasked(Result, AImage, AMaskColor);
  Inc(FCount);
end;

procedure TcxGlyphList.Delete(AIndex: Integer);
begin
  if FUsed[AIndex] then
  begin
    Dec(FCount);
    FUsed[AIndex] := False;
  end;
end;

{$IFNDEF VCL}

  { TcxObjectEventFilter }

  TcxObjectEventFilter = class
  private
    FObjectHook: QObject_hookH;
    function ObjectHookProc(Sender: QObjectH; Event: QEventH): Boolean; cdecl;
  public
    constructor Create(AObject: QObjectH);
    destructor Destroy; override;
  end;

var
  FObjectEventFilter: TcxObjectEventFilter;
  FCurrentMenuButton: TcxCustomButton = nil;
  FCurrentMenuHandle: QWidgetH = nil;

constructor TcxObjectEventFilter.Create(AObject: QObjectH);
var
  Method: TMethod;
begin
  inherited Create;
  FObjectHook := QObject_hook_create(AObject);
  TEventFilterMethod(Method) := ObjectHookProc;
  Qt_hook_hook_events(FObjectHook, Method);
end;

destructor TcxObjectEventFilter.Destroy;
begin
  QObject_hook_destroy(FObjectHook);
  inherited Destroy;
end;

function TcxObjectEventFilter.ObjectHookProc(Sender: QObjectH; Event: QEventH): Boolean; cdecl;
var
  AMouseEvent: QMouseEventH;
  PP: PPoint;
{$IFDEF LINUX}
  AControl: TWidgetControl;
{$ENDIF}
begin
  Result := False;
  case QEvent_type(Event) of
  {$IFDEF LINUX}
    QEventType_MouseButtonDblClick:
      begin
        if FCurrentMenuButton <> nil then
        begin
          FCurrentMenuButton.FDblClick := True;
          Result := True;
        end
        else
        begin
          AControl := FindControl(QWidgetH(Sender));
          Result := AControl is TcxCustomButton;
          if Result then
            with TcxCustomButton(AControl) do
              Result := (Kind <> cxbkStandard) and not (csDesigning in ComponentState);
        end;
      end;
  {$ENDIF}
    QEventType_MouseButtonPress:
      begin
        if not ((FCurrentMenuButton <> nil) and (QWidgetH(Sender) = FCurrentMenuHandle)) then
          Exit;
      {$IFDEF LINUX}
        FCurrentMenuButton.FDblClick := False;
      {$ENDIF}
        AMouseEvent := QMouseEventH(Event);
        PP := QMouseEvent_globalPos(AMouseEvent);
        FCurrentMenuButton.FClosing :=
          QApplication_widgetAt(PP, True) = FCurrentMenuButton.Handle;
      end;
    end;
end;

{$ENDIF}

{$IFDEF VCL}
type
  { TcxGlyphCache }

  TcxGlyphCache = class
  private
    FGlyphLists: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetList(AWidth, AHeight: Integer): TcxGlyphList;
    procedure ReturnList(AList: TcxGlyphList);
    function Empty: Boolean;
  end;

{ TcxGlyphCache }

constructor TcxGlyphCache.Create;
begin
  inherited Create;
  FGlyphLists := TList.Create;
end;

destructor TcxGlyphCache.Destroy;
begin
  FGlyphLists.Free;
  inherited Destroy;
end;

function TcxGlyphCache.GetList(AWidth, AHeight: Integer): TcxGlyphList;
var
  I: Integer;
begin
  for I := FGlyphLists.Count - 1 downto 0 do
  begin
    Result := TcxGlyphList(FGlyphLists[I]);
    with Result do
      if (AWidth = Width) and (AHeight = Height) then Exit;
  end;
  Result := TcxGlyphList.CreateSize(AWidth, AHeight);
  FGlyphLists.Add(Result);
end;

procedure TcxGlyphCache.ReturnList(AList: TcxGlyphList);
begin
  if AList = nil then Exit;
  if AList.Count = 0 then
  begin
    FGlyphLists.Remove(AList);
    AList.Free;
  end;
end;

function TcxGlyphCache.Empty: Boolean;
begin
  Result := FGlyphLists.Count = 0;
end;

var
  GlyphCache: TcxGlyphCache = nil;
{$ENDIF}

{ TcxButtonGlyph }

constructor TcxButtonGlyph.Create;
var
  I: TButtonState;
begin
  inherited Create;
  FOriginal := TBitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FTransparentColor := clOlive;
  FNumGlyphs := 1;
  for I := Low(I) to High(I) do
    FIndexs[I] := -1;
{$IFDEF VCL}
  if GlyphCache = nil then GlyphCache := TcxGlyphCache.Create;
{$ENDIF}
end;

destructor TcxButtonGlyph.Destroy;
begin
  FOriginal.Free;
  Invalidate;
{$IFDEF VCL}
  if Assigned(GlyphCache) and GlyphCache.Empty then
  begin
    GlyphCache.Free;
    GlyphCache := nil;
  end;
{$ENDIF}
  inherited Destroy;
end;

procedure TcxButtonGlyph.Invalidate;
var
  I: TButtonState;
begin
  for I := Low(I) to High(I) do
  begin
    if FIndexs[I] <> -1 then FGlyphList.Delete(FIndexs[I]);
    FIndexs[I] := -1;
  end;
{$IFDEF VCL}
  GlyphCache.ReturnList(FGlyphList);
  FGlyphList := nil;
{$ELSE}
  FreeAndNil(FGlyphList);
{$ENDIF}
end;

procedure TcxButtonGlyph.GlyphChanged(Sender: TObject);
begin
  if Sender = FOriginal then
  begin
    FTransparentColor := FOriginal.TransparentColor;
    Invalidate;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TcxButtonGlyph.SetGlyph(Value: TBitmap);
var
  Glyphs: Integer;
begin
  Invalidate;
  FOriginal.Assign(Value);
  if Value = nil then
  begin
    FOriginal.Width := 0;
    FOriginal.Height := 0;
  end
  else
    if Value.Height > 0 then
    begin
      FTransparentColor := Value.TransparentColor;
      if Value.Width mod Value.Height = 0 then
      begin
        Glyphs := Value.Width div Value.Height;
        if Glyphs > 4 then Glyphs := 1;
        SetNumGlyphs(Glyphs);
      end;
    end;
end;

procedure TcxButtonGlyph.SetNumGlyphs(Value: TNumGlyphs);
begin
  if (Value <> FNumGlyphs) and (Value > 0) then
  begin
    Invalidate;
    FNumGlyphs := Value;
    GlyphChanged(Glyph);
  end;
end;

function TcxButtonGlyph.CreateButtonGlyph(AState: TcxButtonState): Integer;

  function GetStandardButtonState(AState: TcxButtonState): TButtonState;
  const
    States: array[TcxButtonState] of TButtonState =
    //cxbsDefault, cxbsNormal, cxbsHot, cxbsPressed, cxbsDisabled;
      (bsUp, bsUp, bsUp, bsDown, bsDisabled);
  begin
    Result := States[AState];
    if (Result = bsDown) and (NumGlyphs < 3) then
      Result := bsUp;
  end;

  function InternalCreateButtonGlyph(AStandardButtonState: TButtonState): Integer;

    function GetGlyphList(AWidth, AHeight: Integer): TcxGlyphList;
    begin
      if FGlyphList = nil then
      begin
        if GlyphCache = nil then
          GlyphCache := TcxGlyphCache.Create;
        FGlyphList := GlyphCache.GetList(AWidth, AHeight);
      end;
      Result := FGlyphList;
    end;

  var
    ATempImage: TBitmap;
    AWidth, AHeight: Integer;
    ADestRect, ASrcRect: TRect;
    AOffset: Integer;
    AGlyphList: TcxGlyphList;
  begin
    FOriginal.Handle; //HandleNeeded
    AWidth := FOriginal.Width div FNumGlyphs;
    AHeight := FOriginal.Height;
    ADestRect := Rect(0, 0, AWidth, AHeight);
    AOffset := Ord(AStandardButtonState);
    if AOffset >= NumGlyphs then
      AOffset := 0;
    ASrcRect := cxRectOffset(ADestRect, AOffset * AWidth, 0);

    AGlyphList := GetGlyphList(AWidth, AHeight);
    ATempImage := cxCreateBitmap(AWidth, AHeight, pfDevice);
    try
      ATempImage.Canvas.Brush.Color := FTransparentColor;
      ATempImage.Palette := CopyPalette(FOriginal.Palette);

      if (AStandardButtonState = bsDisabled) and (NumGlyphs = 1) then
      begin
        ATempImage.Canvas.FillRect(ADestRect);
        ADestRect := Rect(-AOffset * AWidth, 0, AWidth, AHeight);
        cxDrawImage(ATempImage.Canvas.Handle, ADestRect, ADestRect, FOriginal, nil, -1, idmDisabled, False, 0, FTransparentColor, False);
      end
      else
        ATempImage.Canvas.CopyRect(ADestRect, FOriginal.Canvas, ASrcRect);

      if FOriginal.TransparentMode = tmFixed then
        FIndexs[AStandardButtonState] := AGlyphList.AddMasked(ATempImage, FTransparentColor)
      else
        FIndexs[AStandardButtonState] := AGlyphList.AddMasked(ATempImage, clDefault);
    finally
      ATempImage.Free;
    end;
    Result := FIndexs[AStandardButtonState];
    FOriginal.Dormant;
  end;

  function GetGlyphIndex(AStandardButtonState: TButtonState): Integer;
  begin
    Result := FIndexs[AStandardButtonState];
    if (Result = -1) and ((FOriginal.Width or FOriginal.Height) <> 0) then
      Result := InternalCreateButtonGlyph(AStandardButtonState);
  end;

begin
  Result := GetGlyphIndex(GetStandardButtonState(AState));
end;

procedure TcxButtonGlyph.DrawButtonGlyph(ACanvas: TCanvas; const AGlyphPos: TPoint;
  AState: TcxButtonState);
var
  AIndex: Integer;
begin
  if (FOriginal = nil) or (FOriginal.Width = 0) or (FOriginal.Height = 0) then
    Exit;
  AIndex := CreateButtonGlyph(AState);
{$IFDEF VCL}
  ImageList_DrawEx(FGlyphList.Handle, AIndex, ACanvas.Handle,
    AGlyphPos.X, AGlyphPos.Y, 0, 0, clNone, clNone, ILD_Transparent);
{$ELSE}
  FGlyphList.Draw(ACanvas, AGlyphPos.X, AGlyphPos.Y, AIndex, itImage, True);
{$ENDIF}
end;

procedure TcxButtonGlyph.DrawButtonText(ACanvas: TCanvas; const ACaption: TCaption;
  ATextBounds: TRect; AState: TcxButtonState {$IFDEF VCL}; ABiDiFlags: LongInt;
  ANativeStyle: Boolean{$IFDEF DELPHI7}; AWordWrap: Boolean{$ENDIF}{$ENDIF});

{$IFDEF VCL}
  procedure InternalDrawButtonText;
  var
    ADrawTextFlags: Integer;
  begin
    ADrawTextFlags := DT_CENTER or DT_VCENTER or ABiDiFlags;
    if CanWordWrapText{$IFDEF DELPHI7}(AWordWrap){$ENDIF} then
      ADrawTextFlags := ADrawTextFlags or DT_WORDBREAK;
    DrawText(ACanvas.Handle, PChar(ACaption),
      Length(ACaption), ATextBounds, ADrawTextFlags);
  end;
{$ELSE}
  procedure InternalDrawButtonText;
  begin
    ACanvas.TextRect(ATextBounds, ATextBounds.Left, ATextBounds.Top, ACaption,
      Integer(AlignmentFlags_ShowPrefix));
  end;
{$ENDIF}

var
  ABrushStyle: TBrushStyle;
  AFontColor: TColor;
begin
  if Length(ACaption) = 0 then Exit;
  ABrushStyle := ACanvas.Brush.Style;
  try
    ACanvas.Brush.Style := bsClear;
    if AState = cxbsDisabled then
    begin
      OffsetRect(ATextBounds, 1, 1);
      AFontColor := ACanvas.Font.Color;
      ACanvas.Font.Color := clBtnHighlight;
      InternalDrawButtonText;
      OffsetRect(ATextBounds, -1, -1);
      ACanvas.Font.Color := AFontColor;
    end;
    InternalDrawButtonText;
  finally
    ACanvas.Brush.Style := ABrushStyle;
  end;
end;

procedure TcxButtonGlyph.CalcButtonLayout(ACanvas: TCanvas; const AClient: TRect;
  const AOffset: TPoint; const ACaption: TCaption; ALayout: TButtonLayout;
  AMargin, ASpacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect
  {$IFDEF VCL}; ABiDiFlags: LongInt{$IFDEF DELPHI7}; AWordWrap: Boolean{$ENDIF}{$ENDIF});

  procedure CheckLayout;
  begin
{$IFDEF VCL}
    if ABiDiFlags and DT_RIGHT = DT_RIGHT then
    begin
      if ALayout = blGlyphLeft then
        ALayout := blGlyphRight
      else
        if ALayout = blGlyphRight then
          ALayout := blGlyphLeft;
    end;
{$ENDIF}
  end;

  function GetCaptionSize: TPoint;
  var
    ADrawTextFlags: Integer;
    ATextOffsets: TRect;
  begin
    if Length(ACaption) = 0 then
    begin
      TextBounds := EmptyRect;
      Result := EmptyPoint;
    end
    else
    begin
      TextBounds := Rect(0, 0, AClient.Right - AClient.Left, 0);
      ATextOffsets := GetTextOffsets(ALayout);
      ExtendRect(TextBounds, ATextOffsets);
      ADrawTextFlags := DT_CALCRECT or ABiDiFlags;
      if CanWordWrapText{$IFDEF DELPHI7}(AWordWrap){$ENDIF} then
        ADrawTextFlags := ADrawTextFlags or DT_WORDBREAK;
      DrawText(ACanvas.Handle, PChar(ACaption),
        Length(ACaption), TextBounds, ADrawTextFlags);
      with TextBounds do
        Result := Point(Right - Left, Bottom - Top);
      Inc(Result.X, ATextOffsets.Left + ATextOffsets.Right);
      Inc(Result.Y, ATextOffsets.Top + ATextOffsets.Bottom);
    end;
  end;

var
  ATextPos: TPoint;
  AClientSize, AGlyphSize, ATextSize: TPoint;
  ATotalSize: TPoint;
begin
  CheckLayout;
  ATextSize := GetCaptionSize;
  with AClient do
    AClientSize := Point(Right - Left, Bottom - Top);

(*  if FOriginal.Empty then
  begin
    GlyphPos := EmptyPoint;
    ATextPos.X := (AClientSize.X - ATextSize.X) div 2;
    ATextPos.Y := (AClientSize.Y - ATextSize.Y - 1) div 2;
    OffsetRect(TextBounds, ATextPos.X + AOffset.X, ATextPos.Y + AOffset.Y);
    Exit;
  end;*)

  if FOriginal <> nil then
  begin
    AGlyphSize := Point(FOriginal.Width div FNumGlyphs, FOriginal.Height);
    if ALayout in [blGlyphLeft, blGlyphRight] then
    begin
      GlyphPos.Y := (AClientSize.Y - AGlyphSize.Y) div 2;
      ATextPos.Y := (AClientSize.Y - ATextSize.Y +
        cxBtnStdVertTextOffsetCorrection) div 2;
    end
    else
    begin
      GlyphPos.X := (AClientSize.X - AGlyphSize.X) div 2;
      ATextPos.X := (AClientSize.X - ATextSize.X) div 2;
    end;
  end
  else
    AGlyphSize := EmptyPoint;

  if (ATextSize.X = 0) or (AGlyphSize.X = 0) then ASpacing := 0;

  if AMargin = -1 then
  begin
    if ASpacing = -1 then
    begin
      ATotalSize := Point(AGlyphSize.X + ATextSize.X, AGlyphSize.Y + ATextSize.Y);
      if ALayout in [blGlyphLeft, blGlyphRight] then
        AMargin := (AClientSize.X - ATotalSize.X) div 3
      else
        AMargin := (AClientSize.Y - ATotalSize.Y) div 3;
      ASpacing := AMargin;
    end
    else
    begin
      ATotalSize := Point(AGlyphSize.X + ASpacing + ATextSize.X, AGlyphSize.Y +
        ASpacing + ATextSize.Y);
      if ALayout in [blGlyphLeft, blGlyphRight] then
        AMargin := (AClientSize.X - ATotalSize.X) div 2
      else
        AMargin := (AClientSize.Y - ATotalSize.Y) div 2;
    end;
  end
  else
  begin
    if ASpacing = -1 then
    begin
      ATotalSize := Point(AClientSize.X - (AMargin + AGlyphSize.X),
        AClientSize.Y - (AMargin + AGlyphSize.Y));
      if ALayout in [blGlyphLeft, blGlyphRight] then
        ASpacing := (ATotalSize.X - ATextSize.X) div 2
      else
        ASpacing := (ATotalSize.Y - ATextSize.Y) div 2;
    end;
  end;
  case ALayout of
    blGlyphLeft:
      begin
        GlyphPos.X := AMargin;
        ATextPos.X := GlyphPos.X + AGlyphSize.X + ASpacing;
      end;
    blGlyphRight:
      begin
        GlyphPos.X := AClientSize.X - AMargin - AGlyphSize.X;
        ATextPos.X := GlyphPos.X - ASpacing - ATextSize.X;
      end;
    blGlyphTop:
      begin
        GlyphPos.Y := AMargin;
        ATextPos.Y := GlyphPos.Y + AGlyphSize.Y + ASpacing;
      end;
    blGlyphBottom:
      begin
        GlyphPos.Y := AClientSize.Y - AMargin - AGlyphSize.Y;
        ATextPos.Y := GlyphPos.Y - ASpacing - ATextSize.Y;
      end;
  end;
  with GlyphPos do
  begin
    Inc(X, AClient.Left + AOffset.X);
    Inc(Y, AClient.Top + AOffset.Y);
  end;
  OffsetRect(TextBounds, AClient.Left + ATextPos.X + AOffset.X, AClient.Top + ATextPos.Y + AOffset.X);
end;

procedure TcxButtonGlyph.Draw(ACanvas: TCanvas; const AClient: TRect;
  const AOffset: TPoint; const ACaption: TCaption; ALayout: TButtonLayout;
  AMargin, ASpacing: Integer; AState: TcxButtonState
  {$IFDEF VCL}; ABiDiFlags: LongInt; ANativeStyle: Boolean{$IFDEF DELPHI7}; AWordWrap: Boolean{$ENDIF}{$ENDIF});
var
  AGlyphPos: TPoint;
  ATextRect: TRect;
begin
  CalcButtonLayout(ACanvas, AClient, AOffset, ACaption, ALayout, AMargin,
    ASpacing, AGlyphPos, ATextRect{$IFDEF VCL}, ABiDiFlags{$IFDEF DELPHI7}, AWordWrap{$ENDIF}{$ENDIF});
  DrawButtonGlyph(ACanvas, AGlyphPos, AState);
  DrawButtonText(ACanvas, ACaption, ATextRect, AState{$IFDEF VCL}, ABiDiFlags,
    ANativeStyle{$IFDEF DELPHI7}, AWordWrap{$ENDIF}{$ENDIF});
end;

function TcxButtonGlyph.CanWordWrapText{$IFDEF DELPHI7}(AWordWrap: Boolean){$ENDIF}: Boolean;
begin
{$IFDEF DELPHI7}
  Result := AWordWrap and ((FOriginal = nil) or (FOriginal.Width = 0) or (FOriginal.Height = 0));
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TcxButtonGlyph.GetTextOffsets(ALayout: TButtonLayout): TRect;
begin
  if (FOriginal.Width > 0) and (FOriginal.Height > 0) then
    Result := cxEmptyRect
  else
    Result := TextRectCorrection;
end;

{ TcxCustomButton }

constructor TcxCustomButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGlyph := GetGlyphClass.Create;
  FGlyph.OnChange := GlyphChanged;
  FColors := TcxButtonColors.Create(Self);
  FControlCanvas := TControlCanvas.Create;
  FControlCanvas.Control := Self;
  FCanvas := TcxCanvas.Create(TCanvas(FControlCanvas));
  FLookAndFeel := TcxLookAndFeel.Create(Self);
  FLookAndFeel.OnChanged := LookAndFeelChanged;
  FDoPopup := True;
  FKind := cxbkStandard;
  FLayout := blGlyphLeft;
  FPopupAlignment := paLeft;
  FSpacing := 4;
  FMargin := -1;
{$IFDEF VCL}
  DoubleBuffered := True;
  ControlStyle := ControlStyle + [csReflector, csOpaque];
{$ELSE}
  ControlStyle := ControlStyle + [csOpaque];
{$ENDIF}
end;

destructor TcxCustomButton.Destroy;
begin
{$IFDEF VCL}
  EndMouseTracking(Self);
{$ENDIF}
  FreeAndNil(FLookAndFeel);
  FreeAndNil(FColors);
  inherited Destroy;
  FGlyph.Free;
  FreeAndNil(FCanvas);
  FreeAndNil(FControlCanvas);
end;

procedure TcxCustomButton.SetGlyph(Value: TBitmap);
begin
  FGlyph.Glyph := Value as TBitmap;
  FModifiedGlyph := True;
  Invalidate;
end;

function TcxCustomButton.GetGlyph: TBitmap;
begin
  Result := FGlyph.Glyph;
end;

procedure TcxCustomButton.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TcxCustomButton.SetLayout(Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

function TcxCustomButton.GetNumGlyphs: TNumGlyphs;
begin
  Result := FGlyph.NumGlyphs;
end;

procedure TcxCustomButton.SetNumGlyphs(Value: TNumGlyphs);
begin
  if Value < 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> FGlyph.NumGlyphs then
  begin
    FGlyph.NumGlyphs := Value;
    Invalidate;
  end;
end;

procedure TcxCustomButton.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TcxCustomButton.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= - 1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TcxCustomButton.DoContextPopup({$IFNDEF VCL}const {$ENDIF}MousePos: TPoint;
  var Handled: Boolean);
var
  P: TPoint;
begin
{$IFDEF DELPHI5}
  inherited DoContextPopup(MousePos, Handled);
{$ENDIF}
  if not Handled then
  begin
    if (MousePos.X = -1) and (MousePos.Y = -1) then
      P := ClientToScreen(Point(0, 0))
    else
      P := ClientToScreen(MousePos);
    Handled := DoShowPopupMenu(PopupMenu, P.X, P.Y);
  end;
end;

function TcxCustomButton.DoOnDropDownMenuPopup(var APopupMenu: TPopupMenu): Boolean;
begin
  Result := False;
  if Assigned(FOnDropDownMenuPopup) then
    FOnDropDownMenuPopup(Self, APopupMenu, Result);
end;

function TcxCustomButton.DoShowPopupMenu(APopupMenu: TComponent;
  X, Y: Integer): Boolean;
begin
  Result := ShowPopupMenu(Self, APopupMenu, X, Y);
end;

function TcxCustomButton.GetGlyphClass: TcxButtonGlyphClass;
begin
  Result := TcxButtonGlyph;
end;

function TcxCustomButton.GetPainterClass: TcxCustomLookAndFeelPainterClass;
begin
  Result := GetButtonPainterClass(LookAndFeel);
end;

function TcxCustomButton.StandardButton: Boolean;
begin
  Result := False;
end;

procedure TcxCustomButton.UpdateSize;
var
  ASize: TSize;
begin
  if AutoSize then
  begin
    if csLoading in ComponentState then
      ASize := GetOptimalSize
    else
      ASize := Size(0, 0);
    SetBounds(Self.Left, Self.Top, ASize.cx, ASize.cy);
  end;
end;

//IcxMouseTrackingCaller
procedure TcxCustomButton.ButtonMouseLeave;
begin
{$IFDEF VCL}
  Perform(CM_MOUSELEAVE, 0, 0);
{$ELSE}
  MouseLeave(Self);
{$ENDIF}
end;

// IcxLookAndFeelContainer
function TcxCustomButton.GetLookAndFeel: TcxLookAndFeel;
begin
  Result := LookAndFeel;
end;

procedure TcxCustomButton.Click;
begin
  if FKind = cxbkStandard then
    inherited Click
  else
  begin
  {$IFDEF LINUX}
    if FDblClick then
    begin
      FDblClick := False;
      Exit;
    end;
  {$ENDIF}
    if (FKind = cxbkDropDown) and not FMenuVisible then
    begin
      if not FIsMouseClick then DoDropDownMenu;
      FIsMouseClick := False;
    end
    else
      if FIsMouseClick then FIsMouseClick := False else inherited Click;
  end;
end;

function TcxCustomButton.GetOptimalSize: TSize;
var
  ACanvas: TcxScreenCanvas;
  ACaption: TCaption;
begin
  ACanvas := TcxScreenCanvas.Create;
  try
    ACanvas.Font := Font;
    ACaption := RemoveAccelChars(Caption);
    if ACaption = '' then
      ACaption := ' ';
    Result.cx := ACanvas.TextWidth(ACaption) + ACanvas.TextWidth('R') * 3;
    Result.cy := MulDiv(ACanvas.TextHeight('Wg'), 14, 8);
  finally
    ACanvas.Free;
  end;
end;

procedure TcxCustomButton.LookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  if UseSystemPaint then
    InternalRecreateWindow
  else
    Invalidate;
end;

procedure TcxCustomButton.SetButtonAutoSize(Value: Boolean);
begin
  if Value <> FAutoSize then
  begin
    FAutoSize := Value;
    UpdateSize;
  end;
end;

procedure TcxCustomButton.SetColors(const Value: TcxButtonColors);
begin
  FColors.Assign(Value);
end;

procedure TcxCustomButton.SetKind(const Value: TcxButtonKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    InternalRecreateWindow;
  end
end;

procedure TcxCustomButton.SetLookAndFeel(Value: TcxLookAndFeel);
begin
  FLookAndFeel.Assign(Value);
end;

procedure TcxCustomButton.SetPopupMenu(Value: TComponent);
var
  AIPopupMenu: IcxPopupMenu;
begin
  if (Value <> nil) and not((Value is TPopupMenu) or
  {$IFNDEF DELPHI6}
    Value.GetInterface(IcxPopupMenu, AIPopupMenu)) then
  {$ELSE}
    Supports(Value, IcxPopupMenu, AIPopupMenu)) then
  {$ENDIF}
      Value := nil;
  if FPopupMenu <> Value then
  begin
    {$IFDEF DELPHI5}
    if FPopupMenu <> nil then
      FPopupMenu.RemoveFreeNotification(Self);
    {$ENDIF}  
    FPopupMenu := Value;
    if FPopupMenu <> nil then
      FPopupMenu.FreeNotification(Self);
  end;
end;

procedure TcxCustomButton.ExcludeDropDownButtonRect(var R: TRect);
begin
  if Kind = cxbkDropDownButton then
    R.Right := R.Right - cxDropDownButtonWidth + 2;
end;

procedure TcxCustomButton.CMTextChanged(var Message: TMessage);
begin
  inherited;
  UpdateSize;
end;

procedure TcxCustomButton.DoDropDownMenu;
begin
  FLockDown := True;
  PostMessage(Handle, CM_DROPDOWNPOPUPMENU, 0, 0);
end;

function TcxCustomButton.GetBorderRect(AState: TcxButtonState): TRect;
var
  ABorderSize: Integer;
begin
  Result := ClientRect;
  ABorderSize := GetPainterClass.ButtonBorderSize(AState);
  InflateRect(Result, -ABorderSize, -ABorderSize);
  ExcludeDropDownButtonRect(Result);
end;

function TcxCustomButton.GetContentRect: TRect;
begin
  Result := GetBorderRect(cxbsDefault)
end;

function TcxCustomButton.GetDropDownMenuAlignment(APopupPoint: TPoint;
  AEstimatedAlignment: TPopupAlignment): TPopupAlignment;
var
  ADesktopWorkArea: TRect;
begin
  Result := AEstimatedAlignment;
  ADesktopWorkArea := GetDesktopWorkArea(APopupPoint);
  if APopupPoint.X <= ADesktopWorkArea.Left then
    Result := paRight
  else
    if APopupPoint.X >= ADesktopWorkArea.Right then
      Result := paLeft;
end;

function TcxCustomButton.GetDropDownMenuPopupPoint(ADropDownMenu: TPopupMenu): TPoint;
var
  H: Integer;
begin
    Result := Point(0, Height);
    case FPopupAlignment of
      paLeft:
        Result.X := 0;
      paRight:
        Result.X := Width;
      paCenter:
        Result.X := Width shr 1;
    end;
    Result := ClientToScreen(Result);
    H := GetPopupMenuHeight(ADropDownMenu);
    if Result.Y + H > GetDesktopWorkArea(Result).Bottom then
      Dec(Result.Y, Height + H + 2);
end;

procedure TcxCustomButton.InternalPaint;
var
  APrevClipRgn: TcxRegion;
  AColor: TColor;
  AOffset: TPoint;
  AShift: Integer;
  AState: TcxButtonState;
  ATempRect, R: TRect;
  ATheme: TTheme;
begin
  if StandardButton then
    Exit;

  R := ClientRect;
  if GetPainterClass = TcxWinXPLookAndFeelPainter then
  begin
    ATheme := OpenTheme(totButton);
    if (ATheme <> TC_NONE) and IsThemeBackgroundPartiallyTransparent(ATheme, BP_PUSHBUTTON, PBS_NORMAL) then
      cxDrawThemeParentBackground(Self, FCanvas, R);
  end
  else
    if LookAndFeel.SkinPainter <> nil then
      cxDrawTransparentControlBackground(Self, FCanvas, R);

  case FKind of
    cxbkDropDown:
      FIsDown := FMenuVisible;
    cxbkDropDownButton:
      begin
        ATempRect := Rect(R.Right - cxDropDownButtonWidth, R.Top, R.Right, R.Bottom);
        ExcludeDropDownButtonRect(R);
        if FLockDown then
          FIsDown := False;
      end;
  end;

  if not Enabled then AState := cxbsDisabled
  else if FIsDown or FMenuVisible then AState := cxbsPressed
  else if FMouseInControl then AState := cxbsHot
  else if FIsDefault or FIsFocused then AState := cxbsDefault
  else AState := cxbsNormal;

  FCanvas.Font.Assign(Font);
  AColor := FColors.GetBackgroundColor(AState);
  FCanvas.Font.Color := GetPainterClass.ButtonSymbolColor(AState, FCanvas.Font.Color);
  if Assigned(FOnGetDrawParams) then
    FOnGetDrawParams(Self, AState, AColor, FCanvas.Font);

  GetPainterClass.DrawButton(FCanvas, R, '', AState, True, AColor, FCanvas.Font.Color);

  AShift := GetPainterClass.ButtonTextShift;
  if (AState = cxbsPressed) and (AShift <> 0) then
    AOffset := Point(AShift, AShift)
  else
    AOffset := EmptyPoint;

  APrevClipRgn := FCanvas.GetClipRegion;
  try
    FCanvas.SetClipRegion(TcxRegion.Create(GetBorderRect(AState)), roSet);
    FGlyph.Draw(TCanvas(FControlCanvas), GetContentRect, AOffset, Caption, FLayout,
      FMargin, FSpacing, AState, DrawTextBiDiModeFlags(0),
      GetPainterClass = TcxWinXPLookAndFeelPainter{$IFDEF DELPHI7}, WordWrap{$ENDIF});
  finally
    FCanvas.SetClipRegion(APrevClipRgn, roSet);
  end;

  if FKind = cxbkDropDownButton then
  begin
    GetPainterClass.DrawButton(FCanvas, ATempRect, '', AState, True, AColor, FCanvas.Font.Color);
    GetPainterClass.DrawScrollBarArrow(FCanvas, ATempRect, AState, adDown);
  end;
  if Focused and not FMenuVisible then
    FCanvas.DrawFocusRect(GetPainterClass.ButtonFocusRect(FCanvas, R));
end;

procedure TcxCustomButton.InternalRecreateWindow;
{$IFNDEF VCL}
var
  ASavedCaption: TCaption;
{$ENDIF}
begin
{$IFDEF VCL}
  RecreateWnd;
{$ELSE}
  ASavedCaption := Caption;
  RecreateWidget;
  Caption := ASavedCaption;
{$ENDIF}
end;

function TcxCustomButton.IsColorsStored: Boolean;
begin
  Result := FColors.AssignedColors <> [];
end;

function TcxCustomButton.IsHotTrack: Boolean;
begin
  Result := not StandardButton and GetPainterClass.IsButtonHotTrack and Enabled;
end;

procedure TcxCustomButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);

  procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
  begin
    with Glyph do
    begin
      Width := ImageList.Width;
      Height := ImageList.Height;
      Canvas.Brush.Color := clFuchsia; {! for lack of a better color }
      Canvas.FillRect(Rect(0,0, Width, Height));
      ImageList.Draw(Canvas, 0, 0, Index);
    end;
  end;

begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if (Glyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
        CopyImage(ActionList.Images, ImageIndex);
    end;
end;

function TcxCustomButton.CanResize(var NewWidth, NewHeight: Integer): Boolean;
begin
  if AutoSize then
    with GetOptimalSize do
    begin
      NewWidth := cx;
      NewHeight := cy;
    end;
  Result := inherited CanResize(NewWidth, NewHeight);
end;

procedure TcxCustomButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if FKind = cxbkDropDownButton then
  {$IFDEF VCL}
    if (Key in [VK_UP, VK_DOWN]) and
  {$ELSE}
    if ((Key = Key_Up) or (Key = Key_Down)) and
  {$ENDIF}
      ((ssAlt in Shift) or (ssShift in Shift)) then
    begin
      if not FMenuVisible then DoDropDownMenu;
      Key := 0;
      Exit
    end;
  inherited;
end;

procedure TcxCustomButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  if (Button = mbLeft) and (Kind <> cxbkStandard) {$IFDEF LINUX}and not FDblClick{$ENDIF}then
  begin
    if not FMenuVisible {$IFNDEF VCL}and not FClosing{$ENDIF} then
      if FKind = cxbkDropDownButton then
      begin
        R := ClientRect;
        R.Left := R.Right - cxDropDownButtonWidth;
        if PtInRect(R, Point(X, Y)) then DoDropDownMenu;
      end
      else
        DoDropDownMenu
    else
    begin
      FIsMouseClick := True;
      FMenuVisible := False;
      FIsDown := False;
      Repaint;
    end;
  {$IFNDEF VCL}
    FClosing := False;
  {$ENDIF}
  end;
  inherited;
end;

procedure TcxCustomButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FDropDownMenu then
      FDropDownMenu := nil
    else
      if AComponent = PopupMenu then
        PopupMenu := nil;
  end;
end;

{$IFDEF VCL}

procedure TcxCustomButton.DrawItem(const DrawItemStruct: TDrawItemStruct);
begin
  FCanvas.Canvas.Handle := DrawItemStruct.hDC;
  with DrawItemStruct do
  begin
    if not FLockDown then
      FIsDown := itemState and ODS_SELECTED <> 0
    else
      FIsDown := False;
    FIsDefault := (itemState and ODS_FOCUS <> 0) or
     (Default and (csDesigning in ComponentState));
  end;
  InternalPaint;
  FCanvas.Canvas.Handle := 0;
end;

procedure TcxCustomButton.WMCaptureChanged(var Message: TMessage);
var
  P: TPoint;
begin
  inherited;
  if csDesigning in ComponentState then Exit;
  GetCursorPos(P);
  FMouseInControl := IsHotTrack and (WindowFromPoint(P) = Handle);
end;

procedure TcxCustomButton.WMContextMenu(var Message: TWMContextMenu);
var
  AHandled: Boolean;
  P, P1: TPoint;
begin
  if Message.Result <> 0 then
    Exit;
  if csDesigning in ComponentState then
  begin
    inherited;
    Exit;
  end;

  P := SmallPointToPoint(Message.Pos);
  if (P.X = -1) and (P.Y = -1) then
    P1 := P
  else
  begin
    P1 := ScreenToClient(P);
    if not PtInRect(ClientRect, P1) then
    begin
      inherited;
      Exit;
    end;
  end;

  AHandled := False;
  DoContextPopup(P1, AHandled);
  Message.Result := Ord(AHandled);
  if not AHandled then
    inherited;
end;

procedure TcxCustomButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
{$IFNDEF DELPHI7}
  if (csDestroying in ComponentState) or StandardButton or
    (GetPainterClass = TcxWinXPLookAndFeelPainter) then
      inherited
  else
{$ENDIF}
    Message.Result := 1;
end;

procedure TcxCustomButton.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  Perform(WM_LBUTTONDOWN, Message.Keys,
    LPARAM(Word(Message.XPos) or (Word(Message.YPos) shr 16)));
end;

procedure TcxCustomButton.WMLButtonDown(var Message: TWMLButtonDown);
var
  R: TRect;
begin
  if FKind = cxbkDropDownButton then
  begin
    R := ClientRect;
    R.Left := R.Right - cxDropDownButtonWidth;
    if PtInRect(R, Point(Message.XPos, Message.YPos)) then
      FLockDown := True;
  end;
  inherited;
end;

procedure TcxCustomButton.WMLButtonUp(var Message: TWMLButtonUp);
begin
  FLockDown := False;
  inherited;
end;

procedure TcxCustomButton.CMCloseupPopupMenu(var Message: TMessage);
var
  P: TPoint;
begin
  GetCursorPos(P);
  FMouseInControl := IsHotTrack and (WindowFromPoint(P) = Handle);
  FMenuVisible := False;
  Repaint;
  FLockDown := False;
end;

procedure TcxCustomButton.CMDropDownPopupMenu(var Message: TMessage);
var
  P: TPoint;
  APopupAlignment: TPopupAlignment;
  APopupMenu: TPopupMenu;
begin
  if (Kind <> cxbkStandard) then
  begin
    APopupMenu := FDropDownMenu;
    if DoOnDropDownMenuPopup(APopupMenu) or (APopupMenu = nil) then
      Exit;
    FMenuVisible := True;
    Repaint;
    P := GetDropDownMenuPopupPoint(APopupMenu);
    APopupAlignment := APopupMenu.Alignment;
    try
      APopupMenu.Alignment := GetDropDownMenuAlignment(P, FPopupAlignment);
      APopupMenu.PopupComponent := Self;
      APopupMenu.Popup(P.X, P.Y);
    finally
      APopupMenu.Alignment := APopupAlignment;
    end;
    PostMessage(Handle, CM_CLOSEUPPOPUPMENU, 0, 0);
  end;
end;

procedure TcxCustomButton.CMFontChanged(var Message: TMessage);
begin
  inherited;
  UpdateSize;
  Invalidate;
end;

procedure TcxCustomButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not Enabled then FMouseInControl := False;
  Invalidate;
end;

procedure TcxCustomButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
{$IFDEF DELPHI7}
  if csDesigning in ComponentState then Exit;
{$ENDIF}
  if not FMouseInControl and IsHotTrack and (GetCapture = 0) then
  begin
    BeginMouseTracking(Self, Rect(0, 0, Width, Height), Self);
    FMouseInControl := True;
    Repaint;
  end;
end;

procedure TcxCustomButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
{$IFDEF DELPHI7}
  if csDesigning in ComponentState then Exit;
{$ENDIF}
  EndMouseTracking(Self);
  if FMouseInControl and IsHotTrack then
  begin
    FMouseInControl := False;
    Invalidate;
  end;
end;

procedure TcxCustomButton.CNDrawItem(var Message: TWMDrawItem);
begin
  if not(csDestroying in ComponentState) then
    DrawItem(Message.DrawItemStruct^);
end;

procedure TcxCustomButton.CNKeyDown(var Message: TWMKeyDown);
begin
  if IsPopupMenuShortCut(PopupMenu, Message) then
    Message.Result := 1
  else
    inherited;
end;

procedure TcxCustomButton.CNMeasureItem(var Message: TWMMeasureItem);
var
  ATempVar: TMeasureItemStruct;
begin
  ATempVar := Message.MeasureItemStruct^;
  ATempVar.itemWidth := Width;
  ATempVar.itemHeight := Height;
  Message.MeasureItemStruct^ := ATempVar;
end;

procedure TcxCustomButton.CNSysKeyDown(var Message: TWMSysKeyDown);
begin
  if IsPopupMenuShortCut(PopupMenu, Message) then
    Message.Result := 1
  else
    inherited;
end;

procedure TcxCustomButton.CreateHandle;
var
  State: TcxButtonState;
begin
  if Enabled then
    State := cxbsNormal
  else
    State := cxbsDisabled;
  inherited CreateHandle;
  FGlyph.CreateButtonGlyph(State);
end;

procedure TcxCustomButton.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if not StandardButton then
    with Params do Style := Style or BS_OWNERDRAW;
end;

procedure TcxCustomButton.DestroyWindowHandle;
begin
  if FMenuVisible then
    SendMessage(Handle, CM_CLOSEUPPOPUPMENU, 0, 0);
  inherited DestroyWindowHandle;
end;

function TcxCustomButton.GetPalette: HPALETTE;
begin
  Result := Glyph.Palette;
end;

procedure TcxCustomButton.SetButtonStyle(ADefault: Boolean);
begin
  if StandardButton then
    inherited SetButtonStyle(ADefault)
  else
    if ADefault <> FIsFocused then
    begin
      FIsFocused := ADefault;
      Refresh;
    end;
end;

procedure TcxCustomButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if not FMouseInControl and IsHotTrack and PtInRect(ClientRect, Point(X, Y)) and
    (GetCapture = 0) then
      Perform(CM_MOUSEENTER, 0, 0);
end;

{$ELSE}

procedure TcxCustomButton.EnabledChanged;
begin
  inherited EnabledChanged;
  if not Enabled then FMouseInControl := False;
  Invalidate;
end;

procedure TcxCustomButton.FontChanged;
begin
  inherited FontChanged;
  invalidate;
end;

procedure TcxCustomButton.InitWidget;
var
  State: TcxButtonState;
begin
  if Enabled then
    State := cxbsNormal
  else
    State := cxbsDisabled;
  inherited InitWidget;
  FGlyph.CreateButtonGlyph(State);
end;

procedure TcxCustomButton.MouseEnter(AControl: TControl);
begin
  inherited MouseEnter(AControl);
{$IFDEF DELPHI7}
  if csDesigning in ComponentState then Exit;
{$ENDIF}
  if IsHotTrack and not FMouseInControl and (GetCaptureControl = nil) then
  begin
    FMouseInControl := True;
    Repaint;
  end;
end;

procedure TcxCustomButton.MouseLeave(AControl: TControl);
begin
  inherited MouseLeave(AControl);
{$IFDEF DELPHI7}
  if csDesigning in ComponentState then Exit;
{$ENDIF}
  if IsHotTrack and FMouseInControl then
  begin
    FMouseInControl := False;
    Invalidate;
    QWidget_update(Handle);
  end;
end;

function TcxCustomButton.NeedKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;
begin
  if (FKind = cxbkDropDownButton) and ((Key = Key_Up) or (Key = Key_Down)) and
    ((ssCtrl in Shift) or (ssShift in Shift)) and not FMenuVisible then
  begin
    DoDropDownMenu;
    Result := True;
  end
  else
    Result := inherited NeedKey(Key, Shift, KeyText);
end;

procedure TcxCustomButton.Painting(Sender: QObjectH; EventRegion: QRegionH);
begin
  TControlCanvas(FControlCanvas).StartPaint;
  try
    QPainter_setClipRegion(FControlCanvas.Handle, EventRegion);
    InternalPaint;
  finally
    TControlCanvas(FControlCanvas).StopPaint;
  end;
end;

function TcxCustomButton.WidgetFlags: Integer;
begin
  Result := Integer(WidgetFlags_WRepaintNoErase);
end;
{$ENDIF}

{$IFNDEF VCL}
initialization
  FObjectEventFilter := TcxObjectEventFilter.Create(Application.Handle);

finalization
  FreeAndNil(FObjectEventFilter);
{$ENDIF}

end.



