unit LMDSysNetworkObject;
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

LMDRefineUnit unit (JH, RM, AH)
-------------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes,
  LMDSysObject, LMDSysPropertyDesc, LMDSysBase;

type

  TLMDNetworkCard = class;

  { ************************************************************************** }
  TLMDProtocol = class(TPersistent, IUnknown, ILMDSysDescriptor, ILMDSysPublisher)
  private
    FInstalled: Boolean;
    FNetworkCard: TLMDNetworkCard;
    procedure SetDummyBoolean(const Value: Boolean);
  protected
    FRefCount: Integer;
    FPropertiesDesc : TLMDSysPropertiesDesc;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    procedure RegisterProperties; virtual;
  public
    constructor Create(aNetworkCard: TLMDNetworkCard);
    destructor Destroy; override;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;

    procedure Refresh; virtual;
    function GetElementTitle : string; virtual;
    function GetElementDescription : string; virtual;
    function GetElementType : TLMDSysInfoType; virtual;

    function GetPropertiesCount: integer; virtual;
    function GetPropAvailability(index : integer) : boolean; virtual;
    function GetPropType(index : integer) : TLMDSysPropertyType; virtual;
    function GetPropValue(index : integer) : variant; virtual;
    function GetPropText(index : integer) : string; virtual;
    function GetPropTitle(index : integer) : string; virtual;
    function GetPropDescription(index : integer) : string; virtual;

    property NetworkCard: TLMDNetworkCard read FNetworkCard;
  published
    property Installed: Boolean read FInstalled write SetDummyBoolean stored false;
  end;

  { ************************************************************************** }
  TLMDTCPIP = class(TLMDProtocol)
  private
    FIPSubnetMask: String;
    FIPAddress: String;
    FDefaultGateway: String;
    FDHCPEnabled:Boolean;
    procedure SetDummyString(const Value: String);
    procedure SetDummyBool(const Value: Boolean);
    function GetCSIPAddress(): string;
    function GetCSIPSubnetMask(): string;
    function GetCSDefaultGateWay(): string;

  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh; override;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property DHCPEnabled:Boolean read FDHCPEnabled write SetDummyBool stored false;
    property IPAddress: String read FIPAddress write SetDummyString stored false;
    property IPSubnetMask: String read FIPSubnetMask write SetDummyString stored false;
    property DefaultGateway: String read FDefaultGateway write SetDummyString stored false;

    property CSIPAddress: string read GetCSIPAddress stored False;
    property CSIPSubnetMask: string read GetCSIPSubnetMask stored False;
    property CSDefaultGateWay: string read GetCSDefaultGateWay stored False;

  end;

  { ************************************************************************** }
  TLMDIPX = class(TLMDProtocol)
  private
    FNetworkNumber: String;
    procedure SetDummyString(const Value: String);
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh; override;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property NetworkNumber: String read FNetworkNumber write SetDummyString;
  end;

  { ************************************************************************** }
  TLMDNetBEUI = class(TLMDProtocol)
  public
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  end;

  { ************************************************************************** }
  TLMDNetworkCard = class(TLMDSysCollectionItem, ILMDSysContainer)
  private
    FDescription: String;
    FServiceName: String;
    FTCPIP: TLMDTCPIP;
    FNetBEUI: TLMDNetBEUI;
    FIPX: TLMDIPX;
    procedure SetDummyString(const Value: String);
    procedure SetDummyTCPIP(const Value: TLMDTCPIP);
    procedure SetDummyIPX(const Value: TLMDIPX);
    procedure SetDummyNetBEUI(const Value: TLMDNetBEUI);
  protected
    procedure RegisterProperties;override;
  public
    procedure Refresh;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    function GetElementCount : integer;
    function GetElement(index : integer) : TObject;

  published
    property Description: String read FDescription write SetDummyString stored false;
    property TCPIP: TLMDTCPIP read FTCPIP write SetDummyTCPIP stored false;
    property NetBEUI: TLMDNetBEUI read FNetBEUI write SetDummyNetBEUI stored false;
    property IPX: TLMDIPX read FIPX write SetDummyIPX stored false;
  end;

  { ************************************************************************** }
  TLMDNetworkCards = class(TLMDSysCollection)
  private
    FOwner: TComponent;
    function GetItem(Index: Integer): TLMDNetworkCard;
    procedure SetItem(Index: Integer; Value: TLMDNetworkCard);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDNetworkCard;
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
    property Items[Index: Integer]: TLMDNetworkCard read GetItem write SetItem; default;
  end;

  { ************************************************************************** }
  TLMDSysNetworkObject = class(TLMDSysObject, ILMDSysContainer)
  private
    FUserName: String;
    FComputerName: String;
    FNetworkCards: TLMDNetworkCards;
    FIPList:TStringList;
    //procedure SetDummyStrings(const Value: TStrings);
    procedure SetDummyString(const Value: String);
    procedure SetDummyCards(const Value: TLMDNetworkCards);
    function GetList: TStringList;
  protected
    procedure RegisterProperties;override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Refresh; override;
    procedure Apply; override;
    procedure Init;override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
    function GetElementCount : integer;
    function GetElement(index : integer) : TObject;

    property IPList:TStringList read GetList;
  published
    property UserName: String read FUserName write SetDummyString stored false;
    property ComputerName: String read FComputerName write SetDummyString stored false;
    property NetworkCards: TLMDNetworkCards read FNetworkCards write SetDummyCards stored false;
  end;

  function LMDSysGetLocalIP: string;
  procedure LMDSysGetLocalIPs(TCPIPList:TStringlist);

implementation

uses
  SysUtils, Registry, WinSock, 
  LMDSysLogStrings, LMDSysConst, LMDSysInfoProcs, LMDSysIn;

const
  cpidInstalled = 0;
  cpidIPAddress = 1;
  cpidIPSubnetMask = 2;
  cpidDefaultGateway = 3;
  cpidNetworkNumber = 4;
  cpidDHCPEnabled=5;

function StringToCommaText(AString: string): string;
var
  i: Byte;
begin
  Result := AString;
  if Length(Result) > 0 then
  begin
    while (AString[Length(Result)] = #0) and (Length(Result) > 0) do
      Delete(Result, Length(Result), 1);
    for i := 1 to Length(Result) do
      if Result[i] = #0 then
        Result[i] := ',';
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDSysGetLocalIPs(TCPIPList:TStringlist);

type
  PPInAddr= ^PInAddr;

var
  wsaData: TWSAData;
  HostInfo: PHostEnt;
  HostName: Array[0..255] of Char;
  Addr: PPInAddr;
  begin
  TCPIPList.Clear;
  if WSAStartup($0102, wsaData)<>0 then exit;
  try
    if GetHostname(@HostName, SizeOf(HostName)) <> 0 then exit;
    HostInfo:= GetHostByName(@HostName);
    if HostInfo=nil then Exit;
    Addr:=Pointer(HostInfo^.h_addr_list);
    if (Addr=nil) or (Addr^=nil) then exit;
    TCPIPList.add({$IFDEF LMDCOMP12}String{$ENDIF}(StrPas(PAnsiChar(inet_ntoa(Addr^^)))));
    inc(Addr);
    while Addr^<>nil do
      begin
        TCPIPList.add({$IFDEF LMDCOMP12}String{$ENDIF}(StrPas(PAnsiChar(inet_ntoa(Addr^^)))));
        inc(Addr);
      end;
  finally
    WSACleanup;
  end;
  end;

{ ---------------------------------------------------------------------------- }
function LMDSysGetLocalIP: string;
var
  wsaData : TWSAData;
  p : PHostEnt;
  s : array[0..128] of char;
  p2 : pansichar;
  begin
  result:='';
  if WSAStartup($0102, wsaData)<>0 then exit;
  try
    GetHostName(@s, 128);
    p:=GetHostByName(@s);
    p2 := iNet_ntoa(PInAddr(p^.h_addr_list^)^);
    Result:=Format('%s',[p2]);
  finally
    WSACleanup;
  end;
  end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDProtocol.SetDummyBoolean(const Value: Boolean);
begin
end;

{ --------------------------------- protected -------------------------------- }

function TLMDProtocol.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDProtocol.RegisterProperties;
begin
  FPropertiesDesc.Clear;
  FPropertiesDesc.Add(cpidInstalled, sLMDSysProtocolPropTitleInstalled, sLMDSysProtocolPropDescInstalled);
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDProtocol.Create(aNetworkCard: TLMDNetworkCard);
begin
  inherited Create;
  FNetworkCard:= aNetworkCard;
  FPropertiesDesc := TLMDSysPropertiesDesc.Create;
  // RM
  RegisterProperties;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDProtocol.Destroy;
begin
  FPropertiesDesc.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDProtocol.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;
  FPropertiesDesc.PropertyByID(cpidInstalled).Text := BoolToStr(FInstalled);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDProtocol.AfterConstruction;
begin
  inherited;
//  InterlockedDecrement(FRefCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDProtocol.BeforeDestruction;
begin
  inherited;
//  if RefCount <> 0 then RunError(204);
  if RefCount > 1 then RunError(204);
end;

{ ---------------------------------------------------------------------------- }
class function TLMDProtocol.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TLMDProtocol(Result).FRefCount := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetElementTitle : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetElementDescription : string;
begin
  result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetElementType : TLMDSysInfoType;
begin
  result := itUnknown;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetPropertiesCount: integer;
begin
  result := FPropertiesDesc.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetPropAvailability(index : integer) : boolean;
begin
  result := False;
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Available;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetPropType(index : integer) : TLMDSysPropertyType;
begin
  result := ptUnknown;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetPropValue(index : integer) : variant;
begin
  result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetPropText(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Text;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetPropTitle(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Title;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProtocol.GetPropDescription(index : integer) : string;
begin
  result := '';
  if (index < 0) or (index >= FPropertiesDesc.count) then Exit;
  result := FPropertiesDesc[index].Description;
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDTCPIP.SetDummyString(const Value: String);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDTCPIP.SetDummyBool(const Value: Boolean);
begin
end;

function TLMDTCPIP.GetCSIPAddress(): string;
begin
  Result := StringToCommaText(FIPAddress);
end;

function TLMDTCPIP.GetCSIPSubnetMask(): string;
begin
  Result := StringToCommaText(FIPSubnetMask);
end;

function TLMDTCPIP.GetCSDefaultGateWay: string;
begin
  Result := StringToCommaText(FDefaultGateway)
end;
{ --------------------------------- protected -------------------------------- }
procedure TLMDTCPIP.RegisterProperties;
begin
  inherited;
  if LMDSIWindowsNT then
    FPropertiesDesc.Add(cpidDHCPEnabled, sLMDSysTCPIPPropTitleDHCPEnabled, sLMDSysTCPIPPropDescDHCPEnabled);
  FPropertiesDesc.Add(cpidIPAddress, sLMDSysTCPIPPropTitleIPAddress, sLMDSysTCPIPPropDescIPAddress);
  if LMDSIWindowsNT then
    begin
      FPropertiesDesc.Add(cpidIPSubnetMask, sLMDSysTCPIPPropTitleIPSubnetMask, sLMDSysTCPIPPropDescIPSubnetMask);
      FPropertiesDesc.Add(cpidDefaultGateway, sLMDSysTCPIPPropTitleDefaultGateway, sLMDSysTCPIPPropDescDefaultGateway);
    end;
end;

{ --------------------------------- public ----------------------------------- }
procedure TLMDTCPIP.Refresh;
begin
  inherited;
  if LMDSIWindowsNT then
    FPropertiesDesc.PropertyByID(cpidDHCPEnabled).Text := BoolToStr(FDHCPEnabled);
  FPropertiesDesc.PropertyByID(cpidIPAddress).Text := FIPAddress;
  if LMDSIWindowsNT then
    begin
      FPropertiesDesc.PropertyByID(cpidIPSubnetMask).Text := FIPSubnetMask;
      FPropertiesDesc.PropertyByID(cpidDefaultGateway).Text := FDefaultGateway;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTCPIP.GetElementTitle : string;
begin
  result := sLMDSysTCPIPTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTCPIP.GetElementDescription : string;
begin
  result := sLMDSysTCPIPDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTCPIP.GetElementType : TLMDSysInfoType;
begin
  result := itTCPIP;
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDIPX.SetDummyString(const Value: String);
begin
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDIPX.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidNetworkNumber, sLMDSysIPXPropTitleNetworkNumber, sLMDSysIPXPropDescNetworkNumber);
end;

{ --------------------------------- public ----------------------------------- }
procedure TLMDIPX.Refresh;
begin
  inherited;
  FPropertiesDesc.PropertyByID(cpidNetworkNumber).Text := FNetworkNumber;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIPX.GetElementTitle : string;
begin
  result := sLMDSysIPXTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIPX.GetElementDescription : string;
begin
  result := sLMDSysIPXDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIPX.GetElementType : TLMDSysInfoType;
begin
  result := itIPX;
end;

{ **************************************************************************** }
{ --------------------------------- public ----------------------------------- }
function TLMDNetBEUI.GetElementTitle : string;
begin
  result := sLMDSysNetBEUITitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNetBEUI.GetElementDescription : string;
begin
  result := sLMDSysNetBEUIDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNetBEUI.GetElementType : TLMDSysInfoType;
begin
  result := itNetBEUI;
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
{procedure TLMDSysNetworkObject.SetDummyStrings(const Value: TStrings);
begin
end;
{ ---------------------------------------------------------------------------- }
function TLMDSysNetworkObject.GetList: TStringList;
begin
  if FIPList.Count=0 then
     LMDSysGetLocalIPs(FIPList);
  result:=FIPList;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysNetworkObject.SetDummyString(const Value: String);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysNetworkObject.SetDummyCards(const Value: TLMDNetworkCards);
begin
end;

const
  npidUsername=0;
  npidComputerName=1;

{ --------------------------- protected -------------------------------------- }
procedure TLMDSysNetworkObject.RegisterProperties;
begin
  FPropertiesDesc.Clear;
  FPropertiesDesc.Add(npidUsername, sLMDSysNetUserNameTitle, sLMDSysNetUserNameDesc);
  FPropertiesDesc.Add(npidComputerName, sLMDSysNetComputerNameTitle, sLMDSysNetComputerNameDesc);
end;
{ --------------------------------- public ----------------------------------- }
constructor TLMDSysNetworkObject.Create;
begin
  inherited;
  FIPList:=TStringList.Create;
  FNetworkCards:= TLMDNetworkCards.Create(nil);
  FNetworkCards.OnChangeLog:= DoLog;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysNetworkObject.Destroy;
begin
  FIPList.Free;
  FNetworkCards.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysNetworkObject.Init;
begin
  inherited Init;
  FUserName:= LMDSIUserName;
  FComputerName:=LMDSIComputerName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysNetworkObject.Refresh;
begin
  DoProgress(sLMDSysNetworkTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;
  if not FInit then Init;
  FNetworkCards.Refresh;
  DoProgress(sLMDSysNetworkTitle, 100, 90);
  FPropertiesDesc.PropertyByID(npidUserName).Text := FUserName;
  FPropertiesDesc.PropertyByID(npidComputerName).Text := FComputerName;
  DoProgress(sLMDSysNetworkTitle, 100, 100);
  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysNetworkObject.Apply;
begin
  FNetworkCards.Apply;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysNetworkObject.GetElementTitle : string;
begin
  result := sLMDSysNetworkTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysNetworkObject.GetElementDescription : string;
begin
  result := sLMDSysNetworkDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysNetworkObject.GetElementType : TLMDSysInfoType;
begin
  result := itNetwork;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysNetworkObject.GetElementCount : integer;
begin
  result := 1;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysNetworkObject.GetElement(index : integer) : TObject;
begin
  result := TObject(FNetworkCards);
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDNetworkCard.SetDummyIPX(const Value: TLMDIPX);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNetworkCard.SetDummyNetBEUI(const Value: TLMDNetBEUI);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNetworkCard.SetDummyString(const Value: String);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNetworkCard.SetDummyTCPIP(const Value: TLMDTCPIP);
begin
end;

const
  npidServicename=0;
  npidDescription=1;

{ ---------------------------------------------------------------------------- }
procedure TLMDNetworkCard.RegisterProperties;
begin
  FPropertiesDesc.Clear;
  FPropertiesDesc.Add(npidDescription, sLMDSysNetDescriptionTitle, sLMDSysNetDescriptionDesc);
  if LMDSIWindowsNT then
    FPropertiesDesc.Add(npidServicename, sLMDSysNetServiceNameTitle, sLMDSysNetServiceNameDesc);
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDNetworkCard.Create;
begin
  inherited;
  FTCPIP:= TLMDTCPIP.Create(Self);
  FIPX:= TLMDIPX.Create(Self);
  FNetBEUI:= TLMDNetBEUI.Create(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDNetworkCard.Destroy;
begin
  FNetBEUI.Free;
  FIPX.Free;
  FTCPIP.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNetworkCard.Refresh;

  function GetValue( R: TRegistry; aKey: String): String;
  var
    Len: Integer;
    DataType: Integer;
    begin
    Len:= R.GetDataSize( aKey);
    if len > 0 then
      begin
        SetString(Result, nil, Len);
        DataType := REG_NONE;
        RegQueryValueEx(R.CurrentKey, PChar(aKey), nil, @DataType, PByte(Result), @Len);
        end;
  end;

  function ValueHere( R: TRegistry; aKey, aValue: String): Boolean;
  var
    Len, I: Integer;
    S: String;
    DataType: Integer;
    begin
    result:=false;
    Len:= R.GetDataSize( aKey);
    if len > 0 then
      begin
        SetString(S, nil, Len);
        DataType := REG_NONE;
        RegQueryValueEx(R.CurrentKey, PChar(aKey), nil, @DataType, PByte(S), @Len);
        for I:= 1 to Len - 2 do
          if S[i] = #0 then S[i]:= ' ';
        Result:= Pos( aValue, S) > 0;
      end;
  end;

const
  nwc_9X='\System\CurrentControlSet\Services\Class\NetTrans';

var
  R: TRegistry;
  S: TStringList;
  I: LongInt;
  tmp:String;
begin
  FPropertiesDesc.InvalidateProperties;
  FPropertiesDesc.PropertyByID(npidDescription).Text := FDescription;

  R:= TRegistry.Create(KEY_READ);
  if LMDSIWindowsNT then
    try
      FPropertiesDesc.PropertyByID(npidServiceName).Text := FServiceName;
      R.RootKey:= HKEY_LOCAL_MACHINE;
      R.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Services\' + FServiceName + '\Parameters');
      if R.KeyExists('Tcpip') then
        begin
          FTCPIP.FInstalled:= true;

          R.OpenKeyReadOnly('Tcpip');
          FTCPIP.FDHCPEnabled:= R.ReadBool('EnableDHCP');
          if FTCPIP.FDHCPEnabled then
            begin
              FTCPIP.FIPSubnetMask:= GetValue( R, 'DhcpSubnetMask');
              FTCPIP.FIPAddress:= GetValue( R, 'DhcpIPAddress');
              FTCPIP.FDefaultGateway:= GetValue( R, 'DhcpDefaultGateway');
            end
          else
            begin
              FTCPIP.FIPSubnetMask:= GetValue( R, 'SubnetMask');
              FTCPIP.FIPAddress:= GetValue( R, 'IPAddress');
              FTCPIP.FDefaultGateway:= GetValue( R, 'DefaultGateway');
            end;
          R.CloseKey;
        end;
      R.CloseKey;
      R.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Services\Nbf\Linkage');
      FNetBEUI.FInstalled:= ValueHere(R, 'Bind', FServiceName);
      R.CloseKey;
      R.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Services\NwlnkIpx\Linkage');
      FIPX.FInstalled:= ValueHere(R, 'Bind', FServiceName);
      R.CloseKey;
      if FIPX.FInstalled then
        begin
          R.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Services\NwlnkIpx\Parameters\Adapters\' + FServiceName);
          FIPX.FNetworkNumber:= GetValue( R, 'NetworkNumber');
          R.CloseKey;
        end;
    finally
      R.Free;
    end
  else
    try
      S:=TStringList.Create;
      R.RootKey:= HKEY_LOCAL_MACHINE;
      R.OpenKeyReadOnly(nwc_9x);
      R.GetKeyNames(S);
      for i:= 0 to S.Count-1 do
        begin
          R.OpenKeyReadOnly(nwc_9x+'\' + S[i]+'\Ndi');
          tmp:=R.ReadString('DeviceID');
          R.CloseKey;
          if (not FTCPIP.FInstalled) and (tmp='MSTCP') then
            begin
              FTCPIP.FInstalled:= true;
              FTCPIP.FIPAddress:=LMDSysGetLocalIP;
            end;
          if tmp='NETBEUI' then
            FNetBEUI.FInstalled:=True;
          if tmp='NWLINK' then
            begin
              FIPX.FInstalled:=True;
              R.OpenKeyReadOnly(nwc_9x+'\' + S[i]);
              FIPX.FNetworkNumber:= GetValue( R, 'Network_Id');
              R.CloseKey;
           end;
        end;
    finally
      R.Free;
    end;

  FTCPIP.Refresh;
  FIPX.Refresh;
  FNetBEUI.Refresh;

end;

{------------------------------------------------------------------------------}
function TLMDNetworkCard.GetElementTitle : string;
begin
  result := sLMDSysNetworkCardTitle;
end;

{------------------------------------------------------------------------------}
function TLMDNetworkCard.GetElementDescription : string;
begin
  result := sLMDSysNetworkCardDesc;
end;

{------------------------------------------------------------------------------}
function TLMDNetworkCard.GetElementType : TLMDSysInfoType;
begin
  result := itNetworkCard;
end;

{------------------------------------------------------------------------------}
function TLMDNetworkCard.GetElementCount : integer;
begin
  result := 3;
end;

{------------------------------------------------------------------------------}
function TLMDNetworkCard.GetElement(index : integer) : TObject;
begin
  case index of
    0 : result := TObject(FTCPIP);
    1 : result := TObject(FNetBEUI);
    2 : result := TObject(FIPX);
  else
    result:=nil;
  end;
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
function TLMDNetworkCards.GetItem(Index: Integer): TLMDNetworkCard;
begin
  Result:= TLMDNetworkCard(inherited GetItem(Index))
end;

{ ---------------------------------------------------------------------------- }
function TLMDNetworkCards.GetOwner: TPersistent;
begin
  Result:= FOwner;
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDNetworkCards.Create(aOwner: TComponent);
begin
  inherited Create(TLMDNetworkCard);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDNetworkCards.Destroy;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDNetworkCards.Add: TLMDNetworkCard;
begin
  Result:= TLMDNetworkCard(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDNetworkCards.Refresh;
var
  R: TRegistry;
  S: TStringList;
  I: LongInt;
const
  nwc_NT='\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards';
  nwc_9X='\System\CurrentControlSet\Services\Class\Net';
begin
  //<-- VB Feb 2006
  Clear;
  //-->
  DoProgress(sLMDSysNetworkCardGroupTitle, 100, 0);
  R:= TRegistry.Create(KEY_READ);
  S:= TStringList.Create;
  try
    R.RootKey:= HKEY_LOCAL_MACHINE;
    if LMDSIWindowsNT then
      begin
        R.OpenKeyReadOnly(nwc_NT);
        R.GetKeyNames(S);
        for I:= 0 to S.Count - 1 do
          begin
            DoProgress(sLMDSysNetworkCardGroupTitle, 100, Round(i*100/s.count));
            R.OpenKeyReadOnly(nwc_NT + '\'+S[i]);
            if not ( R.ValueExists( 'Hidden') and (R.ReadInteger('Hidden') = 1)) then
              with Add do
                begin
                  FDescription:= R.ReadString( 'Description');
                  FServiceName:= R.ReadString( 'ServiceName');
                  Refresh;
                end;
            R.CloseKey;
          end
        end
      else
        begin
        R.OpenKeyReadOnly(nwc_9x);
        R.GetKeyNames(S);
        for I:= 0 to S.Count - 1 do
          begin
            DoProgress(sLMDSysNetworkCardGroupTitle, 100, Round(i*100/s.count));
            R.OpenKeyReadOnly(nwc_9x+'\' + S[i]);
            if not ( R.ValueExists( 'Hidden') and (R.ReadInteger('Hidden') = 1)) then
              with Add do
                begin
                  FDescription:= R.ReadString( 'DriverDesc');
                  FServiceName:= '';
                  Refresh;
                end;
            R.CloseKey;
          end
        end;
    R.CloseKey;
  finally
    R.Free;
    S.Free;
  end;
  DoProgress('', 100, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDNetworkCards.SetItem(Index: Integer; Value: TLMDNetworkCard);
begin
  inherited SetItem( Index, Value);
end;

{------------------------------------------------------------------------------}
function TLMDNetworkCards.GetElementTitle : string;
begin
  result := sLMDSysNetworkCardGroupTitle;
end;

{------------------------------------------------------------------------------}
function TLMDNetworkCards.GetElementDescription : string;
begin
  result := sLMDSysNetworkCardGroupDesc;
end;

{------------------------------------------------------------------------------}
function TLMDNetworkCards.GetElementType : TLMDSysInfoType;
begin
  result := itNetworkCardGroup;
end;

end.
