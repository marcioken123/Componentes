unit LMDSysSystemInfo;
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

LMDSysSystemInfo unit (JH)
--------------------------
System information component
TLMDSysSystemInfo - non visible component which contains all system infos extracted

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDSysBase,
  LMDSysBaseComponent,
  LMDSysObject,
  LMDSysPowerStatusObject,
  LMDSysLocaleObject,
  LMDSysTimeZoneObject,
  LMDSysMemoryObject,
  LMDSysMouseObject,
  LMDSysKeyboardObject,
  LMDSysWindowsObject,
  LMDSysDisplayObject,
  LMDSysProcessorObject,
  LMDSysPrinterInfo,
  LMDSysUninstallInfo,
  LMDSysFontInfo,
  LMDSysMultimediaObject,
  LMDSysInternetObject,
  LMDSysFileAssocInfo,
  LMDSysModemInfo,
  LMDSysDriveObject,
  LMDSysNetworkObject,
  LMDSysDriveInfo;

type

    TLMDSysSystemInfoDisplayInfo = (
      doDisplay, doMouse, doDrives, doPrinters,
      doWindows, doKeyboard, doMemoryInfo, doProcessor, doSystemPowerStatus,
      doTimeZone, doLocale, doUninstallInfo, doFontsInfo, doMultimedia, doFileAssoc,
      doInternet, doModems, doNetwork);
    TLMDSysSystemInfoDisplayInfos = set of TLMDSysSystemInfoDisplayInfo;

const
   def_TLMDSysSystemInfoDisplayInfos=[doDisplay, doMouse, doDrives, doPrinters,
      doWindows, doKeyboard, doMemoryInfo, doProcessor, doSystemPowerStatus,
      doTimeZone, doLocale, doUninstallInfo, doFontsInfo, doMultimedia, doFileAssoc,
      doInternet, doModems, doNetwork];
type
  { ************************************************************************** }
  TLMDSysSystemInfo = class(TLMDSysBaseComponent {TComponent})
  private
    FSystemPowerStatus: TLMDSysPowerStatusObject;
    FTimeZone: TLMDSysTimeZoneObject;
    FLocale: TLMDSysLocaleObject;
    FMemoryInfo: TLMDSysMemoryObject;
    FKeyboard: TLMDSysKeyboardObject;
    FMouse: TLMDSysMouseObject;
    FDisplay: TLMDSysDisplayObject;
    FPrinters: TLMDPrintersInfo;
    FWindows: TLMDSysWindowsObject;
//    FDrive: TLMDSysDriveObject;
    FDrives: TLMDSysDrivesInfo;
    FProcessor: TLMDSysProcessorObject;
    FUninstallInfo: TLMDUninstallInfo;
    FFontsInfo: TLMDFontsInfo;
    FMultimedia: TLMDSysMultimediaObject;
    FFileAssoc: TLMDFileAssocsInfo;
    FInternet: TLMDSysInternetObject;
    FModems: TLMDModemInfo;
    FNetwork: TLMDSysNetworkObject;
    FDisplayOptions : TLMDSysSystemInfoDisplayInfos;
    FDisplayInfo: TLMDSysPrinterDisplayInfos;
    FModemDisplayInfo: TLMDSysModemDisplayInfos;
    procedure SetDisplayOptions(const value : TLMDSysSystemInfoDisplayInfos);
    procedure SetDummySPS(aValue: TLMDSysPowerStatusObject);
    procedure SetDummyTimeZone(aValue: TLMDSysTimeZoneObject);
    procedure SetDummyLocale(aValue: TLMDSysLocaleObject);
    procedure SetDummyMemInfo(aValue: TLMDSysMemoryObject);
    procedure SetDummyKeyboardInfo(aValue: TLMDSysKeyboardObject);
    procedure SetDummyMouseInfo(aValue: TLMDSysMouseObject);
    procedure SetDummyDisplayInfo(aValue: TLMDSysDisplayObject);
    procedure SetDummyPrintersInfo(aValue: TLMDPrintersInfo);
    procedure SetDummyWindowsInfo(aValue: TLMDSysWindowsObject);
    procedure SetDummyDrives(aValue: TLMDSysDrivesInfo);
    procedure SetDummyProcessor(const Value: TLMDSysProcessorObject);
    procedure SetDummyUninstallInfo(const Value: TLMDUninstallInfo);
    procedure SetDummyFontsInfo(const Value: TLMDFontsInfo);
    procedure SetDummyMultimedia(const Value: TLMDSysMultimediaObject);
    procedure SetDummyFileAssoc(const Value: TLMDFileAssocsInfo);
    procedure SetDummyInternet(const Value: TLMDSysInternetObject);
    procedure SetDummyModems(const Value: TLMDModemInfo);
    procedure SetDummyNetwork(const Value: TLMDSysNetworkObject);
    procedure SetDisplayInfo(const Value: TLMDSysPrinterDisplayInfos);
    procedure SetModemDisplayInfo(const Value: TLMDSysModemDisplayInfos);
  protected
    procedure RefreshIt; override;
    public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    function GetElementCount : integer; override;
    function GetElement(index : integer) : TObject;  override;
    function GetElementTitle : string;  override;
    function GetElementDescription : string;  override;
    function GetElementType : TLMDSysInfoType;  override;
  published
    property DisplayInfo:TLMDSysSystemInfoDisplayInfos read FDisplayOptions write SetDisplayOptions default def_TLMDSysSystemInfoDisplayInfos;
    property SystemPowerStatus: TLMDSysPowerStatusObject read FSystemPowerStatus write SetDummySPS;
    property TimeZone: TLMDSysTimeZoneObject read FTimeZone write SetDummyTimeZone;
    property LocaleSettings: TLMDSysLocaleObject read FLocale write SetDummyLocale;
    property Memory: TLMDSysMemoryObject read FMemoryInfo write SetDummyMemInfo;
    property Keyboard: TLMDSysKeyboardObject read FKeyboard write SetDummyKeyboardInfo;
    property Mouse: TLMDSysMouseObject read FMouse write SetDummyMouseInfo;
    property Display: TLMDSysDisplayObject read FDisplay write SetDummyDisplayInfo;
    property Printers: TLMDPrintersInfo read FPrinters write SetDummyPrintersInfo stored false;
    property PrintersDisplayInfo:TLMDSysPrinterDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysPrinterDisplayInfos;
    property Windows: TLMDSysWindowsObject read FWindows write SetDummyWindowsInfo;
    property Drives: TLMDSysDrivesInfo read FDrives write SetDummyDrives stored false;
    property Processor: TLMDSysProcessorObject read FProcessor write SetDummyProcessor;
    property UninstallInfo: TLMDUninstallInfo read FUninstallInfo write SetDummyUninstallInfo stored false;
    property FontsInfo: TLMDFontsInfo read FFontsInfo write SetDummyFontsInfo stored false;
    property Multimedia: TLMDSysMultimediaObject read FMultimedia write SetDummyMultimedia stored false;
    property FileAssoc: TLMDFileAssocsInfo read FFileAssoc write SetDummyFileAssoc stored false;
    property Internet: TLMDSysInternetObject read FInternet write SetDummyInternet;
    property Modems: TLMDModemInfo read FModems write SetDummyModems  stored false;
    property ModemsDisplayInfo:TLMDSysModemDisplayInfos read FModemDisplayInfo write SetModemDisplayInfo default def_TLMDSysModemDisplayInfos;
    property Network: TLMDSysNetworkObject read FNetwork write SetDummyNetwork;
  end;

implementation

uses
  Registry, LMDSysConst;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDSysSystemInfo.SetDisplayOptions(const value : TLMDSysSystemInfoDisplayInfos);
begin
  if FDisplayOptions = value then Exit;
  FDisplayOptions := value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysSystemInfo.SetDummySPS(aValue: TLMDSysPowerStatusObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyTimeZone(aValue: TLMDSysTimeZoneObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyLocale(aValue: TLMDSysLocaleObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyMemInfo(aValue: TLMDSysMemoryObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyKeyboardInfo(aValue: TLMDSysKeyboardObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyMouseInfo(aValue: TLMDSysMouseObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyDisplayInfo(aValue: TLMDSysDisplayObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyPrintersInfo(aValue: TLMDPrintersInfo);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyWindowsInfo(aValue: TLMDSysWindowsObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyDrives(aValue: TLMDSysDrivesInfo);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyProcessor(const Value: TLMDSysProcessorObject);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysSystemInfo.SetDummyUninstallInfo(const Value: TLMDUninstallInfo);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysSystemInfo.SetDummyFontsInfo(const Value: TLMDFontsInfo);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysSystemInfo.SetDummyMultimedia(const Value: TLMDSysMultimediaObject);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysSystemInfo.SetDummyFileAssoc(const Value: TLMDFileAssocsInfo);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysSystemInfo.SetDummyInternet(const Value: TLMDSysInternetObject);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysSystemInfo.SetDummyModems(const Value: TLMDModemInfo);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysSystemInfo.SetDummyNetwork(const Value: TLMDSysNetworkObject);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysSystemInfo.SetDisplayInfo(const Value: TLMDSysPrinterDisplayInfos);
begin
  if Value<>FDisplayInfo then
    begin
      FDisplayInfo := Value;
      if not (csDesigning in ComponentState) then
        begin
          FPrinters.UpdateProperties;
          FPrinters.Refresh;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysSystemInfo.SetModemDisplayInfo(const Value: TLMDSysModemDisplayInfos);
begin
  if Value<>FModemDisplayInfo then
    begin
      FModemDisplayInfo := Value;
      if not (csDesigning in ComponentState) then
        begin
          FModems.UpdateProperties;
          FModems.Refresh;
        end;
    end;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysSystemInfo.RefreshIt;
begin

  if doInternet in FDisplayOptions then
    FInternet.Refresh;

  if doDrives in FDisplayOptions then
    FDrives.Refresh;

  if doWindows in FDisplayOptions then
    FWindows.Refresh;

  if doMemoryInfo in FDisplayOptions then
    FMemoryInfo.Refresh;

  if doLocale in FDisplayOptions then
    FLocale.Refresh;

  if doTimeZone in FDisplayOptions then
    FTimeZone.Refresh;

  if doSystemPowerStatus in FDisplayOptions then
    FSystemPowerStatus.Refresh;

  if doMouse in FDisplayOptions then
    FMouse.Refresh;

  if doDisplay in FDisplayOptions then
    FDisplay.Refresh;

  if doProcessor in FDisplayOptions then
    FProcessor.Refresh;

  if doUninstallInfo in FDisplayOptions then
    FUninstallInfo.Refresh;

  if doFontsInfo in FDisplayOptions then
    FFontsInfo.Refresh;

  if doMultimedia in FDisplayOptions then
    FMultimedia.Refresh;

  if doFileAssoc in FDisplayOptions then
    FFileAssoc.Refresh;

  if doNetwork in FDisplayOptions then
    FNetwork.Refresh;

  if doPrinters in FDisplayOptions then
    FPrinters.Refresh;

  if doKeyboard in FDisplayOptions then
    FKeyboard.Refresh;

  if doModems in FDisplayOptions then
    FModems.Refresh;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDSysSystemInfo.Create(aOwner: TComponent);
begin
  FModemDisplayInfo:=def_TLMDSysModemDisplayInfos;
  FDisplayOptions := [doDisplay, doMouse, doDrives, doPrinters,
      doWindows, doKeyboard, doMemoryInfo, doProcessor, doSystemPowerStatus,
      doTimeZone, doLocale, doUninstallInfo, doFontsInfo, doMultimedia, doFileAssoc,
      doInternet, doModems, doNetwork];
  FDisplayInfo:=def_TLMDSysPrinterDisplayInfos;
  inherited Create(aOwner);

  FSystemPowerStatus:= TLMDSysPowerStatusObject.Create;
  FSystemPowerStatus.OnChangeLog:= DoLog;

  FTimeZone:= TLMDSysTimeZoneObject.Create;
  FTimeZone.OnChangeLog:= DoLog;

  FLocale:= TLMDSysLocaleObject.Create;
  FLocale.OnChangeLog:= DoLog;

  FMemoryInfo:= TLMDSysMemoryObject.Create;
  FMemoryInfo.OnChangeLog:= DoLog;

  FKeyboard:= TLMDSysKeyboardObject.Create;
  FKeyboard.OnChangeLog:= DoLog;

  FMouse:= TLMDSysMouseObject.Create;
  FMouse.OnChangeLog:= DoLog;

  FDisplay:= TLMDSysDisplayObject.Create(self);
  FDisplay.OnChangeLog:= DoLog;

  FPrinters:= TLMDPrintersInfo.Create(self);
  FPrinters.OnChangeLog:= DoLog;

  FWindows:= TLMDSysWindowsObject.Create;
  FWindows.OnChangeLog:= DoLog;

//  FDrive:= TLMDSysDriveObject.Create;
//  FDrive.OnChangeLog:= DoLog;

  FDrives:= TLMDSysDrivesInfo.Create(self);
  FDrives.OnChangeLog:= DoLog;

  FProcessor:= TLMDSysProcessorObject.Create;
  FProcessor.OnChangeLog:= DoLog;
  FProcessor.Owner:= Self;

  FUninstallInfo:= TLMDUninstallInfo.Create(self);
  FUninstallInfo.OnChangeLog:= DoLog;

  FFontsInfo:= TLMDFontsInfo.Create(self);
  FFontsInfo.OnChangeLog:= DoLog;

  FMultimedia:= TLMDSysMultimediaObject.Create;
  FMultimedia.OnChangeLog:= DoLog;

  FFileAssoc:= TLMDFileAssocsInfo.Create(self);
  FFileAssoc.OnChangeLog:= DoLog;

  FInternet:= TLMDSysInternetObject.Create;
  FInternet.OnChangeLog:= DoLog;

  FNetwork:= TLMDSysNetworkObject.Create;
  FNetwork.OnChangeLog:= DoLog;

  FModems:= TLMDModemInfo.Create(self);
  FModems.OnChangeLog:= DoLog;

end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysSystemInfo.Destroy;
begin
  FInternet.Free;
//  FDrive.Free;
  FDrives.Free;
  FWindows.Free;
  FPrinters.Free;
  FDisplay.Free;
  FMouse.Free;
  FKeyboard.Free;
  FMemoryInfo.Free;
  FLocale.Free;
  FTimeZone.Free;
  FSystemPowerStatus.Free;
  FProcessor.Free;
  FMultimedia.Free;
  FFileAssoc.Free;
  FNetwork.Free;
  FUninstallInfo.Free;
  FFontsInfo.Free;
  FModems.Free;

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
 procedure TLMDSysSystemInfo.Loaded;
begin
  inherited Loaded;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysSystemInfo.GetElementCount : integer;
var
  Option : TLMDSysSystemInfoDisplayInfo;
begin
  result := 0;
  for Option := Low(TLMDSysSystemInfoDisplayInfo) to High(TLMDSysSystemInfoDisplayInfo) do
    if Option in FDisplayOptions then inc(Result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysSystemInfo.GetElement(index : integer) : TObject;
var
  Option        : TLMDSysSystemInfoDisplayInfo;
  idx           : integer;
begin
  result := nil;
  idx := -1;
  for Option := Low(TLMDSysSystemInfoDisplayInfo) to High(TLMDSysSystemInfoDisplayInfo) do
    begin
      if Option in FDisplayOptions then inc(idx);
      if idx = index then
        begin
          case Option of
            doDisplay : result := TObject(FDisplay);
            doMouse : result := TObject(FMouse);
            doDrives : result := TObject(FDrives);
            doPrinters : result := TObject(FPrinters);
            doWindows : result := TObject(FWindows);
            doKeyboard : result := TObject(FKeyboard);
            doMemoryInfo : result := TObject(FMemoryInfo);
            doProcessor : result := TObject(FProcessor);
            doSystemPowerStatus : result := TObject(FSystemPowerStatus);
            doTimeZone : result := TObject(FTimeZone);
            doLocale : result := TObject(FLocale);
            doUninstallInfo : result := TObject(FUninstallInfo);
            doFontsInfo : result := TObject(FFontsInfo);
            doMultimedia : result := TObject(FMultimedia);
            doFileAssoc : result := TObject(FFileAssoc);
            doInternet : result := TObject(FInternet);
            doModems : result := TObject(FModems);
            doNetwork : result := TObject(FNetwork);
          end;
          Break;
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysSystemInfo.GetElementTitle : string;
begin
  result := cLMDSysInfoTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysSystemInfo.GetElementDescription : string;
begin
  result := cLMDSysInfoDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysSystemInfo.GetElementType : TLMDSysInfoType;
begin
  result := itSystemInfoGroup;
end;

initialization

end.
