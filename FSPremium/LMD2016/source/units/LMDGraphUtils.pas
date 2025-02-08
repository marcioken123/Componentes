unit LMDGraphUtils;
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

LMDGraphUtils unit
------------------


Changes
-------
Release 8.0 (January 2007)
 - Initial Release

###############################################################################}

interface

uses
  // this must be included before other units
  Windows, Graphics, Classes, Types, Math, Forms, Controls,
  LMDTypes, LMDRTLXConst, LMDThemes, LMDClass, LMDBmp, LMDUnicode, LMDGraph, LMDSysIn, LMDFXCaption,
  LMD3DCaption, LMDButtonLayout, LMDGradient, LMDGlyphTextLayout, LMDButtonBase;

const
  //<---  from LMDUtils
  DSF_CLIPRECT=$1;
  {2}
  DSF_USEOFFSCREENBITMAP=$4;

  DSF_CENTER=$8;
  DSF_STRETCH=$10;
  DSF_TILE=$20;

  DSF_TRANSPARENCY=$40;
  DSF_BRUSHCOPY=$80;
  DSF_TRANSPARENCY_MASK=$100;

  DSF_KEEPWIDTH=$200;
  DSF_KEEPHEIGHT=$400;
  {800, 2000, 4000, 8000}

  DSF_PALETTEREALIZE=$1000;

  DSF_KEEPRATIO=DSF_KEEPWIDTH + DSF_KEEPHEIGHT;
  DSF_STRETCHKEEPHEIGHT=DSF_STRETCH+DSF_KEEPHEIGHT;
  DSF_STRETCHKEEPWIDTH=DSF_STRETCH+DSF_KEEPWIDTH;
  DSF_STRETCHKEEPRATIO=DSF_STRETCH+DSF_KEEPRATIO;
  //<--- from ElVclUtils ---
  ROP_DSPDxax = $00E20746;
  DT_LMDCUSTOMDRAW = $10000000;
// <--- from LMD Elpack
  {$IFNDEF LMDCOMP7}
  {$EXTERNALSYM WM_NCMOUSELEAVE}
  WM_NCMOUSELEAVE = $02A2;
  {$ENDIF}

  scWin = $9000;

  MinDistForAntiAliasing = 0;
  MaxDistForAntiAliasing = 255;

  type
  TAlphaBlend = function (DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;
  TTransparentBlt = function (DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: UINT): BOOL; stdcall;
  type
  TLMDArrowDir = (eadLeft, eadUp, eadRight, eadDown);
  type
  TLMDARGBColor = longword;

function LMDPoint(x, y: integer): TPoint;
function  LMDAlphaBlend(DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;
function  LMDTransparentBlt(DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: UINT): BOOL; stdcall;
// --->


// <-- from ELVCLUtils
procedure LMDCheckHLSRange(var hls: integer);
function LMDColorDarker(const OriginalColor: TColor; const Percent: Byte): TColor;
function LMDColorLighter(const Color: TColor; const Percent: Byte): TColor;
function LMDIncColor(const Color: TColor; RInc, GInc, BInc: integer): integer;
function LMDHLStoRGB(hlsc: integer): integer;
function LMDRGBtoHLS(rgbc: integer): integer;

// HSB utilities
function LMDRGBToHSB(rgbc: integer): integer;
function LMDExtTextOut(const ACanvas: TCanvas; X, Y, Options: Integer; Rect: PRect; Str: TLMDString; Count: Integer): Boolean;

//-->
// <-- from ElExtBkgnd
procedure LMDExtDrawBkgnd2(DC : HDC; R, DocRect : TRect; Origin : TPoint; FillColor : TColor;
          SourceBitmap : Graphics.TBitmap; DrawMode : TLMDBackgroundType);

procedure LMDExtDrawBkgnd(DC : HDC; RectDoc, RectWindow, RectDC, RectOnDC : TRect;
  InvertedMode : boolean; FillColor, OverColor : TColor;
  SourceBitmap : Graphics.TBitmap; DrawMode : TLMDBackgroundType);

//-->

function LMDGetTextMetrics(DC: HDC; var TM: TLMDTextMetric): Boolean;

procedure LMDSetGrayscaleDisabled(const FOriginal: TBitmap);
procedure LMDSetDisabled(FOriginal : TBitmap);
//<--- from ElGraphics
type
  TColorRGB = packed record
    R, G, B, A: Byte;
  end;
  PColorRGB = ^TColorRGB;

  // for 32bit bitmaps
  PColorBGRA = ^TColorBGRA;
  TColorBGRA = packed record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
    Alpha: Byte;
  end;

procedure LMDDrawSmoothLine(ABitmap: TBitmap; AX1: Integer; AY1: Integer; AX2: Integer; AY2: Integer; AColor: TColor);
function LMDAlphaPixel(ASrcColor, ADstColor: TColor; AAlphaLevel: Double): TColor;
//-->
//<--- from ElVclUtils ---
procedure LMDAlphaFillRect(Canvas: TCanvas; ARect: TRect; Color: TColor; AlphaLevel: byte); overload;
procedure LMDAlphaFillRect(ADC: THandle; ARect: TRect; Color: TColor; AlphaLevel: byte); overload;

procedure LMDAlphaCopyRect(DestDC: HDC; Dest: TRect; SourceDC: HDC; Source: TRect;
  AlphaLevel: byte; UseAlphaLevel: boolean);
procedure LMDAlphaCopyRect2(DestDC: HDC; Dest: TRect; SourceDC: HDC;
  Source: TRect; Mask: TBitmap; AlphaLevel: byte {; UseAlphaLevel : boolean});
function LMDIsAlphaEmpty(bmp: TBitmap): boolean;

function LMDDrawTextW(hDC: HDC; lpString: PWideChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer;

function LMDDrawText(hDC: HDC; const lpString: TLMDString; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer;

procedure LMDDrawTypedTextW(Canvas: TCanvas; Bounds: TRect; const Text: WideString; Flags: integer; DrawType: TLMDTextDrawType);
procedure LMDDrawTypedText(Canvas: TCanvas; Bounds: TRect; const Text: string; Flags: integer; DrawType: TLMDTextDrawType);

procedure LMDDrawTransparentBitmapEx(DC: HDC; Bitmap: TBitmap; X, Y: integer; Src: TRect; Transparent: TColor);
procedure LMDDrawArrow(Canvas: TCanvas; Dir: TLMDArrowDir; R: TRect; Color: TColor; Enabled: boolean);

function LMDGetTextExtent(ACanvas: TCanvas; const AText: TLMDString): TSize;
function LMDGetTextHeight(ACanvas: TCanvas; const AText: TLMDString): Integer;
function LMDGetTextWidth (ACanvas: TCanvas; const AText: TLMDString): Integer;


procedure LMDDrawParentBackground(Wnd: HWnd; DC: HDC; ARect: PRect);


//<--- from LMDUtils ---
type
  // <-- from LMDUtils
  TLMDWhereRect = record
     CompleteRect,
     TextRect,
     GlyphRect,
     ArrowRect  : TRect;
  end;

{Standard frame routines}
// <-- from LMDUtils
function LMDDrawFrame3D(aCanvas:TCanvas;var dRect:TRect; Style: TLMDBevelStyle;
                        LightColor, ShadowColor:TColor; Depth: Integer):Boolean;
function LMDDrawFrameShadow(aCanvas:TCanvas; var aRect:TRect; LightColor, ShadowColor,
                            BorderColor:TColor; WidthOuter, WidthInner:TLMDBorderWidth;
                            Transparent:Boolean; flags:Word):Boolean;
function LMDDrawStdFrameExt(Style:TLMDBorderStyle):Integer;
function LMDDrawStdFrame(aCanvas:TCanvas; var aRect:TRect;
                         Style: TLMDBorderStyle; flags:Word):Boolean; overload;
function LMDDrawStdFrame(AHdc: HDC; var aRect:TRect;
                         Style: TLMDBorderStyle; flags:Word):Boolean; overload;
procedure LMDDrawBorder(aCanvas: TCanvas; aBounds: TRect; ULColor, LRColor: TColor);

function LMDGetCtrlBorderWidth(aCtl3D:Boolean; aBorderStyle:TBorderStyle; useXP:Boolean=false):Byte;

{Bitmaps}
// =============================================================================
procedure LMDBmpCreateFromRect(aValue:TBitmap; const aRect:TRect; fColor:TColor=clNone);
{3.0}
procedure LMDBmpCreateGrayscale(Dest, Src:TBitmap);
procedure LMDBmpCreateMasks(const srcBmp:TBitmap; Mask, NewImage:TBitmap;
                            MaskColor:TColor);
procedure LMDBmpCreateMasksExt(srcCanvas:TCanvas; srcRect:TRect; aMask,
                               NewImage:TBitmap; MaskColor:TColor);

procedure LMDBmpClipDraw(aCanvas:TCanvas; const aRect:TRect; aBitmap:TBitmap;
                         flags:WORD; pos:LongInt; MaskColor:TColor);
procedure LMDBmpClipDrawExt(aCanvas:TCanvas; const aRect:TRect; srcCanvas:TCanvas;
                            srcRect:TRect; flags:WORD; pos:LongInt; MaskColor:TColor; Add:TObject);

procedure LMDBmpDrawTransparent(ACanvas: TCanvas; X, Y: Integer; ABitmap: TBitmap; AClTransparent: TColor);

function  LMDBmpDraw(aCanvas:TCanvas; const aRect:TRect; aBitmap:TBitmap; flags:WORD;
                     TransColor:TColor):TRect;
function  LMDBmpDrawExt(aCanvas:TCanvas; const aRect:TRect; srcCanvas:TCanvas;
                        srcRect:TRect; flags:WORD; TransColor:TColor; pal:HPalette; Add:TObject):TRect;
{3.0}
procedure LMDBmpDrawDisabledState(DestBmp, SrcBmp:TBitmap; x,y: Integer);
procedure LMDBmpStretchDraw(aCanvas:TCanvas; const aRect:TRect; aBitmap:TBitmap);
procedure LMDCopyBmpSize(DestBmp,SrcBmp: TBitmap);
{3.02}
procedure LMDMaskBmpDraw(aCanvas: TCanvas; const aRect: TRect; aMask, Original: TBitmap;
                         MaskCol, TransCol: TColor);

{Fill routines}
procedure LMDFillPattern(hdc:HDC; const R:TRect; Pattern:TBitmap);
procedure LMDFillTexture(hdc:HDC; const R:TRect; bm:TBitmap; bmOffset:TPoint);
procedure LMDIcon2Bitmap(aIcon:TIcon; aBitmap:TBitmap; aColor:TColor);
procedure LMDBitmap2Icon (aBitmap : TBitmap; aIcon: TIcon; TransparentColor: TColor);

// from ElVClUtils
procedure LMDTiledPaint(Canvas: TCanvas; Bitmap: TBitmap; ARect: TRect); overload;
procedure LMDTiledPaint(ADC: HDC; Bitmap: TBitmap; ARect: TRect); overload;
procedure LMDFillSolidRect(DC: HDC; Rect: TRect; Color: TColor);overload;
procedure LMDFillSolidRect(DC: HDC; x, y, cx, cy: integer; Color: TColor);overload;
//-->

{3.0}
{LMDBmpFromDesktop:
 saves area aRect (in screen coordinates) from the desktop in
 bitmap aBitmap, size of the Bitmap will be adjusted automatically}
procedure LMDBmpFromDesktop(aBitmap:TBitmap; aRect:TRect);

{Gradient Drawing}
{------------------------------------------------------------------------------}
procedure LMDGradientCreateColorList(Color, EndColor:TColor;ColorCount:TLMDColorCount;
                                     ColorList:TList; Clear : Boolean);
function  LMDGradientCreatePalette(ColorList:TList):HPalette;
procedure LMDGradientPaintExt(aCanvas:TCanvas; aRect:TRect; gStyle:TLMDGradientStyle;
                           ColorList:TList; Palette:HPalette; flags:Word; pos:LongInt); overload;
procedure LMDGradientPaintExt(DC: HDC; aRect:TRect; gStyle:TLMDGradientStyle;
                           ColorList:TList; Palette:HPalette; flags:Word; pos:LongInt); overload;
procedure LMDGradientPaint(aCanvas:TCanvas; aRect:TRect; Color, EndColor:TColor;
                           ColorCount:TLMDColorCount; gStyle:TLMDGradientStyle;
                           flags:Word; pos:LongInt); overload;
procedure LMDSuperGradientPaint(aCanvas:TCanvas; aRect:TRect; Color : array of TColor;
                           ColorCount:TLMDColorCount; gStyle:TLMDGradientStyle;
                           flags:Word; pos:LongInt);
function LMDGradientGetColor(Color, EndColor:TColor;CurrentStep, ColorCount:Integer):TColor;
// for easy compatibility with elpack
procedure LMDGradientPaint(DC : HDC; aRect:TRect; Color, EndColor:TColor;
                           ColorCount:TLMDColorCount; gStyle:TLMDGradientStyle;
                           flags:Word; pos:LongInt); overload;
function  LMDBackgroundIsGradient(BGType :TLMDBackgroundType): Boolean;

{Color and Fill Utils for Extended Gradient library}
{------------------------------------------------------------------------------}
function LMDGetRedValue(AColor: TColor):byte;
function LMDGetGreenValue(AColor: TColor):byte;
function LMDGetBlueValue(AColor: TColor):byte;
function LMDGetAlphaValue(AColor: TLMDARGBColor):byte;
function LMDGetColor(ARed, AGreen, ABlue: byte): TColor;
function LMDGetARGBColor(AAlpha, ARed, AGreen, ABlue: byte): TLMDARGBColor;
function LMDCalcProportion(bv, ev: byte; dist, pos: integer): Byte;
function LMDCalcProportionColor(bv, ev: TColor; dist, pos: byte): TColor;
function LMDFastIntDistance(x,y: integer): integer;


{Misc Routines}
function LMDAlignRect(Alignment:TLMDAlignment; srcRect, destRect:TRect):TRect;
function LMDAlignTextRect(Alignment:TLMDAlignment; const aString:String;
                          Effects:TLMD3DCaption; aRect:TRect;
                          Font:TFont; MultiLine, Accel:Boolean; flags:LongInt):TRect;
procedure LMDDrawTextExt(aCanvas:TCanvas; const aString:TLMDString;
                         Effects:TLMD3DCaption; aRect:TRect; flags:Longint;
                         Extflags:TLMDDrawTextStyles; NRect:PRect); overload;

procedure LMDDrawTextExt(aCanvas:TCanvas; const aString:TLMDString; Effects:TLMD3DCaption;
                         aRect:TRect; flags:Word); overload;

{3.0}
procedure LMDDrawTextAndGlyph(aCanvas: TCanvas; const aString:TLMDString; Effects:TLMD3DCaption;
                              aDest: TRect; aGlyph: TBitmap; aGlyphMask: TBitmap;
                              aLayout: TLMDGlyphTextLayout; MultiLine, Accel, Transparent:Boolean;
                              ExtFlags:TLMDDrawTextStyles; flags:LongInt);

function LMDDrawTextAndGlyphExt(
          aCanvas: TCanvas;
          const aString:TLMDString;
          Effects:TLMD3DCaption;     {Font must be already set!}
          aDest: TRect;
          srcCanvas: TCanvas;
          var srcRect:TRect;
          aMaskCanvas: TCanvas;
          TransColor:TColor;
          aLayout: TLMDGlyphTextLayout;
          MultiLine,
          Accel,
          Transparent:Boolean;
          ExtFlags:TLMDDrawTextStyles;
          flags:LongInt) : TLMDWhereRect;

procedure LMDDrawTextCalc(const aString:TLMDString; Effects:TLMD3DCaption; var aRect:TRect;
                          Font:TFont; MultiLine, Accel:Boolean; BExt:Integer; flags:LongInt);
procedure LMDDrawTextCalcExt(Canvas:TCanvas; const aString:TLMDString;
                          Effects:TLMD3DCaption; var aRect:TRect;
                          Font:TFont; MultiLine, Accel:Boolean; BExt:Integer;flags:LongInt);
{Buttons}
function LMDDrawBtnFaceExt(aControl: TWinControl; aCanvas:TCanvas; MouseIsOver: Boolean; var dRect:TRect;Style:TLMDUserButtonStyle;
                          State:TLMDButtonState; flags:Word; aColor: TColor; aTheme: TLMDThemeMode = ttmNative):Boolean;
function LMDDrawBtnFace (aCanvas:TCanvas; MouseIsOver: Boolean; var dRect:TRect;
                        Style:TLMDUserButtonStyle; State:TLMDButtonState;
                        flags:Word; aColor: TColor):Boolean;
//6.0
function LMDDrawBtnIsFlat(Style:TLMDUserButtonStyle):Boolean;
// <--- from ElVCLUtils
procedure LMDDrawButtonFrame(DC: HDC; rc: TRect; Focused: boolean; Pushed: boolean;
                             ButtonColor: TColor; Thin: boolean;
                             BorderSides: TLMDBorderSides); overload;

procedure LMDDrawButtonFrame(DC: HDC; rc: TRect; Focused: boolean; Pushed: boolean;
                             ButtonColor: TColor; Thin: boolean;
                             clrHighlight, clrDkShadow, clrFace, clrShadow: TColor;
                             BorderSides : TLMDBorderSides); overload;
// ---

{3.X}
function LMDGet3DTextWidth(const aString:String; Effects:TLMD3DCaption; aFont:TFont):Integer;
function LMDGet3DTextHeight(Effects:TLMD3DCaption; aFont:TFont):Integer;

// From Elpack Dialog - Average size of english latters
function LMDGetAveCharSize(Canvas: TCanvas): TPoint;

implementation

uses
  {$IFDEF LMDCOMP16}System.UITypes,{$ENDIF}
  Themes, SysUtils, Messages,
  LMDProcs, LMDUtils;

// <--- from LMD BarPack
var
  AlphaBlendFunc : TAlphaBlend;
  TransparentBltFunc: TTransparentBlt;
  var
  hMSILib : THandle;


procedure LMDDrawParentBackground(Wnd: HWnd; DC: HDC; ARect: PRect);
var
  org: TPoint;
  PP: array[1..2] of TPoint;
  ParentWnd: HWnd;
  LRect, R: TRect;
  ClipRgn: HRGN;
  hasClipRgn : integer;
begin
  LRect := ARect^;
  ClipRgn := 0;
  hasClipRgn := -1;
  ParentWnd := GetParent(wnd);
  if(ARect <> nil) then
  begin
      R := LRect;
      pp[1] := R.TopLeft;
      pp[2] := R.BottomRight;
      MapWindowPoints(wnd, ParentWnd, pp, 2);
      R.TopLeft := pp[1];
      R.bottomright := pp[2];

      ClipRgn := CreateRectRgn(0,0,1,1);
      hasClipRgn := GetClipRgn(DC, ClipRgn);
      if(hasClipRgn <> -1) then
        IntersectClipRect(DC, LRect.left, LRect.top, LRect.right, LRect.bottom);
    end
  else
    GetClientRect(Wnd, R);

  OffsetViewportOrgEx(DC, -R.left, -R.top, @org);
  SendMessage(ParentWnd, WM_ERASEBKGND, WPARAM(DC), 0);
  SendMessage(ParentWnd, WM_PRINTCLIENT, WPARAM(DC), PRF_CLIENT);
  SetViewportOrgEx(DC, org.x, org.y, nil);

  if(ARect <> nil) then
  begin
      if(hasClipRgn = 0) then
        SelectClipRgn(DC, 0)
      else
        if(hasClipRgn = 1) then
          SelectClipRgn(DC, ClipRgn);
      DeleteObject(ClipRgn);
    end;
end;


function LMDReplaceTransparentBlt(DestDC: HDC; X: integer; Y: integer; W: integer; H: integer;
                                  SrcDC: HDC; SrcX: integer; SrcY: integer; SrcW: integer; SrcH: integer;
                                  TransparentColor: cardinal): Longbool;
var
  MonoDC: HDC;
  MonoBmp: HBitmap;
  SavedDestDC, SavedSrcDC, SavedMonoDC: integer;
begin
  try
    MonoDC := CreateCompatibleDC(DestDC);
    SavedDestDC := SaveDC(DestDC);
    SavedSrcDC := SaveDC(SrcDC);
    SavedMonoDC := SaveDC(MonoDC);
    SetBkColor(DestDC, RGB(255, 255, 255));
    SetTextColor(DestDC, RGB(0, 0, 0));
    SetBkColor(SrcDC, TransparentColor);
    MonoBmp := CreateBitmap(SrcW, SrcH, 1, 1, nil);
    MonoBmp := SelectObject(MonoDC, MonoBmp);
    BitBlt(MonoDC, 0, 0, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCCOPY);
    BitBlt(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCINVERT);
    BitBlt(DestDC, X, Y, SrcW, SrcH, MonoDC, 0, 0, SRCAND);
    BitBlt(DestDC, X, Y, SrcW, SrcH, SrcDC, SrcX, SrcY, SRCINVERT);
    MonoBmp := SelectObject(MonoDC, MonoBmp);
    RestoreDC(MonoDC, SavedMonoDC);
    DeleteDC(MonoDC);
    DeleteObject(MonoBmp);
    RestoreDC(SrcDC, SavedSrcDC);
    RestoreDC(DestDC, SavedDestDC);
    Result := True;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function  LMDAlphaBlend(DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;
begin
  if Assigned(AlphaBlendFunc) then
  Result := AlphaBlendFunc(DC,p2, p3, p4, p5,DC6,p7, p8, p9, p10,p11)
  else
    begin
      Result := BitBlt(DC,p2, p3, p4, p5,DC6,p7, p8,SRCCOPY);
    end;
end;

{------------------------------------------------------------------------------}
function  LMDTransparentBlt(DC: HDC; p2, p3, p4, p5: Integer; DC6: HDC; p7, p8, p9, p10: Integer; p11: UINT): BOOL; stdcall;
begin
  // 7.01 --> check for NT required: TransparentBlt function contains Resource leak on Win9X systems:
  // http://support.microsoft.com/?kbid=300555
  if Assigned(TransparentBltFunc) and (SysUtils.Win32PlatForm = VER_PLATFORM_WIN32_NT) then
  // ---
  Result := TransparentBltFunc(DC,p2, p3, p4, p5,DC6,p7, p8, p9, p10,p11)
  else
    begin
      // -> AH: Works, but flickers
      // DONE: 04.27.2004 (see LMDExplorerBar.pas, TLMDExplorerBarPanel.WMPaint method)
      Result := LMDReplaceTransparentBlt(DC,p2, p3, p4, p5,DC6,p7, p8, p9, p10,p11) //BitBlt(DC,p2, p3, p4, p5,DC6,p7, p8,SRCCOPY);
    end;
end;

{---- From ElVCLUtils, needed for LMDHTMLRender ----}
{------------------------------------------------------------------------------}
const
  //<--- from ElVclUtils ---
  hlsMax = 252; // H, L, S vary over 0 - hlsMax; best if divisible by 6
  rgbMax = 255; // r, g, b vary over 0-rgbMax; must each fit in a byte

  hlsMaxD2 = hlsMax div 2;
  hlsMaxD3 = hlsMax div 3;
  hlsMaxD6 = hlsMax div 6;
  hlsMaxD12 = hlsMax div 12;
  hlsMaxM2D3 = hlsMax * 2 div 3;
  rgbMaxM2 = rgbMax * 2;
  undefined = (hlsMaxM2D3);

{------------------------------------------------------------------------------}
procedure LMDCheckHLSRange(var hls: integer);
begin
  if hls < 0 then
    inc(hls, hlsMax);
  if hls > hlsMax then
    dec(hls, hlsMax)
end;

{------------------------------------------------------------------------------}
function LMDColorLighter(const Color: TColor; const Percent: Byte): TColor;
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

{------------------------------------------------------------------------------}
function LMDColorDarker(const OriginalColor: TColor; const Percent: Byte): TColor;
var
  R, G, B: Integer;
  WinColor: Integer;
  InOnePercent: single;
begin
  WinColor := ColorToRGB(OriginalColor);
  R := GetRValue(WinColor);
  G := GetGValue(WinColor);
  B := GetBValue(WinColor);

{  R := MulDiv(R, Percent, 100);
  G := MulDiv(G, Percent, 100);
  B := MulDiv(B, Percent, 100);}
  // from elcolors.pas
  InOnePercent := Percent / 100;
  Dec(R, Round((255 - R) * InOnePercent));
  Dec(G, Round((255 - G) * InOnePercent));
  Dec(B, Round((255 - B) * InOnePercent));

  if R < 0 then R := 0;
  if G < 0 then G := 0;
  if B < 0 then B := 0;

  Result := RGB(R, G, B);
end;

function LMDIncColor(const Color: TColor; RInc, GInc, BInc: integer): integer;
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

{------------------------------------------------------------------------------}
procedure LMDExtDrawBkgnd2(DC : HDC; R, DocRect : TRect; Origin : TPoint; FillColor : TColor;
          SourceBitmap : Graphics.TBitmap; DrawMode : TLMDBackgroundType);

var CurRect,
    DstRect,
    SrcRect,
    RealRect : TRect;
    i, j, k,
    l, n,
    sw, sh   : integer;
    HelpBmp  : TBitmap;
    aSaveDC  : integer;
begin
  if DrawMode = bgtColorFill then
  begin
    LMDFillSolidRect(DC, R, ColorToRGB(FillColor));
    exit;
  end;
  RealRect := R;
  OffsetRect(RealRect, Origin.X, Origin.Y);
  if (RealRect.Bottom > DocRect.Bottom) or
     (RealRect.Top < DocRect.Top) or
     (RealRect.Right > DocRect.Right) or
     (RealRect.Left < DocRect.Left) then
  begin
    LMDFillSolidRect(DC, R, ColorToRGB(FillColor));
  end;
  case DrawMode of
    bgtTileBitmap:
      begin
        sw := SourceBitmap.Width;
        sh := SourceBitmap.Height;
        i := 0;
        while i + sh < RealRect.Top do
          inc(i, sh);
        j := 0;
        while j + sw < RealRect.Left do
          inc(j, sw);
        k := j;
        while i < RealRect.Bottom do
        begin
          while j < RealRect.Right do
          begin
            // get visible area of the tiled bitmap
            SrcRect := Rect(j, i, j + sw, i + sh);
            IntersectRect(DstRect, SrcRect, RealRect);
            // get the portion of the bitmap to be copied
            l := DstRect.Left mod sw;
            n := DstRect.Top mod sh;
            //SrcRect := Rect(l, n, l + DstRect.Right - DstRect.Left, n + DstRect.Bottom - DstRect.Top);
            bitblt(DC, DstRect.Left - Origin.X,
                       DstRect.Top - Origin.Y,
                       DstRect.Right - DstRect.Left,
                       DstRect.Bottom - DstRect.Top,
                       SourceBitmap.Canvas.Handle,
                       l, n, SRCCOPY);
            inc(j, sw);
          end;
          j := k;
          inc(i, sh);
        end;
      end;
    bgtTopLeftBitmap,
    bgtCenterBitmap:
      begin
        // Center the bitmap
        if DrawMode = bgtCenterBitmap then
        begin
          LMDCenterRects(SourceBitmap.Width, DocRect.Right - DocRect.Left, SourceBitmap.Height, DocRect.Bottom - DocRect.Top, CurRect);
        end
        else
          CurRect := Rect(0, 0, SourceBitmap.Width, SourceBitmap.Height);

        OffsetRect(CurRect, DocRect.Left, DocRect.Top);
        // now get the target rectangle
        IntersectRect(DstRect, CurRect, RealRect);
        // now get the source rectangle
        SrcRect := DstRect;
        OffsetRect(SrcRect, - CurRect.Left, -CurRect.Top);
        l := SrcRect.Left;
        n := SrcRect.Top;
        bitblt(DC, DstRect.Left - Origin.X,
                   DstRect.Top - Origin.Y,
                   DstRect.Right - DstRect.Left,
                   DstRect.Bottom - DstRect.Top,
                   SourceBitmap.Canvas.Handle,
                   l, n, SRCCOPY);
        aSaveDC := SaveDC(DC);
        ExcludeClipRect(DC, DstRect.Left - Origin.X,
                            DstRect.Top - Origin.Y,
                            DstRect.Right - DstRect.Left,
                            DstRect.Bottom - DstRect.Top);
        LMDFillSolidRect(DC, RealRect, ColorToRGB(FillColor));
        RestoreDC(DC, aSaveDC);
        end;
    bgtStretchBitmap:
      begin
        HelpBmp := TBitmap.Create;
        try
          HelpBmp.Width := DocRect.Right - DocRect.Left;
          HelpBmp.Height := DocRect.Bottom - DocRect.Top;

          SetStretchBltMode(HelpBmp.Canvas.Handle, COLORONCOLOR);
          stretchblt(HelpBmp.Canvas.Handle, 0, 0, HelpBmp.Width, HelpBmp.Height,
                     SourceBitmap.Canvas.Handle, 0, 0, SourceBitmap.Width, SourceBitmap.Height, SRCCOPY);
          DstRect := RealRect;
          CurRect := Rect(0, 0, HelpBmp.Width, HelpBmp.Height);

          OffsetRect(CurRect, DocRect.Left, DocRect.Top);
          // now get the target rectangle
          IntersectRect(DstRect, CurRect, RealRect);
          // now get the source rectangle
          SrcRect := DstRect;
          OffsetRect(SrcRect, - CurRect.Left, -CurRect.Top);
          l := SrcRect.Left;
          n := SrcRect.Top;
          bitblt(DC, DstRect.Left - Origin.X,
                     DstRect.Top - Origin.Y,
                     DstRect.Right - DstRect.Left,
                     DstRect.Bottom - DstRect.Top,
                     HelpBmp.Canvas.Handle,
                     l, n, SRCCOPY);
          finally
          HelpBmp.Free;
        end;
      end;
  end;
end;
{------------------------------------------------------------------------------}
procedure LMDExtDrawBkgnd(DC : HDC; RectDoc, RectWindow, RectDC, RectOnDC : TRect;
  InvertedMode : boolean; FillColor, OverColor : TColor;
  SourceBitmap : Graphics.TBitmap; DrawMode : TLMDBackgroundType);

var
  DestRect : TRect;
  SrcRect : TRect;
  TmpRect : TRect;
  BltMode : Integer;
  HelpBmp : TBitmap;
  sw, sh : integer;
  CurRect : TRect;
  CurLeft,
    CurTop : integer;
  //TempDC : HDC;

begin
  TmpRect := RectOnDC;
  if (DrawMode = bgtColorFill) or (SourceBitmap.Empty and (DrawMode in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap, bgtTopLeftBitmap])) then
  begin
    LMDFillSolidRect(DC, TmpRect, ColorToRGB(FillColor));
    exit;
  end;
  case DrawMode of
    bgtTileBitmap :
      begin
        OffsetRect(TmpRect, -RectDC.Left, -RectDC.Top);
        CurLeft := RectWindow.Left + RectDoc.Left;
        CurTop := RectWindow.Top + RectDoc.Top;
        sw := SourceBitmap.Width;
        sh := SourceBitmap.Height;
        CurRect := Rect(CurLeft - RectDoc.Left, CurTop - RectDoc.Top, CurLeft + sw - RectDoc.Left, CurTop + sh - RectDoc.Top);
        while CurRect.Bottom <= TmpRect.Top do
        begin
          inc(CurTop, sh);
          CurRect := Rect(CurLeft - RectDoc.Left, CurTop - RectDoc.Top, CurLeft + sw - RectDoc.Left, CurTop + sh - RectDoc.Top);
        end;
        while CurTop < TmpRect.Bottom do
        begin
          while CurLeft < TmpRect.Right do
          begin
            SrcRect := Rect(CurLeft, CurTop, CurLeft + sw, CurTop + sh);
            IntersectRect(DestRect, TmpRect, SrcRect);
            if not IsRectEmpty(DestRect) then
            begin
              SrcRect := DestRect;
              OffsetRect(SrcRect, -CurLeft, -CurTop);

              OffsetRect(DestRect, -RectDC.Left, -RectDC.Top);

              if InvertedMode then
                BltMode := SRCINVERT
              else
                BltMode := SRCCOPY;
              begin
                bitblt(DC,
                  DestRect.Left, DestRect.Top,
                  DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top,
                  SourceBitmap.Canvas.Handle,
                  SrcRect.Left, SrcRect.Top, BltMode);
                end;
            end;
            CurLeft := CurLeft + SourceBitmap.Width;
          end;
          CurLeft := RectWindow.Left + RectDoc.Left;
          CurTop := CurTop + SourceBitmap.Height;
        end;
      end;
    bgtTopLeftBitmap,
    bgtCenterBitmap :
      begin
        LMDFillSolidRect(DC, TmpRect, ColorToRGB(FillColor));
        OffsetRect(TmpRect, -RectDC.Left, -RectDC.Top);

        if DrawMode = bgtCenterBitmap then
        begin
          LMDCenterRects(SourceBitmap.Width, RectWindow.Right - RectWindow.Left,
            SourceBitmap.Height, RectWindow.Bottom - RectWindow.Top, SrcRect);
        end
        else
          SrcRect := Rect(0, 0, SourceBitmap.Width, SourceBitmap.Height);

        OffsetRect(SrcRect, RectWindow.Left, RectWindow.Top);

        IntersectRect(TmpRect, TmpRect, SrcRect);
        if not IsRectEmpty(TmpRect) then
        begin
          DestRect := TmpRect;
          OffsetRect(DestRect, -SrcRect.Left, -SrcRect.Top);
          SrcRect := DestRect;

          DestRect := TmpRect;
          OffsetRect(DestRect, -RectDC.Left, -RectDC.Top);

          if InvertedMode then
            BltMode := SRCINVERT
          else
            BltMode := SRCCOPY;
          begin
            bitblt(DC,
              DestRect.Left, DestRect.Top,
              DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top,
              SourceBitmap.Canvas.Handle,
              SrcRect.Left, SrcRect.Top, BltMode);
            end;
        end;
      end;
    bgtStretchBitmap :
      begin
        OffsetRect(TmpRect, -RectDC.Left, -RectDC.Top);
        HelpBmp := TBitmap.Create;
        HelpBmp.Width := RectWindow.Right - RectWindow.Left;
        HelpBmp.Height := RectWindow.Bottom - rectWindow.Top;
        SetStretchBltMode(HelpBmp.Canvas.Handle, COLORONCOLOR);
        stretchblt(HelpBmp.Canvas.Handle, 0, 0, HelpBmp.Width, HelpBmp.Height,
          SourceBitmap.Canvas.Handle, 0, 0, SourceBitmap.Width, SourceBitmap.Height, SRCCOPY);
        SrcRect := RectWindow;
        IntersectRect(TmpRect, TmpRect, SrcRect);
        if not IsRectEmpty(TmpRect) then
        begin
          SrcRect := TmpRect;
          OffsetRect(SrcRect, -RectWindow.Left, -RectWindow.Top);
          DestRect := TmpRect;
          OffsetRect(DestRect, -RectDC.Left, -RectDC.Top);
          if InvertedMode then
            BltMode := SRCINVERT
          else
            BltMode := SRCCOPY;
          begin
            bitblt(DC,
              DestRect.Left, DestRect.Top,
              DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top,
              HelpBmp.Canvas.Handle,
              SrcRect.Left, SrcRect.Top, BltMode);
            end;
          HelpBmp.Free;
        end;

      end;
  end;
end;

{------------------------------------------------------------------------------}
function LMDExtTextOut(const ACanvas: TCanvas; X, Y, Options: Integer; Rect: PRect; Str: TLMDString; Count: Integer): Boolean;
begin
  {$ifdef LMD_UNICODE}
  Result := ExtTextOutW(ACanvas.Handle, X, Y, Options, Rect, PWideChar(Str), Count, nil);
  {$else}
  Result := ExtTextOutA(ACanvas.Handle, X, Y, Options, Rect, PChar(Str), Count, nil);
  {$endif}
end;

{------------------------------------------------------------------------------}
function LMDRGBtoHLS(rgbc: integer): integer;
var
  r, g, b, h, l, s, cMax, cMin,
    cDiff, cSum: integer;
  rD, gD, bD : single;
begin
  r := getRValue(rgbc);
  g := getGValue(rgbc);
  b := getBValue(rgbc);
  cMax := max(max(r, g), b);
  cMin := min(min(r, g), b);

  l := round((((cMax + cMin) * hlsMax) + rgbMax) / (2* rgbMax));
//  l := (((cMax + cMin) * hlsMax) + rgbMax) div (rgbMaxM2);

  if cMax = cMin then
    begin
      s := 0;
      h := undefined
    end
  else
    begin
      cDiff := cMax - cMin;
      cSum := cMax + cMin;
      if l <= (hlsMax / 2) then
        s := round((cDiff * hlsMax + cSum/2) / cSum)
      else
        s := round((cDiff * hlsMax + (rgbMaxM2 - cSum) / 2) / (rgbMaxM2 - cSum));
      rD := ((cMax - r) * hlsMax/6 + cDiff/2)/cDiff;
      gD := ((cMax - g) * hlsMax/6 + cDiff/2)/cDiff;
      bD := ((cMax - b) * hlsMax/6 + cDiff/2)/cDiff;
      if r = cMax then
        h := round(bD - gD)
      else
        if g = cMax then
        h := round(hlsMax/3 + rD - bD)
      else
        h :=round( 2*hlsMax/3 + gD - rD);
      LMDCheckHLSRange(h);
    end;

  result := rgb(h, l, s);
end;

{------------------------------------------------------------------------------}
function LMDHLStoRGB(hlsc: integer): integer;
var
  h, l, s, r, g, b, magic1, magic2: integer;

  function hueToRGB(n1, n2, hue: integer): integer;
  begin
    LMDCheckHLSRange(hue);
    if hue < hlsMaxD6 then
      result := n1 + ((n2 - n1) * hue + hlsMaxD12) div hlsMaxD6
    else
      if hue < hlsMaxD2 then
      result := n2
    else
      if hue < hlsMaxM2D3 then
      result := n1 + ((n2 - n1) * (hlsMaxM2D3 - hue) + hlsMaxD12) div hlsMaxD6
    else
      result := n1
  end;

begin
  h := getRValue(hlsc);
  l := getGValue(hlsc);
  s := getBValue(hlsc);
  if s = 0 then
  begin
    r := l * rgbMax div hlsMax;
    g := r;
    b := r;
    if h <> undefined then
      raise Exception.Create(SHLSToRGBConvertError);
  end
  else
  begin
    if l <= hlsMaxD2 then
      magic2 := (l * (hlsMax + s) + hlsMaxD2) div hlsMax
    else
      magic2 := l + s - (l * s + hlsMaxD2) div hlsMax;
    magic1 := 2 * l - magic2;
    r := Max(0, Min(255, (hueToRGB(magic1, magic2, h + hlsMaxD3) * rgbMax +
      hlsMaxD2) div hlsMax));
    g := Max(0, Min(255, (hueToRGB(magic1, magic2, h) * rgbMax + hlsMaxD2) div
      hlsMax));
    b := Max(0, Min(255, (hueToRGB(magic1, magic2, h - hlsMaxD3) * rgbMax +
      hlsMaxD2) div hlsMax));
  end;
  result := rgb(r, g, b)
end;

{------------------------------------------------------------------------------}
function LMDRGBToHSB(rgbc: integer): integer;
var
  LMinRGB, LMaxRGB, delta : double;
  LHue, LSaturation, LBrightness : Integer;
  LRed: Integer;
  LGreen: Integer;
  LBlue: Integer;
begin
  LHue := 0;
  LRed := GetRValue(rgbc);
  LGreen := GetGValue(rgbc);
  LBlue := GetBValue(rgbc);
  LMinRGB := min(min(LRed, LGreen), LBlue);
  LMaxRGB := max(max(LRed, LGreen), LBlue);
  delta := (LMaxRGB - LMinRGB) ;
  LBrightness := Round(LMaxRGB * 0.392);

  if (LMaxRGB = 0) then
    LSaturation := 0
  else
    LSaturation := Round((1 - (LMinRGB / LMaxRGB)) * 100);

  if (LSaturation <> 0) then
  begin
    if (LRed = LMaxRGB) then
      LHue := Round(60 * (LGreen - LBlue) / delta)
    else if LGreen = LMaxRGB then
      LHue := Round(60 * (LBlue - LRed) / delta + 120)
    else if LBlue = LMaxRGB then
      LHue := Round(60 * (LRed - LGreen) / delta + 240);
  end
  else
    LHue := 0;

  if LHue < 0 then
    LHue := LHue + 360;

  Result := RGB(LHue, LSaturation, LBrightness);
end;

{------------------------------------------------------------------------------}
procedure LMDSetDisabled(FOriginal: TBitmap);
var
  MonoBmp: TBitmap;
  SrcDC,
  DestDC: HDC;

begin
  MonoBmp := TBitmap.Create;
  with MonoBmp do
  begin
    Width := FOriginal.Width;
    Height := FOriginal.Height;
    Monochrome := True;
  end;
  SrcDC := MonoBmp.Canvas.Handle;

  monoBmp.Canvas.CopyRect(Rect(0, 0, FOriginal.Width, FOriginal.Height), FOriginal.Canvas, Rect(0, 0, FOriginal.Width, FOriginal.Height));
  //BitBlt(SrcDC, 0, 0, FOriginal.Width, FOriginal.Height, FOriginal.Canvas.Handle, 0, 0, SRCCOPY);

  FOriginal.Canvas.Brush.Color := cl3DDkShadow;
  FOriginal.Canvas.FillRect(Rect(0, 0, FOriginal.Width, FOriginal.Height));

  { Convert Black to clBtnHighlight }
  FOriginal.Canvas.Brush.Color := clBtnHighlight;
  DestDC := FOriginal.Canvas.Handle;

  Windows.SetTextColor(DestDC, clWhite);
  Windows.SetBkColor(DestDC, clBlack);

  BitBlt(DestDC, 1, 1, FOriginal.Width - 1, FOriginal.Height - 1, SrcDC, 0, 0, ROP_DSPDxax);

  { Convert Black to clBtnShadow }

  FOriginal.Canvas.Brush.Color := clBtnShadow;
  DestDC := FOriginal.Canvas.Handle;

  Windows.SetTextColor(DestDC, clWhite);
  Windows.SetBkColor(DestDC, clBlack);

  BitBlt(DestDC, 0, 0, FOriginal.Width, FOriginal.Height, SrcDC, 0, 0, ROP_DSPDxax);

  MonoBmp.Free;
end;

{------------------------------------------------------------------------------}
type
  // for 32bit bitmaps
  PLMDColorBGRA = ^TLMDColorBGRA;
  TLMDColorBGRA = packed record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
    Alpha: Byte;
  end;
  procedure LMDSetGrayscaleDisabled(const FOriginal: TBitmap);

var
  Pixel: PLMDColorBGRA;
  Gray: Byte;
  x, y: Integer;

begin
  FOriginal.PixelFormat := pf32Bit;
  for Y := 0 to (FOriginal.Height - 1) do
  begin
    Pixel := FOriginal.ScanLine[Y];
    for X := 0 to (FOriginal.Width - 1) do
    begin
      Gray := Round(0.30 * Pixel.Red + 0.59 * Pixel.Green + 0.11 * Pixel.Blue);
      Pixel.Red := Gray;
      Pixel.Green := Gray;
      Pixel.Blue := Gray;
      Inc(Pixel);
    end;
  end;
  end;

{------------------------------------------------------------------------------}
procedure LMDAlphaCopyRect(DestDC: HDC; Dest: TRect; SourceDC: HDC; Source: TRect;
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
    dBits: PtrToPixel;
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
      dp := PInteger(dBits);
      inc(p, k);
      inc(dp, k);

      Color := P^;
      DstColor := DP^;
      if not UseAlphaLevel then
        AlphaLevel := Color shr 24;

//      P^ := ((((Color and $FF0000 shr 16) * AlphaLevel + (DstColor and $FF0000
//        shr 16) * (256 - AlphaLevel)) shl 8) and $FF0000) or
//        (((Color and $FF00 shr 8) * AlphaLevel + (DstColor and $FF00 shr 8) *
//        (256 - AlphaLevel)) and $00FF00) or
//        (((Color and $FF) * AlphaLevel + (DstColor and $FF) * (256 - AlphaLevel))
//        shr 8 and $FF);
      P^
      := ((((Color and $FF0000 shr 16) * AlphaLevel + (DstColor and $FF0000
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

{------------------------------------------------------------------------------}
procedure LMDAlphaFillRect(Canvas: TCanvas; ARect: TRect; Color: TColor; AlphaLevel: byte);
var
  BMP: TBitmap;
begin
  BMP := TBitmap.Create;
  BMp.Width := (ARect.Right - ARect.Left) + 1;
  BMp.Height := (ARect.Bottom - ARect.Top) + 1;
  BMP.Canvas.Brush.Color := Color;
  BMP.Canvas.FillRect(Rect(0, 0, BMP.Width, BMP.Height));
  LMDAlphaCopyRect(Canvas.Handle, ARect, BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), AlphaLevel, true);
  BMP.Free;
end;

{------------------------------------------------------------------------------}
procedure LMDAlphaFillRect(ADC: THandle; ARect: TRect; Color: TColor; AlphaLevel: byte);
var
  BMP: TBitmap;
begin
  BMP := TBitmap.Create;
  BMp.Width := (ARect.Right - ARect.Left) + 1;
  BMp.Height := (ARect.Bottom - ARect.Top) + 1;
  BMP.Canvas.Brush.Color := Color;
  BMP.Canvas.FillRect(Rect(0, 0, BMP.Width, BMP.Height));
  LMDAlphaCopyRect(ADC, ARect, BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), AlphaLevel, true);
  BMP.Free;
end;

{------------------------------------------------------------------------------}
procedure LMDAlphaCopyRect2(DestDC: HDC; Dest: TRect; SourceDC: HDC;
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
  mBits: pointer;
  p, dp, mp: PInteger;
  Alpha: byte;
  fAlpha: double;
  src, dst: TstCol;
  SCA: word;
  //<abb2014>
  msize : Cardinal;
  h_bm : HBITMAP;
  h_dc : HDC;
  //</abb2014>

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

  //<abb2014>
  msize := TmpBitmap.Width * TmpBitmap.Height * SizeOf(Integer);
  pBits := VirtualAlloc(nil, msize, MEM_COMMIT, PAGE_READWRITE);
  GetDIBits(DestDC, TmpBitmap.Handle, 0, TmpBitmap.Height, pBits, Info, DIB_RGB_COLORS);

  dBits := VirtualAlloc(nil, msize, MEM_COMMIT, PAGE_READWRITE);
  GetDIBits(DestDC, DstBitmap.Handle, 0, TmpBitmap.Height, dBits, Info, DIB_RGB_COLORS);

  mBits := VirtualAlloc(nil, msize, MEM_COMMIT, PAGE_READWRITE);
  GetDIBits(DestDC, MskBitmap.Handle, 0, MskBitmap.Height, mBits, Info, DIB_RGB_COLORS);
  //</abb2014>

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
  //<abb2014>
  h_bm := TmpBitmap.Handle;
  h_dc := TmpBitmap.Canvas.Handle;
  SetDIBits(h_dc, h_bm, 0, TmpBitmap.Height, pBits, Info, DIB_RGB_COLORS);
  //</abb2014>
  bitblt(DestDC, Dest.Left, Dest.Top, Dest.Right - Dest.Left, Dest.Bottom -
    Dest.Top, TmpBitmap.Canvas.Handle, 0, 0, srccopy);
  TmpBitmap.Free;
  DstBitmap.Free;
  MskBitmap.Free;
  //<abb2014>
  VirtualFree(dBits, msize, MEM_FREE);
  VirtualFree(pBits, msize, MEM_FREE);
  VirtualFree(mBits, msize, MEM_FREE);
  //</abb2014>
end;

{------------------------------------------------------------------------------}
function LMDIsAlphaEmpty(bmp: TBitmap): boolean;
var
  i: integer;
  dib: PtrToPixel;
  Info: TBitmapInfo;
begin
  Result := true;
  if bmp.PixelFormat <> pf32bit then
    exit;

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

  {$ifdef LMDX86}
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
  {$else}
  while (i > 0) do
  begin
    if (PInteger(TLMDPtrUInt(dib) + (i * 4))^ and $ff000000) > 0 then
      break;
    dec(i);
  end;
  {$endif}
  FreeMem(dib);
  Result := i = 0;
end;

{------------------------------------------------------------------------------}
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

{------------------------------------------------------------------------------}

function LMDDrawTextW(hDC: HDC; lpString: PWideChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer;
{
 Not implemented "uFormat" values:
   DT_EDITCONTROL
   DT_INTERNAL
   DT_NOFULLWIDTHCHARBREAK
}
const
  MAX_STATIC_BUFFER = $2000; // Windows 95/98/Me: This value may not exceed 8192.
  DT_PREFIXONLY = $00200000;

var
  STATIC_BUFFER_LEN: integer;
  TextExtentSize: TSize;
  StrPtr: PWideChar;

  Line: PWideChar;
  SwapStr: PWideChar;
  bMemAllocated: boolean; // flag for freeMem for Line and SwapStr.

  LineStat: array[0..MAX_STATIC_BUFFER - 1] of WideChar;
  SwapStat: array[0..MAX_STATIC_BUFFER - 1] of WideChar;

  Len: integer;
  lh: integer;
  count: integer;
  count1: integer;
  uFormat1: integer;
  prefix_x: integer;
  prefix_end: integer;
  TextMetric: TTextMetricA;
  x, y,
  Width,
  MaxWidth: integer;
  TabStop: integer;
  TabWidth,
  SpaceWidth,
  PrefixOffset: integer;
  FNameDelim: PWideChar;
  TotalLen: integer;
  FNameLen: integer;
  LastBkSlash: PWideChar;
  LastFwdSlash: PWideChar;
  APen: HPEN;
  OldPen: HPEN;
  ExtTextOutFlags: integer;
  strCopyUsed: boolean;

begin

  if LMDSIWindowsNT and (not ((uFormat and DT_LMDCUSTOMDRAW) = DT_LMDCUSTOMDRAW)) then
  begin
    Result := Windows.DrawTextW(hDC, lpString, nCount, lpRect, uFormat);
    exit;
  end
  else{}
  begin
    Len := nCount;
    if Len = -1 then
      Len := LMDWideStrLen(lpString);
    if Len < MAX_STATIC_BUFFER - 4 then
    begin
      strCopyUsed := false;
      bMemAllocated := true;
      Line := @LineStat;
      SwapStr := @SwapStat;
      STATIC_BUFFER_LEN := MAX_STATIC_BUFFER;
    end
    else
    begin
      strCopyUsed := false;
      if not LMDSIWindowsNT then
      begin
        strCopyUsed := true;
        GetMem(Line, (Len + 1) * SizeOf(WideChar));
        LMDWideStrLCopy(Line, lpString, Len);
        lpString := Line;
      end;
      bMemAllocated := false;
      STATIC_BUFFER_LEN := Len;
      GetMem(Line, (Len + 4) * SizeOf(WideChar));
      GetMem(SwapStr, (Len + 4) * SizeOf(WideChar));
    end;
    try
      count := nCount;
      prefix_x := 0;
      prefix_end := 0;
      x := lpRect.left;
      y := lpRect.top;
      MaxWidth := 0;

      if (lpString = nil) then
      begin
        Result := 0;
        exit;
      end;

      if (count = -1) then
        count := LMDWideStrLen(lpString);
      if (count = 0) then
      begin
        lpRect.Right := lpRect.Left;
        lpRect.Bottom := lpRect.Top;
        Result := 0;
        exit;
      end;

      if (uFormat and DT_CALCRECT) = DT_CALCRECT then
      begin
        if (lpRect.Right = 0) then
          lpRect.Right := 32767;
        if (lpRect.Bottom = 0) then
          lpRect.Bottom := 32767;
      end;

      width := lpRect.right - lpRect.left;

      StrPtr := lpString;

      GetTextMetricsA(hdc, TextMetric);
      if (uFormat and DT_EXTERNALLEADING) = DT_EXTERNALLEADING then
        lh := TextMetric.tmHeight + TextMetric.tmExternalLeading
      else
        lh := TextMetric.tmHeight;

      if (uFormat and DT_TABSTOP) = DT_TABSTOP then
        TabStop := uFormat shr 8
      else
        TabStop := 8;

      if (uFormat and DT_EXPANDTABS) = DT_EXPANDTABS then
      begin
        GetTextExtentPoint32W(hdc, WideChar(' '), 1, TextExtentSize);
        SpaceWidth := TextExtentSize.cx - TextMetric.tmOverhang;
        GetTextExtentPoint32W(hdc, WideChar('o'), 1, TextExtentSize);
        TabWidth := (TextExtentSize.cx - TextMetric.tmOverhang) * TabStop;
      end;

      if ((uFormat and DT_CALCRECT) = DT_CALCRECT) and
         (((uFormat and DT_SINGLELINE) = DT_SINGLELINE) or ((uFormat and DT_WORDBREAK) <> DT_WORDBREAK)) then
        uFormat := uFormat or DT_NOCLIP;

      repeat
        PrefixOffset := -1;
        Len := STATIC_BUFFER_LEN;
        StrPtr := NextLineW(hdc, StrPtr, count, Line, Len, width, uFormat,
          TabWidth, SpaceWidth, PrefixOffset, TextMetric.tmOverhang);

        if (PrefixOffset <> -1) then
        begin
          GetTextExtentPoint32W(hdc, Line, PrefixOffset, TextExtentSize);
          prefix_x := TextExtentSize.cx;
          GetTextExtentPoint32W(hdc, Line, PrefixOffset + 1, TextExtentSize);
          prefix_end := TextExtentSize.cx - 1;
        end;

        if (not GetTextExtentPoint32W(hdc, Line, Len, TextExtentSize)) then
        begin
          Result := 0;
          exit;
        end
        else
          inc(TextExtentSize.cx, TextMetric.tmOverhang);

        if ((uFormat and DT_CALCRECT) <> DT_CALCRECT) and (lpRect.left + lpRect.right > TextExtentSize.cx) then
        begin
          if (uFormat and DT_CENTER) = DT_CENTER then
          begin
            if lpRect.left + lpRect.right >= TextExtentSize.cx then
              x := max(lpRect.Left, (lpRect.left + lpRect.right - TextExtentSize.cx) shr 1)
            else
              x := max(lpRect.Left, (lpRect.left + lpRect.right - TextExtentSize.cx) div 2);
          end
          else
            if (uFormat and DT_RIGHT) = DT_RIGHT then
            x := max(lpRect.Left, lpRect.right - TextExtentSize.cx);
        end;

        if ((uFormat and DT_SINGLELINE) = DT_SINGLELINE) then
        begin

          if (uFormat and DT_CALCRECT) <> DT_CALCRECT then
          begin
            if (uFormat and DT_VCENTER) = DT_VCENTER then
              y := lpRect.top + (lpRect.bottom - lpRect.top) shr 1 - (TextExtentSize.cy shr 1 + TextExtentSize.cy mod 2)
            else
              if (uFormat and DT_BOTTOM) = DT_BOTTOM then
              y := lpRect.bottom - TextExtentSize.cy;
          end;

          if ((uFormat and (DT_PATH_ELLIPSIS or DT_END_ELLIPSIS or
            DT_WORD_ELLIPSIS)) <> 0) then
          begin
            // FNameDelim := nil;
            if nCount >= 0 then
              TotalLen := nCount
            else
              TotalLen := LMDWideStrLen(lpString);

            if (TextExtentSize.cx > width) then
            begin
              FNameLen := TotalLen;

              count := min(TotalLen + 3, STATIC_BUFFER_LEN - 3);

              if (uFormat and DT_WORD_ELLIPSIS) = DT_WORD_ELLIPSIS then
                uFormat := uFormat or DT_WORDBREAK;

              if (uFormat and DT_PATH_ELLIPSIS) = DT_PATH_ELLIPSIS then
              begin
                //LastBkSlash := nil;
                //LastFwdSlash := nil;

                LMDWideStrLCopy(Line, lpString, TotalLen);
                Line[TotalLen] := WideChar('0');

                LastBkSlash := LMDWideStrRScan(Line, WideChar('\'));
                LastFwdSlash := LMDWideStrRScan(Line, WideChar('/'));
                if Integer(LastBkSlash) > integer(LastFwdSlash) then
                  FNameDelim := LastBkSlash
                else
                  FNameDelim := LastFwdSlash;

                if (FNameDelim <> nil) then
                  FNameLen := @Line[TotalLen] - FNameDelim
                else
                  FNameDelim := lpString;

                LMDWideStrCopy(SwapStr, '...'#0);
                LMDWideStrLCopy(SwapStr + LMDWideStrLen(SwapStr), FNameDelim, FNameLen);
                SwapStr[FNameLen + 3] := WideChar(#0);
                LMDWideStrLCopy(SwapStr + LMDWideStrLen(SwapStr), lpString, TotalLen - FNameLen);
                SwapStr[TotalLen + 3] := WideChar(#0);
              end
              else (* DT_END_ELLIPSIS | DT_WORD_ELLIPSIS *)
              begin
                LMDWideStrCopy(SwapStr, '...'#0);
                LMDWideStrLCopy(SwapStr + LMDWideStrLen(SwapStr), lpString, TotalLen);
              end;

              Len := STATIC_BUFFER_LEN;
              NextLineW(hdc, SwapStr, count, Line, Len, width, uFormat,
                TabWidth, SpaceWidth, PrefixOffset, TextMetric.tmOverhang);

              (* if only the ELLIPSIS will fit, just let it be clipped *)
              Len := max(4, Len);
              GetTextExtentPoint32W(hdc, Line, Len, TextExtentSize);
              inc(TextExtentSize.cx, TextMetric.tmOverhang);
              (* FIXME:
               * NextLine uses GetTextExtentPoint for each character,
               * rather than GetCharABCWidth...  So the whitespace between
               * characters is ignored in the width measurement, and the
               * reported Len is too great.  To compensate, we must get
               * the width of the entire Line and adjust Len accordingly.
              *)
              while ((TextExtentSize.cx > width) and (Len > 3)) do
              begin
                dec(Len);
                Line[Len] := WideChar(#0);
                GetTextExtentPoint32W(hdc, Line, Len, TextExtentSize);
                inc(TextExtentSize.cx, TextMetric.tmOverhang);
              end;

              if (FNameLen < Len - 3) then
              begin
                (* put the ELLIPSIS between the path and filename *)
                LMDWideStrLCopy(SwapStr, @Line[FNameLen + 3], Len - 3 - FNameLen);
                SwapStr[Len - 3 - FNameLen] := WideChar(#0);
                LMDWideStrCat(SwapStr, '...'#0);
                LMDWideStrLCopy(SwapStr + LMDWideStrLen(SwapStr), @Line[3], FNameLen);
              end
              else
              begin
                (* move the ELLIPSIS to the end *)
                LMDWideStrLCopy(SwapStr, @Line[3], Len - 3);
                SwapStr[Len - 3] := WideChar(#0);
                LMDWideStrCopy(SwapStr + LMDWideStrLen(SwapStr), '...'#0);
              end;

              LMDWideStrLCopy(Line, SwapStr, Len);
              Line[Len] := WideChar(#0);
              StrPtr := nil;
            end;
          end;
          if (uFormat and DT_MODIFYSTRING) = DT_MODIFYSTRING then
            LMDWideStrCopy(lpString, SwapStr);
        end
        else
        begin
          if ((uFormat and DT_CALCRECT) <> DT_CALCRECT) and (((uFormat and
            DT_WORD_ELLIPSIS) <> 0) or (((uFormat and DT_END_ELLIPSIS) <> 0) and
            (StrPtr = nil))) then
          begin
            // FNameDelim := nil;
            TotalLen := Len;

            if (TextExtentSize.cx > width) then
            begin
              FNameLen := TotalLen;

              count1 := min(TotalLen + 3, STATIC_BUFFER_LEN - 3);

              uformat1 := uFormat;
              if (uFormat1 and DT_WORD_ELLIPSIS) = DT_WORD_ELLIPSIS then
                uFormat1 := uFormat1 or DT_WORDBREAK;

              begin
                LMDWideStrCopy(SwapStr, '...'#0);
                LMDWideStrLCopy(SwapStr + LMDWideStrLen(SwapStr), Line, Len);
              end;

              Len := STATIC_BUFFER_LEN;
              NextLineW(hdc, SwapStr, count1, Line, Len, width, uFormat1,
                TabWidth, SpaceWidth, PrefixOffset, TextMetric.tmOverhang);

              (* if only the ELLIPSIS will fit, just let it be clipped *)
              Len := max(4, Len);
              GetTextExtentPoint32W(hdc, Line, Len, TextExtentSize);
              inc(TextExtentSize.cx, TextMetric.tmOverhang);
              (* FIXME:
               * NextLine uses GetTextExtentPoint for each character,
               * rather than GetCharABCWidth...  So the whitespace between
               * characters is ignored in the width measurement, and the
               * reported Len is too great.  To compensate, we must get
               * the width of the entire Line and adjust Len accordingly.
              *)
              while ((TextExtentSize.cx > width) and (Len > 3)) do
              begin
                dec(Len);
                Line[Len] := WideChar(#0);
                GetTextExtentPoint32W(hdc, Line, Len, TextExtentSize);
                inc(TextExtentSize.cx, TextMetric.tmOverhang);
              end;

              if (FNameLen < Len - 3) then
              begin
                (* put the ELLIPSIS between the path and filename *)
                LMDWideStrLCopy(SwapStr, @Line[FNameLen + 3], Len - 3 - FNameLen);
                SwapStr[Len - 3 - FNameLen] := WideChar(#0);
                LMDWideStrCat(SwapStr, '...'#0);
                LMDWideStrLCopy(SwapStr + LMDWideStrLen(SwapStr), @Line[3], FNameLen);
              end
              else
              begin
                (* move the ELLIPSIS to the end *)
                LMDWideStrLCopy(SwapStr, @Line[3], Len - 3);
                SwapStr[Len - 3] := WideChar(#0);
                LMDWideStrCopy(SwapStr + LMDWideStrLen(SwapStr), '...'#0);
              end;

              LMDWideStrLCopy(Line, SwapStr, Len);
              Line[Len] := WideChar(#0);
              // StrPtr := nil;
            end;
            if (uFormat and DT_MODIFYSTRING) = DT_MODIFYSTRING then
              LMDWideStrCopy(lpString, SwapStr);
          end;
        end;
        if (uFormat and DT_CALCRECT) <> DT_CALCRECT then
        begin
          if (uFormat and DT_PREFIXONLY) <> DT_PREFIXONLY then
          begin
            ExtTextOutFlags := 0;
            if uFormat and DT_NOCLIP <> DT_NOCLIP then
              ExtTextOutFlags := ExtTextOutFlags or ETO_CLIPPED;
            if uFormat and DT_RTLREADING = DT_RTLREADING then
              ExtTextOutFlags := ExtTextOutFlags or DT_RTLREADING;

            if (ExtTextOutFlags and ETO_CLIPPED) = ETO_CLIPPED then
              InflateRect(lpRect, 1, 1);
            if (not ExtTextOutW(hdc, x, y, ExtTextOutFlags, @lpRect, Line, Len, nil)) then
            begin
              Result := 0;
              exit;
            end;
            if (ExtTextOutFlags and ETO_CLIPPED) = ETO_CLIPPED then
              InflateRect(lpRect, -1, -1);
          end;
          if (PrefixOffset <> -1) and ((uFormat and DT_HIDEPREFIX) = 0) then
          begin
            APen := CreatePen(PS_SOLID, 1, GetTextColor(hdc));
            OldPen := SelectObject(hdc, APen);
            MoveToEx(hdc, x + prefix_x, y + TextMetric.tmAscent + 1, nil);
            LineTo(hdc, x + prefix_end + 1, y + TextMetric.tmAscent + 1);
            SelectObject(hdc, OldPen);
            DeleteObject(APen);
          end
        end
        else
          if (TextExtentSize.cx > MaxWidth) then
          MaxWidth := TextExtentSize.cx;

        inc(y, lh);
        if (StrPtr <> nil) then
        begin
          if (uFormat and DT_CALCRECT) <> DT_CALCRECT then
          begin
            if (uFormat and DT_NOCLIP <> DT_NOCLIP) then
            begin
              if (y > lpRect.bottom - lh) then
                break;
            end;
          end;
        end;
      until (StrPtr = nil);

      if (uFormat and DT_CALCRECT) = DT_CALCRECT then
      begin
        lpRect.right := lpRect.left + MaxWidth;
        lpRect.bottom := y;
      end;
      Result := y - lpRect.top;
    finally
      if strCopyUsed then
        FreeMem(lpString);
      if not bMemAllocated then
      begin
        FreeMem(Line);
        FreeMem(SwapStr);
      end;
    end
  end;

end;

{------------------------------------------------------------------------------}
function LMDDrawText(hDC: HDC; const lpString: TLMDString; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer;
begin
  {$ifdef LMD_UNICODE}
  Result := LMDDrawTextW(hDC, PWideChar(lpString), nCount, lpRect, uFormat);
  {$else}
  Result := DrawTextA(hDC, PAnsiChar(AnsiString(lpString)), nCount, lpRect, uFormat);
  {$endif}
end;

function LMDGetTextExtent(ACanvas: TCanvas; const AText: TLMDString): TSize;
begin
{$IFNDEF _LMD_UNICODEIMPL}
  Result := ACanvas.TextExtent(AText);
{$ELSE}
  Windows.GetTextExtentPoint32W(ACanvas.Handle, PWideChar(AText),
                                Length(AText), Result);
{$ENDIF}
end;

function LMDGetTextHeight(ACanvas: TCanvas; const AText: TLMDString): Integer;
begin
  Result := LMDGetTextExtent(ACanvas, AText).cy;
end;

function LMDGetTextWidth (ACanvas: TCanvas; const AText: TLMDString): Integer;
begin
  Result := LMDGetTextExtent(ACanvas, AText).cx;
end;
{------------------------------------------------------------------------------}
procedure LMDDrawTypedTextW(Canvas: TCanvas; Bounds: TRect; const Text: WideString; Flags: integer; DrawType: TLMDTextDrawType);
var
  Col: TColor;
begin
  case DrawType of
    tdtNormal:
      LMDDrawTextW(Canvas.Handle, int_RefW(Text), Length(Text), Bounds, Flags);

    tdtShadowed:
      begin
        OffsetRect(Bounds, 2, 2);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnShadow;

        LMDDrawTextW(Canvas.Handle, int_RefW(Text), Length(Text), Bounds, Flags);

        OffsetRect(Bounds, -2, -2);
        Canvas.Font.Color := col;

        LMDDrawTextW(Canvas.Handle, int_RefW(Text), Length(Text), Bounds, Flags);

      end;
    tdtRaised:
      begin
        OffsetRect(Bounds, -1, -1);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnHighlight;

        LMDDrawTextW(Canvas.Handle, int_RefW(Text), Length(Text), Bounds, Flags);

        OffsetRect(Bounds, 1, 1);
        Canvas.Font.Color := col;

        LMDDrawTextW(Canvas.Handle, int_RefW(Text), Length(Text), Bounds, Flags);

      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDDrawTypedText(Canvas: TCanvas; Bounds: TRect; const Text: string; Flags: integer; DrawType: TLMDTextDrawType);
var
  Col: TColor;
begin
  case DrawType of
    tdtNormal:
      DrawText(Canvas.Handle, int_Ref(Text), Length(Text), Bounds, Flags);

    tdtShadowed:
      begin
        OffsetRect(Bounds, 2, 2);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnShadow;

        DrawText(Canvas.Handle, int_Ref(Text), Length(Text), Bounds, Flags);

        OffsetRect(Bounds, -2, -2);
        Canvas.Font.Color := col;

        DrawText(Canvas.Handle, int_Ref(Text), Length(Text), Bounds, Flags);

      end;
    tdtRaised:
      begin
        OffsetRect(Bounds, -1, -1);
        Col := Canvas.Font.Color;
        Canvas.Font.Color := clBtnHighlight;

        DrawText(Canvas.Handle, int_Ref(Text), Length(Text), Bounds, Flags);

        OffsetRect(Bounds, 1, 1);
        Canvas.Font.Color := col;

        DrawText(Canvas.Handle, int_Ref(Text), Length(Text), Bounds, Flags);

      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDDrawTransparentBitmapEx(DC: HDC; Bitmap: TBitmap; X, Y: integer; Src: TRect; Transparent: TColor);
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

   { set the background color of the source DC back to the original color }
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

{------------------------------------------------------------------------------}
procedure LMDTiledPaint(Canvas: TCanvas; Bitmap: TBitmap; ARect: TRect);
begin
  LMDTiledPaint(Canvas.Handle, Bitmap, ARect);
end;

{------------------------------------------------------------------------------}
procedure LMDTiledPaint(ADC: HDC; Bitmap: TBitmap; ARect: TRect);
var
  CurRect: TRect;
  CurLeft,
  CurTop: integer;
begin
  CurTop := ARect.Top;
  while CurTop < ARect.Bottom do
  begin
    CurLeft := ARect.Left;
    while CurLeft < ARect.Right do
    begin
      CurRect := Rect(CurLeft, CurTop, Min(CurLeft + Bitmap.Width,
        ARect.Right), Min(CurTop + Bitmap.Height, ARect.Bottom));

      BitBlt(ADC, CurLeft, CurTop, CurRect.Right - CurRect.Left,
        CurRect.Bottom - CurRect.Top, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);

      Inc(CurLeft, Bitmap.Width);
    end;
    Inc(CurTop, Bitmap.Height);
  end;
end;

{------------------------------------------------------------------------------}
// --> redundant when other major drawing routines are moved to LMDGRaphUtils
procedure Draw3dRectEx(DC: HDC; x, y, cx, cy: integer; clrTopLeft, clrBottomRight: COLORREF; BorderSides: TLMDBorderSides);
var
  adj : integer;

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

{------------------------------------------------------------------------------}
procedure LMDDrawButtonFrame(DC: HDC; rc: TRect; Focused: boolean; Pushed:boolean;
                             ButtonColor: TColor; Thin: boolean; BorderSides: TLMDBorderSides);
var
  Color1, Color2, Color3, Color4: TColor;
  hls1, hls2, hls3, hls4: integer;
  lum: integer;

  procedure DrawBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4: TColor; Thin: boolean; BorderSides: TLMDBorderSides);
  var adj : integer;
  begin
    adj := 0;
    Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj, nColor1, nColor2, BorderSides);
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
      LMDDrawButtonFrame(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
      exit;
    end
  else
    begin
      ButtonColor := ColorToRGB(ButtonColor);

      hls1 := LMDRGBtoHLS(ButtonColor);
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

        Color1 := LMDHLStoRGB(hls1);
        Color2 := LMDHLStoRGB(hls2);
        Color3 := ButtonColor;
        Color4 := LMDHLStoRGB(hls4);
        LMDDrawButtonFrame(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
        exit;
      end
    else
      begin
        Color1 := ColorToRGB(clBtnHighlight);
        Color2 := ColorToRGB(cl3DDkShadow);
        Color3 := ButtonColor;
        Color4 := ColorToRGB(clBtnShadow);
        LMDDrawButtonFrame(DC, RC, Focused, Pushed, ButtonColor, Thin, Color1, Color2, Color3, Color4, BorderSides);
        exit;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDDrawButtonFrame(DC: HDC; rc: TRect; Focused: boolean; Pushed: boolean;
                            ButtonColor: TColor; Thin: boolean;
                            clrHighlight, clrDkShadow, clrFace, clrShadow: TColor; BorderSides : TLMDBorderSides);
var
  Color1, Color2, Color3, Color4: TColor;

  procedure DrawBorder(DC: HDC; rc: TRect; nColor1, nColor2, nColor3, nColor4: TColor; Thin: boolean; BorderSides: TLMDBorderSides);
  var adj : integer;
  begin
    adj := 0;
    Draw3dRectEx(DC, rc.left, rc.top, rc.right - rc.left - adj, rc.bottom - rc.top - adj, nColor1, nColor2, BorderSides);
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

// <-- from LMDUtils
{Internal constants}
const
  {LMDBmpCreateGrayScale}
  LMDBRIGHTNESS_1=550;
  LMDBRIGHTNESS_2=250;
  LMDBRIGHTNESS_3=50;

{------------------------------------------------------------------------------}
function LMDDrawFrame3D(aCanvas:TCanvas;var dRect:TRect;Style: TLMDBevelStyle;
                        LightColor, ShadowColor:TColor; Depth: Integer):Boolean;

var
  bRect:TRect;
  cl1, cl2:TColor;
  i:Integer;

begin
  result:=False;
  if (Depth=0) or (Style in [bvNone, bvShadow]) then exit;

  {setting colors}
  case style of
    bvLowered, bvFrameLowered:
      begin
        cl1:=LightColor;
        cl2:=ShadowColor;
      end;
    bvNormal:
      begin
        cl1:=clBlack;
        cl2:=clBlack;
      end;
    else
      begin
        cl1:=ShadowColor;
        cl2:=LightColor;
      end;
  end;

  case style of
    bvNormal, bvRaised, bvLowered:
      begin
        dec(dRect.Bottom);
        with aCanvas, dRect do
          if Depth=1 then
            begin
              {RM. 3.01}
              dec(dRect.Right);
              Pen.Width := 1;
              Pen.Style:=psSolid;
              pen.Color:=cl2;
              PolyLine([Types.Point(Left, Bottom), Point(Left, Top), Point(Right, Top)]);
              pen.Color:=cl1;
              PolyLine([Point(Right, Top), Point(Right, Bottom), Point(Left, Bottom)]);
              InflateRect(dRect, -1, -1);
            end
          else
            begin
              bRect:=Rect(Left+Depth, Top+Depth, Right-Depth, Bottom-Depth);
              Pen.Style:=psClear;
              Brush.Style:=bsSolid;

              Brush.Color:=cl1;
              Polygon([Point(Left, Bottom+1), Point(bRect.Left, bRect.Bottom), Point(bRect.Right, bRect.Bottom),
                       Point(bRect.Right, bRect.Top), Point(Right, Top), Point(Right, Bottom+1)]);

              Brush.Color:=cl2;
              Dec(bRect.Right);
              Polygon([Point(Left, Bottom), Point(bRect.Left, bRect.Bottom), Point(bRect.Left, bRect.Top),
                       Point(bRect.Right, bRect.Top), Point(Right-1, Top), Point(Left, Top)]);

              InflateRect(dRect, -Depth, -Depth);
              {RM: please check}
              Dec(dRect.Right);
            end;

        Inc(dRect.Right);
        Inc(dRect.Bottom);
        result:=True;
      end;
   bvFrameRaised, bvFrameLowered:
     with aCanvas, dRect do
       begin
         for i:=0 to Pred(Depth) do
           begin
             Brush.Color:=cl1;
             FrameRect(Rect(Left+i+1, Top+i+1, Right, Bottom));
             Brush.Color:=cl2;
             FrameRect(Rect(Left, Top, Right-i-1, Bottom-i-1));
           end;
         dRect:=Rect(Left+Depth+1, Top+Depth+1, Right-Depth-1, Bottom-Depth-1);
         result:=true;
       end;
   bvFlat:
     begin
       aCanvas.Brush.Color := ShadowColor;
       aCanvas.FrameRect(dRect);
     end;
   end;
end;

{------------------------------------------------------------------------------}
function LMDDrawFrameShadow(aCanvas:TCanvas; var aRect:TRect; LightColor, ShadowColor,
                            BorderColor:TColor; WidthOuter, WidthInner:TLMDBorderWidth;
                            Transparent:Boolean; flags:Word):Boolean;
var
  i:Integer;
begin
  with aCanvas, aRect do
    begin
      Brush.Style:=bsSolid;
      Pen.Style:=psClear;
      Brush.Color:=ShadowColor;

      FillRect(Rect(aRect.Right-WidthOuter, aRect.Top+WidthOuter, aRect.Right, aRect.Bottom));
      FillRect(Rect(aRect.Left+WidthOuter, aRect.Bottom-WidthOuter, aRect.Right, aRect.Bottom));

      if not Transparent then
        begin
          Brush.Color:=BorderColor;
          FillRect(Rect(aRect.Right-WidthOuter, aRect.Top, aRect.Right, aRect.Top+WidthOuter));
          FillRect(Rect(aRect.Left, aRect.Bottom-WidthOuter, aRect.Left+WidthOuter, aRect.Bottom));
        end;

      aRect:=Rect(aRect.Left, aRect.Top, aRect.Right-WidthOuter, aRect.Bottom-WidthOuter);
      Brush.color:=LightColor;
      for i:=0 to Pred(WidthInner) do
        begin
          FrameRect(aRect);
          InflateRect(aRect, -1, -1);
        end;
      Pen.Width:=1;
      result:=True;
    end;
end;

{------------------------------------------------------------------------------}
function LMDDrawStdFrameExt(Style:TLMDBorderStyle):Integer;
begin
  case Style of
    lsNone:
      result:=0;
    lsSingle, lsSingleLowered, lsSingleRaised:
      result:=1;
  else
    result:=2;
  end;
end;

{------------------------------------------------------------------------------}
function LMDDrawStdFrame(ACanvas: TCanvas; var aRect:TRect;
                         Style: TLMDBorderStyle; flags:Word):Boolean;
begin
  Result := LMDDrawStdFrame(aCanvas.Handle, aRect, Style, flags);
end;

{------------------------------------------------------------------------------}
function LMDDrawStdFrame(AHdc: HDC; var aRect:TRect;
                         Style: TLMDBorderStyle; flags:Word):Boolean;
begin
  flags:=flags or BF_ADJUST;
  case style of
    lsSingle:    {single black border}
      begin
        DrawEdge(AHdc, aRect, BDR_SUNKENOUTER, BF_TOPLEFT or BF_SOFT or flags);
        DrawEdge(AHdc, aRect, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);
      end;
    lsLowered:
      DrawEdge(AHdc, aRect, EDGE_SUNKEN, BF_RECT or BF_SOFT or flags);
    lsRaised:
      DrawEdge(AHdc, aRect, EDGE_RAISED, BF_RECT or BF_SOFT or flags);
    lsFrameInset:
      DrawEdge(AHdc, aRect, EDGE_ETCHED, BF_RECT or flags);
    lsFrameOffset:
      begin
        DrawEdge(AHdc, aRect, BDR_RAISEDINNER, BF_RECT or flags);
        DrawEdge(AHdc, aRect, BDR_SUNKENOUTER, BF_RECT or flags);
      end;
    lsRaisedSpb:
      begin
        DrawEdge(AHdc, aRect, BDR_RAISEDOUTER, BF_SOFT or BF_RECT or flags);
        DrawEdge(AHdc, aRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT or BF_ADJUST);
      end;
    lsLoweredspb:
      begin
        DrawEdge(AHdc, aRect, BDR_SUNKENOUTER, BF_RECT or flags);
        DrawEdge(AHdc, aRect, BDR_SUNKENINNER, BF_TOPLEFT or flags);
      end;
    lsRaisedExt:
      begin
        DrawEdge(AHdc, aRect, BDR_RAISEDOUTER, BF_SOFT or BF_RECT or flags);
        DrawEdge(AHdc, aRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT or BF_ADJUST);
        Inc(aRect.Top); //extra work to be done due to this in TLMDSplitterPanel (UpDateBar)
        Inc(aRect.Left);
      end;
    lsLoweredExt:
      begin
        DrawEdge(AHdc, aRect, BDR_SUNKENOUTER, BF_RECT or flags);
        DrawEdge(AHdc, aRect, BDR_SUNKENINNER, BF_TOPLEFT or BF_ADJUST);
        Dec(aRect.Right); //extra work to be done due to this in TLMDSplitterPanel (UpDateBar)
        Dec(aRect.Bottom);
      end;
    lsWindowBorder:
      begin
        DrawEdge(AHdc, aRect, BDR_RAISEDOUTER, BF_BOTTOMRIGHT or flags);
        inc(aRect.Top);inc(aRect.Left);
        DrawEdge(AHdc, aRect, BDR_RAISEDINNER, BF_RECT or flags);
      end;
    lsSingleRaised:
      DrawEdge(AHdc, aRect, BDR_RAISEDINNER, BF_RECT or flags);
    lsSingleLowered:
      DrawEdge(AHdc, aRect, BDR_SUNKENOUTER, BF_RECT or flags);
    lsDoubleRaised:
      begin
        DrawEdge(AHdc, aRect, BDR_RAISEDINNER, BF_RECT or flags);
        DrawEdge(AHdc, aRect, BDR_RAISEDINNER, BF_RECT or flags);
      end;
    lsDoubleLowered:
      begin
        DrawEdge(AHdc, aRect, BDR_SUNKENOUTER, BF_RECT or flags);
        DrawEdge(AHdc, aRect, BDR_SUNKENOUTER, BF_RECT or flags);
      end;
  end;
  result:=True;
end;

{------------------------------------------------------------------------------}
procedure LMDDrawBorder(aCanvas: TCanvas; aBounds: TRect; ULColor, LRColor: TColor);
begin
  with aBounds, aCanvas do
  begin
    Pen.Color := ULColor;
    MoveTo( Left, Bottom - 1 );
    LineTo( Left, Top );
    LineTo( Right - 1, Top );

    Pen.Color := LRColor;
    LineTo( Right - 1, Bottom - 1 );
    LineTo( Left, Bottom - 1 );
  end;
end;

{------------------------------------------------------------------------------}
function LMDGetCtrlBorderWidth(aCtl3D:Boolean; aBorderStyle:TBorderStyle; useXp:Boolean=false):Byte;
begin
  result:=0;
  if aBorderStyle=bsSingle then
    begin
      Inc(result);
      if aCtl3D and not UseXP then Inc(result);
    end
end;

{******************************************************************************}
{* Bitmap-Routines                                                            *}
{******************************************************************************}
{------------------------------------------------------------------------------}
procedure LMDBmpCreateFromRect(aValue:TBitmap; const aRect:TRect; fColor:TColor=clNone);
begin
  if (aValue=nil) or IsRectEmpty(aRect) then exit;

  with aValue do
    begin
      Width:=aRect.Right-aRect.Left;
      Height:=aRect.Bottom-aRect.Top;
      if fColor<>clNone then
        begin
          Canvas.Brush.Color:=fColor;
          Canvas.Brush.Style := bsSolid;
          Canvas.FillRect(Rect(0,0,Width, Height));
        end;
    end;
end;

var
  Brightness:LongInt;

{------------------------------------------------------------------------------}
procedure LMDBmpCreateGrayscale(Dest, Src:TBitmap);
var
  CountOk, k, LineX, LineY: Integer;
  Col, TransCol: LongInt;
  sum, addon: LongInt;
begin
  CountOk:=0;
  sum:=0;
  addon:=0;
  Brightness:=0;
  Dest.Assign(Src);
  TransCol:=ColorToRGB(Src.Canvas.Pixels[0,0]);

  for k:=0 to 1 do
    begin
      for LineX:=0 to Src.Width do
        for LineY:=0 to Src.Height do
          begin
            Col:=ColorToRGB(Src.Canvas.Pixels[LineX,LineY]);
            if Col<>TransCol then
              begin
                Brightness:=LongInt(GetRValue(Col)+GetGValue(Col)+GetBValue(Col));
                case k of
                0:
                  begin
                    Inc(sum, Brightness);
                    Inc(CountOk);
                  end;
                1:
                  begin
                    if Brightness>LMDBRIGHTNESS_1+addon then
                      Dest.Canvas.Pixels[LineX,LineY]:=clWhite
                    else if Brightness>LMDBRIGHTNESS_2+addon then
                      Dest.Canvas.Pixels[LineX,LineY]:=clBtnHighlight
                    else if Brightness>LMDBRIGHTNESS_3+addon then
                      Dest.Canvas.Pixels[LineX,LineY]:=clBtnShadow
                    else
                      Dest.Canvas.Pixels[LineX,LineY]:=clBlack;
                  end;
                end;
              end;
          end;
      if (k=0) and (CountOk>0) then
        addon:=-Round(200-(sum/CountOK));
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBmpCreateMasks(const srcBmp:TBitmap; Mask, NewImage:TBitmap;
                            MaskColor:TColor);
begin
  LMDBmpCreateMasksExt(srcBmp.Canvas, Rect(0,0, srcBmp.Width, srcBmp.Height),
                       Mask, NewImage, MaskColor);
end;

{------------------------------------------------------------------------------}
procedure LMDBmpCreateMasksExt(srcCanvas:TCanvas; srcRect:TRect; aMask,
                               NewImage:TBitmap; MaskColor:TColor);

  var
  bw, bh:Integer;
begin
  if (aMask=nil) or (NewImage=nil) then exit;

  MaskColor := ColorToRGB(MaskColor);
  with srcRect do
    begin
      bw:=Right-Left;
      bh:=Bottom-Top;
      With NewImage do
        begin
          Width:=bw;
          Height:=bh;
          BitBlt(Canvas.Handle, 0, 0, bw, bh, srcCanvas.Handle, Left, Top, SRCCOPY);
        end;
    end;

  With aMask do
    begin
      Width:=bw;
      Height:=bh;

      Canvas.CopyRect(Rect(0,0,bw,bh), srcCanvas, srcRect);
      Mask(MaskColor);

      //Canvas.CopyRect(Rect(0,0,bw,bh), srcCanvas, srcRect);
      //Mask(MaskColor);
      end;

  SetBKColor(NewImage.Canvas.Handle, clBlack);
  SetTextColor(NewImage.Canvas.Handle, clWhite);
  BitBlt(NewImage.Canvas.Handle, 0, 0, bw, bh, aMask.Canvas.Handle, 0, 0, SRCAND);
end;

{------------------------------------------------------------------------------}
procedure LMDBmpClipDraw(aCanvas:TCanvas; const aRect:TRect; aBitmap:TBitmap;
                         flags:WORD; pos:LongInt; MaskColor:TColor);
begin
  if aBitmap.Canvas.Penpos.X=-1 then exit;
  with aBitmap do
    begin

      if (DSF_PALETTEREALIZE and flags=DSF_PALETTEREALIZE) and not
        ((aoAutoRealizePalette in LMDApplication.Options) and (LMDSIColorDepth<9)) then
        begin
          SelectPalette(aCanvas.Handle, aBitmap.Palette, false);
          RealizePalette(aCanvas.Handle);
        end;

      if DSF_BRUSHCOPY and flags=DSF_BRUSHCOPY then
        LMDBmpClipDrawExt(aCanvas, aRect, nil, Rect(0,0,Width, Height), flags, pos, MaskColor, aBitmap)
      else
        LMDBmpClipDrawExt(aCanvas, aRect, aBitmap.Canvas, Rect(0,0,Width, Height), flags, pos, MaskColor, nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBmpClipDrawExt(aCanvas:TCanvas; const aRect:TRect; srcCanvas:TCanvas;
                            srcRect:TRect; flags:WORD; pos:LongInt; MaskColor:TColor; Add:TObject);
var
  Rgn:HRgn;

begin

  if DSF_CLIPRECT and flags=DSF_CLIPRECT then
    begin
      if pos=0 then
        Rgn:=CreateRectRgnIndirect(aRect)
      else
        with aRect do
           Rgn:=CreateRectRgn(LoWord(pos)+Left, HiWord(pos)+Top,
                              LoWord(pos)+Right, HiWord(pos)+Bottom);

      try
        SelectClipRgn(aCanvas.Handle, Rgn);
        LMDBmpDrawExt(aCanvas, aRect, srcCanvas, srcRect, flags, MaskColor, 0, Add);
      finally
        if DeleteObject(Rgn) then SelectClipRgn(aCanvas.Handle, 0);
      end;
    end
  else
    LMDBmpDrawExt(aCanvas, aRect, srcCanvas, srcRect, flags, MaskColor, 0, Add);
end;

{------------------------------------------------------------------------------}
procedure LMDBmpDrawTransparent(ACanvas: TCanvas; X, Y: Integer; ABitmap: TBitmap; AClTransparent: TColor);
var
  bmpXOR, bmpAND, bmpINVAND, bmpTarget: TBitmap;
  oldcol: Longint;
begin
  bmpAND := TBitmap.Create;
  bmpINVAND := TBitmap.Create;
  bmpXOR := TBitmap.Create;
  bmpTarget := TBitmap.Create;
  try
    bmpAND.Width := ABitmap.Width;
    bmpAND.Height := ABitmap.Height;
    bmpAND.Monochrome := True;
    oldcol := SetBkColor(ABitmap.Canvas.Handle, ColorToRGB(AClTransparent));
    BitBlt(bmpAND.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, ABitmap.Canvas.Handle, 0, 0, SRCCOPY);
    SetBkColor(ABitmap.Canvas.Handle, oldcol);

    bmpINVAND.Width := ABitmap.Width;
    bmpINVAND.Height := ABitmap.Height;
    bmpINVAND.Monochrome := True;
    BitBlt(bmpINVAND.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, bmpAND.Canvas.Handle, 0, 0, NOTSRCCOPY);

    bmpXOR.Width := ABitmap.Width;
    bmpXOR.Height := ABitmap.Height;
    BitBlt(bmpXOR.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, ABitmap.Canvas.Handle, 0, 0, SRCCOPY);
    BitBlt(bmpXOR.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, bmpINVAND.Canvas.Handle, 0, 0, SRCAND);

    bmpTarget.Width := ABitmap.Width;
    bmpTarget.Height := ABitmap.Height;
    BitBlt(bmpTarget.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, ACanvas.Handle, x, y, SRCCOPY);
    BitBlt(bmpTarget.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, bmpAND.Canvas.Handle, 0, 0, SRCAND);
    BitBlt(bmpTarget.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, bmpXOR.Canvas.Handle, 0, 0, SRCINVERT);
    BitBlt(ACanvas.Handle, x, y, ABitmap.Width, ABitmap.Height, bmpTarget.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    bmpXOR.Free;
    bmpAND.Free;
    bmpINVAND.Free;
    bmpTarget.Free;
  end;
end;

{procedure LMDBmpDrawExt}
{------------------------------------------------------------------------------}
function LMDBmpDrawExt(aCanvas:TCanvas; const aRect:TRect; srcCanvas:TCanvas;
                       srcRect:TRect; flags:WORD; TransColor:TColor; pal:HPalette; Add:TObject):TRect;
var
  i,j, he, wi, bh, bw:Integer;
  oldBk:TColorRef;
  oldText:LongInt;
  aMono, aMask:TBitmap;

  tmpByte:Byte;
  tmpRect:TRect;

  procedure DrawTransparent(x,y,w,h:Integer; aSrc, aSrc1:TCanvas);
  var
    old:TCopyMode;
  begin
    old:=aCanvas.CopyMode;
    aCanvas.CopyMode:=cmSrcAnd;
    aCanvas.CopyRect(Bounds(x, y, w, h), aSrc1, Rect(0, 0, bw, bh));
    aCanvas.CopyMode:=cmSrcPaint;
    aCanvas.CopyRect(Bounds(x, y, w, h), aSrc, Rect(0, 0, bw, bh));
    aCanvas.CopyMode:=old;
  end;

  {for DSF_TRANSPARENCY_MASK}
  procedure DrawTransparentExt(x,y,w,h:Integer; aSrc, aSrc1:TCanvas);
  var
    old:TCopyMode;
  begin
    old:=aCanvas.CopyMode;
    with srcRect do
      begin
        aCanvas.CopyMode:=cmSrcAnd;
        aCanvas.CopyRect(Bounds(x, y, w, h), aSrc1, Bounds(Left, Top, bw, bh));
        aCanvas.CopyMode:=cmSrcPaint;
        aCanvas.CopyRect(Bounds(x, y, w, h), aSrc, Bounds(Left, Top, bw, bh));
      end;
    aCanvas.CopyMode:=old;
  end;

begin

  SetRectEmpty(result);
  if IsRectEmpty(aRect) then exit;

  he:=0;
  wi:=0;

  with srcRect do
    begin
      bh:=Bottom-Top;
      bw:=Right-Left;
    end;

 tmpByte:=0;
  with aRect do
    begin

      if flags and DSF_CENTER=DSF_CENTER then
        begin
          tmpByte:=1;
          tmpRect:=Rect(Left+((Right-Left)-bw) div 2, Top+((Bottom-Top)-bh) div 2, bw,bh);
        end;

      if flags and DSF_STRETCH=DSF_STRETCH then
        begin
          SetStretchBltMode(aCanvas.Handle, STRETCH_DELETESCANS);
          tmpByte:=2;
          he:=(Bottom-Top);
          wi:=(Right-Left);
          tmpRect:=Rect(Left, Top, wi, he);
          if flags and DSF_KEEPRATIO=DSF_KEEPRATIO then
            with tmpRect do
              begin
                tmprect:=LMDAffineRect(Rect(0,0,bw, bh), Rect(0,0, wi, he));
                inc(Left, aRect.Left);
                inc(Top, aRect.Top);
              end
          else
            begin
              if flags and DSF_KEEPHEIGHT=DSF_KEEPHEIGHT then
                tmpRect:=Rect(Left, Top, wi, Round(wi/bw*bh));
              if flags and DSF_KEEPWIDTH=DSF_KEEPWIDTH then
                tmpRect:=Rect(Left, Top, Round(he/bh*bw),he);
            end;
        end;

      if flags and DSF_TILE=DSF_TILE then
        begin
          tmpByte:=3;
          if (bh<>0) and (bw<>0) then
            begin
              he:=((Bottom-Top) div bh)+1;
              wi:=((Right-Left) div bw)+1;
            end;
        end;

      if tmpByte=0 then tmpRect:=Rect(aRect.Left, aRect.Top, bw, bh);
      if IsRectEmpty(tmpRect) then
        result:=aRect
      else
        with tmpRect do
          result:=Bounds(Left, Top, Right, Bottom);

      if flags and DSF_BRUSHCOPY=DSF_BRUSHCOPY then
        begin
          aCanvas.Brush.Color:=TransColor;
          aMask:=TBitmap(Add);
          case tmpByte of
            0..2:
              begin
                with tmpRect do
                  tmpRect:=Bounds(Left, Top,Right, Bottom);
                aCanvas.BrushCopy(tmpRect, aMask, srcRect,
                                  aMask.TransparentColor);
              end;
            3:begin
                tmpRect:=Rect(0,0,bw,bh);
                for i:=0 to he do
                  for j:=0 to wi do
                    aCanvas.BrushCopy(Bounds(Left+j*bw, Top+i*bh, bw, bh), aMask,
                                      srcRect, aMask.TransparentColor);
              end;
          end;
          exit;
        end;

      if (flags and DSF_TRANSPARENCY_MASK=DSF_TRANSPARENCY_MASK) and (Add<>nil) then
        begin
          oldBk:=SetBkColor(aCanvas.Handle, clWhite);
          oldText:=SetTextColor(aCanvas.Handle, clBlack);
          case tmpByte of
            0..2:
              with tmpRect do
                DrawTransparentExt(Left, Top, Right, Bottom, srcCanvas, TCanvas(Add));
            3:for i:=0 to he do
                for j:=0 to wi do
                  DrawTransparentExt(Left+j*bw, Top+i*bh, bw, bh, srcCanvas, TCanvas(Add));
          end;
          SetTextColor(aCanvas.Handle, oldText);
          SetBKColor(aCanvas.Handle, oldBK);
          exit;
        end;

      if (flags and DSF_TRANSPARENCY=DSF_TRANSPARENCY) then
        begin
           aMask:=TBitmap.Create;
           aMono:=TBitmap.Create;
           try
              if pal<>0 then
                aMask.Palette:=pal;
              LMDBmpCreateMasksExt(srcCanvas, srcRect, aMono, aMask, TransColor);
              oldBk:=SetBkColor(aCanvas.Handle, clWhite);
              oldText:=SetTextColor(aCanvas.Handle, clBlack);
              case tmpByte of
                0..2:
                  with tmpRect do
                    DrawTransparent(Left, Top, Right, Bottom, aMask.Canvas, aMono.Canvas);
                3:for i:=0 to he do
                    for j:=0 to wi do
                      DrawTransparent(Left+j*bw, Top+i*bh, bw, bh, aMask.Canvas, aMono.Canvas);
              end;
              SetTextColor(aCanvas.Handle, oldText);
              SetBKColor(aCanvas.Handle, oldBK);
           finally
             aMask.Free;
             aMono.Free;
           end;
           exit;
        end;

      case tmpByte of
        0..2:
          with tmpRect do
            aCanvas.CopyRect(Bounds(Left, Top, Right, Bottom), srcCanvas,
                             Bounds(srcRect.Left, srcRect.Top, bw, bh));
        3:for i:=0 to he do
              for j:=0 to wi do
                aCanvas.CopyRect(Bounds( Left+j*bw, Top+i*bh, bw, bh), srcCanvas,
                                 Bounds(srcRect.Left, srcRect.Top, bw, bh));
      end;

   end;
end;

{Wrapper for LMDBmpDrawExt}
{------------------------------------------------------------------------------}
function LMDBmpDraw(aCanvas:TCanvas; const aRect:TRect; aBitmap:TBitmap;
                     flags:WORD; TransColor:TColor):TRect;
begin
  SetRectEmpty(result);
  if aBitmap.Canvas.Penpos.X=-1 then exit;
  with aBitmap do
    begin
      if (DSF_PALETTEREALIZE and flags=DSF_PALETTEREALIZE) and not
        ((aoAutoRealizePalette in LMDApplication.Options) and (LMDSIColorDepth<9)) then
        begin
          SelectPalette(aCanvas.Handle, aBitmap.Palette, false);
          RealizePalette(aCanvas.Handle);
          if DSF_BRUSHCOPY and flags=DSF_BRUSHCOPY then
            result:=LMDBmpDrawExt(aCanvas, aRect, nil, Rect(0,0,Width, Height), flags, TransColor, 0, aBitmap)
          else
            result:=LMDBmpDrawExt(aCanvas, aRect, Canvas, Rect(0,0,Width, Height), flags, TransColor, aBitmap.Palette, nil);
        end
      else
        begin
          if DSF_BRUSHCOPY and flags=DSF_BRUSHCOPY then
            result:=LMDBmpDrawExt(aCanvas, aRect, nil, Rect(0,0,Width, Height), flags, TransColor, 0, aBitmap)
          else
            result:=LMDBmpDrawExt(aCanvas, aRect, Canvas, Rect(0,0,Width, Height), flags, TransColor, 0, nil);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBmpDrawDisabledState(DestBmp, SrcBmp:TBitmap; x,y: Integer);
var
  MonoBmp: TBitmap;
begin
  MonoBmp := TBitmap.Create;
  try
    MonoBmp.Assign(SrcBmp);
    MonoBmp.Canvas.Brush.Color:=clBlack;
    MonoBmp.Monochrome:=True;
    with DestBmp do
      begin
        Canvas.Brush.Color:=SrcBmp.TransparentColor{clGreen};
        Canvas.FillRect(Rect(0,0,Width,Height));
        Canvas.Brush.Color:=clBtnHighlight;
        SetTextColor(Canvas.Handle, clBlack);
        SetBkColor(Canvas.Handle, clWhite);
        BitBlt(Canvas.Handle, x+1, y+1, SrcBmp.Width, SrcBmp.Height,
         MonoBmp.Canvas.Handle, 0, 0, $00E20746);
        Canvas.Brush.Color:=clBtnShadow;
        SetTextColor(Canvas.Handle, clBlack);
        SetBkColor(Canvas.Handle, clWhite);
        BitBlt(Canvas.Handle, x, y, SrcBmp.Width, SrcBmp.Height,
            MonoBmp.Canvas.Handle, 0, 0, $00E20746);
      end;
  finally
    MonoBmp.Free;
  end
end;

{Wrapper for StretchDraw}
{------------------------------------------------------------------------------}
procedure LMDBmpStretchDraw(aCanvas:TCanvas; const aRect:TRect; aBitmap:TBitmap);
begin
  LMDBmpDraw(aCanvas, aRect, aBitmap, DSF_PALETTEREALIZE OR DSF_STRETCH, clBlack);
end;

{internal helper}
{------------------------------------------------------------------------------}
procedure LMDCopyBmpSize(DestBmp,SrcBmp: TBitmap);
begin
  with DestBmp do
    begin
      srcBmp.Width:=Width;
      srcBmp.Height:=Height;
    end;
end;

{3.02}
{------------------------------------------------------------------------------}
procedure LMDMaskBmpDraw(aCanvas: TCanvas; const aRect: TRect;
                         aMask, Original: TBitmap;
                         MaskCol, TransCol: TColor);
var
  aSecMask: TBitmap;
  bRect:TRect;
begin

  TransCol:=ColorToRGB(TransCol);
  MaskCol:=ColorToRGB(MaskCol);
  bRect:=Rect(0,0, Original.Width, Original.Height);
  if (aMask=nil) or (Original=nil) or (aCanvas=nil) then exit;
  aSecMask:=TBitmap.Create;

  try
    aSecMask.Width:=aMask.Width;
    aSecMask.Height:=aMask.Height;
    LMDBmpCreateMasks(aMask,aMask,aSecMask,MaskCol);

    LMDBmpDrawExt(Original.Canvas,bRect,aSecMask.Canvas, bRect,
                  DSF_TRANSPARENCY_MASK, MaskCol, 0, aMask.Canvas);
    LMDBmpDrawExt(aCanvas, aRect, Original.Canvas, bRect,
                  DSF_TRANSPARENCY or DSF_PALETTEREALIZE,TransCol, 0, nil);
  finally
    aSecMask.Free;
  end;

end;

{Something special}
{------------------------------------------------------------------------------}
procedure LMDFillPattern(hdc:HDC; const R:TRect; Pattern:TBitmap);
var
  rBrush:TLogBrush;
  hIBrush,
  hOBrush,
  hPBrush,
  hOPBrush:HBrush;
  hNPen,
  hOPen:HPen;
  hBm:HBitmap;

begin
  with R do
    begin
      rBrush.lbStyle := BS_HOLLOW;
      hIBrush        := CreateBrushIndirect(rBrush);
      hOBrush        := SelectObject(hdc,hIBrush);
      hNPen          := CreatePen(PS_NULL, 0, 0);
      hOPen          := SelectObject(hdc,hNPen);
      hPBrush        := CreatePatternBrush(Pattern.Handle);
      hOPBrush       := SelectObject(hdc,hPBrush);
      hBm            := CreateCompatibleBitmap(hdc,right,bottom);
      PatBlt(hdc,Left,Top,Right-Left,Bottom-Top,10485961);
      DeleteObject(hBm);
      DeleteObject(SelectObject(hdc,hOPBrush));
      DeleteObject(SelectObject(hdc,hOBrush));
      DeleteObject(SelectObject(hdc,hOPen));
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDFillTexture(hdc : HDC; const R : TRect; bm : TBitmap; bmOffset : TPoint);
var
  l,h : Integer;
begin
  if not bm.Empty and (bmOffset.x>=0) and (bmOffset.y>=0)then
    begin
      if bmOffset.x>bm.Width  then bmOffset.x := bmOffset.x mod bm.Width;
      if bmOffset.y>bm.Height then bmOffset.y := bmOffset.y mod bm.Height;
      with R do
        begin
          if (Right-Left>0) and (Bottom-Top>0) then
            with TBitmap.Create do
              try
                Height:= bm.Height;
                Width := Right-Left;
                l     := bm.Width-bmOffset.x;
                if l>Width then l := Width;
                BitBlt(Canvas.Handle,0,0,l,Height,bm.Canvas.Handle,bmOffset.x,0,SRCCOPY);
                while l+bm.Width<Width do
                  begin
                    BitBlt(Canvas.Handle,l,0,bm.Width,Height,bm.Canvas.Handle,0,0,SRCCOPY);
                    inc(l,bm.Width);
                  end;
                if l<Width then
                  BitBlt(Canvas.Handle,l,0,Width-l,Height,bm.Canvas.Handle,0,0,SRCCOPY);
                h := Bottom-Top;
                l := bm.Height-bmOffset.y;
                if l>h then l := h;
                BitBlt(hdc,Left,Top,Width,l,Canvas.Handle,0,bmOffset.y,SRCCOPY);
                while l+bm.Height<h do
                  begin
                    BitBlt(hdc,Left,Top+l,Width,Height,Canvas.Handle,0,0,SRCCOPY);
                    inc(l,Height);
                  end;
                if l<h then BitBlt(hdc,Left,Top+l,Width,h-l,Canvas.Handle,0,0,SRCCOPY)
              finally
                Free;
              end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDIcon2Bitmap(aIcon:TIcon; aBitmap:TBitmap; aColor:TColor);
begin
  if (aBitmap=nil) or (aIcon=nil) then exit;
  with aBitmap do
    begin
      Width:=aIcon.Width;
      Height:=aIcon.Height;
      Canvas.Brush.Color:=aColor;
      Canvas.FillRect(Rect(0,0, Width, Height));
      Canvas.Draw(0,0, aIcon);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBitmap2Icon (aBitmap : TBitmap; aIcon: TIcon; TransparentColor: TColor);
begin
  with TImageList.CreateSize(aBitmap.Width, aBitmap.Height) do
    try
      AllocBy := 1;
      AddMasked(aBitmap, TransparentColor);
      GetIcon(0, aIcon);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDBmpFromDesktop(aBitmap:TBitmap; aRect:TRect);
var
  DC:HDC;
begin
  if (aBitmap=nil) or IsRectEmpty(aRect) then exit;

  with aRect do
    begin
      aBitmap.Width:=Right-Left;
      aBitmap.Height:=Bottom-Top;
    end;
  DC:=GetDC(0);
  try
    BitBlt(aBitmap.Canvas.Handle, 0, 0, aBitmap.Width, aBitmap.Height, DC,
           aRect.Left, aRect.Top, SRCCOPY);
  finally
    ReleaseDC(0,DC);
  end;
end;
{******************************************************************************}
{********************** Routines - Gradient Fill ******************************}
{------------------------------------------------------------------------------}
function LMDGradientGetColor(Color, EndColor:TColor;CurrentStep, ColorCount:Integer):TColor;
begin
 result:=RGB(Trunc(GetRValue(Color)+(GetRValue(EndColor)-GetRValue(Color))*CurrentStep/ColorCount),
             Trunc(GetGValue(Color)+(GetGValue(EndColor)-GetGValue(Color))*CurrentStep/ColorCount),
             Trunc(GetBValue(Color)+(GetBValue(EndColor)-GetBValue(Color))*CurrentStep/ColorCount));
end;

{------------------------------------------------------------------------------}
procedure LMDGradientCreateColorList(Color, EndColor:TColor;ColorCount:TLMDColorCount;
                                     ColorList:TList; Clear : Boolean);
var
  j,
  i:Integer;
  FbgR, FbgG, FbgB,
  FEndBgr, FEndBgG, FEndBgB:Integer;
  r,g,b:Byte;
  temp: COLORREF;

begin
  if (ColorList=nil) or (ColorCount=0) then exit;

  if Clear then
    ColorList.Clear;

  FbgR:=GetRValue(ColorToRGB(Color));
  FbgB:=GetBValue(ColorTORGB(Color));
  FbgG:=GetGValue(ColorTORGB(Color));
  FEndbgR:=GetRValue(ColorToRGB(EndColor))-FbgR;
  FEndbgB:=GetBValue(ColorToRGB(EndColor))-FbgB;
  FEndbgG:=GetGValue(ColorToRGB(EndColor))-FbgG;

  //include or exclude first color?
  //relevant for gradients out of more than two colors (otherwise first color will appear twice)
  if clear then j := 0 else j := 1;

  for i:=j to ColorCount-1 do
    begin
      r := FbgR+MulDiv(i, FEndbgR, ColorCount-1);
      g := Fbgg+MulDiv(i, FEndbgG, ColorCount-1);
      b := FbgB+MulDiv(i, FEndbgB, ColorCount-1);
      temp:=RGB(r,g,b);
      ColorList.Add(Pointer(TLMDPtrUInt(temp)));
    end;

end;

{------------------------------------------------------------------------------}
function LMDGradientCreatePalette(ColorList:TList):HPalette;
var
  PaletteInfo: PLogPalette;
  PaletteSize: Integer;
  tmpRGB: LongInt;
  i, temp: Integer;

begin

  result:=0;
  if (ColorList=nil) or (ColorList.Count=0) then exit;

  temp := ColorList.Count;

  {Create Palette-Structure}
  PaletteSize  := SizeOf(TLogPalette) + (SizeOf(TPaletteEntry) * temp);

  GetMem(PaletteInfo, PaletteSize);
  {PaletteInfo := PLogPalette(MemAlloc(PaletteSize));}

  with PaletteInfo^ do
    begin
      palVersion := $0300;
      palNumEntries := temp;
      for i:=0 to temp-1 do
        with palPalEntry[i] do
          begin
            //Pointer(tmpRGB) := ColorList[i];
            tmpRGB := LongInt(ColorList[i]);
            peRed := GetRValue(tmpRGB);
            peGreen := GetGValue(tmpRGB);
            peBlue := GetBValue(tmpRGB);
            peFlags := PC_NOCOLLAPSE;
          end;
    end;

  result := CreatePalette(PaletteInfo^);
  FreeMem(PaletteInfo, PaletteSize);
  end;

{------------------------------------------------------------------------------}
function  LMDBackgroundIsGradient(BGType :TLMDBackgroundType): Boolean;
begin
  Result := (BGType in [bgtHorzGradient, bgtVertGradient,
            bgtSquareGradient, bgtEllipticGradient, bgtTopLeftGradient, bgtTopRightGradient,
            bgtBottomLeftGradient, bgtBottomRightGradient, bgtTopLeftDiagonalGradient, bgtTopRightDiagonalGradient]);
end;

{------------------------------------------------------------------------------}
function LMDGetRedValue(AColor: TColor): byte;
begin
  result := AColor;
end;

{------------------------------------------------------------------------------}
function LMDGetGreenValue(AColor: TColor): byte;
begin
  result := AColor shr 8;
end;

{------------------------------------------------------------------------------}
function LMDGetBlueValue(AColor: TColor): byte;
begin
  result := AColor shr 16;
end;

{------------------------------------------------------------------------------}
function LMDGetAlphaValue(AColor: TLMDARGBColor):byte;
begin
  result := AColor shr 24;
end;

{------------------------------------------------------------------------------}
function LMDGetColor(ARed, AGreen, ABlue: byte): TColor;
begin
  result := ARed + (AGreen shl 8) + (ABlue shl 16);
end;

{------------------------------------------------------------------------------}
function LMDGetARGBColor(AAlpha, ARed, AGreen, ABlue: byte): TLMDARGBColor;
begin
  result := ARed + (AGreen shl 8) + (ABlue shl 16) + (AAlpha shl 24);
end;

{------------------------------------------------------------------------------}
function LMDCalcProportion(bv, ev: byte; dist, pos: integer): Byte;
begin
  if (pos < 0) or (dist = 0) then
    result := bv
  else
    if pos >= dist then
      result := ev
    else
      result := bv + muldiv((ev-bv), pos, dist);
end;

{------------------------------------------------------------------------------}
function LMDCalcProportionColor(bv, ev: TColor; dist, pos: byte): TColor;
begin
  result :=  LMDGetColor(LMDCalcProportion(LMDGetRedValue(bv),LMDGetRedValue(ev),dist,pos),
                      LMDCalcProportion(LMDGetGreenValue(bv),LMDGetGreenValue(ev),dist,pos),
                      LMDCalcProportion(LMDGetBlueValue(bv),LMDGetBlueValue(ev),dist,pos));
end;

{------------------------------------------------------------------------------}
function LMDFastIntDistance(x,y: integer): integer;
var
  mn: integer;
begin
  x := abs(x);
  y := abs(y);
  mn := Min(x,y);
  result := x+y - (mn shr 1) - (mn shr 2) + (mn shr 3);
end;

{------------------------------------------------------------------------------}
procedure LMDGradientPaint(DC : HDC; aRect:TRect; Color, EndColor:TColor;
                           ColorCount:TLMDColorCount; gStyle:TLMDGradientStyle;
                           flags:Word; pos:LongInt);
var
  ColorList:TList;
  Palette:HPalette;
begin
   ColorList:=TList.Create;
   Palette:=0;
   try
     LMDGradientCreateColorList(Color, EndColor, ColorCount, ColorList, true);
     if flags and DSF_PaletteRealize=DSF_PALETTEREALIZE then
       Palette := LMDGradientCreatePalette(ColorList);
     LMDGradientPaintExt(DC, aRect, gStyle, ColorList, Palette, flags, pos);
   finally
     if Palette <> 0 then
       DeleteObject(Palette);
     ColorList.Free;
   end;
end;

{------------------------------------------------------------------------------}
function LMDPoint(x, y: integer): TPoint;
begin
  result := Point(x, y);
end;

{------------------------------------------------------------------------------}
procedure LMDGradientPaintExt(DC: HDC; aRect:TRect; gStyle:TLMDGradientStyle;
                              ColorList:TList; Palette:HPalette; flags:Word; pos:LongInt);
var
  i, j, k, w, h, co:integer;
  bmp:TBitmap;
  lDC:HDC;
  Rgn:HRgn;
  temp, start:TRect;
  tmpRGB: COLORREF;
  FPaletteRealize, FUseBmp:Boolean;

  lBrush, lOldBrush: HBRUSH;
  lPen, lOldPen: HPEN;
  lColor: ColorRef;
  LPoints: array[0..3] of TPoint;

begin
  if (ColorList=nil) or (ColorList.Count=0) or IsRectEmpty(aRect) then
    exit;

  {Init}
  co := ColorList.Count;
  bmp := nil;
  Rgn := 0;
  w := aRect.Right - aRect.Left;
  h := aRect.Bottom - aRect.Top;

  FPaletteRealize:=(flags and DSF_PALETTEREALIZE = DSF_PALETTEREALIZE);
  if FPaletteRealize and (aoAutoRealizePalette in LMDApplication.Options) then
    if LMDSIColorDepth < 9 then FPaletteRealize := False;

  FUseBmp:=(flags and DSF_USEOFFSCREENBITMAP = DSF_USEOFFSCREENBITMAP);

  case gstyle of
    gstHorizontal,
    gstVertical: start:=Rect(0,0, w, h);
    gstSquare,
    gstElliptic: start:=Rect(w div 2, (h div 2), (w div 2), (h div 2));
    gstTopLeft:  start:=Rect(0,0,1,1);
    gstTopRight: start:=Rect(w,1,w+1,0);
    gstBottomLeft:start:=Rect(1,h,0,h+1);
    gstBottomRight:start:=Rect(w,h,w+1,h+1);
    gstTopLeftDiagonal:start:=Rect(0,0,1,1);
    gstTopRightDiagonal:start:=Rect(w,0,w+1,0);
  end;

  if FUseBmp then
    begin
      bmp := TBitmap.Create;
      bmp.Height := h;
      bmp.Width := w;
      lDC := bmp.Canvas.Handle;
    end
  else
    begin
      lDC := DC;
      if (flags and DSF_CLIPRECT) = DSF_CLIPRECT then
        begin
          if pos = 0 then
            Rgn := CreateRectRgnIndirect(aRect)
          else
            with aRect do
              Rgn := CreateRectRgn(LoWord(pos)+Left, HiWord(pos)+Top,
                                 LoWord(pos)+Right, HiWord(pos)+Bottom);
          SelectClipRgn(lDC, Rgn);
        end;
      OffsetRect(start, aRect.Left, aRect.top);
    end;

  try
      begin
        {PaletteRealize-Feature?}
        if FPaletteRealize then
          begin
            SelectPalette(lDC, Palette, False);
            RealizePalette(lDC);
          end;

        lPen := GetStockObject(NULL_PEN);
        lOldPen := SelectObject(lDC, lPen);

        {Horizontal is used for Captionbar -> Left side must be drawn first!}
        if gStyle=gstHorizontal then
          begin
            for i := 0 to co-1 do
              with temp do
                begin
                  temp:=Start;
                  tmpRGB:=ColorRef(ColorList[i]);
                  if FPaletteRealize then
                    lColor := PaletteRGB(GetRValue(tmpRGB),GetGValue(tmpRGB),GetBValue(tmpRGB))
                  else
                    lColor := tmpRGB;
                  temp:=Rect(Left+muldiv(i, w, co), Top,
                        Left+muldiv(i+1, w, co), Bottom);

                  lBrush := CreateSolidBrush(lColor);
                  Windows.FillRect(lDC, temp, lBrush);
                  DeleteObject(lBrush);
                end;
          end
        else
          {Main Loop}
          {----------------------------------------------------------------------}
          for i := co - 1 downto 0 do
            with temp do
              begin
                temp := Start;
                tmpRGB := COLORREF(ColorList[i]);
                if FPaletteRealize then
                  lColor := PaletteRGB(GetRValue(tmpRGB),GetGValue(tmpRGB),GetBValue(tmpRGB))
                else
                  lColor := tmpRGB;

                lBrush := CreateSolidBrush(lColor);
                lOldBrush := SelectObject(lDC, lBrush);

                case gStyle of
                  gstVertical:
                    begin
                      temp := Rect(Left, Top+muldiv(i, h, co),
                                 Right, Top+muldiv(i+1,h,co));
                      Windows.FillRect(lDC, temp, lBrush);
                    end;
                  gstSquare:
                    begin
                      j := muldiv((i+1), w, co) div 2;
                      k := muldiv((i+1), h, co) div 2;
                      Windows.Rectangle(lDC, Left-j, Top-k, Left+j+2, Top+k+2);
                    end;
                  gstElliptic:
                    begin
                      j := Round(muldiv((i+1), w, co)/1.4);
                      k := Round(muldiv((i+1), h, co)/1.4);
                      Windows.Ellipse(lDC, Left-j, Top-k, Left+j, Top+k);
                    end;
                  gstTopLeft..gstBottomRight:
                    begin
                      j := muldiv((i+1), w, co);
                      k := muldiv((i+1), h, co);
                      case gStyle of
                        gstTopLeft:
                          Windows.Rectangle(lDC, Left, Top, Right + j, Bottom+k);
                        gstTopRight:
                          Windows.Rectangle(lDC, Left - j, top + k, Right, Bottom);
                        gstBottomLeft:
                          Windows.Rectangle(lDC, Left + j, top - k, Right, Bottom);
                        gstBottomRight:
                          Windows.Rectangle(lDC, Left - j, Top - k, Right, Bottom);
                      end;
                    end;
                  gstTopLeftDiagonal, gstTopRightDiagonal:
                    begin
                      j := muldiv((i + 1), w, co) * 2;
                      k := muldiv((i + 1), h, co) * 2;

                      case gStyle of
                        gstTopLeftDiagonal:
                          begin
                            LPoints[0] := LMDPoint(Left, Top);
                            LPoints[1] := LMDPoint(Left + j, Top);
                            LPoints[2] := LMDPoint(Left, Bottom + k);
                            LPoints[3] := LMDPoint(Left - j, Bottom + k);
                            Polygon(DC, LPoints, High(LPoints) + 1);
                          end;
                        gstTopRightDiagonal:
                          begin
                            LPoints[0] := LMDPoint(Right, Top);
                            LPoints[1] := LMDPoint(Right - j, Top);
                            LPoints[2] := LMDPoint(Right, Bottom + k);
                            LPoints[3] := LMDPoint(Right + j, Bottom + k);
                            Polygon(DC, LPoints, High(LPoints) + 1);
                          end;
                      end;
                    end;
                end;
                SelectObject(lDc, lOldBrush);
                DeleteObject(lBrush);
              end;

        {----------------------------------------------------------------------}
        if FPaletteRealize then
          begin
            SelectPalette(lDC, Palette, False);
            RealizePalette(lDC);
          end;

        if FUseBmp then
          BitBlt(DC, aRect.Left, aRect.Top, w, h, lDc, 0, 0, SRCCOPY);

        SelectObject(lDC, lOldPen);
        //DeleteObject(lPen);

      end;
    finally
      if FUseBmp then
        bmp.Free;
      if Rgn <> 0 then
        if DeleteObject(Rgn) then
          SelectClipRgn(lDC, 0);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDGradientPaintExt(aCanvas:TCanvas; aRect:TRect; gStyle:TLMDGradientStyle;
                              ColorList:TList; Palette:HPalette; flags:Word; pos:LongInt);

var
  i, j, k, w, h, co:integer;
  bmp:TBitmap;
  tmpCanvas:TCanvas;
  Rgn:HRgn;
  temp, start:TRect;
  tmpRGB: COLORREF;//LongInt;
  FPaletteRealize, FUseBmp:Boolean;

begin

  if (ColorList=nil) or (ColorList.Count=0) or IsRectEmpty(aRect) then exit;

  {Init}
  co:=ColorList.Count;
  bmp:=nil;
  Rgn:=0;
  w:=aRect.Right-aRect.Left;
  h:=aRect.Bottom-aRect.Top;

  FPaletteRealize:=(flags and DSF_PALETTEREALIZE = DSF_PALETTEREALIZE);
  if FPaletteRealize and (aoAutoRealizePalette in LMDApplication.Options) then
    if LMDSIColorDepth<9 then FPaletteRealize:=False;

  FUseBmp:=(flags and DSF_USEOFFSCREENBITMAP = DSF_USEOFFSCREENBITMAP);

  case gstyle of
    gstHorizontal,
    gstVertical: start:=Rect(0,0, w, h);
    gstSquare,
    gstElliptic: start:=Rect(w div 2, (h div 2), (w div 2), (h div 2));
    gstTopLeft:  start:=Rect(0,0,1,1);
    gstTopRight: start:=Rect(w,1,w+1,0);
    gstBottomLeft:start:=Rect(1,h,0,h+1);
    gstBottomRight:start:=Rect(w,h,w+1,h+1);
    gstTopLeftDiagonal:start:=Rect(0,0,1,1);
    gstTopRightDiagonal:start:=Rect(w,0,w+1,0);
(*    gstRadial:begin
                start:=Rect(0,0,1,1);
                stepx := (2*w+2*h) div co + 3;
                while stepx * co < 2*w+2*h do
                  inc(stepx);
                side:=0;
              end;*)
  end;

  //j:=w;k:=h; removed, not used according to compiler

  if FUseBmp then
    begin
      bmp:=TBitmap.Create;
      bmp.Height:=h;
      bmp.Width:=w;
      tmpCanvas:=bmp.Canvas;
    end
  else
    begin
      tmpCanvas:=aCanvas;
      if flags and DSF_CLIPRECT = DSF_CLIPRECT then
        begin
          if pos=0 then
            Rgn:=CreateRectRgnIndirect(aRect)
          else
            with aRect do
              Rgn:=CreateRectRgn(LoWord(pos)+Left, HiWord(pos)+Top,
                                 LoWord(pos)+Right, HiWord(pos)+Bottom);
          SelectClipRgn(tmpCanvas.Handle, Rgn);
        end;
      OffsetRect(start, aRect.Left, aRect.top);
    end;

  try
    with tmpCanvas do
      begin

        {PaletteRealize-Feature?}
        if FPaletteRealize then
          begin
            SelectPalette(tmpCanvas.Handle, Palette, False);
            RealizePalette(tmpCanvas.Handle);
          end;

        brush.style:=bsSolid;
        pen.Style:=psClear;

        {Horizontal is used for Captionbar -> Left side must be drawn first!}
        if gStyle=gstHorizontal then
          begin
            for i := 0 to co-1 do
              with temp do
                begin
                  temp:=Start;
                  tmpRGB:=ColorRef(ColorList[i]);
                  if FPaletteRealize then
                    Brush.Color := PaletteRGB(GetRValue(tmpRGB),GetGValue(tmpRGB),GetBValue(tmpRGB))
                  else
                    Brush.Color := tmpRGB;
                  temp:=Rect(Left+muldiv(i, w, co), Top,
                        Left+muldiv(i+1, w, co), Bottom);
                        Windows.FillRect(tmpCanvas.Handle, temp, brush.Handle);
                end;
          end
        else

          {Main Loop}
          {----------------------------------------------------------------------}
          for i := co-1 downto 0 do
            with temp do
              begin
                temp:=Start;
                tmpRGB := COLORREF(ColorList[i]);
                if FPaletteRealize then
                  Brush.Color := PaletteRGB(GetRValue(tmpRGB),GetGValue(tmpRGB),GetBValue(tmpRGB))
                else
                  Brush.Color := tmpRGB;

                case gStyle of
                  gstVertical:
                    begin
                      temp:=Rect(Left, Top+muldiv(i, h, co),
                                 Right, Top+muldiv(i+1,h,co));
                      Windows.FillRect(tmpCanvas.Handle, temp, brush.Handle);
                    end;
                  gstSquare:
                    begin
                      j:=muldiv((i+1), w, co) div 2;
                      k:=muldiv((i+1), h, co) div 2;
                      Windows.Rectangle(tmpCanvas.Handle, Left-j, Top-k, Left+j+2, Top+k+2);
                    end;
                  gstElliptic:
                    begin
                      j:=Round(muldiv((i+1), w + 1, co)/1.4);
                      k:=Round(muldiv((i+1), h + 1, co)/1.4);
                      Windows.Ellipse(tmpCanvas.Handle, Left-j, Top-k, Left+j, Top+k);
                    end;
                  gstTopLeft..gstBottomRight:
                    begin
                      j:=muldiv((i+1), w, co);
                      k:=muldiv((i+1), h, co);
                      case gStyle of
                        gstTopLeft:
                          Windows.Rectangle(tmpCanvas.Handle, Left, Top, Right+j, Bottom+k);
                        gstTopRight:
                          Windows.Rectangle(tmpCanvas.Handle, Left-j, top+k, Right, Bottom);
                        gstBottomLeft:
                          Windows.Rectangle(tmpCanvas.Handle, Left+j, top-k, Right, Bottom);
                        gstBottomRight:
                          Windows.Rectangle(tmpCanvas.Handle, Left-j, Top-k, Right, Bottom);
                      end;
                    end;
     (*             gstRadial:
                    begin
                      //w - width; h - height (2w+2h)
                      //2 * Pi * r
                      tmpCanvas.Polygon ([Point (w div 2, h div 2), Point (j, k),
                                          Point (Left, Bottom)]);

                      start.Left := j;
                      start.bottom := k;
                      if j > w then
                        begin
                          inc(side); j := w;
                        end;
                      if k < 0 then begin inc(side); k:=0; {(Abs(k) = zu weit nach oben }end;
                      if j < 0 then begin inc(side); j:=0; end;

                      case side of
                        0: dec(j, stepx );
                        1: dec(k, stepx );
                        2: inc(j, stepx );
                        3: inc(k, stepx );
                      end;
                    end;*)
                  gstTopLeftDiagonal, gstTopRightDiagonal:
                    begin
                      j:=muldiv((i+1), w, co)*2;
                      k:=muldiv((i+1), h, co)*2;

                      case gStyle of
                        gstTopLeftDiagonal:
                          tmpCanvas.Polygon ([Point (Left, Top), Point (Left + j, Top),
                                              Point (Left, Bottom + k), Point (Left - j, Bottom + k)]);
                        gstTopRightDiagonal:
                          tmpCanvas.Polygon ([Point (Right, Top), Point (Right - j, Top),
                                              Point (Right, Bottom + k), Point (Right + j, Bottom + k)]);

                      end;
                    end;
                end;

              end;

        {----------------------------------------------------------------------}

        if FPaletteRealize then
          begin
            SelectPalette(aCanvas.Handle, Palette, False);
            RealizePalette(aCanvas.Handle);
          end;

        if FuseBmp then
          aCanvas.Draw(aRect.Left, aRect.Top, bmp);

      end;
    finally
      if FUseBmp then bmp.Free;
      if Rgn<>0 then
        if DeleteObject(Rgn) then SelectClipRgn(aCanvas.Handle, 0);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDGradientPaint(aCanvas:TCanvas; aRect:TRect; Color, EndColor:TColor;
                           ColorCount:TLMDColorCount; gStyle:TLMDGradientStyle;
                           flags:Word; pos:LongInt);
var
  ColorList:TList;
  Palette:HPalette;
begin
   ColorList:=TList.Create;
   Palette:=0;
   try
     LMDGradientCreateColorList(Color, EndColor, ColorCount, ColorList, true);
     if flags and DSF_PaletteRealize=DSF_PALETTEREALIZE then
       Palette:=LMDGradientCreatePalette(ColorList);
     LMDGradientPaintExt(aCanvas, aRect, gStyle, ColorList, Palette, flags, pos);
   finally
     if Palette<>0 then DeleteObject(Palette);
     ColorList.Free;
   end;
end;

{------------------------------------------------------------------------------}
procedure LMDSuperGradientPaint(aCanvas:TCanvas; aRect:TRect; Color : array of TColor;
                           ColorCount:TLMDColorCount; gStyle:TLMDGradientStyle;
                           flags:Word; pos:LongInt);
var
  i : Integer;
  ColorList : TList;
begin
  ColorList := TList.Create;
  try
    for i := 0 to High (Color) - 1 do
      LMDGradientCreateColorList(Color[i], Color[i+1], ColorCount div (High (Color)), ColorList, false);
    LMDGradientPaintExt(aCanvas, aRect, gStyle, ColorList, 0, flags, pos);
  finally
    ColorList.Free;
  end;
end;

{********************** Routines - Font ***************************************}
{------------------------------------------------------------------------------}
function LMDAlignRect(Alignment:TLMDAlignment; srcRect, destRect:TRect):TRect;
var
  sw, sh, dw, dh:Integer;
begin
  LMDGetRectWH(srcRect, sw, sh);
  LMDGetRectWH(destRect, dw, dh);
  case Alignment of
    agTopLeft, agTopCenter, agTopRight:result.Top:=0;
    agCenterLeft, agCenter, agCenterRight:result.Top:=(dh-sh) div 2;
    agBottomLeft, agBottomCenter, agBottomRight:result.Top:=dh-sh;
  end;
  case Alignment of
    agTopLeft, agCenterLeft, agBottomLeft:result.Left:=0;
    agTopCenter, agCenter, agBottomCenter:result.Left:=(dw-sw) div 2;
    agTopRight, agCenterRight, agBottomRight:result.Left:=dw-sw;
  end;
  with result do result:=Bounds(destRect.Left+Left, destRect.Top+Top, sw, sh);
end;

{------------------------------------------------------------------------------}
function LMDAlignTextRect(Alignment:TLMDAlignment; const aString:String;
                          Effects:TLMD3DCaption; aRect:TRect;
                          Font:TFont; MultiLine, Accel:Boolean; flags:Longint):TRect;
var
  nRect:TRect;
begin
  nRect:=aRect; Dec(nRect.Right);
  LMDDrawTextCalc(aString, effects, nRect, Font, MultiLine,
                  Accel, 0, flags);
  result:=LMDAlignRect(Alignment, nRect, aRect);
end;

{draws the nice 3D-Font-Effects}
{------------------------------------------------------------------------------}
procedure LMDDrawTextExt(aCanvas:TCanvas; const aString: TLMDString;
                         Effects:TLMD3DCaption; aRect:TRect; flags:LongInt;
                         Extflags:TLMDDrawTextStyles; NRect:PRect);

var

  {$IFDEF LMD_UNICODE}
  LogRec: TLOGFONTW;
  LogRecA: TLOGFONT;
  {$ELSE}
  LogRec: TLOGFONT;
  {$ENDIF}

  Rgn, Rgn1: HRgn;
  tempcol:TColor;
  tempStyle:TLMDThreeDStyle;
  temp:TRect;
  flag:Byte;
  hr, x,y,i,j:Integer;
  x1, y1: integer;
  dx, dy: integer;
  lIsFxCaption, lZeroTracing: boolean;
  s: TLMDString;

   Procedure DrawC(aMoveX, aMoveY:Integer;aColor:TColor);
      var i, j: integer;
          lr: TRect;
          cta: integer;
          r, rx, ry: double;
          lUseExtTextOut: boolean;
      begin
        cta := 0;
        aCanvas.Font.Color:=aColor;
        OffsetRect(temp, aMoveX, aMoveY);
        if (flag < 2) and lZeroTracing then
          {$IFDEF LMD_UNICODE}
          begin
            if LMDSIWindowsNTUp and not LMDApplication.ForceAnsi then
              DrawTextExW(aCanvas.Handle, int_RefW(aString), Length(aString), temp, flags, nil)
            else
              DrawTextEx(aCanvas.Handle, int_Ref(aString), Length(aString), temp, flags, nil);
              //LMDDrawTextW(aCanvas.Handle, int_RefW(aString), Length(aString), temp, flags);
          end
          {$ELSE}
          DrawTextEx(aCanvas.Handle, int_Ref(aString), Length(aString), temp, flags, nil)
          {$ENDIF}
        else
          begin
            lr := temp;
            lUseExtTextOut := ((flags and DT_SINGLELINE) = 0) and (Pos(#10, aString) > 0);
            //rect adjustment for alignments other than LEFT
            if ((flags and (DT_CENTER or DT_RIGHT)) <> 0) and (lUseExtTextOut or not lZeroTracing) then
              begin
                rx := 0;
                ry := 0;
                if (flags and DT_CENTER) = DT_CENTER then
                  begin
                    rx := (arect.right - arect.left) / 2;
                    ry := (arect.bottom - arect.top) / 2;
                    cta := SetTextAlign(aCanvas.Handle, TA_CENTER);
                  end;
                if (flags and DT_RIGHT) = DT_RIGHT then
                  begin
                    rx := (arect.right - arect.left);
                    ry := (arect.bottom - arect.top);
                    cta := SetTextAlign(aCanvas.Handle, TA_RIGHT);
                  end;
                if lIsFxCaption then
                  with TLMDFXCaption(Effects) do
                    begin
                      r := max(rx, ry);
                      dx := round(r * cos(Angle*pi/180));
                      dy := -round(r * sin(Angle*pi/180));
                    end
                  else
                    begin
                      dx := round(rx);
                      dy := 0;
                    end;
                OffsetRect(lr, dx, dy);
              end;
            if lUseExtTextOut then
              with Effects, lr  do
                begin
                  j := 1;
                  for i := 1 to Length(aString) do
                    if aString[i] = #10 then
                      begin
                        s := Copy(aString, j, i - j - 1);
                        x1 := aCanvas.TextWidth(s + ' ');
                        y1 := aCanvas.TextHeight(s);
                        if lIsFxCaption then
                          with TLMDFXCaption(effects) do
                            begin
                              dx := round(y1*sin(Angle*pi/180));
                              dy := round(y1*cos(Angle*pi/180));
                            end
                          else
                            begin
                              dx := 0;
                              dy := round(y1);
                            end;
                        Right := Left + x1;
                        Bottom := Top + y1;
                        j := i + 1;
                        {$IFDEF LMD_UNICODE}
                        if LMDSIWindowsNTUp and not LMDApplication.ForceAnsi  then
                          ExtTextOutW(aCanvas.Handle, Left, Top, 0{ETO_CLIPPED}, @aRect, int_RefW(s), Length(s), nil)
                        else
                          ExtTextOut(aCanvas.Handle, Left, Top, 0{ETO_CLIPPED}, @aRect, int_Ref(s), Length(s), nil);
                          //LMDDrawTextW(aCanvas.Handle, int_RefW(s), Length(s), aRect, flags);
                        {$ELSE}
                        ExtTextOut(aCanvas.Handle, Left, Top, 0{ETO_CLIPPED}, @aRect, int_Ref(s), Length(s), nil);
                        {$ENDIF}
                        OffsetRect(lr, dx, dy);
                      end;

                  s := Copy(aString, j, Length(aString) - j + 1) {+ ' '};
                  if j = 1 then
                    x1 := aCanvas.TextWidth(aString) //one line
                  else
                    x1 := aCanvas.TextWidth(s); //last line
                  lr.Right := lr.Left + x1;
                  {$IFDEF LMD_UNICODE}
                  if LMDSIWindowsNTUp and not LMDApplication.ForceAnsi  then
                    ExtTextOutW(aCanvas.Handle, Left, Top, 0{ETO_CLIPPED}, @aRect, int_RefW(s), Length(s), nil)
                  else
                    ExtTextOut(aCanvas.Handle, Left, Top, 0{ETO_CLIPPED}, @aRect, int_Ref(s), Length(s), nil);
                    //LMDDrawTextW(aCanvas.Handle, int_RefW(s), Length(s), aRect, flags);
                  {$ELSE}
                  ExtTextOut(aCanvas.Handle, Left, Top, 0{ETO_CLIPPED}, @aRect, int_Ref(s), Length(s), nil);
                  {$ENDIF}
                end
            else
              begin
                //if there are line breaks but multiline = false then
                //exttextout renders them as blank/black squares instead of spaces.
                //maybe we should add some flag whether a replacement of #13#10 to spaces should be
                //done before rendering. VB Oct 2009
                {$IFDEF LMD_UNICODE}
                if LMDSIWindowsNTUp and not LMDApplication.ForceAnsi  then
                  ExtTextOutW(aCanvas.Handle, lr.Left, lr.Top, 0{ETO_CLIPPED}, @aRect, int_RefW(aString), Length(aString), nil)
                else
                  ExtTextOut(aCanvas.Handle, lr.Left, lr.Top, 0{ETO_CLIPPED}, @aRect, int_Ref(aString), Length(aString), nil);
                  //LMDDrawTextW(aCanvas.Handle, int_RefW(s), Length(s), aRect, flags);
                {$ELSE}
                ExtTextOut(aCanvas.Handle, lr.Left, lr.Top, 0{ETO_CLIPPED}, @aRect, int_Ref(aString), Length(aString), nil);
                {$ENDIF}
              end;
            if (flags and (DT_CENTER or DT_RIGHT)) <> 0 then
              SetTextAlign(aCanvas.Handle, cta);
          end;
      end;

begin
  x := 0; y := 0; j := 0; //happy compiler

  if (aString='') or IsRectEmpty(aRect) then
    exit;

  flag:=0;

  if effects=nil then
    begin
      {$IFDEF LMD_UNICODE}
      if LMDSIWindowsNTUp and not LMDApplication.ForceAnsi  then
        DrawTextExW(aCanvas.Handle, int_RefW(aString), Length(aString), aRect, Flags, nil)
      else
        DrawTextEx(aCanvas.Handle, int_Ref(aString), Length(aString), aRect, Flags, nil);
        //LMDDrawTextW(aCanvas.Handle, int_RefW(aString), Length(aString), aRect, Flags);
      {$ELSE}
      DrawTextEx(aCanvas.Handle, int_Ref(aString), Length(aString), aRect, Flags, nil);
      {$ENDIF}
      exit;
    end;

  lZeroTracing := (Effects.Tracing = 0);
  lIsFxCaption := effects is TLMDFxCaption;

  if lIsFxCaption then
    begin
      if (TLMDFXCaption(effects).Angle = 0) and lZeroTracing then
        flag:=1
      else
        flag:=2;
    end;

  Rgn:=0;
  Rgn1 := 0;
  hr := -1;
  if dtClip in ExtFlags then
    begin
      if NRect<>nil then
        Rgn:=CreateRectRgnIndirect(NRect^)
      else
        Rgn:=CreateRectRgnIndirect(aRect);
      Rgn1 := CreateRectRgn(0,0,0,0);
      hr := GetClipRgn(aCanvas.Handle, Rgn1);
      if hr = 1 then
        CombineRgn(Rgn, Rgn1, Rgn, RGN_OR);
      if Rgn<>0 then
        SelectClipRgn(aCanvas.Handle, Rgn);
    end;

  try
    with Effects do
      begin
        tempStyle:=Style;
        if (dtEnabled in ExtFlags) or (DisabledStyle=dsNone) then
          if Style in [tdPColorSunken, tdPColorRaised] then
            tempcol:=aCanvas.Brush.Color
          else
            tempcol:=aCanvas.Font.Color
        else
          begin
            tempcol:=clGrayText;
            case DisabledStyle of
              dsAuto:if dt3DDisabled in ExtFlags then tempStyle:=tdSunken;
              ds3d:tempStyle:=tdSunken;
            end;
          end;

        if flag > 0 then
          begin
            if Flag=2 then
              begin
                if lIsFxCaption and (TLMDFxCaption(Effects).Angle <> 0) then
                  begin
                    GetObject(aCanvas.Font.Handle, SizeOf(LogRec), @LogRec);
                    LogRec.lfEscapement:=TLMDFxCaption(Effects).Angle*10;
                    {$IFDEF LMD_UNICODE}
                    if LMDSIWindowsNTUp and not LMDApplication.ForceAnsi  then
                      aCanvas.Font.Handle:=CreateFontIndirectW(LogRec)
                    else
                      begin
                        GetObject(aCanvas.Font.Handle, SizeOf(LogRec), @LogRecA);
                        LogRecA.lfEscapement:=TLMDFxCaption(Effects).Angle*10;
                        aCanvas.Font.Handle := CreateFontIndirect(LogRecA);
                      end;
                    {$ELSE}
                    aCanvas.Font.Handle:=CreateFontIndirect(LogRec);
                    {$ENDIF}
                  end;
              end;
            if lIsFxCaption then
              with TLMDFxCaption(Effects), aRect do
                temp:=Rect(Left+PosX, Top+PosY, Right, Bottom);
          end
        else
          temp:=aRect;

        if Effects.Tracing<>0 then
          SetTextCharacterExtra(aCanvas.Handle,Effects.Tracing);

        if tempStyle in [tdExtrude, tdExtrudeEnh] then
          begin
            case Orientation of
              toTopLeft:begin x:=ShadowDepth;y:=ShadowDepth;end;
              toTopRight:
                begin
                  x:=-ShadowDepth;
                  y:=ShadowDepth;
                  OffsetRect(temp, ShadowDepth+1, 0);
                end;
              toBottomLeft:
                begin
                  x:=ShadowDepth;
                  y:=-ShadowDepth;
                  OffsetRect(temp, 0, ShadowDepth+1);
                end;
              toBottomRight:
                begin
                  x:=-ShadowDepth;
                  y:=-ShadowDepth;
                  OffsetRect(temp, ShadowDepth+1, ShadowDepth+1);
                end;
            end;
            if Abs(x)>Abs(y) then j:=Abs(x) else j:=Abs(y);
          end;

        aCanvas.Brush.Style:=bsClear;
        case tempStyle of
          //5.0
          tdOutline:begin
                      aCanvas.Pen.Style:=psSolid;
                      BeginPath(aCanvas.Handle);
                      DrawC(ShadowDepth Div 2,ShadowDepth Div 2,tempcol);
                      EndPath(aCanvas.Handle);
                      aCanvas.Pen.Color:=tempcol;
                      aCanvas.Pen.Width := ShadowDepth;
                      StrokePath(aCanvas.Handle);
                    end;
          //Jan --> New Styles
          tdExtrude:begin
                      for i := j downto 1 do
                        begin
                          if x>0 then x:=1 else x:=-1;
                          if y>0 then y:=1 else y:=-1;
                          DrawC(x,y, ShadowColor);
                        end;
                      DrawC(0,0, tempcol);
                    end;
          tdExtrudeEnh:
                    begin
                      for i := j downto 1 do
                        begin
                          if x>0 then x:=1 else x:=-1;
                          if y>0 then y:=1 else y:=-1;
                          DrawC(x,y, LMDGradientGetColor(ShadowColor, LightColor, i-1,j));
                        end;
                      DrawC(0,0, tempcol);
                    end;
          tdSunken:begin
                     Dec(temp.Right, LightDepth);
                     DrawC(LightDepth, LightDepth, LightColor);
                     DrawC(-LightDepth, -LightDepth, tempcol);
                   end;
          tdRaised:begin
                     Dec(temp.Right, LightDepth);
                     DrawC(0, 0, LightColor);
                     DrawC(LightDepth, LightDepth, tempcol);
                   end;
          tdShadow:begin
                     Dec(temp.Right, ShadowDepth);
                     DrawC(ShadowDepth, ShadowDepth, ShadowColor);
                     DrawC(-ShadowDepth, -ShadowDepth, tempcol);
                   end;
          tdSunkenShadow, tdPColorSunken:
                   begin
                     Dec(temp.Right, LightDepth+ShadowDepth);
                     DrawC(0, 0, ShadowColor);
                     DrawC(LightDepth+ShadowDepth, LightDepth+ShadowDepth, LightColor);
                     DrawC(-LightDepth, -LightDepth, tempcol);
                   end;
          tdRaisedShadow, tdPColorRaised:
                   begin
                     Dec(temp.Right, LightDepth+ShadowDepth);
                     DrawC(LightDepth+ShadowDepth,LightDepth+ShadowDepth, ShadowColor);
                     DrawC(-(LightDepth+ShadowDepth), -(LightDepth+ShadowDepth), LightColor);
                     DrawC(LightDepth, LightDepth, tempcol);
                   end;
        else
          DrawC(0,0,tempcol);
        end;
     end;
   finally
     if Rgn<>0 then
       begin
         DeleteObject(Rgn);
         if hr <> 1 then
           SelectClipRgn(aCanvas.Handle, 0)
         else
           SelectClipRgn(aCanvas.Handle, Rgn1);
       end;
     if Rgn1 <> 0 then
       DeleteObject(Rgn1);
     if Effects.Tracing<>0 then
       SetTextCharacterExtra(aCanvas.Handle, 0);
   end;

end;

{------------------------------------------------------------------------------}

{wrapper for LMDDrawTextExt}
{------------------------------------------------------------------------------}
procedure LMDDrawTextExt(aCanvas:TCanvas; const aString:TLMDString; Effects:TLMD3DCaption;
                      aRect:TRect; flags:Word);

begin
  LMDDrawTextExt(aCanvas, aString, Effects, aRect, flags, [dtEnabled], nil);
end;

{LMDDrawTextAndGlpyhExt}
{------------------------------------------------------------------------------}
function LMDDrawTextAndGlyphExt(
          aCanvas: TCanvas;
          const aString:TLMDString;
          Effects:TLMD3DCaption;     {Font must be already set!}
          aDest: TRect;
          srcCanvas: TCanvas;
          var srcRect:TRect;
          aMaskCanvas: TCanvas;      {--> next version, mask already included}
          TransColor:TColor;
          aLayout: TLMDGlyphTextLayout;
          MultiLine,
          Accel,
          Transparent:Boolean;
          ExtFlags:TLMDDrawTextStyles;
          flags:LongInt) : TLMDWhereRect;
var
  cRect,pRect,taRect,notDest, ret: TRect;
  tmpSpace, OffsetX_, cCount, pCount: integer;
  DrawArrow, GlyphEmpty, tmp, todraw: Boolean;

begin
  result.TextRect := Rect (0,0,0,0);
  result.GlyphRect := Rect (0,0,0,0);
  result.ArrowRect := Rect (0,0,0,0);

  OffsetX_:=0;
  cCount:=0;
  pCount:=0;
  tmp:=False;

  cRect:=Rect(0,0,0,0);
  pRect:=cRect;
  ret:=aDest;

  {ändern}
  GlyphEmpty:=((srcCanvas=nil) and not (dtGhostGlyph in ExtFlags)) or isRectEmpty(srcRect);

  if (aString='') xor GlyphEmpty then tmpSpace:=0 else tmpSpace:=aLayout.Spacing;

  // 7.01.10
  if GlyphEmpty then
    pRect:=Rect(0,0,0,0)
  else
    pRect:=Rect(0,0, srcRect.Right-srcRect.Left, srcRect.Bottom-srcRect.Top);

  if aString<>'' then
  begin
    cRect.Right:=Abs(Abs(aDest.Right-aDest.Left)-tmpSpace-pRect.Right);  // cRect.Right calculation changed
    LMDDrawTextCalc(aString, Effects, cRect, aCanvas.Font, MultiLine, Accel, 0, flags);
  end;
  // -------

  DrawArrow:=(aLayout is TLMDButtonLayout) and TLMDButtonLayout(aLayout).Arrow;
  toDraw:= not (dtCalculate in ExtFlags);
  if not todraw then
    Include(ExtFlags, dtRectGlyphText);

  {Arrow painting}
  if DrawArrow then
    with TLMDButtonLayout(aLayout) do
      {TP June 98 . RM}
      {if ((ArrowPosition in [apLeftGlyph, apRightGlyph]) and GlyphEmpty ) or
         ((ArrowPosition in [apLeftText, apRightText]) and (aString='')) then
        DrawArrow:=False
      else}
        begin
          {TP June 98 . j.gord}
          OffsetX_:=ArrowSize*2-1;
          case ArrowPosition of
            apLeftText,apRightText:
              cRect.Right:=cRect.Right+OffsetX_+ArrowIndent
            else
              pRect.Right:=pRect.Right+OffsetX_+ArrowIndent;
          end;
        end;

  {calculating rects}
  case aLayout.AlignText2Glyph of
    taLeft,taLeftTop, taRight, taRightTop:
      begin
        if LMDMax([cRect.Bottom,pRect.Bottom])>cRect.Bottom then
          begin
            cCount:=(LMDMax([cRect.Bottom,pRect.Bottom])-cRect.Bottom) div 2;
            pCount:=0;
          end
        else
          begin
            pCount:=(LMDMax([cRect.Bottom,pRect.Bottom])-pRect.Bottom) div 2;
            cCount:=0;
          end;
        taRect:=Rect(0,0,cRect.Right+tmpSpace+pRect.Right,
                     LMDMax([cRect.Bottom,pRect.Bottom]));
      end;
    taTop,taTopLeft, taBottom, taBottomLeft:
      begin
        if LMDMax([cRect.Right,pRect.Right])>cRect.Right then
          begin
            cCount:=(LMDMax([cRect.Right,pRect.Right])-cRect.Right) div 2;
            pCount:=0;
          end
        else
          begin
            pCount:=(LMDMax([cRect.Right,pRect.Right])-pRect.Right) div 2;
            cCount:=0;
          end;
        taRect:=Rect(0,0,LMDMax([cRect.Right,pRect.Right]),
                     cRect.Bottom+tmpSpace+pRect.Bottom);
      end;
  end;

  case aLayout.AlignText2Glyph of
    taLeft:
      begin
        OffsetRect(pRect,cRect.Right+tmpSpace,pCount);
        OffsetRect(cRect,0,cCount);
      end;
    taLeftTop:
      begin
        OffsetRect(pRect,cRect.Right+tmpSpace,0);
        OffsetRect(cRect,0,cCount);
      end;
    taRightTop:
      begin
        OffsetRect(cRect,pRect.Right+tmpSpace,cCount);
        // 01-07-2002 RM/KJS
        OffsetRect(pRect,0,1);
      end;
    taRight:
      begin
        OffsetRect(cRect,pRect.Right+tmpSpace,cCount);
  //Jan: InflateRect (!! -> textrect um glyphsize verkleinern)
        OffsetRect(pRect,0,pCount);
      end;
    taTop:
      begin
        OffsetRect(pRect,pCount,cRect.Bottom+tmpSpace);
        OffsetRect(cRect,cCount,0);
      end;
    taTopLeft:
      begin
        OffsetRect(pRect,0,cRect.Bottom+tmpSpace);
        OffsetRect(cRect,cCount,0);
      end;
    taBottom:
      begin
        OffsetRect(cRect,cCount,pRect.Bottom+tmpSpace);
        OffsetRect(pRect,pCount,0);
      end;
    taBottomLeft:
      OffsetRect(cRect,cCount,pRect.Bottom+tmpSpace);
  end;

  {final Alignment}
  if dtAutosize in ExtFlags then
   taRect:=LMDAlignRect(agTopLeft, taRect, aDest)
  else
    begin
      taRect:=LMDAlignRect(aLayout.Alignment, taRect, aDest);
      OffsetRect(cRect,taRect.Left+1,taRect.Top+1);{the +1 could be wrong...}
      OffsetRect(pRect,taRect.Left,taRect.Top);
      SubtractRect(notDest, aDest, cRect);
    end;

  if DrawArrow and (TLMDButtonLayout(aLayout).ArrowPosition=apLeftText) then
    OffsetRect(cRect,OffsetX_+TLMDButtonLayout(aLayout).ArrowIndent,0);

  {font was set before}
  aCanvas.Brush.Style:=bsClear;
  {Flags for DrawText}
  flags:=flags or DT_EXPANDTABS;

  if MultiLine then
    flags:=flags or DT_WORDBREAK or TLMDAlignFlags[aLayout.Alignment];

  {finally: absolute Offset forced by user}
  OffsetRect(cRect,aLayout.OffsetX,aLayout.OffsetY);
  OffsetRect(pRect,aLayout.OffsetX,aLayout.OffsetY);

  // 6.1: Limit output to destination target
  if dtRectClip in ExtFlags then
  begin
    if aDest.Right<cRect.Right then
      cRect.Right:=aDest.Right;
    if aDest.Bottom<cRect.Bottom then
      cRect.Bottom:=aDest.Bottom;
  end;

  if toDraw then
    LMDDrawTextExt(aCanvas, aString, Effects, cRect, flags, ExtFlags, nil);

  result.TextRect := cRect;

  if dtRectText in ExtFlags then
    begin
      ret:=cRect;
      InflateRect(ret, 1,1);
      tmp:=true;
    end;

  if DrawArrow then
    with TLMDButtonLayout(aLayout) do
      case ArrowPosition of
        apLeftText:
          if toDraw then
            LMDDrawTriangle(aCanvas, cRect.Left-(OffsetX_+ArrowIndent),
                            cRect.Top+((cRect.bottom-cRect.Top) div 2)-
                            (ArrowSize div 2), ArrowSize, ArrowColor, True, dtEnabled in ExtFlags);
        apRightText:
          if toDraw then
            if MultiLine then
              LMDDrawTriangle(aCanvas, cRect.Right-(ArrowSize+1),
                              cRect.Top+((cRect.bottom-cRect.Top) div 2)-
                              (ArrowSize div 2), ArrowSize, ArrowColor, True, dtEnabled in ExtFlags)
            else
              LMDDrawTriangle(aCanvas, cRect.Right-(OffsetX_)-1,
                              cRect.Top+((cRect.bottom-cRect.Top) div 2)-
                              (ArrowSize div 2), ArrowSize, ArrowColor, True, dtEnabled in ExtFlags);
        apLeftGlyph:
           OffsetRect(pRect,OffsetX_+ArrowIndent,0);
      end;

  if not GlyphEmpty then
    begin
      if toDraw and not (srcCanvas=nil) then
        begin

          if not Transparent then
            LMDBmpDrawExt(aCanvas, pRect, srcCanvas, srcRect, 0, TransColor, 0,  nil)
          else
            if aMaskCanvas=nil then
              LMDBmpDrawExt(aCanvas, pRect, srcCanvas, srcRect, DSF_TRANSPARENCY, TransColor, 0, nil)
            else
              LMDBmpDrawExt(aCanvas, pRect, srcCanvas, srcRect, DSF_TRANSPARENCY_MASK,
                            TransColor, 0, aMaskCanvas);
        end;
      if dtRectGlyph in ExtFlags then
        begin
          ret := pRect;
          tmp := True;
        end;
    end;

   result.GlyphRect := pRect;

   if dtRectGlyphText in ExtFlags then
     begin
       UnionRect(ret, pRect, cRect);
       InflateRect(ret,1,1);
       tmp:=True;
     end;

  UnionRect (result.CompleteRect, pRect, cRect);
  {--> Calculate does not work with TLMDButtonLayout at the moment}

  if DrawArrow and toDraw then
    with TLMDButtonLayout(aLayout) do
      case ArrowPosition of
        apLeftGlyph:
          LMDDrawTriangle(aCanvas, pRect.Left-(OffsetX_+ArrowIndent),
                          pRect.Top+((pRect.bottom-pRect.Top) div 2)-
                          ArrowSize div 2, ArrowSize, ArrowColor, True, dtEnabled in ExtFlags);
        apRightGlyph:
          LMDDrawTriangle(aCanvas, pRect.Right-(OffsetX_),
                          pRect.Top+((pRect.bottom-pRect.Top) div 2)-(ArrowSize div 2),
                          ArrowSize, ArrowColor, True, dtEnabled in ExtFlags);
      end;

  if not tmp then InFlateRect(ret, -1, -1);
  if not todraw then InflateRect(ret, 1,1);

  srcRect:=ret;
end;

{first wrapper for LMDDrawTextAndGlyphExt}
{------------------------------------------------------------------------------}
procedure LMDDrawTextAndGlyph(
          aCanvas: TCanvas;
          const aString:TLMDString;
          Effects:TLMD3DCaption;
          aDest: TRect;
          aGlyph: TBitmap;
          aGlyphMask: TBitmap;
          {Font ist auf ZielCanvas bereits gesetzt}
          aLayout: TLMDGlyphTextLayout;
          MultiLine,
          Accel,
          Transparent:Boolean;
          ExtFlags:TLMDDrawTextStyles;
          flags:LongInt);
var
  ts, tm: TCanvas;
  tr:     TRect;
  tc:     TColor;
begin
  if not Assigned(aGlyph) or (aGlyph.Empty) then
  begin
    ts:=nil;
    tr:=Rect(0,0,0,0);
    tc:=clNone;
  end
  else
  begin
    ts:=aGlyph.Canvas;
    tr:=Rect(0,0, aGlyph.Width, aGlyph.Height);
    tc:=aGlyph.TransparentColor;
  end;

  if not Assigned(aGlyphMask) then
    tm:=nil
  else
    tm:=aGlyphMask.Canvas;

  LMDDrawTextAndGlyphExt(aCanvas, aString, Effects, aDest, ts, tr, tm, tc,
                         aLayout, MultiLine, Accel, Transparent, ExtFlags, flags);
end;

{calculates dimensions of strings (normal, rotated, multiline)}
{------------------------------------------------------------------------------}
procedure LMDDrawTextCalc(const aString:TLMDString; Effects:TLMD3DCaption; var aRect:TRect;
                          Font:TFont; MultiLine, Accel:Boolean; BExt:Integer; flags:Longint);
var
  aCanvas:TCanvas;
begin
  aCanvas:=TCanvas.Create;
  try
    LMDDrawTextCalcExt(aCanvas, aString, Effects, aRect, Font, MultiLine, Accel,BExt, flags);
  finally
    aCanvas.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDDrawTextCalcExt(Canvas:TCanvas; const aString:TLMDString; Effects:TLMD3DCaption; var aRect:TRect;
                             Font:TFont; MultiLine, Accel:Boolean; BExt:Integer; flags:Longint);

var DC:HDC;
    flag:Byte;
    sn, cs:real;
    lBrCount, tw, th, xm, ym, dummy:Integer;
    buffer: TLMDString;
    Angle: TLMDAngle;

    Procedure CorrectRect;
      begin
        {Specials}
        //Jan --> New Styles
//        with TLMDFxCaption(Effects), aRect do
        with Effects, aRect do
          case Style of
            tdRaised, tdSunken:
              aRect:=Rect(Left, Top, Right+LightDepth, Bottom+LightDepth);
            tdShadow, tdExtrude, tdExtrudeEnh:
              aRect:=Rect(Left, Top, Right+ShadowDepth, Bottom+ShadowDepth);
            tdRaisedShadow, tdSunkenShadow, tdPColorRaised, tdPColorSunken:
              aRect:=Rect(Left, Top, Right+LightDepth+ShadowDepth, Bottom+LightDepth+ShadowDepth);
            tdOutline:
              aRect:=Rect(Left, Top, Right+ShadowDepth, Bottom+ShadowDepth);
          end;
      end;

   Procedure CalcRectSize;
     var
       i, j: integer;
     begin
       if Multiline and (Pos(#10, aString) > 0) then
         begin
           tw := 0;
           th := 0;
           j := 1;
           for i := 1 to Length(aString) do
             if aString[i] = #10 then
               begin
                 buffer := System.Copy(aString, j, i - j - 1);
                 tw := max(tw, LMDGetTextWidth(Canvas, buffer + ' '));
                 Inc(th, LMDGetTextHeight(Canvas, buffer));
                 j := i + 1;
                 inc(lBrCount);
               end;
           buffer := System.Copy(aString, j, Length(aString) - j + 1) + ' ';
           Inc(th, LMDGetTextHeight(Canvas, buffer)); //add last line height
           if j = 1 then
             tw := max(tw, LMDGetTextWidth(Canvas, aString)) //one line
           else
             tw := max(tw, LMDGetTextWidth(Canvas, buffer)); //last line
         end
       else
         begin
           tw := LMDGetTextWidth(Canvas, aString);
           th := LMDGetTextHeight(Canvas, aString);
         end;
       aRect := Rect(0, 0, tw, th);
     end;

begin
  flag := 0;
  if effects is TLMDFxCaption then
    if (TLMDFXCaption(effects).Angle = 0) then
      flag := 1
    else
      flag := 2;

  buffer := aString;
  DC := GetDC(0);
  try
    Canvas.Handle := DC;
    Canvas.Font := Font;
    lBrCount := 0;
    if  flag < 2 then //angle = 0 or effects is not TLMDFxCaption
      begin
        if (flag =1 ) and (effects is TLMDFxCaption) then
          TLMDFxCaption(Effects).SetPosXY(0,0);

        flags := flags or (DT_EXPANDTABS or DT_CALCRECT);

        if MultiLine then
          flags := flags or DT_WORDBREAK;
        //else                               //Added VB Oct 2009
        //  flags := flags or DT_SINGLELINE; //Outcommented because of problem with autosize month caption in LMDCalandar - todo: check

        if (Length(buffer)=0) or (Accel and (buffer='&')) then buffer:=' ';
        if not Accel then Flags := Flags or DT_NOPREFIX;

        if (Effects <> nil) and (Effects.Tracing <> 0) then
          begin
            SetTextCharacterExtra(Canvas.Handle, Effects.Tracing);
            // BTS #628 - Broken DrawTextEx functionality in several codepages (until Vista) and from Vista on
            CalcRectSize;
          end
        else
          {$IFDEF LMD_UNICODE}
          if LMDSIWindowsNTUp and not LMDApplication.ForceAnsi  then
            DrawTextExW(Canvas.Handle, int_RefW(buffer), Length(buffer), aRect, Flags, nil)
          else
            DrawTextEx(Canvas.Handle, int_Ref(buffer), Length(buffer), aRect, Flags, nil);
            //LMDDrawTextW(Canvas.Handle, int_RefW(buffer), Length(buffer), aRect, Flags);
          {$ELSE}
          DrawTextEx(Canvas.Handle, int_Ref(buffer), Length(buffer), aRect, Flags, nil);
          {$ENDIF}

        if Effects<>nil then
          CorrectRect;

        Inc(aRect.Right, 2*(BExt+1));
        Inc(aRect.Bottom, 2*(BExt+1));
      end
    else   //angle <> 0
      with Effects do
        begin
          if Effects.Tracing<>0 then
            SetTextCharacterExtra(Canvas.Handle, Effects.Tracing);

          CalcRectSize; //tw and th must be calculated in CalcRectSize

          if lBrCount > 0 then
            begin
              Inc(th, Canvas.TextHeight('W')); //Correction for rotation for more than one line
              aRect.Bottom := th;
            end;

          tw:=tw div 2;
          th:=th div 2;

          {3D-Effekte berücksichtigen}
          CorrectRect;

          {Ausmaß des rotierten Textes berechnen --> LMDTools}
          if  Effects is TLMDFxCaption  then
            Angle := TLMDFxCaption(Effects).Angle
          else
            Angle := 0;

          case Angle of
            0:  begin
                  sn := 0;
                  cs := 1;
                end;
            90: begin
                  sn := 1;
                  cs := 0;
                end;
            180: begin
                  sn := 0;
                  cs := -1;
                end;
            270: begin
                  sn := -1;
                  cs := 0;
                end
            else
              begin
                sn:=sin(Angle*pi/180);
                cs:=cos(Angle*pi/180);
              end;
          end; //case
          if (Angle <> 0) and (Angle <> 360) then
            LMDCalcRotRect(aRect, Angle);

          //Jan --> New Styles
          case Style of
            tdRaisedShadow, tdSunkenShadow, tdPColorRaised, tdPColorSunken:
              dummy:=((LightDepth+ShadowDepth) div 2) -1;
            tdSunken, tdRaised:
              dummy:=(LightDepth div 2)-1;
            tdShadow, tdExtrudeEnh, tdExtrude:
              dummy:=(ShadowDepth div 2)-1;
          else
            dummy:=0;
          end;

          if dummy<0 then dummy:=0;

          {Positionieren...}
          with aRect do
            begin
              xm:=left+(right-left) div 2;
              ym:=top +(bottom-top) div 2;

              if  Effects is TLMDFxCaption  then
                with  TLMDFxCaption(Effects) do
                  begin
                    PosX:=round(xm-tw*cs-th*sn)-dummy;
                    PosY:=round(ym+tw*sn-th*cs)-dummy;
                  end;

              Inc(Right, 2*(BExt+1));
              Inc(Bottom, 2*(BExt+1));
            end;
        end;
   finally
     Canvas.Handle := 0;
     ReleaseDC(0, DC);
   end;
end;

{------------------------------------------------------------------------------}
function LMDDrawBtnFaceExt(aControl: TWinControl; aCanvas:TCanvas;
  MouseIsOver: Boolean; var dRect:TRect;Style:TLMDUserButtonStyle;
  State:TLMDButtonState; flags:Word; aColor: TColor;
  aTheme: TLMDThemeMode=ttmNative):Boolean;
var
  tmpC:TColor;
  aRect: TRect;

  procedure drawFoc;
  begin
    InflateRect (aRect, -3, -3);
    if BDF_FOCUSED and flags=BDF_FOCUSED then
    begin
      aCanvas.Brush.Style:=bsSolid;
      Windows.SetTextColor(aCanvas.Handle, clBlack);
      DrawFocusRect(aCanvas.Handle, aRect);
    end;
  end;

  procedure drawToolBarButton;
  var
    button: TThemedToolBar;
    stateID: Byte;
  begin
    button := ttbButtonNormal;
    stateID := 0;
    if BDF_SPLIT and flags = BDF_SPLIT then
    begin
      button := ttbSplitButtonNormal;
      if BDF_SPLITPARTTWO and flags = BDF_SPLITPARTTWO then
        button := ttbSplitButtonDropDownNormal;
    end;
    if (BDF_MOUSEOVER and flags = BDF_MOUSEOVER) or MouseIsOver then
       if (State in [bsOptionSet]) then StateId := 5 {TS_HOTCHECKED-1} else stateId := 1 {TS_HOT-1};
    if (State in [bsOptionSet]) and (StateID <> 5) then stateId := 4; //TS_CHECKED -1
    if State in [bsDown, bsDisabledDown, bsDropDownOpen] then stateId := 2; // TS_PRESSED-1;
    if State in [bsDisabledDown, bsDisabledUp] then stateId := 3; //TS_DISABLED-1;
    button := TThemedToolBar(Ord(button) + stateId);
    LMDThemeServices.DrawElement(aTheme, aCanvas.Handle, button, aRect);
  end;

  procedure drawComboButton;
  var
    button: TThemedComboBox;
  begin
    button := tcDropDownButtonNormal;
    if (BDF_MOUSEOVER and flags = BDF_MOUSEOVER) or MouseIsOver then button := tcDropDownButtonHot;
    if State in [bsOptionSet, bsDown, bsDisabledDown, bsDropDownOpen] then button := tcDropDownButtonPressed;
    if State in [bsDisabledDown, bsDisabledUp] then button := tcDropDownButtonDisabled;
    LMDThemeServices.DrawElement(aTheme, aCanvas.Handle, button, aRect);
  end;

  procedure drawPushButton;
  var
    button: TThemedButton;
  begin
    button := tbPushButtonNormal;
    if BDF_DEFAULT and flags=BDF_DEFAULT then button := tbPushButtonDefaulted;
    if (BDF_MOUSEOVER and flags = BDF_MOUSEOVER) or MouseIsOver then button := tbPushButtonHot;
    if State in [bsOptionSet, bsDown, bsDisabledDown, bsDropDownOpen] then button := tbPushButtonPressed;
    if State in [bsDisabledDown, bsDisabledUp] then button := tbPushButtonDisabled;
    // [YB: This is not compatible with VCL styles] InflateRect (aRect,1,1); //without this a slight gray border is drawn left and top
    LMDThemeServices.DrawElement(aTheme, aCanvas.Handle, button, aRect);
  end;

begin
  {TLMDUserButtonStyle=(
                       ubsWin31,           // framed button, Win 31 style, CTLXP: standard button
                       ubsWin40,           // framed button, Win 40 style, CTLXP: standard button
                       ubsDelphi,          // framed button, Delphi style, CTLXP: standard button
                       ubsDelphiFlat,      // flat button, Delphi 1.0 Style, CTLXP: Tool button
                       ubsFlat,            // flat button, CTLXP: Tool button
                       ubsFlatUnColored,   // flat button without hot state, CTLXP: Tool button
                       ubsNavigator,       // flat button like ubsDelphiFlat, without hot state, CTLXP: Tool button
                       ubsExplorer,         // like ubsFlatUnColored, but transparent
                       ubsExplorerColored,  // like ubsflat, but transparent
                       ubsIntegrated,       // for use in other controls
                       ubsCombo,            // New in 7.0
                       ubsOffice,           // Office XP like button
                       ubsWin40Ext          // like Win40, but with hotstate in frame}

  if (BDF_CTLXP and flags = BDF_CTLXP) and (aTheme <> ttmNone) then   // this is for
  begin
    aRect := dRect;
    case Style of
      ubsWin31, ubsWin40, ubsDelphi, ubsIntegrated, ubsWin40Ext:
        drawPushButton;
      ubsCombo:
        drawComboButton;
     else
       drawToolBarButton;
    end; //of case
    drawFoc;
    dRect:=aRect;
    result:=True;
    exit;
  end;

  if Style in [ubsOffice, ubsOfficeTransp] then
  begin
     // Border:    $$00C66931
     // Down:      $00F7DFD6
     // Selected:  $00EFD3C6
     // HighLight: $00C65252
     aRect := dRect;
     tmpc  := aColor;

     if State in [bsOptionSet, bsDown, bsDisabledDown, bsDropDownOpen] then
       tmpc:=$00F7DFD6;
     if (BDF_MOUSEOVER and flags = BDF_MOUSEOVER) or MouseIsOver then
      if (State in [bsOptionSet]) then
        tmpc:=$00E0A88D
      else
        tmpc:=$00EFD3C6;
     //if (flags and BDF_DEFAULT=BDF_DEFAULT) then
     //  tmpc:=$00C65252;
     if tmpc=aColor then
     begin
       if Style=ubsOffice then
       begin
         aCanvas.Pen.Color:=aColor;
         aCanvas.Brush.Color:=aColor;
         aCanvas.Rectangle(aRect);
       end;
     end
     else
     begin
       aCanvas.Pen.Color:=$00C66931;
       aCanvas.Brush.Color:=tmpc;
       aCanvas.Rectangle(aRect);
     end;
     drawFoc;
     if State in [bsOptionSet, bsDown, bsDisabledDown, bsDropDownOpen] then
       OffsetRect(aRect,1,1);
     dRect:=aRect;
     result:=false;
     exit;
   end;

  // default paintings
  result := LMDDrawBtnFace(aCanvas, MouseIsOver, dRect, Style, State, flags, aColor)
end;

{------------------------------------------------------------------------------}
function LMDDrawBtnFace(aCanvas:TCanvas; MouseIsOver: Boolean; var dRect:TRect;Style:TLMDUserButtonStyle;
                          State:TLMDButtonState; flags:Word; aColor: TColor):Boolean;

  procedure RoundCorner(Rect:TRect);  {applies only to Win31}
  begin
   if Style=ubsWin31 then
     with aCanvas, Rect do
       begin
         Pixels[Left, Top]:=clBtnFace;
         Pixels[Left, Bottom-1]:=clBtnFace;
         Pixels[Right-1, Top]:=clBtnFace;
         Pixels[Right-1, Bottom-1]:=clBtnFace;
       end;
  end;

var
  DC:HDC;
  aRect:TRect;
  value:Byte;
  IsDown:Boolean;
  oldColor:TColor;
begin

  value:=Ord(Style)+1;  // we add 1, because bsAutoDetect is gone since LMD-Tools 7

  {The ubsDelphi-Style looks like the Delphi 1 SpeedButton}
  if (value=3) {and (BDF_SPEEDBUTTON and flags=BDF_SPEEDBUTTON)} then value:=5;
  {LMDButton looks like the Delphi 2 SpeedButton}
  if (value=2) and (BDF_SPEEDBUTTON and flags=0) then value:=3;
  if LMDDrawBtnIsFlat(Style) then value:=4;
  // unsIntegrated = ubsCombo
  if (value=11) then value:=10;

  {assure that the Canvas Handle is valid...}
  if aCanvas.Pixels[0,0]=clNone then ;
  DC:=aCanvas.Handle;

  if (State in [bsOptionSet]) then
    begin
      IsDown:=True;
      if not (Style in [ubsExplorer, ubsExplorerColored]) then
        begin
          if (value=4) and MouseIsOver then
            aCanvas.Brush.Color:=aColor
          else
            aCanvas.Brush.Bitmap:=LMDApplication.GetBrushBitmap(aColor);
          aCanvas.FillRect(dRect);
        end;
    end
  else if (State in [bsDown, bsDisabledDown, bsDropDownOpen]) then
    begin
      IsDown:=True;
      if not (Style in [ubsExplorer, ubsExplorerColored]) then
        begin
          aCanvas.Brush.Color:=aColor;
          aCanvas.FillRect(dRect);
        end;
    end
  else
    begin
      IsDown:=False;
      if not (Style in [ubsExplorer, ubsExplorerColored]) then
        begin
          aCanvas.Brush.Color:=aColor;
          aCanvas.FillRect(dRect);
        end;
    end;

  if (not IsDown) and ((BDF_FOCUSED and flags=BDF_FOCUSED) or
                       (BDF_DEFAULT and flags=BDF_DEFAULT)) then
    begin
      // 7.00.61, RM
      // -----------
      aCanvas.Pen.Color := clWindowFrame;
      aCanvas.Pen.Width := 1;
      aCanvas.Brush.Style := bsClear;
      aCanvas.Rectangle(dRect.Left, dRect.Top, dRect.Right, dRect.Bottom);
      { Replaced code:
      DrawEdge(DC, dRect, BDR_SUNKENOUTER, BF_TOPLEFT or BF_SOFT or flag);
      DrawEdge(DC, dRect, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);}
      // -----------
      if (Style=ubsWin31) and (BDF_ROUNDED and flags=BDF_ROUNDED) then
        begin
          RoundCorner(dRect);
          flags:=flags xor BDF_ROUNDED;
        end;
      InflateRect(dRect, -1,-1);
    end;

  aRect:=dRect;

  case value of
    1:{Win31}
      begin
       DrawEdge(DC, dRect, BDR_SUNKENOUTER, BF_TOPLEFT or BF_SOFT {or flag});
       DrawEdge(DC, dRect, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);

       if BDF_ROUNDED and flags=BDF_ROUNDED then RoundCorner(dRect);

       InflateRect(dRect, -1,-1);
       if IsDown then
         DrawEdge(DC, dRect, BDR_SUNKENINNER, BF_TOPLEFT {or BF_SOFT})
       else
         begin
           DrawEdge(DC, dRect, BDR_RAISEDINNER, BF_RECT or BF_ADJUST{ or BF_SOFT});
           DrawEdge(DC, dRect, BDR_RAISEDINNER, BF_RECT or BF_ADJUST {or BF_SOFT});
         end;
       InflateRect(aRect, -1,-1);
      end;

    2: {Win40 Command Button}
       {LMDDrawStdFrame(aCanvas,dRect,lsLowered, BF_RECT );}
      if not IsDown then
        LMDDrawStdFrame(aCanvas, dRect, lsRaisedspb, BF_RECT)
        {DrawEdge(DC, dRect, BDR_RAISED, BF_RECT)}
      else
        if BDF_EXTDOWNSTYLE and flags=BDF_EXTDOWNSTYLE then
          DrawEdge(DC, dRect, BDR_SUNKEN, BF_RECT)
        else
          {TP June 98 . Self}
          LMDDrawStdFrame(aCanvas,dRect,lsLowered, BF_RECT );
             {LMDDrawStdFrame(aCanvas,dRect,lsLoweredExt, BF_RECT );}
    3: {Win40 Button, Borland Style}
      if IsDown then
        with aCanvas do
          begin
            Pen.Style:=psSolid;
            Pen.Color:=clBlack;
            {Brush.Style:=bsClear;}
            Rectangle(dRect.Left,dRect.Top,dRect.Right,dRect.Bottom);
            (*DrawEdge(DC, dRect, BDR_SUNKENOUTER, BF_RECT {or BF_ADJUST} {or flag} or BF_SOFT);*)
            InflateRect(dRect,-1,-1);
            {DrawEdge(DC, dRect, BDR_SUNKENINNER, BF_TOPLEFT or BF_ADJUST);}
            Pen.Color:=clGray;
            Rectangle(dRect.Left,dRect.Top,dRect.Right,dRect.Bottom);
            InflateRect(dRect,1,1);
            Pen.Color:=clBlack;
            {Brush.Style:=bsSolid;}
          end
      else
        if BDF_FOCUSED and flags=BDF_FOCUSED then
          begin
            DrawEdge(DC, dRect, BDR_RAISEDOUTER, BF_SOFT or BF_RECT or BF_ADJUST {or flag});
            DrawEdge(DC, dRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT or BF_ADJUST);
          end
        else
          LMDDrawStdFrame(aCanvas, dRect, lsRaisedspb, BF_RECT);

    4: {like the InternetExplorer Button}
      begin
        if ((style=ubsNavigator) or (style=ubsDelphiFlat)) and (IsDown or MouseIsOver{(State=bsMouseOver)})then
          begin
            Rectangle(DC, dRect.Left, dRect.Top, dRect.Right, dRect.Bottom);
            InflateRect(dRect,-1,-1);
          end;
        if IsDown then
          DrawEdge(DC, dRect, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST {or flag})
        else
          if MouseIsOver{(State=bsMouseOver)} then
            DrawEdge(DC, dRect, BDR_RAISEDINNER, BF_RECT or BF_ADJUST {or flag})
          else
            if not (Style in [ubsExplorer, ubsExplorerColored]) then
              begin
                {aCanvas.pen.Color:=clBtnFace;}
                aCanvas.Brush.Color:=aColor;
                {with dRect do aCanvas.Rectangle(Left,Top,Right,Bottom);}
                aCanvas.FillRect(dRect);
              end;
      end;

    5: {Delphi 1 SpeedButton}
      with aCanvas do begin
        Pen.Style:=psSolid;
        Brush.Style:=bsClear;
        Pen.Color:=clBlack;
        Rectangle(dRect.Left,dRect.Top,dRect.Right,dRect.Bottom);
        if IsDown then
          begin
            Pen.Color:=clGray;
            MoveTo(dRect.Left+1,dRect.Top+1);
            LineTo(dRect.Right-1,dRect.Top+1);
            MoveTo(dRect.Left+1,dRect.Top+1);
            LineTo(dRect.Left+1,dRect.Bottom-1);
          end
        else
          begin
            InflateRect(dRect, -1, -1);
            DrawEdge(DC, dRect, BDR_RAISEDINNER, BF_RECT or BF_ADJUST {or flag});
            InflateRect(dRect, 1, 1);
          end;
      end;
    10 : { button like combo box btn }
      with aCanvas do
        if isDown then
          begin
            Pen.Color := clGray;
            Rectangle (dRect.Left, dRect.Top, dRect.Right, dRect.Bottom);
          end
        else
          begin
            Pen.Color := clBlack;
            Rectangle (dRect.Left, dRect.Top, dRect.Right, dRect.Bottom);
            Pen.Color := clBtnFace;
            MoveTo (dRect.Right - 2, dRect.Top);
            LineTo (dRect.Left, dRect.Top);
            LineTo (dRect.Left, dRect.Bottom-1);
            Pen.Color := clWhite;
            Rectangle (dRect.Left+1, dRect.Top+1, dRect.Right-1, dRect.Bottom-1);
            Pen.Color := clGray;
            MoveTo (dRect.Right - 2, dRect.Top + 1);
            LineTo (dRect.Right - 2, dRect.Bottom - 2);
            LineTo (dRect.Left, dRect.Bottom -2);
          end;
      14: begin
            if IsDown then
              //LMDDrawStdFrame(aCanvas, dRect, lsLoweredspb, BF_RECT)
              DrawEdge(DC, dRect, BDR_SUNKEN, BF_RECT)
            else
             if MouseIsOver{(State=bsMouseOver)} then
               LMDDrawStdFrame(aCanvas, dRect, lsRaisedspb, BF_RECT)
             else
               DrawEdge(DC, dRect, BDR_RAISEDINNER, BF_RECT or BF_ADJUST {or flag});
          end;

  end;

  if (BDF_FOCUSED and flags=BDF_FOCUSED) then
    begin
      dRect:=aRect;
      if IsDown then
        InflateRect(dRect, -4,-4)
      else
        InflateRect(dRect, -3,-3);
      aCanvas.Brush.Style:=bsSolid;
      oldColor:=Windows.GetTextColor(aCanvas.Handle);
      Windows.SetTextColor(aCanvas.Handle, clBlack);
      DrawFocusRect(aCanvas.Handle, dRect);
      Windows.SetTextColor(aCanvas.Handle, oldColor);
    end;

  InflateRect(aRect, -3, -3);
  if IsDown then OffsetRect(aRect,1,1);
  dRect:=aRect;
  result:=True;
end;

{------------------------------------------------------------------------------}
function LMDDrawBtnIsFlat(Style:TLMDUserButtonStyle):Boolean;
begin
  result:=Style in [ubsDelphiFlat, ubsFlat, ubsNavigator, ubsFlatUnColored, ubsExplorer, ubsExplorerColored];
end;

{------------------------------------------------------------------------------}
function LMDGet3DTextWidth(const aString:String; Effects:TLMD3DCaption; aFont:TFont):Integer;
var
  Extent:TSize;
  old:HFont;
  old2:Integer;
  DC:HDC;

begin
  result:=0;
  DC:=GetDC(0);
  try
    if effects=nil then exit;
    old:=SelectObject(DC, aFont.Handle);
    old2:=SetTextCharacterExtra(DC, Effects.Tracing);
    if GetTextExtentPoint(DC, int_Ref(aString), Length(aString), Extent) then
      result:=Extent.cX;
//     with TLMDFxCaption(Effects) do
     with Effects do
       case Style of
         tdRaised, tdSunken:
           Inc(result, LightDepth);
         tdShadow:
           Inc(result, ShadowDepth);
         tdRaisedShadow, tdSunkenShadow, tdPColorRaised, tdPColorSunken:
           Inc(result, LightDepth+ShadowDepth);
       end;
    SetTextCharacterExtra(DC, old2);
    SelectObject(DC, old);
  finally
    ReleaseDC(0, DC);
  end;
end;

{------------------------------------------------------------------------------}
function LMDGet3DTextHeight(Effects:TLMD3DCaption; aFont:TFont):Integer;
var
  Extent:TSize;
  old:HFont;
  DC:HDC;
begin
  result:=0;
  DC:=GetDC(0);
  try
    old:=SelectObject(DC, aFont.Handle);
    if GetTextExtentPoint(DC, 'W', 1, Extent) then result:=Extent.cY;
//     with TLMDFxCaption(Effects) do
     with Effects do
       case Style of
         tdRaised, tdSunken:
           Inc(result, LightDepth);
         tdShadow:
           Inc(result, ShadowDepth);
         tdRaisedShadow, tdSunkenShadow, tdPColorRaised, tdPColorSunken:
           Inc(result, LightDepth+ShadowDepth);
       end;
     SelectObject(DC, old);
  finally
    ReleaseDC(0, DC);
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDFillSolidRect(DC: HDC; Rect: TRect; Color: TColor);
var
  SaveC: COLORREF;
begin
  SaveC := GetBkColor(DC);
  SetBkColor(DC, Color);
  ExtTextOut(DC, 0, 0, ETO_OPAQUE, @Rect, nil, 0, nil);
  SetBkColor(DC, SaveC);
end;

{------------------------------------------------------------------------------}
procedure LMDFillSolidRect(DC: HDC; x, y, cx, cy: integer; Color: TColor);
var
  Rect: TRect;
  SaveC: COLORREF;
begin
  SaveC := GetBkColor(DC);
  SetBkColor(DC, Color);
  Rect := Classes.Rect(x, y, x + cx, y + cy);
  ExtTextOut(DC, 0, 0, ETO_OPAQUE, @Rect, nil, 0, nil);
  SetBkColor(DC, SaveC);
end;

{------------------------------------------------------------------------------}
procedure LMDDrawArrow(Canvas: TCanvas; Dir: TLMDArrowDir; R: TRect; Color: TColor; Enabled: boolean);
var
  FSavePenColor: TColor;
  DestRect: TRect;
begin
  FSavePenColor := Canvas.Pen.Color;
  if Enabled then
    Canvas.Pen.Color := Color
  else
    Canvas.Pen.Color := clBtnHighlight;
  case Dir of
    eadRight:
      begin
        if (R.Right - R.Left < 3) or (R.Bottom - R.Top < 6) then exit;
        LMDCenterRects(4, R.Right - R.Left, 7, R.Bottom - R.Top, DestRect);
        if not Enabled then
          OffsetRect(DestRect, R.Left + 1, R.Top + 1)
        else
          OffsetRect(DestRect, R.Left, R.Top);

        with Canvas do
        begin
          MoveTo(DestRect.Left, DestRect.Top);
          LineTo(DestRect.Left, DestRect.Top + 7);
          MoveTo(DestRect.Left + 1, DestRect.Top + 1);
          LineTo(DestRect.Left + 1, DestRect.Top + 6);
          MoveTo(DestRect.Left + 2, DestRect.Top + 2);
          LineTo(DestRect.Left + 2, DestRect.Top + 5);
          MoveTo(DestRect.Left + 3, DestRect.Top + 3);
          LineTo(DestRect.Left + 3, DestRect.Top + 4);
          if not Enabled then
          begin
            Canvas.Pen.Color := clBtnShadow;
            OffsetRect(DestRect, -1, -1);
            MoveTo(DestRect.Left, DestRect.Top);
            LineTo(DestRect.Left, DestRect.Top + 7);
            MoveTo(DestRect.Left + 1, DestRect.Top + 1);
            LineTo(DestRect.Left + 1, DestRect.Top + 6);
            MoveTo(DestRect.Left + 2, DestRect.Top + 2);
            LineTo(DestRect.Left + 2, DestRect.Top + 5);
            MoveTo(DestRect.Left + 3, DestRect.Top + 3);
            LineTo(DestRect.Left + 3, DestRect.Top + 4);
          end;
        end;
      end;
    eadUp:
      begin
        if (R.Right - R.Left < 6) or (R.Bottom - R.Top < 3) then exit;
        LMDCenterRects(7, R.Right - R.Left, 4, R.Bottom - R.Top, DestRect);
        if not Enabled then
          OffsetRect(DestRect, R.Left + 1, R.Top + 1)
        else
          OffsetRect(DestRect, R.Left, R.Top);
        with Canvas do
        begin
          //mdm - Decremented all "LineTo(DestRect.Left" by one to draw properly
          MoveTo(DestRect.Left, DestRect.Top + 3);
          LineTo(DestRect.Left + 7, DestRect.Top + 3);

          MoveTo(DestRect.Left + 1, DestRect.Top + 2);
          LineTo(DestRect.Left + 6, DestRect.Top + 2);

          MoveTo(DestRect.Left + 2, DestRect.Top + 1);
          LineTo(DestRect.Left + 5, DestRect.Top + 1);

          MoveTo(DestRect.Left + 3, DestRect.Top);
          LineTo(DestRect.Left + 4, DestRect.Top);
          if not Enabled then
          begin
            Canvas.Pen.Color := clBtnShadow;
            OffsetRect(DestRect, -1, -1);
            MoveTo(DestRect.Left, DestRect.Top + 3);
            LineTo(DestRect.Left + 7, DestRect.Top + 3);

            MoveTo(DestRect.Left + 1, DestRect.Top + 2);
            LineTo(DestRect.Left + 6, DestRect.Top + 2);

            MoveTo(DestRect.Left + 2, DestRect.Top + 1);
            LineTo(DestRect.Left + 5, DestRect.Top + 1);

            MoveTo(DestRect.Left + 3, DestRect.Top);
            LineTo(DestRect.Left + 4, DestRect.Top);
          end;
        end;
      end;
    eadLeft:
      begin
        if (R.Right - R.Left < 3) or (R.Bottom - R.Top < 6) then exit;
        LMDCenterRects(4, R.Right - R.Left, 7, R.Bottom - R.Top, DestRect);
        if not Enabled then
          OffsetRect(DestRect, R.Left + 1, R.Top + 1)
        else
          OffsetRect(DestRect, R.Left, R.Top);
        with Canvas do
        begin
          MoveTo(DestRect.Left + 3, DestRect.Top);
          LineTo(DestRect.Left + 3, DestRect.Top + 7);
          MoveTo(DestRect.Left + 2, DestRect.Top + 1);
          LineTo(DestRect.Left + 2, DestRect.Top + 6);
          MoveTo(DestRect.Left + 1, DestRect.Top + 2);
          LineTo(DestRect.Left + 1, DestRect.Top + 5);

          MoveTo(DestRect.Left, DestRect.Top + 3);
          LineTo(DestRect.Left, DestRect.Top + 4);
          if not Enabled then
          begin
            Canvas.Pen.Color := clBtnShadow;
            OffsetRect(DestRect, -1, -1);
            MoveTo(DestRect.Left + 3, DestRect.Top);
            LineTo(DestRect.Left + 3, DestRect.Top + 7);
            MoveTo(DestRect.Left + 2, DestRect.Top + 1);
            LineTo(DestRect.Left + 2, DestRect.Top + 6);
            MoveTo(DestRect.Left + 1, DestRect.Top + 2);
            LineTo(DestRect.Left + 1, DestRect.Top + 5);

            MoveTo(DestRect.Left, DestRect.Top + 3);
            LineTo(DestRect.Left, DestRect.Top + 4);
          end;
        end;
      end;
    eadDown:
      begin
        if (R.Right - R.Left < 6) or (R.Bottom - R.Top < 3) then exit;
        LMDCenterRects(7, R.Right - R.Left, 4, R.Bottom - R.Top, DestRect);
        if not Enabled then
          OffsetRect(DestRect, R.Left + 1, R.Top + 1)
        else
          OffsetRect(DestRect, R.Left, R.Top);
        with Canvas do
        begin
          MoveTo(DestRect.Left, DestRect.Top);
          LineTo(DestRect.Left + 7, DestRect.Top);

          MoveTo(DestRect.Left + 1, DestRect.Top + 1);
          LineTo(DestRect.Left + 6, DestRect.Top + 1);

          MoveTo(DestRect.Left + 2, DestRect.Top + 2);
          LineTo(DestRect.Left + 5, DestRect.Top + 2);

          MoveTo(DestRect.Left + 3, DestRect.Top + 3);
          LineTo(DestRect.Left + 4, DestRect.Top + 3);
          if not Enabled then
          begin
            Canvas.Pen.Color := clBtnShadow;
            OffsetRect(DestRect, -1, -1);

            MoveTo(DestRect.Left, DestRect.Top);
            LineTo(DestRect.Left + 7, DestRect.Top);

            MoveTo(DestRect.Left + 1, DestRect.Top + 1);
            LineTo(DestRect.Left + 6, DestRect.Top + 1);

            MoveTo(DestRect.Left + 2, DestRect.Top + 2);
            LineTo(DestRect.Left + 5, DestRect.Top + 2);

            MoveTo(DestRect.Left + 3, DestRect.Top + 3);
            LineTo(DestRect.Left + 4, DestRect.Top + 3);
          end;
        end;
      end;
  end;
  Canvas.Pen.Color := FSavePenColor;
end;

function LMDGetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
  begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
  end;

function LMDAlphaPixel(ASrcColor, ADstColor: TColor; AAlphaLevel: Double): TColor;

begin
   Result := clNone;
   AAlphaLevel := 1 - AAlphaLevel;
   with PColorRGB(@Result)^ do
   begin
     R := Round(PColorRGB(@ASrcColor)^.R * AAlphaLevel + ((1 - AAlphaLevel) * PColorRGB(@ADstColor)^.R));
     G := Round(PColorRGB(@ASrcColor)^.G * AAlphaLevel + ((1 - AAlphaLevel) * PColorRGB(@ADstColor)^.G));
     B := Round(PColorRGB(@ASrcColor)^.B * AAlphaLevel + ((1 - AAlphaLevel) * PColorRGB(@ADstColor)^.B));
     A := 0;
   end;
   Result := ColorToRGB(Result);
end;

procedure LMDDrawSmoothLine(ABitmap: TBitmap; AX1: Integer; AY1: Integer; AX2: Integer; AY2: Integer; AColor: TColor);
var

  x1, y1, x2, y2: Double;
  grad : Double;
  xd : Double;
  yd : Double;
  xgap : Double;
  xend : Double;
  yend : Double;
  yf : Double;
  brightness1 : Double;
  brightness2 : Double;
  x : Integer;
  ix1 : Integer;
  ix2 : Integer;
  iy1 : Integer;
  iy2 : Integer;
  WasExchange : Boolean;
  TmpReal : Double;

begin

  x1 := AX1;
  y1 := AY1;
  x2 := AX2;
  y2 := AY2;
  AColor := ColorToRGB(AColor);

  xd := x2 - x1;
  yd := y2 - y1;
  if (xd = 0) and (yd = 0) then
    Exit;

  if Abs(xd) > Abs(yd) then
    WasExchange := False
  else
  begin
    WasExchange := True;
    TmpReal := x1;
    x1 := y1;
    y1 := TmpReal;
    TmpReal := x2;
    x2 := y2;
    y2 := TmpReal;
    TmpReal := xd;
    xd := yd;
    yd := TmpReal;
  end;
  if x1 > x2 then
  begin
    TmpReal := x1;
    x1 := x2;
    x2 := TmpReal;
    TmpReal := y1;
    y1 := y2;
    y2 := TmpReal;
    xd := x2-x1;
    yd := y2-y1;
  end;
  grad := yd / xd;
  xend := Floor(x1 + 0.5);
  yend := y1 + grad * (xend-x1);
  xgap := 1 - Frac(x1 + 0.5);
  ix1 := Floor(x1 + 0.5);
  iy1 := Floor(yend);
  brightness1 := (1 - Frac(yend)) * xgap;
  brightness2 := Frac(yend) * xgap;
  if WasExchange then
  begin
    ABitmap.Canvas.Pixels[iy1, ix1] := LMDAlphaPixel(ABitmap.Canvas.Pixels[iy1, ix1], AColor, Brightness1);
    ABitmap.Canvas.Pixels[iy1 + 1, ix1] :=  LMDAlphaPixel(ABitmap.Canvas.Pixels[iy1 + 1, ix1], AColor, Brightness2);
  end
  else
  begin
    ABitmap.Canvas.Pixels[ix1, iy1] := LMDAlphaPixel(ABitmap.Canvas.Pixels[ix1, iy1], AColor, Brightness1);
    ABitmap.Canvas.Pixels[ix1, iy1 + 1] := LMDAlphaPixel(ABitmap.Canvas.Pixels[ix1, iy1 + 1], AColor, Brightness2);
  end;
  yf := yend + grad;
  xend := Floor(x2 + 0.5);
  yend := y2 + grad * (xend - x2);
  xgap := 1 - Frac(x2 - 0.5);
  ix2 := Floor(x2 + 0.5);
  iy2 := Floor(yend);
  brightness1 := (1 - Frac(yend)) * xgap;
  brightness2 := Frac(yend) * xgap;

  if WasExchange then
  begin
    ABitmap.Canvas.Pixels[iy2, ix2] := LMDAlphaPixel(ABitmap.Canvas.Pixels[iy1, ix1], AColor, Brightness1);
    ABitmap.Canvas.Pixels[iy2 + 1, ix2] :=  LMDAlphaPixel(ABitmap.Canvas.Pixels[iy2 + 1, ix2], AColor, Brightness2);
  end
  else
  begin
    ABitmap.Canvas.Pixels[ix2, iy2] := LMDAlphaPixel(ABitmap.Canvas.Pixels[iy1, ix1], AColor, Brightness1);
    ABitmap.Canvas.Pixels[ix2, iy2 + 1] :=  LMDAlphaPixel(ABitmap.Canvas.Pixels[ix2, iy2 + 1], AColor, Brightness2);
  end;

  x := ix1 + 1;

  while x <= ix2 - 1 do
  begin
    brightness1 := 1 - Frac(yf);
    brightness2 := Frac(yf);
    if WasExchange then
    begin
      ABitmap.Canvas.Pixels[Floor(yf), x] :=  LMDAlphaPixel(ABitmap.Canvas.Pixels[Floor(yf), x], AColor, Brightness1);
      ABitmap.Canvas.Pixels[Floor(yf) + 1, x] := LMDAlphaPixel(ABitmap.Canvas.Pixels[Floor(yf) + 1, x], AColor, Brightness2);
    end
    else
    begin
      ABitmap.Canvas.Pixels[x, Floor(yf)] := LMDAlphaPixel(ABitmap.Canvas.Pixels[x, Floor(yf)], AColor, Brightness1);
      ABitmap.Canvas.Pixels[x, Floor(yf) + 1] := LMDAlphaPixel(ABitmap.Canvas.Pixels[x, Floor(yf) + 1], AColor, Brightness2);
    end;
    yf := yf + grad;
    Inc(x);
  end;

end;

function LMDGetTextMetrics(DC: HDC; var TM: TLMDTextMetric): Boolean;
{$ifdef LMD_UNICODE}
var
  tma: tagTextMetricA;
{$ENDIF}
begin
{$ifdef LMD_UNICODE}
  if LMDSIWindowsNTUp then
    Result := GetTextMetricsW(DC, TM)
  else
    begin
      Result := GetTextMetricsA(DC, tma);
      tm.tmHeight := tma.tmHeight;
      tm.tmAscent := tma.tmAscent;
      tm.tmDescent := tma.tmDescent;
      tm.tmInternalLeading := tma.tmInternalLeading;
      tm.tmExternalLeading := tma.tmExternalLeading;
      tm.tmAveCharWidth := tma.tmAveCharWidth;
      tm.tmMaxCharWidth := tma.tmMaxCharWidth;
      tm.tmWeight := tma.tmWeight;
      tm.tmOverhang := tma.tmOverhang;
      tm.tmDigitizedAspectX := tma.tmDigitizedAspectX;
      tm.tmDigitizedAspectY := tma.tmDigitizedAspectY;
      tm.tmFirstChar := WideChar(tma.tmFirstChar);
      tm.tmLastChar := WideChar(tma.tmLastChar);
      tm.tmDefaultChar := WideChar(tma.tmDefaultChar);
      tm.tmBreakChar := WideChar(tma.tmBreakChar);
      tm.tmItalic := tma.tmItalic;
      tm.tmUnderlined := tma.tmUnderlined;
      tm.tmStruckOut := tma.tmStruckOut;
      tm.tmPitchAndFamily := tma.tmPitchAndFamily;
      tm.tmCharSet := tma.tmCharSet;
    end;
{$else}
  Result := GetTextMetricsA(DC, TM);
{$endif}
end;

initialization
  AlphaBlendFunc := nil;
  HMSILib := LoadLibrary(msimg32);
  if HMSILib <> 0 then
    begin
      AlphaBlendFunc := GetProcAddress(hMSILib,'AlphaBlend');
      TransparentBltFunc := GetProcAddress(hMSILib,'TransparentBlt');
    end;

finalization
  if hMSILib<>0 then
    FreeLibrary(hMSILib);
end.
