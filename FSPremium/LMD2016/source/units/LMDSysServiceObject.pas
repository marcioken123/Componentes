unit LMDSysServiceObject;
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

LMDSysServiceObject unit (AH)
-----------------------------


Changes
-------
Release 11.0 (August 2010)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, LMDSysObject;

type
  TLMDSysServiceType = (sstFileSystemDriver, sstKernelDriver, sstWin32OwnProcess,
    sstWin32ShareProcess, sstInteractiveProcess);

  TLMDSysServiceTypes = set of TLMDSysServiceType;

  TLMDSysServiceCurrentState = (sscsContinuePending = 5, sscsPausePending = 6, sscsPaused = 7,
    sscsRunning = 4, sscsStartPending = 2, sscsStopPending = 3, sscsStopped = 1);

  TLMDSysServiceStartType = (ssstAutoStart = 2, ssstBootStart = 0, ssstDemandStart = 3,
    ssstdisabled = 4, ssstSystemStart = 1);

  TLMDSysServiceObject = class(TLMDSysObject)
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
    function ServiceTypeToString(const AType: TLMDSysServiceType): String;
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh; override;
    procedure Apply; override;

    function ServiceTypesToString: String;
    function CurrentStateToString: String;
    function StartTypeToString: String;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
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

implementation

uses
  LMDSysConst;

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

{ TLMDSysServiceObject }

procedure TLMDSysServiceObject.Apply;
begin
end;

function TLMDSysServiceObject.CurrentStateToString: String;
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

function TLMDSysServiceObject.GetElementDescription: string;
begin
  Result := sLMDSysServiceObjectDesc;
end;

function TLMDSysServiceObject.GetElementTitle: string;
begin
  Result := sLMDSysServiceObjectTitle;
end;

procedure TLMDSysServiceObject.Refresh;
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

procedure TLMDSysServiceObject.RegisterProperties;
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

function TLMDSysServiceObject.ServiceTypesToString: String;
var
  i: TLMDSysServiceType;
begin
  for i := Low(TLMDSysServiceType) to High(TLMDSysServiceType) do
  begin
    if (i in FServiceTypes) then
    begin
      Result := Result + ServiceTypeToString(i);
      if (i <> High(TLMDSysServiceType)) then
        Result := Result + ', ';
    end;
  end;
end;

function TLMDSysServiceObject.ServiceTypeToString(const AType: TLMDSysServiceType): String;
begin
  case AType of
    sstFileSystemDriver: Result := sLMDSysServiceTypeFileSystemDriver;
    sstKernelDriver: Result := sLMDSysServiceTypeKernelDriver;
    sstWin32OwnProcess: Result := sLMDSysServiceTypeWin32OwnProcess;
    sstWin32ShareProcess: Result := sLMDSysServiceTypeWin32ShareProcess;
    sstInteractiveProcess: Result := sLMDSysServiceTypeInteractiveProcess;
  end;
end;

function TLMDSysServiceObject.StartTypeToString: String;
begin
  case FStartType of
    ssstAutoStart: Result := sLMDSysServiceStartAutoStart;
    ssstBootStart: Result := sLMDSysServiceStartBootStart;
    ssstDemandStart: Result := sLMDSysServiceStartDemandStart;
    ssstdisabled: Result := sLMDSysServiceStartdisabled;
    ssstSystemStart: Result := sLMDSysServiceStartSystemStart;
  end;
end;

procedure TLMDSysServiceObject.SetDummyDWord(aValue: DWORD);
begin end;

procedure TLMDSysServiceObject.SetDummyStartType(aValue: TLMDSysServiceStartType);
begin end;

procedure TLMDSysServiceObject.SetDummyState(aValue: TLMDSysServiceCurrentState);
begin end;

procedure TLMDSysServiceObject.SetDummyString(const aValue: string);
begin end;

procedure TLMDSysServiceObject.SetDummyTypes(aValue: TLMDSysServiceTypes);
begin end;

end.
