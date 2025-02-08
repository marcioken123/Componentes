unit LMDSysDisplayObject;
{$I LMDCmps.inc}

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

LMDSysDisplayObject unit (JH)
-----------------------------
TLMDSysDisplayObject - display information object
TLMDDisplayMode - collection item class, stores values of a possible display setting
TLMDDisplayModes - retrieves all possible display settings and stored them as collection

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  LMDSysObject,
  LMDSysPlusObject,
  LMDSysWallpaperObject,
  LMDSysScreenSaverObject,
  LMDSysPropertyDesc, LMDSysBase;

type
  { ************************************************************************** }
  TLMDSysDisplayMode = class(TLMDSysBaseCollectionItem)
  private
    FWidth,
    FColors,
    FHeight,
    FBitsPerPixel,
    FFrequency: Cardinal;
    FMonochrome,
    FInterlaced: Boolean;
    procedure SetDummyCardinal(aValue: Cardinal);
    procedure SetDummyBool(aValue: Boolean);
  protected
    procedure RegisterProperties; override;
  public
    function Activate: LongInt;
    function Test: LongInt;

    procedure Refresh;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property Width: Cardinal read FWidth write SetDummyCardinal stored false;
    property Height: Cardinal read FHeight write SetDummyCardinal stored false;
    property Frequency: Cardinal read FFrequency write SetDummyCardinal stored false;
    property BitsPerPixel: Cardinal read FBitsPerPixel write SetDummyCardinal stored false;
    property Monochrome: Boolean read FMonochrome write SetDummyBool stored false;
    property Interlaced: Boolean read FInterlaced write SetDummyBool stored false;
    property Colors: Cardinal read FColors write SetDummyCardinal stored false;
  end;

  { ************************************************************************** }
  TLMDSysDisplayModes = class(TLMDSysBaseCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDSysDisplayMode;
    procedure SetItem(Index: Integer; Value: TLMDSysDisplayMode);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDSysDisplayMode;
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDSysDisplayMode read GetItem write SetItem; default;
  end;

  TLMDSysDisplayDisplayInfo=(ddiPlus, ddiScreenSaver, ddiWallPaper, ddiDisplayModes);
  TLMDSysDisplayDisplayInfos=set of TLMDSysDisplayDisplayInfo;

const
  def_TLMDSysDisplayDisplayInfos=[ddiPlus, ddiScreenSaver, ddiWallPaper];

type
  { ************************************************************************** }
  TLMDSysDisplayObject = class(TLMDSysObject, ILMDSysContainer)
  private
    FWidth,
    FHeight,
    FColors,
    FBitsPerPixel,
    FFrequency: Cardinal;
    FMonochrome,
    FInterlaced: Boolean;

    FPlus: TLMDSysPlusObject;
    FScreenSaver: TLMDSysScreenSaverObject;
    FDisplayModes: TLMDSysDisplayModes;
    FWallpaper: TLMDSysWallpaperObject;
    FDisplayInfo: TLMDSysDisplayDisplayInfos;

    //Font smoothing, current res, DisplayModes, ....

    procedure SetDummyPlusInfo(aValue: TLMDSysPlusObject);
    procedure SetDummyScreenSaverInfo(aValue: TLMDSysScreenSaverObject);
    procedure SetDummyDisplayModes(aValue: TLMDSysDisplayModes);
    procedure SetDummyWallpaperObject(aValue: TLMDSysWallpaperObject);
    procedure SetDummyCardinal(aValue: Cardinal);
    procedure SetDummyBool(aValue: Boolean);
    procedure SetDisplayInfo(const Value: TLMDSysDisplayDisplayInfos);
  protected
    procedure RegisterProperties; override;
    procedure InitObject(aOwner: TComponent); virtual;
  public
    constructor Create; overload; override;
    constructor Create(aOwner: TComponent);reintroduce; overload;
    destructor Destroy; override;
    //    procedure GetValues(aText: TStrings); override;

    procedure Refresh; override;
    procedure Apply; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    function GetElementCount : integer;
    function GetElement(index : integer) : TObject;
  published
    // current settings
    property Width: Cardinal read FWidth write SetDummyCardinal stored false;
    property Height: Cardinal read FHeight write SetDummyCardinal stored false;
    property Frequency: Cardinal read FFrequency write SetDummyCardinal stored false;
    property BitsPerPixel: Cardinal read FBitsPerPixel write SetDummyCardinal stored false;
    property Monochrome: Boolean read FMonochrome write SetDummyBool stored false;
    property Interlaced: Boolean read FInterlaced write SetDummyBool stored false;
    property Colors: Cardinal read FColors write SetDummyCardinal stored false;
    // additional objects
    property Plus: TLMDSysPlusObject read FPlus write SetDummyPlusInfo stored false;
    property ScreenSaver: TLMDSysScreenSaverObject read FScreenSaver write SetDummyScreenSaverInfo stored false;
    property DisplayModes: TLMDSysDisplayModes read FDisplayModes write SetDummyDisplayModes stored false;
    property Wallpaper: TLMDSysWallpaperObject read FWallpaper write SetDummyWallpaperObject stored false;
    // DisplayInfo
    property DisplayInfo:TLMDSysDisplayDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysDisplayDisplayInfos;
  end;

implementation
uses
  LMDSysConst, Sysutils;

const
  cpidWidth             = 0;
  cpidHeight            = 1;
  cpidFrequency         = 2;
  cpidBitsPerPixel      = 3;
  cpidMonochrome        = 4;
  cpidInterlaced        = 5;
  cpidColors            = 6;

{ **************************************************************************** }
{ ---------------------------------------------------------------------------- }

procedure TLMDSysDisplayMode.SetDummyCardinal(aValue: Cardinal);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDisplayMode.SetDummyBool(aValue: Boolean);
begin
end;

{ -------------------------- protected --------------------------------------- }
procedure TLMDSysDisplayMode.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidWidth, sLMDSysDisplayModePropTitleWidth, sLMDSysDisplayModePropDescWidth);
  FPropertiesDesc.Add(cpidHeight, sLMDSysDisplayModePropTitleHeight, sLMDSysDisplayModePropDescHeight);
  FPropertiesDesc.Add(cpidFrequency, sLMDSysDisplayModePropTitleFrequency, sLMDSysDisplayModePropDescFrequency);
  FPropertiesDesc.Add(cpidBitsPerPixel, sLMDSysDisplayModePropTitleBitsPerPixel, sLMDSysDisplayModePropDescBitsPerPixel);
  FPropertiesDesc.Add(cpidMonochrome, sLMDSysDisplayModePropTitleMonochrome, sLMDSysDisplayModePropDescMonochrome);
  FPropertiesDesc.Add(cpidInterlaced, sLMDSysDisplayModePropTitleInterlaced, sLMDSysDisplayModePropDescInterlaced);
  FPropertiesDesc.Add(cpidColors, sLMDSysDisplayModePropTitleColors, sLMDSysDisplayModePropDescColors);
end;

{ -------------------------- public ------------------------------------------ }
procedure TLMDSysDisplayMode.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;
  FPropertiesDesc.PropertyByID(cpidWidth).Text := IntToStr(FWidth);
  FPropertiesDesc.PropertyByID(cpidHeight).Text := IntToStr(FHeight);
  FPropertiesDesc.PropertyByID(cpidFrequency).Text := IntToStr(FFrequency);
  FPropertiesDesc.PropertyByID(cpidBitsPerPixel).Text := IntToStr(FBitsPerPixel);
  FPropertiesDesc.PropertyByID(cpidMonochrome).Text := BoolToStr(FMonochrome);
  FPropertiesDesc.PropertyByID(cpidInterlaced).Text := BoolToStr(FInterlaced);
  FPropertiesDesc.PropertyByID(cpidColors).Text := IntToStr(FColors);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayMode.Activate: LongInt;
var
  dev: TDEVMODE;
begin
  EnumDisplaySettings(nil, Index, dev);
  Result:=ChangeDisplaySettings(dev, CDS_UPDATEREGISTRY);
  //DISP_CHANGE_SUCCESFUL
  //DISP_CHANGE_RESTART
  //DISP_CHANGE_BADFLAGS
  //DISP_CHANGE_FAILED
  //DISP_CHANGE_BADMODE
  //DISP_CHANGE_NOTUPDATED
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayMode.Test: LongInt;
var
  dev: TDEVMODE;
begin
  EnumDisplaySettings(nil, Index, dev);
  Result:= ChangeDisplaySettings(dev, CDS_TEST);
  //DISP_CHANGE_SUCCESFUL
  //DISP_CHANGE_RESTART
  //DISP_CHANGE_BADFLAGS
  //DISP_CHANGE_FAILED
  //DISP_CHANGE_BADMODE
  //DISP_CHANGE_NOTUPDATED
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayMode.GetElementTitle : string;
begin
  result := sLMDSysDisplayModeObjectTitle + ' ('+IntToStr(FWidth)+'x'+IntToStr(FHeight)+')';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayMode.GetElementDescription : string;
begin
  result :=  sLMDSysDisplayModeObjectDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayMode.GetElementType : TLMDSysInfoType;
begin
  result := itDisplayMode;
end;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }
function TLMDSysDisplayModes.GetItem(Index: Integer): TLMDSysDisplayMode;
begin
  Result:= TLMDSysDisplayMode(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysDisplayModes.SetItem(Index: Integer; Value: TLMDSysDisplayMode);
begin
  inherited SetItem(Index, Value);
end;

{ -------------------------- protected --------------------------------------- }
function TLMDSysDisplayModes.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ -------------------------- public ------------------------------------------ }
function TLMDSysDisplayModes.Add: TLMDSysDisplayMode;
begin
  Result:= TLMDSysDisplayMode(inherited Add);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDSysDisplayModes.Create(aOwner: TComponent);
begin
  inherited Create(TLMDSysDisplayMode);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysDisplayModes.Destroy;
begin
  FOwner:= nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayModes.Refresh;
var
  i: Integer;
  dev: TDEVMODE;

  function xy(val: Cardinal): Cardinal;
  var
    i: Integer;
  begin
    if val = 32 then val:= 24;
    Result:= 2;
    for i:= val downto 2 do
      Result:= Result * 2;
  end;

begin
  Clear;
DoProgress(sLMDSysDisplayObjectTitle, 100, 0);
  i:= 0;
  while EnumDisplaySettings(nil, i, dev) do
    with Add do
      begin
        FWidth:= dev.dmPelsWidth;
        FHeight:= dev.dmPelsHeight;
        FFrequency:= dev.dmDisplayFrequency;
        FBitsPerPixel:= dev.dmBitsPerPel;
        FMonochrome:= dev.dmDisplayFlags and DM_GRAYSCALE = DM_GRAYSCALE;
        FInterlaced:= dev.dmDisplayFlags and DM_INTERLACED = DM_INTERLACED;
        FColors:= xy(FBitsPerPixel);
        Refresh;
        inc(i);
        DoProgress(sLMDSysDisplayObjectTitle, 100, i mod 100);
      end;
DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayModes.GetElementTitle : string;
begin
  result := sLMDSysDisplayModeObjectTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayModes.GetElementDescription : string;
begin
  result := sLMDSysDisplayModeObjectDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayModes.GetElementType : TLMDSysInfoType;
begin
  result := itDisplayModes;
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDSysDisplayObject.SetDummyPlusInfo(aValue: TLMDSysPlusObject);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayObject.SetDummyScreenSaverInfo(aValue: TLMDSysScreenSaverObject);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayObject.SetDummyDisplayModes(aValue: TLMDSysDisplayModes);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayObject.SetDummyWallpaperObject(aValue: TLMDSysWallpaperObject);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayObject.SetDummyBool(aValue: Boolean);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayObject.SetDummyCardinal(aValue: Cardinal);
begin
end;

{ --------------------------- protected -------------------------------------- }
function TLMDSysDisplayObject.GetElementTitle : string;
begin
  result := sLMDSysDisplayObjectTitle
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayObject.GetElementDescription : string;
begin
  result := sLMDSysDisplayObjectDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayObject.GetElementType : TLMDSysInfoType;
begin
  result := itDisplayGroup;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayObject.GetElementCount : integer;
begin
  result := 4;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysDisplayObject.RegisterProperties;
begin
  FPropertiesDesc.Add(cpidWidth, sLMDSysDisplayModePropTitleWidth, sLMDSysDisplayModePropDescWidth);
  FPropertiesDesc.Add(cpidHeight, sLMDSysDisplayModePropTitleHeight, sLMDSysDisplayModePropDescHeight);
  FPropertiesDesc.Add(cpidFrequency, sLMDSysDisplayModePropTitleFrequency, sLMDSysDisplayModePropDescFrequency);
  FPropertiesDesc.Add(cpidBitsPerPixel, sLMDSysDisplayModePropTitleBitsPerPixel, sLMDSysDisplayModePropDescBitsPerPixel);
  FPropertiesDesc.Add(cpidMonochrome, sLMDSysDisplayModePropTitleMonochrome, sLMDSysDisplayModePropDescMonochrome);
  FPropertiesDesc.Add(cpidInterlaced, sLMDSysDisplayModePropTitleInterlaced, sLMDSysDisplayModePropDescInterlaced);
  FPropertiesDesc.Add(cpidColors, sLMDSysDisplayModePropTitleColors, sLMDSysDisplayModePropDescColors);
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDSysDisplayObject.Create;
begin
  FDisplayInfo := def_TLMDSysDisplayDisplayInfos;
  inherited Create;
  InitObject(nil);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSysDisplayObject.Create(aOwner: TComponent);
begin
  FDisplayInfo := def_TLMDSysDisplayDisplayInfos;
  inherited Create;
  InitObject(aOwner);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayObject.InitObject(aOwner: TComponent);
begin
  FPlus:= TLMDSysPlusObject.Create;
  FPlus.OnChangeLog := DoLog;
  FScreenSaver := TLMDSysScreenSaverObject.Create;
  FScreenSaver.OnChangeLog:= DoLog;
  FDisplayModes := TLMDSysDisplayModes.Create(aOwner);
  FWallpaper := TLMDSysWallpaperObject.Create;
  FWallpaper.OnChangeLog:= DoLog;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysDisplayObject.Destroy;
begin
  FWallpaper.Free;
  FDisplayModes.Free;
  FScreenSaver.Free;
  FPlus.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
//procedure TLMDSysDisplayObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayObject.Refresh;
var
  DevMode: TDevMode;

  function xy(val: Cardinal): Cardinal;
  var
    i: Integer;
  begin
    if val = 32 then val:= 24;
    Result:= 2;
    for i:= val downto 2 do
      Result:= Result * 2;
  end;

begin
  FillChar(DevMode, SizeOf(TDevMode), 0);
  DevMode.dmSize := SizeOf(TDevMode);
  if EnumDisplaySettings(nil, $FFFFFFFF, DevMode) then
  with DevMode do
      begin
        FWidth:= dmPelsWidth;
        FHeight:= dmPelsHeight;
        FFrequency:= dmDisplayFrequency;
        FBitsPerPixel:= dmBitsPerPel;
        FMonochrome:= dmDisplayFlags and DM_GRAYSCALE = DM_GRAYSCALE;
        FInterlaced:= dmDisplayFlags and DM_INTERLACED = DM_INTERLACED;
        FColors:= xy(FBitsPerPixel);
      end;

  FPropertiesDesc.InvalidateProperties;
  FPropertiesDesc.PropertyByID(cpidWidth).Text := IntToStr(FWidth);
  FPropertiesDesc.PropertyByID(cpidHeight).Text := IntToStr(FHeight);
  FPropertiesDesc.PropertyByID(cpidFrequency).Text := IntToStr(FFrequency);
  FPropertiesDesc.PropertyByID(cpidBitsPerPixel).Text := IntToStr(FBitsPerPixel);
  FPropertiesDesc.PropertyByID(cpidMonochrome).Text := BoolToStr(FMonochrome);
  FPropertiesDesc.PropertyByID(cpidInterlaced).Text := BoolToStr(FInterlaced);
  FPropertiesDesc.PropertyByID(cpidColors).Text := IntToStr(FColors);

  if ddiPlus in FDisplayInfo then
    FPlus.Refresh;

  if ddiScreenSaver in FDisplayInfo then
    FScreenSaver.Refresh;

  if ddiWallPaper in FDisplayInfo then
    FWallpaper.Refresh;

  if ddiDisplayModes in FDisplayInfo then
    FDisplayModes.Refresh;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysDisplayObject.Apply;
begin
  FPlus.Apply;
  FScreenSaver.Apply;
  FWallpaper.Apply;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysDisplayObject.GetElement(index : integer) : TObject;
begin
  result := nil;
  case index of
    0 : if ddiPlus in FDisplayInfo then result := TObject(FPlus);
    1 : if ddiScreenSaver in FDisplayInfo then result := TObject(FScreenSaver);
    2 : if ddiWallPaper in FDisplayInfo then result := TObject(FWallpaper);
    3 : if ddiDisplayModes in FDisplayInfo then result := TObject(FDisplayModes);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysDisplayObject.SetDisplayInfo(const Value: TLMDSysDisplayDisplayInfos);
begin
  FDisplayInfo := Value;
end;

end.
