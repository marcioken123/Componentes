{ AMReg - version 1.0 (freeware)

This component simplifies the proces of saving application settings. As a bonus there is an Shareware
component available. With this component you can set a trialperiod for your Shareware app, this
component needs the AMReg-component.

Follow these steps:
1. Drop AMReg-component on your form
2. Set the following properties: Group, Company, Application and if needed User (AutoUser sets User
   to current user logged on to the system)
3. When you wan't to save some info you can use the following code:
        with AMReg1 do
        begin
          Active := True;
            WString('SomeString', Edit1.Text);
            WInteger('SomeInteger', SpinEdit1.Value);
            ... (all the other normal registry write procedures (even an encrypt-string)
          Active := False;
        end;
   ATTENTION: Always open the registry by setting 'Active' property at the beginning and close at
              the end. 'SomeString' and 'SomeInteger' is the userdefined key.
4. When you wan't to read some info you can use the following code:
        with AMReg1 do
        begin
          Active := True;
            Edit1.Text := RString('SomeString');
            SpinEdit1.Value := RInteger('SomeInteger');
            ... (all the other normal registry read functions (even an decrypt-string)
          Active := False;
        end;
5. There is one special write and one special read string function. You can en-/de-crypt a string
   to/from the register:
     WEString('SomeString', Edit1.Text);
     Edit1.Text := RDString('SomeString'); 

Version 1.0 - First release

Use it as you like, when you have a question please mail me: ameeder@dds.nl
}
unit AMReg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Registry;

const
  C1 = 52845;
  C2 = 22719;

type
  TStrCrypt = procedure(const S: string; var ResultStr:string) of object;

  EAMRegError = class(Exception);
  
  TOnExpired = procedure(Sender: TObject; Expired: boolean; ExpirationDate: TDateTime) of object;

  TRootKey = (HKeyClassesRoot, HKeyCurrentUser, HKeyLocalMachine, HKeyUsers,
              HKeyPerformanceData, HKeyCurrentConfig, HKeyDynData);

  TAMReg = class(TComponent)
  private
    FActive: boolean;
    FApplication: string;
    FAutoUser: boolean;
    FCompany: string;
    FGroup: string;

    FRootKey: TRootKey;
    FUser: string;

    KeyBasis: string;
    FReg: TRegistry;

    FEncryptFunc:TStrCrypt;
    FDecryptFunc:TStrCrypt;

    procedure SetActive(Value: Boolean);
    procedure SetAutoUser(Value: Boolean);
    procedure SetKeyBasis(Index: integer; Value: string);
    function GetReg: TRegistry;
  protected
    procedure Loaded; override;
    procedure UpdateKeyBasis;
  public
    function RBinaryData(const Key: string; var Buffer; BufSize: Integer): Integer;
    function RBool(const Key: string): boolean;
    function RCurrency(const Key: string): currency;
    function RDate(const Key: string): TDateTime;
    function RDateTime(const Key: string): TDateTime;
    function RFloat(const Key: string): double;
    function RInteger(const Key: string): integer;
    function RString(const Key: string): string;
    function RDString(const Key: string): string;
    function RTime(const Key: string): TDateTime;
    procedure WBinaryData(const Key: string; var Buffer; BufSize: Integer);
    procedure WBool(const Key: string; Value: bool);
    procedure WCurrency(const Key: string; Value: Currency);
    procedure WDate(const Key: string; Value: TDateTime);
    procedure WDateTime(const Key: string; Value: TDateTime);
    procedure WFloat(const Key: string; Value: Double);
    procedure WInteger(const Key: string; Value: integer);
    procedure WString(const Key, Value: string);
    procedure WEString(const Key, Value: string);
    procedure WTime(const Key: string; Value: TDateTime);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Active: boolean read FActive write SetActive default False;
    property Reg: TRegistry read GetReg write FReg;
  published
    property Application: string index 1 read FApplication write SetKeyBasis;
    property AutoUser: boolean read FAutoUser write SetAutoUser default False;
    property Company: string index 2 read FCompany write SetKeyBasis;
    property Group: string index 3 read FGroup write SetKeyBasis;
    property RootKey: TRootKey read FRootKey write FRootKey default HkeyCurrentUser;
    property User: string index 4 read FUser write SetKeyBasis;

    property StrEncrypt: TStrCrypt read FEncryptFunc write FEncryptFunc;
    property StrDecrypt: TStrCrypt read FDecryptFunc write FDecryptFunc;
  end;

  TAMShareware = class(TComponent)
  private
    FAMReg: TAMReg;
    FID: string;
    FTrialPeriod: integer;
    FOnExpired: TOnExpired;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AMReg: TAMReg read FAMReg write FAMReg;
    property ID: string read FID write FID;
    property TrialPeriod: integer read FTrialPeriod write FTrialPeriod default 30;
    property OnExpired: TOnExpired read FOnExpired write FOnExpired;
  end;

procedure Register;

implementation

var
  RootKeys : array[TRootKey] of HKey = (HKEY_CLASSES_ROOT, HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE,
                                        HKEY_USERS, HKEY_PERFORMANCE_DATA, HKEY_CURRENT_CONFIG,
                                        HKEY_DYN_DATA);

function GetUser: string;
var
  UserName: PChar;
  Count: cardinal;
begin
  Count := 0;
  GetUserName(nil, Count);
  UserName := StrAlloc(Count);
  try
    if GetUserName(UserName, Count) then Result := String(UserName) else Result := 'Unknown';
  finally
    StrDispose(UserName);
  end;
end;

// Beginning of AMShareware-component implementation...
procedure TAMShareware.Loaded;
var
  Expired: boolean;
  ExpireDate: TDateTime;
begin
  inherited Loaded;
  Expired := False;
  ExpireDate := Now+TrialPeriod;
  if (ID <> '') and Assigned(AMReg) and not (csDesigning in ComponentState) then
  begin
    with AMReg do
    begin
      Reg := TRegistry.Create;
      try
        Reg.RootKey := RootKeys[RootKey];
        if Reg.KeyExists(KeyBasis+ID) then
        begin
          Reg.OpenKey(KeyBasis+ID, False);
          ExpireDate := Reg.ReadDateTime(ID)
        end
        else
        begin
          Reg.OpenKey(KeyBasis+ID, True);
          Reg.WriteDateTime(ID, Now+TrialPeriod);
        end;

        Expired := Now >= ExpireDate;
        if Assigned(FOnExpired) then FOnExpired(Self, Expired, ExpireDate);
      finally
        Reg.Free;
      end;
    end;
  end;
  if Expired then Application.Terminate;
end;

procedure TAMShareware.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FAMReg then FAMReg := nil;
  end;
end;

constructor TAMShareware.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTrialPeriod := 30;
end;

// Beginning of AMReg-component implementation...

procedure TAMReg.UpdateKeyBasis;
begin
   KeyBasis := '\' + Group + '\' + Company + '\' + Application + '\';
   if User <> '' then KeyBasis := KeyBasis + User + '\';
end;

procedure TAMReg.SetActive(Value: Boolean);
begin
  if Value <> FActive then
  begin
    FActive := Value;
    if not (csDesigning in ComponentState) then
    begin
      if FActive then
      begin
        Reg := TRegistry.Create;
        Reg.RootKey := RootKeys[RootKey];
      end
      else
      begin
        Reg.Free;
        Reg := nil;
      end;
    end;
  end;
end;

procedure TAMReg.SetAutoUser(Value: boolean);
begin
  if Value <> FAutoUser then
  begin
    FAutoUser := Value;
    FUser := GetUser;
    UpdateKeyBasis;
  end;
end;

procedure TAMReg.SetKeyBasis(Index: integer; Value: string);
begin
  if (Value = '') and not (Index = 4) then raise EAMRegError.Create('This property may not be empty');

  case Index of
    1: FApplication := Value;
    2: FCompany := Value;
    3: FGroup := Value;
    4: if not AutoUser then FUser := Value;
  end;
  UpdateKeyBasis;
end;

function TAMReg.GetReg: TRegistry;
begin
  if not Assigned(FReg) then
    raise EAMRegError.Create('Registry not opened')
  else
    Result := FReg;
end;

function TAMReg.RBinaryData(const Key: string; var Buffer; BufSize: Integer): Integer;
begin
  Result := 0;
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadBinaryData(Key, Buffer, BufSize);
    end;
  end;
end;

function TAMReg.RBool(const Key: string): boolean;
begin
  Result := False;
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadBool(Key);
    end;
  end;
end;

function TAMReg.RCurrency(const Key: string): currency;
begin
  Result := 0.00;
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadCurrency(Key);
    end;
  end;
end;

function TAMReg.RDate(const Key: string): TDateTime;
begin
  Result := Date;
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadDate(Key);
    end;
  end;
end;

function TAMReg.RDateTime(const Key: string): TDateTime;
begin
  Result := Now;
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadDateTime(Key);
    end;
  end;
end;

function TAMReg.RFloat(const Key: string): double;
begin
  Result := 0.00;
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadFloat(Key);
    end;
  end;
end;

function TAMReg.RInteger(const Key: string): integer;
begin
  Result := 0;
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadInteger(Key);
    end;
  end;
end;

function TAMReg.RString(const Key: string): string;
begin
  Result := '';
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadString(Key);
    end;
  end;
end;

function TAMReg.RDString(const Key: string): string;
  function Decrypt(const S: string; Key: word): string;
  var
    I: integer;
  begin
    Result := S;
    for I := 1 to Length(S) do
    begin
      Result[I] := char(byte(S[I]) xor (Key shr 8));
      Key := (byte(S[I]) + Key) * C1 + C2;
    end;
  end;

  var
    decryptvalue:string;

begin
  Result := '';
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      if Assigned(FDecryptFunc) then 
         begin
           FDecryptFunc(ReadString(Key),decryptvalue);
           Result:=decryptvalue;
         end
      else
         Result:=Decrypt(ReadString(Key), 65535);
    end;
  end;
end;

function TAMReg.RTime(const Key: string): TDateTime;
begin
  Result := Time;
  with Reg do
  begin
    if Active and KeyExists(KeyBasis+Key) then
    begin
      OpenKey(KeyBasis+Key, False);
      Result := ReadTime(Key);
    end;
  end;
end;

procedure TAMReg.WBinaryData(const Key: string; var Buffer; BufSize: Integer);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteBinaryData(Key, Buffer, BufSize);
    end;
  end;
end;

procedure TAMReg.WBool(const Key: string; Value: bool);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteBool(Key, Value);
    end;
  end;
end;

procedure TAMReg.WCurrency(const Key: string; Value: Currency);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteCurrency(Key, Value);
    end;
  end;
end;

procedure TAMReg.WDate(const Key: string; Value: TDateTime);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteDate(Key, Value);
    end;
  end;
end;

procedure TAMReg.WDateTime(const Key: string; Value: TDateTime);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteDateTime(Key, Value);
    end;
  end;
end;

procedure TAMReg.WFloat(const Key: string; Value: Double);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteFloat(Key, Value);
    end;
  end;
end;

procedure TAMReg.WInteger(const Key: string; Value: integer);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteInteger(Key, Value);
    end;
  end;
end;

procedure TAMReg.WString(const Key, Value: string);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteString(Key, Value);
    end;
  end;
end;

procedure TAMReg.WEString(const Key, Value: string);
  function Encrypt(const S: string; Key: word): string;
  var
    I: integer;
  begin
    Result := S;
    for I := 1 to Length(S) do
    begin
      Result[I] := char(byte(S[I]) xor (Key shr 8));
      Key := (byte(Result[I]) + Key) * C1 + C2;
    end;
  end;

  var
    encryptvalue:string;
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      if Assigned(FEncryptFunc) then 
         begin
           FEncryptFunc(Value,encryptvalue);
           WriteString(Key,encryptvalue);
         end
      else
         WriteString(Key, Encrypt(Value, 65535));
    end;
  end;
end;

procedure TAMReg.WTime(const Key: string; Value: TDateTime);
begin
  if Active then
  begin
    with Reg do
    begin
      OpenKey(KeyBasis+Key, True);
      WriteTime(Key, Value);
    end;
  end;
end;

procedure TAMReg.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then UpdateKeyBasis;
end;

constructor TAMReg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRootKey := HKeyCurrentUser;
  FActive := False;
  FApplication := Forms.Application.Title;
  FAutoUser := False; 
  FCompany := 'AM Software';
  FGroup := 'Software';
  FUser := '';
end;

destructor TAMReg.Destroy;
begin
  if Active then Reg.Free;
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Domani', [TAMReg, TAMShareware]);
end;

end.
