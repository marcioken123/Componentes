{       WAK Productions Presents:                               }
{       TRegware    version 2.1                                 }
{       Copyright ©2001 - WAK Productions                       }
{       ---------------------------------                       }
{       Programmed by Winston Kotzan                            }
{       Email: waksoftware@hotmail.com                          }
{       Website URL: http://www.wakproductions.com/                        }
{
This program helps developers of shareware include a timebomb/registration
for their program.  The end-user will enter their a name representing their
license, and a serial number (kinda like Winzip).  If their registration info.
is correct, then the program becomes registered.  TRegware hides data in the Windows
registry to check if program was registered.

Version 2 of TRegware uses a different, more secure method of encoding
data in the registry.  Unfortunately, this makes version 1 of TRegware
incompatible with version 2.  To provide backwards compatibility, the
class name for TRegware in version 2 has been changed to TRegwareII.
}
(*
Updates
-------
06-28-01  --  Version 2.1  (no backwards compatibility)
-Fixed bug that caused program to improperly cut down registration codes that
 were longer RegCodeSize, causing the last number in some codes to be incorrect.
-New feature that detects when user sets clock backwards.  If the user tries
 setting his computer's clock to an earlier time, program will consider itself
 'expired'.  When the user puts his clock back within the remaining x days
 of his evaluation, the program will continue to operate as normal.


Quick Reference
---------------
Here is a sumamary of the usage of the variables in TRegInfo:

License -  Name of the user who registered program
Organization - Organization or company of user who registered program
ExpireTime - TDateTime value of when the program will expire
  (decimal portion is ignored)
LastCountDown - Number of days left of evaluation time, recorded when the program
  was last shut down (used to make sure that user does not set clock backwards)
RegVersion - Version of TRegware used for registry (for future expansion)
RegCode - After the program has been registered, this value contains the serial
  number derived from the License value
ExpX - Not in use - provided for future expansion



End-User License Agreement
--------------------------
By using this software, you are agreeing to the following terms:

        1. WAK Productions and any employees will not be responsible for
           any damages, misuse, vertigo, or any other unfortunate accidents
           related to this product.

        2. Despite the many precautions made, there is no guarantee that this
           product will make your shareware program invulnerable to 'cracks',
           'hacks', or any other type of manipulation to bypass or deceive
           the shareware timebomb.

        2. The author of this software mantains the right to freely modify whole
           or any portion of this product in the next release.

        3. Any modifications must be marked as such, with some credit given to
           its original creator.

        4. You will not claim ownership of this product.

        5. This product may only be redistributed under the conditions that
           it comes in a duplicate of its original package, including
           all accompanied files, documentation, etc.
*)
unit regware2;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
     Forms, Graphics, Registry, ComObj, Dialogs;

type
  TRegInfo = record
    License, Organization, RegCode, Exp1: string[100];
    RegVersion: string[10];
    LastCountDown, Exp2, Exp3: integer;
    ExpireTime, Exp4: TDateTime;
  end;

  TRegwareII = class(TComponent)
    private
      { Private fields of TRegwareII }
        FCheckTamper: boolean;
        FDays : Integer;
        FLastCountDown: integer;
        FExpireTime: TDateTime;
        FLicense : String;
        FMaxChars: integer;
        FMinChars: integer;
        FOrganization : String;
        FProgGUID : String;
        FRegCode: string;
        FRegCodeSize: integer;
        FSeed : Int64;
        FTimebomb : Boolean;
        FOnClockChange: TNotifyEvent;
        FOnExpire: TNotifyEvent;
        FOnNagScreen: TNotifyEvent;
        FRegVersion: string;

      { Private methods of TRegwareII }
        { Method to set variable and property values and create objects }
        procedure AutoInitialize;
        { Method to free any objects created by AutoInitialize }
        procedure AutoDestroy;
        function GetDaysLeft : Integer;
        function GetRegistered : Boolean;
        { Checks if user set clock backwards }
        function CheckClockTampered: boolean;
        procedure CheckVariablesSet;
        function GetExpired: boolean;
        procedure LoadRegistryValues;
        procedure SaveRegistryValues;
        procedure SetMaxChars(MaxChars: integer);
        procedure SetMinChars(MinChars: integer);
        procedure SetSeed(Seed: Int64);

    protected
        procedure Expire; virtual;
        procedure ShowNag; virtual;
        procedure Loaded; override;
        procedure ClockChange; virtual;

    public
      { Calculates the registration code based on the LicenseName variable. }
      function CalculateCode(LicenseName: string): string;
      { Checks if the program's evaluation time has expired. True is returned
        if the time has run out, false if the evaluation period is still
        running. }
      function CheckExpired: boolean;
      { Checks the registry to see if the user has registered the program.
        True is returned if the program is registered, false otherwise. }
      function CheckRegistered: boolean;
      { Creates a new instance of TRegwareII }
      constructor Create(AOwner: TComponent); override;
      { Frees associated memory with TRegwareII.  Do not call Destroy directly,
        instead call the Free method }
      destructor Destroy; override;
      { Registers the program. LicenseName is the name of the person the program
        is being registered to.  Organization is optional, it can be the user's
        company. Organization is ignored if it is a null string.  RegCode is the
        registration code that goes with license.  To get RegCode, use the
        CalculateCode method.  Program will not be registered if serial is the
        incorrect registration code for LicenseName. }
      function DoRegistration(LicenseName, Organization, RegCode: string): boolean;
      { Resets the registry so that the program becomes unregistered. If the
        Timebomb property is true, then the timebomb is reset }
      procedure SetUnregistered;

      { The number of days left (if unregistered) for the evaluation period.
        This property is equal to -1 if the program is registered or has passed the
        time limit. }
      property DaysLeft: Integer read GetDaysLeft;
      { Indicates whether the program has expired. }
      property Expired: boolean read GetExpired;
      { An identifying name for the user's paid license.  Usually this is the
        name of the person the program is licensed to. This property is only
        available after the program has been registered.  It is the same as the
        LicenseName parameter passed to DoRegistration() }
      property License: String read FLicense;
      { This is the name of the organization (if any) that the licensee belongs
        to.  This property is only available after the program has been registered.
        It will be the same as the Organization parameter passed to DoRegistration() }
      property Organization : String read FOrganization;
      { This is the registration code based on the License property.  Same
        as the RegCode parameter passed to DoRegistration().  This property is
        only available after the program has been registered }
      property RegCode : string read FRegCode;
      { Indicates whether the program has been registered. }
      property Registered : Boolean read GetRegistered;

    published
      { Event is sent after the component loads in memory.  This event means that
        tampering has been done with the system's clock.  Difference is how many
        days back the clock has been set. }
      property OnClockChange: TNotifyEvent read FOnClockChange write FOnClockChange;
      { Event sent on startup of program if program has expired }
      property OnExpire: TNotifyEvent read FOnExpire write FOnExpire;
      { Event sent on startup of program, indicating an appropriate time
        to show a nag screen.  See Demo1 for proper use. }
      property OnNagScreen: TNotifyEvent read FOnNagScreen write FOnNagScreen;
      property CheckTamper: boolean read FCheckTamper write FCheckTamper default true;
      { This is the number of days timebomb will run.  It is ignored if the timebomb is already running. }
      property Days : Integer read FDays write FDays default 30;
      { Maximum number of characters that the License name can be }
      property MaxChars: integer read FMaxChars write SetMaxChars default 25;
      { Minimum number of characters that License name can be }
      property MinChars: integer read FMinChars write SetMinChars default 3;
      { The GUID string indicating the registry key where timebomb and registration
        information is stored.  If the programmer forgets to set this property
        to a valid GUID string, then a message box shows up making sure that
        the programmer is reminded. For more information on GUID's, look up TGUID
        in your Delphi online help file. }
      property ProgGUID : String read FProgGUID write FProgGUID;
      { A number used in generating the registration code.  Changing this number
        will yield different registration codes. If you forget to set this property
        to a value between 1000 and 2^63, then you WILL BE REMINDED when you
        try running the program. }
      property Seed : Int64 read FSeed write SetSeed default 0;
      { The number of digits you would like the registration code to be.  Setting
        this to 12 will have TRegwareII generate a registration code 12 digits long }
      property RegCodeSize: integer read FRegCodeSize write FRegCodeSize default 12;
      { This property contains the version number of the TRegwareII component you
        are using.  (Not applicable to version 1.0)
      property RegVersion: integer read FRegVersion;
      { Set this to true if you want TRegwareII to cause the program to stop functioning
        after a certain number of days.  If this is set to false, the program
        will not expire. }
      property Timebomb : Boolean read FTimebomb write FTimebomb default True;
  end;

procedure Register;

implementation

procedure Register;
begin
     RegisterComponents('WAK', [TRegwareII]);
end;

{ Checks for a valid GUID string }

function ValidateGUID(GUIDStr: string): boolean;
  { Check for hex character }
  function IsHex(AlphaNumChar: char): boolean;
  begin
    if ((Ord(AlphaNumChar) >= 48) and (Ord(AlphaNumChar) <= 57)) or
       ((Ord(AlphaNumChar) >= 65) and (Ord(AlphaNumChar) <= 70)) then
       Result := true
    else
      Result := false;
  end;

var
  i: integer;
begin
  Result := false;
  if Length(GUIDStr) <> 38 then Exit; // Not proper length
  for i := 1 to Length(GUIDStr) do
  begin
    // Check for valid letters and numbers
    if (i <> 1) and (i <> 10) and (i <> 15) and (i <> 20) and (i <> 25) and (i <> 38) then
    begin
      if not IsHex(GUIDStr[i]) then Exit;
    end else
      // Check for valid brackets
      if (i = 1) and (GUIDStr[i] <> '{') then Exit
        else if (i = 38) and (GUIDStr[i] <> '}') then Exit
          // Hyphens
          else if (i = 10) or (i = 15) or (i = 20) or (i = 25) then
            if (GUIDStr[i] <> '-') then Exit;
  end;
  Result := true;  // Ok, if all the above conditions checked;
end;

{------------------ TRegwareII methods ------------------}

{ Method to set variable and property values and create objects }
procedure TRegwareII.AutoInitialize;
begin
     FCheckTamper := true;
     FDays := 30;
     FMaxChars := 25;
     FMinChars := 3;
     FTimebomb := True;
end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TRegwareII.AutoDestroy;
begin
end;

function TRegwareII.GetDaysLeft : Integer;
begin
  if CheckClockTampered then // User tampered with clock
    Result := 0   // Consider program as expired
  else if (not Registered) and (Timebomb = true) then
  begin
    Result := Trunc(FExpireTime - Date);
    if Result < 0 then Result := 0;
  end
  else  // Clock not tampered and program registered
    Result := -1;
end;

function TRegwareII.GetRegistered : Boolean;
begin
  Result := CheckRegistered;
end;

{ Calculates the registration code to register program }
function TRegwareII.CalculateCode(LicenseName: string): string;
var
  i, Code: integer;
  CodeStr: string;
  Num: Int64;
begin
  // You can modify this algorithm if you want to...
  if (Length(LicenseName) > FMaxChars) or (Length(LicenseName) < FMinChars) then
  begin
    Result := '';  // LicenseName did not fit length requirements
    Exit;
  end;

  i := Length(LicenseName);
  while (i >= (Length(LicenseName) - 6)) and (i > 0) do
    begin
      CodeStr := CodeStr + IntToStr(FSeed mod Ord(LicenseName[i]));
      Dec(i);
    end;

  i := 1;
  while (i <= 6) and (Length(LicenseName) > 0) do
    begin
      CodeStr := CodeStr + IntToStr(FSeed mod Ord(LicenseName[i]));
      Inc(i);
    end;

  Val(CodeStr, Num, Code);

  if FRegCodeSize <= 0 then
    Result := IntToHex(Num, 0)
  else begin
    Result := IntToHex(Num, FRegCodeSize);
    Delete(Result, FRegCodeSize + 1, Length(Result) - FRegCodeSize);
  end;
end;

{ Checks if time has expired }
function TRegwareII.CheckExpired: boolean;
begin
  if GetDaysLeft = 0 then Result := true else Result := false;
end;

{ Checks if program is registered }
function TRegwareII.CheckRegistered: boolean;
begin
  if (FRegCode <> '') and (FLicense <> '') then
  begin
    if CompareStr( FRegCode, CalculateCode(FLicense) ) = 0 then
    begin
      Result := true;  // Reg Values check... program registered
    end else
    begin
      Result := false;  // Reg Values invalid... program not registered
      // Clear the false values
      FRegCode := '';
      FLicense := '';
      FOrganization := '';
    end;
  end else Result := false;  // Values not there... program not registered
end;

procedure TRegwareII.SetMaxChars(MaxChars: integer);
begin
  if (MaxChars > 100) or (MaxChars < MinChars) then
    raise Exception.Create('Please enter a number between ' +
      IntToStr(FMinChars) + ' and 100')
  else
    FMaxChars := MaxChars;
end;

constructor TRegwareII.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { AutoInitialize sets the initial values of variables and properties }
  AutoInitialize;
  FRegCodeSize := 12;
end;

destructor TRegwareII.Destroy;
begin
  SaveRegistryValues;
  AutoDestroy;
  inherited Destroy;
end;

function TRegwareII.DoRegistration(LicenseName, Organization, RegCode: string): boolean;
begin
  if (Length(LicenseName) > FMaxChars) or (Length(LicenseName) < FMinChars) or (Length(RegCode) = 0) then
  begin
    Result := false;
    Exit;
  end;
  RegCode := UpperCase(RegCode);  // Registration codes are not case sensitive
  if CompareStr(CalculateCode(LicenseName), RegCode) <> 0 then Result := false
  else begin
    FLicense := LicenseName;
    FOrganization := Organization;
    FRegCode := RegCode;
    SaveRegistryValues;
    Result := true;
  end;
end;

procedure TRegwareII.SetUnregistered;
begin
  FLicense := '';
  FOrganization := '';
  FRegCode := '';
  if Timebomb then
  begin
    FExpireTime := Now + FDays;
    FLastCountDown := FDays;
  end else
  begin
    FExpireTime := 0;
    FLastCountDown := FDays;
  end;
  SaveRegistryValues;
end;

procedure TRegwareII.Expire;
begin
  if Assigned(FOnExpire) then FOnExpire(Self);
end;

procedure TRegwareII.ShowNag;
begin
  if Assigned(FOnNagScreen) then FOnNagScreen(Self);
end;

procedure TRegwareII.Loaded;
begin
  inherited;
  CheckVariablesSet;
  LoadRegistryValues;
  if (not Registered) and (FExpireTime = 0) then
    SetUnregistered
  else if CheckClockTampered then
    ClockChange
  else if not Registered then
  begin
    ShowNag;
    if CheckExpired = true then
      Expire;
  end;
end;

procedure TRegwareII.ClockChange;
begin
  if Assigned(FOnClockChange) then FOnClockChange(Self);
end;

function TRegwareII.CheckClockTampered: boolean;
var
  DateDifference: integer;  // Difference between expiration date and now
begin
  Result := false;
  if FCheckTamper = true then
  begin
    DateDifference := Trunc(FExpireTime - Date);
    if DateDifference > FLastCountDown then // User set clock backwards
      Result := true;
  end;
end;

function TRegwareII.GetExpired: boolean;
begin
  Result := CheckExpired;
end;

procedure TRegwareII.SetSeed(Seed: Int64);
begin
  if (Seed > 1000) and (FSeed <> Seed) then FSeed := Seed;
end;


procedure TRegwareII.SaveRegistryValues;
var
  RegData: TRegInfo;
  Registry: TRegistry;
begin
  if ValidateGUID(FProgGUID) = false then Exit;

  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKey('\Software\CLASSES\CLSID\' + FProgGUID + '\Info', true);
    with RegData do
    begin
      License := FLicense;
      Organization := FOrganization;
      RegCode := FRegCode;
      RegVersion := '2.00';

      if not Registered then
      begin
        ExpireTime := FExpireTime;
        if CheckClockTampered = false then
          LastCountDown := Trunc(ExpireTime - Date)
        else
          LastCountDown := FLastCountDown;   // Only save this value if clock is correct
      end else
      begin
        ExpireTime := 0;
        LastCountDown := 0;
      end; // if..then..else

    end; // with RegData do
      Registry.WriteBinaryData('Data', RegData, SizeOf(RegData));
      Registry.CloseKey;
   finally
    Registry.Free;
  end; // try..finally }
end;

procedure TRegwareII.SetMinChars(MinChars: integer);
begin
  if (MinChars > FMaxChars) or (MinChars < 3) then
    raise Exception.Create('Please enter a number between 3 and ' +
      IntToStr(FMaxChars));
end;

procedure TRegwareII.LoadRegistryValues;
var
  RegData: TRegInfo;
  Registry: TRegistry;
begin
  if ValidateGUID(FProgGUID) = false then Exit;

  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKey('\Software\CLASSES\CLSID\' + FProgGUID + '\Info', true);
    if Registry.ValueExists('Data') then
    begin
      Registry.ReadBinaryData('Data', RegData, SizeOf(RegData));
      with RegData do
      begin
        FLicense := License;
        FOrganization := Organization;
        FRegCode := RegCode;
        FExpireTime := ExpireTime;
        FRegVersion := RegVersion;
        FLastCountDown := LastCountDown;
      end;
    end else
    begin
      SetUnregistered;
    end;
    Registry.CloseKey;
  finally
    Registry.Free;
  end; // try..finally
end;

procedure TRegwareII.CheckVariablesSet;
begin
  if ValidateGUID(FProgGUID) = false then
    ShowMessage('Mr. Programmer forgot to set the ProgGUID property to a ' +
      'valid GUID string!  Tsk, Tsk...');
  if FSeed = 0 then
    ShowMessage('Mr. Programmer forgot to set the Seed property to a ' +
      'valid integer between 1000 and 2^63!  Tsk, Tsk...');
end;


end.
