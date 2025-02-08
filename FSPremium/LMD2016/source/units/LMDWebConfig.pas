unit LMDWebConfig;
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

LMDWebConfig unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, LMDURLSupp, URLMon, LMDWebbase, IniFiles, Registry;

type

  { **************************TLMDMasterWebComponent**************************** }
  TLMDMasterWebComponent = class(TLMDWebComponent)
  public
    procedure UpdateFromConfig; virtual; abstract;
  end;

  { **************************TLMDWebConfig**************************** }
  TLMDWebConfig = class(TLMDWebComponent)
  private
    FReferer: string;
    FURL: string;
    FUserName: string;
    FPassword: string;
    FAcceptTypes: TStringList;
    FMasterComponent: TLMDMasterWebComponent;
    FInternetOptions: TLMDInternetOptions;
    FPostParams: TStringList;
    procedure SendUpdate;
    procedure SetAcceptTypes(const Value: TStringList);
    procedure SetPassword(const Value: string);
    procedure SetReferer(const Value: string);
    procedure SetURL(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetMasterComponent(const Value: TLMDMasterWebComponent);
    procedure SetInternetOptions(const Value: TLMDInternetOptions);
    procedure SetPostParams(const Value: TStringList);
    function GetOnInteractiveEvent: TLMDInternetOptionsInteractiveEvent;
    procedure SetOnInteractiveEvent(
      const Value: TLMDInternetOptionsInteractiveEvent);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SaveToIniFile(FileName: String);
    procedure LoadFromIniFile(FileName: String);
    procedure SaveToRegistry(RegistryPath: String);
    procedure LoadFromRegistry(RegistryPath: String);
    property MasterComponent: TLMDMasterWebComponent read FMasterComponent write
      SetMasterComponent;
  published
    property AcceptTypes: TStringList read FAcceptTypes write SetAcceptTypes
      stored true;
    property URL: string read FURL write SetURL;
    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write SetPassword;
    property Referer: string read FReferer write SetReferer;
    property PostParams: TStringList read FPostParams write SetPostParams;
    property InternetOptions: TLMDInternetOptions read FInternetOptions write
      SetInternetOptions;
    property OnInteractiveEvent:TLMDInternetOptionsInteractiveEvent read GetOnInteractiveEvent write SetOnInteractiveEvent;
  end;

implementation

const
  GeneralSection = 'WebConfig';
  OptionsSection = 'InternetOptions';

{ **************************TLMDWebConfig**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.Assign(Source: TPersistent);
var
  LSWebConfig: TLMDWebConfig;
begin
  if Source is TLMDWebConfig then
    begin
      LSWebConfig := TLMDWebConfig(Source);
      Self.AcceptTypes.Assign(LSWebConfig.AcceptTypes);
      Self.URL := LSWebConfig.URL;
      Self.UserName := LSWebConfig.UserName;
      Self.Password := LSWebConfig.Password;
      Self.Referer := LSWebConfig.Referer;
      Self.PostParams.Assign(LSWebConfig.PostParams);
      Self.InternetOptions.Assign(LSWebConfig.InternetOptions);
    end
  else
    inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SaveToIniFile(FileName: String);
var
  IniFile: TIniFile;
  i: integer;
begin
  IniFile := TIniFile.Create(FileName);
  try
    IniFile.WriteInteger(GeneralSection, 'AcceptTypesCount', AcceptTypes.Count);
    for i := 0 to AcceptTypes.Count - 1 do
     IniFile.WriteString(GeneralSection, 'AcceptTypes_' + IntToStr(i),
      AcceptTypes[i]);
    IniFile.WriteString(GeneralSection, 'URL', URL);
    IniFile.WriteString(GeneralSection, 'UserName', UserName);
    IniFile.WriteString(GeneralSection, 'Password', Password);
    IniFile.WriteString(GeneralSection, 'Referer', Referer);
    IniFile.WriteInteger(GeneralSection, 'PostParamsCount', PostParams.Count);
    for i := 0 to PostParams.Count - 1 do
     IniFile.WriteString(GeneralSection, 'PostParams_' + IntToStr(i),
      PostParams[i]);
    IniFile.WriteInteger(OptionsSection, 'PathListCount',
     InternetOptions.PathList.Count);
    for i := 0 to InternetOptions.PathList.Count - 1 do
     IniFile.WriteString(OptionsSection, 'PathList_' + IntToStr(i),
      InternetOptions.PathList[i]);
    IniFile.WriteInteger(OptionsSection, 'ConnectRetries',
     InternetOptions.ConnectRetries);
    IniFile.WriteInteger(OptionsSection, 'ConnectTimeout',
     InternetOptions.ConnectTimeout);
    IniFile.WriteInteger(OptionsSection, 'DataTimeout',
     InternetOptions.DataTimeout);
    IniFile.WriteBool(OptionsSection, 'UseProxy', InternetOptions.UseProxy);
    IniFile.WriteBool(OptionsSection, 'SocksProxy', InternetOptions.SocksProxy);
    case InternetOptions.SocksVersion of
      sv4:  IniFile.WriteInteger(OptionsSection, 'SocksVersion', 0);
      sv4A: IniFile.WriteInteger(OptionsSection, 'SocksVersion', 1);
      sv5:  IniFile.WriteInteger(OptionsSection, 'SocksVersion', 2);
    end;
    IniFile.WriteString(OptionsSection, 'ProxyName', InternetOptions.ProxyName);
    IniFile.WriteInteger(OptionsSection, 'ProxyPort',
     InternetOptions.ProxyPort);
    IniFile.WriteBool(OptionsSection, 'UseProxyAuth',
     InternetOptions.UseProxyAuth);
    IniFile.WriteString(OptionsSection, 'ProxyUserName',
     InternetOptions.ProxyUserName);
    IniFile.WriteString(OptionsSection, 'ProxyPassword',
     InternetOptions.ProxyPassword);
    IniFile.WriteString(OptionsSection, 'UserAgent', InternetOptions.UserAgent);
    IniFile.WriteBool(OptionsSection, 'UseDefaultOptions',
     InternetOptions.UseDefaultOptions);
    IniFile.WriteInteger(OptionsSection, 'ServerThreads',
     InternetOptions.ServerThreads);
    IniFile.WriteBool(OptionsSection, 'ModemConnection',
     InternetOptions.ModemConnection);
    IniFile.WriteBool(OptionsSection, 'UseDefaultBrowser',
     InternetOptions.UseDefaultBrowser);
    IniFile.WriteBool(OptionsSection, 'AutoDial', InternetOptions.AutoDial);
    IniFile.WriteBool(OptionsSection, 'AutoClose', InternetOptions.AutoClose);
    IniFile.WriteBool(OptionsSection, 'ForceInternetCheck',
     InternetOptions.ForceInternetCheck);
    IniFile.WriteBool(OptionsSection, 'UseIEDUNSettings',
     InternetOptions.UseIEDUNSettings);
    IniFile.WriteString(OptionsSection, 'DUN', InternetOptions.DUN);
  finally
    FreeAndNil(IniFile);
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.LoadFromIniFile(FileName: String);
var
  IniFile: TIniFile;
  Count, i: integer;
begin
  IniFile := TIniFile.Create(FileName);
  try
    if IniFile.SectionExists(GeneralSection) then
    begin
      AcceptTypes.Clear;
      Count := IniFile.ReadInteger(GeneralSection, 'AcceptTypesCount', 0);
      for i := 0 to Count - 1 do
       AcceptTypes.Add(IniFile.ReadString(GeneralSection, 'AcceptTypes_' +
        IntToStr(i), ''));
      URL := IniFile.ReadString(GeneralSection, 'URL', '');
      UserName := IniFile.ReadString(GeneralSection, 'UserName', '');
      Password := IniFile.ReadString(GeneralSection, 'Password', '');
      Referer := IniFile.ReadString(GeneralSection, 'Referer', '');
      Count := IniFile.ReadInteger(GeneralSection, 'PostParamsCount', 0);
      PostParams.Clear;
      for i := 0 to Count - 1 do
       PostParams.Add(IniFile.ReadString(GeneralSection, 'PostParams_' +
        IntToStr(i), ''));
    end;
    if IniFile.SectionExists(OptionsSection) then
    begin
      InternetOptions.PathList.Clear;
      Count := IniFile.ReadInteger(OptionsSection, 'PathListCount', 0);
      for i := 0 to Count - 1 do
       InternetOptions.PathList.Add(IniFile.ReadString(OptionsSection,
        'PathList_' + IntToStr(i), ''));
      InternetOptions.ConnectRetries := IniFile.ReadInteger(OptionsSection,
       'ConnectRetries', 2);
      InternetOptions.ConnectTimeout := IniFile.ReadInteger(OptionsSection,
       'ConnectTimeout', 30);
      InternetOptions.DataTimeout := IniFile.ReadInteger(OptionsSection,
       'DataTimeout', 0);
      InternetOptions.UseProxy := IniFile.ReadBool(OptionsSection, 'UseProxy',
       False);
      InternetOptions.SocksProxy := IniFile.ReadBool(OptionsSection,
       'SocksProxy', True);
      Count := IniFile.ReadInteger(OptionsSection, 'SocksVersion', 0);
      case Count of
        0: InternetOptions.SocksVersion := sv4;
        1: InternetOptions.SocksVersion := sv4a;
        2: InternetOptions.SocksVersion := sv5;
      end;
      InternetOptions.ProxyName := IniFile.ReadString(OptionsSection,
       'ProxyName', '');
      InternetOptions.ProxyPort := IniFile.ReadInteger(OptionsSection,
       'ProxyPort', 0);
      InternetOptions.UseProxyAuth := IniFile.ReadBool(OptionsSection,
       'UseProxyAuth', True);
      InternetOptions.ProxyUserName := IniFile.ReadString(OptionsSection,
       'ProxyUserName', '');
      InternetOptions.ProxyPassword := IniFile.ReadString(OptionsSection,
       'ProxyPassword', '');
      InternetOptions.UserAgent := IniFile.ReadString(OptionsSection,
       'UserAgent', '');
      InternetOptions.UseDefaultOptions := IniFile.ReadBool(OptionsSection,
       'UseDefaultOptions', False);
      InternetOptions.ServerThreads := IniFile.ReadInteger(OptionsSection,
       'ServerThreads', 4);
      InternetOptions.ModemConnection := IniFile.ReadBool(OptionsSection,
       'ModemConnection', True);
      InternetOptions.UseDefaultBrowser := IniFile.ReadBool(OptionsSection,
       'UseDefaultBrowser', True);
      InternetOptions.AutoDial := IniFile.ReadBool(OptionsSection, 'AutoDial',
       True);
      InternetOptions.AutoClose := IniFile.ReadBool(OptionsSection, 'AutoClose',
       True);
      InternetOptions.ForceInternetCheck := IniFile.ReadBool(OptionsSection,
       'ForceInternetCheck', False);
      InternetOptions.UseIEDUNSettings := IniFile.ReadBool(OptionsSection,
       'UseIEDUNSettings', True);
      InternetOptions.DUN := IniFile.ReadString(OptionsSection, 'DUN', '');
    end;
  finally
    FreeAndNil(IniFile);
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SaveToRegistry(RegistryPath: String);
var
  Registry: TRegistry;
  i: integer;
begin
  if Trim(RegistryPath) = '' then exit;
  if RegistryPath[Length(RegistryPath)] = '\' then
   RegistryPath := copy(RegistryPath, 1, length(RegistryPath) - 1);
  Registry := TRegistry.Create;
  try
    if Registry.OpenKey(RegistryPath + '\' + GeneralSection, True) then
    begin
      Registry.WriteInteger('AcceptTypesCount', AcceptTypes.Count);
      for i := 0 to AcceptTypes.Count - 1 do
       Registry.WriteString('AcceptTypes_' + IntToStr(i), AcceptTypes[i]);
      Registry.WriteString('URL', URL);
      Registry.WriteString('UserName', UserName);
      Registry.WriteString('Password', Password);
      Registry.WriteString('Referer', Referer);
      Registry.WriteInteger('PostParamsCount', PostParams.Count);
      for i := 0 to PostParams.Count - 1 do
       Registry.WriteString('PostParams_' + IntToStr(i), PostParams[i]);
      Registry.CloseKey;
    end;

    if Registry.OpenKey(RegistryPath + '\' + OptionsSection, True) then
    begin
      Registry.WriteInteger('PathListCount', InternetOptions.PathList.Count);
      for i := 0 to InternetOptions.PathList.Count - 1 do
       Registry.WriteString('PathList_' + IntToStr(i),
        InternetOptions.PathList[i]);
      Registry.WriteInteger('ConnectRetries', InternetOptions.ConnectRetries);
      Registry.WriteInteger('ConnectTimeout', InternetOptions.ConnectTimeout);
      Registry.WriteInteger('DataTimeout', InternetOptions.DataTimeout);
      Registry.WriteBool('UseProxy', InternetOptions.UseProxy);
      Registry.WriteBool('SocksProxy', InternetOptions.SocksProxy);
      case InternetOptions.SocksVersion of
        sv4:  Registry.WriteInteger('SocksVersion', 0);
        sv4A: Registry.WriteInteger('SocksVersion', 1);
        sv5:  Registry.WriteInteger('SocksVersion', 2);
      end;
      Registry.WriteString('ProxyName', InternetOptions.ProxyName);
      Registry.WriteInteger('ProxyPort', InternetOptions.ProxyPort);
      Registry.WriteBool('UseProxyAuth', InternetOptions.UseProxyAuth);
      Registry.WriteString('ProxyUserName', InternetOptions.ProxyUserName);
      Registry.WriteString('ProxyPassword', InternetOptions.ProxyPassword);
      Registry.WriteString('UserAgent', InternetOptions.UserAgent);
      Registry.WriteBool('UseDefaultOptions',
       InternetOptions.UseDefaultOptions);
      Registry.WriteInteger('ServerThreads', InternetOptions.ServerThreads);
      Registry.WriteBool('ModemConnection', InternetOptions.ModemConnection);
      Registry.WriteBool('UseDefaultBrowser',
       InternetOptions.UseDefaultBrowser);
      Registry.WriteBool('AutoDial', InternetOptions.AutoDial);
      Registry.WriteBool('AutoClose', InternetOptions.AutoClose);
      Registry.WriteBool('ForceInternetCheck',
       InternetOptions.ForceInternetCheck);
      Registry.WriteBool('UseIEDUNSettings', InternetOptions.UseIEDUNSettings);
      Registry.WriteString('DUN', InternetOptions.DUN);
      Registry.CloseKey;
    end;
  finally
    FreeAndNil(Registry);
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.LoadFromRegistry(RegistryPath: String);
var
  Registry: TRegistry;
  i, Count: integer;
begin
  if Trim(RegistryPath) = '' then exit;
  if RegistryPath[Length(RegistryPath)] = '\' then
   RegistryPath := copy(RegistryPath, 1, length(RegistryPath) - 1);
  Registry := TRegistry.Create;
  try
    if Registry.OpenKey(RegistryPath + '\' + GeneralSection, False) then
    begin
      AcceptTypes.Clear;
      if Registry.ValueExists('AcceptTypesCount') then
       Count := Registry.ReadInteger('AcceptTypesCount') else
       Count := 0;
      for i := 0 to Count - 1 do
       if Registry.ValueExists('AcceptTypes_' + IntToStr(i)) then
       AcceptTypes.Add(Registry.ReadString('AcceptTypes_' + IntToStr(i)));
      if Registry.ValueExists('URL') then
       URL := Registry.ReadString('URL') else
       URL := '';
      if Registry.ValueExists('UserName') then
       UserName := Registry.ReadString('UserName') else
       UserName := '';
      if Registry.ValueExists('Password') then
       Password := Registry.ReadString('Password') else
       Password := '';
      if Registry.ValueExists('Referer') then
       Referer := Registry.ReadString('Referer') else
       Referer := '';
      if Registry.ValueExists('PostParamsCount') then
       Count := Registry.ReadInteger('PostParamsCount') else
       Count := 0;
      PostParams.Clear;
      for i := 0 to Count - 1 do
       if Registry.ValueExists('PostParams_' + IntToStr(i)) then
        PostParams.Add(Registry.ReadString('PostParams_' + IntToStr(i)));
      Registry.CloseKey;
    end;

    if Registry.OpenKey(RegistryPath + '\' + OptionsSection, False) then
    begin
      InternetOptions.PathList.Clear;
      if Registry.ValueExists('PathListCount') then
       Count := Registry.ReadInteger('PathListCount') else
       Count := 0;
      for i := 0 to Count - 1 do
       if Registry.ValueExists('PathList_' + IntToStr(i)) then
        InternetOptions.PathList.Add(Registry.ReadString('PathList_' +
         IntToStr(i)));
      if Registry.ValueExists('ConnectRetries') then
       InternetOptions.ConnectRetries := Registry.ReadInteger('ConnectRetries')
        else InternetOptions.ConnectRetries := 2;
      if Registry.ValueExists('ConnectTimeout') then
       InternetOptions.ConnectTimeout := Registry.ReadInteger('ConnectTimeout')
        else InternetOptions.ConnectTimeout := 30;
      if Registry.ValueExists('DataTimeout') then
       InternetOptions.DataTimeout := Registry.ReadInteger('DataTimeout') else
       InternetOptions.DataTimeout := 0;
      if Registry.ValueExists('UseProxy') then
       InternetOptions.UseProxy := Registry.ReadBool('UseProxy') else
       InternetOptions.UseProxy := False;
      if Registry.ValueExists('SocksProxy') then
       InternetOptions.SocksProxy := Registry.ReadBool('SocksProxy') else
       InternetOptions.SocksProxy := True;
      if Registry.ValueExists('SocksVersion') then
       Count := Registry.ReadInteger('SocksVersion') else Count := 0;
      case Count of
        0: InternetOptions.SocksVersion := sv4;
        1: InternetOptions.SocksVersion := sv4a;
        2: InternetOptions.SocksVersion := sv5;
      end;
      if Registry.ValueExists('ProxyName') then
       InternetOptions.ProxyName := Registry.ReadString('ProxyName') else
       InternetOptions.ProxyName := '';
      if Registry.ValueExists('ProxyPort') then
       InternetOptions.ProxyPort := Registry.ReadInteger('ProxyPort') else
       InternetOptions.ProxyPort := 0;
      if Registry.ValueExists('UseProxyAuth') then
       InternetOptions.UseProxyAuth := Registry.ReadBool('UseProxyAuth') else
       InternetOptions.UseProxyAuth := True;
      if Registry.ValueExists('ProxyUserName') then
       InternetOptions.ProxyUserName := Registry.ReadString('ProxyUserName')
        else InternetOptions.ProxyUserName := '';
      if Registry.ValueExists('ProxyPassword') then
       InternetOptions.ProxyPassword := Registry.ReadString('ProxyPassword')
        else InternetOptions.ProxyPassword := '';
      if Registry.ValueExists('UserAgent') then
       InternetOptions.UserAgent := Registry.ReadString('UserAgent') else
       InternetOptions.UserAgent := '';
      if Registry.ValueExists('UseDefaultOptions') then
       InternetOptions.UseDefaultOptions :=
        Registry.ReadBool('UseDefaultOptions') else
       InternetOptions.UseDefaultOptions := False;
      if Registry.ValueExists('ServerThreads') then
       InternetOptions.ServerThreads := Registry.ReadInteger('ServerThreads')
        else InternetOptions.ServerThreads := 4;
      if Registry.ValueExists('ModemConnection') then
       InternetOptions.ModemConnection := Registry.ReadBool('ModemConnection')
        else InternetOptions.ModemConnection := True;
      if Registry.ValueExists('UseDefaultBrowser') then
       InternetOptions.UseDefaultBrowser :=
        Registry.ReadBool('UseDefaultBrowser') else
        InternetOptions.UseDefaultBrowser := True;
      if Registry.ValueExists('AutoDial') then
       InternetOptions.AutoDial := Registry.ReadBool('AutoDial') else
       InternetOptions.AutoDial := True;
      if Registry.ValueExists('AutoClose') then
       InternetOptions.AutoClose := Registry.ReadBool('AutoClose') else
       InternetOptions.AutoClose := True;
      if Registry.ValueExists('ForceInternetCheck') then
       InternetOptions.ForceInternetCheck :=
        Registry.ReadBool('ForceInternetCheck') else
       InternetOptions.ForceInternetCheck := True;
      if Registry.ValueExists('UseIEDUNSettings') then
       InternetOptions.UseIEDUNSettings := Registry.ReadBool('UseIEDUNSettings')
        else InternetOptions.UseIEDUNSettings := True;
      if Registry.ValueExists('DUN') then
       InternetOptions.DUN := Registry.ReadString('DUN') else
       InternetOptions.DUN := '';
      Registry.CloseKey;
    end;
  finally
    FreeAndNil(Registry);
  end;
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebConfig.Create(AOwner: TComponent);
begin
  inherited;
  FInternetOptions:= TLMDInternetOptions.Create;
  FAcceptTypes:= TStringList.Create;
  FPostParams:= TStringList.Create;
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebConfig.Destroy;
begin
  FInternetOptions.Free;
  FAcceptTypes.Free;
  FPostParams.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDWebConfig.GetOnInteractiveEvent: TLMDInternetOptionsInteractiveEvent;
begin
  Result := FInternetOptions.OnInteractiveEvent;
end;

procedure TLMDWebConfig.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent <> nil) and (AComponent =
    FMasterComponent) then
    FMasterComponent:= nil;
  inherited;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SendUpdate;
begin
  if FMasterComponent <> nil then
    FMasterComponent.UpdateFromConfig;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SetAcceptTypes(const Value: TStringList);
begin
  FAcceptTypes.Assign(Value);
  SendUpdate;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SetInternetOptions(const Value: TLMDInternetOptions);
begin
  FInternetOptions.Assign(Value);
  SendUpdate;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SetMasterComponent(const Value: TLMDMasterWebComponent);
begin
  if FMasterComponent <> Value then
    begin
      if FMasterComponent <> nil then
        begin
          FMasterComponent.RemoveFreeNotification(Self);
        end;
      FMasterComponent:= Value;
      if FMasterComponent <> nil then
        FMasterComponent.FreeNotification(Self);
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SetOnInteractiveEvent(
  const Value: TLMDInternetOptionsInteractiveEvent);
begin
  FInternetOptions.OnInteractiveEvent := Value;
end;

procedure TLMDWebConfig.SetPassword(const Value: string);
begin
  FPassword:= Value;
  SendUpdate;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SetPostParams(const Value: TStringList);
begin
  FPostParams.Assign(Value);
  SendUpdate;
end;

procedure TLMDWebConfig.SetReferer(const Value: string);
begin
  FReferer:= Value;
  SendUpdate;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SetURL(const Value: string);
begin
  FURL:= Value;
  SendUpdate;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebConfig.SetUserName(const Value: string);
begin
  FUserName:= Value;
  SendUpdate;
end;
end.
