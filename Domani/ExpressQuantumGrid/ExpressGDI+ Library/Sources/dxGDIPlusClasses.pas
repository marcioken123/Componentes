{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       GDI+ Library                                                }
{                                                                   }
{       Copyright (c) 2002-2007 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE GDIPLUS LIBRARY AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxGDIPlusClasses;

{$I cxVer.inc}

interface

uses
  Windows, Classes, SysUtils, Graphics, dxGDIPlusAPI, ActiveX;

{$IFNDEF CLR}

type
  TdxGPBrush = class(TdxGPBase)
  private
    FNativeBrush: GpBrush;
    FLastResult: TdxGPStatus;
  protected
    constructor CreateNative (nativeBrush: GpBrush; AStatus: Status);
    procedure SetNativeBrush(ANativeBrush: GpBrush);
    function SetStatus(AStatus: TdxGPStatus): TdxGPStatus;
  public
    constructor Create;
    destructor Destroy; override;
    function Clone: TdxGPBrush; virtual;
    function GetType: BrushType;
    function GetLastStatus: Status;
  end;

  TdxGPSolidBrush = class(TdxGPBrush)
  private
    function GetColor: DWORD;
    procedure SetColor(const Value: DWORD);
  public
    constructor Create; overload;
    constructor Create(color: TColor); overload;
    property Color: DWORD read GetColor write SetColor;
  end;

  TdxGPTextureBrush = class(TdxGPBrush)
  end;

  TdxGPLinearGradientBrush = class(TdxGPBrush)
  private
    procedure SetWrapMode(const Value: TdxGPWrapMode);
    function GetWrapMode: TdxGPWrapMode;
  public
    constructor Create; overload;
    constructor Create(rect: TdxGPRect; color1, color2: DWORD; mode: TdxGPLinearGradientMode); overload;
    function SetLinearColors(color1, color2: DWORD): TdxGPStatus;
    function GetLinearColors(out color1, color2: DWORD): TdxGPStatus;
    function GetRectangle: TdxGPRect; overload;
    property WrapMode: TdxGPWrapMode read GetWrapMode write SetWrapMode;
  end;

  TdxGPHatchBrush = class(TdxGPBrush)
  public
    constructor Create; overload;
    constructor Create(hatchStyle: TdxGPHatchStyle; foreColor: DWORD; backColor: DWORD); overload;
    function GetHatchStyle: TdxGPHatchStyle;
    function GetForegroundColor: DWORD;
    function GetBackgroundColor: DWORD;
  end;

  TdxGPPen = class(TdxGPBase)
  private
    FNativePen: GpPen;
    FLastResult: TdxGPStatus;

    function GetAlignment: TdxGPPenAlignment;
    function GetColor: DWORD;
    function GetBrush: TdxGPBrush;
    function GetWidth: Single;
    procedure SetAlignment(const Value: TdxGPPenAlignment);
    procedure SetColor(const Value: DWORD);
    procedure SetBrush(const Value: TdxGPBrush);
    procedure SetWidth(const Value: Single);
  protected
    procedure SetNativePen(ANativePen: GpPen);
    function SetStatus(status: TdxGPStatus): TdxGPStatus;
  public
    constructor Create(color: DWORD; width: Single = 1.0); overload;
    constructor Create(brush: TdxGPBrush; width: Single = 1.0); overload;
    destructor Destroy; override;
    function GetLastStatus: TdxGPStatus;
    function GetPenType: TdxGPPenType;
    property ALignment: TdxGPPenAlignment read GetAlignment write SetAlignment;
    property Brush: TdxGPBrush read GetBrush write SetBrush;
    property Color: DWORD read GetColor write SetColor;
    property Width: Single read GetWidth write SetWidth;
  end;

  TdxGPGraphics = class(TdxGPBase)
  private
    FNativeGraphics: GpGraphics;
    FLastResult: TdxGPStatus;
  protected
    procedure SetNativeGraphics(AGraphics: GpGraphics);
    function SetStatus(status: TdxGPStatus): TdxGPStatus;
    function GetNativeGraphics: GpGraphics;
    function GetNativePen(pen: TdxGPPen): GpPen;
  public
    constructor Create(hdc: HDC); overload;
    destructor Destroy; override;
    function GetHDC: HDC;
    procedure ReleaseHDC(hdc: HDC);
    function GetLastStatus: TdxGPStatus;

    function DrawLine(pen: TdxGPPen; x1, y1, x2, y2: Integer): TdxGPStatus; overload;
    function DrawLine(pen: TdxGPPen; const pt1, pt2: TdxGPPoint): TdxGPStatus; overload;
    function DrawArc(pen: TdxGPPen; const rect: TdxGPRect; startAngle, sweepAngle: Single): TdxGPStatus; overload;
    function DrawBezier(pen: TdxGPPen; x1, y1, x2, y2, x3, y3, x4, y4: Integer): TdxGPStatus; overload;
    function DrawBezier(pen: TdxGPPen; const pt1, pt2, pt3, pt4: TdxGPPoint): TdxGPStatus; overload;
    function DrawRectangle(pen: TdxGPPen; const rect: TdxGPRect): TdxGPStatus; overload;
    function DrawEllipse(pen: TdxGPPen; const rect: TdxGPRect): TdxGPStatus; overload;
    function DrawPie(pen: TdxGPPen; const rect: TdxGPRect; startAngle, sweepAngle: Single): TdxGPStatus; overload;
    function DrawPolygon(pen: TdxGPPen; points: PdxGPPoint; count: Integer): TdxGPStatus; overload;
    function DrawCurve(pen: TdxGPPen; points: PdxGPPoint; count: Integer; tension: Single): TdxGPStatus; overload;
    function DrawClosedCurve(pen: TdxGPPen; points: PdxGPPoint; count: Integer; tension: Single): TdxGPStatus; overload;
    function Clear(color: TColor): TdxGPStatus;
    procedure FillRectangle(brush: TdxGPBrush; const rect: TdxGPRect);
    function FillPolygon(brush: TdxGPBrush; points: PdxGPPoint; count: Integer): TdxGPStatus; overload;
    function FillEllipse(brush: TdxGPBrush; const rect: TdxGPRect): TdxGPStatus; overload;
    function FillPie(brush: TdxGPBrush; const rect: TdxGPRect; startAngle, sweepAngle: Single): TdxGPStatus; overload;
    function FillClosedCurve(brush: TdxGPBrush; points: PdxGPPoint; count: Integer): TdxGPStatus; overload;
  end;

  TdxRGBColors = array of TRGBQuad;

  TdxGPImage = class(TdxGPBase)
  private
    FBits: TdxRGBColors;
    FHandle: GpImage;
  private
    function GetBitmapBits(ABitmap: TBitmap): TdxRGBColors;
    procedure LoadFromDataStream(AStream: TStream); virtual;
  public
    constructor CreateFromBitmap(ABitmap: TBitmap); virtual;
    constructor CreateFromPattern(const AWidth, AHeight: Integer;
      const ABits: TdxRGBColors; AHasAlphaChannel: Boolean); virtual;
    constructor CreateFromStream(AStream: TStream); virtual;
    destructor Destroy; override;
    function Clone: TdxGPImage;
    procedure SaveToStream(AStream: TStream);

    property Handle: GpImage read FHandle;
  end;

  TdxPNGImage = class(TGraphic)
  private
    FHandle: TdxGPImage;
    procedure SetHandle(AHandle: TdxGPImage);
  protected
    procedure Draw(ACanvas: TCanvas; const ARect: TRect); override;
    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetSize: TSize;
    function GetTransparent: Boolean; override;
    function GetWidth: Integer; override;
    procedure SetWidth(Value: Integer); override;
    procedure SetHeight(Value: Integer); override;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    class function CreateFromBitmap(ASource: TBitmap): TdxGPImage;
    procedure DrawEx(Graphics: GpGraphics; const ADest, ASource: TRect);
    function GetAsBitmap: TBitmap; virtual;
    procedure SetBitmap(ABitmap: TBitmap); virtual;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
      var APalette: HPALETTE); override;
    procedure StretchDraw(DC: HDC; const ADest: TRect); overload; virtual;
    procedure StretchDraw(DC: HDC; const ADest, ASource: TRect); overload; virtual;
    procedure StretchDrawEx(Graphics: GpGraphics; const ADest, ASource: TRect); virtual;

    property Handle: TdxGPImage read FHandle write SetHandle;
  end;


{$ENDIF}

implementation

{$IFNDEF CLR}

{ TdxGPBrush }

constructor TdxGPBrush.Create;
begin
  SetStatus(NotImplemented);
  FNativeBrush := nil;
end;

destructor TdxGPBrush.Destroy;
begin
  GdipDeleteBrush(FNativeBrush);
  inherited;
end;

constructor TdxGPBrush.CreateNative(nativeBrush: GpBrush; AStatus: Status);
begin
  inherited Create;
  FLastResult := AStatus;
  SetNativeBrush(FNativeBrush);
end;

function TdxGPBrush.Clone: TdxGPBrush;
var
  gpB: GpBrush;
begin
  gpB := nil;
  Result := nil;
  SetStatus (GdipCloneBrush(FNativeBrush, gpB));
  try
    Result := TdxGPBrush.CreateNative(gpB, FLastResult);
  except
    GdipDeleteBrush(gpB);
  end;
end;

function TdxGPBrush.GetLastStatus: Status;
begin
  Result := FLastResult;
  FLastResult := Ok;
end;

function TdxGPBrush.GetType: BrushType;
begin
  SetStatus(GdipGetBrushType (FNativeBrush, Result));
end;

procedure TdxGPBrush.SetNativeBrush(ANativeBrush: GpBrush);
begin
  FNativeBrush := ANativeBrush;
end;

function TdxGPBrush.SetStatus(AStatus: TdxGPStatus): TdxGPStatus;
begin
  Result := AStatus;
  if (AStatus <> Ok) and (FLastResult <> AStatus) then
  Result := GenericError;
end;

{ TdxGPSolidBrush }

constructor TdxGPSolidBrush.Create(color: TColor);
var
  ABrush: GpSolidFill;
begin
  ABrush := nil;
  FLastResult := GdipCreateSolidFill(color, ABrush);
  SetNativeBrush(ABrush);
end;

constructor TdxGPSolidBrush.Create;
begin
// hide parent method
end;

function TdxGPSolidBrush.GetColor: DWORD;
begin
  SetStatus(GdipGetSolidFillColor(GPSOLIDFILL(FNativeBrush), Result));
end;

procedure TdxGPSolidBrush.SetColor(const Value: DWORD);
begin
  SetStatus(GdipSetSolidFillColor(GpSolidFill(FNativeBrush), Value));
end;

{ TdxGPLinearGradientBrush }

constructor TdxGPLinearGradientBrush.Create(rect: TdxGPRect; color1, color2: DWORD; mode: TdxGPLinearGradientMode);
var
  ABrush: GpLineGradient;
begin
  ABrush := nil;
  FLastResult := GdipCreateLineBrushFromRectI(@rect, color1, color2, mode, WrapModeTile, ABrush);
  SetNativeBrush(ABrush);
end;

constructor TdxGPLinearGradientBrush.Create;
begin
// hide parent method
end;

function TdxGPLinearGradientBrush.GetLinearColors(out color1, color2: DWORD): TdxGPStatus;
var
  AColors: array[0..1] of DWORD;
begin
  SetStatus(GdipGetLineColors(GpLineGradient(FNativeBrush), PARGB(@AColors)));
  if (FLastResult = Ok) then
  begin
    color1 := AColors[0];
    color2 := AColors[1];
  end;
  Result := FLastResult;
end;

function TdxGPLinearGradientBrush.GetRectangle: TdxGPRect;
var
  ARect: PdxGPRect;
begin
  ARect := @Result;
  SetStatus(GdipGetLineRectI(GpLineGradient(FNativeBrush), ARect));
end;

function TdxGPLinearGradientBrush.GetWrapMode: TdxGPWrapMode;
begin
   Result := WrapModeTile;
   SetStatus(GdipGetLineWrapMode(GpLineGradient(FNativeBrush), Result));
end;

function TdxGPLinearGradientBrush.SetLinearColors(color1, color2: DWORD): TdxGPStatus;
begin
  Result := SetStatus(GdipSetLineColors(GpLineGradient(FNativeBrush), color1, color2));
end;

procedure TdxGPLinearGradientBrush.SetWrapMode(const Value: TdxGPWrapMode);
begin
  SetStatus(GdipSetLineWrapMode(GpLineGradient(FNativeBrush), Value));
end;

{ TdxGPHatchBrush }

constructor TdxGPHatchBrush.Create;
begin
// hide parent method
end;

constructor TdxGPHatchBrush.Create(hatchStyle: TdxGPHatchStyle; foreColor,
  backColor: DWORD);
var
  ABrush: GpHatch;
begin
  ABrush := nil;
  FLastResult := GdipCreateHatchBrush(hatchStyle, foreColor, backColor, ABrush);
  SetNativeBrush(ABrush);
end;

function TdxGPHatchBrush.GetBackgroundColor: DWORD;
begin
  SetStatus(GdipGetHatchBackgroundColor(GpHatch(FNativeBrush), Result));
end;

function TdxGPHatchBrush.GetForegroundColor: DWORD;
begin
  SetStatus(GdipGetHatchForegroundColor(GpHatch(FNativeBrush), Result));
end;

function TdxGPHatchBrush.GetHatchStyle: TdxGPHatchStyle;
begin
  SetStatus(GdipGetHatchStyle(GpHatch(FNativeBrush), Result));
end;

{ TdxGPPen }

constructor TdxGPPen.Create(brush: TdxGPBrush; width: Single);
var
  unit_: TdxGPUnit;
begin
  unit_ := UnitWorld;
  FNativePen := nil;
  FLastResult := GdipCreatePen2(brush.FNativeBrush, width, unit_, FNativePen);
end;

constructor TdxGPPen.Create(color: DWORD; width: Single);
var
  unit_: TdxGPUnit;
begin
  unit_ := UnitWorld;
  FNativePen := nil;
  FLastResult := GdipCreatePen1(color, width, unit_, FNativePen);
end;

destructor TdxGPPen.Destroy;
begin
  GdipDeletePen(FNativePen);
  inherited;
end;

function TdxGPPen.GetAlignment: TdxGPPenAlignment;
begin
  SetStatus(GdipGetPenMode(FNativePen, Result));
end;

function TdxGPPen.GetBrush: TdxGPBrush;
var
  type_: TdxGPPenType;
  ABrush: TdxGPBrush;
  ANativeBrush: GpBrush;
begin
  type_ := GetPenType;
  ABrush := nil;
  case type_ of
     PenTypeSolidColor     : ABrush := TdxGPSolidBrush.Create;
     PenTypeHatchFill      : ABrush := TdxGPHatchBrush.Create;
     PenTypeTextureFill    : ABrush := TdxGPTextureBrush.Create;
     PenTypePathGradient   : ABrush := TdxGPBrush.Create;
     PenTypeLinearGradient : ABrush := TdxGPLinearGradientBrush.Create;
   end;
   if ABrush <> nil then
   begin
     SetStatus(GdipGetPenBrushFill(FNativePen, ANativeBrush));
     brush.SetNativeBrush(ANativeBrush);
   end;
   Result := ABrush;
end;

function TdxGPPen.GetColor: DWORD;
var
  type_: TdxGPPenType;
  argb: DWORD;
begin
  type_ := GetPenType;
  Result := 0;
  if (type_ = PenTypeSolidColor) then
  begin
    SetStatus(GdipGetPenColor(FNativePen, argb));
    if FLastResult = Ok then Result := argb;
  end;
end;

function TdxGPPen.GetLastStatus: TdxGPStatus;
begin
  Result := FLastResult;
  FLastResult := Ok;
end;

function TdxGPPen.GetPenType: TdxGPPenType;
begin
  SetStatus(GdipGetPenFillType(FNativePen, Result));
end;

function TdxGPPen.GetWidth: Single;
begin
  SetStatus(GdipGetPenWidth(FNativePen, Result));
end;

procedure TdxGPPen.SetAlignment(const Value: TdxGPPenAlignment);
begin
  SetStatus(GdipSetPenMode(FNativePen, Value));
end;

procedure TdxGPPen.SetBrush(const Value: TdxGPBrush);
begin
  SetStatus(GdipSetPenBrushFill(FNativePen, Value.FNativeBrush));
end;

procedure TdxGPPen.SetColor(const Value: DWORD);
begin
  SetStatus(GdipSetPenColor(FNativePen, Value));
end;

procedure TdxGPPen.SetNativePen(ANativePen: GpPen);
begin
  FNativePen := ANativePen;
end;

function TdxGPPen.SetStatus(status: TdxGPStatus): TdxGPStatus;
begin
  if (status <> Ok) then FLastResult := status;
  Result := status;
end;

procedure TdxGPPen.SetWidth(const Value: Single);
begin
  SetStatus(GdipSetPenWidth(FNativePen, Value));
end;

{ TdxGPGraphics }

constructor TdxGPGraphics.Create(hdc: HDC);
var
  AGraphics :GpGraphics;
begin
  inherited Create;
  AGraphics := nil;
  FLastResult := GdipCreateFromHDC(hdc, AGraphics);
  SetNativeGraphics(AGraphics);
end;

destructor TdxGPGraphics.Destroy;
begin
  GdipDeleteGraphics(FNativeGraphics);
  inherited;
end;

procedure TdxGPGraphics.FillRectangle(brush: TdxGPBrush; const rect: TdxGPRect);
begin
  SetStatus(GdipFillRectangleI(FNativeGraphics, brush.FNativeBrush, rect.X, rect.Y, rect.Width, rect.Height));
end;

procedure TdxGPGraphics.SetNativeGraphics(AGraphics: GpGraphics);
begin
  FNativeGraphics := AGraphics
end;

function TdxGPGraphics.Clear(color: TColor): TdxGPStatus;
begin
  Result := SetStatus(GdipGraphicsClear(FNativeGraphics, color));
end;


function TdxGPGraphics.DrawArc(pen: TdxGPPen; const rect: TdxGPRect;
  startAngle, sweepAngle: Single): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawArcI(FNativeGraphics, pen.FNativePen,
     rect.X, rect.Y, rect.Width, rect.Height, startAngle, sweepAngle));
end;

function TdxGPGraphics.DrawBezier(pen: TdxGPPen; const pt1, pt2, pt3,
  pt4: TdxGPPoint): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawBezierI(FNativeGraphics, pen.FNativePen,
      pt1.X, pt1.Y, pt2.X, pt2.Y, pt3.X, pt3.Y, pt4.X, pt1.Y));
end;

function TdxGPGraphics.DrawBezier(pen: TdxGPPen; x1, y1, x2, y2, x3, y3,
  x4, y4: Integer): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawBezierI(FNativeGraphics, pen.FNativePen,
      x1, y1, x2, y2, x3, y3, x4, y4));
end;

function TdxGPGraphics.DrawClosedCurve(pen: TdxGPPen; points: PdxGPPoint;
  count: Integer; tension: Single): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawClosedCurve2I(FNativeGraphics, pen.FNativePen,
      points, count, tension));
end;

function TdxGPGraphics.DrawCurve(pen: TdxGPPen; points: PdxGPPoint;
  count: Integer; tension: Single): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawCurve2I(FNativeGraphics, pen.FNativePen,
      points, count, tension));
end;

function TdxGPGraphics.DrawEllipse(pen: TdxGPPen;
  const rect: TdxGPRect): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawEllipseI(FNativeGraphics, pen.FNativePen,
      rect.X, rect.Y, rect.Width, rect.Height));
end;

function TdxGPGraphics.DrawLine(pen: TdxGPPen; x1, y1, x2, y2: Integer): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawLineI(FNativeGraphics, pen.FNativePen, x1, y1, x2, y2));
end;

function TdxGPGraphics.DrawLine(pen: TdxGPPen; const pt1, pt2: TdxGPPoint): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawLineI(FNativeGraphics, pen.FNativePen, pt1.X, pt1.Y, pt2.X, pt2.Y));
end;

function TdxGPGraphics.DrawPie(pen: TdxGPPen; const rect: TdxGPRect;
  startAngle, sweepAngle: Single): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawPieI(FNativeGraphics, pen.FNativePen,
      rect.X, rect.Y, rect.Width, rect.Height, startAngle, sweepAngle));
end;

function TdxGPGraphics.DrawPolygon(pen: TdxGPPen; points: PdxGPPoint;
  count: Integer): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawPolygonI(FNativeGraphics, pen.FNativePen, points, count));
end;

function TdxGPGraphics.DrawRectangle(pen: TdxGPPen;
  const rect: TdxGPRect): TdxGPStatus;
begin
  Result := SetStatus(GdipDrawRectangleI(FNativeGraphics, pen.FNativePen,
      rect.X, rect.Y, rect.Width, rect.Height));
end;

function TdxGPGraphics.FillClosedCurve(brush: TdxGPBrush; points: PdxGPPoint;
  count: Integer): TdxGPStatus;
begin
  Result := SetStatus(GdipFillClosedCurveI(FNativeGraphics, brush.FNativeBrush,
    points, count));
end;

function TdxGPGraphics.FillEllipse(brush: TdxGPBrush;
  const rect: TdxGPRect): TdxGPStatus;
begin
  Result := SetStatus(GdipFillEllipseI(FNativeGraphics, brush.FNativeBrush,
      rect.X, rect.Y, rect.Width, rect.Height));
end;

function TdxGPGraphics.FillPie(brush: TdxGPBrush; const rect: TdxGPRect;
  startAngle, sweepAngle: Single): TdxGPStatus;
begin
  Result := SetStatus(GdipFillPieI(FNativeGraphics, brush.FNativeBrush,
      rect.X, rect.Y, rect.Width, rect.Height, startAngle, sweepAngle));
end;

function TdxGPGraphics.FillPolygon(brush: TdxGPBrush; points: PdxGPPoint;
  count: Integer): TdxGPStatus;
begin
  Result := SetStatus(GdipFillPolygonI(FNativeGraphics, brush.FNativeBrush,
      points, count, FillModeAlternate));
end;

function TdxGPGraphics.GetHDC: HDC;
begin
  SetStatus(GdipGetDC(FNativeGraphics, Result));
end;

function TdxGPGraphics.GetLastStatus: TdxGPStatus;
begin
  Result := FLastResult;
  FLastResult := Ok;
end;

function TdxGPGraphics.GetNativeGraphics: GpGraphics;
begin
  Result := FNativeGraphics;
end;

function TdxGPGraphics.GetNativePen(pen: TdxGPPen): GpPen;
begin
  Result := pen.FNativePen;
end;

procedure TdxGPGraphics.ReleaseHDC(hdc: HDC);
begin
  SetStatus(GdipReleaseDC(FNativeGraphics, hdc));
end;

function TdxGPGraphics.SetStatus(status: TdxGPStatus): TdxGPStatus;
begin
  if (status <> Ok) then FLastResult := status;
  Result := status;
end;

{ TdxGPImage }

constructor TdxGPImage.CreateFromBitmap(ABitmap: TBitmap);
begin
  CheckPngCodec;
  CreateFromPattern(ABitmap.Width, ABitmap.Height,
    GetBitmapBits(ABitmap), ABitmap.PixelFormat = pf32Bit);
end;

constructor TdxGPImage.CreateFromPattern(const AWidth, AHeight: Integer;
  const ABits: TdxRGBColors; AHasAlphaChannel: Boolean); 
var
  I: Integer;
begin
  FBits := ABits;
  if not AHasAlphaChannel then
    for I := 0 to Length(FBits) - 1 do
      FBits[I].rgbReserved := 255;
  GdipCheck(GdipCreateBitmapFromScan0(AWidth, AHeight,
    AWidth * 4, PixelFormat32bppPARGB, @FBits[0], FHandle));
end;

constructor TdxGPImage.CreateFromStream(AStream: TStream);
var
  Bitmap: TBitmap;
  Header: TBitmapFileHeader;
begin
  if not CheckGdiPlus or (AStream.Size < SizeOf(Header)) then Exit;
  AStream.ReadBuffer(Header, SizeOf(Header));
  AStream.Seek(-SizeOf(Header), soFromCurrent);
  if Header.bfType = $4D42 then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.LoadFromStream(AStream);
      CreateFromBitmap(Bitmap);
    finally
      Bitmap.Free;
    end;
  end
  else
    LoadFromDataStream(AStream);
end;

destructor TdxGPImage.Destroy;
begin
  if Handle <> nil then
    GdipCheck(GdipDisposeImage(Handle));
  FBits := nil;
  inherited Destroy;
end;

function TdxGPImage.Clone: TdxGPImage;
var
  W, H: Single;
begin
  if Length(FBits) > 0 then
  begin
    GdipCheck(GdipGetImageDimension(Handle, W, H));
    Result := TdxGPImage.CreateFromPattern(Trunc(W), Trunc(H), FBits, True);
  end
  else
  begin
    Result := TdxGPImage.Create;
    GdipCheck(GdipCloneImage(Handle, Result.FHandle));
  end;
end;

procedure TdxGPImage.SaveToStream(AStream: TStream);
begin
  GdipCheck(GdipSaveImageToStream(Handle,
    TStreamAdapter.Create(AStream, soReference), @PngCodec, nil));
end;

function TdxGPImage.GetBitmapBits(ABitmap: TBitmap): TdxRGBColors;
var
  ScreenDC: HDC;
  AInfo: TBitmapInfo;
begin
  SetLength(Result, ABitmap.Width * ABitmap.Height);
  AInfo.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  AInfo.bmiHeader.biWidth := ABitmap.Width;
  AInfo.bmiHeader.biHeight := -ABitmap.Height;
  AInfo.bmiHeader.biPlanes := 1;
  AInfo.bmiHeader.biBitCount := 32;
  AInfo.bmiHeader.biCompression := BI_RGB;
  ScreenDC := GetDC(0);
  GetDIBits(ScreenDC, ABitmap.Handle, 0, ABitmap.Height, Result,
    AInfo, DIB_RGB_COLORS);
  ReleaseDC(0, ScreenDC);
end;

procedure TdxGPImage.LoadFromDataStream(AStream: TStream);
var
  Data: HGlobal;
  DataPtr: Pointer;
  AccessStream: IStream;
begin
  Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, AStream.Size);
  try
    DataPtr := GlobalLock(Data);
    try
      AStream.Read(DataPtr^, AStream.Size);
      GdipCheck(CreateStreamOnHGlobal(Data, False, AccessStream) = s_OK);
      GdipCheck(GdipCreateBitmapFromStream(AccessStream, FHandle));
    finally
      GlobalUnlock(Data);
      AccessStream := nil;
    end;
  finally
    GlobalFree(Data);
  end;
end;


{ TdxPNGImage }

destructor TdxPNGImage.Destroy;
begin
  Handle := nil;
  inherited Destroy;
end;

procedure TdxPNGImage.Assign(Source: TPersistent);
begin
  if Source is TBitmap then
    Handle := CreateFromBitmap(TBitmap(Source))
  else
    if (Source is TdxPNGImage) and (TdxPNGImage(Source).Handle <> nil) then
      Handle := TdxPNGImage(Source).Handle.Clone
    else
      inherited Assign(Source);
end;

procedure TdxPNGImage.DrawEx(
  Graphics: GpGraphics; const ADest, ASource: TRect);
begin
  if Handle = nil then Exit;
  StretchDrawEx(Graphics, ADest, ASource);
end;

function TdxPNGImage.GetAsBitmap: TBitmap;
var
  AHandle: HBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := pf32Bit;
  GdipCheck(GdipCreateHBITMAPFromBitmap(Handle.Handle, AHandle, 0));
  Result.Handle := AHandle;
end;

class function TdxPNGImage.CreateFromBitmap(ASource: TBitmap): TdxGPImage;
begin
  CheckGdiPlus;
  Result := TdxGPImage.CreateFromBitmap(ASource);
end;

procedure TdxPNGImage.LoadFromStream(Stream: TStream);
begin
  Handle := TdxGPImage.CreateFromStream(Stream);
end;

procedure TdxPNGImage.SaveToStream(Stream: TStream);
var
  ADest: TMemoryStream;
begin
  if Handle <> nil then
  begin
    ADest := TMemoryStream.Create();
    try
      Handle.SaveToStream(ADest);
      ADest.Position := 0;
      Stream.CopyFrom(ADest, ADest.Size);
    finally
      ADest.Free;
    end;
  end;
end;

procedure TdxPNGImage.LoadFromClipboardFormat(AFormat: Word; AData: THandle;
  APalette: HPALETTE);
begin
end;

procedure TdxPNGImage.SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
  var APalette: HPALETTE);
begin
end;

procedure TdxPNGImage.SetBitmap(ABitmap: TBitmap);
begin
  Handle := CreateFromBitmap(ABitmap);
end;

procedure TdxPNGImage.StretchDraw(DC: HDC; const ADest: TRect);
begin
  StretchDraw(DC, ADest, Rect(0, 0, Width, Height));
end;

procedure TdxPNGImage.StretchDraw(DC: HDC; const ADest, ASource: TRect);
var
  Gp: GpGraphics;
begin
  if Handle = nil then Exit;
  GdipCheck(GdipCreateFromHDC(DC, Gp));
  StretchDrawEx(Gp, ADest, ASource);
  GdipCheck(GdipDeleteGraphics(Gp));
end;

procedure TdxPNGImage.StretchDrawEx(
  Graphics: GpGraphics; const ADest, ASource: TRect);
var
  DstH, DstW, SrcH, SrcW: Single;
begin
  if Handle = nil then Exit;
  SrcW := ASource.Right - ASource.Left;
  SrcH := ASource.Bottom - ASource.Top;
  DstW := ADest.Right - ADest.Left;
  DstH := ADest.Bottom - ADest.Top;
  if (SrcW < 1) or (SrcH < 1) or (DstW < 1) or (DstH < 1) then Exit;
  if (DstW > SrcW) and (SrcW > 1) then
    SrcW := SrcW - 1;
  if (DstH > SrcH) and (SrcH > 1) then
    SrcH := SrcH - 1;
  GdipCheck(GdipDrawImageRectRect(Graphics, Handle.Handle, ADest.Left, ADest.Top,
    DstW, DstH, ASource.Left, ASource.Top, SrcW,  SrcH, UnitPixel, nil, nil, nil))
end;

procedure TdxPNGImage.Draw(ACanvas: TCanvas; const ARect: TRect);
begin
  StretchDraw(ACanvas.Handle, ARect, Rect(0, 0, Width, Height));
end;

function TdxPNGImage.GetEmpty: Boolean;
begin
  with GetSize do
    Result := (cx <= 0) or (cy <= 0)
end;

function TdxPNGImage.GetHeight: Integer;
begin
  Result := GetSize.cy;
end;

function TdxPNGImage.GetSize: TSize;
var
  W, H: Single;
begin
  if Handle <> nil then
    GdipCheck(GdipGetImageDimension(Handle.Handle, W, H))
  else
  begin
    W := 0;
    H := 0;
  end;
  Result.cx := Trunc(W);
  Result.cy := Trunc(H);
end;

function TdxPNGImage.GetTransparent: Boolean;
begin
  Result := True;
end;

function TdxPNGImage.GetWidth: Integer;
begin
  Result := GetSize.cx;
end;

procedure TdxPNGImage.SetWidth(Value: Integer);
begin
end;

procedure TdxPNGImage.SetHeight(Value: Integer);
begin
end;

procedure TdxPNGImage.SetHandle(AHandle: TdxGPImage);
begin
  if AHandle <> FHandle then
  begin
    FHandle.Free;
    FHandle := AHandle;
  end;
end;

initialization
  if CheckGdiPlus then
  begin
    CheckPngCodec;
    RegisterClasses([TdxPNGImage]);
    TPicture.RegisterFileFormat('PNG', 'PNG graphics from DevExpress', TdxPNGImage);
  end;

finalization
  TPicture.UnregisterGraphicClass(TdxPNGImage);
  UnregisterClasses([TdxPNGImage]);

{$ENDIF}

end.
