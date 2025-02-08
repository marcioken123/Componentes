unit LMDThemesMain;
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

LMDThemesMain unit (VB)
-----------------------

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
  Windows, Classes, UxTheme,
  LMDTypes, LMDThemesGeneral, LMDThemes;

const
  CMaxIntListCount = 10;

  CThemeSizeMin = 0;
  CThemeSizeTrue = 1;
  CThemeSizeDraw = 2;

  CPropOriginState = 0;
  CPropOriginPart = 1;
  CPropOriginClass = 2;
  CPropOriginGlobal = 3;
  CPropOriginNotFound = 4;

// Standard Visual Styles API
// For description on each function see MSDN at http://msdn.microsoft.com/

  function CloseThemeData(ATheme: TThemeHandle): HResult; stdcall; export;
  function DrawThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; const Rect: TRect; ClipRect: PRect): HResult; stdcall; export;
  function DrawThemeEdge(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; const DestRect: TRect; Edge: cardinal; Flags: cardinal;
    ContentRect: PRect): HResult; stdcall; export;
  function DrawThemeIcon(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; Rect: PRect; ImageList: THandle;
    ImageIndex: integer): HResult; stdcall; export;
  function DrawThemeParentBackground(Wnd: HWnd; DC: HDC; const ARect: PRect):
    HResult; stdcall; export;
  function DrawThemeText(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID:
    integer; Text: PLMDChar; CharCount: integer; TextFlags: cardinal; TextFlags2: cardinal;
    const Rect: TRect): HResult; stdcall; export;
  function EnableThemeDialogTexture(Wnd: HWnd; Flags: cardinal): HResult; stdcall; export;
  function EnableTheming(Enable: boolean): HResult; stdcall; export;
  function GetCurrentThemeName(ThemeFileName: PWideChar; MaxNameChars: integer;
    ColorName: PWideChar; MaxColorChars: integer; SizeName: PWideChar;
    MaxSizeChars: integer): HResult; stdcall; export;
  function GetThemeAppProperties: cardinal; stdcall; export;
  function GetThemeBackgroundContentRect(Theme: TThemeHandle; DC: HDC; PartID:
    integer; StateID: integer; const BoundingRect: TRect; var ContentRect: TRect): HResult; stdcall; export;
  function GetThemeBackgroundExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; const ContentRect: TRect; var ExtentRect: TRect): HResult; stdcall; export;
  function GetThemeBackgroundRegion(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; Rect: PRect; var Region: HRgn): HResult; stdcall; export;
  function GetThemeBool(Theme: TThemeHandle; PartID: integer; StateID: integer;
    PropID: integer; var Value: BOOL): HResult; stdcall; export;
  function GetThemeColor(Theme: TThemeHandle; PartID: integer; StateID: integer;
    PropID: integer; var Color: ColorRef): HResult; stdcall; export;
  function GetThemeDocumentationProperty(ThemeName: PWideChar;
    PropertyName: PWideChar; Value: PWideChar; MaxValueChars: integer): HResult; stdcall;
  function GetThemeEnumValue(Theme: TThemeHandle; PartID: integer; StateID:
    integer; PropID: integer; var Value: integer): HResult; stdcall;
  function GetThemeFilename(Theme: TThemeHandle; PartID: integer; StateID:
    integer; PropID: integer; ThemeFileName: PWideChar; MaxNameChars: integer): HResult; stdcall;
  function GetThemeFont(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID:
    integer; PropID: integer; var Font: TLogFontW): HResult; stdcall;
  function GetThemeInt(Theme: TThemeHandle; PartID: integer; StateID: integer;
    PropID: integer; var Value: integer): HResult; stdcall;
  function GetThemeIntList(Theme: TThemeHandle; PartID: integer; StateID: integer;
    PropID: integer; var List: TThemeIntList): HResult; stdcall;
  function GetThemeMargins(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID:
    integer; PropID: integer; {Rect: PRect;} var Margins: TMargins): HResult; stdcall;
  function GetThemeMetric(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID:
    integer; PropID: integer; var Value: integer): HResult; stdcall;
  function GetThemePartSize(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; Rect: PRect; SizeType: THEMESIZE; var Size: Windows.TSize): HResult; stdcall;
  function GetThemePosition(Theme: TThemeHandle; PartID: integer; StateID:
    integer; PropID: integer; var Point: TPoint): HResult; stdcall;
  function GetThemePropertyOrigin(Theme: TThemeHandle; PartID: integer; StateID:
    integer; PropID: integer; var Origin: {TPropertyOrigin}integer): HResult; stdcall;
  function GetThemeRect(Theme: TThemeHandle; PartID: integer; StateID: integer;
    PropID: integer; var Rect: TRect): HResult; stdcall;
  function GetThemeString(Theme: TThemeHandle; PartID: integer; StateID: integer;
    PropID: integer; Buffer: PWideChar; MaxBufferChars: integer): HResult; stdcall;
  function GetThemeSysBool(Theme: TThemeHandle; BoolID: integer): BOOL; stdcall;
  function GetThemeSysColor(Theme: TThemeHandle; ColorID: integer): ColorRef; stdcall;
  function GetThemeSysColorBrush(Theme: TThemeHandle; ColorID: integer): HBrush; stdcall;
  function GetThemeSysFont(Theme: TThemeHandle; FontID: integer; var Font: TLogFontW): HResult; stdcall;
  function GetThemeSysInt(Theme: TThemeHandle; IntID: integer; var Value: integer): HResult; stdcall;
  function GetThemeSysSize(Theme: TThemeHandle; SizeID: integer): integer; stdcall;
  function GetThemeSysString(Theme: TThemeHandle; StringID: integer; Value:
    PWideChar; MaxStringChars: integer): HResult; stdcall;
  function GetThemeTextExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; Text: PLMDChar; CharCount: integer; TextFlags: cardinal;
    BoundingRect: PRect; var ExtentRect: TRect): HResult; stdcall;
  function GetThemeTextMetrics(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; var Metrics: TTextMetricW): HResult; stdcall;
  function GetWindowTheme(Wnd: HWnd): TThemeHandle; stdcall;
  function HitTestThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
    StateID: integer; Options: cardinal; Rect: PRect; Region: HRgn;
    Test: TPoint; var HitTestCode: word): HResult; stdcall;
  function IsAppThemed: boolean; stdcall;
  function IsThemeActive: boolean; stdcall;
  function IsThemeBackgroundPartiallyTransparent(Theme: TThemeHandle; PartID:
    integer; StateID: integer): boolean; stdcall;
  function IsThemeDialogTextureEnabled: BOOL; stdcall;
  function IsThemePartDefined(Theme: TThemeHandle; PartID: integer;
    StateID: integer): boolean; stdcall;
  function OpenThemeData(Wnd: HWnd; ClassList: PWideChar): TThemeHandle; stdcall;
  procedure SetThemeAppProperties(Flags: cardinal); stdcall;
  function SetWindowTheme(Wnd: HWnd; SubAppName: PWideChar;
    SubIDList: PWideChar): HResult; stdcall;

// Advanced Visual Styles API

//Loads Microsoft(r) WindowsXP(r) Visual Style from [*.msstyles] file
//and returns theme manager's handle if successfull or 0(NULL) otherwise.
//The loaded theme manager must be released by calling UnloadTheme routine.

function LoadTheme(const FileName: WideString): TThemeManagerHandle; stdcall;

//Unloads the given theme manager and returns S_OK if successfull or
//E_FAIL otherwise. If the given theme manager is active at the moment,
//it will be deactivated automatically.
//function UnloadTheme: HResult; stdcall;

//Sets the given theme manager as active and loads the given color scheme.
//If color scheme is not specified, the routine loads a default color scheme
//for this theme manager. The activated theme manager must be deactivated
//by calling DeactivateTheme routine.
//The function returns S_OK if succeeded and E_FAIL otherwise.
//
//Note: if ActivateTheme is called while another theme manager is active,
//the previous theme manager will be deactivated automatically (but not
//unloaded!), so it's no need to call DeactivateTheme before calling
//ActivateTheme, but it's still needed to call UnloadTheme for each
//theme manager returned by LoadTheme functions.
function ActivateTheme(ColorScheme: WideString): HResult; stdcall;

//Deactivates currently active theme manager.
procedure DeactivateTheme; stdcall;

//This function retrives display name for the given theme manager.
//The function returns S_OK if succeeded or E_FAIL otherwise.
function GetThemeDisplayName(ThemeManager: TThemeManagerHandle;
  var DisplayName: WideString): HResult; stdcall;

//This function returns a list of all color schemes supported by
//the given theme manager. Color schemes' names in the list are
//separated by zero-char. The list is terminated by two zero-chars.
//The function returns S_OK if succeeded or E_FAIL otherwise.

function EnumThemeColorSchemes(ThemeManager: TThemeManagerHandle;
  var Schemes: TLMDMemoryStrings): HResult; stdcall;

//This function returns display name for the given theme manager
//and color scheme.
//The function returns S_OK if succeeded or E_FAIL otherwise.
function GetThemeColorSchemeDisplayName(SchemeName: WideString; var DisplayName: WideString): HResult; stdcall;

//This function returns the handle of currently active theme manager
//or 0(NULL) if there is no active theme manager.
function GetCurrentThemeManagerHandle: TThemeManagerHandle;  stdcall;
//function GetThemeManagerByHandle(AThemeManagerHandle: TThemeManagerHandle): TThemeManager;
function GetCurrentThemeManager: TThemeManager;

implementation

uses
  SysUtils,
  LMDUnicode,
  LMDThemesWindowsXP;

var
  CurrentThemeManager: TThemeManager;
  CurrentThemeManagerHandle: TThemeManagerHandle;

{------------------------------------------------------------------------------}
function GetCurrentThemeManager: TThemeManager;
begin
  result := CurrentThemeManager;
end;

{------------------------------------------------------------------------------}
function SetCurrentThemeManager(AThemeManager: TThemeManager): Boolean;
begin
  CurrentThemeManager := AThemeManager;
  result := true;
end;

{------------------------------------------------------------------------------}
(*
function GetThemeManagerByHandle(AThemeManagerHandle: TThemeManagerHandle): TThemeManager;
begin
  result := nil;
  if AThemeManagerHandle <> 0 then
    result := TThemeManager(AThemeManagerHandle);
end;
*)

// Standard Visual Styles API

{------------------------------------------------------------------------------}
function CloseThemeData(ATheme: TThemeHandle): HResult;
var
  CurrentTheme: TThemeManager;
  LTheme: TTheme;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  if ATheme = 0 then
    Result := E_FAIL
  else
  try
    if IsValidTheme(ATheme, LTheme) then
    begin
      if (CurrentTheme = nil) or (LTheme.Manager <> CurrentTheme) then
        LTheme.Free
      else
        CurrentTheme.CloseThemeData(ATheme);
      Result := S_OK;
    end
    else
      Result := E_FAIL;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

function DrawThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const Rect: TRect; ClipRect: PRect): HResult;

var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    Result := CurrentTheme.DrawThemeBackground(Theme, DC, PartID, StateID, Rect, ClipRect);
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
function DrawThemeEdge(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const DestRect: TRect; Edge: cardinal; Flags: cardinal;
  ContentRect: PRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeEdge(Theme, DC, PartID, StateID, DestRect, Edge,
      Flags, ContentRect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function DrawThemeIcon(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Rect: PRect; ImageList: THandle;
  ImageIndex: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeIcon(Theme, DC, PartID, StateID, Rect^, ImageList,
      ImageIndex);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

function DrawThemeParentBackground(Wnd: HWnd; DC: HDC; const ARect: PRect): HResult;

var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeParentBackground(Wnd, DC, ARect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function DrawThemeText(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID: integer;
  Text: PLMDChar; CharCount: integer; TextFlags: cardinal; TextFlags2: cardinal;
  const Rect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.DrawThemeText(Theme, DC, PartID, StateID, Text, CharCount,
      TextFlags, TextFlags2, Rect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function EnableThemeDialogTexture(Wnd: HWnd; Flags: cardinal): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.EnableThemeDialogTexture(Wnd, Flags);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function EnableTheming(Enable: boolean): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.EnableTheming(Enable);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

function GetCurrentThemeName(ThemeFileName: PWideChar; MaxNameChars: integer;
  ColorName: PWideChar; MaxColorChars: integer; SizeName: PWideChar;
  MaxSizeChars: integer): HResult;

var
  CurrentTheme: TThemeManager;
  begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetCurrentThemeName(ThemeFileName, MaxNameChars, ColorName,
      MaxColorChars, SizeName, MaxSizeChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeAppProperties: cardinal;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := 0
  else
  try
    Result := CurrentTheme.GetThemeAppProperties;
  except
    Result := 0;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeBackgroundContentRect(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const BoundingRect: TRect; var ContentRect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeBackgroundContentRect(Theme, DC, PartID, StateID,
      BoundingRect, ContentRect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeBackgroundExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; const ContentRect: TRect; var ExtentRect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
    try
      CurrentTheme.GetThemeBackgroundExtent(Theme, DC, PartID, StateID,
        ContentRect, ExtentRect);
      Result := S_OK;
    except
      Result := E_FAIL;
    end;
end;

{------------------------------------------------------------------------------}
function GetThemeBackgroundRegion(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Rect: PRect; var Region: HRgn): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeBackgroundRegion(Theme, DC, PartID, StateID, Rect^,
      Region);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeBool(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Value: BOOL): HResult;
var
  V: boolean;
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    V := Value;
    CurrentTheme.GetThemeBool(Theme, PartID, StateID, PropID, V);
    Value := V;
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeColor(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Color: ColorRef): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeColor(Theme, PartID, StateID, PropID, Color);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

function GetThemeDocumentationProperty(ThemeName: PWideChar;
  PropertyName: PWideChar; Value: PWideChar; MaxValueChars: integer): HResult;

var
  CurrentTheme: TThemeManager;
  begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeDocumentationProperty(ThemeName, PropertyName, Value,
      MaxValueChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeEnumValue(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Value: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeEnumValue(Theme, PartID, StateID, PropID, Value);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeFilename(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; ThemeFileName: PWideChar; MaxNameChars: integer): HResult;
var
  CurrentTheme: TThemeManager;
  begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeFilename(Theme, PartID, StateID, PropID, ThemeFileName,
      MaxNameChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeFont(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID: integer;
  PropID: integer; var Font: TLogFontW): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    Result := CurrentTheme.GetThemeFont(Theme, DC, PartID, StateID, PropID, Font);
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeInt(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Value: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeInt(Theme, PartID, StateID, PropID, Value);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeIntList(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var List: TThemeIntList): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeIntList(Theme, PartID, StateID, PropID, List);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeMargins(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID: integer;
  PropID: integer; {Rect: PRect;} var Margins: TMargins): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeMargins(Theme, DC, PartID, StateID, PropID, {Rect,}
      Margins);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeMetric(Theme: TThemeHandle; DC: HDC; PartID: integer; StateID: integer;
  PropID: integer; var Value: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeMetric(Theme, DC, PartID, StateID, PropID, Value);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

function GetThemePartSize(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Rect: PRect; SizeType: THEMESIZE; var Size: TSize): HResult;

var
  CurrentTheme: TThemeManager;
  LSize: cardinal;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    LSize := Cardinal(SizeType);
    CurrentTheme.GetThemePartSize(Theme, DC, PartID, StateID, Rect, LSize, TSize(Size));
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
function GetThemePosition(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Point: TPoint): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemePosition(Theme, PartID, StateID, PropID, Point);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemePropertyOrigin(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Origin: {TPropertyOrigin}integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemePropertyOrigin(Theme, PartID, StateID, PropID, Origin);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeRect(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; var Rect: TRect): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeRect(Theme, PartID, StateID, PropID, Rect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

function GetThemeString(Theme: TThemeHandle; PartID: integer; StateID: integer;
  PropID: integer; Buffer: PWideChar; MaxBufferChars: integer): HResult;

var
  CurrentTheme: TThemeManager;
  begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeString(Theme, PartID, StateID, PropID, Buffer,
      MaxBufferChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeSysBool(Theme: TThemeHandle; BoolID: integer): BOOL;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := False
  else
  try
    Result := CurrentTheme.GetThemeSysBool(Theme, BoolID);
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeSysColor(Theme: TThemeHandle; ColorID: integer): ColorRef;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := $FFFFFFFF
  else
  try
    Result := CurrentTheme.GetThemeSysColor(Theme, ColorID);
  except
    Result := $FFFFFFFF;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeSysColorBrush(Theme: TThemeHandle; ColorID: integer): HBrush;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := 0
  else
  try
    Result := CurrentTheme.GetThemeSysColorBrush(Theme, ColorID);
  except
    Result := 0;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeSysFont(Theme: TThemeHandle; FontID: integer;
  var Font: LogFontW): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    Result := CurrentTheme.GetThemeSysFont(Theme, FontID, Font);
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeSysInt(Theme: TThemeHandle; IntID: integer;
  var Value: integer): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    Result := CurrentTheme.GetThemeSysInt(Theme, IntID, Value);
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeSysSize(Theme: TThemeHandle; SizeID: integer): integer;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    Result := CurrentTheme.GetThemeSysSize(Theme, SizeID);
  except
    Result := 0;
  end;
end;

{------------------------------------------------------------------------------}

function GetThemeSysString(Theme: TThemeHandle; StringID: integer;
  Value: PWideChar; MaxStringChars: integer): HResult;

var
  CurrentTheme: TThemeManager;
  begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeSysString(Theme, StringID, Value, MaxStringChars);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}

function GetThemeTextExtent(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Text: PLMDChar; CharCount: integer; TextFlags: cardinal;
  BoundingRect: PRect; var ExtentRect: TRect): HResult;

var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeTextExtent(Theme, DC, PartID, StateID, Text, CharCount,
      TextFlags, BoundingRect, ExtentRect);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeTextMetrics(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; var Metrics: TTextMetricW): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.GetThemeTextMetrics(Theme, DC, PartID, StateID, Metrics);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function GetWindowTheme(Wnd: HWnd): TThemeHandle;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := 0
  else
  try
    Result := CurrentTheme.GetWindowTheme(Wnd);
  except
    Result := 0;
  end;
end;

{------------------------------------------------------------------------------}
function HitTestThemeBackground(Theme: TThemeHandle; DC: HDC; PartID: integer;
  StateID: integer; Options: cardinal; Rect: PRect; Region: HRgn;
  Test: TPoint; var HitTestCode: word): HResult;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.HitTestThemeBackground(Theme, DC, PartID, StateID, Options,
      Rect^, Region, Test, HitTestCode);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
function IsAppThemed: boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
function IsThemeActive: boolean;
begin
  //Result := (GetCurrentTheme <> 0);
  Result := (GetCurrentThemeManager <> nil);
end;

{------------------------------------------------------------------------------}
function IsThemeBackgroundPartiallyTransparent(Theme: TThemeHandle; PartID: integer;
  StateID: integer): boolean;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := False
  else
  try
    Result := CurrentTheme.IsThemeBackgroundPartiallyTransparent(Theme, PartID,
      StateID);
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function IsThemeDialogTextureEnabled: BOOL;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := False
  else
  try
    Result := CurrentTheme.IsThemeDialogTextureEnabled;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function IsThemePartDefined(Theme: TThemeHandle; PartID: integer;
  StateID: integer): boolean;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := False
  else
  try
    Result := CurrentTheme.IsThemePartDefined(Theme, PartID, StateID);
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function OpenThemeData(Wnd: HWnd; ClassList: PWideChar): TThemeHandle;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := 0
  else
  try
    Result := CurrentTheme.OpenThemeData(Wnd, ClassList);
  except
    Result := 0;
  end;
end;

{------------------------------------------------------------------------------}
procedure SetThemeAppProperties(Flags: cardinal);
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme <> nil then
  try
    CurrentTheme.SetThemeAppProperties(Flags);
  except
  end;
end;

{------------------------------------------------------------------------------}

function SetWindowTheme(Wnd: HWnd; SubAppName: PWideChar; SubIDList: PWideChar): HResult;

var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := E_FAIL
  else
  try
    CurrentTheme.SetWindowTheme(Wnd, SubAppName, SubIDList);
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;

// Advanced Visual Styles API
{------------------------------------------------------------------------------}

function LoadTheme(const FileName: WideString): TThemeManagerHandle;
var
  Manager: TWindowsXPThemeManager;
begin
  //try <-- outcommented because in CLR always get to line //*//
  //        however, these blocks seem to be redundant in win32 either
    Manager := TWindowsXPThemeManager.Create;
    //try
      Manager.Open(FileName);
      if Manager.FileHandle <> 0 then
        begin
          if CurrentThemeManagerHandle <> 0 then
            DeactivateTheme;
          CurrentThemeManagerHandle := Manager.ThemeManagerHandle;
          CurrentThemeManager := Manager;
          Result := Manager.ThemeManagerHandle;          
        end
      else
        begin
          Manager.Free;
          Result := 0;  //*//
        end;
    //except
    //  Manager.Free;
    //  Result := 0;
    //end;
  //except
  //  Result := 0;
  //end;
end;

{------------------------------------------------------------------------------}
(*function UnloadTheme: HResult;
begin
  try
    DeactivateTheme;
    FreeAndNil(CurrentThemeManager);
    CurrentThemeManagerHandle := 0;
    Result := S_OK;
  except
    Result := E_FAIL;
  end;
end;*)

{------------------------------------------------------------------------------}
function ActivateTheme(ColorScheme: WideString): HResult;
begin
  try
    if GetCurrentThemeManager <> nil then
      begin
        GetCurrentThemeManager.ChangeColorScheme(ColorScheme);
        Result := S_OK;
      end
    else
      Result := E_FAIL;    
  except
    Result := E_FAIL;
  end;
end;

{------------------------------------------------------------------------------}
procedure DeactivateTheme;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  try
    if CurrentTheme <> nil then
    begin
      CurrentTheme.Free;
      SetCurrentThemeManager(nil);      
    end;
  except
  end;
end;

{------------------------------------------------------------------------------}
function GetThemeDisplayName(ThemeManager: TThemeManagerHandle;
  var DisplayName: WideString): HResult;
begin
  if GetCurrentThemeManager = nil then
    Result := E_FAIL
  else
    begin
      DisplayName := GetCurrentThemeManager.DisplayName;
      Result := S_OK;
    end;
end;

{------------------------------------------------------------------------------}
function EnumThemeColorSchemes(ThemeManager: TThemeManagerHandle;
  var Schemes: TLMDMemoryStrings): HResult;
var
  i: integer;
begin
  if Schemes = nil then
    Result := E_FAIL
  else
    try
      Schemes.Clear;
      if (GetCurrentThemeManager <> nil) and (GetCurrentThemeManager.ColorSchemeCount > 0) then
        begin
          for i := 0 to GetCurrentThemeManager.ColorSchemeCount - 1 do
            Schemes.Add(GetCurrentThemeManager.ColorSchemes[I]);
          Result := S_OK;
        end
      else
        Result := E_FAIL;
    except
      Result := E_FAIL;
    end;
end;

{------------------------------------------------------------------------------}
function GetThemeColorSchemeDisplayName(SchemeName: WideString; var DisplayName: WideString): HResult; stdcall;
var
  Manager: TThemeManager;
  Name: WideString;
begin
  if (SchemeName = '') then
    Result := E_FAIL
  else
    try
      Manager := GetCurrentThemeManager;
      Name := Manager.GetColorSchemeDisplayName(SchemeName);
      if Length(Name) = 0 then
        Result := E_FAIL
      else
        begin
          DisplayName := Name;
          Result := S_OK;
        end;
    except
      Result := E_FAIL;
    end;
end;

{------------------------------------------------------------------------------}
function GetCurrentThemeManagerHandle: TThemeManagerHandle;
var
  CurrentTheme: TThemeManager;
begin
  CurrentTheme := GetCurrentThemeManager;
  if CurrentTheme = nil then
    Result := 0
  else
    Result := CurrentTheme.ThemeManagerHandle;
end;

initialization

  CurrentThemeManager := nil;
  CurrentThemeManagerHandle := 0;

finalization

  if Assigned(CurrentThemeManager) then
  begin
    CurrentThemeManager.Free;
    CurrentThemeManager := nil;
  end;

end.
