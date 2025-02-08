unit LMDThemesEngine;
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

LMDThemesEngine unit (VB)
------------------

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
  Classes, Windows, SysUtils, Graphics,
  UxTheme, Themes,
  LMDThemes, LMDClass,
  LMDTypes, LMDStrings, LMDCustomComponent,
  LMDThemesMain, LMDThemesGeneral;

const
  cSpecialColorArraySize = 30;

type
  TLMDThemeData = TThemeData;
  TLMDThemedElement = TThemedElement;

type
  TLMDThemeEngine = class;

  TLMDThemeEngineController = class (TLMDThemesControllerBase)
  private
    FFTPNotification: boolean;
    FCustomReadOnlyColor: TColor;
    FCustomDisabledColor: TColor;
    FReadOnlyColorMode: TLMDStateColorMode;
    FDisabledColorMode: TLMDStateColorMode;
  private

    function GetCustomReadOnlyColor: TColor;
    procedure SetCustomReadonlyColor(Value: TColor);
    function GetReadOnlyColorMode: TLMDStateColorMode;
    procedure SetReadOnlyColorMode(Value: TLMDStateColorMode);
    function GetDisabledColorMode: TLMDStateColorMode;
    procedure SetDisabledColorMode(Value: TLMDStateColorMode);

    function GetCustomDisabledColor: TColor;
    procedure SetCustomDisabledColor(const Value: TColor);

    function GetThemeEngine: TLMDThemeEngine;
    function GetFTPNotification: boolean;
    procedure SetFTPNotification(const Value: boolean);
  protected
    function GetThemeRenderer: TLMDThemeRenderer; override;
    procedure RegisterController; override;    
    procedure UnregisterController; override;
    procedure SetFormThemeProviderOptions(const Value: TLMDFormThemeProviderOptions); override;
    procedure SetFormThemeProvidersEnabled(const Value: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    property ThemeEngine: TLMDThemeEngine read GetThemeEngine;
  published
    property CustomReadOnlyColor: TColor read GetCustomReadOnlyColor write SetCustomReadOnlyColor;
    property CustomDisabledColor: TColor read GetCustomDisabledColor write SetCustomDisabledColor;
    property ReadOnlyColorMode: TLMDStateColorMode read GetReadOnlyColorMode write SetReadOnlyColorMode;
    property DisabledColorMode: TLMDStateColorMode read GetDisabledColorMode write SetDisabledColorMode;
    property FormThemeProvidersEnabled;
    property FormThemeProviderOptions;
    property FTPNotification: boolean read GetFTPNotification write SetFTPNotification;
  end;

  TLMDThemeEngine = class (TLMDThemeRenderer)
  private
    FThemeData: TLMDThemeData;
    FEnabled: Boolean;

    FCurrentSystemColorScheme: WideString;

    FLastColorScheme: WideString;
    FDontLoadSystemTheme: boolean;
    FFormThemeProviders: TList;

    FCustomReadOnlyColor: TColor;
    FCustomDisabledColor: TColor;
    FDisabledColorMode: TLMDStateColorMode;
    FReadOnlyColorMode: TLMDStateColorMode;

    FFTPNotification: boolean;

    FFormThemeProvidersEnabled: boolean;
    FFormThemeProviderOptions: TLMDFormThemeProviderOptions;


    function UseFTPNotification: boolean;

    function GetCurrentTheme: TThemeManager;
    function GetTheme(Element: TLMDThemedElement): HTHEME;
    procedure SetCustomDisabledColor(const Value: TColor);
    procedure SetCustomReadOnlyColor(const Value: TColor);

  protected
    procedure ApplyThemeChange;
    procedure UnloadThemeData;

    function GetEnabled: boolean; override;
    procedure SetEnabled(Value: boolean); override;

    function GetActiveThemeName: TLMDString; override;
    function GetActiveColorSchemeName: TLMDString; override;

    procedure SetFormThemeProviderOptions(const Value: TLMDFormThemeProviderOptions); override;
    procedure SetFormThemeProvidersEnabled(const Value: boolean); override;
    function GetFormThemeProviderOptions: TLMDFormThemeProviderOptions; override;
    function GetFormThemeProvidersEnabled: boolean; override;
  public
    class function Controller: TLMDThemesControllerBase; override;
    class procedure Init; override;
    class function GetThemeRendererName: TLMDString; override;

    constructor Create; override;
    destructor Destroy; override;

    function ActivateColorScheme(AColorScheme: String = ''; ADoApply: boolean = true): boolean; override;
    function ActivateDefaultTheme(AColorScheme: string = ''; aDoApply: boolean = true): boolean; override;
    function LoadCurrentSystemTheme: boolean;
    function ActivateTheme(AFileName: string; AColorScheme: String = ''): boolean; override;
    procedure DeactivateTheme; override;

    function EnumThemeColorSchemes(ThemeManagerHandle: TThemeManagerHandle; var Schemes: TLMDMemoryStrings): boolean;
    function GetThemeDisplayName(var DisplayName: WideString): boolean;
    function GetThemeColorSchemeDisplayName(SchemeName: WideString; var DisplayName: WideString): boolean;

    function GetCurrentThemeDisplayName(var DisplayName: WideString): boolean;
    function GetCurrentColorScheme(var ColorScheme: WideString): boolean;
    function GetCurrentThemeHandle: TThemeManagerHandle; override;

    //this indicates whether themes are active (not in the application, but in the system)
    function IsSystemThemeEnabled: boolean;

    procedure RegisterFormThemeProvider(Value: TObject); override;
    procedure UnregisterFormThemeProvider(Value: TObject); override;

    function IsCurrentThemeSystem: boolean;
    property CurrentTheme: TThemeManager read GetCurrentTheme;

    property Theme[Element: TLMDThemedElement]: HTHEME read GetTheme;

    //<-- theme renderer interface
    function ContentRect(DC: HDC; Details: TThemedElementDetails; BoundingRect: TRect): TRect; override;

    function GetThemeBackgroundExtent(DC: HDC; Detail: TThemedElement; iPartID, iStateID: integer; ContentRect: TRect; var ExtentRect: TRect): boolean; override;
    function GetThemeColor(Detail: TThemedElement; iPartId, iStateId, iPropId: Integer): COLORREF; overload; override;
    function GetThemeFont(DC: HDC; Detail: TThemedElement; iPartId, iStateId, iPropId:Integer; var font: LOGFONTW): boolean; overload; override;

    function GetThemePartSize(DC: HDC; Detail: TThemedElement; iPartId, iStateId:Integer; var size: TSize): boolean; overload; override;
    function GetThemeSysColor(Detail: TThemedElement; ColorID: integer): ColorRef; override;
    function GetThemeSysSize(Detail: TThemedElement; iSizeId: Integer): Integer; override;
    function GetThemeTextExtent(DC: HDC; Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString; CharCount: Integer; dwTextFlags: DWORD; BoundingRect: TLMDRectPtr; var ExtentRect: TRect): boolean; override;
    procedure DrawElement(DC: HDC; Detail: TThemedButton; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedButton; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedComboBox; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedComboBox; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedEdit; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedEdit; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedExplorerBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedExplorerBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedProgress; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedProgress; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedScrollBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedScrollBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedSpin; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedSpin; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedStatus; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedStatus; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTab; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTab; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolTip; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolTip; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTrackBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTrackBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedWindow; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedWindow; const R: TRect; ClipRect: TLMDRectPtr); overload; override;

    procedure DrawElement(DC: HDC; Detail: TThemedListview; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedListview; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedHeader; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedHeader; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTreeview; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTreeview; const R: TRect; ClipRect: TLMDRectPtr); overload; override;

    procedure DrawElement(DC: HDC; Details: TThemedElementDetails; const R: TRect; ClipRect: TLMDRectPtr = LMDNullRectPtr); overload; override;

    procedure DrawThemeParentBackground(Wnd: HWnd; DC: HDC; ARect: TLMDRectPtr); override;

    function DrawThemeEdge(DC: HDC; Detail: TThemedElement; iPartId, iStateId: Integer; const pDestRect: TRect; uEdge, uFlags: UINT; pContentRect: TLMDRectPtr): boolean; overload; override;
    function DrawThemeText(DC: HDC; Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString; CharCount: Integer; dwTextFlags, dwTextFlags2: DWORD; const pRect: TRect): boolean; override;
    //-->

    property Enabled: boolean read GetEnabled write SetEnabled;
    property CustomReadOnlyColor: TColor read FCustomReadOnlyColor write SetCustomReadOnlyColor;
    property CustomDisabledColor: TColor read FCustomDisabledColor write SetCustomDisabledColor;
    property FTPNotification: boolean read FFTPNotification write FFTPNotification default false;
    property ReadOnlyColorMode: TLMDStateColorMode read FReadOnlyColorMode write FReadOnlyColorMode default scmTheme;
    property DisabledColorMode: TLMDStateColorMode read FDisabledColorMode write FDisabledColorMode default scmTheme;
    property FormThemeProvidersEnabled: boolean read GetFormThemeProvidersEnabled write SetFormThemeProvidersEnabled;
    property FormThemeProviderOptions: TLMDFormThemeProviderOptions read GetFormThemeProviderOptions write SetFormThemeProviderOptions;
  end;

var
  UxThemeLibraryAvailable: Boolean;
  LMDThemeEngine: TLMDThemeEngine;
  LMDThemeEngineController: TLMDThemeEngineController;

procedure RegisterRenderer;

implementation

uses
  Messages,
  Controls,
  Forms,
  TypInfo,
  LMDProcs,
  LMDUtils,
  LMDUnicode,
  LMDSysIn,
  LMDRtlxConst,
  LMDFormThemeProvider;

var
  ThemeDataNamesStr: array[TLMDThemedElement] of WideString;
  ThemeDataNames: array[TLMDThemedElement] of PWideChar;
  ThemedElement: TLMDThemedElement;
  ThemeDataName: WideString;

{------------------------------------------------------------------------------}
procedure RegisterRenderer;
begin
  if LMDThemeEngine = nil then
  begin
    LMDThemeEngine := TLMDThemeEngine.Create;
    LMDThemeServices.RegisterThemeRenderer(LMDThemeEngine);
  end;  
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DeactivateTheme;
begin
  if not Enabled then
    exit;
  if not Application.Terminated then
    begin
      UnloadThemeData;
      Enabled := false;
      ApplyThemeChange;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDThemeEngine.ApplyThemeChange;
var
  i: integer;
begin
  if UseFTPNotification then
    for i := 0 to FFormThemeProviders.Count - 1 do
      TLMDFormThemeProvider(FFormThemeProviders[i]).DoThemeChange
  else
    LMDApplication.DoThemeChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.UnloadThemeData;
var
  Element: TLMDThemedElement;
begin
  for Element := Low(TThemeData) to High(TThemeData) do
    if FThemeData[Element] <> 0 then
    begin
      LMDThemesMain.CloseThemeData(FThemeData[Element]);
      FThemeData[Element] := 0;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetThemeDisplayName(var DisplayName: WideString): boolean;
begin
  Result := LMDThemesMain.GetThemeDisplayName(GetCurrentThemeManagerHandle, DisplayName) = S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetThemeFont(DC: HDC; Detail: TThemedElement; iPartId,
  iStateId, iPropId: Integer; var font: LOGFONTW): Boolean;
begin
  result := LMDThemesMain.GetThemeFont(Theme[Detail], DC, iPartID, iStateId, iPropId, font) = S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetThemePartSize(DC: HDC; Detail: TThemedElement; 
  iPartId, iStateId: Integer; var size: TSize): boolean;
begin
  result := LMDThemesMain.GetThemePartSize(Theme[Detail], DC, iPartID, iStateId, nil, TS_TRUE, size) = S_OK;
end;

{------------------------------------------------------------------------------}
class function TLMDThemeEngine.GetThemeRendererName: TLMDString;
begin
  result := 'LMD Windows XP Themes Renderer';
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetThemeSysColor(Detail: TThemedElement; ColorID: integer): ColorRef;
var
  c: ColorRef;
begin
  c := clNone;
  result := c;
  if Succeeded(LMDThemesMain.GetThemeSysColor(Theme[Detail], c)) then
     result := c;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetThemeSysSize(Detail: TThemedElement; iSizeId: Integer): Integer;
begin
  result := LMDThemesMain.GetThemeSysSize(Theme[Detail], iSizeID);
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetThemeTextExtent(DC: HDC; Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString; CharCount: Integer; dwTextFlags: DWORD; BoundingRect: TLMDRectPtr; var ExtentRect: TRect): boolean;
begin
  result := LMDThemesMain.GetThemeTextExtent(Theme[Detail], DC, iPartId, iStateId, PLMDChar(Text), CharCount, dwTextFlags, BoundingRect, ExtentRect) = S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.EnumThemeColorSchemes(ThemeManagerHandle: TThemeManagerHandle;
  var Schemes: TLMDMemoryStrings): boolean;
begin
  Result := LMDThemesMain.EnumThemeColorSchemes(ThemeManagerHandle, Schemes) = S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetTheme(Element: TLMDThemedElement): HTHEME;
begin
  if (FThemeData[Element] = 0) then
    FThemeData[Element] := LMDThemesMain.OpenThemeData(0, ThemeDataNames[Element]);
  Result := FThemeData[Element];
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetThemeColor(Detail: TThemedElement; iPartId,
  iStateId, iPropId: Integer): COLORREF;
var
  c: COLORREF;
begin
  if LMDThemesMain.GetThemeColor(Theme[Detail], iPartID, iStateID, iPropID, c) = S_OK then
    result := c
  else
    result := clNone;
  if (Detail = teComboBox) and (iPropID = TMT_FILLCOLOR) and (iStateID = CBXS_DISABLED)
    and (DisabledColorMode = scmCustom) then
    result := CustomDisabledColor;
end;

function TLMDThemeEngine.GetThemeColorSchemeDisplayName(SchemeName: WideString; var DisplayName: WideString): boolean;
begin
  Result := LMDThemesMain.GetThemeColorSchemeDisplayName(SchemeName, DisplayName) = S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetCurrentThemeDisplayName(var DisplayName: WideString): boolean;
begin
  Result := LMDThemesMain.GetThemeDisplayName(GetCurrentThemeManagerHandle, DisplayName) = S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetCurrentColorScheme(var ColorScheme: WideString): boolean;
var
  CS: WideString;
  begin
  SetLength(CS, 100);
  if UxThemeLibraryAvailable and Succeeded(GetCurrentThemeName(nil, 0, PWideChar(CS), 100, nil, 0)) then
  begin
      ColorScheme := LMDGetFirstString(CS, #0);
      Result := true;
    end
  else
    begin
      SetLength(ColorScheme, 0);
      Result := false;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetCurrentThemeHandle: TThemeManagerHandle;
begin
  Result := LMDThemesMain.GetCurrentThemeManagerHandle;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.LoadCurrentSystemTheme: boolean;
var
  FileName: WideString;
begin
  result := false;
  SetLength(FCurrentSystemColorScheme, 100);
  SetLength(FileName, 1024);
  if Succeeded(uxTheme.GetCurrentThemeName(PWideChar(FileName), 1024,
    PWideChar(FCurrentSystemColorScheme), 100, nil, 0)) then
    begin
      SetLength(FileName, LMDWideStrLen(PWideChar(FileName)));
      SetLength(FCurrentSystemColorScheme, LMDWideStrLen(PWideChar(FCurrentSystemColorScheme)));
      result := LoadTheme(FileName) <> 0;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetCurrentTheme: TThemeManager;
begin
  result := LMDThemesMain.GetCurrentThemeManager;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.ActivateColorScheme(AColorScheme: String = ''; ADoApply: boolean = true): boolean;
begin
  Result := false;
  UnloadThemeData;
  if (GetCurrentThemeManagerHandle = 0) then
    exit;
  Result := LMDThemesMain.ActivateTheme(AColorScheme) = S_OK;
  if Result then
    begin
      FEnabled := true;
      ApplyThemeChange;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.ActivateDefaultTheme(AColorScheme: string;
  aDoApply: boolean): boolean;
begin
  if LMDSIWindowsXPUp and not LMDSIWindowsVistaUp then
    begin
      ActivateTheme('C:\WINDOWS\Resources\Themes\Luna\luna.msstyles');
      //Enabled := true;
    end;
  result := Enabled;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.ActivateTheme(AFileName: string; AColorScheme: String): boolean;
var
  ManagerHandle: TThemeManagerHandle;
begin
  Result := false;
  if GetCurrentThemeManager <> nil then
    DeactivateTheme;
  ManagerHandle := LoadTheme(AFileName);
  if ManagerHandle <> 0 then
    Result := ActivateColorScheme(AColorScheme);
end;

{------------------------------------------------------------------------------}
constructor TLMDThemeEngine.Create;
begin
  if LMDThemeEngine <> nil then
    raise Exception.Create(SLMDThemesOneInst);

  inherited;

  FEnabled := false;

  FFormThemeProviders := TList.Create;
  FCurrentSystemColorScheme := '';
  FTPNotification := false;

  ReadOnlyColorMode := scmTheme;
  DisabledColorMode := scmTheme;

  FDontLoadSystemTheme := False;

end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.ContentRect(DC: HDC; Details: TThemedElementDetails;
  BoundingRect: TRect): TRect;
begin
  with Details do
    LMDThemesMain.GetThemeBackgroundContentRect(Theme[Element], DC, Part, State, BoundingRect, Result);
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetThemeBackgroundExtent(DC: HDC; Detail: TThemedElement;
  iPartID, iStateID: integer; ContentRect: TRect; var ExtentRect: TRect): boolean;
begin
  result := LMDThemesMain.GetThemeBackgroundExtent(Theme[Detail], DC, iPartId, iStateId, ContentRect, ExtentRect) = S_OK;
end;

{------------------------------------------------------------------------------}
destructor TLMDThemeEngine.Destroy;
begin
  FFormThemeProviders.Clear;
  FFormThemeProviders.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedScrollBar;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedProgress;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedProgress;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedScrollBar;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedStatus;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedSpin;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedSpin;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedExplorerBar;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedComboBox;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedButton;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedButton;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedComboBox;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedExplorerBar;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedEdit;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedEdit;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedTrackBar;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedTrackBar;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedToolTip;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Details: TThemedElementDetails;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with Details do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedHeader;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedListview;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedListview;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedHeader;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedTreeview;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedTreeview;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.DrawThemeEdge(DC: HDC; Detail: TThemedElement;
  iPartId, iStateId: Integer; const pDestRect: TRect; uEdge, uFlags: UINT;
  pContentRect: TLMDRectPtr): boolean;

begin

  result := LMDThemesMain.DrawThemeEdge(Theme[Detail], DC, iPartID, iStateId, pDestRect, uEdge, uFlags, pContentRect) = S_OK;

end;

procedure TLMDThemeEngine.DrawThemeParentBackground(Wnd: HWnd; DC: HDC; ARect: TLMDRectPtr);
begin
  LMDThemesMain.DrawThemeParentBackground(Wnd, DC, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.DrawThemeText(DC: HDC; Detail: TThemedElement; iPartId, iStateId: Integer; Text: TLMDString; CharCount: Integer; dwTextFlags, dwTextFlags2: DWORD; const pRect: TRect): boolean;
begin
  result := LMDThemesMain.DrawThemeText(Theme[Detail], DC, iPartId, iStateId, PLMDChar(Text), CharCount, dwTextFlags, dwTextFlags2, pRect) = S_OK;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedWindow;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedWindow;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedTab;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedTab;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedStatus;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedToolTip;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedToolBar;
  const R: TRect; ClipRect: TLMDRectPtr);
begin
  with ThemeServices.GetElementDetails(Detail) do
    LMDThemesMain.DrawThemeBackground(Theme[Element], DC, Part, State, R, ClipRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.DrawElement(DC: HDC; Detail: TThemedToolBar;
  const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;


{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.SetFormThemeProviderOptions(
  const Value: TLMDFormThemeProviderOptions);
var
  i: integer;
begin
  if Value <> FFormThemeProviderOptions then
    begin
      FFormThemeProviderOptions := Value;
      for i := 0 to FFormThemeProviders.Count - 1 do
        TLMDFormThemeProvider(FFormThemeProviders[i]).ReInit;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.SetFormThemeProvidersEnabled(const Value: boolean);
var
  i: integer;
begin
  if Value <> FFormThemeProvidersEnabled then
    begin
      FFormThemeProvidersEnabled := Value;
      for i := 0 to FFormThemeProviders.Count - 1 do
        TLMDFormThemeProvider(FFormThemeProviders[i]).ReInit;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.RegisterFormThemeProvider(Value: TObject);
begin
  FFormThemeProviders.Add(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.UnregisterFormThemeProvider(Value: TObject);
var
  i: integer;
begin
  i := FFormThemeProviders.IndexOf(Value);
  if (i >= 0) and (i < FFormThemeProviders.Count) then
    FFormThemeProviders.Delete(i);
  FFormThemeProviders.Capacity := FFormThemeProviders.Count;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetEnabled: boolean;
begin
  result := FEnabled;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.SetEnabled(Value: boolean);
begin
  if FEnabled <> Value then
    begin
      if not Value then
        begin
          if CurrentTheme <> nil then
            begin
              GetCurrentColorScheme(FLastColorScheme);
              SetLength(FLastColorScheme, LMDWideStrLen(PWideChar(FLastColorScheme)));
              LMDThemesMain.DeactivateTheme;
            end;
        end;
      FEnabled := Value;
      if FEnabled then
        begin
          if not FDontLoadSystemTheme then
            begin
              try
                LoadCurrentSystemTheme;
              except
              end;
              if not ActivateColorScheme(FCurrentSystemColorScheme) then
                begin
                  FEnabled := false;
                  FDontLoadSystemTheme := true;
                end;
            end
          else
            if not ActivateColorScheme(FLastColorScheme) then
              if not ActivateColorScheme('') then
                begin
                  FEnabled := false;
                end
        end
      else
        ApplyThemeChange;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.IsSystemThemeEnabled: boolean;
begin
  if UxThemeLibraryAvailable then
    Result := uxTheme.IsThemeActive
  else
    Result := false;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.IsCurrentThemeSystem: boolean;
var
  LCurrentSystemColorScheme, LFileName, LCCScheme: WideString;
begin
  result := false;
  if Enabled = false then
    begin
      result := true;
      exit;
    end;
  if GetCurrentThemeManagerHandle = 0 then
    exit;
  SetLength(LCurrentSystemColorScheme, 100);
  SetLength(LFileName, 1024);
  if Succeeded(UxTheme.GetCurrentThemeName(PWideChar(LFileName), 1024,
    PWideChar(LCurrentSystemColorScheme), 100, nil, 0)) then
    begin
      SetLength(LFileName, LMDWideStrLen(PWideChar(LFileName)));
      SetLength(LCurrentSystemColorScheme, LMDWideStrLen(PWideChar(FCurrentSystemColorScheme)));
    end;
  if LFileName <> GetCurrentTheme.FileName then
     exit;

  if GetCurrentColorScheme(LCCScheme) then
    if LCCScheme <> LCurrentSystemColorScheme then
      exit;

  result := true;
end;

{------------------- TLMDThemeEngineController --------------------------------}
function TLMDThemeEngineController.GetCustomDisabledColor: TColor;
begin
  Result := FCustomDisabledColor;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.UseFTPNotification: boolean;
begin
  result := FormThemeProvidersEnabled and FTPNotification;
   //or ((FController <> nil) and (csDesigning in (FController.ComponentState)));
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngineController.GetCustomReadOnlyColor: TColor;
begin
  Result := FCustomReadOnlyColor;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngineController.GetDisabledColorMode: TLMDStateColorMode;
begin
  Result := FDisabledColorMode;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngineController.GetReadOnlyColorMode: TLMDStateColorMode;
begin
  Result := FReadOnlyColorMode;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.SetCustomDisabledColor(
  const Value: TColor);
begin
  FCustomDisabledColor := Value;
  if Assigned(LMDThemeEngine) then
    LMDThemeEngine.CustomDisabledColor := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.SetCustomReadonlyColor(Value: TColor);
begin
  FCustomReadOnlyColor := Value;
  if Assigned(LMDThemeEngine) then
    LMDThemeEngine.CustomReadOnlyColor := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.SetDisabledColorMode(
  Value: TLMDStateColorMode);
begin
  FDisabledColorMode := Value;
  if Assigned(LMDThemeEngine) then
    LMDThemeEngine.DisabledColorMode := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.SetReadOnlyColorMode(
  Value: TLMDStateColorMode);
begin
  FReadOnlyColorMode := Value;
  if Assigned(LMDThemeEngine) then
    LMDThemeEngine.ReadOnlyColorMode := Value;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngineController.GetThemeEngine: TLMDThemeEngine;
begin
  result := LMDThemeEngine;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngineController.GetFTPNotification: boolean;
begin
  result := FFTPNotification;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.SetFTPNotification(
  const Value: boolean);
begin
  FFTPNotification := Value;
end;

function TLMDThemeEngineController.GetThemeRenderer: TLMDThemeRenderer;
begin
  result := LMDThemeEngine;
end;


{------------------------------------------------------------------------------}
constructor TLMDThemeEngineController.Create(AOwner: TComponent);
begin
  if Assigned(LMDThemeEngineController) then
    raise Exception.Create('An instance of ' + ClassName + ' already exists (owner: ' + LMDThemeEngineController.Owner.Name +')');
  inherited;
  if not Assigned(LMDThemeEngine) and not (csDesigning in ComponentState) then
    TLMDThemeEngine.Init;
end;


{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.SetCustomDisabledColor(const Value: TColor);
begin
  FCustomDisabledColor := Value;
  ApplyThemeChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngine.SetCustomReadOnlyColor(const Value: TColor);
begin
  FCustomReadOnlyColor := Value;
  ApplyThemeChange;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetActiveColorSchemeName: TLMDString;
var
  s: WideString;
begin
  if GetCurrentColorScheme(s) then
    result := TLMDString(s)
  else
    result := '';
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetActiveThemeName: TLMDString;
var
  s: WideString;
begin
  if GetThemeDisplayName(s) then
    result := TLMDString(s)
  else
    result := '';
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetFormThemeProviderOptions: TLMDFormThemeProviderOptions;
begin
  result :=  FFormThemeProviderOptions;
end;

{------------------------------------------------------------------------------}
function TLMDThemeEngine.GetFormThemeProvidersEnabled: boolean;
begin
  result :=  FFormThemeProvidersEnabled;
end;

{------------------------------------------------------------------------------}
class procedure TLMDThemeEngine.Init;
begin
  RegisterRenderer;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.SetFormThemeProviderOptions(
  const Value: TLMDFormThemeProviderOptions);
begin
  inherited;
  if Assigned(LMDThemeEngine) then
    LMDThemeEngine.FormThemeProviderOptions := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.SetFormThemeProvidersEnabled(
  const Value: boolean);
begin
  inherited;
  if Assigned(LMDThemeEngine) then
    LMDThemeEngine.FormThemeProvidersEnabled := Value;
end;

{------------------------------------------------------------------------------}
class function TLMDThemeEngine.Controller: TLMDThemesControllerBase;
begin
  result := LMDThemeEngineController;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.RegisterController;
begin
  LMDThemeEngineController := Self;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemeEngineController.UnregisterController;
begin
  LMDThemeEngineController := nil;
end;

initialization

  for ThemedElement := Low(TLMDThemedElement) to High(TLMDThemedElement) do
  begin
    ThemeDataName := WideString(getEnumName(typeInfo(TLMDThemedElement), ord(ThemedElement)));
    Delete(ThemeDataName, 1, 2);
    ThemeDataName := UpperCase(ThemeDataName);
    ThemeDataNamesStr[ThemedElement] := ThemeDataName;
    ThemeDataNames[ThemedElement] := PWideChar(ThemeDataNamesStr[ThemedElement]);
  end;

  UxThemeLibraryAvailable:= InitThemeLibrary;
  LMDThemeEngineController := nil;
  LMDThemeEngine := nil;


finalization

  if LMDThemeEngine <> nil then
    FreeAndNil(LMDThemeEngine);

end.
