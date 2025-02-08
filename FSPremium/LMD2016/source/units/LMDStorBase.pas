unit LMDStorBase;
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

LMDStorBase unit (VO)
---------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Graphics, Controls, Registry, ShlObj, ActiveX, Forms,
  Windows, Types, FileCtrl,
  LMDStorCommon, LMDCustomComponent, LMDTypes;

type
  TLMDAbstractStorageCryptor = class;

  TLMDStorSectionAddEvent = procedure(Sender: TObject; const Section: string) of object;
  TLMDStorSectionDeleteEvent = procedure(Sender: TObject; const Section: string) of object;
  TLMDStorLoadStreamEvent = procedure(Sender: TObject; var Stream: TMemoryStream) of object;
  TLMDStorSaveStreamEvent = procedure(Sender: TObject;var Stream: TMemoryStream) of object;

  {-------------------  Class TLMDStorComponent -------------------------------}
  TLMDStorComponent = class(TLMDCustomComponent)
  public
   function getLMDPackage:TLMDPackageID;override;
  published
    property About;
  end;

  TLMDStorStreamEvent = procedure(Sender: TObject; var Stream: TMemoryStream) of object;
  TLMDStorStringCryptEvent = procedure(Sender: TObject; var Value: String) of object;
  TLMDStorStringCryptProcessEvent = procedure(Sender: TObject; var Value: String; var CanProcess: Boolean) of object;
  TLMDStorIntegerCryptEvent = procedure(Sender: TObject; var Value: Integer) of object;
  TLMDStorIntegerCryptProcessEvent = procedure(Sender: TObject; var Value: Integer; var CanProcess: Boolean) of object;
  TLMDStorCustomRootEvent = procedure(Sender: TObject; Instance: TComponent; var Root: TComponent) of object;
  TLMDStorUpdateBeforeCloseEvent = procedure(Sender: TObject; var ACanUpdate: boolean) of object;  

  TLMDStorPathPrefix = (ppDefault, ppSystem, ppProgram, ppWindows, ppCustom);

  {-------------------  Class TLMDAbstractStorageVault ------------------------}
  TLMDAbstractStorageVault = class(TLMDStorComponent)
  private
    FOnBeforeEncryption        : TLMDStorStreamEvent;
    FOnAfterEncryption         : TLMDStorStreamEvent;
    FOnBeforeDecryption        : TLMDStorStreamEvent;
    FOnAfterDecryption         : TLMDStorStreamEvent;
    FOnBeforeStringEncryption  : TLMDStorStringCryptProcessEvent;
    FOnAfterStringEncryption   : TLMDStorStringCryptEvent;
    FOnBeforeStringDecryption  : TLMDStorStringCryptProcessEvent;
    FOnAfterStringDecryption   : TLMDStorStringCryptEvent;
    FOnBeforeIntegerEncryption : TLMDStorIntegerCryptProcessEvent;
    FOnAfterIntegerEncryption  : TLMDStorIntegerCryptEvent;
    FOnBeforeIntegerDecryption : TLMDStorIntegerCryptProcessEvent;
    FOnAfterIntegerDecryption  : TLMDStorIntegerCryptEvent;
    FOnUpdateBeforeClose       : TLMDStorUpdateBeforeCloseEvent;  
    FBinaryStream              : Boolean;
    FCompressedStream          : Boolean;
    FSections                  : TStrings;
    FActiveSection             : string;
    FActiveSectionIndex        : Integer;
    FOnBeforeOpen              : TNotifyEvent;
    FOnAfterOpen               : TNotifyEvent;
    FOnBeforeClose             : TNotifyEvent;
    FOnAfterClose              : TNotifyEvent;
    FOnSectionAdd              : TLMDStorSectionAddEvent;
    FOnSectionDelete           : TLMDStorSectionDeleteEvent;
    FOnLoadStream              : TLMDStorLoadStreamEvent;
    FOnSaveStream              : TLMDStorSaveStreamEvent;
    FFileName                  : TFileName;
    FFilePrefix                : TLMDStorPathPrefix;
    FAppDataPath               : String;
    FAppDataCommon             : Boolean;
    FEncrypted                 : Boolean;
    FAutoUpdate                : Boolean;
    FOnCustomRootRead          : TLMDStorCustomRootEvent;
    FOnCustomRootWrite         : TLMDStorCustomRootEvent;
    procedure SetBinaryStream(const Value: Boolean);
    procedure SetCompressedStream(const Value: Boolean);
    procedure SetSections(const Value: TStrings); virtual;
    procedure SetActiveSection(const Value: string); virtual;
    procedure SetActiveSectionIndex(const Value: Integer); virtual;
    procedure SetStorageCryptor(const Value: TLMDAbstractStorageCryptor);
    procedure SetFileName(const Value: TFileName);
    procedure SetFilePrefix(const Value: TLMDStorPathPrefix);
    procedure SetEncrypted(const Value: Boolean);
    function GetDataFile: String;
    function IsCustomDataPath:Boolean;
    function LMDAppData: String;
    function LMDCreatePathPrefix(aValue: TLMDStorPathPrefix; Slash: Boolean): String;
  protected
    FIsLoading: boolean;
    FStorageCryptor: TLMDAbstractStorageCryptor;
    function Extension: String; dynamic; abstract;
    property FileName: TFileName read FFileName write SetFileName;
    property FilePrefix: TLMDStorPathPrefix read FFilePrefix write SetFilePrefix default ppProgram;
    property Encrypted: Boolean read FEncrypted write SetEncrypted default false;
    property AppDataPath: String read FAppDataPath write FAppDataPath stored IsCustomDataPath;
    property AppDataCommon: Boolean read FAppDataCommon write FAppDataCommon default false;
    procedure DoOnBeforeEncryption(Sender: TObject; var Stream: TMemoryStream); dynamic;
    procedure DoOnAfterEncryption(Sender: TObject; var Stream: TMemoryStream); dynamic;
    procedure DoOnBeforeDecryption(Sender: TObject; var Stream: TMemoryStream); dynamic;
    procedure DoOnAfterDecryption(Sender: TObject; var Stream: TMemoryStream); dynamic;
    procedure DoOnBeforeStringEncryption(Sender: TObject; var Value: String; var CanProcess: Boolean); dynamic;
    procedure DoOnAfterStringEncryption(Sender: TObject; var Value: String); dynamic;
    procedure DoOnBeforeStringDecryption(Sender: TObject; var Value: String; var CanProcess: Boolean); dynamic;
    procedure DoOnAfterStringDecryption(Sender: TObject; var Value: String); dynamic;
    procedure DoOnBeforeIntegerEncryption(Sender: TObject; var Value: Integer; var CanProcess: Boolean); dynamic;
    procedure DoOnAfterIntegerEncryption(Sender: TObject; var Value: Integer); dynamic;
    procedure DoOnBeforeIntegerDecryption(Sender: TObject; var Value: Integer; var CanProcess: Boolean); dynamic;
    procedure DoOnAfterIntegerDecryption(Sender: TObject; var Value: Integer); dynamic;
    procedure DoOnBeforeOpen(Sender: TObject); dynamic;
    procedure DoOnAfterOpen(Sender: TObject); dynamic;
    procedure DoOnBeforeClose(Sender: TObject); dynamic;
    procedure DoOnAfterClose(Sender: TObject); dynamic;
    procedure DoOnSectionAdd(Sender: TObject; const Section: String); dynamic;
    procedure DoOnSectionDelete(Sender: TObject; const Section: String);dynamic;
    procedure DoOnLoadStream(Sender: TObject; var Stream: TMemoryStream);dynamic;
    procedure DoOnSaveStream(Sender: TObject; var Stream: TMemoryStream);dynamic;
    procedure DoOnUpdateBeforeCloseEvent(Sender: TObject; var ACanUpdate: boolean); dynamic;
    procedure DoCustomRootRead(Instance: TComponent; var Root: TComponent); virtual;
    procedure DoCustomRootWrite(Instance: TComponent; var Root: TComponent); virtual;
    procedure FileChanged; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;

    property OnBeforeOpen: TNotifyEvent read FOnBeforeOpen write FOnBeforeOpen;
    property OnAfterOpen: TNotifyEvent read FOnAfterOpen write FOnAfterOpen;
    property OnBeforeClose: TNotifyEvent read FOnBeforeClose write FOnBeforeClose;
    property OnAfterClose: TNotifyEvent read FOnAfterClose write FOnAfterClose;
    property OnSectionAdd: TLMDStorSectionAddEvent read FOnSectionAdd write FOnSectionAdd;
    property OnSectionDelete: TLMDStorSectionDeleteEvent read FOnSectionDelete write FOnSectionDelete;
    property OnLoadStream: TLMDStorLoadStreamEvent read FOnLoadStream write FOnLoadStream;
    property OnSaveStream: TLMDStorSaveStreamEvent read FOnSaveStream write FOnSaveStream;
    property OnBeforeEncryption: TLMDStorStreamEvent read FOnBeforeEncryption write FOnBeforeEncryption;
    property OnAfterEncryption: TLMDStorStreamEvent read FOnAfterEncryption write FOnAfterEncryption;
    property OnBeforeDecryption: TLMDStorStreamEvent read FOnBeforeDecryption write FOnBeforeDecryption;
    property OnAfterDecryption: TLMDStorStreamEvent read FOnAfterDecryption write FOnAfterDecryption;
    property OnBeforeStringEncryption: TLMDStorStringCryptProcessEvent read FOnBeforeStringEncryption write FOnBeforeStringEncryption;
    property OnAfterStringEncryption: TLMDStorStringCryptEvent read FOnAfterStringEncryption write FOnAfterStringEncryption;
    property OnBeforeStringDecryption: TLMDStorStringCryptProcessEvent read FOnBeforeStringDecryption write FOnBeforeStringDecryption;
    property OnAfterStringDecryption: TLMDStorStringCryptEvent read FOnAfterStringDecryption write FOnAfterStringDecryption;
    property OnBeforeIntegerEncryption: TLMDStorIntegerCryptProcessEvent read FOnBeforeIntegerEncryption write FOnBeforeIntegerEncryption;
    property OnAfterIntegerEncryption: TLMDStorIntegerCryptEvent read FOnAfterIntegerEncryption write FOnAfterIntegerEncryption;
    property OnBeforeIntegerDecryption: TLMDStorIntegerCryptProcessEvent read FOnBeforeIntegerDecryption write FOnBeforeIntegerDecryption;
    property OnAfterIntegerDecryption: TLMDStorIntegerCryptEvent read FOnAfterIntegerDecryption write FOnAfterIntegerDecryption;
    property OnCustomRootRead: TLMDStorCustomRootEvent read FOnCustomRootRead write FOnCustomRootRead;
    property OnCustomRootWrite: TLMDStorCustomRootEvent read FOnCustomRootWrite write FOnCustomRootWrite;
    property OnUpdateBeforeClose: TLMDStorUpdateBeforeCloseEvent read FOnUpdateBeforeClose write FOnUpdateBeforeClose;
    property BinaryStream: Boolean read FBinaryStream write SetBinaryStream default false;
    property Sections: TStrings read FSections write SetSections;
    property ActiveSectionIndex: Integer read FActiveSectionIndex write SetActiveSectionIndex default -1;
    property StorageCryptor: TLMDAbstractStorageCryptor read FStorageCryptor write SetStorageCryptor;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save(Stream: TMemoryStream); virtual;
    procedure Load(Stream: TMemoryStream); virtual;
    procedure Open; virtual; abstract;
    procedure Close; virtual; abstract;
    procedure Update; virtual; abstract;
    function KeyExists(const Key: string; Section: string = ''): Boolean; virtual; abstract;
    procedure ReadKeys(Strings: TStrings; Section: string = ''); virtual; abstract;
    function KeyCount(Section: string = ''): Integer; virtual; abstract;
    function SectionExists(const Section: string): Boolean; virtual; abstract;
    procedure AddSection(const Section: string); virtual; abstract;
    function RenameSection(const OldName, NewName: string): Boolean; virtual; abstract;
    function RemoveSection(const Section: string): Boolean; virtual; abstract;
    function DeleteSection(const Section: string): Boolean; virtual; abstract;
    function ClearSection(const Section: string): Boolean; virtual; abstract;
    procedure DeleteKey(const Section, Ident: string); virtual; abstract;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); virtual; abstract;
    function ReadBool(const Section, Ident: string; ADefault: Boolean): Boolean; virtual; abstract;
    procedure WriteColor(const Section, Ident: string; Value: TColor); virtual; abstract;
    function ReadColor(const Section, Ident: string; ADefault: TColor): TColor; virtual; abstract;
    procedure WriteComponent(const Instance: TComponent; const Section: string = ''); virtual; abstract;
    function ReadComponent(const Section: string; Instance: TComponent):TComponent; virtual; abstract;
    procedure WriteDate(const Section, Ident: string; Value: TDateTime);virtual; abstract;
    function ReadDate(const Section, Ident: string; ADefault: TDateTime):TDateTime; virtual; abstract;
    procedure WriteDateTime(const Section, Ident: string; Value: TDateTime);virtual; abstract;
    function ReadDateTime(const Section, Ident: string; ADefault: TDateTime):TDateTime; virtual; abstract;
    procedure WriteFloat(const Section, Ident: string; Value: Double);virtual; abstract;
    function ReadFloat(const Section, Ident: string; ADefault: Double):Double; virtual; abstract;
    procedure WriteObject(const Section, Ident: string; Instance: TPersistent);virtual; abstract;
    function ReadObject(const Section, Ident: string; Instance: TPersistent):TPersistent; virtual; abstract;
    procedure WriteFont(const Section, Ident: string; Instance: TFont);virtual; abstract;
    function ReadFont(const Section, Ident: string; Instance: TFont): TFont;virtual; abstract;
    procedure WriteInteger(const Section, Ident: string; Value: LongInt);virtual; abstract;
    function ReadInteger(const Section, Ident: string; ADefault: LongInt):LongInt; virtual; abstract;
    procedure WriteInt64(const Section, Ident: string; Value: Int64);virtual; abstract;
    function ReadInt64(const Section, Ident: string; ADefault: Int64):Int64; virtual; abstract;
    procedure WritePoint(const Section, Ident: string; Value: TPoint);virtual; abstract;
    function ReadPoint(const Section, Ident: string; ADefault: TPoint): TPoint;virtual; abstract;
    procedure WriteRect(const Section, Ident: string; Value: TRect);virtual; abstract;
    function ReadRect(const Section, Ident: string; ADefault: TRect): TRect;virtual; abstract;
    procedure WriteString(const Section, Ident: string; Value: string);virtual; abstract;
    function ReadString(const Section, Ident: string; ADefault: String): String;virtual; abstract;
    procedure WriteStrings(const Section, Ident: string; Value: TStrings);virtual; abstract;
    procedure ReadStrings(const Section, Ident: string; Value: TStrings);virtual; abstract;
    procedure WriteTime(const Section, Ident: string; Value: TDateTime);virtual; abstract;
    function ReadTime(const Section, Ident: string; ADefault: TDateTime):TDateTime; virtual; abstract;
    procedure ReadSection (const Section: String; Strings: TStrings);virtual; abstract;
    procedure ReadSections(Strings: TStrings); virtual; abstract;
    function EncryptString(Value: String): String;
    function DecryptString(Value: String): String;
    function EncryptInteger(Value: Integer): Integer;
    function DecryptInteger(Value: Integer): Integer;
    property DataFile: String read GetDataFile;
    property AutoUpdate:boolean read FAutoUpdate write FAutoUpdate;
    property ActiveSection: string read FActiveSection write SetActiveSection;
    property IsLoading: boolean read FIsLoading;
  published
    property CompressedStream: Boolean read FCompressedStream write SetCompressedStream default true;
  end;

  TLMDStorCryptTypes = set of (ctString, ctInteger);

  TLMDAbstractStorageCryptor = class(TLMDStorComponent)
  protected
    FCryptTypes: TLMDStorCryptTypes;
  public
    procedure Encrypt(Stream: TMemoryStream); virtual; abstract;
    procedure Decrypt(Stream: TMemoryStream); virtual; abstract;
    function EncryptString(Value: String): String; virtual; abstract;
    function DecryptString(Value: String): String; virtual; abstract;
    function EncryptInteger(Value: Integer): Integer; virtual; abstract;
    function DecryptInteger(Value: Integer): Integer; virtual; abstract;
    property CryptTypes: TLMDStorCryptTypes read FCryptTypes write FCryptTypes default [];
  end;

implementation

uses
  LMDStorPropertiesStorage, LMDStorConsts, LMDUtils, LMDProcs, LMDStrings
  {$IFDEF LMD_DEBUGTRACE},dialogs{$ENDIF}
  ;

const
  REGSTR_PATH_EXPLORER        = 'Software\Microsoft\Windows\CurrentVersion\Explorer';
  REGSTR_PATH_SPECIAL_FOLDERS = REGSTR_PATH_EXPLORER + '\Shell Folders';

{********************* TLMDStorComponent **************************************}
function TLMDStorComponent.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_STORAGE;
end;

{********************* TLMDAbstractStorageVault *******************************}
{------------------------- Private --------------------------------------------}
procedure TLMDAbstractStorageVault.SetBinaryStream(const Value: Boolean);
begin
  FBinaryStream := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.SetCompressedStream(const Value: Boolean);
begin
  FCompressedStream := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.SetSections(const Value: TStrings);
begin
  FSections.Clear;
  FActiveSectionIndex := -1;
  FActiveSection := '';
  FSections.AddStrings(Value);
  if FSections.Count > 0 then
    begin
      if FActiveSectionIndex = -1 then FActiveSectionIndex := 0;
      if FActiveSection = '' then FActiveSection := FSections[0];
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.SetActiveSection(const Value: string);
begin
  if FActiveSection <> Value then
    begin
      FActiveSection := Value;
      FActiveSectionIndex := FSections.IndexOf(Value);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.SetActiveSectionIndex(const Value: Integer);
begin
  if FActiveSectionIndex <> Value then
    begin
      FActiveSection := '';
      FActiveSectionIndex := Value;
      if FActiveSectionIndex >= FSections.Count then
        FActiveSectionIndex := FSections.Count - 1 else
        if FActiveSectionIndex < -1 then
          FActiveSectionIndex := -1;
      if FActiveSectionIndex > -1 then
        FActiveSection := FSections[FActiveSectionIndex];
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.SetStorageCryptor(const Value: TLMDAbstractStorageCryptor);
begin
  if FStorageCryptor <> Value then
    begin
      if FStorageCryptor <> nil then
        begin
          FStorageCryptor.RemoveFreeNotification(Self);
        end;
      FStorageCryptor := Value;
      if FStorageCryptor <> nil then
        begin
          FStorageCryptor.FreeNotification(Self);
        end;
{      if FStorageCryptor <> nil then
        begin
           FStorageVault.BinaryStream := True;
        end;}
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.SetFileName(const Value: TFileName);
var
  S : string;
begin
  S := Trim(Value);
  if S <> FFileName then
    begin
      // strip filename from full qualified path of FilePrefix <> custom
      if (FFilePrefix <> ppCustom) and not (csLoading in ComponentState) then
          FFileName := ExtractFileName(S)
        else
          FFileName := S;
      FileChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.SetFilePrefix(const Value: TLMDStorPathPrefix);
begin
  if Value <> FFilePrefix then
    begin
      FFilePrefix := Value;
      FileChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.SetEncrypted(const Value: Boolean);
begin
  if Value <> FEncrypted then FEncrypted := Value;
end;

{------------------------------------------------------------------------------}
function TLMDAbstractStorageVault.GetDataFile: String;
begin
  if (FFileName = '') and IsLibrary then
    raise EReadError.Create('Invalid FileName property.');

  if FFileName = '' then
    FFileName := ChangeFileExt(Application.ExeName, '.' + Extension);

  if (FilePrefix = ppDefault) and (FAppDataPath = '') then
    raise EReadError.Create('Invalid AppDataPath property.');

  if FFilePrefix <> ppCustom then
    begin
      Result := LMDCreatePathPrefix(FFilePrefix, True);
      if FilePrefix = ppDefault then Result := Result + FAppDataPath;
      if not DirectoryExists(Result) then CreateDirs(Result);
      // Prevents double slash
      if (Result <> '') and (Result[Length(Result)] <> '\') then
        Result := Result + '\' + ExtractFileName(FFileName)
      else
        Result := Result + ExtractFileName(FFileName);
    end
  else
    Result := FFileName;
end;

{------------------------------------------------------------------------------}
function TLMDAbstractStorageVault.IsCustomDataPath: Boolean;
begin
  Result := FAppDataPath<>IDS_STOR_DEFAULTAPPDATAPATH;
end;

{------------------------------------------------------------------------------}
function TLMDAbstractStorageVault.LMDAppData: String;
const
  CSIDL_COMMON_APPDATA = $0023;

  function GetShellDirectory(ID: Integer): string;
  var
    S: string;
    ItemIDList: PItemIDList;
    SystemHeap: IMalloc;
  begin
    Result := EmptyStr;

    if SHGetSpecialFolderLocation(Application.Handle,
         ID, ItemIDList) = NOERROR then
    begin
      try
        SetLength(S, MAX_PATH);
        if SHGetPathFromIDList(ItemIDList, PChar(S)) then
        begin
          Result:= Copy(S, 1, Pos(#0, S) - 1);
        end;
      finally
        if SHGetMalloc(SystemHeap) = NOERROR then
        begin
          SystemHeap.Free(ItemIDList);
        end;
      end;
    end;
  end;
  function GetShellDirectoryEx(ID: Integer; RegName: string): string;
  var
    Reg: TRegistry;
  begin
    Result:= GetShellDirectory(ID);

    if Result = '' then
    begin
      Reg:= TRegistry.Create;
      try
        Reg.RootKey:= HKEY_CURRENT_USER;

        if Reg.OpenKey(REGSTR_PATH_SPECIAL_FOLDERS, False) then
        begin
          if Reg.ValueExists(RegName) then
            Result:= Reg.ReadString(RegName);
        end;
      finally
        Reg.Free;
      end;
    end;

    if Result = '' then
    begin
      Reg:= TRegistry.Create;
      try
        Reg.RootKey:= HKEY_LOCAL_MACHINE;

        if Reg.OpenKey(REGSTR_PATH_SPECIAL_FOLDERS, False) then
        begin
          if Reg.ValueExists(RegName) then
            Result:= Reg.ReadString(RegName);
        end;
      finally
        Reg.Free;
      end;
    end;
  end;

begin
  if AppDataCommon then
   Result := GetShellDirectoryEx(CSIDL_COMMON_APPDATA, 'AppData')
  else
   Result := GetShellDirectoryEx(CSIDL_APPDATA, 'AppData');
end;

{------------------------------------------------------------------------------}
function TLMDAbstractStorageVault.LMDCreatePathPrefix(aValue: TLMDStorPathPrefix; Slash: Boolean): String;
begin
  result := '';
  case aValue of
    ppDefault: result := LMDAppData;
    ppSystem : result := LMDSystemDirectory;
    ppProgram: Result := LMDAppPath;
    ppWindows: Result := LMDWindowsDirectory;
  else
    exit;
  end;
  if Slash then result := LMDAnsiSlashAdd(result) else result := LMDAnsiSlashRemove(result);
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnBeforeEncryption(Sender: TObject;
 var Stream: TMemoryStream);
begin
  if Assigned(OnBeforeEncryption) then OnBeforeEncryption(Sender, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnAfterEncryption(Sender: TObject;
 var Stream: TMemoryStream);
begin
  if Assigned(OnAfterEncryption) then OnAfterEncryption(Sender, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnBeforeDecryption(Sender: TObject;
 var Stream: TMemoryStream);
begin
  if Assigned(OnBeforeDecryption) then OnBeforeDecryption(Sender, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnAfterDecryption(Sender: TObject;
 var Stream: TMemoryStream);
begin
  if Assigned(OnAfterDecryption) then OnAfterDecryption(Sender, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnBeforeStringEncryption(Sender:
 TObject; var Value: String; var CanProcess: Boolean);
begin
  if Assigned(OnBeforeStringEncryption) then
   OnBeforeStringEncryption(Sender, Value, CanProcess);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnAfterStringEncryption(Sender:
 TObject; var Value: String);
begin
  if Assigned(OnAfterStringEncryption) then
   OnAfterStringEncryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnBeforeStringDecryption(Sender:
 TObject; var Value: String; var CanProcess: Boolean);
begin
  if Assigned(OnBeforeStringDecryption) then
   OnBeforeStringDecryption(Sender, Value, CanProcess);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnAfterStringDecryption(Sender:
 TObject; var Value: String);
begin
  if Assigned(OnAfterStringDecryption) then
   OnAfterStringDecryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnBeforeIntegerEncryption(Sender:
 TObject; var Value: Integer; var CanProcess: Boolean);
begin
  if Assigned(OnBeforeIntegerEncryption) then
   OnBeforeIntegerEncryption(Sender, Value, CanProcess);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnAfterIntegerEncryption(Sender:
 TObject; var Value: Integer);
begin
  if Assigned(OnAfterIntegerEncryption) then
   OnAfterIntegerEncryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnBeforeIntegerDecryption(Sender:
 TObject; var Value: Integer; var CanProcess: Boolean);
begin
  if Assigned(OnBeforeIntegerDecryption) then
   OnBeforeIntegerDecryption(Sender, Value, CanProcess);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnAfterIntegerDecryption(Sender:
 TObject; var Value: Integer);
begin
  if Assigned(OnAfterIntegerDecryption) then
   OnAfterIntegerDecryption(Sender, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnBeforeOpen(Sender: TObject);
begin
  if Assigned(OnBeforeOpen) then OnBeforeOpen(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnAfterOpen(Sender: TObject);
begin
  if Assigned(OnAfterOpen) then OnAfterOpen(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnBeforeClose(Sender: TObject);
begin
  if Assigned(OnBeforeClose) then OnBeforeClose(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnAfterClose(Sender: TObject);
begin
  if Assigned(OnAfterClose) then OnAfterClose(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnSectionAdd(Sender: TObject;
 const Section: String);
begin
  if Assigned(OnSectionAdd) then OnSectionAdd(Sender, Section);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnSectionDelete(Sender: TObject;
 const Section: String);
begin
  if Assigned(OnSectionDelete) then OnSectionDelete(Sender, Section);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnLoadStream(Sender: TObject;
 var Stream: TMemoryStream);
begin
  if Assigned(OnLoadStream) then OnLoadStream(Sender, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnSaveStream(Sender: TObject;
 var Stream: TMemoryStream);
begin
  if Assigned(OnSaveStream) then OnSaveStream(Sender, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoOnUpdateBeforeCloseEvent(Sender: TObject; var ACanUpdate: boolean);
begin
  if Assigned(FOnUpdateBeforeClose) then OnUpdateBeforeClose(Sender, ACanUpdate);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoCustomRootRead(Instance: TComponent; var Root: TComponent);
begin
  if Assigned(FOnCustomRootRead) then FOnCustomRootRead(Self, Instance, Root);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.DoCustomRootWrite(Instance: TComponent; var Root: TComponent);
begin
  if Assigned(FOnCustomRootWrite) then FOnCustomRootWrite(Self, Instance, Root);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent <> nil) then
    begin
      if (AComponent = FStorageCryptor) then
        StorageCryptor := nil;
    end;
  inherited;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDAbstractStorageVault.Create(AOwner: TComponent);
begin
  inherited;
  FBinaryStream := False;
  FSections := TStringList.Create;
  FActiveSection := '';
  FActiveSectionIndex := -1;
  FFilePrefix := ppProgram;
  FAppDataPath:=IDS_STOR_DEFAULTAPPDATAPATH;
  FCompressedStream := True;
end;

{------------------------------------------------------------------------------}
destructor TLMDAbstractStorageVault.Destroy;
begin
  FSections.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.Save(Stream: TMemoryStream);
var
  MS: TMemoryStream;
begin
  if Assigned(FStorageCryptor) and Encrypted then
  begin
    DoOnBeforeEncryption(Self, Stream);
    if FBinaryStream then FStorageCryptor.Encrypt(Stream);
    DoOnAfterEncryption(Self, Stream);
  end;
  if FBinaryStream and FCompressedStream then
  begin
    MS := TMemoryStream.Create;
    try
    Stream.Seek(0, soFromBeginning);
    MS.CopyFrom(Stream, Stream.Size);
      Stream.Clear;
    MS.Seek(0, soFromBeginning);
    LMDStorSaveCompressedStream(MS, Stream, MS.Size);
    finally
      FreeAndNil(MS);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.Load(Stream: TMemoryStream);
var
  MS: TMemoryStream;
begin
  if FBinaryStream and FCompressedStream then
  begin
    MS := TMemoryStream.Create;
    try
    Stream.Seek(0, soFromBeginning);
    MS.CopyFrom(Stream, Stream.Size);
      Stream.Clear;
    MS.Seek(0, soFromBeginning);
    LMDStorLoadCompressedStream(MS, Stream);
    finally
      FreeAndNil(MS);
    end;
  end;
  if Assigned(FStorageCryptor) and (Stream.Size > 0) and Encrypted then
    begin
      DoOnBeforeDecryption(Self, Stream);
      if FBinaryStream then FStorageCryptor.Decrypt(Stream);
      DoOnAfterDecryption(Self, Stream);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDAbstractStorageVault.EncryptString(Value: String): String;
var
  DoIt: Boolean;

  function StrEncode(const szStr: string): string;
  var
    i: integer;
    iCount: integer;
  begin
    Result:= '';
    iCount:= Length(szStr);
    for i:= 1 to iCount do
      if AnsiChar(szStr[i]) in [#0..#31,'%','"'] then
        Result:= Result + Format('%%%.2x', [Ord(szStr[i])])
      else
        Result:= Result + szStr[i];
  end;

begin
  if Assigned(FStorageCryptor) and (ctString in FStorageCryptor.CryptTypes)
   and Encrypted then
    begin
      DoIt := True;
      DoOnBeforeStringEncryption(Self, Value, DoIt);
      if DoIt then Result := FStorageCryptor.EncryptString(Value) else
       Result := Value;
      DoOnAfterStringEncryption(Self, Result);
    end else Result := Value;
    Result := StrEncode(Result);
end;

{------------------------------------------------------------------------------}
procedure TLMDAbstractStorageVault.FileChanged;
begin
  //do nothing in base class
end;

{------------------------------------------------------------------------------}
function TLMDAbstractStorageVault.DecryptString(Value: String): String;
var
  DoIt: Boolean;

function StrDecode(const AStr: string): string;

var
  Sp, Rp, Cp: PChar;
begin
  SetLength(Result, Length(AStr));
  Sp:= PChar(AStr);
  Rp:= PChar(Result);
  while Sp^ <> #0 do
    begin
      if Sp^ = '%' then
        begin
          Inc(Sp);
          Cp:= Sp;
          Inc(Sp);
          Rp^:= Chr(StrToInt(Format('$%s%s', [Cp^, Sp^])));
        end
      else
        Rp^:= Sp^;
      Inc(Rp);
      Inc(Sp);
    end;
  SetLength(Result, Rp - PChar(Result));
end;

begin
  value:=StrDecode(value);
  if Assigned(FStorageCryptor) and (ctString in FStorageCryptor.CryptTypes)
   and Encrypted then
    begin
      DoIt := True;
      DoOnBeforeStringDecryption(Self, Value, DoIt);
      if DoIt then Result := FStorageCryptor.DecryptString(Value) else
       Result := Value;
      DoOnAfterStringDecryption(Self, Result);
    end else Result := Value;
end;

{------------------------------------------------------------------------------}
function TLMDAbstractStorageVault.EncryptInteger(Value: Integer):
 Integer;
var
  DoIt: Boolean;
begin
  if Assigned(FStorageCryptor) and (ctInteger in FStorageCryptor.CryptTypes)
   and Encrypted then
    begin
      DoIt := True;
      DoOnBeforeIntegerEncryption(Self, Value, DoIt);
      if DoIt then Result := FStorageCryptor.EncryptInteger(Value) else
       Result := Value;
      DoOnAfterIntegerEncryption(Self, Result);
    end else Result := Value;
end;

{------------------------------------------------------------------------------}
function TLMDAbstractStorageVault.DecryptInteger(Value: Integer):
 Integer;
var
  DoIt: Boolean;
begin
  if Assigned(FStorageCryptor) and (ctInteger in FStorageCryptor.CryptTypes)
   and Encrypted then
    begin
      DoIt := True;
      DoOnBeforeIntegerDecryption(Self, Value, DoIt);
      if DoIt then Result := FStorageCryptor.DecryptInteger(Value) else
       Result := Value;
      DoOnAfterIntegerDecryption(Self, Result);
    end else Result := Value;
end;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{ TLMDStorComponent }

initialization
  {$I C3.INC}
{$ENDIF}

end.
