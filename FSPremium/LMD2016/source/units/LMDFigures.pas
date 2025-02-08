unit LMDFigures;
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

LMD VCL Series 2010
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdtools.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
BugTracking        : http://bts.lmd.de
Fax                : ++49 69 15347696

################################################################################

LMDFigures unit (EN/VB)
-----------------------

Changes
-------

Release 10.0X (January 2010)
 - Initial Release
###############################################################################}

interface

uses Types, Classes, Windows, Graphics, LMDGraph, LMDFillers;

type  
  TLMDFigure = class (TObject)
  private
    FAntiAliasing: Boolean;
    FAutoBoundFill: Boolean;
    FBasePoint: TPoint;
    FBorderColor: TColor;
    FBorderSides: TLMDBorderSides;
    FBorderWidth: Integer;
    FFiller: TLMDFiller;
    FLengthN: Integer;
    FLengthN2: Integer;
    FLengthT: Integer;
    FLengthT2: Integer;
    FMoveFillerWithFigure: Boolean;
    FSoftBorder: Boolean;
    FTransparent: Boolean;
    FVectorN: TPoint;
    FVectorT: TPoint;

    function GetBasePoint: TPoint; virtual;
    function GetBorderColor: TColor; virtual;
    function GetBorderWidth: Integer; virtual;
    function GetVectorN: TPoint; virtual;
    function GetVectorT: TPoint; virtual;
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            virtual;
    procedure PreCalc; virtual;
    procedure SetBasePoint(Value: TPoint); virtual;
    procedure SetBorderColor(Value: TColor); virtual;
    procedure SetBorderWidth(Value: Integer); virtual;
    procedure SetFiller(Value: TLMDFiller);
    procedure SetVectorN(Value: TPoint); virtual;
    procedure SetVectorT(Value: TPoint); virtual;
  public
    constructor Create(AFiller: TLMDFiller = nil); overload;
    procedure Draw24(ABitMap: TBitMap); virtual;
    procedure Draw32(ABitMap: TBitMap; aPremult: Boolean); virtual;

    procedure Draw(ABitMap: TBitMap; aPixelFormat: TPixelFormat {= pf24bit}; aUsePremult: boolean = true); overload; virtual;
    procedure Draw(aTargetDC: HDC; aPixelFormat: TPixelFormat {= pf24bit}; aUsePremult: boolean = true; aCopyBkgnd: boolean = true); overload; virtual;

    function IncludeRect: TRect; virtual;
    property AntiAliasing: Boolean read FAntiAliasing write FAntiAliasing;
    property AutoBoundFill: Boolean read FAutoBoundFill write FAutoBoundFill
            default true;
    property BasePoint: TPoint read GetBasePoint write SetBasePoint;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property BorderSides: TLMDBorderSides read FBorderSides write FBorderSides;
    property BorderWidth: Integer read GetBorderWidth write SetBorderWidth;
    property Filler: TLMDFiller read FFiller write SetFiller;
    property MoveFillerWithFigure: Boolean read FMoveFillerWithFigure write
            FMoveFillerWithFigure default false;
    property SoftBorder: Boolean read FSoftBorder write FSoftBorder;
    property Transparent: Boolean read FTransparent write FTransparent;
    property VectorN: TPoint read GetVectorN write SetVectorN;
    property VectorT: TPoint read GetVectorT write SetVectorT;
  end;

  TLMDRectangle = class (TLMDFigure)
  private
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
  public
    constructor Create(x1, y1, x2, y2: integer; AFiller: TLMDFiller = nil);
            overload;
    constructor Create(ATopLeft, ABottomRight: TPoint; AFiller: TLMDFiller = nil);
            overload;
    constructor Create(ARect: TRect; AFiller: TLMDFiller = nil); overload;
    function IncludeRect: TRect; override;
    procedure Rectangle(x1, y1, x2, y2: integer); overload;
    procedure Rectangle(ATopLeft, ABottomRight: TPoint); overload;
    procedure Rectangle(ARect: TRect); overload;
  end;

  TLMDCutBaseRectangle = class (TLMDRectangle)
  private
    FCornerCut: TLMDCornerCut;
    FXCut: Integer;
    FYCut: Integer;
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
  public
    function CornerInclude(AX, AY: integer; ACutType: TLMDCutType = ctNone):
            Double;
  end;

  TLMDCustomCutRectangle = class (TLMDCutBaseRectangle)
  private
    function GetCornerCut(Index: TLMDRectangleCorner): TLMDCutType;
    function GetCutX: Integer;
    function GetCutY: Integer;
    procedure SetCornerCut(Index: TLMDRectangleCorner; Value: TLMDCutType);
    procedure SetCutX(Value: Integer);
    procedure SetCutY(Value: Integer);
  public
    property CornerCut[Index: TLMDRectangleCorner]: TLMDCutType read
            GetCornerCut write SetCornerCut;
    property CutX: Integer read GetCutX write SetCutX;
    property CutY: Integer read GetCutY write SetCutY;
  end;

  TLMDCutRectangle = class (TLMDCutBaseRectangle)
  private
    function GetCut: Integer;
    procedure SetCut(Value: Integer);
  public
    property Cut: Integer read GetCut write SetCut;
  end;

  TLMDCutXYRectangle = class (TLMDCutBaseRectangle)
  private
    function GetCutX: Integer;
    function GetCutY: Integer;
    procedure SetCutX(Value: Integer);
    procedure SetCutY(Value: Integer);
  public
    property CutX: Integer read GetCutX write SetCutX;
    property CutY: Integer read GetCutY write SetCutY;
  end;

  TLMDRoundRectangle = class (TLMDCutBaseRectangle)
  private
    function GetRadius: Integer;
    procedure SetRadius(Value: Integer);
  public
    property Radius: Integer read GetRadius write SetRadius;
  end;

  TLMDLine = class (TLMDFigure)
  private
    FPointFrom: TPoint;
    FPointTo: TPoint;
    FWidth: Integer;
    FWidthLeft: Integer;
    FWidthLeftN: Integer;
    FWidthRight: Integer;
    FWidthRightN: Integer;
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
    procedure PreCalc; override;
    procedure SetPointFrom(Value: TPoint);
    procedure SetPointTo(Value: TPoint);
    procedure SetWidth(Value: Integer);
  public
    constructor Create(x1, y1, x2, y2, AWidth: integer; AFiller: TLMDFiller = nil);
            overload;
    constructor Create(APointFrom, APointTo: TPoint; AWidth: integer; AFiller:
            TLMDFiller = nil); overload;
    function IncludeRect: TRect; override;
    procedure Line(x1, y1, x2, y2, AWidth: integer); overload;
    procedure Line(APointFrom, APointTo: TPoint; AWidth: integer); overload;
    property PointFrom: TPoint read FPointFrom write SetPointFrom;
    property PointTo: TPoint read FPointTo write SetPointTo;
    property Width: Integer read FWidth write SetWidth;
  end;

  TLMDCircle = class (TLMDFigure)
  private
    FRadius: Integer;
    procedure SetRadius(Value: Integer);
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
    function GetCenter: TPoint;
    procedure SetCenter(Value: TPoint);
  public
    constructor Create(x, y, ARadius: integer; AFiller: TLMDFiller = nil); overload;
    constructor Create(ACenterPoint: TPoint; ARadius: integer; AFiller: TLMDFiller
            = nil); overload;
    procedure Circle(x, y, ARadius: integer); overload;
    procedure Circle(ACenterPoint: TPoint; ARadius: integer); overload;
    function IncludeRect: TRect; override;
    property Radius: Integer read FRadius write SetRadius;
    property Center: TPoint read GetCenter write SetCenter;
  end;

  TLMDEllipse = class (TLMDFigure)
  private
    FDistance: Integer;
    FFocus1: TPoint;
    FFocus2: TPoint;
    procedure PreCalc; override;
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
  public
    constructor Create(x1, y1, x2, y2: integer; AFiller: TLMDFiller = nil);
            overload;
    constructor Create(ARect: TRect; AFiller: TLMDFiller = nil); overload;
    procedure Ellipse(x1, y1, x2, y2: integer); overload;
    procedure Ellipse(ARect: TRect); overload;
    function IncludeRect: TRect; override;
  end;

  TLMDContainerFigure = class (TLMDFigure)
  private
    FFigureList: TList;
    function GetItem(Index: Integer): TLMDFigure;
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
    procedure SetBorderColor(Value: TColor); override;
    procedure SetBorderWidth(Value: Integer); override;
    procedure SetItem(Index: Integer; Value: TLMDFigure);
  public
    constructor Create; overload;
    destructor Destroy; override;
    function Add(AFigure: TLMDFigure): Integer;
    function Count: Integer;
    procedure Clear(aFreeItems: boolean = false);
    procedure Delete(AFigure: TLMDFigure);
    function IncludeRect: TRect; override;
    procedure PreCalc; override;
    property Item[Index: Integer]: TLMDFigure read GetItem write SetItem;
  end;

  TLMDUnionFigure = class (TLMDContainerFigure)
  private
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
  public
    function IncludeRect: TRect; override;
  end;

  TLMDIntersectFigure = class (TLMDContainerFigure)
  private
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
  public
    function IncludeRect: TRect; override;
  end;

  TLMDSubtractionFigure = class (TLMDContainerFigure)
  private
    function IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
            override;
  public
    function IncludeRect: TRect; override;
  end;


implementation

uses Math, SysUtils, LMDGraphUtils;

{********************************* TLMDFigure *********************************}
constructor TLMDFigure.Create(AFiller: TLMDFiller = nil);
begin
  inherited Create;
  FBasePoint := Point(0,0);
  FAutoBoundFill := true;
  FMoveFillerWithFigure := false;

  FAntiAliasing := true;
  FTransparent := false;

  FBorderColor := clNone;
  FBorderWidth := 0;
  FSoftBorder := false;

  FBorderSides := LMDFullBorderSides;

  FFiller := AFiller;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.Draw24(ABitMap: TBitMap);
var
  x, y: Integer;
  l: PByteArray;
  LPoint: TPoint;
  LIncludeRect: TRect;
  LFrag: Double;
  LDist: Integer;
  LRed, LGreen, LBlue, LAlfa: Byte;
  LBorderWidth: Integer;
begin
  LIncludeRect := IncludeRect;
  for y:=Max(0, LIncludeRect.Top) to Min(ABitMap.Height-1, LIncludeRect.Bottom) do
  begin
    l := ABitMap.ScanLine[y];
    for x:=Max(0, LIncludeRect.Left) to Min(ABitMap.Width-1, LIncludeRect.Right) do
    begin
      LPoint := Point(x, y);
      LFrag := IsInside(LPoint, LBorderWidth);
      if LBorderWidth = -1 then
        LBorderWidth := FBorderWidth;
      LDist := Round(LFrag * 255);
      if LDist=MaxDistForAntiAliasing then
      begin
        LBlue := FFiller.BlueChannel.Value(LPoint);
        LGreen := FFiller.GreenChannel.Value(LPoint);
        LRed := FFiller.RedChannel.Value(LPoint);
      end
      else
      begin
        if FAntiAliasing and (LDist>MinDistForAntiAliasing) then
        begin
          if LBorderWidth = 0 then
          begin
            LBlue := LMDCalcProportion(l[x * 3], FFiller.BlueChannel.Value(LPoint), 255, LDist);
            LGreen := LMDCalcProportion(l[x * 3 + 1], FFiller.GreenChannel.Value(LPoint), 255, LDist);
            LRed := LMDCalcProportion(l[x * 3 + 2], FFiller.RedChannel.Value(LPoint), 255, LDist);
          end
          else
          begin
            if FSoftBorder then
            begin
              if LDist > 127 then
              begin
                LBlue := LMDCalcProportion(LMDGetBlueValue(FBorderColor), FFiller.BlueChannel.Value(LPoint), 127, LDist - 127);
                LGreen := LMDCalcProportion(LMDGetGreenValue(FBorderColor), FFiller.GreenChannel.Value(LPoint), 127, LDist - 127);
                LRed := LMDCalcProportion(LMDGetRedValue(FBorderColor), FFiller.RedChannel.Value(LPoint), 127, LDist - 127);
              end
              else
              begin
                LBlue := LMDCalcProportion(l[x * 3], LMDGetBlueValue(FBorderColor), 127, LDist);
                LGreen := LMDCalcProportion(l[x * 3 + 1], LMDGetGreenValue(FBorderColor), 127, LDist);
                LRed := LMDCalcProportion(l[x * 3 + 2], LMDGetRedValue(FBorderColor), 127, LDist);
              end;
            end
            else
            begin
              LFrag := LFrag * (FBorderWidth + 1);
              if LFrag < 1 then
              begin
                LDist := Round(LFrag * 255);
                LBlue := LMDCalcProportion(l[x * 3], LMDGetBlueValue(FBorderColor), 255, LDist);
                LGreen := LMDCalcProportion(l[x * 3 + 1], LMDGetGreenValue(FBorderColor), 255, LDist);
                LRed := LMDCalcProportion(l[x * 3 + 2], LMDGetRedValue(FBorderColor), 255, LDist);
              end
              else
              begin
                if LFrag > LBorderWidth then
                begin
                  LDist := Round((LFrag - LBorderWidth) * 255);
                  LBlue := LMDCalcProportion(LMDGetBlueValue(FBorderColor), FFiller.BlueChannel.Value(LPoint), 255, LDist);
                  LGreen := LMDCalcProportion(LMDGetGreenValue(FBorderColor), FFiller.GreenChannel.Value(LPoint), 255, LDist);
                  LRed := LMDCalcProportion(LMDGetRedValue(FBorderColor), FFiller.RedChannel.Value(LPoint), 255, LDist);
                end
                else
                begin
                  LBlue := LMDGetBlueValue(FBorderColor);
                  LGreen := LMDGetGreenValue(FBorderColor);
                  LRed := LMDGetRedValue(FBorderColor);
                end;
              end;
            end;
          end;
        end
        else
        begin
          if LBorderWidth = 0 then
          begin
            LBlue := l[x * 3];
            LGreen := l[x * 3 + 1];
            LRed := l[x * 3 + 2];
          end
          else
          begin
            LBlue := LMDGetBlueValue(FBorderColor);
            LGreen := LMDGetGreenValue(FBorderColor);
            LRed := LMDGetRedValue(FBorderColor);
          end;
        end;
      end;
      if LDist>MinDistForAntiAliasing then
        if FTransparent then
        begin
          LAlfa := FFiller.AlphaChannel.Value(LPoint);
          if LAlfa < 255 then
          begin
            l[x * 3] := LMDCalcProportion(l[x * 3], LBlue, 255, LAlfa);
            l[x * 3 + 1] := LMDCalcProportion(l[x * 3 + 1], LGreen, 255, LAlfa);
            l[x * 3 + 2] := LMDCalcProportion(l[x * 3 + 2], LRed, 255, LAlfa);
          end
          else
          begin
            l[x * 3] := LBlue;
            l[x * 3 + 1] := LGreen;
            l[x * 3 + 2] := LRed;
          end
        end
        else
        begin
          l[x * 3] := LBlue;
          l[x * 3 + 1] := LGreen;
          l[x * 3 + 2] := LRed;
        end;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.Draw32(ABitMap: TBitMap; aPremult: boolean);
var
  x, y: Integer;
  l: PByteArray;
  LPoint: TPoint;
  LIncludeRect: TRect;
  LFrag: Double;
  LDist: Integer;
  LBorderWidth: Integer;
  a: integer;
begin
  LIncludeRect := IncludeRect;

  for y:=Max(0, LIncludeRect.Top) to Min(ABitMap.Height-1, LIncludeRect.Bottom) do
  begin
    l := ABitMap.ScanLine[y];
    for x:=Max(0, LIncludeRect.Left) to Min(ABitMap.Width-1, LIncludeRect.Right) do
    begin
      LPoint := Point(x, y);
      LFrag := IsInside(LPoint, LBorderWidth);
      LDist := Round(LFrag * 255);
      if LDist < MaxDistForAntiAliasing then
      begin
        //l[x * 4 + 0] := 255;
        //l[x * 4 + 1] := 255;
        //l[x * 4 + 2] := 255;
        //l[x * 4 + 3] := 255;
      end;
      if LDist = MaxDistForAntiAliasing then
      begin
        a := FFiller.AlphaChannel.Value(LPoint);
        l[x * 4 + 3] := a;
        l[x * 4 + 0] := FFiller.BlueChannel.Value(LPoint);
        l[x * 4 + 1] := FFiller.GreenChannel.Value(LPoint);
        l[x * 4 + 2] := FFiller.RedChannel.Value(LPoint);
        if aPremult then
        begin
          l[x * 4 + 0] := muldiv(l[x * 4 + 0], a, 255);
          l[x * 4 + 1] := muldiv(l[x * 4 + 1], a, 255);
          l[x * 4 + 2] := muldiv(l[x * 4 + 2], a, 255);
        end;
      end
      else
      if FAntiAliasing and (LDist > MinDistForAntiAliasing) then
      begin
        a := LMDCalcProportion(0, FFiller.AlphaChannel.Value(LPoint), 255, LDist);
        l[x * 4 + 3] := a;
        l[x * 4 + 0] := FFiller.BlueChannel.Value(LPoint);
        l[x * 4 + 1] := FFiller.GreenChannel.Value(LPoint);
        l[x * 4 + 2] := FFiller.RedChannel.Value(LPoint);
        if aPremult then
        begin
          l[x * 4 + 0] := muldiv(l[x * 4 + 0], a, 255);
          l[x * 4 + 1] := muldiv(l[x * 4 + 1], a, 255);
          l[x * 4 + 2] := muldiv(l[x * 4 + 2], a, 255);
        end;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.Draw(aTargetDC: HDC; aPixelFormat: TPixelFormat {= pf24bit}; aUsePremult: boolean = true; aCopyBkgnd: boolean = true);
var
  bmp: TBitmap;
  OldP: TPoint;
begin
  Bmp := TBitmap.Create;
  Bmp.PixelFormat := aPixelFormat;
  {$IFDEF LMDCOMP12}
  if aPixelFormat = pf32bit then
    Bmp.AlphaFormat := afDefined;
  {$ENDIF}
  Bmp.Width := IncludeRect.Right + BorderWidth * 2;
  Bmp.Height := IncludeRect.Bottom + BorderWidth * 2;
  SetViewPortOrgEx(aTargetDC, -BasePoint.X, -BasePoint.Y, @OldP);
  if aCopyBkgnd then
    BitBlt(bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, aTargetDC, BasePoint.X, BasePoint.Y, SRCCOPY);
  Draw(Bmp, aPixelFormat, aUsePremult);
  BitBlt(aTargetDC, BasePoint.X, BasePoint.Y, Bmp.Width + 1, Bmp.Height + 1, bmp.Canvas.Handle, 0, 0, SRCCOPY);
  SetViewPortOrgEx(aTargetDC, OldP.X, OldP.Y, nil);
  Bmp.Free;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFigure.GetBasePoint: TPoint;
begin
  Result := FBasePoint;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFigure.GetBorderColor: TColor;
begin
  Result := FBorderColor;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFigure.GetBorderWidth: Integer;
begin
  Result := FBorderWidth;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFigure.GetVectorN: TPoint;
begin
  Result := FVectorN;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFigure.GetVectorT: TPoint;
begin
  Result := FVectorT;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFigure.IncludeRect: TRect;
begin
  result := Rect(0, 0, 0, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFigure.IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
begin
  ABorderWidth := -1;
  result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.PreCalc;
var
  LLengthFillerN, LLengthFillerT: Integer;
begin
  FLengthN2 := FVectorN.X * FVectorN.X + FVectorN.Y * FVectorN.Y;
  FLengthN := Round(Sqrt(FLengthN2));
  FLengthT2 := FVectorT.X * FVectorT.X + FVectorT.Y * FVectorT.Y;
  FLengthT := Round(Sqrt(FLengthT2));

  if Assigned(FFiller) then
    begin
      if FAutoBoundFill then
        FFiller.SetPosition(self);

      if FMoveFillerWithFigure then
        begin
          LLengthFillerN := Round(Sqrt(FFiller.VectorN.X * FFiller.VectorN.X + FFiller.VectorN.Y * FFiller.VectorN.Y));
          FFiller.VectorN := Point(Round((FVectorN.X * LLengthFillerN) / FLengthN),
                          Round((FVectorN.Y * LLengthFillerN) / FLengthN));
          LLengthFillerT := Round(Sqrt(FFiller.VectorT.X * FFiller.VectorT.X + FFiller.VectorT.Y * FFiller.VectorT.Y));
          FFiller.VectorT := Point(Round((FVectorT.X * LLengthFillerT) / FLengthT),
                          Round((FVectorT.Y * LLengthFillerT) / FLengthT));
          FFiller.BasePoint := FBasePoint;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.SetBasePoint(Value: TPoint);
begin
  FBasePoint := Value;
  PreCalc;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.SetBorderColor(Value: TColor);
begin
  FBorderColor := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.SetBorderWidth(Value: Integer);
begin
  FBorderWidth := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.SetFiller(Value: TLMDFiller);
begin
  FFiller := Value;
  if FAutoBoundFill and Assigned(FFiller) then
    FFiller.SetPosition(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.SetVectorN(Value: TPoint);
begin
  FVectorN := Value;
  PreCalc;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.SetVectorT(Value: TPoint);
begin
  FVectorT := Value;
  PreCalc;
end;

{******************************** TLMDRectangle *******************************}
constructor TLMDRectangle.Create(x1, y1, x2, y2: integer; AFiller: TLMDFiller =
        nil);
begin
  inherited Create;
  Rectangle(x1, y1, x2, y2);
  Filler := AFiller;  
  FBorderSides := LMDFullBorderSides;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDRectangle.Create(ATopLeft, ABottomRight: TPoint; AFiller:
        TLMDFiller = nil);
begin
  inherited Create(AFiller);
  Rectangle(ATopLeft, ABottomRight);
  Filler := AFiller;
  FBorderSides := LMDFullBorderSides;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDRectangle.Create(ARect: TRect; AFiller: TLMDFiller = nil);
begin
  inherited Create(AFiller);
  Rectangle(ARect);
  Filler := AFiller;
  FBorderSides := LMDFullBorderSides;
end;

{ ---------------------------------------------------------------------------- }
function TLMDRectangle.IncludeRect: TRect;
begin
  result := Rect(FBasePoint.X - FBorderWidth - 1,
                 FBasePoint.Y  - FBorderWidth - 1,
                 FBasePoint.X + FVectorN.X + FBorderWidth + 1,
                 FBasePoint.Y + FVectorT.Y + FBorderWidth + 1);
end;

{ ---------------------------------------------------------------------------- }
function TLMDRectangle.IsInside(APoint: TPoint; var ABorderWidth: integer):
        Double;
var
  x1, y1, x2, y2: Integer;
  LFragX, LFragY: Double;
begin
  x1 := BasePoint.X;
  y1 := BasePoint.Y;
  x2 := BasePoint.X + VectorN.X;
  y2 := BasePoint.Y + VectorT.Y;
  if (APoint.X >= x1) and (APoint.X <= x2) then
    LFragX := 1
  else
  begin
    if APoint.X < x1 then
    begin
      if (APoint.X >= x1 - FBorderWidth) and (ebsLeft in FBorderSides) then
        LFragX := (x1 - APoint.X) / (FBorderWidth + 1)
      else
        LFragX := 0;
    end
    else
    begin
      if (APoint.X <= x2 + FBorderWidth) and (ebsRight in FBorderSides) then
        LFragX := (APoint.X - x2) / (FBorderWidth + 1)
      else
        LFragX := 0;
    end
  end;

  if (APoint.Y >= y1) and (APoint.Y <= y2) then
    LFragY := 1
  else
  begin
    if APoint.Y < y1 then
    begin
      if (APoint.Y >= y1 - FBorderWidth) and (ebsTop in FBorderSides) then
        LFragY := (y1 - APoint.Y) / (FBorderWidth + 1)
      else
        LFragY := 0;
    end
    else
    begin
      if (APoint.Y <= y2 + FBorderWidth) and (ebsBottom in FBorderSides) then
        LFragY := (APoint.Y - y2) / (FBorderWidth + 1)
      else
        LFragY := 0;
    end
  end;

  ABorderWidth := -1;

  result := min(LFragX, LFragY);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRectangle.Rectangle(x1, y1, x2, y2: integer);
begin
  FBasePoint := Point(x1, y1);
  FVectorN := Point(x2 - x1, 0);
  FVectorT := Point(0, y2 - y1);

  PreCalc;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRectangle.Rectangle(ATopLeft, ABottomRight: TPoint);
begin
  Rectangle(ATopLeft.X, ATopLeft.Y, ABottomRight.X, ABottomRight.Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRectangle.Rectangle(ARect: TRect);
begin
  Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

{*************************** TLMDCutBaseRectangle *****************************}
function TLMDCutBaseRectangle.CornerInclude(AX, AY: integer; ACutType:
        TLMDCutType = ctNone): Double;
var
  LSinA, LD, LDE, XE, YE, lalfa: Double;
begin
  if ACutType = ctLine then
  begin
    LSinA := FXCut * (AY - FYCut) + FYCut * AX;
    if LSinA <= 0 then
      result := 1
    else
    begin
      LSinA := LSinA / SQRT(FXCut * FXCut + FYCut * FYCut);
      result := 1 - LSinA / (FBorderWidth + 1);
    end;
  end
  else
  if ACutType = ctRound then
  begin
    LD := SQRT(AX * AX + AY * AY);
    if AX = 0 then
      lalfa := PI / 2
    else
      lalfa := arctan(AY / AX * FXCut / FYCut);
    XE := FXCut * cos(lalfa);
    YE := FYCut * sin(lalfa);
    LDE := SQRT(XE * XE + YE * YE);
    if LD < LDE then
      result := 1
    else
      result := 1 - (LD - LDE) / (FBorderWidth + 1);
  end else
  result := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCutBaseRectangle.IsInside(APoint: TPoint; var ABorderWidth:
        integer): Double;
var
  LX, LY, LH, LW: Integer;
begin
  Result := inherited IsInside(APoint, ABorderWidth);
  if Result > 0 then
  begin
    LX := APoint.X - FBasePoint.X;
    if FVectorN.X < 0 then
    begin
      LX := - LX;
      LW := - FVectorN.X;
    end
    else
      LW := FVectorN.X;
    LY := APoint.Y - FBasePoint.Y;
    if FVectorT.Y < 0 then
    begin
      LY := - LY;
      LH := - FVectorT.Y;
    end
    else
      LH := FVectorT.Y;

    if LX < FXCut then
    begin
      if LY < FYCut then
        result := min(result, CornerInclude(FXCut - LX, FYCut - LY, FCornerCut[rcTopLeft]));
      if LY > LH - FYCut then
          result := min(result, CornerInclude(FXCut - LX, FYCut - LH + LY, FCornerCut[rcBottomLeft]));
    end;

    if LX > LW - FXCut then
    begin
      if LY < FYCut then
        result := min(result, CornerInclude(FXCut - LW + LX, FYCut - LY, FCornerCut[rcTopRight]));
      if LY > LH - FYCut then
          result := min(result, CornerInclude(FXCut - LW + LX, FYCut - LH + LY, FCornerCut[rcBottomRight]));
    end;
  end;
end;

{**************************** TLMDCustomCutRectangle **************************}
function TLMDCustomCutRectangle.GetCornerCut(Index: TLMDRectangleCorner):
        TLMDCutType;
begin
  result := FCornerCut[Index];
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCutRectangle.GetCutX: Integer;
begin
  result := FXCut;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCutRectangle.GetCutY: Integer;
begin
  result := FYCut;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCutRectangle.SetCornerCut(Index: TLMDRectangleCorner;
        Value: TLMDCutType);
begin
  FCornerCut[Index] := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCutRectangle.SetCutX(Value: Integer);
begin
  FXCut := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCutRectangle.SetCutY(Value: Integer);
begin
  FYCut := Value;
end;

{******************************* TLMDCutRectangle ****************************}
function TLMDCutRectangle.GetCut: Integer;
begin
  result := FXCut;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCutRectangle.SetCut(Value: Integer);
begin
  FXCut := Value;
  FYCut := Value;
  FCornerCut[rcTopLeft] := ctLine;
  FCornerCut[rcBottomLeft] := ctLine;
  FCornerCut[rcBottomRight] := ctLine;
  FCornerCut[rcTopRight] := ctLine;
end;

{****************************** TLMDCutXYRectangle ****************************}
function TLMDCutXYRectangle.GetCutX: Integer;
begin
  result := FXCut;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCutXYRectangle.GetCutY: Integer;
begin
  result := FYCut;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCutXYRectangle.SetCutX(Value: Integer);
begin
  FXCut := Value;
  FCornerCut[rcTopLeft] := ctLine;
  FCornerCut[rcBottomLeft] := ctLine;
  FCornerCut[rcBottomRight] := ctLine;
  FCornerCut[rcTopRight] := ctLine;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCutXYRectangle.SetCutY(Value: Integer);
begin
  FYCut := Value;

  FCornerCut[rcTopLeft] := ctLine;
  FCornerCut[rcBottomLeft] := ctLine;
  FCornerCut[rcBottomRight] := ctLine;
  FCornerCut[rcTopRight] := ctLine;
end;

{***************************** TLMDRoundRectangle ****************************}
function TLMDRoundRectangle.GetRadius: Integer;
begin
  result := FXCut;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRoundRectangle.SetRadius(Value: Integer);
begin
  FXCut := Value;
  FYCut := Value;

  FCornerCut[rcTopLeft] := ctRound;
  FCornerCut[rcBottomLeft] := ctRound;
  FCornerCut[rcBottomRight] := ctRound;
  FCornerCut[rcTopRight] := ctRound;
end;

{********************************** TLMDLine *********************************}
constructor TLMDLine.Create(x1, y1, x2, y2, AWidth: integer; AFiller: TLMDFiller =
        nil);
begin
  inherited Create;
  Line(x1, y1, x2, y2, AWidth);

  Filler := AFiller;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDLine.Create(APointFrom, APointTo: TPoint; AWidth: integer;
        AFiller: TLMDFiller = nil);
begin
  inherited Create(AFiller);
  Line(PointFrom, PointTo, AWidth);

  Filler := AFiller;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLine.IncludeRect: TRect;
begin
  if FPointFrom.X < FPointTo.X then
    result.Left := FPointFrom.X - FWidth - FBorderWidth
  else
    result.Left := FPointTo.X - FWidth - FBorderWidth;
  if result.Left < 0 then
    result.Left := 0;

  if FPointFrom.Y < FPointTo.Y then
    result.Top := FPointFrom.Y - FWidth - FBorderWidth
  else
    result.Top := FPointTo.Y - FWidth - FBorderWidth;
  if result.Top < 0 then
    result.Top := 0;

  if FPointFrom.X > FPointTo.X then
    result.Right := FPointFrom.X + FWidth + FBorderWidth
  else
    result.Right := FPointTo.X + FWidth + FBorderWidth;

  if FPointFrom.Y > FPointTo.Y then
    result.Bottom := FPointFrom.Y + FWidth + FBorderWidth
  else
    result.Bottom := FPointTo.Y + FWidth + FBorderWidth;
end;

{ ---------------------------------------------------------------------------- }
function TLMDLine.IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
var
  LCurrentVector: TPoint;
  LProjectionNn, LProjectionTn: Integer;
  LProjectionN, LProjectionT: Double;
  LFragN, LFragT: Double;
  LBorderWidth: Integer;
begin
  LBorderWidth := 0;
  LCurrentVector.X := APoint.X - FPointFrom.X;
  LCurrentVector.Y := APoint.Y - FPointFrom.Y;

  //if FAntiAliasing then
  begin
    LProjectionNn := LCurrentVector.X * FVectorN.X + LCurrentVector.Y * FVectorN.Y;
    LProjectionN := LProjectionNn / FLengthN;

    ABorderWidth := FBorderWidth;

    if LProjectionNn >= 0 then
      LFragN := LProjectionN - FLengthN
    else
      LFragN := -LProjectionN;

    //LFragN := LFragN + 0.5;

    if LFragN <= 0 then
      LFragN := 1
    else
    begin
      if LProjectionNn >= 0 then
      begin
        if ebsRight in FBorderSides then
          ABorderWidth := FBorderWidth
        else
          ABorderWidth := 0;
      end
      else
      begin
        if ebsLeft in FBorderSides then
          ABorderWidth := FBorderWidth
        else
          ABorderWidth := 0;
      end;

      if (LFragN > ABorderWidth + 1) then
        LFragN := 0
      else
        LFragN := (ABorderWidth + 1 - LFragN) / (ABorderWidth + 1);
    end;

    if LFragN = 0 then
      result := 0
    else
    begin
      LProjectionTn := LCurrentVector.X * FVectorT.X + LCurrentVector.Y * FVectorT.Y;
      LProjectionT := LProjectionTn / FLengthN;

      if LProjectionTn > 0 then
        LFragT := LProjectionT - FWidthLeft
      else
        LFragT := -LProjectionT - FWidthRight;

      //LFragT := LFragT + 0.5;

      if LFragT <= 0 then
        LFragT := 1
      else
      begin
        if LProjectionTn >= 0 then
        begin
          if ebsTop in FBorderSides then
            LBorderWidth := FBorderWidth
          else
            LBorderWidth := 0;
        end
        else
        begin
          if ebsBottom in FBorderSides then
            LBorderWidth := FBorderWidth
          else
            LBorderWidth := 0;
        end;

        if LFragT > LBorderWidth + 1 then
          LFragT := 0
        else
          LFragT := (LBorderWidth + 1 - LFragT) / (LBorderWidth + 1);
      end;

      if LFragN < LFragT then
        result := LFragN
      else
      begin
        result := LFragT;
        ABorderWidth := LBorderWidth;
      end;
    end;
  end
  {
  else
  begin
    LProjectionNn := LCurrentVector.X * FVectorN.X + LCurrentVector.Y * FVectorN.Y;

    if LProjectionNn >= 0 then
    begin
      LProjectionTn := LCurrentVector.X * FVectorT.X + LCurrentVector.Y * FVectorT.Y;

      if LProjectionTn >= 0 then
      begin
        if (LProjectionNn < FLengthN2) and (LProjectionTn < FWidthLeftN) then
          result := MaxDistForAntiAliasing
        else
          result := MinDistForAntiAliasing;
      end
      else
      begin
        if (LProjectionNn < FLengthN2) and ( - LProjectionTn < FWidthRightN) then
          result := MaxDistForAntiAliasing
        else
          result := MinDistForAntiAliasing;
      end;
    end
    else
      result := MinDistForAntiAliasing;
  end;
  }
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLine.Line(x1, y1, x2, y2, AWidth: integer);
begin
  PointFrom := Point(x1, y1);
  PointTo := Point(x2, y2);

  Width := AWidth;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLine.Line(APointFrom, APointTo: TPoint; AWidth: integer);
begin
  PointFrom := APointFrom;
  PointTo := APointTo;

  Width := AWidth;
end;

procedure TLMDLine.PreCalc;
begin
  FVectorN.X := FPointTo.X - FPointFrom.X;
  FVectorN.Y := FPointTo.Y - FPointFrom.Y;

  FVectorT.X := - FVectorN.Y;
  FVectorT.Y := FVectorN.X;

  FBasePoint := FPointFrom;
  inherited PreCalc;
  FWidthRight := FWidth div 2;
  FWidthLeft := FWidthRight + (FWidth mod 2);

  FWidthRightN := FWidthRight * FLengthN;
  FWidthLeftN := FWidthLeft * FLengthN;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLine.SetPointFrom(Value: TPoint);
begin
  FPointFrom := Value;
  PreCalc;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLine.SetPointTo(Value: TPoint);
begin
  FPointTo := Value;
  PreCalc;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDLine.SetWidth(Value: Integer);
begin
  FWidth := Value;
  PreCalc;
end;

{********************************** TLMDCircle ********************************}
constructor TLMDCircle.Create(x, y, ARadius: integer; AFiller: TLMDFiller = nil);
begin
  inherited Create(AFiller);
  Circle(x, y, ARadius);

  Filler := AFiller;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCircle.Create(ACenterPoint: TPoint; ARadius: integer; AFiller:
        TLMDFiller = nil);
begin
  inherited Create(AFiller);
  Circle(ACenterPoint, ARadius);

  Filler := AFiller;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCircle.Circle(x, y, ARadius: integer);
begin
  BasePoint := Point(x, y);

  Radius := ARadius;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCircle.Circle(ACenterPoint: TPoint; ARadius: integer);
begin
  BasePoint := ACenterPoint;

  Radius := ARadius;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCircle.GetCenter: TPoint;
begin
  result := BasePoint;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCircle.IncludeRect: TRect;
var
  HalfRectLength: Integer;
begin
  HalfRectLength := FRadius;
  if FAntiAliasing then
    Inc(HalfRectLength);
  result.Left := FBasePoint.X - HalfRectLength - FBorderWidth;
  result.Right := FBasePoint.X + HalfRectLength + FBorderWidth;
  result.Top := FBasePoint.Y - HalfRectLength - FBorderWidth;
  result.Bottom := FBasePoint.Y + HalfRectLength + FBorderWidth;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCircle.IsInside(APoint: TPoint; var ABorderWidth: integer): Double;
var
  LDistance: Double;
  X, Y: Integer;
begin
  X := APoint.X - FBasePoint.X;
  Y := APoint.Y - FBasePoint.Y;
  LDistance := Sqrt(X * X + Y * Y) - FRadius;
  if LDistance <= 0 then
    result := 1
  else
  begin
    if LDistance >= FBorderWidth + 1 then
      result := 0
    else
      result := 1 - LDistance / (FBorderWidth + 1);
  end;
  ABorderWidth := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCircle.SetCenter(Value: TPoint);
begin
  BasePoint := Value;
end;

procedure TLMDCircle.SetRadius(Value: Integer);
begin
  FRadius := Value;
  VectorN := Point(0, Value);
  VectorT := Point(Value, 0);
end;

{******************************** TLMDEllipse ********************************}
constructor TLMDEllipse.Create(x1, y1, x2, y2: integer; AFiller: TLMDFiller = nil);
begin
  inherited Create;
  Ellipse(x1, y1, x2, y2);

  Filler := AFiller;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDEllipse.Create(ARect: TRect; AFiller: TLMDFiller = nil);
begin
  inherited Create;
  Ellipse(Arect);

  Filler := AFiller;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEllipse.Ellipse(x1, y1, x2, y2: integer);
begin
  BasePoint := Point((x1 + x2) div 2, (y1 + y2) div 2);

  VectorN := Point((x2 - x1) div 2, 0);
  VectorT := Point(0, (y2 - y1) div 2);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEllipse.Ellipse(ARect: TRect);
begin
  Ellipse(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

{ ---------------------------------------------------------------------------- }
function TLMDEllipse.IncludeRect: TRect;
var
  BigHalfAxisLength: Integer;
begin
  BigHalfAxisLength := Max(FLengthN, FLengthT);
  if FAntiAliasing then
    Inc(BigHalfAxisLength);
  result.Left := FBasePoint.X - BigHalfAxisLength - FBorderWidth * 2;
  result.Right := FBasePoint.X + BigHalfAxisLength + FBorderWidth * 2;
  result.Top := FBasePoint.Y - BigHalfAxisLength - FBorderWidth * 2;
  result.Bottom := FBasePoint.Y + BigHalfAxisLength + FBorderWidth * 2;
end;

{ ---------------------------------------------------------------------------- }
function TLMDEllipse.IsInside(APoint: TPoint; var ABorderWidth: integer):
        Double;
var
  LDistance: Double;
  LVectorFrom_F1, LVectorFrom_F2: TPoint;
begin
  LVectorFrom_F1 := Point(APoint.X - FFocus1.X, APoint.Y - FFocus1.Y);
  LVectorFrom_F2 := Point(APoint.X - FFocus2.X, APoint.Y - FFocus2.Y);
  LDistance := Sqrt(LVectorFrom_F1.X * LVectorFrom_F1.X + LVectorFrom_F1.Y * LVectorFrom_F1.Y) +
               Sqrt(LVectorFrom_F2.X * LVectorFrom_F2.X + LVectorFrom_F2.Y * LVectorFrom_F2.Y);

  if LDistance<=FDistance then
    result := 1
  else
    begin
      if (LDistance - FDistance) >= FBorderWidth * 2 + 1 then
        result := 0
      else
        result := 1 - (LDistance - FDistance) / (FBorderWidth * 2 + 1);
    end;

  ABorderWidth := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEllipse.PreCalc;
var
  LDistanseCenterToFocus: Double;
  BigHalfAxis: TPoint;
begin
  inherited PreCalc;
  if (FLengthN2 <> 0) and (FLengthT2 <> 0) then
    begin
      LDistanseCenterToFocus := Sqrt(Abs(FLengthN2 - FLengthT2));

      if FLengthN > FLengthT then
        BigHalfAxis := FVectorN
      else
        BigHalfAxis := FVectorT;

      FDistance := Round(2 * Sqrt(BigHalfAxis.X * BigHalfAxis.X + BigHalfAxis.Y * BigHalfAxis.Y));

      FFocus1 := Point(Round(FBasePoint.X - BigHalfAxis.X * LDistanseCenterToFocus / FLengthN),
                       Round(FBasePoint.Y - BigHalfAxis.Y * LDistanseCenterToFocus / FLengthN));
      FFocus2 := Point(Round(FBasePoint.X + BigHalfAxis.X * LDistanseCenterToFocus / FLengthN),
                       Round(FBasePoint.Y + BigHalfAxis.Y * LDistanseCenterToFocus / FLengthN));
    end;
end;

{**************************** TLMDContainerFigure ****************************}
constructor TLMDContainerFigure.Create;
begin
  inherited Create;
  FFigureList := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDContainerFigure.Destroy;
begin
  FFigureList.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerFigure.Add(AFigure: TLMDFigure): Integer;
begin
  FFigureList.Add(AFigure);
  result := FFigureList.Count-1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerFigure.Count: Integer;
begin
  result := FFigureList.Count;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFigure.Clear(aFreeItems: boolean = false);
var
  i: integer;
begin
  for i := FFigureList.Count - 1 downto 0 do
    begin
      if aFreeItems then
        TLMDFigure(FFigureList.Items[i]).Free;
      FFigureList.Delete(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFigure.Delete(AFigure: TLMDFigure);
begin
  if FFigureList.IndexOf(AFigure) > 0 then
    FFigureList.Delete(FFigureList.IndexOf(AFigure));
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerFigure.GetItem(Index: Integer): TLMDFigure;
begin
  if Index < FFigureList.Count then
    result := TLMDFigure(FFigureList.Items[Index])
  else
    result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerFigure.IncludeRect: TRect;
var
  i: Integer;
  LFigureRect: TRect;
begin
  if Count > 0 then
  begin
    result := TLMDFigure(FFigureList.Items[0]).IncludeRect;

    for i:=1 to Count - 1 do
    begin
      LFigureRect := TLMDFigure(FFigureList.Items[i]).IncludeRect;
      result.Left := min(result.Left, LFigureRect.Left);
      result.Top := min(result.Top, LFigureRect.Top);
      result.Right := max(result.Right, LFigureRect.Right);
      result.Bottom := max(result.Bottom, LFigureRect.Bottom);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDContainerFigure.IsInside(APoint: TPoint; var ABorderWidth:
        integer): Double;
var
  i: Integer;
  LBorderWidth: Integer;
begin
  result := 0;

  for i:=0 to Count - 1 do
  begin
    result := max(result, TLMDFigure(FFigureList.Items[i]).IsInside(APoint, LBorderWidth));
  end;

  ABorderWidth := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFigure.SetBorderColor(Value: TColor);
var
  i: Integer;
begin
  inherited SetBorderColor(Value);
  for i:=0 to Count-1 do
    TLMDFigure(FFigureList.Items[i]).BorderColor := value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFigure.SetBorderWidth(Value: Integer);
var
  i: Integer;
begin
  inherited SetBorderWidth(Value);
  for i:=0 to Count-1 do
    TLMDFigure(FFigureList.Items[i]).BorderWidth := value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFigure.SetItem(Index: Integer; Value: TLMDFigure);
begin
  if Index < FFigureList.Count then
    FFigureList.Items[Index] := Value;
end;

{****************************** TLMDUnionFigure ******************************}
function TLMDUnionFigure.IncludeRect: TRect;
var
  i: Integer;
  LFigureRect: TRect;
begin
  if Count > 0 then
  begin
    result := TLMDFigure(FFigureList.Items[0]).IncludeRect;

    for i:=1 to Count - 1 do
    begin
      LFigureRect := TLMDFigure(FFigureList.Items[i]).IncludeRect;
      result.Left := min(result.Left, LFigureRect.Left);
      result.Top := min(result.Top, LFigureRect.Top);
      result.Right := max(result.Right, LFigureRect.Right);
      result.Bottom := max(result.Bottom, LFigureRect.Bottom);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDUnionFigure.IsInside(APoint: TPoint; var ABorderWidth: integer):
        Double;
var
  i: Integer;
  LBorderWidth: Integer;
begin
  result := 0;
  for i:=0 to Count - 1 do
    result := max(result, TLMDFigure(FFigureList.Items[i]).IsInside(APoint, LBorderWidth));
  ABorderWidth := -1;
end;

{**************************** TLMDIntersectFigure ****************************}
function TLMDIntersectFigure.IncludeRect: TRect;
var
  i: Integer;
  LFigureRect: TRect;
begin
  if Count > 0 then
  begin
    result := TLMDFigure(FFigureList.Items[0]).IncludeRect;

    for i:=1 to Count - 1 do
    begin
      LFigureRect := TLMDFigure(FFigureList.Items[i]).IncludeRect;
      result.Left := max(result.Left, LFigureRect.Left);
      result.Top := max(result.Top, LFigureRect.Top);
      result.Right := min(result.Right, LFigureRect.Right);
      result.Bottom := min(result.Bottom, LFigureRect.Bottom);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIntersectFigure.IsInside(APoint: TPoint; var ABorderWidth:
        integer): Double;
var
  i: Integer;
  LBorderWidth: Integer;
begin
  result := 0;
  if Count > 0 then
  begin
    result := TLMDFigure(FFigureList.Items[0]).IsInside(APoint, LBorderWidth);

    for i:=1 to Count - 1 do
      result := min(result, TLMDFigure(FFigureList.Items[i]).IsInside(APoint, LBorderWidth));
  end;

  ABorderWidth := -1;
end;


{**************************** TLMDSubtractionFigure ***************************}

function TLMDSubtractionFigure.IncludeRect: TRect;
begin
  if Count > 0 then
    result := TLMDFigure(FFigureList.Items[0]).IncludeRect;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSubtractionFigure.IsInside(APoint: TPoint;
  var ABorderWidth: integer): Double;
var
  i: Integer;
  LBorderWidth: Integer;
  r: double;
begin
  result := 0;
  if Count > 0 then
  begin
    result := TLMDFigure(FFigureList.Items[0]).IsInside(APoint, LBorderWidth);
    r := 0;
    for i := 1 to Count - 1 do
      r := max(r, TLMDFigure(FFigureList.Items[i]).IsInside(APoint, LBorderWidth));

    if (result > 0) and (result < 1) then
      begin
        if r = 1 then
          result := 0
        else
          if r > 0.5 then
            result := 1 - r;
      end
    else
      begin
        if result = 1 then
          begin
            if (r = 1) then
              result := 0
            else
              result := 1 - r;
          end;
      end;
  end;
  ABorderWidth := -1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDContainerFigure.PreCalc;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFigure.Draw(ABitMap: TBitMap; aPixelFormat: TPixelFormat; aUsePremult: boolean = true);
begin
  case aPixelFormat of
    pf24bit: Draw24(aBitMap);
    pf32bit: Draw32(aBitMap, aUsePremult);
  end;
end;

end.
