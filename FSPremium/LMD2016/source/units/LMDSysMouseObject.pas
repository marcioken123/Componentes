unit LMDSysMouseObject;
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

LMDSysMouseObject unit (JH, AH)
-------------------------------
Current mouse settings

ToDo
----
The WMI support (which provides far more properties) was deferred for now
to provide full compatibility with Win9X.

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  LMDSysBase,
  LMDSysObject,
  LMDSysConst;

type
  // WMI left out for SysPack 2 for sale of compatbility reasons
  {TLMDSysMouseDisplayInfo=(mpidName, mpidManufacturer, mpidHardwareType, mpidButtons, mpidSwapButtons,
                           mpidHasWheel, mpidSpeed, mpidResolution, mpidDoubleClickTime,
                           mpidDoubleClickWidth, mpidDoubleClickHeight, mpidExist, mpidSnapToDefault,
                           mpidCursorScheme, mpidCursorSchemes, mpidAvailability, mpidDeviceID,
                           mpidDoubleSpeedThreshold, mpidQuadSpeedThreshold, mpidPowerManagementSupported,
                           mpidSampleRate, mpidStatus, mpidStatusInfo, mpidSynch);
  TLMDSysMouseDisplayInfos=set of TLMDSysMouseDisplayInfo;}

  TLMDSysMouseDisplayInfo=(mpidButtons, mpidSwapButtons, mpidHasWheel, mpidSpeed, mpidDoubleClickTime,
                           mpidDoubleClickWidth, mpidDoubleClickHeight, mpidExist, mpidSnapToDefault,
                           mpidCursorScheme, mpidCursorSchemes);
  TLMDSysMouseDisplayInfos=set of TLMDSysMouseDisplayInfo;

const
  def_TLMDSysMouseDisplayInfos=[mpidButtons, mpidSwapButtons, mpidHasWheel, mpidSpeed, mpidDoubleClickTime,
                                mpidDoubleClickWidth, mpidDoubleClickHeight, mpidExist, mpidSnapToDefault,
                                mpidCursorScheme, mpidCursorSchemes];

  LMDSysMouseProps:array[TLMDSysMouseDisplayInfo] of TLMDSysProperty =(
    //(Name: sLMDSysMousePropTitleName; Description: sLMDSysMousePropDescName),
    //(Name: sLMDSysMousePropTitleManufacturer; Description: sLMDSysMousePropDescManufacturer),
    //(Name: sLMDSysMousePropTitleHardwareType; Description: sLMDSysMousePropDescHardwareType),
    (Name: sLMDSysMousePropTitleButtons; Description: sLMDSysMousePropDescButtons),
    (Name: sLMDSysMousePropTitleSwapButtons; Description: sLMDSysMousePropDescSwapButtons),
    (Name: sLMDSysMousePropTitleHasWheel; Description: sLMDSysMousePropDescHasWheel),
    (Name: sLMDSysMousePropTitleSpeed; Description: sLMDSysMousePropDescSpeed),
    //(Name: sLMDSysMousePropTitleResolution; Description: sLMDSysMousePropDescResolution),
    (Name: sLMDSysMousePropTitleDoubleClickTime; Description: sLMDSysMousePropDescDoubleClickTime),
    (Name: sLMDSysMousePropTitleDoubleClickWidth; Description: sLMDSysMousePropDescDoubleClickWidth),
    (Name: sLMDSysMousePropTitleDoubleClickHeight; Description: sLMDSysMousePropDescDoubleClickHeight),
    (Name: sLMDSysMousePropTitleExist; Description: sLMDSysMousePropDescExist),
    (Name: sLMDSysMousePropTitleSnapToDefault; Description: sLMDSysMousePropDescSnapToDefault),
    (Name: sLMDSysMousePropTitleCursorScheme; Description: sLMDSysMousePropDescCursorScheme),
    (Name: sLMDSysMousePropTitleCursorSchemes; Description: sLMDSysMousePropDescCursorSchemes)
    //(Name: sLMDSysMousePropTitleAvailability; Description: sLMDSysMousePropDescAvailability),
    //(Name: sLMDSysMousePropTitleDeviceID; Description: sLMDSysMousePropDescDeviceID),
    //(Name: sLMDSysMousePropTitleDoubleSpeedThreshold; Description: sLMDSysMousePropDescDoubleSpeedThreshold),
    //(Name: sLMDSysMousePropTitleQuadSpeedThreshold; Description: sLMDSysMousePropDescQuadSpeedThreshold),
    //(Name: sLMDSysMousePropTitlePowerManagementSupported; Description: sLMDSysMousePropDescPowerManagementSupported),
    //(Name: sLMDSysMousePropTitleSampleRate; Description: sLMDSysMousePropDescSampleRate),
    //(Name: sLMDSysMousePropTitleStatus; Description: sLMDSysMousePropDescStatus),
    //(Name: sLMDSysMousePropTitleStatusInfo; Description: sLMDSysMousePropTitleStatusInfo),
    //(Name: sLMDSysMousePropTitleSynch; Description: sLMDSysMousePropDescSynch)
    );

type
  { ************************************************************************** }
  TLMDSysMouseObject = class(TLMDSysObject)
  private
    FBtns,
      FDoubleClickTime: Word;
    FSnapToDefault,
      FSwapBtns,
      FExist,
      FWheel: Boolean;
    FSpeed,
      FDblClickWidth,
      FDblClickHeight: Integer;
    FCurSchemeFiles,
      FCursorSchemes: TStrings;
    FCursorScheme: string;

    {FAvailability                       : TLMDSysAvailability;
    FConfigManagerErrorCode             : integer;
    FConfigManagerUserConfig            : boolean;
    FDeviceID                           : string;
    FDoubleSpeedThreshold               : cardinal;
    FErrorCleared                       : boolean;
    FErrorDescription                   : string;
    FHardwareType                       : string;
    FInfFileName                        : string;
    FInfSection                         : string;
    FInstallDate                        : TDateTime;
    FIsLocked                           : boolean;
    FLastErrorCode                      : cardinal;
    FManufacturer                       : string;
    FName                               : string;
    //FNumberOfButtons                    : byte;
    FPowerManagementCapabilities        : TLMDSysPowerManagementCapabilities;
    FPowerManagementSupported           : boolean;
    FQuadSpeedThreshold                 : cardinal;
    FResolution                         : cardinal;
    FSampleRate                         : cardinal;
    FStatus                             : string;
    FStatusInfo                         : TLMDSysStatusInfo;
    FSynch                              : cardinal;}
    FDisplayInfo:TLMDSysMouseDisplayInfos;
    procedure SetBool(index: Integer; aValue: Boolean);
    procedure SetDisplayInfo(const Value: TLMDSysMouseDisplayInfos);
    procedure SetWord(index: Integer; aValue: Word);
    procedure SetInteger(index: Integer; aValue: Integer);
    procedure SetDummyStrings(aValue: TStrings);
    procedure SetDummyString(aValue: string);
    function GetBool(index: Integer): Boolean;
    function GetWord(index: Integer): Word;
    function GetInteger(index: Integer): Integer;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    //    procedure GetValues(aText: TStrings); override;
    procedure Refresh; override;
    procedure Apply; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    {property Availability : TLMDSysAvailability read FAvailability;
    property ConfigManagerErrorCode : integer read FConfigManagerErrorCode;
    property ConfigManagerUserConfig : boolean read FConfigManagerUserConfig;
    property DeviceID : string read FDeviceID;
    property DoubleSpeedThreshold : cardinal read FDoubleSpeedThreshold;
    property ErrorCleared : boolean read FErrorCleared;
    property ErrorDescription : string read FErrorDescription;
    property HardwareType : string read FHardwareType;
    property InfFileName : string read FInfFileName;
    property InfSection : string read FInfSection;
    property InstallDate : TDateTime read FInstallDate;
    property IsLocked : boolean read FIsLocked;
    property LastErrorCode : cardinal read FLastErrorCode;
    property Manufacturer : string read FManufacturer;
    property Name : string read FName;
    property PowerManagementCapabilities : TLMDSysPowerManagementCapabilities read FPowerManagementCapabilities;
    property PowerManagementSupported : boolean read FPowerManagementSupported;
    property QuadSpeedThreshold : cardinal read FQuadSpeedThreshold;
    property Resolution : cardinal read FResolution;
    property SampleRate : cardinal read FSampleRate;
    property Status : string read FStatus;
    property StatusInfo : TLMDSysStatusInfo read FStatusInfo;
    property Synch : cardinal read FSynch;}

  published
    property DoubleClickTime: Word index 0 read GetWord write SetWord stored false;
    property DoubleClickWidth: Integer index 0 read GetInteger write SetInteger stored false;
    property DoubleClickHeight: Integer index 1 read GetInteger write SetInteger stored false;
    property Speed: Integer index 2 read GetInteger write SetInteger stored false;
    property Buttons: Word index 1 read GetWord write SetWord stored false;
    property SwapButtons: Boolean index 0 read GetBool write SetBool stored false;
    property Exist: Boolean index 1 read GetBool write SetBool stored false;
    property HasWheel: Boolean index 2 read GetBool write SetBool stored false;
    property SnapToDefault: Boolean index 3 read GetBool write SetBool stored false;
    property CursorScheme: string read FCursorScheme write SetDummyString stored false;
    property CursorSchemes: TStrings read FCursorSchemes write SetDummyStrings stored false;

    property DisplayInfo:TLMDSysMouseDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysMouseDisplayInfos;
  end;

implementation

uses
  SysUtils,
  LMDSysLogStrings{, LMDSysWMI};

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }

procedure TLMDSysMouseObject.SetBool(index: Integer; aValue: Boolean);
begin
  case index of
    0:
      if FSwapBtns <> aValue then
        begin
          RememberChange(strDoubleClickTime, BoolToStr(FSwapBtns), BoolToStr(aValue));
          FSwapBtns:= aValue;
        end;
    3:
      if FSnapToDefault <> aValue then
        begin
          RememberChange(strDoubleClickTime, BoolToStr(FSnapToDefault), BoolToStr(aValue));
          FSnapToDefault:= aValue;
        end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMouseObject.SetDisplayInfo(const Value: TLMDSysMouseDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      RegisterProperties;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysMouseObject.SetWord(index: Integer; aValue: Word);
begin
  case index of
    0:
      if FDoubleClickTime <> aValue then
        begin
          RememberChange(strDoubleClickTime, IntToStr(FDoubleClickTime), IntToStr(aValue));
          FDoubleClickTime:= aValue;
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysMouseObject.SetDummyStrings(aValue: TStrings);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysMouseObject.SetDummyString(aValue: string);
begin
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysMouseObject.SetInteger(index, aValue: Integer);
begin
  case index of
    0:
      if FDblClickWidth <> aValue then
        begin
          RememberChange(strDoubleClickWidth, IntToStr(FDblClickWidth), IntToStr(aValue));
          FDblClickWidth:= aValue;
        end;
    1:
      if FDblClickHeight <> aValue then
        begin
          RememberChange(strDoubleClickHeight, IntToStr(FDblClickHeight), IntToStr(aValue));
          FDblClickHeight:= aValue;
        end;
    2:
      if FSpeed <> aValue then
        begin
          RememberChange(strMouseSpeed, IntToStr(FSpeed), IntToStr(aValue));
          FSpeed:= aValue;
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSysMouseObject.GetBool(index: Integer): Boolean;
begin
  if FInstantUpdate then
    Refresh;
  Result:= false;
  case index of
    0: Result:= FSwapBtns;
    1: Result:= FExist;
    2: Result:= FWheel;
    3: Result:= FSnapToDefault;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSysMouseObject.GetWord(index: Integer): Word;
begin
  if FInstantUpdate then
    Refresh;
  Result:= 0;
  case index of
    0: Result:= FDoubleClickTime;
    1: Result:= FBtns;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDSysMouseObject.GetInteger(index: Integer): Integer;
begin
  if FInstantUpdate then
    Refresh;
  Result:= 0;
  case index of
    0: Result:= FDblClickWidth;
    1: Result:= FDblClickHeight;
    2: Result:= FSpeed;
  end;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysMouseObject.RegisterProperties;
var
  i:TLMDSysMouseDisplayInfo;
begin
  FPropertiesDesc.Clear;
  for i:=Low(TLMDSysMouseDisplayInfo) to High(TLMDSysMouseDisplayInfo) do
    if i in FDisplayInfo then
      FPropertiesDesc.Add(Ord(i), LMDSysMouseProps[i].Name, LMDSysMouseProps[i].Description);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDSysMouseObject.Create;
{var
  WMIObjectSet   : TLMDSysWMIObjectSet;}
begin
  FDisplayInfo:= def_TLMDSysMouseDisplayInfos;
  inherited Create;

  FCursorSchemes:= TStringList.Create;
  FCurSchemeFiles:= TStringList.Create;

  //WMIObjectSet := nil;
  {WMIObjectSet := TLMDSysWMIObjectSet.Create('Win32_PointingDevice');
  if assigned(WMIObjectSet) then
    begin
      BindWMIObject(WMIObjectSet[0]);
      WMIObjectSet.Free;
    end;}
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDSysMouseObject.Destroy;
begin
  FCurSchemeFiles.Free;
  FCursorSchemes.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

//procedure TLMDSysMouseObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysMouseObject.Refresh;
var
  i: Integer;
  tmpStr : string;
  j:TLMDSysMouseDisplayInfo;
  begin
  FPropertiesDesc.InvalidateProperties;

  DoProgress(sLMDSysMouseObjectTitle, 100, 0);

  SystemParametersInfo(SPI_GETSNAPTODEFBUTTON, 0, @FSnapToDefault, 0);
  FCursorSchemes.Clear;
  FCurSchemeFiles.Clear;
  FExist:= Boolean(GetSystemMetrics(SM_MOUSEPRESENT));

  FBtns:= GetSystemMetrics(SM_CMOUSEBUTTONS);
  FWheel:= Boolean(GetSystemMetrics(SM_MOUSEWHEELPRESENT));
  FSwapBtns:= Boolean(GetSystemMetrics(SM_SWAPBUTTON));
  FDoubleClickTime:= GetDoubleClickTime;
  DoProgress(sLMDSysMouseObjectTitle, 100, 20);

  SystemParametersInfo(SPI_GETMOUSESPEED, 0, @FSpeed, 0);
  FDblClickWidth:= GetSystemMetrics(SM_CXDOUBLECLK);
  FDblClickHeight:= GetSystemMetrics(SM_CYDOUBLECLK);
  DoProgress(sLMDSysMouseObjectTitle, 100, 40);

  OpenRegistry(true);

  SetRegistryRootKey(HKEY_LOCAL_MACHINE);
  if OpenRegistrySubKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes') then
    begin
      Registry.GetValueNames(FCursorSchemes);
      tmpStr := '';
      for i:= 0 to FCursorSchemes.Count - 1 do
        begin
          FCurSchemeFiles.Add(Registry.ReadString(FCursorSchemes[i]));
          tmpStr := tmpStr + '; ' + FCurSchemeFiles[i];
        end;
        //FPropertiesDesc.PropertyByID(cpidCursorSchemes).Text := tmpStr;
      CloseRegistrySubKey;
    end;

  DoProgress(sLMDSysMouseObjectTitle, 100, 50);

  SetRegistryRootKey(HKEY_CURRENT_USER);
  if OpenRegistrySubKey('\Control Panel\Cursors') then
    begin
      FCursorScheme:= Registry.ReadString('');
       // FPropertiesDesc.PropertyByID(cpidCursorScheme).Text := FCursorScheme;
      CloseRegistrySubKey;
    end;
DoProgress(sLMDSysMouseObjectTitle, 100, 60);

 { if WMIObject.Ready then
    begin

      FAvailability := TLMDSysAvailability(WMIObject.PropertyByNameAsInteger('Availability'));
      FConfigManagerErrorCode := WMIObject.PropertyByNameAsInteger('ConfigManagerErrorCode');
      FConfigManagerUserConfig := WMIObject.PropertyByNameAsBoolean('ConfigManagerUserConfig');
      FDeviceID := WMIObject.PropertyByNameAsString('DeviceID');
      FDoubleSpeedThreshold := WMIObject.PropertyByNameAsInteger('DoubleSpeedThreshold');
      FErrorCleared := WMIObject.PropertyByNameAsBoolean('ErrorCleared');
      FErrorDescription := WMIObject.PropertyByNameAsString('ErrorDescription');
      FHardwareType := WMIObject.PropertyByNameAsString('HardwareType');
      FInfFileName := WMIObject.PropertyByNameAsString('InfFileName');
      FInfSection := WMIObject.PropertyByNameAsString('InfSection');
      FInstallDate := WMIObject.PropertyByNameAsDateTime('InstallDate');
      FIsLocked := WMIObject.PropertyByNameAsBoolean('IsLocked');
      FLastErrorCode := WMIObject.PropertyByNameAsInteger('LastErrorCode');
      FManufacturer := WMIObject.PropertyByNameAsString('Manufacturer');
      FName := WMIObject.PropertyByNameAsString('Name');
      FPowerManagementSupported := WMIObject.PropertyByNameAsBoolean('PowerManagementSupported');
      FQuadSpeedThreshold := WMIObject.PropertyByNameAsInteger('QuadSpeedThreshold');
      FResolution := WMIObject.PropertyByNameAsInteger('Resolution');
      FSampleRate := WMIObject.PropertyByNameAsInteger('SampleRate');
      FStatus := WMIObject.PropertyByNameAsString('Status');
      FStatusInfo := TLMDSysStatusInfo(WMIObject.PropertyByNameAsInteger('StatusInfo'));
      FSynch := WMIObject.PropertyByNameAsInteger('Synch');
    end;}

    for j:=Low(TLMDSysMouseDisplayInfo) to High(TLMDSysMouseDisplayInfo) do
    if j in FDisplayInfo then
      with FPropertiesDesc.PropertyByID(Ord(j)) do
        case j of
          mpidCursorSchemes: Text:=tmpStr;

          //mpidName: Text:= FName;
          //mpidManufacturer: Text:= FManufacturer;
          //mpidHardwareType: Text:=  FHardwareType;
          mpidButtons: Text:= IntToStr(FBtns);
          mpidHasWheel: Text:=BoolToStr(FWheel);
          mpidSwapButtons: Text:= BoolToStr(FSwapBtns);
          mpidSpeed: Text:=IntToStr(FSpeed);
          //mpidResolution: Text:=IntToStr(FResolution);
          mpidDoubleClickTime: Text:= IntToStr(FDoubleClickTime);
          mpidDoubleClickWidth: Text:=  IntToStr(FDblClickWidth);
          mpidDoubleClickHeight: Text:=IntToStr(FDblClickHeight);
          mpidExist: Text:=BoolToStr(FExist);
          mpidSnapToDefault: Text:=  BoolToStr(FSnapToDefault);
          mpidCursorScheme: Text:= FCursorScheme;

          //mpidAvailability: Text:=  SysAvailabilityToStr(FAvailability);
          //mpidDeviceID: Text:=  FDeviceID;
          //mpidDoubleSpeedThreshold: Text:=IntToStr(FDoubleSpeedThreshold);
          //mpidPowerManagementSupported: Text:=  BoolToStr(FPowerManagementSupported);
          //mpidQuadSpeedThreshold: Text:= IntToStr(FQuadSpeedThreshold);
          //mpidSampleRate: Text:=  IntToStr(FSampleRate);
          //mpidStatus: Text:=  FStatus;
          //mpidStatusInfo: Text:=  SysStatusInfoToStr(FStatusInfo);
          //mpidSynch: Text:= IntToStr(FSynch);
        end;

DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysMouseObject.Apply;
begin
  if PropChanged(strDoubleClickTime) then
    begin
      WriteToLog(strDoubleClickTime);
      SetDoubleClickTime(FDoubleClickTime);
    end;
  if PropChanged(strSwapButtons) then
    begin
      WriteToLog(strSwapButtons);
      SystemParametersInfo(SPI_SETMOUSEBUTTONSWAP, FDoubleClickTime, nil, 0);
    end;
  if PropChanged(strMouseSpeed) then
    begin
      WriteToLog(strMouseSpeed);
      SystemParametersInfo(SPI_SETMOUSESPEED, FSpeed, nil, 0);
    end;
  if PropChanged(strMouseSnapToDefault) then
    begin
      WriteToLog(strMouseSnapToDefault);
      SystemParametersInfo(SPI_SETSNAPTODEFBUTTON, Ord(FSnapToDefault), nil, 0);
    end;
  if PropChanged(strDoubleClickHeight) then
    begin
      WriteToLog(strDoubleClickHeight);
      SystemParametersInfo(SPI_SETDOUBLECLKHEIGHT, FDblClickHeight, nil, 0);
    end;
  if PropChanged(strDoubleClickWidth) then
    begin
      WriteToLog(strDoubleClickWidth);
      SystemParametersInfo(SPI_SETDOUBLECLKWIDTH, FDblClickWidth, nil, 0);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMouseObject.GetElementTitle : string;
begin
  result := sLMDSysMouseObjectTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMouseObject.GetElementDescription : string;
begin
  result := sLMDSysMouseObjectDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMouseObject.GetElementType : TLMDSysInfoType;
begin
  result := itMouse;
end;

end.
