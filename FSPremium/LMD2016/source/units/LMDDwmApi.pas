Unit LMDDwmApi;
{$i lmdcmps.inc}

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

LMDDwmApi unit - Parital port dwmapi.h for Delphi
-------------------------------------------------
dwmapi.h is header for new Desktop Window Management API, that
introduced for Microsoft Windows Vista (TM) to support Aero effects

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, {$IFDEF LMDCOMP11}DwmAPI, {$ENDIF}
  UxTheme,
  LMDSysIn;

{$IFNDEF LMDCOMP7}
type
  TMargins = MARGINS;
{$ENDIF}

// specifies whether Aero Glass is enabled at all.
var
  LMDDwmEnabled: {$IFDEF LMDCOMP11}BOOL{$ELSE}Boolean{$ENDIF} = false;

procedure LMDDwmUpdate;
// returns true when Dwm is enabled for a wnodw
function LMDWndIsDwmEnabled(Handle:THandle):Boolean;
// Disables Dwm for a window
function LMDWndDwmDisable(Handle:THandle):Boolean;
// Enables Dwm for a window
function LMDWndDwmEnable(Handle:THandle):Boolean;
// Extend Glass into client area
{$EXTERNALSYM LMDDwmExtendFrameIntoClientArea}
function LMDDwmExtendFrameIntoClientArea(AHandle: THandle; const AMargins: TMargins): HResult;

implementation

{$IFNDEF LMDCOMP11}
// 7.11 new Vista support --> Check for Aero Glass themes
{******************************************************************************}

var
  libModule: HModule;
  uxLibModule: HModule;
  DwmInitialized: Boolean=false;

const
  DWMAPI = 'dwmapi.dll';

const
  {$EXTERNALSYM DWMWA_NCRENDERING_ENABLED}
  DWMWA_NCRENDERING_ENABLED = $00000001;
  {$EXTERNALSYM DWMWA_NCRENDERING_POLICY}
  DWMWA_NCRENDERING_POLICY = $00000002;
  {$EXTERNALSYM DWMNCRP_DISABLED}
  DWMNCRP_DISABLED = $00000001;
  {$EXTERNALSYM DWMNCRP_ENABLED}
  DWMNCRP_ENABLED = $00000002;
  {$EXTERNALSYM DWMNCRP_LAST}
  DWMNCRP_LAST = $00000003;

{ ---------------------------------------------------------------------------- }
// DrawThemeTextEx
const
  DTT_TEXTCOLOR       = 1 shl 0;
  DTT_BORDERCOLOR     = 1 shl 1;
  DTT_SHADOWCOLOR     = 1 shl 2;
  DTT_SHADOWTYPE      = 1 shl 3;
  DTT_SHADOWOFFSET    = 1 shl 4;
  DTT_BORDERSIZE      = 1 shl 5;
  DTT_FONTPROP        = 1 shl 6;
  DTT_COLORPROP       = 1 shl 7;
  DTT_STATEID         = 1 shl 8;
  DTT_CALCRECT        = 1 shl 9;
  DTT_APPLYOVERLAY    = 1 shl 10;
  DTT_GLOWSIZE        = 1 shl 11;
  DTT_CALLBACK        = 1 shl 12;
  DTT_COMPOSITED      = 1 shl 13;
  DTT_VALIDBITS       = DTT_TEXTCOLOR or
                        DTT_BORDERCOLOR or
                        DTT_SHADOWCOLOR or
                        DTT_SHADOWTYPE or
                        DTT_SHADOWOFFSET or
                        DTT_BORDERSIZE or
                        DTT_FONTPROP or
                        DTT_COLORPROP or
                        DTT_STATEID or
                        DTT_CALCRECT or
                        DTT_APPLYOVERLAY or
                        DTT_GLOWSIZE or
                        DTT_COMPOSITED;

type
  TLMDDTTCallbackProc = function(hdc: HDC; pszText: LPWSTR; cchText: Integer;
    prc: PRect; dwFlags: UINT; lParam: LPARAM): Integer; stdcall;
  TLMDDTTOpts = packed record
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
    pfnDrawTextCallback: TLMDDTTCallbackProc;
    lParam: LPARAM;
  end;

{ ---------------------------------------------------------------------------- }

type
  DwmIsCompositionEnabledFunc = function(out pfEnabled: Boolean): HRESULT; stdcall;
  DwmSetWindowAttributeFunc = function(HWnd:THandle; dwAttribute:DWORD; pvAttribute: Pointer; cbAttribute:DWORD):HRESULT;stdcall;
  DwmGetWindowAttributeFunc = function(HWnd:THandle; dwAttribute:DWORD; pvAttribute: Pointer; cbAttribute:DWORD):HRESULT;stdcall;
  DwmExtendFrameIntoClientAreaFunc = function(AHandle: THandle; const AMargins: TMargins): HResult; stdcall;
  DrawThemeTextExFunc = function (hTheme: HTHEME; hdc: HDC; iPartId: Integer;
                                  iStateId: Integer; pszText: LPCWSTR; cchText: Integer;
                                  dwTextFlags: DWORD; pRect: PRect; var pOptions: TLMDDTTOpts): HResult; stdcall;

var
  DwmIsCompositionEnabled: DwmIsCompositionEnabledFunc = nil;
  DwmSetWindowAttribute: DwmSetWindowAttributeFunc = nil;
  DwmGetWindowAttribute: DwmGetWindowAttributeFunc = nil;
  DwmExtendFrameIntoClientArea: DwmExtendFrameIntoClientAreaFunc = nil;
  DrawThemeTextEx: DrawThemeTextExFunc = nil;

{$ENDIF LMDCOMP11}

{------------------------------------------------------------------------------}
function LMDWndDwmDisable(Handle:THandle):Boolean;
var
  myAttribute:DWORD;
  begin
  {$ifndef LMDCOMP11}
  Result:=false;
  if Assigned(DwmSetWindowAttribute) then
  {$endif LMDCOMP11}
  begin
    myAttribute := DWMNCRP_DISABLED;
    result := DwmSetWindowAttribute(Handle, DWMWA_NCRENDERING_POLICY,
                                 @myAttribute,
                                 sizeof(myAttribute))=0;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWndDwmEnable(Handle:THandle):Boolean;
var
  myAttribute:DWORD;
  begin
  {$ifndef LMDCOMP11}
  result:=false;
  if Assigned(DwmSetWindowAttribute) then
  {$ENDIF LMDCOMP11}
  begin
    myAttribute:=DWMNCRP_ENABLED;
    result:=DwmSetWindowAttribute(Handle, DWMWA_NCRENDERING_POLICY,
                                 @myAttribute,
                                 sizeof(myAttribute))=0;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWndIsDwmEnabled(Handle:THandle):Boolean;
var
  tmp: DWORD;
  begin
  Result := false;
  {$IFNDEF LMDCOMP11}
  if Assigned(DwmGetWindowAttribute) then
  {$ENDIF LMDCOMP11}
  begin
    tmp := 0;
    if DwmGetWindowAttribute(Handle, DWMWA_NCRENDERING_ENABLED, @tmp, sizeof(tmp))=0 then
      begin
        result := tmp <> 0;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDDwmUpdate;
begin
  {$IFNDEF LMDCOMP11}
  if Assigned(DwmIsCompositionEnabled) then
    DwmIsCompositionEnabled(LMDDwmEnabled)
  else
    LMDDwmEnabled := false;
  {$else}
  DwmIsCompositionEnabled(LMDDwmEnabled)
  {$ENDIF LMDCOMP11}
end;

{------------------------------------------------------------------------------}
function LMDDwmExtendFrameIntoClientArea(AHandle: THandle; const AMargins: TMargins): HResult;
begin
  {$IFNDEF LMDCOMP11}
  Result := E_NOTIMPL;
  if Assigned(DwmExtendFrameIntoClientArea) then
  {$ENDIF LMDCOMP11}
    Result := DwmExtendFrameIntoClientArea(AHandle, AMargins);
end;

{$IFNDEF LMDCOMP11}
{------------------------------------------------------------------------------}
procedure Install;
begin
  if DwmInitialized or not LMDSIWindowsVistaUp then
    exit;
  libModule := LoadLibrary (DWMAPI);
  uxLibModule := LoadLibrary('uxtheme.dll');
  if libModule<>0 then
  begin
    @DwmIsCompositionEnabled := GetProcAddress(libModule, 'DwmIsCompositionEnabled');
    @DwmSetWindowAttribute := GetProcAddress(libModule, 'DwmSetWindowAttribute');
    @DwmGetWindowAttribute := GetProcAddress(libModule, 'DwmGetWindowAttribute');
    @DwmExtendFrameIntoClientArea := GetProcAddress(libModule, 'DwmExtendFrameIntoClientArea');
    if uxLibModule <> 0 then
      @DrawThemeTextEx := GetProcAddress(uxLibModule, 'DrawThemeTextEx');
    DwmInitialized := True;
  end;
  LMDDwmUpdate;
end;

{------------------------------------------------------------------------------}
procedure Uninstall;
begin
  if libModule <> 0 then
  begin
    FreeLibrary (libModule);
    libModule := 0;
    FreeLibrary(uxLibModule);
    uxLibModule := 0;
  end;
end;
{$ENDIF LMDCOMP11}

initialization
  {$IFDEF LMDCOMP11}
  LMDDwmEnabled := DwmCompositionEnabled;
  {$ELSE}
  Install;
  {$ENDIF}

finalization
  {$IFNDEF LMDCOMP11}
  Uninstall;
  {$ENDIF}
end.
