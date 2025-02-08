unit ElVCLUtils;
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

ElVCLUtils unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  LMDTypes, Messages, Windows, MultiMon, Forms, Graphics, StdCtrls, Controls, Registry,
  Math, Clipbrd, Classes, SysUtils, LMDGraphUtils, LMDUtils,
  LMDInprocHookAPI, LMDGraph, LMDSysIn, LMDProcs;

const
  MOUSE_WHEEL_DELTA = 120;
{$externalsym CM_MOUSEWHEEL}
  CM_MOUSEWHEEL     = CM_BASE + WM_MOUSEWHEEL;
{$externalsym WM_MOUSEWHEEL}
  WM_MOUSEWHEEL     = $020A;
  WM_UPDATESBFRAME  = WM_USER + 1298;

  EL_SETTINGCHANGE  = WM_USER + 1299;

{$EXTERNALSYM DT_HIDEPREFIX}
  DT_HIDEPREFIX = $00100000;
{$EXTERNALSYM WM_CHANGEUISTATE}
  WM_CHANGEUISTATE = $0127;
{$EXTERNALSYM WM_UPDATEUISTATE}
  WM_UPDATEUISTATE = $0128;
{$EXTERNALSYM WM_QUERYUISTATE}
  WM_QUERYUISTATE = $0129;

{$EXTERNALSYM SPI_GETKEYBOARDCUES}
  SPI_GETKEYBOARDCUES = $100A;

const
  { gradient drawing modes }
{$EXTERNALSYM GRADIENT_FILL_RECT_H}
  GRADIENT_FILL_RECT_H = $00000000;
{$EXTERNALSYM GRADIENT_FILL_RECT_V}
  GRADIENT_FILL_RECT_V = $00000001;
{$EXTERNALSYM GRADIENT_FILL_TRIANGLE}
  GRADIENT_FILL_TRIANGLE = $00000002;
{$EXTERNALSYM GRADIENT_FILL_OP_FLAG}
  GRADIENT_FILL_OP_FLAG = $000000FF;
  SC_DRAGMOVE = $F012;
  DT_ELCUSTOMDRAW = $10000000;

var
  ParentControlRepaintedMessage: DWORD;

type
  TBlendFunction = record
    BlendOp: Byte;
    BlendFlags: Byte;
    SourceConstantAlpha: Byte;
    AlphaFormat: Byte;
  end;

  PGradientRect = ^TGradientRect;
{$EXTERNALSYM _GRADIENT_RECT}
  _GRADIENT_RECT = packed record
    UpperLeft: ULONG;
    LowerRight: ULONG;
  end;
  TGradientRect = _GRADIENT_RECT;
{$EXTERNALSYM GRADIENT_RECT}
  GRADIENT_RECT = _GRADIENT_RECT;

type
  TAlphaBlend =
    function(
    hdcDest: HDC; // handle to destination DC
    nXOriginDest: Integer; // x-coord of upper-left corner
    nYOriginDest: Integer; // y-coord of upper-left corner
    nWidthDest: Integer; // destination width
    nHeightDest: Integer; // destination height
    hdcSrc: HDC; // handle to source DC
    nXOriginSrc: Integer; // x-coord of upper-left corner
    nYOriginSrc: Integer; // y-coord of upper-left corner
    nWidthSrc: Integer; // source width
    nHeightSrc: Integer; // source height
    blendFunction: Integer // alpha-blending function

    ): BOOL; stdcall;

type

  TElLinkCtlPos = (lcpLeftTop, lcpLeftBottom, lcpLeftCenter,
    lcpTopLeft, lcpTopRight, lcpTopCenter,
    lcpRightTop, lcpRightBottom, lcpRightCenter,
    lcpBottomLeft, lcpBottomRight, lcpBottomCenter);

  TElFlatBorderType = (fbtFlat, fbtSunken, fbtSunkenInner,
    fbtSunkenOuter, fbtRaised, fbtRaisedInner, fbtRaisedOuter,
    fbtBump, fbtBigBump, fbtEtched, fbtFramed,
    fbtLine, fbtLineBorder, fbtNone, fbtColorLineBorder);

  TElTextDrawType = TLMDTextDrawType ; //(tdtNormal, tdtShadowed, tdtRaised);

  TTaskbarEdge = (tbeBottom, tbeLeft, tbeTop, tbeRight);

  TElTextCase = (etcNoChange, etcUppercase, etcLowercase);

  TElGradientEdge = (egeTopLeft, egeTopRight, egeBottomLeft, egeBottomRight);

  PtrToPixel = Pointer;

{$EXTERNALSYM TElBorderSides}
  TElBorderSides = LMDGraph.TLMDBorderSides;

{$EXTERNALSYM HDC}
  HDC = Windows.HDC;

const
  AllBorderSides: TLMDBorderSides = [ebsLeft, ebsRight, ebsTop, ebsBottom];

const
  smXEdge: array[boolean] of DWORD = (SM_CXBORDER, SM_CXEDGE);
  smYEdge: array[boolean] of DWORD = (SM_CYBORDER, SM_CYEDGE);

function GetSysTrayRect: TRect;
function GetTaskbarEdge: TTaskbarEdge;
function GetTaskbarRect: TRect;

procedure MinimizeToTray(Wnd: HWND);

procedure RepaintControlBorder(Wnd: HWND);

procedure GradientFill(DC: HDC; R: TRect; StartColor, EndColor: TColor; Steps:
  integer; Vertical: boolean);

procedure GradientFillEx(DC: HDC; DCRect, R: TRect; Origin: TPoint;
  StartColor, EndColor: TColor; Steps: integer;
  Vertical: boolean);
// DCRect - the rectangle of the "real DC", i.e. the DC, on which the painting is
//          usually performed
// R      - the real rectangle to be painted
// Origin - The original point, i.e. the point, which, when addded to R, would have
//          been copied from the "real DC"

procedure GradientEdge(DC: HDC; R: TRect; StartColor, EndColor: TColor; Steps:
  integer; Edge: TElGradientEdge; Rounded: boolean);

function GetTopOwnerControl(Component: TComponent): TControl;
function GetComponentByName(AOwner: TComponent; AName: string): TComponent;

function GetKeybTimes(TimeKind: integer): integer;
// correct parameter values are SPI_GETKEYBOARDDELAY and SPI_GETKEYBOARDSPEED

function FindVCLChild(Control: TWinControl; ChildHandle: HWND): TWinControl;
function GetTopWindowHandle(Child: HWND): HWND;

function HitTest(R: TRect; Pt: TPoint; CornerSize, BorderSize: integer): integer;

//procedure FillSolidRect2(DC : QPainterH; Rect : TRect; Color : TColor);
//procedure FillSolidRect(DC : QPainterH; x, y, cx, cy : integer; Color : TColor);

procedure TiledPaint(Canvas: TCanvas; Bitmap: TBitmap; Rect: TRect); overload;
procedure TiledPaint(ADC: HDC; Bitmap: TBitmap; Rect: TRect); overload;
// destination rectangle is meant.

procedure DrawEdge(DC: HDC; var RC: TRect; edge: UINT; grfFlags: UINT);
procedure DrawEdgeEx(DC: HDC; var RC: TRect; edge: UINT; grfFlags: UINT; Color1, Color2, Color3, Color4 : TColor);

procedure DrawButtonFrame(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean);
procedure DrawButtonFrameEx2(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean; ButtonColor: TColor; Thin: boolean; clrHighlight, clrDkShadow, clrFace,
  clrShadow: TColor; BorderSides : TElBorderSides);
procedure DrawButtonFrameEx3(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean;
  ButtonColor: TColor; Thin: boolean; BorderSides: TElBorderSides);
procedure Draw3dBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4:
  TColor);

procedure Draw3dRectEx(DC: HDC; x, y, cx, cy: integer; clrTopLeft,

  clrBottomRight: COLORREF;

  BorderSides: TElBorderSides);

function DrawBevel(DC: HDC; R: TRect; Color1, Color2: TColor; Sides:
  TElBorderSides): TRect;

function DrawFlatFrame(DC: HDC; R: TRect; BkColor: TColor; Focused: boolean):
TRect;
function DrawFlatFrame2(DC: HDC; R: TRect; BkColor: TColor; Focused: boolean;
  BorderSides: TElBorderSides): TRect;

procedure DrawFlatFrameEx(DC: HDC; R: TRect; BkColor: TColor; Focused, Enabled:
  boolean);

procedure DrawFlatFrameEx2(DC: HDC; R: TRect; Color, BkColor: TColor;
  Focused, Enabled: boolean;
  BorderSides: TElBorderSides;
  BorderType: TElFlatBorderType;
  Color1, Color2, Color3, Color4, Color5 : TColor);

function DrawFlatScrollbars(

  Wnd: HWND; DC: HDC;

  Rect: TRect; Focused: boolean;
  ScrollBars: TScrollStyle; DragHorz, DragVert: boolean;
  IsControl: boolean; Style, ExStyle: integer): TRect;

procedure DrawTypedText(Canvas: TCanvas; Bounds: TRect; Text: string; Flags:
  integer; DrawType: TElTextDrawType);
procedure DrawTypedTextW(Canvas: TCanvas; Bounds: TRect; Text: WideString;
  Flags: integer; DrawType: TElTextDrawType);

procedure DrawFlatScrollbarThumb(DC: HDC; rc: TRect; Focused: boolean);

procedure DrawTransparentBitmapEx(DC: HDC; Bitmap: TBitmap; X, Y: integer; Src:
  TRect; Transparent: TColor);

function RectsIntersect(R1, R2: TRect): boolean;
function RectVisible(Canvas : TCanvas; R: TRect): boolean;

function GetDesktopTop: integer;
function GetDesktopLeft: integer;
function GetDesktopBottom: integer;
function GetDesktopRight: integer;
function GetDesktopRect: TRect;

function GetWorkSpaceTop: integer;
function GetWorkSpaceLeft: integer;
function GetWorkSpaceBottom: integer;
function GetWorkSpaceRight: integer;
function GetWorkSpaceRect: TRect;

const
  WaitCursor: TCursor = crHourGlass;

procedure StartWait;
procedure StopWait;

function InvertColor(aColor: TColor): TColor;

function HLS(H, L, S: Word): Integer;
function RGBtoHLS(rgbc: integer): integer;
function HLStoRGB(hlsc: integer): integer;

procedure DrawFlatScrollBarsEx(

  Wnd: HWND; DC: HDC;

  Rect: TRect; Focused: boolean; ScrollBars: TScrollStyle;
  DragHorz, DragVert: boolean; IsControl: boolean;
  BkColor, DitherColor, ButtonColor, ArrowColor, HotButtonColor: TColor;
  DrawFrames, DitherBack: boolean);

procedure DrawFlatScrollBarEx(

  Wnd: HWND; DC: HDC;

  Rect: TRect; nType: integer; bScrollbarCtrl: boolean;
  Dragging: boolean; Focused: boolean;
  BkColor, DitherColor, ButtonColor, ArrowColor, HotButtonColor: TColor;
  DrawFrames, DitherBack: boolean);

function AlphaBlend(
  hdcDest: HDC; // handle to destination DC
  nXOriginDest: Integer; // x-coord of upper-left corner
  nYOriginDest: Integer; // y-coord of upper-left corner
  nWidthDest: Integer; // destination width
  nHeightDest: Integer; // destination height
  hdcSrc: HDC; // handle to source DC
  nXOriginSrc: Integer; // x-coord of upper-left corner
  nYOriginSrc: Integer; // y-coord of upper-left corner
  nWidthSrc: Integer; // source width
  nHeightSrc: Integer; // source height
  SourceConstantAlpha: Byte;
    // Specifies an alpha transparency value to be used on the entire source bitmap
  srcAlpha: byte
  ): Boolean;

procedure AlphaCopyRect(DestDC: HDC; Dest: TRect; SourceDC: HDC; Source: TRect;
  AlphaLevel: byte; UseAlphaLevel: boolean);
procedure AlphaCopyRect2(DestDC: HDC; Dest: TRect; SourceDC: HDC; Source: TRect;
  Mask: TBitmap; AlphaLevel: byte);
function IsAlphaEmpty(bmp: TBitmap): boolean;
procedure ClearAlpha(var bmp: TBitmap);
procedure AlphaFillRect(Canvas: TCanvas; ARect: TRect; Color: TColor; AlphaLevel:
  byte);

function DrawTextW(hDC: HDC; lpString: PWideChar; nCount: Integer;
         var lpRect: TRect; uFormat: UINT): Integer;
function GetSysColorPen(Color: COLORREF): HPEN;

procedure RotateBitmap(const ASource: TBitmap; out ADest: TBitmap; AAngle: Real); overload;
procedure RotateBitmap(const ASource: TBitmap; out ADest: TBitmap; AAngle: Real;
                       const AOldCenter: TPoint; var ANewCenter: TPoint); overload;

function IncColor(const Color: TColor; RInc, GInc, BInc: integer): integer;

procedure DrawFocus(Canvas: TCanvas; R: TRect);

function Win2KHideUIState: boolean;

function ModalFormVisible: boolean;

function ShiftStateToKeyData(Shift: TShiftState): integer;

function GetTimeAMChar: char;
function GetTimePMChar: char;

{$EXTERNALSYM GetGValue}
function GetGValue(aColor: TColor): byte;
{$EXTERNALSYM GetBValue}
function GetBValue(aColor: TColor): byte;
{$EXTERNALSYM GetRValue}
function GetRValue(aColor: TColor): byte;
{$EXTERNALSYM RGB}
function RGB(R, G, B: byte): TColor;

function ColorDarker(const OriginalColor: TColor; const Percent: Byte): TColor;
function ColorLighter(const Color: TColor; const Percent: Byte): TColor;

function GetRootComponent(Component: TComponent): TComponent;

{< VCL DFM UTILS}

type
  TElReader = class(TReader)
  procedure ReadPropertyFix(AInstance: TPersistent); // - Fixed read TPersistent complex property defined by means of DefineProperty
  public

    procedure FakeDefineProperty(Filer: TFiler);

    procedure SkipValue;

    procedure FakeValue(Reader: TReader); // - Skip any property. (Except for complex: persistent.property)

    procedure FakeInteger(Reader: TReader);
    procedure FakeBoolean(Reader: TReader);
    procedure FakeStr(Reader: TReader);
    procedure FakeIdent(Reader: TReader);
  end;

  function GetElReader : TElReader;

type
  TElDisplayOptions = class(TPersistent)
  private
    FEnabled: Boolean;
    FTextColor: TColor;
    FBkColor: TColor;
    FOnChange: TNotifyEvent;
  protected
    procedure Changed; virtual;
    procedure TriggerOnChange; virtual;
    procedure SetBkColor(const Value: TColor); virtual;
    procedure SetEnabled(const Value: Boolean); virtual;
    procedure SetTextColor(const Value: TColor); virtual;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property BkColor: TColor read FBkColor write SetBkColor default clWindow;
    property TextColor: TColor read FTextColor write SetTextColor default clWindowText;
  end;

function ElFileCreate(const FileName: TLMDString): Integer;
function ElFileOpen(const FileName: TLMDString; Mode: LongWord): Integer;

{> VCL DFM UTILS}

function DWordToStr(Value:DWORD):String;

function IsAnyBitsInOwnerDrawState( const State: TOwnerDrawState; const Bits: Word): Boolean;

function GetScrollBarPos( hWnd: THandle; BarFlag:Integer ):Integer;

implementation
uses
  {$IFDEF LMD_DEBUGTRACE}Dialogs,{$ENDIF}
  RTLConsts, Types,
  TypInfo;

type
  TTriVertex = packed record
    x: longint;
    y: longint;
    Red: word;
    Green: word;
    Blue: word;
    Alpha: word;
  end;

  TGradientFillProc = function(DC: HDC; Verteces: pointer; NumVerteces: DWORD;
    Meshes: pointer; NumMeshes: DWORD; Mode: DWORD): DWORD; stdcall;

var
  //MSImg32Lib: THandle;
  GradientFillProc: TGradientFillProc;

function IncAddr(P: Pointer; A: TLMDPtrInt): Pointer;
begin
  Result := Pointer(TLMDPtrInt(P) + A);
end;

procedure PtrToBuf(P: Pointer; var Buf: array of byte; Len: TLMDPtrInt);
begin
  CopyMemory (@Buf, P, Len);
end;

procedure BufToPtr(const Buf: array of byte; P: Pointer; Len: TLMDPtrInt);
begin
  CopyMemory (P, @Buf, Len);
end;

function GetTimeAMChar: char;
begin
  if Length({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeAMString) > 0 then
    result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeAMString[1]
  else
    result := #0;
end;

function GetTimePMChar: char;
begin
  if Length({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimePMString) > 0 then
    result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimePMString[1]
  else
    result := #0;
end;

procedure RotateBitmap(const ASource: TBitmap; out ADest: TBitmap; AAngle: Real);
var
  LNewCenter: TPoint;
begin
  RotateBitmap(ASource, ADest, AAngle, Point(ASource.Width div 2, ASource.Height div 2), LNewCenter);
end;

function  int_GetGap(BMP: TBitmap; var Gap: integer): Boolean;
begin
  if  BMP.PixelFormat = pf24bit  then
    Gap := 3
  else
  if  BMP.PixelFormat = pf32bit  then
    Gap := 4
  else
    Gap := 0;

  Result := (Gap <> 0);
end;

{$warnings off}
{
  Based on:
  (c) har*GIS L.L.C., 1999
    You are free to use this in any way, but please retain this comment block.
    Please email questions to jim@har-gis.com .
  Doc & Updates: http://www.efg2.com/Lab/ImageProcessing/RotateScanline.htm
  and http://www.efg2.com/Lab/Library/Delphi/Graphics/JimHargis_RotateBitMap.zip
}
procedure RotateBitmap(const ASource: TBitmap; out ADest: TBitmap; AAngle: Real;
                       const AOldCenter: TPoint; var ANewCenter: TPoint);

type
  TRGBTripleArray = array [0..32767] of TRGBTriple; //allow integer subscript
  pRGBTripleArray = ^TRGBTripleArray;
  TRGBQuadArray = array [0..32767]  of TRGBQuad; //allow integer subscript
  pRGBQuadArray = ^TRGBQuadArray;

VAR
  cosTheta: Extended;
  sinTheta: Extended;

  LDist, Ldx, Ldy, LSin, LCos: Extended;

  i: Integer;
  iOriginal: Integer;
  //iRotationAxis: Integer;
  iPrime: Integer;
  j: Integer;
  jOriginal: Integer;
  //jRotationAxis: Integer;
  jPrime: Integer;

  NewWidth, NewHeight: Integer;
  nBytes, nBits: Integer;
  Oht, Owi, Rht, Rwi: Integer;

  RowRotatedB: pByteArray;      //1 byte
  RowRotatedW: pWordArray;      //2 bytes
  RowRotatedT: pRGBtripleArray; //3 bytes
  RowRotatedQ: pRGBquadArray;   //4 bytes

  TransparentB: Byte;
  TransparentW: Word;
  TransparentT: TRGBTriple;
  TransparentQ: TRGBQuad;

  DIB: TDIBSection;
  //Center:  TPoint;

begin

  with ASource do
  begin
    case pixelformat of
      pfDevice:
      begin
        nBits :=  GetDeviceCaps(Canvas.Handle, BITSPIXEL) + 1;
        if (nBits > 0) and (nBits mod 8 <> 0) then
          exit
        else
          nBytes := nBits div 8;
      end;
      pf1bit: nBytes:=0;
      pf4bit: nBytes:=0;
      pf8bit: nBytes:=1;
      pf15bit: nBytes:=2;
      pf16bit: nBytes:=2;
      pf24bit: nBytes:=3;
      pf32bit: nBytes:=4;

      pfCustom:
      begin
        GetObject(Handle, SizeOf(DIB), @DIB);
        nBits := DIB.dsBmih.biSizeImage;
        if (nBits > 0) and (nBits mod 8 <> 0) then
          Exit
        else
          nBytes := nBits div 8;
      end;
      else
        Exit;
    end;

    if nBytes=0 then
      PixelFormat := pf8bit;

    ADest.Assign(ASource);

    SinCos(AAngle, sinTheta, cosTheta);

    NewWidth  := Abs(Round(Height * sinTheta)) + Abs(Round(Width * cosTheta));
    NewHeight := Abs(Round(Width * sinTheta )) + Abs(Round(Height * cosTheta));

    if (Abs(AAngle) * Max(Width, Height)) > 1 then
    begin
      ADest.Width  := NewWidth;   //resize it for rotation
      ADest.Height := NewHeight;
      //iRotationAxis := width div 2;
      //jRotationAxis := height div 2;

      Rwi := NewWidth - 1; //right column index
      Rht := NewHeight - 1;//bottom row index
      Owi := Width - 1;    //transp color column index
      Oht := Height - 1;   //transp color row  index

      case nBytes of
        0,1: TransparentB := PByteArray(Scanline[Oht])[0];
        2: TransparentW := PWordArray(Scanline[Oht])[0];
        3: TransparentT := pRGBtripleArray(Scanline[Oht])[0];
        4: TransparentQ := pRGBquadArray(Scanline[Oht])[0];
      end;//case *)

      for j := Rht downto 0 do
      begin

        case nBytes of  //1/6/00
          0,1:RowRotatedB := ADest.Scanline[ j ] ;
          2:  RowRotatedW := ADest.Scanline[ j ] ;
          3:  RowRotatedT := ADest.Scanline[ j ] ;
          4:  RowRotatedQ := ADest.Scanline[ j ] ;
        end;//case

        jPrime := 2*j - NewHeight + 1 ;

        for i := Rwi downto 0 do
        begin

          iPrime := 2 * i - NewWidth + 1;

          iOriginal := (Round(iPrime * CosTheta - jPrime * sinTheta ) - 1 + Width) div 2;
          jOriginal := (Round(iPrime * sinTheta + jPrime * cosTheta ) - 1 + Height) div 2 ;

          if (iOriginal >= 0) and (iOriginal <= Owi) and
             (jOriginal >= 0 ) and (jOriginal <= Oht) then
          begin
            case nBytes of  //get pixel bytes according to pixel format   1/6/00
              0,1: RowRotatedB[i] := pByteArray(ScanLine[joriginal])[iOriginal];
              2: RowRotatedW[i] := pWordArray(ScanLine[jOriginal])[iOriginal];
              3: RowRotatedT[i] := pRGBtripleArray(ScanLine[jOriginal])[iOriginal];
              4: RowRotatedQ[i] := pRGBquadArray(ScanLine[jOriginal])[iOriginal];
            end;
          end
          else
          begin
            case nBytes of
              0,1:RowRotatedB[i] := TransparentB;
              2: RowRotatedW[i] := TransparentW;
              3: RowRotatedT[i] := TransparentT;
              4: RowRotatedQ[i] := TransparentQ;
            end;
          end;
        end;
      end;
    end;

    Ldx := (AOldCenter.x - (Width div 2));  Ldy := (AOldCenter.y - (Height div 2));
    LDist := Hypot(Ldx, Ldy);
    if Abs(LDist) < 1 then
    begin
      LSin := 0.0;
      LCos := 1.0;
    end
    else
    begin
      LSin := Ldy / LDist;
      LCos := Ldx / LDist;
    end;

    ANewCenter.X := newWidth div 2 + Round(LDist * (cosTheta * LCos - SinTheta * LSin));
    ANewCenter.Y := newHeight div 2 - Round(LDist * (sinTheta * LCos + CosTheta * LSin));
  end;
end;

{$warnings on}

function ColorLighter(const Color: TColor; const Percent: Byte): TColor;
var
  R, G, B: Byte;
  FColor: TColorRef;
begin
  FColor := ColorToRGB(Color);

  R := GetRValue(FColor);
  G := GetGValue(FColor);
  B := GetBValue(FColor);

  R := R + muldiv(255 - r, Percent, 100);
  G := G + muldiv(255 - g, Percent, 100);
  B := B + muldiv(255 - b, Percent, 100);

  Result := RGB(R, G, B);
end;

function ColorDarker(const OriginalColor: TColor; const Percent: Byte): TColor;
var
  R, G, B: Integer;
  WinColor: Integer;
begin
  WinColor := ColorToRGB(OriginalColor);
  R := GetRValue(WinColor);
  G := GetGValue(WinColor);
  B := GetBValue(WinColor);

  R := MulDiv(R, Percent, 100);
  G := MulDiv(G, Percent, 100);
  B := MulDiv(B, Percent, 100);

  if R < 0 then R := 0;
  if G < 0 then G := 0;
  if B < 0 then B := 0;

  Result := RGB(R, G, B);
end;

function IncColor(const Color: TColor; RInc, GInc, BInc: integer): integer;
var
  r, g, b: integer;
begin
  r := (ColorToRgb(Color) and $0000FF) + RInc;
  g := (ColorToRgb(Color) and $00FF00) shr 8 + GInc;
  b := (ColorToRgb(Color) and $FF0000) shr 16 + BInc;

  if r < 0 then
    r := 0
  else
    if r > 255 then
    r := 255;
  if g < 0 then
    g := 0
  else
    if g > 255 then
    g := 255;
  if b < 0 then
    b := 0
  else
    if b > 255 then
    b := 255;
  result := (b shl 16) or (g shl 8) or r;
end;

function GetBValue(aColor: TColor): Byte;
begin
  result := (ColorToRgb(aColor) and $FF0000) shr 16;
end;

function GetGValue(aColor: TColor): Byte;
begin
  result := (ColorToRgb(aColor) and $00FF00) shr 8;
end;

function GetRValue(aColor: TColor): Byte;
begin
  result := (ColorToRgb(aColor) and $0000FF);
end;

function RGB(R, G, B: Byte): TColor;
begin
  result := (b shl 16) or (g shl 8) or r;
end;

function InvertColor(aColor: TColor): TColor;
var
  r, g, b: integer;
begin
  r := GetRValue(ColorToRgb(aColor));
  g := GetGValue(ColorToRgb(aColor));
  b := GetBValue(ColorToRgb(aColor));

  r := (not r) and $000000FF;
  g := ((not g) and $000000FF) shl 8;
  b := ((not b) and $000000FF) shl 16;

  Result := b or g or r;
end;

function GetWorkSpaceRect: TRect;
begin
  Result := LMDGetWorkSpaceRect;
end;

function GetWorkSpaceTop: integer;
begin
  result := GetWorkSpaceRect.Top;
end;

function GetWorkSpaceLeft: integer;
begin
  result := GetWorkSpaceRect.Left;
end;

function GetWorkSpaceBottom: integer;
begin
  result := GetWorkSpaceRect.Bottom;
end;

function GetWorkSpaceRight: integer;
begin
  result := GetWorkSpaceRect.Right;
end;

function GetDesktopRect: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @result, 0);
end;

function GetDesktopTop: integer;
begin
  result := GetDesktopRect.Top;
end;

function GetDesktopLeft: integer;
begin
  result := GetDesktopRect.Left;
end;

function GetDesktopBottom: integer;
begin
  result := GetDesktopRect.Bottom;
end;

function GetDesktopRight: integer;
begin
  result := GetDesktopRect.Right;
end;

procedure RepaintControlBorder(Wnd: HWND);
begin

end;

procedure MinimizeToTray(Wnd: HWND);
var
  WinPlace: TWindowPlacement;
  R: TRect;
begin
  WinPlace.length := SizeOf(TWindowPlacement);
  GetWindowPlacement(Wnd, @WinPlace);
  WinPlace.flags := WPF_SETMINPOSITION;
  R := GetSysTrayRect;
  WinPlace.ptMinPosition.x := R.Left;
  WinPlace.ptMinPosition.y := R.Top;
  SetWindowPlacement(Wnd, @WinPlace);
  SendMessage(Wnd, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

function GetSysTrayRect: TRect;
var
  H1,
    H2: HWND;
begin
  SetRectEmpty(result);
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    H2 := FindWindowEx(H1, 0, 'TrayNotifyWnd', nil);
    if H2 <> 0 then
      GetWindowRect(H2, result);
  end;
end;

function GetTaskbarRect: TRect;
var
  H1: HWND;
begin
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
    GetWindowRect(H1, Result)
  else
    SetRectEmpty(result);
end;

function GetTaskbarEdge: TTaskbarEdge;
var
  H1: HWND;
  R: TRect;
  DesktopWidth,
    DesktopHeight: integer;
begin
  result := tbeBottom;
  H1 := FindWindow('Shell_TrayWnd', nil);
  if H1 <> 0 then
  begin
    R := GetWorkSpaceRect;
    DesktopWidth := R.Right - R.Left;
    DesktopHeight := R.Bottom - R.Top;
    GetWindowRect(H1, R);
    if R.Top > DesktopHeight div 2 then
      result := tbeBottom
    else
      if R.Right < DesktopWidth div 2 then
      result := tbeLeft
    else
      if R.Bottom < DesktopHEight div 2 then
      result := tbeTop
    else
      if R.Left > DesktopWidth div 2 then
      result := tbeRight;
  end;
end;

{$WARNINGS off}

function GetKeybTimes(TimeKind: integer): integer;
begin

  SystemParametersInfo(TimeKind, 0, @result, 0);
  if TimeKind = SPI_GETKEYBOARDSPEED then
  begin
    result := 1000 div (result + 1);
  end
  else
    if TimeKind = SPI_GETKEYBOARDDELAY then
  begin
    result := 250 * (result + 1);
  end;

end;
{$WARNINGS on}

procedure GradientFillEx(DC: HDC; DCRect, R: TRect; Origin: TPoint; StartColor,
  EndColor: TColor; Steps: integer; Vertical: boolean);
var
  i: integer;
  RBeg, RDif, Rc,
    GBeg, GDif, Gc,
    BBeg, BDif, Bc: integer;

  Brush,
    OldBrush: HBrush;

  R1, R2, R3: TRect;
begin
  if StartColor = EndColor then
  begin

    Brush := CreateSolidBrush(ColorToRGB(StartColor));
    FillRect(DC, R, Brush);
    DeleteObject(Brush);

  end
  else
  begin
    RBeg := GetRValue(ColorToRGB(StartColor));
    GBeg := GetGValue(ColorToRGB(StartColor));
    BBeg := GetBValue(ColorToRGB(StartColor));
    RDif := GetRValue(ColorToRGB(EndColor)) - RBeg;
    GDif := GetGValue(ColorToRGB(EndColor)) - GBeg;
    BDif := GetBValue(ColorToRGB(EndColor)) - BBeg;
    R1 := R;
    for i := 0 to Steps - 1 do // Iterate
    begin
      if Vertical then
      begin
        R1.Top := R.Top + MulDiv(i, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Top + MulDiv(i + 1, R.Bottom - R.Top, Steps);
      end
      else
      begin
        R1.Left := R.Left + MulDiv(i, R.Right - R.Left, Steps);
        R1.Right := R.Left + MulDiv(i + 1, R.Right - R.Left, Steps);
      end;
      R3 := DCRect;
      OffsetRect(R3, Origin.X, Origin.Y);
      IntersectRect(R2, R3, R1);
      if not IsRectEmpty(R2) then
      begin
        //R2 := R1;
        OffsetRect(R2, -Origin.x, -Origin.y);
        Rc := RBeg + MulDiv(i, RDif, Steps - 1);
        Gc := GBeg + MulDiv(i, GDif, Steps - 1);
        Bc := BBeg + MulDiv(i, BDif, Steps - 1);

        Brush := CreateSolidBrush(RGB(Rc, Gc, Bc));
        OldBrush := SelectObject(DC, Brush);
        PatBlt(DC, R2.Left, R2.Top, R2.Right - R2.Left, R2.Bottom - R2.Top,
          PATCOPY);
        SelectObject(DC, OldBrush);
        DeleteObject(Brush);

      end;
    end; // for
  end;
end;

procedure GradientFill(DC: HDC; R: TRect; StartColor, EndColor: TColor; Steps:
  integer; Vertical: boolean);

var
  i: integer;
  c1,
    c2: TColorRef;
  RBeg, RDif, Rc,
    GBeg, GDif, Gc,
    BBeg, BDif, Bc: integer;

  Brush,
    OldBrush: HBrush;
  Verteces: array[0..1] of TTriVertex;
  GradientRect: TGradientRect;

  R1: TRect;
begin
  c1 := ColorToRGB(StartColor);
  c2 := ColorToRGB(EndColor);
  if c1 = c2 then
  begin
    Brush := CreateSolidBrush(ColorToRGB(StartColor));
    FillRect(DC, R, Brush);
    DeleteObject(Brush);
  end
  else
  if (LMDSIWindows98 or LMDSIWindows2000Up) and (@GradientFillProc <> nil) then
  begin
    Verteces[0].x := R.Left;
    Verteces[0].y := R.Top;
    Verteces[0].Red := GetRValue(c1) shl 8;
    Verteces[0].Green := GetGValue(c1) shl 8;
    Verteces[0].Blue := GetBValue(c1) shl 8;
    Verteces[0].Alpha := 0;
    Verteces[1].x := R.Right;
    Verteces[1].y := R.Bottom;
    Verteces[1].Red := GetRValue(c2) shl 8;
    Verteces[1].Green := GetGValue(c2) shl 8;
    Verteces[1].Blue := GetBValue(c2) shl 8;
    Verteces[1].Alpha := 0;
    GradientRect.UpperLeft := 0;
    GradientRect.LowerRight := 1;
    if Vertical then
      GradientFillProc(DC, @Verteces[0], 2, @GradientRect, 1,
        GRADIENT_FILL_RECT_V)
    else
      GradientFillProc(DC, @Verteces[0], 2, @GradientRect, 1,
        GRADIENT_FILL_RECT_H);
  end
  else
  begin
    RBeg := GetRValue(c1);
    GBeg := GetGValue(c1);
    BBeg := GetBValue(c1);
    RDif := GetRValue(c2) - RBeg;
    GDif := GetGValue(c2) - GBeg;
    BDif := GetBValue(c2) - BBeg;

    R1 := R;
    for i := 0 to Steps - 1 do // Iterate
    begin
      if Vertical then
      begin
        R1.Top := R.Top + MulDiv(i, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Top + MulDiv(i + 1, R.Bottom - R.Top, Steps);
      end
      else
      begin
        R1.Left := R.Left + MulDiv(i, R.Right - R.Left, Steps);
        R1.Right := R.Left + MulDiv(i + 1, R.Right - R.Left, Steps);
      end;

      Rc := RBeg + MulDiv(i, RDif, Steps - 1);
      Gc := GBeg + MulDiv(i, GDif, Steps - 1);
      Bc := BBeg + MulDiv(i, BDif, Steps - 1);

      Brush := CreateSolidBrush(RGB(Rc, Gc, Bc));
      OldBrush := SelectObject(DC, Brush);
      PatBlt(DC, R1.Left, R1.Top, R1.Right - R1.Left, R1.Bottom - R1.Top,
        PATCOPY);
      SelectObject(DC, OldBrush);
      DeleteObject(Brush);

    end; // for
  end;
end;

procedure GradientEdge(DC: HDC; R: TRect; StartColor, EndColor: TColor; Steps:
  integer; Edge: TElGradientEdge; Rounded: boolean);
var
  i: integer;
  c1,
  c2: TColorRef;
  RBeg, RDif, Rc,
  GBeg, GDif, Gc,
  BBeg, BDif, Bc: integer;

  Brush,
  OldBrush: HBrush;
  R1, R2: TRect;

begin
  c1 := ColorToRGB(StartColor);
  c2 := ColorToRGB(EndColor);
  if c1 = c2 then
  begin
    Brush := CreateSolidBrush(ColorToRGB(StartColor));
    FillRect(DC, R, Brush);
    DeleteObject(Brush);
  end;

  RBeg := GetRValue(c1);
  GBeg := GetGValue(c1);
  BBeg := GetBValue(c1);
  RDif := GetRValue(c2) - RBeg;
  GDif := GetGValue(c2) - GBeg;
  BDif := GetBValue(c2) - BBeg;

  R1 := R;
  R2 := R;
  for i := 0 to Steps - 1 do // Iterate
  begin
    case Edge of
    egeTopLeft:
      begin
        R1.Top := R.Top + MulDiv(i, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Top + MulDiv(i + 1, R.Bottom - R.Top, Steps);

        R2.Left := R.Left + MulDiv(i, R.Right - R.Left, Steps);
        R2.Right := R.Left + MulDiv(i + 1, R.Right - R.Left, Steps);
      end;
    egeTopRight:
      begin
        R1.Top := R.Top + MulDiv(i, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Top + MulDiv(i + 1, R.Bottom - R.Top, Steps);

        R2.Left := R.Right - MulDiv(i, R.Right - R.Left, Steps);
        R2.Right := R.Right - MulDiv(i + 1, R.Right - R.Left, Steps);
      end;
    egeBottomLeft:
      begin
        R1.Top := R.Bottom - MulDiv(i, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Bottom - MulDiv(i + 1, R.Bottom - R.Top, Steps);

        R2.Left := R.Left + MulDiv(i, R.Right - R.Left, Steps);
        R2.Right := R.Left + MulDiv(i + 1, R.Right - R.Left, Steps);
      end;
    egeBottomRight:
      begin
        R1.Top := R.Bottom - MulDiv(i, R.Bottom - R.Top, Steps);
        R1.Bottom := R.Bottom - MulDiv(i + 1, R.Bottom - R.Top, Steps);

        R2.Left := R.Right - MulDiv(i, R.Right - R.Left, Steps);
        R2.Right := R.Right - MulDiv(i + 1, R.Right - R.Left, Steps);
      end;
    end;

    Rc := RBeg + MulDiv(i, RDif, Steps - 1);
    Gc := GBeg + MulDiv(i, GDif, Steps - 1);
    Bc := BBeg + MulDiv(i, BDif, Steps - 1);

    Brush := CreateSolidBrush(RGB(Rc, Gc, Bc));
    OldBrush := SelectObject(DC, Brush);

    PatBlt(DC, R2.Left, R2.Top, R2.Right - R2.Left, R2.Bottom - R2.Top, PATCOPY);
    PatBlt(DC, R1.Left, R1.Top, R1.Right - R1.Left, R1.Bottom - R1.Top, PATCOPY);

    SelectObject(DC, OldBrush);
    DeleteObject(Brush);
  end;
end;

function RectsIntersect(R1, R2: TRect): boolean;
var
  R: TRect;
begin
  IntersectRect(R, R1, R2);
  result := not IsRectEmpty(R);
end;

function RectVisible(Canvas : TCanvas; R: TRect): boolean;
begin
  result := Windows.RectVisible(Canvas.Handle, R);
  end;

function FindVCLChild(Control: TWinControl; ChildHandle: HWND): TWinControl;
var
  i: integer;
  C: TWinControl;
begin
  for i := 0 to Control.ControlCount - 1 do // Iterate
  begin
    if Control.Controls[i] is TWinControl then
    begin
      C := TWinControl(Control.Controls[i]);
      if C.HandleAllocated and (C.Handle = ChildHandle) then
      begin
        result := C;
        exit;
      end;
    end;
  end; // for
  result := nil;
end;

procedure DrawTransparentBitmapEx(DC: HDC; Bitmap: TBitmap; X, Y: integer; Src:
  TRect; Transparent: TColor);

var

  cColor: TColorRef;
  bmAndBack,
    bmAndObject,
    bmAndMem,
    bmSave,
    bmBackOld,
    bmObjectOld,
    bmMemOld,
    bmSaveOld: HBitmap;
  hdcMem,
    hdcBack,
    hdcObject,
    hdcTemp,
    hdcSave: HDC;
  bmWidth, bmHeight: integer;

begin

  hdcTemp := CreateCompatibleDC(DC);
  SelectObject(hdcTemp, Bitmap.Handle); { select the bitmap }

  bmWidth := Src.Right - Src.Left;
  bmHeight := Src.Bottom - Src.Top;

   { create some DCs to hold temporary data }
  hdcBack := CreateCompatibleDC(DC);
  hdcObject := CreateCompatibleDC(DC);
  hdcMem := CreateCompatibleDC(DC);
  hdcSave := CreateCompatibleDC(DC);

   { create a bitmap for each DC }

   { monochrome DC }
  bmAndBack := CreateBitmap(bmWidth, bmHeight, 1, 1, nil);
  bmAndObject := CreateBitmap(bmWidth, bmHeight, 1, 1, nil);

  bmAndMem := CreateCompatibleBitmap(DC, bmWidth, bmHeight);
  bmSave := CreateCompatibleBitmap(DC, bmWidth, bmHeight);

   { each DC must select a bitmap object to store pixel data }
  bmBackOld := SelectObject(hdcBack, bmAndBack);
  bmObjectOld := SelectObject(hdcObject, bmAndObject);
  bmMemOld := SelectObject(hdcMem, bmAndMem);
  bmSaveOld := SelectObject(hdcSave, bmSave);

   { set proper mapping mode }
  SetMapMode(hdcTemp, GetMapMode(DC));

   { save the bitmap sent here, because it will be overwritten }
  BitBlt(hdcSave, 0, 0, bmWidth, bmHeight, hdcTemp, Src.Left, Src.Top, SRCCOPY);

   { set the background color of the source DC to the color.
    contained in the parts of the bitmap that should be transparent }
  cColor := SetBkColor(hdcTemp, ColorToRGB(Transparent));

   { create the object mask for the bitmap by performing a BitBlt()
     from the source bitmap to a monochrome bitmap }
  BitBlt(hdcObject, 0, 0, bmWidth, bmHeight, hdcTemp, Src.Left, Src.Top,
    SRCCOPY);

   { set the background color of the source DC back to the original
color }
  SetBkColor(hdcTemp, cColor);

   { create the inverse of the object mask }
  BitBlt(hdcBack, 0, 0, bmWidth, bmHeight, hdcObject, 0, 0, NOTSRCCOPY);

   { copy the background of the main DC to the destination }
  BitBlt(hdcMem, 0, 0, bmWidth, bmHeight, DC, X, Y, SRCCOPY);

   { mask out the places where the bitmap will be placed }
  BitBlt(hdcMem, 0, 0, bmWidth, bmHeight, hdcObject, 0, 0, SRCAND);

   { mask out the transparent colored pixels on the bitmap }
  BitBlt(hdcTemp, Src.Left, Src.Top, bmWidth, bmHeight, hdcBack, 0, 0, SRCAND);

   { XOR the bitmap with the background on the destination DC }
  BitBlt(hdcMem, 0, 0, bmWidth, bmHeight, hdcTemp, Src.Left, Src.Top, SRCPAINT);

   { copy the destination to the screen }
  BitBlt(DC, X, Y, bmWidth, bmHeight, hdcMem, 0, 0, SRCCOPY);

   { place the original bitmap back into the bitmap sent here }
  BitBlt(hdcTemp, Src.Left, Src.Top, bmWidth, bmHeight, hdcSave, 0, 0, SRCCOPY);

   { delete the memory bitmaps }
  DeleteObject(SelectObject(hdcBack, bmBackOld));
  DeleteObject(SelectObject(hdcObject, bmObjectOld));
  DeleteObject(SelectObject(hdcMem, bmMemOld));
  DeleteObject(SelectObject(hdcSave, bmSaveOld));

   { delete the memory DCs }
  DeleteDC(hdcMem);
  DeleteDC(hdcBack);
  DeleteDC(hdcObject);
  DeleteDC(hdcSave);
  DeleteDC(hdcTemp);

end;

procedure DrawTypedTextW(Canvas: TCanvas; Bounds: TRect; Text: WideString;
  Flags: integer; DrawType: TElTextDrawType);
var
  Col: TColor;
begin
  case DrawType of
    tdtNormal:
      {ElVCLUtils.}DrawTextW(Canvas.Handle, Int_RefW(Text), Length(Text), Bounds, Flags);
    tdtShadowed:
      begin
        OffsetRect(Bounds, 2, 2);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnShadow;
        {ElVCLUtils.}DrawTextW(Canvas.Handle, Int_RefW(Text), Length(Text), Bounds, Flags);
        OffsetRect(Bounds, -2, -2);
        Canvas.Font.Color := col;
        {ElVCLUtils.}DrawTextW(Canvas.Handle, Int_RefW(Text), Length(Text), Bounds, Flags);
      end;
    tdtRaised:
      begin
        OffsetRect(Bounds, -1, -1);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnHighlight;

        {ElVCLUtils.}DrawTextW(Canvas.Handle, Int_RefW(Text), Length(Text),
          Bounds, Flags);

        OffsetRect(Bounds, 1, 1);
        Canvas.Font.Color := col;

        {ElVCLUtils.}DrawTextW(Canvas.Handle, Int_RefW(Text), Length(Text),
          Bounds, Flags);

      end;
  end;
end;

procedure DrawTypedText(Canvas: TCanvas; Bounds: TRect; Text: string; Flags:
  integer; DrawType: TElTextDrawType);
var
  Col: TColor;
begin
  case DrawType of
    tdtNormal:

      DrawText(Canvas.Handle, Int_ref(Text), Length(Text), Bounds, Flags);

    tdtShadowed:
      begin
        OffsetRect(Bounds, 2, 2);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnShadow;

        DrawText(Canvas.Handle, Int_Ref(Text), Length(Text), Bounds, Flags);

        OffsetRect(Bounds, -2, -2);
        Canvas.Font.Color := col;

        DrawText(Canvas.Handle, Int_Ref(Text), Length(Text), Bounds, Flags);

      end;
    tdtRaised:
      begin
        OffsetRect(Bounds, -1, -1);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnHighlight;

        DrawText(Canvas.Handle, Int_Ref(Text), Length(Text), Bounds, Flags);

        OffsetRect(Bounds, 1, 1);
        Canvas.Font.Color := col;

        DrawText(Canvas.Handle, Int_Ref(Text), Length(Text), Bounds, Flags);

      end;
  end;
end;

procedure Draw3dRect(DC: HDC; x, y, cx, cy: integer; clrTopLeft,

  clrBottomRight: COLORREF);

begin
  Draw3DRectEx(DC, x, y, cx, cy, clrTopLeft, clrBottomRight, AllBorderSides);
end;

procedure Draw3dRectEx(DC: HDC; x, y, cx, cy: integer; clrTopLeft,

  clrBottomRight: COLORREF;

  BorderSides: TElBorderSides);
var adj : integer;

begin

  if ebsTop in BorderSides then
  begin
    if ebsRight in BorderSides then
      adj := 1
    else

      adj := 0;
    LMDFillSolidRect(DC, x, y, cx - adj, 1, clrTopLeft);
  end;
  if ebsLeft in BorderSides then
  begin
    if ebsBottom in BorderSides then
      adj := 1
    else
      adj := 0;
    LMDFillSolidRect(DC, x, y, 1, cy - adj, clrTopLeft);
  end;
  if ebsRight in BorderSides then
    LMDFillSolidRect(DC, x + cx, y, -1, cy, clrBottomRight);
  if ebsBottom in BorderSides then
    LMDFillSolidRect(DC, x, y + cy, cx , -1, clrBottomRight);

end;

procedure Draw3dBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4:
  TColor);

begin

  nColor1 := ColorToRGB(GetSysColor(nColor1));
  nColor2 := ColorToRGB(GetSysColor(nColor2));
  nColor3 := ColorToRGB(GetSysColor(nColor3));
  nColor4 := ColorToRGB(GetSysColor(nColor4));

  Draw3dRect(DC, rc.left, rc.top, rc.right - rc.left, rc.bottom - rc.top,
    nColor1, nColor2);
  Draw3dRect(DC, rc.left + 1, rc.top + 1, rc.right - rc.left - 2, rc.bottom -
    rc.top - 2, nColor3, nColor4);

end;

const
  hlsMax = 252; // H, L, S vary over 0 - hlsMax; best if divisible by 6
  rgbMax = 255; // r, g, b vary over 0-rgbMax; must each fit in a byte

  hlsMaxD2 = hlsMax div 2;
  hlsMaxD3 = hlsMax div 3;
  hlsMaxD6 = hlsMax div 6;
  hlsMaxD12 = hlsMax div 12;
  hlsMaxM2D3 = hlsMax * 2 div 3;
  rgbMaxM2 = rgbMax * 2;
  undefined = (hlsMaxM2D3);

procedure checkRange(var hls: integer);
begin
  if hls < 0 then inc(hls, hlsMax);
  if hls > hlsMax then
    dec(hls, hlsMax)
end;

function RGBtoHLS(rgbc: integer): integer;
var
  r, g, b, h, l, s, cMax, cMin, rD, gD, bD,
    cDiff, cDiffD2, cSum, cSumD2: integer;
begin
  r := getRValue(rgbc);
  g := getGValue(rgbc);
  b := getBValue(rgbc);
  cMax := max(max(r, g), b);
  cMin := min(min(r, g), b);

  l := (((cMax + cMin) * hlsMax) + rgbMax) div (rgbMaxM2);

  if cMax = cMin then
  begin
    s := 0;
    h := undefined
  end
  else
  begin
    cDiff := cMax - cMin;
    cDiffD2 := cDiff div 2;
    cSum := cMax + cMin;
    cSumD2 := cSum div 2;
    if l <= hlsMaxD2 then
      s := (cDiff * hlsMax + cSumD2) div cSum
    else
      s := (cDiff * hlsMax + (rgbMaxM2 - cDiff) div 2) div (rgbMaxM2 - cDiff);
    rD := ((cMax - r) * hlsMaxD6 + cDiffD2) div cDiff;
    gD := ((cMax - g) * hlsMaxD6 + cDiffD2) div cDiff;
    bD := ((cMax - b) * hlsMaxD6 + cDiffD2) div cDiff;
    if r = cMax then
      h := bD - gD
    else
      if g = cMax then
      h := hlsMaxD3 + rD - bD
    else
      h := hlsMaxM2D3 + gD - rD;
    checkRange(h);
  end;

  result := rgb(h, l, s);

end;

function HLStoRGB(hlsc: integer): integer;
begin
  result:=LMDHLStoRGB(hlsc);
end;

function HLS(H, L, S: Word): Integer;
begin
  Result := (S shl 16) or (L shl 8) or H;
end;

procedure DrawButtonFrameEx3(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean;
  ButtonColor: TColor; Thin: boolean; BorderSides: TElBorderSides);
var
  Color1,
    Color2,
    Color3,
    Color4: TColor;
  hls1, hls2, hls3, hls4: integer;
  lum: integer;

  procedure DrawBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4:
    TColor; Thin: boolean; BorderSides: TElBorderSides);
  var adj : integer;
  begin

    adj := 0;

    Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
      nColor1, nColor2, BorderSides);
    if not Thin then
    begin
      if ebsTop in BorderSides then
        inc(rc.Top);
      if ebsBottom in BorderSides then
        dec(rc.Bottom);
      if ebsLeft in BorderSides then
        inc(rc.Left);
      if ebsRight in BorderSides then
        dec(rc.Right);
      Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
        nColor3, nColor4, BorderSides);
    end;
  end;

begin
  if ButtonColor = clBtnFace then
  begin
    Color1 := ColorToRGB(clBtnHighlight);
    Color2 := ColorToRGB(cl3DDkShadow);
    Color3 := ColorToRGB(clBtnFace);
    Color4 := ColorToRGB(clBtnShadow);
    DrawButtonFrameEx2(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
    exit;
  end
  else
  begin
    ButtonColor := ColorToRGB(ButtonColor);

    hls1 := RGBtoHLS(ButtonColor);
    hls2 := hls1;
    hls3 := hls1;
    hls4 := hls1;

    lum := Hi(hls3 and $0000FFFF);
    if lum <> 0 then
    begin
      hls1 := (Min(239, (Hi(hls3 and $0000FFFF) + lum div 3)) shl 8) or (hls1
        and
        $FF00FF);
      hls2 := (Min(239, (Hi(hls3 and $0000FFFF) - lum div 2)) shl 8) or (hls2
        and
        $FF00FF);
      hls4 := (Min(239, (Hi(hls3 and $0000FFFF) - lum div 3)) shl 8) or (hls4
        and
        $FF00FF);

      Color1 := HLStoRGB(hls1);
      Color2 := HLStoRGB(hls2);
      Color3 := ButtonColor;
      Color4 := HLStoRGB(hls4);
      DrawButtonFrameEx2(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
      exit;
    end
    else
    begin
      Color1 := ColorToRGB(clBtnHighlight);
      Color2 := ColorToRGB(cl3DDkShadow);
      Color3 := ButtonColor;
      Color4 := ColorToRGB(clBtnShadow);
      DrawButtonFrameEx2(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
      exit;
    end;
  end;
end;

procedure DrawButtonFrame(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean);
begin

  if not Pushed then
  begin
    if Focused then
      Draw3dBorder(DC, rc, COLOR_3DHIGHLIGHT, COLOR_3DDKSHADOW, COLOR_3DFACE,
        COLOR_3DSHADOW)
    else
      Draw3dBorder(DC, rc, COLOR_3DHIGHLIGHT, COLOR_3DSHADOW, COLOR_3DFACE,
        COLOR_3DFACE);
  end
  else
    Draw3dBorder(DC, rc, COLOR_3DDKSHADOW, COLOR_3DHIGHLIGHT, COLOR_3DSHADOW,
      COLOR_3DFACE);

end;

procedure DrawButtonFrameEx2(DC: HDC; rc: TRect; Focused: boolean; Pushed:
  boolean; ButtonColor: TColor; Thin: boolean; clrHighlight, clrDkShadow,
    clrFace,
  clrShadow: TColor; BorderSides : TElBorderSides);
var
  Color1,
    Color2,
    Color3,
    Color4: TColor;

  procedure DrawBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4:
    TColor; Thin: boolean; BorderSides: TElBorderSides);
  var adj : integer;
  begin

    adj := 0;

    Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
      nColor1, nColor2, BorderSides);
    if not Thin then
    begin
      if ebsTop in BorderSides then
        inc(rc.Top);
      if ebsBottom in BorderSides then
        dec(rc.Bottom);
      if ebsLeft in BorderSides then
        inc(rc.Left);
      if ebsRight in BorderSides then
        dec(rc.Right);
      Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
        nColor3, nColor4, BorderSides);
    end;
  end;

begin
  Color1 := clrHighlight;
  Color2 := clrDkShadow;
  Color3 := clrFace;
  Color4 := clrShadow;
  if not Pushed then
  begin
    if Focused then
      DrawBorder(DC, rc, Color1, Color2, Color3, Color4, Thin, BorderSides)
    else
      DrawBorder(DC, rc, Color1, Color4, Color3, Color3, Thin, BorderSides);
  end
  else
    DrawBorder(DC, rc, Color4, Color1, Color2, Color3, Thin, BorderSides);
end;

{$WARNINGS off}

procedure DrawFlatFrameEx2(DC: HDC; R: TRect; Color, BkColor: TColor;
  Focused, Enabled: boolean;
  BorderSides: TElBorderSides;
  BorderType: TElFlatBorderType;
  Color1, Color2, Color3, Color4, Color5  :TColor);

var
  BtnFaceBrush,
    WindowBrush,
    ShadowBrush: HBRUSH;

  CustomColors : boolean;

  R1: TRect;
  Edge: DWORD;

const
  EdgeTypes: array[TElFlatBorderType] of DWORD = (EDGE_RAISED, BDR_SUNKEN,
    BDR_SUNKENINNER, BDR_SUNKENOUTER, EDGE_RAISED, BDR_RAISEDINNER,
    BDR_RAISEDOUTER, EDGE_BUMP, EDGE_BUMP, EDGE_ETCHED, EDGE_BUMP, 0, 0, 0, 0);
  EdgeFlat: array[boolean] of DWORD = (BF_RECT or BF_ADJUST, BF_FLAT or
    BF_ADJUST);

begin

  if BorderType = fbtFlat then
  begin
    DrawFlatFrame2(DC, R, BkColor, false, BorderSides);
    exit;
  end;

  if (BorderType <> fbtColorLineBorder) then
  begin
    CustomColors := true;
    BtnFaceBrush := CreateSolidBrush(ColorToRGB(Color1));
    WindowBrush := CreateSolidBrush(ColorToRGB(Color5));
    ShadowBrush := CreateSolidBrush(ColorToRGB(Color4));
    end
  else
  begin
    CustomColors := false;
    BtnFaceBrush := GetSysColorBrush(COLOR_BTNFACE); //get the Windows brush
    WindowBrush := GetSysColorBrush(COLOR_WINDOW); //get the Windows brush
    ShadowBrush := GetSysColorBrush(COLOR_BTNSHADOW);
    end;

  if BorderType = fbtFlat then
    Edge := BF_FLAT or BF_ADJUST
  else
  begin
    Edge := BF_ADJUST;
    if ebsLeft in BorderSides then
      Edge := Edge or BF_LEFT;
    if ebsTop in BorderSides then
      Edge := Edge or BF_TOP;
    if ebsRight in BorderSides then
      Edge := Edge or BF_RIGHT;
    if ebsBottom in BorderSides then
      Edge := Edge or BF_BOTTOM;
  end;

  if BorderType < fbtLine then
  begin
    if CustomColors then
      DrawEdgeEx(DC, R, EdgeTypes[BorderType], Edge, Color1, Color2, Color4, Color3)
    else
    DrawEdge(DC, R, EdgeTypes[BorderType], Edge);
  end;

  case BorderType of
    fbtFramed:
      with R do
      begin
        if ebsLeft in BorderSides then
          FrameRect(DC, Rect(Left - 1, Top, Left, Bottom), BtnFaceBrush);
        if ebsTop in BorderSides then
          FrameRect(DC, Rect(Left - 2, Top - 1, Right + 1, Top), BtnFaceBrush);
        if ebsRight in BorderSides then
          FrameRect(DC, Rect(Right + 1, Top - 2, Right + 2, Bottom + 2),
            ShadowBrush);
        if ebsBottom in BorderSides then
          FrameRect(DC, Rect(Left - 2, Bottom + 1, Right + 2, Bottom + 2),
            ShadowBrush);
        end;
    fbtRaised:
      begin
        R1 := R;
        (*
        R1 := DrawBevel(DC, R1, BkColor, BkColor, [ebsLeft, ebsRight, ebsTop, ebsBottom]);
        R1 := DrawBevel(DC, R1, BkColor, BkColor, [ebsLeft, ebsRight, ebsTop, ebsBottom]);
        R1 := DrawBevel(DC, R, clBtnShadow, clBtnHighlight, [ebsLeft, ebsRight, ebsTop, ebsBottom]);
        *)
        R1 := DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
        R1 := DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
        R1 := DrawBevel(DC, R, Color4, Color3, BorderSides);
      end;
    fbtRaisedInner:
      with R do
      begin
        if ebsLeft in BorderSides then
          FrameRect(DC, Rect(Left, Top, Left + 1, Bottom), BtnFaceBrush);
        if ebsTop in BorderSides then
          FrameRect(DC, Rect(Left, Top, Right, Top + 1), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), BtnFaceBrush);
        end;
    fbtRaisedOuter:
      with R do
      begin
        if ebsLeft in BorderSides then
          FillRect(DC, Rect(Left, Top, Left + 1, Bottom), BtnFaceBrush);
        if ebsTop in BorderSides then
          FillRect(DC, Rect(Left, Top, Right, Top + 1), BtnFaceBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right, Top - 1, Right + 1, Bottom + 1),
            ShadowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 1, Bottom, Right + 1, Bottom + 1),
            ShadowBrush);
        end;
    {fbtSunken:
      begin
        if not Focused then
        begin
          FrameRect (DC, R, BtnFaceBrush);
          InflateRect (R, -1, -1);
          if (not Enabled)
             then FrameRect(DC, R, WindowBrush)
             else FrameRect(DC, R, BtnFaceBrush);
        end;
      end;
    } fbtSunkenInner:
      with R do
      begin
        if ebsLeft in BorderSides then
          FrameRect(DC, Rect(Left, Top, Left + 1, Bottom), BtnFaceBrush);
        if ebsTop in BorderSides then
          FrameRect(DC, Rect(Left, Top, Right, Top + 1), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right, Top - 1, Right + 1, Bottom + 1),
            BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 1, Bottom, Right + 1, Bottom + 1),
            BtnFaceBrush);
        end;
    fbtSunkenOuter:
      with R do
      begin
        if ebsLeft in BorderSides then
          FrameRect(DC, Rect(Left, Top, Left + 1, Bottom - 1), BtnFaceBrush);
        if ebsTop in BorderSides then
          FrameRect(DC, Rect(Left, Top, Right - 1, Top + 1), BtnFaceBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right - 1, Top, Right, Bottom), BtnFaceBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left, Bottom - 1, Right, Bottom), BtnFaceBrush);

        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right, Top - 1, Right + 1, Bottom + 1),
            WindowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 1, Bottom, Right + 1, Bottom + 1),
            WindowBrush);
        end;
    fbtBump:
      with R do
      begin
        if ebsLeft in BorderSides then
          FillRect(DC, Rect(Left - 1, Top - 1, Left, Bottom), ShadowBrush);
        if ebsTop in BorderSides then
          FillRect(DC, Rect(Left, Top - 1, Right, Top), ShadowBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right + 2, Top - 2, Right + 1, Bottom + 2),
            ShadowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 2, Bottom + 1, Right + 2, Bottom + 2),
            ShadowBrush);
        end;
    fbtBigBump:
      with R do
      begin
        if ebsLeft in BorderSides then
          FillRect(DC, Rect(Left - 1, Top - 1, Left, Bottom), ShadowBrush);
        if ebsTop in BorderSides then
          FillRect(DC, Rect(Left, Top - 1, Right, Top), ShadowBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right + 2, Top - 2, Right + 1, Bottom + 2),
            ShadowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 2, Bottom + 1, Right + 2, Bottom + 2),
            ShadowBrush);

        if ebsLeft in BorderSides then
          FillRect(DC, Rect(Left - 2, Top - 2, Left - 1, Bottom + 1),
            WindowBrush);
        if ebsTop in BorderSides then
          FillRect(DC, Rect(Left - 2, Top - 2, Right + 1, Top - 1),
            WindowBrush);
        if ebsRight in BorderSides then
          FillRect(DC, Rect(Right + 1, Top - 2, Right, Bottom + 1),
            WindowBrush);
        if ebsBottom in BorderSides then
          FillRect(DC, Rect(Left - 2, Bottom, Right + 1, Bottom + 1),
            WindowBrush);
        end;
    fbtFlat,
    fbtEtched:
      with R do
      begin
        if (ebsLeft in BorderSides) and
          (ebsTop in BorderSides) then
          FillRect(DC, Rect(Left - 1, Top - 1, Right, Top), BtnFaceBrush)
        else
          if (ebsLeft in BorderSides) then
          FillRect(DC, Rect(Left - 1, Top, Right, Top), BtnFaceBrush)
        else
          if (ebsTop in BorderSides) then
          FillRect(DC, Rect(Left, Top - 1, Right, Top), BtnFaceBrush);
        end;
    fbtLine,
      fbtLineBorder,
      fbtNone: //mdm - Support for new styles
      begin
        R1 := DrawBevel(DC, R, BkColor, BkColor, BorderSides);
        DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
        case BorderType of
          fbtLine: DrawBevel(DC, R, clWindowFrame, clWindowFrame, [ebsBottom]);
          fbtLineBorder:
            DrawBevel(Dc, R, clWindowFrame, clWindowFrame,
              BorderSides);
        end;
      end;
    fbtColorLineBorder:
      begin
        R1 := DrawBevel(DC, R, Color, Color, BorderSides);
        DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
      end;
  end;
  if CustomColors then
  begin
    DeleteObject(WindowBrush);
    DeleteObject(ShadowBrush);
    DeleteObject(BtnFaceBrush);
  end;
  end;

procedure DrawFlatFrameEx(DC: HDC; R: TRect; BkColor: TColor; Focused, Enabled:
  boolean);
begin
  if Focused then
  begin
    Draw3dBorder(DC, R, COLOR_3DSHADOW, COLOR_3DHIGHLIGHT, COLOR_3DDKSHADOW,
      COLOR_3DLIGHT);
  end
  else
  begin
    if not Enabled then
      Draw3dBorder(DC, R, COLOR_3DSHADOW, COLOR_3DHIGHLIGHT, COLOR_3DFACE,
        COLOR_3DFACE)
    else
      Draw3dBorder(DC, R, COLOR_3DSHADOW, COLOR_3DHIGHLIGHT, COLOR_3DLIGHT,
        COLOR_3DLIGHT);
  end;
end;

function DrawFlatFrame(DC: HDC; R: TRect; BkColor: TColor; Focused: boolean):
TRect;
var
  R1: TRect;
begin
  R1 := R;
  R1 := DrawBevel(DC, R1, BkColor, BkColor, [ebsLeft, ebsRight, ebsTop,
    ebsBottom]);
  R1 := DrawBevel(DC, R1, BkColor, BkColor, [ebsLeft, ebsRight, ebsTop,
    ebsBottom]);

  if Focused then
  begin
    R := DrawBevel(DC, R, clBtnShadow, clBtnHighlight, [ebsLeft, ebsRight,
      ebsTop, ebsBottom]);
    R := DrawBevel(DC, R, clBtnText, cl3DLight, [ebsLeft, ebsRight, ebsTop,
      ebsBottom]);
  end
  else
  begin
    DrawBevel(DC, R, clBtnShadow, clBtnHighlight, [ebsLeft, ebsRight, ebsTop,
      ebsBottom]);
  end;
end;

function DrawFlatFrame2(DC: HDC; R: TRect; BkColor: TColor; Focused: boolean;
  BorderSides: TElBorderSides): TRect;
var
  R1: TRect;
begin
  R1 := R;
  R1 := DrawBevel(DC, R1, BkColor, BkColor, BorderSides);
  R1 := DrawBevel(DC, R1, BkColor, BkColor, BorderSides);

  if Focused then
  begin
    R := DrawBevel(DC, R, clBtnShadow, clBtnHighlight, BorderSides);
    R := DrawBevel(DC, R, clBtnText, cl3DLight, BorderSides);
  end
  else
  begin
    DrawBevel(DC, R, clBtnShadow, clBtnHighlight, BorderSides);
  end;
end;

procedure TiledPaint(Canvas: TCanvas; Bitmap: TBitmap; Rect: TRect);
begin
  TiledPaint(Canvas.Handle, Bitmap, Rect);
end;

procedure TiledPaint(ADC: HDC; Bitmap: TBitmap; Rect: TRect);
var
  CurRect: TRect;
  CurLeft,
  CurTop: integer;
begin
    CurTop := Rect.Top;
    while CurTop < Rect.Bottom do
      begin
        CurLeft := Rect.Left;
        while CurLeft < Rect.Right do
          begin
            CurRect := Classes.Rect(CurLeft, CurTop, Min(CurLeft + Bitmap.Width,
              Rect.Right), Min(CurTop + Bitmap.Height, Rect.Bottom));

            BitBlt(ADC, CurLeft, CurTop, CurRect.Right - CurRect.Left,
              CurRect.Bottom - CurRect.Top, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);

            Inc(CurLeft, Bitmap.Width);
          end;
        Inc(CurTop, Bitmap.Height);
      end;
end;

function HitTest(R: TRect; Pt: TPoint; CornerSize, BorderSize: integer):
integer;
begin
  if not PtInRect(R, Pt) then
  begin
    result := HTNOWHERE;
    exit;
  end;
  if LMDInRange(Pt.X, R.Left, R.Left + BorderSize - 1) then
  begin
    if Pt.Y <= (R.Top + CornerSize) then
    begin
      result := HTTOPLEFT;
      exit;
    end;
    if Pt.Y >= (R.Bottom - CornerSize - 1) then
    begin
      result := HTBOTTOMLEFT;
      exit;
    end;
    result := HTLEFT;
    exit;
  end
  else
    if LMDInRange(Pt.Y, R.Top, R.Top + BorderSize - 1) then
  begin
    if PT.X <= (R.Left + CornerSize) then
    begin
      result := HTTOPLEFT;
      exit;
    end;
    if PT.x >= (R.Right - CornerSize - 1) then
    begin
      result := HTTOPRIGHT;
      exit;
    end;
    result := HTTOP;
    exit;
  end
  else
    if LMDInRange(Pt.Y, R.Bottom - BorderSize - 1, R.Bottom - 1) then
  begin
    if PT.X <= (R.Left + CornerSize) then
    begin
      result := HTBOTTOMLEFT;
      exit;
    end;
    if PT.x >= (R.Right - CornerSize - 1) then
    begin
      result := HTBOTTOMRIGHT;
      exit;
    end;
    result := HTBOTTOM;
    exit;
  end
  else
    if LMDInRange(Pt.X, R.Right - BorderSize - 1, R.Right - 1) then
  begin
    if Pt.Y <= (R.Top + CornerSize) then
    begin
      result := HTTOPRIGHT;
      exit;
    end;
    if Pt.Y >= (R.Bottom - CornerSize - 1) then
    begin
      result := HTBOTTOMRIGHT;
      exit;
    end;
    result := HTRIGHT;
    exit;
  end;
  result := HTCLIENT;
end;

function GetTopWindowHandle(Child: HWND): HWND;
var
  h: HWND;
begin
  result := Child;
  while true do
  begin
    H := GetParent(result);
    if H <> 0 then
      result := H
    else
      break;
  end;
end;

function GetTopOwnerControl(Component: TComponent): TControl;
begin
  while (not (Component is TControl)) and (Component.Owner <> nil) do
    Component := Component.Owner;
  result := Component as TControl;
end;

function GetComponentByName(AOwner: TComponent; AName: string): TComponent;
begin
  Result := nil;
  if (AOwner <> nil) then
  begin
    Result := AOwner.FindComponent(AName);
    if (Result = nil) and (AOwner.Owner <> nil) then
      Result := AOwner.Owner.FindComponent(AName);
  end;
  if Result = nil then
    Result := Application.FindComponent(AName);
end;

function GetRootComponent(Component: TComponent): TComponent;
begin
  while (Component.Owner <> nil) do
    Component := Component.Owner;
  result := Component;
end;

var

  WaitCount: Integer = 0;
  SaveCursor: TCursor = crDefault;

procedure StartWait;
begin
  if WaitCount = 0 then
  begin
    SaveCursor := Screen.Cursor;
    Screen.Cursor := WaitCursor;
  end;
  Inc(WaitCount);
end;

procedure StopWait;
begin
  if WaitCount > 0 then
  begin
    Dec(WaitCount);
    if WaitCount <= 0 then
      Screen.Cursor := SaveCursor;
  end;
end;

procedure DrawFlatScrollbarThumb(DC: HDC; rc: TRect; Focused: boolean);
begin

  if Focused then
    Draw3dBorder(DC, rc, COLOR_3DFACE, COLOR_3DDKSHADOW, COLOR_3DHIGHLIGHT,
      COLOR_3DSHADOW)
  else
    Draw3dBorder(DC, rc, COLOR_3DHIGHLIGHT, COLOR_3DSHADOW, COLOR_3DFACE,
      COLOR_3DFACE);

end;

function AlphaBlend(
  hdcDest: HDC; // handle to destination DC
  nXOriginDest: Integer; // x-coord of upper-left corner
  nYOriginDest: Integer; // y-coord of upper-left corner
  nWidthDest: Integer; // destination width
  nHeightDest: Integer; // destination height
  hdcSrc: HDC; // handle to source DC
  nXOriginSrc: Integer; // x-coord of upper-left corner
  nYOriginSrc: Integer; // y-coord of upper-left corner
  nWidthSrc: Integer; // source width
  nHeightSrc: Integer; // source height
  SourceConstantAlpha: Byte;
    // Specifies an alpha transparency value to be used on the entire source bitmap
  SrcAlpha: byte
  ): Boolean;

var
  hLib: HINST;
  Func: TAlphaBlend;
  blendFunction: TBlendFunction;
  iBlendFunction: Integer absolute blendFunction;
begin
{$OPTIMIZATION OFF}
  Result := False;
  if LMDSIWindows2000Up or LMDSIWindows98 then
  begin
    hLib := LoadLibrary(PChar('msimg32.dll'));
    if hLib <> 0 then
    begin
      Func := TAlphaBlend(GetProcAddress(hLib, PChar('AlphaBlend')));
      if Assigned(Func) then
      begin
        with blendFunction do
        begin
          BlendOp := 0;
          BlendFlags := 0;
          AlphaFormat := SrcAlpha; //AC_SRC_ALPHA;
        end;
        blendFunction.SourceConstantAlpha := SourceConstantAlpha;
        Result := Func(hdcDest, nXOriginDest, nYOriginDest, nWidthDest,
          nHeightDest, hdcSrc, nXOriginSrc, nYOriginSrc, nWidthSrc, nHeightSrc,
          iBlendFunction);
      end;
      FreeLibrary(hLib);
    end;
  end;
{$OPTIMIZATION ON}
end;

procedure DrawFlatScrollBar(Wnd: HWND; DC: HDC; rect: TRect; nType: integer;
  bScrollbarCtrl: boolean; Dragging: boolean; Focused: boolean);
var
  nScrollSize: integer;
  nMinThumbSize: integer;
  RC1, RC2: TRect;
  si: TScrollInfo;
  nRange: integer;
  nThumbPos,
    nThumbSize: integer;
  nScrollArea: integer;

begin
  nScrollSize := GetSystemMetrics(SM_CXHSCROLL);

   // The minimal thumb size depends on the system version
   // For Windows 98 minimal thumb size is a half of scrollbar size
   // and for Windows NT is always 8 pixels regardless of system metrics.
   // I really don't know why.
  if LMDSIWindows98 then // Windows 98 code
    nMinThumbSize := nScrollSize div 2
  else
    nMinThumbSize := 8;

   // Calculate the arrow rectangles
  rc1 := rect;
  rc2 := rect;

  if (nType = SB_HORZ) then
  begin
    if ((rect.right - rect.left) < 2 * nScrollSize) then
      //nScrollSize := ( rect.right - rect.left ) div 2;
      nScrollSize := Round((rect.right - rect.left) / 2);
    rc1.right := rect.left + nScrollSize;
    rc2.left := rect.right - nScrollSize;
  end
  else // SB_VERT
  begin
    if ((rect.bottom - rect.top) < 2 * nScrollSize) then
      nScrollSize := (rect.bottom - rect.top) div 2;
    rc1.bottom := rect.top + nScrollSize;
    rc2.top := rect.bottom - nScrollSize;
  end;
  if not Dragging then
  begin
     // Draw the scrollbar arrows
    DrawFlatScrollbarThumb(DC, rc1, Focused);
    DrawFlatScrollbarThumb(DC, rc2, Focused);
  end;

   // Disabled scrollbar never have a thumb
  if (bScrollbarCtrl and not (IsWindowEnabled(Wnd))) then exit;

  si.cbSize := SizeOf(TSCROLLINFO);
  si.fMask := SIF_ALL;
  if bScrollbarCtrl then
    GetScrollInfo(Wnd, SB_CTL, si)
  else
    GetScrollInfo(Wnd, nType, si);

  if si.nPage = 0 then exit;
   // Calculate the size and position of the thumb
  nRange := si.nMax - si.nMin + 1;

  if (nRange <> 0) then
  begin
    if nType = SB_VERT then
      nScrollArea := (rect.bottom - rect.top) - 2 * nScrollSize
    else
      nScrollArea := (rect.right - rect.left) - 2 * nScrollSize;
    if (si.nPage = 0) then // If nPage is not set then thumb has default size
      nThumbSize := GetSystemMetrics(SM_CXHTHUMB)
    else
      nThumbSize := max(MulDiv(si.nPage, nScrollArea, nRange), nMinThumbSize);

    if (nThumbSize >= nScrollArea) then
    begin
      nThumbSize := nScrollArea;
      if (bScrollbarCtrl = FALSE) then exit;
    end;

    if (DWORD(nRange) = si.nPage) then
    begin
      nThumbPos := 0;
      dec(nThumbSize);
    end
    else
    begin
      if Dragging then
        nThumbPos := MulDiv(si.nTrackPos - si.nMin, nScrollArea - nThumbSize,
          nRange - si.nPage)
      else
        nThumbPos := MulDiv(si.nPos - si.nMin, nScrollArea - nThumbSize, nRange
          - si.nPage);
    end;

    if (nType = SB_VERT) then
    begin
      rc1.top := rc1.top + nScrollSize + nThumbPos;
      rc1.bottom := rc1.top + nThumbSize;
    end
    else // SB_HORZ
    begin
      rc1.left := rc1.left + nScrollSize + nThumbPos;
      rc1.right := rc1.left + nThumbSize;
    end;

    if (nThumbSize <= nScrollArea) then
      // Don't draw the thumb when it's larger than the scroll area
      DrawFlatScrollbarThumb(DC, rc1, Focused);
  end;
end;
{$WARNINGS on}

function DrawFlatScrollbars(Wnd: HWND; DC: HDC; Rect: TRect; Focused: boolean;
  ScrollBars: TScrollStyle; DragHorz, DragVert: boolean; IsControl: boolean;
  Style, ExStyle: integer): TRect;
var
  nFrameSize,
    hScrollSize,
    vScrollSize: integer;
  RC, RC1: TRect;
  dwStyle: DWORD;
  st: integer;
  bRightVSB :Boolean;
begin
  dwStyle := Style;
  st := ExStyle;
  if ((dwStyle and WS_BORDER) = WS_BORDER) then
    nFrameSize := GetSystemMetrics(SM_CXBORDER)
  else
    if ((st and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
    nFrameSize := GetSystemMetrics(SM_CXEDGE)
  else
    nFrameSize := 0;
  hScrollSize := GetSystemMetrics(SM_CXHSCROLL);
  vScrollSize := GetSystemMetrics(SM_CYVSCROLL);
  bRightVSB := ((dwStyle and WS_VSCROLL) <> 0) and ( (ExStyle and WS_EX_LEFTSCROLLBAR)=0 );
  if (not bRightVSB) and (not NewStyleControls) then
    bRightVSB := True;
  GetClientRect(Wnd, Rc);
  GetWindowRect(Wnd, Rc1);
  OffsetRect(Rc1, -Rc1.Left, -Rc1.Top);

  // paint cross scrollbars area:
  if ((dwStyle and WS_HSCROLL) <> 0) and ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    if bRightVSB then
    begin
      rc.left := rect.right - nFrameSize - hScrollSize;
      rc.right := rect.right - nFrameSize;
    end
    else
    begin
      rc.left := rect.left + nFrameSize;
      rc.right := rect.left + rc.left + hScrollSize;
    end;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.bottom := rect.bottom - nFrameSize;
    FillRect(DC, rc, HBRUSH(COLOR_BTNFACE + 1));
  end;

  if ScrollBars = ssNone then exit;

  if ScrollBars <> ssBoth then
  begin
    if ScrollBars = ssVertical then dwStyle := dwStyle and not WS_HSCROLL;
    if ScrollBars = {$IFDEF LMDCOMP18}TScrollStyle.{$ENDIF}ssHorizontal then dwStyle := dwStyle and not WS_VSCROLL;
  end;
  if ((dwStyle and WS_HSCROLL) <> 0) and ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    // horz scrollbar:
    if bRightVSB then
    begin
      rc.left := rect.left + nFrameSize;
      rc.right := rect.right - nFrameSize - hScrollSize;
    end
    else
    begin
      rc.left := rect.left + nFrameSize + hScrollSize;
      rc.right := rect.right - nFrameSize;
    end;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBar(Wnd, DC, rc, SB_HORZ, IsControl, DragHorz, Focused);
    // vert scrollbar:
    if bRightVSB then
    begin
      rc.left := rect.right - nFrameSize - hScrollSize;
      rc.right := rect.right - nFrameSize;
    end
    else
    begin
      rc.left := rect.left + nFrameSize;
      rc.right := rc.left + hScrollSize;
    end;
    rc.top := rect.top + nFrameSize;
    rc.bottom := rect.bottom - nFrameSize - vScrollSize;
    DrawFlatScrollBar(Wnd, DC, rc, SB_VERT, IsControl, DragVert, Focused);
  end
  else
    if ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize) then
  begin
    if bRightVSB then
    begin
      rc.left := rect.right - nFrameSize - hScrollSize;
      rc.right := rect.right - nFrameSize;
    end
    else
    begin
      rc.left := rect.left + nFrameSize;
      rc.right := rc.left + hScrollSize;
    end;
    rc.top := rect.top + nFrameSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBar(Wnd, DC, rc, SB_VERT, IsControl, DragVert, Focused);
  end
  else
    if ((dwStyle and WS_HSCROLL) <> 0)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    rc.left := rect.left + nFrameSize;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.right := rect.right - nFrameSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBar(Wnd, DC, rc, SB_HORZ, IsControl, DragHorz, Focused);
  end;
end;

{$WARNINGS off}

procedure DrawFlatScrollBarEx(Wnd: HWND; DC: HDC; rect: TRect; nType:
  integer; bScrollbarCtrl: boolean; Dragging: boolean; Focused: boolean;
  BkColor, DitherColor, ButtonColor, ArrowColor, HotButtonColor: TColor;
  DrawFrames, DitherBack: boolean);
var
  nScrollSize: integer;
  nMinThumbSize: integer;
  RC1, RC2: TRect;
  si: TScrollInfo;
  nRange: integer;
  nThumbPos,
    nThumbSize: integer;
  nScrollArea: integer;

begin
  nScrollSize := GetSystemMetrics(SM_CXHSCROLL);

   // The minimal thumb size depends on the system version
   // For Windows 98 minimal thumb size is a half of scrollbar size
   // and for Windows NT is always 8 pixels regardless of system metrics.
   // I really don't know why.
  if LMDSIWindows98 then // Windows 98 code
    nMinThumbSize := nScrollSize div 2
  else
    nMinThumbSize := 8;

   // Calculate the arrow rectangles
  rc1 := rect;
  rc2 := rect;

  if (nType = SB_HORZ) then
  begin
    if ((rect.right - rect.left) < 2 * nScrollSize) then
      //nScrollSize := ( rect.right - rect.left ) div 2;
      nScrollSize := Round((rect.right - rect.left) / 2);
    rc1.right := rect.left + nScrollSize;
    rc2.left := rect.right - nScrollSize;
  end
  else // SB_VERT
  begin
    if ((rect.bottom - rect.top) < 2 * nScrollSize) then
      nScrollSize := (rect.bottom - rect.top) div 2;
    rc1.bottom := rect.top + nScrollSize;
    rc2.top := rect.bottom - nScrollSize;
  end;
  if not Dragging then
  begin
     // Draw the scrollbar arrows
    DrawFlatScrollbarThumb(DC, rc1, Focused);
    DrawFlatScrollbarThumb(DC, rc2, Focused);
  end;

   // Disabled scrollbar never have a thumb
  if (bScrollbarCtrl and not (IsWindowEnabled(Wnd))) then exit;

  si.cbSize := SizeOf(TSCROLLINFO);
  si.fMask := SIF_ALL;
  if bScrollbarCtrl then
    GetScrollInfo(Wnd, SB_CTL, si)
  else
    GetScrollInfo(Wnd, nType, si);

   // Calculate the size and position of the thumb
  nRange := si.nMax - si.nMin + 1;

  if (nRange <> 0) then
  begin
    if nType = SB_VERT then
      nScrollArea := (rect.bottom - rect.top) - 2 * nScrollSize
    else
      nScrollArea := (rect.right - rect.left) - 2 * nScrollSize;
    if (si.nPage = 0) then // If nPage is not set then thumb has default size
      nThumbSize := GetSystemMetrics(SM_CXHTHUMB)
    else
      nThumbSize := max(MulDiv(si.nPage, nScrollArea, nRange), nMinThumbSize);

    if (nThumbSize >= nScrollArea) then
    begin
      nThumbSize := nScrollArea;
      if (bScrollbarCtrl = FALSE) then exit;
    end;

    if (DWORD(nRange) = si.nPage) then
    begin
      nThumbPos := 0;
      dec(nThumbSize);
    end
    else
    begin
      if Dragging then
        nThumbPos := MulDiv(si.nTrackPos - si.nMin, nScrollArea - nThumbSize,
          nRange - si.nPage)
      else
        nThumbPos := MulDiv(si.nPos - si.nMin, nScrollArea - nThumbSize, nRange
          - si.nPage);
    end;

    if (nType = SB_VERT) then
    begin
      rc1.top := rc1.top + nScrollSize + nThumbPos;
      rc1.bottom := rc1.top + nThumbSize;
    end
    else // SB_HORZ
    begin
      rc1.left := rc1.left + nScrollSize + nThumbPos;
      rc1.right := rc1.left + nThumbSize;
    end;

    if (nThumbSize <= nScrollArea) then
      // Don't draw the thumb when it's larger than the scroll area
      DrawFlatScrollbarThumb(DC, rc1, Focused);
  end;
end;

procedure DrawFlatScrollBarsEx(Wnd: HWND; DC: HDC; Rect: TRect; Focused:
  boolean; ScrollBars: TScrollStyle; DragHorz, DragVert: boolean; IsControl
  : boolean; BkColor, DitherColor, ButtonColor, ArrowColor, HotButtonColor:
  TColor; DrawFrames, DitherBack: boolean);
var
  nFrameSize,
    hScrollSize,
    vScrollSize: integer;
  RC, RC1: TRect;
  dwStyle: DWORD;
  st: integer;
begin
  if ScrollBars = ssNone then exit;
  dwStyle := GetWindowLong(Wnd, GWL_STYLE);
  st := GetWindowLong(Wnd, GWL_EXSTYLE);
  if ((dwStyle and WS_BORDER) = WS_BORDER) then
    nFrameSize := GetSystemMetrics(SM_CXBORDER)
  else
    if ((st and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
    nFrameSize := GetSystemMetrics(SM_CXEDGE)
  else
    nFrameSize := 0;
  hScrollSize := GetSystemMetrics(SM_CXHSCROLL);
  vScrollSize := GetSystemMetrics(SM_CYVSCROLL);
  GetClientRect(Wnd, Rc);
  GetWindowRect(Wnd, Rc1);
  OffsetRect(Rc1, -Rc1.Left, -Rc1.Top);

  if ScrollBars <> ssBoth then
  begin
    if ScrollBars = ssVertical then dwStyle := dwStyle and not WS_HSCROLL;
    if ScrollBars = {$IFDEF LMDCOMP18}TScrollStyle.{$ENDIF}ssHorizontal then dwStyle := dwStyle and not WS_VSCROLL;
  end;
  if ((dwStyle and WS_HSCROLL) <> 0) and ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    rc.left := rect.left + nFrameSize;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.right := rect.right - nFrameSize - hScrollSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBarEx(Wnd, DC, rc, SB_HORZ, IsControl, DragHorz, Focused,
      BkColor, DitherColor, ButtonColor, ArrowColor,
      HotButtonColor, DrawFrames, DitherBack);

    rc.left := rect.right - nFrameSize - hScrollSize;
    rc.top := rect.top + nFrameSize;
    rc.right := rect.right - nFrameSize;
    rc.bottom := rect.bottom - nFrameSize - vScrollSize;
    DrawFlatScrollBarEx(Wnd, DC, rc, SB_VERT, IsControl, DragVert, Focused,
      BkColor, DitherColor, ButtonColor, ArrowColor,
      HotButtonColor, DrawFrames, DitherBack);

    rc.left := rect.right - nFrameSize - hScrollSize;
    rc.right := rect.right - nFrameSize;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.bottom := rect.bottom - nFrameSize;
    FillRect(DC, rc, HBRUSH(COLOR_BTNFACE + 1));
  end
  else
    if ((dwStyle and WS_VSCROLL) <> 0)
    and ((Rc1.Bottom - Rc1.Top) - (Rc.Bottom - Rc.Top) >= nFrameSize +
    vScrollSize) then
  begin
    rc.left := rect.right - nFrameSize - hScrollSize;
    rc.top := rect.top + nFrameSize;
    rc.right := rect.right - nFrameSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBarEx(Wnd, DC, rc, SB_VERT, IsControl, DragVert, Focused,
      BkColor, DitherColor, ButtonColor, ArrowColor,
      HotButtonColor, DrawFrames, DitherBack);
  end
  else
    if ((dwStyle and WS_HSCROLL) <> 0)
    and ((Rc1.Right - Rc1.Left) - (Rc.Right - Rc.Left) >= nFrameSize +
    hScrollSize) then
  begin
    rc.left := rect.left + nFrameSize;
    rc.top := rect.bottom - nFrameSize - vScrollSize;
    rc.right := rect.right - nFrameSize;
    rc.bottom := rect.bottom - nFrameSize;
    DrawFlatScrollBarEx(Wnd, DC, rc, SB_HORZ, IsControl, DragHorz, Focused,
      BkColor, DitherColor, ButtonColor, ArrowColor,
      HotButtonColor, DrawFrames, DitherBack);
  end;
end;

{$WARNINGS on}

function DrawBevel(DC: HDC; R: TRect; Color1, Color2: TColor; Sides:
  TElBorderSides): TRect;
var
  APN,
    OPN: HPEN;
begin
  APN := CreatePen(PS_SOLID, 1, ColorToRGB(Color1));
  OPN := SelectObject(DC, APN);
  if ebsLeft in Sides then
  begin
    MoveToEx(DC, R.Left, R.Top, nil);
    LineTo(DC, R.Left, R.Bottom);
  end;
  if ebsTop in Sides then
  begin
    MoveToEx(DC, R.Left, R.Top, nil);
    LineTo(DC, R.Right, R.Top);
  end;

  SelectObject(DC, OPN);
  DeleteObject(APN);

  APN := CreatePen(PS_SOLID, 1, ColorToRGB(Color2));
  SelectObject(DC, APN);
  if ebsRight in Sides then
  begin
    MoveToEx(DC, R.Right - 1, R.Top, nil);
    LineTo(DC, R.Right - 1, R.Bottom);
  end;
  if ebsBottom in Sides then
  begin
    MoveToEx(DC, R.Left, R.Bottom - 1, nil);
    LineTo(DC, R.Right, R.Bottom - 1);
  end;
  SelectObject(DC, OPN);
  DeleteObject(APN);

  if ebsLeft in Sides then inc(R.Left);
  if ebsTop in Sides then inc(R.Top);
  if ebsRight in Sides then dec(R.Right);
  if ebsBottom in Sides then dec(R.Bottom);
  Result := R;
end;

procedure AlphaCopyRect(DestDC: HDC; Dest: TRect; SourceDC: HDC; Source: TRect;
  AlphaLevel: byte; UseAlphaLevel: boolean);

var
  i, j, k: integer;
  Color,
    DstColor: TColor;
  DstBitmap,
    TmpBitmap: TBitmap;

    {h,} w: integer;
  Info: TBitmapInfo;
  pBits,
    dBits: pchar;
  p, dp: PInteger;
begin
  TmpBitmap := TBitmap.Create;
  TmpBitmap.Width := Dest.Right - Dest.Left;
  TmpBitmap.Height := Dest.Bottom - Dest.Top;
  TmpBitmap.PixelFormat := pf32Bit;

  DstBitmap := TBitmap.Create;
  DstBitmap.Width := Dest.Right - Dest.Left;
  DstBitmap.Height := Dest.Bottom - Dest.Top;
  DstBitmap.PixelFormat := pf32Bit;

  if (Dest.Right - Dest.Left = Source.Right - Source.Left) and
    (Dest.Bottom - Dest.Top = Source.Bottom - Source.Top) then
    bitblt(TmpBitmap.Canvas.Handle, 0, 0, Dest.Right - Dest.Left, Dest.Bottom -
      Dest.Top, SourceDC, Source.Left, Source.Top, srccopy)
  else
    StretchBlt(TmpBitmap.Canvas.Handle, 0, 0, TmpBitmap.Width, TmpBitmap.Height,
      SourceDC, Source.Left, Source.Top,
      Source.Right - Source.Left, Source.Bottom - Source.Top, SRCCOPY);

  bitblt(DstBitmap.Canvas.Handle, 0, 0, Dest.Right - Dest.Left, Dest.Bottom -
    Dest.Top, DestDC, Dest.Left, Dest.Top, srccopy);

  ZeroMemory(@Info.bmiHeader, SizeOf(Info.bmiHeader));
  Info.bmiHeader.biSize := SizeOf(Info.bmiHeader);
  Info.bmiHeader.biWidth := TmpBitmap.Width;
  Info.bmiHeader.biHeight := TmpBitmap.Height;
  Info.bmiHeader.biPlanes := 1;
  Info.bmiHeader.biBitCount := 32;
  Info.bmiHeader.biCompression := BI_RGB;

  i := TmpBitmap.Width * TmpBitmap.Height * SizeOf(Integer);
  GetMem(pBits, i);
  GetDIBits(DestDC, TmpBitmap.Handle, 0, TmpBitmap.Height, pBits, Info,
    DIB_RGB_COLORS);

  GetMem(dBits, i);
  GetDIBits(DestDC, DstBitmap.Handle, 0, TmpBitmap.Height, dBits, Info,
    DIB_RGB_COLORS);

  //h := TmpBitmap.Height;
  w := TmpBitmap.Width;

  for j := 0 to Dest.Bottom - Dest.Top - 1 do
  begin
    for i := 0 to Dest.Right - Dest.Left - 1 do
    begin
      k := ({H - 1 - } j) * w + i;
      p := PInteger(pBits);
      inc(p, k);
      dp := PInteger(dBits);
      inc(dp, k);

      Color := P^;
      DstColor := DP^;

      if not UseAlphaLevel then
        AlphaLevel := Color shr 24;

      P^ := ((((Color and $FF0000 shr 16) * AlphaLevel + (DstColor and $FF0000
        shr 16) * (256 - AlphaLevel)) shl 8) and $FF0000) or
        (((Color and $FF00 shr 8) * AlphaLevel + (DstColor and $FF00 shr 8) *
        (256 - AlphaLevel)) and $00FF00) or
        (((Color and $FF) * AlphaLevel + (DstColor and $FF) * (256 - AlphaLevel))
        shr 8 and $FF);
    end;
  end;
  SetDIBits(TmpBitmap.Canvas.Handle, TmpBitmap.Handle, 0, TmpBitmap.Height,
    pBits, Info, DIB_RGB_COLORS);
  bitblt(DestDC, Dest.Left, Dest.Top, Dest.Right - Dest.Left, Dest.Bottom -
    Dest.Top, TmpBitmap.Canvas.Handle, 0, 0, srccopy);
  TmpBitmap.Free;
  DstBitmap.Free;
  FreeMem(dBits);
  FreeMem(pBits);
end;

procedure AlphaCopyRect2(DestDC: HDC; Dest: TRect; SourceDC: HDC;
  Source: TRect; Mask: TBitmap; AlphaLevel: byte {; UseAlphaLevel : boolean});

type
  TstCol = record
    case Cardinal of
      0: (Blue, Green, Red, Alpha: byte);
      1: (RGBA: Cardinal);
  end;

var
  i, j, k: integer;
  Color,
  DstColor: TColor;
  DstBitmap,
  TmpBitmap,
  MskBitmap: TBitmap;

  w: integer;
  Info: TBitmapInfo;
  pBits,
  dBits,
  mBits: pchar;
  p, dp, mp: PInteger;
  Alpha: byte;
  fAlpha: double;
  src, dst: TstCol;
  SCA: word;
begin
  TmpBitmap := TBitmap.Create;
  TmpBitmap.Width := Dest.Right - Dest.Left;
  TmpBitmap.Height := Dest.Bottom - Dest.Top;
  TmpBitmap.PixelFormat := pf32Bit;

  DstBitmap := TBitmap.Create;
  DstBitmap.Width := Dest.Right - Dest.Left;
  DstBitmap.Height := Dest.Bottom - Dest.Top;
  DstBitmap.PixelFormat := pf32Bit;

  MskBitmap := TBitmap.Create;
  MskBitmap.Width := TmpBitmap.Width;
  MskBitmap.Height := TmpBitmap.Height;
  MskBitmap.PixelFormat := pf32bit;

  if (Dest.Right - Dest.Left = Source.Right - Source.Left) and
     (Dest.Bottom - Dest.Top = Source.Bottom - Source.Top) then
    bitblt(TmpBitmap.Canvas.Handle, 0, 0, Dest.Right - Dest.Left, Dest.Bottom -
           Dest.Top, SourceDC, Source.Left, Source.Top, srccopy)
  else
    StretchBlt(TmpBitmap.Canvas.Handle, 0, 0, TmpBitmap.Width, TmpBitmap.Height,
               SourceDC, Source.Left, Source.Top,
               Source.Right - Source.Left, Source.Bottom - Source.Top, SRCCOPY);

  if (MskBitmap.Width = Source.Right - Source.Left) and
     (MskBitmap.Height = Source.Bottom - Source.Top) then
    bitblt(MskBitmap.Canvas.Handle, 0, 0, MskBitmap.Width, MskBitmap.Height,
           Mask.Canvas.Handle, Source.Left, Source.Top, srccopy)
  else
    StretchBlt(MskBitmap.Canvas.Handle, 0, 0, MskBitmap.Width, MskBitmap.Height,
               Mask.Canvas.Handle, Source.Left, Source.Top,
               Source.Right - Source.Left, Source.Bottom - Source.Top, SRCCOPY);

  bitblt(DstBitmap.Canvas.Handle, 0, 0, Dest.Right - Dest.Left, Dest.Bottom -
         Dest.Top, DestDC, Dest.Left, Dest.Top, srccopy);
  ZeroMemory(@Info.bmiHeader, SizeOf(Info.bmiHeader));
  Info.bmiHeader.biSize := SizeOf(Info.bmiHeader);
  Info.bmiHeader.biWidth := TmpBitmap.Width;
  Info.bmiHeader.biHeight := TmpBitmap.Height;
  Info.bmiHeader.biPlanes := 1;
  Info.bmiHeader.biBitCount := 32;
  Info.bmiHeader.biCompression := BI_RGB;

  i := TmpBitmap.Width * TmpBitmap.Height * SizeOf(Integer);
  GetMem(pBits, i);
  GetDIBits(DestDC, TmpBitmap.Handle, 0, TmpBitmap.Height, pBits, Info, DIB_RGB_COLORS);

  GetMem(dBits, i);
  GetDIBits(DestDC, DstBitmap.Handle, 0, TmpBitmap.Height, dBits, Info, DIB_RGB_COLORS);

  GetMem(mBits, i);
  GetDIBits(DestDC, MskBitmap.Handle, 0, MskBitmap.Height, mBits, Info, DIB_RGB_COLORS);

  w := TmpBitmap.Width;

  SCA := AlphaLevel + 1;

  for j := 0 to Dest.Bottom - Dest.Top - 1 do
  begin
    for i := 0 to Dest.Right - Dest.Left - 1 do
    begin
      k := ({H - 1 - } j) * w + i;
      p := PInteger(pBits);
      inc(p, k);
      dp := PInteger(dBits);
      inc(dp, k);

      Color := P^;
      DstColor := DP^;

      mp := PInteger(mBits);
      inc(mp, k);
      Alpha := mp^ and $FF;

      dst.rgba := DstColor;
      src.rgba := Color;

      src.Alpha := (Alpha * SCA) shr 8;
      src.Red := (src.Red * SCA) shr 8;
      src.Green := (src.Green * SCA) shr 8;
      src.Blue := (src.Blue * SCA) shr 8;

      fAlpha := Src.Alpha / 255;

      dst.Alpha := trunc(Src.Alpha + (1 - fAlpha) * Dst.Alpha);
      dst.Red := trunc(fAlpha * Src.Red + (1 - fAlpha) * Dst.Red);
      dst.Green := trunc(fAlpha * Src.Green + (1 - fAlpha) * Dst.Green);
      dst.Blue := trunc(fAlpha * Src.Blue + (1 - fAlpha) * Dst.Blue);

      P^ := dst.rgba;
    end;
  end;
  SetDIBits(TmpBitmap.Canvas.Handle, TmpBitmap.Handle, 0, TmpBitmap.Height,
    pBits, Info, DIB_RGB_COLORS);
  bitblt(DestDC, Dest.Left, Dest.Top, Dest.Right - Dest.Left, Dest.Bottom -
    Dest.Top, TmpBitmap.Canvas.Handle, 0, 0, srccopy);
  TmpBitmap.Free;
  DstBitmap.Free;
  MskBitmap.Free;
  FreeMem(dBits);
  FreeMem(pBits);
  FreeMem(mBits);
end;

function IsAlphaEmpty(bmp: TBitmap): boolean;

var
  i: integer;
  {$ifdef LMDX86}
  //j: integer;
  {$endif}
  dib: pchar;
  Info: TBitmapInfo;
begin
  Result := true;
  if bmp.PixelFormat <> pf32bit then exit;

  ZeroMemory(@Info.bmiHeader, SizeOf(Info.bmiHeader));
  Info.bmiHeader.biSize := SizeOf(Info.bmiHeader);
  Info.bmiHeader.biWidth := bmp.Width;
  Info.bmiHeader.biHeight := bmp.Height;
  Info.bmiHeader.biPlanes := 1;
  Info.bmiHeader.biBitCount := 32;
  Info.bmiHeader.biCompression := BI_RGB;
  i := bmp.Width * bmp.Height;
  GetMem(dib, i * SizeOf(Integer));
  GetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, bmp.Height, dib, Info, DIB_RGB_COLORS);

  {$ifdef LMDX64}
  while i > 0 do
  begin
    dec(i);
    if (PInteger(dib + (i * SizeOf(Integer)))^ and $ff000000) = $ff000000 then
      break;
  end;
  {$else}
  asm
    mov edx, PInteger(dib)
    dec edx
    dec edx
    dec edx
    dec edx

    mov ecx, i
  @:
    inc edx
    inc edx
    inc edx
    inc edx
    test dword ptr [edx], $ff000000
    loopz @
    mov i, ecx
  end;
  {$endif}

  FreeMem(dib);

  Result := i=0;
end;

procedure ClearAlpha(var bmp: TBitmap);

var
  i: integer;
  dib: pchar;
  Info: TBitmapInfo;
begin
  if bmp.PixelFormat <> pf32bit then exit;

  ZeroMemory(@Info.bmiHeader, SizeOf(Info.bmiHeader));
  Info.bmiHeader.biSize := SizeOf(Info.bmiHeader);
  Info.bmiHeader.biWidth := bmp.Width;
  Info.bmiHeader.biHeight := bmp.Height;
  Info.bmiHeader.biPlanes := 1;
  Info.bmiHeader.biBitCount := 32;
  Info.bmiHeader.biCompression := BI_RGB;
  i := bmp.Width * bmp.Height;
  GetMem(dib, i * SizeOf(Integer));
  GetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, bmp.Height, dib, Info, DIB_RGB_COLORS);
  {$ifdef LMDX64}
  while i > 0 do
  begin
    dec(i);
    PInteger(dib + (i * sizeOf(Integer)))^ := PInteger(dib + (i * sizeOf(Integer)))^ or $ff00000;
    PInteger(dib + (i * sizeOf(Integer)))^ := PInteger(dib + (i * sizeOf(Integer)))^ xor $ff00000;
  end;
  {$else}
  asm
    mov edx, PInteger(dib)
    dec edx
    dec edx
    dec edx
    dec edx

    mov ecx, i
  @:
    inc edx
    inc edx
    inc edx
    inc edx
    or dword ptr [edx], $ff000000
    xor dword ptr [edx], $ff000000
    loop @
  end;
  {$endif}

  SetDIBits(bmp.Canvas.Handle, bmp.Handle, 0, bmp.Height, dib, Info, DIB_RGB_COLORS);
  FreeMem(dib);
end;

procedure AlphaFillRect(Canvas: TCanvas; ARect: TRect; Color: TColor; AlphaLevel: byte);
var
  BMP: TBitmap;
begin
  BMP := TBitmap.Create;
  BMp.Width := (ARect.Right - ARect.Left) + 1;
  BMp.Height := (ARect.Bottom - ARect.Top) + 1;
  BMP.Canvas.Brush.Color := Color;
  BMP.Canvas.FillRect(Rect(0, 0, BMP.Width, BMP.Height));
  AlphaCopyRect(Canvas.Handle, ARect, BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), AlphaLevel, true);
  BMP.Free;
end;

function NextLineW(hdc: HDC; const Str: PWideChar; var Count: Integer;
  Dest: PWideChar; var Len: Integer; Width: integer; Format: Word;
  var TabWidth, SpaceWidth, PrefixOffset, Overhang: integer): PWideChar;
var
  i, j, k: integer;
  LenLimit: integer;
  bUnderLineChar: Boolean;
  LineWidth: integer;
  SpaceCount: integer;
  Size: TSize;
  LastTab: integer;
  wb_i: integer;
  wb_j: integer;
  wb_Count: integer;
begin
  Result := nil;
  i := 0;
  j := 0;
  LineWidth := 0;
  LastTab := 0;
  wb_i := 0;
  wb_j := 0;
  wb_Count := 0;
  LenLimit := Len;

  while (Count <> 0) and (j < LenLimit) do
  begin
    case (Str[i]) of
      WideChar(#9):
        if (format and DT_EXPANDTABS) = DT_EXPANDTABS then
        begin
          inc(i);
          wb_i := i;
          wb_j := j;
          wb_Count := Count;

          if (not GetTextExtentPoint32W(hdc, @Dest[LastTab], j - LastTab, Size)) then
            exit;

          SpaceCount := (tabwidth - (Size.cx - Overhang)) div SpaceWidth;
          for k := 0 to SpaceCount - 1 do
          begin
            Dest[j] := WideChar(#32);
            inc(j);
          end;
          inc(LineWidth, tabwidth - Size.cx);
          LastTab := wb_j + SpaceCount;
        end
        else
        begin
          Dest[j] := Str[i];
          inc(j);
          inc(i);

          if ((Format and DT_NOCLIP)  <> DT_NOCLIP) and
            (
              ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
              ((Format and DT_WORDBREAK) = DT_WORDBREAK)
            ) then
          begin
            if (not GetTextExtentPoint32W(hdc, @Dest[j - 1], 1, Size)) then
              exit;
            inc(LineWidth, Size.cx - Overhang);
          end;
        end;
      WideChar(#10),
      WideChar(#13):
        begin
          if (format and DT_SINGLELINE) <> DT_SINGLELINE then
          begin
            if ((Count > 1) and (Str[i] = WideChar(#13)) and (Str[i + 1] =
              WideChar(#10))) then
            begin
              dec(Count);
              inc(i);
            end;
            inc(i);
            Len := j;
            dec(Count);
            Result := (@Str[i]);
            exit;
          end;

          Dest[j] := Str[i];
          inc(j);
          inc(i);

          if ((Format and DT_NOCLIP)  <> DT_NOCLIP) and
            (
              ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
              ((Format and DT_WORDBREAK) = DT_WORDBREAK)
            ) then
          begin
            if (not GetTextExtentPoint32W(hdc, @Dest[j - 1], 1, Size)) then
              exit;
            inc(LineWidth, Size.cx - Overhang);
          end;
        end;
      WideChar(#32):
        begin
          Dest[j] := Str[i];
          inc(j);
          inc(i);

            if ((Format and DT_NOCLIP)  <> DT_NOCLIP) and
              (
                ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
                ((Format and DT_WORDBREAK) = DT_WORDBREAK)
              ) then
          begin
            wb_i := i;
            wb_j := j - 1;
            wb_Count := Count;
            if (not GetTextExtentPoint32W(hdc, @Dest[j - 1], 1, Size)) then
              exit;
            inc(LineWidth, Size.cx - Overhang);
          end;
        end;
      WideChar('&'){#38}:
        begin
          bUnderLineChar := true;
          if ((format and DT_NOPREFIX) <> DT_NOPREFIX) and (Count > 1) then
          begin
            inc(i);
            if (Str[i] = WideChar('&')) then
              dec(Count)
            else
            begin
              PrefixOffset := j;
              bUnderLineChar := false;
            end;
          end;
          if bUnderLineChar then
          begin
            Dest[j] := Str[i];
            inc(j);
            inc(i);
            if ((Format and DT_NOCLIP)  <> DT_NOCLIP) and
              (
                ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
                ((Format and DT_WORDBREAK) = DT_WORDBREAK)
              ) then
            begin
              if (not GetTextExtentPoint32W(hdc, @Dest[j - 1], 1, Size)) then
                exit;
              inc(LineWidth, Size.cx - Overhang);
            end;
          end;
        end;
    else
      begin
        Dest[j] := Str[i];
        inc(j);
        inc(i);

        if ((Format and DT_NOCLIP)  <> DT_NOCLIP) and
          (
            ((Format and DT_NOPREFIX) <> DT_NOPREFIX) or
            ((Format and DT_WORDBREAK) = DT_WORDBREAK)
          ) then
        begin
          if (not GetTextExtentPoint32W(hdc, @Dest[j - 1], 1, Size)) then
            exit;
          inc(LineWidth, Size.cx - Overhang);
        end;
      end;
    end;//of: case (Str[i])

    dec(Count);
    if ((format and DT_NOCLIP) <> DT_NOCLIP) and
      ((format and DT_WORDBREAK) = DT_WORDBREAK) then
    begin
      if (LineWidth > width)
        {and (((format and DT_CALCRECT) <> DT_CALCRECT) or (width <> 0))}then
      begin
        if (format and DT_WORDBREAK) = DT_WORDBREAK then
        begin
          if (wb_j <> 0) then
          begin
            Len := wb_j;
            Count := wb_Count - 1;
            Result := (@Str[wb_i]);
            exit;
          end
          else
          begin
            if (j > 1) and (i > 0) then
            begin
              Len := j - 1;
              Result := (@Str[i - 1]);
              Inc(Count);
            end
            else
            begin
              Len := j;
              Result := (@Str[i]);
            end;
            exit;
          end;
        end
        else
        begin
          Len := j;
          exit;
        end;
      end;
    end;
  end;//of: while (Count <> 0) and (j < LenLimit)

  Len := j;
end;

function DrawTextW(hDC: HDC; lpString: PWideChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer;
begin
  Result := LMDDrawTextW(hDC, lpString, nCount, lpRect, uFormat);
end;

function GetSysColorPen(Color: COLORREF): HPEN;
begin
  result := CreatePen(PS_SOLID, 1, Color);
end;

procedure DrawFocus(Canvas: TCanvas; R: TRect);

  procedure DrawLine(Canvas: TCanvas; StartX, StartY, EndX, EndY: integer);
  var
    Coord: Integer;
    // CRef: COLORREF;
    // DC: HDC;
  begin
    // CRef := ColorToRGB(Canvas.Pen.Color);
    // skip a pixel if not in grid
    Coord := (StartX and 1) xor (StartY and 1);
    if StartX = EndX then
    begin
      // draw vertical Line
      Inc(Coord, StartY);
      // DC := Canvas.Handle;
      while Coord < EndY do
      begin
        Canvas.MoveTo(StartX, Coord);
        Inc(Coord, 1);
        Canvas.LineTo(StartX, Coord);
        Inc(Coord, 1);
      end;
    end
    else
    begin
      // draw horizontal Line
      Inc(Coord, StartX);
      //DC := Canvas.Handle;
      while Coord < EndX do
      begin
        Canvas.MoveTo(Coord, StartY);
        Inc(Coord, 1);
        Canvas.LineTo(Coord, StartY);
        Inc(Coord, 1);
      end;
    end;
  end;

begin
  DrawLine(Canvas, R.Left, R.Top, R.Left, R.Bottom - 1);
  DrawLine(Canvas, R.Left, R.Top, R.Right - 1, R.Top);
  DrawLine(Canvas, R.Right - 1, R.Top, R.Right - 1, R.Bottom);
  DrawLine(Canvas, R.Left, R.Bottom - 1, R.Right - 1, R.Bottom - 1);
end;

function Win2KHideUIState: boolean;
var
  b: bool;
begin
  SystemParametersInfo(SPI_GETKEYBOARDCUES, 0, @b, 0);
  result := not b;
end;

function ModalFormVisible: boolean;
var
  i: integer;

begin
  result := false;
  for i := 0 to Screen.FormCount - 1 do
  begin

    if fsModal in TCustomForm(Screen.Forms[i]).FormState then

    begin
      result := true;
      exit;
    end;
  end;
end;

function ShiftStateToKeyData(Shift: TShiftState): integer;
begin
  if ssAlt in Shift then
    result := $20000000
  else
    result := 0;
end;

procedure DrawEdge(DC: HDC; var RC: TRect; edge: UINT; grfFlags: UINT);
var
  Color1,
    Color2,
    Color3,
    Color4: TColor;
    BorderSides: TElBorderSides;
    R : TRect;

  procedure DrawBorder(DC: HDC; var rc: TRect; nColor1, nColor2, nColor3, nColor4:
    TColor; Inner, Outer : boolean; SunkenInner, SunkenOuter : boolean; BorderSides: TElBorderSides);
  var adj : integer;
  begin

    adj := 0;

    if Outer then
    begin
      if SunkenOuter then
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor4, nColor3, BorderSides)
      else
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor1, nColor2, BorderSides);
    end;
    if Inner then
    begin
      if Outer then
      begin
        if ebsTop in BorderSides then
          inc(rc.Top);
        if ebsBottom in BorderSides then
          dec(rc.Bottom);
        if ebsLeft in BorderSides then
          inc(rc.Left);
        if ebsRight in BorderSides then
          dec(rc.Right);
      end;
      if SunkenInner then
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor2, nColor1, BorderSides)
      else
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor3, nColor4, BorderSides);
    end;
    if Outer or (Inner and (not Outer)) then
      if ebsTop in BorderSides then
        inc(rc.Top);
      if ebsBottom in BorderSides then
        dec(rc.Bottom);
      if ebsLeft in BorderSides then
        inc(rc.Left);
      if ebsRight in BorderSides then
        dec(rc.Right);
  end;

begin
  if grfFlags and BF_DIAGONAL = BF_DIAGONAL then
  begin
    Windows.DrawEdge(DC, RC, Edge, grfFlags);
    exit;
  end;
  if grfFlags and BF_MONO = BF_MONO then
  begin
    Color1 := ColorToRGB(cl3DDkShadow);
    Color2 := ColorToRGB(cl3DDkShadow);
    Color3 := ColorToRGB(clBtnFace);
    Color4 := ColorToRGB(clBtnFace);
  end
  else
  if grfFlags and BF_FLAT = BF_FLAT then
  begin
    Color1 := ColorToRGB(clBtnShadow);
    Color2 := ColorToRGB(clBtnShadow);
    Color3 := ColorToRGB(clBtnFace);
    Color4 := ColorToRGB(clBtnFace);
  end
  else
  begin
    Color1 := ColorToRGB(clBtnFace);
    Color2 := ColorToRGB(cl3DDkShadow);
    Color3 := ColorToRGB(clBtnHighlight);
    Color4 := ColorToRGB(clBtnShadow);
  end;

  BorderSides := [];
  if (grfFlags and BF_LEFT) <> 0 then
    Include(BorderSides, ebsLeft);
  if (grfFlags and BF_TOP) <> 0 then
    Include(BorderSides, ebsTop);
  if (grfFlags and BF_RIGHT) <> 0 then
    Include(BorderSides, ebsRight);
  if (grfFlags and BF_BOTTOM) <> 0 then
    Include(BorderSides, ebsBottom);

  R := RC;

  DrawBorder(DC, r, Color1, Color2, Color3, Color4,
    {Inner}(Edge and (BDR_RAISEDINNER or BDR_SUNKENINNER)) <> 0,
    {Outer}(Edge and (BDR_RAISEDOUTER or BDR_SUNKENOUTER)) <> 0,
    {SunkenInner}(Edge and BDR_SUNKENINNER) <> 0,
    {SunkenOuter}(Edge and BDR_SUNKENOUTER) <> 0,
    BorderSides);

  if grfFlags and BF_ADJUST = BF_ADJUST then
  begin
    RC := R;
  end;

  // fill interior
  if grfFlags and BF_MIDDLE = BF_MIDDLE then
    with R do
      LMDFillSolidRect(DC, Left, Top, Right - Left, Bottom - Top, clBtnFace);
end;

procedure DrawEdgeEx(DC: HDC; var RC: TRect; edge: UINT; grfFlags: UINT; Color1, Color2, Color3, Color4 : TColor);
var
  BorderSides: TElBorderSides;
  R : TRect;

  procedure DrawBorder(DC: HDC; var rc: TRect; nColor1, nColor2, nColor3, nColor4:
    TColor; Inner, Outer : boolean; SunkenInner, SunkenOuter : boolean; BorderSides: TElBorderSides);
  var adj : integer;
  begin

    adj := 0;

    if Outer then
    begin
      if SunkenOuter then
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor4, nColor3, BorderSides)
      else
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor1, nColor2, BorderSides);
    end;
    if Inner then
    begin
      if Outer then
      begin
        if ebsTop in BorderSides then
          inc(rc.Top);
        if ebsBottom in BorderSides then
          dec(rc.Bottom);
        if ebsLeft in BorderSides then
          inc(rc.Left);
        if ebsRight in BorderSides then
          dec(rc.Right);
      end;
      if SunkenInner then
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor2, nColor1, BorderSides)
      else
        Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj,
          nColor3, nColor4, BorderSides);
    end;
    if Outer or (Inner and (not Outer)) then
      if ebsTop in BorderSides then
        inc(rc.Top);
      if ebsBottom in BorderSides then
        dec(rc.Bottom);
      if ebsLeft in BorderSides then
        inc(rc.Left);
      if ebsRight in BorderSides then
        dec(rc.Right);
  end;

begin
  if grfFlags and BF_DIAGONAL = BF_DIAGONAL then
  begin
    Windows.DrawEdge(DC, RC, Edge, grfFlags);
    exit;
  end;
  begin
    Color1 := ColorToRGB(Color1);
    Color2 := ColorToRGB(Color2);
    Color3 := ColorToRGB(Color3);
    Color4 := ColorToRGB(Color4);
  end;

  BorderSides := [];
  if (grfFlags and BF_LEFT) <> 0 then
    Include(BorderSides, ebsLeft);
  if (grfFlags and BF_TOP) <> 0 then
    Include(BorderSides, ebsTop);
  if (grfFlags and BF_RIGHT) <> 0 then
    Include(BorderSides, ebsRight);
  if (grfFlags and BF_BOTTOM) <> 0 then
    Include(BorderSides, ebsBottom);

  R := RC;

  DrawBorder(DC, r, Color1, Color2, Color3, Color4,
    {Inner}(Edge and (BDR_RAISEDINNER or BDR_SUNKENINNER)) <> 0,
    {Outer}(Edge and (BDR_RAISEDOUTER or BDR_SUNKENOUTER)) <> 0,
    {SunkenInner}(Edge and BDR_SUNKENINNER) <> 0,
    {SunkenOuter}(Edge and BDR_SUNKENOUTER) <> 0,
    BorderSides);

  if grfFlags and BF_ADJUST = BF_ADJUST then
  begin
    RC := R;
  end;

  // fill interior
  if grfFlags and BF_MIDDLE = BF_MIDDLE then
    with R do
      LMDFillSolidRect(DC, Left, Top, Right - Left, Bottom - Top, Color1);
end;

{< VCL DFM UTILS}

var

  fElReader: TElReader;
  fStream:TMemoryStream;

function GetElReader:TElReader;
begin
  if Assigned(fElReader) then
    Result := fElReader
  else
  begin
    fStream := TMemoryStream.Create;
    fElReader := TElReader.Create(fStream, 0);
    Result := fElReader;
  end;
end;

{ TElReader }

type
  {$warnings off}
  {$hints off}
  TReaderHack = class(TFiler)
  private
    FOwner: TComponent;
    FParent: TComponent;
    FFixups: TList;
    FLoaded: TList;
    FOnFindMethod: TFindMethodEvent;
    FOnSetName: TSetNameEvent;
    FOnReferenceName: TReferenceNameEvent;
    FOnAncestorNotFound: TAncestorNotFoundEvent;
    FOnError: TReaderError;
    FOnFindComponentClass: TFindComponentClassEvent;
      FOnCreateComponent: TCreateComponentEvent;
      FPropName: string;
      FFinder: TClassFinder;
      FCanHandleExcepts: Boolean;
   end;
  {$hints on}
  {$warnings on}

procedure TElReader.FakeDefineProperty(Filer: TFiler);
begin
  if TReaderHack(Filer).FPropName <> '' then
    Filer.DefineProperty(TReaderHack(Filer).FPropName, FakeValue, nil, False);
  end;

procedure TElReader.FakeValue(Reader: TReader);
begin
  TElReader(Reader).SkipValue;
end;

procedure TElReader.FakeInteger(Reader: TReader);
begin
  Reader.ReadInteger;
end;

procedure TElReader.FakeBoolean(Reader: TReader);
begin
  Reader.ReadBoolean;
end;

procedure TElReader.FakeStr(Reader: TReader);
begin
  Reader.ReadStr;
end;

procedure TElReader.FakeIdent(Reader: TReader);
begin
  Reader.ReadIdent;
end;

procedure TElReader.SkipValue;
begin
  inherited SkipValue;
end;

procedure ReadError(Ident: PResStringRec);
begin
  raise EReadError.CreateRes(Ident);
end;

type

  TPersistentProtected = class(TPersistent)
  end;

// Fixed read TPersistent complex property defined by means of DefineProperty
procedure TElReader.ReadPropertyFix(AInstance: TPersistent);
var
  I, J, L: Integer;
  Instance: TPersistent;
  PropInfo: PPropInfo;
  PropValue: TObject;
  PropPath: string;
  vTmpStr: string;
  procedure HandleException(E: Exception);
  var
    Name: string;
  begin
    Name := '';
    if AInstance is TComponent then
      Name := TComponent(AInstance).Name;
    if Name = '' then Name := AInstance.ClassName;
    raise EReadError.CreateResFmt(@SPropertyException, [Name, DotSep, PropPath, E.Message]);
    end;

  procedure PropPathError;
  begin
    SkipValue;
    ReadError(@SInvalidPropertyPath);
    end;

begin
  with TReaderHack(Self) do
  begin
  try
    PropPath := ReadStr;
    try
      I := 1;
      L := Length(PropPath);
      Instance := AInstance;
      FCanHandleExcepts := True;
      while True do
      begin
        J := I;
        while (I <= L) and (PropPath[I] <> '.') do Inc(I);
        FPropName := Copy(PropPath, J, I - J);
        if I > L then
          Break;
        PropInfo := GetPropInfo(Instance.ClassInfo, FPropName);
        if PropInfo = nil then
        //PropertyError(FPropName); // OLD CODE
        {+} // NEW CODE
        begin
          vTmpStr := FPropName;
          FPropName := PropPath;
          FCanHandleExcepts := False;
          TPersistentProtected(Instance).DefineProperties(Self);
          FCanHandleExcepts := True;
          if FPropName <> '' then
          begin
            FPropName := vTmpStr;
            FCanHandleExcepts := False;
            TPersistentProtected(Instance).DefineProperties(Self);
            FCanHandleExcepts := True;
            if FPropName <> '' then
            PropertyError(FPropName);
              end;
          exit;
        end;
        {+.}
        PropValue := nil;
        if PropInfo.PropType^.Kind = tkClass then
          PropValue := TObject(GetOrdProp(Instance, PropInfo));
        if not (PropValue is TPersistent) then
          PropPathError;
        Instance := TPersistent(PropValue);
        Inc(I);
      end;
      PropInfo := GetPropInfo(Instance.ClassInfo, PropName);
      if PropInfo <> nil then ReadPropValue(Instance, PropInfo) else
      begin
        { Cannot reliably recover from an error in a defined property }
        FCanHandleExcepts := False;
        TPersistentProtected(Instance).DefineProperties(Self);
        FCanHandleExcepts := True;
        if FPropName <> '' then
        PropertyError(FPropName);
          end;
    except
      on E: Exception do HandleException(E);
    end;
  except
    on E: Exception do
      if not (FCanHandleExcepts) or not Error(E.Message) then
      raise E;
  end;
  end;
end;
//var
//  fReader_ReadProperty_Inst :TJumpInstruction;

{> VCL DFM UTILS}

function DWordToStr(Value: DWORD): String;
const
  sFormat: String = '%u';
begin
  Result := Format(sFormat, [Value]);
end;

function IsAnyBitsInOwnerDrawState(const State: TOwnerDrawState; const Bits: Word): Boolean;
var
  W: Word absolute State;
begin
  Result := (W and Bits) <> 0;
  end;

{procedure IncludeBitsToOnerDrawState(var State: TOwnerDrawState; const Bits: Word);
var
  W: Word absolute State;
begin
  W := W or Bits;
end;}

function GetScrollBarPos( hWnd: THandle; BarFlag:Integer ):Integer;
var
  SI: TScrollInfo;
begin
  SI.cbSize := SizeOf(SI);
  SI.fMask := SIF_POS;
  if GetScrollInfo(hWnd, BarFlag, SI) then
    Result := SI.nPos
  else
    Result := -1;
end;

function FindWinCallBack(WinHandle: HWND; Param: LParam): boolean; stdcall;
begin
  SendMessage(WinHandle, EL_SETTINGCHANGE, SPI_SETNONCLIENTMETRICS, 0);
  EnumChildWindows(WinHandle, @FindWinCallback, 0);
  result := true;
end;

type
  TLMDSettingChangeNotify = class
    function SettingChangeWndProc(var Message: TMessage): boolean;
  end;

function TLMDSettingChangeNotify.SettingChangeWndProc(var Message: TMessage): boolean;
begin
  if (Message.Msg = WM_SETTINGCHANGE) and (Message.wParam = SPI_SETNONCLIENTMETRICS) then
  begin
    EnumThreadWindows(GetCurrentThreadId, @FindWinCallBack, 0);
  end;
  Result := false;
end;

function ElFileOpen(const FileName: TLMDString; Mode: LongWord): Integer;
const
  AccessMode: array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
{$ifdef LMD_UNICODE}
var
  FileNameA: String;
{$endif}
begin
  Result := -1;
  if ((Mode and 3) <= fmOpenReadWrite) and
    (((Mode and $F0) shr 4) <= fmShareDenyNone) then
    {$ifdef LMD_UNICODE}
    begin
      if LMDSIWindowsNTUp then
        Result := Integer(CreateFileW(PWideChar(FileName), AccessMode[Mode and 3],
                                      ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING,
                                      FILE_ATTRIBUTE_NORMAL, 0))
        else
      begin
        FileNameA := FileName;
        Result := Integer(Windows.CreateFile(Int_Ref(FileNameA), AccessMode[Mode and 3],
                                       ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING,
                                       FILE_ATTRIBUTE_NORMAL, 0))
      end;
    end;
//    Result := Integer(CreateFileW(PWideChar(FileName), AccessMode[Mode and 3],
    {$else}
    Result := Integer(Windows.CreateFile(PChar(FileName), AccessMode[Mode and 3],
      ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING,
      FILE_ATTRIBUTE_NORMAL, 0));
    {$endif}
end;

function ElFileCreate(const FileName: TLMDString): Integer;
{$ifdef LMD_UNICODE}
var
  FileNameA: String;
{$endif}
begin
  {$ifdef LMD_UNICODE}
    if LMDSIWindowsNTUp then
      Result := Integer(CreateFileW(PWideChar(FileName), GENERIC_READ or GENERIC_WRITE,
                        0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0))
    else
    begin
      FileNameA := FileName;
      Result := Integer(Windows.CreateFile(Int_Ref(FileNameA), GENERIC_READ or GENERIC_WRITE,
                        0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
    end;
//  Result := Integer(CreateFileW(PWideChar(FileName), GENERIC_READ or GENERIC_WRITE,
  {$else}
  Result := Integer(Windows.CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE,
    0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
  {$endif}
end;

{ TElDisplayOptions }

procedure TElDisplayOptions.Assign(Source: TPersistent);
begin
  if (Source is TElDisplayOptions) then
  begin
    FBkColor := (Source as TElDisplayOptions).BkColor;
    FTextColor := (Source as TElDisplayOptions).TextColor;
    FEnabled := (Source as TElDisplayOptions).Enabled;
    Changed;
  end
  else
    inherited;
end;

procedure TElDisplayOptions.Changed;
begin
  TriggerOnChange;
end;

constructor TElDisplayOptions.Create;
begin
  inherited Create;
  FBkColor := clWindow;
  FTextColor := clWindowText;
end;

procedure TElDisplayOptions.SetBkColor(const Value: TColor);
begin
  if FBkColor <> Value then
  begin
    FBkColor := Value;
    Changed;
  end;
end;

procedure TElDisplayOptions.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TElDisplayOptions.SetTextColor(const Value: TColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    Changed;
  end;
end;

procedure TElDisplayOptions.TriggerOnChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

var
  SettingChanger: TLMDSettingChangeNotify;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.Inc}
initialization
  {$I C1.INC}
{$ELSE}
initialization
{$ENDIF}
  SettingChanger := TLMDSettingChangeNotify.Create;
  ParentControlRepaintedMessage := WM_USER + 7;
  Application.HookMainWindow(SettingChanger.SettingChangeWndProc);
  //SimpleAppFinallize := not IsLibrary;

finalization
  Application.UnHookMainWindow(SettingChanger.SettingChangeWndProc);
  FreeAndNil(SettingChanger);
  fElReader.Free; fElReader := nil;
  fStream.Free; fStream := nil;

end.
