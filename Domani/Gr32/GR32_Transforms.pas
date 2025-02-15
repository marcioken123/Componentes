unit GR32_Transforms;

{*********************************************}
{  This unit is a part of Graphics32 library  }
{  Copyright � 2000-2003 Alex Denisov         }
{  See License.txt for licence information    }
{*********************************************}
// $Id: GR32_Transforms.pas,v 1.10 2003/05/20 16:59:14 Alex Exp $

interface

{$I GR32.INC}

uses
  Windows, SysUtils, Classes, GR32, GR32_Blend;

type
  ETransformError = class(Exception);

procedure BlockTransfer(
  Dst: TBitmap32; DstX: Integer; DstY: Integer; DstClip: TRect;
  Src: TBitmap32; SrcRect: TRect;
  CombineOp: TDrawMode; CombineCallBack: TPixelCombineEvent = nil);


procedure StretchTransfer(
  Dst: TBitmap32; DstRect: TRect; DstClip: TRect;
  Src: TBitmap32; SrcRect: TRect;
  StretchFilter: TStretchFilter;
  CombineOp: TDrawMode; CombineCallBack: TPixelCombineEvent = nil);

type
  TFloatMatrix = array[0..2, 0..2] of Single;  // 3x3 single precision

const
  IdentityMatrix: TFloatMatrix = (
    (1, 0, 0),
    (0, 1, 0),
    (0, 0, 1));

type
  TVector3f = array[0..2] of Single;
  TVector3i = array[0..2] of Integer;

procedure Adjoint(var M: TFloatMatrix);
function Determinant(const M: TFloatMatrix): Single;
procedure Scale(var M: TFloatMatrix; Factor: Single);
procedure Invert(var M: TFloatMatrix);
function Mult(const M1, M2: TFloatMatrix): TFloatMatrix;

type
  TTransformation = class(TObject)
  private
    FSrcRect: TFloatRect;
    procedure SetSrcRect(const Value: TFloatRect);
    procedure Transform(DstX, DstY: Integer; out SrcX, SrcY: Integer); virtual; abstract;
    procedure Transform256(DstX, DstY: Integer; out SrcX256, SrcY256: Integer); virtual; abstract;
  protected
    TransformValid: Boolean;
    procedure PrepareTransform; virtual; abstract;
  public
    function  GetTransformedBounds: TRect; virtual; abstract;
    property SrcRect: TFloatRect read FSrcRect write SetSrcRect;
  end;

  TAffineTransformation = class(TTransformation)
  protected
    A, B, C: Integer;
    D, E, F: Integer;
    procedure PrepareTransform; override;
    procedure Transform(DstX, DstY: Integer; out SrcX, SrcY: Integer); override;
    procedure Transform256(DstX, DstY: Integer; out SrcX256, SrcY256: Integer); override;
  public
    Matrix: TFloatMatrix;
    constructor Create; virtual;
    function  GetTransformedBounds: TRect; override;
    procedure Clear;
    procedure Rotate(Cx, Cy, Alpha: Single); // degrees
    procedure Skew(Fx, Fy: Single);
    procedure Scale(Sx, Sy: Single);
    procedure Translate(Dx, Dy: Single);
  end;

  TProjectiveTransformation = class(TTransformation)
  private
    Wx0, Wx1, Wx2, Wx3: Single;
    Wy0, Wy1, Wy2, Wy3: Single;
    procedure SetX0(Value: Single);
    procedure SetX1(Value: Single);
    procedure SetX2(Value: Single);
    procedure SetX3(Value: Single);
    procedure SetY0(Value: Single);
    procedure SetY1(Value: Single);
    procedure SetY2(Value: Single);
    procedure SetY3(Value: Single);
  protected
    M: TFloatMatrix;
    procedure PrepareTransform; override;
    procedure Transform(DstX, DstY: Integer; out SrcX, SrcY: Integer); override;
    procedure Transform256(DstX, DstY: Integer; out SrcX256, SrcY256: Integer); override;
  public
    function  GetTransformedBounds: TRect; override;
    property X0: Single read Wx0 write SetX0;
    property X1: Single read Wx1 write SetX1;
    property X2: Single read Wx2 write SetX2;
    property X3: Single read Wx3 write SetX3;
    property Y0: Single read Wy0 write SetY0;
    property Y1: Single read Wy1 write SetY1;
    property Y2: Single read Wy2 write SetY2;
    property Y3: Single read Wy3 write SetY3;
  end;

procedure Transform(Dst, Src: TBitmap32; Transformation: TTransformation);
procedure SetBorderTransparent(ABitmap: TBitmap32; ARect: TRect);

{ FullEdge controls how the bitmap is resampled }
var
  FullEdge: Boolean = True;

implementation

{$R-}{$Q-}  // switch off overflow and range checking

uses GR32_LowLevel, Math;

const
  SDstEmpty = 'Destination bitmap is nil or empty';
  SSrcEmpty = 'Source bitmap is nil or empty';
  SSrcInvalid = 'Source rectangle is invalid';

procedure CheckBitmaps(Dst, Src: TBitmap32);
begin
  if not Assigned(Dst) or Dst.Empty then raise ETransformError.Create(SDstEmpty);
  if not Assigned(Src) or Src.Empty then raise ETransformError.Create(SSrcEmpty);
end;

function CheckSrcRect(Src: TBitmap32; const SrcRect: TRect): Boolean;
begin
  Result := False;
  if IsRectEmpty(SrcRect) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Top < 0) or (SrcRect.Bottom > Src.Height) then
    raise ETransformError.Create(SSrcInvalid);
  Result := True;
end;

procedure BlendBlock(
  Dst: TBitmap32; DstRect: TRect;
  Src: TBitmap32; SrcX, SrcY: Integer;
  CombineOp: TDrawMode; CombineCallBack: TPixelCombineEvent);
var
  SrcP, DstP: PColor32;
  SP, DP: PColor32;
  W, I, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    case CombineOp of
      dmOpaque: MoveLongWord(SrcP^, DstP^, W);
      dmBlend:
        if Src.MasterAlpha >= 255 then BlendLine(SrcP, DstP, W)
        else BlendLineEx(SrcP, DstP, W, Src.MasterAlpha);
    else //  dmCustom:
      begin
        SP := SrcP;
        DP := DstP;
        for I := 0 to W - 1 do
        begin
          CombineCallBack(SP^, DP^, Src.MasterAlpha);
          Inc(SP); Inc(DP);
        end;
      end;
    end;
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
  end;
end;

procedure BlockTransfer(
  Dst: TBitmap32; DstX: Integer; DstY: Integer; DstClip: TRect;
  Src: TBitmap32; SrcRect: TRect;
  CombineOp: TDrawMode; CombineCallBack: TPixelCombineEvent);
var
  SrcX, SrcY: Integer;
begin
  if Src.Empty then Exit;
  CheckBitmaps(Src, Dst);

  if (CombineOp = dmCustom) and not Assigned(CombineCallBack) then
    CombineOp := dmOpaque;

  if (CombineOp = dmBlend) and (Src.MasterAlpha = 0) then Exit;

  SrcX := SrcRect.Left;
  SrcY := SrcRect.Top;

  IntersectRect(DstClip, DstClip, Dst.BoundsRect);
  IntersectRect(SrcRect, SrcRect, Src.BoundsRect);
  OffsetRect(SrcRect, DstX - SrcX, DstY - SrcY);
  IntersectRect(SrcRect, DstClip, SrcRect);
  DstClip := SrcRect;
  OffsetRect(SrcRect, SrcX - DstX, SrcY - DstY);

  if not IsRectEmpty(SrcRect) then 
  try
    BlendBlock(Dst, DstClip, Src, SrcRect.Left, SrcRect.Top, CombineOp, CombineCallBack);
  finally
    EMMS;
  end;
end;


procedure StretchNearest(
  Dst: TBitmap32; DstRect, DstClip: TRect;
  Src: TBitmap32; SrcRect: TRect;
  CombineOp: TDrawMode; CombineCallBack: TPixelCombineEvent);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PColor32Array;
  Buffer: TArrayOfColor32;
  Scale: Single;
begin
  IntersectRect(DstClip, DstClip, MakeRect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then raise Exception.Create('Invalid SrcRect');

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BlendBlock(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top, CombineOp, CombineCallBack);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        if FullEdge then
        begin
          Scale := SrcW / DstW;
          for I := 0 to DstClipW - 1 do
            MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
        end
        else
        begin
          Scale := (SrcW - 1) / (DstW - 1);
          for I := 0 to DstClipW - 1 do
            MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
        end;
        Assert(MapHorz[0] >= SrcRect.Left);
        Assert(MapHorz[DstClipW - 1] < SrcRect.Right);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH <= 1 then Scale := 0
      else if FullEdge then Scale := SrcH / DstH
      else Scale := (SrcH - 1) / (DstH - 1);

      if CombineOp = dmOpaque then
      begin
        DstLine := PColor32Array(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
        OldSrcY := -1;
        for J := 0 to DstClipH - 1 do
        begin
          if DstH <= 1 then
            SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2
          else if FullEdge then
            SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale)
          else
            SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
          if SrcY <> OldSrcY then
          begin
            SrcLine := Src.ScanLine[SrcY];
            for I := 0 to DstClipW - 1 do DstLine[I] := SrcLine[MapHorz[I]];
            OldSrcY := SrcY;
          end
          else
            MoveLongWord(DstLine[-Dst.Width], DstLine[0], DstClipW);
          Inc(DstLine, Dst.Width);
        end;
      end
      else
      begin
        SetLength(Buffer, DstClipW);
        DstLine := PColor32Array(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
        OldSrcY := -1;
        for J := 0 to DstClipH - 1 do
        begin
          if DstH > 1 then
          begin
            EMMS;
            SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
          end
          else
            SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
          if SrcY <> OldSrcY then
          begin
            SrcLine := Src.ScanLine[SrcY];
            for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
            OldSrcY := SrcY;
          end;

          if CombineOp = dmBlend then
          begin
            if Src.MasterAlpha >= 255 then BlendLine(@Buffer[0], @DstLine[0], DstClipW)
            else BlendLineEx(@Buffer[0], @DstLine[0], DstClipW, Src.MasterAlpha);
          end
          else
            for I := 0 to DstClipW - 1 do
              CombineCallBack(Buffer[I], DstLine[I], Src.MasterAlpha);

          Inc(DstLine, Dst.Width);
        end;
      end;
    end;
  finally
    EMMS;
  end;
end;

type
  TPointRec = record
    Pos: Integer;
    Weight: Cardinal;
  end;

procedure StretchHorzStretchVertLinear(
  Dst: TBitmap32; DstRect, DstClip: TRect;
  Src: TBitmap32; SrcRect: TRect;
  CombineOp: TDrawMode; CombineCallBack: TPixelCombineEvent);
var
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  MapHorz, MapVert: array of TPointRec;
  t: Integer;
  t2, Scale: Single;
  SrcLine, DstLine: PColor32Array;
  SrcIndex, OldSrcIndex: Integer;
  I, J: Integer;
  WX, WY, WY2: Cardinal;
  C, C11, C12, C21, C22, CL, CR: TColor32;
  LeftAG, LeftRB, RightAG, RightRB, AG, RB: Cardinal;
  R, G, B, A: Cardinal;
begin
  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  Assert((DstW > SrcW) and (DstH > SrcH));

  SetLength(MapHorz, DstClipW);
  if FullEdge then Scale := SrcW / DstW
  else Scale := (SrcW - 1) / (DstW - 1);
  for I := 0 to DstClipW - 1 do
  begin
    if FullEdge then t2 := SrcRect.Left - 0.5 + (I + DstClip.Left - DstRect.Left + 0.5) * Scale
    else t2 := SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale;
    if t2 < 0 then t2 := 0
    else if t2 > Src.Width - 1 then t2 := Src.Width - 1;
    MapHorz[I].Pos := Floor(t2);
    MapHorz[I].Weight := 256 - Round(Frac(t2) * 256);
  end;
  if MapHorz[DstClipW - 1].Pos = SrcRect.Right - 1 then
  begin
    Dec(MapHorz[DstClipW - 1].Pos);
    MapHorz[DstClipW - 1].Weight := 0;
  end;

  SetLength(MapVert, DstClipH);
  if FullEdge then Scale := SrcH / DstH
  else Scale := (SrcH - 1) / (DstH - 1);
  for I := 0 to DstClipH - 1 do
  begin
    if FullEdge then t2 := SrcRect.Top - 0.5 + (I + DstClip.Top - DstRect.Top + 0.5) * Scale
    else t2 := SrcRect.Top + (I + DstClip.Top - DstRect.Top) * Scale;
    if t2 < 0 then t2 := 0
    else if t2 > Src.Height - 1 then t2 := Src.Height - 1;
    MapVert[I].Pos := Floor(t2);
    MapVert[I].Weight := 256 - Round(Frac(t2) * 256);
  end;
  if MapVert[DstClipH - 1].Pos = SrcRect.Bottom - 1 then
  begin
    Dec(MapVert[DstClipH - 1].Pos);
    MapVert[DstClipH - 1].Weight := 0;
  end;

  DstLine := PColor32Array(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
  LeftRB := 0;
  LeftAG := 0;
  RightRB := 0;
  RightAG := 0;
  for J := 0 to DstClipH - 1 do
  begin
    SrcLine := Src.ScanLine[MapVert[J].Pos];
    WY := MapVert[J].Weight;
    WY2 := 256 - WY;
    OldSrcIndex := -1;
    case CombineOp of
      dmOpaque:
        for I := 0 to DstClipW - 1 do
        begin
          SrcIndex := MapHorz[I].Pos;
          if SrcIndex <> OldSrcIndex then
          begin
            C11 := SrcLine[SrcIndex];
            LeftRB := (C11 and $00FF00FF) * WY;
            C12 := SrcLine[SrcIndex + 1];
            LeftAG := (C11 shr 8 and $00FF00FF) * WY;
            RightRB := (C12 and $00FF00FF) * WY;
            C21 := SrcLine[SrcIndex + Src.Width];
            RightAG := (C12 shr 8 and $00FF00FF) * WY;

            Inc(LeftRB, (C21 and $00FF00FF) * WY2);
            C22 := SrcLine[SrcIndex + Src.Width + 1];
            Inc(LeftAG, (C21 shr 8 and $00FF00FF) * WY2);
            Inc(RightRB, (C22 and $00FF00FF) * WY2);
            Inc(RightAG, (C22 shr 8 and $00FF00FF) * WY2);

            LeftRB := LeftRB shr 8 and $00FF00FF;
            LeftAG := LeftAG shr 8 and $00FF00FF;
            OldSrcIndex := SrcIndex;
            RightRB := RightRB shr 8 and $00FF00FF;
            RightAG := RightAG shr 8 and $00FF00FF;
          end;

          WX := MapHorz[I].Weight;
          RB := LeftRB * WX;
          AG := LeftAG * WX;
          WX := 256 - WX;
          DstLine[I] := (AG  + RightAG * WX) and $FF00FF00 or (RB + RightRB * WX) shr 8 and $00FF00FF;
        end;
    else
        for I := 0 to DstClipW - 1 do
        begin
          SrcIndex := MapHorz[I].Pos;
          if SrcIndex <> OldSrcIndex then
          begin
            C11 := SrcLine[SrcIndex];
            LeftRB := (C11 and $00FF00FF) * WY;
            C12 := SrcLine[SrcIndex + 1];
            LeftAG := (C11 shr 8 and $00FF00FF) * WY;
            RightRB := (C12 and $00FF00FF) * WY;
            C21 := SrcLine[SrcIndex + Src.Width];
            RightAG := (C12 shr 8 and $00FF00FF) * WY;

            Inc(LeftRB, (C21 and $00FF00FF) * WY2);
            C22 := SrcLine[SrcIndex + Src.Width + 1];
            Inc(LeftAG, (C21 shr 8 and $00FF00FF) * WY2);
            Inc(RightRB, (C22 and $00FF00FF) * WY2);
            Inc(RightAG, (C22 shr 8 and $00FF00FF) * WY2);

            LeftRB := LeftRB shr 8 and $00FF00FF;
            LeftAG := LeftAG shr 8 and $00FF00FF;
            OldSrcIndex := SrcIndex;
            RightRB := RightRB shr 8 and $00FF00FF;
            RightAG := RightAG shr 8 and $00FF00FF;
          end;

          WX := MapHorz[I].Weight;
          RB := LeftRB * WX;
          AG := LeftAG * WX;
          WX := 256 - WX;
          C := (AG  + RightAG * WX) and $FF00FF00 or (RB + RightRB * WX) shr 8 and $00FF00FF;

          if CombineOp = dmBlend then BlendMemEx(C, DstLine[I], Src.MasterAlpha)
          else CombineCallBack(C, DstLine[I], Src.MasterAlpha);
        end;
    end;
    Inc(DstLine, Dst.Width);
  end;
end;

{ StretchFlt }

type
  TCluster = array of TPointRec;
  TMappingTable = array of TCluster;
  TFilterFunc = function(Value: Single): Single;

function NearestFilter(Value: Single): Single;
begin
  if (Value > -0.5) and (Value <= 0.5) then Result := 1
  else Result := 0;
end;

function LinearFilter(Value: Single): Single;
begin
  if Value < -1 then Result := 0
  else if Value < 0 then Result := 1 + Value
  else if Value < 1 then Result := 1 - Value
  else Result := 0;
end;

function SplineFilter(Value: Single): Single;
var
  tt: Single;
begin
  Value := Abs(Value);
  if Value < 1 then
  begin
    tt := Sqr(Value);
    Result := 0.5 * tt * Value - tt + 2 / 3;
  end
  else if Value < 2 then
  begin
    Value := 2 - Value;
    Result := 1 / 6 * Sqr(Value) * Value;
  end
  else Result := 0;
end;

function Sinc(Value: Single): Single;
begin
  if Value <> 0 then
  begin
    Value := Value * Pi;
    Result := Sin(Value) / Value;
  end
  else Result := 1;
end;

function LanczosFilter(Value: Single): Single;
begin
  Value := Abs(Value);
  if Value < 3 then Result := Sinc(Value) * Sinc(Value / 3)
  else Result := 0;
end;

function MitchellFilter(Value: Single): Single;
var
  tt, ttt: Single;
begin
  Value := Abs(Value);
  tt := Sqr(Value);
  ttt := tt * Value;
  if Value < 1 then Result := (7 * ttt + -12 * tt + 16 / 3) / 6
  else if Value < 2 then Result := (-7 / 3 * ttt + 12 * tt - 20 * Value + 32 / 3) / 6
  else Result := 0;
end;

function BuildMappingTable(
  DstLo, DstHi: Integer;
  ClipLo, ClipHi: Integer;
  SrcLo, SrcHi: Integer;
  StretchFilter: TStretchFilter): TMappingTable;
const
  { the first filter from these arrays is never used since the nearest and
    filter is implemented separately }
  FILTERS: array[TStretchFilter] of TFilterFunc = (NearestFilter, LinearFilter,
    SplineFilter, LanczosFilter, MitchellFilter);
  FILTERWIDTHS: array [TStretchFilter] of Single = (1, 1, 2, 3, 2);
var
  SrcW, DstW, ClipW: Integer;
  Filter: TFilterFunc;
  FilterWidth: Single;
  Scale, OldScale: Single;
  Center: Single;
  Count: Integer;
  Left, Right: Integer;
  I, J, K: Integer;
  Weight: Integer;
begin
  SrcW := SrcHi - SrcLo;
  DstW := DstHi - DstLo;
  ClipW := ClipHi - ClipLo;
  if SrcW = 0 then
  begin
    Result := nil;
    Exit;
  end
  else if SrcW = 1 then
  begin
    SetLength(Result, ClipW);
    for I := 0 to ClipW - 1 do
    begin
      SetLength(Result[I], 1);
      Result[I][0].Pos := 0;
      Result[I][0].Weight := 256;
    end;
    Exit;
  end;
  SetLength(Result, ClipW);
  if ClipW = 0 then Exit;

  if FullEdge then Scale := DstW / SrcW
  else Scale := (DstW - 1) / (SrcW - 1);

  Filter := FILTERS[StretchFilter];
  FilterWidth := FILTERWIDTHS[StretchFilter];
  K := 0;

  if Scale = 0 then
  begin
    Assert(Length(Result) = 1);
    SetLength(Result[0], 1);
    Result[0][0].Pos := (SrcLo + SrcHi) div 2;
    Result[0][0].Weight := 256;
  end
  else if Scale < 1 then
  begin
    OldScale := Scale;
    Scale := 1 / Scale;
    FilterWidth := FilterWidth * Scale;
    for I := 0 to ClipW - 1 do
    begin
      if FullEdge then
        Center := SrcLo - 0.5 + (I - DstLo + ClipLo + 0.5) * Scale
      else
        Center := SrcLo + (I - DstLo + ClipLo) * Scale;
      Left := Floor(Center - FilterWidth);
      Right := Ceil(Center + FilterWidth);
      Count := -256;
      for J := Left to Right do
      begin
        Weight := Round(256 * Filter((Center - J) * OldScale) * OldScale);
        if Weight <> 0 then
        begin
          Inc(Count, Weight);
          K := Length(Result[I]);
          SetLength(Result[I], K + 1);
          Result[I][K].Pos := Constrain(J, SrcLo, SrcHi - 1);
          Result[I][K].Weight := Weight;
        end;
      end;
      if Length(Result[I]) = 0 then
      begin
        SetLength(Result[I], 1);
        Result[I][0].Pos := Floor(Center);
        Result[I][0].Weight := 256;
      end
      else if Count <> 0 then
        Dec(Result[I][K div 2].Weight, Count);
    end;
  end
  else // scale > 1
  begin
    Scale := 1 / Scale;
    for I := 0 to ClipW - 1 do
    begin
      if FullEdge then
        Center := SrcLo - 0.5 + (I - DstLo + ClipLo + 0.5) * Scale
      else
        Center := SrcLo + (I - DstLo + ClipLo) * Scale;
      Left := Floor(Center - FilterWidth);
      Right := Ceil(Center + FilterWidth);
      Count := -256;
      for J := Left to Right do
      begin
        Weight := Round(256 * Filter(Center - j));
        if Weight <> 0 then
        begin
          Inc(Count, Weight);
          K := Length(Result[I]);
          SetLength(Result[I], k + 1);
          Result[I][K].Pos := Constrain(j, SrcLo, SrcHi - 1);
          Result[I][K].Weight := Weight;
        end;
      end;
      if Count <> 0 then
        Dec(Result[I][K div 2].Weight, Count);
    end;
  end;
end;

{$WARNINGS OFF}
procedure Resample(
  Dst: TBitmap32; DstRect: TRect; DstClip: TRect;
  Src: TBitmap32; SrcRect: TRect;
  StretchFilter: TStretchFilter;
  CombineOp: TDrawMode; CombineCallBack: TPixelCombineEvent);
type
  TBufferEntry = record
    R, G, B, A: Integer;
  end;
var
  SrcW, SrcH: Single;
  DstW, DstH: Integer;
  DstClipW, DstClipH: Integer;
  t: Single;
  MapX, MapY: TMappingTable;
  I, J, X, Y, Index: Integer;
  MapXLoPos, MapXHiPos: Integer;
  HorzBuffer: array of TBufferEntry;
  ClusterX, ClusterY: TCluster;
  ClusterXSize, ClusterYSize: Integer;
  C, Wt, Cr, Cg, Cb, Ca: Integer;
  ClustYP, ClustYW, ClustXP, ClustXW: Integer;
  SrcP: PColor32;
  DstLine: PColor32Array;
  RangeCheck: Boolean;
begin
  if (CombineOp = dmCustom) and not Assigned(CombineCallBack) then
    CombineOp := dmOpaque;

  { check source and destination }
  if (CombineOp = dmBlend) and (Src.MasterAlpha = 0) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;

  // mapping tables
  MapX := BuildMappingTable(DstRect.Left, DstRect.Right, DstClip.Left, DstClip.Right, SrcRect.Left, SrcRect.Right, StretchFilter);
  MapY := BuildMappingTable(DstRect.Top, DstRect.Bottom, DstClip.Top, DstClip.Bottom, SrcRect.Top, SrcRect.Bottom, StretchFilter);
  ClusterX := nil;
  ClusterY := nil;
  try
    RangeCheck := StretchFilter in [sfLanczos, sfMitchell];
    if (MapX = nil) or (MapY = nil) then Exit;

    MapXLoPos := MapX[0][0].Pos;
    MapXHiPos := MapX[DstClipW - 1][High(MapX[DstClipW - 1])].Pos;
    SetLength(HorzBuffer, MapXHiPos - MapXLoPos + 1);

    { transfer pixels }
    for J := DstClip.Top to DstClip.Bottom - 1 do
    begin

      ClusterY := MapY[J - DstClip.Top];
      for X := MapXLoPos to MapXHiPos do
      begin
        Ca := 0; Cr := 0; Cg := 0; Cb := 0;
        for Y := 0 to Length(ClusterY) - 1 do
        begin
          C := Src.Bits[X + ClusterY[Y].Pos * Src.Width];
          ClustYW := ClusterY[Y].Weight;
          Inc(Ca, C shr 24 * ClustYW);
          Inc(Cr, (C and $00FF0000) shr 16 * ClustYW);
          Inc(Cg, (C and $0000FF00) shr 8 * ClustYW);
          Inc(Cb, (C and $000000FF) * ClustYW);
        end;
        with HorzBuffer[X - MapXLoPos] do
        begin
          R := Cr;
          G := Cg;
          B := Cb;
          A := Ca;
        end;
      end;

      DstLine := Dst.ScanLine[J];
      for I := DstClip.Left to DstClip.Right - 1 do
      begin
        ClusterX := MapX[I - DstClip.Left];
        Ca := 0; Cr := 0; Cg := 0; Cb := 0;
        for X := 0 to Length(ClusterX) - 1 do
        begin
          Wt := ClusterX[X].Weight;
          with HorzBuffer[ClusterX[X].Pos - MapXLoPos] do
          begin
            Inc(Ca, A * Wt);
            Inc(Cr, R * Wt);
            Inc(Cg, G * Wt);
            Inc(Cb, B * Wt);
          end;
        end;

        if RangeCheck then
        begin
          if Ca > $FF0000 then Ca := $FF0000
          else if Ca < 0 then Ca := 0
          else Ca := Ca and $00FF0000;

          if Cr > $FF0000 then Cr := $FF0000
          else if Cr < 0 then Cr := 0
          else Cr := Cr and $00FF0000;

          if Cg > $FF0000 then Cg := $FF0000
          else if Cg < 0 then Cg := 0
          else Cg := Cg and $00FF0000;

          if Cb > $FF0000 then Cb := $FF0000
          else if Cb < 0 then Cb := 0
          else Cb := Cb and $00FF0000;

          C := (Ca shl 8) or Cr or (Cg shr 8) or (Cb shr 16);
        end
        else
          C := ((Ca and $00FF0000) shl 8) or (Cr and $00FF0000) or ((Cg and $00FF0000) shr 8) or ((Cb and $00FF0000) shr 16);


        // combine it with the background
        case CombineOp of
          dmOpaque: DstLine[I] := C;
          dmBlend: BlendMemEx(C, DstLine[I], Src.MasterAlpha);
          dmCustom: CombineCallBack(C, DstLine[I], Src.MasterAlpha);
        end;
      end;
    end;
  finally
    EMMS;
    MapX := nil;
    MapY := nil;
  end;
end;
{$WARNINGS ON}


{$WARNINGS OFF}
procedure StretchTransfer(
  Dst: TBitmap32; DstRect: TRect; DstClip: TRect;
  Src: TBitmap32; SrcRect: TRect;
  StretchFilter: TStretchFilter;
  CombineOp: TDrawMode; CombineCallBack: TPixelCombineEvent);
var
  SrcW, SrcH: Single;
  DstW, DstH: Integer;
  R: TRect;
begin
  if Src.Empty then Exit;
  CheckBitmaps(Dst, Src);
  if not CheckSrcRect(Src, SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, MakeRect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;

  if (CombineOp = dmCustom) and not Assigned(CombineCallBack) then CombineOp := dmOpaque;
  if (CombineOp = dmBlend) and (Src.MasterAlpha = 0) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;

  try
    if (SrcW = DstW) and (SrcH = DstH) then
      BlendBlock(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top, CombineOp, CombineCallBack)
    else case StretchFilter of
      sfNearest: StretchNearest(Dst, DstRect, DstClip, Src, SrcRect, CombineOp, CombineCallBack);
      sfLinear:
        if (DstW > SrcW) and (DstH > SrcH) then
          StretchHorzStretchVertLinear(Dst, DstRect, DstClip, Src, SrcRect, CombineOp, CombineCallBack)
        else
          Resample(Dst, DstRect, DstClip, Src, SrcRect, sfLinear, CombineOp, CombineCallBack);
    else
      Resample(Dst, DstRect, DstClip, Src, SrcRect, StretchFilter, CombineOp, CombineCallBack);
    end;

  finally
    EMMS;
  end;
end;
{$WARNINGS ON}


{ A bit of linear algebra }

function _DET(a1, a2, b1, b2: Single): Single; overload;
begin
  Result := a1 * b2 - a2 * b1;
end;

function _DET(a1, a2, a3, b1, b2, b3, c1, c2, c3: Single): Single; overload;
begin
  Result :=
    a1 * (b2 * c3 - b3 * c2) -
    b1 * (a2 * c3 - a3 * c2) +
    c1 * (a2 * b3 - a3 * b2);
end;

procedure Adjoint(var M: TFloatMatrix);
var
  a1, a2, a3: Single;
  b1, b2, b3: Single;
  c1, c2, c3: Single;
begin
  a1 := M[0,0]; a2:= M[0,1]; a3 := M[0,2];
  b1 := M[1,0]; b2:= M[1,1]; b3 := M[1,2];
  c1 := M[2,0]; c2:= M[2,1]; c3 := M[2,2];

  M[0,0]:= _DET(b2, b3, c2, c3);
  M[0,1]:=-_DET(a2, a3, c2, c3);
  M[0,2]:= _DET(a2, a3, b2, b3);

  M[1,0]:=-_DET(b1, b3, c1, c3);
  M[1,1]:= _DET(a1, a3, c1, c3);
  M[1,2]:=-_DET(a1, a3, b1, b3);

  M[2,0]:= _DET(b1, b2, c1, c2);
  M[2,1]:=-_DET(a1, a2, c1, c2);
  M[2,2]:= _DET(a1, a2, b1, b2);
end;

function Determinant(const M: TFloatMatrix): Single;
begin
  Result := _DET(M[0,0], M[1,0], M[2,0],
                 M[0,1], M[1,1], M[2,1],
                 M[0,2], M[1,2], M[2,2]);
end;

procedure Scale(var M: TFloatMatrix; Factor: Single);
var
  i, j: Integer;
begin
  for i := 0 to 2 do
    for j := 0 to 2 do
      M[i,j] := M[i,j] * Factor;
end;

procedure Invert(var M: TFloatMatrix);
var
  Det: Single;
begin
  Det := Determinant(M);
  if Abs(Det) < 1E-5 then M := IdentityMatrix
  else
  begin
    Adjoint(M);
    Scale(M, 1 / Det);
  end;
end;

function Mult(const M1, M2: TFloatMatrix): TFloatMatrix;
var
  i, j: Integer;
begin
  for i := 0 to 2 do
    for j := 0 to 2 do
      Result[i, j] :=
        M1[0, j] * M2[i, 0] +
        M1[1, j] * M2[i, 1] +
        M1[2, j] * M2[i, 2];
end;

function VectorTransform(const M: TFloatMatrix; const V: TVector3f): TVector3f;
begin
  Result[0] := M[0,0] * V[0] + M[1,0] * V[1] + M[2,0] * V[2];
  Result[1] := M[0,1] * V[0] + M[1,1] * V[1] + M[2,1] * V[2];
  Result[2] := M[0,2] * V[0] + M[1,2] * V[1] + M[2,2] * V[2];
end;


{ Transformation functions }

procedure Transform(Dst, Src: TBitmap32; Transformation: TTransformation);
var
  C, SrcAlpha: TColor32;
  R, SrcRectI, DstRect, SrcRect256: TRect;
  Pixels: PColor32Array;
  I, J, X, Y: Integer;
  DrawMode: TDrawMode;
  CombineCallBack: TPixelCombineEvent;

  function GET_S256(X256, Y256: Integer; out C: TColor32): Boolean;
  var
    flrx, flry, celx, cely: Longword;
    C1, C2, C3, C4: TColor32;
    P: PColor32;
  begin
    flrx := X256 and $FF;
    flry := Y256 and $FF;

    X := SAR_8(X256);
    Y := SAR_8(Y256);

    celx := flrx xor 255;
    cely := flry xor 255;

    if (X > SrcRectI.Left) and (X < SrcRectI.Right - 1) and
      (Y > SrcRectI.Top) and (Y < SrcRectI.Bottom - 1) then
    begin
      // everything is ok interpolate between four neighbors
      P := Src.PixelPtr[X, Y];
      C1 := P^;
      Inc(P);
      C2 := P^;
      Inc(P, Src.Width);
      C4 := P^;
      Dec(P);
      C3 := P^;
      C := CombineReg(CombineReg(C1, C2, celx), CombineReg(C3, C4, celx), cely);
      Result := True;
    end
    else if (X < SrcRectI.Left - 1) or (Y < SrcRectI.Top - 1) or (X >= SrcRectI.Right) or (Y >= SrcRectI.Bottom) then
    begin
      // (X,Y) coordinate is out of the SrcRect, do not interpolate
      C := 0; // just write something to disable compiler warnings
      Result := False;
    end
    else
    begin
      // handle edge
      C1 := Src.PixelS[X, Y];
      C2 := Src.PixelS[X + 1, Y];
      C3 := Src.PixelS[X, Y + 1];
      C4 := Src.PixelS[X + 1, Y + 1];
      C := CombineReg(CombineReg(C1, C2, celx), CombineReg(C3, C4, celx), cely);   
      Result := True;
    end;
  end;
begin
  if not Transformation.TransformValid then Transformation.PrepareTransform;

  CombineCallBack := Src.OnPixelCombine; // store it into a local variable
  DrawMode := Src.DrawMode;    // store it into a local variable
  SrcAlpha := Src.MasterAlpha;
  if (DrawMode = dmCustom) and not Assigned(CombineCallBack) then
    DrawMode := dmOpaque;

  // clip SrcRect
  R := MakeRect(Transformation.SrcRect);
  IntersectRect(SrcRectI, R, MakeRect(0, 0, Src.Width - 1, Src.Height - 1));

  with Transformation.SrcRect do
  begin
    IntersectRect(SrcRect256, MakeRect(Round(Left * 256), Round(Top * 256),
      Round(Right * 256), Round(Bottom * 256)), MakeRect(0, 0, (Src.Width - 1) * 256,
      (Src.Height - 1) * 256));
  end;

  // clip DstRect
  R := Transformation.GetTransformedBounds;
  IntersectRect(DstRect, R, MakeRect(0, 0, Dst.Width - 1, Dst.Height - 1));
  if IsRectEmpty(DstRect) then Exit;

  try
    if Src.StretchFilter <> sfNearest then
      for J := DstRect.Top to DstRect.Bottom do
      begin
        Pixels := Dst.ScanLine[J];
        for I := DstRect.Left to DstRect.Right do
        begin
          Transformation.Transform256(I, J, X, Y);
          if GET_S256(X, Y, C) then
            case DrawMode of
              dmOpaque: Pixels[I] := C;
              dmBlend: BlendMemEx(C, Pixels[I], SrcAlpha);
            else // dmCustom:
              CombineCallBack(C, Pixels[I], SrcAlpha);
            end;
        end;
      end
    else // nearest filter
      for J := DstRect.Top to DstRect.Bottom do
      begin
        Pixels := Dst.ScanLine[J];
        for I := DstRect.Left to DstRect.Right do
        begin
          Transformation.Transform(I, J, X, Y);
          if (X >= SrcRectI.Left) and (X <= SrcRectI.Right) and
            (Y >= SrcRectI.Top) and (Y <= SrcRectI.Bottom) then
          case DrawMode of
            dmOpaque: Pixels[I] := Src.Pixel[X, Y];
            dmBlend: BlendMemEx(Src.Pixel[X, Y], Pixels[I], SrcAlpha);
          else // dmCustom:
            CombineCallBack(Src.Pixel[X, Y], Pixels[I], SrcAlpha);
          end;
        end;
      end;
  finally
    EMMS;
  end;
  Dst.Changed;
end;

procedure SetBorderTransparent(ABitmap: TBitmap32; ARect: TRect);
var
  I: Integer;
begin
  if TestClip(ARect.Left, ARect.Right, ABitmap.Width) and
    TestClip(ARect.Top, ARect.Bottom, ABitmap.Height) then
  begin
    for I := ARect.Left to ARect.Right do
      ABitmap[I, ARect.Top] := ABitmap[I, ARect.Top] and $00FFFFFF;

    for I := ARect.Left to ARect.Right do
      ABitmap[I, ARect.Bottom] := ABitmap[I, ARect.Bottom] and $00FFFFFF;

    if ARect.Bottom > ARect.Top + 1 then
      for I := ARect.Top + 1 to ARect.Bottom - 1 do
      begin
        ABitmap[ARect.Left, I] := ABitmap[ARect.Left, I] and $00FFFFFF;
        ABitmap[ARect.Right, I] := ABitmap[ARect.Right, I] and $00FFFFFF;
      end;

    ABitmap.Changed;
  end;
end;


{ TTransformation }

procedure TTransformation.SetSrcRect(const Value: TFloatRect);
begin
  FSrcRect := Value;
  TransformValid := False;
end;


{ TAffineTransformation }

procedure TAffineTransformation.Clear;
begin
  Matrix := IdentityMatrix;
  TransformValid := False;
end;

constructor TAffineTransformation.Create;
begin
  Clear;
end;

function TAffineTransformation.GetTransformedBounds: TRect;
var
  V1, V2, V3, V4: TVector3f;
begin
  V1[0] := FSrcRect.Left;  V1[1] := FSrcRect.Top;    V1[2] := 1;
  V2[0] := FSrcRect.Right; V2[1] := V1[1];           V2[2] := 1;
  V3[0] := V1[0];          V3[1] := FSrcRect.Bottom; V3[2] := 1;
  V4[0] := V2[0];          V4[1] := V3[1];           V4[2] := 1;
  V1 := VectorTransform(Matrix, V1);
  V2 := VectorTransform(Matrix, V2);
  V3 := VectorTransform(Matrix, V3);
  V4 := VectorTransform(Matrix, V4);
  Result.Left   := Round(Min(Min(V1[0], V2[0]), Min(V3[0], V4[0])) - 0.5);
  Result.Right  := Round(Max(Max(V1[0], V2[0]), Max(V3[0], V4[0])) + 0.5);
  Result.Top    := Round(Min(Min(V1[1], V2[1]), Min(V3[1], V4[1])) - 0.5);
  Result.Bottom := Round(Max(Max(V1[1], V2[1]), Max(V3[1], V4[1])) + 0.5);
end;

procedure TAffineTransformation.PrepareTransform;
var
  M: TFloatMatrix;
begin
  M := Matrix;
  Invert(M);

  // calculate a fixed point (4096) factors
  A := Round(M[0,0] * 4096); B := Round(M[1,0] * 4096); C := Round(M[2,0] * 4096);
  D := Round(M[0,1] * 4096); E := Round(M[1,1] * 4096); F := Round(M[2,1] * 4096);

  TransformValid := True;
end;

procedure TAffineTransformation.Rotate(Cx, Cy, Alpha: Single);
var
  S, C: Single;
  M: TFloatMatrix;
begin
  TransformValid := False;
  if (Cx <> 0) or (Cy <> 0) then Translate(-Cx, -Cy);
  Alpha := DegToRad(Alpha);
  S := Sin(Alpha); C := Cos(Alpha);
  M := IdentityMatrix;
  M[0,0] := C;   M[1,0] := S;
  M[0,1] := -S;  M[1,1] := C;
  Matrix := Mult(M, Matrix);
  if (Cx <> 0) or (Cy <> 0) then Translate(Cx, Cy);
end;

procedure TAffineTransformation.Scale(Sx, Sy: Single);
var
  M: TFloatMatrix;
begin
  TransformValid := False;
  M := IdentityMatrix;
  M[0,0] := Sx;
  M[1,1] := Sy;
  Matrix := Mult(M, Matrix);
end;

procedure TAffineTransformation.Skew(Fx, Fy: Single);
var
  M: TFloatMatrix;
begin
  TransformValid := False;
  M := IdentityMatrix;
  M[1, 0] := Fx;
  M[0, 1] := Fy;
  Matrix := Mult(M, Matrix);
end;

procedure TAffineTransformation.Transform(
  DstX, DstY: Integer;
  out SrcX, SrcY: Integer);
begin
  SrcX := SAR_12(DstX * A + DstY * B + C + 2047);
  SrcY := SAR_12(DstX * D + DstY * E + F + 2047);
end;

procedure TAffineTransformation.Transform256(
  DstX, DstY: Integer;
  out SrcX256, SrcY256: Integer);
begin
  SrcX256 := SAR_4(DstX * A + DstY * B + C + 7);
  SrcY256 := SAR_4(DstX * D + DstY * E + F + 7);
end;

procedure TAffineTransformation.Translate(Dx, Dy: Single);
var
  M: TFloatMatrix;
begin
  TransformValid := False;
  M := IdentityMatrix;
  M[2,0] := Dx;
  M[2,1] := Dy;
  Matrix := Mult(M, Matrix);
end;


{ TProjectiveTransformation }

function TProjectiveTransformation.GetTransformedBounds: TRect;
begin
  Result.Left   := Round(Min(Min(Wx0, Wx1), Min(Wx2, Wx3)) - 0.5);
  Result.Right  := Round(Max(Max(Wx0, Wx1), Max(Wx2, Wx3)) + 0.5);
  Result.Top    := Round(Min(Min(Wy0, Wy1), Min(Wy2, Wy3)) - 0.5);
  Result.Bottom := Round(Max(Max(Wy0, Wy1), Max(Wy2, Wy3)) + 0.5);
end;

procedure TProjectiveTransformation.PrepareTransform;
var
  dx1, dx2, px, dy1, dy2, py: Single;
  g, h, k: Single;
  R: TFloatMatrix;
begin
  px  := Wx0 - Wx1 + Wx2 - Wx3;
  py  := Wy0 - Wy1 + Wy2 - Wy3;

  if (px = 0) and (py = 0) then
  begin
    // affine mapping
    M[0,0] := Wx1 - Wx0;
    M[1,0] := Wx2 - Wx1;
    M[2,0] := Wx0;

    M[0,1] := Wy1 - Wy0;
    M[1,1] := Wy2 - Wy1;
    M[2,1] := Wy0;

    M[0,2] := 0;
    M[1,2] := 0;
    M[2,2] := 1;
  end
  else
  begin
    // projective mapping
    dx1 := Wx1 - Wx2;
    dx2 := Wx3 - Wx2;
    dy1 := Wy1 - Wy2;
    dy2 := Wy3 - Wy2;
    k := dx1 * dy2 - dx2 * dy1;
    if k <> 0 then
    begin
      g := (px * dy2 - py * dx2) / k;
      h := (dx1 * py - dy1 * px) / k;

      M[0,0] := Wx1 - Wx0 + g * Wx1;
      M[1,0] := Wx3 - Wx0 + h * Wx3;
      M[2,0] := Wx0;

      M[0,1] := Wy1 - Wy0 + g * Wy1;
      M[1,1] := Wy3 - Wy0 + h * Wy3;
      M[2,1] := Wy0;

      M[0,2] := g;
      M[1,2] := h;
      M[2,2] := 1;
    end
    else
    begin
      FillChar(M, SizeOf(M), 0);
    end;
  end;

  // denormalize texture space (u, v)
  R := IdentityMatrix;
  R[0,0] := 1 / (SrcRect.Right - SrcRect.Left);
  R[1,1] := 1 / (SrcRect.Bottom - SrcRect.Top);
  M := Mult(M, R);

  R := IdentityMatrix;
  R[2,0] := -SrcRect.Left;
  R[2,1] := -SrcRect.Top;
  M := Mult(M, R);

  Invert(M);

  TransformValid := True;
end;

procedure TProjectiveTransformation.SetX0(Value: Single);
begin
  Wx0 := Value;  TransformValid := False;
end;

procedure TProjectiveTransformation.SetX1(Value: Single);
begin
  Wx1 := Value;  TransformValid := False;
end;

procedure TProjectiveTransformation.SetX2(Value: Single);
begin
  Wx2 := Value;  TransformValid := False;
end;

procedure TProjectiveTransformation.SetX3(Value: Single);
begin
  Wx3 := Value;  TransformValid := False;
end;

procedure TProjectiveTransformation.SetY0(Value: Single);
begin
  Wy0 := Value;  TransformValid := False;
end;

procedure TProjectiveTransformation.SetY1(Value: Single);
begin
  Wy1 := Value;  TransformValid := False;
end;

procedure TProjectiveTransformation.SetY2(Value: Single);
begin
  Wy2 := Value;  TransformValid := False;
end;

procedure TProjectiveTransformation.SetY3(Value: Single);
begin
  Wy3 := Value;  TransformValid := False;
end;

procedure TProjectiveTransformation.Transform(DstX, DstY: Integer;
  out SrcX, SrcY: Integer);
var
  X, Y, Z: Single;
begin
  EMMS;
  X := DstX; Y := DstY;
  Z := M[0,2] * X + M[1,2] * Y + M[2,2];
  if Z = 0 then Exit
  else if Z = 1 then
  begin
    SrcX := Round(M[0,0] * X + M[1,0] * Y + M[2,0]);
    SrcY := Round(M[0,1] * X + M[1,1] * Y + M[2,1]);
  end
  else
  begin
    Z := 1 / Z;
    SrcX := Round((M[0,0] * X + M[1,0] * Y + M[2,0]) * Z);
    SrcY := Round((M[0,1] * X + M[1,1] * Y + M[2,1]) * Z);
  end;
end;

procedure TProjectiveTransformation.Transform256(DstX, DstY: Integer;
  out SrcX256, SrcY256: Integer);
var
  X, Y, Z: Single;
begin
  EMMS;
  X := DstX; Y := DstY;
  Z := M[0,2] * X + M[1,2] * Y + M[2,2];
  if Z = 0 then Exit
  else if Z = 1 then
  begin
    SrcX256 := Round(256 * (M[0,0] * X + M[1,0] * Y + M[2,0]));
    SrcY256 := Round(256 * (M[0,1] * X + M[1,1] * Y + M[2,1]));
  end
  else
  begin
    Z := 1 / Z;
    SrcX256 := Round(256 * (M[0,0] * X + M[1,0] * Y + M[2,0]) * Z);
    SrcY256 := Round(256 * (M[0,1] * X + M[1,1] * Y + M[2,1]) * Z);
  end;
end;

end.
