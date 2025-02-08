unit ElSndMap;

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

ElSndMap unit
-------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses

  Windows,
  Messages,
  ElRegUtils,
  mmSystem,

Types,

  SysUtils,
  Classes,
  ElComponent,
  ElIni,
  LMDSysIn,
  TypInfo;

type

  TElSoundName = type string;  // RM September 2004

  TElSoundMap = class(TElComponent)
  private
    FSchemes : TStringList;
    FStorage : TElIniFile;
    FStoragePath : string;
    FScheme : string;
    FApplicationKey : string;
    FApplicationName : string;
    FRegIni,
      ARegIni : TElIniFile;
    FEventKeys : TStringList;
    FMute : Boolean;
    function GetEventLabels(EventKey : string) : string;
    procedure SetEventLabels(EventKey : string; newValue : string);

    function GetEnabled(EventKey : string) : boolean;
    procedure SetEnabled(EventKey : string; newValue : boolean);

    function GetSchemes : TStringList;
    function GetEventKeys : TStringList;
    function GetEventValues(EventKey : string) : string;
    procedure SetEventValues(EventKey : string; newValue : string);
    procedure SetApplicationName(newValue : string);
    procedure SetApplicationKey(newValue : string);
    procedure SetScheme(newValue : string);
    procedure SetStorage(newValue : TElIniFile);
    procedure SetStoragePath(newValue : string);
  protected
    { Protected declarations }
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Play(EventKey : string);
    procedure Add(EventKey, EventLabel, EventValue : string; Enabled : boolean);
    procedure Delete(EventKey : string);
    procedure Loaded; override;
    property EventKeys : TStringList read GetEventKeys; { Published }
    property EventLabel[EventKey : string] : string read GetEventLabels write SetEventLabels; { Published }
    property EventValue[EventKey : string] : string read GetEventValues write SetEventValues; { Published }
    property EventEnabled[EventKey : string] : boolean read GetEnabled write SetEnabled; { Published }
    property Schemes : TStringList read GetSchemes;
  published
    property Mute : Boolean read FMute write FMute; { Published }
    property ApplicationName : string read FApplicationName write SetApplicationName; { Published }
    property ApplicationKey : string read FApplicationKey write SetApplicationKey; { Published }
    property Scheme : string read FScheme write SetScheme;
    property StoragePath : string read FStoragePath write SetStoragePath; { Published }
    property Storage : TElIniFile read FStorage write SetStorage;
  end; { TElSoundMap }

implementation

procedure TElSoundMap.Loaded;
begin
  inherited;
  if FStorage = nil then
    FStoragePath := '';
end;

function TElSoundMap.GetSchemes : TStringList;
begin
  FSchemes.Clear;
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  FRegIni.EnumSubKeys(FStoragePath + FRegIni.Delimiter + 'Schemes\Schemes', FSchemes);
  result := FSchemes;
end;

function TElSoundMap.GetEventKeys;
begin
  FEventKeys.Clear;
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  FRegIni.EnumSubKeys(FStoragePath + FRegIni.Delimiter + 'Schemes\Apps\' + ApplicationKey, FEventKeys);
  result := FEventKeys;
end; { GetEventNames }

function TElSoundMap.GetEventLabels;
var
  SaveKey : string;
begin
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  SaveKey := FRegIni.CurrentKey;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + 'EventLabels\' + EventKey, false) then
  begin
    FRegIni.ReadString('', '', '', result);
    FRegIni.OpenKey(SaveKey, false);
  end
  else
    result := '';
end; { GetEventValues }

procedure TElSoundMap.SetEventLabels(EventKey : string; newValue : string);
var
  SaveKey : string;
begin
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  SaveKey := FRegIni.CurrentKey;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + '\EventLabels\' + EventKey, true) then
  begin
    FRegIni.WriteString('', '', newValue);
    FRegIni.OpenKey(SaveKey, false);
  end;
end; { SetEventValues }

function TElSoundMap.GetEventValues(EventKey : string) : string;
var
  SaveKey : string;
begin
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  SaveKey := FRegIni.CurrentKey;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + 'Schemes\Apps\' + ApplicationKey + '\' + EventKey + '\' + Scheme, false) then
  begin
    FRegIni.ReadString('', '', '', result);
    FRegIni.OpenKey(SaveKey, false);
  end
  else
    result := '';
end; { GetEventValues }

procedure TElSoundMap.SetEventValues(EventKey : string; newValue : string);
var
  SaveKey : string;
begin
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  SaveKey := FRegIni.CurrentKey;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + 'Schemes\Apps\' + ApplicationKey + '\' + EventKey + '\' + Scheme, true) then
  begin
    FRegIni.WriteString('', '', newValue);
    FRegIni.OpenKey(SaveKey, false);
  end;
end; { SetEventValues }

function TElSoundMap.GetEnabled(EventKey : string) : boolean;
var
  SaveKey : string;
begin
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  SaveKey := FRegIni.CurrentKey;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + 'Schemes\Apps\' + ApplicationKey + '\' + EventKey, false) then
  begin
    FRegIni.ReadBool('', 'Disabled', false, result);
    result := not result;
    FRegIni.OpenKey(SaveKey, false);
  end
  else
    result := true;
end;

procedure TElSoundMap.SetEnabled(EventKey : string; newValue : boolean);
var
  SaveKey : string;
begin
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  SaveKey := FRegIni.CurrentKey;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + 'Schemes\Apps\' + ApplicationKey + '\' + EventKey, true) then
  begin
    FRegIni.WriteBool('', 'Disabled', (not newValue));
    FRegIni.OpenKey(SaveKey, false);
  end;
end;

procedure TElSoundMap.Play(EventKey : string); { public }
var
  S, S1 : string;
begin
  if not Mute then
  begin
    S := Trim(EventValue[EventKey]);
    S1 := LMDSIWindowsDirectory;
    S := StringReplace( S, '%SystemRoot%', S1, [rfIgnoreCase] );
    if (Length(S) > 0) and EventEnabled[EventKey] then
      mmSystem.PlaySound(PChar(s), 0, SND_ASYNC);
  end;
end; { Play }

procedure TElSoundMap.Add(EventKey, EventLabel, EventValue : string; Enabled : boolean);
var
  SaveKey : string;
begin
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  SaveKey := FRegIni.CurrentKey;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + 'Schemes\Apps\' + ApplicationKey + '\' + EventKey, true) then
  begin
    Self.EventLabel[EventKey] := EventLabel;
    Self.EventValue[EventKey] := EventValue;
    EventEnabled[EventKey] := Enabled;
    FRegIni.OpenKey(SaveKey, false);
  end;
end;

procedure TElSoundMap.Delete(EventKey : string); { public }
var
  SaveKey : string;
begin
  if FStorage = nil then
    FRegIni := ARegIni
  else
    FRegIni := FStorage;
  SaveKey := FRegIni.CurrentKey;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + 'Schemes\Apps\' + ApplicationKey, true) then
  begin
    FRegIni.Delete(EventKey, '');
    FRegIni.OpenKey(SaveKey, false);
  end;
  if FRegIni.OpenKey(FStoragePath + FRegIni.Delimiter + 'EventLabels', false) then
  begin
    FRegIni.Delete(EventKey, '');
    FRegIni.OpenKey(SaveKey, false);
  end;
end; { SetEventValues }

procedure TElSoundMap.SetApplicationKey(newValue : string);
begin
  if (FApplicationKey <> newValue) then
  begin
    if not IsValidKeyName(AnsiString(newValue)) then
      raise Exception.Create('Key name contains invalid characters')
    else
    FApplicationKey := newValue;
  end; { if }
end; { SetApplicationKey }

procedure TElSoundMap.SetScheme(newValue : string);
begin
  if (FScheme <> newValue) then
  begin
    if not IsValidKeyName(AnsiString(newValue)) then
      raise Exception.Create('Scheme name contains invalid characters')
    else
    FScheme := newValue;
  end; { if }
end; { SetApplicationKey }

procedure TElSoundMap.SetApplicationName(newValue : string);
begin
  if (FApplicationName <> newValue) then
  begin
    FApplicationName := newValue;
    if FStorage = nil then
      FRegIni := ARegIni
    else
      FRegIni := FStorage;
    FRegIni.WriteString(FStoragePath + FRegIni.Delimiter + 'Schemes\Apps\' + ApplicationKey, '', newValue);
  end; { if }
end; { SetApplicationKey }

procedure TElSoundMap.SetStorage(newValue : TElIniFile);
begin
  if (FStorage <> newValue) then
  begin
    FStorage := newValue;
    if FStorage = nil then
      StoragePath := '';
  end; { if }
end; { SetStorage }

procedure TElSoundMap.SetStoragePath(newValue : string);
begin
  if FStoragePath <> newValue then
  begin
    FStoragePath := newValue;
    if (FStorage = nil) and (not (csLoading in ComponentState)) then FStoragePath := '';
  end;
end;

procedure TElSoundMap.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if (AComponent = FStorage) then Storage := nil;
  end; { if }
end; { Notification }

destructor TElSoundMap.Destroy;
begin
  FSchemes.Free;
  FEventKeys.Free;
  ARegIni.Free;
  inherited Destroy;
end; { Destroy }

constructor TElSoundMap.Create(AOwner : TComponent);
{ Creates an object of type TElSoundMap, and initializes properties. }
begin
  inherited Create(AOwner);
  ARegIni := TElIniFile.Create(Self);
  FEventKeys := TStringList.Create;
  ARegIni.UseRegistry := true;
  ARegIni.Path := '\AppEvents';
  FScheme := '.current';
  FSchemes := TStringList.Create;
end; { Create }

end.
