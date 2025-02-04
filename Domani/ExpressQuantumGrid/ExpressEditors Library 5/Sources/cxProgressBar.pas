
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

unit cxProgressBar;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types, Variants,
{$ENDIF}
  Windows, Classes, Controls, Forms, Graphics, Messages, SysUtils, cxClasses,
  cxContainer, cxControls, cxCustomData, cxEdit, cxExtEditConsts,
  cxFilterControlUtils, cxGraphics, cxTextEdit, cxVariants;

type
  TcxBorderWidth = 0..MaxWord;
  TcxProgressBarBevelOuter = (cxbvNone, cxbvLowered, cxbvRaised);
  TcxProgressBarOrientation = (cxorHorizontal, cxorVertical);
  TcxProgressBarTextStyle = (cxtsPercent, cxtsPosition);
  TcxProgressBarBarStyle = (cxbsSolid, cxbsLEDs, cxbsGradient,
    cxbsGradientLEDs, cxbsBitmap, cxbsBitmapLEDs);

  { TcxCustomProgressBarViewInfo }

  TcxCustomProgressBarViewInfo = class(TcxCustomTextEditViewInfo)
  private
    FBeginColor: TColor;
    FBarBevelOuter: TcxProgressBarBevelOuter;
    FEndColor: TColor;
    FMin: Double;
    FMax: Double;
    FPosition: Double;
    FForegroundImage: TBitmap;
    FOrientation: TcxProgressBarOrientation;
    FShowText: Boolean;
    FShowTextStyle: TcxProgressBarTextStyle;
    FTextOrientation: TcxProgressBarOrientation;
    FSolidTextColor: Boolean;
    FBarStyle: TcxProgressBarBarStyle;
    FOverloadValue: Double;
    FOverloadBeginColor: TColor;
    FOverloadEndColor: TColor;
    FShowOverload: Boolean;
    FPeakValue: Double;
    FPeakColor: TColor;
    FPeakSize: TcxNaturalNumber;
    FShowPeak: Boolean;
    FRealShowOverload: Boolean;
    FRealShowPeak: Boolean;
    FPropTransparent: Boolean;
  protected
    BarRect: TRect;
    ProgressBarRect: TRect;
    OverloadBarRect: TRect;
    PeakBarRect: TRect;
    property BeginColor: TColor read FBeginColor write FBeginColor;
    property BarBevelOuter: TcxProgressBarBevelOuter read FBarBevelOuter
      write FBarBevelOuter;
    property EndColor: TColor read FEndColor write FEndColor;
    property Min: Double read FMin write FMin;
    property Max: Double read FMax write FMax;
    property Position : Double read FPosition write FPosition;
    property ForegroundImage: TBitmap read FForegroundImage write FForegroundImage;
    property Orientation: TcxProgressBarOrientation read FOrientation write FOrientation;
    property ShowText: Boolean read FShowText write FShowText;
    property ShowTextStyle: TcxProgressBarTextStyle read FShowTextStyle write FShowTextStyle;
    property TextOrientation: TcxProgressBarOrientation read FTextOrientation
      write FTextOrientation;
    property SolidTextColor: Boolean read FSolidTextColor write FSolidTextColor;
    property BarStyle: TcxProgressBarBarStyle read FBarStyle write FBarStyle;
    property OverloadValue: Double read FOverloadValue write FOverloadValue;
    property OverloadBeginColor: TColor read FOverloadBeginColor write FOverloadBeginColor;
    property OverloadEndColor: TColor read FOverloadEndColor write FOverloadEndColor;
    property PeakValue: Double read FPeakValue write FPeakValue;
    property PeakColor: TColor read FPeakColor write FPeakColor;
    property PeakSize: TcxNaturalNumber read FPeakSize write FPeakSize;
    property ShowOverload: Boolean read FShowOverload write FShowOverload;
    property ShowPeak: Boolean read FShowPeak write FShowPeak;
    property PropTransparent: Boolean read FPropTransparent write FPropTransparent;
  public
    FocusRect: TRect;
    HasForegroundImage: Boolean;
    constructor Create; override;
    destructor Destroy; override;
    procedure DrawText(ACanvas: TcxCanvas); override;
    function GetUpdateRegion(AViewInfo: TcxContainerViewInfo): TcxRegion; override;
    function NeedShowHint(ACanvas: TcxCanvas; const P: TPoint; out AText: TCaption;
      out AIsMultiLine: Boolean; out ATextRect: TRect): Boolean; override;
    procedure Paint(ACanvas: TcxCanvas); override;
    procedure PaintProgressBar(ACanvas: TcxCanvas); virtual;
    procedure Offset(DX: Integer; DY: Integer); override;
  end;

  { TcxCustomProgressBarViewData }

  TcxCustomProgressBarProperties = class;
  
  TcxCustomProgressBarViewData = class(TcxCustomEditViewData)
  private
    function GetProperties: TcxCustomProgressBarProperties;
  protected
    procedure CalculateViewInfoProperties(AViewInfo: TcxCustomEditViewInfo); virtual;
    function InternalGetEditConstantPartSize(ACanvas: TcxCanvas; AIsInplace: Boolean;
      AEditSizeProperties: TcxEditSizeProperties;
      var MinContentSize: TSize; AViewInfo: TcxCustomEditViewInfo): TSize; override;
    function GetDrawTextFlags: Integer; virtual;
    function GetIsEditClass: Boolean;
  public
    procedure Calculate(ACanvas: TcxCanvas; const ABounds: TRect; const P: TPoint;
      Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
      AIsMouseEvent: Boolean); override;
    procedure EditValueToDrawValue(ACanvas: TcxCanvas; const AEditValue: TcxEditValue;
      AViewInfo: TcxCustomEditViewInfo); override;
    property Properties: TcxCustomProgressBarProperties read GetProperties;
  end;

  { TcxProgressBarPropertiesValues }

  TcxProgressBarPropertiesValues = class(TcxCustomEditPropertiesValues)
  private
    function GetMax: Boolean;
    function GetMin: Boolean;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    procedure SetMax(Value: Boolean);
    procedure SetMin(Value: Boolean);
  published
    property Max: Boolean read GetMax write SetMax stored IsMaxStored;
    property Min: Boolean read GetMin write SetMin stored IsMinStored;
  end;

  { TcxCustomProgressBarProperties }

  TcxCustomProgressBarProperties = class(TcxCustomEditProperties)
  private
    FBeginColor: TColor;
    FBarBevelOuter: TcxProgressBarBevelOuter;
    FEndColor: TColor;
    FForegroundImage: TBitmap;
    FOrientation: TcxProgressBarOrientation;
    FShowText: Boolean;
    FShowTextStyle: TcxProgressBarTextStyle;
    FTextOrientation: TcxProgressBarOrientation;
    FSolidTextColor: Boolean;
    FBarStyle: TcxProgressBarBarStyle;
    FTransparentImage: Boolean;
    FBorderWidth: TcxBorderWidth;
    FOverloadValue: Double;
    FShowOverload: Boolean;
    FOverloadBeginColor: TColor;
    FOverloadEndColor: TColor;
    FPeakValue: Double;
    FShowPeak: Boolean;
    FPeakColor: TColor;
    FPeakSize: TcxNaturalNumber;
    function GetAssignedValues: TcxProgressBarPropertiesValues;
    function GetForegroundImage: TBitmap;
    procedure ForegroundImageChanged(Sender: TObject);
    function GetMax: Double;
    function GetMin: Double;
    function GetOverloadValueStored: Boolean;
    function GetPeakValueStored: Boolean;
    function GetRealPeakValue(APosition: Double): Double;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    procedure SetAssignedValues(Value: TcxProgressBarPropertiesValues);
    procedure SetBeginColor(Value: TColor);
    procedure SetBarBevelOuter(Value: TcxProgressBarBevelOuter);
    procedure SetEndColor(Value: TColor);
    procedure SetForegroundImage(Value: TBitmap);
    procedure SetMax(Value: Double);
    procedure SetMin(Value: Double);
    procedure SetOrientation(Value: TcxProgressBarOrientation);
    procedure SetShowText(Value: Boolean);
    procedure SetShowTextStyle(Value: TcxProgressBarTextStyle);
    procedure SetTextOrientation(Value: TcxProgressBarOrientation);
    procedure SetSolidTextColor(Value: Boolean);
    procedure SetBarStyle(Value: TcxProgressBarBarStyle);
    procedure SetTransparentImage(Value: Boolean);
    procedure SetBorderWidth(Value: TcxBorderWidth);
    procedure SetOverloadValue(Value: Double);
    procedure SetShowOverload(Value: Boolean);
    procedure SetOverloadBeginColor(Value: TColor);
    procedure SetOverloadEndColor(Value: TColor);
    procedure SetPeakValue(Value: Double);
    procedure SetShowPeak(Value: Boolean);
    procedure SetPeakColor(Value: TColor);
    procedure SetPeakSize(Value: TcxNaturalNumber);
    procedure PostMinValue;
    procedure PostMaxValue;
    procedure PostOverloadValue;
  protected
    procedure CorrectPositionWithMaxMin(
      AViewInfo: TcxCustomProgressBarViewInfo); virtual;
    class function GetAssignedValuesClass: TcxCustomEditPropertiesValuesClass; override;
    function GetMaxValue: Double; override;
    function GetMinValue: Double; override;
    class function GetViewDataClass: TcxCustomEditViewDataClass; override;
    function HasDisplayValue: Boolean; override;
    property AssignedValues: TcxProgressBarPropertiesValues read GetAssignedValues
      write SetAssignedValues;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CanCompareEditValue: Boolean; override;
    class function GetContainerClass: TcxContainerClass; override;
    function GetDisplayText(const AEditValue: TcxEditValue;
      AFullText: Boolean = False; AIsInplace: Boolean = True): WideString; override;
    function GetSupportedOperations: TcxEditSupportedOperations; override;
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
    function IsEditValueValid(var EditValue: TcxEditValue;
      AEditFocused: Boolean): Boolean; override;
    procedure PrepareDisplayValue(const AEditValue: TcxEditValue;
      var DisplayValue: TcxEditValue; AEditFocused: Boolean); override;
    // !!!
    property BarBevelOuter: TcxProgressBarBevelOuter read FBarBevelOuter
      write SetBarBevelOuter default cxbvNone;
    property BarStyle: TcxProgressBarBarStyle read FBarStyle write SetBarStyle
      default cxbsSolid;
    property BeginColor: TColor read FBeginColor write SetBeginColor
      default clNavy;
    property BorderWidth : TcxBorderWidth read FBorderWidth write SetBorderWidth
      default 0;
    property EndColor: TColor read FEndColor write SetEndColor default clWhite;
    property ForegroundImage: TBitmap read GetForegroundImage
      write SetForegroundImage;
    property Max: Double read GetMax write SetMax stored IsMaxStored;
    property Min: Double read GetMin write SetMin stored IsMinStored;
    property Orientation: TcxProgressBarOrientation read FOrientation
      write SetOrientation default cxorHorizontal;
    property OverloadBeginColor: TColor read FOverloadBeginColor
      write SetOverloadBeginColor default $008080FF;
    property OverloadEndColor: TColor read FOverloadEndColor
      write SetOverloadEndColor default clFuchsia;
    property OverloadValue: Double read FOverloadValue write SetOverloadValue
      stored GetOverloadValueStored;
    property PeakColor: TColor read FPeakColor write SetPeakColor default clRed;
    property PeakSize: TcxNaturalNumber read FPeakSize write SetPeakSize
      default 2;
    property PeakValue: Double read FPeakValue write SetPeakValue
      stored GetPeakValueStored;
    property ShowOverload: Boolean read FShowOverload write SetShowOverload
      default False;
    property ShowPeak: Boolean read FShowPeak write SetShowPeak default False;
    property ShowText: Boolean read FShowText write SetShowText default True;
    property ShowTextStyle: TcxProgressBarTextStyle read FShowTextStyle
      write SetShowTextStyle default cxtsPercent;
    property SolidTextColor: Boolean read FSolidTextColor
      write SetSolidTextColor default False;
    property TextOrientation: TcxProgressBarOrientation read FTextOrientation
      write SetTextOrientation default cxorHorizontal;
    property Transparent; // deprecated
    property TransparentImage: Boolean read FTransparentImage
      write SetTransparentImage default True;
  end;

  { TcxProgressBarProperties }

  TcxProgressBarProperties = class(TcxCustomProgressBarProperties)
  published
    property AssignedValues;
    property BarBevelOuter;
    property BarStyle;
    property BeginColor;
    property BorderWidth;
    property EndColor;
    property ForegroundImage;
    property Max;
    property Min;
    property Orientation;
    property OverloadBeginColor;
    property OverloadEndColor;
    property OverloadValue;
    property PeakColor;
    property PeakSize;
    property PeakValue;
    property ShowOverload;
    property ShowPeak;
    property ShowText;
    property ShowTextStyle;
    property SolidTextColor;
    property TextOrientation;
    property Transparent; // deprecated
    property TransparentImage;
  end;

  { TcxCustomProgressBar }

  TcxCustomProgressBar = class(TcxCustomEdit)
  private
    function GetPosition: Double;
    function GetPositionStored: Boolean;
    function GetProperties: TcxCustomProgressBarProperties;
    function GetActiveProperties: TcxCustomProgressBarProperties;
    function GetViewInfo: TcxCustomProgressBarViewInfo;
    procedure SetProperties(Value: TcxCustomProgressBarProperties);
    procedure SetPosition(Value: Double);
  protected
    procedure CheckEditorValueBounds; virtual;
    procedure CheckEditValue; virtual;
    function DefaultParentColor: Boolean; override;
    procedure FillSizeProperties(var AEditSizeProperties: TcxEditSizeProperties); override;
    procedure Initialize; override;
    function InternalGetNotPublishedStyleValues: TcxEditStyleValues; override;
    procedure SynchronizeDisplayValue; override;
    procedure PropertiesChanged(Sender: TObject); override;
    property ViewInfo: TcxCustomProgressBarViewInfo read GetViewInfo;
    function CanFocusOnClick: Boolean; override;
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    function CanFocus: Boolean; override;
    property ActiveProperties: TcxCustomProgressBarProperties
      read GetActiveProperties;
    property Position: Double read GetPosition write SetPosition
      stored GetPositionStored;
    property Properties: TcxCustomProgressBarProperties read GetProperties
      write SetProperties;
    property Transparent;
  end;

  { TcxCustomProgressBar }

  TcxProgressBar = class(TcxCustomProgressBar)
  private
    function GetActiveProperties: TcxProgressBarProperties;
    function GetProperties: TcxProgressBarProperties;
    procedure SetProperties(Value: TcxProgressBarProperties);
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxProgressBarProperties
      read GetActiveProperties;
  published
    property Align;
    property Anchors;
    property AutoSize;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Position;
    property Properties: TcxProgressBarProperties read GetProperties
      write SetProperties;
    property ShowHint;
    property Style;
    property StyleDisabled;
    property StyleFocused;
    property StyleHot;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property OnContextPopup;
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
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  Math, cxEditConsts, cxDrawTextUtils, cxEditUtils, cxExtEditUtils, cxSpinEdit,
  dxThemeConsts, dxThemeManager, dxUxTheme, cxGeometry;

type  
  { TcxFilterProgressBarHelper }

  TcxFilterProgressBarHelper = class(TcxFilterSpinEditHelper)
  public
    class procedure InitializeProperties(AProperties,
      AEditProperties: TcxCustomEditProperties; AHasButtons: Boolean); override;
  end;

procedure CalculateCustomProgressBarViewInfo(ACanvas: TcxCanvas; AViewData: TcxCustomProgressBarViewData;
  AViewInfo: TcxCustomProgressBarViewInfo);

  procedure CheckFocusRectBounds;
  begin
    with AViewInfo do
    begin
      if FocusRect.Left < TextRect.Left - 1 then
        FocusRect.Left := TextRect.Left - 1;
      if FocusRect.Top < TextRect.Top - 1 then
        FocusRect.Top := TextRect.Top - 1;
      if FocusRect.Right > TextRect.Right + 1 then
        FocusRect.Right := TextRect.Right + 1;
      if FocusRect.Bottom > TextRect.Bottom + 1 then
        FocusRect.Bottom := TextRect.Bottom + 1;
    end;
  end;

begin
  with AViewInfo do
  begin
    if not IsInplace and Focused then
      if Length(Text) = 0 then
        FocusRect := cxEmptyRect
      else
      begin
        FocusRect := TextRect;
        InflateRect(FocusRect, 1, 1);
        CheckFocusRectBounds;
      end;
  end;
end;

function CalculateDelta(const APositionDelta, ARectWidth, AMaxMinDelta: Double): Integer;
var
  ACalc: Double;
begin
  ACalc := (APositionDelta * ARectWidth) / AMaxMinDelta;
  Result := Trunc(ACalc);
end;

function MaxMinDiff(AMax, AMin: Double): Double;
begin
  Result := AMax - AMin;
  if Result < 1 then
    Result := 1;
end;

{ TcxCustomProgressBarViewInfo }

constructor TcxCustomProgressBarViewInfo.Create;
begin
  inherited Create;
  FForegroundImage := TBitmap.Create;
end;

destructor TcxCustomProgressBarViewInfo.Destroy;
begin
  if Assigned(FForegroundImage) then
    FreeAndNil(FForegroundImage);
  inherited Destroy;
end;

function TcxCustomProgressBarViewInfo.GetUpdateRegion(AViewInfo: TcxContainerViewInfo): TcxRegion;
begin
  Result := inherited GetUpdateRegion(AViewInfo);
  if not (AViewInfo is TcxCustomProgressBarViewInfo) then Exit;
end;

function TcxCustomProgressBarViewInfo.NeedShowHint(ACanvas: TcxCanvas;
  const P: TPoint; out AText: TCaption; out AIsMultiLine: Boolean;
  out ATextRect: TRect): Boolean;
begin
  Result := False;
end;

procedure TcxCustomProgressBarViewInfo.DrawText(ACanvas: TcxCanvas);
var
  ABarText: string;
  ADrawDelta: Integer;
  ATextDeltaX: Integer;
  ATextDeltaY: Integer;
begin
  if not ShowText then Exit;

  if ShowTextStyle = cxtsPosition then
    ABarText := FloatToStr(Position)
  else
  if ShowTextStyle = cxtsPercent then
    ABarText := IntToStr(Math.Min(Round((FPosition-FMin) / MaxMinDiff(FMax, FMin) * 100), 100)) + '%';

  ACanvas.Font.Assign(Font);
  if (Painter = nil) or ((Painter <> nil) and (Painter.ProgressBarTextColor = clDefault)) then
    ACanvas.Font.Color := TextColor
  else
    ACanvas.Font.Color := Painter.ProgressBarTextColor;

  ACanvas.Brush.Style := bsClear;
  if TextOrientation = cxorHorizontal then
    ACanvas.DrawText(ABarText, BarRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE)
  else
  if TextOrientation = cxorVertical then
  begin
    if NativeStyle or IsInplace then
      ADrawDelta := 0
    else
      ADrawDelta := 2;

    ATextDeltaX := (RectWidth(BarRect) + ACanvas.TextHeight(ABarText)) div 2 + ADrawDelta;
    ATextDeltaY := (RectHeight(BarRect) - ACanvas.TextWidth(ABarText)) div 2 + ADrawDelta;

    ACanvas.SetFontAngle(270);
    cxExtTextOut(ACanvas.Handle, ABarText, Point(ATextDeltaX, ATextDeltaY), 0);
  end;
end;

procedure TcxCustomProgressBarViewInfo.Offset(DX: Integer; DY: Integer);
begin
  inherited Offset(DX, DY);
  InflateRectEx(BarRect, DX, DY, DX, DY);
  InflateRectEx(ProgressBarRect, DX, DY, DX, DY);
  InflateRectEx(OverloadBarRect, DX, DY, DX, DY);
  InflateRectEx(PeakBarRect, DX, DY, DX, DY);
end;

procedure TcxCustomProgressBarViewInfo.Paint(ACanvas: TcxCanvas);
var
  ABitmap: TBitmap;
  ABitmapCanvas: TcxCanvas;
  ABordersOffset: TRect;
  AChunkRect: TRect;
  AChunkSize: Integer;
  AProgressKf: Single;
  ARect: TRect;
  AVertical: Boolean;
begin
  if Painter <> nil then
  begin
    AProgressKf := Position / (Max - Min);
    AVertical := Orientation = cxorVertical;
    
    ABitmap := TcxBitmap.Create;
    ABitmap.Width := RectWidth(Bounds);
    ABitmap.Height := RectHeight(Bounds);
    ABitmap.PixelFormat := pf32bit;
    ABitmapCanvas := TcxCanvas.Create(ABitmap.Canvas);
    ARect := Rect(BarRect.Left - Bounds.Left, BarRect.Top - Bounds.Top,
      ABitmap.Width - (Bounds.Right - BarRect.Right),
      ABitmap.Height - (Bounds.Bottom - BarRect.Bottom));

    cxDrawTransparentControlBackground(Edit, ABitmapCanvas, Bounds);
    try
      Painter.DrawProgressBarBorder(ABitmapCanvas, ARect, AVertical);
      ABordersOffset := Painter.ProgressBarBorderSize(AVertical);
      ABitmapCanvas.SetClipRegion(TcxRegion.Create(
        cxRectContent(ARect, ABordersOffset)), roSet);
      if AVertical then
      begin
        AChunkSize := Trunc((RectHeight(ARect) - ABordersOffset.Bottom - ABordersOffset.Top) *
          (1 - AProgressKf));
        with ABordersOffset do
          AChunkRect := Rect(ARect.Left + Left, ARect.Top + Top + AChunkSize,
            ARect.Right - Right, ARect.Bottom - Bottom);
      end else
      begin
        AChunkSize := Trunc((RectWidth(ARect) - ABordersOffset.Right - ABordersOffset.Left) *
          AProgressKf);
        with ABordersOffset do
          AChunkRect := Rect(ARect.Left + Left, ARect.Top + Top,
            ARect.Left + Left + AChunkSize, ARect.Bottom - Bottom);
      end;
      Painter.DrawProgressBarChunk(ABitmapCanvas, AChunkRect, AVertical);
      DrawText(ABitmapCanvas);
      cxBitBlt(ACanvas.Handle, ABitmapCanvas.Handle, Bounds, cxNullPoint, SRCCOPY);
    finally
      ABitmap.Free;
      ABitmapCanvas.Free;
    end;
  end else
  begin
    if not (AreVisualStylesMustBeUsed(NativeStyle, totProgress) or
      IsInplace and Transparent) then
        DrawCustomEdit(ACanvas, Self, False, bpsSolid);
    PaintProgressBar(ACanvas);
  end;
end;

procedure TcxCustomProgressBarViewInfo.PaintProgressBar(ACanvas: TcxCanvas);
var
  R, FSolidRect, FRealSolidRect, FChunkRect: TRect;
  I, J, FRectWidth, FRectHeight, FOld, FModValue, FPercent: Integer;
  FBarText: string;
  FTextWidth, FTextHeight: Integer;
  FTM: TTextMetric;
  FLF: TLogFont;
  FLocalFont: TFont;
  FBarWidth, FBarHeight : Integer;
  FPos, FMaxPos, FAbsolutePos: Integer;
  FRealBeginColor, FRealEndColor: TColor;
  FBmp, FChunkBmp, FTextBmp, FTextSavedBmp: TBitmap;
  FTextDeltaX, FTextDeltaY: Integer;
  FTopX, FDrawDelta: Integer;
  FTheme: TTheme;
  FBarThemeType, FChunkThemeType: Integer;
  FCondition: Boolean;
  FParentDC: HDC;
  FDrawProgressBarRect: TRect;
  FDrawOverloadBarRect: TRect;
  FDrawPeakBarRect: TRect;

  procedure PaintBarBevelOuter(ABBORect: TRect);
  begin
    if FBarBevelOuter = cxbvLowered then
    begin
      DrawEdge(FBmp.Canvas.Handle, ABBORect, BDR_SUNKENOUTER, BF_TOPLEFT);
      DrawEdge(FBmp.Canvas.Handle, ABBORect, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
    end;
    if FBarBevelOuter = cxbvRaised then
    begin
      DrawEdge(FBmp.Canvas.Handle, ABBORect, BDR_RAISEDINNER, BF_TOPLEFT);
      DrawEdge(FBmp.Canvas.Handle, ABBORect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
    end;
  end;

  function GetColor(const ABeginColor, AEndColor: TColor; const N, H: Integer): TColor;
  begin
    Result := RGB(Trunc(GetRValue(ABeginColor) + (GetRValue(AEndColor)-GetRValue(ABeginColor)) * N / H),
      Trunc(GetGValue(ABeginColor) + (GetGValue(AEndColor)-GetGValue(ABeginColor)) * N / H),
      Trunc(GetBValue(ABeginColor) + (GetBValue(AEndColor)-GetBValue(ABeginColor)) * N / H));
  end;

var
  APrevLogFont: TLogFont;
begin
  SaveCanvasFont(ACanvas, APrevLogFont);
  try
    FBarWidth := RectWidth(BarRect);
    FBarHeight := RectHeight(BarRect);
    FDrawProgressBarRect := ProgressBarRect;
    FDrawOverloadBarRect := OverloadBarRect;
    FDrawPeakBarRect := PeakBarRect;
    if NativeStyle or IsInplace then
      FDrawDelta := 0
    else
      FDrawDelta := 2;
    if IsInplace then
    begin
      InflateRectEx(FDrawProgressBarRect, -BarRect.Left, -BarRect.Top, -BarRect.Left, -BarRect.Top);
      InflateRectEx(FDrawOverloadBarRect, -BarRect.Left, -BarRect.Top, -BarRect.Left, -BarRect.Top);
      InflateRectEx(FDrawPeakBarRect, -BarRect.Left, -BarRect.Top, -BarRect.Left, -BarRect.Top);
    end;
    FBmp := TBitmap.Create;
    FChunkBmp := TBitmap.Create;
    try
      FBmp.Width := FBarWidth + FDrawDelta;
      FBmp.Height := FBarHeight + FDrawDelta;
      {Draw Background section}

      if PropTransparent then
      begin
        if not IsInplace then
          cxDrawTransparentControlBackground(Edit, FBmp.Canvas,
            Rect(0, 0, FBmp.Width, FBmp.Height))
        else
        begin
          BitBlt(FBmp.Canvas.Handle, 0, 0,
            FBarWidth, FBarHeight,
            ACanvas.Handle, BarRect.Left, BarRect.Top, SRCCOPY);
        end;
      end;

      if not PropTransparent then
      begin
        FBmp.Canvas.Brush.Style := bsSolid;
        FBmp.Canvas.Brush.Color := BackgroundColor;
        FBmp.Canvas.FillRect(Rect(0, 0, FBmp.Width, FBmp.Height));
      end;

      if NativeStyle then
      begin
        FTheme := OpenTheme(totProgress);
        if FOrientation = cxorHorizontal then
        begin
          FBarThemeType := PP_BAR;
          FChunkThemeType := PP_CHUNK;
          FChunkBmp.Width := 1;
          if RectHeight(FDrawProgressBarRect) < 0 then
            FChunkBmp.Height := 0
          else
            FChunkBmp.Height := RectHeight(FDrawProgressBarRect);
          FChunkRect := FChunkBmp.Canvas.ClipRect;
          FChunkRect.Left := -4;
        end
        else
        begin
          FBarThemeType := PP_BARVERT;
          FChunkThemeType := PP_CHUNKVERT;
          FChunkBmp.Height := 1;
          if RectWidth(FDrawProgressBarRect) < 0 then
            FChunkBmp.Width := 0
          else
            FChunkBmp.Width := RectWidth(FDrawProgressBarRect);
          FChunkRect := FChunkBmp.Canvas.ClipRect;
          FChunkRect.Top := -4;
        end;
        if not IsInplace and not PropTransparent then
          DrawThemeBackground(FTheme, FBmp.Canvas.Handle, FBarThemeType, 1,
            BarRect);
        DrawThemeBackground(FTheme, FChunkBmp.Canvas.Handle, FChunkThemeType, 1,
          FChunkRect);
      end;

      if FRealShowOverload = False then
        FSolidRect := FDrawProgressBarRect
      else
      begin
        if FOrientation = cxorHorizontal then
          FSolidRect := Rect(FDrawProgressBarRect.Left, FDrawProgressBarRect.Top,
            FDrawOverloadBarRect.Right, FDrawOverloadBarRect.Bottom)
         else
          FSolidRect := Rect(FDrawOverloadBarRect.Left, FDrawOverloadBarRect.Top,
            FDrawProgressBarRect.Right, FDrawProgressBarRect.Bottom)
      end;
      {FRealSolidRect neeed only for draw inverted Text under rectangles}
      FRealSolidRect := FSolidRect;

      if NativeStyle then
      begin
        if FBarStyle = cxbsSolid then
          FBarStyle := cxbsGradient
        else
          if FBarStyle = cxbsLEDs then
            FBarStyle := cxbsGradientLEDs;
      end;

      if FBarStyle = cxbsSolid then
      begin
        FBmp.Canvas.Brush.Color := FBeginColor;
        if FRealShowOverload = False then
          FBmp.Canvas.FillRect(FSolidRect)
        else
        begin
          FBmp.Canvas.FillRect(FDrawProgressBarRect);
          FBmp.Canvas.Brush.Color := FOverloadBeginColor;
          FBmp.Canvas.FillRect(FDrawOverloadBarRect);
        end;
        PaintBarBevelOuter(FSolidRect);
      end;

      if FBarStyle = cxbsGradient then begin
        FRealBeginColor := FBeginColor;
        FRealEndColor := FEndColor;
        if FOrientation = cxorHorizontal then
        begin
          for I := FSolidRect.Left to FSolidRect.Right - 1 do
          begin
            FPos := I - FSolidRect.Left;
            if NativeStyle then
              BitBlt(FBmp.Canvas.Handle, I, FSolidRect.Top, FChunkBmp.Width, FChunkBmp.Height,
                FChunkBmp.Canvas.Handle, 0, 0, SRCCOPY)
            else
            begin
              FMaxPos := FBarWidth;
              if (FRealShowOverload = True) and (FPos >= FDrawOverloadBarRect.Left - 1) then
              begin
                FPos := (I - FDrawOverloadBarRect.Left);
                FMaxPos := FDrawOverloadBarRect.Left;
                FRealBeginColor := FOverloadBeginColor;
                FRealEndColor := FOverloadEndColor;
              end;
              FBmp.Canvas.Pen.Color := GetColor(FRealBeginColor, FRealEndColor, FPos, FMaxPos);
              FBmp.Canvas.MoveTo(I, FSolidRect.Top);
              FBmp.Canvas.LineTo(I, FSolidRect.Bottom);
            end;
          end;
        end else
        begin
          for I := FSolidRect.Bottom - 1 downto FSolidRect.Top do
          begin
            FPos := FSolidRect.Bottom - I;
            if NativeStyle then
              BitBlt(FBmp.Canvas.Handle, FSolidRect.Left, I, FChunkBmp.Width, FChunkBmp.Height,
                FChunkBmp.Canvas.Handle, 0, 0, SRCCOPY)
            else
            begin
              FMaxPos := FBarHeight;
              if (FRealShowOverload = True) and (I < FDrawOverloadBarRect.Bottom) then
              begin
                FPos := (FDrawOverloadBarRect.Bottom - I);
                FMaxPos := FDrawOverloadBarRect.Bottom;
                FRealBeginColor := FOverloadBeginColor;
                FRealEndColor := FOverloadEndColor;
              end;
              FBmp.Canvas.Pen.Color := GetColor(FRealBeginColor, FRealEndColor, FPos, FMaxPos);
              FBmp.Canvas.MoveTo(FSolidRect.Left, I);
              FBmp.Canvas.LineTo(FSolidRect.Right, I);
            end;
          end;
        end;
        PaintBarBevelOuter(FSolidRect);
      end;

      if FBarStyle = cxbsLEDs then
      begin
        FOld := 0;
        FRealBeginColor := FBeginColor;
        if FOrientation = cxorHorizontal then
        begin
          FRectWidth := Trunc(FBarHeight * 2 / 3) + 2;
          for I := FSolidRect.Left to FSolidRect.Right - 1 do
            if (((I - FSolidRect.Left) mod FRectWidth) = 0) and (I - FRectWidth >= FSolidRect.Left) then
            begin
              if (FRealShowOverload = True) and (I >= FDrawOverloadBarRect.Left - 1) then
                FRealBeginColor := FOverloadBeginColor;

              FBmp.Canvas.Pen.Color := FRealBeginColor;
              FBmp.Canvas.Brush.Color := FRealBeginColor;

              //
              // The leds...
              //
              FBmp.Canvas.FillRect(Rect(I - FRectWidth, FSolidRect.Top, I - 2, FSolidRect.Bottom));
              PaintBarBevelOuter(Rect(I - FRectWidth, FSolidRect.Top, I - 2, FSolidRect.Bottom));
              FOld := I;
              FRealSolidRect.Right := I - 2;

              //
              // Partial rect in the right.
              //
              if FSolidRect.Right - I - 2 < FRectWidth then
              begin
                FBmp.Canvas.FillRect(Rect(I, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
                PaintBarBevelOuter(Rect(I, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
              end;
            end;
          if FPosition >= FMax then
          begin
            if (FRealShowOverload = True) then FRealBeginColor := FOverloadBeginColor;
            FBmp.Canvas.Pen.Color := FRealBeginColor;
            FBmp.Canvas.Brush.Color := FRealBeginColor;
            FBmp.Canvas.FillRect(Rect(FOld, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
            PaintBarBevelOuter(Rect(FOld, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
          end;
        end
        else
        begin
          FRectHeight := Trunc(FBarWidth * 2 / 3) + 2;
          for I := FSolidRect.Bottom - 1 downto FSolidRect.Top do
            if (((FSolidRect.Bottom - I - 1) mod FRectHeight) = 0) and
              (I + FRectHeight <= FSolidRect.Bottom) then
            begin
              if (FRealShowOverload = True) and (I < FDrawOverloadBarRect.Bottom) then
                FRealBeginColor := FOverloadBeginColor;

              FBmp.Canvas.Pen.Color := FRealBeginColor;
              FBmp.Canvas.Brush.Color := FRealBeginColor;

              FBmp.Canvas.FillRect(Rect(FSolidRect.Left, I + 2, FSolidRect.Right, I + FRectHeight));
              PaintBarBevelOuter(Rect(FSolidRect.Left, I + 2, FSolidRect.Right, I + FRectHeight));

              FOld := I;
              FRealSolidRect.Top := I + 2;

              if I - FSolidRect.Top  < FRectHeight then
              begin
                FBmp.Canvas.FillRect(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, I));
                PaintBarBevelOuter(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, I));
              end;
            end;
          if FPosition >= FMax then
          begin
            if (FRealShowOverload = True) then FRealBeginColor := FOverloadBeginColor;
            FBmp.Canvas.Pen.Color := FRealBeginColor;
            FBmp.Canvas.Brush.Color := FRealBeginColor;
            FBmp.Canvas.FillRect(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, FOld));
            PaintBarBevelOuter(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, FOld));
          end;
        end;
      end;

      if FBarStyle = cxbsGradientLEDs then
      begin
        FOld := 0;
        FRealBeginColor := FBeginColor;
        FRealEndColor := FEndColor;
        if FOrientation = cxorHorizontal then
        begin
          FRectWidth := Trunc(RectHeight(FSolidRect) * 2 / 3) + 2;
          for I := FSolidRect.Left to FSolidRect.Right - 1 do
          begin
            FModValue := (I - FSolidRect.Left) mod FRectWidth;
            FCondition := (FModValue = 0);
            if FCondition and (I - FRectWidth >= FSolidRect.Left) then
            begin
              FPos := I - FSolidRect.Left;
              if NativeStyle then
              begin
                if I - FRectWidth >= FSolidRect.Left then
                  for J := (I - FRectWidth) to (I - 3) do
                    BitBlt(FBmp.Canvas.Handle, J, FSolidRect.Top, FChunkBmp.Width, FChunkBmp.Height,
                      FChunkBmp.Canvas.Handle, 0, 0, SRCCOPY);

                if FSolidRect.Right - I - 2 < FRectWidth then
                begin
                  for J := I to FSolidRect.Right do
                    BitBlt(FBmp.Canvas.Handle, J, FSolidRect.Top, FChunkBmp.Width, FChunkBmp.Height,
                      FChunkBmp.Canvas.Handle, 0, 0, SRCCOPY);
                end;
              end
              else
              begin
                FMaxPos := FBarWidth;
                if (FRealShowOverload = True) and (FPos >= FDrawOverloadBarRect.Left - 1) then
                begin
                  FPos := (I - FDrawOverloadBarRect.Left);
                  FMaxPos := FDrawOverloadBarRect.Left;
                  FRealBeginColor := FOverloadBeginColor;
                  FRealEndColor := FOverloadEndColor;
                end;
                FBmp.Canvas.Pen.Color := GetColor(FRealBeginColor, FRealEndColor, FPos, FMaxPos);
                FBmp.Canvas.Brush.Color := FBmp.Canvas.Pen.Color;

                //
                // The leds...
                //
                FBmp.Canvas.FillRect(Rect(I - FRectWidth, FSolidRect.Top, I - 2, FSolidRect.Bottom));
                PaintBarBevelOuter(Rect(I - FRectWidth, FSolidRect.Top, I - 2, FSolidRect.Bottom));
                FRealSolidRect.Right := I - 2;

                //
                // Partial rect
                //
                if FSolidRect.Right - I - 2 < FRectWidth then
                begin
                  FBmp.Canvas.FillRect(Rect(I, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
                  PaintBarBevelOuter(Rect(I, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
                end;
              end;
              FOld := I;
            end;
          end;
          if (FPosition >= FMax) then
          begin
            if NativeStyle then
            begin
              for J := FOld to FSolidRect.Right - 1 do
                BitBlt(FBmp.Canvas.Handle, J, FSolidRect.Top, FChunkBmp.Width, FChunkBmp.Height,
                  FChunkBmp.Canvas.Handle, 0, 0, SRCCOPY);
            end
            else
            begin
              if (FRealShowOverload = True) then
              begin
                FRealBeginColor := FOverloadBeginColor;
                FRealEndColor := FOverloadEndColor;
              end;
              FBmp.Canvas.Pen.Color := GetColor(FRealBeginColor, FRealEndColor, FOld - FSolidRect.Left, FBarWidth);
              FBmp.Canvas.Brush.Color := GetColor(FRealBeginColor, FRealEndColor, FOld - FSolidRect.Left, FBarWidth);
              FBmp.Canvas.FillRect(Rect(FOld, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
              PaintBarBevelOuter(Rect(FOld, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
            end;
          end;
        end
        else
        begin
          FRectHeight := Trunc(RectWidth(FSolidRect) * 2 / 3) + 2;
          for I := FSolidRect.Bottom - 1 downto FSolidRect.Top do
          begin
            FModValue := (FSolidRect.Bottom - I - 1) mod FRectHeight;
            FCondition := (FModValue = 0);
            if FCondition and (I + FRectHeight <= FSolidRect.Bottom) then
            begin
              FPos := FSolidRect.Bottom - I;
              if NativeStyle then
              begin
                if I + FRectHeight <= FSolidRect.Bottom then
                  for J := (I + 3) to I + FRectHeight do
                    BitBlt(FBmp.Canvas.Handle, FSolidRect.Left, J, FChunkBmp.Width, FChunkBmp.Height,
                      FChunkBmp.Canvas.Handle, 0, 0, SRCCOPY);

                if I - FSolidRect.Top  < FRectHeight then
                begin
                  for J := FSolidRect.Top to I do
                    BitBlt(FBmp.Canvas.Handle, FSolidRect.Left, J, FChunkBmp.Width, FChunkBmp.Height,
                      FChunkBmp.Canvas.Handle, 0, 0, SRCCOPY);
                end;
              end
              else
              begin
                FMaxPos := FBarHeight;
                if (FRealShowOverload = True) and (I < FDrawOverloadBarRect.Bottom) then
                begin
                  FPos := (FDrawOverloadBarRect.Bottom - I);
                  FMaxPos := FDrawOverloadBarRect.Bottom;
                  FRealBeginColor := FOverloadBeginColor;
                  FRealEndColor := FOverloadEndColor;
                end;
                FBmp.Canvas.Pen.Color := GetColor(FRealBeginColor, FRealEndColor, FPos, FMaxPos);
                FBmp.Canvas.Brush.Color := GetColor(FRealBeginColor, FRealEndColor, FPos, FMaxPos);
                FBmp.Canvas.FillRect(Rect(FSolidRect.Left, I + 2, FSolidRect.Right, I + FRectHeight));
                PaintBarBevelOuter(Rect(FSolidRect.Left, I + 2, FSolidRect.Right, I + FRectHeight));
                FRealSolidRect.Top := I + 2;

                if I - FSolidRect.Top  < FRectHeight then
                begin
                  FBmp.Canvas.FillRect(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, I));
                  PaintBarBevelOuter(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, I));
                end;
              end;
              FOld := I;
            end;
          end;
          if (FPosition >= FMax) then
          begin
            if NativeStyle then
            begin
              for J := FSolidRect.Top to FOld do
                BitBlt(FBmp.Canvas.Handle, FSolidRect.Left, J, FChunkBmp.Width, FChunkBmp.Height,
                  FChunkBmp.Canvas.Handle, 0, 0, SRCCOPY);
            end
            else
            begin
              if (FRealShowOverload = True) then
              begin
                FRealBeginColor := FOverloadBeginColor;
                FRealEndColor := FOverloadEndColor;
              end;
              FBmp.Canvas.Pen.Color := GetColor(FRealBeginColor, FRealEndColor, FSolidRect.Bottom - FOld, FBarHeight);
              FBmp.Canvas.Brush.Color := GetColor(FRealBeginColor, FRealEndColor, FSolidRect.Bottom - FOld, FBarHeight);
              FBmp.Canvas.FillRect(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, FOld));
              PaintBarBevelOuter(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, FOld));
            end;
          end;
        end;
      end;

      if ((FBarStyle = cxbsBitmap) or (FBarStyle = cxbsBitmapLEDs)) and
        (FForegroundImage.Width > 0) and (FForegroundImage.Height > 0) then
      begin
        FBmp.Canvas.Brush.Bitmap := FForegroundImage;
        if FBarStyle = cxbsBitmap then
          FBmp.Canvas.FillRect(FSolidRect)
        else
        begin
          if FOrientation = cxorHorizontal then
          begin
            FRectWidth := FForegroundImage.Width;
            if FRectWidth > RectHeight(FSolidRect) then
              FRectWidth := RectHeight(FSolidRect);
            for I := FSolidRect.Left to FSolidRect.Right - 1 do
              if (((I - FSolidRect.Left) mod (FRectWidth + 2)) = 0) then
              begin
                FRealSolidRect.Right := I - 2;
                FBmp.Canvas.FillRect(FRealSolidRect);
                FRealSolidRect.Left := I;

                if FSolidRect.Right - I - 2 < FRectWidth then
                  FBmp.Canvas.FillRect(Rect(I, FSolidRect.Top, FSolidRect.Right, FSolidRect.Bottom));
              end;
            if FPosition = FMax then
            begin
              FRealSolidRect.Right := FSolidRect.Right;
              FBmp.Canvas.FillRect(FRealSolidRect);
            end;
          end
          else
          begin
            FRectHeight := FForegroundImage.Height;
            if FRectHeight > RectWidth(FSolidRect) then
              FRectHeight := RectWidth(FSolidRect);
            for I := FSolidRect.Bottom - 1 downto FSolidRect.Top do
              if (((FSolidRect.Bottom - I - 1) mod (FRectHeight - 2)) = 0) then
              begin
                FRealSolidRect.Top := I + 2;
                FBmp.Canvas.FillRect(FRealSolidRect);
                FRealSolidRect.Bottom := I;

                if I - FSolidRect.Top  < FRectHeight then
                  FBmp.Canvas.FillRect(Rect(FSolidRect.Left, FSolidRect.Top, FSolidRect.Right, I));
              end;
            if FPosition = FMax then
            begin
              FRealSolidRect.Top := FSolidRect.Top;
              FBmp.Canvas.FillRect(FRealSolidRect);
            end;
          end;
        end;
      end;

      if FRealShowPeak = True then
      begin
        FBmp.Canvas.Brush.Color := FPeakColor;
        FBmp.Canvas.FillRect(FDrawPeakBarRect);
      end;

      if FShowText then
      begin
        if FShowTextStyle = cxtsPosition then
          FBarText := FloatToStr(FPosition);
        if FShowTextStyle = cxtsPercent then
        begin
          FPercent := Round((FPosition-FMin) / MaxMinDiff(FMax, FMin) * 100);
          if FPercent > 100 then FPercent := 100;
          FBarText := IntToStr(FPercent)+ ' %';
        end;
        FBmp.Canvas.Font.Assign(Font);
        FBmp.Canvas.Font.Color := TextColor;
        FBmp.Canvas.Brush.Style := bsClear;
        FTextWidth := FBmp.Canvas.TextWidth(FBarText);
        FTextHeight := FBmp.Canvas.TextHeight(FBarText);
        if TextOrientation = cxorHorizontal then
        begin
          FTextDeltaX := ((FBarWidth - FTextWidth) div 2) + FDrawDelta;
          FTextDeltaY := ((FBarHeight - FTextHeight) div 2) + FDrawDelta;
          if (FTextDeltaX < FRealSolidRect.Right) and (SolidTextColor = False) then
          begin
            FTextBmp := TBitmap.Create;
            FTextSavedBmp := TBitmap.Create;
            try
              if (FRealSolidRect.Right - FTextDeltaX) < FTextWidth then
                FTextBmp.Width := (FRealSolidRect.Right - FTextDeltaX)
              else
                FTextBmp.Width := FTextWidth;
              FTextBmp.Height := FTextHeight;
              FTextSavedBmp.Width := FTextBmp.Width;
              FTextSavedBmp.Height := FTextHeight;
              FTextBmp.Canvas.Font.Assign(FBmp.Canvas.Font);
              FTextBmp.Canvas.Font.Color := clBlack;
              FTextBmp.Canvas.Brush.Color := clWhite;
              FTextBmp.Canvas.FillRect(FTextBmp.Canvas.ClipRect);
              FTextBmp.Canvas.TextOut(0, 0, FBarText);
              {Save original Background under Text}
              BitBlt(FTextSavedBmp.Canvas.Handle, 0, 0, FTextBmp.Width, FTextHeight,
                FBmp.Canvas.Handle, FTextDeltaX, FTextDeltaY, SRCCOPY);
              {Draw Inverted Background on Text}
              BitBlt(FTextBmp.Canvas.Handle, 0, 0, FTextBmp.Width, FTextHeight,
                FBmp.Canvas.Handle, FTextDeltaX, FTextDeltaY, DSTINVERT);
              FBmp.Canvas.TextOut(FTextDeltaX, FTextDeltaY, FBarText);
              FBmp.Canvas.CopyMode := cmSrcCopy;
              {Restore original Background}
              FBmp.Canvas.Draw(FTextDeltaX, FTextDeltaY, FTextSavedBmp);
              FBmp.Canvas.CopyMode := cmSrcInvert;
              {Draw inverted Text}
              FBmp.Canvas.Draw(FTextDeltaX, FTextDeltaY, FTextBmp);
            finally
              FTextSavedBmp.Free;
              FTextBmp.Free;
            end;
          end
          else
            FBmp.Canvas.TextOut(FTextDeltaX, FTextDeltaY, FBarText);
        end;
        if TextOrientation = cxorVertical then
        begin
          FLocalFont := TFont.Create;
          FLocalFont.Assign(Font);
          GetTextMetrics(FLocalFont.Handle, FTM);
          if (FTM.tmPitchAndFamily and TMPF_TRUETYPE) = 0 then
            FLocalFont.Name := 'Arial';
          cxGetFontData(FLocalFont.Handle, FLF);
          FLF.lfEscapement := 2700;
          FBmp.Canvas.Font.Handle := CreateFontIndirect(FLF);
          FTextDeltaX := FTextHeight + ((FBarWidth - FTextHeight) div 2) + FDrawDelta;
          FTextDeltaY := (FBarHeight - FTextWidth) div 2 + FDrawDelta;
          if (FRealSolidRect.Top < (FTextDeltaY + FTextWidth)) and (SolidTextColor = False) then
          begin
            FTextBmp := TBitmap.Create;
            FTextSavedBmp := TBitmap.Create;
            try
              FTextBmp.Height := FTextWidth;
              FTextBmp.Width := FTextHeight;
              FTextSavedBmp.Width := FTextBmp.Width;
              FTextSavedBmp.Height := FTextBmp.Height;
              FTextBmp.Canvas.Font.Assign(FBmp.Canvas.Font);
              FTextBmp.Canvas.Font.Color := clBlack;
              FTextBmp.Canvas.Brush.Color := clWhite;
              FTextBmp.Canvas.FillRect(FTextBmp.Canvas.ClipRect);
              if FRealSolidRect.Top < FTextDeltaY then
              begin
                FTextBmp.Canvas.TextOut(FTextBmp.Width, 0, FBarText);
                FTopX := FTextDeltaY;
              end else
              begin
                FTextBmp.Canvas.TextOut(FTextBmp.Width, FTextDeltaY - FRealSolidRect.Top, FBarText);
                FTopX := FRealSolidRect.Top;
              end;
              {Save original Background under Text}
              BitBlt(FTextSavedBmp.Canvas.Handle, 0, 0, FTextBmp.Width, FTextBmp.Height,
                     FBmp.Canvas.Handle, FTextDeltaX - FTextBmp.Width, FTopX, SRCCOPY);
              {Draw Inverted Background on Text}
              BitBlt(FTextBmp.Canvas.Handle, 0, 0, FTextBmp.Width, FTextBmp.Height,
                     FBmp.Canvas.Handle, FTextDeltaX - FTextBmp.Width, FTopX, DSTINVERT);
              FBmp.Canvas.TextOut(FTextDeltaX, FTextDeltaY, FBarText);
              FBmp.Canvas.CopyMode := cmSrcCopy;
              {Restore original Background}
              FBmp.Canvas.Draw(FTextDeltaX - FTextBmp.Width, FTopX, FTextSavedBmp);
              FBmp.Canvas.CopyMode := cmSrcInvert;
              {Draw inverted Text}
              FBmp.Canvas.Draw(FTextDeltaX - FTextBmp.Width, FTopX, FTextBmp);
            finally
              FTextSavedBmp.Free;
              FTextBmp.Free;
            end;
          end
          else
            FBmp.Canvas.TextOut(FTextDeltaX, FTextDeltaY, FBarText);

          FLocalFont.Free;
        end;
      end;
      BitBlt(ACanvas.Canvas.Handle, BarRect.Left, BarRect.Top,
        FBarWidth, FBarHeight,
        FBmp.Canvas.Handle, FDrawDelta, FDrawDelta, SRCCOPY);
    finally
      FChunkBmp.Free;
      FBmp.Free;
    end;
  finally
    RestoreCanvasFont(ACanvas, APrevLogFont);
  end;
end;
{ TcxCustomProgressBarViewInfo }

{ TcxCustomProgressBarViewData }
procedure TcxCustomProgressBarViewData.CalculateViewInfoProperties(AViewInfo: TcxCustomEditViewInfo);
begin
  with TcxCustomProgressBarViewInfo(AViewInfo) do
  begin
    BeginColor := ColorToRGB(Properties.BeginColor);
    EndColor := ColorToRGB(Properties.EndColor);
    BarBevelOuter := Properties.BarBevelOuter;
    Min := Properties.Min;
    Max := Properties.Max;
    Orientation := Properties.Orientation;
    ShowText := Properties.ShowText;
    ShowTextStyle := Properties.ShowTextStyle;
    TextOrientation := Properties.TextOrientation;
    SolidTextColor := Properties.SolidTextColor;
    BarStyle := Properties.BarStyle;
    BorderWidth := Properties.BorderWidth;
    OverloadValue := Properties.OverloadValue;
    OverloadBeginColor := ColorToRGB(Properties.OverloadBeginColor);
    OverloadEndColor := ColorToRGB(Properties.OverloadEndColor);
    ShowOverload := Properties.ShowOverload;
    PeakValue := Properties.GetRealPeakValue(Position);
    PeakColor := ColorToRGB(Properties.PeakColor);
    PeakSize := Properties.PeakSize;
    ShowPeak := Properties.ShowPeak;
    if IsInplace then
      PropTransparent := Transparent
    else
      PropTransparent := TcxCustomProgressBar(Edit).Transparent;
  end;
end;

procedure TcxCustomProgressBarViewData.Calculate(ACanvas: TcxCanvas; const ABounds: TRect;
  const P: TPoint; Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
  AIsMouseEvent: Boolean);
var
  FBounds : TRect;
  FViewInfo : TcxCustomProgressBarViewInfo;
  FRealNativeStyle: Boolean;
  FBmp: TBitmap;
begin
  inherited Calculate(ACanvas, ABounds, P, Button, Shift, AViewInfo, AIsMouseEvent);
  if (ABounds.Bottom = MaxInt) or (ABounds.Right = MaxInt) then Exit;
  FViewInfo := TcxCustomProgressBarViewInfo(AViewInfo);
  CalculateViewInfo(FViewInfo, AIsMouseEvent);
  FViewInfo.Font := Style.GetVisibleFont;
  CalculateViewInfoProperties(AViewInfo);
  {$IFDEF VCL}
  if AreVisualStylesMustBeUsed(NativeStyle, totProgress) then
  begin
    FBounds := ABounds;
    FRealNativeStyle := True;
    FViewInfo.BarRect := ABounds;
    if IsInplace then
      InflateRectEx(FBounds, (AViewInfo.BorderWidth + 2), (AViewInfo.BorderWidth + 2),
        -(AViewInfo.BorderWidth + 2), -(AViewInfo.BorderWidth + 2))
    else
      InflateRectEx(FBounds, (AViewInfo.BorderWidth + 3), (AViewInfo.BorderWidth + 3),
        -(AViewInfo.BorderWidth + 2), -(AViewInfo.BorderWidth + 2));
    FViewInfo.ProgressBarRect := FBounds;
  end
  else
  {$ENDIF}
  begin
    if IsInplace then
      FViewInfo.BarRect := ABounds
    else
      FViewInfo.BarRect := FViewInfo.BorderRect;
    FBounds := FViewInfo.BorderRect;
    FRealNativeStyle := False;
    InflateRect(FBounds, -AViewInfo.BorderWidth, -AViewInfo.BorderWidth);
    FViewInfo.ProgressBarRect := FBounds;
  end;
  FViewInfo.NativeStyle := FRealNativeStyle;
  CalculateCustomProgressBarViewInfo(ACanvas, Self, FViewInfo);

  if FViewInfo.FOrientation = cxorHorizontal then
    FViewInfo.ProgressBarRect.Right := FBounds.Left +
      CalculateDelta(FViewInfo.Position - FViewInfo.Min, RectWidth(FBounds),
        MaxMinDiff(FViewInfo.Max, FViewInfo.Min))
  else
    FViewInfo.ProgressBarRect.Top := FBounds.Bottom -
      CalculateDelta((FViewInfo.Position - FViewInfo.Min), RectHeight(FBounds),
        MaxMinDiff(FViewInfo.Max, FViewInfo.Min));

  FViewInfo.FRealShowOverload := False;
  if (Properties.ShowOverload) and (not FRealNativeStyle) and
    (FViewInfo.Position >= FViewInfo.OverloadValue) then
  begin
    FViewInfo.FRealShowOverload := True;
    FViewInfo.OverloadBarRect := FViewInfo.ProgressBarRect;
    if FViewInfo.FOrientation = cxorHorizontal then
    begin
      FViewInfo.OverloadBarRect.Left := FBounds.Left +
        CalculateDelta(FViewInfo.OverloadValue - FViewInfo.Min, RectWidth(FBounds),
          MaxMinDiff(FViewInfo.Max, FViewInfo.Min));
      if FViewInfo.OverloadBarRect.Right > FBounds.Right then
        FViewInfo.OverloadBarRect.Right := FBounds.Right;
      FViewInfo.ProgressBarRect.Right := FViewInfo.OverloadBarRect.Left;
    end else
    begin
      FViewInfo.OverloadBarRect.Top := FViewInfo.OverloadBarRect.Bottom -
        CalculateDelta(FViewInfo.Position - FViewInfo.Min, RectHeight(FBounds),
          MaxMinDiff(FViewInfo.Max, FViewInfo.Min));
      FViewInfo.OverloadBarRect.Bottom := FViewInfo.OverloadBarRect.Bottom -
        CalculateDelta(FViewInfo.OverloadValue - FViewInfo.Min, RectHeight(FBounds),
          MaxMinDiff(FViewInfo.Max, FViewInfo.Min));
      if FViewInfo.OverloadBarRect.Bottom < FBounds.Top then
        FViewInfo.OverloadBarRect.Bottom := FBounds.Top;
      FViewInfo.ProgressBarRect.Top := FViewInfo.OverloadBarRect.Bottom;
    end;
  end;

  FViewInfo.FRealShowPeak := FViewInfo.ShowPeak;
  FViewInfo.PeakBarRect := FViewInfo.ProgressBarRect;
  if FViewInfo.FOrientation = cxorHorizontal then
  begin
    FViewInfo.PeakBarRect.Left := FBounds.Left +
      CalculateDelta(FViewInfo.PeakValue - FViewInfo.Min, RectWidth(FBounds),
        MaxMinDiff(FViewInfo.Max, FViewInfo.Min));
    if (FViewInfo.PeakBarRect.Left + FViewInfo.PeakSize) > FBounds.Right then
      FViewInfo.PeakBarRect.Left := FBounds.Right - FViewInfo.PeakSize;
    FViewInfo.PeakBarRect.Right := FViewInfo.PeakBarRect.Left + FViewInfo.PeakSize;
  end
  else
  begin
    FViewInfo.PeakBarRect.Bottom := FBounds.Bottom -
      CalculateDelta(FViewInfo.PeakValue - FViewInfo.Min, RectHeight(FBounds),
        MaxMinDiff(FViewInfo.Max, FViewInfo.Min));
    if (FViewInfo.PeakBarRect.Bottom - FViewInfo.PeakSize) < FBounds.Top then
      FViewInfo.PeakBarRect.Bottom := FBounds.Top + FViewInfo.PeakSize;
    FViewInfo.PeakBarRect.Top := FViewInfo.PeakBarRect.Bottom - FViewInfo.PeakSize;
  end;

  FViewInfo.ForegroundImage.Assign(Properties.ForegroundImage);
  if Properties.TransparentImage then
  begin
    FBmp := TBitmap.Create;
    try
      FViewInfo.ForegroundImage.Transparent := True;
      FBmp.Width := FViewInfo.ForegroundImage.Width;
      FBmp.Height := FViewInfo.ForegroundImage.Height;
      FBmp.Canvas.Brush.Color := FViewInfo.BackgroundColor;
      FBmp.Canvas.FillRect(FBmp.Canvas.ClipRect);
      FBmp.Canvas.Draw(0, 0, FViewInfo.ForegroundImage);
      FViewInfo.ForegroundImage.Assign(FBmp);
    finally
      FBmp.Free;
    end;
  end;

  if not IsInplace then FViewInfo.DrawSelectionBar := False;
end;

procedure TcxCustomProgressBarViewData.EditValueToDrawValue(ACanvas: TcxCanvas;
  const AEditValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo);
var
  ADisplayValue: TcxEditValue;
begin
  CalculateCustomProgressBarViewInfo(ACanvas, Self,
    TcxCustomProgressBarViewInfo(AViewInfo));
  if PreviewMode then
    Properties.PrepareDisplayValue(30, ADisplayValue, InternalFocused)
  else
    Properties.PrepareDisplayValue(AEditValue, ADisplayValue, InternalFocused);
  TcxCustomProgressBarViewInfo(AViewInfo).Position := ADisplayValue;
  Properties.CorrectPositionWithMaxMin(TcxCustomProgressBarViewInfo(AViewInfo));
end;

function TcxCustomProgressBarViewData.InternalGetEditConstantPartSize(ACanvas: TcxCanvas;
  AIsInplace: Boolean; AEditSizeProperties: TcxEditSizeProperties;
  var MinContentSize: TSize; AViewInfo: TcxCustomEditViewInfo): TSize;
var
  APrevLogFont: TLogFont;
  ASize1, ASize2: TSize;
  AText: string;
begin
  SaveCanvasFont(ACanvas, APrevLogFont);
  try
    Result := inherited InternalGetEditConstantPartSize(ACanvas, AIsInplace,
      AEditSizeProperties, MinContentSize, AViewInfo);

    with TcxCustomProgressBarViewInfo(AViewInfo) do
    begin
      ASize1.cx := RectWidth(ProgressBarRect);

      if not(IsInplace or
        AreVisualStylesMustBeUsed(AViewInfo.NativeStyle, totButton)) then
          ASize1.cx := ASize1.cx + 4;

      AText := '';
      ASize2 := GetTextEditContentSize(ACanvas, Self, AText,
        DrawTextFlagsTocxTextOutFlags(cxTextOutFlagsToDrawTextFlags(GetDrawTextFlags) and
          not(CXTO_CENTER_VERTICALLY or CXTO_BOTTOM) or CXTO_TOP), AEditSizeProperties, 0, False);
      ASize2.cx := ASize2.cx + 3;
      ASize1.cx := ASize1.cx + ASize2.cx;
      ASize1.cy := ASize2.cy;
    end;
    Result.cx := Result.cx + ASize1.cx;
    Result.cy := Result.cy + ASize1.cy;
  finally
    RestoreCanvasFont(ACanvas, APrevLogFont);
  end;
end;

function TcxCustomProgressBarViewData.GetDrawTextFlags: Integer;
begin
  Result := 0;
end;

function TcxCustomProgressBarViewData.GetIsEditClass: Boolean;
begin
  Result := False;
end;

function TcxCustomProgressBarViewData.GetProperties: TcxCustomProgressBarProperties;
begin
  Result := TcxCustomProgressBarProperties(FProperties);
end;

{ TProgressBarPropertiesValues }

function TcxProgressBarPropertiesValues.GetMax: Boolean;
begin
  Result := MaxValue;
end;

function TcxProgressBarPropertiesValues.GetMin: Boolean;
begin
  Result := MinValue;
end;

function TcxProgressBarPropertiesValues.IsMaxStored: Boolean;
begin
  Result := Max and (TcxCustomProgressBarProperties(Properties).Max = 0);
end;

function TcxProgressBarPropertiesValues.IsMinStored: Boolean;
begin
  Result := Min and (TcxCustomProgressBarProperties(Properties).Min = 0);
end;

procedure TcxProgressBarPropertiesValues.SetMax(Value: Boolean);
begin
  MaxValue := Value;
end;

procedure TcxProgressBarPropertiesValues.SetMin(Value: Boolean);
begin
  MinValue := Value;
end;

{ TcxCustomProgressBarProperties }

constructor TcxCustomProgressBarProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
//  FCurrentPosition := 0;
  FBeginColor := clNavy;
  FEndColor := clWhite;
  FBarBevelOuter := cxbvNone;
  FPeakValue := 0;
  FOverloadValue := 80;
  FPeakSize := 2;
  FOrientation := cxorHorizontal;
  FShowText := True;
  FShowTextStyle := cxtsPercent;
  FTextOrientation := cxorHorizontal;
  FSolidTextColor := False;
  FBarStyle := cxbsSolid;
  FTransparentImage := True;
  FOverloadValue := 80;
  FBorderWidth := 0;
  FShowOverload := False;
  FOverloadBeginColor := $008080FF;
  FOverloadEndColor := clFuchsia;
  FShowPeak := False;
  FPeakColor := clRed;
end;

destructor TcxCustomProgressBarProperties.Destroy;
begin
  if FForegroundImage <> nil then
    FreeAndNil(FForegroundImage);
  inherited Destroy;
end;

procedure TcxCustomProgressBarProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomProgressBarProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TcxCustomProgressBarProperties do
      begin
        Self.BeginColor := BeginColor;
        Self.BarBevelOuter := BarBevelOuter;
        Self.EndColor := EndColor;
        Self.ForegroundImage := ForegroundImage;
        Self.Min := Min;
        Self.Max := Max;
        Self.Orientation := Orientation;
        Self.ShowText := ShowText;
        Self.ShowTextStyle := ShowTextStyle;
        Self.TextOrientation := TextOrientation;
        Self.SolidTextColor := SolidTextColor;
        Self.BarStyle := BarStyle;
        Self.TransparentImage := TransparentImage;
        Self.BorderWidth := BorderWidth;
        Self.OverloadValue := OverloadValue;
        Self.ShowOverload := ShowOverload;
        Self.OverloadBeginColor := OverloadBeginColor;
        Self.OverloadEndColor := OverloadEndColor;
        Self.PeakValue := PeakValue;
        Self.ShowPeak := ShowPeak;
        Self.PeakColor := PeakColor;
        Self.PeakSize := PeakSize;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

function TcxCustomProgressBarProperties.CanCompareEditValue: Boolean;
begin
  Result := True;
end;

class function TcxCustomProgressBarProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxProgressBar;
end;

function TcxCustomProgressBarProperties.GetDisplayText(const AEditValue: TcxEditValue;
  AFullText: Boolean = False; AIsInplace: Boolean = True): WideString;
var
  ADisplayValue: TcxEditValue;
begin
  PrepareDisplayValue(AEditValue, ADisplayValue, False);
  if FShowTextStyle = cxtsPercent then
    ADisplayValue := VarToStr(ADisplayValue) + ' %';
  Result := VarToStr(ADisplayValue);
end;

function TcxCustomProgressBarProperties.GetSupportedOperations: TcxEditSupportedOperations;
begin
  Result := [esoAlwaysHotTrack, esoFiltering, esoSorting];
end;

class function TcxCustomProgressBarProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxCustomProgressBarViewInfo;
end;

function TcxCustomProgressBarProperties.IsEditValueValid(var EditValue: TcxEditValue;
  AEditFocused: Boolean): Boolean;
begin
  Result := inherited IsEditValueValid(EditValue, AEditFocused);
end;

procedure TcxCustomProgressBarProperties.PrepareDisplayValue(const AEditValue:
  TcxEditValue; var DisplayValue: TcxEditValue; AEditFocused: Boolean);
var
  AValue: Double;
  ACode: Integer;
begin
  DisplayValue := 0;
  if VarIsStr(AEditValue) then
  begin
    Val(VarToStr(AEditValue), AValue, ACode);
    if ACode = 0 then
      DisplayValue := AValue;
  end
  else
    if VarIsNumericEx(AEditValue) or VarIsDate(AEditValue) then
      DisplayValue := AEditValue;
//  PrepareCurrentPosition(DisplayValue);
end;

procedure TcxCustomProgressBarProperties.CorrectPositionWithMaxMin(
  AViewInfo: TcxCustomProgressBarViewInfo);
begin
  if Min < Max then
    if AViewInfo.Position < Min then
      AViewInfo.Position := Min
    else
      if AViewInfo.Position > Max then
        AViewInfo.Position := Max;
end;

class function TcxCustomProgressBarProperties.GetAssignedValuesClass: TcxCustomEditPropertiesValuesClass;
begin
  Result := TcxProgressBarPropertiesValues;
end;

function TcxCustomProgressBarProperties.GetMaxValue: Double;
begin
  if AssignedValues.Max then
    Result := inherited GetMaxValue
  else
    Result := 100;
end;

function TcxCustomProgressBarProperties.GetMinValue: Double;
begin
  if AssignedValues.Min then
    Result := inherited GetMinValue
  else
    Result := 0;
end;

class function TcxCustomProgressBarProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
  Result := TcxCustomProgressBarViewData;
end;

function TcxCustomProgressBarProperties.HasDisplayValue: Boolean;
begin
  Result := True;
end;

function TcxCustomProgressBarProperties.GetAssignedValues: TcxProgressBarPropertiesValues;
begin
  Result := TcxProgressBarPropertiesValues(FAssignedValues);
end;

function TcxCustomProgressBarProperties.GetForegroundImage: TBitmap;
begin
  if FForegroundImage = nil then
  begin
    FForegroundImage := TBitmap.Create;
    FForegroundImage.OnChange := ForegroundImageChanged;
  end;
  Result := FForegroundImage;
end;

procedure TcxCustomProgressBarProperties.ForegroundImageChanged(Sender: TObject);
begin
  Changed;
end;

function TcxCustomProgressBarProperties.GetMax: Double;
begin
  Result := MaxValue;
end;

function TcxCustomProgressBarProperties.GetMin: Double;
begin
  Result := MinValue;
end;

function TcxCustomProgressBarProperties.GetOverloadValueStored: Boolean;
begin
  Result := FOverloadValue <> 80;
end;

function TcxCustomProgressBarProperties.GetPeakValueStored: Boolean;
begin
  Result := FPeakValue <> 0;
end;

procedure TcxCustomProgressBarProperties.SetAssignedValues(
  Value: TcxProgressBarPropertiesValues);
begin
  FAssignedValues.Assign(Value);
end;

procedure TcxCustomProgressBarProperties.SetBeginColor(Value: TColor);
begin
  if FBeginColor <> Value then
  begin
    FBeginColor := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetBarBevelOuter(Value: TcxProgressBarBevelOuter);
begin
  if FBarBevelOuter <> Value then
  begin
    FBarBevelOuter := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetEndColor(Value: TColor);
begin
  if Value <> FEndColor then
  begin
    FEndColor := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetForegroundImage(Value: TBitmap);
begin
  if Value = nil then
    FreeAndNil(FForegroundImage)
  else
    ForegroundImage.Assign(Value);
  Changed;
end;

procedure TcxCustomProgressBarProperties.SetMax(Value: Double);
begin
  MaxValue := Value;
  PostMaxValue;
end;

procedure TcxCustomProgressBarProperties.SetMin(Value: Double);
begin
  MinValue := Value;
  PostMinValue;
end;

procedure TcxCustomProgressBarProperties.SetOverloadValue(Value: Double);
begin
  if FOverloadValue <> Value then
  begin
    FOverloadValue := Value;
    PostOverloadValue;
    Changed;
  end;
end;

function TcxCustomProgressBarProperties.GetRealPeakValue(APosition: Double): Double;
begin
  Result := FPeakValue;
  if Result < Min then
    Result := Min;
  if Result > Max then
    Result := Max;
  if Result < APosition then
    Result := APosition;
  if Result > FPeakValue then
    FPeakValue := Result;
end;

function TcxCustomProgressBarProperties.IsMaxStored: Boolean;
begin
  Result := IsMaxValueStored;
end;

function TcxCustomProgressBarProperties.IsMinStored: Boolean;
begin
  Result := IsMinValueStored;
end;

procedure TcxCustomProgressBarProperties.SetPeakValue(Value: Double);
begin
  if FPeakValue <> Value then
  begin
    FPeakValue := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.PostMinValue;
begin
  if Min > Max then Max := Min;
//  if FCurrentPosition < FMin then FCurrentPosition := FMin;
  if FOverloadValue < Min then FOverloadValue := Min;
  if FPeakValue < Min then FPeakValue := Min;
end;

procedure TcxCustomProgressBarProperties.PostMaxValue;
begin
  if Min > Max then Min := Max;
//  if FCurrentPosition > FMax then FCurrentPosition := FMax;
  if FOverloadValue > Max then FOverloadValue := Max;
  if FPeakValue > Max then FPeakValue := Max;
end;

procedure TcxCustomProgressBarProperties.PostOverloadValue;
begin
  if FOverloadValue < Min then
    FOverloadValue := Min;
  if FOverloadValue > Max then
    FOverloadValue := Max;
end;

procedure TcxCustomProgressBarProperties.SetOrientation(Value: TcxProgressBarOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetShowText(Value: Boolean);
begin
  if FShowText <> Value then
  begin
    FShowText := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetShowTextStyle(Value: TcxProgressBarTextStyle);
begin
  if FShowTextStyle <> Value then
  begin
    FShowTextStyle := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetTextOrientation(Value: TcxProgressBarOrientation);
begin
  if FTextOrientation <> Value then
  begin
    FTextOrientation := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetSolidTextColor(Value: Boolean);
begin
  if FSolidTextColor <> Value then
  begin
    FSolidTextColor := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetBarStyle(Value: TcxProgressBarBarStyle);
begin
  if FBarStyle <> Value then
  begin
    FBarStyle := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetTransparentImage(Value: Boolean);
begin
  if FTransparentImage <> Value then
  begin
    FTransparentImage := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetBorderWidth(Value: TcxBorderWidth);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetShowOverload(Value: Boolean);
begin
  if FShowOverload <> Value then
  begin
    FShowOverload := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetOverloadBeginColor(Value: TColor);
begin
  if FOverloadBeginColor <> Value then
  begin
    FOverloadBeginColor := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetOverloadEndColor(Value: TColor);
begin
  if FOverloadEndColor <> Value then
  begin
    FOverloadEndColor := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetShowPeak(Value: Boolean);
begin
  if FShowPeak <> Value then
  begin
    FShowPeak := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetPeakColor(Value: TColor);
begin
  if FPeakColor <> Value then
  begin
    FPeakColor := Value;
    Changed;
  end;
end;

procedure TcxCustomProgressBarProperties.SetPeakSize(Value: TcxNaturalNumber);
begin
  if FPeakSize <> Value then
  begin
    FPeakSize := Value;
    Changed;
  end;
end;

{ TcxCustomProgressBar }

class function TcxCustomProgressBar.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomProgressBarProperties;
end;

procedure TcxCustomProgressBar.CheckEditorValueBounds;
var
  AValue: Variant;
begin
  KeyboardAction := True;
  try
    with ActiveProperties do
      if Min < Max then
      begin
        PrepareDisplayValue(FEditValue, AValue, Focused);
        if AValue < Min then
          InternalSetEditValue(Min, False)
        else
          if AValue > Max then
            InternalSetEditValue(Max, False);
      end;     
  finally
    KeyboardAction := False;
  end;
end;

procedure TcxCustomProgressBar.CheckEditValue;
begin
  if not(IsInplace or IsDBEdit or PropertiesChangeLocked) then
    CheckEditorValueBounds;
end;

function TcxCustomProgressBar.DefaultParentColor: Boolean;
begin
  Result := True;
end;

procedure TcxCustomProgressBar.FillSizeProperties(var AEditSizeProperties: TcxEditSizeProperties);
begin
  AEditSizeProperties := DefaultcxEditSizeProperties;
  AEditSizeProperties.MaxLineCount := 1;
  AEditSizeProperties.Width := ViewInfo.TextRect.Right - ViewInfo.TextRect.Left;
end;

procedure TcxCustomProgressBar.Initialize;
begin
  inherited Initialize;
  ControlStyle := ControlStyle - [csDoubleClicks, csCaptureMouse, csClickEvents];
  Width := 121;
  Height := 21;
end;

function TcxCustomProgressBar.InternalGetNotPublishedStyleValues: TcxEditStyleValues;
begin
  Result := inherited InternalGetNotPublishedStyleValues;
  Include(Result, svHotTrack);
end;

procedure TcxCustomProgressBar.SynchronizeDisplayValue;
var
  ADisplayValue: TcxEditValue;
begin
  ActiveProperties.PrepareDisplayValue(FEditValue, ADisplayValue, Focused);
  TcxCustomProgressBarViewInfo(ViewInfo).Position := ADisplayValue;
  if ActiveProperties.Transparent then
    Invalidate;
//  if not (IsInplace and (ActiveProperties.ShowTextStyle = cxtsPosition)) then
  ActiveProperties.CorrectPositionWithMaxMin(ViewInfo);
  ShortRefreshContainer(False);
end;

procedure TcxCustomProgressBar.PropertiesChanged(Sender: TObject);
begin
  CheckEditValue;
//  if not (IsInplace and (ActiveProperties.ShowTextStyle = cxtsPosition)) then
  ActiveProperties.CorrectPositionWithMaxMin(ViewInfo);
  inherited PropertiesChanged(Sender);
  if ActiveProperties.Transparent then
    Invalidate;
end;

function TcxCustomProgressBar.CanFocus: Boolean;
begin
  Result := IsInplace;
end;

function TcxCustomProgressBar.CanFocusOnClick: Boolean;
begin
  Result := inherited CanFocusOnClick and IsInplace;
end;

function TcxCustomProgressBar.GetPosition: Double;
begin
  Result := ViewInfo.Position;
end;

function TcxCustomProgressBar.GetPositionStored: Boolean;
begin
  Result := ViewInfo.Position <> 0;
end;

function TcxCustomProgressBar.GetProperties: TcxCustomProgressBarProperties;
begin
  Result := TcxCustomProgressBarProperties(FProperties);
end;

function TcxCustomProgressBar.GetActiveProperties: TcxCustomProgressBarProperties;
begin
  Result := TcxCustomProgressBarProperties(InternalGetActiveProperties);
end;

function TcxCustomProgressBar.GetViewInfo: TcxCustomProgressBarViewInfo;
begin
  Result := TcxCustomProgressBarViewInfo(FViewInfo);
end;

procedure TcxCustomProgressBar.SetProperties(
  Value: TcxCustomProgressBarProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomProgressBar.SetPosition(Value: Double);
begin
  if Value = ViewInfo.Position then
    Exit;
  with ActiveProperties do
    if (not IsLoading) and (Min < Max) then
    begin
      if Value < Min then
        Value := Min;
      if Value > Max then
        Value := Max;
    end;
  EditValue := Value;
end;

{ TcxProgressBar }

class function TcxProgressBar.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxProgressBarProperties;
end;

function TcxProgressBar.GetActiveProperties: TcxProgressBarProperties;
begin
  Result := TcxProgressBarProperties(InternalGetActiveProperties);
end;

function TcxProgressBar.GetProperties: TcxProgressBarProperties;
begin
  Result := TcxProgressBarProperties(FProperties);
end;

procedure TcxProgressBar.SetProperties(Value: TcxProgressBarProperties);
begin
  FProperties.Assign(Value);
end;

{ TcxFilterProgressBarHelper }

class procedure TcxFilterProgressBarHelper.InitializeProperties(AProperties,
  AEditProperties: TcxCustomEditProperties; AHasButtons: Boolean);
begin
  inherited InitializeProperties(AProperties, AEditProperties, AHasButtons);
  with TcxCustomSpinEditProperties(AProperties) do
  begin
    Buttons.Add;
    Buttons.Add;
    MinValue := TcxCustomProgressBarProperties(AEditProperties).Min;
    MaxValue := TcxCustomProgressBarProperties(AEditProperties).Max;
  end;
end;

initialization
  GetRegisteredEditProperties.Register(TcxProgressBarProperties, scxSEditRepositoryProgressBarItem);
  FilterEditsController.Register(TcxProgressBarProperties, TcxFilterProgressBarHelper);

finalization
  FilterEditsController.Unregister(TcxProgressBarProperties, TcxFilterProgressBarHelper);
  GetRegisteredEditProperties.Unregister(TcxProgressBarProperties);

end.

