unit LMDSysServiceInfo;
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

LMDSysServiceInfo unit (AH)
---------------------------


Changes
-------
Release 11.0 (August 2010)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, LMDSysBase, LMDSysObject, LMDSysServiceObject;

type
  TLMDSysServiceInfoType = (sitServices, sitDrivers, sitAll);
  TLMDSysServiceInfoStatus = (sisActive, sisInactive, sisAll);

  TLMDSysServiceItem = class(TLMDSysCollectionItem)
  private
    FDisplayName: String;
    FServiceName: String;
    FBinaryPath: String;
    FLoadOrderGroup: String;
    FServiceStartName: String;
    FTagId: DWord;
    FServiceTypes: TLMDSysServiceTypes;
    FCurrentState: TLMDSysServiceCurrentState;
    FStartType: TLMDSysServiceStartType;
    procedure SetDummyDWord(aValue: DWORD);
    procedure SetDummyString(const aValue: string);
    procedure SetDummyTypes(aValue: TLMDSysServiceTypes);
    procedure SetDummyState(aValue: TLMDSysServiceCurrentState);
    procedure SetDummyStartType(aValue: TLMDSysServiceStartType);
    function ServiceTypesToString: String;
    function ServiceTypeToString(const AType: TLMDSysServiceType): String;
    function CurrentStateToString: String;
    function StartTypeToString: String;
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property DisplayName: String read FDisplayName write SetDummyString;
    property ServiceName: String read FServiceName write SetDummyString;
    property BinaryPath: String read FBinaryPath write SetDummyString;
    property LoadOrderGroup: String read FLoadOrderGroup write SetDummyString;
    property ServiceStartName: String read FServiceStartName write SetDummyString;
    property TagId: DWord read FTagId write SetDummyDWord;
    property ServiceTypes: TLMDSysServiceTypes read FServiceTypes write SetDummyTypes;
    property CurrentState: TLMDSysServiceCurrentState read FCurrentState write SetDummyState;
    property StartType: TLMDSysServiceStartType read FStartType write SetDummyStartType;
  end;

  { ************************************************************************** }
  TLMDSysServicesInfo = class(TLMDSysCollection)
  private
    FOwner: TComponent;
    FStatus: TLMDSysServiceInfoStatus;
    FType: TLMDSysServiceInfoType;
    function GetItem(Index: Integer): TLMDSysServiceItem;
    procedure SetItem(Index: Integer; Value: TLMDSysServiceItem);
    procedure SetServiceStatus(const Value: TLMDSysServiceInfoStatus);
    procedure SetServiceType(const Value: TLMDSysServiceInfoType);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDSysServiceItem;
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure Refresh;

    function GetElementTitle : string;  override;
    function GetElementDescription : string;  override;
    function GetElementType : TLMDSysInfoType; override;

    property Items[Index: Integer]: TLMDSysServiceItem read GetItem write SetItem; default;
  published
    property ServiceType: TLMDSysServiceInfoType read FType write SetServiceType default sitAll;
    property ServiceStatus: TLMDSysServiceInfoStatus read FStatus write SetServiceStatus default sisAll;
  end;

implementation

uses
  WinSvc, LMDSysConst;

const
  cpidServiceName = 0;
  cpidDisplayName = 1;
  cpidBinaryPath = 2;
  cpidLoadOrderGroup = 3;
  cpidServiceStartName = 4;
  cpidTagId = 5;
  cpidServiceTypes = 6;
  cpidCurrentState = 7;
  cpidStartType = 8;

{ TLMDSysServicesInfo }

function TLMDSysServicesInfo.Add: TLMDSysServiceItem;
begin
  Result:= TLMDSysServiceItem(inherited Add);
end;

constructor TLMDSysServicesInfo.Create(aOwner: TComponent);
begin
  inherited Create(TLMDSysServiceItem);
  FOwner:= aOwner;
  FType := sitServices;
  FStatus := sisAll;
end;

destructor TLMDSysServicesInfo.Destroy;
begin
  FOwner:= nil;
  inherited Destroy;
end;

function TLMDSysServicesInfo.GetElementDescription: string;
begin
  result := sLMDSysServiceObjectDesc;
end;

function TLMDSysServicesInfo.GetElementTitle: string;
begin
  result := sLMDSysServiceObjectTitle;
end;

function TLMDSysServicesInfo.GetElementType: TLMDSysInfoType;
begin
  Result := itServiceGroup;
end;

function TLMDSysServicesInfo.GetItem(Index: Integer): TLMDSysServiceItem;
begin
  Result := TLMDSysServiceItem(GetItem(Index));
end;

function TLMDSysServicesInfo.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

procedure TLMDSysServicesInfo.Refresh;
const
  LMDSysServiceTypeValues: array[TLMDSysServiceType] of integer = ($2, $1, $10, $20, $100);
  LMDSysServiceInfoTypeValues: array[TLMDSysServiceInfoType] of integer = (SERVICE_WIN32, SERVICE_DRIVER, SERVICE_TYPE_ALL);
  LMDSysServiceInfoStatusValues: array[TLMDSysServiceInfoStatus] of integer = (SERVICE_ACTIVE, SERVICE_INACTIVE, SERVICE_STATE_ALL);

var
  LScMan: SC_Handle;
  LSsa: array of TEnumServiceStatus;
  LBytesNeeded: Cardinal;
  LServices: Cardinal;
  LResumeHandle: Cardinal;
  LResult: Boolean;
  i: Integer;
  LLastError: Cardinal;
  LService: Cardinal;
  {$ifdef LMDCOMP16}
  LServiceConfig: LPQUERY_SERVICE_CONFIGW;
  {$else}
  LServiceConfig: PQueryServiceConfig;
  {$endif}
  j: TLMDSysServiceType;
begin
  Clear;
  LScMan := OpenSCManager(PChar(''), nil, SC_MANAGER_ENUMERATE_SERVICE);
  try
    if (LScMan > 0) then
    begin
      SetLength(LSsa, 1);
      LResumeHandle := 0;
      LResult := EnumServicesStatus(LScMan, LMDSysServiceInfoTypeValues[FType], LMDSysServiceInfoStatusValues[FStatus], LSsa[0], 0,
        LBytesNeeded, LServices, LResumeHandle);
      LLastError := GetLastError();
      if (not LResult) then
      begin
        if (LLastError = ERROR_MORE_DATA) then
        begin
          LResumeHandle := 0;
          SetLength(LSsa, LBytesNeeded div SizeOf(TEnumServiceStatus));
          EnumServicesStatus(LScMan, LMDSysServiceInfoTypeValues[FType], LMDSysServiceInfoStatusValues[FStatus], LSsa[0],
            Length(LSsa) * SizeOf(TEnumServiceStatus), LBytesNeeded, LServices, LResumeHandle);
        end
        else
          {$IFNDEF LMDCOMP9}
          RaiseLastOSError;
          {$ELSE}
          RaiseLastOSError(LLastError);
          {$ENDIF}
      end;
      DoProgress(sLMDSysServiceObjectTitle, LServices - 1, 0);
      for i := 0 to LServices - 1 do
      begin
        LService := OpenService(LScMan, LSsa[i].lpServiceName, SERVICE_QUERY_CONFIG);
        try
          if (LService > 0) then
          begin
            QueryServiceConfig(LService, nil, 0, LBytesNeeded);
            GetMem(LServiceConfig, LBytesNeeded);
            try
              if (QueryServiceConfig(LService, LServiceConfig, LBytesNeeded, LBytesNeeded)) then
              begin
                with Add() do
                begin
                  FServiceName := LSsa[i].lpServiceName;
                  FDisplayName := LSsa[i].lpDisplayName;
                  FBinaryPath := LServiceConfig.lpBinaryPathName;
                  FLoadOrderGroup := LServiceConfig.lpLoadOrderGroup;
                  FServiceStartName := LServiceConfig.lpServiceStartName;
                  FTagId := LServiceConfig.dwTagId;
                  FStartType := TLMDSysServiceStartType(LServiceConfig.dwStartType);
                  FCurrentState := TLMDSysServiceCurrentState(LSsa[i].ServiceStatus.dwCurrentState);
                  for j := Low(TLMDSysServiceType) to High(LMDSysServiceTypeValues) do
                  begin
                    if (LSsa[i].ServiceStatus.dwServiceType and LMDSysServiceTypeValues[j]) > 0 then
                      Include(FServiceTypes, j);
                  end;
                  Refresh;
                  DoProgress(sLMDSysServiceObjectTitle, LServices - 1, i);
                end;
              end
            finally
              FreeMem(LServiceConfig);
            end;
          end
        finally
          CloseServiceHandle(LServices);
        end;
      end;
    end;
  finally
    CloseServiceHandle(LScMan);
    DoProgress('', 100, 0);
  end;
end;

procedure TLMDSysServicesInfo.SetItem(Index: Integer; Value: TLMDSysServiceItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TLMDSysServicesInfo.SetServiceStatus(const Value: TLMDSysServiceInfoStatus);
begin
  if (FStatus <> Value) then
  begin
    FStatus := Value;
    Refresh;
  end;
end;

procedure TLMDSysServicesInfo.SetServiceType(const Value: TLMDSysServiceInfoType);
begin
  if (FType <> Value) then
  begin
    FType := Value;
    Refresh;
  end;
end;

{ TLMDSysServiceItem }

function TLMDSysServiceItem.CurrentStateToString: String;
begin
  case FCurrentState of
    sscsContinuePending: Result := sLMDSysServiceContinuePending;
    sscsPausePending: Result := sLMDSysServicePausePending;
    sscsPaused: Result := sLMDSysServicePaused;
    sscsRunning: Result := sLMDSysServiceRunning;
    sscsStartPending: Result := sLMDSysServiceStartPending;
    sscsStopPending: Result := sLMDSysServiceStopPending;
    sscsStopped: Result := sLMDSysServiceStopped;
  end;
end;

function TLMDSysServiceItem.GetElementDescription: string;
begin
  Result := FDisplayName;
end;

function TLMDSysServiceItem.GetElementTitle: string;
begin
  Result := FServiceName;
end;

function TLMDSysServiceItem.GetElementType: TLMDSysInfoType;
begin
  if [sstFileSystemDriver, sstKernelDriver] * FServiceTypes <> [] then
    Result := itDriver
  else
    Result := itService;
end;

procedure TLMDSysServiceItem.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidServiceName).Text := FServiceName;
  FPropertiesDesc.PropertyByID(cpidDisplayName).Text := FDisplayName;
  FPropertiesDesc.PropertyByID(cpidBinaryPath).Text := FBinaryPath;
  FPropertiesDesc.PropertyByID(cpidLoadOrderGroup).Text := FLoadOrderGroup;
  FPropertiesDesc.PropertyByID(cpidServiceStartName).Text := FServiceStartName;
  FPropertiesDesc.PropertyByID(cpidTagId).Text := IntToStr(FTagId);
  FPropertiesDesc.PropertyByID(cpidServiceTypes).Text := ServiceTypesToString();
  FPropertiesDesc.PropertyByID(cpidCurrentState).Text := CurrentStateToString();
  FPropertiesDesc.PropertyByID(cpidStartType).Text := StartTypeToString();
end;

procedure TLMDSysServiceItem.RegisterProperties;
begin
  Inherited;
  FPropertiesDesc.Add(cpidServiceName, sLMDSysServicePropTitleServiceName, sLMDSysServicePropDescServiceName);
  FPropertiesDesc.Add(cpidDisplayName, sLMDSysServicePropTitleDisplayName, sLMDSysServicePropDescDisplayName);
  FPropertiesDesc.Add(cpidBinaryPath, sLMDSysServicePropTitleBinaryPath, sLMDSysServicePropDescBinaryPath);
  FPropertiesDesc.Add(cpidLoadOrderGroup, sLMDSysServicePropTitleLoadOrderGroup, sLMDSysServicePropDescLoadOrderGroup);
  FPropertiesDesc.Add(cpidServiceStartName, sLMDSysServicePropTitleServiceStartName, sLMDSysServicePropDescServiceStartName);
  FPropertiesDesc.Add(cpidTagId, sLMDSysServicePropTitleTagId, sLMDSysServicePropDescTagId);
  FPropertiesDesc.Add(cpidServiceTypes, sLMDSysServicePropTitleServiceTypes, sLMDSysServicePropDescServiceTypes);
  FPropertiesDesc.Add(cpidCurrentState, sLMDSysServicePropTitleCurrentState, sLMDSysServicePropDescCurrentState);
  FPropertiesDesc.Add(cpidStartType, sLMDSysServicePropTitleStartType, sLMDSysServicePropDescStartType);
end;

function TLMDSysServiceItem.ServiceTypesToString: String;
var
  i: TLMDSysServiceType;
begin
  for i := Low(TLMDSysServiceType) to High(TLMDSysServiceType) do
  begin
    if (i in FServiceTypes) then
      if Result = '' then
        Result := Result + ServiceTypeToString(i)
      else
        Result := Result + ', ' + ServiceTypeToString(i);
  end;
end;

function TLMDSysServiceItem.ServiceTypeToString(const AType: TLMDSysServiceType): String;
begin
  case AType of
    sstFileSystemDriver: Result := sLMDSysServiceTypeFileSystemDriver;
    sstKernelDriver: Result := sLMDSysServiceTypeKernelDriver;
    sstWin32OwnProcess: Result := sLMDSysServiceTypeWin32OwnProcess;
    sstWin32ShareProcess: Result := sLMDSysServiceTypeWin32ShareProcess;
    sstInteractiveProcess: Result := sLMDSysServiceTypeInteractiveProcess;
  end;
end;

function TLMDSysServiceItem.StartTypeToString: String;
begin
  case FStartType of
    ssstAutoStart: Result := sLMDSysServiceStartAutoStart;
    ssstBootStart: Result := sLMDSysServiceStartBootStart;
    ssstDemandStart: Result := sLMDSysServiceStartDemandStart;
    ssstdisabled: Result := sLMDSysServiceStartdisabled;
    ssstSystemStart: Result := sLMDSysServiceStartSystemStart;
  end;
end;

procedure TLMDSysServiceItem.SetDummyDWord(aValue: DWORD);
begin end;

procedure TLMDSysServiceItem.SetDummyStartType(aValue: TLMDSysServiceStartType);
begin end;

procedure TLMDSysServiceItem.SetDummyState(aValue: TLMDSysServiceCurrentState);
begin end;

procedure TLMDSysServiceItem.SetDummyString(const aValue: string);
begin end;

procedure TLMDSysServiceItem.SetDummyTypes(aValue: TLMDSysServiceTypes);
begin end;

end.
