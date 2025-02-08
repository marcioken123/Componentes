unit LMDStorControllerVault;
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

LMDStorControllerVault unit (VO)
------------------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Classes, SysUtils, Graphics, TypInfo, Controls, Windows, Types,
     LMDStorBase, LMDStorPropertiesStorage;

type
  {-------------------  Class TLMDStorCustomControllerVault -------------------}
  TLMDStorCustomControllerVault = class(TLMDAbstractStorageVault)
  private
    procedure SetStorageVault(const Value: TLMDAbstractStorageVault);
  protected
    FStorageVault: TLMDAbstractStorageVault;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
  property StorageVault: TLMDAbstractStorageVault read FStorageVault write SetStorageVault;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save(Stream: TMemoryStream); override;
    procedure Load(Stream: TMemoryStream); override;
    procedure Open; override;
    procedure Close; override;
    procedure Update; override;
    function KeyExists(const Key: string; Section: string = ''): Boolean;override;
    procedure ReadKeys(Strings: TStrings; Section: string = ''); override;
    function KeyCount(Section: string = ''): Integer; override;
    function SectionExists(const Section: string): Boolean; override;
    procedure AddSection(const Section: string); override;
    function RenameSection(const OldName, NewName: string): Boolean; override;
    function RemoveSection(const Section: string): Boolean; override;
    function DeleteSection(const Section: string): Boolean; override;
    function ClearSection(const Section: string): Boolean; override;
    procedure DeleteKey(const Section, Ident: string); override;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); override;
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean;override;
    procedure WriteColor(const Section, Ident: string; Value: TColor); override;
    function ReadColor(const Section, Ident: string; Default: TColor): TColor;override;
    procedure WriteComponent(const Instance: TComponent;const Section: string = ''); override;
    function ReadComponent(const Section: string; Instance: TComponent):TComponent; override;
    procedure WriteDate(const Section, Ident: string; Value: TDateTime);override;
    function ReadDate(const Section, Ident: string; Default: TDateTime):TDateTime; override;
    procedure WriteDateTime(const Section, Ident: string; Value: TDateTime);override;
    function ReadDateTime(const Section, Ident: string; Default: TDateTime):TDateTime; override;
    procedure WriteFloat(const Section, Ident: string; Value: Double);override;
    function ReadFloat(const Section, Ident: string; Default: Double):Double; override;
    procedure WriteObject(const Section, Ident: string; Instance: TPersistent);override;
    function ReadObject(const Section, Ident: string; Instance: TPersistent):TPersistent; override;
    procedure WriteFont(const Section, Ident: string; Instance: TFont);override;
    function ReadFont(const Section, Ident: string; Instance: TFont): TFont;override;
    procedure WriteInteger(const Section, Ident: string; Value: LongInt);override;
    function ReadInteger(const Section, Ident: string; Default: LongInt):LongInt; override;
    procedure WriteInt64(const Section, Ident: string; Value: Int64); override;
    function ReadInt64(const Section, Ident: string; Default: Int64): Int64;override;
    procedure WritePoint(const Section, Ident: string; Value: TPoint); override;
    function ReadPoint(const Section, Ident: string; Default: TPoint): TPoint;override;
    procedure WriteRect(const Section, Ident: string; Value: TRect); override;
    function ReadRect(const Section, Ident: string; Default: TRect): TRect;override;
    procedure WriteString(const Section, Ident: string; Value: string);override;
    function ReadString(const Section, Ident: string; Default: string): string;override;
    procedure WriteStrings(const Section, Ident: string; Value: TStrings);override;
    procedure ReadStrings(const Section, Ident: string; Value: TStrings);override;
    procedure WriteTime(const Section, Ident: string; Value: TDateTime);override;
    function ReadTime(const Section, Ident: string; Default: TDateTime):TDateTime; override;
    procedure ReadSection (const Section: String; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
  end;

  {-------------------  Class TLMDStorControllerVault -------------------------}
  TLMDStorControllerVault = class(TLMDStorCustomControllerVault)
  published
    property StorageVault;
    property OnBeforeOpen;
    property OnAfterOpen;
    property OnBeforeClose;
    property OnAfterClose;
    property OnSectionAdd;
    property OnSectionDelete;
    property OnLoadStream;
    property OnSaveStream;
    property OnBeforeEncryption;
    property OnAfterEncryption;
    property OnBeforeDecryption;
    property OnAfterDecryption;
    property OnBeforeStringEncryption;
    property OnAfterStringEncryption;
    property OnBeforeStringDecryption;
    property OnAfterStringDecryption;
    property OnBeforeIntegerEncryption;
    property OnAfterIntegerEncryption;
    property OnBeforeIntegerDecryption;
    property OnAfterIntegerDecryption;    
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
   dialogs;
  {$I C2.INC}
{$ENDIF}

{********************* TLMDStorCustomControllerVault **************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorCustomControllerVault.Notification(AComponent: TComponent;Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent <> nil) then
    begin
      if (AComponent = FStorageVault) then
        StorageVault := nil;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.SetStorageVault(const Value: TLMDAbstractStorageVault);
begin
  if (FStorageVault<>Value) and not (Value is TLMDStorCustomControllerVault) then
    begin
      if FStorageVault<>nil then
        FStorageVault.RemoveFreeNotification(Self);
      FStorageVault := Value;
      if FStorageVault<> nil then
        FStorageVault.FreeNotification(Self)
    end;
end;

{------------------------- Public----------------------------------------------}
constructor TLMDStorCustomControllerVault.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{------------------------------------------------------------------------------}
destructor TLMDStorCustomControllerVault.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.Save(Stream: TMemoryStream);
begin
  DoOnSaveStream(self, Stream);
  if Assigned(FStorageVault) then FStorageVault.Save(Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.Load(Stream: TMemoryStream);
begin
  if Assigned(FStorageVault) then FStorageVault.Load(Stream);
  DoOnLoadStream(self, Stream);  
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.Open;
begin
  DoOnBeforeOpen(self);
  if Assigned(FStorageVault) then FStorageVault.Open;
  DoOnAfterOpen(self);  
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.Close;
begin
  DoOnBeforeClose(self);
  if Assigned(FStorageVault) then FStorageVault.Close;
  DoOnAfterClose(self);  
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.Update;
begin
  if Assigned(FStorageVault) then FStorageVault.Update;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.KeyExists(const Key: string;
  Section: string = ''): Boolean;
begin
  Result := False;
  if Assigned(FStorageVault) then
   Result := FStorageVault.KeyExists(Key, Section); 
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.ReadKeys(Strings: TStrings;
  Section: string = '');
begin
  if Assigned(FStorageVault) then FStorageVault.ReadKeys(Strings, Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.KeyCount(Section: string = ''): Integer;
begin
  Result := 0;
  if Assigned(FStorageVault) then Result := FStorageVault.KeyCount(Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.SectionExists(const Section: string):
 Boolean;
begin
  Result := False;
  if Assigned(FStorageVault) then
   Result := FStorageVault.SectionExists(Section);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.AddSection(const Section: string);
begin
  if Assigned(FStorageVault) then FStorageVault.AddSection(Section);
  DoOnAfterClose(self);  
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.RenameSection
 (const OldName, NewName: string): Boolean;
begin
  Result := False;
  if Assigned(FStorageVault) then
   Result := FStorageVault.RenameSection(OldName, NewName);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.RemoveSection
 (const Section: string): Boolean;
begin
  Result := False;
  if Assigned(FStorageVault) then
   Result := FStorageVault.RemoveSection(Section);
  DoOnSectionDelete(self, Section);   
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.DeleteSection
 (const Section: string): Boolean;
begin
  Result := False;
  if Assigned(FStorageVault) then
   Result := FStorageVault.DeleteSection(Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ClearSection
 (const Section: string): Boolean;
begin
  Result := False;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ClearSection(Section);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.DeleteKey(const Section, Ident: string);
begin
  if Assigned(FStorageVault) then FStorageVault.DeleteKey(Section, Ident);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteBool(const Section, Ident: string;
  Value: Boolean);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteBool(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadBool(const Section,
  Ident: string; Default: Boolean): Boolean;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadBool(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteColor(const Section, Ident: string;
  Value: TColor);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteColor(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadColor(const Section, Ident: string;
  Default: TColor): TColor;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadColor(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteComponent
 (const Instance: TComponent; const Section: string = '');
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteComponent(Instance, Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadComponent(const Section: string;
  Instance: TComponent): TComponent;
begin
  Result := Instance;
  If Assigned(FStorageVault) then
   Result := FStorageVault.ReadComponent(Section, Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteDate(const Section, Ident: string;
  Value: TDateTime);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteDate(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadDate(const Section, Ident: string;
  Default: TDateTime): TDateTime;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadDate(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteDateTime
 (const Section, Ident: string; Value: TDateTime);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteDateTime(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadDateTime
 (const Section, Ident: string; Default: TDateTime): TDateTime;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadDateTime(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteFloat(const Section, Ident: string;
  Value: Double);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteFloat(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadFloat(const Section, Ident: string;
  Default: Double): Double;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadFloat(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteObject
 (const Section, Ident: string; Instance: TPersistent);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteObject(Section, Ident, Instance);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadObject(const Section, Ident: string;
  Instance: TPersistent): TPersistent;
begin
  Result := Instance;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadObject(Section, Ident, Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteFont(const Section, Ident: string;
  Instance: TFont);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteFont(Section, Ident, Instance);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadFont(const Section, Ident: string;
  Instance: TFont): TFont;
begin
  Result := Instance;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadFont(Section, Ident, Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteInteger
 (const Section, Ident: string; Value: LongInt);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteInteger(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadInteger(const Section, Ident: string;
  Default: LongInt): LongInt;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadInteger(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteInt64(const Section, Ident: string;
  Value: Int64);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteInt64(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadInt64(const Section, Ident: string;
  Default: Int64): Int64;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadInt64(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WritePoint(const Section, Ident: string;
  Value: TPoint);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WritePoint(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadPoint(const Section, Ident: string;
  Default: TPoint): TPoint;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadPoint(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteRect(const Section, Ident: string;
  Value: TRect);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteRect(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadRect(const Section, Ident: string;
  Default: TRect): TRect;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadRect(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteString
 (const Section, Ident: string; Value: string);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteString(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadString(const Section, Ident: string;
  Default: string): string;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadString(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteStrings
 (const Section, Ident: string; Value: TStrings);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteStrings(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.ReadStrings
 (const Section, Ident: string; Value: TStrings);
begin
  if Assigned(FStorageVault) then
   FStorageVault.ReadStrings(Section, Ident, Value); 
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.WriteTime(const Section, Ident: string;
 Value: TDateTime);
begin
  if Assigned(FStorageVault) then
   FStorageVault.WriteTime(Section, Ident, Value);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomControllerVault.ReadTime(const Section, Ident: string;
 Default: TDateTime): TDateTime;
begin
  Result := Default;
  if Assigned(FStorageVault) then
   Result := FStorageVault.ReadTime(Section, Ident, Default);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.ReadSection
 (const Section: String; Strings: TStrings);
begin
  if Assigned(FStorageVault) then FStorageVault.ReadSection(Section, Strings);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomControllerVault.ReadSections(Strings: TStrings);
begin
  if Assigned(FStorageVault) then FStorageVault.ReadSections(Strings);
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
