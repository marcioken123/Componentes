
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressXPThemeManager                                        }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSXPTHEMEMANAGER AND ALL         }
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

unit dxUxTheme;

{$I cxVer.inc}

interface

uses
{$IFDEF CLR}
  System.Text, System.Runtime.InteropServices,
{$ENDIF}
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Windows, Classes, CommCtrl;

const
// DrawThemeText() flags
  DTT_GRAYED = $1;

// HitTestThemeBackground(), HitTestThemeBackgroundRegion() flags
  HTTB_BACKGROUNDSEG = $0;

// Fixed border hit test option
  HTTB_FIXEDBORDER = $2;

// Caption hit test option
  HTTB_CAPTION = $4;

// Resizing border hit test flags
  HTTB_RESIZINGBORDER_LEFT = $10;
  HTTB_RESIZINGBORDER_TOP = $20;
  HTTB_RESIZINGBORDER_RIGHT = $40;
  HTTB_RESIZINGBORDER_BOTTOM = $80;
  HTTB_RESIZINGBORDER = HTTB_RESIZINGBORDER_LEFT or HTTB_RESIZINGBORDER_TOP or
    HTTB_RESIZINGBORDER_RIGHT or HTTB_RESIZINGBORDER_BOTTOM;
  HTTB_SIZINGTEMPLATE = $100;
  HTTB_SYSTEMSIZINGMARGINS = $200;

(*// DrawThemeLine() flags
  DTL_LEFT = $1;
  DTL_TOP = $2;
  DTL_RIGHT = $4;
  DTL_BOTTOM = $8;*)

  MAX_INTLIST_COUNT = 10;

  ETDT_DISABLE = $1;
  ETDT_ENABLE = $2;
  ETDT_USETABTEXTURE = $4;
  ETDT_ENABLETAB = ETDT_ENABLE or ETDT_USETABTEXTURE;

// flags to control theming within an app
  STAP_ALLOW_NONCLIENT = $1;
  STAP_ALLOW_CONTROLS = $2;
  STAP_ALLOW_WEBCONTENT = $4;

  SZ_THDOCPROP_DISPLAYNAME = 'DisplayName';
  SZ_THDOCPROP_CANONICALNAME = 'ThemeName';
  SZ_THDOCPROP_TOOLTIP = 'ToolTip';
  SZ_THDOCPROP_AUTHOR = 'author';

  TS_MIN = 0;
  TS_TRUE = 1;
  TS_DRAW = 2;

//vista extension
  DTT_TEXTCOLOR      = (1 shl 0);      // crText has been specified
  DTT_BORDERCOLOR    = (1 shl 1);      // crBorder has been specified
  DTT_SHADOWCOLOR    = (1 shl 2);      // crShadow has been specified
  DTT_SHADOWTYPE     = (1 shl 3);      // iTextShadowType has been specified
  DTT_SHADOWOFFSET   = (1 shl 4);      // ptShadowOffset has been specified
  DTT_BORDERSIZE     = (1 shl 5);      // iBorderSize has been specified
  DTT_FONTPROP       = (1 shl 6);      // iFontPropId has been specified
  DTT_COLORPROP      = (1 shl 7);      // iColorPropId has been specified
  DTT_STATEID        = (1 shl 8);      // IStateId has been specified
  DTT_CALCRECT       = (1 shl 9);      // Use pRect as and in/out parameter
  DTT_APPLYOVERLAY   = (1 shl 10);     // fApplyOverlay has been specified
  DTT_GLOWSIZE       = (1 shl 11);     // iGlowSize has been specified
  DTT_CALLBACK       = (1 shl 12);     // pfnDrawTextCallback has been specified
  DTT_COMPOSITED     = (1 shl 13);     // Draws text with antialiased alpha (needs a DIB section)

type
{$IFDEF CLR}
  Pointer = IntPtr;
  PRect = IntPtr;
{$ENDIF}
  HTHEME = THandle;
  TTheme = HTHEME;

  THEMESIZE = Integer;
  TThemeSize = THEMESIZE;

  _MARGINS = record
    cxLeftWidth: Integer;
    cxRightWidth: Integer;
    cyTopHeight: Integer;
    cyBottomHeight: Integer;
  end;
  MARGINS = _MARGINS;
  PMARGINS = ^MARGINS;
  TMargins = MARGINS;

  _INTLIST = record
    iValueCount: Integer;
    iValues: array[0..MAX_INTLIST_COUNT - 1] of Integer;
  end;
  INTLIST = _INTLIST;
  PINTLIST = ^INTLIST;
  TIntList = INTLIST;

  PROPERTYORIGIN = (PO_STATE, PO_PART, PO_CLASS, PO_GLOBAL, PO_NOTFOUND);
  TPropertyOrigin = PROPERTYORIGIN;

// vista extention
  HPAINTBUFFER = THandle;

  _DTTOPTS = packed record
    dwSize: DWORD;
    dwFlags: DWORD;
    crText: COLORREF;
    crBorder: COLORREF;
    crShadow: COLORREF;
    iTextShadowType: Integer;
    ptShadowOffset: TPoint;
    iBorderSize: Integer;
    iFontPropId: Integer;
    iColorPropId: Integer;
    iStateId: Integer;
    fApplyOverlay: BOOL;
    iGlowSize: Integer;
    pfnDrawTextCallback: DWORD;
    lParam: LPARAM;
  end;
  TDTOPTS = _DTTOPTS;
  PDTOPTS = ^TDTOPTS;

function OpenThemeData(hWnd: HWND; pszClassList: {$IFNDEF CLR}PWideChar{$ELSE}string{$ENDIF}): HTHEME;
function CloseThemeData(hTheme: HTHEME): HRESULT;

// functions for basic drawing support
{$IFNDEF CLR}
function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pRect: PRect; pClipRect: PRect = nil): HRESULT; overload;
function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; pClipRect: PRect = nil): HRESULT; overload;
function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; const pClipRect: TRect): HRESULT; overload;
{$ELSE}
function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; const pClipRect: TRect): HRESULT; overload;
function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pRect: TRect): HRESULT; overload;
{$ENDIF}

{$IFNDEF CLR}
function DrawThemeText(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pszText: PWideChar; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  pRect: PRect): HRESULT; overload;
function DrawThemeText(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pszText: string; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT; overload;
{$ELSE}
function DrawThemeText(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pszText: string; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT;
{$ENDIF}

function DrawThemeTextEx(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pszText: WideString; iCharCount: Integer; dwTextFlags: DWORD;
  const pRect: TRect; const pOptions: TDTOPTS): HRESULT;

function GetThemeBackgroundContentRect(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const BoundingRect: TRect; out ContentRect: TRect): HRESULT;

function GetThemeBackgroundExtent(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  {$IFNDEF CLR}pContentRect: PRect{$ELSE}const pContentRect: TRect{$ENDIF};
  out ExtentRect: TRect): HRESULT;

{$IFNDEF CLR}
function GetThemePartSize(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  prc: PRect; eSize: THEMESIZE; psz: PSize): HRESULT; overload;
{$ENDIF}
function GetThemePartSize(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const prc: TRect; eSize: THEMESIZE; out psz: TSize): HRESULT; overload;
function GetThemePartSize(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  eSize: THEMESIZE; out psz: TSize): HRESULT; overload;

function GetThemeTextExtent(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pszTextL: {$IFNDEF CLR}PWideChar{$ELSE}string{$ENDIF}; iCharCount: Integer; dwTextFlags: DWORD;
  {$IFNDEF CLR}pBoundingRect: PRect{$ELSE}const pBoundingRect: TRect{$ENDIF}; out ExtentRect: TRect): HRESULT;
function GetThemeTextMetrics(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  out tm: TEXTMETRIC): HRESULT;
function GetThemeBackgroundRegion(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  {$IFNDEF CLR}pRect: PRect{$ELSE}const pRect: TRect{$ENDIF}; out Region: HRGN): HRESULT;
function HitTestThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  dwOptions: DWORD; {$IFNDEF CLR}pRect: PRect{$ELSE}const pRect: TRect{$ENDIF};
  hRgn: HRGN; ptTest: TPoint; out wHitTestCode: WORD): HRESULT;

{$IFNDEF CLR}
function DrawThemeEdge(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pDestRect: PRect; uEdge, uFlags: UINT; pContentRect: PRect): HRESULT; overload;
{$ENDIF}
function DrawThemeEdge(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pDestRect: TRect; uEdge, uFlags: UINT; out pContentRect: TRect): HRESULT; overload;
function DrawThemeEdge(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pDestRect: TRect; uEdge, uFlags: UINT): HRESULT; overload;

function DrawThemeIcon(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  {$IFNDEF CLR}pRect: PRect{$ELSE}const pRect: TRect{$ENDIF}; himl: HIMAGELIST; iImageIndex: Integer): HRESULT;
function IsThemePartDefined(hTheme: HTHEME; iPartId, iStateId: Integer): BOOL;
function IsThemeBackgroundPartiallyTransparent(hTheme: HTHEME;
  iPartId, iStateId: Integer): BOOL;
function DrawThemeParentBackground(hWnd: HWND; DC: HDC; const prc: TRect): HRESULT;

// lower-level theme information services
function GetThemeColor(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out Color: TColorRef): HRESULT;
function GetThemeMetric(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
  out iVal: Integer): HRESULT;
function GetThemeString(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  pszBuff: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF}; cchMaxBuffChars: Integer): HRESULT;
function GetThemeBool(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out fVal{???}: BOOL): HRESULT; // TODO
function GetThemeInt(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out iVal: Integer): HRESULT;
function GetThemeEnumValue(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out iVal: Integer): HRESULT;
function GetThemePosition(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out Point: TPoint): HRESULT;
function GetThemeFont(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
  out Font: {$IFNDEF CLR}LOGFONTW{$ELSE}LOGFONT{$ENDIF}): HRESULT;
function GetThemeRect(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out Rect: TRect): HRESULT;
function GetThemeMargins(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
  {$IFNDEF CLR}prc: PRect{$ELSE}const prc: TRect{$ENDIF}; out Margins: MARGINS): HRESULT;
function GetThemeIntList(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out IntList: INTLIST): HRESULT;
function GetThemePropertyOrigin(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out Origin: PROPERTYORIGIN): HRESULT;
function SetWindowTheme(hWnd: HWND; pszSubAppName, pszSubIdList:
  {$IFNDEF CLR}PWideChar{$ELSE}string{$ENDIF}): HRESULT;
function GetThemeFilename(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  pszThemeFileName: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF}; cchMaxBuffChars: Integer): HRESULT;
function GetThemeSysColor(hTheme: HTHEME; iColorId: Integer): COLORREF;
function GetThemeSysColorBrush(hTheme: HTHEME; iColorId: Integer): HBRUSH;
function GetThemeSysBool(hTheme: HTHEME; iBoolId: Integer): BOOL;
function GetThemeSysSize(hTheme: HTHEME; iSizeId: Integer): Integer;
function GetThemeSysFont(hTheme: HTHEME; iFontId: Integer; out lf: {$IFNDEF CLR}LOGFONTW{$ELSE}LOGFONT{$ENDIF}): HRESULT;
function GetThemeSysString(hTheme: HTHEME; iStringId: Integer; pszStringBuff:
  {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF}; cchMaxStringChars: Integer): HRESULT;
function GetThemeSysInt(hTheme: HTHEME; iIntId: Integer; var iValue: Integer): HRESULT; // TODO var -> out ???

function IsThemeActive: BOOL;
function IsAppThemed: BOOL;
function GetWindowTheme(hWnd: HWND): HTHEME;
function EnableThemeDialogTexture(hWnd: HWND; dwFlags: DWORD): HRESULT;
function IsThemeDialogTextureEnabled(hWnd: HWND): BOOL;
function GetThemeAppProperties: DWORD;
procedure SetThemeAppProperties(dwFlags: DWORD);
function GetCurrentThemeName(pszThemeFileName: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF};
  cchMaxNameChars: Integer; pszColorBuff: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF};
  cchMaxColorChars: Integer; pszSizeBuff: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF};
  cchMaxSizeChars: Integer): HRESULT;
function GetThemeDocumentationProperty(
{$IFNDEF CLR}
  pszThemeName, pszPropertyName, pszValueBuff: PWideChar;
{$ELSE}
  pszThemeName, pszPropertyName: string;
  pszValueBuff: StringBuilder;
{$ENDIF}
  cchMaxValChars: Integer): HRESULT;

//vista extention
{$IFNDEF CLR}
type
  BP_BUFFERFORMAT = (
    BPBF_COMPATIBLEBITMAP,
    BPBF_DIB,
    BPBF_TOPDOWNDIB,
    BPBF_TOPDOWNMONODIB);
  TBPBufferFormat = BP_BUFFERFORMAT;

  BP_PAINTPARAMS = packed record
    cbSize: DWORD;
    dwFlags: DWORD; // BPPF_ flags
    prcExclude: PRect;
    pBlendFunction: Pointer;
  end;
  TBPPaintParams = BP_PAINTPARAMS;
  PBPPaintParams = ^TBPPaintParams;

function BufferedPaintInit: HRESULT;
function BufferedPaintUnInit: HRESULT;
function BeginBufferedPaint(hdcTarget: HDC; prcTarget: PRect;
  dwFormat: TBPBufferFormat; pPaintParams: PBPPaintParams; out dc: HDC): HPAINTBUFFER;
function EndBufferedPaint(hBufferedPaint: HPAINTBUFFER; fUpdateTarget: BOOL): HRESULT;
function BufferedPaintSetAlpha(hBufferedPaint: HPAINTBUFFER; prc: PRect; alpha: Byte): HRESULT;
{$ENDIF}

function IsThemeLibraryLoaded: Boolean;
function IsWindowsXPOrLater: Boolean;

implementation

{$IFNDEF CLR}
uses
  ComCtrls;
{$ENDIF}

const
  ThemeLibraryName = 'UxTheme.dll';

{$IFNDEF CLR}

type
  TCloseThemeData = function(hTheme: HTHEME): HRESULT; stdcall;
  TDrawThemeBackground = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    pRect: PRect; pClipRect: PRect = nil): HRESULT; stdcall;
  TDrawThemeEdge = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    pDestRect: PRect; uEdge, uFlags: UINT; pContentRect: PRect): HRESULT; stdcall;
  TDrawThemeIcon = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    pRect: PRect; himl: HIMAGELIST; iImageIndex: Integer): HRESULT; stdcall;
  TDrawThemeParentBackground = function(hWnd: HWND; DC: HDC; const prc: TRect): HRESULT; stdcall;
  TDrawThemeText = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    pszText: PWideChar; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
    pRect: PRect): HRESULT; stdcall;
  TDrawThemeTextEx = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    const pszText: WideString; iCharCount: Integer; dwTextFlags: DWORD;
    pRect: PRect; const pOptions: TDTOPTS): HRESULT; stdcall;
  TEnableThemeDialogTexture = function(hWnd: HWND; dwFlags: DWORD): HRESULT; stdcall;
  TGetCurrentThemeName = function(pszThemeFileName: PWideChar; cchMaxNameChars: Integer;
    pszColorBuff: PWideChar; cchMaxColorChars: Integer; pszSizeBuff: PWideChar;
    cchMaxSizeChars: Integer): HRESULT; stdcall;
  TGetThemeAppProperties = function: DWORD; stdcall;
  TGetThemeBackgroundContentRect = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    const BoundingRect: TRect; out ContentRect: TRect): HRESULT; stdcall;
  TGetThemeBackgroundRegion = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    pRect: PRect; out Region: HRGN): HRESULT; stdcall;
  TGetThemeBackgroundExtent = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    pContentRect: PRect; out ExtentRect: TRect): HRESULT; stdcall;
  TGetThemeBool = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    out fVal: BOOL): HRESULT; stdcall;
  TGetThemeColor = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    out Color: TColorRef): HRESULT; stdcall;
  TGetThemeDocumentationProperty = function(pszThemeName, pszPropertyName, pszValueBuff: PWideChar;
    cchMaxValChars: Integer): HRESULT; stdcall;
  TGetThemeEnumValue = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    out iVal: Integer): HRESULT; stdcall;
  TGetThemeFilename = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    pszThemeFileName: PWideChar; cchMaxBuffChars: Integer): HRESULT; stdcall;
  TGetThemeFont = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
    out pFont: LOGFONTW): HRESULT; stdcall;
  TGetThemeInt = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    out iVal: Integer): HRESULT; stdcall;
  TGetThemeIntList = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    out IntList: INTLIST): HRESULT; stdcall;
  TGetThemeMargins = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
    prc: PRect; out Margins: MARGINS): HRESULT; stdcall;
  TGetThemeMetric = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
    out iVal: Integer): HRESULT; stdcall;
  TGetThemePartSize = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    prc: PRect; eSize: THEMESIZE; psz: PSize): HRESULT; stdcall;
  TGetThemePosition = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    out Point: TPoint): HRESULT; stdcall;
  TGetThemePropertyOrigin = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    out Origin: PROPERTYORIGIN): HRESULT; stdcall;
  TGetThemeRect = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    out Rect: TRect): HRESULT; stdcall;
  TGetThemeString = function(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
    pszBuff: PWideChar; cchMaxBuffChars: Integer): HRESULT; stdcall;
  TGetThemeSysBool = function(hTheme: HTHEME; iBoolId: Integer): BOOL; stdcall;
  TGetThemeSysColor = function(hTheme: HTHEME; iColorId: Integer): COLORREF; stdcall;
  TGetThemeSysColorBrush = function(hTheme: HTHEME; iColorId: Integer): HBRUSH; stdcall;
  TGetThemeSysFont = function(hTheme: HTHEME; iFontId: Integer; out lf: LOGFONTW): HRESULT; stdcall;
  TGetThemeSysInt = function(hTheme: HTHEME; iIntId: Integer; var iValue: Integer): HRESULT; stdcall;
  TGetThemeSysSize = function(hTheme: HTHEME; iSizeId: Integer): Integer; stdcall;
  TGetThemeSysString = function(hTheme: HTHEME; iStringId: Integer; pszStringBuff: PWideChar;
    cchMaxStringChars: Integer): HRESULT; stdcall;
  TGetThemeTextExtent = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    pszTextL: PWideChar; iCharCount: Integer; dwTextFlags: DWORD;
    pBoundingRect: PRect; out ExtentRect: TRect): HRESULT; stdcall;
  TGetThemeTextMetrics = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    out tm: TEXTMETRIC): HRESULT; stdcall;
  TGetWindowTheme = function(hWnd: HWND): HTHEME;stdcall;
  THitTestThemeBackground = function(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
    dwOptions: DWORD; pRect : PRect; hRgn: HRGN; ptTest: TPoint;
    out wHitTestCode: WORD): HRESULT; stdcall;
  TIsAppThemed = function: BOOL; stdcall;
  TIsThemeActive = function: BOOL; stdcall;
  TIsThemePartDefined = function(hTheme: HTHEME; iPartId, iStateId: Integer): BOOL; stdcall;
  TIsThemeBackgroundPartiallyTransparent = function(hTheme: HTHEME;
    iPartId, iStateId: Integer): BOOL; stdcall;
  TIsThemeDialogTextureEnabled = function(hWnd: HWND): BOOL; stdcall;
  TOpenThemeData = function(hWnd: HWND; pszClassList: PWideChar): HTHEME; stdcall;
  TSetThemeAppProperties = procedure(dwFlags: DWORD); stdcall;
  TSetWindowTheme = function(hWnd: HWND; pszSubAppName, pszSubIdList: PWideChar): HRESULT; stdcall;
  //vista extention
  TBufferedPaintInit = function: HRESULT; stdcall;
  TBufferedPaintUnInit = function: HRESULT; stdcall;
  TBeginBufferedPaint = function(hdcTarget: HDC; prcTarget: PRect;
    dwFormat: TBPBufferFormat; pPaintParams: PBPPaintParams; out dc: HDC): HPAINTBUFFER; stdcall;
  TEndBufferedPaint = function(hBufferedPaint: HPAINTBUFFER; fUpdateTarget: BOOL): HRESULT; stdcall;
  TBufferedPaintSetAlpha = function(hBufferedPaint: HPAINTBUFFER; prc: PRect; alpha: Byte): HRESULT; stdcall;

  TThemeLibraryMethodPointersKeeper = record
    FCloseThemeData: TCloseThemeData;
    FDrawThemeBackground: TDrawThemeBackground;
    FDrawThemeEdge: TDrawThemeEdge;
    FDrawThemeIcon: TDrawThemeIcon;
    FDrawThemeParentBackground: TDrawThemeParentBackground;
    FDrawThemeText: TDrawThemeText;
    FDrawThemeTextEx: TDrawThemeTextEx;
    FEnableThemeDialogTexture: TEnableThemeDialogTexture;
    FGetCurrentThemeName: TGetCurrentThemeName;
    FGetThemeAppProperties: TGetThemeAppProperties;
    FGetThemeBackgroundContentRect: TGetThemeBackgroundContentRect;
    FGetThemeBackgroundRegion: TGetThemeBackgroundRegion;
    FGetThemeBackgroundExtent: TGetThemeBackgroundExtent;
    FGetThemeBool: TGetThemeBool;
    FGetThemeColor: TGetThemeColor;
    FGetThemeDocumentationProperty: TGetThemeDocumentationProperty;
    FGetThemeEnumValue: TGetThemeEnumValue;
    FGetThemeFilename: TGetThemeFilename;
    FGetThemeFont: TGetThemeFont;
    FGetThemeInt: TGetThemeInt;
    FGetThemeIntList: TGetThemeIntList;
    FGetThemeMargins: TGetThemeMargins;
    FGetThemeMetric: TGetThemeMetric;
    FGetThemePartSize: TGetThemePartSize;
    FGetThemePosition: TGetThemePosition;
    FGetThemePropertyOrigin: TGetThemePropertyOrigin;
    FGetThemeRect: TGetThemeRect;
    FGetThemeString: TGetThemeString;
    FGetThemeSysBool: TGetThemeSysBool;
    FGetThemeSysColor: TGetThemeSysColor;
    FGetThemeSysColorBrush: TGetThemeSysColorBrush;
    FGetThemeSysFont: TGetThemeSysFont;
    FGetThemeSysInt: TGetThemeSysInt;
    FGetThemeSysSize: TGetThemeSysSize;
    FGetThemeSysString: TGetThemeSysString;
    FGetThemeTextExtent: TGetThemeTextExtent;
    FGetThemeTextMetrics: TGetThemeTextMetrics;
    FGetWindowTheme: TGetWindowTheme;
    FHitTestThemeBackground: THitTestThemeBackground;
    FIsAppThemed: TIsAppThemed;
    FIsThemeActive: TIsThemeActive;
    FIsThemePartDefined: TIsThemePartDefined;
    FIsThemeBackgroundPartiallyTransparent: TIsThemeBackgroundPartiallyTransparent;
    FIsThemeDialogTextureEnabled: TIsThemeDialogTextureEnabled;
    FOpenThemeData: TOpenThemeData;
    FSetThemeAppProperties: TSetThemeAppProperties;
    FSetWindowTheme: TSetWindowTheme;
    //vista extention
    FBufferedPaintInit: TBufferedPaintInit;
    FBufferedPaintUnInit: TBufferedPaintUnInit;
    FBeginBufferedPaint: TBeginBufferedPaint;
    FEndBufferedPaint: TEndBufferedPaint;
    FBufferedPaintSetAlpha: TBufferedPaintSetAlpha;
  end;

{$ELSE}

[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'OpenThemeData')]
function _OpenThemeData(hwnd: HWND; pszClassList: string): HTHEME; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'CloseThemeData')]
function _CloseThemeData(hTheme: HTHEME): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'DrawThemeBackground')]
function _DrawThemeBackground(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; const pClipRect: TRect): HRESULT; overload; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'DrawThemeBackground')]
function _DrawThemeBackground(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; pClipRect: IntPtr): HRESULT; overload; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'DrawThemeText')]
function _DrawThemeText(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  pszText: string; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'DrawThemeTextEx')]
function _DrawThemeTextEx(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  pszText: string; iCharCount: Integer; dwTextFlags: DWORD;
  const pRect: TRect; const pOptions: TDTOPTS): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeBackgroundContentRect')]
function _GetThemeBackgroundContentRect(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: Integer; const pBoundingRect: TRect;
  out pContentRect: TRect): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeBackgroundExtent')]
function _GetThemeBackgroundExtent(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: Integer; const pContentRect: TRect;
  out pExtentRect: TRect): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemePartSize')]
function _GetThemePartSize(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  const prc: TRect; eSize: THEMESIZE; out psz: TSize): HRESULT; overload; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeTextExtent')]
function _GetThemeTextExtent(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  pszText: string; iCharCount: Integer; dwTextFlags: DWORD;
  const pBoundingRect: TRect; out pExtentRect: TRect): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeTextMetrics')]
function _GetThemeTextMetrics(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  out ptm: TEXTMETRIC): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeBackgroundRegion')]
function _GetThemeBackgroundRegion(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; out pRegion: HRGN): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'HitTestThemeBackground')]
function _HitTestThemeBackground(hTheme: HTHEME; hdc: HDC;
  iPartId, iStateId: Integer; dwOptions: DWORD; const pRect: TRect;
  hrgn: HRGN; ptTest: TPoint; out pwHitTestCode: WORD): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'DrawThemeEdge')]
function _DrawThemeEdge(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  const pDestRect: TRect; uEdge, uFlags: UINT; out pContentRect: TRect): HRESULT; overload; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'DrawThemeIcon')]
function _DrawThemeIcon(hTheme: HTHEME; hdc: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; himl: HIMAGELIST; iImageIndex: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'IsThemePartDefined')]
function _IsThemePartDefined(hTheme: HTHEME; iPartId, iStateId: Integer): BOOL; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'IsThemeBackgroundPartiallyTransparent')]
function _IsThemeBackgroundPartiallyTransparent(hTheme: HTHEME;
  iPartId, iStateId: Integer): BOOL; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'DrawThemeParentBackground')]
function _DrawThemeParentBackground(hwnd: HWND; hdc: HDC; const prc: TRect): HRESULT; overload; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeColor')]
function _GetThemeColor(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out pColor: COLORREF): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeMetric')]
function _GetThemeMetric(hTheme: HTHEME; hdc: HDC; iPartId, iStateId, iPropId: Integer;
  out piVal: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeString')]
function _GetThemeString(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  pszBuff: StringBuilder; cchMaxBuffChars: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeBool')]
function _GetThemeBool(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out pfVal: BOOL): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeInt')]
function _GetThemeInt(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out piVal: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeEnumValue')]
function _GetThemeEnumValue(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out piVal: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemePosition')]
function _GetThemePosition(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out pPoint: TPoint): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeFont')]
function _GetThemeFont(hTheme: HTHEME; hdc: HDC; iPartId, iStateId, iPropId: Integer;
  out pFont: LOGFONT): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeRect')]
function _GetThemeRect(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out pRect: TRect): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeMargins')]
function _GetThemeMargins(hTheme: HTHEME; hdc: HDC; iPartId, iStateId,
  iPropId: Integer; const prc: TRect; out pMargins: MARGINS): HRESULT; overload; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeIntList')]
function _GetThemeIntList(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out pIntList: INTLIST): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemePropertyOrigin')]
function _GetThemePropertyOrigin(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out pOrigin: PROPERTYORIGIN): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'SetWindowTheme')]
function _SetWindowTheme(hwnd: HWND; pszSubAppName: string;
  pszSubIdList: string): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeFilename')]
function _GetThemeFilename(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  pszThemeFileName: StringBuilder; cchMaxBuffChars: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeSysColor')]
function _GetThemeSysColor(hTheme: HTHEME; iColorId: Integer): COLORREF; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeSysColorBrush')]
function _GetThemeSysColorBrush(hTheme: HTHEME; iColorId: Integer): HBRUSH; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeSysBool')]
function _GetThemeSysBool(hTheme: HTHEME; iBoolId: Integer): BOOL; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeSysSize')]
function _GetThemeSysSize(hTheme: HTHEME; iSizeId: Integer): Integer; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeSysFont')]
function _GetThemeSysFont(hTheme: HTHEME; iFontId: Integer;
  out plf: LOGFONT): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeSysString')]
function _GetThemeSysString(hTheme: HTHEME; iStringId: Integer;
  pszStringBuff: StringBuilder; cchMaxStringChars: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeSysInt')]
function _GetThemeSysInt(hTheme: HTHEME; iIntId: Integer;
  out piValue: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'IsThemeActive')]
function _IsThemeActive: BOOL; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'IsAppThemed')]
function _IsAppThemed: BOOL; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetWindowTheme')]
function _GetWindowTheme(hwnd: HWND): HTHEME; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'EnableThemeDialogTexture')]
function _EnableThemeDialogTexture(hwnd: HWND; dwFlags: DWORD): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'IsThemeDialogTextureEnabled')]
function _IsThemeDialogTextureEnabled(hwnd: HWND): BOOL; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeAppProperties')]
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeAppProperties')]
function _GetThemeAppProperties: DWORD; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'SetThemeAppProperties')]
procedure _SetThemeAppProperties(dwFlags: DWORD); external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetCurrentThemeName')]
function _GetCurrentThemeName(pszThemeFileName: StringBuilder;
  cchMaxNameChars: Integer; pszColorBuff: StringBuilder; cchMaxColorChars: Integer;
  pszSizeBuff: StringBuilder; cchMaxSizeChars: Integer): HRESULT; external;
[DllImport(ThemeLibraryName, CharSet = CharSet.Auto, SetLastError = True, EntryPoint = 'GetThemeDocumentationProperty')]
function _GetThemeDocumentationProperty(pszThemeName, pszPropertyName: string;
  pszValueBuff: StringBuilder; cchMaxValChars: Integer): HRESULT; external;

{$ENDIF}

var
  FIsWindowsXPOrLater: Boolean;
  FThemeLibrary: HMODULE = 0;
{$IFNDEF CLR}
  FThemeLibraryMethodPointersKeeper: TThemeLibraryMethodPointersKeeper;
{$ENDIF}

function OpenThemeData(hWnd: HWND; pszClassList: {$IFNDEF CLR}PWideChar{$ELSE}string{$ENDIF}): HTHEME;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FOpenThemeData(hWnd, pszClassList);
{$ELSE}
  Result := _OpenThemeData(hWnd, pszClassList);
{$ENDIF}
end;

function CloseThemeData(hTheme: HTHEME): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FCloseThemeData(hTheme);
{$ELSE}
  Result := _CloseThemeData(hTheme);
{$ENDIF}
end;

function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
{$IFNDEF CLR}
  pRect: PRect; pClipRect: PRect = nil
{$ELSE}
  const pRect: TRect; const pClipRect: TRect
{$ENDIF}): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FDrawThemeBackground(hTheme, DC,
    iPartId, iStateId, pRect, pClipRect);
{$ELSE}
  Result := _DrawThemeBackground(hTheme, DC, iPartId, iStateId, pRect, pClipRect);
{$ENDIF}
end;
{$IFNDEF CLR}
function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; pClipRect: PRect = nil): HRESULT;
begin
  Result := DrawThemeBackground(hTheme, DC, iPartId, iStateId, @pRect, pClipRect);
end;

function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; const pClipRect: TRect): HRESULT;
begin
  Result := DrawThemeBackground(hTheme, DC, iPartId, iStateId, @pRect, @pClipRect);
end;
{$ELSE}
function DrawThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pRect: TRect): HRESULT;
begin
  Result := _DrawThemeBackground(hTheme, DC, iPartId, iStateId, pRect, nil);
end;
{$ENDIF}

function DrawThemeText(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pszText: {$IFNDEF CLR}PWideChar{$ELSE}string{$ENDIF};
  iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  {$IFNDEF CLR}pRect: PRect{$ELSE}const pRect: TRect{$ENDIF}): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FDrawThemeText(hTheme, DC, iPartId, iStateId,
    pszText, iCharCount, dwTextFlags, dwTextFlags2, pRect);
{$ELSE}
  Result := _DrawThemeText(hTheme, DC, iPartId, iStateId,
    pszText, iCharCount, dwTextFlags, dwTextFlags2, pRect);
{$ENDIF}
end;

{$IFNDEF CLR}
function DrawThemeText(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pszText: string; iCharCount: Integer; dwTextFlags, dwTextFlags2: DWORD;
  const pRect: TRect): HRESULT;
begin
  Result := DrawThemeText(hTheme, DC, iPartId, iStateId,
    PWideChar(WideString(pszText)), iCharCount, dwTextFlags, dwTextFlags2, @pRect);
end;
{$ENDIF}

//vista extention
function DrawThemeTextEx(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pszText: WideString; iCharCount: Integer; dwTextFlags: DWORD;
  const pRect: TRect; const pOptions: TDTOPTS): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FDrawThemeTextEx(hTheme, DC, iPartId, iStateId,
    PWideChar(pszText), iCharCount, dwTextFlags, @pRect, pOptions);
{$ELSE}
  Result := _DrawThemeTextEx(hTheme, DC, iPartId, iStateId,
    pszText, iCharCount, dwTextFlags, pRect, pOptions);
{$ENDIF}
end;

function GetThemeBackgroundContentRect(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const BoundingRect: TRect; out ContentRect: TRect): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeBackgroundContentRect(hTheme,
    DC, iPartId, iStateId, BoundingRect, ContentRect);
{$ELSE}
  Result := _GetThemeBackgroundContentRect(hTheme,
    DC, iPartId, iStateId, BoundingRect, ContentRect);
{$ENDIF}
end;

function GetThemeBackgroundExtent(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  {$IFNDEF CLR}pContentRect: PRect{$ELSE}const pContentRect: TRect{$ENDIF};
  out ExtentRect: TRect): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeBackgroundExtent(hTheme, DC,
    iPartId, iStateId, pContentRect, ExtentRect);
{$ELSE}
  Result := _GetThemeBackgroundExtent(hTheme, DC,
    iPartId, iStateId, pContentRect, ExtentRect);
{$ENDIF}
end;

function GetThemePartSize(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  {$IFNDEF CLR}prc: PRect{$ELSE}const prc: TRect{$ENDIF}; eSize: THEMESIZE;
  {$IFNDEF CLR}psz: PSize{$ELSE}out psz: TSize{$ENDIF}): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemePartSize(hTheme, DC, iPartId,
    iStateId, prc, eSize, psz);
{$ELSE}
  Result := _GetThemePartSize(hTheme, DC, iPartId,
    iStateId, prc, eSize, psz);
{$ENDIF}
end;

{$IFNDEF CLR}
function GetThemePartSize(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const prc: TRect; eSize: THEMESIZE; out psz: TSize): HRESULT;
begin                                                                   
  Result := GetThemePartSize(hTheme, DC, iPartId, iStateId, @prc, eSize, @psz);
end;
{$ENDIF}

function GetThemePartSize(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  eSize: THEMESIZE; out psz: TSize): HRESULT;
begin
  {$IFNDEF CLR}
  Result := GetThemePartSize(hTheme, DC, iPartId, iStateId, nil, eSize, @psz);
  {$ELSE}
  Result := GetThemePartSize(hTheme, DC, iPartId, iStateId, TRect.Empty, eSize, psz);
  {$ENDIF}
end;

function GetThemeTextExtent(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  pszTextL: {$IFNDEF CLR}PWideChar{$ELSE}string{$ENDIF}; iCharCount: Integer; dwTextFlags: DWORD;
  {$IFNDEF CLR}pBoundingRect: PRect{$ELSE}const pBoundingRect: TRect{$ENDIF}; out ExtentRect: TRect): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeTextExtent(hTheme, DC, iPartId,
    iStateId, pszTextL, iCharCount, dwTextFlags, pBoundingRect, ExtentRect);
{$ELSE}
  Result := _GetThemeTextExtent(hTheme, DC, iPartId,
    iStateId, pszTextL, iCharCount, dwTextFlags, pBoundingRect, ExtentRect);
{$ENDIF}
end;

function GetThemeTextMetrics(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  out tm: TEXTMETRIC): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeTextMetrics(hTheme, DC, iPartId,
    iStateId, tm);
{$ELSE}
  Result := _GetThemeTextMetrics(hTheme, DC, iPartId, iStateId, tm);
{$ENDIF}
end;

function GetThemeBackgroundRegion(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  {$IFNDEF CLR}pRect: PRect{$ELSE}const pRect: TRect{$ENDIF}; out Region: HRGN): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeBackgroundRegion(hTheme,
    DC, iPartId, iStateId, pRect, Region);
{$ELSE}
  Result := _GetThemeBackgroundRegion(hTheme, DC, iPartId, iStateId, pRect, Region);
{$ENDIF}
end;

function HitTestThemeBackground(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  dwOptions: DWORD; {$IFNDEF CLR}pRect: PRect{$ELSE}const pRect: TRect{$ENDIF};
  hRgn: HRGN; ptTest: TPoint; out wHitTestCode: WORD): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FHitTestThemeBackground(hTheme, DC,
    iPartId, iStateId, dwOptions, pRect, hRgn, ptTest, wHitTestCode);
{$ELSE}
  Result := _HitTestThemeBackground(hTheme, DC,
    iPartId, iStateId, dwOptions, pRect, hRgn, ptTest, wHitTestCode);
{$ENDIF}
end;

function DrawThemeEdge(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  {$IFNDEF CLR}pDestRect: PRect{$ELSE}const pDestRect: TRect{$ENDIF};
  uEdge, uFlags: UINT; {$IFNDEF CLR}pContentRect: PRect{$ELSE}out pContentRect: TRect{$ENDIF}): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FDrawThemeEdge(hTheme, DC, iPartId, iStateId,
    pDestRect, uEdge, uFlags, pContentRect);
{$ELSE}
  Result := _DrawThemeEdge(hTheme, DC, iPartId, iStateId,
    pDestRect, uEdge, uFlags, pContentRect);
{$ENDIF}
end;

{$IFNDEF CLR}
function DrawThemeEdge(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pDestRect: TRect; uEdge, uFlags: UINT; out pContentRect: TRect): HRESULT;
begin
  Result := DrawThemeEdge(hTheme, DC, iPartId, iStateId, @pDestRect, uEdge, uFlags, @pContentRect);
end;
{$ENDIF}

function DrawThemeEdge(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  const pDestRect: TRect; uEdge, uFlags: UINT): HRESULT;
var
  R: TRect;
begin
  Result := DrawThemeEdge(hTheme, DC, iPartId, iStateId, pDestRect, uEdge, uFlags, R);
end;

function DrawThemeIcon(hTheme: HTHEME; DC: HDC; iPartId, iStateId: Integer;
  {$IFNDEF CLR}pRect: PRect{$ELSE}const pRect: TRect{$ENDIF}; himl: HIMAGELIST; iImageIndex: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FDrawThemeIcon(hTheme, DC, iPartId, iStateId,
    pRect, himl, iImageIndex);
{$ELSE}
  Result := _DrawThemeIcon(hTheme, DC, iPartId, iStateId,
    pRect, himl, iImageIndex);
{$ENDIF}
end;

function IsThemePartDefined(hTheme: HTHEME; iPartId: Integer; iStateId: Integer): BOOL;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FIsThemePartDefined(hTheme, iPartId, iStateId);
{$ELSE}
  Result := _IsThemePartDefined(hTheme, iPartId, iStateId);
{$ENDIF}
end;

function IsThemeBackgroundPartiallyTransparent(hTheme: HTHEME;
  iPartId: Integer; iStateId: Integer): BOOL;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FIsThemeBackgroundPartiallyTransparent(hTheme,
    iPartId, iStateId);
{$ELSE}
  Result := _IsThemeBackgroundPartiallyTransparent(hTheme,
    iPartId, iStateId);
{$ENDIF}
end;

function DrawThemeParentBackground(hWnd: HWND; DC: HDC; const prc: TRect): HRESULT;
var
  AFontHandle: HFONT;
begin
  AFontHandle := GetCurrentObject(DC, OBJ_FONT);
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FDrawThemeParentBackground(hWnd, DC, prc);
{$ELSE}
  Result := _DrawThemeParentBackground(hWnd, DC, prc);
{$ENDIF}
  SelectObject(DC, AFontHandle);
end;

function GetThemeColor(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out Color: TColorRef): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeColor(hTheme, iPartId, iStateId, iPropId, Color);
{$ELSE}
  Result := _GetThemeColor(hTheme, iPartId, iStateId, iPropId, Color);
{$ENDIF}
end;

function GetThemeMetric(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
  out iVal: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeMetric(hTheme, DC, iPartId,
    iStateId, iPropId, iVal);
{$ELSE}
  Result := _GetThemeMetric(hTheme, DC, iPartId,
    iStateId, iPropId, iVal);
{$ENDIF}
end;

function GetThemeString(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  pszBuff: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF}; cchMaxBuffChars: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeString(hTheme, iPartId, iStateId,
    iPropId, pszBuff, cchMaxBuffChars);
{$ELSE}
  Result := _GetThemeString(hTheme, iPartId, iStateId,
    iPropId, pszBuff, cchMaxBuffChars);
{$ENDIF}
end;

function GetThemeBool(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out fVal: BOOL): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeBool(hTheme, iPartId, iStateId,
    iPropId, fVal);
{$ELSE}
  Result := _GetThemeBool(hTheme, iPartId, iStateId,
    iPropId, fVal);
{$ENDIF}
end;

function GetThemeInt(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out iVal: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeInt(hTheme, iPartId, iStateId,
    iPropId, iVal);
{$ELSE}
  Result := _GetThemeInt(hTheme, iPartId, iStateId,
    iPropId, iVal);
{$ENDIF}
end;

function GetThemeEnumValue(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out iVal: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeEnumValue(hTheme, iPartId,
    iStateId, iPropId, iVal);
{$ELSE}
  Result := _GetThemeEnumValue(hTheme, iPartId,
    iStateId, iPropId, iVal);
{$ENDIF}
end;

function GetThemePosition(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out Point: TPoint): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemePosition(hTheme, iPartId, iStateId,
    iPropId, Point);
{$ELSE}
  Result := _GetThemePosition(hTheme, iPartId, iStateId,
    iPropId, Point);
{$ENDIF}
end;

function GetThemeFont(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
  out Font: {$IFNDEF CLR}LOGFONTW{$ELSE}LOGFONT{$ENDIF}): HRESULT;
{$IFNDEF CLR}
var
  S: array [0 .. 1000] of Char;
{$ENDIF}
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeFont(hTheme, DC, iPartId, iStateId,
    iPropId, Font);
  FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil, Result, LOCALE_USER_DEFAULT, S, 1001, nil);
{$ELSE}
  Result := _GetThemeFont(hTheme, DC, iPartId, iStateId,
    iPropId, Font);
{$ENDIF}
end;

function GetThemeRect(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out Rect: TRect): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeRect(hTheme, iPartId, iStateId,
    iPropId, Rect);
{$ELSE}
  Result := _GetThemeRect(hTheme, iPartId, iStateId,
    iPropId, Rect);
{$ENDIF}
end;

function GetThemeMargins(hTheme: HTHEME; DC: HDC; iPartId, iStateId, iPropId: Integer;
  {$IFNDEF CLR}prc: PRect{$ELSE}const prc: TRect{$ENDIF}; out Margins: MARGINS): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeMargins(hTheme, DC, iPartId,
    iStateId, iPropId, prc, Margins);
{$ELSE}
  Result := _GetThemeMargins(hTheme, DC, iPartId,
    iStateId, iPropId, prc, Margins);
{$ENDIF}
end;

function GetThemeIntList(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out IntList: INTLIST): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeIntList(hTheme, iPartId, iStateId,
    iPropId, IntList);
{$ELSE}
  Result := _GetThemeIntList(hTheme, iPartId, iStateId,
    iPropId, IntList);
{$ENDIF}
end;

function GetThemePropertyOrigin(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  out Origin: PROPERTYORIGIN): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemePropertyOrigin(hTheme, iPartId,
    iStateId, iPropId, Origin);
{$ELSE}
  Result := _GetThemePropertyOrigin(hTheme, iPartId,
    iStateId, iPropId, Origin);
{$ENDIF}
end;

function SetWindowTheme(hWnd: HWND; pszSubAppName, pszSubIdList:
  {$IFNDEF CLR}PWideChar{$ELSE}string{$ENDIF}): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FSetWindowTheme(hWnd, pszSubAppName, pszSubIdList);
{$ELSE}
  Result := _SetWindowTheme(hWnd, pszSubAppName, pszSubIdList);
{$ENDIF}
end;

function GetThemeFilename(hTheme: HTHEME; iPartId, iStateId, iPropId: Integer;
  pszThemeFileName: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF}; cchMaxBuffChars: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeFilename(hTheme, iPartId,
    iStateId, iPropId, pszThemeFileName, cchMaxBuffChars);
{$ELSE}
  Result := _GetThemeFilename(hTheme, iPartId,
    iStateId, iPropId, pszThemeFileName, cchMaxBuffChars);
{$ENDIF}
end;

function GetThemeSysColor(hTheme: HTHEME; iColorId: Integer): COLORREF;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeSysColor(hTheme, iColorId);
{$ELSE}
  Result := _GetThemeSysColor(hTheme, iColorId);
{$ENDIF}
end;

function GetThemeSysColorBrush(hTheme: HTHEME; iColorId: Integer): HBRUSH;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeSysColorBrush(hTheme, iColorId);
{$ELSE}
  Result := _GetThemeSysColorBrush(hTheme, iColorId);
{$ENDIF}
end;

function GetThemeSysBool(hTheme: HTHEME; iBoolId: Integer): BOOL;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeSysBool(hTheme, iBoolId);
{$ELSE}
  Result := _GetThemeSysBool(hTheme, iBoolId);
{$ENDIF}
end;

function GetThemeSysSize(hTheme: HTHEME; iSizeId: Integer): Integer;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeSysSize(hTheme, iSizeId);
{$ELSE}
  Result := _GetThemeSysSize(hTheme, iSizeId);
{$ENDIF}
end;

function GetThemeSysFont(hTheme: HTHEME; iFontId: Integer;
  out lf: {$IFNDEF CLR}LOGFONTW{$ELSE}LOGFONT{$ENDIF}): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeSysFont(hTheme, iFontId, lf);
{$ELSE}
  Result := _GetThemeSysFont(hTheme, iFontId, lf);
{$ENDIF}
end;

function GetThemeSysString(hTheme: HTHEME; iStringId: Integer; pszStringBuff:
  {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF}; cchMaxStringChars: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeSysString(hTheme, iStringId,
    pszStringBuff, cchMaxStringChars);
{$ELSE}
  Result := _GetThemeSysString(hTheme, iStringId,
    pszStringBuff, cchMaxStringChars);
{$ENDIF}
end;

function GetThemeSysInt(hTheme: HTHEME; iIntId: Integer; var iValue: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeSysInt(hTheme, iIntId, iValue);
{$ELSE}
  Result := _GetThemeSysInt(hTheme, iIntId, iValue);
{$ENDIF}
end;

function IsThemeActive: BOOL;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FIsThemeActive;
{$ELSE}
  Result := _IsThemeActive;
{$ENDIF}
end;

function IsAppThemed: BOOL;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FIsAppThemed;
{$ELSE}
  Result := _IsAppThemed;
{$ENDIF}
end;

function GetWindowTheme(hWnd: HWND): HTHEME;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetWindowTheme(hWnd);
{$ELSE}
  Result := _GetWindowTheme(hWnd);
{$ENDIF}
end;

function EnableThemeDialogTexture(hWnd: HWND; dwFlags: DWORD): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FEnableThemeDialogTexture(hWnd, dwFlags);
{$ELSE}
  Result := _EnableThemeDialogTexture(hWnd, dwFlags);
{$ENDIF}
end;

function IsThemeDialogTextureEnabled(hWnd: HWND): BOOL;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FIsThemeDialogTextureEnabled(hWnd);
{$ELSE}
  Result := _IsThemeDialogTextureEnabled(hWnd);
{$ENDIF}
end;

function GetThemeAppProperties: DWORD;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeAppProperties;
{$ELSE}
  Result := _GetThemeAppProperties;
{$ENDIF}
end;

procedure SetThemeAppProperties(dwFlags: DWORD);
begin
{$IFNDEF CLR}
  FThemeLibraryMethodPointersKeeper.FSetThemeAppProperties(dwFlags);
{$ELSE}
  _SetThemeAppProperties(dwFlags);
{$ENDIF}
end;

function GetCurrentThemeName(pszThemeFileName: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF};
  cchMaxNameChars: Integer; pszColorBuff: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF};
  cchMaxColorChars: Integer; pszSizeBuff: {$IFNDEF CLR}PWideChar{$ELSE}StringBuilder{$ENDIF};
  cchMaxSizeChars: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetCurrentThemeName(pszThemeFileName,
    cchMaxNameChars, pszColorBuff, cchMaxColorChars, pszSizeBuff, cchMaxSizeChars);
{$ELSE}
  Result := _GetCurrentThemeName(pszThemeFileName,
    cchMaxNameChars, pszColorBuff, cchMaxColorChars, pszSizeBuff, cchMaxSizeChars);
{$ENDIF}
end;

function GetThemeDocumentationProperty(
{$IFNDEF CLR}
  pszThemeName, pszPropertyName, pszValueBuff: PWideChar;
{$ELSE}
  pszThemeName, pszPropertyName: string;
  pszValueBuff: StringBuilder;
{$ENDIF}
  cchMaxValChars: Integer): HRESULT;
begin
{$IFNDEF CLR}
  Result := FThemeLibraryMethodPointersKeeper.FGetThemeDocumentationProperty(pszThemeName,
    pszPropertyName, pszValueBuff, cchMaxValChars);
{$ELSE}
  Result := _GetThemeDocumentationProperty(pszThemeName,
    pszPropertyName, pszValueBuff, cchMaxValChars);
{$ENDIF}
end;

//vista extention
{$IFNDEF CLR}
function BufferedPaintInit: HRESULT;
begin
  Result := FThemeLibraryMethodPointersKeeper.FBufferedPaintInit;
end;

function BufferedPaintUnInit: HRESULT;
begin
  Result := FThemeLibraryMethodPointersKeeper.FBufferedPaintUnInit;
end;

function BeginBufferedPaint(hdcTarget: HDC; prcTarget: PRect;
  dwFormat: TBPBufferFormat; pPaintParams: PBPPaintParams; out dc: HDC): HPAINTBUFFER;
begin
  Result := FThemeLibraryMethodPointersKeeper.FBeginBufferedPaint(hdcTarget,
  prcTarget, dwFormat, pPaintParams, dc);
end;

function EndBufferedPaint(hBufferedPaint: HPAINTBUFFER; fUpdateTarget: BOOL): HRESULT;
begin
  Result := FThemeLibraryMethodPointersKeeper.FEndBufferedPaint(hBufferedPaint, fUpdateTarget);
end;

function BufferedPaintSetAlpha(hBufferedPaint: HPAINTBUFFER; prc: PRect; alpha: Byte): HRESULT;
begin
  Result := FThemeLibraryMethodPointersKeeper.FBufferedPaintSetAlpha(hBufferedPaint, prc, alpha);
end;
{$ENDIF}


function IsThemeLibraryLoaded: Boolean;
begin
  Result := FThemeLibrary <> 0;
end;

function IsWindowsXPOrLater: Boolean;
begin
  Result := FIsWindowsXPOrLater;
end;

procedure CheckOSVersion;
var
  Info: TOSVersionInfo;
begin
{$IFNDEF CLR}
  Info.dwOSVersionInfoSize := SizeOf(Info);
{$ELSE}
  Info.dwOSVersionInfoSize := Marshal.SizeOf(TypeOf(Info));
{$ENDIF}
  GetVersionEx(Info);
  FIsWindowsXPOrLater := (Info.dwMajorVersion > 5) or
    ((Info.dwMajorVersion = 5) and (Info.dwMinorVersion >= 1));
end;

{$IFNDEF CLR}

procedure SetMethodPointers;
begin
  with FThemeLibraryMethodPointersKeeper do
  begin
    @FCloseThemeData := GetProcAddress(FThemeLibrary, 'CloseThemeData');
    @FDrawThemeBackground := GetProcAddress(FThemeLibrary, 'DrawThemeBackground');
    @FDrawThemeEdge := GetProcAddress(FThemeLibrary, 'DrawThemeEdge');
    @FDrawThemeIcon := GetProcAddress(FThemeLibrary, 'DrawThemeIcon');
    @FDrawThemeParentBackground := GetProcAddress(FThemeLibrary, 'DrawThemeParentBackground');
    @FDrawThemeText := GetProcAddress(FThemeLibrary, 'DrawThemeText');
    @FDrawThemeTextEx := GetProcAddress(FThemeLibrary, 'DrawThemeTextEx');
    @FEnableThemeDialogTexture := GetProcAddress(FThemeLibrary, 'EnableThemeDialogTexture');
    @FGetCurrentThemeName := GetProcAddress(FThemeLibrary, 'GetCurrentThemeName');
    @FGetThemeAppProperties := GetProcAddress(FThemeLibrary, 'GetThemeAppProperties');
    @FGetThemeBackgroundContentRect := GetProcAddress(FThemeLibrary, 'GetThemeBackgroundContentRect');
    @FGetThemeBackgroundRegion := GetProcAddress(FThemeLibrary, 'GetThemeBackgroundRegion');
    @FGetThemeBackgroundExtent := GetProcAddress(FThemeLibrary, 'GetThemeBackgroundExtent');
    @FGetThemeBool := GetProcAddress(FThemeLibrary, 'GetThemeBool');
    @FGetThemeColor := GetProcAddress(FThemeLibrary, 'GetThemeColor');
    @FGetThemeDocumentationProperty := GetProcAddress(FThemeLibrary, 'GetThemeDocumentationProperty');
    @FGetThemeEnumValue := GetProcAddress(FThemeLibrary, 'GetThemeEnumValue');
    @FGetThemeFilename := GetProcAddress(FThemeLibrary, 'GetThemeFilename');
    @FGetThemeFont := GetProcAddress(FThemeLibrary, 'GetThemeFont');
    @FGetThemeInt := GetProcAddress(FThemeLibrary, 'GetThemeInt');
    @FGetThemeIntList := GetProcAddress(FThemeLibrary, 'GetThemeIntList');
    @FGetThemeMargins := GetProcAddress(FThemeLibrary, 'GetThemeMargins');
    @FGetThemeMetric := GetProcAddress(FThemeLibrary, 'GetThemeMetric');
    @FGetThemePartSize := GetProcAddress(FThemeLibrary, 'GetThemePartSize');
    @FGetThemePosition := GetProcAddress(FThemeLibrary, 'GetThemePosition');
    @FGetThemePropertyOrigin := GetProcAddress(FThemeLibrary, 'GetThemePropertyOrigin');
    @FGetThemeRect := GetProcAddress(FThemeLibrary, 'GetThemeRect');
    @FGetThemeString := GetProcAddress(FThemeLibrary, 'GetThemeString');
    @FGetThemeSysBool := GetProcAddress(FThemeLibrary, 'GetThemeSysBool');
    @FGetThemeSysColor := GetProcAddress(FThemeLibrary, 'GetThemeSysColor');
    @FGetThemeSysColorBrush := GetProcAddress(FThemeLibrary, 'GetThemeSysColorBrush');
    @FGetThemeSysFont := GetProcAddress(FThemeLibrary, 'GetThemeSysFont');
    @FGetThemeSysInt := GetProcAddress(FThemeLibrary, 'GetThemeSysInt');
    @FGetThemeSysSize := GetProcAddress(FThemeLibrary, 'GetThemeSysSize');
    @FGetThemeSysString := GetProcAddress(FThemeLibrary, 'GetThemeSysString');
    @FGetThemeTextExtent := GetProcAddress(FThemeLibrary, 'GetThemeTextExtent');
    @FGetThemeTextMetrics := GetProcAddress(FThemeLibrary, 'GetThemeTextMetrics');
    @FGetWindowTheme := GetProcAddress(FThemeLibrary, 'GetWindowTheme');
    @FHitTestThemeBackground := GetProcAddress(FThemeLibrary, 'HitTestThemeBackground');
    @FIsAppThemed := GetProcAddress(FThemeLibrary, 'IsAppThemed');
    @FIsThemeActive := GetProcAddress(FThemeLibrary, 'IsThemeActive');
    @FIsThemePartDefined := GetProcAddress(FThemeLibrary, 'IsThemePartDefined');
    @FIsThemeBackgroundPartiallyTransparent := GetProcAddress(FThemeLibrary, 'IsThemeBackgroundPartiallyTransparent');
    @FIsThemeDialogTextureEnabled := GetProcAddress(FThemeLibrary, 'IsThemeDialogTextureEnabled');
    @FOpenThemeData := GetProcAddress(FThemeLibrary, 'OpenThemeData');
    @FSetThemeAppProperties := GetProcAddress(FThemeLibrary, 'SetThemeAppProperties');
    @FSetWindowTheme := GetProcAddress(FThemeLibrary, 'SetWindowTheme');
    //vista extention
    @FBufferedPaintInit := GetProcAddress(FThemeLibrary, 'BufferedPaintInit');
    @FBufferedPaintUnInit := GetProcAddress(FThemeLibrary, 'BufferedPaintUnInit');
    @FBeginBufferedPaint := GetProcAddress(FThemeLibrary, 'BeginBufferedPaint');
    @FEndBufferedPaint := GetProcAddress(FThemeLibrary, 'EndBufferedPaint');
    @FBufferedPaintSetAlpha := GetProcAddress(FThemeLibrary, 'BufferedPaintSetAlpha');
  end;
end;

{$ENDIF}

initialization
  CheckOSVersion;
{$IFNDEF CLR}
  InitCommonControls;
{$ENDIF}
  if FIsWindowsXPOrLater (*and (GetComCtlVersion >= $60000) *)then
  begin
    FThemeLibrary := LoadLibrary(ThemeLibraryName);
  {$IFNDEF CLR}
    if FThemeLibrary <> 0 then
      SetMethodPointers;
  {$ENDIF}
  end;

finalization
  if FThemeLibrary <> 0 then
    FreeLibrary(FThemeLibrary);
    
end.
