unit LMDSysInternetObject;
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

LMDSysInternetObject unit (JH)
------------------------------
Current Internet settings

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
  LMDSysBase,
  LMDSysConst;

type
  TLMDSysInternetDisplayInfo=(ipidInetBrowser, ipidInetHomePage,ipidInetHTMLEditor,ipidInetEMailClient,
                              ipidInetNewsClient, ipidInetCalendar,ipidInetInetCall,
                              ipidInetContacts, ipidInetTempPath, ipidInetTempMaxSize,
                              ipidInetZones, ipidInetAdvancedProperties);
  TLMDSysInternetDisplayInfos=set of TLMDSysInternetDisplayInfo;

const
  def_TLMDSysInternetDisplayInfos=[ipidInetBrowser, ipidInetHomePage,ipidInetHTMLEditor,ipidInetEMailClient,
                                   ipidInetNewsClient, ipidInetCalendar,ipidInetInetCall,
                                   ipidInetContacts, ipidInetTempPath, ipidInetTempMaxSize,
                                   ipidInetZones, ipidInetAdvancedProperties];

  LMDSysInternetProps:array[TLMDSysInternetDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysInetPropTitleBrowser; Description: sLMDSysInetPropDescBrowser),
    (Name: sLMDSysInetPropTitleHomePage; Description: sLMDSysInetPropDescHomePage),
    (Name: sLMDSysInetPropTitleHTMLEditor; Description: sLMDSysInetPropDescHTMLEditor),
    (Name: sLMDSysInetPropTitleEMailClient; Description: sLMDSysInetPropDescEMailClient),
    (Name: sLMDSysInetPropTitleNewsClient; Description: sLMDSysInetPropDescNewsClient),
    (Name: sLMDSysInetPropTitleCalendar; Description: sLMDSysInetPropDescCalendar),
    (Name: sLMDSysInetPropTitleInetCall; Description: sLMDSysInetPropDescInetCall),
    (Name: sLMDSysInetPropTitleContacts; Description: sLMDSysInetPropDescContacts),
    (Name: sLMDSysInetPropTitlePath; Description: sLMDSysInetPropDescPath),
    (Name: sLMDSysInetPropTitleMaxSize; Description: sLMDSysInetPropDescMaxSize),
    (Name: sLMDSysInetZoneGroupTitle; Description: sLMDSysInetZoneGroupDesc),
    (Name: sLMDSysInetAdvPropGroupTitle; Description: sLMDSysInetAdvPropGroupDesc)
    );

type
  { ************************************************************************** }
  TLMDSysInetAdvProp = class(TLMDSysCollectionItem)
  private
    FValue: Boolean;
    FName: string;
    procedure SetDummyString(const Value: string);
    procedure SetDummyBool(const Value: Boolean);
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property Name: string read FName write SetDummyString stored false;
    property Value: Boolean read FValue write SetDummyBool stored false;
  end;

  TLMDSysInetAdvProps = class(TLMDSysCollection)
  private
    function GetItem(Index: Integer): TLMDSysInetAdvProp;
    procedure SetItem(Index: Integer; const Value: TLMDSysInetAdvProp);
  public
    constructor Create;
    function Add: TLMDSysInetAdvProp;
    function Insert(Index: Integer): TLMDSysInetAdvProp;
    property Items[Index: Integer]: TLMDSysInetAdvProp read GetItem write SetItem;
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  end;

  TLMDSysInetZone = class(TLMDSysCollectionItem)
  private
    FZoneName: string;
    FZoneDescription: string;
    FZoneSites: TStrings;
    procedure SetDummyString(const Value: string);
    procedure SetDummyStrings(const Value: TStrings);
  protected
    procedure RegisterProperties; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property ZoneName: string read FZoneName write SetDummyString stored false;
    property ZoneDescription: string read FZoneDescription write SetDummyString stored false;
    property ZoneSites: TStrings read FZoneSites write SetDummyStrings stored false;
  end;

  TLMDSysInetZones = class(TLMDSysCollection)
  private
    function GetItem(Index: Integer): TLMDSysInetZone;
    procedure SetItem(Index: Integer; const Value: TLMDSysInetZone);
  public
    constructor Create;
    function Add: TLMDSysInetZone;
    function Insert(Index: Integer): TLMDSysInetZone;
    property Items[Index: Integer]: TLMDSysInetZone read GetItem write SetItem; default;
    procedure Refresh;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

  end;

  TLMDSysInternetObject = class(TLMDSysObject, ILMDSysContainer)
  private
    FHomePage: string;
    FZones: TLMDSysInetZones;
    FAdvancedOptions: TLMDSysInetAdvProps;
    FBrowser:String;
    FInetCall: string;
    FCalendar: string;
    FHTMLEditor: string;
    FEMailClient: string;
    FNewsClient: string;
    FContacts: string;
    FDisplayInfo: TLMDSysInternetDisplayInfos;
    FPath: string;
    FMaxSize: LongInt;
    procedure SetDummyZones(const Value: TLMDSysInetZones);
    procedure SetDummayAdvOpt(const Value: TLMDSysInetAdvProps);
    procedure SetDisplayInfo(const Value: TLMDSysInternetDisplayInfos);
    procedure SetDummyString(const Value: string);
    procedure SetDummyInt(const Value: LongInt);
  protected
    procedure RegisterProperties; override;
  public
    procedure Refresh; override;
    procedure Apply; override;
    constructor Create; override;
    destructor Destroy; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    function GetElementCount : integer;
    function GetElement(index : integer) : TObject;

    property AdvancedOptions: TLMDSysInetAdvProps read FAdvancedOptions write SetDummayAdvOpt stored false;
    property Zones: TLMDSysInetZones read FZones write SetDummyZones stored false;
  published
    property Browser:String read FBrowser write SetDummyString stored false;
    property DisplayInfo:TLMDSysInternetDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysInternetDisplayInfos;
    property HomePage: string read FHomePage write SetDummyString stored false;
    property HTMLEditor: string read FHTMLEditor write SetDummyString stored false;
    property EMailClient: string read FEMailClient write SetDummyString stored false;
    property NewsClient: string read FNewsClient write SetDummyString stored false;
    property Calendar: string read FCalendar write SetDummyString stored false;
    property InetCall: string read FInetCall write SetDummyString stored false;
    property Contacts: string read FContacts write SetDummyString stored false;

    property InetTempPath: string read FPath write SetDummyString stored false;
    property InetTempMaxSize: LongInt read FMaxSize write SetDummyInt stored false;
  end;

implementation

uses
  SysUtils, ShlObj, Registry,
  LMDShUtils;

{ **************************************************************************** }
{ ---------------------------- private --------------------------------------- }
procedure TLMDSysInternetObject.SetDummyInt(const Value: LongInt);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInternetObject.SetDummyString(const Value: string);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInternetObject.SetDummyZones(const Value: TLMDSysInetZones);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInternetObject.SetDummayAdvOpt(const Value: TLMDSysInetAdvProps);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInternetObject.SetDisplayInfo(const Value: TLMDSysInternetDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      RegisterProperties;
    end;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDSysInternetObject.RegisterProperties;
var
  i:TLMDSysInternetDisplayInfo;
begin
  FPropertiesDesc.Clear;
  for i:=Low(TLMDSysInternetDisplayInfo) to High(TLMDSysInternetDisplayInfo) do
    if i in FDisplayInfo then
      FPropertiesDesc.Add(Ord(i), LMDSysInternetProps[i].Name, LMDSysInternetProps[i].Description);
end;

{----------------------------- public -----------------------------------------}
constructor TLMDSysInternetObject.Create;
begin
  FDisplayInfo:=def_TLMDSysInternetDisplayInfos;;
  inherited;
  FZones:= TLMDSysInetZones.Create;
  FZones.OnChangeLog:= DoLog;
  FAdvancedOptions:= TLMDSysInetAdvProps.Create;
  FAdvancedOptions.OnChangeLog:= DoLog;
end;

{------------------------------------------------------------------------------}
destructor TLMDSysInternetObject.Destroy;
begin
  FAdvancedOptions.Free;
  FZones.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInternetObject.Refresh;
var
  i:TLMDSysInternetDisplayInfo;
begin
  FPropertiesDesc.InvalidateProperties;

  OpenRegistry(true);
  try
    SetRegistryRootKey(HKEY_CLASSES_ROOT);
    if OpenRegistrySubKey('HTTP\shell\open\ddeExec\Application') then
      try
        FBrowser:= Registry.ReadString('');
        if FBrowser='IExplore' then FBrowser:='Microsoft Internet Explorer';
        if FBrowser='NSShell' then FBrowser:='Netscape Navigator';
      finally
        CloseRegistrySubKey;
      end;

    SetRegistryRootKey(HKEY_CURRENT_USER);
    if OpenRegistrySubKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Content\') then
      try
        FMaxSize := 0;
        if Registry.ValueExists('CacheLimit') then
          FMaxSize:= Registry.ReadInteger('CacheLimit');
      finally
        CloseRegistrySubKey;
      end;

    OpenRegistrySubKey('Software\Microsoft\Internet Explorer\Main\');
    FHomePage:= Registry.ReadString('Start Page');
    CloseRegistrySubKey;

    OpenRegistrySubKey('Software\Microsoft\Internet Explorer\Default HTML Editor');
    FHTMLEditor:= Registry.ReadString('Description');
    CloseRegistrySubKey;

    SetRegistryRootKey(HKEY_LOCAL_MACHINE);
    OpenRegistrySubKey('SOFTWARE\Clients\Calendar');
    OpenRegistrySubKey(Registry.ReadString(''));
    FCalendar:= Registry.ReadString('');
    CloseRegistrySubKey;
    CloseRegistrySubKey;

    OpenRegistrySubKey('SOFTWARE\Clients\Contacts');
    OpenRegistrySubKey(Registry.ReadString(''));
    FContacts:= Registry.ReadString('');
    CloseRegistrySubKey;
    CloseRegistrySubKey;

    OpenRegistrySubKey('SOFTWARE\Clients\Mail');
    OpenRegistrySubKey(Registry.ReadString(''));
    FEMailClient:= Registry.ReadString('');
    CloseRegistrySubKey;
    CloseRegistrySubKey;

    OpenRegistrySubKey('SOFTWARE\Clients\News');
    OpenRegistrySubKey(Registry.ReadString(''));
    FNewsClient:= Registry.ReadString('');
    CloseRegistrySubKey;
    CloseRegistrySubKey;

    OpenRegistrySubKey('SOFTWARE\Clients\Internet Call');
    OpenRegistrySubKey(Registry.ReadString(''));
    FInetCall:= Registry.ReadString('');
    CloseRegistrySubKey;
    CloseRegistrySubKey;

  finally
    CloseRegistry;
  end;

  FPath:=LMDGetSpecialFolderPath(sfInternetCache);

  for i:=Low(TLMDSysInternetDisplayInfo) to High(TLMDSysInternetDisplayInfo) do
    if i in FDisplayInfo then
      with FPropertiesDesc.PropertyByID(Ord(i)) do
        case i of
          ipidInetBrowser: Text:=FBrowser;
          ipidInetHomePage: Text:=FHomePage;
          ipidInetHTMLEditor: Text:=FHTMLEditor;
          ipidInetEMailClient: Text:=FEMailClient;
          ipidInetNewsClient: Text:=FNewsClient;
          ipidInetCalendar: Text:=FCalendar;
          ipidInetInetCall: Text:=FInetCall;
          ipidInetContacts: Text:=FContacts;
          ipidInetTempPath: Text:=FPath;
          ipidInetTempMaxSize: Text:=Inttostr(FMaxSize);
          ipidInetZones:
            begin
              FZones.Refresh;
              Text:=Inttostr(FZones.Count);
            end;
          ipidInetAdvancedProperties:
            begin
              FAdvancedOptions.Refresh;
              Text:=Inttostr(FAdvancedOptions.Count);
            end;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInternetObject.Apply;
begin
  FAdvancedOptions.Apply;
  FZones.Apply;
end;

{------------------------------------------------------------------------------}
function TLMDSysInternetObject.GetElementTitle : string;
begin
  result := sLMDSysInternetTitle;
end;

{------------------------------------------------------------------------------}
function TLMDSysInternetObject.GetElementDescription : string;
begin
  result := sLMDSysInternetDesc;
end;

{------------------------------------------------------------------------------}
function TLMDSysInternetObject.GetElementType : TLMDSysInfoType;
begin
  result := itInternet;
end;

{------------------------------------------------------------------------------}
function TLMDSysInternetObject.GetElementCount : integer;
begin
  result := 2;
end;

{------------------------------------------------------------------------------}
function TLMDSysInternetObject.GetElement(index : integer) : TObject;
begin
  result := nil;
  case index of
    0 : if ipidInetZones in FDisplayInfo then result := FZones;
    1 : if ipidInetAdvancedProperties in FDisplayInfo then result := FAdvancedOptions;
  end;
end;

{ TLMDSysInetZones }
{ ----------------------------- private -------------------------------------- }
function TLMDSysInetZones.GetItem(Index: Integer): TLMDSysInetZone;
begin
  Result:= TLMDSysInetZone(inherited GetItem(Index))
end;

{------------------------------------------------------------------------------}
function TLMDSysInetZones.Insert(Index: Integer): TLMDSysInetZone;
begin
  Result:= TLMDSysInetZone(inherited Insert(Index))
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInetZones.SetItem(Index: Integer;const Value: TLMDSysInetZone);
begin
  inherited SetItem(Index, Value);
end;

{----------------------------- public -----------------------------------------}
constructor TLMDSysInetZones.Create;
begin
  inherited Create(TLMDSysInetZone);
end;

{------------------------------------------------------------------------------}
function TLMDSysInetZones.Add: TLMDSysInetZone;
begin
  Result:= TLMDSysInetZone(inherited Add)
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInetZones.Refresh;
var
  R: TRegistry;

  procedure GetZoneSites(aZoneIndex: string; aZoneDomain: string; aURL: string; aSites: TStrings);
  var
    S: TStrings;
    I: LongInt;
  begin
    S:= TStringList.Create;
    try
      R.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains' + aZoneDomain, false);
      R.GetValueNames(S);
      for I:= 0 to S.Count - 1 do
        if (S[I] <> '') and (AnsiCompareText(IntToStr(R.ReadInteger(S[I])), aZoneIndex) = 0) then
        aSites.Add(S[I] + '://' + aURL);
      S.Clear;
      R.GetKeyNames(S);
      R.CloseKey;
      for I:= 0 to S.Count - 1 do
        GetZoneSites(aZoneIndex, aZoneDomain + '\' + S[I], S[I] + '.' + aURL, aSites);
    finally
      S.Free;
    end;
  end;

var
  S: TStrings;
  I: LongInt;
begin
  Clear;
DoProgress(sLMDSysInetZoneGroupTitle, 100, 0);
  R:= TRegistry.Create(KEY_READ);
  try
    R.RootKey:= HKEY_CURRENT_USER;
    if R.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones', false) then
      begin
        S:= TStringList.Create;
        try
          R.GetKeyNames(S);
          for I:= 0 to S.Count - 1 do
            begin
              DoProgress(sLMDSysInetZoneGroupTitle, 100, Round(i*100/s.count));
              if R.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\' + S[I], false) then
                begin
                  with Add do
                    begin
                      FZoneName:= R.ReadString('DisplayName');
                      FZoneDescription:= R.ReadString('Description');
                      GetZoneSites(S[I], '', '', FZoneSites);
                      Refresh;
                    end;
                  R.CloseKey;
                end;
            end;
        finally
          S.Free;
        end;
      end;
    R.CloseKey;
  finally
    R.Free;
  end;
DoProgress('', 100, 0);
end;

{------------------------------------------------------------------------------}
function TLMDSysInetZones.GetElementTitle : string;
begin
  result := sLMDSysInetZoneGroupTitle;
end;

{------------------------------------------------------------------------------}
function TLMDSysInetZones.GetElementDescription : string;
begin
  result := sLMDSysInetZoneGroupDesc;
end;

{------------------------------------------------------------------------------}
function TLMDSysInetZones.GetElementType : TLMDSysInfoType;
begin
  result := itInetZoneGroup;
end;

const
  cpidInetZoneName = 0;
  cpidInetZoneDescription = 1;
  cpidInetZoneSites = 2;

{ TLMDSysInetZone }
{ ----------------------------- private -------------------------------------- }
procedure TLMDSysInetZone.SetDummyString(const Value: string);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInetZone.SetDummyStrings(const Value: TStrings);
begin
end;

{----------------------------- public -----------------------------------------}
constructor TLMDSysInetZone.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FZoneSites:= TStringList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDSysInetZone.Destroy;
begin
  FZoneSites.Free;
  inherited;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDSysInetZone.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidInetZoneName, sLMDSysInetPropTitleZoneName, sLMDSysInetPropDescZoneName);
  FPropertiesDesc.Add(cpidInetZoneDescription, sLMDSysInetPropTitleZoneDescription, sLMDSysInetPropDescZoneDescription);
  FPropertiesDesc.Add(cpidInetZoneSites, sLMDSysInetPropTitleZoneSites, sLMDSysInetPropDescZoneSites);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInetZone.Refresh;
var
  i : integer;
  tmpStr : string;
begin
  FPropertiesDesc.InvalidateProperties;

  FPropertiesDesc.PropertyByID(cpidInetZoneName).Text := FZoneName;
  FPropertiesDesc.PropertyByID(cpidInetZoneDescription).Text := FZoneDescription;
  tmpStr := '';
  for i := 0 to FZoneSites.count-1 do
    tmpStr := tmpStr + ' ' + FZoneSites[i];
  FPropertiesDesc.PropertyByID(cpidInetZoneSites).Text := tmpStr;
end;

{------------------------------------------------------------------------------}
function TLMDSysInetZone.GetElementTitle : string;
begin
  result := sLMDSysInetZoneTitle +' ['+FZoneName+']';
end;

{------------------------------------------------------------------------------}
function TLMDSysInetZone.GetElementDescription : string;
begin
  result := sLMDSysInetZoneDesc;
end;

{------------------------------------------------------------------------------}
function TLMDSysInetZone.GetElementType : TLMDSysInfoType;
begin
  result := itInetZone;
end;

const
  cpidInetName = 0;
  cpidInetValue = 1;

{ TLMDSysInetAdvProp }
{ ----------------------------- private -------------------------------------- }
procedure TLMDSysInetAdvProp.SetDummyBool(const Value: Boolean);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInetAdvProp.SetDummyString(const Value: string);
begin
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDSysInetAdvProp.RegisterProperties;
begin
  inherited;
  FPropertiesDesc.Add(cpidInetName, sLMDSysInetPropTitleName, sLMDSysInetPropDescName);
  FPropertiesDesc.Add(cpidInetValue, sLMDSysInetPropTitleValue, sLMDSysInetPropDescValue);
end;

{----------------------------- public -----------------------------------------}
procedure TLMDSysInetAdvProp.Refresh;
begin
  FPropertiesDesc.InvalidateProperties;
  FPropertiesDesc.PropertyByID(cpidInetName).Text := FName;
  FPropertiesDesc.PropertyByID(cpidInetValue).Text := BoolToStr(FValue);
end;

{------------------------------------------------------------------------------}
function TLMDSysInetAdvProp.GetElementTitle : string;
begin
  result := sLMDSysInetAdvPropTitle + ' ['+FName+']';
end;

{------------------------------------------------------------------------------}
function TLMDSysInetAdvProp.GetElementDescription : string;
begin
  result := sLMDSysInetAdvPropDesc;
end;

{------------------------------------------------------------------------------}
function TLMDSysInetAdvProp.GetElementType : TLMDSysInfoType;
begin
  result := itInetAdvProp;
end;

{ TLMDSysInetAdvProps }
{------------------------------------------------------------------------------}
function TLMDSysInetAdvProps.Add: TLMDSysInetAdvProp;
begin
  Result:= TLMDSysInetAdvProp(inherited Add)
end;

{------------------------------------------------------------------------------}
constructor TLMDSysInetAdvProps.Create;
begin
  inherited Create(TLMDSysInetAdvProp);
end;

{------------------------------------------------------------------------------}
function TLMDSysInetAdvProps.GetItem(Index: Integer): TLMDSysInetAdvProp;
begin
  Result:= TLMDSysInetAdvProp(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
function TLMDSysInetAdvProps.Insert(Index: Integer): TLMDSysInetAdvProp;
begin
  Result:= TLMDSysInetAdvProp(inherited Insert(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInetAdvProps.Refresh;

  procedure GetAdvOpt(aPath, aN: string);
  var
    R, R1: TRegistry;
    S: TStrings;
    I: LongInt;
    CheckedValueS: string;
    CheckedValueI: LongInt;
  begin
    CheckedValueI:=0;
    R:= TRegistry.Create(KEY_READ);
    R1:= TRegistry.Create(KEY_READ);
    S:= TStringList.Create;
    try
      R.RootKey:= HKEY_LOCAL_MACHINE;
      R.OpenKey('\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions' + aPath, false);
      R.GetKeyNames(S);
      for I:= 0 to S.Count - 1 do
        begin
          DoProgress(sLMDSysInetAdvPropGroupTitle, 100, Round(i*100/s.count));
          if R.OpenKey('\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions' + aPath + '\' + S[I], false) then
            begin
              if AnsiCompareText(R.ReadString('Type'), 'group') = 0 then
              GetAdvOpt(aPath + '\' + S[I], aN + R.ReadString('Text') + ':')
              else
                with Add do
                  begin
                    FName:= R.ReadString('Text');
                    case R.GetDataType('CheckedValue') of
                      rdUnknown,
                        rdBinary: ;
                      rdString,
                        rdExpandString: CheckedValueS:= R.ReadString('CheckedValue');
                      rdInteger: CheckedValueI:= R.ReadInteger('CheckedValue');
                    end;
                    R1.RootKey:= HKEY_CURRENT_USER; //R.ReadInteger('HKeyRoot');
                    R1.OpenKey(R.ReadString('RegPath'), false);
                    if R1.ValueExists(R.ReadString('ValueName')) then
                      begin
                        case R1.GetDataType(R.ReadString('ValueName')) of
                          rdUnknown,
                            rdBinary: ;
                          rdString,
                            rdExpandString:
                            FValue:= AnsiSameText(CheckedValueS, R1.ReadString(R.ReadString('ValueName')));
                            rdInteger: FValue:= CheckedValueI = R1.ReadInteger(R.ReadString('ValueName'));
                        end;
                      end
                    else
                      FValue:= false;
                    R1.CloseKey;
                    Refresh;
                  end;
            end;
          R.CloseKey;
        end;
    finally
      R.Free;
      R1.Free;
      S.Free;
    end;
  end;

begin
  Clear;
  DoProgress(sLMDSysInetAdvPropGroupTitle, 100, 0);
  GetAdvOpt('', '');
  DoProgress('', 100, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysInetAdvProps.SetItem(Index: Integer;const Value: TLMDSysInetAdvProp);
begin
  inherited SetItem(Index, Value);
end;

{------------------------------------------------------------------------------}
function TLMDSysInetAdvProps.GetElementTitle : string;
begin
  result := sLMDSysInetAdvPropGroupTitle;
end;

{------------------------------------------------------------------------------}
function TLMDSysInetAdvProps.GetElementDescription : string;
begin
  result := sLMDSysInetAdvPropGroupDesc;
end;

{------------------------------------------------------------------------------}
function TLMDSysInetAdvProps.GetElementType : TLMDSysInfoType;
begin
  result := itInetAdvPropGroup;
end;

end.
