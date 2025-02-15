unit sGraphUtils;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, math, Buttons,
  {$IFDEF TNTUNICODE} TntGraphics, {$IFDEF D2006} WideStrUtils,{$ELSE} TntWideStrUtils,{$ENDIF} {$ENDIF}
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFNDEF ACHINTS} imglist, sMaskData, sCommonData, {$ENDIF}
  {$IFNDEF NOJPG}{$IFDEF TINYJPG}acTinyJpg,{$ELSE}Jpeg,{$ENDIF}{$ENDIF}
  acntTypes, acntUtils, sConst;


{$IFNDEF NOTFORHELP}
const
  MaxKernelSize = 16;

type
  TsHSV = record
    h: integer;
    s, v: real;
  end;
  TFilterType = (ftBox {fastest}, ftTriangle, ftHermite, ftBell {if Dest is smaller}, ftSpline, ftLanczos3 {Slowest}, ftMitchell);


  PByteArrays = ^TByteArrays;
  TByteArrays = array [0..1000000] of PByteArray;
  TKernelSize = 1..MaxKernelSize;

  TacDrawBorderData = record
    Bmp: TBitmap;
    R: TRect;
    gd: TsGeneralData;
    State: integer;
    CI: TCacheInfo;
    RadiusLT: integer;
    RadiusRT: integer;
    RadiusLB: integer;
    RadiusRB: integer;
  end;

procedure CopyBmp(DstBmp, SrcBmp: TBitmap);
procedure DrawCloseBtn(DC: hdc; R: TRect; State: integer);
procedure DrawColorArrow(const Canvas: TCanvas; const Color: TColor; R: TRect; const Direction: TacSide; PPI: integer); overload;
procedure DrawColorArrow(const aBmp: TBitmap;   const Color: TColor; R: TRect; const Direction: TacSide; PPI: integer); overload;

procedure DrawArrow(const aBmp: TBitmap; const Color1, Color2: TColor; R: TRect; const Direction: TacSide; LineWidth: integer; AngleShift: integer; ArrowSize: integer; Style: TacArrowsStyle; PPI: integer = 96); overload;
procedure DrawArrow(DC: hdc;             const Color1, Color2: TColor; R: TRect; const Direction: TacSide; LineWidth: integer; AngleShift: integer; ArrowSize: integer; Style: TacArrowsStyle; PPI: integer = 96); overload;

function InitLine(Bmp: TBitmap; var Line0: Pointer; var Delta: Integer): boolean;
function MakeAngledFont(DC: hdc; Font: TFont; Orient: integer): hFont;
procedure SetFontSmoothing(AFont: TFont);
function FontSizeIsNear(const BaseFont: TFont; const TestText: acString; const FontName: string): boolean;
// Alpha-blending of rectangle on bitmap by Blend, excluding pixels with color clFuchsia
procedure BlendTransRectangle(Dst: TBitmap; X, Y: integer; Src: TBitmap; aRect: TRect; Blend: byte; TransColor: TColor = clFuchsia); overload;
procedure BlendTransBitmap(Bmp: TBitmap; Blend: byte; const Color: TsColor); overload;

procedure PaintBmpMaskRect32(const DstBmp, SrcBmp, MaskBmp: Graphics.TBitMap; MaskRect: TRect; DstPoint: TPoint; SrcBlendValue: byte = MaxByte);
procedure PaintTranspBmpRect32(const DstBmp, SrcBmp, TranspBmp: Graphics.TBitMap; TranspColor: TColor; SrcRect: TRect; DstPoint, TranspPoint: TPoint; SrcBlendValue: byte = MaxByte);

function TryPaintBorder(aBmp: TBitmap; const aRect: TRect; aSkinData: TsCommonData; aState: integer; const aCI: TCacheInfo): boolean; overload;
function TryPaintBorder(aBmp: TBitmap; aRect: TRect; gd: TsGeneralData; aState: integer; const aCI: TCacheInfo; CustomBorderData: TacPaintBorderData; iPPI: integer; UpdateCornersProc: TacUpdateBorderProc): boolean; overload;
{$ENDIF} // NOTFORHELP

function SwapInteger(const i: integer): integer;
// Paint tiled TGraphic on bitmap
procedure TileBitmap(const Canvas: TCanvas; const aRect: TRect; const Graphic: TGraphic); overload;
procedure Stretch(const SrcBmp, DstBmp: TBitmap; const DstWidth, DstHeight: Integer; const Filter: TFilterType);//; const Param: Integer = 0);
procedure QBlur(Bmp: TBitmap);

{$IFNDEF ACHINTS}
procedure RGBToHSV(const R, G, B: Real; var H, S, V: Real);
procedure HSVtoRGB(const H, S, V: Real; var R, G, B: Real);
// Painting based on SkinSections
procedure PaintItemBG(SkinData: TsCommonData; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; OffsetX: integer = 0; OffsetY: integer = 0); overload;
procedure PaintItem(SkinData: TsCommonData; CI: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; UpdateCorners: boolean; OffsetX: integer = 0; OffsetY: integer = 0; ColorsAutoUpdate: boolean = True); overload;
function PaintSection(const Bmp: TBitmap; const Section, SecondSection: string; const State: integer; const CommonSkinData: TacObject; const ParentOffset: TPoint; const BGColor: TColor; ParentDC: hdc = 0): integer; overload;
function PaintSection(const Bmp: TBitmap; SectionIndex: integer; const SecondIndex: integer; const State: integer; const CommonSkinData: TacObject; const ParentOffset: TPoint; const BGColor: TColor; ParentDC: hdc = 0): integer; overload;

function PaintSkinControl(const SkinData: TsCommonData; const Parent: TControl; const Filling: boolean; State: integer; const R: TRect; const pP: TPoint; const ItemBmp: TBitmap; const UpdateCorners: boolean; const OffsetX: integer = 0; const OffsetY: integer = 0): boolean;
//
procedure PaintControlByTemplate(const DstBmp, SrcBmp: TBitmap; const DstRect, SrcRect, BorderWidths, BorderMaxWidths: TRect; const DrawModes: TRect; const StretchCenter: boolean; FillCenter: boolean = True);
procedure CopyChannel32(const DstBmp, SrcBmp: TBitmap; const Channel: integer); overload;
procedure CopyChannel32(const DstBmp, SrcBmp: TBitmap; const Channel: integer; DstRect, SrcRect: TRect); overload;
procedure CopyChannel(const Bmp32, Bmp8: TBitmap; const Channel: integer; const From32To8: boolean);

procedure DrawGlyphEx(Glyph, DstBmp: TBitmap; R: TRect; NumGlyphs: integer; Enabled: boolean; DisabledGlyphKind: TsDisabledGlyphKind; State, Blend: integer; Down: boolean = False; Reflected: boolean = False);
{$ENDIF}
// Fills rectangle on device context by Color
procedure FillDC(DC: HDC; const aRect: TRect; const Color: TColor; AlphaValue: integer = 0);
procedure FillDCBorder(const DC: HDC; const aRect: TRect; const wl, wt, wr, wb: integer; const Color: TColor; AlphaValue: integer = 0);
procedure BitBltBorder(const DestDC: HDC; const X, Y, Width, Height: Integer; const SrcDC: HDC; const XSrc, YSrc: Integer; WidthLeft: integer; WidthTop: integer = -1; WidthRight: integer = -1; WidthBottom: integer = -1);
// Grayscale bitmap
procedure GrayScale(Bmp: TBitmap);
procedure GrayScaleTrans(Bmp: TBitmap; const TransColor: TsColor);
function CutText(Canvas: TCanvas; const Text: acString; MaxLength: integer): acString;
// Writes text on Canvas on custom rectangle by Flags
procedure WriteText(Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal);
// Sum of bitmaps without alphachannels
procedure SumBitmaps(SrcBmp, MskBmp: Graphics.TBitMap; const AlphaValue: byte);
// Sum rects of bitmaps without alphachannels
procedure SumBmpRect(const DstBmp, SrcBmp: Graphics.TBitMap; const AlphaValue: byte; SrcRect: TRect; DstPoint: TPoint);
procedure SumBitmapsToDst(DstBmp, SrcBmp1, SrcBmp2: Graphics.TBitMap; const AlphaValue: byte);
procedure PaintBmp32(SrcBmp, MskBmp: Graphics.TBitMap);
procedure PaintBmpRect32(const DstBmp, SrcBmp: Graphics.TBitMap; SrcRect: TRect; DstPoint: TPoint; SrcBlendValue: byte = MaxByte);
//procedure StretchBmpRect32(const DstBmp, SrcBmp: Graphics.TBitMap; DstRect, SrcRect: TRect; SrcBlendValue: byte = MaxByte);
procedure StretchBmpRect32(const DstBmp: Graphics.TBitmap; XDst, YDst, DstWidth, DstHeight: Integer; SrcBmp: Graphics.TBitMap; XSrc, YSrc, SrcWidth, SrcHeight: Integer; SrcBlendValue: byte = MaxByte);
// Alpha-blending of rectangle on bitmap custom transparency, color, blur and radius
procedure FadeBmp(FadedBmp: TBitMap; aRect: TRect; Transparency: integer; const Color: TsColor; Blur, Radius: integer);
// Sum two bitmaps where Color used as mask
procedure BlendBmpByMask(SrcBmp, MskBmp: Graphics.TBitMap; const BlendColor: TsColor);
//procedure BlendBmpRectByMask(SrcBmp, MskBmp: Graphics.TBitMap; TopLeft: TPoint; const BlendColor: TsColor);
// Copying bitmap SrcBmp to DstBmp, excluding pixels with color TransColor
procedure CopyTransBitmaps(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; TransColor: TsColor);
// Sum two bitmaps by mask MskBmp
procedure SumByMaskWith32(const DstBmp, SrcBmp, MskBmp: Graphics.TBitMap; const aRect: TRect);
procedure ColorizeByMask(const DstBmp, MskBmp: TBitMap; TopLeft: TPoint; Color, BGColor: TColor);
// procedure SumByMask(var Src1, Src2, MskBmp: Graphics.TBitMap; aRect: TRect);
function MakeRotated90(var Bmp: TBitmap; CW: boolean; KillSource: boolean = True): TBitmap;
function sMakeRotated90(var Bmp: TBitmap; CW: boolean; KillSource: boolean = True): TBitmap;
procedure BitBltRotated(DC: hdc; SrcBmp: TBitmap; ACenter: TPoint; Angle: integer);

// Returns color as (ColorBegin + ColorEnd) / 2
function AverageColor(const ColorBegin, ColorEnd: TsColor): TsColor; overload;
function AverageColor(const ColorBegin, ColorEnd: TColor): TColor; overload;
function BlendColors(const Color1, Color2: TColor; const BlendOf1: byte): TColor;
// Draws rectangle on device context
procedure DrawRectangleOnDC(DC: HDC; var R: TRect; ColorTop, ColorBottom: TColor; var Width: integer; PSides: PacSides = nil);
// Returns height of font
function GetFontHeight(hFont: HWnd; NoLeading: boolean = False): integer;
// Returns width of text
function GetStringSize(hFont: hgdiobj; const Text: acString; Flags: Cardinal = 0; WrapText: boolean = False; MaxWidth: integer = MaxInt; IsItalic: boolean = False): TSize;
procedure LoadBmpFromPngFile(Bmp: TBitmap; const FileName: string);
procedure LoadBmpFromPngStream(Bmp: TBitmap; Stream: TStream);
procedure FocusRect(Canvas: TCanvas; R: TRect; LightColor: TColor = clBtnFace; DarkColor: TColor = clBlack);//{$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
{$IFNDEF NOTFORHELP}
procedure acDrawFocusRect(Canvas: TCanvas; const R: TRect);
procedure PaintTransBG(Bmp: TBitmap; R: TRect; Color1, Color2: TColor; Size: integer);
procedure MixDiagBmpRect(const DstBmp, SrcBmp: Graphics.TBitMap; SrcXShift: integer; SrcRect: TRect; DstPoint: TPoint);
{$IFNDEF ACHINTS}
procedure SetBmp32Pixels(var Bmp: TBitmap);
procedure ExcludeControls(const DC: hdc; const Ctrl: TWinControl; const OffsetX: integer; const OffsetY: integer);
procedure CalcButtonLayout(const Client: TRect; const GlyphSize: TPoint; const TextRectSize: TSize; Layout: TButtonLayout; Alignment: TAlignment;
  AMargin, Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect; BiDiFlags: LongInt; VerticalAlignment: TVerticalAlignment = taVerticalCenter);
procedure TileBitmap(Canvas: TCanvas; var aRect: TRect; Graphic: TGraphic; const MaskData: TsMaskData; FillMode: TacFillMode = fmTiled); overload;
procedure TileMasked(Bmp: TBitmap; var aRect: TRect; const CI: TCacheInfo; const MaskData: TsMaskData; FillMode: TacFillMode = fmDisTiled);

procedure AddRgn(var AOR: TRects; Width: integer; const MaskData: TsMaskData; VertOffset: integer; Bottom: boolean; iPadding: integer = 0); overload;
procedure AddRgn(var AOR: TRects; MaskBmp: TBitmap; MaskRect: TRect; DstWidth, WL, WT, WR, WB: integer;
  VertOffset: integer; IsBottom, Masked: boolean; TranspColor: TColor; iPadding: integer = 0); overload;

procedure AddRgnBmp(var AOR: TRects; MaskBmp: TBitmap; TransColor: TsColor);
procedure GetRgnFromBmp(var rgn: hrgn; MaskBmp: TBitmap; TransColor: TColor);
function GetBGInfo(const BGInfo: PacBGInfo; const Handle: THandle; aPleaseDraw: boolean = False): boolean; overload;
function GetBGInfo(const BGInfo: PacBGInfo; const Control: TControl; aPleaseDraw: boolean = False): boolean; overload;
function BGInfoToCI(const BGInfo: PacBGInfo): TCacheInfo;
{$ENDIF}
procedure SumBitmapsByMask(var DstBmp, Src1, Src2: Graphics.TBitMap; MskBmp: Graphics.TBitMap; Percent: word = 0);
// Copy Bmp with AlphaMask if Bmp2 is not MasterBitmap
procedure CopyByMask(DstRect, SrcRect: TRect; const DstBmp, SrcBmp: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean); overload;
procedure CopyByMask(DstRect, SrcRect: TRect; const DstBmp, SrcBmp: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean; const MaskData: TsMaskData); overload;
procedure CopyBmp32 (R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean; GrayedColor: TColor;
                    const Blend: integer; const Reflected: boolean);
// Copying rectangle from SrcBmp to DstBmp, excluding pixels with color TransColor (get trans pixels from parent)
procedure CopyTransRect(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect; TransColor: TColor; const CI: TCacheInfo; UpdateTrans: boolean);
// Skip transarent part
procedure CopyTransRectA(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect; TransColor: TColor; CI: TCacheInfo; const Blend: integer = 0);
// Creates bitmap like Bmp
function CreateBmpLike(const Bmp: TBitmap): TBitmap;
function CreateAlphaBmp(const SrcMaskedBmp: TBitmap; const SrcRect: TRect): TBitmap;
function CreateMaskFromAlpha(const SrcAlphaBmp: TBitmap): TBitmap;
procedure PrepareBmp(var Bmp: TBitmap; const Width: integer = 0; const Height: integer = 0);
function CreateBmp32(const Width: integer = 0; const Height: integer = 0): TBitmap; overload;
function CreateBmp32(const R: TRect): TBitmap; overload;
function CreateBmp32(const Size: TSize): TBitmap; overload;
function CreateBmp32(const Bmp: TBitmap): TBitmap; overload;
function CreateBmp32(const Ctrl: TControl): TBitmap; overload;
procedure CheckBmp(var BmpOut: TBitmap; SampleBmp: TBitmap);
procedure WriteTextOnDC(DC: hdc; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal);
function acDrawText(hDC: HDC; const Text: ACString; var lpRect: TRect; uFormat: Cardinal; Bmp: TBitmap = nil): Integer;
function acExtTextOut(DC: HDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PacChar; Count: Longint; Dx: PInteger): boolean;
function acTextWidth (const Canvas: TCanvas; const Text: ACString): Integer;
function acTextHeight(const Canvas: TCanvas; const Text: ACString): Integer;
function acTextExtent(const Canvas: TCanvas; const Text: ACString): TSize;
procedure acTextRect (const Canvas: TCanvas; const Rect: TRect; X, Y: Integer; const Text: ACString);

function acGetTextExtent(const DC: HDC; const Str: acString; var Size: TSize; AFont: HFONT = 0): BOOL;
function acGetTextExtentW(const DC: HDC; const Str: WideString; var Size: TSize; AFont: HFONT = 0): BOOL;

procedure acDrawGlowForText(const DstBmp: TBitmap; Text: PacChar; aRect: TRect; Flags: Cardinal; Side: Cardinal; BlurSize: integer; Color: TColor; var MaskBmp: TBitmap);
procedure acPaintLine(DC: hdc; X1, Y1, X2, Y2: integer);
procedure Blur8(Bmp: TBitmap; radius: double);
//procedure MakeRectOpaque(PaintBuffer: THandle; Rect: PRect = nil);

procedure acWriteTextEx(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal; const SkinData: TsCommonData; const Hot: boolean; const SkinManager: TObject = nil; CanGlow: boolean = True); overload;
procedure acWriteTextEx(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal; const SkinIndex: integer; const Hot: boolean; const SkinManager: TObject = nil); overload;
procedure acWriteText(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal);

{$IFNDEF ACHINTS}
procedure WriteTextEx(const Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil); overload;
procedure WriteTextEx(const Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean; SkinManager: TObject = nil; CanGlow: boolean = True); overload;
{$IFDEF TNTUNICODE}
procedure WriteUnicode(const Canvas: TCanvas; const Text: WideString; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean); overload;
procedure WriteTextExW(const Canvas: TCanvas; Text: PWideChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean; CanGlow: boolean = True); overload;
// replace function of Canvas.TextRect
procedure TextRectW(const Canvas: TCanvas; var Rect: TRect; X, Y: Integer; const Text: WideString);
procedure WriteTextExW(const Canvas: TCanvas; Text: PWideChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil); overload;
{$ENDIF}

procedure PaintItemBG(SkinIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TComponent; TextureIndex: integer = -1; HotTextureIndex: integer = -1; CustomColor: TColor = clFuchsia); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItemBG(SkinIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject; TextureIndex: integer = -1; HotTextureIndex: integer = -1; CustomColor: TColor = clFuchsia); overload;

procedure PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TComponent); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject); overload;

procedure PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TComponent); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex: integer; ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject); overload;

procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TComponent; BGIndex: integer = -1; BGHotIndex: integer = -1); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItem(SkinIndex: integer; ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject; BGIndex: integer = -1; BGHotIndex: integer = -1); overload;
procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject; md: TsMaskData); overload;

procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; DC: HDC; SkinManager: TComponent); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; DC: HDC; CommonSkinData: TacObject); overload;

function ChangeBrightness(const Color: TColor; const Delta: integer): TColor;

function ChangeSaturation(const Color: TColor;  const Delta: integer):  TColor;   overload;
function ChangeSaturation(const Delta: integer; const Color: TsColor_): TsColor_; overload;

function ChangeHue(const Delta: integer; const Color: TColor): TColor; overload;
function ChangeHue(const Delta: integer; C: TsColor_): TsColor_; overload;

function ChangeTone(const Color: TsColor_; const Tone: TsColor_RGB): TsColor_; overload;
function ChangeTone(const Color, Tone: TColor): TColor; overload;

function acCos(Angle: integer): real;
function acSin(Angle: integer): real;

function Hsv2Rgb(h, s, v: real): TsColor;
function Rgb2Hsv(C: TsColor): TsHSV;
function acLayered: Boolean;

function CheckBoxWidth (const SkinData: TacObject; const SmallGlyphs: boolean = True): integer;
function CheckBoxHeight(const SkinData: TacObject; const SmallGlyphs: boolean = True): integer;

procedure acDrawCheck(const R: TRect; const AState: TCheckBoxState; const AEnabled: Boolean; const Bmp: TBitmap; const CI: TCacheInfo; const CommonSkinData: TObject; const SmallGlyphs: boolean = True; CtrlState: integer = 0);
function FontsEqual(const Font1, Font2: TFont): boolean;

procedure acPaintStdBtn(ACanvas: TCanvas; ARect: TRect; AEnabled, AFocusRect: boolean; AState: integer);

procedure UpdateCtrlCornersProc(PaintBorderData: TacPaintBorderData; var OutCorners: TacIntValues; var POutSides: PacSides);

type
  TacChangeColor = procedure(var Color: TsColor_; const Param: integer);

procedure DrawBmp(ACanvas: TCanvas; Bmp: TBitmap; R: TRect; Reflected: boolean);
function MakeCompIcon(Img: TBitmap{; BGColor: TColor = Graphics.clNone}): HICON;
procedure ChangeBitmapPixels(Bmp: TBitmap; ChangeProc: TacChangeColor; Param: integer; SkipColor: TColor);
procedure ChangeColorBrightness(var Prop: TsColor_; const Param: integer);
procedure ChangeColorSaturation(var Prop: TsColor_; const Param: integer);
procedure ChangeColorHUE       (var Prop: TsColor_; const Param: integer);
procedure ChangeColorTone      (var Prop: TsColor_; const Param: integer);
procedure MakeAlphaPixel       (var Prop: TsColor_; const Param: integer);
procedure acSetLayout(hdc: HDC; dwLayout: DWORD);
function acGetLayout(hdc: HDC): DWord;
procedure UpdateLayeredWnd(Handle: THandle; Bmp: TBitmap; Size: PSize; BlendData: PBlendFunction; NewPos: PPoint = nil);
{$ENDIF}


var
  FCheckWidth, FCheckHeight: Integer;
  User32Lib: HModule = 0;
  Gdi32Lib: HModule = 0;
  SetLayeredWindowAttributes: function (Hwnd: THandle; crKey: COLORREF; bAlpha: Byte; dwFlags: DWORD): Boolean; stdcall;
  UpdateLayeredWindow: function (Handle: THandle; hdcDest: HDC; pptDst: PPoint; _psize: PSize;
    hdcSrc: HDC; pptSrc: PPoint; crKey: COLORREF; pblend: PBLENDFUNCTION; dwFlags: DWORD): Boolean; stdcall;

  SetLayout: function(hdc: HDC; dwLayout: DWORD): DWORD; stdcall;
  GetLayout: function(hdc: HDC): DWORD; stdcall;
{$ENDIF} // NOTFORHELP


implementation


uses
  {$IFNDEF ACHINTS} sStyleSimply, sSkinManager, sSkinProvider, sMessages, {$ENDIF}
  {$IFDEF TNTUNICODE} TntWindows, {$ENDIF}
  {$IFNDEF ALITE} sSplitter, {$ENDIF}
  {$IFDEF DELPHI7UP} UxTheme, Themes, {$ENDIF}
  {$IFNDEF FPC} acPng, {$ENDIF}
  sVclUtils, sGradient, sAlphaGraph, sDefaults, acGPUtils;


type
  TKernel = record
    Size: TKernelSize;
    Weights: array [-MaxKernelSize..MaxKernelSize] of Single;
  end;


procedure SetFontSmoothing(AFont: TFont);
var
  tagLOGFONT: TLogFont;
begin
  GetObject(AFont.Handle, SizeOf(TLogFont), @tagLOGFONT);
  tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
  AFont.Handle := CreateFontIndirect(tagLOGFONT);
end;


procedure CopyBmp(DstBmp, SrcBmp: TBitmap);
begin
  DstBmp.PixelFormat := SrcBmp.PixelFormat;
  DstBmp.HandleType := bmDIB;
  DstBmp.Width := SrcBmp.Width;
  DstBmp.Height := SrcBmp.Height;
  BitBlt(DstBmp.Canvas.Handle, 0, 0, SrcBmp.Width, SrcBmp.Height, SrcBmp.Canvas.Handle, 0, 0, SRCCOPY);
end;


function InitLine(Bmp: TBitmap; var Line0: Pointer; var Delta: Integer): boolean;
begin
  Result := False;
  with Bmp do
    if Height > 0 then
      try
        Line0 := ScanLine[0];
        if Height > 1 then
          Delta := Integer(ScanLine[1]) - Integer(Line0)
        else
          Delta := 0;
      finally
        Result := True;
      end;
end;


procedure DrawCloseBtn(DC: hdc; R: TRect; State: integer);
{$IFDEF DELPHI7UP}
var
  tw: TThemedWindow;
  Details: TThemedElementDetails;
{$ENDIF}
begin
{$IFDEF DELPHI7UP}
  if acThemesEnabled then begin
    case State of
      0:   tw := twSmallCloseButtonNormal;
      1:   tw := twSmallCloseButtonHot;
      else tw := twSmallCloseButtonPushed;
    end;
    Details := acThemeServices.GetElementDetails(tw);
    acThemeServices.DrawElement(DC, Details, R);
  end
  else
{$ENDIF}
  begin
    FillDC(DC, R, clWhite);
    InflateRect(R, -1, -1);
    case State of
      0: FillDC(DC, R, $005858AB);
      1: FillDC(DC, R, clRed);
      2: FillDC(DC, R, clMaroon);
    end;
    SelectObject(DC, CreatePen(PS_SOLID, 2, clWhite));
    acPaintLine(DC, R.Left + 3, R.Top    + 3, R.Right - 4, R.Bottom - 4);
    acPaintLine(DC, R.Left + 3, R.Bottom - 4, R.Right - 4, R.Top    + 3);
  end;
end;


procedure DrawColorArrow(const Canvas: TCanvas; const Color: TColor; R: TRect; const Direction: TacSide; PPI: integer);
var
  ArrWidth, ArrHeight, x, y, Left, Top, i: integer;
begin
  i := 0;
  ArrWidth := acArrowSize * PPI div 96;
  ArrHeight := ArrWidth div 2 + ArrWidth mod 2;
  case Direction of
    asTop: begin
      Left := R.Left + (WidthOf(R) - ArrWidth) div 2 - 1;
      Top := R.Top + (HeightOf(R) - ArrHeight) div 2 - 1;
      for y := Top + ArrHeight downto Top do begin
        for x := i to ArrHeight do begin
          Canvas.Pixels[Left + x, y] := Color;
          Canvas.Pixels[Left + ArrWidth - x + 1, y] := Color;
        end;
        inc(i);
      end;
    end;

    asLeft: begin
      Left := R.Left + (WidthOf(R) - ArrHeight) div 2;
      Top  := R.Top + (HeightOf(R) - ArrWidth)  div 2;
      for x := Left + ArrHeight downto Left do begin
        for y := Top + i to Top + ArrHeight do begin
          Canvas.Pixels[x, y] := Color;
          Canvas.Pixels[x, y + ArrHeight - i] := Color;
        end;
        inc(i);
      end;
    end;

    asBottom: begin
      Left := R.Left + (WidthOf(R) - ArrWidth) div 2 - 1;
      Top := R.Top + (HeightOf(R) - ArrHeight) div 2 - 1;
      for y := Top to Top + ArrHeight do begin
        for x := i to ArrHeight do begin
          Canvas.Pixels[Left + x, y] := Color;
          Canvas.Pixels[Left + ArrWidth - x + 1, y] := Color;
        end;
        inc(i);
      end;
    end;

    asRight: begin
      Left := R.Left + (WidthOf(R) - ArrHeight) div 2;
      Top  := R.Top + (HeightOf(R) - ArrWidth)  div 2;
      for x := Left to Left + ArrHeight do begin
        for y := Top + i to Top + ArrHeight do begin
          Canvas.Pixels[x, y] := Color;
          Canvas.Pixels[x, y + ArrHeight - i] := Color;
        end;
        inc(i);
      end;
    end;
  end;
end;


procedure DrawColorArrow(const aBmp: TBitmap; const Color: TColor; R: TRect; const Direction: TacSide; PPI: integer); overload;
var
  ArrWidth, ArrHeight, DeltaS, x, y, LeftPos, TopPos, i: integer;
  S0, S: PRGBAArray_;
  ActColor: TColor;
begin
  i := 0;
  ArrWidth := acArrowSize * PPI div 96;
  ArrHeight := ArrWidth div 2 + ArrWidth mod 2;
  with R do
    if Direction in [asTop, asBottom] then begin
      LeftPos := Left + (Right - Left - ArrWidth) div 2;
      TopPos  := Top + (Bottom - Top - ArrHeight) div 2;
      if (LeftPos < 0) or (TopPos < 0) or (LeftPos + ArrWidth >= aBmp.Width) or (TopPos + ArrHeight >= aBmp.Height) then
        Exit;
    end
    else begin
      LeftPos := R.Left + (WidthOf(R) - ArrHeight) div 2;
      TopPos  := R.Top + (HeightOf(R) - ArrWidth)  div 2;
      if (LeftPos < 0) or (TopPos < 0) or (LeftPos + ArrHeight >= aBmp.Width) or (TopPos + ArrWidth >= aBmp.Height) then
        Exit;
    end;

  ActColor := SwapRedBlue(Color);
  if InitLine(aBmp, Pointer(S0), DeltaS) then
    case Direction of
      asTop:
        for y := ArrHeight - 1 downto 0 do begin
          S := Pointer(PAnsiChar(S0) + DeltaS * (TopPos + y));
          for x := i to ArrHeight - 1 do begin
            S[LeftPos + x].C := ActColor;
            S[LeftPos + ArrWidth - x - 1].C := ActColor;
          end;
          inc(i);
        end;

      asLeft:
        for y := 0 to ArrWidth do begin
          S := Pointer(PAnsiChar(S0) + DeltaS * (TopPos + y));
          if y < ArrHeight then
            for x := LeftPos + ArrHeight - y to LeftPos + ArrHeight - 1 do
              S[x].C := ActColor
          else
            for x := LeftPos + y - ArrHeight to LeftPos + ArrHeight - 1 do
              S[x].C := ActColor;
        end;

      asBottom: begin
        for y := 0 to 0 + ArrHeight do begin
          S := Pointer(PAnsiChar(S0) + DeltaS * (TopPos + y));
          for x := i to ArrHeight - 1 do begin
            S[LeftPos + x].C := ActColor;
            S[LeftPos + ArrWidth - x - 1].C := ActColor;
          end;
          inc(i);
        end;
      end;

      asRight:
        for y := 0 to ArrWidth do begin
          S := Pointer(PAnsiChar(S0) + DeltaS * (TopPos + y));
          if y < ArrHeight then
            for x := LeftPos to LeftPos + y do
              S[x].C := ActColor
          else
            for x := LeftPos to LeftPos + ArrWidth - y - 1 do
              S[x].C := ActColor;

        end;
    end;
end;


function bmpRotate(var SBitmap: TBitmap; RotateAngle: Word; FreeupBmp: Boolean): TBitmap;
var
  SDBits, TDBits: PByteArray;
  SHPIX, THPIX: HGlobal;
  YY1, XX1, YY2, XX2,
  BitPos1, BitPos2,
  SIW, SIL, TIW,
  ImageSize, LBPS1, LBPS2, BmpBitRead: Integer;
begin
  if (SBitmap <> nil) and (SBitmap.PixelFormat = pf32bit) then begin
    SIW := SBitmap.Width;
    SIL := SBitmap.Height;

    LBPS1 := SIW * 4;
    ImageSize := LBPS1 * SIL;
    SHPIX := GlobalAlloc(GMEM_FIXED, ImageSize);
    SDBits := GlobalLock(Shpix);
    BmpBitRead := GetBitmapBits(SBitmap.Handle, ImageSize, SDBits);
    Result := TBitmap.Create;
    Result.IgnorePalette := True;
    Result.Monochrome := SBitmap.Monochrome;
    Result.PixelFormat := SBitmap.PixelFormat;
    if BmpBitRead = 0 then begin // Upps what happens? No error handling yet, just do not return any bmp
      GlobalUnlock(shpix);
      GlobalFree(sHpix);
      FreeAndNil(Result);
      Result := SBitmap;
    end
    else begin
      if FreeupBmp then
        FreeAndNil(SBitmap);

      Result.Width := SIW;
      Result.Height := SIl;
      LBPS2 := LBPS1;
      if (RotateAngle = i90) or (RotateAngle = i270) then begin
        Result.Width := SIL;
        Result.Height := SIW;
        LBPS2 := SIL * 4;
      end;
      TIW := Result.Width - 1;
      THPIX := GlobalAlloc(GMEM_FIXED, ImageSize);
      TDBits := GlobalLock(thpix);
      dec(SIL);
      dec(SIW);
      for YY1 := 0 to SIL do
        for XX1 := 0 to SIW do begin
          case RotateAngle of
            i90: begin
              YY2 := XX1;
              XX2 := TIW - YY1;
            end;

            i180: begin
              XX2 := SIW - XX1;
              YY2 := SIL - YY1;
            end;

            i270: begin
              YY2 := SIW - XX1;
              XX2 := YY1;
            end

            else begin
              YY2 := YY1;
              XX2 := XX1;
            end;
          end;
          BitPos1 := YY1 * LBPS1 + XX1 * 4;
          BitPos2 := YY2 * LBPS2 + XX2 * 4;
          TDBits^[BitPos2] := SDBits^[BitPos1];

          inc(BitPos1);
          inc(BitPos2);
          TDBits^[BitPos2] := SDBits^[BitPos1];

          inc(BitPos1);
          inc(BitPos2);
          TDBits^[BitPos2] := SDBits^[BitPos1];

          inc(BitPos1);
          inc(BitPos2);
          TDBits^[BitPos2] := SDBits^[BitPos1];
        end;

      SetBitmapBits(RESULT.Handle, ImageSize, TDBits);
      GlobalUnlock(shpix);
      GlobalFree(sHpix);
      GlobalUnlock(thpix);
      GlobalFree(tHpix);
    end;
  end
  else
    Result := SBitmap;
end;


procedure DrawArrow(const aBmp: TBitmap; const Color1, Color2: TColor; R: TRect; const Direction: TacSide; LineWidth: integer; AngleShift: integer; ArrowSize: integer; Style: TacArrowsStyle; PPI: integer = 96);
var
  DeltaS, h, wR, w, x, y, oY, addi: integer;
  CenterColor, BordColor: TColor;
  ps: array [0..3] of TPoint;
  ArrowBmp, TmpBmp: TBitmap;
  S0, S, S2: PRGBAArray_;
  p: TPoint;

  procedure MakeArrowBmp;
  var
    X, Y, m, Ldiv2, maxLdiv2: integer;
  begin
    Ldiv2 := LineWidth div 2;
    maxLdiv2 := max(1, Ldiv2);
    case Style of
      arsSolid1: begin
        h := ArrowSize;
        w := 2 * ArrowSize;
        if wR mod 2 = 1 then
          inc(w);

        if wR mod 2 = 1 then
          inc(h);
      end;

      arsLines1: begin
        h := ArrowSize;
        w := 2 * ArrowSize;
        if wR mod 2 = 1 then
          inc(w);

        inc(h, LineWidth + maxLdiv2);
        inc(w, LineWidth);
      end;

      arsSolid2: begin
        h := ArrowSize div 2;
        w := 2 * ArrowSize;
        if wR mod 2 = 0 then
          inc(w);

        if wR mod 2 = 1 then
          inc(h);
      end;

      arsLines2: begin
        h := ArrowSize div 2;
        w := 2 * ArrowSize;
        if wR mod 2 = 0 then
          inc(w);

        inc(h, LineWidth + maxLdiv2);
        inc(w, LineWidth);
      end;

      arsSolid3: begin
        h := ArrowSize + 3;
        w := h + 1;
        if w mod 2 = 0 then
          inc(w);
      end;
    end;
    addi := w mod 2;

    m := max(w, h);
    oY := (m - h) div 2;
    ArrowBmp := CreateBmp32(m, m);
    FillRect32(ArrowBmp, MkRect(ArrowBmp), clWhite, 0);

    if InitLine(ArrowBmp, Pointer(S0), DeltaS) then begin
      if Style in [arsLines1, arsLines2{, arsLines3}] then begin
        ps[0] := Point(maxLdiv2, maxLdiv2 + oY);
        ps[1] := Point(maxLdiv2 + ArrowSize, oY + h - LineWidth);

        ps[2] := Point(ps[1].X - Ldiv2 + addi, ps[1].Y);
        ps[3] := Point(ps[2].X + ArrowSize, ps[0].Y);
      end
      else begin
        ps[0] := Point(0, oY);
        ps[1] := Point(ArrowBmp.Width div 2 - 1 + addi, oY + h - 1);

        ps[2] := Point(ps[1].X + 1 - addi, ps[1].Y);
        ps[3] := Point(ps[2].X + ArrowBmp.Width div 2 - 1 + addi, ps[0].Y);
      end;

      if Style = arsSolid3 then
        acgpFillPolygon(ArrowBmp.Canvas.Handle, CenterColor, PPoint(@ps[0]), 4)
      else begin
        if CenterColor <> clNone then begin
          ArrowBmp.Canvas.Brush.Style := bsSolid;
          ArrowBmp.Canvas.Brush.Color := 0;
          ArrowBmp.Canvas.Polygon(ps);
          for Y := 0 to ArrowBmp.Height - 1 do begin
            S := Pointer(PAnsiChar(S0) + DeltaS * Y);
            for X := 0 to ArrowBmp.Width - 1 do
              with S[X] do begin
                m := B + G + R;
                if m <> MaxByte * 3 then begin
                  C := CenterColor;
                  A := MaxByte - m div 3;
                end
                else
                  C := $FFFFFF;
              end;
          end;
        end;

        if LineWidth > 0 then begin
          acgpDrawLine(ArrowBmp.Canvas.Handle, ps[0].X, ps[0].Y, ps[1].X, ps[1].Y, BordColor, LineWidth);
          acgpDrawLine(ArrowBmp.Canvas.Handle, ps[2].X, ps[2].Y, ps[3].X, ps[3].Y, BordColor, LineWidth);
        end;
      end;
    end;
  end;

begin
  BordColor := Color1;
  if ArrowSize = 0 then
    ArrowSize := acArrowSize;

  ArrowSize := ArrowSize * PPI div 96;
  wR := WidthOf(R);

  case Style of
    arsLines1, arsLines2:  begin
      if wR mod 2 = 0 then
        inc(wR);

      if LineWidth = 0 then begin
        LineWidth := acLineWidth;
        LineWidth := LineWidth * PPI div 96;
      end;
      if Color2 <> clNone then
        CenterColor := TColor(Cardinal(SwapRedBlue(Color2)) or $FF000000)
      else
        CenterColor := Color2
    end;
    arsSolid1, arsSolid2: begin
      CenterColor := TColor(Cardinal(SwapRedBlue(BordColor)) or $FF000000);
      LineWidth := 1;
    end;
    else begin
      CenterColor := TColor(Cardinal(BordColor) or $FF000000);
      LineWidth := 1;
    end;
  end;
  if Style in [arsSolid1, arsSolid2] then
    dec(ArrowSize);

  with R do
    if Direction in [asTop, asBottom] then begin
      if (Style in [arsSolid2]) and (wR mod 2 = 0) then
        inc(ArrowSize);

      MakeArrowBmp;
      if Direction = asTop then // Flip vertical
        if InitLine(ArrowBmp, Pointer(S0), DeltaS) then
          for y := 0 to (ArrowBmp.Height - 1) div 2 do begin
            S := Pointer(PAnsiChar(S0) + DeltaS * Y);
            S2 := Pointer(PAnsiChar(S0) + DeltaS * (ArrowBmp.Height - 1 - Y));
            for X := 0 to ArrowBmp.Width - 1 do begin
              CenterColor := S[X].C;
              S[X] := S2[X];
              S2[X].C := CenterColor;
            end;
          end;
    end
    else begin
      if (Style in [arsSolid2]) and (wR mod 2 = 0) then
        inc(ArrowSize);

      MakeArrowBmp;
      if Direction = asLeft then
        ArrowBmp := bmpRotate(ArrowBmp, i90, True)
      else
        ArrowBmp := bmpRotate(ArrowBmp, i270, True);
    end;

  p.X := R.Left + (WidthOf(R) - ArrowBmp.Width) div 2;
  p.Y := R.Top + (HeightOf(R) - ArrowBmp.Height) div 2;
  if AngleShift <> 0 then begin
    // Create new rotated arrow
    TmpBmp := CreateBmpLike(ArrowBmp);
    FillRect32(TmpBmp, MkRect(TmpBmp), clWhite, 0);
    BitBltRotated(TmpBmp.Canvas.Handle, ArrowBmp, Point(ArrowBmp.Width div 2 - 1, ArrowBmp.Height div 2 - 1), Round(AngleShift) - i90);
    PaintBmpRect32(aBmp, TmpBmp, MkRect(TmpBmp), p);
    TmpBmp.Free;
  end
  else
    PaintBmpRect32(aBmp, ArrowBmp, MkRect(ArrowBmp), p);

  ArrowBmp.Free;
end;


procedure DrawArrow(DC: hdc; const Color1, Color2: TColor; R: TRect; const Direction: TacSide; LineWidth: integer; AngleShift: integer; ArrowSize: integer; Style: TacArrowsStyle; PPI: integer = 96); overload;
var
  Bmp: TBitmap;
begin
  Bmp := CreateBmp32(R);
  BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, DC, R.Left, R.Top, SRCCOPY);
  DrawArrow(Bmp, Color1, Color2, MkRect(Bmp), Direction, LineWidth, AngleShift, ArrowSize, Style, PPI);
  BitBlt(DC, R.Left, R.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
  Bmp.Free;
end;


function MakeAngledFont(DC: hdc; Font: TFont; Orient: integer): hFont;
var
  NewFont: hFont;
  pFont:    {$IFDEF TNTUNICODE}PLogFontW{$ELSE}PLogFont{$ENDIF};
  VertFont: {$IFDEF TNTUNICODE}TLogFontW{$ELSE}TLogFont{$ENDIF};
begin
{$IFDEF TNTUNICODE}
  pFont := PLogFontW(@VertFont);
  GetObject(DC, SizeOf(TLogFontW), pFont);
{$ELSE}
  pFont := PLogFont(@VertFont);
  GetObject(DC, SizeOf(TLogFont), pFont);
{$ENDIF}
  VertFont.lfEscapement := Orient;
  VertFont.lfHeight := Font.Height;
  VertFont.lfStrikeOut := integer(fsStrikeOut in Font.Style);
  VertFont.lfItalic := integer(fsItalic in Font.Style);
  VertFont.lfUnderline := integer(fsUnderline in Font.Style);
  if fsBold in Font.Style then
    VertFont.lfWeight := FW_BOLD
  else
    VertFont.lfWeight := FW_NORMAL;

  VertFont.lfCharSet := Font.Charset;
  VertFont.lfWidth := 0;
  VertFont.lfOutPrecision := OUT_DEFAULT_PRECIS;
  VertFont.lfClipPrecision := CLIP_DEFAULT_PRECIS;
  VertFont.lfOrientation := VertFont.lfEscapement;
  VertFont.lfPitchAndFamily := Default_Pitch;
{$IFDEF DELPHI_XE}
  if Font.Quality = fqDefault then
    VertFont.lfQuality := ord(fqAntialiased)
  else
    VertFont.lfQuality := ord(Font.Quality);
{$ELSE}
  VertFont.lfQuality := ANTIALIASED_QUALITY;
{$ENDIF}
  if Font.Name <> s_MSSansSerif then
{$IFDEF TNTUNICODE}
    WStrPCopy(VertFont.lfFaceName, Font.Name)
  else
    WStrPCopy(VertFont.lfFaceName, s_Arial);

  NewFont := CreateFontIndirectW(VertFont);
{$ELSE}
    StrPCopy(VertFont.lfFaceName, Font.Name)
  else
    VertFont.lfFaceName := s_Arial;

  NewFont := CreateFontIndirect(VertFont);
{$ENDIF}

  Result := SelectObject(DC, NewFont);
  SetTextColor(DC, ColorToRGB(Font.Color));
  DeleteObject(NewFont);
end;


function CheckBoxWidth(const SkinData: TacObject; const SmallGlyphs: boolean = True): integer;
var
  sd: TacSkinData;
begin
  if Assigned(SkinData) and Assigned(TacSkinData(SkinData).FOwner) then
    with TacSkinData(SkinData).FOwner do begin
      sd := TacSkinData(SkinData);
      if SmallGlyphs then
        if Active and IsValidImgIndex(sd.SmallCheckBox[cbChecked]) then
          Result := sd.ma[sd.SmallCheckBox[cbChecked]].Width + 2
        else
          Result := FCheckWidth
      else
        if Active and IsValidImgIndex(sd.CheckBox[cbChecked]) then
          Result := sd.ma[sd.CheckBox[cbChecked]].Width + 2
        else
          Result := FCheckWidth
    end
  else
    Result := FCheckWidth;
end;


function CheckBoxHeight(const SkinData: TacObject; const SmallGlyphs: boolean = True): integer;
var
  sd: TacSkinData;
begin
  if Assigned(SkinData) and Assigned(TacSkinData(SkinData).FOwner) then
    with TacSkinData(SkinData).FOwner do begin
      sd := TacSkinData(SkinData);
      if SmallGlyphs then
        if Active and IsValidImgIndex(sd.SmallCheckBox[cbChecked]) then
          Result := sd.ma[sd.SmallCheckBox[cbChecked]].Height
        else
          Result := FCheckHeight
      else
        if Active and IsValidImgIndex(sd.CheckBox[cbChecked]) then
          Result := sd.ma[sd.CheckBox[cbChecked]].Height
        else
          Result := FCheckHeight
    end
  else
    Result := FCheckWidth;
end;


procedure GetCheckSize;
var
  AButtonsBitmap: HBITMAP;
  B: Windows.TBitmap;
begin
  AButtonsBitmap := LoadBitmap(0, PChar(OBM_CHECKBOXES));
  try
    GetObject(AButtonsBitmap, SizeOf(Windows.TBitmap), @B);
    FCheckWidth := B.bmWidth shr 2;
    FCheckHeight := B.bmHeight div 3;
  finally
    DeleteObject(AButtonsBitmap);
  end;
end;


procedure acDrawCheck(const R: TRect; const AState: TCheckBoxState; const AEnabled: Boolean; const Bmp: TBitmap; const CI: TCacheInfo; const CommonSkinData: TObject; const SmallGlyphs: boolean = True; CtrlState: integer = 0);
var
  DrawState, w, h: Integer;
  SkinnedGlyph: boolean;
  DrawRect: TRect;
const
  CheckStates: array [boolean] of Cardinal = (DFCS_ADJUSTRECT, DFCS_CHECKED);
{$IFDEF DELPHI7UP}
  ThemedChecks: array [TCheckBoxState, 0..3] of TThemedButton = ((tbCheckBoxUncheckedNormal, tbCheckBoxUncheckedHot, tbCheckBoxUncheckedPressed, tbCheckBoxUncheckedDisabled),
                                                          (tbCheckBoxCheckedNormal,   tbCheckBoxCheckedHot,   tbCheckBoxCheckedPressed, tbCheckBoxCheckedDisabled),
                                                          (tbCheckBoxMixedNormal, tbCheckBoxMixedHot, tbCheckBoxMixedPressed, tbCheckBoxMixedDisabled));
{$ENDIF}
begin
  if not (CommonSkinData is TacSkinData) then begin
{$IFDEF DEBUG}
    if IsIDERunning then
      Alert('Check parameters of the acDrawCheck procedure.');
{$ENDIF}
    Exit;
  end
  else
    with TacSkinData(CommonSkinData) do begin
      SkinnedGlyph := False;
      if (FOwner <> nil) and FOwner.IsValidImgIndex(SmallCheckBox[AState]) then
        SkinnedGlyph := True;

      DrawRect := R;
      DrawState := 0;

      w := CheckBoxWidth (TacSkinData(CommonSkinData), SmallGlyphs);
      h := CheckBoxHeight(TacSkinData(CommonSkinData), SmallGlyphs);

      if not SkinnedGlyph then begin
        if CI.Ready then
          BitBlt(Bmp.Canvas.Handle, DrawRect.Left, DrawRect.Top, w + 2, HeightOf(R), CI.Bmp.Canvas.Handle, CI.X + R.Left + 1, CI.Y + R.Top + 1, SRCCOPY)
        else
          if CI.FillColor <> clFuchsia then
            FillDC(Bmp.Canvas.Handle, Rect(DrawRect.Left, DrawRect.Top, DrawRect.Left + w + 2, DrawRect.Top + HeightOf(R)), CI.FillColor);

        case AState of
          cbChecked:   DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
          cbUnchecked: DrawState := DFCS_BUTTONCHECK;
          else         DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
        end;

        if not AEnabled then
          DrawState := DrawState or DFCS_INACTIVE;
      end;

      DrawRect.Left   := DrawRect.Left + (DrawRect.Right - DrawRect.Left - w) div 2;
      DrawRect.Top    := DrawRect.Top  + (DrawRect.Bottom - DrawRect.Top - h) div 2;
      DrawRect.Right  := DrawRect.Left + w;
      DrawRect.Bottom := DrawRect.Top  + h;

      if SkinnedGlyph then begin
        if SmallGlyphs then begin
          if FOwner.IsValidImgIndex(SmallCheckBox[AState]) then
            sAlphaGraph.DrawSkinGlyph(Bmp, DrawRect.TopLeft, 0, 1 + integer(not AEnabled), ma[SmallCheckBox[AState]], CI);
        end
        else
          if FOwner.IsValidImgIndex(CheckBox[AState]) then
            sAlphaGraph.DrawSkinGlyph(Bmp, DrawRect.TopLeft, 0, 1 + integer(not AEnabled), ma[CheckBox[AState]], CI);
      end
      else
{$IFDEF DELPHI7UP}
        if acThemesEnabled then
          acThemeServices.DrawElement(Bmp.Canvas.Handle, acThemeServices.GetElementDetails(ThemedChecks[AState, iff(AEnabled, CtrlState, 3)]), DrawRect)
        else
{$ENDIF}
          DrawFrameControl(Bmp.Canvas.Handle, DrawRect, DFC_BUTTON, DrawState);
    end;
end;


type
  TAccessBmp = class (TBitmap);

procedure DrawBmp(ACanvas: TCanvas; Bmp: TBitmap; R: TRect; Reflected: boolean);
var
  DstBmp, SrcBmp, SrcBmp8, Mask: TBitmap;
  w, h: integer;
begin
  if Bmp.PixelFormat = pf32bit then begin
    w := WidthOf(R);
    h := HeightOf(R);
    DstBmp := CreateBmp32(w, h + Integer(Reflected) * (h div 2));
    BitBlt(DstBmp.Canvas.Handle, 0, 0, w, DstBmp.Height, ACanvas.Handle, R.Left, R.Top, SRCCOPY);
    if (w = Bmp.Width) and (h = Bmp.Height) then
      CopyBmp32(MkRect(w, h), MkRect(w, h), DstBmp, Bmp, EmptyCI, False, Graphics.clNone, 0, Reflected)
    else begin // If stretched
      SrcBmp := CreateBmp32;
      SrcBmp.PixelFormat := pfDevice;
      SrcBmp.Width := w;
      SrcBmp.Height := h;

      SetStretchBltMode(SrcBmp.Canvas.Handle, COLORONCOLOR);
      StretchBlt(SrcBmp.Canvas.Handle, 0, 0, w, h, Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SRCCOPY);
      SrcBmp.PixelFormat := pf32bit;

      Mask := CreateBmpLike(Bmp);
      Mask.PixelFormat := pf8bit;

      CopyChannel(Bmp, Mask, 3, True);
      Mask.PixelFormat := pfDevice;
      SrcBmp8 := CreateBmp32;
      SrcBmp8.PixelFormat := pfDevice;
      SrcBmp8.Width := w;
      SrcBmp8.Height := h;
      SetStretchBltMode(SrcBmp8.Canvas.Handle, COLORONCOLOR);
      StretchBlt(SrcBmp8.Canvas.Handle, 0, 0, w, h, Mask.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SRCCOPY);
      SrcBmp8.PixelFormat := pf8bit;
      CopyChannel(SrcBmp, SrcBmp8, 3, False);
      FreeAndNil(Mask);
      FreeAndNil(SrcBmp8);
      CopyBmp32(MkRect(w, h), MkRect(w, h), DstBmp, SrcBmp, EmptyCI, False, Graphics.clNone, 0, False);
      FreeAndNil(SrcBmp);
    end;
    BitBlt(ACanvas.Handle, R.Left, R.Top, DstBmp.Width, DstBmp.Height, DstBmp.Canvas.Handle, 0, 0, SRCCOPY);
    FreeAndNil(DstBmp);
  end
  else
    TAccessBmp(Bmp).Draw(ACanvas, R);
end;


function MakeCompIcon(Img: TBitmap): HICON;
var
  IconInfo: TIconInfo;
begin
  try
    IconInfo.fIcon := True;
    IconInfo.xHotspot := 0;
    IconInfo.yHotspot := 0;
    IconInfo.hbmColor := Img.Handle;
    IconInfo.hbmMask := CreateBitmap(Img.Width, Img.Height, 1, 1, nil);
    Result := CreateIconIndirect(IconInfo);
    DeleteObject(IconInfo.hbmMask);
  finally
  end;
end;


procedure ChangeBitmapPixels(Bmp: TBitmap; ChangeProc: TacChangeColor; Param: integer; SkipColor: TColor);
var
  CC: TsColor;
  S0, S: PRGBAArray_;
  Delta, x, y, h, w: integer;
begin
  CC.C := SwapRedBlue(SkipColor);
  if Assigned(Bmp) and InitLine(Bmp, Pointer(S0), Delta) then begin
    w := Bmp.Width - 1;
    h := Bmp.Height - 1;
    if SkipColor <> clNone then
      for y := 0 to h do begin
        S := Pointer(PAnsiChar(S0) + Delta * Y);
        for x := 0 to w do
          if S[X].C <> CC.C then
            ChangeProc(S[X], Param);
      end
    else
      for y := 0 to h do begin
        S := Pointer(PAnsiChar(S0) + Delta * Y);
        for x := 0 to w do
          ChangeProc(S[X], Param);
      end
  end;
end;


procedure ChangeColorBrightness(var Prop: TsColor_; const Param: integer);
begin
  Prop.C := ChangeBrightness(Prop.C, Param);
end;


procedure ChangeColorSaturation(var Prop: TsColor_; const Param: integer);
begin
  Prop := ChangeSaturation(Param, Prop);
end;


procedure ChangeColorHUE(var Prop: TsColor_; const Param: integer);
begin
  Prop := ChangeHUE(Param, Prop);
end;


procedure ChangeColorTone(var Prop: TsColor_; const Param: integer);
begin
  Prop := ChangeTone(Prop, TsColor_RGB(Param));
end;


procedure MakeAlphaPixel(var Prop: TsColor_; const Param: integer);
begin
  Prop.A := MaxByte;
end;


function acLayered: Boolean;
begin
  Result := Pointer(@UpdateLayeredWindow) <> nil;
end;


function SwapInteger(const i: integer): integer;
var
  r, g, b, j: integer;
begin
  r := i mod 256;
  j := i shr 8;
  g := j mod 256;
  b := j shr 8;
  Result := r shl 16 + g shl 8 + b;
end;


{$IFNDEF ACHINTS}
function IsNAN(const d: double): boolean;
var
  Overlay: Int64 absolute d;
begin
  Result := (Overlay and $7FF0000000000000 = $7FF0000000000000) and (Overlay and $000FFFFFFFFFFFFF <> $0000000000000000);
end;


function ChangeTone(const Color: TsColor_; const Tone: TsColor_RGB): TsColor_; overload;
begin
  with Result, Tone do begin
    A := Color.A;
    // Discolor by lighter channel
    if Color.R > Color.G then
      if Color.R > Color.B then
        R := Color.R
      else
        R := Color.B
    else
      if Color.G > Color.B then
        R := Color.G
      else
        R := Color.B;

    G := R;
    B := R;

    R := R * Red   shr 8;
    G := G * Green shr 8;
    B := B * Blue  shr 8;
  end;
end;


procedure acSetLayout(hdc: HDC; dwLayout: DWORD);
begin
  if @SetLayout <> nil then
    SetLayout(hdc, dwLayout);
end;


function acGetLayout(hdc: HDC): DWord;
begin
  if @GetLayout <> nil then
    Result := GetLayout(hdc)
  else
    Result := 0;
end;


procedure UpdateLayeredWnd(Handle: THandle; Bmp: TBitmap; Size: PSize; BlendData: PBlendFunction; NewPos: PPoint = nil);
var
  DC: hdc;
  BmpTopLeft: TPoint;
begin
  DC := GetDC(0);
  BmpTopLeft := MkPoint;
  try
    ResetLastError;
    if not UpdateLayeredWindow(Handle, DC, NewPos, Size, Bmp.Canvas.Handle, @BmpTopLeft, clNone, BlendData, ULW_ALPHA) then
      CheckLastError;
  finally
    ReleaseDC(0, DC);
  end;
end;


function ChangeTone(const Color, Tone: TColor): TColor; overload;
begin
  Result := ChangeTone(TsColor_(Color), TsColor_RGB(Tone)).C;
end;


function ChangeBrightness(const Color: TColor; const Delta: integer): TColor;
var
  C: TsColor;
  nDelta: integer;
begin
  Result := Color;
  if Delta > 0 then
    with C do begin
      C := Color;
      R := min(MaxByte, R + R * Delta shr 8);
      G := min(MaxByte, G + G * Delta shr 8);
      B := min(MaxByte, B + B * Delta shr 8);
      Result := C;
    end
  else
    if Delta < 0 then
      with C do begin
        nDelta := -Delta;
        C := Color;
        R := max(R - R * nDelta shr 8, 0);
        G := max(G - G * nDelta shr 8, 0);
        B := max(B - B * nDelta shr 8, 0);
        Result := C;
      end;
end;


function ChangeSaturation(const Color: TColor; const Delta: integer): TColor;
begin
  if Delta <> 0 then
    Result := ChangeSaturation(Delta, TsColor_(Color)).C
  else
    Result := Color;
end;

function LimIt(const Value, MinValue, MaxValue: integer): integer; {$IFDEF D2005}inline;{$ENDIF}
begin
  if Value < MinValue then
    Result := MinValue
  else
    if Value > MaxValue then
      Result := MaxValue
    else
      Result := Value;
end;


function ChangeSaturation(const Delta: integer; const Color: TsColor_): TsColor_; overload;
var
  Gray, Delta2, dGray: integer;
begin
  if Delta <> 0 then begin
    Delta2 := MaxByte + Delta;
    Gray := Round(0.299 * Color.R + 0.587 * Color.G + 0.114 * Color.B);
    dGray := Delta * Gray;
    with TsColor(Result) do begin
      A := Color.A;
      B := Limit(Color.R * Delta2 - dGray, 0, $FFFF) shr 8;
      G := Limit(Color.G * Delta2 - dGray, 0, $FFFF) shr 8;
      R := Limit(Color.B * Delta2 - dGray, 0, $FFFF) shr 8;
    end;
  end
  else
    Result := Color;
end;


function Hsv2Rgb(h, s, v: real): TsColor;
var
  II: integer;
  F, M, N, K: real;
begin
  Result.A := 0;
  if S = 0 then
    with Result do begin
      R := lo(Round(V * MaxByte));
      G := R;
      B := R;
    end
  else begin
    if H = 360 then
      H := 0
    else
      H := H / 60;

    II := Round(Int(H));
    F := H - II;

    V := V * MaxByte;
    M := V * (1 - S);
    N := V * (1 - S * F);
    K := V * (1 - S * (1 - F));

    M := max(min(M, MaxByte), 0);
    N := max(min(N, MaxByte), 0);
    K := max(min(K, MaxByte), 0);

    with Result do begin
      A := 0;
      case II of
        0: begin
          R := Round(V);
          G := Round(K);
          B := Round(M)
        end;
        1: begin
          R := Round(N);
          G := Round(V);
          B := Round(M)
        end;
        2: begin
          R := Round(M);
          G := Round(V);
          B := Round(K)
        end;
        3: begin
          R := Round(M);
          G := Round(N);
          B := Round(V)
        end;
        4: begin
          R := Round(K);
          G := Round(M);
          B := Round(V)
        end
        else begin
          R := Round(V);
          G := Round(M);
          B := Round(N)
        end
      end;
    end;
  end
end;


function Rgb2Hsv(C: TsColor): TsHSV;
var
  Rt, Gt, Bt, H, S, V: real;
  d, max, min: integer;
begin
  C.A := 0;
  max := math.Max(math.Max(c.R, c.G), c.B);
  min := math.Min(math.Min(c.R, c.G), c.B);
  d := max - min;
  V := max;

  if max <> 0 then
    S := d / max
  else
    S := 0;

  if S = 0 then
    Result.H := 0
  else begin
    rt := max - c.R * 60 / d;
    gt := max - c.G * 60 / d;
    bt := max - c.B * 60 / d;

    if c.R = max then
      H := bt - gt
    else
      if c.G = max then
        H := 120 + rt - bt
      else
        H := 240 + gt - rt;

    if H < 0 then
      H := H + 360;

    Result.H := Trunc(H);
  end;
  Result.S := S;
  Result.V := V / MaxByte;
end;


function ChangeHue(const Delta: integer; C: TsColor_): TsColor_; overload;
var
  F, M, N, K, Rt, Gt, Bt, H, S, V, r: real;
  d, max, min, II: integer;
begin
  max := math.Max(math.Max(c.R, c.G), c.B);
  min := math.Min(math.Min(c.R, c.G), c.B);
  d := max - min;
  V := max;

  if max <> 0 then
    S := d / max
  else
    S := 0;

  if S = 0 then
    H := 0
  else begin
    r := 60 / d;
    rt := max - c.R * r;
    gt := max - c.G * r;
    bt := max - c.B * r;
    if c.R = max then
      H := bt - gt
    else
      if c.G = max then
        H := 120 + rt - bt
      else
        H := 240 + gt - rt;

    if H < 0 then
      H := H + 360;
  end;
  H := Trunc(H + Delta) mod 360;
  if S = 0 then
    C.R := Trunc(V)
  else begin
    H := H / 60;
    Ii := Trunc(H);
    F := (H - Ii);

    M := V * (1 - S);
    N := V * (1 - S * F);
    K := V * (1 - S * (1 - F));

    M := Math.max(Math.min(M, MaxByte), 0);
    N := Math.max(Math.min(N, MaxByte), 0);
    K := Math.max(Math.min(K, MaxByte), 0);

    with C do
      case Ii of
        0: begin
          R := Trunc(V);
          G := Trunc(K);
          B := Trunc(M)
        end;
        1: begin
          R := Trunc(N);
          G := Trunc(V);
          B := Trunc(M)
        end;
        2: begin
          R := Trunc(M);
          G := Trunc(V);
          B := Trunc(K)
        end;
        3: begin
          R := Trunc(M);
          G := Trunc(N);
          B := Trunc(V)
        end;
        4: begin
          R := Trunc(K);
          G := Trunc(M);
          B := Trunc(V)
        end
        else begin
          R := Trunc(V);
          G := Trunc(M);
          B := Trunc(N)
        end
      end;
  end;
  Result := C
end;


function ChangeHue(const Delta: integer; const Color: TColor): TColor; overload;
var
  CC: TsColor_;
begin
  if Delta <> 0 then
    with CC do begin
      with TsColor_RGB(Color) do begin
        A := Alpha;
        R := Red;
        G := Green;
        B := Blue;
      end;
      CC := ChangeHue(Delta, CC);
      with TsColor_RGB(Result) do begin
        Alpha := A;
        Red   := R;
        Green := G;
        Blue  := B;
      end;
    end
  else
    Result := Color;
end;


procedure HSVtoRGB(const H, S, V: Real; var R, G, B: Real);
var
  f: Real;
  i: Integer;
  hTemp: Real;        // since H is const parameter
  p, q, t: Real;
begin
  if (ABS(S - 0.0001) <= 0.0001) or IsNan(H) { color is on black-and-white center line } then begin
    if IsNaN(H) then begin
      R := V;         // achromatic: shades of gray
      G := V;
      B := V
    end;
  end
  else begin          // chromatic color
    if H = 360.0 then // 360 degrees same as 0 degrees
      hTemp := 0.0
    else
      hTemp := H;

    hTemp := hTemp / 60; // h is now IN [0,6)
    i := Trunc(hTemp);   // largest integer <= h
    f := hTemp - i;      // fractional part of h
    p := V * (1.0 - S);
    q := V * (1.0 - (S * f));
    t := V * (1.0 - (S * (1.0 - f)));
    case i OF
      0: begin
        R := V;
        G := t;
        B := p
      end;
      1: begin
        R := q;
        G := V;
        B := p
      end;
      2: begin
        R := p;
        G := V;
        B := t
      end;
      3: begin
        R := p;
        G := q;
        B := V
      end;
      4: begin
        R := t;
        G := p;
        B := V
      end;
      5: begin
        R := V;
        G := p;
        B := q
      end
    end
  end
end;


procedure RGBToHSV (const R, G, B: Real; var H, S, V: Real);
var
  Delta, Min: Real;
begin
  Min := MinValue( [R, G, B] );
  V   := MaxValue( [R, G, B] );
  Delta := V - Min;
  // Calculate saturation: saturation is 0 if r, g and b are all 0
  if V = 0.0 then
    S := 0
  else
    S := Delta / V;

  if S <> 0.0 then
    {H := NAN     // Achromatic:  When s = 0, h is undefined
  else }begin     // Chromatic
    if R = V then // between yellow and magenta [degrees]
      H := 60.0 * (G - B) / Delta
    else
      if G = V then // between cyan and yellow
        H := 120.0 + 60.0 * (B - R) / Delta
      else
        if B = V then // between magenta and cyan
          H := 240.0 + 60.0 * (R - G) / Delta;

    if H < 0.0 then
      H := H + 360.0
  end
end;


procedure GetRgnFromBmp(var rgn: hrgn; MaskBmp: TBitmap; TransColor: TColor);
var
  ArOR: TRects;
  subrgn: hrgn;
  i, l: integer;
begin
  SetLength(ArOR, 0);
  AddRgnBmp(ArOR, MaskBmp, TsColor(TransColor));
  l := Length(ArOR);
  rgn := CreateRectRgn(0, 0, MaskBmp.Width, MaskBmp.Height);
  if l > 0 then
    for i := 0 to l - 1 do
      with ArOR[i] do begin
        subrgn := CreateRectRgn(Left, Top, Right, Bottom);
        CombineRgn(rgn, rgn, subrgn, RGN_DIFF);
        DeleteObject(subrgn);
      end
end;


function GetBGInfo(const BGInfo: PacBGInfo; const Handle: THandle; aPleaseDraw: boolean = False): boolean;
var
  P: TPoint;
  b: boolean;
  FSaveIndex: hdc;
  Ctrl: TWinControl;
begin
  with BGInfo^ do begin
    BgType := btUnknown;
    PleaseDraw := aPleaseDraw;
    b := PleaseDraw;
    FillRect := MkRect;
    SendAMessage(Handle, AC_GETBG, LPARAM(BGInfo));

    if BgType <> btUnknown then
      Result := True
    else begin
      Offset := GetClientPos(Handle);
      if b then begin // If real parent bg is required
        FSaveIndex := SaveDC(DrawDC);
        GetViewportOrgEx(DrawDC, P);
        SetViewportOrgEx(DrawDC, P.X - Offset.X, P.Y - Offset.Y, nil);
        OffsetRect(R, Offset.X, Offset.Y);
        IntersectClipRect(DrawDC, R.Left, R.Top, R.Right, R.Bottom);
        SendMessage(Handle, WM_ERASEBKGND, WPARAM(DrawDC), 0);
        SendMessage(Handle, WM_PAINT, WPARAM(DrawDC), 0);
        RestoreDC(DrawDC, FSaveIndex);
        Result := False;
      end
      else begin
        if (DefaultManager <> nil) and DefaultManager.IsActive then
          Color := DefaultManager.GetGlobalColor
        else begin
          Ctrl := FindControl(Handle);
          if Ctrl <> nil then
            Color := GetControlColor(Ctrl)
          else
            Color := clBtnFace;
        end;
        BgType := btFill;
        Result := False;
      end;
    end;
  end;
end;


function BGInfoToCI(const BGInfo: PacBGInfo): TCacheInfo;
begin
  with BGInfo^ do
    if BgType = btCache then
      Result := MakeCacheInfo(Bmp, Offset.X, Offset.Y)
    else begin
      Result.Bmp := Bmp;
      Result.X := Offset.X;
      Result.Y := Offset.Y;
      Result.Ready := False;
      Result.FillColor := ColorToRGB(Color);
      Result.FillRect := FillRect;
    end;
end;


function GetBGInfo(const BGInfo: PacBGInfo; const Control: TControl; aPleaseDraw: boolean = False): boolean; overload;
var
  FSaveIndex: hdc;
  b: boolean;
  P: TPoint;
begin
  with BGInfo^ do begin
    Bmp := nil;
    BgType := btUnknown;
    PleaseDraw := aPleaseDraw;
    FillRect := MkRect;
    b := PleaseDraw;
    SendAMessage(Control, AC_GETBG, LPARAM(BGInfo));
    if BgType = btUnknown then
      if b then begin // If real parent bg is required
        FSaveIndex := SaveDC(DrawDC);
        GetViewportOrgEx(DrawDC, P);
        SetViewportOrgEx(DrawDC, P.X - Offset.X, P.Y - Offset.Y, nil);
        OffsetRect(R, Offset.X, Offset.Y);
        IntersectClipRect(DrawDC, R.Left, R.Top, R.Right, R.Bottom);

        Control.Perform(WM_ERASEBKGND, WPARAM(DrawDC), 0);
        Control.Perform(WM_PAINT, WPARAM(DrawDC), 0);
        RestoreDC(DrawDC, FSaveIndex);
      end
      else begin
        BgType := btFill;
        Color := Control.Perform(SM_ALPHACMD, AC_GETCONTROLCOLOR_HI, 0);

        if Color = 0 then
          Color := ColorToRGB(TacAccessControl(Control).Color);

        if PleaseDraw and (Bmp <> nil) then
          FillDC(DrawDC, R, Color);
      end;
  end;
  Result := True;
end;


procedure AddRgnBmp(var AOR: TRects; MaskBmp: TBitmap; TransColor: TsColor);
var
  X, Y, h, w, l: Integer;
  RegRect: TRect;
  c: TsColor;
begin
  h := MaskBmp.Height - 1;
  w := MaskBmp.Width - 1;
  RegRect := Rect(-1, 0, 0, 0);
  TransColor.A := 0;
  c.A := 0;
  l := Length(AOR);
  with RegRect do
    for Y := 0 to h do begin
      for X := 0 to w do begin
        c := GetAPixel(MaskBmp, x, y);
        if c.C = TransColor.C then
          if Left <> -1 then
            inc(Right)
          else begin
            Left := X;
            Right := Left + 1;
            Top := Y;
            Bottom := Top + 1;
          end
        else
          if Left <> -1 then begin
            SetLength(aOR, l + 1);
            AOR[l] := RegRect;
            inc(l);
            Left := -1;
          end;
      end;
      if Left <> -1 then begin
        SetLength(AOR, l + 1);
        AOR[l] := RegRect;
        inc(l);
        Left := -1;
      end;
    end;
end;


procedure AddRgn(var AOR: TRects; Width: integer; const MaskData: TsMaskData; VertOffset: integer; Bottom: boolean; iPadding: integer = 0);
var
  Bmp: TBitmap;
begin
  if MaskData.Manager <> nil then begin
    if MaskData.Bmp = nil then
      Bmp := TsSkinManager(MaskData.Manager).MasterBitmap
    else
      Bmp := MaskData.Bmp;

    AddRgn(AOR, Bmp, MaskData.R, Width, MaskData.WL, MaskData.WT, MaskData.WR, MaskData.WB, VertOffset, Bottom, MaskData.MaskType <> 0, clFuchsia);
  end;
end;


procedure AddRgn(var AOR: TRects; MaskBmp: TBitmap; MaskRect: TRect; DstWidth, WL, WT, WR, WB: integer;
  VertOffset: integer; IsBottom, Masked: boolean; TranspColor: TColor; iPadding: integer = 0);
var
  XOffs, YOffs, MaskOffs, Delta, X, Y, h, w, l, w2, cx, yPadding: Integer;
  S0, S: PRGBAArray_;
  RegRect: TRect;
  cur: TsColor_;
begin
    if IsBottom then begin
      h := WB;
      yPadding := -iPadding;
    end
    else begin
      h := WT;
      yPadding := 0;//iPadding;
    end;

    w := WL;
    if IsBottom then
      MaskOffs := (HeightOf(MaskRect) div (1 + integer(Masked)) - WB)
    else
      MaskOffs := 0;

    XOffs := MaskRect.Left;
    YOffs := MaskRect.Top;
    if MaskBmp <> nil then begin
      inc(YOffs, MaskOffs);
      RegRect := Rect(-1, 0, 0, 0);
      l := Length(AOR);
      dec(h);
      dec(w);
      if h + YOffs < MaskBmp.Height then
        if InitLine(MaskBmp, Pointer(S0), Delta) then begin
          for Y := 0 to h do begin
            S := Pointer(PAnsiChar(S0) + Delta * (Y + YOffs));
            for X := 0 to w do begin
              cur := S[X + XOffs];
              if cur.C = TranspColor{clFuchsia} then
                if RegRect.Left <> -1 then
                  inc(RegRect.Right)
                else begin
                  RegRect.Left := X + iPadding;
                  RegRect.Right := RegRect.Left + 1;
                  RegRect.Top := Y + VertOffset + yPadding;
                  RegRect.Bottom := RegRect.Top + 1;
                end
              else
                if RegRect.Left <> -1 then begin
                  SetLength(aOR, l + 1);
                  AOR[l] := RegRect;
                  inc(l);
                  RegRect.Left := -1;
                end;
            end;
            if RegRect.Left <> -1 then begin
              SetLength(AOR, l + 1);
              AOR[l] := RegRect;
              inc(l);
              RegRect.Left := -1;
            end;
          end;
          w2 := WidthOf(MaskRect);
          w := w2 - WR;
          cx := DstWidth - w2; // First pixel on control
          dec(w2);
          for Y := 0 to h do begin
            S := Pointer(PAnsiChar(S0) + Delta * (Y + YOffs));
            for X := w to w2 do begin
              cur := S[X + XOffs];
              if cur.C = TranspColor{clFuchsia} then
                if RegRect.Left <> -1 then
                  inc(RegRect.Right)
                else begin
                  RegRect.Left := cx + X - iPadding;
                  RegRect.Right := RegRect.Left + 1;
                  RegRect.Top := Y + VertOffset + yPadding;
                  RegRect.Bottom := RegRect.Top + 1;
                end
              else
                if RegRect.Left <> -1 then begin
                  SetLength(aOR, l + 1);
                  AOR[l] := RegRect;
                  inc(l);
                  RegRect.Left := -1;
                end;
            end;
            if RegRect.Left <> -1 then begin
              SetLength(AOR, l + 1);
              AOR[l] := RegRect;
              inc(l);
              RegRect.Left := -1;
            end;
          end;
        end;
    end;
  end;


procedure PaintItemBG(SkinIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TComponent; TextureIndex: integer = -1; HotTextureIndex: integer = -1; CustomColor: TColor = clFuchsia); overload;
begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if SkinManager <> nil then
    PaintItemBG(SkinIndex, ci, State, R, pP, ItemBmp, TsSkinManager(SkinManager).CommonSkinData, TextureIndex, HotTextureIndex, CustomColor);
end;


procedure PaintItemBG(SkinIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject; TextureIndex: integer = -1; HotTextureIndex: integer = -1; CustomColor: TColor = clFuchsia); overload;
var
  ImagePercent, GradientPercent, w, h, Transparency: integer;
  bImgDrawn, bGradOverlay: boolean;
  GradientArray: TsGradArray;
  aRect, dRect, bRect: TRect;
  TempBmp: TBitmap;
  Color, C: TColor;
  aCI: TCacheInfo;

  procedure PaintAddons(var aBmp: TBitmap);
  var
    bmp: TBitmap;
    R: TRect;
  begin
    with TacSkinData(CommonSkinData) do
      if (ImagePercent + GradientPercent = 100) and
           (GradientPercent in [1..99]) and
             (TextureIndex >= 0) and
               (ma[TextureIndex].DrawMode = 0) and
                 (GradientArray[0].Mode < 2) then // Optimized drawing

        if ma[TextureIndex].Bmp <> nil then
          PaintGradTxt(aBmp, aRect, GradientArray, ma[TextureIndex].Bmp, ma[TextureIndex].R, MaxByte * ImagePercent div 100)
        else
          PaintGradTxt(aBmp, aRect, GradientArray, FOwner.MasterBitmap, ma[TextureIndex].R, MaxByte * ImagePercent div 100)
      else begin
        R := aRect;
        // BGImage painting
        if (ImagePercent > 0) and IsValidIndex(TextureIndex, Length(ma)) then begin
          if Boolean(ma[TextureIndex].MaskType) then
            TileMasked(aBmp, R, CI, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode])
          else
            TileBitmap(aBmp.Canvas, R, ma[TextureIndex].Bmp, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode]);

          bImgDrawn := True;
          if R.Right <> -1 then // If some area should be filled by color
            FillRect32(aBmp, R, Color);
        end
        else
          bImgDrawn := False;
        // BGGradient painting
        if GradientPercent > 0 then
          if bImgDrawn then begin
            Bmp := CreateBmp32(aRect);
            try
              if Length(GradientArray) > 0 then
                PaintGrad(Bmp, MkRect(Bmp), GradientArray)
              else
                FillRect32(Bmp, aRect, Color);

              SumBmpRect(aBmp, Bmp, max(min((ImagePercent * integer(MaxByte)) div 100, MaxByte), 0), MkRect(Bmp), aRect.TopLeft);
            finally
              FreeAndNil(Bmp);
            end;
          end
          else
            if Length(GradientArray) > 0 then
              PaintGrad(aBmp, aRect, GradientArray)
            else
              FillRect32(aBmp, aRect, Color);

        case GradientPercent + ImagePercent of
          1..99:
            BlendColorRect(aBmp, aRect, byte((GradientPercent + ImagePercent) * MaxByte div 100), Color);

          0: begin
            if not ci.Ready and (Transparency > 0) then
              case Transparency of
                100: C := Color
                else
                  if ci.FillColor = clFuchsia then
                    C := Color
                  else
                    C := BlendColors(Color, ci.FillColor, Transparency * MaxByte div 100);
              end
            else
              C := Color;

            FillRect32(aBmp, aRect, Color);
          end;
        end;
    end;
  end;

begin
  with TacSkinData(CommonSkinData) do
    if FOwner.IsValidSkinIndex(SkinIndex) then begin
      if gd[SkinIndex].States <= State then
        State := gd[SkinIndex].States - 1;

      if State > ac_MaxPropsIndex then
        State := ac_MaxPropsIndex;

      aRect := R;
      if CustomColor = clFuchsia then begin
        Color := gd[SkinIndex].Props[State].Color;
        Transparency := gd[SkinIndex].Props[State].Transparency;
        bGradOverlay := (Length(gd[SkinIndex].Props[State].GradientArray) > 0) and (gd[SkinIndex].Props[State].GradientArray[0].Mode and PM_OVERLAY <> 0);
        if Transparency < 100 then begin
          ImagePercent := gd[SkinIndex].Props[State].ImagePercent;
          if not bGradOverlay then
            GradientPercent := gd[SkinIndex].Props[State].GradientPercent
          else
            GradientPercent := 0;

          if (ImagePercent > 0) and (TextureIndex < 0) then
            TextureIndex := gd[SkinIndex].Props[State].TextureIndex;
        end
        else begin
          ImagePercent := 0;
          GradientPercent := 0;
        end;
        if (GradientPercent > 0) or bGradOverlay then
          GradientArray := gd[SkinIndex].Props[State].GradientArray;
      end
      else begin
        bGradOverlay := False;
        ImagePercent := 0;
        GradientPercent := 0;
        Color := CustomColor;
        Transparency := 0;
      end;
      if ci.Ready or (ci.FillColor <> clFuchsia) then
        case Transparency of
          100: begin
            w := WidthOf(aRect, True);
            h := HeightOf(aRect, True);
            if ci.Ready and (ci.Bmp <> nil) then begin
              if ItemBmp <> ci.Bmp then
                BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Top, w, h, ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.Y, SRCCOPY)
            end
            else begin
              bRect := MkRect(w, h);
              OffsetRect(bRect, pP.X, pP.Y);
              if ci.Bmp <> nil then begin
                if (ci.FillRect.Left - ci.X > 0) and (bRect.Left < ci.FillRect.Left) then begin
                  dRect.Left := ci.FillRect.Left - bRect.Left;
                  BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Top, dRect.Left, h, ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.Y, SRCCOPY);
                end
                else
                  dRect.Left := 0;

                if (ci.FillRect.Top - ci.Y > 0) and (bRect.Top < ci.FillRect.Top) then begin
                  dRect.Top := ci.FillRect.Top - bRect.Top;
                  BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Top, w, dRect.Top, ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.Y, SRCCOPY);
                end
                else
                  dRect.Top := 0;

                if (ci.FillRect.Right > 0) and (ci.Bmp.Width - ci.FillRect.Right < bRect.Right) then
                  if ci.Bmp.Width > bRect.Right then begin
                    dRect.Right := bRect.Right - (ci.Bmp.Width - ci.FillRect.Right);
                    BitBlt(ItemBmp.Canvas.Handle, aRect.Right - dRect.Right, aRect.Top, dRect.Right, h, ci.Bmp.Canvas.Handle, ci.X + bRect.Right - dRect.Right, ci.Y + pP.Y, SRCCOPY);
                  end
                  else
                    dRect.Right := 0
                else
                  dRect.Right := 0;

                if (ci.FillRect.Bottom > 0) and (ci.Bmp.Height - ci.FillRect.Bottom < bRect.Bottom) then
                  if ci.Bmp.Height > bRect.Bottom then begin
                    dRect.Bottom := bRect.Bottom - (ci.Bmp.Height - ci.FillRect.Bottom);
                    BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Bottom - dRect.Bottom, w, dRect.Bottom, ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + bRect.Bottom - dRect.Bottom, SRCCOPY);
                  end
                  else
                    dRect.Bottom := 0
                else
                  dRect.Bottom := 0;

                FillRect32(ItemBmp, Rect(aRect.Left + dRect.Left, aRect.Top + dRect.Top, aRect.Right - dRect.Right, aRect.Bottom - dRect.Bottom), ci.FillColor);
              end
              else
                FillRect32(ItemBmp, aRect, ci.FillColor);
            end;
          end;

          0:
            PaintAddons(ItemBmp);

          else begin
            if ci.Ready or (GradientPercent + ImagePercent <> 0) then begin
              TempBmp := CreateBmp32(aRect);
              try
                OffsetRect(aRect, -aRect.Left, -aRect.Top);
                PaintAddons(TempBmp);
                aRect := R;
                if ci.Ready then begin
                  if ItemBmp <> ci.Bmp then
                    BitBlt(ItemBmp.Canvas.Handle, R.Left, R.Top, WidthOf(R, True), HeightOf(R, True), ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.y, SRCCOPY)
                end
                else
                  if ItemBmp.PixelFormat = pf32bit then
                    FillRect32(ItemBmp, aRect, ci.FillColor)
                  else
                    FillDC(ItemBmp.Canvas.Handle, R, ci.FillColor);

                SumBmpRect(ItemBmp, TempBmp, lo(Transparency * 255 div 100), MkRect(WidthOf(aRect, True), HeightOf(aRect, True)), aRect.TopLeft);
              finally
                FreeAndNil(TempBmp);
              end
            end
            else begin
              case Transparency of
                0:   C := ci.FillColor;
                100: C := Color
                else C := BlendColors(ci.FillColor, Color, Transparency * MaxByte div 100)
              end;
              if ItemBmp.PixelFormat = pf32bit then
                FillRect32(ItemBmp, aRect, C)
              else
                FillDC(ItemBmp.Canvas.Handle, aRect, C)
            end;
          end;
        end
      else
        PaintAddons(ItemBmp);

      if bGradOverlay then
        PaintGrad(ItemBmp, aRect, GradientArray);

      if TextureIndex < 0 then
        TextureIndex := gd[SkinIndex].Props[State].TextureIndex;

      case State of
        0:
          if TextureIndex >= 0 then
            if ma[TextureIndex].MaskType > 0 then
              if ma[TextureIndex].DrawMode in [ord(fmDisTiled)] then begin
                aCI := CI;
                inc(aCI.X, pP.X);
                inc(aCI.Y, pP.Y);
                TileMasked(ItemBmp, R, aCI, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode]);
              end;

        else
          if HotTextureIndex >= 0 then
            if ma[HotTextureIndex].MaskType > 0 then
              if ma[HotTextureIndex].DrawMode in [ord(fmDisTiled)] then begin
                aCI := CI;
                inc(aCI.X, pP.X);
                inc(aCI.Y, pP.Y);
                TileMasked(ItemBmp, R, aCI, ma[HotTextureIndex], acFillModes[ma[HotTextureIndex].DrawMode]);
              end;
      end;
    end;
end;


procedure PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TComponent); overload; overload;
begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if SkinManager <> nil then
    PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex, ci, State, R, pP, ItemBmp, TsSkinManager(SkinManager).CommonSkinData);
end;


procedure PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject); overload;
var
  aRect: TRect;
  Color: TColor;
  iDrawed, bGradOverlay: boolean;
  TempBmp: TBitmap;
  GradientArray: TsGradArray;
  ImagePercent, GradientPercent: integer;
  TextureIndex, Transparency, arState: integer;

  procedure PaintAddons(var aBmp: TBitmap);
  var
    bmp: TBitmap;
  begin
    iDrawed := False;
    // BGImage painting
    if ImagePercent > 0 then
      with TacSkinData(CommonSkinData) do begin
        aRect := R;
        if IsValidIndex(TextureIndex, Length(ma)) then begin
          if boolean(ma[TextureIndex].MaskType) then
            TileMasked(aBmp, R, CI, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode])
          else
            TileBitmap(aBmp.Canvas, R, ma[TextureIndex].Bmp, ma[TextureIndex], acFillModes[ma[TextureIndex].DrawMode]);

          iDrawed := True;
        end;

        if R.Right <> -1 then
          if aBmp.PixelFormat = pf32bit then
            FillRect32(aBmp, R, Color)
          else
            FillDC(aBmp.Canvas.Handle, R, Color)
        else
          R := aRect;
      end;
    // BGGradient painting
    if GradientPercent > 0 then begin
      if iDrawed then begin
        bmp := CreateBmp32(R);
        try
          if Length(GradientArray) > 0 then
            PaintGrad(Bmp, MkRect(Bmp), GradientArray)
          else
            if Bmp.PixelFormat = pf32bit then
              FillRect32(Bmp, R, Color)
            else
              FillDC(Bmp.Canvas.Handle, R, Color);

          SumBmpRect(aBmp, Bmp, ImagePercent * integer(MaxByte) div 100, MkRect(Bmp), R.TopLeft);
        finally
          FreeAndNil(Bmp);
        end;
      end
      else
        if Length(GradientArray) > 0 then
          PaintGrad(aBmp, R, GradientArray)
        else
          if aBmp.PixelFormat = pf32bit then
            FillRect32(aBmp, R, Color)
          else
            FillDC(aBmp.Canvas.Handle, R, Color);
    end;
    case GradientPercent + ImagePercent of
      1..99:
        BlendColorRect(aBmp, R, byte((GradientPercent + ImagePercent) * MaxByte div 100), Color);

      100:
        //

      else begin
        if not CI.Ready and (Transparency = 100) then
          if aBmp.PixelFormat = pf32bit then
            FillRect32(aBmp, R, ci.FillColor)
          else
            FillDC(aBmp.Canvas.Handle, R, CI.FillColor)
        else
          if aBmp.PixelFormat = pf32bit then
            FillRect32(aBmp, R, Color)
          else
            FillDC(aBmp.Canvas.Handle, R, Color);
      end;
    end;
  end;

begin
  if not (CommonSkinData is TacSkinData) then begin
{$IFDEF DEBUG}
    if IsIDERunning then
      Alert('Check parameters of the PaintItemBGFast procedure.');
{$ENDIF}
    Exit;
  end
  else
    if TacSkinData(CommonSkinData).FOwner.IsValidSkinIndex(SkinIndex) then
      with TacSkinData(CommonSkinData), gd[SkinIndex] do begin
        bGradOverlay := (Length(gd[SkinIndex].Props[State].GradientArray) > 0) and (gd[SkinIndex].Props[State].GradientArray[0].Mode and PM_OVERLAY <> 0);
        // Properties definition from skin file
        arState         := min(State, ac_MaxPropsIndex);
        Color           := Props[arState].Color;
        ImagePercent    := Props[arState].ImagePercent;
        if bGradOverlay then
          GradientPercent := 0
        else
          GradientPercent := Props[arState].GradientPercent;

        Transparency    := Props[arState].Transparency;
        if arState = 0 then
          TextureIndex := BGIndex
        else
          TextureIndex := BGHotIndex;

        if GradientPercent > 0 then
          GradientArray := Props[arState].GradientArray;

        if ci.Ready and (Transparency = 100) then begin
          if ItemBmp <> ci.Bmp then
            BitBlt(ItemBmp.Canvas.Handle, R.Left, R.Top, WidthOf(R, True), HeightOf(R, True), ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.Y, SRCCOPY);
        end
        else
          if not ci.Ready or (Transparency = 0) then
            PaintAddons(ItemBmp)
          else
            if ci.Ready and (Transparency > 0) then begin
              TempBmp := CreateBmp32(R);
              try
                aRect := R;
                OffsetRect(R, -R.Left, -R.Top);
                PaintAddons(TempBmp);
                R := aRect;
                if ci.Ready and (ci.Bmp <> nil) and (ci.Bmp <> ItemBmp) then
                  BitBlt(ItemBmp.Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect, True), HeightOf(aRect, True), ci.Bmp.Canvas.Handle, ci.X + pP.X, ci.Y + pP.y, SRCCOPY);

                SumBmpRect(ItemBmp, TempBmp, lo(Transparency * integer(MaxByte) div 100), MkRect(WidthOf(aRect, True), HeightOf(aRect, True)), aRect.TopLeft);
              finally
                FreeAndNil(TempBmp);
              end;
            end;

        if bGradOverlay then
          PaintGrad(ItemBmp, aRect, Props[arState].GradientArray);
      end;
end;


procedure PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TComponent);
begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if SkinManager <> nil then
    PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex, ci, Filling, State, R, pP, ItemBmp, TsSkinManager(SkinManager).CommonSkinData);
end;


procedure PaintItemFast(SkinIndex, MaskIndex, BGIndex, BGHotIndex: integer; ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject);
var
  aci: TCacheInfo;
begin
  if not (CommonSkinData is TacSkinData) then begin
{$IFDEF DEBUG}
    if IsIDERunning then
      Alert('Check parameters of the PaintItemFast procedure.');
{$ENDIF}
    Exit;
  end
  else
    with TacSkinData(CommonSkinData) do
      if FOwner.IsValidSkinIndex(SkinIndex) then
        if (R.Bottom <= ItemBmp.Height) and (R.Right <= ItemBmp.Width) and (R.Left >= 0) and (R.Top >= 0) then begin
          if gd[SkinIndex].States <= State then
            State := gd[SkinIndex].States - 1;

          PaintItemBGFast(SkinIndex, BGIndex, BGHotIndex, ci, State, R, pP, ItemBmp, CommonSkinData);
          aci := ci;
          inc(aci.X, pP.X);
          inc(aci.Y, pP.Y);
          if FOwner.IsValidImgIndex(MaskIndex) then
            DrawSkinRect(ItemBmp, R, aci, ma[MaskIndex], State, True)
          else begin
            inc(CI.X, pP.X);
            inc(CI.Y, pP.Y);
            TryPaintBorder(ItemBmp, R, gd[SkinIndex], State, CI, nil, PPI, nil);
          end;
        end;
end;


procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; SkinManager: TComponent; BGIndex: integer = -1; BGHotIndex: integer = -1); overload;
begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if SkinManager <> nil then
    PaintItem(SkinIndex, ci, Filling, State, R, pP, ItemBmp, TsSkinManager(SkinManager).CommonSkinData, BGIndex, BGHotIndex);
end;


procedure PaintItem(SkinIndex: integer; ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject; BGIndex: integer = -1; BGHotIndex: integer = -1); overload;
begin
  if (ItemBmp <> nil) and not IsRectEmpty(R) then begin
    if not (CommonSkinData is TacSkinData) then begin
{$IFDEF DEBUG}
      if IsIDERunning then
        Alert('Check parameters of the PaintItem 1 procedure.');
{$ENDIF}
      Exit;
    end
    else
      with TacSkinData(CommonSkinData) do begin
        if (FOwner <> nil) and FOwner.IsValidSkinIndex(SkinIndex) and (R.Bottom <= ItemBmp.Height) and (R.Right <= ItemBmp.Width) and (R.Left >= 0) and (R.Top >= 0) then begin
          // Count of allowed states is limited in skin
          if gd[SkinIndex].States <= State then
            State := gd[SkinIndex].States - 1;

          PaintItemBG(SkinIndex, ci, State, R, pP, ItemBmp, CommonSkinData);
          with gd[SkinIndex] do begin
            if ImgTL >= 0 then
              DrawSkinGlyph(ItemBmp, Point(R.Left, R.Top), State, 1, ma[ImgTL], MakeCacheInfo(ItemBmp));

            if ImgTR >= 0 then
              DrawSkinGlyph(ItemBmp, Point(R.Right - ma[ImgTR].Width, R.Top), State, 1, ma[ImgTR], MakeCacheInfo(ItemBmp));

            if ImgBL >= 0 then
              DrawSkinGlyph(ItemBmp, Point(R.Left, R.Bottom - ma[ImgBL].Height), State, 1, ma[ImgBL], MakeCacheInfo(ItemBmp));

            if ImgBR >= 0 then
              DrawSkinGlyph(ItemBmp, Point(R.Right - ma[ImgBR].Width, R.Bottom - ma[ImgBR].Height), State, 1, ma[ImgBR], MakeCacheInfo(ItemBmp));

            inc(ci.X, pP.X);
            inc(ci.Y, pP.Y);
            if FOwner.IsValidImgIndex(BorderIndex) then
              DrawSkinRect(ItemBmp, R, CI, ma[BorderIndex], State, True)
            else
              TryPaintBorder(ItemBmp, R, gd[SkinIndex], State, CI, nil, PPI, nil);
          end;
        end;
      end;
  end;
end;


procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; CommonSkinData: TacObject; md: TsMaskData); overload;
var
  aci: TCacheInfo;
begin
  with TacSkinData(CommonSkinData) do begin
    if (FOwner <> nil) and FOwner.IsValidSkinIndex(SkinIndex) and (R.Bottom <= ItemBmp.Height) and (R.Right <= ItemBmp.Width) and (R.Left >= 0) and (R.Top >= 0) then begin
      // Count of allowed states is limited in skin
      if gd[SkinIndex].States <= State then
        State := gd[SkinIndex].States - 1;

      PaintItemBG(SkinIndex, ci, State, R, pP, ItemBmp, CommonSkinData);
      with gd[SkinIndex] do begin
        if ImgTL >= 0 then
          DrawSkinGlyph(ItemBmp, Point(R.Left, R.Top), State, 1, ma[ImgTL], MakeCacheInfo(ItemBmp));

        if ImgTR >= 0 then
          DrawSkinGlyph(ItemBmp, Point(R.Right - ma[ImgTR].Width, R.Top), State, 1, ma[ImgTR], MakeCacheInfo(ItemBmp));

        if ImgBL >= 0 then
          DrawSkinGlyph(ItemBmp, Point(R.Left, R.Bottom - ma[ImgBL].Height), State, 1, ma[ImgBL], MakeCacheInfo(ItemBmp));

        if ImgBR >= 0 then
          DrawSkinGlyph(ItemBmp, Point(R.Right - ma[ImgBR].Width, R.Bottom - ma[ImgBR].Height), State, 1, ma[ImgBR], MakeCacheInfo(ItemBmp));

        if FOwner.IsValidImgIndex(BorderIndex) then begin
          aci := ci;
          inc(aci.X, pP.X);
          inc(aci.Y, pP.Y);
          DrawSkinRect(ItemBmp, R, aci, md, State, True);
        end;
      end;
    end;
  end;
end;


procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; DC: HDC; SkinManager: TComponent); overload; {$IFDEF WARN_DEPRECATED} deprecated; {$ENDIF}
begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if SkinManager <> nil then
    PaintItem(SkinIndex, ci, Filling, State, R, pP, DC, TsSkinManager(SkinManager).CommonSkinData);
end;


procedure PaintItem(SkinIndex: integer; const ci: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; DC: HDC; CommonSkinData: TacObject); overload;
var
  TempBmp: TBitmap;
  SavedDC: HDC;
begin
  if not (CommonSkinData is TacSkinData) then begin
{$IFDEF DEBUG}
    if IsIDERunning then
      Alert('Check parameters of the PaintItem 2 procedure.');
{$ENDIF}
    Exit;
  end
  else
    with TacSkinData(CommonSkinData), R do
      if FOwner.IsValidSkinIndex(SkinIndex) and (Left >= 0) and (Top >= 0) and (Right > Left) and (Bottom > Top) then begin
        SavedDC := SaveDC(DC);
        TempBmp := CreateBmp32(R);
        try
          PaintItem(SkinIndex, ci, Filling, State , MkRect(TempBmp), pP, TempBmp, CommonSkinData);
          BitBlt(DC, Left, top, WidthOf(R, True), HeightOf(R, True), TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
        finally
          FreeAndNil(TempBmp);
          RestoreDC(DC, SavedDC);
        end;
      end;
end;


procedure PaintItemBG(SkinData: TsCommonData; const ci: TCacheInfo; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; OffsetX: integer = 0; OffsetY: integer = 0); overload;
var
  aCustomColor: TColor;
begin
  with SkinData do begin
    if CustomColor then // If custom color used
      if FOwnerObject is TsSkinProvider then
        aCustomColor := acColorToRGB(TsSkinProvider(FOwnerObject).Form.Color, SkinData.SkinManager)
      else
        if (FOwnerControl <> nil) then
          aCustomColor := acColorToRGB(TacAccessControl(FOwnerControl).Color, SkinData.SkinManager)
        else
          aCustomColor := clFuchsia
    else
      aCustomColor := clFuchsia;

    PaintItemBG(SkinIndex, ci, State, R, pP, ItemBmp, CommonSkinData, -1, -1, aCustomColor);
  end;
end;


function PaintSection(const Bmp: TBitmap; const Section, SecondSection: string; const State: integer; const CommonSkinData: TacObject; const ParentOffset: TPoint; const BGColor: TColor; ParentDC: hdc = 0): integer;
var
  CI: TCacheInfo;
begin
  with TacSkinData(CommonSkinData) do begin
    Result := FOwner.GetSkinIndex(Section);
    if not FOwner.IsValidSkinIndex(Result) then
      Result := FOwner.GetSkinIndex(SecondSection);

    if FOwner.IsValidSkinIndex(Result) then begin
      CI.FillColor := BGColor;
      CI.Ready := ParentDC <> 0;
      if not CI.Ready then
        CI.Bmp := nil
      else begin
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, ParentDC, ParentOffset.x, ParentOffset.y, SRCCOPY);
        CI.Bmp := Bmp;
      end;
      PaintItem(Result, CI, True, State, MkRect(Bmp), MkPoint, Bmp, CommonSkinData);
    end;
  end;
end;


function PaintSection(const Bmp: TBitmap; SectionIndex: integer; const SecondIndex: integer; const State: integer; const CommonSkinData: TacObject; const ParentOffset: TPoint; const BGColor: TColor; ParentDC: hdc = 0): integer; overload;
var
  CI: TCacheInfo;
begin
  with TacSkinData(CommonSkinData) do begin
    if SectionIndex >= 0 then
      Result := SectionIndex
    else
      Result := SecondIndex;

    if Result >= 0 then begin
      CI.FillColor := BGColor;
      CI.Ready := ParentDC <> 0;
      if not CI.Ready then
        CI.Bmp := nil
      else begin
        BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, ParentDC, ParentOffset.x, ParentOffset.y, SRCCOPY);
        CI.Bmp := Bmp;
      end;
      PaintItem(Result, CI, True, State, MkRect(Bmp), MkPoint, Bmp, CommonSkinData);
    end;
  end;
end;


function TryPaintBorder(aBmp: TBitmap; const aRect: TRect; aSkinData: TsCommonData; aState: integer; const aCI: TCacheInfo): boolean;
begin
  if aSkinData.SkinIndex >= 0 then
    Result := TryPaintBorder(aBmp, aRect, aSkinData.CommonSkinData.gd[aSkinData.SkinIndex], aState, aCI, aSkinData.CustomBorder, aSkinData.CurrentPPI, nil)
  else
    Result := False;
end;


function TryPaintBorder(aBmp: TBitmap; aRect: TRect; gd: TsGeneralData; aState: integer; const aCI: TCacheInfo; CustomBorderData: TacPaintBorderData; iPPI: integer; UpdateCornersProc: TacUpdateBorderProc): boolean;
var
  CI: TCacheInfo;
  bColor: TColor;
  iWidth: integer;
  Sides: TacSides;
  PSides: PacSides;
  Radiuses: TacIntValues;
  PRadiuses: PacIntValues;

  procedure UpdateValues;
  begin
    iWidth := iWidth * iPPI div 96;
    if PRadiuses <> nil then begin
      if Assigned(UpdateCornersProc) then
        UpdateCornersProc(CustomBorderData, Radiuses, PSides)
    end;
  end;

begin
  if (CustomBorderData <> nil) and CustomBorderData.IsChanged then begin
    iWidth := CustomBorderData.Width;
    Radiuses.Value0 := CustomBorderData.GetCorner(0); // TopLeft;
    Radiuses.Value1 := CustomBorderData.GetCorner(1); // TopRight;
    Radiuses.Value2 := CustomBorderData.GetCorner(2); // BottomLeft;
    Radiuses.Value3 := CustomBorderData.GetCorner(3); // BottomRight;
    PRadiuses := @Radiuses;
    Sides := [asLeft, asTop, asRight, asBottom];
    PSides := @Sides;
    bColor := CustomBorderData.ColorNormal;
    if aState > 0 then
      if CustomBorderData.ColorActive <> clNone then
        bColor := CustomBorderData.ColorActive;

    if aState > 1 then
      if CustomBorderData.ColorPressed <> clNone then
        bColor := CustomBorderData.ColorPressed;

    if iWidth < 0 then
      iWidth := gd.BorderWidth;

    if bColor = clNone then
      bColor := gd.Props[aState].BorderColor;
  end
  else begin
    PSides := nil;
    if gd.BorderRadius > 0 then begin
      Radiuses.Value0 := gd.BorderRadius;
      Radiuses.Value1 := gd.BorderRadius;
      Radiuses.Value2 := gd.BorderRadius;
      Radiuses.Value3 := gd.BorderRadius;
      PRadiuses := @Radiuses;
    end
    else
      if Assigned(UpdateCornersProc) then begin
        Radiuses.Value0 := -1;
        Radiuses.Value1 := -1;
        Radiuses.Value2 := -1;
        Radiuses.Value3 := -1;
        PRadiuses := @Radiuses;
      end
      else
        PRadiuses := nil;

    iWidth := gd.BorderWidth;
    bColor := gd.Props[aState].BorderColor;
  end;
  UpdateValues;

  if bColor <> clFuchsia then begin
    Result := True;
    if PRadiuses <> nil then begin
      CI := aCI;
      if not CI.Ready and (CI.FillColor = clFuchsia) then
        CI.FillColor := bColor;

      if (aRect.Right - aRect.Left < PRadiuses.Value0 + PRadiuses.Value1) or (aRect.Right - aRect.Left < PRadiuses.Value2 + PRadiuses.Value3) or
         (aRect.Bottom - aRect.Top < PRadiuses.Value0 + PRadiuses.Value2) or (aRect.Bottom - aRect.Top < PRadiuses.Value1 + PRadiuses.Value3) then begin
        acgpRoundRect(aBmp.Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), iWidth, acColorToRGB(bColor){ or $FF000000}, @Radiuses, PSides);
        UpdateCorners(gd, aBmp, aRect, CI, PRadiuses);
      end
      else begin
        UpdateCorners(gd, aBmp, aRect, CI, PRadiuses);
        acgpRoundRect(aBmp.Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), iWidth, acColorToRGB(bColor){ or $FF000000}, @Radiuses, PSides);
      end;
    end
    else // Just lines
      acgpDrawRect(aBmp.Canvas.Handle, aRect, iWidth, TColor(Cardinal(bColor) or $FF000000), PSides);
//      DrawRectangleOnDC(aBmp.Canvas.Handle, aRect, bColor, bColor or $FF000000, iWidth, PSides);
  end
  else begin
    if gd.Props[aState].Transparency <> 100 then
      UpdateCorners(gd, aBmp, aRect, aCI, PRadiuses); // If BG corners are rounded

    Result := False;
  end;
end;


procedure UpdateCtrlCornersProc(PaintBorderData: TacPaintBorderData; var OutCorners: TacIntValues; var POutSides: PacSides);
var
  Ctrl: TControl;
begin
  Ctrl := TControl(PaintBorderData.FOwnerObject);
  if Ctrl <> nil then
    with OutCorners do
      if Ctrl.Width < Ctrl.Height then begin
        if Value0 + Value1 > Ctrl.Width - 1 then begin
          Value0 := (Ctrl.Width - 1) div 2;
          Value1 := Value0;
        end;
        if Value3 + Value2 > Ctrl.Width - 1 then begin
          Value3 := (Ctrl.Width - 1) div 2;
          Value2 := Value3;
        end;
      end
      else begin
        if Value0 + Value3 > Ctrl.Height - 1 then begin
          Value0 := (Ctrl.Height - 1) div 2;
          Value3 := Value0;
        end;
        if Value1 + Value2 > Ctrl.Height - 1 then begin
          Value1 := (Ctrl.Height - 1) div 2;
          Value2 := Value1;
        end;
      end;
end;


procedure PaintItem(SkinData: TsCommonData; CI: TCacheInfo; Filling: boolean; State: integer; R: TRect; pP: TPoint; ItemBmp: TBitmap; UpdateCorners: boolean; OffsetX: integer = 0; OffsetY: integer = 0; ColorsAutoUpdate: boolean = True); overload;
var
  bCheckColors: boolean;
  gdata: TsGeneralData;
  mState, bMode: integer;
begin
  with SkinData, CommonSkinData do
    if SkinManager <> nil then
      if (ItemBmp <> nil) and SkinManager.IsValidSkinIndex(SkinIndex) and RectInRect(MkRect(ItemBmp), R) then begin
        if State >= gd[SkinIndex].States then
          State := gd[SkinIndex].States - 1;

        mState := min(State, ac_MaxPropsIndex);
        PaintItemBG(SkinData, CI, mState, R, pP, ItemBmp, OffsetX, OffsetY);
        gdata := gd[SkinIndex];
        with gdata do begin
          if ImgTL >= 0 then
            DrawSkinGlyph(ItemBmp, R.TopLeft, mState, 1, ma[ImgTL], MakeCacheInfo(ItemBmp));

          if ImgTR >= 0 then
            DrawSkinGlyph(ItemBmp, Point(R.Right - ma[ImgTR].Width, R.Top), mState, 1, ma[ImgTR], MakeCacheInfo(ItemBmp));

          if ImgBL >= 0 then
            DrawSkinGlyph(ItemBmp, Point(0, R.Bottom - ma[ImgBL].Height), mState, 1, ma[ImgBL], MakeCacheInfo(ItemBmp));

          if ImgBR >= 0 then
            DrawSkinGlyph(ItemBmp, Point(R.Right - ma[ImgBR].Width, R.Bottom - ma[ImgBR].Height), mState, 1, ma[ImgBR], MakeCacheInfo(ItemBmp));

          if CustomBorder.IsChanged then
            bMode := 2
          else
            if SkinManager.IsValidImgIndex(BorderIndex) then
              bMode := integer((State <> 0) or (ma[BorderIndex].DrawMode and BDM_ACTIVEONLY = 0))
            else
              bMode := iff(gd[SkinIndex].Props[mState].BorderColor <> clFuchsia, 2, 0);

          inc(CI.X, pP.X);
          inc(CI.Y, pP.Y);
          case bMode of
            2: bCheckColors := TryPaintBorder(ItemBmp, R, SkinData.SkinManager.gd[SkinData.SkinIndex], mState, CI, SkinData.CustomBorder, SkinData.CurrentPPI, UpdateCtrlCornersProc) or (Props[mState].Transparency = 0); // Vector border
            1: begin
              DrawSkinRect(ItemBmp, R, CI, ma[BorderIndex], State, UpdateCorners);
              bCheckColors := True;
            end
            else
              bCheckColors := Props[mState].Transparency < 100;
          end;
        end;

        if bCheckColors and ColorsAutoUpdate then begin
          if SkinData.ColorTone <> clNone then
            ChangeBitmapPixels(ItemBmp, ChangeColorTone, acColorToRGB(SkinData.ColorTone), clFuchsia);

          if SkinData.HUEOffset <> 0 then
            ChangeBitmapPixels(ItemBmp, ChangeColorHUE, SkinData.HUEOffset, clFuchsia);

          if SkinData.Saturation <> 0 then
            ChangeBitmapPixels(ItemBmp, ChangeColorSaturation, SkinData.Saturation, clFuchsia);
        end;
      end;
end;


function PaintSkinControl(const SkinData: TsCommonData; const Parent: TControl; const Filling: boolean; State: integer; const R: TRect; const pP: TPoint; const ItemBmp: TBitmap; const UpdateCorners: boolean; const OffsetX: integer = 0; const OffsetY: integer = 0): boolean;
var
  bMode: integer;
  CI: TCacheInfo;
  BG: TacBGInfo;
  cR: TRect;
begin
  Result := True;
  with SkinData, SkinManager, SkinData.CommonSkinData do
    if SkinManager <> nil then
      if (ItemBmp <> nil) and RectInRect(MkRect(ItemBmp), R) and IsValidSkinIndex(SkinIndex) then begin
        if State >= gd[SkinIndex].States then
          State := gd[SkinIndex].States - 1;

        BG.PleaseDraw := False;
        GetBGInfo(@BG, Parent);
        if BG.BgType = btNotReady then
          Result := False
        else begin
          CI := BGInfoToCI(@BG);
          if SkinData.FOwnerControl is TWinControl then begin
            GetClientRect(TWinControl(SkinData.FOwnerControl).Handle, cR);
            inc(CI.X, cR.Left);
            inc(CI.Y, cR.Top);
          end;
          PaintItemBG(SkinData, CI, State, R, pP, ItemBmp, OffsetX, OffsetY);

          if CustomBorder.IsChanged then
            bMode := 2
          else
            if IsValidImgIndex(gd[SkinIndex].BorderIndex) then
              bMode := integer((State <> 0) or (ma[gd[SkinIndex].BorderIndex].DrawMode and BDM_ACTIVEONLY = 0))
            else
              if gd[SkinIndex].Props[State].BorderColor <> clFuchsia then
                bMode := 2
              else
                bMode := 0;

          inc(CI.X, pP.X);
          inc(CI.Y, pP.Y);
          case bMode of
            1: DrawSkinRect(ItemBmp, R, ci, ma[gd[SkinIndex].BorderIndex], State, UpdateCorners);
            2: TryPaintBorder(ItemBmp, R, SkinData, min(State, ac_MaxPropsIndex), CI);
          end;

          with gd[SkinIndex] do begin
            if ImgTL >= 0 then
              DrawSkinGlyph(ItemBmp, Point(R.Left, R.Top), State, 1, ma[ImgTL], MakeCacheInfo(ItemBmp));

            if ImgTR >= 0 then
              DrawSkinGlyph(ItemBmp, Point(R.Right - ma[ImgTR].Width, R.Top), State, 1, ma[ImgTR], MakeCacheInfo(ItemBmp));

            if ImgBL >= 0 then
              DrawSkinGlyph(ItemBmp, Point(0, R.Bottom - ma[ImgBL].Height), State, 1, ma[ImgBL], MakeCacheInfo(ItemBmp));

            if ImgBR >= 0 then
              DrawSkinGlyph(ItemBmp, Point(R.Right - ma[ImgBR].Width, R.Bottom - ma[ImgBR].Height), State, 1, ma[ImgBR], MakeCacheInfo(ItemBmp));
          end;
        end;
      end;
end;


procedure CopyChannel32(const DstBmp, SrcBmp: TBitmap; const Channel: integer);
var
  D0, S0, D, S: PByteArray;
  DeltaS, DeltaD, X, Y: integer;
begin
  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    for Y := 0 to DstBmp.Height - 1 do begin
      D := Pointer(PAnsiChar(D0) + DeltaD * Y);
      S := Pointer(PAnsiChar(S0) + DeltaS * Y);
      for X := 0 to DstBmp.Width - 1 do
        D[X * 4 + Channel] := S[X * 4 + Channel];
    end;
end;


procedure CopyChannel32(const DstBmp, SrcBmp: TBitmap; const Channel: integer; DstRect, SrcRect: TRect); overload;
var
  D0, S0, D, S: PByteArray;
  DeltaS, DeltaD, X, Y, X1, Y1, hSrc, wSrc: integer;
begin
  hSrc := HeightOf(SrcRect, True) - 1;
  if hSrc + SrcRect.Top >= SrcBmp.Height then
    hSrc := SrcBmp.Height - SrcRect.Top - 1;

  if hSrc + DstRect.Top >= DstBmp.Height then
    hSrc := DstBmp.Height - DstRect.Top - 1;

  if SrcRect.Top < 0 then
    Y1 := -SrcRect.Top else Y1 := 0;

  if DstRect.Top < 0 then
    Y1 := min(Y1, -SrcRect.Top);

  wSrc := WidthOf(SrcRect, True) - 1;
  if wSrc + SrcRect.Left >= SrcBmp.Width then
    wSrc := SrcBmp.Width - SrcRect.Left - 1;

  if wSrc + DstRect.Left >= DstBmp.Width then
    wSrc := DstBmp.Width - DstRect.Left - 1;

  if SrcRect.Left < 0 then
    X1 := -DstRect.Left
  else
    X1 := 0;

  if DstRect.Left < 0 then
    X1 := max(X1, -DstRect.Left);

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    with SrcRect do
      for Y := Y1 to hSrc + Y1 do begin
        D := Pointer(PAnsiChar(D0) + DeltaD * (Y + DstRect.Top));
        S := Pointer(PAnsiChar(S0) + DeltaS * (Y + Top));
        for X := X1 to wSrc + X1 do
          D[(X + DstRect.Left) * 4 + Channel] := S[(X + Left) * 4 + Channel];
      end;
end;


procedure CopyChannel(const Bmp32, Bmp8: TBitmap; const Channel: integer; const From32To8: boolean);
var
  S0, D0, D, S: PByteArray;
  DeltaS, DeltaD, X, Y: integer;
begin
  if From32To8 then begin
    if InitLine(Bmp32, Pointer(S0), DeltaS) and InitLine(Bmp8, Pointer(D0), DeltaD) then
      for Y := 0 to Bmp32.Height - 1 do begin
        D := Pointer(PAnsiChar(D0) + DeltaD * Y);
        S := Pointer(PAnsiChar(S0) + DeltaS * Y);
        for X := 0 to Bmp32.Width - 1 do
          D[X] := S[X * 4 + Channel];
      end
  end
  else
    if InitLine(Bmp8, Pointer(S0), DeltaS) and InitLine(Bmp32, Pointer(D0), DeltaD) then
      for Y := 0 to Bmp32.Height - 1 do begin
        D := Pointer(PAnsiChar(D0) + DeltaD * Y);
        S := Pointer(PAnsiChar(S0) + DeltaS * Y);
        for X := 0 to Bmp32.Width - 1 do
          D[X * 4 + Channel] := S[X];
      end;
end;


procedure PaintControlByTemplate(const DstBmp, SrcBmp: TBitmap; const DstRect, SrcRect, BorderWidths, BorderMaxWidths: TRect; const DrawModes: TRect; const StretchCenter: boolean; FillCenter: boolean = True);
var
  X, Y, w, h, dl, dr, dt, db, xCenter, yCenter, actLeft, actTop, actRight, actBottom: integer;
begin
  with TSrcRect(SrcRect), TDstRect(DstRect), BorderWidths do begin
    dl := min(Left,   BorderMaxWidths.Left);
    dr := min(Right,  BorderMaxWidths.Right);
    dt := min(Top,    BorderMaxWidths.Top);
    db := min(Bottom, BorderMaxWidths.Bottom);
    xCenter := (DLeft + DRight) div 2;
    yCenter := (DTop + DBottom) div 2;

    actLeft := min(Left, xCenter);
    actTop := min(Top, yCenter);
    actRight := min(DRight - xCenter, Right);
    actBottom := min(DBottom - yCenter, Bottom);

    SetStretchBltMode(DstBmp.Canvas.Handle, COLORONCOLOR);
    // Copy corners
    // LeftTop
    BitBlt(DstBmp.Canvas.Handle, DLeft, DTop, actLeft, dt, SrcBmp.Canvas.Handle, SLeft, STop, SRCCOPY);
    if dt <> Top then
      BitBlt(DstBmp.Canvas.Handle, DLeft, DTop + dt, dl, actTop - dt, SrcBmp.Canvas.Handle, SLeft, STop + dt, SRCCOPY);

    // LeftBottom
    BitBlt(DstBmp.Canvas.Handle, DLeft, DBottom - db, actLeft, db, SrcBmp.Canvas.Handle, SLeft, SBottom - db, SRCCOPY);
    if db <> Bottom then
      BitBlt(DstBmp.Canvas.Handle, DLeft, DBottom - actBottom, dl, actBottom - db, SrcBmp.Canvas.Handle, SLeft, SBottom - actBottom, SRCCOPY);

    // RightTop
    BitBlt(DstBmp.Canvas.Handle, DRight - actRight, DTop, actRight, dt, SrcBmp.Canvas.Handle, SRight - actRight, STop, SRCCOPY);
    if dt <> Top then
      BitBlt(DstBmp.Canvas.Handle, DRight - dr, DTop + dt, dr, actTop - dt, SrcBmp.Canvas.Handle, SRight - dr, STop + dt, SRCCOPY);

    // RightBottom
    BitBlt(DstBmp.Canvas.Handle, DRight - actRight, DBottom - db, actRight, db, SrcBmp.Canvas.Handle, SRight - actRight, SBottom - db, SRCCOPY);
    if db <> Bottom then
      BitBlt(DstBmp.Canvas.Handle, DRight - dr, DBottom - actBottom, dr, actBottom - db, SrcBmp.Canvas.Handle, SRight - dr, SBottom - actBottom, SRCCOPY);

    w := max(0, WidthOf (SrcRect, True) - Right - Left);
    h := max(0, HeightOf(SrcRect, True) - Bottom - Top);
    // Left border
    if h <> 0 then
      case DrawModes.Left and BDM_STRETCH of
        0: begin
          X := DLeft;
          Y := DTop + actTop;
          while Y < DBottom - actBottom - h do begin
            BitBlt(DstBmp.Canvas.Handle, X, Y, dl, h, SrcBmp.Canvas.Handle, SLeft, STop + actTop, SRCCOPY);
            inc(Y, h);
          end;
          if Y < DBottom - actBottom then
            BitBlt(DstBmp.Canvas.Handle, X, Y, dl, DBottom - actBottom - Y, SrcBmp.Canvas.Handle, SLeft, STop + actTop, SRCCOPY);
        end;

        1:
          StretchBlt(DstBmp.Canvas.Handle, DLeft, DTop + actTop, dl, DBottom - DTop - actTop - actBottom,
                     SrcBmp.Canvas.Handle, SLeft, STop + actTop, dl, SBottom - STop - actTop - Bottom, SRCCOPY);
      end;
    // Top border
    if w <> 0 then
      case DrawModes.Top and BDM_STRETCH of
        0: begin
          X := DLeft + actLeft;
          Y := DTop;
          while X < DRight - actRight - w do begin
            BitBlt(DstBmp.Canvas.Handle, X, Y, w, dt, SrcBmp.Canvas.Handle, SLeft + actLeft, STop, SRCCOPY);
            inc(X, w);
          end;
          if X < DRight - actRight then
            BitBlt(DstBmp.Canvas.Handle, X, Y, DRight - actRight - X, dt, SrcBmp.Canvas.Handle, SLeft + actLeft, STop, SRCCOPY);
        end;

        1:
          StretchBlt(DstBmp.Canvas.Handle, DLeft + actLeft, DTop, DRight - DLeft - actLeft - actRight, dt,
                     SrcBmp.Canvas.Handle, SLeft + actLeft, STop, SRight - SLeft - actLeft - actRight, dt, SRCCOPY);
      end;
    // Right border
    if h <> 0 then
      case DrawModes.Right and BDM_STRETCH of
        0: begin
          X := DRight - dr;
          Y := DTop + actTop;
          while Y < DBottom - actBottom - h do begin
            BitBlt(DstBmp.Canvas.Handle, X, Y, dr, h, SrcBmp.Canvas.Handle, SRight - dr, STop + actTop, SRCCOPY);
            inc(Y, h);
          end;
          if Y < DBottom - actBottom then
            BitBlt(DstBmp.Canvas.Handle, X, Y, dr, DBottom - actBottom - Y, SrcBmp.Canvas.Handle, SRight - dr, STop + actTop, SRCCOPY);
        end;

        1:
          StretchBlt(DstBmp.Canvas.Handle, DRight - dr, DTop + actTop, dr, DBottom - DTop - actBottom - actTop,
                     SrcBmp.Canvas.Handle, SRight - dr, STop + actTop, dr, SBottom - STop - actBottom - actTop, SRCCOPY);
      end;
    // Bottom border
    if w <> 0 then
      case DrawModes.Bottom and BDM_STRETCH of
        0: begin
          X := DLeft + actLeft;
          Y := DBottom - db;
          while X < DRight - actRight - w do begin
            BitBlt(DstBmp.Canvas.Handle, X, Y, w, db, SrcBmp.Canvas.Handle, SLeft + actLeft, SBottom - db, SRCCOPY);
            inc(X, w);
          end;
          if X < DRight - actRight then
            BitBlt(DstBmp.Canvas.Handle, X, Y, DRight - actRight - X, db, SrcBmp.Canvas.Handle, SLeft + actLeft, SBottom - db, SRCCOPY);
        end;

        1:
          StretchBlt(DstBmp.Canvas.Handle, DLeft + actLeft, DBottom - db, DRight - DLeft - actRight - actLeft, db,
                     SrcBmp.Canvas.Handle, SLeft + actLeft, SBottom - db, SRight - SLeft - actRight - actLeft, db, SRCCOPY);
      end;
    // Center
    if FillCenter then
      if StretchCenter then
        StretchBlt(DstBmp.Canvas.Handle, DLeft + actLeft, DTop + actTop,
                   DRight - DLeft - actRight - actLeft, DBottom - DTop - actBottom - actTop,
                   SrcBmp.Canvas.Handle, SLeft + actLeft, STop + actTop,
                   SRight - SLeft - actRight - actLeft, SBottom - STop - actBottom - actTop, SRCCOPY)
      else
        if (h <> 0) and (w <> 0) then begin
          X := DLeft + actLeft;
          while X < DRight - actRight - w do begin
            Y := DTop + actTop;
            while Y < DBottom - actBottom - h do begin
              BitBlt(DstBmp.Canvas.Handle, X, Y, w, h, SrcBmp.Canvas.Handle, SLeft + actLeft, STop + actTop, SRCCOPY);
              inc(Y, h);
            end;
            if Y < DBottom - actBottom then
              BitBlt(DstBmp.Canvas.Handle, X, Y, w, DBottom - actBottom - Y, SrcBmp.Canvas.Handle, SLeft + actLeft, STop + actTop, SRCCOPY);

            inc(X, w);
          end;
          if X < DRight - actRight then begin
            Y := DTop + actTop;
            while Y < DBottom - actBottom - h do begin
              BitBlt(DstBmp.Canvas.Handle, X, Y, DRight - actRight - X, h, SrcBmp.Canvas.Handle, SLeft + actLeft, STop + actTop, SRCCOPY);
              inc(Y, h);
            end;
            if Y < DBottom - actBottom then
              BitBlt(DstBmp.Canvas.Handle, X, Y, DRight - actRight - X, DBottom - actBottom - Y, SrcBmp.Canvas.Handle, SLeft + actLeft, STop + actTop, SRCCOPY);
          end;
        end;
  end;
end;


procedure DrawGlyphReflection(DstBmp, SrcBmp: TBitmap; DstTopLeft: TPoint; SrcRect: TRect; TransColor: TsColor_; BlendValue: integer);
var
  DeltaS, DeltaD, MaskValue, oldleft, oldtop, dx, dy, h, w, bWidth, bHeight, curX, nextX: integer;
  TransStep, TransValue: byte;
  S0, D0, D: PRGBAArray_;
  S: PRGBAArray_S;
begin
  if SrcRect.Top < 0 then begin
    oldtop := SrcRect.Top;
    SrcRect.Top := 0
  end
  else
    oldtop := 0;

  if SrcRect.Left < 0 then begin
    oldleft := SrcRect.Left;
    SrcRect.Left := 0
  end
  else
    oldleft := 0;

  if SrcRect.Bottom >= SrcBmp.Height then
    SrcRect.Bottom := SrcBmp.Height - 1;

  if SrcRect.Right >= SrcBmp.Width then
    SrcRect.Right := SrcBmp.Width - 1;

  w := WidthOf(SrcRect);
  bWidth := DstBmp.Width - 1;
  bHeight := DstBmp.Height - 1;
  h := min(SrcBmp.Height div 3 * 2 - 1, bHeight - DstTopLeft.Y);

  TransStep := MaxByte div (h + 1);
  TransValue := MaxByte;
  TransColor.C := SwapColor(TransColor.C);

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    with DstTopLeft do
      for dy := 0 to h do
        if (dy + Y <= bHeight) and (dy + Y >= 0) then
          if dy + SrcRect.Top >= 0 then begin
            S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Bottom - dy - oldtop));
            if dy + Y - oldtop >= 0 then
              if dy + Y - oldtop < DstBmp.Height then begin
                D := Pointer(PAnsiChar(D0) + DeltaD * (Y + dy));
                nextX := X - oldleft;
                CurX := SrcRect.Left;
                MaskValue := (MaxByte * (h - dy) div h * TransValue shr 9 * (100 - BlendValue) div 100) and MaxByte;
                for dx := 0 to w do
                  if nextX > bWidth then
                    Break
                  else
                    if (nextX >= 0) and (CurX < SrcBmp.Width) then begin
                      with S[CurX] do
                        if SC <> TransColor.C then
                          with D[nextX] do begin
                            R := ((SR - R) * MaskValue + R shl 8) shr 8;
                            G := ((SG - G) * MaskValue + G shl 8) shr 8;
                            B := ((SB - B) * MaskValue + B shl 8) shr 8;
                          end;

                      inc(nextX);
                      inc(CurX);
                    end;

                dec(TransValue, TransStep);
              end;
          end;
end;


procedure DrawGlyphEx(Glyph, DstBmp: TBitmap; R: TRect; NumGlyphs: integer; Enabled: boolean; DisabledGlyphKind: TsDisabledGlyphKind; State, Blend: integer; Down: boolean = False; Reflected: boolean = False);
var
  CI: TCacheInfo;
  TmpGlyph: TBitmap;
  MaskColor: TsColor;
  w, GlyphIndex: integer;
begin
  GlyphIndex := -1;
  TmpGlyph := CreateBmp32;
  TmpGlyph.Assign(Glyph);
  TmpGlyph.PixelFormat := pf32bit;
  if Reflected then
    OffsetRect(R, 0, - HeightOf(R) div 8);

  if NumGlyphs = 1 then
    State := 0;

  if State > 0 then
    Blend := 0;

  if not Enabled then
    GlyphIndex := 0
  else begin
    case State of
      0:
        GlyphIndex := 0;

      1:
        if (Glyph.PixelFormat = pf4bit) or (DefaultManager = nil) or DefaultManager.Options.StdGlyphsOrder then
          GlyphIndex := 0
        else
          GlyphIndex := 1;

      2:
        if NumGlyphs > 2 + integer(Down) then
          GlyphIndex := 2 + integer(Down)
        else begin
          if (Glyph.PixelFormat = pf4bit) or (DefaultManager = nil) or DefaultManager.Options.StdGlyphsOrder then
            GlyphIndex := 0
          else
            GlyphIndex := min(1, NumGlyphs - 1);
        end;

      3:
        if NumGlyphs > 2 then
          GlyphIndex := 2
        else
          GlyphIndex := 0;
    end;
  end;
  w := TmpGlyph.Width div NumGlyphs;
  MaskColor := TsColor(TmpGlyph.Canvas.Pixels[GlyphIndex * w, TmpGlyph.Height - 1]);
  if Enabled or (Blend = 0) then begin
    CI := MakeCacheInfo(DstBmp);
    CopyTransRectA(DstBmp, TmpGlyph, R.Left, R.Top, Rect(w * GlyphIndex, 0, (GlyphIndex + 1) * w - 1, TmpGlyph.Height - 1), MaskColor.C, CI)
  end
  else
    BlendTransRectangle(DstBmp, R.Left, R.Top, TmpGlyph, Rect(w * GlyphIndex, 0, (GlyphIndex + 1) * w - 1, TmpGlyph.Height - 1), byte(Blend));

  if Reflected then begin
    OffsetRect(R, 0, HeightOf(R));
    DrawGlyphReflection(DstBmp, TmpGlyph, R.TopLeft, Rect(w * GlyphIndex, 0, (GlyphIndex + 1) * w - 1, TmpGlyph.Height - 1), TsColor_(MaskColor), Blend);
  end;
  FreeAndNil(TmpGlyph);
end;
{$ENDIF}


procedure FillDC(DC: HDC; const aRect: TRect; const Color: TColor; AlphaValue: integer = 0);
var
  OldBrush, NewBrush: hBrush;
  SavedDC: hdc;
begin
  if AlphaValue <> 0 then
    acgpFillRect(DC, Color, aRect, AlphaValue)
  else begin
    SavedDC := SaveDC(DC);
    NewBrush := CreateSolidBrush(Cardinal(ColorToRGB(Color)));
    OldBrush := SelectObject(DC, NewBrush);
    try
      FillRect(DC, aRect, NewBrush);
    finally
      SelectObject(DC, OldBrush);
      DeleteObject(NewBrush);
      RestoreDC(DC, SavedDC);
    end;
  end;
end;


procedure FillDCBorder(const DC: HDC; const aRect: TRect; const wl, wt, wr, wb: integer; const Color: TColor; AlphaValue: integer = 0);
var
  OldBrush, NewBrush: hBrush;
  SavedDC: hWnd;
begin
  if AlphaValue > 0 then
    with aRect do begin
      acgpFillRect(DC, Color, Rect(Left,       Top,         Right,     Top + wt),    AlphaValue);
      acgpFillRect(DC, Color, Rect(Left,       Top + wt,    Left + wl, Bottom),      AlphaValue);
      acgpFillRect(DC, Color, Rect(Left + wl,  Bottom - wb, Right,     Bottom),      AlphaValue);
      acgpFillRect(DC, Color, Rect(Right - wr, Top + wt,    Right,     Bottom - wb), AlphaValue);
    end
  else begin
    SavedDC := SaveDC(DC);
    NewBrush := CreateSolidBrush(Cardinal(ColorToRGB(Color)));
    OldBrush := SelectObject(dc, NewBrush);
    with aRect do
      try
        FillRect(DC, Rect(Left,       Top,         Right,     Top + wt),    NewBrush);
        FillRect(DC, Rect(Left,       Top + wt,    Left + wl, Bottom),      NewBrush);
        FillRect(DC, Rect(Left + wl,  Bottom - wb, Right,     Bottom),      NewBrush);
        FillRect(DC, Rect(Right - wr, Top + wt,    Right,     Bottom - wb), NewBrush);
      finally
        SelectObject(dc, OldBrush);
        DeleteObject(NewBrush);
        RestoreDC(DC, SavedDC);
      end;
  end;
end;


procedure BitBltBorder(const DestDC: HDC; const X, Y, Width, Height: Integer; const SrcDC: HDC; const XSrc, YSrc: Integer; WidthLeft: integer; WidthTop: integer = -1; WidthRight: integer = -1; WidthBottom: integer = -1);
begin
  if WidthLeft < 0 then
    WidthLeft := 0;

  if WidthBottom < 0 then begin
    WidthBottom := WidthLeft;
    if WidthTop < 0 then
      WidthTop := WidthLeft;

    if WidthRight < 0 then
      WidthRight := WidthLeft;
  end;
  // Left
  BitBlt(DestDC, X, Y, WidthLeft, Height, SrcDC, XSrc, YSrc, SRCCOPY);
  // Top
  BitBlt(DestDC, X + WidthLeft, Y, Width, WidthTop, SrcDC, XSrc + WidthLeft, YSrc, SRCCOPY);
  // Right
  BitBlt(DestDC, X + Width - WidthRight, Y + WidthTop, WidthRight, Height, SrcDC, XSrc + Width - WidthRight, YSrc + WidthTop, SRCCOPY);
  // Bottom
  BitBlt(DestDC, X + WidthLeft, Y + Height - WidthBottom, Width - WidthRight, Height, SrcDC, XSrc + WidthLeft, YSrc + Height - WidthBottom, SRCCOPY);
end;


procedure ExcludeControls(const DC: hdc; const Ctrl: TWinControl; const OffsetX: integer; const OffsetY: integer);
var
  i: integer;
  Child: TControl;
begin
  for i := 0 to Ctrl.ControlCount - 1 do begin
    Child := Ctrl.Controls[i];
    if (Child is TGraphicControl) and ((DefaultManager = nil) or DefaultManager.Options.StdImgTransparency) {$IFNDEF ALITE} or (Child is TsSplitter) {$ENDIF} then
      Continue;

    with Child do
      if Visible then
        ExcludeClipRect(DC, Left + OffsetX, Top + OffsetY, Left + Width + OffsetX, Top + Height + OffsetY);
  end;
end;


procedure GrayScale(Bmp: TBitmap);
var
  S0, S: PRGBAArray_;
  Delta, x, y, w, h: integer;
begin
  h := Bmp.Height - 1;
  w := Bmp.Width - 1;
  if InitLine(Bmp, Pointer(S0), Delta) then
    for y := 0 to h do begin
      S := Pointer(PAnsiChar(S0) + Delta * Y);
      for x := 0 to w do
        with S[x] do begin
          R := Round(0.299 * R + 0.587 * G + 0.114 * B);
          G := R;
          B := R;
        end
    end;
end;


procedure GrayScaleTrans(Bmp: TBitmap; const TransColor: TsColor);
var
  S0, S: PRGBAArray_;
  InvColor: TsColor_;
  Delta, x, y, w, h: integer;
begin
  h := Bmp.Height - 1;
  w := Bmp.Width - 1;
  InvColor.C := TransColor.C;
  InvColor.R := TransColor.B;
  InvColor.B := TransColor.R;
  if InitLine(Bmp, Pointer(S0), Delta) then
    for Y := 0 to h do begin
      S := Pointer(PAnsiChar(S0) + Delta * Y);
      for X := 0 to w do
        with S[x] do
          if C <> InvColor.C then begin
            R := Round(0.299 * R + 0.587 * G + 0.114 * B);
            G := R;
            B := R
          end
    end;
end;


procedure PaintTransBG(Bmp: TBitmap; R: TRect; Color1, Color2: TColor; Size: integer);
var
  SavedDC: hdc;
  x, y: integer;
begin
  if Bmp.PixelFormat <> pf32bit then
    Bmp.PixelFormat := pf32bit;

  SavedDC := SaveDC(Bmp.Canvas.Handle);
  IntersectClipRect(Bmp.Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);
  try
    FillRect32(Bmp, Rect(R.Left, R.Top, R.Left + Size, R.Top + Size), Color1);
    FillRect32(Bmp, Rect(R.Left + Size, R.Top, R.Left + 2 * Size, R.Top + Size), Color2);
    // Draw line
    x := R.Left + 2 * Size;
    while x < R.Right do begin
      BitBlt(Bmp.Canvas.Handle, x, R.Top, 2 * Size, Size, Bmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
      inc(x, 2 * Size);
    end;
    // Draw second line
    FillRect32(Bmp, Rect(R.Left, R.Top + Size, R.Left + Size, R.Top + 2 * Size), Color2);
    BitBlt(Bmp.Canvas.Handle, R.Left + Size, R.Top + Size, WidthOf(R) - Size, Size, Bmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
    // Copy lines
    y := R.Top + 2 * Size;
    while y < R.Bottom do begin
      BitBlt(Bmp.Canvas.Handle, R.Left, y, WidthOf(R), 2 * Size, Bmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
      inc(y, 2 * Size);
    end;
  finally
    RestoreDC(Bmp.Canvas.Handle, SavedDC);
  end;

{
  FillRect32(Bmp, R, Color1);
  y := R.Top;
  while y < R.Bottom do begin
    x := R.Left + iff((y div Size) mod 2 = 1, 0, Size);
    maxY := min(y + Size, R.Bottom);
    while x < R.Right do begin
      FillRect32(Bmp, Rect(x, y, min(x + Size, R.Right), maxY), Color2);
      inc(x, Size * 2);
    end;
    inc(y, Size);
  end;
}
end;


procedure SetBmp32Pixels(var Bmp: TBitmap);
{$IFDEF FPC}
var
  TmpBmp: TBitmap;
begin
  if Bmp.PixelFormat <> pf32bit then begin
    TmpBmp := CreateBmp32(Bmp.Width, Bmp.Height);
    BitBlt(TmpBmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    Bmp.Free;
    Bmp := TmpBmp;
  end
{$ELSE}
begin
  Bmp.PixelFormat := pf32bit;
{$ENDIF}
end;


function CutText(Canvas: TCanvas; const Text: acString; MaxLength: integer): acString;
begin
  Result := iff(MaxLength <= 0, '', Text);
  if (Canvas.TextWidth(Result) > MaxLength) and (Result <> '') then begin
    while (Result <> '') and (Canvas.TextWidth(Result + s_Ellipsis) > MaxLength) do
      Delete(Result, Length(Result), 1);

    if Result <> '' then
      Result := Result + s_Ellipsis;
  end;
end;


procedure WriteText(Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal);
var
  x, y: integer;
  R, Rd: TRect;
  ts: TSize;
begin
  R := aRect;
  if Flags or DT_WORDBREAK <> Flags then begin // If not multiline
    GetTextExtentPoint32(Canvas.Handle, Text, Length(Text), ts);
    R.Right := R.Left + ts.cx;
    R.Bottom := R.Top + ts.cy;
    if Flags or DT_CENTER = Flags then begin
      y := (HeightOf(R) - HeightOf(aRect)) div 2;
      x := (WidthOf(R, True) - WidthOf(aRect, True)) div 2;
      InflateRect(aRect, x, y);
    end
    else
      if Flags or DT_RIGHT = Flags then begin
        y := (HeightOf(R) - HeightOf(aRect)) div 2;
        dec(aRect.Top, y);
        inc(aRect.Bottom, y);
        inc(aRect.Left, WidthOf(aRect, True) - WidthOf(R, True));
      end
      else
        if Flags or DT_LEFT = Flags then begin
          y := (HeightOf(R) - HeightOf(aRect)) div 2;
          dec(aRect.Top, y);
          inc(aRect.Bottom, y);
          inc(aRect.Right, WidthOf(R) - WidthOf(aRect));
        end;

    R := aRect;
    InflateRect(aRect, 1, 1);
  end;
  Canvas.Brush.Style := bsClear;
  if Text <> ''then
    if Enabled then
      DrawText(Canvas.Handle, Text, Length(Text), R, Flags)
    else begin
      Rd := Rect(R.Left + 1, R.Top + 1, R.Right + 1, R.Bottom + 1);
      Canvas.Font.Color := ColorToRGB(clBtnHighlight);
      DrawText(Canvas.Handle, Text, Length(Text), Rd, Flags);
      Canvas.Font.Color := ColorToRGB(clBtnShadow);
      DrawText(Canvas.Handle, Text, Length(Text), R, Flags);
    end;
end;


procedure WriteTextOnDC(DC: hdc; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal);
var
  x, y: integer;
  R, Rd: TRect;
  ts: TSize;
begin
  if Text <> '' then begin
    R := aRect;
    SetBkMode(DC, TRANSPARENT);
    if Flags or DT_WORDBREAK <> Flags then begin // If no multiline
      GetTextExtentPoint32(DC, Text, Length(Text), ts);
      R.Right := R.Left + ts.cx;
      R.Bottom := R.Top + ts.cy;
      if Flags or DT_CENTER = Flags then begin
        y := (HeightOf(R) - HeightOf(aRect)) div 2;
        x := (WidthOf(R) - WidthOf(aRect)) div 2;
        InflateRect(aRect, x, y);
      end
      else
        if Flags or DT_RIGHT = Flags then begin
          y := (HeightOf(R) - HeightOf(aRect)) div 2;
          dec(aRect.Top, y);
          inc(aRect.Bottom, y);
          inc(aRect.Left, WidthOf(aRect) - WidthOf(R));
        end
        else
          if Flags or DT_LEFT = Flags then begin
            y := (HeightOf(R) - HeightOf(aRect)) div 2;
            dec(aRect.Top, y);
            inc(aRect.Bottom, y);
            inc(aRect.Right, WidthOf(R) - WidthOf(aRect));
          end;

      R := aRect;
      InflateRect(aRect, 1, 1);
    end;
    if Enabled then
      DrawText(DC, Text, Length(Text), R, Flags)
    else begin
      Rd := Rect(R.Left + 1, R.Top + 1, R.Right + 1, R.Bottom + 1);
      DrawText(DC, Text, Length(Text), Rd, Flags);
      DrawText(DC, Text, Length(Text), R, Flags);
    end;
  end;
end;


function acDrawText32(hDC: HDC; const Text: ACString; var lpRect: TRect; uFormat: Cardinal; AlphaLayer: boolean; Bmp: TBitmap = nil): Integer;
begin
  if DT_CALCRECT and uFormat = 0 then begin
    if not acgpDrawString(hDC, Text, lpRect, SwapRedBlue(GetTextColor(hDC)), AlignmentFromInt(uFormat), VertAlignmentFromInt(uFormat), 0, AlphaLayer) and Assigned(Bmp) then
      // If GDI+ can't use current font, try again without DT_ALPHATEXT
      WriteColor(Bmp, PacChar(Text), True, lpRect, uFormat and not DT_ALPHATEXT, GetTextColor(hDC));
  end
  else
    with acgpMeasureString(hDC, Text, Cardinal(uFormat and DT_WORDBREAK) <> 0, WidthOf(lpRect)) do begin
      lpRect.Right := lpRect.Left + cx;
      lpRect.Bottom := lpRect.Top + cy;
    end;

  Result := 1;
end;


function acDrawText(hDC: HDC; const Text: ACString; var lpRect: TRect; uFormat: Cardinal; Bmp: TBitmap = nil): Integer;
begin
  if (DT_ALPHATEXT and uFormat = 0) {or (DT_CALCRECT and uFormat <> 0) }then
  {$IFDEF TNTUNICODE}
    Result := Tnt_DrawTextW(hDC, PACChar(Text), min(5460, Length(Text)), lpRect, uFormat)
  {$else}
    Result := DrawText(hDC, PACChar(Text), min(5460, Length(Text)) {fix the bug in API}, lpRect, uFormat)
  {$ENDIF}
  else
    Result := acDrawText32(hDC, Text, lpRect, uFormat, Cardinal(DT_ALPHATEXT and uFormat) <> 0, Bmp)
end;


function acExtTextOut(DC: HDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PacChar; Count: Longint; Dx: PInteger): boolean;
begin
  Result := {$IFDEF TNTUNICODE}ExtTextOutW{$ELSE}ExtTextOut{$ENDIF}(DC, X, Y, Options, Rect, Str, Count, Dx);
end;


function acTextWidth(const Canvas: TCanvas; const Text: ACString): Integer;
begin
{$IFDEF TNTUNICODE}
  Result := WideCanvasTextExtent(Canvas, Text).cx;
{$ELSE}
  Result := Canvas.TextExtent(Text).cx;
{$ENDIF}
end;


function acTextHeight(const Canvas: TCanvas; const Text: ACString): Integer;
begin
{$IFDEF TNTUNICODE}
  Result := WideCanvasTextExtent(Canvas, Text).cy;
{$ELSE}
  Result := Canvas.TextExtent(Text).cy;
{$ENDIF}
end;


function acTextExtent(const Canvas: TCanvas; const Text: ACString): TSize;
begin
{$IFDEF TNTUNICODE}
  Result := WideCanvasTextExtent(Canvas, Text);
{$ELSE}
  Result := Canvas.TextExtent(Text);
{$ENDIF}
end;


procedure acTextRect(const Canvas: TCanvas; const Rect: TRect; X, Y: Integer; const Text: ACString);
begin
{$IFDEF TNTUNICODE}
  WideCanvasTextRect(Canvas, Rect, X, Y, Text);
{$ELSE}
  Canvas.TextRect(Rect, X, Y, Text);
{$ENDIF}
end;


function acGetTextExtent(const DC: HDC; const Str: acString; var Size: TSize; AFont: HFONT = 0): BOOL;
var
  ActDC: hdc;
begin
  if DC <> 0 then
    ActDC := DC
  else begin
    ActDC := GetDC(0);
    if AFont <> 0 then
      SelectObject(ActDC, AFont);
  end;
{$IFDEF TNTUNICODE}
  Result := GetTextExtentPoint32W(ActDC, PWideChar(Str), Length(Str), Size);
{$ELSE}
  Result := GetTextExtentPoint32(ActDC, PChar(Str), Length(Str), Size);
{$ENDIF}
  if DC = 0 then
    ReleaseDC(0, ActDC);
end;


function acGetTextExtentW(const DC: HDC; const Str: WideString; var Size: TSize; AFont: HFONT = 0): BOOL;
var
  ActDC: hdc;
begin
  if DC <> 0 then
    ActDC := DC
  else begin
    ActDC := GetDC(0);
    if AFont <> 0 then
      SelectObject(ActDC, AFont);
  end;
  Result := GetTextExtentPoint32W(ActDC, PWideChar(Str), Length(Str), Size);
  if DC = 0 then
    ReleaseDC(0, ActDC);
end;


procedure acDrawGlowForText(const DstBmp: TBitmap; Text: PacChar; aRect: TRect; Flags: Cardinal; Side: Cardinal; BlurSize: integer; Color: TColor; var MaskBmp: TBitmap);
const
  Offs = 4;
  lOffs = 1;
var
  gColor: TsColor;
  M0, M: PByteArray;
  D0, D: PRGBAArray_D;
  bMask, bMask2: byte;
  RR, lRect, tmpRect: TRect;
  bWidth, X, Y, DeltaD, DeltaM: integer;
begin
  OffsetRect(aRect, 1, 1);
  RR := aRect;
  gColor.C := Color;
  InflateRect(RR, BlurSize + Offs, BlurSize + Offs);
  if (MaskBmp = nil) or (MaskBmp.Width <> WidthOf(RR)) or (MaskBmp.Height <> HeightOf(RR)) then begin
    if MaskBmp = nil then
      MaskBmp := CreateBmp32;

    MaskBmp.PixelFormat := pf8bit;
    MaskBmp.Width := WidthOf(RR, True);
    MaskBmp.Height := HeightOf(RR, True);
    MaskBmp.Canvas.Brush.Color := clWhite;
    MaskBmp.Canvas.FillRect(MkRect(MaskBmp));

    MaskBmp.Canvas.Font.Assign(DstBmp.Canvas.Font);
    MaskBmp.Canvas.Font.Color := 0;
    MaskBmp.Canvas.Brush.Style := bsClear;

    lRect := Rect(BlurSize + Offs, BlurSize + Offs, BlurSize + Offs + WidthOf(aRect), BlurSize + Offs + HeightOf(aRect));
    if Side and BF_LEFT = BF_LEFT then begin
      tmpRect := Rect(lRect.Left - lOffs, lRect.Top, lRect.Right - lOffs, lRect.Bottom);
      acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    end;
    if Side and BF_TOP = BF_TOP then begin
      tmpRect := Rect(lRect.Left, lRect.Top - lOffs, lRect.Right, lRect.Bottom - lOffs);
      acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    end;
    if Side and BF_RIGHT = BF_RIGHT then begin
      tmpRect := Rect(lRect.Left + lOffs, lRect.Top, lRect.Right + lOffs, lRect.Bottom);
      acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    end;
    if Side and BF_BOTTOM = BF_BOTTOM then begin
      tmpRect := Rect(lRect.Left, lRect.Top + lOffs, lRect.Right, lRect.Bottom + lOffs);
      acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    end;
    tmpRect := lRect;
    acDrawText(MaskBmp.Canvas.Handle, Text, tmpRect, Flags);
    Blur8(MaskBmp, BlurSize);
  end;
  if MaskBmp <> nil then begin
    bWidth := MaskBmp.Width - 1;
    if InitLine(MaskBmp, Pointer(M0), DeltaM) and InitLine(DstBmp, Pointer(D0), DeltaD) then
      for Y := 0 to MaskBmp.Height - 1 do
        if (aRect.Top + Y - BlurSize - Offs >= 0) and (aRect.Top + Y - BlurSize - Offs < DstBmp.Height) then begin
          D := Pointer(PAnsiChar(D0) + DeltaD * (aRect.Top + Y - BlurSize - Offs));
          M := Pointer(PAnsiChar(M0) + DeltaM * Y);
          for X := 0 to bWidth do
            if M[X] <> MaxByte then
              if (aRect.Left + X - BlurSize - Offs >= 0) and (aRect.Left + X - BlurSize - Offs < DstBmp.Width) then begin
                bMask := M[X];
                bMask2 := MaxByte - bMask;
                with D[aRect.Left + X - BlurSize - Offs], gColor do begin
                  DA := DA + (MaxByte - DA) * bMask2 shr 8;
                  DR := (R * bMask2 + DR * bMask) shr 8;
                  DG := (G * bMask2 + DG * bMask) shr 8;
                  DB := (B * bMask2 + DB * bMask) shr 8;
                end;
              end;
        end;
  end;
end;


procedure acPaintLine(DC: hdc; X1, Y1, X2, Y2: integer);
begin
  MoveToEx(DC, X1, Y1, nil);
  LineTo(DC, X2, Y2);
end;

(*
procedure MakeRectOpaque(PaintBuffer: THandle; Rect: PRect = nil);
//var
//  MemDC: HDC;
//  PaintBuffer: HPAINTBUFFER;
begin
//  BufferedPaintInit;
//  PaintBuffer := BeginBufferedPaint(DC, Rect^, BPBF_TOPDOWNDIB, nil, MemDC);
  try
    if PaintBuffer <> 0 then
      BufferedPaintSetAlpha(PaintBuffer, Rect, MaxByte);
  finally
    EndBufferedPaint(PaintBuffer, True);
//    BufferedPaintUnInit;
  end;
end;
*)

procedure MakeGaussianKernel(var K: TKernel; radius: double; MaxData, DataGranularity: double);
var
  j: integer;
  temp, delta: double;
  KernelSize: TKernelSize;
begin
  with K do begin
    for j := Low(Weights) to High(Weights) do begin
      temp := j / radius;
      Weights[j] := Round(exp(-temp * temp / 2));
    end;

    temp := 0;
    for j := Low(Weights) to High(Weights) do
      temp := temp + Weights[j];

    for j := Low(Weights) to High(Weights) do
      Weights[j] := Weights[j] / temp;

    KernelSize := MaxKernelSize;
    delta := DataGranularity / (2 * MaxData);
    temp := 0;
    while (temp < delta) and (KernelSize > 1) do begin
      temp := temp + 2 * Weights[KernelSize];
      dec(KernelSize);
    end;
    Size := KernelSize;
    temp := 0;

    for j := -Size to Size do
      temp := temp + Weights[j];

    for j := -Size to Size do
      Weights[j] := Weights[j] / temp;
  end;
end;


procedure BlurRow8(var theRow: array of byte; const K: TKernel; P: PByteArray);
var
  j, n, h: integer;
  d: double;
begin
  h := High(theRow);
  if h >= 0 then begin
    with K do
      for j := 0 to h do begin
        d := 0;
        for n := -Size to Size do
          d := d + Weights[n] * theRow[LimIt(j - n, 0, h)];

        if d > MaxByte then
          P[j] := MaxByte
        else
          if d < 0 then
            P[j] := 0
          else
            P[j] := Round(d);
      end;

    Move(P[0], theRow[0], (h + 1));
  end;
end;


procedure Blur8(Bmp: TBitmap; radius: double);
var
  K: TKernel;
  P, ACol: PByteArray;
  R0, theRows: PByteArrays;
  bWidth, bHeight, DeltaR, Row, Col: integer;
begin
  with Bmp do
    if (HandleType = bmDIB) and (PixelFormat = pf8Bit) then begin
      bWidth := Width - 1;
      bHeight := Height - 1;
      MakeGaussianKernel(K, radius, MaxByte, 1);
      GetMem(theRows, Height * SizeOf(PByteArrays));
      GetMem(ACol, Height);
      if InitLine(Bmp, Pointer(R0), DeltaR) then begin
        for Row := 0 to bHeight do
          theRows[Row] := Pointer(LongInt(R0) + DeltaR * Row);

        P := AllocMem(Width);
        for Row := 0 to bHeight do
          BlurRow8(Slice(theRows[Row]^, Width), K, P);

        ReAllocMem(P, Height);
        for Col := 0 to bWidth do begin
          for Row := 0 to bHeight do
            ACol[Row] := theRows[Row][Col];

          BlurRow8(Slice(ACol^, Height), K, P);
          for Row := 0 to bHeight do
            theRows[Row][Col] := ACol[Row];
        end;
      end;
      FreeMem(theRows);
      FreeMem(ACol);
      ReAllocMem(P, 0);
    end;
end;


procedure QBlur(Bmp: TBitmap);
{$IFNDEF WIN64}
var
  TmpBmp: TBitmap;
begin

  TmpBmp := CreateBmp32(Bmp.Width div 2, Bmp.Height div 2);
  acgpStretchRect(TmpBmp, Bmp, 0, 0, Bmp.Width - 1, Bmp.Height - 1);
  acgpStretchRect(Bmp, TmpBmp, 0, 0, TmpBmp.Width - 1, TmpBmp.Height - 1);
  TmpBmp.Free;
{$ELSE}
begin
  acgpBlur(Bmp, 1);
{$ENDIF}
end;


procedure acWriteTextEx(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal; const SkinData: TsCommonData; const Hot: boolean; const SkinManager: TObject = nil; CanGlow: boolean = True);
begin
{$IFDEF TNTUNICODE}
  WriteTextExW(Canvas, Text, Enabled, aRect, Flags, SkinData, Hot, CanGlow);
{$ELSE}
  WriteTextEx(Canvas, Text, Enabled, aRect, Flags, SkinData, Hot, SkinManager, CanGlow);
{$ENDIF}
end;


procedure acWriteTextEx(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal; const SkinIndex: integer; const Hot: boolean; const SkinManager: TObject = nil);
begin
{$IFDEF TNTUNICODE}
  WriteTextExW(Canvas, Text, Enabled, aRect, Flags, SkinIndex, Hot, SkinManager);
{$ELSE}
  WriteTextEx(Canvas, Text, Enabled, aRect, Flags, SkinIndex, Hot, SkinManager);
{$ENDIF}
end;


procedure acWriteText(const Canvas: TCanvas; const Text: PacChar; const Enabled: boolean; var aRect: TRect; const Flags: Cardinal);
begin
{$IFDEF TNTUNICODE}
  DrawTextW(Canvas.Handle, Text, Length(Text), aRect, Flags);
{$ELSE}
  acDrawText(Canvas.Handle, Text, {Length(Text), }aRect, Flags);
{$ENDIF}
end;


{$IFNDEF ACHINTS}
procedure WriteTextEx(const Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil); overload;
var
  R, Rd: TRect;
  State: integer;
begin
  if Text <> '' then begin
    if SkinManager = nil then
      SkinManager := DefaultManager;

    SetBkMode(Canvas.Handle, TRANSPARENT);
    if not Assigned(SkinManager) or not TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) then
      acDrawText(Canvas.Handle, Text, aRect, Flags)
    else
      with TsSkinManager(SkinManager), CommonSkinData do begin
        R := aRect;
        if Enabled then begin
          State := integer(Hot);
          if IsValidSkinIndex(SkinIndex) then
            with gd[SkinIndex].Props[State].FontColor do begin
              // Left
              if Left <> -1 then begin
                Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
                SetTextColor(Canvas.Handle, Cardinal(Left));
                acDrawText(Canvas.Handle, Text, Rd, Flags);
              end;
              // Top
              if Top <> -1 then begin
                Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
                SetTextColor(Canvas.Handle, Cardinal(Top));
                acDrawText(Canvas.Handle, Text, Rd, Flags);
              end;
              // Right
              if Right <> -1 then begin
                Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
                SetTextColor(Canvas.Handle, Cardinal(Right));
                acDrawText(Canvas.Handle, Text, Rd, Flags);
              end;
              // Bottom
              if Bottom <> -1 then begin
                Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
                SetTextColor(Canvas.Handle, Cardinal(Bottom));
                acDrawText(Canvas.Handle, Text, Rd, Flags);
              end;
              // Center
              SetTextColor(Canvas.Handle, Cardinal(Color));
              acDrawText(Canvas.Handle, Text, R, Flags);
            end
          else
            acDrawText(Canvas.Handle, Text, R, Flags);
        end
        else begin
          Rd := R;
          if IsValidSkinIndex(SkinIndex) then
            Canvas.Font.Color := BlendColors(gd[SkinIndex].Props[0].FontColor.Color, gd[SkinIndex].Props[0].Color, DefBlendDisabled)
          else
            Canvas.Font.Color := Graphics.clGrayText;

          acDrawText(Canvas.Handle, Text, Rd, Flags);
        end;
      end;
  end;
end;
{$ENDIF}


function UpdateColor(Color: TColor; SkinData: TsCommonData): TColor;
begin
  with SkinData do begin
    if ColorTone <> clNone then
      Result := ChangeTone(Color, SwapRedBlue(ColorToRGB(ColorTone)))
    else
      Result := Color;

    Result := ColortoRGB(ChangeSaturation(ChangeHUE(HUEOffset, Result), Saturation shl 8 div 100));
  end;
end;


procedure WriteTextEx(const Canvas: TCanvas; Text: PChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean; SkinManager: TObject = nil; CanGlow: boolean = True); overload;
var
  C: TColor;
  R, Rd: TRect;
  SavedDC: hdc;
  pi: TacPaintInfo;
  SM: TsSkinManager;
  FGlowMask: TBitmap;
  State, nLength, aSkinIndex, i: integer;

  procedure DrawStd;
  begin
    if Enabled then
      DrawText(Canvas.Handle, Text, nLength, R, Flags)
    else begin
      Rd := OffsRect(R, 1);
      Canvas.Font.Color := clBtnHighlight;
      DrawText(Canvas.Handle, Text, nLength, Rd, Flags);
      Canvas.Font.Color := clBtnShadow;
      DrawText(Canvas.Handle, Text, nLength, R, Flags);
    end;
  end;

begin
  if Text <> '' then
    with SkinData, SkinManager.SkinCommonInfo do begin
      nLength := StrLen(Text);
      R := aRect;
      SM := SkinManager;
      if Hot and Skinned and (SkinIndex = Sections[ssWebBtn]) then
        Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];

      Canvas.Brush.Style := bsClear;
      SavedDC := SaveDC(Canvas.Handle);
      try
        if Skinned and not CustomFont then begin
          State := integer(Hot);
          aSkinIndex := -1;
          if (FOwnerControl <> nil) and (SectionInArray(Sections, SkinIndex, ssMenuItem, ssButton) or SectionInArray(Sections, SkinIndex, ssTBBtn, ssTBBtn)) and (FOwnerControl.Parent <> nil) then begin
            pi.SkinManager := SM;
            pi.R := FOwnerControl.BoundsRect;
            pi.State := State;
            pi.FontIndex := SkinIndex;
            case FOwnerControl.Perform(SM_ALPHACMD, AC_GETFONTINDEX_HI, LParam(@pi)) of
              -1: aSkinIndex := SkinIndex;
              0: aSkinIndex := -1 // Parent not skinned
              else
                if pi.FontIndex >= 0 then begin
                  aSkinIndex := pi.FontIndex;
                  SM := TsSkinManager(pi.SkinManager);
                end;
            end;
//            case Ctrl.Perform(SM_ALPHACMD, AC_GETFONTINDEX_HI, LParam(@pi)) of
//            aSkinIndex := GetFontIndex(FOwnerControl, SkinIndex, SM, State{integer(Hot)})
          end
          else
            aSkinIndex := SkinIndex;

          if (aSkinIndex < 0) and (FOwnerControl.Parent <> nil) then begin // Get font from not skinned parent
            Canvas.Font.Color := TacAccessControl(FOwnerControl.Parent).Font.Color;
            DrawStd;
            Exit;
          end;

          State := min(State, ac_MaxPropsIndex);
          if SM.IsValidSkinIndex(aSkinIndex) then
//            with SkinData.CommonSkinData.gd[aSkinIndex].Props[State] do begin
            with SM.gd[aSkinIndex].Props[State] do begin
              if CanGlow and (FCacheBmp <> nil) then begin
                i := GlowSize;
                if i <> 0 then begin
                  IntersectClipRect(Canvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
                  FGlowMask := nil;
                  c := UpdateColor(GlowColor, SkinData);
                  acDrawGlowForText(FCacheBmp, PacChar(Text), R, Flags, BF_RECT, i, C, FGlowMask);
                  FreeAndNil(FGlowMask);
                  RestoreDC(Canvas.Handle, SavedDC);
                  SavedDC := SaveDC(Canvas.Handle);
                end;
              end;
              if Enabled then begin
                // Left contour
                if not CustomFont then
                  with FontColor do begin
                    if Left <> -1 then begin
                      Rd := OffsRect(R, -1, 0);
                      SetTextColor(Canvas.Handle, UpdateColor(Left, SkinData));
                      acDrawText(Canvas.Handle, Text, Rd, Flags);
                    end;
                    // Top
                    if Top <> -1 then begin
                      Rd := OffsRect(R, 0, -1);
                      SetTextColor(Canvas.Handle, UpdateColor(Top, SkinData));
                      acDrawText(Canvas.Handle, Text, Rd, Flags);
                    end;
                    // Right
                    if Right <> -1 then begin
                      Rd := OffsRect(R, 1, 0);
                      SetTextColor(Canvas.Handle, UpdateColor(Right, SkinData));
                      acDrawText(Canvas.Handle, Text, Rd, Flags);
                    end;
                    // Bottom
                    if Bottom <> -1 then begin
                      Rd := OffsRect(R, 0, 1);
                      SetTextColor(Canvas.Handle, UpdateColor(Bottom, SkinData));
                      acDrawText(Canvas.Handle, Text, Rd, Flags);
                    end;
                    // Center
                    SetTextColor(Canvas.Handle, UpdateColor(Color, SkinData));
                    acDrawText(Canvas.Handle, Text, R, Flags);
                  end
                else
                  acDrawText(Canvas.Handle, Text, R, Flags);
              end
              else begin
                Canvas.Font.Color := UpdateColor(BlendColors(FontColor.Color, SkinManager.GetGlobalColor, DefBlendDisabled), SkinData);
                acDrawText(Canvas.Handle, Text, R, Flags);
              end
            end
            else
              acDrawText(Canvas.Handle, Text, R, Flags);
        end
        else
          DrawStd;
      finally
        RestoreDC(Canvas.Handle, SavedDC);
      end;
    end;
end;


{$IFDEF TNTUNICODE}
procedure WriteTextExW(const Canvas: TCanvas; Text: PWideChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean; CanGlow: boolean = True); overload;
var
  C: TColor;
  R, Rd: TRect;
  SavedDC: hdc;
  FGlowMask: TBitmap;
  State, nLength, aSkinIndex, i: integer;
begin
  if Text <> '' then
    with SkinData do begin
      nLength := Length(Text);
      R := aRect;
      if Hot and Skinned and (SkinIndex = SkinManager.SkinCommonInfo.Sections[ssWebBtn]) then
        Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];

      SavedDC := SaveDC(Canvas.Handle);
      try
        IntersectClipRect(Canvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
        if Skinned then begin
          State := min(integer(Hot), ac_MaxPropsIndex);
          if (FOwnerControl <> nil) and
               SectionInArray(SkinManager.SkinCommonInfo.Sections, SkinIndex, ssMenuItem, ssWebBtn) and
                    (FOwnerControl.Parent <> nil) then
            aSkinIndex := GetFontIndex(FOwnerControl, SkinIndex, SkinManager, integer(Hot))
          else
            aSkinIndex := SkinIndex;

          Canvas.Brush.Style := bsClear;
          if SkinManager.IsValidSkinIndex(aSkinIndex) then
            with SkinManager.gd[aSkinIndex].Props[State] do begin
              if FCacheBmp <> nil then begin
                i := GlowSize;
                if i <> 0 then begin
                  FGlowMask := nil;
                  C := UpdateColor(GlowColor, SkinData);
                  acDrawGlowForText(FCacheBmp, PacChar(Text), R, Flags, BF_RECT, i, C, FGlowMask);
                  FreeAndNil(FGlowMask);
                end;
              end;
              if Enabled then begin
                // Left contour
                if not CustomFont then begin
                  if FontColor.Left <> -1 then begin
                    C := UpdateColor(FontColor.Left, SkinData);
                    Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
                    SetTextColor(Canvas.Handle, C);
                    Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
                  end;
                  // Top
                  if FontColor.Top <> -1 then begin
                    C := UpdateColor(FontColor.Top, SkinData);
                    Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
                    SetTextColor(Canvas.Handle, C);
                    Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
                  end;
                  // Right
                  if FontColor.Right <> -1 then begin
                    C := UpdateColor(FontColor.Right, SkinData);
                    Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
                    SetTextColor(Canvas.Handle, C);
                    Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
                  end;
                  // Bottom
                  if FontColor.Bottom <> -1 then begin
                    C := UpdateColor(FontColor.Bottom, SkinData);
                    Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
                    SetTextColor(Canvas.Handle, C);
                    Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
                  end;
                  // Center
                  C := UpdateColor(FontColor.Color, SkinData);
                  SetTextColor(Canvas.Handle, C);
                  Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags or DT_NOCLIP);
                end
                else
                  Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags or DT_NOCLIP);
              end
              else begin
                Canvas.Font.Color := UpdateColor(BlendColors(FontColor.Color, SkinManager.GetGlobalColor, DefBlendDisabled), SkinData);
                Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
              end
            end
            else
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
        end
        else
          if Enabled then
            Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags)
          else begin
            OffsetRect(R, 1, 1);
            Canvas.Font.Color := clBtnHighlight;
            Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
            OffsetRect(R, -1, -1);
            Canvas.Font.Color := clBtnShadow;
            Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
          end;
      finally
        RestoreDC(Canvas.Handle, SavedDC);
      end;
    end;
end;


procedure WriteUnicode(const Canvas: TCanvas; const Text: WideString; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinData: TsCommonData; Hot: boolean); overload;
var
  ts: TSize;
  SavedDC: hdc;
  R, Rd: TRect;
  nLength, State, x, y: integer;
begin
  nLength := Length(Text);
  R := aRect;
  if Hot and SkinData.Skinned and (SkinData.SkinIndex = SkinData.SkinManager.SkinCommonInfo.Sections[ssWebBtn]) then
    Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];

  State := integer(Hot);
  SavedDC := SaveDC(Canvas.Handle);
  try
    IntersectClipRect(Canvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
    if Flags or DT_WORDBREAK <> Flags then begin // If no multiline
      ts := WideCanvasTextExtent(Canvas, Text);

      R.Right := R.Left + ts.cx;
      R.Bottom := R.Top + ts.cy;

      if Flags or DT_CENTER = Flags then begin
        y := (HeightOf(R) - HeightOf(aRect)) div 2;
        x := (WidthOf(R) - WidthOf(aRect)) div 2;
        InflateRect(aRect, x, y);
      end
      else
        if Flags or DT_RIGHT = Flags then begin
          y := (HeightOf(R) - HeightOf(aRect)) div 2;
          dec(aRect.Top, y);
          inc(aRect.Bottom, y);
          inc(aRect.Left, WidthOf(aRect) - WidthOf(R));
        end
        else
          if Flags or DT_LEFT = Flags then begin
            y := (HeightOf(R) - HeightOf(aRect)) div 2;
            dec(aRect.Top, y);
            inc(aRect.Bottom, y);
            inc(aRect.Right, WidthOf(R) - WidthOf(aRect));
          end;

      R := aRect;
      InflateRect(aRect, 1, 1);
    end;
    Canvas.Brush.Style := bsClear;
    Flags := ETO_CLIPPED or Flags;
    if Text <> '' then
      if Enabled then begin
        if Assigned(SkinData.SkinManager) and SkinData.SkinManager.IsValidSkinIndex(SkinData.SkinIndex) then
          // Left contur
          if not SkinData.CustomFont then
            with SkinData.CommonSkinData.gd[SkinData.SkinIndex].Props[State].FontColor do begin
              if Left <> -1 then begin
                Canvas.Font.Color := UpdateColor(Left, SkinData);
                Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
                Windows.ExtTextOutW(Canvas.Handle, Rd.Left, Rd.Top, Flags, @Rd, PWideChar(Text), nLength, nil)
              end;
              // Top
              if Top <> -1 then begin
                Canvas.Font.Color := Top;
                Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
                Windows.ExtTextOutW(Canvas.Handle, Rd.Left, Rd.Top, Flags, @Rd, PWideChar(Text), nLength, nil)
              end;
              // Right
              if Right <> -1 then begin
                Canvas.Font.Color := Right;
                Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
                Windows.ExtTextOutW(Canvas.Handle, Rd.Left, Rd.Top, Flags, @Rd, PWideChar(Text), nLength, nil)
              end;
              // Bottom
              if Bottom <> -1 then begin
                Canvas.Font.Color := Bottom;
                Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
                Windows.ExtTextOutW(Canvas.Handle, Rd.Left, Rd.Top, Flags, @Rd, PWideChar(Text), nLength, nil)
              end;
              // Center
              Canvas.Font.Color := Color;
            end;
            Windows.ExtTextOutW(Canvas.Handle, R.Left, R.Top, Flags, @R, PWideChar(Text), nLength, nil)
          end
        else
          Windows.ExtTextOutW(Canvas.Handle, R.Left, R.Top, Flags, @R, PWideChar(Text), nLength, nil)
      else begin
        Canvas.Font.Color := BlendColors(SkinData.CommonSkinData.gd[SkinData.SkinIndex].Props[0].FontColor.Color, SkinData.CommonSkinData.gd[SkinData.SkinIndex].Props[0].Color, DefBlendDisabled);
        Windows.ExtTextOutW(Canvas.Handle, R.Left, R.Top, Flags, @R, PWideChar(Text), nLength, nil)
      end;
  finally
    RestoreDC(Canvas.Handle, SavedDC);
  end;
end;


procedure TextRectW(const Canvas: TCanvas; var Rect: TRect; X, Y: Integer; const Text: WideString);
begin
  WideCanvasTextRect(Canvas, Rect, X, Y, Text);
end;


procedure WriteTextExW(const Canvas: TCanvas; Text: PWideChar; Enabled: boolean; var aRect: TRect; Flags: Cardinal; SkinIndex: integer; Hot: boolean; SkinManager: TObject = nil);
var
  ts: TSize;
  R, Rd: TRect;
  i, x, y, nLength: Integer;
begin
  nLength := {$IFNDEF D2006}WStrLen(Text){$ELSE}Length(Text){$ENDIF};
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if not Assigned(SkinManager) or not TsSkinManager(SkinManager).IsValidSkinIndex(SkinIndex) then
    Tnt_DrawTextW(Canvas.Handle, Text, nLength, aRect, Flags)
  else
    with TsSkinManager(SkinManager) do begin
      R := aRect;
      if (Flags or DT_WORDBREAK <> Flags) and (Flags or DT_END_ELLIPSIS <> Flags) then begin // If not multiline
        GetTextExtentPoint32W(Canvas.Handle, Text, nLength, ts);
        R.Right := R.Left + ts.cx;
        R.Bottom := R.Top + ts.cy;

        if Flags or DT_CENTER = Flags then begin
          y := (HeightOf(R) - HeightOf(aRect)) div 2;
          x := (WidthOf(R) - WidthOf(aRect)) div 2;
          InflateRect(aRect, x, y);
        end
        else
          if Flags or DT_RIGHT = Flags then begin
            y := (HeightOf(R) - HeightOf(aRect)) div 2;
            dec(aRect.Top, y);
            inc(aRect.Bottom, y);
            inc(aRect.Left, WidthOf(aRect) - WidthOf(R));
          end
          else
            if Flags or DT_LEFT = Flags then begin
              y := (HeightOf(R) - HeightOf(aRect)) div 2;
              dec(aRect.Top, y);
              inc(aRect.Bottom, y);
              inc(aRect.Right, WidthOf(R) - WidthOf(aRect));
            end;

        R := aRect;
        InflateRect(aRect, 1, 1);
      end;
      Canvas.Brush.Style := bsClear;
      i := integer(Hot);
      if Text <> '' then
        if Enabled then begin
          if IsValidSkinIndex(SkinIndex) then begin
            // Left contur
            Canvas.Font.Color := gd[SkinIndex].Props[i].FontColor.Left;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left - 1, R.Top, R.Right - 1, R.Bottom);
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Top
            Canvas.Font.Color := gd[SkinIndex].Props[i].FontColor.Top;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left, R.Top - 1, R.Right, R.Bottom - 1);
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Right
            Canvas.Font.Color := gd[SkinIndex].Props[i].FontColor.Right;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left + 1, R.Top, R.Right + 1, R.Bottom);
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Bottom
            Canvas.Font.Color := gd[SkinIndex].Props[i].FontColor.Bottom;
            if Canvas.Font.Color <> -1 then begin
              Rd := Rect(R.Left, R.Top + 1, R.Right, R.Bottom + 1);
              Tnt_DrawTextW(Canvas.Handle, Text, nLength, Rd, Flags);
            end;
            // Center
            Canvas.Font.Color := gd[SkinIndex].Props[i].FontColor.Color;
            Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
          end
          else
            Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
        end
        else begin
          Canvas.Font.Color := BlendColors(gd[SkinIndex].Props[i].FontColor.Color, gd[SkinIndex].Props[i].Color, DefBlendDisabled);
          Tnt_DrawTextW(Canvas.Handle, Text, nLength, R, Flags);
        end;
    end;
end;
{$ENDIF}


procedure FadeBmp(FadedBmp: TBitMap; aRect: TRect; Transparency: integer; const Color: TsColor; Blur, Radius: integer);
var
  rr: TRect;
  delta: real;
  Ct: TsColor;
  RValue, ii: integer;
  Bmp, TempBmp: Graphics.TBitmap;
begin
  Bmp := CreateBmp32(aRect.Right - aRect.Left, aRect.Bottom - aRect.Top);
  TempBmp := CreateBmp32(Bmp.Width, Bmp.Height);
  Blur   := min(min(TempBmp.Width div 2, TempBmp.Height div 2), Blur);
  Radius := min(min(TempBmp.Width div 2, TempBmp.Height div 2), Radius);
  RValue := MaxByte * Transparency div 100;
  // Copy faded area in Ftb
  bitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, FadedBmp.Canvas.Handle, aRect.Left, aRect.Top, SrcCopy);

  TempBmp.Canvas.Pen.Style   := psClear;
  TempBmp.Canvas.Brush.Style := bsSolid;
  TempBmp.Canvas.Brush.Color := clWhite;

  delta := (MaxByte - RValue) / (Blur + 1);
  // Prepare template
  Ct.C := clWhite;

  with Ct do
    for ii := 0 to Blur do begin
      TempBmp.Canvas.Brush.Color := C;
      TempBmp.Canvas.RoundRect(ii, ii, TempBmp.Width - ii, TempBmp.Height - ii, Radius, Radius);
      R := RValue + Round(Delta * (Blur - ii));
      G := R;
      B := R;
    end;
    
  rr := Rect(Blur, Blur, TempBmp.Width - Blur, TempBmp.Height - Blur);

  TempBmp.Canvas.Brush.Color := Ct.C;
  TempBmp.Canvas.Pen.Style := psClear;
  TempBmp.Canvas.Brush.Style := bsSolid;
  TempBmp.Canvas.RoundRect(rr.Left, rr.Top, rr.Right, rr.Bottom, Blur, Blur);

  BlendBmpByMask(Bmp, TempBmp, Color);
  // Copy back
  BitBlt(FadedBmp.Canvas.Handle, aRect.Left, aRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
  FreeAndNil(Bmp);
  FreeAndNil(TempBmp);
end;


procedure BlendTransRectangle(Dst: TBitmap; X, Y: integer; Src: TBitmap; aRect: TRect; Blend: byte; TransColor: TColor = clFuchsia); overload;
var
  oldleft, oldtop, dx, dy, h, w, width, height, curX, nextX, DeltaS, DeltaD: integer;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  Blend2: byte;
begin
  if aRect.Top < 0 then begin
    oldtop := aRect.Top;
    aRect.Top := 0
  end
  else
    oldtop := 0;

  if aRect.Left < 0 then begin
    oldleft := aRect.Left;
    aRect.Left := 0
  end
  else
    oldleft := 0;

  if aRect.Bottom >= Src.Height then
    aRect.Bottom := Src.Height - 1;

  if aRect.Right >= Src.Width then
    aRect.Right := Src.Width - 1;

  h := HeightOf(aRect);
  w := WidthOf(aRect);
  width := Dst.Width - 1;
  height := Dst.Height - 1;
  Blend2 := MaxByte - Blend;

  if InitLine(Src, Pointer(S0), DeltaS) and InitLine(Dst, Pointer(D0), DeltaD) then
    for dy := 0 to h do
      if dy + Y > height then
        Exit
      else
        if dy + Y >= 0 then
          if dy + aRect.Top >= 0 then begin
            S := Pointer(PAnsiChar(S0) + DeltaS * (dy + aRect.Top));
            if dy + Y - oldtop >= 0 then
              if dy + Y - oldtop >= Dst.Height then
                Exit
              else begin
                D := Pointer(PAnsiChar(D0) + DeltaD * (dy + Y - oldtop));
                nextX := X - oldleft;
                CurX := aRect.Left;
                for dx := 0 to w do
                  if nextX > Width then
                    Break
                  else
                    if nextX >= 0 then
                      if CurX < Src.Width then begin
                        with S[CurX] do
                          if SC <> TransColor then
                            with D[nextX] do begin
                              DR := (SR * Blend2 + Blend * DR) shr 8;
                              DG := (SG * Blend2 + Blend * DG) shr 8;
                              DB := (SB * Blend2 + Blend * DB) shr 8;
                              DA := (SA * Blend2 + Blend * DA) shr 8;
                            end;

                        inc(nextX);
                        inc(CurX);
                      end;
              end;
          end;
end;


procedure BlendTransBitmap(Bmp: TBitmap; Blend: byte; const Color: TsColor);
var
  Blend2: byte;
  S: PRGBAArray_S;
  w, h, dx, dy: integer;
begin
  w := Bmp.Width - 1;
  h := Bmp.Height - 1;
  Blend2 := MaxByte - Blend;
  for dy := 0 to h do begin
    S := Bmp.ScanLine[dy];
    for dx := 0 to w do
      with S[dX] do
        if SC <> clFuchsia then
          with Color do begin
            SR := (SR * Blend + R * Blend2) shr 8;
            SG := (SG * Blend + G * Blend2) shr 8;
            SB := (SB * Blend + B * Blend2) shr 8;
          end;
  end;
end;


procedure BlendBmpByMask(SrcBmp, MskBmp: Graphics.TBitMap; const BlendColor: TsColor);
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaD, DeltaS: integer;
  minW, minH, X, Y, rr, gg, bb: integer;
begin
  if (SrcBmp.Width = MskBmp.Width) and (SrcBmp.Height = MskBmp.Height) then begin
    minH := SrcBmp.Height - 1;
    minW := SrcBmp.Width - 1;
    rr := BlendColor.R shl 8;
    gg := BlendColor.G shl 8;
    bb := BlendColor.B shl 8;

    if InitLine(MskBmp, Pointer(S0), DeltaS) and InitLine(SrcBmp, Pointer(D0), DeltaD) then
      with BlendColor do
        for Y := 0 to minH do begin
          S := Pointer(PAnsiChar(S0) + DeltaS * Y);
          D := Pointer(PAnsiChar(D0) + DeltaD * Y);
          for X := 0 to minW do
            with D[X], S[X] do begin
              DR := ((DR - R) * SR + rr) shr 8;
              DG := ((DG - G) * SG + gg) shr 8;
              DB := ((DB - B) * SB + bb) shr 8;
            end
        end;
  end;
end;

{
procedure BlendBmpRectByMask(SrcBmp, MskBmp: Graphics.TBitMap; TopLeft: TPoint; const BlendColor: TsColor);
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaD, DeltaS: integer;
  minW, minH: integer;
  rr, gg, bb: integer;
  X, Y: Integer;
begin
  minH := MskBmp.Height - 1;
  minW := MskBmp.Width - 1;
  rr := BlendColor.R shl 8;
  gg := BlendColor.G shl 8;
  bb := BlendColor.B shl 8;

  if InitLine(MskBmp, Pointer(S0), DeltaS) and InitLine(SrcBmp, Pointer(D0), DeltaD) then
    with BlendColor do
      for Y := 0 to minH do begin
        S := Pointer(PAnsiChar(S0) + DeltaS * Y);
        D := Pointer(PAnsiChar(D0) + DeltaD * (Y + TopLeft.Y));
        for X := 0 to minW do
          with D[X + TopLeft.X], S[X], BlendColor do begin
            DR := ((DR - R) * SR + rr) shr 8;
            DG := ((DG - G) * SG + gg) shr 8;
            DB := ((DB - B) * SB + bb) shr 8;
          end
      end;
end;
}

procedure SumBitmaps(SrcBmp, MskBmp: Graphics.TBitMap; const AlphaValue: byte);
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaD, DeltaS, X, Y: Integer;
begin
  if (SrcBmp.Width = MskBmp.Width) and (SrcBmp.Height = MskBmp.Height) then
    if InitLine(MskBmp, Pointer(S0), DeltaS) and InitLine(SrcBmp, Pointer(D0), DeltaD) then
      for Y := 0 to SrcBmp.Height - 1 do begin
        S := Pointer(PAnsiChar(S0) + DeltaS * Y);
        D := Pointer(PAnsiChar(D0) + DeltaD * Y);
        for X := 0 to SrcBmp.Width - 1 do
          with D[X], S[X] do begin
            DR := ((DR - SR) * AlphaValue + SR shl 8) shr 8;
            DG := ((DG - SG) * AlphaValue + SG shl 8) shr 8;
            DB := ((DB - SB) * AlphaValue + SB shl 8) shr 8;
          end
      end;
end;


procedure SumBitmapsToDst(DstBmp, SrcBmp1, SrcBmp2: Graphics.TBitMap; const AlphaValue: byte);
var
  S10, S1: PRGBAArray_S;
  S20, S2: PRGBAArray_M;
  D0, D: PRGBAArray_D;
  DeltaD, DeltaS1, DeltaS2, X, Y: Integer;
begin
  if (SrcBmp1.Width = DstBmp.Width) and (SrcBmp1.Height = DstBmp.Height) then
    if InitLine(SrcBmp1, Pointer(S10), DeltaS1) and InitLine(SrcBmp2, Pointer(S20), DeltaS2) and InitLine(DstBmp, Pointer(D0), DeltaD) then
      for Y := 0 to SrcBmp1.Height - 1 do begin
        S1 := Pointer(PAnsiChar(S10) + DeltaS1 * Y);
        S2 := Pointer(PAnsiChar(S20) + DeltaS2 * Y);
        D := Pointer(PAnsiChar(D0) + DeltaD * Y);
        for X := 0 to SrcBmp1.Width - 1 do
          with D[X], S1[X], S2[X] do begin
            DR := ((MR - SR) * AlphaValue + SR shl 8) shr 8;
            DG := ((MG - SG) * AlphaValue + SG shl 8) shr 8;
            DB := ((MB - SB) * AlphaValue + SB shl 8) shr 8;
            DA := ((MA - SA) * AlphaValue + SA shl 8) shr 8;
          end
      end;
end;


procedure PaintBmp32(SrcBmp, MskBmp: Graphics.TBitMap);
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaD, DeltaS, X, Y: Integer;
begin
  if (SrcBmp.Width = MskBmp.Width) and (SrcBmp.Height = MskBmp.Height) then
    if InitLine(MskBmp, Pointer(S0), DeltaS) and InitLine(SrcBmp, Pointer(D0), DeltaD) then
      for Y := 0 to SrcBmp.Height - 1 do begin
        S := Pointer(PAnsiChar(S0) + DeltaS * Y);
        D := Pointer(PAnsiChar(D0) + DeltaD * Y);
        for X := 0 to SrcBmp.Width - 1 do
          with D[X], S[X] do begin
            DR := ((SR - DR) * SA + DR shl 8) shr 8;
            DG := ((SG - DG) * SA + DG shl 8) shr 8;
            DB := ((SB - DB) * SA + DB shl 8) shr 8;
          end
      end;
end;


procedure SumBmpRect(const DstBmp, SrcBmp: Graphics.TBitMap; const AlphaValue: byte; SrcRect: TRect; DstPoint: TPoint);
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, X, Y, Xd, Yd: Integer;
begin
  with TSrcRect(SrcRect) do begin
    // Coordinates correcting
    if DstPoint.x < 0 then begin
      inc(SLeft, -DstPoint.x);
      DstPoint.x := 0;
    end;
    if DstPoint.y < 0 then begin
      inc(STop, -DstPoint.y);
      DstPoint.y := 0;
    end;
    if SLeft < 0 then begin
      inc(DstPoint.x, -SLeft);
      SLeft := 0;
      if DstPoint.x < 0 then begin
        inc(SLeft, -DstPoint.x);
        DstPoint.x := 0;
      end;
    end;
    if STop < 0 then begin
      inc(DstPoint.y, - STop);
      STop := 0;
      if DstPoint.y < 0 then begin
        inc(STop, - DstPoint.y);
        DstPoint.y := 0;
      end;
    end;

    if (SRight > SLeft) and (SBottom > STop) then
      if (DstPoint.x < DstBmp.Width) and (DstPoint.y < DstBmp.Height) then
        if (SLeft < SrcBmp.Width) and (STop < SrcBmp.Height) then begin
          if SRight >= SrcBmp.Width then
            SRight := SrcBmp.Width - 1;

          if SBottom >= SrcBmp.Height then
            SBottom := SrcBmp.Height - 1;

          if DstPoint.x + WidthOf(SrcRect) >= DstBmp.Width then
            SRight := SLeft + (DstBmp.Width - DstPoint.x) - 1;

          if DstPoint.y + HeightOf(SrcRect) >= DstBmp.Height then
            SBottom := STop + (DstBmp.Height - DstPoint.y) - 1;

          Yd := DstPoint.Y;
          if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
            for Y := STop to SBottom do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              Xd := DstPoint.X;
              for X := SLeft to SRight do
                with D[Xd], S[X] do begin
                  DR := ((DR - SR) * AlphaValue + SR shl 8) shr 8;
                  DG := ((DG - SG) * AlphaValue + SG shl 8) shr 8;
                  DB := ((DB - SB) * AlphaValue + SB shl 8) shr 8;
                  DA := ((DA - SA) * AlphaValue + SA shl 8) shr 8;
                  inc(Xd);
                end;

              inc(Yd);
            end;
        end;
  end;
end;


procedure MixDiagBmpRect(const DstBmp, SrcBmp: Graphics.TBitMap; SrcXShift: integer; SrcRect: TRect; DstPoint: TPoint);
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, X, Y, Xd, Yd: Integer;

  function IsSrcPixel(NewX, NewY: integer): boolean;
  begin
{    if SrcXShift = 0 then
      Result := False
    else             }
      Result := SrcXShift > (NewX + HeightOf(SrcRect) - NewY);
  end;

begin
  with TSrcRect(SrcRect) do begin
    // Coordinates correcting
    if DstPoint.x < 0 then begin
      inc(SLeft, -DstPoint.x);
      DstPoint.x := 0;
    end;
    if DstPoint.y < 0 then begin
      inc(STop, -DstPoint.y);
      DstPoint.y := 0;
    end;
    if SLeft < 0 then begin
      inc(DstPoint.x, -SLeft);
      SLeft := 0;
      if DstPoint.x < 0 then begin
        inc(SLeft, -DstPoint.x);
        DstPoint.x := 0;
      end;
    end;
    if STop < 0 then begin
      inc(DstPoint.y, - STop);
      STop := 0;
      if DstPoint.y < 0 then begin
        inc(STop, - DstPoint.y);
        DstPoint.y := 0;
      end;
    end;

    if (SRight > SLeft) and (SBottom > STop) then
      if (DstPoint.x < DstBmp.Width) and (DstPoint.y < DstBmp.Height) then
        if (SLeft < SrcBmp.Width) and (STop < SrcBmp.Height) then begin
          if SRight >= SrcBmp.Width then
            SRight := SrcBmp.Width - 1;

          if SBottom >= SrcBmp.Height then
            SBottom := SrcBmp.Height - 1;

          if DstPoint.x + WidthOf(SrcRect) >= DstBmp.Width then
            SRight := SLeft + (DstBmp.Width - DstPoint.x) - 1;

          if DstPoint.y + HeightOf(SrcRect) >= DstBmp.Height then
            SBottom := STop + (DstBmp.Height - DstPoint.y) - 1;

          Yd := DstPoint.Y;
          if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
            for Y := STop to SBottom do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              Xd := DstPoint.X;
              for X := SLeft to SRight do
                with D[Xd], S[X] do begin
                  if IsSrcPixel(X - SrcRect.Left, Y - SrcRect.Top) then
                    DC := SC;

                  inc(Xd);
                end;

              inc(Yd);
            end;
        end;
  end;
end;


procedure PaintBmpRect32(const DstBmp, SrcBmp: Graphics.TBitMap; SrcRect: TRect; DstPoint: TPoint; SrcBlendValue: byte = MaxByte);
var
  b: byte;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, X, Y, Xd, Yd: Integer;
begin
  // Coordinates correcting
  if DstPoint.x < 0 then begin
    inc(SrcRect.Left, -DstPoint.x);
    DstPoint.x := 0;
  end;
  if DstPoint.y < 0 then begin
    inc(SrcRect.Top, -DstPoint.y);
    DstPoint.y := 0;
  end;
  if SrcRect.Left < 0 then begin
    inc(DstPoint.x, -SrcRect.Left);
    SrcRect.Left := 0;
    if DstPoint.x < 0 then begin
      inc(SrcRect.Left, -DstPoint.x);
      DstPoint.x := 0;
    end;
  end;
  if SrcRect.Top < 0 then begin
    inc(DstPoint.y, - SrcRect.Top);
    SrcRect.Top := 0;
    if DstPoint.y < 0 then begin
      inc(SrcRect.Top, - DstPoint.y);
      DstPoint.y := 0;
    end;
  end;

  if (SrcRect.Right >= SrcRect.Left) and (SrcRect.Bottom >= SrcRect.Top) then
    if (DstPoint.x < DstBmp.Width) and (DstPoint.y < DstBmp.Height) then
      if (SrcRect.Left < SrcBmp.Width) and (SrcRect.Top < SrcBmp.Height) then begin
        if SrcRect.Right >= SrcBmp.Width then
          SrcRect.Right := SrcBmp.Width - 1;

        if SrcRect.Bottom >= SrcBmp.Height then
          SrcRect.Bottom := SrcBmp.Height - 1;

        if DstPoint.x + WidthOf(SrcRect) >= DstBmp.Width then
          SrcRect.Right := SrcRect.Left + (DstBmp.Width - DstPoint.x) - 1;

        if DstPoint.y + HeightOf(SrcRect) >= DstBmp.Height then
          SrcRect.Bottom := SrcRect.Top + (DstBmp.Height - DstPoint.y) - 1;

        Yd := DstPoint.Y;

        if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
          if SrcBlendValue = MaxByte then
            for Y := SrcRect.Top to SrcRect.Bottom do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              Xd := DstPoint.X;
              for X := SrcRect.Left to SrcRect.Right do
                with D[Xd], S[X] do begin
                  DR := ((SR - DR) * SA + DR shl 8) shr 8;
                  DG := ((SG - DG) * SA + DG shl 8) shr 8;
                  DB := ((SB - DB) * SA + DB shl 8) shr 8;
                  DA := max(DA, ((SA - DA) * SA + DA shl 8) shr 8);
                  inc(Xd);
                end;

              inc(Yd);
            end
          else
            for Y := SrcRect.Top to SrcRect.Bottom do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              Xd := DstPoint.X;
              for X := SrcRect.Left to SrcRect.Right do
                with D[Xd], S[X] do begin
                  b := SA * SrcBlendValue shr 8;
                  DR := ((SR - DR) * b + DR shl 8) shr 8;
                  DG := ((SG - DG) * b + DG shl 8) shr 8;
                  DB := ((SB - DB) * b + DB shl 8) shr 8;
                  DA := max(DA, ((b  - DA) * b + DA shl 8) shr 8);
                  inc(Xd);
                end;

              inc(Yd);
            end
      end;
end;


procedure PaintTranspBmpRect32(const DstBmp, SrcBmp, TranspBmp: Graphics.TBitMap; TranspColor: TColor; SrcRect: TRect; DstPoint, TranspPoint: TPoint; SrcBlendValue: byte = MaxByte);
var
  b: byte;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  M0, M: PRGBAArray_M;
  DeltaS, DeltaD, DeltaM, X, Y, Xd, Yd, Xm, Ym: Integer;
begin
  // Coordinates correcting
  if DstPoint.x < 0 then begin
    inc(SrcRect.Left, -DstPoint.x);
    inc(TranspPoint.X, -DstPoint.x);
    DstPoint.x := 0;
  end;
  if DstPoint.y < 0 then begin
    inc(SrcRect.Top, -DstPoint.y);
    inc(TranspPoint.Y, -DstPoint.Y);
    DstPoint.y := 0;
  end;
  if SrcRect.Left < 0 then begin
    inc(DstPoint.x, -SrcRect.Left);
    inc(TranspPoint.X, -SrcRect.Left);
    SrcRect.Left := 0;
    if DstPoint.x < 0 then begin
      inc(SrcRect.Left, -DstPoint.x);
      inc(TranspPoint.X, -DstPoint.x);
      DstPoint.x := 0;
    end;
  end;
  if SrcRect.Top < 0 then begin
    inc(DstPoint.y, -SrcRect.Top);
    inc(TranspPoint.y, -SrcRect.Top);
    SrcRect.Top := 0;
    if DstPoint.y < 0 then begin
      inc(SrcRect.Top, -DstPoint.y);
      inc(TranspPoint.y, -DstPoint.y);
      DstPoint.y := 0;
    end;
  end;

  if TranspPoint.Y < 0 then begin
    inc(SrcRect.Top, -TranspPoint.Y);
    inc(DstPoint.Y, -TranspPoint.Y);
    TranspPoint.Y := 0;
  end;

  if TranspPoint.X < 0 then begin
    inc(SrcRect.Left, -TranspPoint.X);
    inc(DstPoint.X, -TranspPoint.X);
    TranspPoint.X := 0;
  end;

  if (SrcRect.Right > SrcRect.Left) and (SrcRect.Bottom > SrcRect.Top) then
    if (DstPoint.x < DstBmp.Width) and (DstPoint.y < DstBmp.Height) then
      if (SrcRect.Left < SrcBmp.Width) and (SrcRect.Top < SrcBmp.Height) then begin
        if SrcRect.Right >= SrcBmp.Width then
          SrcRect.Right := SrcBmp.Width - 1;

        if SrcRect.Bottom >= SrcBmp.Height then
          SrcRect.Bottom := SrcBmp.Height - 1;

        if DstPoint.x + WidthOf(SrcRect) >= DstBmp.Width then
          SrcRect.Right := SrcRect.Left + (DstBmp.Width - DstPoint.x) - 1;

        if DstPoint.y + HeightOf(SrcRect) >= DstBmp.Height then
          SrcRect.Bottom := SrcRect.Top + (DstBmp.Height - DstPoint.y) - 1;

        Yd := DstPoint.Y;

        if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
          if (TranspBmp <> nil) and InitLine(TranspBmp, Pointer(M0), DeltaM) then begin
            if TranspPoint.Y + SrcRect.Bottom - SrcRect.Top >= TranspBmp.Height then begin
              Y := (TranspPoint.Y + SrcRect.Bottom - SrcRect.Top) - TranspBmp.Height + 1;
              dec(SrcRect.Bottom, Y);
            end;

            if TranspPoint.X + SrcRect.Right - SrcRect.Left >= TranspBmp.Width then begin
              X := (TranspPoint.X + SrcRect.Right - SrcRect.Left) - TranspBmp.Width + 1;
              dec(SrcRect.Right, X);
            end;

            Yd := DstPoint.Y;
            Ym := TranspPoint.Y;
            for Y := SrcRect.Top to SrcRect.Bottom do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              M := Pointer(PAnsiChar(M0) + DeltaM * Ym);
              Xd := DstPoint.X;
              Xm := TranspPoint.X;
              for X := SrcRect.Left to SrcRect.Right do begin
try
                with D[Xd], S[X], M[Xm] do begin
                  if DC <> MC then begin
                    b := SA * SrcBlendValue shr 8;
                    DR := ((SR - DR) * b + DR shl 8) shr 8;
                    DG := ((SG - DG) * b + DG shl 8) shr 8;
                    DB := ((SB - DB) * b + DB shl 8) shr 8;
                    DA := max(DA, ((b  - DA) * b + DA shl 8) shr 8);
                  end;
                  inc(Xd);
                  inc(Xm);
                end;
finally
end;
              end;

              inc(Yd);
              inc(Ym);
            end
          end
          else begin
            for Y := SrcRect.Top to SrcRect.Bottom do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              Xd := DstPoint.X;
              for X := SrcRect.Left to SrcRect.Right do
                with D[Xd], S[X] do begin
                  if DC <> TranspColor then begin
                    b := SA * SrcBlendValue shr 8;
                    DR := ((SR - DR) * b + DR shl 8) shr 8;
                    DG := ((SG - DG) * b + DG shl 8) shr 8;
                    DB := ((SB - DB) * b + DB shl 8) shr 8;
                    DA := max(DA, ((b  - DA) * b + DA shl 8) shr 8);
                  end;
                  inc(Xd);
                end;

              inc(Yd);
            end
          end;
      end;
end;


procedure PaintBmpMaskRect32(const DstBmp, SrcBmp, MaskBmp: Graphics.TBitMap; MaskRect: TRect; DstPoint: TPoint; SrcBlendValue: byte = MaxByte);
var
  b: byte;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  M0, M: PRGBAArray_M;
  DeltaS, DeltaD, DeltaM, X, Y, Xd, Yd: Integer;
begin
  // Coordinates correcting
  if DstPoint.x < 0 then begin
    inc(MaskRect.Left, -DstPoint.x);
    DstPoint.x := 0;
  end;
  if DstPoint.y < 0 then begin
    inc(MaskRect.Top, -DstPoint.y);
    DstPoint.y := 0;
  end;
  if MaskRect.Left < 0 then begin
    inc(DstPoint.x, -MaskRect.Left);
    MaskRect.Left := 0;
    if DstPoint.x < 0 then begin
      inc(MaskRect.Left, -DstPoint.x);
      DstPoint.x := 0;
    end;
  end;
  if MaskRect.Top < 0 then begin
    inc(DstPoint.y, - MaskRect.Top);
    MaskRect.Top := 0;
    if DstPoint.y < 0 then begin
      inc(MaskRect.Top, - DstPoint.y);
      DstPoint.y := 0;
    end;
  end;

  if (MaskRect.Right > MaskRect.Left) and (MaskRect.Bottom > MaskRect.Top) then
    if (DstPoint.x < DstBmp.Width) and (DstPoint.y < DstBmp.Height) then
      if (MaskRect.Left < MaskBmp.Width) and (MaskRect.Top < MaskBmp.Height) then begin
        if MaskRect.Right >= MaskBmp.Width then
          MaskRect.Right := MaskBmp.Width - 1;

        if MaskRect.Bottom >= MaskBmp.Height then
          MaskRect.Bottom := MaskBmp.Height - 1;

        if DstPoint.x + WidthOf(MaskRect) >= DstBmp.Width then
          MaskRect.Right := MaskRect.Left + (DstBmp.Width - DstPoint.x) - 1;

        if DstPoint.y + HeightOf(MaskRect) >= DstBmp.Height then
          MaskRect.Bottom := MaskRect.Top + (DstBmp.Height - DstPoint.y) - 1;

        Yd := DstPoint.Y;

        if InitLine(MaskBmp, Pointer(M0), DeltaM) and InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
          if SrcBlendValue = MaxByte then
            for Y := MaskRect.Top to MaskRect.Bottom do begin
              M := Pointer(PAnsiChar(M0) + DeltaM * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              S := Pointer(PAnsiChar(S0) + DeltaS * Yd);
              Xd := DstPoint.X;
              for X := MaskRect.Left to MaskRect.Right do
                with D[Xd], S[Xd], M[X] do begin
                  if MA > 0 then
                  begin
//                    b := min(127, 4 * MA);
                    b := MA;
                    DR := ((SR - DR) * b + DR shl 8) shr 8;
                    DG := ((SG - DG) * b + DG shl 8) shr 8;
                    DB := ((SB - DB) * b + DB shl 8) shr 8;
                    DA := max(DA, ((MA - DA) * MA + DA shl 8) shr 8);
(*
                    b := min(255, 4 * MA);
//                    b := MA;
                    DR := ((SR - DR) * b{ div 4} + DR shl 8) shr 8;
                    DG := ((SG - DG) * b{ div 4} + DG shl 8) shr 8;
                    DB := ((SB - DB) * b{ div 4} + DB shl 8) shr 8;
*)
  //                  DA := max(DA, ((MA - DA) * MA + DA shl 8) shr 8);
                  end{
                  else
                    D[Xd].DI := $FFFFFFFF};

                  inc(Xd);
                end;

              inc(Yd);
            end
          else
            for Y := MaskRect.Top to MaskRect.Bottom do begin
              M := Pointer(PAnsiChar(M0) + DeltaM * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              S := Pointer(PAnsiChar(S0) + DeltaS * Yd);
              Xd := DstPoint.X;
              for X := MaskRect.Left to MaskRect.Right do
                with D[Xd], S[Xd], M[X] do
                  if MA > 0 then begin
                    b := MA * SrcBlendValue shr 8;
                    DR := ((MR - DR) * b + DR shl 8) shr 8;
                    DG := ((MG - DG) * b + DG shl 8) shr 8;
                    DB := ((MB - DB) * b + DB shl 8) shr 8;
                    DA := max(DA, ((b  - DA) * b + DA shl 8) shr 8);

                    DR := ((SR - DR) * 255{b} + DR shl 8) shr 8;
                    DG := ((SG - DG) * 255{b} + DG shl 8) shr 8;
                    DB := ((SB - DB) * 255{b} + DB shl 8) shr 8;
  //                  DA := max(DA, ((b  - DA) * b + DA shl 8) shr 8);

                    inc(Xd);
                  end;

              inc(Yd);
            end
      end;
end;


procedure StretchBmpRect32(const DstBmp: Graphics.TBitmap; XDst, YDst, DstWidth, DstHeight: Integer; SrcBmp: Graphics.TBitMap; XSrc, YSrc, SrcWidth, SrcHeight: Integer; SrcBlendValue: byte = MaxByte);
var
  b: byte;
  Bmp: TBitmap;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, h, X, Y, Xd, Yd: Integer;
begin
  // Coordinates correcting
  if XDst < 0 then begin
    inc(XSrc, -XDst);
    XDst := 0;
  end;
  if YDst < 0 then begin
    inc(YSrc, -YDst);
    YDst := 0;
  end;
  if XSrc < 0 then begin
    inc(XDst, -XSrc);
    XSrc := 0;
    if XDst < 0 then begin
      inc(XSrc, -XDst);
      XDst := 0;
    end;
  end;
  if YSrc < 0 then begin
    inc(YDst, - YSrc);
    YSrc := 0;
    if YDst < 0 then begin
      inc(YSrc, - YDst);
      YDst := 0;
    end;
  end;

  if (SrcWidth > 0) and (SrcHeight > 0) and (DstWidth > 0) and (DstHeight > 0) then
    if (XDst < DstBmp.Width) and (YDst < DstBmp.Height) then
      if (XSrc < SrcBmp.Width) and (YSrc < SrcBmp.Height) then begin
        Yd := YDst;
        Bmp := CreateBmp32(DstWidth, DstHeight);
        if (XSrc <> 0) or (YSrc <> 0) {or (SrcBmp.Width <> SrcWidth) or (SrcBmp.Height <> SrcHeight)} then begin
          SetStretchBltMode(Bmp.Canvas.Handle, COLORONCOLOR);
          StretchBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SrcBmp.Canvas.Handle, XSrc, YSrc, SrcWidth, SrcHeight, SRCCOPY);
        end
        else
          Stretch(SrcBmp, Bmp, Bmp.Width, Bmp.Height, ftMitchell);

        if InitLine(Bmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then begin
          h := min(Bmp.Height, DstBmp.Height - Yd) - 1;
          if SrcBlendValue = MaxByte then
            for Y := 0 to h do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              Xd := XDst;
              for X := 0 to Bmp.Width - 1 do
                with D[Xd], S[X] do begin
                  DR := ((SR - DR) * SA + DR shl 8) shr 8;
                  DG := ((SG - DG) * SA + DG shl 8) shr 8;
                  DB := ((SB - DB) * SA + DB shl 8) shr 8;
                  DA := max(DA, ((SA - DA) * SA + DA shl 8) shr 8);
                  inc(Xd);
                end;

              inc(Yd);
            end
          else
            for Y := 0 to h do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * Y);
              D := Pointer(PAnsiChar(D0) + DeltaD * Yd);
              Xd := XDst;
              for X := 0 to Bmp.Width - 1 do
                with D[Xd], S[X] do begin
                  b := SA * SrcBlendValue shr 8;
                  DR := ((SR - DR) * b + DR shl 8) shr 8;
                  DG := ((SG - DG) * b + DG shl 8) shr 8;
                  DB := ((SB - DB) * b + DB shl 8) shr 8;
                  DA := Max(DA, ((b  - DA) * b + DA shl 8) shr 8);
                  inc(Xd);
                end;

              inc(Yd);
            end;
        end;
        Bmp.Free;
      end;
end;


procedure CopyByMask(DstRect, SrcRect: TRect; const DstBmp, SrcBmp: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean); overload;
var
  C_: TsColor_;
  col: TsColor;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaD, DeltaS, X, Y, h, w, dX1, dX2: Integer;
begin
  if SrcBmp <> nil then begin
    h := Min(HeightOf(DstRect), HeightOf(SrcRect));
    h := Min(h, DstBmp.Height - DstRect.Top);
    h := Min(h, SrcBmp.Height - SrcRect.Top) - 1;
    if h >= 0 then begin
      w := Min(WidthOf(DstRect), WidthOf(SrcRect));
      w := Min(w, DstBmp.Width - DstRect.Left);
      w := Min(w, SrcBmp.Width - SrcRect.Left) - 1;
      if w >= 0 then begin
        if DstRect.Left < SrcRect.Left then begin
          if DstRect.Left < 0 then begin
            inc(SrcRect.Left, - DstRect.Left);
            dec(w, - DstRect.Left);
            DstRect.Left := 0;
          end;
        end
        else
          if SrcRect.Left < 0 then begin
            inc(DstRect.Left, - SrcRect.Left);
            dec(w, - SrcRect.Left);
            SrcRect.Left := 0;
          end;

        if DstRect.Top < SrcRect.Top then begin
          if DstRect.Top < 0 then begin
            inc(SrcRect.Top, - DstRect.Top);
            dec(h, - DstRect.Top);
            DstRect.Top := 0;
          end;
        end
        else
          if SrcRect.Top < 0 then begin
            inc(DstRect.Top, - SrcRect.Top);
            dec(h, - SrcRect.Top);
            SrcRect.Top := 0;
          end;

        if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
          if not CI.Ready then
            for Y := 0 to h do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + Y));
              D := Pointer(PAnsiChar(D0) + DeltaD * (DstRect.Top + Y));
              dX1 := DstRect.Left;
              dX2 := SrcRect.Left;
              for X := 0 to w do
                with D[dX1], S[dX2] do begin
                  DR := ((SR - DR) * SA + DR shl 8) shr 8;
                  DG := ((SG - DG) * SA + DG shl 8) shr 8;
                  DB := ((SB - DB) * SA + DB shl 8) shr 8;
                  if SA <> 0 then
                    DA := DA + ((MaxByte - DA) * SA) shr 8;

                  inc(dX1);
                  inc(dX2);
                end;
            end
          else
            for Y := 0 to h do begin
              S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + Y));
              D := Pointer(PAnsiChar(D0) + DeltaD * (DstRect.Top + Y));
              dX1 := DstRect.Left;
              dX2 := SrcRect.Left - 1;
              for X := 0 to w do begin
                inc(dX2);
                with S[dX2] do
                  if C_.C <> clFuchsia then
                    with D[dX1] do begin
                      DR := ((SR - DR) * SA + DR shl 8) shr 8;
                      DG := ((SG - DG) * SA + DG shl 8) shr 8;
                      DB := ((SB - DB) * SA + DB shl 8) shr 8;
                      if SA <> 0 then
                        DA := DA + ((MaxByte - DA) * SA) shr 8;
                    end
                  else
                    if UpdateTrans then
                      if (CI.Bmp.Height > ci.Y + DstRect.Top + Y) and (CI.Bmp.Width > ci.X + DstRect.Left + X) then
                        if (ci.Y + DstRect.Top + Y >= 0) and (ci.X + dX1 >= 0) then begin
                          col := GetAPixel(ci.Bmp, ci.X + DstRect.Left + X, ci.Y + DstRect.Top + Y);
                          with D[dX1] do begin
                            DR := col.R;
                            DG := col.G;
                            DB := col.B;
                            DA := MaxByte;
                          end;
                        end;

                inc(dX1);
              end;
            end;
      end;
    end;
  end;
end;

const
  bTranspLimit = 16;

procedure CopyBmp32(R1, R2: TRect; const Bmp1, Bmp2: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean; GrayedColor: TColor; const Blend: integer; const Reflected: boolean);
var
  col: TsColor;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaD, DeltaS, XPos, YPos, h, w, dX1, dX2: Integer;
  Bmp1H, Bmp1W, Bmp2H, Bmp2W, CIBmpH, CIBmpW: integer;
  TempR, TempG, TempB, gMaskValue, MaskValue, BlendByte: byte;
begin
  if Bmp2 <> nil then begin
    BlendByte := MaxByte - MaxByte * Blend div 100;
    Bmp2.PixelFormat := pf32Bit;
    Bmp1H := Bmp1.Height;
    Bmp1W := Bmp1.Width;
    Bmp2H := Bmp2.Height;
    Bmp2W := Bmp2.Width;
    if CI.Bmp <> nil then begin
      CIBmpH := CI.Bmp.Height;
      CIBmpW := CI.Bmp.Width;
    end
    else begin
      CIBmpH := 0;
      CIBmpW := 0;
    end;

    h := Min(HeightOf(R1, True), HeightOf(R2, True));
    h := Min(h, Bmp1H - R1.Top);
    h := Min(h, Bmp2H - R2.Top) - 1;
    if h >= 0 then begin
      w := Min(WidthOf(R1, True), WidthOf(R2, True));
      w := Min(w, Bmp1W - R1.Left);
      w := Min(w, Bmp2W - R2.Left);
      if w >= 0 then begin
        if R1.Left < R2.Left then
          if R1.Left < 0 then begin
            inc(R2.Left, - R1.Left);
            dec(w, - R1.Left);
            R1.Left := 0;
            w := Min(w, Bmp2W - R2.Left) - 1;
          end
        else
          if R2.Left < 0 then begin
            inc(R1.Left, - R2.Left);
            dec(w, - R2.Left);
            R2.Left := 0;
            w := Min(w, Bmp1W - R1.Left) - 1;
          end;

        if R1.Top < R2.Top then
          if R1.Top < 0 then begin
            inc(R2.Top, - R1.Top);
            dec(h, - R1.Top);
            R1.Top := 0;
            h := Min(h, Bmp2H - R2.Top) - 1;
          end
        else
          if R2.Top < 0 then begin
            inc(R1.Top, - R2.Top);
            dec(h, - R2.Top);
            R2.Top := 0;
            h := Min(h, Bmp1H - R1.Top) - 1;
          end;

        w := Min(w, Bmp1W - R1.Left);
        w := Min(w, Bmp2W - R2.Left) - 1;
        Bmp2.Handle;
        if InitLine(Bmp2, Pointer(S0), DeltaS) and InitLine(Bmp1, Pointer(D0), DeltaD) then
          with Col do begin
            if GrayedColor <> clNone then begin
              C := GrayedColor;

              MaskValue := max(R, G);
              MaskValue := MaxByte - max(B, MaskValue);
              inc(R, MaskValue);
              inc(G, MaskValue);
              inc(B, MaskValue);

              if Blend <> 0 then begin
                if not CI.Ready then
                  for YPos := 0 to h do begin
                    S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Top + YPos));
                    D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Top + YPos));
                    for XPos := 0 to w do begin
                      dX1 := R1.Left + XPos;
                      dX2 := R2.Left + XPos;
                      with S[dX2] do begin
                        MaskValue := SA * BlendByte shr 8;
                        gMaskValue := SR shr 2 + SG shr 1 + SB shr 2;
                        TempR := gMaskValue * R shr 8;
                        TempG := gMaskValue * G shr 8;
                        TempB := gMaskValue * B shr 8;
                        with D[dX1] do begin
                          DR := ((TempR - DR) * MaskValue + DR shl 8) shr 8;
                          DG := ((TempG - DG) * MaskValue + DG shl 8) shr 8;
                          DB := ((TempB - DB) * MaskValue + DB shl 8) shr 8;
                        end;
                      end;
                    end;
                  end
                else
                  for YPos := 0 to h do begin
                    S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Top + YPos));
                    D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Top + YPos));
                    dX1 := R1.Left;
                    dX2 := R2.Left;
                    for XPos := 0 to w do begin
                      with S[dX2] do begin
                        if (SC <> clFuchsia) and (SA > bTranspLimit) then begin
                          MaskValue := SA * BlendByte shr 8;//(100 - Blend) div 100;
                          gMaskValue := SR shr 2 + SG shr 1 + SB shr 2;
                          TempR := gMaskValue * R shr 8;
                          TempG := gMaskValue * G shr 8;
                          TempB := gMaskValue * B shr 8;
                          with D[dX1] do begin
                            DR := ((TempR - DR) * MaskValue + DR shl 8) shr 8;
                            DG := ((TempG - DG) * MaskValue + DG shl 8) shr 8;
                            DB := ((TempB - DB) * MaskValue + DB shl 8) shr 8;
                          end;
                        end
                        else
                          if UpdateTrans then
                            with CI do
                              if (CIBmpH > Y + R1.Top + YPos) and (X + dX1 >= 0) then
                                if (CIBmpW <= X + dX1) or (Y + R1.Top + YPos < 0) then
                                  Break
                                else begin
                                  C := GetAPixel(Bmp, X + dX1, Y + R1.Top + YPos).C;
                                  with D[dX1] do begin
                                    DR := R;
                                    DG := G;
                                    DB := B;
                                  end;
                                end;

                      inc(dX1);
                      inc(dX2);
                    end;
                  end;
                end;
              end // end of "if Blend <> 0 then "
              else begin
                if not CI.Ready then
                  for YPos := 0 to h do begin
                    S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Top + YPos));
                    D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Top + YPos));
                    dX1 := R1.Left;
                    dX2 := R2.Left;
                    for XPos := 0 to w do
                      with S[dX2] do begin // Col � gMaskValue
                        gMaskValue := SR shr 2 + SG shr 1 + SB shr 2;
                        TempR := gMaskValue * R shr 8;
                        TempG := gMaskValue * G shr 8;
                        TempB := gMaskValue * B shr 8;
                        with D[dX1] do begin
                          DR := ((TempR - DR) * SA + DR shl 8) shr 8;
                          DG := ((TempG - DG) * SA + DG shl 8) shr 8;
                          DB := ((TempB - DB) * SA + DB shl 8) shr 8;
                          DA := ((MaxByte - DA) * SA + DA shl 8) shr 8;
                        end;

                        inc(dX1);
                        inc(dX2);
                      end;
                  end
                else
                  for YPos := 0 to h do begin
                    S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Top + YPos));
                    D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Top + YPos));
                    dX1 := R1.Left;
                    dX2 := R2.Left;
                    for XPos := 0 to w do
                      with S[dX2] do begin
                        gMaskValue := SR shr 2 + SG shr 1 + SB shr 2;
                        TempR := gMaskValue * R shr 8;
                        TempG := gMaskValue * G shr 8;
                        TempB := gMaskValue * B shr 8;
                        if (SC <> clFuchsia) and (SA > bTranspLimit) then begin
                          with D[dX1] do begin
                            DR := ((TempR - DR) * SA + DR shl 8) shr 8;
                            DG := ((TempG - DG) * SA + DG shl 8) shr 8;
                            DB := ((TempB - DB) * SA + DB shl 8) shr 8;
                          end;
                        end
                        else
                          if UpdateTrans then
                            with CI do
                              if (CIBmpH > Y + R1.Top + YPos) and (X + dX1 >= 0) then
                                if (CIBmpW <= X + dX1) or (Y + R1.Top + YPos < 0) then
                                  Break
                                else begin
                                  C := GetAPixel(Bmp, X + R1.Left + XPos, Y + R1.Top + YPos).C;
                                  with D[dX1] do begin
                                    DR := R;
                                    DG := G;
                                    DB := B;
                                  end;
                                end;

                        inc(dX1);
                        inc(dX2);
                      end;
                  end;
              end;
              if Reflected then begin
                h := min(Bmp2H div 2 - 1, Bmp1H - R1.Bottom - 1);
                for YPos := 1 to h do begin
                  S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Bottom - YPos - 1));
                  D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Bottom + YPos));
                  dX1 := R1.Left;
                  dX2 := R2.Left;
                  for XPos := 0 to w do
                    with S[dX2], D[dX1] do begin
                      if (SC <> clFuchsia) and (SA > bTranspLimit) then begin
                        gMaskValue := SR shr 2 + SG shr 1 + SB shr 2;
                        if Blend = 0 then
                          MaskValue := (SA * (h - YPos) div h) shr 2
                        else
                          MaskValue := (SA * (h - YPos) div h) shr 2 * BlendByte shr 8;//(100 - Blend) div 100;

                        TempR := gMaskValue * R shr 8;
                        TempG := gMaskValue * G shr 8;
                        TempB := gMaskValue * B shr 8;

                        DR := ((TempR - DR) * MaskValue + DR shl 8) shr 8;
                        DG := ((TempG - DG) * MaskValue + DG shl 8) shr 8;
                        DB := ((TempB - DB) * MaskValue + DB shl 8) shr 8;
                      end;
                      inc(dX1);
                      inc(dX2);
                    end;
                end;
              end;
            end
            else begin
              if Blend <> 0 then begin
                if not CI.Ready then
                  for YPos := 0 to h do begin
                    S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Top + YPos));
                    D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Top + YPos));
                    for XPos := 0 to w do begin
                      dX1 := R1.Left + XPos;
                      dX2 := R2.Left + XPos;
                      with S[dX2] do begin
                        MaskValue := SA * BlendByte shr 8;//(100 - Blend) div 100;
                        with D[dX1] do begin
                          DR := ((SR - DR) * MaskValue + DR shl 8) shr 8;
                          DG := ((SG - DG) * MaskValue + DG shl 8) shr 8;
                          DB := ((SB - DB) * MaskValue + DB shl 8) shr 8;
                        end;
                      end;
                    end;
                  end
                else
                  for YPos := 0 to h do begin
                    S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Top + YPos));
                    D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Top + YPos));
                    dX1 := R1.Left;
                    dX2 := R2.Left;
                    for XPos := 0 to w do begin
                      with S[dX2] do
                        if (SC <> clFuchsia) and (SA > bTranspLimit) then begin
                          MaskValue := SA * BlendByte shr 8;//(100 - Blend) div 100;
                          with D[dX1] do begin
                            DR := ((SR - DR) * MaskValue + DR shl 8) shr 8;
                            DG := ((SG - DG) * MaskValue + DG shl 8) shr 8;
                            DB := ((SB - DB) * MaskValue + DB shl 8) shr 8;
                          end;
                        end
                        else
                          if UpdateTrans then
                            with CI do
                              if (CIBmpH > Y + R1.Top + YPos) and (X + dX1 >= 0) then
                                if (CIBmpW <= X + dX1) or (Y + R1.Top + YPos < 0) then
                                  Break
                                else begin
                                  C := GetAPixel(Bmp, X + dX1, Y + R1.Top + YPos).C;
                                  with D[dX1] do begin
                                    DR := R;
                                    DG := G;
                                    DB := B;
                                  end;
                                end;

                      inc(dX1);
                      inc(dX2);
                    end;
                  end;
              end
              else begin
                if not CI.Ready then
                  for YPos := 0 to h do begin
                    S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Top + YPos));
                    D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Top + YPos));
                    dX1 := R1.Left;
                    dX2 := R2.Left;
                    for XPos := 0 to w do begin
                      with D[dX1], S[dX2] do begin
                        DR := ((SR - DR) * SA + DR shl 8) shr 8;
                        DG := ((SG - DG) * SA + DG shl 8) shr 8;
                        DB := ((SB - DB) * SA + DB shl 8) shr 8;
                        DA := max(DA, SA);
                      end;
                      inc(dX1);
                      inc(dX2);
                    end;
                  end
                else
                  for YPos := 0 to h do begin
                    S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Top + YPos));
                    D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Top + YPos));
                    dX1 := R1.Left;
                    dX2 := R2.Left;
                    for XPos := 0 to w do begin
                      with S[dX2] do
                        if (SC <> clFuchsia) and (SA > bTranspLimit) then begin
                          with D[dX1] do begin
                            DR := ((SR - DR) * SA + DR shl 8) shr 8;
                            DG := ((SG - DG) * SA + DG shl 8) shr 8;
                            DB := ((SB - DB) * SA + DB shl 8) shr 8;
                            DA := max(DA, SA);
                          end;
                        end
                        else
                          if UpdateTrans then
                            with CI do
                              if (CIBmpH > Y + R1.Top + YPos) and (X + dX1 >= 0) then
                                if (CIBmpW <= X + dX1) or (Y + R1.Top + YPos < 0) then
                                  Break
                                else begin
                                  C := GetAPixel(Bmp, X + R1.Left + XPos, Y + R1.Top + YPos).C;
                                  with D[dX1] do begin
                                    DR := R;
                                    DG := G;
                                    DB := B;
                                  end;
                                end;

                      inc(dX1);
                      inc(dX2);
                    end;
                  end;
              end;
              if Reflected then begin
                h := min(Bmp2H div 2 - 1, Bmp1H - R1.Bottom - 1);
                A := MaxByte div Bmp2H; // Step
                R := MaxByte;
                for YPos := 1 to h do begin
                  S := Pointer(PAnsiChar(S0) + DeltaS * (R2.Bottom - YPos - 1));
                  D := Pointer(PAnsiChar(D0) + DeltaD * (R1.Bottom + YPos));
                  dX1 := R1.Left;
                  dX2 := R2.Left;
                  for XPos := 0 to w do begin
                    with S[dX2] do
                      if (SC <> clFuchsia) and (SA > bTranspLimit) then begin
                        if Blend = 0 then
                          MaskValue := SA * (h - YPos) div h * R shr 9
                        else
                          MaskValue := SA * (h - YPos) div h * R shr 9 * BlendByte shr 8;//(100 - Blend) div 100;

                        with D[dX1] do begin
                          DR := ((SR - DR) * MaskValue + DR shl 8) shr 8;
                          DG := ((SG - DG) * MaskValue + DG shl 8) shr 8;
                          DB := ((SB - DB) * MaskValue + DB shl 8) shr 8;
                        end;
                      end;

                    inc(dX1);
                    inc(dX2);
                  end;
                  dec(R, A);
                end;
              end;
            end;
          end;
      end;
    end;
  end;
end;


procedure CopyByMask(DstRect, SrcRect: TRect; const DstBmp, SrcBmp: TBitmap; const CI: TCacheInfo; const UpdateTrans: boolean; const MaskData: TsMaskData); overload;
var
  M: PRGBAArray_M;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  Color: TsColor_RGB_;
  DeltaS, DeltaD, XPos, YPos, h, w, ch, cw, dX1, dX2, hdiv2, k1, k2: Integer;
begin
{$IFDEF TESTSLOWDETAILS} Exit;{$ENDIF}
  h := DstRect.Bottom - DstRect.Top;
  if h > SrcRect.Bottom - SrcRect.Top then
    h := SrcRect.Bottom - SrcRect.Top;

  if h > DstBmp.Height - DstRect.Top then
    h := DstBmp.Height - DstRect.Top;

  if h <= 0 then
    Exit;

  if h > SrcBmp.Height - SrcRect.Top then
    h := SrcBmp.Height - SrcRect.Top - 1
  else
    h := h - 1;

  w := DstRect.Right - DstRect.Left;
  if w > SrcRect.Right - SrcRect.Left then
    w := SrcRect.Right - SrcRect.Left;

  if w > DstBmp.Width - DstRect.Left then
    w := DstBmp.Width - DstRect.Left;

  if w <= 0 then
    Exit;

  if w > SrcBmp.Width - SrcRect.Left then
    w := SrcBmp.Width - SrcRect.Left - 1
  else
    w := w - 1;

  if DstRect.Left < SrcRect.Left then begin
    if DstRect.Left < 0 then begin
      inc(SrcRect.Left, - DstRect.Left);
      dec(w, - DstRect.Left);
      DstRect.Left := 0;
    end;
  end
  else
    if SrcRect.Left < 0 then begin
      inc(DstRect.Left, - SrcRect.Left);
      dec(w, - SrcRect.Left);
      SrcRect.Left := 0;
    end;

  if DstRect.Top < SrcRect.Top then begin
    if DstRect.Top < 0 then begin
      inc(SrcRect.Top, - DstRect.Top);
      dec(h, - DstRect.Top);
      DstRect.Top := 0;
    end;
  end
  else
    if SrcRect.Top < 0 then begin
      inc(DstRect.Top, - SrcRect.Top);
      dec(h, - SrcRect.Top);
      SrcRect.Top := 0;
    end;

  C1.A := 0;
  with TsColor(CI.FillColor) do begin
    Color.Alpha := A; // Invert channels for a fast filling
    Color.Red   := R;
    Color.Green := G;
    Color.Blue  := B;
  end;

  hdiv2 := (MaskData.R.Bottom - MaskData.R.Top) div 2;
  k1 := min(SrcRect.Top + hdiv2, SrcBmp.Height - h - 1); // Mask offset
  k2 := ci.X + DstRect.Left;

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    if not CI.Ready then begin
      if UpdateTrans then
        if MaskData.Cfg and 1 = 1 then
          for YPos := 0 to h do begin
            S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + YPos));
            D := Pointer(PAnsiChar(D0) + DeltaD * (DstRect.Top + YPos));
            M := Pointer(PAnsiChar(S0) + DeltaS * (k1 + YPos));
            dX1 := DstRect.Left;
            dX2 := SrcRect.Left;
            for XPos := 0 to w do begin
              with S[dX2], D[dX1], M[dX2] do
                if SC <> clFuchsia then begin
                  DR := ((DR - SR) * MR + SR shl 8) shr 8;
                  DG := ((DG - SG) * MG + SG shl 8) shr 8;
                  DB := ((DB - SB) * MB + SB shl 8) shr 8;
                end
                else
                  DC := Color.Col; // UpdateTrans

              inc(dX1);
              inc(dX2);
            end;
          end
        else
          for YPos := 0 to h do begin
            S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + YPos));
            D := Pointer(PAnsiChar(D0) + DeltaD * (DstRect.Top + YPos));
            M := Pointer(PAnsiChar(S0) + DeltaS * (k1 + YPos));
            dX1 := DstRect.Left;
            dX2 := SrcRect.Left;
            for XPos := 0 to w do begin
              with S[dX2], D[dX1], M[dX2] do
                if SA <> 0 then begin
                  DR := ((DR - SR) * MR + SR shl 8) shr 8;
                  DG := ((DG - SG) * MG + SG shl 8) shr 8;
                  DB := ((DB - SB) * MB + SB shl 8) shr 8;
                end
                else
                  DC := Color.Col; // UpdateTrans

              inc(dX1);
              inc(dX2);
            end;
          end
      else
        for YPos := 0 to h do begin
          S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + YPos));
          D := Pointer(PAnsiChar(D0) + DeltaD * (DstRect.Top + YPos));
          M := Pointer(PAnsiChar(S0) + DeltaS * (k1 + YPos));
          dX1 := DstRect.Left;
          dX2 := SrcRect.Left;
          for XPos := 0 to w do begin
            with D[dX1], S[dX2], M[dX2] do begin
              if SC <> clFuchsia then begin
                DR := ((DR - SR) * MR + SR shl 8) shr 8;
                DG := ((DG - SG) * MG + SG shl 8) shr 8;
                DB := ((DB - SB) * MB + SB shl 8) shr 8;
              end;
            end;
            inc(dX1);
            inc(dX2);
          end;
        end;
    end
    else begin
      ch := CI.Bmp.Height;
      cw := CI.Bmp.Width;
      if UpdateTrans then
        if MaskData.DrawMode and BDM_ALPHA = 0 then
          for YPos := 0 to h do begin
            S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + YPos));
            D := Pointer(PAnsiChar(D0) + DeltaD * (DstRect.Top + YPos));
            M := Pointer(PAnsiChar(S0) + DeltaS * (k1 + YPos));
            dX1 := DstRect.Left;
            dX2 := SrcRect.Left;
            for XPos := 0 to w do begin
              with D[dX1], S[dX2] do begin
                DA := MaxByte;
                if SC <> clFuchsia then
                  with M[dX2] do begin
                    DR := ((DR - SR) * MR + SR shl 8) shr 8;
                    DG := ((DG - SG) * MG + SG shl 8) shr 8;
                    DB := ((DB - SB) * MB + SB shl 8) shr 8;
                  end
                else
                  with ci do
                    if (ch > Y + DstRect.Top + YPos) and (XPos >= -k2) then
                      if cw > k2 + XPos then
                        if Y + DstRect.Top + YPos >= 0 then
                          DC := GetAPixel(Bmp, k2 + XPos, Y + DstRect.Top + YPos).C
                        else
                          Break;
              end;
              inc(dX1);
              inc(dX2);
            end;
          end
        else
          for YPos := 0 to h do begin
            S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + YPos));
            D := Pointer(PAnsiChar(D0) + DeltaD * (DstRect.Top + YPos));
//            M := Pointer(PAnsiChar(S0) + DeltaS * (k1 + YPos));
            dX1 := DstRect.Left;
            dX2 := SrcRect.Left;
            for XPos := 0 to w do begin
              with D[dX1], S[dX2] do begin
                DA := MaxByte;
                if SA <> 0 then
                  {with M[dX2] do} begin
                    DR := ((DR - SR) * (MaxByte - SA) + SR shl 8) shr 8;
                    DG := ((DG - SG) * (MaxByte - SA) + SG shl 8) shr 8;
                    DB := ((DB - SB) * (MaxByte - SA) + SB shl 8) shr 8;
                  end
                else
                  with ci do
                    if (ch > Y + DstRect.Top + YPos) and (XPos >= -k2) then
                      if cw > k2 + XPos then
                        if Y + DstRect.Top + YPos >= 0 then
                          DC := GetAPixel(Bmp, k2 + XPos, Y + DstRect.Top + YPos).C
                        else
                          Break;
              end;
              inc(dX1);
              inc(dX2);
            end;
          end
      else
        for YPos := 0 to h do begin
          S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + YPos));
          D := Pointer(PAnsiChar(D0) + DeltaD * (DstRect.Top + YPos));
          M := Pointer(PAnsiChar(S0) + DeltaS * (k1 + YPos));
          dX1 := DstRect.Left;
          dX2 := SrcRect.Left;
          for XPos := 0 to w do begin
            with D[dX1], S[dX2], M[dX2] do begin
              DR := ((DR - SR) * MR + SR shl 8) shr 8;
              DG := ((DG - SG) * MG + SG shl 8) shr 8;
              DB := ((DB - SB) * MB + SB shl 8) shr 8;
              DA := MaxByte;
            end;
            inc(dX1);
            inc(dX2);
          end;
        end;
    end;
end;


procedure CopyTransBitmaps(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; TransColor: TsColor);
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, minDY, maxDY, minDX, maxDX, dX, dY, sX, sY, sw, sh, dh, dw: Integer;
begin
  sw := SrcBmp.Width - 1;
  sh := SrcBmp.Height - 1;
  dw := DstBmp.Width - 1;
  dh := DstBmp.Height - 1;

  sY := 0;
  maxDY := min(dh, Y + sh);
  minDY := max(Y, 0);
  maxDX := min(dw, X + sw);
  minDX := max(X, 0);

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then begin
    TransColor.C := SwapColor(TransColor.C);
    for dY := minDY to maxDY do begin
      S := Pointer(PAnsiChar(S0) + DeltaS * sY);
      D := Pointer(PAnsiChar(D0) + DeltaD * dY);
      sX := 0;
      for dX := minDX to maxDX do begin
        with S[sX], D[dX] do
          if SC <> TransColor.C then begin
            DC := SC;
            DA := MaxByte
          end;

        inc(sX);
      end;
      inc(sY);
    end
  end;
end;


procedure CopyTransRect(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect; TransColor: TColor; const CI: TCacheInfo; UpdateTrans: boolean);
var
  DstPix: TsColor;
  S0, S: PRGBAArray_S;
  ParentRGBA: TsColor_;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, sX, sY, DstX, DstY, SrcX, SrcY, h, w, ch, cw, dh, dw: integer;
begin
  if SrcRect.Top < 0 then
    SrcRect.Top := 0;

  if SrcRect.Bottom >= SrcBmp.Height then
    SrcRect.Bottom := SrcBmp.Height - 1;

  if SrcRect.Left < 0 then
    SrcRect.Left := 0;

  if SrcRect.Right >= SrcBmp.Width then
    SrcRect.Right := SrcBmp.Width - 1;

  h := HeightOf(SrcRect);
  w := WidthOf(SrcRect);
  dh := DstBmp.Height - 1;
  dw := DstBmp.Width - 1;

  if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
    if UpdateTrans and CI.Ready and (CI.Bmp <> nil) then begin
      ch := CI.Bmp.Height;
      cw := CI.Bmp.Width;
      DstY := Y;
      SrcY := SrcRect.Top;
      if DstBmp <> CI.Bmp then
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(PAnsiChar(S0) + DeltaS * SrcY);
            D := Pointer(PAnsiChar(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do begin
              if (DstX <= dw) and (DstX >= 0) then
                with S[SrcX], D[DstX] do
                  if SC <> TransColor then
                    DI := SI
                  else
                    if (ch > ci.Y + DstY) and (ci.X + DstX >= 0) then
                      if cw > ci.X + DstX then
                        if ci.Y + DstY >= 0 then
                          DC := GetAPixel(CI.Bmp, ci.X + DstX, ci.Y + DstY).C
                        else
                          Break;

              inc(DstX);
              inc(SrcX);
            end
          end;
          inc(DstY);
          inc(SrcY);
        end
      else
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(PAnsiChar(S0) + DeltaS * SrcY);
            D := Pointer(PAnsiChar(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do begin
              if (DstX <= dw) and (DstX >= 0) then
                with S[SrcX], D[DstX] do
                  if SC <> TransColor then begin
                    DC  := SC;
                    DA := MaxByte;
                  end;

              inc(DstX);
              inc(SrcX);
            end
          end;
          inc(DstY);
          inc(SrcY);
        end
    end
    else begin
      DstY := Y;
      SrcY := SrcRect.Top;
      if not CI.Ready then
        with ParentRGBA do begin // If color for transparent pixels is defined
          DstPix := GetAPixel(DstBmp, 0, 0); // Save Alpha Value of dest bitmap
          R := TsColor(CI.FillColor).R;
          G := TsColor(CI.FillColor).G;
          B := TsColor(CI.FillColor).B;
          A := DstPix.A; // Save Alpha Value of dest bitmap
          for sY := 0 to h do begin
            if (DstY <= dh) and (DstY >= 0) then begin
              S := Pointer(PAnsiChar(S0) + DeltaS * SrcY);
              D := Pointer(PAnsiChar(D0) + DeltaD * DstY);
              DstX := X;
              SrcX := SrcRect.Left;
              for sX := 0 to w do begin
                if (DstX <= dw) and (DstX >= 0) then
                  with S[SrcX], D[DstX] do
                    if (SC <> TransColor) then
                      DC := SC
                    else
                      DC := C;

                inc(DstX);
                inc(SrcX);
              end
            end;
            inc(DstY);
            inc(SrcY);
          end
      end
      else
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(PAnsiChar(S0) + DeltaS * SrcY);
            D := Pointer(PAnsiChar(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do begin
              if (DstX <= dw) and (DstX >= 0) then
                with S[SrcX] do
                  if (SC <> TransColor) then
                    D[DstX].DC := SC;

              inc(DstX);
              inc(SrcX);
            end
          end;
          inc(DstY);
          inc(SrcY);
        end;
    end;
end;


procedure CopyTransRectA(DstBmp, SrcBmp: Graphics.TBitMap; X, Y: integer; SrcRect: TRect; TransColor: TColor; CI: TCacheInfo; const Blend: integer = 0);
var
  M: TsColor_M;
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, sX, sY, SrcX, DstX, DstY, h, w, dh, dw: integer;
begin
  with M do begin
    with TsColor_(TransColor) do begin
      MB := R;
      MG := G;
      MR := B;
    end;
    MA := 0;

    if SrcRect.Top < 0 then
      SrcRect.Top := 0;

    if SrcRect.Bottom >= SrcBmp.Height then
      SrcRect.Bottom := SrcBmp.Height - 1;

    if SrcRect.Left < 0 then
      SrcRect.Left := 0;

    if SrcRect.Right >= SrcBmp.Width then
      SrcRect.Right := SrcBmp.Width - 1;

    h := HeightOf(SrcRect);
    w := WidthOf(SrcRect);

    DstY := Y;
    dh := DstBmp.Height - 1;
    dw := DstBmp.Width - 1;

    if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) then
      if Blend = 0 then
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(PAnsiChar(S0) + DeltaS * (sY + SrcRect.Top));
            D := Pointer(PAnsiChar(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do
              if (DstX <= dw) and (DstX >= 0) then begin
                with S[SrcX] do
                  if SC <> MC then
                    D[DstX].DC := SC;

                inc(SrcX);
                inc(dstX);
              end;
          end;
          inc(DstY);
        end
      else
        for sY := 0 to h do begin
          if (DstY <= dh) and (DstY >= 0) then begin
            S := Pointer(PAnsiChar(S0) + DeltaS * (sY + SrcRect.Top));
            D := Pointer(PAnsiChar(D0) + DeltaD * DstY);
            DstX := X;
            SrcX := SrcRect.Left;
            for sX := 0 to w do
              if (DstX <= dw) and (DstX >= 0) then begin
                with S[SrcX], D[DstX] do
                  if SC <> MC then begin
//                    D[DstX].DC := SC;
                    DR := ((SR - DR) * Blend + DR shl 8) shr 8;
                    DG := ((SG - DG) * Blend + DG shl 8) shr 8;
                    DB := ((SB - DB) * Blend + DB shl 8) shr 8;
                    DA := Max(DA, Blend);
                  end;

                inc(SrcX);
                inc(dstX);
              end;
          end;
          inc(DstY);
        end
  end;
end;


procedure SumBitmapsByMask(var DstBmp, Src1, Src2: Graphics.TBitMap; MskBmp: Graphics.TBitMap; Percent: word = 0);
var
  D0, D: PRGBAArray_D;
  M0, M: PRGBAArray_M;
  S01, S1: PRGBAArray_S;
  S02, S2: PRGBAArray_;
  X, Y, w, h, DeltaS1, DeltaS2, DeltaD, DeltaM: integer;
begin
  if (Src1.Width = Src2.Width) and (Src1.Height = Src2.Height) then begin
    w := Src1.Width - 1;
    h := Src1.Height - 1;
    if InitLine(Src1, Pointer(S01), DeltaS1) and InitLine(Src2, Pointer(S02), DeltaS2) and InitLine(DstBmp, Pointer(D0), DeltaD) then begin
      if MskBmp = nil then
        for Y := 0 to h do begin
          S1 := Pointer(PAnsiChar(S01) + DeltaS1 * Y);
          S2 := Pointer(PAnsiChar(S02) + DeltaS2 * Y);
          D  := Pointer(PAnsiChar(D0) + DeltaD * Y);
          for X := 0 to w do
            with D[X], S1[X], S2[X] do begin
              DR := ((SR - R) * Percent + R shl 8) shr 8;
              DG := ((SG - G) * Percent + G shl 8) shr 8;
              DB := ((SB - B) * Percent + B shl 8) shr 8;
            end
        end
      else
        if InitLine(MskBmp, Pointer(M0), DeltaM) then
          for Y := 0 to h do begin
            S1 := Pointer(PAnsiChar(S01) + DeltaS1 * Y);
            S2 := Pointer(PAnsiChar(S02) + DeltaS2 * Y);
            D  := Pointer(PAnsiChar(D0) + DeltaD * Y);
            M  := Pointer(PAnsiChar(M0) + DeltaM * Y);
            for X := 0 to w do
              with D[X], S1[X], S2[X], M[X] do begin
                DR := ((SR - R) * MR + R shl 8) shr 8;
                DG := ((SG - G) * MG + G shl 8) shr 8;
                DB := ((SB - B) * MB + B shl 8) shr 8;
              end
          end;
    end;
  end;
end;


procedure SumByMaskWith32(const DstBmp, SrcBmp, MskBmp: Graphics.TBitMap; const aRect: TRect);
var
  D0, D: PRGBAArray_D;
  S0, S: PRGBAArray_S;
  M0, M: PRGBAArray_M;
  DeltaS, DeltaD, DeltaM, X, Y, BB, RR, tmp: integer;
begin
  if (DstBmp.Width >= WidthOf(aRect)) and (DstBmp.Height >= HeightOf(aRect)) then begin
    BB := aRect.Bottom - 1;
    RR := aRect.Right - 1;
    if InitLine(SrcBmp, Pointer(S0), DeltaS) and InitLine(DstBmp, Pointer(D0), DeltaD) and InitLine(MskBmp, Pointer(M0), DeltaM) then
      for Y := aRect.Top to BB do begin
        S := Pointer(PAnsiChar(S0) + DeltaS * Y);
        D := Pointer(PAnsiChar(D0) + DeltaD * Y);
        M := Pointer(PAnsiChar(M0) + DeltaM * Y);
        for X := aRect.Left to RR do
          with M[X] do
            case MR of
              MaxByte:
                ;// skip

              0:
                with D[X], S[X] do begin
                  DR := ((SR - DR) * SA + DR shl 8) shr 8;
                  DG := ((SG - DG) * SA + DG shl 8) shr 8;
                  DB := ((SB - DB) * SA + DB shl 8) shr 8;
                end

              else
                with D[X], S[X] do begin
                  tmp := ((MaxByte - MR) * SA) shr 8;
                  DR := ((SR - DR) * tmp + DR shl 8) shr 8;
                  DG := ((SG - DG) * tmp + DG shl 8) shr 8;
                  DB := ((SB - DB) * tmp + DB shl 8) shr 8;
                end;
            end;
      end;
  end;
end;


procedure ColorizeByMask(const DstBmp, MskBmp: TBitMap; TopLeft: TPoint; Color, BGColor: TColor);
var
  D0, D: PRGBAArray_D;
  M0, M: PRGBAArray_M;
  C, BG: TsColor;
  w, h, DeltaD, DeltaM, X, Y, tmp: integer;
begin
  if TopLeft.X < 0 then
    TopLeft.X := 0;

  if TopLeft.Y < 0 then
    TopLeft.Y := 0;

  w := min(MskBmp.Width, DstBmp.Width - TopLeft.X) - 1;
  h := min(MskBmp.Height, DstBmp.Height - TopLeft.Y) - 1;
  C.C := Color;
  BG.C := BGColor;
  if InitLine(DstBmp, Pointer(D0), DeltaD) and InitLine(MskBmp, Pointer(M0), DeltaM) then
    if BGColor <> clNone then
      for Y := 0 to h do begin
        D := Pointer(PAnsiChar(D0) + DeltaD * (Y + TopLeft.Y));
        M := Pointer(PAnsiChar(M0) + DeltaM * Y);
        for X := 0 to w do
          with M[X], D[X + TopLeft.X], C do begin
            tmp := MaxByte - (MR + MB + MG shl 1 {x2}) shr 2; // Real mask
            DR := ((R - BG.R) * tmp + BG.R shl 8) shr 8;
            DG := ((G - BG.G) * tmp + BG.G shl 8) shr 8;
            DB := ((B - BG.B) * tmp + BG.B shl 8) shr 8;
          end;
      end
    else
      if MskBmp.PixelFormat = pf32bit then
        for Y := 0 to h do begin
          D := Pointer(PAnsiChar(D0) + DeltaD * (Y + TopLeft.Y));
          M := Pointer(PAnsiChar(M0) + DeltaM * Y);
          for X := 0 to w do
            with M[X], D[X + TopLeft.X], C do begin
              tmp := MA; // Real mask
              DR := ((R - DR) * tmp + DR shl 8) shr 8;
              DG := ((G - DG) * tmp + DG shl 8) shr 8;
              DB := ((B - DB) * tmp + DB shl 8) shr 8;
            end;
        end
      else
        for Y := 0 to h do begin
          D := Pointer(PAnsiChar(D0) + DeltaD * (Y + TopLeft.Y));
          M := Pointer(PAnsiChar(M0) + DeltaM * Y);
          for X := 0 to w do
            with M[X], D[X + TopLeft.X], C do begin
              tmp := MaxByte - (MR + MB + MG shl 1 {x2}) shr 2; // Real mask
              DR := ((R - DR) * tmp + DR shl 8) shr 8;
              DG := ((G - DG) * tmp + DG shl 8) shr 8;
              DB := ((B - DB) * tmp + DB shl 8) shr 8;
            end;
        end
end;


function MakeRotated90(var Bmp: TBitmap; CW: boolean; KillSource: boolean = True): TBitmap;
begin
  if Bmp.PixelFormat = pf32bit then
    if CW then
      Result := bmpRotate(bmp, i90, KillSource)
    else
      Result := bmpRotate(bmp, i270, KillSource)
  else
    Result := nil;
end;


function sMakeRotated90(var Bmp: TBitmap; CW: boolean; KillSource: boolean = True): TBitmap;
var
  X, Y, w, h: integer;
  C: TsColor;
begin
  w := Bmp.Width - 1;
  h := Bmp.Height - 1;
  if Bmp.PixelFormat = pf32bit then begin
    Result := CreateBmp32(h + 1, w + 1);
    if CW then
      for Y := 0 to h do
        for X := 0 to w do begin
          C := GetAPixel(Bmp, X, Y);
          SetAPixel(Result, h - Y, X, C);
        end
    else
      for Y := 0 to h do
        for X := 0 to w do begin
          C := GetAPixel(Bmp, w - X, Y);
          SetAPixel(Result, Y, X, C);
        end;
  end
  else
    Result := nil;

  if KillSource then
    FreeAndNil(Bmp);
end;


type
  TAngle = 0..359;

  TDoublePoint = record
    X, Y: Double;
  end;

  TPrlgram = class
  private
    FPoints: array [0..3] of TDoublePoint;
    function GetPoint(Index: Integer): TPoint;
  public
    constructor Create(const APoints: array of TPoint); reintroduce;
    property Points[Index: Integer]: TPoint read GetPoint;
    procedure Rotate(Angle: TAngle);
  end;

  TSinCos = record
    S, C: Single;
  end;

var
  SCA: array of TSinCos;


procedure InitSCA;
Var
  I: Integer;
  S, C: Extended;
begin
  if Length(SCA) = 0 then begin
    SetLength(SCA, 360);
//    if SCA[0].C = 0 then
    for I := 0 to 359 do begin
      SinCos(DegToRad(I), S, C);
      SCA[I].S := S;
      SCA[I].C := C;
    end;
  end;
end;


constructor TPrlgram.Create(const APoints: array of TPoint);
Var
  I: Integer;
begin
  inherited Create;
  for I := 0 to Min(4, Length(APoints)) - 1 do begin
    FPoints[I].X := APoints[I].X;
    FPoints[I].Y := APoints[I].Y;
  end;
end;


function TPrlgram.GetPoint(Index: Integer): TPoint;
begin
  if Index in [0..3] then
    Result := Point(Round(FPoints[Index].X), Round(FPoints[Index].Y));
end;


procedure TPrlgram.Rotate(Angle: TAngle);
Var
  T: TDoublePoint;
  CX, CY: Single;
  X, Y: Single;
  I: Integer;
begin
  CX := (FPoints[0].X + FPoints[2].X) / 2;
  CY := (FPoints[0].Y + FPoints[2].Y) / 2;
  for i := 0 to 3 do begin
    T.X := FPoints[i].X - CX;
    T.Y := FPoints[i].Y - CY;
    with SCA[Angle] do begin
      X := T.X * C + T.Y * S;
      Y := -T.X * S + T.Y * C;
    end;
    FPoints[i].X := CX + X;
    FPoints[i].Y := CY + Y;
  end;
end;


procedure BitBltRotated(DC: hdc; SrcBmp: TBitmap; ACenter: TPoint; Angle: integer);
Var
  Points: array [0..3] of TPoint;
  Pts: array [0..2] of TPoint;
begin
  InitSCA;
  Angle := 360 - Angle;
  if Angle < 0 then
    inc(Angle, 360)
  else
    if Angle >= 360 then
      dec(Angle, 360);

  Points[0].X := ACenter.X - SrcBmp.Width div 2;
  Points[0].Y := ACenter.Y - SrcBmp.Height div 2;
  Points[1].X := Points[0].X + SrcBmp.Width;
  Points[1].Y := Points[0].Y;
  Points[2].X := Points[1].X;
  Points[2].Y := Points[1].Y + SrcBmp.Height;
  Points[3].X := Points[0].X;
  Points[3].Y := Points[0].Y + SrcBmp.Height;

  with TPrlgram.Create(Points) do begin
    Rotate(Angle);
    Pts[0] := Points[1];
    Pts[1] := Points[2];
    Pts[2] := Points[0];
    PlgBlt(DC, Pts, SrcBmp.Canvas.Handle, 0, 0, SrcBmp.Width, SrcBmp.Height, 0, 0, 0);
    Free;
  end;
end;


function CreateBmpLike(const Bmp: TBitmap): TBitmap;
begin
  Result := CreateBmp32;
  Result.Width := Bmp.Width;
  Result.Height := Bmp.Height;
  Result.PixelFormat := Bmp.PixelFormat;
end;


function CreateAlphaBmp(const SrcMaskedBmp: TBitmap; const SrcRect: TRect): TBitmap;
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, w, h, Y, X: integer;
begin
  w := WidthOf(SrcRect, True);
  h := HeightOf(SrcRect, True) div 2;
  if (w <> 0) and (h <> 0) and (SrcRect.Bottom <= SrcMaskedBmp.Height) and (SrcRect.Right <= SrcMaskedBmp.Width) then begin
    Result := CreateBmp32(w, h);
    // Copy content
    BitBlt(Result.Canvas.Handle, 0, 0, w, h, SrcMaskedBmp.Canvas.Handle, SrcRect.Left, SrcRect.Top, SRCCOPY);
    // Copy mask (red channel) as AlphaChannel
    if InitLine(SrcMaskedBmp, Pointer(S0), DeltaS) and InitLine(Result, Pointer(D0), DeltaD) then
      for Y := 0 to h - 1  do begin
        S := Pointer(PAnsiChar(S0) + DeltaS * (SrcRect.Top + Y + h));
        D := Pointer(PAnsiChar(D0) + DeltaD * Y);
        for X := 0 to w - 1  do
          D[X].DA := MaxByte - S[SrcRect.Left + X].SR;
      end;
  end
  else
    Result := nil;
end;


function CreateMaskFromAlpha(const SrcAlphaBmp: TBitmap): TBitmap;
var
  S0, S: PRGBAArray_S;
  D0, D: PRGBAArray_D;
  DeltaS, DeltaD, w, h, Y, X: integer;
begin
  w := SrcAlphaBmp.Width;
  h := SrcAlphaBmp.Height;// * 2;
  if (w <> 0) and (h <> 0) then begin
    Result := CreateBmp32(w, h * 2);
    // Copy content
    FillRect32(Result, MkRect(0, h, w, h * 2), clWhite, MaxByte);
    BitBlt(Result.Canvas.Handle, 0, 0, w, h, SrcAlphaBmp.Canvas.Handle, 0, 0, SRCCOPY);
    // Copy mask
    if InitLine(SrcAlphaBmp, Pointer(S0), DeltaS) and InitLine(Result, Pointer(D0), DeltaD) then
      for Y := 0 to h - 1 do begin
        S := Pointer(PAnsiChar(S0) + DeltaS * (Y));
        D := Pointer(PAnsiChar(D0) + DeltaD * (Y + h));
        for X := 0 to w - 1 do
          with D[X], S[X] do begin
            DR := MaxByte - SA;
            DG := DR;
            DB := DR;
            DA := MaxByte;
          end;
      end;
  end
  else
    Result := nil;
end;


procedure PrepareBmp(var Bmp: TBitmap; const Width: integer = 0; const Height: integer = 0);
begin
  if Bmp <> nil then begin
    Bmp.Width := Width;
    Bmp.Height := Height
  end
  else
    Bmp := CreateBmp32(Width, Height);
end;


function CreateBmp32(const Width: integer = 0; const Height: integer = 0): TBitmap;
begin
ResetLastError;
  Result := TBitmap.Create;
  try
    Result.IgnorePalette := True;
    Result.PixelFormat := pf32bit;
    Result.HandleType  := bmDIB;
    if (Width < 0) or (Height < 0) then begin
      Result.Width := 0;
      Result.Height := 0;
    end
    else begin
      Result.Width := Width;
      Result.Height := Height;
    end;
  except
    Result.Width  := 0;
    Result.Height := 0;
  end;
CheckLastError;
end;


function CreateBmp32(const R: TRect): TBitmap; overload;
begin
  Result := CreateBmp32(WidthOf(R, True), HeightOf(R, True));
end;


function CreateBmp32(const Size: TSize): TBitmap; overload;
begin
  Result := CreateBmp32(Size.cx, Size.cy);
end;


function CreateBmp32(const Bmp: TBitmap): TBitmap; overload;
begin
  Result := CreateBmp32(Bmp.Width, Bmp.Height);
end;


function CreateBmp32(const Ctrl: TControl): TBitmap; overload;
begin
  Result := CreateBmp32(Ctrl.Width, Ctrl.Height);
end;


procedure CheckBmp(var BmpOut: TBitmap; SampleBmp: TBitmap);
begin
  if BmpOut = nil then
    BmpOut := CreateBmp32(SampleBmp)
  else begin
    BmpOut.Width  := SampleBmp.Width;
    BmpOut.Height := SampleBmp.Height;
  end;
end;


function AverageColor(const ColorBegin, ColorEnd: TsColor): TsColor;
begin
  with TsColor_S(ColorBegin), TsColor_D(ColorEnd), TsColor(Result) do begin
    R := ((SR - DR) * 127 + DR shl 8) shr 8;
    G := ((SG - DG) * 127 + DG shl 8) shr 8;
    B := ((SB - DB) * 127 + DB shl 8) shr 8;
    A := 0;
  end;
end;


function AverageColor(const ColorBegin, ColorEnd: TColor): TColor; overload;
var
  c1, c2: TsColor;
begin
  c1.C := ColorBegin;
  c2.C := ColorEnd;
  Result := AverageColor(c1, c2).C;
end;


function BlendColors(const Color1, Color2: TColor; const BlendOf1: byte): TColor;
var
  c1: TsColor_D;
  c2: TsColor_S;
  BlendOf2: byte;
begin
  BlendOf2 := MaxByte - BlendOf1;
  with c1, c2 do begin
    DC := Color1;
    SC := Color2;
    DR := (DR * BlendOf1 + SR * BlendOf2) shr 8;
    DG := (DG * BlendOf1 + SG * BlendOf2) shr 8;
    DB := (DB * BlendOf1 + SB * BlendOf2) shr 8;
    Result := DC;
  end;
end;


procedure DrawRectangleOnDC(DC: HDC; var R: TRect; ColorTop, ColorBottom: TColor; var Width: integer; PSides: PacSides = nil);
var
  OldBrush: hBrush;
  Points: array [0..2] of TPoint;
  PenTop, PenBottom, OldPen: hPen;

  procedure DoRect;
  var
    TopRight, BottomLeft: TPoint;
  begin
    with R do begin
      TopRight.X := Right;
      TopRight.Y := Top;
      BottomLeft.X := Left;
      BottomLeft.Y := Bottom;

      Points[0] := BottomLeft;
      Points[1] := TopLeft;
      Points[2] := TopRight;
      SelectObject(dc, PenTop);
      PolyLine(DC, PPoints(@Points)^, 3);

      Dec(BottomLeft.X);

      Points[0] := TopRight;
      Points[1] := BottomRight;
      Points[2] := BottomLeft;
      SelectObject(dc, PenBottom);
      PolyLine(DC, PPoints(@Points)^, 3);
    end;
  end;

begin
  PenTop := CreatePen(PS_SOLID, 1, ColorToRGB(ColorTop));
  PenBottom := CreatePen(PS_SOLID, 1, ColorBottom);
  OldPen := SelectObject(dc, PenTop);
  OldBrush := SelectObject(dc, GetStockObject(NULL_BRUSH));

  Dec(R.Bottom);
  Dec(R.Right);

  while Width > 0 do begin
    Dec(Width);
    if PSides = nil then
      DoRect
    else begin
      if asLeft in PSides^ then
        acPaintLine(DC, R.Left, R.Top, R.Left, R.Bottom);

      if asTop in PSides^ then
        acPaintLine(DC, R.Left, R.Top, R.Right, R.Top);

      if asRight in PSides^ then
        acPaintLine(DC, R.Right, R.Top, R.Right, R.Bottom);

      if asBottom in PSides^ then
        acPaintLine(DC, R.Left, R.Bottom, R.Right, R.Bottom);
    end;
    InflateRect(R, -1, -1);
  end;
  Inc(R.Bottom); Inc(R.Right);

  SelectObject(dc, OldPen);
  SelectObject(dc, OldBrush);
  DeleteObject(PenTop);
  DeleteObject(PenBottom);
end;


procedure TileBitmap(const Canvas: TCanvas; const aRect: TRect; const Graphic: TGraphic);
var
  X, Y, cx, cy, w, h: Integer;
  SavedDC: hdc;
begin
{$IFNDEF TESTSLOWDETAILS}
  if Graphic <> nil then begin
    w := Graphic.Width;
    h := Graphic.Height;
    if (w <> 0) and (h <> 0) then begin
      Canvas.OnChange := nil;
      Canvas.OnChanging := nil;
      if Graphic is TBitmap then
        with TBitmap(Graphic).Canvas do begin
          x := aRect.Left;
          while x < aRect.Right - w do begin
            y := aRect.Top;
            while y < aRect.Bottom - h do begin
              BitBlt(Canvas.Handle, x, y, w, h, Handle, 0, 0, SRCCOPY);
              inc(y, h);
            end;
            BitBlt(Canvas.Handle, x, y, w, aRect.Bottom - y, Handle, 0, 0, SRCCOPY);
            inc(x, w);
          end;
          y := aRect.Top;
          while y < aRect.Bottom - h do begin
            BitBlt(Canvas.Handle, x, y, aRect.Right - x, h, Handle, 0, 0, SRCCOPY);
            inc(y, h);
          end;
          BitBlt(Canvas.Handle, x, y, aRect.Right - x, aRect.Bottom - y, Handle, 0, 0, SRCCOPY);
        end
      else
  {$IFNDEF NOJPG}
    {$IFDEF TINYJPG}
        if Graphic is TacTinyJPGImage then begin
    {$ELSE}
        if Graphic is TJPEGImage then begin
    {$ENDIF}
          SavedDC := SaveDC(Canvas.Handle);
          IntersectClipRect(Canvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
          cx := WidthOf(aRect) div w;
          cy := HeightOf(aRect) div h;
          for X := 0 to cx do
            for Y := 0 to cy do
              Canvas.Draw(aRect.Left + X * w, aRect.Top + Y * h, Graphic);

          RestoreDC(Canvas.Handle, SavedDC);
        end;
  {$ENDIF}
    end;
  end;
{$ENDIF}  
end;


{$IFNDEF ACHINTS}
procedure TileBitmap(Canvas: TCanvas; var aRect: TRect; Graphic: TGraphic; const MaskData: TsMaskData; FillMode: TacFillMode = fmTiled);
var
  X, Y, w, h, NewX, NewY, Tmp: Integer;
  SrcBmp: TBitmap;
begin
{$IFNDEF TESTSLOWDETAILS}
//  if (MaskData.PropertyName <> '') then begin // If bitmap in the MaskData
//  if ((Graphic = nil) or Graphic.Empty) and (MaskData.R.Left <> MaskData.R.Right) then begin // If bitmap in the MaskData
    if MaskData.Bmp <> nil then
      SrcBmp := MaskData.Bmp
    else
      if MaskData.Manager <> nil then
        SrcBmp := TsSkinManager(MaskData.Manager).MasterBitmap
      else
        Exit;

    w := WidthOf(MaskData.R);
    h := HeightOf(MaskData.R);
    Tmp := 0;
    case FillMode of
      fmStretched: begin
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        StretchBlt(Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), HeightOf(aRect), SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmStretchHorzTop: begin
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        StretchBlt(Canvas.Handle, aRect.Left, aRect.Top, WidthOf(aRect), h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(aRect.Left, aRect.Top + h, aRect.Right, aRect.Bottom);
      end;

      fmStretchVertLeft: begin
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        StretchBlt(Canvas.Handle, aRect.Left, aRect.Top, w, HeightOf(aRect), SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(aRect.Left + w, aRect.Top, aRect.Right, aRect.Bottom);
      end;

      fmStretchHorz: begin
        y := aRect.Top;
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        while y < aRect.Bottom - h do begin
          StretchBlt(Canvas.Handle, aRect.Left, y, WidthOf(aRect), h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
          inc(y, h);
        end;
        StretchBlt(Canvas.Handle, aRect.Left, y, WidthOf(aRect), h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmStretchVert: begin
        x := aRect.Left;
        SetStretchBltMode(Canvas.Handle, COLORONCOLOR);
        while x < aRect.Right - w do begin
          StretchBlt(Canvas.Handle, x, aRect.Top, w, HeightOf(aRect), SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
          inc(x, w);
        end;
        StretchBlt(Canvas.Handle, x, aRect.Top, w, HeightOf(aRect), SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, w, h, SRCCOPY);
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmDisTiled: begin
        x := aRect.Left;
        NewX := aRect.Right - w;
        NewY := aRect.Bottom - h;
        while x < NewX do begin
          y := aRect.Top;
          while y < NewY do begin
            BitBlt(Canvas.Handle, x, y, w, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
            inc(y, h);
          end;
          inc(x, w);
        end;
        y := aRect.Top;
        while y < NewY do begin
          BitBlt(Canvas.Handle, x, y, aRect.Right - x, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
          inc(y, h);
        end;
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmFromBottomToTop: begin
        NewX := aRect.Left;
        NewY := aRect.Top;
        x := aRect.Right - w;
        while x > NewX do begin
          y := aRect.Bottom - h;
          while y > NewY do begin
            BitBlt(Canvas.Handle, x, y, w, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
            dec(y, h);
          end;
          Tmp := NewY - y;
          BitBlt(Canvas.Handle, x, NewY, w, h - Tmp, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top + Tmp, SRCCOPY);
          dec(x, w);
        end;
        y := aRect.Bottom - h;

        while y > NewY do begin
          Tmp := NewX - X;
          BitBlt(Canvas.Handle, NewX, y, w - Tmp, h, SrcBmp.Canvas.Handle, MaskData.R.Left + Tmp, MaskData.R.Top, SRCCOPY);
          dec(y, h);
        end;
        Tmp := NewX - X;
        Y := NewY - Y;
        BitBlt(Canvas.Handle, NewX, NewY, w - Tmp, h - Y, SrcBmp.Canvas.Handle, MaskData.R.Left + Tmp, MaskData.R.Top + Y, SRCCOPY);

        aRect := Rect(-1, -1, -1, -1);
      end

      else begin
        x := aRect.Left;
        case FillMode of
          fmTiled: begin
            NewX := aRect.Right - w;
            NewY := aRect.Bottom - h;
          end;

          fmTiledHorz: begin
            NewX := aRect.Right - w;
            NewY := aRect.Top;
          end;

          fmTiledVert: begin
            NewX := aRect.Left;
            NewY := aRect.Bottom - h;
          end;

          fmTileHorBtm: begin
            Tmp := aRect.Top;
            aRect.Top := aRect.Bottom - h;
            NewX := aRect.Right - w;
            NewY := aRect.Top;
          end

          else begin
            Tmp := aRect.Left;
            aRect.Left := aRect.Right - w;
            NewX := aRect.Left;
            NewY := aRect.Bottom - h;
          end;
        end;
        if h > 0 then
          while x < NewX do begin
            y := aRect.Top;
            while y < NewY do begin
              BitBlt(Canvas.Handle, x, y, w, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
              inc(y, h);
            end;
            BitBlt(Canvas.Handle, x, y, w, aRect.Bottom - y, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
            inc(x, w);
          end;

        y := aRect.Top;
        if h > 0 then
          while y < NewY do begin
            BitBlt(Canvas.Handle, x, y, aRect.Right - x, h, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
            inc(y, h);
          end;
          
        BitBlt(Canvas.Handle, x, y, aRect.Right - x, aRect.Bottom - y, SrcBmp.Canvas.Handle, MaskData.R.Left, MaskData.R.Top, SRCCOPY);
        case FillMode of
          fmTiled:         aRect := Rect(-1, -1, -1, -1);
          fmTiledHorz:     aRect := Rect(aRect.Left, aRect.Top + h, aRect.Right, aRect.Bottom);
          fmTiledVert:     aRect := Rect(aRect.Left + w, aRect.Top, aRect.Right, aRect.Bottom);
          fmTileHorBtm:    aRect := Rect(aRect.Left, Tmp, aRect.Right, aRect.Bottom - h);
          fmTileVertRight: aRect := Rect(Tmp, arect.Top, aRect.Right - w, aRect.Bottom);
        end;
      end
    end
{$ENDIF}
end;


procedure TileMasked(Bmp: TBitmap; var aRect: TRect; const CI: TCacheInfo; const MaskData: TsMaskData; FillMode: TacFillMode = fmDisTiled);
var
  X, Y, w, h, NewX, NewY: Integer;
  mr: TRect;
begin
  if MaskData.Manager <> nil then begin
    w := MaskData.Width;
    h := HeightOf(MaskData.R) div 2;
    case FillMode of
      fmTiled: begin
        x := aRect.Left;
        NewX := aRect.Right - w;
        NewY := aRect.Bottom - h;
        mr := MaskData.R;
        while x < NewX do begin
          y := aRect.Top;
          while y < NewY do begin
            CopyMasterRect(Rect(x, y, x + w, y + h), mr, Bmp, CI, MaskData);
            inc(y, h);
          end;
          inc(x, w);
        end;
        y := aRect.Top;
        while y < NewY do begin
          CopyMasterRect(Rect(x, y, aRect.Right, y + h), mr, Bmp, CI, MaskData);
          inc(y, h);
        end;
        aRect := Rect(-1, -1, -1, -1);
      end;

      fmDisTiled: begin
        x := aRect.Left;
        NewX := aRect.Right - w;
        NewY := aRect.Bottom - h;
        mr := MaskData.R;
        y := 0;
        while x < NewX do begin
          y := aRect.Top;
          while y < NewY do begin
            CopyMasterRect(Rect(x, y, x + w, y + h), mr, Bmp, CI, MaskData);
            inc(y, h);
          end;
          inc(x, w);
        end;
        if CI.Ready then begin
          BitBlt(Bmp.Canvas.Handle, aRect.Left, y, WidthOf(aRect), aRect.Bottom - y, CI.Bmp.Canvas.Handle, aRect.Left + CI.X, Y + CI.Y, SRCCOPY);
          BitBlt(Bmp.Canvas.Handle, x, aRect.Top, aRect.Right - x, HeightOf(aRect), CI.Bmp.Canvas.Handle, x + CI.X, aRect.Top + CI.Y, SRCCOPY);
        end
        else
          if Bmp.PixelFormat = pf32bit then begin
            FillRect32(Bmp, Rect(aRect.Left, y, aRect.Right, aRect.Bottom), ci.FillColor);
            FillRect32(Bmp, Rect(x, aRect.Top, aRect.Right, aRect.Bottom), ci.FillColor);
          end
          else begin
            FillDC(Bmp.Canvas.Handle, Rect(aRect.Left, y, aRect.Right, aRect.Bottom), CI.FillColor);
            FillDC(Bmp.Canvas.Handle, Rect(x, aRect.Top, aRect.Right, aRect.Bottom), CI.FillColor);
          end;

        aRect := Rect(-1, -1, -1, -1);
      end;
    end;
  end;
end;
{$ENDIF}


procedure CalcButtonLayout(const Client: TRect; const GlyphSize: TPoint; const TextRectSize: TSize; Layout: TButtonLayout; Alignment: TAlignment;
  AMargin, Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect; BiDiFlags: LongInt; VerticalAlignment: TVerticalAlignment = taVerticalCenter);
var
  TextPos, ClientSize, TextSize, TotalSize: TPoint;
  Margin, dh: integer;
begin
  { Calculate the item sizes }
  ClientSize := Point(Client.Right - Client.Left, Client.Bottom - Client.Top);

  TextBounds := MkRect(TextRectSize.cx, TextRectSize.cy);
  TextSize := Point(TextRectSize.cx, TextRectSize.cy);
  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically. If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [blGlyphLeft, blGlyphRight] then begin
    GlyphPos.Y := (ClientSize.Y - GlyphSize.Y + 1) div 2;
    TextPos.Y  := (ClientSize.Y - TextSize.Y  + 1) div 2;
  end
  else begin
    GlyphPos.X := (ClientSize.X - GlyphSize.X + 1) div 2;
    TextPos.X  := (ClientSize.X - TextSize.X  + 1) div 2;
  end;
  { If there is no text or no bitmap, then Spacing is irrelevant }
  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  Margin := AMargin;
  if Margin = -1 then // Adjust Margin and Spacing
    if Spacing = -1{< 0} then begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 3;

      Spacing := Margin;
    end
    else begin
      if Alignment in [taLeftJustify, taRightJustify] then
        TotalSize := ClientSize
      else
        TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y + Spacing + TextSize.Y);

      case VerticalAlignment of
        taVerticalCenter:
          if Alignment = taCenter then
            if Layout in [blGlyphLeft, blGlyphRight] then
              Margin := (ClientSize.X - TotalSize.X + 1) div 2
            else
              Margin := (ClientSize.Y - TotalSize.Y + 1) div 2
          else
            Margin := 2;

        taAlignTop, taAlignBottom:
          Margin := 2;
      end;
    end
  else
    if Spacing =-1{< 0} then begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y - (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;

  case Layout of
    blGlyphLeft:
      case Alignment of
        taLeftJustify:
          if GlyphSize.X = 0 then begin
            TextPos.X := Margin;
            TextBounds.Right := TextPos.X + TextSize.X;
          end
          else begin
            GlyphPos.X := Margin;
            TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
            TextBounds.Right := Client.Right - Margin - TextPos.X;
          end;

        taCenter: begin
          Margin := max((ClientSize.X - TextSize.X - Spacing - GlyphSize.X) div 2, Margin);
          GlyphPos.X := Margin;
          TextPos.X := GlyphPos.X + Spacing + GlyphSize.X;
        end;

        taRightJustify: begin
          TextPos.X := ClientSize.X - Margin - TextSize.X;
          GlyphPos.X := TextPos.X - Spacing - GlyphSize.X;
        end;
      end;

    blGlyphRight:
      case Alignment of
        taLeftJustify: begin
          GlyphPos.X := Margin + TextSize.X + Spacing;
          TextPos.X := GlyphPos.X - Spacing - TextRectSize.cx;
        end;
        taCenter: begin
          Margin := (ClientSize.X - TextSize.X - Spacing - GlyphSize.X) div 2;
          TextPos.X := Margin;
          GlyphPos.X := TextPos.X + Spacing + TextSize.X;
        end;
        taRightJustify: begin
          GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
          TextPos.X := 0;
          TextBounds.Right := GlyphPos.X - Spacing - TextPos.X;
        end;
      end;

    blGlyphTop: begin
      dh := (ClientSize.y - GlyphSize.Y - Spacing - TextRectSize.cy) div 2 - Margin;
      GlyphPos.Y := Margin + dh;
      TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
    end;

    blGlyphBottom: begin
      dh := (ClientSize.y - GlyphSize.Y - Spacing - TextRectSize.cy) div 2 - Margin;
      GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y - dh;
      TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
    end;
  end;
  // Fixup the result variables
  with GlyphPos do begin
    Inc(X, Client.Left);
    Inc(Y, Client.Top);
  end;
  OffsetRect(TextBounds, TextPos.X + Client.Left, TextPos.Y + Client.Top);
  case VerticalAlignment of
    taAlignTop: begin
      Margin := max(0, AMargin);
      case Layout of
        blGlyphLeft, blGlyphRight: begin
          GlyphPos.Y := Margin;
          OffsetRect(TextBounds, 0, Margin - TextBounds.Top);
        end;
        blGlyphTop: begin
          OffsetRect(TextBounds, 0, Margin - GlyphPos.Y);
          GlyphPos.Y := Margin;
        end;
        blGlyphBottom: begin
          GlyphPos.Y := GlyphPos.Y + (Margin - TextBounds.Top);
          OffsetRect(TextBounds, 0, Margin - TextBounds.Top);
        end;
      end;
    end;

    taAlignBottom: begin
      Margin := max(0, AMargin);
      case Layout of
        blGlyphLeft, blGlyphRight: begin
          GlyphPos.Y := Client.Bottom - Margin - GlyphSize.Y;
          OffsetRect(TextBounds, 0, Client.Bottom - Margin - TextBounds.Bottom);
        end;
        blGlyphTop: begin
          GlyphPos.Y := GlyphPos.Y + (Client.Bottom - Margin - TextBounds.Bottom);
          OffsetRect(TextBounds, 0, Client.Bottom - Margin - TextBounds.Bottom);
        end;
        blGlyphBottom: begin
          OffsetRect(TextBounds, 0, Client.Bottom - Margin - GlyphPos.Y - GlyphSize.Y);
          GlyphPos.Y := Client.Bottom - Margin - GlyphSize.Y;
        end;
      end;
    end;
  end;
  if BiDiFlags and DT_RIGHT <> 0 then begin
    ReflectRect(TextBounds, ClientSize.X, ClientSize.Y, True);
    GlyphPos.X := ClientSize.X - GlyphPos.X - GlyphSize.X;
  end;
end;


function GetFontHeight(hFont: HWnd; NoLeading: boolean = False): integer;
var
  DC: HDC;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    SelectObject(DC, hFont);
    if GetTextMetrics(DC, Metrics) then
      if NoLeading then
        Result := Metrics.tmHeight - Metrics.tmInternalLeading - Metrics.tmExternalLeading
      else
        Result := Metrics.tmHeight + 6
    else
      Result := 0;
  finally
    ReleaseDC(0, DC);
  end;
end;


function FontSizeIsNear(const BaseFont: TFont; const TestText: acString; const FontName: string): boolean;
var
  DC: HDC;
  F: TFont;
  SaveFont: HGDIOBJ;
  BaseSize, NewSize: TSize;
begin
  Result := False;
  F := TFont.Create;
  F.Assign(BaseFont);
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, F.Handle);
{$IFDEF TNTUNICODE}
    if not GetTextExtentPoint32W(DC, PWideChar(TestText), Length(TestText), BaseSize) then
{$ELSE}
    if not GetTextExtentPoint32(DC, PChar(TestText), Length(TestText), BaseSize) then
{$ENDIF}
      Exit;

    F.Name := FontName;
    SelectObject(DC, F.Handle);
{$IFDEF TNTUNICODE}
    if not GetTextExtentPoint32W(DC, PWideChar(TestText), Length(TestText), NewSize) then
{$ELSE}
    if not GetTextExtentPoint32(DC, PChar(TestText), Length(TestText), NewSize) then
{$ENDIF}
      Exit;

    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  if BaseSize.cx > NewSize.cx then
    Result := BaseSize.cx / NewSize.cx < 1.07
  else
    Result := NewSize.cx / BaseSize.cx < 1.07;

  if Result then
    if BaseSize.cy > NewSize.cy then
      Result := BaseSize.cy / NewSize.cy < 1.2
    else
      Result := NewSize.cy / BaseSize.cy < 1.2
end;


function GetStringSize(hFont: hgdiobj; const Text: acString; Flags: Cardinal = 0; WrapText: boolean = False; MaxWidth: integer = MaxInt; IsItalic: boolean = False): TSize;
var
  C: AnsiChar;
  DC: HDC;
  R: TRect;
  Size: TSize;
  SaveFont: HGDIOBJ;
begin
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, hFont);
    if WrapText then begin
      R := MkRect(MaxWidth, 0);
      acDrawText(DC, PacChar(Text), R, Flags or DT_CALCRECT or DT_WORDBREAK and not DT_SINGLELINE);
      Result := MkSize(R);
    end
    else
      if not {$IFDEF TNTUNICODE}GetTextExtentPoint32W{$ELSE}GetTextExtentPoint32{$ENDIF}(DC, PacChar(Text), Length(Text), Result) then
        Result := MkSize;

    if IsItalic then begin
      Size := MkSize;
      C := 'I';
      GetTextExtentPoint32(DC, PAnsiChar(@C), 1, Size);
      inc(Result.cx, Size.cx);
    end;
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
end;


procedure LoadBmpFromPngFile(Bmp: TBitmap; const FileName: string);
{$IFNDEF FPC}
var
  Png: TPNGGraphic;
begin
  Png := TPNGGraphic.Create;
{$ELSE}
var
  Png: TPortableNetworkGraphic;
begin
  Png := TPortableNetworkGraphic.Create;
{$ENDIF}
  try
    Png.LoadFromFile(FileName);
    Bmp.Assign(Png);
    UpdateTransparency(Bmp, Png);
  finally
    Png.Free;
  end;
end;


procedure LoadBmpFromPngStream(Bmp: TBitmap; Stream: TStream);
{$IFNDEF FPC}
var
  b: boolean;
  Png: TPNGGraphic;
begin
  Png := TPNGGraphic.Create;
{$ELSE}
var
  Png: TPortableNetworkGraphic;
begin
  Png := TPortableNetworkGraphic.Create;
{$ENDIF}
  try
    Png.LoadFromStream(Stream);
    b := Bmp.Transparent;
    Bmp.IgnorePalette := Png.IgnorePalette;
    Bmp.Assign(Png);
    Bmp.Transparent := b;
    UpdateTransparency(Bmp, Png);
  finally
    Png.Free;
  end;
end;


procedure FocusRect(Canvas: TCanvas; R: TRect; LightColor: TColor = clBtnFace; DarkColor: TColor = clBlack);
const
  Step = 2;
var
  x, y, dx, dy: integer;
begin
  dx := WidthOf(R)  div Step;
  dy := HeightOf(R) div Step;
  dec(R.Right);
  dec(R.Bottom);
  for x := dx downto 1 do begin
    if DarkColor <> clNone then begin
      Canvas.Pixels[R.Left + Step * x, R.Top] := DarkColor;
      Canvas.Pixels[R.Left + Step * x, R.Bottom] := DarkColor;
    end;
    if LightColor <> clNone then begin
      Canvas.Pixels[R.Left + Step * x - 1, R.Top] := LightColor;
      Canvas.Pixels[R.Left + Step * x - 1, R.Bottom] := LightColor;
    end;
  end;
  for y := dy downto 1 do begin
    if DarkColor <> clNone then begin
      Canvas.Pixels[R.Left, R.Top + Step * y] := DarkColor;
      Canvas.Pixels[R.Right, R.Top + Step * y] := DarkColor;
    end;
    if LightColor <> clNone then begin
      Canvas.Pixels[R.Left, R.Top + Step * y - 1] := LightColor;
      Canvas.Pixels[R.Right, R.Top + Step * y - 1] := LightColor;
    end;
  end;
end;


procedure acDrawFocusRect(Canvas: TCanvas; const R: TRect);
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Style := psClear;
  DrawFocusRect(Canvas.Handle, R);
end;


type
  TContributor = packed record
    Pixel: Integer;
    Weight: Integer;
  end;
  TContributorList = array[0..0] of TContributor;
  PContributorList = ^TContributorList;
  TCList = packed record
    Count: Integer;
    Data: PContributorList;
  end;
  TCListList = array[0..0] of TCList;
  PCListList = ^TCListList;
  TRGBTripleArray = array[0..0] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;
  TDrawProc = procedure(Count: Integer; Contributes: PCListList; srcLine, dstLine: Pointer; dstDelta, srcDelta: Integer); pascal;


procedure CreateContributors(var Contrib: PCListList; Size: Integer; MaxSize: Integer; Filter: TFilterType; Delta: Integer);
var
  Scale2, AWidth, Param, W, Center: Single;
  A, B, Count, CSize: Integer;
  Data: PContributorList;
const
  CFilters: array [TFilterType] of Single = (0.51, 1, 1, 1.5, 2, 3, 2);
begin
{$T-}
{$R-}
  Contrib := nil;
  if MaxSize > Size then
    Scale2 := Size / MaxSize
  else
    Scale2 := 1;

  AWidth := CFilters[Filter] / Scale2;
  CSize := Trunc(AWidth * 2 + 1) * SizeOf(TContributor);
  GetMem(Contrib, Size * (SizeOf(TCList) + CSize));
  Data := @PAnsiChar(Contrib)[Size * SizeOf(TCList)];
  for A := Size - 1 downto 0 do begin
    Count := 0;
    Center := A * MaxSize / Size;
    for B := Ceil(Center + AWidth) downto Floor(Center - AWidth) do begin
      Param := Abs(Center - B) * Scale2;
      if Param >= CFilters[Filter] then
        Continue;

      case Filter of
        ftBox:
          if (Param <= 0.5) and ((Center - B) * Scale2 <> -0.5) then
            W := 1.0
          else
            W := 0.0;

        ftTriangle:
          W := 1.0 - Param;

        ftHermite:
          W := (2.0 * Param - 3.0) * Sqr(Param) + 1.0;

        ftBell:
          if Param < 0.5 then
            W := 0.75 - Sqr(Param)
          else
            W := Sqr(Param - 1.5) * 0.5;

        ftSpline:
          if Param < 1.0 then
            W := 2 / 3 + Sqr(Param) * (Param * 0.5 - 1.0)
          else
            W := Sqr(2 - Param) * (2 - Param) * (1 / 6);

        ftLanczos3:
          if Param <> 0.0 then
            W := Sin(Param * Pi) * Sin(Param) / (Sqr(Param) * Pi)
          else
            W := 1.0;

        ftMitchell:
          if Param < 1.0 then
            W := Sqr(Param) * (7 / 6 * Param - 2) + 8 / 9
          else
            W := Sqr(Param) * ((-7 / 18) * Param + 2.0) - 10 / 3 * Param + 16 / 9;

        else
          W := 0.0;
      end;
      if W <> 0.0 then begin
        with Data[Count] do begin
          if B < 0 then
            if -B >= MaxSize then
              Pixel := 2 * MaxSize + B - 1
            else
              Pixel := -B
          else
            if B >= MaxSize then
              Pixel := 2 * MaxSize - B - 1
            else
              Pixel := B;

          Pixel := Pixel * Delta;
          Weight := Round(W * Scale2 * 65536);
        end;
        Inc(Count);
      end;
    end;
    Contrib[A].Count := Count;
    Contrib[A].Data := Data;
    Data := PContributorList(PAnsiChar(Data) + CSize);
  end;
{$R+}
{$T+}
end;


procedure FreeContributors(var Contrib: PCListList);
begin
  if Assigned(Contrib) then begin
    FreeMem(Contrib);
    Contrib := nil;
  end;
end;


procedure DrawLine32Pas(Count: Integer; Contributes: PCListList; srcLine, dstLine: Pointer; dstDelta, srcDelta: Integer); pascal;
var
  Dest: PRGBQUAD;
  R, G, B, AA, A, X: Integer;
begin
{$R-}
  Dest := dstLine;
  for X := 0 to Count - 1 do begin
    R := 0;
    G := 0;
    B := 0;
    AA := 0;
    for A := Contributes[X].Count - 1 downto 0 do
      with Contributes[X].Data[A] do
        if Weight <> 0 then
          with PRGBQuad(Integer(srcLine) + Pixel)^ do begin
            Inc(R,  rgbRed      * Weight);
            Inc(G,  rgbGreen    * Weight);
            Inc(B,  rgbBlue     * Weight);
            Inc(AA, rgbReserved * Weight);
          end;

    with Dest^ do begin
      if R < 0 then
        rgbRed := 0
      else
        if R > $FF0000 then
          rgbRed := MaxByte
        else
          rgbRed := R shr 16;

      if G < 0 then
        rgbGreen := 0
      else
        if G > $FF0000 then
          rgbGreen := MaxByte
        else
          rgbGreen := G shr 16;

      if B < 0 then
        rgbBlue := 0
      else
        if B > $FF0000 then
          rgbBlue := MaxByte
        else
          rgbBlue := B shr 16;

      if AA < 0 then
        rgbReserved := 0
      else
        if AA > $FF0000 then
          rgbReserved := MaxByte
        else
          rgbReserved := AA shr 16;
    end;

    if ACNativeInt(PAnsiChar(Dest) + dstDelta) < MaxLongInt then
      Dest := PRGBQUAD(PAnsiChar(Dest) + dstDelta)
  end;
{$R+}
end;


function FontsEqual(const Font1, Font2: TFont): boolean;
begin
  Result := (Font1.Style = Font2.Style) and (Font1.Size = Font2.Size) and (Font1.Color = Font2.Color) and (Font1.Name = Font2.Name);
end;


procedure acPaintStdBtn(ACanvas: TCanvas; ARect: TRect; AEnabled, AFocusRect: boolean; AState: integer);
var
  cRect: TRect;
  Flags: Cardinal;
{$IFDEF DELPHI7UP}
  Details: TThemedElementDetails;
  Button: TThemedButton;
{$ENDIF}
begin
{$IFDEF DELPHI7UP}
  if acThemesEnabled then begin
    if not AEnabled then
      Button := tbPushButtonDisabled
    else
      case AState of
        1: Button :=   tbPushButtonHot;
        2: Button :=   tbPushButtonPressed;
        3: Button :=   tbPushButtonDefaulted
        else Button := tbPushButtonNormal;
      end;

    Details := acThemeServices.GetElementDetails(Button);
    FillDC(ACanvas.Handle, ARect, clBtnFace);
    // Button shape
    acThemeServices.DrawElement(ACanvas.Handle, Details, ARect);
{$IFDEF DELPHI_XE2}
    acThemeServices.GetElementContentRect(ACanvas.Handle, Details, ARect, ARect);
{$ELSE}
    ARect := acThemeServices.ContentRect(ACanvas.Handle, Details, ARect);
{$ENDIF}
    if AFocusRect then begin
      ACanvas.Pen.Color := clWindowFrame;
      ACanvas.Brush.Color := clBtnFace;
      DrawFocusRect(ACanvas.Handle, ARect);
    end;
  end
  else
{$ENDIF}
  begin
    cRect := ARect;
    Flags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
    if AState = 2 then
      Flags := Flags or DFCS_PUSHED;

    if not AEnabled then
      Flags := Flags or DFCS_INACTIVE;
    // DrawFrameControl doesn't allow for drawing a button as the default button, so it must be done here
    if AState = 3 then begin
      FillDCBorder(ACanvas.Handle, ARect, 1, 1, 1, 1, clWindowFrame);
      // DrawFrameControl must draw within this border
      InflateRect(ARect, -1, -1);
    end;
    // DrawFrameControl does not draw a pressed button correctly
    if AState = 2 then begin
      InflateRect(ARect, -1, -1);
      ACanvas.Pen.Color := clBtnShadow;
      ACanvas.Pen.Width := 1;
      ACanvas.Brush.Color := clBtnFace;
      ACanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      FillDCBorder(ACanvas.Handle, ARect, 1, 1, 0, 0, clBtnShadow);
      FillDCBorder(ACanvas.Handle, ARect, 0, 0, 1, 1, clWhite);
    end
    else
      DrawFrameControl(ACanvas.Handle, ARect, DFC_BUTTON, Flags);

    if AFocusRect then
      DrawFocusRect(ACanvas.Handle, Rect(cRect.Left + 3, cRect.Top + 3, cRect.Right - 3, cRect.Bottom - 3));
  end;
end;


procedure Stretch(const SrcBmp, DstBmp: TBitmap; const DstWidth, DstHeight: Integer; const Filter: TFilterType);
var
  S, D: Pointer;
  WorkBmp: TBitmap;
  Contrib: PCListList;
  A, DeltaS, DeltaD, SrcWidth, SrcHeight: Integer;
begin
  if DstHeight <> 0 then begin
    SrcWidth := SrcBmp.Width;
    SrcHeight := SrcBmp.Height;
    if (SrcWidth > 1) and (SrcHeight > 1) and (DstWidth > 0) and (DstHeight > 0) then begin // Source bitmap is not too small
      if (SrcWidth <> DstWidth) or (SrcHeight <> DstHeight) then begin
        WorkBmp := CreateBmp32(DstWidth, SrcHeight);
        try
          if InitLine(SrcBmp, Pointer(S), DeltaS) and InitLine(WorkBmp, Pointer(D), DeltaD) then begin
            D := WorkBmp.ScanLine[0];
            CreateContributors(Contrib, DstWidth, SrcWidth, Filter, 4);
            try
              for A := SrcHeight - 1 downto 0 do begin
                DrawLine32Pas(DstWidth, Contrib, S, D, 4, 4);
                Inc(PAnsiChar(S), DeltaS);
                Inc(PAnsiChar(D), DeltaD);
              end;
            finally
              FreeContributors(Contrib);
            end;
          end;

          DstBmp.Width := DstWidth;
          DstBmp.Height := DstHeight;
          if InitLine(WorkBmp, Pointer(S), DeltaS) and InitLine(DstBmp, Pointer(D), DeltaD) then begin
            CreateContributors(Contrib, DstHeight, SrcHeight, Filter, DeltaS);
            try
              for A := DstWidth - 1 downto 0 do begin
                DrawLine32Pas(DstHeight, Contrib, S, D, DeltaD, DeltaS);
                S := Pointer(PAnsiChar(S) + 4);
                D := Pointer(PAnsiChar(D) + 4);
              end;
            finally
              FreeContributors(Contrib);
            end;
          end;
        finally
          WorkBmp.Free;
        end;
      end
      else
        if DstBmp <> SrcBmp then
          DstBmp.Assign(SrcBmp);
    end;
  end;
end;


function acCos(Angle: integer): real;
begin
  InitSCA;
  if Angle >= 0 then
    Result := SCA[Angle mod 360].C
  else
    Result := SCA[360 - (-Angle mod 360)].C;
end;


function acSin(Angle: integer): real;
begin
  InitSCA;
  if Angle >= 0 then
    Result := SCA[Angle mod 360].S
  else
    Result := SCA[360 - (-Angle mod 360)].S;
end;


initialization
  Gdi32Lib := LoadLibrary(gdi32);
  @UpdateLayeredWindow := nil;
  if Gdi32Lib <> 0 then begin
    SetLayout := GetProcAddress(Gdi32Lib, 'SetLayout');
    GetLayout := GetProcAddress(Gdi32Lib, 'GetLayout');
  end
  else begin
    @SetLayout := nil;
    @GetLayout := nil;
  end;

  if not Assigned(UpdateLayeredWindow) then begin
    User32Lib := LoadLibrary(user32);
    if User32Lib <> 0 then begin
      UpdateLayeredWindow := GetProcAddress(User32Lib, 'UpdateLayeredWindow');
      SetLayeredWindowAttributes := GetProcAddress(User32Lib, 'SetLayeredWindowAttributes');
    end
    else begin
      @UpdateLayeredWindow := nil;
      @SetLayeredWindowAttributes := nil;
    end;
  end;
  GetCheckSize;


finalization
  if Gdi32Lib <> 0 then
    FreeLibrary(Gdi32Lib);

  if User32Lib <> 0 then
    FreeLibrary(User32Lib);

end.



