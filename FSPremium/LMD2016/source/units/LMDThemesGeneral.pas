unit LMDThemesGeneral;
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

LMDThemesGeneral unit (VB)
--------------------------

ToDo
----
.Net port

Changes
-------
Release 8.0 (XX 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Types, Classes, SysUtils, UxTheme, {$IFNDEF LMDCOMP7} LMDThemes, {$ENDIF}
  LMDThemesWindowsXPConsts, LMDRtlxConst, LMDDebugUnit, LMDUnicode, LMDTypes;

type
  TThemeHandle = THandle;
  TThemeManagerHandle = THandle;

  {$IFNDEF LMDCOMP7}
  TThemeIntList = INTLIST;
  {$ELSE}
  TThemeIntList = TIntList;
  {$ENDIF}
  PThemeIntList = ^TThemeIntList;

  TThemeSize = cardinal;

  //PSize = ^TSize;

  TTheme = class;
  TThemeManager = class;

  TThemePart = class
  private
    FParent: TThemePart;
    FTheme: TTheme;
  public
    constructor Create(Theme: TTheme; Parent: TThemePart); virtual;
    destructor Destroy; override;
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); virtual; abstract;
    procedure DrawThemeEdge(DC: HDC; StateID: integer; const DestRect: TRect;
      Edge: cardinal; Flags: cardinal; ContentRect: PRect); virtual; abstract;
    procedure DrawThemeIcon(DC: HDC; StateID: integer; const Rect: TRect;
      ImageList: THandle; ImageIndex: integer); virtual; abstract;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PLMDChar;
      CharCount: integer; TextFlags: cardinal; TextFlags2: cardinal;
      const Rect: TRect); virtual; abstract;
    procedure GetThemeBackgroundContentRect(DC: HDC; StateID: integer;
      const BoundingRect: TRect; out ContentRect: TRect); virtual; abstract;
    procedure GetThemeBackgroundExtent(DC: HDC; StateID: integer;
      const ContentRect: TRect; out ExtentRect: TRect); virtual; abstract;
    procedure GetThemeBackgroundRegion(DC: HDC; StateID: integer;
      const Rect: TRect; out Region: HRgn); virtual; abstract;
    procedure GetThemeBool(StateID: integer; PropID: integer;
      out Value: boolean); virtual; abstract;
    procedure GetThemeColor(StateID: integer; PropID: integer;
      out Color: ColorRef); virtual; abstract;
    procedure GetThemeEnumValue(StateID: integer;
      PropID: integer; out Value: integer); virtual; abstract;
    procedure GetThemeFilename(StateID: integer; PropID: integer;
      ThemeFileName: PWideChar; MaxNameChars: integer); virtual; abstract;
    procedure GetThemeFont(DC: HDC; StateID: integer; PropID: integer;
      var Font: TLogFontW); virtual; abstract;
    procedure GetThemeInt(StateID: integer; PropID: integer;
      out Value: integer); virtual; abstract;
    procedure GetThemeIntList(StateID: integer; PropID: integer;
      out List: TThemeIntList); virtual; abstract;
    procedure GetThemeMargins(DC: HDC; StateID: integer;
      PropID: integer; var Margins: TMargins); virtual; abstract;
    procedure GetThemeMetric(DC: HDC; StateID: integer; PropID: integer;
      out Value: integer); virtual; abstract;
    procedure GetThemePartSize(DC: HDC; StateID: integer; Rect: PRect;
      SizeType: TThemeSize; out Size: TSize); virtual; abstract;
    procedure GetThemePosition(StateID: integer; PropID: integer;
      out Point: TPoint); virtual; abstract;
    procedure GetThemePropertyOrigin(StateID: integer; PropID: integer;
      var Origin: integer); virtual; abstract;
    procedure GetThemeRect(StateID: integer; PropID: integer;
      out Rect: TRect); virtual; abstract;
    procedure GetThemeString(StateID: integer; PropID: integer;
      Buffer: PWideChar; MaxBufferChars: integer); virtual; abstract;

    procedure GetThemeTextExtent(DC: HDC; StateID: integer;
      Text: PLMDChar; CharCount: integer; TextFlags: cardinal;
      BoundingRect: PRect; out ExtentRect: TRect); virtual; abstract;
    procedure GetThemeTextMetrics(DC: HDC; StateID: integer;
      out Metrics: TTextMetricW); virtual; abstract;
    procedure HitTestThemeBackground(DC: HDC; StateID: integer;
      Options: cardinal; const Rect: TRect; Region: HRgn; Test: TPoint;
      out HitTestCode: word); virtual; abstract;
    function IsThemeBackgroundPartiallyTransparent(StateID: integer): boolean; virtual; abstract;
    function IsThemePartStateDefined(StateID: integer): boolean; virtual; abstract;

    function GetSection: string; virtual; abstract;

    property Parent: TThemePart read FParent;
    property Theme: TTheme read FTheme;
  end;

  TTheme = class
  private
    FIndex: integer;
    FManager: TThemeManager;
    FPartIndex: array of integer;
    FParts: TList;
    FOnDestroy: TNotifyEvent;
  protected
    procedure AddPart(PartID: integer; ThemePart: TThemePart); virtual;
    procedure ClearParts; virtual;
    function FindPart(PartID: integer): TThemePart; virtual;

    procedure DoDestroy; dynamic;
    property Parts: TList read FParts;
  public
    constructor Create(Manager: TThemeManager); virtual;
    destructor Destroy; override;
    function DrawThemeBackground(DC: HDC; PartID: integer; StateID: integer;
      const Rect: TRect; ClipRect: PRect): HResult; virtual;
    function DrawThemeEdge(DC: HDC; PartID: integer; StateID: integer;
      const DestRect: TRect; Edge: cardinal; Flags: cardinal;
      ContentRect: PRect): HResult; virtual;
    procedure DrawThemeIcon(DC: HDC; PartID: integer; StateID: integer;
      const Rect: TRect; ImageList: THandle; ImageIndex: integer); virtual;
    procedure DrawThemeText(DC: HDC; PartID: integer; StateID: integer;
      Text: PLMDChar; CharCount: integer;  TextFlags: cardinal;
      TextFlags2: cardinal; const Rect: TRect); virtual;
    procedure GetThemeBackgroundContentRect(DC: HDC; PartID: integer;
      StateID: integer; const BoundingRect: TRect;
      out ContentRect: TRect); virtual;
    procedure GetThemeBackgroundExtent(DC: HDC; PartID: integer; StateID: integer;
      const ContentRect: TRect; out ExtentRect: TRect); virtual;
    procedure GetThemeBackgroundRegion(DC: HDC; PartID: integer; StateID: integer;
      const Rect: TRect; out Region: HRgn); virtual;
    procedure GetThemeBool(PartID: integer; StateID: integer; PropID: integer;
      out Value: boolean); virtual;
    function GetThemeColor(PartID: integer; StateID: integer; PropID: integer;
      out Color: ColorRef): HResult; virtual;
    procedure GetThemeEnumValue(PartID: integer; StateID: integer;
      PropID: integer; out Value: integer); virtual;
    procedure GetThemeFilename(PartID: integer; StateID: integer; PropID: integer;
      ThemeFileName: PWideChar; MaxNameChars: integer); virtual;
    function GetThemeFont(DC: HDC; PartID: integer; StateID: integer;
      PropID: integer; var Font: TLogFontW): HResult; virtual;
    procedure GetThemeInt(PartID: integer; StateID: integer; PropID: integer;
      out Value: integer); virtual;
    procedure GetThemeIntList(PartID: integer; StateID: integer; PropID: integer;
      out List: TThemeIntList); virtual;
    procedure GetThemeMargins(DC: HDC; PartID: integer; StateID: integer;
      PropID: integer;  var Margins: TMargins); virtual;
    procedure GetThemeMetric(DC: HDC; PartID: integer; StateID: integer;
      PropID: integer; out Value: integer); virtual;
    procedure GetThemePartSize(DC: HDC; PartID, StateID: integer;
      Rect: PRect; SizeType: TThemeSize; out Size: TSize); virtual;
    procedure GetThemePosition(PartID: integer; StateID: integer;
      PropID: integer; out Point: TPoint); virtual;
    procedure GetThemePropertyOrigin(PartID: integer; StateID: integer;
      PropID: integer; out Origin: integer); virtual;
    procedure GetThemeRect(PartID: integer; StateID: integer; PropID: integer;
      out Rect: TRect); virtual;
    procedure GetThemeString(PartID: integer; StateID: integer; PropID: integer;
      Buffer: PWideChar; MaxBufferChars: integer); virtual;
    function GetThemeSysBool(BoolID: integer): boolean; virtual;
    function GetThemeSysColor(ColorID: integer): ColorRef; virtual;
    function GetThemeSysColorBrush(ColorID: integer): HBrush; virtual;
    function GetThemeSysFont(FontID: integer; out Font: TLogFontW): HResult; virtual;
    function GetThemeSysInt(IntID: integer; out Value: integer): HResult; virtual;
    function GetThemeSysSize(SizeID: integer): integer; virtual;
    procedure GetThemeSysString(StringID: integer; Value: PWideChar;
      MaxStringChars: integer); virtual;
    procedure GetThemeTextExtent(DC: HDC; PartID: integer; StateID: integer;
      Text: PLMDChar; CharCount: integer; TextFlags: cardinal;
      BoundingRect: PRect; out ExtentRect: TRect); virtual;
    procedure GetThemeTextMetrics(DC: HDC; PartID: integer; StateID: integer;
      out Metrics: TTextMetricW); virtual;
    procedure HitTestThemeBackground(DC: HDC; PartID: integer; StateID: integer;
      Options: cardinal; const Rect: TRect; Region: HRgn; Test: TPoint;
      out HitTestCode: word); virtual;
    function IsThemeBackgroundPartiallyTransparent(PartID: integer;
      StateID: integer): boolean; virtual;
    function IsThemePartDefined(PartID: integer; StateID: integer): boolean; virtual;

    property Manager: TThemeManager read FManager;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property ThemeIndex: integer read FIndex;
  end;

  TThemeManager = class
  private
    FThemes: TLMDMemoryStrings;
    procedure DeleteTempFile;
    procedure ThemeDestroyed(Sender: TObject);
  protected
    FColorScheme: WideString;
    FColorSchemes: TLMDMemoryStrings;
    FFileName: WideString;
    FIsCabFile: boolean;
    FUnpackedFileName: WideString;
    function GetColorScheme(Index: integer): WideString; virtual;
    function GetColorSchemeCount: integer; virtual;
    function GetDisplayName: WideString; virtual; abstract;

    procedure AddTheme(ThemeName: WideString; Theme: TTheme); virtual;
    procedure ClearThemes; virtual;
    function CreateTheme(ThemeName: WideString): TTheme; virtual; abstract;
    function FindTheme(ThemeName: WideString): TTheme; virtual;
    function IndexOfTheme(Theme: TTheme): integer; virtual;
  public
    constructor Create(); virtual;
    destructor Destroy(); override;

    // Standard API
    procedure CloseThemeData(ThemeHandle: TThemeHandle); virtual;
    function DrawThemeBackground(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; const Rect: TRect; ClipRect: PRect): HResult; virtual;
    function DrawThemeEdge(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; const DestRect: TRect; Edge: cardinal; Flags: cardinal;
      ContentRect: PRect): HResult; virtual;
    procedure DrawThemeIcon(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; const Rect: TRect; ImageList: THandle;
      ImageIndex: integer); virtual;
    procedure DrawThemeParentBackground(Wnd: HWnd; DC: HDC; ARect: PRect); virtual;
    procedure DrawThemeText(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; Text: PLMDChar; CharCount: integer;
      TextFlags: cardinal; TextFlags2: cardinal; const Rect: TRect); virtual;
    procedure EnableThemeDialogTexture(Wnd: HWnd; Flags: cardinal); virtual;
    procedure EnableTheming(Enable: boolean); virtual;
    procedure GetCurrentThemeName(ThemeFileName: PWideChar; MaxNameChars: integer;
      ColorName: PWideChar; MaxColorChars: integer; FontSize: PWideChar;
      MaxSizeChars: integer); virtual;
    function GetThemeAppProperties: cardinal; virtual;
    procedure GetThemeBackgroundContentRect(ThemeHandle: TThemeHandle; DC: HDC;
      PartID: integer; StateID: integer; const BoundingRect: TRect;
      out ContentRect: TRect); virtual;
    procedure GetThemeBackgroundExtent(ThemeHandle: TThemeHandle; DC: HDC;
      PartID: integer; StateID: integer; const ContentRect: TRect;
      out ExtentRect: TRect); virtual;
    procedure GetThemeBackgroundRegion(ThemeHandle: TThemeHandle; DC: HDC;
      PartID: integer; StateID: integer; const Rect: TRect;
      out Region: HRgn); virtual;
    procedure GetThemeBool(ThemeHandle: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; out Value: boolean); virtual;
    function GetThemeColor(ThemeHandle: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; out Color: ColorRef): HResult; virtual;
    procedure GetThemeDocumentationProperty(ThemeName,
      PropertyName, Value: PWideChar; MaxValueChars: integer); virtual;
    procedure GetThemeEnumValue(ThemeHandle: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; out Value: integer); virtual;
    procedure GetThemeFilename(ThemeHandle: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer;  ThemeFileName: PWideChar;
      MaxNameChars: integer); virtual;
    function GetThemeFont(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; PropID: integer; var Font: TLogFontW): HResult; virtual;
    procedure GetThemeInt(ThemeHandle: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; out Value: integer); virtual;
    procedure GetThemeIntList(ThemeHandle: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; out List: TThemeIntList); virtual;
    procedure GetThemeMargins(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; PropID: integer; var Margins: TMargins); virtual;
    procedure GetThemeMetric(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; PropID: integer; out Value: integer); virtual;
    procedure GetThemePartSize(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer;  Rect: PRect; SizeType: TThemeSize; out Size: TSize); virtual;
    procedure GetThemePosition(ThemeHandle: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; out Point: TPoint); virtual;
    procedure GetThemePropertyOrigin(ThemeHandle: TThemeHandle; PartID: integer;
      StateID: integer; PropID: integer; out Origin: integer); virtual;
    procedure GetThemeRect(ThemeHandle: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; out Rect: TRect); virtual;
    procedure GetThemeString(ThemeHandle: TThemeHandle; PartID: integer; StateID: integer;
      PropID: integer; Buffer: PWideChar; MaxBufferChars: integer); virtual;
    function GetThemeSysBool(ThemeHandle: TThemeHandle; BoolID: integer): boolean; virtual;
    function GetThemeSysColor(ThemeHandle: TThemeHandle; ColorID: integer): ColorRef; virtual;
    function GetThemeSysColorBrush(ThemeHandle: TThemeHandle; ColorID: integer): HBrush; virtual;
    function GetThemeSysFont(ThemeHandle: TThemeHandle; FontID: integer; out Font: LogFontW): HResult; virtual;
    function GetThemeSysInt(ThemeHandle: TThemeHandle; IntID: integer; out Value: integer): HResult; virtual;
    function GetThemeSysSize(ThemeHandle: TThemeHandle; SizeID: integer): integer; virtual;
    procedure GetThemeSysString(ThemeHandle: TThemeHandle; StringID: integer;
      Value: PWideChar; MaxStringChars: integer); virtual;
    procedure GetThemeTextExtent(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; Text: PLMDChar; CharCount: integer; TextFlags: cardinal;
      BoundingRect: PRect; out ExtentRect: TRect); virtual;
    procedure GetThemeTextMetrics(ThemeHandle: TThemeHandle; DC: HDC; PartID: integer;
      StateID: integer; out Metrics: TTextMetricW); virtual;
    function GetWindowTheme(Wnd: HWnd): TThemeHandle; virtual;
    procedure HitTestThemeBackground(ThemeHandle: TThemeHandle; DC: HDC;
      PartID: integer; StateID: integer; Options: cardinal; const Rect: TRect;
      Region: HRgn; Test: TPoint; out HitTestCode: word); virtual;
    function IsThemeBackgroundPartiallyTransparent(ThemeHandle: TThemeHandle;
      PartID: integer; StateID: integer): boolean; virtual;
    function IsThemeDialogTextureEnabled: boolean; virtual;
    function IsThemePartDefined(ThemeHandle: TThemeHandle; PartID: integer;
      StateID: integer): boolean; virtual;
    function OpenThemeData(Wnd: HWnd; const ClassList: PWideChar): TThemeHandle; virtual;
    procedure SetThemeAppProperties(Flags: cardinal); virtual;
    procedure SetWindowTheme(Wnd: HWnd; SubAppName: PWideChar;
      SubIDList: PWideChar); virtual;

    // Advanced API
    procedure Open(FileName: WideString); virtual;
    procedure Close; virtual;

    procedure Activate(ColorScheme: WideString); virtual;
    procedure ChangeColorScheme(ColorScheme: WideString); virtual;
    procedure Deactivate; virtual;

    function GetColorSchemeDisplayName(SchemeName: WideString): WideString; virtual; abstract;
    function ThemeManagerHandle: TThemeManagerHandle; virtual; abstract;

    property DisplayName: WideString read GetDisplayName;
    property ColorSchemeCount: integer read GetColorSchemeCount;
    property ColorSchemes[Index: integer]: WideString read GetColorScheme;

    property FileName: WideString read FFileName;
  end;

function IsValidTheme(ThemeHandle: TThemeHandle; var Theme: TTheme): boolean;

implementation

uses
  Messages,
  LMDSysIn, LMDGraphUtils, LMDCabSupport;

var
  ValidThemes: TList;

{------------------------------------------------------------------------------}
function IsValidTheme(ThemeHandle: TThemeHandle; var Theme: TTheme): boolean;

var
  i: integer;

begin
  Theme := nil;
  Result := false;
  if ValidThemes = nil then
    exit;
  i := ValidThemes.IndexOf(Pointer(ThemeHandle));
  Result := (i >= 0);
  if Result then
    Theme := TTheme(ValidThemes[i]);
end;

{------------------- TThemePart -----------------------------------------------}

constructor TThemePart.Create(Theme: TTheme; Parent: TThemePart);
begin
  inherited Create;
  FParent := Parent;
  FTheme := Theme;
end;

{------------------------------------------------------------------------------}
destructor TThemePart.Destroy;
begin
  inherited;
end;

{--------------------- TTheme -------------------------------------------------}
procedure TTheme.AddPart(PartID: integer; ThemePart: TThemePart);
var
  Index: integer;
begin
  Index := Length(FPartIndex);
  SetLength(FPartIndex, Index + 1);
  FPartIndex[Index] := PartID;
  FParts.Add(ThemePart);
end;

{------------------------------------------------------------------------------}
procedure TTheme.ClearParts;
var
  I: integer;
begin
  for I := 0 to FParts.Count - 1 do
    TThemePart(FParts[I]).Free;
  FParts.Clear;
  SetLength(FPartIndex, 0);
end;

{------------------------------------------------------------------------------}
constructor TTheme.Create(Manager: TThemeManager);
begin
  inherited Create;
  FManager := Manager;
  SetLength(FPartIndex, 0);
  FParts := TList.Create;
  ValidThemes.Add(Self);
  Self.FIndex := 1 + ValidThemes.IndexOf(Self);
end;

{------------------------------------------------------------------------------}
destructor TTheme.Destroy;
begin
  DoDestroy;
  ClearParts;
  FreeAndNil(FParts);
  ValidThemes.Remove(Self);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TTheme.DoDestroy;
begin
  if Assigned(FOnDestroy) then
    FOnDestroy(Self);
end;

{------------------------------------------------------------------------------}
function TTheme.DrawThemeBackground(DC: HDC; PartID: integer; StateID: integer;
  const Rect: TRect; ClipRect: PRect): HResult;
var
  Part: TThemePart;
begin
  Result := E_FAIL;
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
  begin
    Part.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    Result := S_OK;
  end;
end;

{------------------------------------------------------------------------------}
function TTheme.DrawThemeEdge(DC: HDC; PartID, StateID: integer;
  const DestRect: TRect; Edge, Flags: cardinal;  ContentRect: PRect): HResult;
var
  Part: TThemePart;
begin
  Result := E_FAIL;
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
  begin
    Part.DrawThemeEdge(DC, StateID, DestRect, Edge, Flags, ContentRect);
    Result := S_OK;
  end;
end;

{------------------------------------------------------------------------------}
procedure TTheme.DrawThemeIcon(DC: HDC; PartID, StateID: integer;
  const Rect: TRect; ImageList: THandle; ImageIndex: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.DrawThemeIcon(DC, StateID, Rect, ImageList, ImageIndex);
end;

{------------------------------------------------------------------------------}
procedure TTheme.DrawThemeText(DC: HDC; PartID, StateID: integer;
  Text: PLMDChar; CharCount: integer; TextFlags, TextFlags2: cardinal;
  const Rect: TRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
end;

{------------------------------------------------------------------------------}
function TTheme.FindPart(PartID: integer): TThemePart;
var
  I: integer;
begin
  //if (PartID = GP_BORDER)  then //vb !!!
  //  PartID := 0;
  Result := nil;
  for I := 0 to Length(FPartIndex) - 1 do
    if FPartIndex[I] = PartID then
    begin
      Result := TThemePart(FParts[I]);
      break;
    end;
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeBackgroundContentRect(DC: HDC; PartID,
  StateID: integer; const BoundingRect: TRect; out ContentRect: TRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeBackgroundContentRect(DC, StateID, BoundingRect, ContentRect);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeBackgroundExtent(DC: HDC; PartID, StateID: integer;
  const ContentRect: TRect; out ExtentRect: TRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeBackgroundExtent(DC, StateID, ContentRect, ExtentRect);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeBackgroundRegion(DC: HDC; PartID,
  StateID: integer; const Rect: TRect; out Region: HRgn);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeBackgroundRegion(DC, StateID, Rect, Region);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeBool(PartID, StateID, PropID: integer;
  out Value: boolean);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeBool(StateID, PropID, Value);
end;

{------------------------------------------------------------------------------}
function TTheme.GetThemeColor(PartID, StateID, PropID: integer; out Color: ColorRef): HResult;
var
  Part: TThemePart;
begin
  Result := E_FAIL;
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
  begin
    Part.GetThemeColor(StateID, PropID, Color);
    Result := S_OK;
  end;
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeEnumValue(PartID, StateID, PropID: integer;
  out Value: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeEnumValue(StateID, PropID, Value);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeFilename(PartID, StateID, PropID: integer;
  ThemeFileName: PWideChar; MaxNameChars: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeFilename(StateID, PropID, ThemeFileName, MaxNameChars);
end;

{------------------------------------------------------------------------------}
function TTheme.GetThemeFont(DC: HDC; PartID, StateID, PropID: integer; var Font: TLogFontW): HResult;
var
  Part: TThemePart;
begin
  Result := E_FAIL;
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
  begin
    Part.GetThemeFont(DC, StateID, PropID, Font);
    Result := S_OK;
  end;
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeInt(PartID, StateID, PropID: integer;
  out Value: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeInt(StateID, PropID, Value);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeIntList(PartID, StateID, PropID: integer;
  out List: TThemeIntList);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeIntList(StateID, PropID, List);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeMargins(DC: HDC; PartID, StateID, PropID: integer;
   var Margins: TMargins);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeMargins(DC, StateID, PropID, {Rect,} Margins);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeMetric(DC: HDC; PartID, StateID, PropID: integer;
  out Value: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeMetric(DC, StateID, PropID, Value);
end;

{------------------------------------------------------------------------------}

procedure TTheme.GetThemePartSize(DC: HDC; PartID, StateID: integer;
  Rect: PRect; SizeType: TThemeSize; out Size: TSize);

var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemePartSize(DC, StateID, Rect, SizeType, Size);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemePosition(PartID, StateID, PropID: integer;
  out Point: TPoint);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemePosition(StateID, PropID, Point);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemePropertyOrigin(PartID, StateID, PropID: integer;
  out Origin: {TPropertyOrigin}integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemePropertyOrigin(StateID, PropID, Origin);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeRect(PartID, StateID, PropID: integer;
  out Rect: TRect);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeRect(StateID, PropID, Rect);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeString(PartID, StateID, PropID: integer;
  Buffer: PWideChar; MaxBufferChars: integer);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeString(StateID, PropID, Buffer, MaxBufferChars);
end;

{------------------------------------------------------------------------------}
function TTheme.GetThemeSysBool(BoolID: integer): boolean;
const
  SPI_GETFLATMENU = $1022;
var
  R: bool;
begin
  if BoolID = TMT_FLATMENUS then
  begin
    R := False;
    SystemParametersInfo(SPI_GETFLATMENU, 0, @R, 0);
  end
  else
    LMDDebug(Format(SLMDUnknownThemeBool, [BoolID]));
  Result := R;
end;

const
  COLOR_MENUHILIGHT = 29;
  COLOR_MENUBAR = 30;
  ColorIndexes: array [TMT_FIRSTCOLOR..TMT_LASTCOLOR] of integer = (
    COLOR_SCROLLBAR, COLOR_BACKGROUND, COLOR_ACTIVECAPTION, COLOR_INACTIVECAPTION,
    COLOR_MENU, COLOR_WINDOW, COLOR_WINDOWFRAME, COLOR_MENUTEXT, COLOR_WINDOWTEXT,
    COLOR_CAPTIONTEXT, COLOR_ACTIVEBORDER, COLOR_INACTIVEBORDER, COLOR_APPWORKSPACE,
    COLOR_HIGHLIGHT, COLOR_HIGHLIGHTTEXT, COLOR_BTNFACE, COLOR_BTNSHADOW,
    COLOR_GRAYTEXT, COLOR_BTNTEXT, COLOR_INACTIVECAPTIONTEXT, COLOR_BTNHIGHLIGHT,
    COLOR_3DDKSHADOW, COLOR_3DLIGHT, COLOR_INFOTEXT, COLOR_INFOBK,
    COLOR_3DFACE, COLOR_HOTLIGHT, COLOR_GRADIENTACTIVECAPTION,
    COLOR_GRADIENTINACTIVECAPTION, COLOR_MENUHILIGHT, COLOR_MENUBAR
  );

{------------------------------------------------------------------------------}
function TTheme.GetThemeSysColor(ColorID: integer): ColorRef;
begin
  Result := GetSysColor(ColorIndexes[ColorID]);
end;

{------------------------------------------------------------------------------}
function TTheme.GetThemeSysColorBrush(ColorID: integer): HBrush;
begin
  Result := GetSysColorBrush(ColorIndexes[ColorID]);
end;

{------------------------------------------------------------------------------}
function TTheme.GetThemeSysFont(FontID: integer; out Font: LogFontW): HResult;
var
  TempFont: LogFontW;
  W: WideString;
  Metrics: TNonClientMetricsW;
begin
  Result := S_OK;
  {$IFDEF LMDCOMP14}
  Metrics.cbSize := Metrics.SizeOf;
  {$ELSE}
  Metrics.cbSize := SizeOf(Metrics);
  {$ENDIF}
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, SizeOf(Metrics), @Metrics, 0);
  case FontID of
    TMT_CAPTIONFONT:
      TempFont := Metrics.lfCaptionFont;
    TMT_SMALLCAPTIONFONT:
      TempFont := Metrics.lfSmCaptionFont;
    TMT_MENUFONT:
      TempFont := Metrics.lfMenuFont;
    TMT_STATUSFONT:
      TempFont := Metrics.lfStatusFont;
    TMT_MSGBOXFONT:
      TempFont := Metrics.lfMessageFont;
    TMT_ICONTITLEFONT:
      SystemParametersInfo(SPI_GETICONTITLELOGFONT, Sizeof(TempFont), @TempFont, 0);
      else
    LMDDebug(Format(SLMDUnknownThemeFont, [FontID]));
    Result := E_FAIL;
  end;
  Move(TempFont, Font, SizeOf(TempFont));
  W := TempFont.lfFaceName;
  LMDWideStrLCopy(Font.lfFaceName, PWideChar(W), 32);
  end;

{------------------------------------------------------------------------------}
function TTheme.GetThemeSysInt(IntID: integer; out Value: integer): HResult;
var
  DC: HDC;
begin
  Result := S_OK;
  case IntID of
    TMT_DPIX:
      begin
        DC := GetDC(0);
        Value := GetDeviceCaps(DC, LOGPIXELSX);
        ReleaseDC(0, DC);
      end;
    TMT_DPIY:
      begin
        DC := GetDC(0);
        Value := GetDeviceCaps(DC, LOGPIXELSY);
        ReleaseDC(0, DC);
      end;
    TMT_MINCOLORDEPTH:
      begin
        DC := GetDC(0);
        Value := GetDeviceCaps(DC, BITSPIXEL);
        ReleaseDC(0, DC);
      end;
  else
    LMDDebug(Format(SLMDUnknownThemeInt, [IntID]));
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function TTheme.GetThemeSysSize(SizeID: integer): integer;
var
  Metrics: TNonClientMetricsW;
begin
  Result := 0;
  Metrics.cbSize := SizeOf(Metrics);
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, SizeOf(Metrics), @Metrics, 0);
  case SizeID of
    TMT_SIZINGBORDERWIDTH : Result := Metrics.iBorderWidth;
    TMT_SCROLLBARWIDTH    : Result := Metrics.iScrollWidth;
    TMT_SCROLLBARHEIGHT   : Result := Metrics.iScrollHeight;
    TMT_CAPTIONBARWIDTH   : Result := Metrics.iCaptionWidth;
    TMT_CAPTIONBARHEIGHT  : Result := Metrics.iCaptionHeight;
    TMT_SMCAPTIONBARWIDTH : Result := Metrics.iSmCaptionWidth;
    TMT_SMCAPTIONBARHEIGHT: Result := Metrics.iSmCaptionHeight;
    TMT_MENUBARWIDTH      : Result := Metrics.iMenuWidth;
    TMT_MENUBARHEIGHT     : Result := Metrics.iMenuHeight;
  else
    LMDDebug(Format(SLMDUnknownThemeSize, [SizeID]));
  end;
end;

{------------------------------------------------------------------------------}

procedure TTheme.GetThemeSysString(StringID: integer; Value: PWideChar;
      MaxStringChars: integer);

begin
  if (StringID >= TMT_FIRSTSTRING) and (StringID <= TMT_LASTSTRING) and
    (Value <> nil) and (MaxStringChars > 0) then
    LMDWideStrLCopy(Value, PWideChar(WideString('')), MaxStringChars)
    else
    LMDDebug(Format(SLMDUnknownThemeString, [StringID]));
end;

{------------------------------------------------------------------------------}

procedure TTheme.GetThemeTextExtent(DC: HDC; PartID, StateID: integer;
  Text: PLMDChar; CharCount: integer; TextFlags: cardinal;
  BoundingRect: PRect; out ExtentRect: TRect);

var
  Part: TThemePart;
begin
  if BoundingRect = nil then
    ExtentRect := Rect(0, 0, 0, 0)
  else
    ExtentRect := BoundingRect^;
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeTextExtent(DC, StateID, Text, CharCount, TextFlags,
      BoundingRect, ExtentRect);
end;

{------------------------------------------------------------------------------}
procedure TTheme.GetThemeTextMetrics(DC: HDC; PartID, StateID: integer;
  out Metrics: TTextMetricW);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.GetThemeTextMetrics(DC, StateID, Metrics);
end;

{------------------------------------------------------------------------------}
procedure TTheme.HitTestThemeBackground(DC: HDC; PartID, StateID: integer;
  Options: cardinal; const Rect: TRect; Region: HRgn; Test: TPoint;
  out HitTestCode: word);
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Part.HitTestThemeBackground(DC, StateID, Options, Rect, Region,
      Test, HitTestCode);
end;

{------------------------------------------------------------------------------}
function TTheme.IsThemeBackgroundPartiallyTransparent(PartID,
  StateID: integer): boolean;
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  Result := False;
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Result := Part.IsThemeBackgroundPartiallyTransparent(StateID);
end;

{------------------------------------------------------------------------------}
function TTheme.IsThemePartDefined(PartID, StateID: integer): boolean;
var
  Part: TThemePart;
begin
  Part := FindPart(PartID);
  Result := False;
  if Part = nil then
    LMDDebug(Format(SLMDUnknownThemePart, [PartID]))
  else
    Result := Part.IsThemePartStateDefined(StateID);
end;

{----------------------- TThemeManager ----------------------------------------}
procedure TThemeManager.Activate(ColorScheme: WideString);
begin
  ChangeColorScheme(ColorScheme);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.AddTheme(ThemeName: WideString; Theme: TTheme);
begin
  if Theme <> nil then
  begin
    Theme.OnDestroy := ThemeDestroyed;
    FThemes.AddObject(ThemeName, Theme);
  end;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.ChangeColorScheme(ColorScheme: WideString);
begin
  if (ColorScheme <> '') and (FColorSchemes.IndexOf(ColorScheme) < 0) then
    LMDDebug(Format(SLMDUnknownThemeColorScheme, [String(ColorScheme)]));
  FColorScheme := ColorScheme;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.ClearThemes;
var
  I: integer;
  Theme: TTheme;
  ThemeHandle: TTHemeHandle;
begin
  for I := 0 to FThemes.Count - 1 do
  begin
    ThemeHandle := TThemeHandle(FThemes.Objects[I]);
    if IsValidTheme(ThemeHandle, Theme) then
    begin
      Theme.FManager := nil;
      Theme.OnDestroy := nil;
      Theme.Free;
    end;
    FThemes.Objects[I] := nil;
  end;
  FThemes.Clear;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.Close;
begin
  ClearThemes;
  FColorSchemes.Clear;
  DeleteTempFile;
  FFileName := '';
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.CloseThemeData(ThemeHandle: TThemeHandle);
begin
end;

{------------------------------------------------------------------------------}
constructor TThemeManager.Create;
begin
  inherited;
  FIsCabFile := false;
  FUnpackedFileName := '';
  FColorScheme := '';
  FColorSchemes := TLMDMemoryStrings.Create;
  FFileName := '';
  FThemes := TLMDMemoryStrings.Create;
  FThemes.Sorted := True;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.Deactivate;
begin
  ClearThemes;
  FColorScheme := '';
end;

{------------------------------------------------------------------------------}
destructor TThemeManager.Destroy;
begin
  Close;
  FreeandNil(FColorSchemes);
  FreeandNil(FThemes);
  inherited;
end;

{------------------------------------------------------------------------------}
function TThemeManager.DrawThemeBackground(ThemeHandle: TThemeHandle; DC: HDC;
  PartID, StateID: integer; const Rect: TRect; ClipRect: PRect): HResult;
var
  LTheme: TTheme;
begin
  Result := E_FAIL;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.DrawThemeBackground(DC, PartID, StateID, Rect, ClipRect);
end;

{------------------------------------------------------------------------------}
function TThemeManager.DrawThemeEdge(ThemeHandle: TThemeHandle; DC: HDC; PartID,
  StateID: integer; const DestRect: TRect; Edge, Flags: cardinal;
  ContentRect: PRect): HResult;
var
  LTheme: TTheme;
begin
  Result := E_FAIL;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.DrawThemeEdge(DC, PartID, StateID, DestRect, Edge, Flags, ContentRect);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.DrawThemeIcon(ThemeHandle: TThemeHandle; DC: HDC; PartID,
  StateID: integer; const Rect: TRect; ImageList: THandle;
  ImageIndex: integer);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.DrawThemeIcon(DC, PartID, StateID, Rect, ImageList, ImageIndex);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.DrawThemeParentBackground(Wnd: HWnd; DC: HDC;
  ARect: PRect);
begin
  LMDDrawParentBackground(Wnd, DC, ARect);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.DrawThemeText(ThemeHandle: TThemeHandle; DC: HDC; PartID,
  StateID: integer; Text: PLMDChar; CharCount: integer; TextFlags,
  TextFlags2: cardinal; const Rect: TRect);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.DrawThemeText(DC, PartID, StateID, Text, CharCount, TextFlags,
      TextFlags2, Rect);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.EnableThemeDialogTexture(Wnd: HWnd; Flags: cardinal);
begin
  // By default this method does nothing
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.EnableTheming(Enable: boolean);
begin
  // By default this method does nothing
end;

{------------------------------------------------------------------------------}
function TThemeManager.FindTheme(ThemeName: WideString): TTheme;
var
  Index: integer;
begin
  Index := FThemes.IndexOf(ThemeName);
  if Index >= 0 then
    Result := TTheme(FThemes.Objects[Index])
  else
    begin
      Result := CreateTheme(ThemeName);
      if Result <> nil then
        AddTheme(ThemeName, Result);
    end;
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetColorScheme(Index: integer): WideString;
begin
  Result := FColorSchemes[Index];
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetColorSchemeCount: integer;
begin
  Result := FColorSchemes.Count;
end;

{------------------------------------------------------------------------------}

procedure TThemeManager.GetCurrentThemeName(ThemeFileName: PWideChar; MaxNameChars: integer;
  ColorName: PWideChar; MaxColorChars: integer; FontSize: PWideChar;
  MaxSizeChars: integer);

begin
  if (ThemeFileName <> nil) and (MaxNameChars > 0) then
    LMDWideStrLCopy(ThemeFileName, PWideChar(FFileName), MaxNameChars);
  if (ColorName <> nil) and (MaxColorChars > 0) then
    LMDWideStrLCopy(ColorName, PWideChar(FColorScheme), MaxColorChars);
  if (FontSize <> nil) and (MaxSizeChars > 0) then
    LMDWideStrLCopy(FontSize, PWideChar(WideString('')), MaxSizeChars);
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeAppProperties: cardinal;
begin
  Result := STAP_ALLOW_NONCLIENT or STAP_ALLOW_CONTROLS;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeBackgroundContentRect(ThemeHandle: TThemeHandle;
  DC: HDC; PartID, StateID: integer; const BoundingRect: TRect;
  out ContentRect: TRect);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeBackgroundContentRect(DC, PartID, StateID, BoundingRect,
      ContentRect);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeBackgroundExtent(ThemeHandle: TThemeHandle;
  DC: HDC; PartID, StateID: integer; const ContentRect: TRect;
  out ExtentRect: TRect);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeBackgroundExtent(DC, PartID, StateID, ContentRect, ExtentRect);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeBackgroundRegion(ThemeHandle: TThemeHandle;
  DC: HDC; PartID, StateID: integer; const Rect: TRect; out Region: HRgn);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeBackgroundRegion(DC, PartID, StateID, Rect, Region);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeBool(ThemeHandle: TThemeHandle; PartID, StateID,
  PropID: integer; out Value: boolean);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeBool(PartID, StateID, PropID, Value);
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeColor(ThemeHandle: TThemeHandle; PartID, StateID,
  PropID: integer; out Color: ColorRef): HResult;
var
  LTheme: TTheme;
begin
  Result := E_FAIL;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.GetThemeColor(PartID, StateID, PropID, Color);
end;

{------------------------------------------------------------------------------}

procedure TThemeManager.GetThemeDocumentationProperty(ThemeName,
  PropertyName, Value: PWideChar; MaxValueChars: integer);

begin
  if (PropertyName <> nil) and (Value <> nil) and (MaxValueChars > 0) then
    LMDWideStrLCopy(Value, PWideChar(WideString('')), MaxValueChars);
  end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeEnumValue(ThemeHandle: TThemeHandle; PartID,
  StateID, PropID: integer; out Value: integer);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeEnumValue(PartID, StateID, PropID, Value);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeFilename(ThemeHandle: TThemeHandle; PartID,
  StateID, PropID: integer;  ThemeFileName: PWideChar;
  MaxNameChars: integer);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeFilename(PartID, StateID, PropID, ThemeFileName, MaxNameChars);
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeFont(ThemeHandle: TThemeHandle; DC: HDC; PartID,
  StateID, PropID: integer; var Font: TLogFontW): HResult;
var
  LTheme: TTheme;
begin
  Result := E_FAIL;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.GetThemeFont(DC, PartID, StateID, PropID, Font);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeInt(ThemeHandle: TThemeHandle; PartID, StateID,
  PropID: integer; out Value: integer);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeInt(PartID, StateID, PropID, Value);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeIntList(ThemeHandle: TThemeHandle; PartID,
  StateID, PropID: integer; out List: TThemeIntList);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeIntList(PartID, StateID, PropID, List);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeMargins(ThemeHandle: TThemeHandle; DC: HDC;
  PartID, StateID, PropID: integer; var Margins: TMargins);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeMargins(DC, PartID, StateID, PropID, Margins);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeMetric(ThemeHandle: TThemeHandle; DC: HDC;
  PartID, StateID, PropID: integer; out Value: integer);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeMetric(DC, PartID, StateID, PropID, Value);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemePartSize(ThemeHandle: TThemeHandle; DC: HDC;
  PartID, StateID: integer;  Rect: PRect; SizeType: TThemeSize;
  out Size: TSize);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemePartSize(DC, PartID, StateID, Rect, SizeType, Size);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemePosition(ThemeHandle: TThemeHandle; PartID,
  StateID, PropID: integer; out Point: TPoint);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemePosition(PartID, StateID, PropID, Point);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemePropertyOrigin(ThemeHandle: TThemeHandle; PartID,
  StateID, PropID: integer; out Origin: {TPropertyOrigin}integer);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemePropertyOrigin(PartID, StateID, PropID, Origin);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeRect(ThemeHandle: TThemeHandle; PartID, StateID,
  PropID: integer; out Rect: TRect);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeRect(PartID, StateID, PropID, Rect);
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeString(ThemeHandle: TThemeHandle; PartID,
  StateID, PropID: integer; Buffer: PWideChar; MaxBufferChars: integer);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeString(PartID, StateID, PropID, Buffer, MaxBufferChars);
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeSysBool(ThemeHandle: TThemeHandle;
  BoolID: integer): boolean;
var
  LTheme: TTheme;
begin
  Result := False;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.GetThemeSysBool(BoolID)
  else
    LMDDebug(Format(SLMDUnknownThemeBool, [BoolID]));
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeSysColor(ThemeHandle: TThemeHandle;
  ColorID: integer): ColorRef;
var
  LTheme: TTheme;
begin
  Result := $FFFFFFFF;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.GetThemeSysColor(ColorID)
  else
    LMDDebug(Format(SLMDUnknownThemeColor, [ColorID]));
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeSysColorBrush(ThemeHandle: TThemeHandle;
  ColorID: integer): HBrush;
var
  LTheme: TTheme;
begin
  Result := 0;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.GetThemeSysColorBrush(ColorID)
  else
    LMDDebug(Format(SLMDUnknownThemeColor, [ColorID]));
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeSysFont(ThemeHandle: TThemeHandle;
  FontID: integer; out Font: LogFontW): HResult;
var
  LTheme: TTheme;
begin
  Result := E_FAIL;
  if IsValidTheme(ThemeHandle, LTheme) then
  begin
    LTheme.GetThemeSysFont(FontID, Font);
    Result := S_OK;
  end
  else
    LMDDebug(Format(SLMDUnknownThemeFont, [FontID]));
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeSysInt(ThemeHandle: TThemeHandle; IntID: integer;
  out Value: integer): HResult;
var
  LTheme: TTheme;
begin
  Result := E_FAIL;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.GetThemeSysInt(IntID, Value)
  else
    LMDDebug(Format(SLMDUnknownThemeInt, [IntID]));
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetThemeSysSize(ThemeHandle: TThemeHandle;
  SizeID: integer): integer;
var
  LTheme: TTheme;
begin
  Result := 0;
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.GetThemeSysSize(SizeID)
  else
    LMDDebug(Format(SLMDUnknownThemeSize, [SizeID]));
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeSysString(ThemeHandle: TThemeHandle;
  StringID: integer; Value: PWideChar; MaxStringChars: integer);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeSysString(StringID, Value, MaxStringChars)
  else
    LMDDebug(Format(SLMDUnknownThemeString, [StringID]));
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeTextExtent(ThemeHandle: TThemeHandle; DC: HDC;
  PartID, StateID: integer; Text: PLMDChar; CharCount: integer;
  TextFlags: cardinal; BoundingRect: PRect; out ExtentRect: TRect);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeTextExtent(DC, PartID, StateID, Text, CharCount,
      TextFlags, BoundingRect, ExtentRect)
  else
    ExtentRect := BoundingRect^;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.GetThemeTextMetrics(ThemeHandle: TThemeHandle; DC: HDC;
  PartID: integer; StateID: integer; out Metrics: TTextMetricW);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.GetThemeTextMetrics(DC, PartID, StateID, Metrics);
end;

{------------------------------------------------------------------------------}
function TThemeManager.GetWindowTheme(Wnd: HWnd): TThemeHandle;
begin
  Result := 0;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.HitTestThemeBackground(ThemeHandle: TThemeHandle;
  DC: HDC; PartID, StateID: integer; Options: cardinal; const Rect: TRect;
  Region: HRgn; Test: TPoint; out HitTestCode: word);
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    LTheme.HitTestThemeBackground(DC, PartID, StateID, Options, Rect,
      Region, Test, HitTestCode);
end;

{------------------------------------------------------------------------------}
function TThemeManager.IndexOfTheme(Theme: TTheme): integer;
begin
  Result := FThemes.IndexOfObject(Theme);
end;

{------------------------------------------------------------------------------}
function TThemeManager.IsThemeBackgroundPartiallyTransparent(
  ThemeHandle: TThemeHandle; PartID, StateID: integer): boolean;
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.IsThemeBackgroundPartiallyTransparent(PartID, StateID)
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
function TThemeManager.IsThemeDialogTextureEnabled: boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
function TThemeManager.IsThemePartDefined(ThemeHandle: TThemeHandle; PartID,
  StateID: integer): boolean;
var
  LTheme: TTheme;
begin
  if IsValidTheme(ThemeHandle, LTheme) then
    Result := LTheme.IsThemePartDefined(PartID, StateID)
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.Open(FileName: WideString);
var
  LTmpPath: String;
  j, i: integer;
  SL: TStringList;
begin
  FFileName := FileName;
  //<-- CAB Support
  DeleteTempFile;
  if AnsiPos('.msstyles', FileName) > 0 then
    FIsCabFile := false
  else
    if AnsiPos('.cab', FileName) > 0 then
      begin
        FIsCabFile := true;
        LTmpPath := LMDSITempPath;
        SL := TStringList.Create;
        try
          LMDCabGetFileList(AnsiString(FileName),  SL);
          j := -1;
          if SL.Count > 0 then
            for i := 0 to SL.Count -1 do
              if AnsiPos('.msstyles', SL[i]) > 0 then
                begin
                  j := i;
                  break;
                end;
          if j = - 1 then
            begin
             LMDDebug(Format(SLMDInvalidThemeFileName, [String(FileName)]));
             exit;
            end
          else
            if not LMDCABExtractFile(AnsiString(FileName), AnsiString(LTmpPath), AnsiString(SL[j])) then
              begin
                LMDDebug(Format(SLMDInvalidThemeFileName, [String(FileName)]));
                exit;
              end;
            FUnpackedFileName := LTmpPath + SL[j];
        finally
          SL.Clear;
          SL.Free;
        end
      end
    else
      begin
        LMDDebug(Format(SLMDInvalidThemeFileName, [String(FileName)]));
        exit;
      end;
  // -- end of CAB Support code -->
end;

{------------------------------------------------------------------------------}
function TThemeManager.OpenThemeData(Wnd: HWnd; const ClassList: PWideChar): TThemeHandle;
var
  Theme: TTheme;
begin
  Theme := FindTheme(ClassList);
  Result := TThemeHandle(Theme);
  end;

{------------------------------------------------------------------------------}
procedure TThemeManager.SetThemeAppProperties(Flags: cardinal);
begin
  // By default this method does nothing
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.SetWindowTheme(Wnd: HWnd; SubAppName,
  SubIDList: PWideChar);
begin
  // By default this method does nothing
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.DeleteTempFile;
begin
  if (FFileName <> FUnpackedFileName) and
      FIsCabFile and
     (FUnpackedFileName <> '') and
     (FileExists(FUnpackedFileName)) then
    begin
      DeleteFile(FUnpackedFileName);
      FUnpackedFileName := '';
    end;
end;

{------------------------------------------------------------------------------}
procedure TThemeManager.ThemeDestroyed(Sender: TObject);
var
  I: integer;
begin
  I := FThemes.IndexOfObject(Sender);
  if I >= 0 then
    FThemes.Delete(I);
end;

initialization
  ValidThemes := TList.Create;

finalization
  try
    FreeAndNil(ValidThemes);
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization LMDThemesGeneral: ' + e.Message);
    end;
  end;

end.
