
{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           Express Cross Platform Library graphics classes          }
{                                                                    }
{           Copyright (c) 2000-2007 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSCROSSPLATFORMLIBRARY AND ALL   }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit cxGraphics;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
{$IFDEF VCL}
  Windows,
{$ELSE}
  Qt,
{$ENDIF}
{$IFDEF CLR}
  System.Runtime.InteropServices,
{$ENDIF}
  Classes, SysUtils, Controls, Graphics, CommCtrl, ImgList, cxClasses;

const
  cxAlignLeft = 1;
  cxAlignRight = 2;
  cxAlignHCenter = 4;
  cxAlignTop = 8;
  cxAlignBottom = 16;
  cxAlignVCenter = 32;
  cxAlignCenter = 36;
  cxSingleLine = 64;
  cxDontClip = 128;
  cxExpandTabs = 256;
  cxShowPrefix = 512;
  cxWordBreak = 1024;
  cxShowEndEllipsis = 2048;
  cxDontPrint = 4096;
  cxShowPathEllipsis = 8192;
  cxDontBreakChars = 16384;

{$IFNDEF DELPHI6}
  clMoneyGreen = TColor($C0DCC0);
  clSkyBlue = TColor($F0CAA6);
  clCream = TColor($F0FBFF);
  clMedGray = TColor($A4A0A0);
{$ENDIF}
  clcxLightGray = $CFCFCF;

  cxEmptyRect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);

  cxDesignSelectionWidth = 2;

  cxDefaultAlphaValue = 200;

{$IFNDEF CLR}
  cxHalfToneBrush: TBrush = nil;
{$ENDIF}

type
  IcxFontListener = interface
    ['{B144DD7E-0B27-439A-B908-FC3ACFE6A2D3}']
    procedure Changed(Sender: TObject; AFont: TFont);
  end;

  TcxBorder = (bLeft, bTop, bRight, bBottom);
  TcxBorders = set of TcxBorder;

const
  cxBordersAll = [bLeft, bTop, bRight, bBottom];

type
  TBrushHandle = {$IFDEF VCL}HBRUSH{$ELSE}QBrushH{$ENDIF};

  TPointArray = array of TPoint;
  TRectArray = array of TRect;

  TcxColorPart = -100..100;

  TcxGridLines = (glBoth, glNone, glVertical, glHorizontal);

  PcxViewParams = ^TcxViewParams;
  TcxViewParams = record
    Bitmap: TBitmap;
    Color: TColor;
    Font: TFont;
    TextColor: TColor;
  end;

  { TcxRegion }

  TcxRegionHandle = {$IFDEF VCL}HRGN{$ELSE}QRegionH{$ENDIF};
  TcxRegionOperation = (roSet, roAdd, roSubtract, roIntersect);

  TcxRegion = class  {6}
  private
    FHandle: TcxRegionHandle;
    function GetIsEmpty: Boolean;
  protected
    procedure DestroyHandle;
  public
    constructor Create(AHandle: TcxRegionHandle); overload;
    constructor Create(const ABounds: TRect); overload;
    constructor Create; overload;
    constructor Create(ALeft, ATop, ARight, ABottom: Integer); overload;
    destructor Destroy; override;

    procedure Combine(ARegion: TcxRegion; AOperation: TcxRegionOperation;
      ADestroyRegion: Boolean = True);
    function IsEqual(ARegion: TcxRegion): Boolean; overload;
    function IsEqual(ARegionHandle: TcxRegionHandle): Boolean; overload;
    procedure Offset(DX, DY: Integer);
    function PtInRegion(const Pt: TPoint): Boolean; overload;
    function PtInRegion(X, Y: Integer): Boolean; overload;
    function RectInRegion(const R: TRect): Boolean; overload;
    function RectInRegion(ALeft, ATop, ARight, ABottom: Integer): Boolean; overload;
    
    property Handle: TcxRegionHandle read FHandle write FHandle;
    property IsEmpty: Boolean read GetIsEmpty;
  end;

  { TcxCanvas }     

  TcxRotationAngle = (ra0, raPlus90, raMinus90{$IFDEF VCL}, ra180{$ENDIF});
  TcxCanvasState = record
    Font: TFont;
    Brush: TBrush;
    Pen: TPen;
  end;
  TcxCanvasStates = array of TcxCanvasState;

  TcxCanvas = class
  private
    FCanvas: TCanvas;
    FSavedDCs: TList;
    FSavedRegions: TList;
    FSavedStates: TcxCanvasStates;

    function GetBrush: TBrush;
    function GetCopyMode: TCopyMode;
    function GetDCOrigin: TPoint;
    function GetFont: TFont;
    function GetHandle: {$IFDEF VCL}HDC{$ELSE}QPainterH{$ENDIF};
    function GetPen: TPen;
    function GetViewportOrg: TPoint;
    function GetWindowOrg: TPoint;
    procedure SetBrush(Value: TBrush);
    procedure SetCopyMode(Value: TCopyMode);
    procedure SetFont(Value: TFont);
    procedure SetPen(Value: TPen);
    procedure SetPixel(X, Y: Integer; Value: TColor);
    procedure SetViewportOrg(const P: TPoint);
    procedure SetWindowOrg(const P: TPoint);
  protected
    procedure SynchronizeObjects(ADC: THandle);
  public
    constructor Create(ACanvas: TCanvas); virtual;
    destructor Destroy; override;

    procedure AlignMultiLineTextRectVertically(var R: TRect; const AText: string;
      AAlignmentVert: TcxAlignmentVert; AWordBreak, AShowPrefix: Boolean;
      AEnabled: Boolean = True; ADontBreakChars: Boolean = False);
    procedure CopyRect(const Dest: TRect; ACanvas: TCanvas; const Source: TRect);
    procedure Draw(X, Y: Integer; Graphic: TGraphic);
    procedure DrawComplexFrame(const R: TRect; ALeftTopColor, ARightBottomColor: TColor;
      ABorders: TcxBorders = [bLeft, bTop, bRight, bBottom]; ABorderWidth: Integer = 1);
    procedure DrawEdge(const R: TRect; ASunken, AOuter: Boolean;
      ABorders: TcxBorders = [bLeft, bTop, bRight, bBottom]);
    procedure DrawFocusRect(const R: TRect);
    procedure DrawGlyph(X, Y: Integer; AGlyph: TBitmap; AEnabled: Boolean = True;
      ABackgroundColor: TColor = clNone{; ATempCanvas: TCanvas = nil});
    procedure DrawImage(Images: TCustomImageList; X, Y, Index: Integer;
      Enabled: Boolean = True);
    procedure DrawTexT(const Text: string; R: TRect; Flags: Integer;
      Enabled: Boolean = True);
    procedure FillRect(const R: TRect; AColor: TColor); overload;
    procedure FillRect(const R: TRect; ABitmap: TBitmap = nil;
      AExcludeRect: Boolean = False); overload;
    procedure FillRect(R: TRect; const AParams: TcxViewParams;
      ABorders: TcxBorders = []; ABorderColor: TColor = clDefault;
      ALineWidth: Integer = 1; AExcludeRect: Boolean = False); overload;
  {$IFDEF LINUX}
    procedure FillRect(const R: TRect; ABrush: TBrush); overload;
  {$ELSE}
    procedure DrawDesignSelection(ARect: TRect; AWidth: Integer = cxDesignSelectionWidth);
    procedure DrawRegion(ARegion: TcxRegion; AContentColor: TColor = clDefault;
      ABorderColor: TColor = clDefault; ABorderWidth: Integer = 1; ABorderHeight: Integer = 1); overload;
    procedure DrawRegion(ARegion: TcxRegionHandle; AContentColor: TColor = clDefault;
      ABorderColor: TColor = clDefault; ABorderWidth: Integer = 1; ABorderHeight: Integer = 1); overload;
    procedure FillRegion(ARegion: TcxRegion; AColor: TColor = clDefault); overload;
    procedure FillRegion(ARegion: TcxRegionHandle; AColor: TColor = clDefault); overload;
    procedure FlipHorizontally(ABitmap: TBitmap);
    procedure FrameRegion(ARegion: TcxRegion; AColor: TColor = clDefault;
      ABorderWidth: Integer = 1; ABorderHeight: Integer = 1); overload;
    procedure FrameRegion(ARegion: TcxRegionHandle; AColor: TColor = clDefault;
      ABorderWidth: Integer = 1; ABorderHeight: Integer = 1); overload;
    procedure Pie(const R: TRect; const ARadial1, ARadial2: TPoint); overload;
    procedure Pie(const R: TRect; AStartAngle, ASweepAngle: Integer); overload;
  {$ENDIF}
    function FontHeight(AFont: TFont): Integer;
    procedure FrameRect(const R: TRect; Color: TColor = clDefault;
      ALineWidth: Integer = 1; ABorders: TcxBorders = cxBordersAll;
      AExcludeFrame: Boolean = False);
    procedure InvertFrame(const R: TRect; ABorderSize: Integer);
    procedure InvertRect({$IFNDEF LINUX}const {$ENDIF}R: TRect);
    procedure LineTo(X, Y: Integer);
    procedure MoveTo(X, Y: Integer);
    procedure Polygon(const Points: array of TPoint);
    procedure Polyline(const Points: array of TPoint);
    procedure RotateBitmap(ABitmap: TBitmap; ARotationAngle: TcxRotationAngle;
      AFlipVertically: Boolean = False);
    function TextExtent(const Text: string): TSize; overload;
    procedure TextExtent(const Text: string; var R: TRect; Flags: Integer); overload;
    function TextHeight(const Text: string): Integer;
    function TextWidth(const Text: string): Integer;
    procedure TransparentDraw(X, Y: Integer; ABitmap: TBitmap; AAlpha: Byte;
      ABackground: TBitmap = nil);

    procedure RestoreDC;
    procedure SaveDC;
    procedure RestoreClipRegion;
    procedure SaveClipRegion;
    procedure RestoreState;
    procedure SaveState;

    procedure GetParams(var AParams: TcxViewParams);
    procedure SetParams(AParams: TcxViewParams);
    procedure SetBrushColor(Value: TColor);
    procedure SetFontAngle(Value: Integer);

  {$IFDEF VCL}
    procedure GetTextStringsBounds(Text: string; R: TRect; Flags: Integer;
      Enabled: Boolean; var ABounds: TRectArray);
  {$ENDIF}

  {$IFNDEF LINUX}
    procedure BeginPath;
    procedure EndPath;
    function PathToRegion: TcxRegion;
    procedure WidenPath;
  {$ENDIF}

    // clipping
    procedure ExcludeClipRect(const R: TRect);
    procedure IntersectClipRect(const R: TRect);
    function GetClipRegion(AConsiderOrigin: Boolean = True): TcxRegion;
    procedure SetClipRegion(ARegion: TcxRegion; AOperation: TcxRegionOperation;
      ADestroyRegion: Boolean = True; AConsiderOrigin: Boolean = True);
    function RectFullyVisible(const R: TRect): Boolean;
    function RectVisible({$IFDEF VCL}const {$ENDIF}R: TRect): Boolean;

    property Brush: TBrush read GetBrush write SetBrush;
    property Canvas: TCanvas read FCanvas write FCanvas;
    property CopyMode: TCopyMode read GetCopyMode write SetCopyMode;
    property DCOrigin: TPoint read GetDCOrigin;
    property Font: TFont read GetFont write SetFont;
    property Handle: {$IFDEF VCL}HDC{$ELSE}QPainterH{$ENDIF} read GetHandle;
    property Pen: TPen read GetPen write SetPen;
    property Pixels[X, Y: Integer]: TColor write SetPixel;
    property ViewportOrg: TPoint read GetViewportOrg write SetViewportOrg;
    property WindowOrg: TPoint read GetWindowOrg write SetWindowOrg;
  end;

  { TcxScreenCanvas }

  TcxScreenCanvas = class(TcxCanvas)
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
  end;

  { TcxBitmap }

  TRGBColors = array of TRGBQuad;
  TcxImageDrawMode = (idmNormal, idmDisabled, idmFaded, idmGrayScale, idmDingy, idmShadowed);
  TcxBitmapTransformationMode = (btmDingy, btmDirty, btmGrayScale, btmSetOpaque, btmMakeMask, btmFade, btmDisable, btmCorrectBlend, btmHatch, btmClear);
  TcxBitmapTransformationProc = procedure(var AColor: TRGBQuad) of object;
  TcxDrawImageProc = function (ACanvas: TCanvas; AImages: TCustomImageList; AImageIndex: Integer; AGlyph: TBitmap; ARect: TRect; ADrawMode: TcxImageDrawMode): Boolean;

  TcxColorTransitionMap = record
    RedScale: Single;
    GreenScale: Single;
    BlueScale: Single;
    SrcAlpha: Byte;
    SrcConstantAlpha: Byte;
  end;

  TcxHatchData = record
    Color1: TRGBQuad;
    Alpha1: Byte;
    Color2: TRGBQuad;
    Alpha2: Byte;
    Step: Byte;
  end;

  TcxColorList = class(TList)
  public
    function Add(AColor: TColor): Integer;
  end;

  TcxBitmap = class(TBitmap)
  private
    FBitmapInfo: TBitmapInfo;
    FDC: HDC;
    FTransparentBkColor: TRGBQuad;
    FTransparentPixels: TcxColorList;

    FCurrentColorIndex: TPoint;
    FHatchData: TcxHatchData;

    FLockCount: Integer;
    FModified: Boolean;

    function GetClientRect: TRect;
    function GetIsAlphaUsed: Boolean;

    procedure CorrectBlend(var AColor: TRGBQuad);
    procedure ClearColor(var AColor: TRGBQuad);
    procedure Dingy(var AColor: TRGBQuad);
    procedure Dirty(var AColor: TRGBQuad);
    procedure Disable(var AColor: TRGBQuad);
    procedure Fade(var AColor: TRGBQuad);
    procedure GrayScale(var AColor: TRGBQuad);
    procedure Hatch(var AColor: TRGBQuad);
    procedure MakeMask(var AColor: TRGBQuad);
    procedure SetOpaque(var AColor: TRGBQuad);

    procedure Scale(var AColor: TRGBQuad; const AColorMap: TcxColorTransitionMap);

    procedure UpdateBitmapInfo;

    function IsColorTransparent(const AColor: TRGBQuad): Boolean;
  protected
    procedure Changed(Sender: TObject); override;
    function ChangeLocked: Boolean;

    property HatchData: TcxHatchData read FHatchData write FHatchData;
    property TransparentBkColor: TRGBQuad read FTransparentBkColor write FTransparentBkColor;
    property TransparentPixels: TcxColorList read FTransparentPixels;
  public
    constructor Create; override;
    constructor CreateSize(ARect: TRect); overload;
    constructor CreateSize(AWidth, AHeight: Integer); overload;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure EndUpdate(AForceUpdate: Boolean = True);

    procedure GetBitmapColors(out AColors: TRGBColors);
    procedure SetBitmapColors(const AColors: TRGBColors);

    procedure AlphaBlend(ABitmap: TcxBitmap; const ARect: TRect; ASmoothImage: Boolean; AConstantAlpha: Byte = $FF);
    procedure Clear;
    procedure CopyBitmap(ABitmap: TBitmap; ACopyMode: DWORD = SRCCOPY);
    procedure DrawHatch(const AHatchData: TcxHatchData); overload;
    procedure DrawHatch(AColor1, AColor2: TColor; AStep: Byte; AAlpha1: Byte = $FF; AAlpha2: Byte = $FF); overload;
    procedure DrawShadow(AMaskBitmap: TcxBitmap; AShadowSize: Integer; AShadowColor: TColor = clBtnShadow);
    procedure Filter(AMaskBitmap: TcxBitmap);
    procedure Invert;
    procedure RecoverAlphaChannel(ATransparentColor: TColor);
    procedure Shade(AMaskBitmap: TcxBitmap);

    procedure TransformBitmap(AMode: TcxBitmapTransformationMode);

    property ClientRect: TRect read GetClientRect;
    property IsAlphaUsed: Boolean read GetIsAlphaUsed;
  end;

  TcxImageList = class(TDragImageList)
  private
    FAlphaBlending: Boolean;
    FLockCount: Integer;
    function GetImageHandle(AImage: TBitmap): Integer;
    class function GetPixelFormat(AHandle: HIMAGELIST): Integer;
  protected
    function ChangeLocked: Boolean;
    procedure Change; override;
    procedure DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer;
      Style: Cardinal; Enabled: Boolean = True); override;
    procedure DoDrawEx(AIndex: Integer; ACanvas: TCanvas;
      const ARect: TRect; AStyle: Cardinal; AStretch, ASmoothResize, AEnabled: Boolean);
    procedure Initialize; override;
  public
    function Add(AImage, AMask: TBitmap): Integer;
    procedure AddImages(AImageList: TCustomImageList);
    function AddMasked(AImage: TBitmap; AMaskColor: TColor): Integer;
    procedure Assign(Source: TPersistent); override;
    procedure CopyImages(AImageList: TCustomImageList; AStartIndex: Integer = 0; AEndIndex: Integer = -1);
    procedure Insert(AIndex: Integer; AImage, AMask: TBitmap);
    procedure InsertMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor);
    procedure Move(ACurIndex, ANewIndex: Integer);
    function Replace(AIndex: Integer; AImage, AMask: TBitmap): Boolean;
    procedure ReplaceMasked(AIndex: Integer; ANewImage: TBitmap; AMaskColor: TColor);

    procedure BeginUpdate;
    procedure EndUpdate(AForceUpdate: Boolean = True);

  {$IFNDEF DELPHI6}
    procedure Draw(ACanvas: TCanvas; X, Y, AIndex: Integer;
      ADrawingStyle: TDrawingStyle; AImageType: TImageType;
      AEnabled: Boolean = True); overload;
  {$ENDIF}
    procedure Draw(ACanvas: TCanvas; const ARect: TRect; AIndex: Integer;
      AStretch: Boolean = True; ASmoothResize: Boolean = False; AEnabled: Boolean = True); overload;

    procedure GetImageInfo(AIndex: Integer; AImage, AMask: TBitmap); overload;
    procedure GetImage(AIndex: Integer; AImage: TBitmap);
    procedure GetMask(AIndex: Integer; AMask: TBitmap);

    class procedure GetImageInfo(AHandle: HIMAGELIST; AIndex: Integer; AImage, AMask: TBitmap); overload;
    property AlphaBlending: Boolean read FAlphaBlending write FAlphaBlending;
  published
    property BlendColor;
    property BkColor;
    property DrawingStyle;
    property Height;
    property ImageType;
    property ShareImages;
    property Width;
    property OnChange;
  end;

{$IFNDEF CLR}

  { TcxBrushCache }

  TcxBrushData = record
    Brush: TBrush;
    Color: TColor;
    RefCount: Integer;
  end;

  TcxBrushesData = array of TcxBrushData;

  EBrushCache = class(Exception);

  TcxBrushCache = class
  private
    FCapacity: Integer;
    FCount: Integer;
    FData: TcxBrushesData;
    FDeletedCount: Integer;
    FLockRef: Integer;
  protected
    function Add(AColor: TColor): TBrush;
    function AddItemAt(AIndex: Integer; AColor: TColor): TBrush;
    procedure CacheCheck(Value: Boolean; const AMessage: string);
    procedure Delete(AIndex: Integer);
    function IndexOf(AColor: TColor; out AIndex: Integer): Boolean;
    procedure InitItem(var AItem: TcxBrushData; AColor: TColor);
    function IsSystemBrush(ABrush: TBrush): Boolean;
    function FindNearestItem(AColor: TColor): Integer;
    procedure Move(ASrc, ADst, ACount: Integer);
    procedure Pack;
    procedure Recreate;
    procedure Release(AIndex: Integer);
  public
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure ReleaseBrush(var ABrush: TBrush);
    procedure SetBrushColor(var ABrush: TBrush; AColor: TColor);
  end;

{$ENDIF}

const
  DisableMap: TcxColorTransitionMap = (RedScale: 0.0729; GreenScale: 0.7146; BlueScale: 0.2125; SrcAlpha: 105; SrcConstantAlpha: 151);
  FadeMap: TcxColorTransitionMap = (RedScale: 0.299; GreenScale: 0.587; BlueScale: 0.114; SrcAlpha: 192; SrcConstantAlpha: 64);
  GrayMap: TcxColorTransitionMap = (RedScale: 0.299; GreenScale: 0.587; BlueScale: 0.114; SrcAlpha: $FF; SrcConstantAlpha: $FF);

var
  CustomDrawImageProc: TcxDrawImageProc = nil;

function cxFlagsToDTFlags(Flags: Integer): Integer;

procedure ExtendRect(var Rect: TRect; const AExtension: TRect);
function IsGlyphAssigned(AGlyph: TBitmap): Boolean;
function IsImageAssigned(AImageList: TCustomImageList; AImageIndex: Integer): Boolean;

function GetRealColor(AColor: TColor): TColor;

// light colors
function GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: TcxColorPart): TColor;
function GetLightBtnFaceColor: TColor;
function GetLightDownedColor: TColor;
function GetLightDownedSelColor: TColor;
function GetLightSelColor: TColor;

function GetBitmapBits(ABitmap: TBitmap; ATopDownDIB: Boolean): TRGBColors;
procedure SetBitmapBits(ABitmap: TBitmap; var AColors: TRGBColors;
  ATopDownDIB: Boolean);

procedure cxAlphaBlend(ADestBitmap, ASrcBitmap: TBitmap; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
procedure cxAlphaBlend(ADestDC: HDC; ASrcBitmap: TBitmap; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
procedure cxAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
procedure cxBitBlt(ADestDC, ASrcDC: HDC; const ADestRect: TRect; const ASrcTopLeft: TPoint; ROP: DWORD);
procedure cxBlendFunction(const ASource: TRGBQuad; var ADest: TRGBQuad; ASourceConstantAlpha: Byte);
function cxColorToRGBQuad(AColor: TColor; AReserved: Byte = 0): TRGBQuad;
function cxCreateBitmap(const ASize: TSize; AFormat: TPixelFormat = pf24bit): TBitmap; overload;
function cxCreateBitmap(const ARect: TRect; AFormat: TPixelFormat = pf24bit): TBitmap; overload;
function cxCreateBitmap(AWidth, AHeight: Integer; AFormat: TPixelFormat = pf24bit): TBitmap; overload;
function cxCreateTrueColorBitmap(const ASize: TSize): TBitmap; overload;
function cxCreateTrueColorBitmap(AWidth, AHeight: Integer): TBitmap; overload;
function cxCreateTrueColorBitmapHandle(AWidth, AHeight: Integer; ABPP: Integer = 32): HBitmap;
procedure cxDrawImage(ADC: THandle; AGlyphRect, ABackgroundRect: TRect; AGlyph: TBitmap;
  AImages: TCustomImageList; AImageIndex: Integer; ADrawMode: TcxImageDrawMode;
  ASmoothImage: Boolean = False; ABrush: THandle = 0;
  ATransparentColor: TColor = clNone; AUseLeftBottomPixelAsTransparent: Boolean = True);
procedure cxDrawImageList(AImageListHandle: HIMAGELIST; AImageIndex: Integer;
  ADC: HDC; APoint: TPoint; ADrawingStyle: TDrawingStyle; AImageType: TImageType);
procedure cxDrawHatch(ADC: HDC; const ARect: TRect; AColor1, AColor2: TColor; AStep: Byte; AAlpha1: Byte = $FF; AAlpha2: Byte = $FF);
procedure cxSmoothResizeBitmap(ASource, ADestination: TBitmap; AForceUseLanczos3Filter: Boolean = False);

{!!! TODO: adapt to .net}
{$IFNDEF CLR}
// mouse cursor size
function cxGetCursorSize: TSize;

// image helper routines
procedure cxAlphaBlend(ASource: TBitmap; ARect: TRect; const ASelColor: TColor; Alpha: Byte = 170); overload;
procedure cxAlphaBlend(ADest, ABkSource, ASource: TBitmap; Alpha: Byte = cxDefaultAlphaValue); overload;
procedure cxApplyViewParams(ACanvas: TcxCanvas; const AViewParams: TcxViewParams);
procedure cxCopyImage(ASource, ADest: TBitmap; const ASrcOffset, ADstOffset: TPoint; const ARect: TRect); overload;
procedure cxCopyImage(ASource, ADest: TCanvas; const ASrcOffset, ADstOffset: TPoint; const ARect: TRect); overload;
procedure cxDrawArrows(ACanvas: TCanvas; const ARect: TRect;
  ASide: TcxBorder; AColor: TColor; APenColor: TColor = clDefault);
procedure cxFillHalfToneRect(Canvas: TCanvas; const ARect: TRect; ABkColor, AColor: TColor);
procedure cxSetCanvasOrg(ACanvas: TCanvas; var AOrg: TRect);
function cxTextHeight(AFont: TFont; const S: string = 'Wg'; AFontSize: Integer = 0): Integer;
function cxTextExtent(AFont: TFont; const S: string; AFontSize: Integer = 0): TSize;
function cxTextWidth(AFont: TFont; const S: string; AFontSize: Integer = 0): Integer;
{$ENDIF}

function cxDrawText(ADC: THandle; const AText: string; var ARect: TRect;
  AFormat: UINT; ACharCount: Integer = - 1): Integer;
function cxExtTextOut(ADC: THandle; const AText: string; const APoint: TPoint;
  const ARect: TRect; AOptions: UINT; ACharCount: Integer = -1): Boolean; overload;
function cxExtTextOut(ADC: THandle; const AText: string; const APoint: TPoint;
  AOptions: UINT; ACharCount: Integer = -1): Boolean; overload;
procedure cxInvalidateRect(AHandle: THandle; const ARect: TRect; AEraseBackground: Boolean = True); overload;
procedure cxInvalidateRect(AHandle: THandle; AEraseBackground: Boolean = True); overload;
function cxTextSize(ADC: THandle; const AText: string): TSize;
function cxGetTextRect(ADC: THandle; const AText: string; ARowCount: Integer;
  AReturnMaxRectHeight: Boolean = False): TRect; overload;
function cxGetTextRect(AFont: TFont; const AText: string; ARowCount: Integer): TRect; overload;

function cxGetBitmapData(ABitmapHandle: HBITMAP; out ABitmapData: Windows.TBitmap): Boolean;
function cxGetBrushData(ABrushHandle: HBRUSH; out ALogBrush: TLogBrush): Boolean; overload;
function cxGetBrushData(ABrushHandle: HBRUSH): TLogBrush; overload;
function cxGetFontData(AFontHandle: HFONT; out ALogFont: TLogFont): Boolean;
function cxGetPenData(APenHandle: HPEN; out ALogPen: TLogPen): Boolean;

function cxGetWritingDirection(AFontCharset: TFontCharset; const AText: string): TCanvasOrientation;
procedure cxDrawThemeParentBackground(AControl: TWinControl; ACanvas: TcxCanvas; const ARect: TRect); overload;
procedure cxDrawThemeParentBackground(AControl: TWinControl; ACanvas: TCanvas; const ARect: TRect); overload;
procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TcxCanvas; ARect: TRect; APaintParentWithChildren: Boolean = True); overload;
procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TCanvas; const ARect: TRect; APaintParentWithChildren: Boolean = True); overload;
function cxScreenCanvas: TcxScreenCanvas;

{$IFDEF CLR}
[DllImport(gdi32, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'GetDIBits')]
function GetDIBits(DC: HDC; Bitmap: HBitmap; StartScan, NumScans: UINT;
  [out] Bits: TRGBColors; var BitsInfo: TBitmapInfo; Usage: UINT): Integer; external;

[DllImport(gdi32, CharSet = CharSet.Ansi, SetLastError = True, EntryPoint = 'SetDIBits')]
function SetDIBits(DC: HDC; Bitmap: HBITMAP; StartScan, NumScans: UINT;
  [in] Bits: TRGBColors; const BitsInfo: TBitmapInfo; Usage: UINT): Integer; external;

{$IFNDEF DELPHI9}
[DllImport(gdi32, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetObject')]
function GetObject(Handle: HGDIOBJ; cbBuffer: Integer; out lpvObject: TLogBrush): Integer; external; overload;

[DllImport(gdi32, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetObject')]
function GetObject(Handle: HGDIOBJ; cbBuffer: Integer; out lpvObject: TLogPen): Integer; external; overload;
{$ENDIF}
{$ENDIF}

implementation

uses
  Messages, Math, Menus, cxControls, cxGeometry, dxUxTheme;

type
  TCanvasAccess = class(TCanvas);

  TContributor = record
    Pixel: Integer;
    Weight: Integer;
  end;
  TContributorArray = array of TContributor;

  TContributors = record
    Count: Integer;
    Contributors: TContributorArray;
  end;
  TContributorList = array of TContributors;

const
{!!! TODO: adapt to .net}
{$IFNDEF CLR}
  BaseRgns: array[0..3, 0..6, 0..1] of Integer =
  (((0, -1), (-5, -6),(-2, -6), (-2, -9), (2, -9), (2, -6), (5, -6)),
   ((0, 0), (5, 5), (2, 5), (2, 8), (-2, 8), (-2, 5), (-5, 5)),
   ((-1, 0), (-6, -5), (-6, -2), (-9, -2), (-9, 2), (-6, 2), (-6, 5)),
   ((0, 0), (5, 5), (5, 2), (8, 2), (8, -2), (5, -2), (5, -5)));
{$ENDIF}
  DefaultBlendFunction: TBlendFunction =
   (BlendOp: AC_SRC_OVER;
    BlendFlags: 0;
    SourceConstantAlpha: cxDefaultAlphaValue;
    AlphaFormat: $0);

var
  VCLAlphaBlend: {$IFNDEF CLR}function(DC: LongWord; p2, p3, p4, p5: Integer; DC6: LongWord;
    p7, p8, p9, p10: Integer; p11: TBlendFunction): BOOL; stdcall;{$ELSE}FARPROC;{$ENDIF}
  ScreenCanvas: TcxScreenCanvas = nil;
  DrawBitmap, ImageBitmap, MaskBitmap: TcxBitmap;

procedure cxBitmapInit(var ABitmap: TcxBitmap; AWidth, AHeight: Integer);
begin
  if ABitmap = nil then
    ABitmap := TcxBitmap.CreateSize(AWidth, AHeight)
  else
  begin
    ABitmap.TransparentPixels.Clear;
    ABitmap.Width := AWidth;
    ABitmap.Height := AHeight;
  end;
end;

function GetDrawBitmap(AWidth, AHeight: Integer): TcxBitmap;
begin
  cxBitmapInit(DrawBitmap, AWidth, AHeight);
  Result := DrawBitmap;
end;

function GetImageBitmap(AWidth, AHeight: Integer): TcxBitmap;
begin
  cxBitmapInit(ImageBitmap, AWidth, AHeight);
  Result := ImageBitmap;
end;

function GetMaskBitmap(AWidth, AHeight: Integer): TcxBitmap;
begin
  cxBitmapInit(MaskBitmap, AWidth, AHeight);
  Result := MaskBitmap;
end;

function cxFlagsToDTFlags(Flags: Integer): Integer;
begin
  Result := DT_NOPREFIX;
  if cxAlignLeft and Flags <> 0 then
    Result := Result or DT_LEFT;
  if cxAlignRight and Flags <> 0 then
    Result := Result or DT_RIGHT;
  if cxAlignHCenter and Flags <> 0 then
    Result := Result or DT_CENTER;
  if cxAlignTop and Flags <> 0 then
    Result := Result or DT_TOP;
  if cxAlignBottom and Flags <> 0 then
    Result := Result or DT_BOTTOM;
  if cxAlignVCenter and Flags <> 0 then
    Result := Result or DT_VCENTER;
  if cxSingleLine and Flags <> 0 then
    Result := Result or DT_SINGLELINE;
  if cxDontClip and Flags <> 0 then
    Result := Result or DT_NOCLIP;
  if cxExpandTabs and Flags <> 0 then
    Result := Result or DT_EXPANDTABS;
  if cxShowPrefix and Flags <> 0 then
    Result := Result and not DT_NOPREFIX;
  if cxWordBreak and Flags <> 0 then
  begin
    Result := Result or DT_WORDBREAK;
    if cxDontBreakChars and Flags = 0 then
      Result := Result or DT_EDITCONTROL;
  end;
  if cxShowEndEllipsis and Flags <> 0 then
    Result := Result or DT_END_ELLIPSIS;
  if cxDontPrint and Flags <> 0 then
    Result := Result or DT_CALCRECT;
  if cxShowPathEllipsis and Flags <> 0 then
    Result := Result or DT_PATH_ELLIPSIS;
end;

procedure ExtendRect(var Rect: TRect; const AExtension: TRect);
begin
  with AExtension do
  begin
    Inc(Rect.Left, Left);
    Inc(Rect.Top, Top);
    Dec(Rect.Right, Right);
    Dec(Rect.Bottom, Bottom);
  end;
end;

function IsGlyphAssigned(AGlyph: TBitmap): Boolean;
begin
  Result := (AGlyph <> nil) and not AGlyph.Empty;
end;

function IsImageAssigned(AImageList: TCustomImageList; AImageIndex: Integer): Boolean;
begin
  Result := (AImageList <> nil) and (0 <= AImageIndex) and (AImageIndex < AImageList.Count);
end;

function GetRealColor(AColor: TColor): TColor;
{$IFDEF VCL}
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetNearestColor(DC, AColor);
  ReleaseDC(0, DC);
end;
{$ELSE}
begin
  Result := AColor;
end;
{$ENDIF}

function GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: TcxColorPart): TColor;
var
  ABtnFaceColor, AHighlightColor, AWindowColor: TColor;

  function GetLightIndex(ABtnFaceValue, AHighlightValue, AWindowValue: Byte): Integer;
  begin
    Result :=
      MulDiv(ABtnFaceValue, ABtnFaceColorPart, 100) +
      MulDiv(AHighlightValue, AHighlightColorPart, 100) +
      MulDiv(AWindowValue, AWindowColorPart, 100);
    if Result < 0 then Result := 0;
    if Result > 255 then Result := 255;
  end;

begin
  ABtnFaceColor := ColorToRGB(clBtnFace);
  AHighlightColor := ColorToRGB(clHighlight);
  AWindowColor := ColorToRGB(clWindow);
  if (ABtnFaceColor = 0) or (ABtnFaceColor = $FFFFFF) then
    Result := AHighlightColor
  else
    Result := RGB(
      GetLightIndex(GetRValue(ABtnFaceColor), GetRValue(AHighlightColor), GetRValue(AWindowColor)),
      GetLightIndex(GetGValue(ABtnFaceColor), GetGValue(AHighlightColor), GetGValue(AWindowColor)),
      GetLightIndex(GetBValue(ABtnFaceColor), GetBValue(AHighlightColor), GetBValue(AWindowColor)));
end;

function GetLightBtnFaceColor: TColor;

  function GetLightValue(Value: Byte): Byte;
  begin
    Result := Value + MulDiv(255 - Value, 16, 100);
  end;

begin
  Result := ColorToRGB(clBtnFace);
  Result := RGB(
    GetLightValue(GetRValue(Result)),
    GetLightValue(GetGValue(Result)),
    GetLightValue(GetBValue(Result)));
  Result := GetRealColor(Result);
end;

function GetLightDownedColor: TColor;
begin
  Result := GetRealColor(GetLightColor(11, 9, 73));
end;

function GetLightDownedSelColor: TColor;
begin
  Result := GetRealColor(GetLightColor(14, 44, 40));
end;

function GetLightSelColor: TColor;
begin
  Result := GetRealColor(GetLightColor(-2, 30, 72));
end;

procedure FillBitmapInfoHeader(out AHeader: TBitmapInfoHeader; AWidth, AHeight: Integer;
  ATopDownDIB: Boolean); overload;
begin
  AHeader.biSize := SizeOf(TBitmapInfoHeader);
  AHeader.biWidth := AWidth;
  if ATopDownDIB then
    AHeader.biHeight := -AHeight
  else
    AHeader.biHeight := AHeight;
  AHeader.biPlanes := 1;
  AHeader.biBitCount := 32;
  AHeader.biCompression := BI_RGB;
end;

procedure FillBitmapInfoHeader(out AHeader: TBitmapInfoHeader; ABitmap: TBitmap;
  ATopDownDIB: Boolean); overload;
begin
  FillBitmapInfoHeader(AHeader, ABitmap.Width, ABitmap.Height, ATopDownDIB);
end;

function GetBitmapBits(ABitmap: TBitmap; ATopDownDIB: Boolean): TRGBColors;
var
  AInfo: TBitmapInfo;
begin
  SetLength(Result, ABitmap.Width * ABitmap.Height);
  FillBitmapInfoHeader(AInfo.bmiHeader, ABitmap, ATopDownDIB);
//  GetDIBits(ABitmap.Canvas.Handle, ABitmap.Handle, 0, ABitmap.Height, nil, AInfo,
//    DIB_RGB_COLORS);
  GetDIBits(cxScreenCanvas.Handle, ABitmap.Handle, 0, ABitmap.Height, Result,
    AInfo, DIB_RGB_COLORS);
end;

procedure SetBitmapBits(ABitmap: TBitmap; var AColors: TRGBColors;
  ATopDownDIB: Boolean);
var
  AInfo: TBitmapInfo;
begin
  FillBitmapInfoHeader(AInfo.bmiHeader, ABitmap, ATopDownDIB);
  SetDIBits(cxScreenCanvas.Handle, ABitmap.Handle, 0, ABitmap.Height,
    AColors, AInfo, DIB_RGB_COLORS);
  AColors := nil;
end;

procedure SystemAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; AConstantAlpha: Byte = $FF);
{$IFNDEF DELPHI6}
const
  AC_SRC_ALPHA = 1;
{$ENDIF}
var
  ABlendFunction: TBlendFunction;
begin
  ABlendFunction.BlendOp := AC_SRC_OVER;
  ABlendFunction.BlendFlags := 0;
  ABlendFunction.SourceConstantAlpha := AConstantAlpha;
  ABlendFunction.AlphaFormat := AC_SRC_ALPHA;
  {$IFDEF CLR}AlphaBlend{$ELSE}VCLAlphaBlend{$ENDIF}(
    ADestDC, ADestRect.Left, ADestRect.Top, cxRectWidth(ADestRect), cxRectHeight(ADestRect),
    ASrcDC, ASrcRect.Left, ASrcRect.Top, cxRectWidth(ASrcRect), cxRectHeight(ASrcRect), ABlendFunction);
end;

procedure CommonAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean; AConstantAlpha: Byte = $FF);

  function CreateDirectBitmap(ASrcDC: HDC; const ASrcRect: TRect): TBitmap;
  var
    ARect: TRect;
  begin
    ARect := Rect(0, 0, cxRectWidth(ASrcRect), cxRectHeight(ASrcRect));
    Result := cxCreateBitmap(ARect, pf32bit);
    Result.Canvas.Brush.Color := 0;
    Result.Canvas.FillRect(ARect);
    cxBitBlt(Result.Canvas.Handle, ASrcDC, ARect, ASrcRect.TopLeft, SRCCOPY);
  end;

  function cxRectIdentical(const ARect1, ARect2: TRect): Boolean;
  begin
    Result := (cxRectWidth(ARect1) = cxRectWidth(ARect2)) and (cxRectHeight(ARect1) = cxRectHeight(ARect2));
  end;

  procedure ResizeBitmap(ADestBitmap, ASrcBitmap: TBitmap);
  begin
    StretchBlt(ADestBitmap.Canvas.Handle, 0, 0, ADestBitmap.Width, ADestBitmap.Height,
      ASrcBitmap.Canvas.Handle, 0, 0, ASrcBitmap.Width, ASrcBitmap.Height, SRCCOPY);
  end;

  procedure InternalAlphaBlend(ADestBitmap, ASrcBitmap: TBitmap);

    procedure SoftwareAlphaBlend(AWidth, AHeight: Integer);
    var
      ASourceColors, ADestColors: TRGBColors;
      I: Integer;
    begin
      ASourceColors := GetBitmapBits(ASrcBitmap, False);
      ADestColors := GetBitmapBits(ADestBitmap, False);
      for I := 0 to AWidth * AHeight - 1 do
        cxBlendFunction(ASourceColors[I], ADestColors[I], AConstantAlpha);
      SetBitmapBits(ADestBitmap, ADestColors, False);
    end;

  var
    AClientRect: TRect;
  begin
    AClientRect := Rect(0, 0, ADestBitmap.Width, ADestBitmap.Height);
    if Assigned(VCLAlphaBlend) then
      SystemAlphaBlend(ADestBitmap.Canvas.Handle, ASrcBitmap.Canvas.Handle, AClientRect, AClientRect, AConstantAlpha)
    else
      SoftwareAlphaBlend(AClientRect.Right, AClientRect.Bottom);
  end;

  procedure ComplexAlphaBlend;
  var
    ADirectDestBitmap, ADirectSrcBitmap, AStretchedSrcBitmap: TBitmap;
  begin
    ADirectSrcBitmap := CreateDirectBitmap(ASrcDC, ASrcRect);
    ADirectDestBitmap := CreateDirectBitmap(ADestDC, ADestRect);
    AStretchedSrcBitmap := cxCreateBitmap(ADestRect, pf32bit);
    try
      if ASmoothImage then
        cxSmoothResizeBitmap(ADirectSrcBitmap, AStretchedSrcBitmap, True)
      else
        ResizeBitmap(AStretchedSrcBitmap, ADirectSrcBitmap);
      InternalAlphaBlend(ADirectDestBitmap, AStretchedSrcBitmap);
      cxBitBlt(ADestDC, ADirectDestBitmap.Canvas.Handle, ADestRect, cxNullPoint, SRCCOPY);
    finally
      AStretchedSrcBitmap.Free;
      ADirectDestBitmap.Free;
      ADirectSrcBitmap.Free;
    end;
  end;

begin
  ASmoothImage := ASmoothImage and not cxRectIdentical(ADestRect, ASrcRect);
  if IsWin95X or not Assigned(VCLAlphaBlend) or ASmoothImage then
    ComplexAlphaBlend
  else
    SystemAlphaBlend(ADestDC, ASrcDC, ADestRect, ASrcRect, AConstantAlpha);
end;

procedure cxAlphaBlend(ADestBitmap, ASrcBitmap: TBitmap; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
begin
  CommonAlphaBlend(ADestBitmap.Canvas.Handle, ASrcBitmap.Canvas.Handle, ADestRect, ASrcRect, ASmoothImage, AConstantAlpha);
end;

procedure cxAlphaBlend(ADestDC: HDC; ASrcBitmap: TBitmap; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
begin
  CommonAlphaBlend(ADestDC, ASrcBitmap.Canvas.Handle, ADestRect, ASrcRect, ASmoothImage, AConstantAlpha);
end;

procedure cxAlphaBlend(ADestDC, ASrcDC: HDC; const ADestRect, ASrcRect: TRect; ASmoothImage: Boolean = False; AConstantAlpha: Byte = $FF); overload;
begin
  CommonAlphaBlend(ADestDC, ASrcDC, ADestRect, ASrcRect, ASmoothImage, AConstantAlpha);
end;

procedure cxBitBlt(ADestDC, ASrcDC: HDC; const ADestRect: TRect; const ASrcTopLeft: TPoint; ROP: DWORD);
begin
  BitBlt(ADestDC, ADestRect.Left, ADestRect.Top, cxRectWidth(ADestRect), cxRectHeight(ADestRect),
    ASrcDC, ASrcTopLeft.X, ASrcTopLeft.Y, ROP);
end;

procedure cxBlendFunction(const ASource: TRGBQuad; var ADest: TRGBQuad; ASourceConstantAlpha: Byte);

  function GetValue(AValue: Single): Byte;
  begin
    if AValue < 255 then
      Result := Round(AValue)
    else
      Result := 255;
  end;

var
  ASCA, ASrcAlpha: Single;
begin
  ASCA := ASourceConstantAlpha / 255;
  ASrcAlpha := 1 - ASource.rgbReserved * ASCA / 255;

  ADest.rgbRed := GetValue(ASource.rgbRed * ASCA + ASrcAlpha * ADest.rgbRed);
  ADest.rgbGreen := GetValue(ASource.rgbGreen * ASCA + ASrcAlpha * ADest.rgbGreen);
  ADest.rgbBlue := GetValue(ASource.rgbBlue * ASCA + ASrcAlpha * ADest.rgbBlue);
  ADest.rgbReserved := GetValue(ASource.rgbReserved * ASCA + ASrcAlpha * ADest.rgbReserved);
end;

function cxColorToRGBQuad(AColor: TColor; AReserved: Byte = 0): TRGBQuad;
{$IFDEF CLR}
var
  ARGBColor: DWORD;
{$ENDIF}
begin
{$IFDEF CLR}
  ARGBColor := ColorToRGB(AColor);
  Result.rgbBlue := GetBValue(ARGBColor);
  Result.rgbGreen := GetGValue(ARGBColor);
  Result.rgbRed := GetRValue(ARGBColor);
{$ELSE}
  DWORD(Result) := ColorToRGB(AColor);

  //#DG exchange values
  Result.rgbBlue := Result.rgbBlue xor Result.rgbRed;
  Result.rgbRed := Result.rgbBlue xor Result.rgbRed;
  Result.rgbBlue := Result.rgbBlue xor Result.rgbRed;
{$ENDIF}
  Result.rgbReserved := AReserved;
end;

function cxCreateBitmap(const ASize: TSize; AFormat: TPixelFormat = pf24bit): TBitmap;
begin
  Result := cxCreateBitmap(ASize.cx, ASize.cy, AFormat);
end;

function cxCreateBitmap(const ARect: TRect; AFormat: TPixelFormat = pf24bit): TBitmap;
begin
  Result := cxCreateBitmap(cxRectWidth(ARect), cxRectHeight(ARect), AFormat);
end;

function cxCreateBitmap(AWidth, AHeight: Integer; AFormat: TPixelFormat = pf24bit): TBitmap;
begin
  Result := TBitmap.Create;
{$IFDEF DELPHI6}
  Result.PixelFormat := AFormat;
{$ENDIF}
  Result.Width := AWidth;
  Result.Height := AHeight;
{$IFNDEF DELPHI6}
  Result.PixelFormat := AFormat;
{$ENDIF}
end;

function cxCreateTrueColorBitmap(const ASize: TSize): TBitmap;
begin
  Result := cxCreateTrueColorBitmap(ASize.cx, ASize.cy);
end;

function cxCreateTrueColorBitmap(AWidth, AHeight: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  Result.Handle := cxCreateTrueColorBitmapHandle(AWidth, AHeight);
end;

function cxCreateTrueColorBitmapHandle(AWidth, AHeight: Integer; ABPP: Integer = 32): HBitmap;
begin
  Result := CreateBitmap(AWidth, AHeight, 1, ABPP, nil);
end;

procedure cxDrawImage(ADC: THandle; AGlyphRect, ABackgroundRect: TRect; AGlyph: TBitmap;
  AImages: TCustomImageList; AImageIndex: Integer; ADrawMode: TcxImageDrawMode;
  ASmoothImage: Boolean = False; ABrush: THandle = 0;
  ATransparentColor: TColor = clNone; AUseLeftBottomPixelAsTransparent: Boolean = True);

  procedure DrawBackGround(ABitmap: TcxBitmap);
  begin
    if ABrush = 0 then
      cxBitBlt(ABitmap.Canvas.Handle, ADC, ABitmap.ClientRect, ABackgroundRect.TopLeft, SRCCOPY)
    else
      FillRect(ABitmap.Canvas.Handle, ABitmap.ClientRect, ABrush);
  end;

  procedure DrawImage(ABitmap: TcxBitmap; ADrawMode: TcxImageDrawMode);

    procedure MakeImage(AImageBitmap: TcxBitmap; out AIsAlphaUsed: Boolean);
    begin
      if not IsGlyphAssigned(AGlyph) then
      begin
        TcxImageList.GetImageInfo(AImages.Handle, AImageIndex, AImageBitmap, nil);
//        cxDrawImageList(AImages.Handle, AImageIndex, AImageBitmap.Canvas.Handle,
//          cxNullPoint, AImages.DrawingStyle, AImages.ImageType)
//#DG can break destination        AImages.Draw(AImageBitmap.Canvas, 0, 0, AImageIndex)
        AIsAlphaUsed := TcxImageList.GetPixelFormat(AImages.Handle) >= 32;
      end
      else
      begin
        AImageBitmap.CopyBitmap(AGlyph);
        AIsAlphaUsed := (AGlyph.PixelFormat = pf32bit) or
          ((AGlyph.PixelFormat = pfDevice) and (GetDeviceCaps(cxScreenCanvas.Handle, BITSPIXEL) >= 32));
      end;
      AIsAlphaUsed := AIsAlphaUsed and AImageBitmap.IsAlphaUsed;
      if not AIsAlphaUsed then
        AImageBitmap.TransformBitmap(btmSetOpaque);
    end;

    procedure MakeMask(AImageBitmap, AMaskBitmap: TcxBitmap; AIsAlphaUsed: Boolean);
    var
      AImageListMask: TcxBitmap;
    begin
      AMaskBitmap.CopyBitmap(AImageBitmap);
      if not AIsAlphaUsed then
      begin
        if not IsGlyphAssigned(AGlyph) then
        begin
          AImageListMask := TcxBitmap.CreateSize(AMaskBitmap.ClientRect);
          try
            TcxImageList.GetImageInfo(AImages.Handle, AImageIndex, nil, AImageListMask);
            AImageListMask.TransformBitmap(btmCorrectBlend);
            AMaskBitmap.Filter(AImageListMask);
          finally
            AImageListMask.Free;
          end;
        end;
        if ATransparentColor <> clNone then
          AMaskBitmap.TransparentPixels.Add(ATransparentColor);
        if AUseLeftBottomPixelAsTransparent and IsGlyphAssigned(AGlyph) then
          AMaskBitmap.TransparentPixels.Add(AMaskBitmap.TransparentColor);
      end;
      AMaskBitmap.TransformBitmap(btmMakeMask);
    end;

  const
    ImageShadowSize = 2;
  var
    BW, BH: Integer;
    AImageBitmap, AMaskBitmap: TcxBitmap;
    AConstantAlpha: Byte;
    AIsAlphaUsed: Boolean;
  begin
    OffsetRect(AGlyphRect, -ABackgroundRect.Left, -ABackgroundRect.Top);
    if not Assigned(CustomDrawImageProc) or not CustomDrawImageProc(ABitmap.Canvas, AImages, AImageIndex, AGlyph, AGlyphRect, ADrawMode) then
    begin
      if not IsGlyphAssigned(AGlyph) then
      begin
        BW := AImages.Width;
        BH := AImages.Height;
      end
      else
      begin
        BW := AGlyph.Width;
        BH := AGlyph.Height;
      end;

      AImageBitmap := GetImageBitmap(BW, BH);
      MakeImage(AImageBitmap, AIsAlphaUsed);

      AMaskBitmap := GetMaskBitmap(BW, BH);
      MakeMask(AImageBitmap, AMaskBitmap, AIsAlphaUsed);
      AImageBitmap.Filter(AMaskBitmap);
      AConstantAlpha := $FF;
      case ADrawMode of
        idmFaded:
          begin
            AImageBitmap.TransformBitmap(btmFade);
            AConstantAlpha := FadeMap.SrcConstantAlpha;
          end;
        idmGrayScale:
          AImageBitmap.TransformBitmap(btmGrayScale);
        idmDingy:
          AImageBitmap.TransformBitmap(btmDingy);
        idmShadowed:
          AImageBitmap.DrawShadow(AMaskBitmap, ImageShadowSize);
        idmDisabled:
          begin
            if AIsAlphaUsed then
            begin
              AImageBitmap.TransformBitmap(btmDisable);
              AConstantAlpha := DisableMap.SrcConstantAlpha;
            end
            else
            begin
              AImageBitmap.TransformBitmap(btmDirty);
              AImageBitmap.DrawShadow(AMaskBitmap, 1, clBtnHighlight);
            end;
          end;
      end;
      AImageBitmap.AlphaBlend(ABitmap, AGlyphRect, ASmoothImage, AConstantAlpha);
    end;
  end;

var
  ADrawBitmap: TcxBitmap;
begin
  if not (IsGlyphAssigned(AGlyph) or IsImageAssigned(AImages, AImageIndex)) then
    Exit;

  ADrawBitmap := GetDrawBitmap(cxRectWidth(ABackgroundRect), cxRectHeight(ABackgroundRect));
  DrawBackGround(ADrawBitmap);
  DrawImage(ADrawBitmap, ADrawMode);
  cxBitBlt(ADC, ADrawBitmap.Canvas.Handle, ABackgroundRect, cxNullPoint, SRCCOPY);
end;

function GetImageListStyle(ADrawingStyle: TDrawingStyle; AImageType: TImageType): DWORD;
const
  ADrawingStyles: array[TDrawingStyle] of DWORD = (ILD_FOCUS, ILD_SELECTED, ILD_NORMAL, ILD_TRANSPARENT);
  AImageTypes: array[TImageType] of DWORD = (0, ILD_MASK);
begin
  Result := ADrawingStyles[ADrawingStyle] or AImageTypes[AImageType];
end;

procedure cxDrawImageList(AImageListHandle: HIMAGELIST; AImageIndex: Integer;
  ADC: HDC; APoint: TPoint; ADrawingStyle: TDrawingStyle; AImageType: TImageType);
begin
  ImageList_Draw(AImageListHandle, AImageIndex, ADC, APoint.X, APoint.Y, GetImageListStyle(ADrawingStyle, AImageType));
end;

procedure cxDrawHatch(ADC: HDC; const ARect: TRect; AColor1, AColor2: TColor; AStep: Byte; AAlpha1: Byte = $FF; AAlpha2: Byte = $FF);
var
  ADrawBitmap: TcxBitmap;
begin
  ADrawBitmap := TcxBitmap.CreateSize(ARect);
  try
    cxBitBlt(ADrawBitmap.Canvas.Handle, ADC, ADrawBitmap.ClientRect, ARect.TopLeft, SRCCOPY);
    ADrawBitmap.DrawHatch(AColor1, AColor2, AStep, AAlpha1, AAlpha2);
    cxBitBlt(ADC, ADrawBitmap.Canvas.Handle, ARect, cxNullPoint, SRCCOPY);
  finally
    ADrawBitmap.Free;
  end;
end;

function Lanczos3Filter(Value: Single): Single;

  function SinC(Value: Single): Single;
  begin
    if (Value <> 0.0) then
    begin
      Value  := Value * PI;
      Result := Sin(Value) / Value
    end
    else Result := 1.0;
  end;

begin
  if (Value < 0.0) then Value := -Value;
  if (Value < 3.0) then
    Result := SinC(Value) * SinC(Value / 3.0)
  else
    Result := 0.0;
end;

procedure BuildFilter(out AContributorList: TContributorList; AScale: Single; ASrcSize, ADestSize: Integer);
var
  I, J, APixel, AMaxContributors, AWeight: Integer;
  ACenter, ARadius, AScaleFactor: Single;
begin
  SetLength(AContributorList, ADestSize);
  if AScale < 1.0 then AScaleFactor := 1.0 / AScale else AScaleFactor := 1.0;
  ARadius := 3 * AScaleFactor;
  AMaxContributors := Trunc(ARadius * 2.0 + 1);
  for I := 0 to ADestSize - 1 do
    with AContributorList[I] do
    begin
      SetLength(Contributors, AMaxContributors);
      Count := 0;
      ACenter := I / AScale;
      for J := Floor(ACenter - ARadius) to Ceil(ACenter + ARadius) do
      begin
        AWeight := Round(Lanczos3Filter((ACenter - J) / AScaleFactor) / AScaleFactor * 256);
        if AWeight = 0 then continue;
        if J < 0 then
          APixel := -J
        else
          if (J >= ASrcSize) then
            APixel := ASrcSize - J + ASrcSize - 1
          else
            APixel := J;
        Contributors[Count].Pixel := APixel;
        Contributors[Count].Weight := AWeight;
        Inc(Count);
      end;
    end;
end;

procedure ApplyFilter(var AContributorList: TContributorList;
  var ASource: TRGBColors; ASrcSize, ASrcLineLength: Integer;
  var ADest: TRGBColors; ADestSize, ADestLineLength: Integer;
  AHorizontal: Boolean);

  function GetColorPart(Value: Integer): Integer;
  begin
    if Value < 0 then
      Result := 0
    else
    begin
      Value := Value shr 8;
      Result := Min(255, Value);
    end;
  end;

var
  AWeight: Integer;
  AColor: TRGBQuad;
  R, G, B, A: Integer;
  K, I, J: Integer;
begin
  for I := 0 to ASrcSize - 1 do
    for J := 0 to ADestSize - 1 do
      with AContributorList[J] do
      begin
        R := 0; G := 0; B := 0; A := 0;
        for K := 0 to Count - 1 do
        begin
          if AHorizontal then
            AColor := ASource[Contributors[K].Pixel + (I * ASrcLineLength)]
          else
            AColor := ASource[I + (Contributors[K].Pixel * ASrcLineLength)];
          AWeight := Contributors[K].Weight;
          if AWeight = 0 then continue;
          Inc(R, AColor.rgbRed * AWeight);
          Inc(G, AColor.rgbGreen * AWeight);
          Inc(B, AColor.rgbBlue * AWeight);
          Inc(A, AColor.rgbReserved * AWeight);
        end;
        AColor.rgbRed := GetColorPart(R);
        AColor.rgbGreen := GetColorPart(G);
        AColor.rgbBlue := GetColorPart(B);
        AColor.rgbReserved := GetColorPart(A);
        if AHorizontal then
          ADest[J + (I * ADestLineLength)] := AColor
        else
          ADest[I + (J * ADestLineLength)] := AColor;
      end;
  //dispose contributors and source buffer
  for I := 0 to HIGH(AContributorList) do
    AContributorList[I].Contributors := nil;
  AContributorList := nil;
  ASource := nil;
end;

procedure cxSmoothResizeBitmap(ASource, ADestination: TBitmap; AForceUseLanczos3Filter: Boolean = False);
var
  AContributorList: TContributorList;
  ASrcWidth, ASrcHeight, ADestWidth, ADestHeight: Integer;
  ABuffer1, ABuffer2: TRGBColors;
  AOldMode: Cardinal;
  AScale: Single;
begin
  ADestWidth := ADestination.Width;
  ADestHeight := ADestination.Height;
  ASrcWidth := ASource.Width;
  ASrcHeight := ASource.Height;
  if (ADestWidth = 0) or (ADestHeight = 0) or (ASrcWidth = 0) or (ASrcHeight = 0) then Exit;
  ASource.Canvas.Lock;
  ADestination.Canvas.Lock;
  try
    if IsWinNT and not AForceUseLanczos3Filter then
    begin
      AOldMode := SetStretchBltMode(ADestination.Canvas.Handle, HALFTONE);
      StretchBlt(ADestination.Canvas.Handle, 0, 0, ADestWidth, ADestHeight,
        ASource.Canvas.Handle, 0, 0, ASrcWidth, ASrcHeight, srcCopy);
      SetStretchBltMode(ADestination.Canvas.Handle, AOldMode);
    end
    else
    begin
      ABuffer1 := GetBitmapBits(ASource, False);
      SetLength(ABuffer2, ADestWidth * ASrcHeight);
      if ASrcWidth = 1 then
        AScale :=  ADestWidth / ASrcWidth
      else
        AScale :=  (ADestWidth - 1) / (ASrcWidth - 1);
      BuildFilter(AContributorList, AScale, ASrcWidth, ADestWidth);
      ApplyFilter(AContributorList, ABuffer1, ASrcHeight, ASrcWidth, ABuffer2, ADestWidth, ADestWidth, True);
      ABuffer1 := GetBitmapBits(ADestination, False);
      if (ASrcHeight = 1) or (ADestHeight = 1) then
        AScale :=  ADestHeight / ASrcHeight
      else
        AScale :=  (ADestHeight - 1) / (ASrcHeight - 1);
      BuildFilter(AContributorList, AScale, ASrcHeight, ADestHeight);
      ApplyFilter(AContributorList, ABuffer2, ADestWidth, ADestWidth, ABuffer1, ADestHeight, ADestWidth, False);
      SetBitmapBits(ADestination, ABuffer1, False);
    end;
  finally
    ASource.Canvas.Unlock;
    ADestination.Canvas.Unlock;
  end;
end;

{!!! TODO: adapt to .net}
{$IFNDEF CLR}

function cxGetCursorSize: TSize;
var
  IconInfo: TIconInfo;
  BitmapInfoSize, BitmapBitsSize, ImageSize: DWORD;
  Bitmap: PBitmapInfoHeader;
  Bits: Pointer;
  BytesPerScanline: Integer;

  function FindScanline(Source: Pointer; MaxLen: Cardinal;
    Value: Cardinal): Cardinal; assembler;
  asm
    PUSH    ECX
    MOV     ECX,EDX
    MOV     EDX,EDI
    MOV     EDI,EAX
    POP     EAX
    REPE    SCASB
    MOV     EAX,ECX
    MOV     EDI,EDX
  end;

begin
  { Default value is entire icon height }
  Result.cy := GetSystemMetrics(SM_CYCURSOR);
  Result.cx := GetSystemMetrics(SM_CXCURSOR);

  if GetIconInfo(GetCursor, IconInfo) then
  try
    GetDIBSizes(IconInfo.hbmMask, BitmapInfoSize, BitmapBitsSize);
    Bitmap := AllocMem(DWORD(BitmapInfoSize) + BitmapBitsSize);
    try
    Bits := Pointer(DWORD(Bitmap) + BitmapInfoSize);
    if GetDIB(IconInfo.hbmMask, 0, Bitmap^, Bits^) and
      (Bitmap^.biBitCount = 1) then
    begin
      { Point Bits to the end of this bottom-up bitmap }
      with Bitmap^ do
      begin
        Result.cx := biWidth;
        BytesPerScanline := ((biWidth * biBitCount + 31) and not 31) div 8;
        ImageSize := biWidth * BytesPerScanline;
        Bits := Pointer(DWORD(Bits) + BitmapBitsSize - ImageSize);
        { Use the width to determine the height since another mask bitmap
          may immediately follow }
        Result.cy := FindScanline(Bits, ImageSize, $FF);
        { In case the and mask is blank, look for an empty scanline in the
          xor mask. }
        if (Result.cy = 0) and (biHeight >= 2 * biWidth) then
          Result.cy := FindScanline(Pointer(DWORD(Bits) - ImageSize),
          ImageSize, $00);
        Result.cy := Result.cy div BytesPerScanline;
      end;
      Dec(Result.cy, IconInfo.yHotSpot);
    end;
    finally
      FreeMem(Bitmap);
    end;
  finally
    if IconInfo.hbmColor <> 0 then DeleteObject(IconInfo.hbmColor);
    if IconInfo.hbmMask <> 0 then DeleteObject(IconInfo.hbmMask);
  end;
end;

procedure cxAlphaBlend(ASource: TBitmap; ARect: TRect;
  const ASelColor: TColor; Alpha: Byte = 170);
var
  ARow, ACol: Integer;
  SrcLine: Pointer;
  C1, C2: Double;
  AColorValues: array[0..3] of Byte;
  P: TPoint;
begin
  C1 := Alpha / 255;
  C2 := 1.0 - C1;
  AColorValues[0] := Round(GetBValue(ASelColor) * C1);
  AColorValues[1] := Round(GetGValue(ASelColor) * C1);
  AColorValues[2] := Round(GetRValue(ASelColor) * C1);
  AColorValues[3] := 0;
  GetWindowOrgEx(ASource.Canvas.Handle, P);
  OffsetRect(ARect, -P.X, -P.Y);
  for ARow := Max(ARect.Top, 0) to Min(ARect.Bottom, ASource.Height - 1) do
  begin
    SrcLine := ASource.ScanLine[ARow];
    ACol := Max(0, ARect.Left * 4);
    while ACol < Min(ARect.Right * 4, ASource.Width * 4 - 1) do
    begin
      WriteByte(SrcLine, AColorValues[ACol mod 4] + Round(ReadByte(SrcLine, ACol) * C2), ACol);
      Inc(ACol);
    end;
  end;
end;

procedure cxAlphaBlend(
  ADest, ABkSource, ASource: TBitmap; Alpha: Byte = cxDefaultAlphaValue);

  function SystemAlphaPaint: Boolean;
  {$IFDEF VCL}
  var
    ABlendFunction: TBlendFunction;
  {$ENDIF}
  begin
  {$IFDEF VCL}
    if not Assigned(VCLAlphaBlend) then
    begin
      Result := False;
      Exit;
    end;
    ABlendFunction := DefaultBlendFunction;
    ABlendFunction.SourceConstantAlpha := Alpha;
    with ADest do
    begin
      Canvas.Draw(0, 0, ABkSource); //      Assign(ABkSource); todo: graphics bug image not copying but _AddRef called
      Result := {$IFDEF CLR}AlphaBlend{$ELSE}VCLAlphaBlend{$ENDIF}(Canvas.Handle,
        0, 0, Width, Height, ASource.Canvas.Handle, 0, 0, Width, Height, ABlendFunction);
    end;
  {$ELSE}
    Result := False;
  {$ENDIF}
  end;

  procedure AlphaPaint;
  var
    ACount, K: Integer;
    DstLine, BkSrcLine, SrcLine: Pointer;
    C1, C2: Double;
  begin
    C1 := Alpha / 255;
    C2 := 1.0 - C1;
    with ASource do
    begin
      K := Height;
      ACount := ((Width * 24 + 31) and not 31) shr 3 * K;
    end;
    BkSrcLine := ABkSource.ScanLine[K - 1];
    SrcLine := ASource.ScanLine[K - 1];
    DstLine := ADest.ScanLine[K - 1];
    for K := 0 to ACount - 1 do
      WriteByte(DstLine,
        Round(ReadByte(SrcLine, K) * C1) + Round(ReadByte(BkSrcLine, K) * C2), K);
  end;

  procedure DoAlphaPaint;
  begin
  {$IFDEF VCL}
    if GetDeviceCaps(cxScreenCanvas.Handle, BITSPIXEL) in [16, 24, 32] then
  {$ELSE}
  //TODO
    if False then
  {$ENDIF}
      AlphaPaint
    else
      ADest.Canvas.Draw(0, 0, ASource); // .Assign(ASource);
  end;

begin
  if not SystemAlphaPaint then DoAlphaPaint;
end;

procedure cxApplyViewParams(ACanvas: TcxCanvas;
  const AViewParams: TcxViewParams);
begin
  with ACanvas do
  begin
    Font := AViewParams.Font;
    Font.Color := AViewParams.TextColor;
    Brush.Color := AViewParams.Color;
  end;
end;

procedure cxCopyImage(ASource, ADest: TBitmap;
  const ASrcOffset, ADstOffset: TPoint; const ARect: TRect);
var
  ADstRect, ASrcRect: TRect;
begin
  ADstRect := ARect;
  ASrcRect := ARect;
  OffsetRect(ASrcRect, ASrcOffset.X, ASrcOffset.Y);
  OffsetRect(ADstRect, ADstOffset.X, ADstOffset.Y);
  ADest.Canvas.CopyRect(ASrcRect, ASource.Canvas, ADstRect);
end;

procedure cxCopyImage(ASource, ADest: TCanvas;
  const ASrcOffset, ADstOffset: TPoint; const ARect: TRect);
var
  ADstRect, ASrcRect: TRect;
begin
  ADstRect := ARect;
  ASrcRect := ARect;
  OffsetRect(ASrcRect, ASrcOffset.X, ASrcOffset.Y);
  OffsetRect(ADstRect, ADstOffset.X, ADstOffset.Y);
  ADest.CopyRect(ADstRect, ASource, ASrcRect);
end;

procedure cxDrawArrows(ACanvas: TCanvas; const ARect: TRect;
  ASide: TcxBorder; AColor: TColor; APenColor: TColor = clDefault);
type
  TArrowPolygon = array[0..6] of TPoint;
var
  ArrowRgns: array[0..1, 0..6, 0..1] of Integer;
  BaseLine: array[0..1, 0..1] of Integer;
  I, J, K: Integer;
begin
  with ARect do
  begin
    BaseLine[0, 0] := Left;
    BaseLine[0, 1] := Top;
    BaseLine[1, 0] := Right;
    BaseLine[1, 1] := Bottom;
  end;
  if ASide in [bLeft, bBottom] then
  begin
    BaseLine[Byte(ASide = bLeft), 0] := ARect.Left;
    BaseLine[Byte(ASide = bLeft), 1] := ARect.Bottom;
  end
  else
  begin
    BaseLine[Byte(ASide = bTop), 0] := ARect.Right;
    BaseLine[Byte(ASide = bTop), 1] := ARect.Top;
  end;
  Move(BaseRgns[Byte(ASide in [bTop, bBottom]) shl 1], ArrowRgns, SizeOf(ArrowRgns));
  for I := 0 to 1 do
    for J := 0 to 6 do
      for K := 0 to 1 do
        Inc(ArrowRgns[I, J, K], BaseLine[I, K]);
  ACanvas.Brush.Color := AColor;
  if APenColor = clDefault then
    ACanvas.Pen.Color := $FFFFFF xor ColorToRgb(AColor)
  else
    ACanvas.Pen.Color := APenColor;
  for I := 0 to 1 do
    ACanvas.Polygon(TArrowPolygon(ArrowRgns[I]));
end;

procedure cxFillHalfToneRect(
  Canvas: TCanvas; const ARect: TRect; ABkColor, AColor: TColor);
begin
  with Canvas do
  begin
    {$IFDEF VCL}
    ABkColor := SetBkColor(Handle, ColorToRgb(ABkColor));
    AColor := SetTextColor(Handle, ColorToRgb(AColor));
    Windows.FillRect(Handle, ARect, cxHalfToneBrush.Handle);
    SetBkColor(Handle, ABkColor);
    SetTextColor(Handle, AColor);
    {$ELSE}
    QBrush_SetColor(HalfToneBrush.Handle, QColor(AColor));
    QPainter_SetBackgroundColor(Handle, QColor(ABkColor));
    with ARect do
      QPainter_FillRect(Handle, Left, Top, Right - Left + 1, Bottom - Top + 1, cxHalfToneBrush);
    {$ENDIF}
  end;
end;

procedure cxSetCanvasOrg(ACanvas: TCanvas; var AOrg: TRect);
begin
{$IFDEF VCL}
  with AOrg do
    SetWindowOrgEx(ACanvas.Handle, Left, Top, @TopLeft);
{$ELSE}
   QPainter_SetWindow(ACanvas.Handle, AOrg);
{$ENDIF}
end;

function cxTextHeight(AFont: TFont; const S: string = 'Wg'; AFontSize: Integer = 0): Integer;
begin
  Result := cxTextExtent(AFont, S, AFontSize).cy;
end;

function cxTextExtent(AFont: TFont; const S: string; AFontSize: Integer = 0): TSize;
begin
  with cxScreenCanvas do
  begin
    Font.Assign(AFont);
    if AFontSize <> 0 then Font.Size := AFontSize;
    Result := TextExtent(S);
  end;
end;

function cxTextWidth(AFont: TFont; const S: string; AFontSize: Integer = 0): Integer;
begin
  Result := cxTextExtent(AFont, S, AFontSize).cx;
end;
{$ENDIF}

function cxDrawText(ADC: THandle; const AText: string; var ARect: TRect; AFormat: UINT; ACharCount: Integer = - 1): Integer;
begin
  Result := Windows.DrawText(ADC, {$IFNDEF CLR}PChar{$ENDIF}(AText), ACharCount, ARect, AFormat);
end;

function cxExtTextOut(ADC: THandle; const AText: string; const APoint: TPoint;
  const ARect: TRect; AOptions: UINT; ACharCount: Integer = -1): Boolean;
begin
 if ACharCount = -1 then
   ACharCount := Length(AText);
  Result := ExtTextOut(ADC, APoint.X, APoint.Y, AOptions,
    {$IFNDEF CLR}@{$ENDIF}ARect, {$IFNDEF CLR}PChar{$ENDIF}(AText), ACharCount, nil);
end;

function cxExtTextOut(ADC: THandle; const AText: string; const APoint: TPoint;
  AOptions: UINT; ACharCount: Integer = -1): Boolean; overload;
begin
 if ACharCount = -1 then
   ACharCount := Length(AText);
  Result := ExtTextOut(ADC, APoint.X, APoint.Y, AOptions,
    nil, {$IFNDEF CLR}PChar{$ENDIF}(AText), ACharCount, nil);
end;

procedure cxInvalidateRect(AHandle: THandle; const ARect: TRect; AEraseBackground: Boolean = True);
begin
  InvalidateRect(AHandle, {$IFNDEF CLR}@{$ENDIF}ARect, AEraseBackground);
end;

procedure cxInvalidateRect(AHandle: THandle; AEraseBackground: Boolean = True);
begin
  InvalidateRect(AHandle, nil, AEraseBackground);  
end;

function cxTextSize(ADC: THandle; const AText: string): TSize; // differs from cxTextExtent
var
  ARect: TRect;
begin
  ARect := cxGetTextRect(ADC, AText, 1);
  Result := Size(ARect.Right, ARect.Bottom);
end;

function cxGetTextRect(ADC: THandle; const AText: string; ARowCount: Integer; AReturnMaxRectHeight: Boolean = False): TRect;

  function GetMaxWidth: Integer;
  var
    R: TRect;
  begin
    R := cxEmptyRect;
    cxDrawText(ADC, AText, R, DT_SINGLELINE or DT_CALCRECT);
    Result := R.Right;
  end;

  function GetMinWidth: Integer;
  var
    R: TRect;
  begin
    R := Rect(0, 0, 1, 1);
    cxDrawText(ADC, AText, R, DT_WORDBREAK or DT_CALCRECT);
    Result := R.Right;
  end;

  function GetTextSize(AWidth: Integer): TRect;
  begin
    Result := Rect(0, 0, AWidth, 1);
    cxDrawText(ADC, AText, Result, DT_WORDBREAK or DT_CALCRECT);
  end;

var
  AMaxTextHeight, AMaxWidth, AMinWidth, AWidth: Integer;
begin
  Result := cxEmptyRect;
  if ARowCount <= 0 then
    Exit;
  if ARowCount = 1 then
    cxDrawText(ADC, AText, Result, DT_SINGLELINE or DT_CALCRECT)
  else
  begin
    AMaxTextHeight := cxTextSize(ADC, 'Wg').cy * ARowCount;
    AMinWidth := GetMinWidth;
    AMaxWidth := GetMaxWidth;
    AWidth := (AMinWidth + AMaxWidth) div 2;
    while AMaxWidth - AMinWidth > 1 do
    begin
      if GetTextSize(AWidth).Bottom > AMaxTextHeight then
        AMinWidth := AWidth
      else
        AMaxWidth := AWidth;
      AWidth := (AMinWidth + AMaxWidth) div 2;
    end;
    Result := GetTextSize(AMinWidth);
    if Result.Bottom > AMaxTextHeight then
      Result := GetTextSize(AMaxWidth);
    if AReturnMaxRectHeight then
      Result.Bottom := AMaxTextHeight;
  end;
end;

function cxGetTextRect(AFont: TFont; const AText: string; ARowCount: Integer): TRect;
begin
  cxScreenCanvas.Font := AFont;
  Result := cxGetTextRect(cxScreenCanvas.Handle, AText, ARowCount);
end;

function cxGetBitmapData(ABitmapHandle: HBITMAP; out ABitmapData: Windows.TBitmap): Boolean;
begin
  Result := GetObject(ABitmapHandle, SizeOf(Windows.TBitmap), {$IFNDEF CLR}@{$ENDIF}ABitmapData) <> 0;
end;

function cxGetBrushData(ABrushHandle: HBRUSH; out ALogBrush: TLogBrush): Boolean;
begin
  Result := GetObject(ABrushHandle, SizeOf(TLogBrush), {$IFNDEF CLR}@{$ENDIF}ALogBrush) <> 0;
end;

function cxGetBrushData(ABrushHandle: HBRUSH): TLogBrush;
begin
  cxGetBrushData(ABrushHandle, Result);
end;

function cxGetFontData(AFontHandle: HFONT; out ALogFont: TLogFont): Boolean;
begin
{$IFNDEF CLR}
  Result := GetObject(AFontHandle, SizeOf(TLogFont), @ALogFont) <> 0;
{$ELSE}
  Result := GetObject(AFontHandle, Marshal.SizeOf(TypeOf(TLogFont)), ALogFont) <> 0;
{$ENDIF}
end;

function cxGetPenData(APenHandle: HPEN; out ALogPen: TLogPen): Boolean;
begin
  Result := GetObject(APenHandle, SizeOf(TLogPen), {$IFNDEF CLR}@{$ENDIF}ALogPen) <> 0;
end;

function cxGetWritingDirection(AFontCharset: TFontCharset; const AText: string): TCanvasOrientation;

  function IsStandardASCIIChar: Boolean;
  begin
  {$IFDEF CLR}
    Result := (Length(AText) > 0) and (Integer(AText[1]) < 128);
  {$ELSE}
    Result := (Length(AText) > 0) and (cxStrCharLength(AText) = 1) and (Integer(AText[1]) < 128);
  {$ENDIF}
  end;

begin
  if AFontCharset = DEFAULT_CHARSET then
    AFontCharset := GetDefFontCharset;
  if not IsStandardASCIIChar and (AFontCharset in [ARABIC_CHARSET, CHINESEBIG5_CHARSET, GB2312_CHARSET]) then
    Result := coRightToLeft
  else
    Result := coLeftToRight;
end;

procedure cxDrawThemeParentBackground(AControl: TWinControl; ACanvas: TcxCanvas; const ARect: TRect);
begin
  if AControl.Parent.DoubleBuffered then
    cxDrawTransparentControlBackground(AControl, ACanvas, ARect, False)
  else
    DrawThemeParentBackground(AControl.Handle, ACanvas.Handle, ARect);
end;

procedure cxDrawThemeParentBackground(AControl: TWinControl; ACanvas: TCanvas; const ARect: TRect);
var
  AcxCanvas: TcxCanvas;
begin
  AcxCanvas := TcxCanvas.Create(ACanvas);
  try
    cxDrawThemeParentBackground(AControl, AcxCanvas, ARect);
  finally
    AcxCanvas.Free;
  end;
end;

procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TcxCanvas; ARect: TRect; APaintParentWithChildren: Boolean = True);

  procedure cxPaintControlTo(ADrawControl: TWinControl;
    AOffsetX, AOffsetY: Integer; ADrawRect: TRect);

    procedure DrawEdgesAndBorders;
    var
      AEdgeFlags, ABorderFlags: Integer;
      ABorderRect: TRect;
    begin
      ABorderFlags := 0;
      AEdgeFlags := 0;
      if GetWindowLong(ADrawControl.Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE <> 0 then
      begin
        AEdgeFlags := EDGE_SUNKEN;
        ABorderFlags := BF_RECT or BF_ADJUST
      end
      else
        if GetWindowLong(ADrawControl.Handle, GWL_STYLE) and WS_BORDER <> 0 then
        begin
          AEdgeFlags := BDR_OUTER;
          ABorderFlags := BF_RECT or BF_ADJUST or BF_MONO;
        end;
      if ABorderFlags <> 0 then
      begin
        ABorderRect := Rect(0, 0, ADrawControl.Width, ADrawControl.Height);
        DrawEdge(ACanvas.Handle, ABorderRect, AEdgeFlags, ABorderFlags);
        ACanvas.SetClipRegion(TcxRegion.Create(ABorderRect), roIntersect);
        MoveWindowOrg(ACanvas.Handle, ABorderRect.Left, ABorderRect.Top);
      end;
    end;

  var
    I: Integer;
    AChildControl: TControl;
  begin
    ACanvas.SaveDC;
    try
      MoveWindowOrg(ACanvas.Handle, AOffsetX, AOffsetY);

      ACanvas.SetClipRegion(TcxRegion.Create(ADrawRect), roIntersect);
      with ACanvas.GetClipRegion do
        try
          if IsEmpty then
            Exit;
        finally
          Free;
        end;

      ADrawControl.ControlState := ADrawControl.ControlState + [csPaintCopy];
      try
        if ADrawControl <> AControl.Parent then
          DrawEdgesAndBorders;
        ACanvas.Canvas.Lock;
        try
          ADrawControl.Perform(WM_ERASEBKGND, ACanvas.Handle, ACanvas.Handle);
          ADrawControl.Perform(WM_PAINT, ACanvas.Handle, 0);
        finally
          ACanvas.Canvas.Unlock;
        end;
        if APaintParentWithChildren then
          for I := 0 to ADrawControl.ControlCount - 1 do
          begin
            AChildControl := ADrawControl.Controls[I];
            if AChildControl = AControl then
              Break;
            if (AChildControl is TWinControl) and TWinControl(AChildControl).Visible then
              cxPaintControlTo(TWinControl(AChildControl), AChildControl.Left, AChildControl.Top, Rect(0, 0, AChildControl.Width, AChildControl.Height));
          end;
      finally
        ADrawControl.ControlState := ADrawControl.ControlState - [csPaintCopy];
      end;
    finally
      ACanvas.RestoreDC;
    end;
  end;

begin
  if AControl.Parent <> nil then
  begin
    OffsetRect(ARect, AControl.Left, AControl.Top);
    cxPaintControlTo(AControl.Parent, -ARect.Left, -ARect.Top, ARect);
// wrong cxLabel painting    cxPaintControlTo(AControl.Parent, -AControl.Left, -AControl.Top, ARect);
  end;
end;

procedure cxDrawTransparentControlBackground(AControl: TWinControl;
  ACanvas: TCanvas; const ARect: TRect; APaintParentWithChildren: Boolean = True);
var
  AcxCanvas: TcxCanvas;
begin
  AcxCanvas := TcxCanvas.Create(ACanvas);
  try
    cxDrawTransparentControlBackground(AControl, AcxCanvas, ARect, APaintParentWithChildren);
  finally
    AcxCanvas.Free;
  end;
end;

function cxScreenCanvas: TcxScreenCanvas;
begin
  if ScreenCanvas = nil then
    ScreenCanvas := TcxScreenCanvas.Create;
  Result := ScreenCanvas;
end;

{ TcxRegion }

constructor TcxRegion.Create(AHandle: TcxRegionHandle);
begin
  inherited Create;
  FHandle := AHandle;
end;

constructor TcxRegion.Create(const ABounds: TRect);
var
  AHandle: TcxRegionHandle;
begin
{$IFDEF VCL}
  AHandle := CreateRectRgnIndirect(ABounds);
{$ELSE}
  AHandle := QRegion_create(@ABounds, QRegionRegionType_Rectangle);
{$ENDIF}
  Create(AHandle);
end;

constructor TcxRegion.Create;
begin
{$IFDEF VCL}
  Create(0, 0, 0, 0);
{$ELSE}
  Create(QRegion_create);
{$ENDIF}
end;

constructor TcxRegion.Create(ALeft, ATop, ARight, ABottom: Integer);
begin
  Create(Rect(ALeft, ATop, ARight, ABottom));
end;

destructor TcxRegion.Destroy;
begin
  DestroyHandle;
  inherited;
end;

function TcxRegion.GetIsEmpty: Boolean;
{$IFDEF VCL}
var
  R: TRect;
{$ENDIF}
begin
{$IFDEF VCL}
  Result := GetRgnBox(FHandle, R) = NULLREGION;
{$ELSE}
  Result := QRegion_isEmpty(FHandle);
{$ENDIF}
end;

procedure TcxRegion.DestroyHandle;
begin
{$IFDEF VCL}
  if FHandle <> 0 then
  begin
    DeleteObject(FHandle);
    FHandle := 0;
  end;
{$ELSE}
  if FHandle <> nil then
  begin
    QRegion_destroy(FHandle);
    FHandle := nil;
  end;
{$ENDIF}
end;

procedure TcxRegion.Combine(ARegion: TcxRegion; AOperation: TcxRegionOperation;
  ADestroyRegion: Boolean = True);
{$IFDEF VCL}
const
  Modes: array[TcxRegionOperation] of Integer = (RGN_COPY, RGN_OR, RGN_DIFF, RGN_AND);
{$ENDIF}
begin
{$IFDEF VCL}
  if AOperation = roSet then
    CombineRgn(FHandle, ARegion.Handle, 0, Modes[AOperation])
  else
    CombineRgn(FHandle, FHandle, ARegion.Handle, Modes[AOperation]);
{$ELSE}
  case AOperation of
    roSet:
      {};
    roAdd:
      QRegion_unite(FHandle, FHandle, ARegion.Handle);
    roSubtract:
      QRegion_subtract(FHandle, FHandle, ARegion.Handle);
    roIntersect:
      QRegion_intersect(FHandle, FHandle, ARegion.Handle);
  end;
{$ENDIF}
  if ADestroyRegion then ARegion.Free;
end;

function TcxRegion.IsEqual(ARegion: TcxRegion): Boolean;
begin
  Result := (ARegion <> nil) and ((IsEmpty and ARegion.IsEmpty) or IsEqual(ARegion.Handle));
end;

function TcxRegion.IsEqual(ARegionHandle: TcxRegionHandle): Boolean;
begin
  Result := EqualRgn(Handle, ARegionHandle);
end;

procedure TcxRegion.Offset(DX, DY: Integer);
begin
{$IFDEF VCL}
  OffsetRgn(FHandle, DX, DY);
{$ELSE}
  QRegion_translate(FHandle, DX, DY);
{$ENDIF}
end;

function TcxRegion.PtInRegion(const Pt: TPoint): Boolean;
begin
{$IFDEF VCL}
  Result := Windows.PtInRegion(Handle, Pt.X, Pt.Y);
{$ELSE}
  Result := QRegion_contains(Handle, @Pt);
{$ENDIF}
end;

function TcxRegion.PtInRegion(X, Y: Integer): Boolean;
begin
  Result := PtInRegion(Point(X, Y));
end;

function TcxRegion.RectInRegion(const R: TRect): Boolean;
begin
{$IFDEF VCL}
  Result := Windows.RectInRegion(Handle, R);
{$ELSE}
  Result := QRegion_contains(Handle, @R);
{$ENDIF}
end;

function TcxRegion.RectInRegion(ALeft, ATop, ARight, ABottom: Integer): Boolean;
begin
  Result := RectInRegion(Rect(ALeft, ATop, ARight, ABottom));
end;

{ TcxCanvas }

constructor TcxCanvas.Create(ACanvas: TCanvas);
begin
  inherited Create;
  FCanvas := ACanvas;
  FSavedDCs := TList.Create;
  FSavedRegions := TList.Create;
end;

destructor TcxCanvas.Destroy;
begin
  FreeAndNil(FSavedRegions);
  FreeAndNil(FSavedDCs);
  inherited;
end;

function TcxCanvas.GetBrush: TBrush;
begin
  Result := Canvas.Brush;
end;

function TcxCanvas.GetCopyMode: TCopyMode;
begin
  Result := Canvas.CopyMode;
end;

function TcxCanvas.GetDCOrigin: TPoint;
var
  AWindowOrg, AViewportOrg: TPoint;
begin
  AWindowOrg := WindowOrg;
  AViewportOrg := ViewportOrg;
  Result := Point(AViewportOrg.X - AWindowOrg.X, AViewportOrg.Y - AWindowOrg.Y);
end;

function TcxCanvas.GetFont: TFont;
begin
  Result := Canvas.Font;
end;

function TcxCanvas.GetHandle: {$IFDEF VCL}HDC{$ELSE}QPainterH{$ENDIF};
begin
  Result := Canvas.Handle;
end;

function TcxCanvas.GetPen: TPen;
begin
  Result := Canvas.Pen;
end;

function TcxCanvas.GetViewportOrg: TPoint;
begin
  GetViewportOrgEx(Handle, Result);
end;

function TcxCanvas.GetWindowOrg: TPoint;
{$IFNDEF VCL}
var
  R: TRect;
{$ENDIF}
begin
{$IFDEF VCL}
  GetWindowOrgEx(Handle, Result);
{$ELSE}
  QPainter_window(Handle, @R);
  Result := R.TopLeft;
{$ENDIF}
end;

procedure TcxCanvas.SetBrush(Value: TBrush);
begin
  Canvas.Brush := Value;
end;

procedure TcxCanvas.SetCopyMode(Value: TCopyMode);
begin
  Canvas.CopyMode := Value;
end;

procedure TcxCanvas.SetFont(Value: TFont);
begin
  Canvas.Font := Value;
end;

procedure TcxCanvas.SetPen(Value: TPen);
begin
  Canvas.Pen := Value;
end;

procedure TcxCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
{$IFDEF VCL}
  Canvas.Pixels[X, Y] := Value;
{$ELSE}
  SetBrushColor(Value);
  FillRect(Rect(X, Y, X + 1, Y + 1));
{$ENDIF}
end;

procedure TcxCanvas.SetViewportOrg(const P: TPoint);
begin
  SetViewportOrgEx(Handle, P.X, P.Y, nil);
end;

procedure TcxCanvas.SetWindowOrg(const P: TPoint);
{$IFNDEF VCL}
var
  ACanvasHandle: QPainterH;
  R: TRect;
{$ENDIF}
begin
{$IFDEF VCL}
  SetWindowOrgEx(Handle, P.X, P.Y, nil);
{$ELSE}
  ACanvasHandle := Handle;
  QPainter_window(ACanvasHandle, @R);
  OffsetRect(R, P.X - R.Left, P.Y - R.Top);
  QPainter_setWindow(ACanvasHandle, @R);
{$ENDIF}
end;

procedure TcxCanvas.SynchronizeObjects(ADC: THandle);

  procedure AssignFont;
  var
    ALogFont: TLogFont;
  begin
    cxGetFontData(GetCurrentObject(ADC, OBJ_FONT), ALogFont);
    Font.Handle := CreateFontIndirect(ALogFont);
    Font.Color := GetTextColor(ADC);
  end;

  procedure AssignBrush;

    function GetBrushStyle(const ALogBrush: TLogBrush): TBrushStyle;
    begin
      Result := bsSolid;
      case ALogBrush.lbStyle of  // TODO lbStyle = BS_PATTERN
        BS_HATCHED:
          case ALogBrush.lbHatch of
            HS_BDIAGONAL: Result := bsBDiagonal;
            HS_CROSS: Result := bsCross;
            HS_DIAGCROSS: Result := bsDiagCross;
            HS_FDIAGONAL: Result := bsFDiagonal;
            HS_HORIZONTAL: Result := bsHorizontal;
            HS_VERTICAL: Result := bsVertical;
          end;
        BS_HOLLOW:
          Result := bsClear;
      end;
    end;

  var
    ALogBrush: TLogBrush;
  begin
    cxGetBrushData(GetCurrentObject(ADC, OBJ_BRUSH), ALogBrush);
    Brush.Handle := CreateBrushIndirect(ALogBrush);
    Brush.Color := ALogBrush.lbColor;  // required: set Color before Style
    Brush.Style := GetBrushStyle(ALogBrush)
  end;

  procedure AssignPen;

    function GetPenStyle(const ALogPen: TLogPen): TPenStyle;
    begin
      Result := TPenStyle(ALogPen.lopnStyle);
    end;

    function GetPenMode: TPenMode;
    const
      PenModes: array[TPenMode] of Integer =
        (R2_BLACK, R2_WHITE, R2_NOP, R2_NOT, R2_COPYPEN, R2_NOTCOPYPEN, R2_MERGEPENNOT,
         R2_MASKPENNOT, R2_MERGENOTPEN, R2_MASKNOTPEN, R2_MERGEPEN, R2_NOTMERGEPEN,
         R2_MASKPEN, R2_NOTMASKPEN, R2_XORPEN, R2_NOTXORPEN);
    var
      I: TPenMode;
      ADrawMode: Integer;
    begin
      Result := pmCopy;
      ADrawMode := GetROP2(ADC);
      for I := Low(TPenMode) to High(TPenMode) do
        if PenModes[I] = ADrawMode then
          Result := I;
    end;

  var
    ALogPen: TLogPen;
  begin
    cxGetPenData(GetCurrentObject(ADC, OBJ_PEN), ALogPen);
    Pen.Handle := CreatePenIndirect(ALogPen);
    Pen.Color := ALogPen.lopnColor;
    Pen.Style := GetPenStyle(ALogPen);
    Pen.Mode := GetPenMode;
    Pen.Width := ALogPen.lopnWidth.X;
  end;

begin
  AssignFont;
  AssignBrush;
  AssignPen;
end;

procedure TcxCanvas.AlignMultiLineTextRectVertically(var R: TRect;
  const AText: string; AAlignmentVert: TcxAlignmentVert;
  AWordBreak, AShowPrefix: Boolean; AEnabled: Boolean = True;
  ADontBreakChars: Boolean = False);
var
  ASizeR: TRect;
  AFlags: Integer;
begin
  if AAlignmentVert = vaTop then Exit;
  ASizeR := Rect(0, 0, R.Right - R.Left - Ord(not AEnabled), 0);
  AFlags := cxAlignLeft or cxAlignTop;
  if AWordBreak then
    AFlags := AFlags or cxWordBreak;
  if AShowPrefix then
    AFlags := AFlags or cxShowPrefix;
  if ADontBreakChars then
    AFlags := AFlags or cxDontBreakChars;
  TextExtent(AText, ASizeR, AFlags);
  case AAlignmentVert of
    vaCenter:
      R.Top := (R.Top + R.Bottom - (ASizeR.Bottom - ASizeR.Top)) div 2;
    vaBottom:
      R.Top := R.Bottom - (ASizeR.Bottom - ASizeR.Top + Ord(not AEnabled));
  end;
end;

procedure TcxCanvas.CopyRect(const Dest: TRect; ACanvas: TCanvas;
  const Source: TRect);
begin
{$IFNDEF VCL}
  if IsRectEmpty(Dest) or IsRectEmpty(Source) then Exit;
{$ENDIF}
  Canvas.CopyRect(Dest, ACanvas, Source);
end;

procedure TcxCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  Canvas.Draw(X, Y, Graphic);
end;

procedure TcxCanvas.DrawComplexFrame(const R: TRect;
  ALeftTopColor, ARightBottomColor: TColor; ABorders: TcxBorders;
  ABorderWidth: Integer);
var
  ABorder: TcxBorder;

  function GetBorderColor: TColor;
  begin
    if ABorder in [bLeft, bTop] then
      Result := ALeftTopColor
    else
      Result := ARightBottomColor;
  end;

  function GetBorderBounds: TRect;
  begin
    Result := R;
    with Result do
      case ABorder of
        bLeft:
          Right := Left + ABorderWidth;
        bTop:
          Bottom := Top + ABorderWidth;
        bRight:
          Left := Right - ABorderWidth;
        bBottom:
          Top := Bottom - ABorderWidth;
      end;
  end;

begin
  for ABorder := Low(ABorder) to High(ABorder) do
    if ABorder in ABorders then
    begin
      SetBrushColor(GetBorderColor);
      FillRect(GetBorderBounds);
    end;
end;

procedure TcxCanvas.DrawEdge(const R: TRect; ASunken, AOuter: Boolean;
  ABorders: TcxBorders);
begin
  if ASunken then
    if AOuter then
      DrawComplexFrame(R, clBtnShadow, clBtnHighlight, ABorders)
    else
      DrawComplexFrame(R, cl3DDkShadow{clBtnText}, cl3DLight{clBtnFace}, ABorders)
  else
    if AOuter then
      DrawComplexFrame(R, cl3DLight{clBtnFace}, cl3DDkShadow{clBtnText}, ABorders)
    else
      DrawComplexFrame(R, clBtnHighlight, clBtnShadow, ABorders);
end;

procedure TcxCanvas.DrawFocusRect(const R: TRect);
begin
  SetBrushColor(clWhite);
{$IFDEF VCL}
  Canvas.Font.Color := clBlack;
{$IFNDEF CLR}
  TCanvasAccess(Canvas).RequiredState([csFontValid]);
{$ELSE}
  Canvas.Handle;
{$ENDIF}
{$ELSE}
  Canvas.Pen.Color := clBlack;
{$ENDIF}
  Canvas.DrawFocusRect(R);
end;

procedure TcxCanvas.DrawGlyph(X, Y: Integer; AGlyph: TBitmap; AEnabled: Boolean = True;
  ABackgroundColor: TColor = clNone{; ATempCanvas: TCanvas = nil});
var
{$IFDEF VCL}
  APrevBrushStyle: TBrushStyle;
{$ENDIF}  
  AImageList: TImageList;
  ABitmap: TBitmap;
begin
{$IFDEF VCL}
  if AEnabled {and (ATempCanvas = nil)} then
  begin
    APrevBrushStyle := Brush.Style;
    if ABackgroundColor = clNone then
      Brush.Style := bsClear
    else
      Brush.Color := ABackgroundColor;
    Canvas.BrushCopy(Bounds(X, Y, AGlyph.Width, AGlyph.Height), AGlyph,
      Rect(0, 0, AGlyph.Width, AGlyph.Height), AGlyph.TransparentColor);
    Brush.Style := APrevBrushStyle;
    Exit;
  end;
{$ENDIF}

  AImageList := nil;
  ABitmap := nil;
  try
    AImageList := TImageList.Create(nil);
    AImageList.Width := AGlyph.Width;
    AImageList.Height := AGlyph.Height;
    if ABackgroundColor <> clNone then
      //if ATempCanvas = nil then
      begin
        ABitmap := TBitmap.Create;
        ABitmap.Width := AImageList.Width;
        ABitmap.Height := AImageList.Height;
        with ABitmap.Canvas do
        begin
          Brush.Color := ABackgroundColor;
          FillRect(Rect(0, 0, ABitmap.Width, ABitmap.Height));
        end;
      end
      {else
        with ATempCanvas do
        begin
          Brush.Color := ABackgroundColor;
          FillRect(Bounds(X, Y, AGlyph.Width, AGlyph.Height));
        end};

    if AGlyph.TransparentMode = tmFixed then
      AImageList.AddMasked(AGlyph, AGlyph.TransparentColor)
    else
      AImageList.AddMasked(AGlyph, clDefault);

    if ABitmap <> nil then
    begin
      AImageList.Draw(ABitmap.Canvas, 0, 0, 0{$IFNDEF VCL}, itImage{itMask}{$ENDIF}, AEnabled); // ??? itMask TODO
      Draw(X, Y, ABitmap);
    end
    else
      (*if ATempCanvas <> nil then
        AImageList.Draw(ATempCanvas, X, Y, 0{$IFNDEF VCL}, itMask{$ENDIF}, AEnabled) // ??? itMask TODO
      else*)
        AImageList.Draw(Canvas, X, Y, 0{$IFNDEF VCL}, itImage{itMask}{$ENDIF}, AEnabled); // ??? itMask TODO
  finally
    ABitmap.Free;
    AImageList.Free;
  end;        
end;

procedure TcxCanvas.DrawImage(Images: TCustomImageList; X, Y, Index: Integer;
  Enabled: Boolean = True);
begin
  if (0 <= Index) and (Index < Images.Count) then
  begin
    SaveDC;
    Images.Draw(Canvas, X, Y, Index, {$IFNDEF VCL}itImage, {$ENDIF}Enabled);
    RestoreDC;
  end;
end;

procedure TcxCanvas.DrawText(const Text: string; R: TRect; Flags: Integer;
  Enabled: Boolean);
var
{$IFDEF VCL}
  AUseDrawText: Boolean;
{$ENDIF}
  PrevBrushStyle: TBrushStyle;
  PrevFontColor: TColor;

  procedure ProcessFlags;
  var
    ASize: TSize;
  {$IFDEF VCL}
    AAlignmentVert: TcxAlignmentVert;
  {$ENDIF}
  begin
    ASize := TextExtent(Text);
    if (ASize.cx <= R.Right - R.Left) and (ASize.cy <= R.Bottom - R.Top) then
      Flags := Flags or cxDontClip;
  {$IFDEF VCL}
    if AUseDrawText then
    begin
      if (Flags and cxSingleLine = 0) and (Flags and (cxAlignBottom or cxAlignVCenter) <> 0) then
      begin
        if Flags and cxAlignBottom <> 0 then
          AAlignmentVert := vaBottom
        else
          AAlignmentVert := vaCenter;
        AlignMultiLineTextRectVertically(R, Text, AAlignmentVert,
          cxWordBreak and Flags <> 0, cxShowPrefix and Flags <> 0, Enabled,
          cxDontBreakChars and Flags <> 0);
      end;
      Flags := cxFlagsToDTFlags(Flags);
    end
    else
    begin
      if ASize.cx < R.Right - R.Left then
        case Flags and (cxAlignLeft or cxAlignRight or cxAlignHCenter) of
          cxAlignRight:
            R.Left := R.Right - ASize.cx - Ord(not Enabled);
          cxAlignHCenter:
            R.Left := (R.Left + R.Right - ASize.cx) div 2;
        end;
      if ASize.cy < R.Bottom - R.Top then
        case Flags and (cxAlignTop or cxAlignBottom or cxAlignVCenter) of
          cxAlignBottom:
            R.Top := R.Bottom - ASize.cy - Ord(not Enabled);
          cxAlignVCenter:
            R.Top := (R.Top + R.Bottom - ASize.cy) div 2;
        end;
      if Flags and cxDontClip = 0 then
        Flags := ETO_CLIPPED
      else
        Flags := 0;
    end;
  {$ELSE}
    Flags := Flags and not (cxShowEndEllipsis or cxShowPathEllipsis);
  {$ENDIF}
  end;

  procedure DoDrawText;
  begin
  {$IFDEF VCL}
    if AUseDrawText then
      cxDrawText(Canvas.Handle, Text, R, Flags)
    else
      cxExtTextOut(Canvas.Handle, Text, R.TopLeft, R, Flags);
  {$ELSE}
    Canvas.TextRect(R, R.Left, R.Top, Text, Flags);
  {$ENDIF}
  end;

begin
  if Length(Text) = 0 then Exit;
{$IFDEF VCL}
  AUseDrawText := (Flags and cxSingleLine = 0) or
    (Flags and (cxShowPrefix or cxShowEndEllipsis or cxShowPathEllipsis) <> 0);
{$ENDIF}
  ProcessFlags;
  PrevBrushStyle := Brush.Style;
  PrevFontColor := Font.Color;
  if not Enabled then
  begin
    with R do
    begin
      Inc(Left);
      Inc(Top);
    end;
    Brush.Style := bsClear;
    Font.Color := clBtnHighlight;
    DoDrawText;
    OffsetRect(R, -1, -1);
    Font.Color := clBtnShadow;
  end;
  DoDrawText;
  if Brush.Style <> PrevBrushStyle then
    Brush.Style := PrevBrushStyle;
  Font.Color := PrevFontColor;
end;
                                 
procedure TcxCanvas.FillRect(const R: TRect; AColor: TColor); 
begin
  if AColor = clNone then Exit; 
  if AColor <> clDefault then
    SetBrushColor(AColor);
  Canvas.FillRect(R);
end;

procedure TcxCanvas.FillRect(const R: TRect; ABitmap: TBitmap = nil;
  AExcludeRect: Boolean = False);
var
  ABitmapSize, AOffset: TPoint;
  AFirstCol, AFirstRow, ALastCol, ALastRow, I, J: Integer;
  ABitmapRect, ACellRect: TRect;
begin
  if IsRectEmpty(R) then Exit;
  if not IsGlyphAssigned(ABitmap) then
    Canvas.FillRect(R)
  else
    with ABitmapSize do
    begin
      X := ABitmap.Width;
      Y := ABitmap.Height;
      AFirstCol := R.Left div X;
      AFirstRow := R.Top div Y;
      ALastCol := R.Right div X - Ord(R.Right mod X = 0);
      ALastRow := R.Bottom div Y - Ord(R.Bottom mod Y = 0);
      for J := AFirstRow to ALastRow do
        for I := AFirstCol to ALastCol do
        begin
          AOffset.X := I * X;
          AOffset.Y := J * Y;
          ACellRect := Bounds(AOffset.X, AOffset.Y, X, Y);
          IntersectRect(ACellRect, ACellRect, R);
          ABitmapRect := ACellRect;
          OffsetRect(ABitmapRect, -AOffset.X, -AOffset.Y);
          CopyRect(ACellRect, ABitmap.Canvas, ABitmapRect);
        end;
    end;
  if AExcludeRect then
    SetClipRegion(TcxRegion.Create(R), roSubtract);
end;

procedure TcxCanvas.FillRect(R: TRect; const AParams: TcxViewParams;
  ABorders: TcxBorders = []; ABorderColor: TColor = clDefault;
  ALineWidth: Integer = 1; AExcludeRect: Boolean = False);
begin
  FrameRect(R, ABorderColor, ALineWidth, ABorders, AExcludeRect);
  with R do
  begin
    if bLeft in ABorders then
      Inc(Left, ALineWidth);
    if bRight in ABorders then
      Dec(Right, ALineWidth);
    if bTop in ABorders then
      Inc(Top, ALineWidth);
    if bBottom in ABorders then
      Dec(Bottom, ALineWidth);
  end;
  SetBrushColor(AParams.Color);
  FillRect(R, AParams.Bitmap, AExcludeRect);
end;

{$IFDEF LINUX}

procedure TcxCanvas.FillRect(const R: TRect; ABrush: TBrush);
begin
  QPainter_fillRect(Handle, @R, ABrush.Handle);
end;

{$ELSE}

procedure TcxCanvas.DrawDesignSelection(ARect: TRect; AWidth: Integer = cxDesignSelectionWidth);
var
  I: Integer;
begin
  for I := 0 to AWidth - 1 do
  begin
    DrawFocusRect(ARect);
    InflateRect(ARect, -1, -1);
  end;
end;

procedure TcxCanvas.DrawRegion(ARegion: TcxRegion; AContentColor: TColor = clDefault;
  ABorderColor: TColor = clDefault; ABorderWidth: Integer = 1; ABorderHeight: Integer = 1);
begin
  DrawRegion(ARegion.Handle, AContentColor, ABorderColor, ABorderWidth, ABorderHeight);
end;

procedure TcxCanvas.DrawRegion(ARegion: TcxRegionHandle; AContentColor: TColor = clDefault;
  ABorderColor: TColor = clDefault; ABorderWidth: Integer = 1; ABorderHeight: Integer = 1);
begin
  FillRegion(ARegion, AContentColor);
  FrameRegion(ARegion, ABorderColor, ABorderWidth, ABorderHeight);
end;

procedure TcxCanvas.FillRegion(ARegion: TcxRegion; AColor: TColor = clDefault);
begin
  FillRegion(ARegion.Handle, AColor);
end;

procedure TcxCanvas.FillRegion(ARegion: TcxRegionHandle; AColor: TColor = clDefault);
begin
  SetBrushColor(AColor);
  FillRgn(Handle, ARegion, Brush.Handle);
end;

procedure TcxCanvas.FlipHorizontally(ABitmap: TBitmap);
var
  Bits: TRGBColors;
  ARow, ACol, W, H, ARowStart: Integer;
  AValue: TRGBQuad;
begin
  W := ABitmap.Width;
  H := ABitmap.Height;

  Bits := GetBitmapBits(ABitmap, True);
  ARowStart := 0;
  for ARow := 0 to H - 1 do
  begin
    for ACol := 0 to (W - 1) div 2 do
    begin
      AValue := Bits[ARowStart + ACol];
      Bits[ARowStart + ACol] := Bits[ARowStart + W - 1 - ACol];
      Bits[ARowStart + W - 1 - ACol] := AValue;
    end;
    Inc(ARowStart, W);
  end;
  SetBitmapBits(ABitmap, Bits, True);
end;

procedure TcxCanvas.FrameRegion(ARegion: TcxRegion; AColor: TColor = clDefault;
  ABorderWidth: Integer = 1; ABorderHeight: Integer = 1);
begin
  FrameRegion(ARegion.Handle, AColor, ABorderWidth, ABorderHeight);
end;

procedure TcxCanvas.FrameRegion(ARegion: TcxRegionHandle; AColor: TColor = clDefault;
  ABorderWidth: Integer = 1; ABorderHeight: Integer = 1);
begin
  SetBrushColor(AColor);
  FrameRgn(Handle, ARegion, Brush.Handle, ABorderWidth, ABorderHeight);
end;

procedure TcxCanvas.Pie(const R: TRect; const ARadial1, ARadial2: TPoint);
begin
  with R do
    Canvas.Pie(Left, Top, Right, Bottom, ARadial1.X, ARadial1.Y, ARadial2.X, ARadial2.Y);
end;

procedure TcxCanvas.Pie(const R: TRect; AStartAngle, ASweepAngle: Integer);

{
                      A * B
  V = ---------------------------------------------
      Sqrt(A^2 * Sin^2(Alpha) + B^2 * Cos^2(Alpha))

  Radial.X = V * Cos(Alpha)
  Radial.Y = V * Sin(Alpha)

  where:
    A - horizontal ellipse semiaxis
    B - vertical ellipse semiaxis
    Angle - an angle between Radius-Vector and A calculated in counterclockwise direction
}

  function CalculateRadial(A, B: Integer; const ACenter: TPoint; AnAngle: Integer): TPoint;
  var
    Sin, Cos, V: Extended;
  begin
    SinCos(DegToRad(AnAngle), Sin, Cos);
    if (A <> 0) and (B <> 0) then
      V := A * B / Sqrt(A * A * Sin * Sin + B * B * Cos * Cos)
    else
      V := 0;
    Result.X := ACenter.X + Round(V * Cos);
    Result.Y := ACenter.Y - Round(V * Sin);
  end;

var
  A, B: Integer;
  Center, Radial1, Radial2: TPoint;
begin
  if IsRectEmpty(R) or (ASweepAngle = 0) then Exit;
  with R do
  begin
    A := (Right - Left) div 2;
    B := (Bottom - Top) div 2;
    Center.X := Left + A;
    Center.Y := Top + B;
  end;
  Radial1 := CalculateRadial(A, B, Center, AStartAngle);
  if ASweepAngle = 360 then
    Radial2 := Radial1
  else
    Radial2 := CalculateRadial(A, B, Center, AStartAngle + ASweepAngle);
  if (Radial1.X <> Radial2.X) or (Radial1.Y <> Radial2.Y) or (ASweepAngle > 180) then
    Pie(R, Radial1, Radial2);
end;

{$ENDIF}

function TcxCanvas.FontHeight(AFont: TFont): Integer;
begin
  Font := AFont;
  Result := TextHeight('Qq');
end;

procedure TcxCanvas.FrameRect(const R: TRect; Color: TColor = clDefault;
  ALineWidth: Integer = 1; ABorders: TcxBorders = cxBordersAll;
  AExcludeFrame: Boolean = False);
begin
  if IsRectEmpty(R) then Exit;
  if Color <> clDefault then
  begin
    SetBrushColor(Color);
  {$IFNDEF VCL}
    Brush.Style := bsSolid;  // bug in Qt
  {$ENDIF}  
  end;
  with R do
  begin
    if bLeft in ABorders then
      FillRect(Rect(Left, Top, Min(Left + ALineWidth, Right), Bottom), nil, AExcludeFrame);
    if bRight in ABorders then
      FillRect(Rect(Max(Right - ALineWidth, Left), Top, Right, Bottom), nil, AExcludeFrame);
    if bTop in ABorders then
      FillRect(Rect(Left, Top, Right, Min(Top + ALineWidth, Bottom)), nil, AExcludeFrame);
    if bBottom in ABorders then
      FillRect(Rect(Left, Max(Bottom - ALineWidth, Top), Right, Bottom), nil, AExcludeFrame);
  end;
end;

procedure TcxCanvas.InvertFrame(const R: TRect; ABorderSize: Integer);
begin
  with R do
  begin
    InvertRect(Rect(Left, Top, Left + ABorderSize, Bottom));
    InvertRect(Rect(Right - ABorderSize, Top, Right, Bottom));
    InvertRect(Rect(Left + ABorderSize, Top,
      Right - ABorderSize, Top + ABorderSize));
    InvertRect(Rect(Left + ABorderSize, Bottom - ABorderSize,
      Right - ABorderSize, Bottom));
  end;
end;

procedure TcxCanvas.InvertRect({$IFNDEF LINUX}const {$ENDIF}R: TRect);
begin
{$IFDEF LINUX}
  IntersectRect(R, R, Canvas.ClipRect);
{$ENDIF}
  with Canvas do
  begin
    CopyMode := cmDstInvert;
    CopyRect(R, Canvas, R);
    CopyMode := cmSrcCopy;
  end;
end;

procedure TcxCanvas.LineTo(X, Y: Integer);
begin
  Canvas.LineTo(X, Y);
end;

procedure TcxCanvas.MoveTo(X, Y: Integer);
begin
  Canvas.MoveTo(X, Y);
end;

procedure TcxCanvas.Polygon(const Points: array of TPoint);
begin
  Canvas.Polygon(Points{$IFNDEF VCL}, False, 0, -1{$ENDIF});
end;

procedure TcxCanvas.Polyline(const Points: array of TPoint);
begin
  Canvas.Polyline(Points);
end;

{$IFDEF VCL}

procedure TcxCanvas.RotateBitmap(ABitmap: TBitmap; ARotationAngle: TcxRotationAngle;
  AFlipVertically: Boolean = False);
var
  SourceRGBs, DestRGBs: TRGBColors;
  ARow, ACol, H, W, ASourceI, ADestI: Integer;
begin
  SourceRGBs := nil; // to remove compiler's warning
  if (ARotationAngle = ra0) and not AFlipVertically then exit;
  H := ABitmap.Height;
  W := ABitmap.Width;

  SourceRGBs := GetBitmapBits(ABitmap, True);
  SetLength(DestRGBs, Length(SourceRGBs));

  for ARow := 0 to H - 1 do
    for ACol := 0 to W - 1 do
    begin
      ASourceI := ARow * W + ACol;
      case ARotationAngle of
        raPlus90:
          if AFlipVertically then
            ADestI := ACol * H + ARow
          else
            ADestI := (W - ACol - 1) * H + ARow;
        ra0:
          ADestI := (H - 1 - ARow) * W + ACol;
        ra180:
          if AFlipVertically then
            ADestI := ARow * W + W - ACol - 1
          else
            ADestI := (H - ARow - 1) * W + W - ACol - 1;
      else
        if AFlipVertically then
          ADestI := (W - ACol - 1) * H + H - ARow - 1
        else
          ADestI := H - 1 + ACol * H - ARow;
      end;
      DestRGBs[ADestI] := SourceRGBs[ASourceI];
    end;

  if ARotationAngle in [raPlus90, raMinus90] then
  begin
  {$IFNDEF CLR}
    ABitmap.Height := 0;
  {$ENDIF}
    ABitmap.Width := H;
    ABitmap.Height := W;
  end;
  SetBitmapBits(ABitmap, DestRGBs, True);
end;

{$ELSE}

procedure RotateBitmap(Bitmap: TBitmap; Angle: TcxRotationAngle);
var
  PDest, PDestStart: ^DWord;
  PSource: ^DWord;
  PBuffer: Pointer;
  XSource, YSource: Integer;
  LineCopyingDirection: Integer;
  TempVar: Integer;
begin
  case Angle of
    raPlus90, raMinus90:
      with Bitmap do
      begin
        GetMem(PBuffer, Width * Height * 4);

        LineCopyingDirection := 0;
        PDestStart := PBuffer;
        case Angle of
          raPlus90:
            begin
              Inc(PDestStart, Height * (Width - 1));
              LineCopyingDirection := 1;
            end;
          raMinus90:
            begin
              Inc(PDestStart, Height - 1);
              LineCopyingDirection := -1;
            end;
        end;

        for YSource := 0 to Height - 1 do
        begin
          PSource := ScanLine[YSource];
          PDest := PDestStart;
          for XSource := 0 to Width - 1 do
          begin
            PDest^ := PSource^;
            Dec(PDest, Height * LineCopyingDirection);
            Inc(PSource);
          end;
          Inc(PDestStart, LineCopyingDirection);
        end;

        TempVar := Width;
        Width := Height;
        Height := TempVar;
        if Width = Height then
        begin
          Width := Width + 1;
          Width := Width - 1;
        end;

        PDest := PBuffer;
        for YSource := 0 to Height - 1 do
        begin
          Move(PDest^, ScanLine[YSource]^, Width * 4);
          Inc(PDest, Width);
        end;

        FreeMem(PBuffer);
      end;
  end;
end;

{$ENDIF}

function TcxCanvas.TextExtent(const Text: string): TSize;
begin
{$IFDEF VCL}
{$IFNDEF CLR}
  TCanvasAccess(Canvas).RequiredState([csHandleValid, csFontValid]);
{$ELSE}
  Canvas.Handle;
{$ENDIF}
  Result.cX := 0;
  Result.cY := 0;
  GetTextExtentPoint(Handle, {$IFNDEF CLR}PChar{$ENDIF}(Text), Length(Text), Result);
{$ELSE}
  Result := Canvas.TextExtent(Text, 0);
{$ENDIF}
end;

procedure TcxCanvas.TextExtent(const Text: string; var R: TRect; Flags: Integer);
{$IFDEF VCL}
var
  RWidth, RHeight, TextWidth, TextHeight: Integer;

  procedure CalcRSizes(var AWidth, AHeight: Integer);
  begin
    with R do
    begin
      AWidth := Right - Left;
      AHeight := Bottom - Top;
    end;
  end;

  procedure AlignR;
  begin
    if Flags and DT_CENTER <> 0 then
      OffsetRect(R, (RWidth - TextWidth) div 2, 0)
    else
      if Flags and DT_RIGHT <> 0 then
        OffsetRect(R, RWidth - TextWidth, 0);
    if Flags and DT_VCENTER <> 0 then
      OffsetRect(R, 0, (RHeight - TextHeight) div 2)
    else
      if Flags and DT_BOTTOM <> 0 then
        OffsetRect(R, 0, RHeight - TextHeight);
  end;

begin
  CalcRSizes(RWidth, RHeight);
  Flags := cxFlagsToDTFlags(Flags);
  if (RWidth <= 0) and (Text <> '') then  // A2079
    R.Right := R.Left + 1;
  if cxDrawText(Canvas.Handle, Text, R, Flags and not DT_VCENTER or DT_CALCRECT) = 0 then
  begin
    R.Right := R.Left;
    R.Bottom := R.Top;
  end;
  CalcRSizes(TextWidth, TextHeight);
  AlignR;
end;
{$ELSE}
begin
  Canvas.TextExtent(Text, R, Flags);
end;
{$ENDIF}

function TcxCanvas.TextHeight(const Text: string): Integer;
begin
  Result := TextExtent(Text).cy;
end;

function TcxCanvas.TextWidth(const Text: string): Integer;
begin
  Result := TextExtent(Text).cx;
end;

procedure TcxCanvas.TransparentDraw(X, Y: Integer; ABitmap: TBitmap; AAlpha: Byte;
  ABackground: TBitmap = nil);

  function BlendValues(ASource, ADestination: DWORD): DWORD;
  begin
    Result := MulDiv(ASource, AAlpha, 255) + MulDiv(ADestination, 255 - AAlpha, 255);
  end;

  procedure BlendValue(const ASource: TRGBQuad; var ADestination: TRGBQuad);
  begin
    ADestination.rgbBlue := BlendValues(ASource.rgbBlue, ADestination.rgbBlue);
    ADestination.rgbGreen := BlendValues(ASource.rgbGreen, ADestination.rgbGreen);
    ADestination.rgbRed := BlendValues(ASource.rgbRed, ADestination.rgbRed);
  end;

var
  W, H, ARow, ACol: Integer;
  ABackgroundBitmap: TBitmap;
  ABlendFunction: TBlendFunction;
  ABits, ABackgroundBits: TRGBColors;
begin
  ABits := nil; // to remove compiler's warning
  W := ABitmap.Width;
  H := ABitmap.Height;

  ABackgroundBitmap := TBitmap.Create;
  ABackgroundBitmap.Width := W;
  ABackgroundBitmap.Height := H;

  if ABackground = nil then
    ABackgroundBitmap.Canvas.CopyRect(Rect(0, 0, W, H), Canvas, Bounds(X, Y, W, H))
  else
    ABackgroundBitmap.Canvas.Draw(0, 0, ABackground);

  if Assigned(VCLAlphaBlend) then
  begin
    ABlendFunction := DefaultBlendFunction;
    ABlendFunction.SourceConstantAlpha := AAlpha;
    {$IFDEF CLR}AlphaBlend{$ELSE}VCLAlphaBlend{$ENDIF}(ABackgroundBitmap.Canvas.Handle,
      0, 0, W, H, ABitmap.Canvas.Handle, 0, 0, W, H, ABlendFunction);
  end
  else
  begin
    ABits := GetBitmapBits(ABitmap, True);
    ABackgroundBits := GetBitmapBits(ABackgroundBitmap, True);

    for ARow := 0 to H - 1 do
      for ACol := 0 to W - 1 do
        BlendValue(ABits[ACol * H + ARow], ABackgroundBits[ACol * H + ACol]);

    SetBitmapBits(ABackgroundBitmap, ABackgroundBits, True);
  end;

  Draw(X, Y, ABackgroundBitmap);

  ABackgroundBitmap.Free;
end;

procedure TcxCanvas.RestoreDC;
var
  ALastSavedDCIndex: Integer;
begin
  ALastSavedDCIndex := FSavedDCs.Count - 1;
  if ALastSavedDCIndex >= 0 then
  begin
    Windows.RestoreDC(Handle, Integer(FSavedDCs[ALastSavedDCIndex]));
    FSavedDCs.Delete(ALastSavedDCIndex);
  end;
end;

procedure TcxCanvas.SaveDC;
begin
  FSavedDCs.Add(TObject(Windows.SaveDC(Handle)));
end;

procedure TcxCanvas.RestoreClipRegion;
var
  ALastSavedRegionIndex: Integer;
begin
  ALastSavedRegionIndex := FSavedRegions.Count - 1;
  if ALastSavedRegionIndex >= 0 then
  begin
    SetClipRegion(TcxRegion(FSavedRegions[ALastSavedRegionIndex]), roSet);
    FSavedRegions.Delete(ALastSavedRegionIndex);
  end;
end;

procedure TcxCanvas.SaveClipRegion;
begin
  FSavedRegions.Add(GetClipRegion);
end;

procedure TcxCanvas.RestoreState;

  procedure InternalRestoreState(var ACurrentState: TcxCanvasState);
  begin
    Font.Assign(ACurrentState.Font);
    ACurrentState.Font.Free;
    Brush.Assign(ACurrentState.Brush);
    ACurrentState.Brush.Free;
    Pen.Assign(ACurrentState.Pen);
    ACurrentState.Pen.Free;
  end;

begin
  if Length(FSavedStates) > 0 then
  begin
    InternalRestoreState(FSavedStates[High(FSavedStates)]);
    SetLength(FSavedStates, Length(FSavedStates) - 1);
    RestoreDC;
  end;
end;

procedure TcxCanvas.SaveState;

  procedure InternalSaveState(var ACurrentState: TcxCanvasState);
  begin
    ACurrentState.Font := TFont.Create;
    ACurrentState.Font.Assign(Font);
    ACurrentState.Brush := TBrush.Create;
    ACurrentState.Brush.Assign(Brush);
    ACurrentState.Pen := TPen.Create;
    ACurrentState.Pen.Assign(Pen);
  end;

begin
  SaveDC;
  SetLength(FSavedStates, Length(FSavedStates) + 1);
  InternalSaveState(FSavedStates[High(FSavedStates)]);
end;

procedure TcxCanvas.GetParams(var AParams: TcxViewParams);
begin
  AParams.Color := Brush.Color;
  AParams.Font := Font;
  AParams.TextColor := Font.Color;
end;

procedure TcxCanvas.SetParams(AParams: TcxViewParams);
begin
  SetBrushColor(AParams.Color);
  Font := AParams.Font;
  Font.Color := AParams.TextColor;
end;

procedure TcxCanvas.SetBrushColor(Value: TColor);
begin
  if Brush.Color <> Value then
    Brush.Color := Value;
end;

procedure TcxCanvas.SetFontAngle(Value: Integer);
var
  ALogFont: TLogFont;
begin
  cxGetFontData(Font.Handle, ALogFont);
{$IFDEF CLR}
  ALogFont.lfOrientation := Value * 10;
{$ENDIF}
  ALogFont.lfEscapement := Value * 10;
  if Value <> 0 then
    ALogFont.lfOutPrecision := OUT_TT_ONLY_PRECIS;
  Font.Handle := CreateFontIndirect(ALogFont);
end;

{$IFDEF VCL}

procedure TcxCanvas.GetTextStringsBounds(Text: string; R: TRect; Flags: Integer;
  Enabled: Boolean; var ABounds: TRectArray);
var
  AAlignHorz, AAlignVert, AMaxCharCount: Integer;
  ATextR: TRect;
  AStringSize: TSize;

  procedure PrepareRects;
  begin
    if not Enabled then
      with R do
      begin
        Dec(Right);
        Dec(Bottom);
      end;
    ATextR := R;
    TextExtent(Text, ATextR, Flags);
    case AAlignVert of
      cxAlignBottom:
        OffsetRect(ATextR, 0, R.Bottom - ATextR.Bottom);
      cxAlignVCenter:
        OffsetRect(ATextR, 0, (R.Bottom - ATextR.Bottom) div 2);
    end;
  end;

  procedure CheckMaxCharCount;

    function ProcessSpecialChars: Boolean;
    const
      SpecialChars = [#10, #13];
    var
      I, ACharCount: Integer;
    begin
      Result := False;
      for I := 1 to AMaxCharCount do
        if Text[I] in SpecialChars then
        begin
          AMaxCharCount := I - 1;
          ACharCount := 1;
          if (I < Length(Text)) and
            (Text[I + 1] in SpecialChars) and (Text[I] <> Text[I + 1]) then
            Inc(ACharCount);
          Delete(Text, I, ACharCount);
          Result := True;
          Break;
        end;
    end;

    procedure ProcessSpaces;
    var
      I: Integer;
    begin
      if AMaxCharCount < Length(Text) then
        for I := AMaxCharCount + 1 downto 1 do
          if Text[I] = ' ' then
          begin
            if I < AMaxCharCount then
            begin
              AMaxCharCount := I;
              if AAlignHorz <> cxAlignLeft then
              begin
                Delete(Text, I, 1);
                Dec(AMaxCharCount);
              end;
            end;  
            Break;
          end;
    end;

  begin
    if not ProcessSpecialChars then
      ProcessSpaces;
  end;

  procedure GetStringSize;
  begin
    if AMaxCharCount = 0 then
      AStringSize.cx := 0
    else
      GetTextExtentPoint(Handle, {$IFNDEF CLR}PChar{$ENDIF}(Copy(Text, 1, AMaxCharCount)),
        AMaxCharCount, AStringSize);
  end;

  function GetBounds: TRect;
  begin
    Result := ATextR;
    with Result, AStringSize do
    begin
      case AAlignHorz of
        cxAlignLeft:
          Right := Left + cx;
        cxAlignRight:
          Left := Right - cx;
        cxAlignHCenter:
          begin
            Left := (Left + Right - cx) div 2;
            Right := Left + cx;
          end;
      end;
      Bottom := Top + cy;
    end;
    ATextR.Top := Result.Bottom;
  end;

begin
  if Text = '' then Exit;
  if Flags and cxShowPrefix <> 0 then
  begin
    Text := StripHotKey(Text);
    Flags := Flags and not cxShowPrefix;
  end;
  AAlignHorz := Flags and (cxAlignLeft or cxAlignRight or cxAlignHCenter);
  AAlignVert := Flags and (cxAlignTop or cxAlignBottom or cxAlignVCenter);
  PrepareRects;
  repeat
    GetTextExtentExPoint(Handle, {$IFNDEF CLR}PChar{$ENDIF}(Text), Length(Text), R.Right - R.Left,
      {$IFNDEF CLR}@{$ENDIF}AMaxCharCount, nil, AStringSize);
    CheckMaxCharCount;
    GetStringSize;
    SetLength(ABounds, High(ABounds) + 2);
    ABounds[High(ABounds)] := GetBounds;
    Delete(Text, 1, AMaxCharCount);
  until Text = '';
end;

{$ENDIF}

{$IFNDEF LINUX}

procedure TcxCanvas.BeginPath;
begin
  Windows.BeginPath(Handle);
end;

procedure TcxCanvas.EndPath;
begin
  Windows.EndPath(Handle);
end;

function TcxCanvas.PathToRegion: TcxRegion;
begin
  Result := TcxRegion.Create(Windows.PathToRegion(Handle));
end;

procedure TcxCanvas.WidenPath;
begin
  Windows.WidenPath(Handle);
end;

{$ENDIF}

procedure TcxCanvas.ExcludeClipRect(const R: TRect);
begin
{$IFDEF VCL}
  with R do
    Windows.ExcludeClipRect(Handle, Left, Top, Right, Bottom);
{$ELSE}
  if not IsRectEmpty(R) then
    SetClipRegion(TcxRegion.Create(R), roSubtract);
{$ENDIF}
end;

procedure TcxCanvas.IntersectClipRect(const R: TRect);
begin
{$IFDEF VCL}
  with R do
    Windows.IntersectClipRect(Canvas.Handle, Left, Top, Right, Bottom);
{$ELSE}
  if IsRectEmpty(R) then Exit;
  SetClipRegion(TcxRegion.Create(R), roIntersect);
{$ENDIF}
end;

function TcxCanvas.GetClipRegion(AConsiderOrigin: Boolean = True): TcxRegion;
const
  MaxRegionSize = 30000;
begin
  Result := TcxRegion.Create;
{$IFDEF VCL}
  if GetClipRgn(Handle, Result.Handle) = 0 then
    SetRectRgn(Result.Handle, 0, 0, MaxRegionSize, MaxRegionSize);
{$ELSE}
  if QPainter_hasClipping(Handle) then
    QRegion_unite(Result.Handle, Result.Handle, Canvas.GetClipRegion)
  else
  begin
    Result.DestroyHandle;
    Result.Handle := QRegion_create(0, 0, MaxInt div 20, MaxInt div 20,
      QRegionRegionType_Rectangle);
  end;
{$ENDIF}
  if AConsiderOrigin then
    Result.Offset(-DCOrigin.X, -DCOrigin.Y);
end;

procedure TcxCanvas.SetClipRegion(ARegion: TcxRegion; AOperation: TcxRegionOperation;
  ADestroyRegion: Boolean = True; AConsiderOrigin: Boolean = True);
var
  AClipRegion: TcxRegion;
  ARegionOrigin: TPoint;
begin
  if AOperation = roSet then
  begin
    if AConsiderOrigin then
    begin
      ARegionOrigin := DCOrigin;
      ARegion.Offset(ARegionOrigin.X, ARegionOrigin.Y);
    end;
    SelectClipRgn(Handle, ARegion.Handle);
    if ADestroyRegion then
      ARegion.Free
    else
      if AConsiderOrigin then
        ARegion.Offset(-ARegionOrigin.X, -ARegionOrigin.Y);
  end
  else
  begin
    AClipRegion := GetClipRegion(AConsiderOrigin);
    AClipRegion.Combine(ARegion, AOperation, ADestroyRegion);
    SetClipRegion(AClipRegion, roSet, True, AConsiderOrigin);
  end;
end;

function TcxCanvas.RectFullyVisible(const R: TRect): Boolean;
var
  AClipRegion, ARegion: TcxRegion;
begin
  AClipRegion := GetClipRegion;
  ARegion := TcxRegion.Create(R);
  try
    CombineRgn(AClipRegion.Handle, AClipRegion.Handle, ARegion.Handle, RGN_AND);
    Result := AClipRegion.IsEqual(ARegion);
  finally
    ARegion.Free;
    AClipRegion.Free;
  end;
end;

function TcxCanvas.RectVisible({$IFDEF VCL}const {$ENDIF}R: TRect): Boolean;
begin
{$IFDEF VCL}
  Result := Windows.RectVisible(Handle, R);
{$ELSE}
  Result := not QPainter_hasClipping(Handle);
  if Result then
    Result := not IsRectEmpty(R)
  else
  begin
    Inc(R.Right);
    Inc(R.Bottom);
    Result := QRegion_contains(QPainter_clipRegion(Handle), PRect(@R));
  end;
{$ENDIF}
end;

{ TScreenCanvas }

type
  TScreenCanvas = class({$IFDEF VCL}TCanvas{$ELSE}TQtCanvas{$ENDIF})
  private
  {$IFNDEF VCL}
    FWidget: QOpenWidgetH;
    FWidgetFlags: Integer;
  {$ENDIF}
  {$IFDEF VCL}
    procedure FreeHandle;
  protected
    procedure CreateHandle; override;
  {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
  end;

constructor TScreenCanvas.Create;
begin
  inherited Create;
  {$IFNDEF VCL}
  FWidget := QOpenWidgetH(QApplication_desktop);
  FWidgetFlags := QOpenWidget_getWFlags(FWidget);
  QOpenWidget_setWFlags(FWidget, FWidgetFlags or Integer(WidgetFlags_WPaintUnclipped));
  QtHandle := FWidget;
  Start;
  {$ENDIF}
end;

destructor TScreenCanvas.Destroy;
begin
{$IFDEF VCL}
  FreeHandle;
{$ELSE}
  Stop;
  QOpenWidget_setWFlags(FWidget, FWidgetFlags);
{$ENDIF}
  inherited;
end;

{$IFDEF VCL}

procedure TScreenCanvas.FreeHandle;
begin
  ReleaseDC(0, Handle);
  Handle := 0;
end;

procedure TScreenCanvas.CreateHandle;
begin
  Handle := GetDC(0);
end;

{$ENDIF}

{ TcxScreenCanvas }

constructor TcxScreenCanvas.Create;
begin
  inherited Create(TScreenCanvas.Create);
end;

destructor TcxScreenCanvas.Destroy;
begin
  FCanvas.Free;
  inherited;
end;

{ TcxBitmap }

const
  ClrNone: TRGBQuad = (rgbBlue: $FF; rgbGreen: $FF; rgbRed: $FF; rgbReserved: $FF);
  ClrTransparent: TRGBQuad = (rgbBlue: 0; rgbGreen: 0; rgbRed: 0; rgbReserved: 0);

function cxColorIsEqual(const AColor1, AColor2: TRGBQuad): Boolean;
begin
{$IFDEF CLR}
  Result := (AColor1.rgbBlue = AColor2.rgbBlue) and
    (AColor1.rgbGreen = AColor2.rgbGreen) and
    (AColor1.rgbRed = AColor2.rgbRed) and
    (AColor1.rgbReserved = AColor2.rgbReserved);
{$ELSE}
  Result := DWORD(AColor1) = DWORD(AColor2);
{$ENDIF}
end;

function cxColorEssence(const AColor: TRGBQuad): DWORD;
begin
{$IFDEF CLR}
  Result := RGB(AColor.rgbRed, AColor.rgbGreen, AColor.rgbBlue);
{$ELSE}
  Result := DWORD(AColor) and $00FFFFFF;
{$ENDIF}
end;

function TcxColorList.Add(AColor: TColor): Integer;
begin
  Result := inherited Add(Pointer(cxColorEssence(cxColorToRGBQuad(AColor))));
end;

constructor TcxBitmap.Create;
begin
  CreateSize(0, 0);
end;

constructor TcxBitmap.CreateSize(ARect: TRect);
begin
  CreateSize(cxRectWidth(ARect), cxRectHeight(ARect));
end;

constructor TcxBitmap.CreateSize(AWidth, AHeight: Integer);
begin
  inherited Create;

  FillBitmapInfoHeader(FBitmapInfo.bmiHeader, Self, False);
  FDC := CreateCompatibleDC(0);
  FTransparentPixels := TcxColorList.Create;

  Width := AWidth;
  Height := AHeight;
  PixelFormat := pf32bit;
  Clear;
end;

destructor TcxBitmap.Destroy;
begin
  FreeAndNil(FTransparentPixels);
  DeleteDC(FDC);
  inherited;
end;

procedure TcxBitmap.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxBitmap.EndUpdate(AForceUpdate: Boolean = True);
begin
  if FLockCount > 0 then
  begin
    Dec(FLockCount);
    if AForceUpdate or FModified then
      Changed(Self);
  end;
end;

procedure TcxBitmap.GetBitmapColors(out AColors: TRGBColors);
begin
  SetLength(AColors, Width * Height);
  GetDIBits(FDC, Handle, 0, Height, AColors, FBitmapInfo, DIB_RGB_COLORS);
end;

procedure TcxBitmap.SetBitmapColors(const AColors: TRGBColors);
begin
  SetDIBits(FDC, Handle, 0, Height, AColors, FBitmapInfo, DIB_RGB_COLORS);
end;

procedure TcxBitmap.AlphaBlend(ABitmap: TcxBitmap; const ARect: TRect; ASmoothImage: Boolean; AConstantAlpha: Byte = $FF);
begin
  cxAlphaBlend(ABitmap, Self, ARect, ClientRect, ASmoothImage, AConstantAlpha);
end;

procedure TcxBitmap.Clear;
begin
  if FTransparentBkColor.rgbReserved <> 0 then
    TransformBitmap(btmClear)
  else
  begin
    Canvas.Brush.Color := 0;
    Canvas.FillRect(ClientRect);
  end;
end;

procedure TcxBitmap.CopyBitmap(ABitmap: TBitmap; ACopyMode: DWORD);
begin
  cxBitBlt(Canvas.Handle, ABitmap.Canvas.Handle, ClientRect, cxNullPoint, ACopyMode);
end;

procedure TcxBitmap.DrawHatch(const AHatchData: TcxHatchData);
begin
  HatchData := AHatchData;
  TransformBitmap(btmHatch);
end;

procedure TcxBitmap.DrawHatch(AColor1, AColor2: TColor; AStep, AAlpha1, AAlpha2: Byte);
var
  AHatchData: TcxHatchData;
begin
  AHatchData.Color1 := cxColorToRGBQuad(AColor1, $FF);
  AHatchData.Alpha1 := AAlpha1;
  AHatchData.Color2 := cxColorToRGBQuad(AColor2, $FF);
  AHatchData.Alpha2 := AAlpha2;
  AHatchData.Step := AStep;
  DrawHatch(AHatchData);
end;

procedure TcxBitmap.DrawShadow(AMaskBitmap: TcxBitmap; AShadowSize: Integer; AShadowColor: TColor = clBtnShadow);
const
  DPSnaa = $00200F09;
var
  AShadowOffset: Integer;
  AShadowBitmap: TcxBitmap;
begin
  AShadowBitmap := TcxBitmap.CreateSize(AMaskBitmap.ClientRect);
  try
    AShadowBitmap.CopyBitmap(AMaskBitmap);
    AShadowBitmap.Canvas.Brush.Color := AShadowColor;
    AShadowBitmap.Canvas.CopyMode := DPSnaa;
    AShadowBitmap.Canvas.Draw(AShadowSize, AShadowSize, AMaskBitmap);

    AShadowBitmap.TransformBitmap(btmCorrectBlend);

    BitBlt(Canvas.Handle, AShadowSize, AShadowSize, Width, Height, AShadowBitmap.Canvas.Handle, AShadowSize, AShadowSize, SRCPAINT);

    AShadowOffset := AShadowSize div 2;
    BitBlt(Canvas.Handle, -AShadowOffset, -AShadowOffset, Width, Height, Canvas.Handle, 0, 0, SRCCOPY);
    Canvas.Brush.Color := 0;
    Canvas.FillRect(Rect(0, Height - AShadowOffset, Width, Height));
    Canvas.FillRect(Rect(Width - AShadowOffset, 0, Width, Height));
  finally
    AShadowBitmap.Free;
  end;
end;

procedure TcxBitmap.Filter(AMaskBitmap: TcxBitmap);
const
  DSna = $00220326;
begin
  CopyBitmap(AMaskBitmap, DSna);
end;

procedure TcxBitmap.Invert;
begin
  CopyBitmap(Self, NOTSRCCOPY);
end;

procedure TcxBitmap.RecoverAlphaChannel(ATransparentColor: TColor);
begin
  TransparentPixels.Clear;
  TransparentPixels.Add(ATransparentColor);
  TransparentBkColor := cxColorToRGBQuad(ATransparentColor);
  TransformBitmap(btmCorrectBlend);
end;

procedure TcxBitmap.Shade(AMaskBitmap: TcxBitmap);
const
  DSPDxax = $00E20746;
begin
  AMaskBitmap.Canvas.CopyMode := cmPatInvert;
  AMaskBitmap.Canvas.Draw(0, 0, AMaskBitmap);

  Canvas.CopyMode := cmSrcCopy;
  Canvas.Draw(1, 1, AMaskBitmap);

  Canvas.CopyMode := DSPDxax;
  Canvas.Brush.Color := clBtnShadow;
  Canvas.Draw(0, 0, AMaskBitmap);

  TransformBitmap(btmCorrectBlend);
end;

procedure TcxBitmap.TransformBitmap(AMode: TcxBitmapTransformationMode);
var
  AColors: TRGBColors;
  I, J: Integer;
  ATransformProc: TcxBitmapTransformationProc;
begin
  case AMode of
    btmDingy:
      ATransformProc := Dingy;
    btmDirty:
      ATransformProc := Dirty;
    btmGrayScale:
      ATransformProc := GrayScale;
    btmSetOpaque:
      ATransformProc := SetOpaque;
    btmMakeMask:
      ATransformProc := MakeMask;
    btmFade:
      ATransformProc := Fade;
    btmDisable:
      ATransformProc := Disable;
    btmCorrectBlend:
      ATransformProc := CorrectBlend;
    btmHatch:
      ATransformProc := Hatch;
    btmClear:
      ATransformProc := ClearColor;
  else
    Exit;
  end;

  GetBitmapColors(AColors);

  for I := 0 to Width - 1 do
    for J := 0 to Height - 1 do
    begin
      FCurrentColorIndex.X := I;
      FCurrentColorIndex.Y := J;

      ATransformProc(AColors[J * Width + I]);
    end;

  SetBitmapColors(AColors);
end;

procedure TcxBitmap.Changed(Sender: TObject);
begin
  if not ChangeLocked then
  begin
    inherited;
    UpdateBitmapInfo;
    FModified := False;
  end
  else
    FModified := True;
end;

function TcxBitmap.ChangeLocked: Boolean;
begin
  Result := FLockCount > 0;
end;

function TcxBitmap.GetClientRect: TRect;
begin
  Result := Rect(0, 0, Width, Height);
end;

function TcxBitmap.GetIsAlphaUsed: Boolean;
var
  AColors: TRGBColors;
  I: Integer;
begin
  Result := False;
  GetBitmapColors(AColors);
  for I := Low(AColors) to High(AColors) do
  begin
    Result := AColors[I].rgbReserved <> 0;
    if Result then
      Break;
  end;
end;

procedure TcxBitmap.CorrectBlend(var AColor: TRGBQuad);
begin
  if not IsColorTransparent(AColor) and (AColor.rgbReserved = 0) then
    AColor.rgbReserved := $FF;
end;

procedure TcxBitmap.ClearColor(var AColor: TRGBQuad);
begin
  AColor := TransparentBkColor;
end;

procedure TcxBitmap.Dingy(var AColor: TRGBQuad);

  procedure LightColor(var AColor: Byte);
  begin
    Inc(AColor, MulDiv(255 - AColor, 3, 10));
  end;

begin
  if not IsColorTransparent(AColor) then
  begin
    LightColor(AColor.rgbRed);
    LightColor(AColor.rgbGreen);
    LightColor(AColor.rgbBlue);
    LightColor(AColor.rgbReserved);
  end;
end;

procedure TcxBitmap.Dirty(var AColor: TRGBQuad);
var
  ADirtyScreen:TRGBQuad;
begin
  if not IsColorTransparent(AColor) then
  begin
    Scale(AColor, GrayMap);

    ADirtyScreen := cxColorToRGBQuad(clBtnShadow);
    ADirtyScreen.rgbReserved := $C0;

    cxBlendFunction(ADirtyScreen, AColor, $EE);
  end;
end;

procedure TcxBitmap.Disable(var AColor: TRGBQuad);
begin
  if not IsColorTransparent(AColor) then
    Scale(AColor, DisableMap);
end;

procedure TcxBitmap.Fade(var AColor: TRGBQuad);
begin
  if not IsColorTransparent(AColor) then
    Scale(AColor, FadeMap);
end;

procedure TcxBitmap.GrayScale(var AColor: TRGBQuad);
var
  AValue: Byte;
begin
  if not IsColorTransparent(AColor) then
  begin
    AValue := (AColor.rgbRed + AColor.rgbGreen + AColor.rgbBlue) div 3;
    AColor.rgbRed := AValue;
    AColor.rgbGreen := AValue;
    AColor.rgbBlue := AValue;
  end;
end;

procedure TcxBitmap.Hatch(var AColor: TRGBQuad);
begin
  if Odd(FCurrentColorIndex.X div FHatchData.Step + FCurrentColorIndex.Y div FHatchData.Step) then
    cxBlendFunction(FHatchData.Color2, AColor, FHatchData.Alpha2)
  else
    cxBlendFunction(FHatchData.Color1, AColor, FHatchData.Alpha1);
end;

procedure TcxBitmap.MakeMask(var AColor: TRGBQuad);
begin
  if IsColorTransparent(AColor) then
    AColor := ClrNone
  else
    AColor := ClrTransparent;
end;

procedure TcxBitmap.SetOpaque(var AColor: TRGBQuad);
begin
  AColor.rgbReserved := $FF;
end;

procedure TcxBitmap.Scale(var AColor: TRGBQuad; const AColorMap: TcxColorTransitionMap);
var
  AResultValue: Byte;
begin
  AResultValue := Round(AColorMap.RedScale * AColor.rgbRed + AColorMap.GreenScale * AColor.rgbGreen + AColorMap.BlueScale * AColor.rgbBlue);
  AColor.rgbBlue := AResultValue;
  AColor.rgbGreen := AResultValue;
  AColor.rgbRed := AResultValue;
end;

procedure TcxBitmap.UpdateBitmapInfo;
begin
  FBitmapInfo.bmiHeader.biHeight := Height;
  FBitmapInfo.bmiHeader.biWidth := Width;
end;

function TcxBitmap.IsColorTransparent(const AColor: TRGBQuad): Boolean;

  function IsTransparentPixel(AColor: DWORD): Boolean;
  begin
    Result := TransparentPixels.IndexOf(Pointer(AColor)) <> -1;
  end;

begin
  Result := cxColorIsEqual(AColor, TransparentBkColor) or IsTransparentPixel(cxColorEssence(AColor));
end;

{ TcxImageList }

function cxCopyImage(ASrcHandle: THandle): HBITMAP; overload;

  function InternalCopyImage: HBITMAP;
  begin
    Result := CopyImage(ASrcHandle, IMAGE_BITMAP, 0, 0, LR_COPYRETURNORG or LR_CREATEDIBSECTION);
  end;

{$IFNDEF CLR}
  function InternalCopyImage95X: HBITMAP;
  var
    ABitmapData: Windows.TBitmap;
    AInfo: TBitmapInfo;
    ADestinationBits: Pointer;
    ABits: TBytes;
  begin
    cxGetBitmapData(ASrcHandle, ABitmapData);
    if ABitmapData.bmBitsPixel = 32 then
    begin
      FillBitmapInfoHeader(AInfo.bmiHeader, ABitmapData.bmWidth, ABitmapData.bmHeight, False);
      if ABitmapData.bmBits = nil then
      begin
        SetLength(ABits, ABitmapData.bmWidthBytes * ABitmapData.bmHeight);
        GetDIBits(cxScreenCanvas.Handle, ASrcHandle, 0, ABitmapData.bmHeight, ABits, AInfo, 0);
        ABitmapData.bmBits := ABits;
      end;
      Result := CreateDIBSection(cxScreenCanvas.Handle, AInfo, DIB_RGB_COLORS, ADestinationBits, 0, 0);
      cxCopyData(ABitmapData.bmBits, ADestinationBits, ABitmapData.bmWidthBytes * ABitmapData.bmHeight);
    end
    else
      Result := InternalCopyImage;
  end;
{$ENDIF}  

begin
{$IFNDEF CLR}
  if IsWin95X then
    Result := InternalCopyImage95X
  else
{$ENDIF}
    Result := InternalCopyImage;
end;

function TcxImageList.Add(AImage, AMask: TBitmap): Integer;
var
  AImageHandle, AMaskHandle: HBITMAP;
begin
  AImagehandle := GetImageHandle(AImage);
  if AMask = nil then
    AMaskHandle := CreateBitmap(Width, Height, 1, 1, nil)
  else
    AMaskHandle := AMask.Handle;
  Result := ImageList_Add(Handle, AImageHandle, AMaskHandle);
  if AMask = nil then
    DeleteObject(AMaskHandle);
  Change;
end;

procedure TcxImageList.AddImages(AImageList: TCustomImageList);
begin
  if AImageList <> nil then
  begin
    BeginUpdate;
    try
      CopyImages(AImageList);
    finally
      EndUpdate;
    end;
  end;
end;

function TcxImageList.AddMasked(AImage: TBitmap; AMaskColor: TColor): Integer;
begin
  BeginUpdate;
  try
    if AMaskColor = clNone then
      Result := Add(AImage, nil)
    else
      Result := ImageList_AddMasked(Handle, AImage.Handle, ColorToRGB(AMaskColor));
  finally
    EndUpdate;
  end;
end;

procedure TcxImageList.Assign(Source: TPersistent);
begin
  if Source is TCustomImageList then
  begin
    BeginUpdate;
    try
      inherited;
      Clear;
      CopyImages(TCustomImageList(Source));
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxImageList.CopyImages(AImageList: TCustomImageList; AStartIndex, AEndIndex: Integer);
var
  I: Integer;
  AImage, AMask: TBitmap;
begin
  BeginUpdate;
  AImage := nil;
  AMask := nil;
  try
    AImage := cxCreateBitmap(Width, Height, pf32bit);
    AMask := cxCreateBitmap(Width, Height, pf1bit);
    if AEndIndex < 0 then
      AEndIndex := AImageList.Count - 1
    else
      AEndIndex := Min(AImageList.Count - 1, AEndIndex);
    for I := Max(AStartIndex, 0) to AEndIndex do
    begin
      GetImageInfo(AImageList.Handle, I, AImage, AMask);
      Add(AImage, AMask);
    end;
  finally
    AImage.Free;
    AMask.Free;
    EndUpdate;
  end;
end;

procedure TcxImageList.Insert(AIndex: Integer; AImage, AMask: TBitmap);
begin
  if (AIndex >= 0) and (AIndex <= Count) then
  begin
    BeginUpdate;
    try
      Move(Add(AImage, AMask), AIndex);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxImageList.InsertMasked(AIndex: Integer; AImage: TBitmap; AMaskColor: TColor);
begin
  if (AIndex >= 0) and (AIndex <= Count) then
  begin
    BeginUpdate;
    try
      Move(AddMasked(AImage, AMaskColor), AIndex);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxImageList.Move(ACurIndex, ANewIndex: Integer);
var
  AStep: Integer;
begin
  BeginUpdate;
  try
    AStep := cxSign(ANewIndex - ACurIndex);
    while ACurIndex <> ANewIndex do
    begin
      ImageList_Copy(Handle, ACurIndex + AStep, Handle, ACurIndex, ILCF_SWAP);
      Inc(ACurIndex, AStep);
    end;
  finally
    EndUpdate;
  end;
end;

function TcxImageList.Replace(AIndex: Integer; AImage, AMask: TBitmap): Boolean;
var
  AImageHandle, AMaskHandle: HBITMAP;
begin
  AImagehandle := GetImageHandle(AImage);
  AMaskHandle := GetImageHandle(AMask);
  Result := ImageList_Replace(Handle, AIndex, AImageHandle, AMaskHandle);
  Change;
end;

procedure TcxImageList.ReplaceMasked(AIndex: Integer; ANewImage: TBitmap; AMaskColor: TColor);
begin
  BeginUpdate;
  try
    Delete(AIndex);
    InsertMasked(AIndex, ANewImage, AMaskColor);
  finally
    EndUpdate;
  end;
end;

procedure TcxImageList.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TcxImageList.EndUpdate(AForceUpdate: Boolean = True);
begin
  if FLockCount > 0 then
  begin
    Dec(FLockCount);
    if AForceUpdate then
      Change;
  end;
end;

{$IFNDEF DELPHI6}
procedure TcxImageList.Draw(ACanvas: TCanvas; X, Y, AIndex: Integer;
  ADrawingStyle: TDrawingStyle; AImageType: TImageType; AEnabled: Boolean);
begin
  if HandleAllocated then
    DoDraw(AIndex, ACanvas, X, Y, GetImageListStyle(ADrawingStyle, AImageType), AEnabled);
end;
{$ENDIF}

procedure TcxImageList.Draw(ACanvas: TCanvas; const ARect: TRect; AIndex: Integer;
  AStretch, ASmoothResize, AEnabled: Boolean);
begin
  DoDrawEx(AIndex, ACanvas, ARect, GetImageListStyle(DrawingStyle, ImageType), AStretch, ASmoothResize, AEnabled);
end;

procedure TcxImageList.GetImageInfo(AIndex: Integer; AImage, AMask: TBitmap);
begin
  GetImageInfo(Handle, AIndex, AImage, AMask);
end;

procedure TcxImageList.GetImage(AIndex: Integer; AImage: TBitmap);
begin
  GetImageInfo(AIndex, AImage, nil);
end;

procedure TcxImageList.GetMask(AIndex: Integer; AMask: TBitmap);
begin
  GetImageInfo(AIndex, nil, AMask);
end;

class procedure TcxImageList.GetImageInfo(AHandle: HIMAGELIST; AIndex: Integer; AImage, AMask: TBitmap);

  procedure GetBitmap(ASrcHandle: HBITMAP; ADestBitmap: TBitmap; ACopyAll: Boolean; const ARect: TRect);

    procedure CopyRect;
    var
      ASrcBitmap: TBitmap;
      AWidth, AHeight: Integer;
    begin
      ASrcBitmap := TBitmap.Create;
      try
        ASrcBitmap.Handle := cxCopyImage(ASrcHandle);
        AWidth := cxRectWidth(ARect);
        AHeight := cxRectHeight(ARect);
        ADestBitmap.Width := AWidth;
        ADestBitmap.Height := AHeight;
        cxBitBlt(ADestBitmap.Canvas.Handle, ASrcBitmap.Canvas.Handle,
          cxRect(0, 0, AWidth, AHeight), ARect.TopLeft, SRCCOPY);
      finally
        ASrcBitmap.Free;
      end;
    end;

  begin
    if ACopyAll then
      ADestBitmap.Handle := cxCopyImage(ASrcHandle)
    else
      CopyRect;
  end;

var
  AImageInfo: TImageInfo;
  ACopyAll: Boolean;
begin
  ACopyAll := AIndex = -1;
  if ACopyAll then
    AIndex := 0;
  if ImageList_GetImageInfo(AHandle, AIndex, AImageInfo) then
  begin
    if AMask <> nil then
      GetBitmap(AImageInfo.hbmMask, AMask, ACopyAll, AImageInfo.rcImage);
    if AImage <> nil then
      GetBitmap(AImageInfo.hbmImage, AImage, ACopyAll, AImageInfo.rcImage);
    DeleteObject(AImageInfo.hbmImage);
    DeleteObject(AImageInfo.hbmMask);
  end;
end;

function TcxImageList.ChangeLocked: Boolean;
begin
  Result := FLockCount > 0;
end;

procedure TcxImageList.Change;
begin
  if not ChangeLocked then
    inherited Change;
end;

procedure TcxImageList.DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer;
  Style: Cardinal; Enabled: Boolean = True);
begin
  DoDrawEx(Index, Canvas, cxRectBounds(X, Y, Width, Height), Style, False, False, Enabled);
end;

procedure TcxImageList.DoDrawEx(AIndex: Integer; ACanvas: TCanvas;
  const ARect: TRect; AStyle: Cardinal; AStretch, ASmoothResize, AEnabled: Boolean);
const
  ADrawModes: array [Boolean] of TcxImageDrawMode = (idmDisabled, idmNormal);
var
  AGlyphRect: TRect;
  ADrawBitmap: TBitmap;
begin
  if AStretch then
    AGlyphRect := ARect
  else
    AGlyphRect := cxRectCenter(ARect, Width, Height);
  if AlphaBlending then
    cxDrawImage(ACanvas.Handle, AGlyphRect, ARect, nil, Self, AIndex, ADrawModes[AEnabled], ASmoothResize)
  else
  begin
    if AStretch then
    begin
      ADrawBitmap := cxCreateBitmap(Width, Height, pfDevice);
      try
        inherited DoDraw(AIndex, ADrawBitmap.Canvas, 0, 0, AStyle, AEnabled);
        cxDrawImage(ACanvas.Handle, AGlyphRect, ARect, ADrawBitmap, nil, 0, ADrawModes[AEnabled], ASmoothResize);
      finally
        ADrawBitmap.Free;
      end;
    end
    else
      inherited DoDraw(AIndex, ACanvas, AGlyphRect.Left, AGlyphRect.Top, AStyle, AEnabled);
  end;
end;

procedure TcxImageList.Initialize;
begin
  inherited;
  FAlphaBlending := True;
  Handle := ImageList_Create(Width, Height, ILC_COLOR32 or ILC_MASK, AllocBy, AllocBy);
end;

function TcxImageList.GetImageHandle(AImage: TBitmap): Integer;
begin
  if AImage <> nil then
    Result := AImage.Handle
  else
    Result := 0;
end;

class function TcxImageList.GetPixelFormat(AHandle: HIMAGELIST): Integer;
var
  AImageInfo: TImageInfo;
  ABitmap: Windows.TBitmap;
begin
  Result := 0;
  if ImageList_GetImageInfo(AHandle, 0, AImageInfo) then
  begin
    cxGetBitmapData(AImageInfo.hbmImage, ABitmap);
    Result := ABitmap.bmBitsPixel;
    DeleteObject(AImageInfo.hbmImage);
    DeleteObject(AImageInfo.hbmMask);
  end;
end;

{$IFNDEF CLR}

{$IFDEF VCL}
const
  SystemBrushes: TList = nil;
  SysColorPrefix = {$IFDEF DELPHI7} clSystemColor {$ELSE} $80000000 {$ENDIF};
  BrushDataSize = SizeOf(TcxBrushData);
  scxBrushCacheReleaseUnusedBrush = 'Release unused brush';
{$ENDIF}

destructor TcxBrushCache.Destroy;
var
  I: Integer;
begin
  try
    for I := 0 to FCount - 1 do
      FData[I].Brush.Free;
  finally
    inherited Destroy;
  end;
end;

procedure TcxBrushCache.BeginUpdate;
begin
  Inc(FLockRef);
end;

procedure TcxBrushCache.EndUpdate;
begin
  Inc(FLockRef);
  if (FLockRef = 0) and (FDeletedCount <> 0) then Pack;
end;

procedure TcxBrushCache.ReleaseBrush(var ABrush: TBrush);
var
  AIndex: Integer;
begin
  if ABrush <> nil then
  begin
    if not IsSystemBrush(ABrush) and IndexOf(ABrush.Color, AIndex) then
    begin
      with FData[AIndex] do
      begin
        Dec(RefCount);
        CacheCheck(RefCount < 0, scxBrushCacheReleaseUnusedBrush);
        if RefCount <= 0 then Delete(AIndex);
      end;
    end;
  end; 
end;

procedure TcxBrushCache.SetBrushColor(var ABrush: TBrush; AColor: TColor);
begin
  ReleaseBrush(ABrush);
  ABrush := Add(AColor);
end;

function TcxBrushCache.Add(AColor: TColor): TBrush;
begin
{$IFDEF VCL}
  if AColor and SysColorPrefix <> 0 then
    Result := TBrush(SystemBrushes[AColor and not SysColorPrefix])
  else
{$ENDIF}
  Result := AddItemAt(FindNearestItem(AColor), AColor);
  Result.Color := AColor; 
end;

function TcxBrushCache.AddItemAt(AIndex: Integer; AColor: TColor): TBrush;
var
  Delta: Integer;
begin
  if (AIndex >= FCount) or (FData[AIndex].Color <> AColor) then
  begin
    if FCapacity <= FCount then
    begin
      Delta := FCapacity shr 2;
      if Delta < 8 then Delta := 8;
      Inc(FCapacity, Delta);
      SetLength(FData, FCapacity);
    end;
    if AIndex < FCount then Move(AIndex, AIndex + 1, FCount - AIndex);
    InitItem(FData[AIndex], AColor);
    Inc(FCount);
  end
  else
    if FData[AIndex].RefCount = 0 then Dec(FDeletedCount);
  Inc(FData[AIndex].RefCount);
  Result := FData[AIndex].Brush;
end;

procedure TcxBrushCache.CacheCheck(Value: Boolean; const AMessage: string);
begin
  if Value then
    raise EBrushCache.Create(AMessage);
end;

procedure TcxBrushCache.Delete(AIndex: Integer);
begin
  if FLockRef = 0 then
  begin
    FData[AIndex].Brush.Free;
    Dec(FCount);
    if AIndex < FCount then
      Move(AIndex + 1, AIndex, FCount - AIndex);
  end
  else
    Inc(FDeletedCount);
end;

function TcxBrushCache.IndexOf(AColor: TColor; out AIndex: Integer): Boolean;
begin
  AIndex := -1;
{$IFDEF VCL}
  if (AColor and SysColorPrefix = 0) then
{$ENDIF}
    AIndex := FindNearestItem(AColor);
  Result := (AIndex >= 0) and (AIndex < FCount) and (FData[AIndex].Color = AColor);
end;

procedure TcxBrushCache.InitItem(var AItem: TcxBrushData; AColor: TColor);
begin
  FillChar(AItem, BrushDataSize, 0);
  AItem.Brush := TBrush.Create;
  AItem.Brush.Color := AColor;
end;

function TcxBrushCache.IsSystemBrush(ABrush: TBrush): Boolean;
begin
  Result := ABrush = nil;
{$IFDEF VCL}
  Result := Result or ((ABrush.Color and SysColorPrefix) <> 0);
{$ENDIF};
end;

function TcxBrushCache.FindNearestItem(AColor: TColor): Integer;

  function Check(Min, Max: Integer): Integer;
  begin
    Result := Max;
    if AColor <= FData[Min].Color then
      Result := Min
    else
      if AColor > FData[Max].Color then
        AColor := Max + 1;
  end;

var
  A, B, C: Integer;
begin
  if FCount > 0 then
  begin
    A := 0;
    B := FCount - 1;
    if (FData[0].Color >= AColor) or (FData[B].Color <= AColor) then
      Result := Check(A, B)
    else
    begin
      while A < B do
      begin
        C := (A + B) shr 1;
        with FData[C] do
        begin
          if Color < AColor then
            A := C
          else
            if Color > AColor then
              B := C
            else
              B := A;
        end;
      end;
      Result := Check(A, B);
    end;
  end
  else
    Result := 0;
end;

procedure TcxBrushCache.Move(ASrc, ADst, ACount: Integer);
begin
  System.Move(FData[ASrc], FData[ADst], ACount * BrushDataSize);
end;

procedure TcxBrushCache.Pack;
var
  I, ACount: Integer;
begin
  try
    ACount := 0;
    I := FCount - 1;
    while (ACount < FDeletedCount) and (I >= 0) do
    begin
      if FData[I].RefCount < 0 then
      begin
        Delete(I);
        Inc(ACount);
      end;
      Dec(I);
    end;
  finally
    FDeletedCount := 0;
  end;
end;

procedure TcxBrushCache.Recreate;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    with FData[I] do Brush.Color := Color;
end;

procedure TcxBrushCache.Release(AIndex: Integer);
begin
  Dec(FData[AIndex].RefCount);
  if FData[AIndex].RefCount = 0 then Delete(AIndex);
end;

{$IFDEF VCL}
procedure InitSystemBrushes;
var
  I: Word;
  ABrush: TBrush;
begin
  SystemBrushes := TList.Create;
  for I := COLOR_SCROLLBAR to COLOR_ENDCOLORS do
  begin
    ABrush := TBrush.Create;
    ABrush.Handle := GetSysColorBrush(I);
    SystemBrushes.Add(ABrush);
  end;
end;

procedure DestroySystemBrushes;
var
  I: Integer;
begin
  try
    for I := 0 to SystemBrushes.Count - 1 do
      TBrush(SystemBrushes[I]).Free;
  finally
    SystemBrushes.Free;
  end;
end;
{$ENDIF}

procedure InitPredefinedBrushes;
var
  ABitmap: {$IFDEF VCL} HBitmap {$ELSE} TBitmap{$ENDIF};
{$IFNDEF VCL}
  I, J: Integer;
{$ENDIF}
const
  APattern: array[0..7] of Word =
    ($00AA, $0055, $00AA, $0055, $00AA, $0055, $00AA, $0055);
begin
  cxHalfToneBrush := TBrush.Create;
{$IFDEF VCL}
  InitSystemBrushes;
  ABitmap := CreateBitmap(8, 8, 1, 1, @APattern);
  cxHalfToneBrush.Handle := CreatePatternBrush(ABitmap);
  DeleteObject(ABitmap);
{$ELSE}
  ABitmap := cxCreateBitmap(TSize(cxPointPoint(8, 8)), pf1Bit);
  ABitmap.Monochrome := True;
  for I := 0 to 7 do
    for J := 0 to 7 do
    begin
      if ((APattern[I] and (1 shl J)) <> 0) then
        ABitmap.Canvas.Pen.Color := ColorToRGB(clBlack)
      else
        ABitmap.Canvas.Pen.Color := ColorToRGB(clWhite);
      ABitmap.Canvas.DrawPoint(J, K);
    end;
  cxHalfToneBrush.Bitmap := ABitmap;
{$ENDIF}
end;

procedure DestroyPredefinedBrushes;
begin
  DestroySystemBrushes;
{$IFDEF DELPHI9}
{$IFNDEF DELPHI10}
  cxHalfToneBrush.Bitmap.Free;
{$ENDIF}
{$ENDIF}
  cxHalfToneBrush.Free;
end;

{$ENDIF}

var
  ALib: Integer;

initialization
{$IFNDEF CLR}
  InitPredefinedBrushes;
{$ENDIF}
  ALib := LoadLibrary('msimg32.dll');
  if ALib <> 0 then
    VCLAlphaBlend := GetProcAddress(ALib, 'AlphaBlend')
  else
    VCLAlphaBlend := nil;

finalization
  if ALib <> 0 then FreeLibrary(ALib);
{$IFNDEF CLR}
  DestroyPredefinedBrushes;
  FreeAndNil(ScreenCanvas);
{$ENDIF}
  FreeAndNil(MaskBitmap);
  FreeAndNil(ImageBitmap);
  FreeAndNil(DrawBitmap);

end.
