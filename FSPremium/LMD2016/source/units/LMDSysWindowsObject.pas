unit LMDSysWindowsObject;
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

LMDSysWindowsObject unit (JH)
-----------------------------
Information about the operating system

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, 
  LMDSysObject, LMDSysBase, LMDSysConst;

type
  TLMDSysWindowsDisplayInfo=(wdiRegisteredOwner, wdiRegisteredCompany, wdiProductID,
                             wdiProductName, wdiProductFullName, wdiPProductType, wdiPlatformID, wdiProductSuite,
                             wdiMajorVersion, wdiMinorVersion, wdiBuildNumber, wdiVersionName,
                             wdiCSDVersion, wdiServicePackMajor, wdiServicePackMinor,
                             wdiInstallDate, wdiLastBoot, wdiUpTimeString,
                             wdiSystemFolders, wdiEnvironment,
                             wdiTempDir, wdiSysDir, wdiWinDir);
  TLMDSysWindowsDisplayInfos=set of TLMDSysWindowsDisplayInfo;

const
  def_TLMDSysWindowsDisplayInfos=[wdiRegisteredOwner, wdiRegisteredCompany, wdiProductID,
                             wdiProductName, wdiProductFullName, wdiPProductType, wdiPlatformID, wdiProductSuite,
                             wdiMajorVersion, wdiMinorVersion, wdiBuildNumber, wdiVersionName,
                             wdiCSDVersion, wdiServicePackMajor, wdiServicePackMinor,
                             wdiInstallDate, wdiLastBoot, wdiUpTimeString,
                             wdiSystemFolders, wdiEnvironment,
                             wdiTempDir, wdiSysDir, wdiWinDir];

  LMDSysWindowsProps:array[TLMDSysWindowsDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysWinPropTitleRegisteredOwner; Description: sLMDSysWinPropDescRegisteredOwner),
    (Name: sLMDSysWinPropTitleRegisteredCompany; Description: sLMDSysWinPropDescRegisteredCompany),
    (Name: sLMDSysWinPropTitleProductID; Description: sLMDSysWinPropDescProductID),
    (Name: sLMDSysWinPropTitleProductName; Description: sLMDSysWinPropDescProductName),
    (Name: sLMDSysWinPropTitleProductName; Description: sLMDSysWinPropDescProductName),
    (Name: sLMDSysWinPropTitleProductType; Description: sLMDSysWinPropDescProductType),
    (Name: sLMDSysWinPropTitlePlatformID; Description: sLMDSysWinPropDescPlatformID),
    (Name: sLMDSysWinPropTitleProductSuite; Description: sLMDSysWinPropDescProductSuite),
    (Name: sLMDSysWinPropTitleMajorVersion; Description: sLMDSysWinPropDescMajorVersion),
    (Name: sLMDSysWinPropTitleMinorVersion; Description: sLMDSysWinPropDescMinorVersion),
    (Name: sLMDSysWinPropTitleBuildNumber; Description: sLMDSysWinPropDescBuildNumber),
    (Name: sLMDSysWinPropTitleVersionName; Description: sLMDSysWinPropDescVersionName),
    (Name: sLMDSysWinPropTitleCSDVersion; Description: sLMDSysWinPropDescCSDVersion),
    (Name: sLMDSysWinPropTitleServicePackMajor; Description: sLMDSysWinPropDescServicePackMajor),
    (Name: sLMDSysWinPropTitleServicePackMinor; Description: sLMDSysWinPropDescServicePackMinor),
    (Name: sLMDSysWinPropTitleInstallDate; Description: sLMDSysWinPropDescInstallDate),
    (Name: sLMDSysWinPropTitleLastBoot; Description: sLMDSysWinPropDescLastBoot),
    (Name: sLMDSysWinPropTitleUpTimeString; Description: sLMDSysWinPropDescUpTimeString),
    (Name: sLMDSysWinPropTitleSystemFolders; Description: sLMDSysWinPropDescSystemFolders),
    (Name: sLMDSysWinPropTitleEnvironment; Description: sLMDSysWinPropDescEnvironment),
    (Name: sLMDSysWinPropTitleTempDir; Description: sLMDSysWinPropDescTempDir),
    (Name: sLMDSysWinPropTitleSysDir; Description: sLMDSysWinPropDescSysDir),
    (Name: sLMDSysWinPropTitleWinDir; Description: sLMDSysWinPropDescWinDir)
    );

type
  { ************************************************************************** }
  TLMDSysWindowsObject = class(TLMDSysObject)
  private
    //version ...
    FCSDVersion,
    FProductID,
    FWinDir,
    FWinSysDir,
    FProductName,
    FVersion,
    FRegisteredCompany,
    FRegisteredOwner: string;
    FBuildNumber,
    FPlatformID,
    FMajorVersion,
    FMinorVersion,
    FServiceMajor,
    FServiceMinor: Cardinal;
    FInstallDate,
    FLastBoot:TDateTime;
    FSystemFolders,
    FEnvironment:TStringList;
    FProductTypeID:TLMDSysProductType;
    FProductSuite:TLMDSysProductSuites;
    FProductExtName: String;
    FDisplayInfo: TLMDSysWindowsDisplayInfos;
    procedure DummyStrings(AList:TStrings);
    procedure SetDummyString(aValue: string);
    procedure SetDummyCardinal(aValue: Cardinal);
    procedure SetDummyDateTime(const Value: TDateTime);
    procedure SetDummyType(const Value: TLMDSysProductSuites);
    procedure SetDisplayInfo(const Value: TLMDSysWindowsDisplayInfos);
    function GetProductType: String;
    function GetEnvironment: TStrings;
    function GetSystemFolders: TStrings;
    function GetUpTime:Double;
    function GetTempDir: String;
    function GetUptimeString: String;
    function GetSuiteString:String;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create;override;
    destructor Destroy;override;

    procedure Init;override;
    procedure Refresh; override;
    procedure Apply; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType:TLMDSysInfoType; override;

    property UpTime:Double read GetUpTime;
    property ProductTypeID:TLMDSysProductType read FProductTypeID;
  published
    property RegisteredOwner: string read FRegisteredOwner write SetDummyString stored false;
    property RegisteredCompany: string read FRegisteredCompany write SetDummyString stored false;
    property ProductName: string read FProductName write SetDummyString stored false;
    property ProductID: string read FProductID write SetDummyString stored false;
    property CSDVersion: string read FCSDVersion write SetDummyString stored false;
    property PlatformID: Cardinal read FPlatformID write SetDummyCardinal stored false;
    property BuildNumber: Cardinal read FBuildNumber write SetDummyCardinal stored false;
    property MajorVersion: Cardinal read FMajorVersion write SetDummyCardinal stored false;
    property MinorVersion: Cardinal read FMinorVersion write SetDummyCardinal stored false;

    // Updated
    property ProductSuite:TLMDSysProductSuites read FProductSuite write SetDummyType stored false;
    property Environment:TStrings read GetEnvironment write DummyStrings stored false;
    property SystemFolders:TStrings read GetSystemFolders write DummyStrings stored false;
    property LastBoot:TDateTime read FLastBoot write SetDummyDateTime stored false;
    property InstallDate:TDateTime read FInstallDate write SetDummyDateTime stored false;
    property WindowsDir:String read FWindir write SetDummyString stored false;
    property SystemDir:String read FWinSysDir write SetDummyString stored false;
    property ServicePackMajor:Cardinal read FServiceMajor write SetDummyCardinal stored false;
    property ServicePackMinor:Cardinal read FServiceMinor write SetDummyCardinal stored false;
    property VersionName:String read FVersion write SetDummyString  stored false;
    property ProductType:String read GetProductType write SetDummyString stored false;
    property ProductFullName:String read FProductExtName write SetDummyString stored false;
    property TempDir:String read GetTempDir write SetDummyString stored false;
    property UpTimeString:String read GetUptimeString write SetDummyString stored false;

    // Allows programmer to select which information is shown
    property DisplayInfo:TLMDSysWindowsDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysWindowsDisplayInfos;
  end;

implementation
uses
  TypInfo, Registry, SysUtils,
  LMDSysInfoProcs, LMDSysIn, LMDProcs;

{ **************************************************************************** }
{ -------------------------- private ----------------------------------------- }
function TLMDSysWindowsObject.GetProductType: String;
begin
  result:=sLMDSysProductType[ProductTypeID];
end;

{------------------------------------------------------------------------------}
function TLMDSysWindowsObject.GetSuiteString: String;
var
  i:TLMDSysProductSuite;
begin
  result:='';
  for i:=Low(TLMDSysProductSuite) to High (TLMDSysProductSuite) do
    if i in FProductSuite then
      begin
        if result<>'' then result:=result+', ';
        result:=result+copy(GetEnumName(TypeInfo(TLMDSysProductSuite), Ord(i)), 4, 200);
      end;
end;

{------------------------------------------------------------------------------}
function TLMDSysWindowsObject.GetEnvironment: TStrings;
begin
  if not Assigned(FEnvironment) then
    begin
      FEnvironment:=TStringList.Create;
      LMDSIEnvironment(FEnvironment);
    end;
  result:=FEnvironment;
end;

{------------------------------------------------------------------------------}
function TLMDSysWindowsObject.GetSystemFolders: TStrings;
begin
  if not Assigned(FSystemFolders) then
    begin
      FSystemFolders:=TStringList.Create;
      LMDSysSystemFolders(FSystemFolders);
    end;
  result:=FSystemFolders;
end;

{------------------------------------------------------------------------------}
function TLMDSysWindowsObject.GetUpTime:Double;
begin
  result:=LMDSITimeElapsedSinceBoot;
end;

{------------------------------------------------------------------------------}
function TLMDSysWindowsObject.GetTempDir: String;
begin
  result:=LMDSITempPath;
end;

{------------------------------------------------------------------------------}
function TLMDSysWindowsObject.GetUptimeString: String;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Uptime, Hour, Min, Sec, MSec);
  result:=Format(sLMDSysElapsedTime, [Trunc(Uptime), Hour, Min, Sec]);
end;
{------------------------------------------------------------------------------}
procedure TLMDSysWindowsObject.SetDummyType(const Value: TLMDSysProductSuites);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysWindowsObject.SetDummyString(aValue: string);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWindowsObject.SetDisplayInfo(const Value: TLMDSysWindowsDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      RegisterProperties;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWindowsObject.SetDummyCardinal(aValue: Cardinal);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysWindowsObject.SetDummyDateTime(const Value: TDateTime);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysWindowsObject.DummyStrings(AList: TStrings);
begin
end;

{ -------------------------- procected --------------------------------------- }
procedure TLMDSysWindowsObject.RegisterProperties;
var
  i:TLMDSysWindowsDisplayInfo;
begin
  FPropertiesDesc.Clear;
  for i:=Low(TLMDSysWindowsDisplayInfo) to High(TLMDSysWindowsDisplayInfo) do
    if i in FDisplayInfo then
      FPropertiesDesc.Add(Ord(i), LMDSysWindowsProps[i].Name, LMDSysWindowsProps[i].Description);
end;

{ -------------------------- public ------------------------------------------ }
//procedure TLMDSysWindowsObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWindowsObject.Refresh;
var
  i:TLMDSysWindowsDisplayInfo;
begin
  DoProgress(sLMDSysWindowsObjectsTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;
  if not FInit then Init;

  for i:=Low(TLMDSysWindowsDisplayInfo) to High(TLMDSysWindowsDisplayInfo) do
    if i in FDisplayInfo then
      with FPropertiesDesc.PropertyByID(Ord(i)) do
        case i of
          wdiRegisteredOwner: Text := FRegisteredOwner;
          wdiRegisteredCompany: Text := FRegisteredCompany;
          wdiProductID: Text := FProductID;
          wdiProductName: Text := FProductName;
          wdiProductFullName: Text := FProductExtName;
          wdiPProductType: Text := ProductType;
          wdiPlatformID: Text := Inttostr(FPlatformID);
          wdiProductSuite:Text := GetSuiteString;
          wdiMajorVersion:Text := Inttostr(FMajorVersion);
          wdiMinorVersion: Text := Inttostr(FMinorVersion);
          wdiBuildNumber: Text := Inttostr(FBuildNumber);
          wdiVersionName: Text := FVersion;
          wdiCSDVersion: Text := FCSDVersion;
          wdiServicePackMajor: Text := Inttostr(FServiceMajor);
          wdiServicePackMinor: Text := Inttostr(FServiceMinor);
          wdiInstallDate: Text := DateToStr(FInstallDate);
          wdiLastBoot: Text := DateTimeToStr(FLastBoot);
          wdiUpTimeString: Text := UpTimeString;
          wdiSystemFolders: Text:= GetSystemFolders.Text;
          wdiEnvironment: Text:=GetEnvironment.Text;
          wdiTempDir: Text := TempDir;
          wdiSysDir: Text := FWinSysDir;
          wdiWinDir: Text := FWinDir;
        end;

  DoProgress(sLMDSysWindowsObjectsTitle, 100, 100);
  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysWindowsObject.Apply;
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWindowsObject.GetElementTitle : string;
begin
  result := sLMDSysWindowsObjectsTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWindowsObject.GetElementDescription : string;
begin
  result := sLMDSysWindowsObjectsDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysWindowsObject.GetElementType : TLMDSysInfoType;
begin
  result := itWindows;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDSysWindowsObject.Create;
begin
  FDisplayInfo:=def_TLMDSysWindowsDisplayInfos;
  FEnvironment:=nil;
  FSystemFolders:=nil;
  inherited;  //call inherited after that
end;

{------------------------------------------------------------------------------}
destructor TLMDSysWindowsObject.Destroy;
begin
  if Assigned(FEnvironment) then
    FreeAndNil(FEnvironment);
  if Assigned(FSystemFolders) then
    FreeAndNil(FSystemFolders);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysWindowsObject.Init;
var
  s: string;
  tmp:DWORD;
  os: TOSVersionInfoEx;

const
  VER_SUITE_SMALLBUSINESS = $00000001;
  VER_SUITE_ENTERPRISE = $00000002;
  VER_SUITE_BACKOFFICE = $00000004;
  VER_SUITE_COMMUNICATIONS = $00000008;
  VER_SUITE_TERMINAL = $00000010;
  VER_SUITE_SMALLBUSINESS_RESTRICTED = $00000020;
  VER_SUITE_EMBEDDEDNT = $00000040;
  VER_SUITE_DATACENTER = $00000080;
  VER_SUITE_SINGLEUSERTS = $00000100;

  VER_SUITE_BLADE = $00000400;
  VER_SUITE_EMBEDDED_RESTRICTED = $00000800;
  VER_SUITE_PERSONAL = $00000200;

begin
  inherited;
  FCSDVersion:= Win32CSDVersion;
  FBuildNumber:= Win32BuildNumber;
  FPlatformID:= Win32Platform;
  FMajorVersion:= Win32MajorVersion;
  FMinorVersion:= Win32MinorVersion;
  FWinDir:=LMDWindowsDirectory;
  FWinSysDir:=LMDSystemDirectory;
  FLastBoot:=LMDSILastBootTime;

  s:= '\SOFTWARE\Microsoft\Windows';
  if LMDSIWindowsNT then s:= s + ' NT';
  s:= s + '\CurrentVersion';

  OpenRegistry(true);
  SetRegistryRootKey(HKEY_LOCAL_MACHINE);
  Registry.Access := KEY_QUERY_VALUE or $0100{KEY_WOW64_64KEY};
  if OpenRegistrySubKey(s) then
    try
      FRegisteredOwner:= Registry.ReadString('RegisteredOwner');
      FRegisteredCompany:= Registry.ReadString('RegisteredOrganization');
      FProductID:= Registry.ReadString('ProductID');
      FProductName:= Registry.ReadString('ProductName');
      FVersion:=Registry.ReadString('CurrentType');
      if LMDSIWindowsNT then
        begin
          tmp := Registry.ReadInteger('InstallDate');
          FInstallDate := LMDSysUnixTimeToDateTime(tmp);
        end
      else
        begin
          Registry.ReadBinaryData('FirstInstallDateTime', tmp, SizeOf(tmp));
          FInstallDate := FileDateToDatetime(tmp);
          //FInstallDate:=SystemTimeToDatetime(tmp);
        end;

    finally
      CloseRegistrySubKey;
    end;

  if not LMDGetOSVersionInfoEx(os) then
    exit;

  FServiceMajor:=os.wServicePackMajor;
  FServiceMinor:=os.wServicePackMinor;

  FProductTypeID := TLMDSysProductType(os.wProductType);

  if os.wSuiteMask and VER_SUITE_SMALLBUSINESS > 0 then Include(FProductSuite, spsSmallBusiness);
  if os.wSuiteMask and VER_SUITE_ENTERPRISE > 0 then Include(FProductSuite, spsEnterprise);
  if os.wSuiteMask and VER_SUITE_BACKOFFICE > 0 then Include(FProductSuite, spsBackOffice);
  if os.wSuiteMask and VER_SUITE_COMMUNICATIONS > 0 then Include(FProductSuite, spsCommunications);
  if os.wSuiteMask and VER_SUITE_TERMINAL > 0 then Include(FProductSuite, spsTerminal);
  if os.wSuiteMask and VER_SUITE_SMALLBUSINESS_RESTRICTED > 0 then Include(FProductSuite, spsSmallBusinessRestricted);
  if os.wSuiteMask and VER_SUITE_EMBEDDEDNT > 0 then Include(FProductSuite, spsEmbeddedNT);
  if os.wSuiteMask and VER_SUITE_DATACENTER > 0 then Include(FProductSuite, spsDataCenter);
  // terminal server for two clients
  if os.wSuiteMask and VER_SUITE_SINGLEUSERTS > 0 then Include(FProductSuite, spsSingleUserTS);

  if os.wSuiteMask and VER_SUITE_BLADE > 0 then Include(FProductSuite, spsWebEdition);
  if os.wSuiteMask and VER_SUITE_EMBEDDED_RESTRICTED > 0 then Include(FProductSuite, spsEmbeddedRestricted);
  if os.wSuiteMask and VER_SUITE_PERSONAL > 0 then Include(FProductSuite, spsPersonal);

  // FProductExtName
  FProductExtName:='Microsoft '+ LMDSIPlatformStr;
  if not (LMDSysPlatform in [pfWin95, pfWin98, pfWinME]) then
    case FProductTypeID of
      sptWorkStation:
        if FMajorVersion=4 then
           FProductExtName:=sLMDSysProductType[ProductTypeID]+' 4.0'
        else
          if spsPersonal in FProductSuite then
            FProductExtName:=FProductExtName+' Home Edition'
          else
            FProductExtName:=FProductExtName+' Professional';
       sptServer, sptDomainController:
         if (FMajorVersion=5) and (FMinorVersion=2) then
           begin
              FProductExtName:=FProductExtName+'Server ';
              if spsDataCenter in FProductSuite then
                FProductExtName:=FProductExtName+'Datacenter Edition'
              else if spsEnterprise in FProductSuite then
                FProductExtName:=FProductExtName+'Enterprise Edition'
              else if spsWebEdition in FProductSuite then
                FProductExtName:=FProductExtName+'Web Edition'
              else
                FProductExtName:=FProductExtName+'Standard Edition';
           end
         else if (FMajorVersion=5) and (FMinorVersion=0) then
           begin
             FProductExtName:=FProductExtName+'Server ';
             if spsDataCenter in FProductSuite then
               FProductExtName:=FProductExtName+'Datacenter Edition'
              else if spsEnterprise in FProductSuite then
                FProductExtName:=FProductExtName+'Advanced Server Edition'
              else
                FProductExtName:=FProductExtName+'Standard Edition';
           end
         else
           begin
             // Windows NT 4 Service Pack 6 required
             if spsEnterprise in FProductSuite then
               FProductExtName:=FProductExtName+' Server 4.0, Enterprise Edition'
             else
               FProductExtName:=FProductExtName+' Server 4.0';
            end;
     end;
end;

end.
