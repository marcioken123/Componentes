unit LMDObjectStorage;
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

LMDObjectStorage unit
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Windows,Classes,SysUtils, Registry, TypInfo, Consts, Forms,
     LMDCustomComponent, LMDZLib;

type
  // --> must be removed to own unit
  {****************** TLMDFormEventsHook **************************************}
  //----------------------------------------------------------------------------
  // This class hooks into the FormCreate, FormClose and FormDestroy Event of a
  // Form. Mainly used for components which save/restore certain states
  // of the component
  TLMDFormEventsHook=class(TLMDCustomComponent)
  private
    FEnabled,                 // replace Form Events?
    FHandled:Boolean;
    FOwnerFormCreate,
    FOwnerFormDestroy,
    FOnLoading,
    FOnSaving:TNotifyEvent;
    FOwnerFormClose:TCloseQueryEvent;
    function GetOwnerForm:TForm;
    procedure OwnerFormCreate(Sender:TObject);
    procedure OwnerFormDestroy(Sender:TObject);
    procedure OwnerFormClose(Sender:TObject; var CanClose:Boolean);
  protected
    procedure Loaded;override;
    procedure RestoreEvents;
    procedure SetEvents;
    // method for custom features in descendants
    procedure DoOnLoading;dynamic;
    procedure DoOnSaving;dynamic;
  public
    constructor Create(aOwner:TComponent);override;
    property Form:TForm read GetOwnerForm;
    property Enabled:Boolean read FEnabled write FEnabled default True;
    property OnLoading:TNotifyEvent read FOnLoading write FOnLoading;
    property OnSaving:TNotifyEvent read FOnSaving write FOnSaving;
  end;

  {****************** TLMDPropertyStorage *************************************}
  //----------------------------------------------------------------------------

  TLMDCustomObjectStorage=class;
  TLMDRegRoot=(rrCurrentUser, rrLocalMachine);

  //TLMDPropertyStorageItem
  TLMDPropertyStorageItem=class(TCollectionItem)
  private
    FName: String;
    FComponentName: String;
    procedure SetName(const Value: String);
    procedure SetComponentName(const Value: String);
  public
    constructor Create(Collection: TCollection);override;
  published
    property Name:String read FName write SetName;
    property ComponentName:String read FComponentName write SetComponentName;
  end;

  //TLMDPropertyStorage
  TLMDPropertyStorage=class(TCollection)
  private
    function GetItems(Index: Integer): TLMDPropertyStorageItem;
  public
    constructor Create(AOwner: TPersistent);
    function    Add:TLMDPropertyStorageItem;
    function    FindItem(szComponent,szProperty:String):TLMDPropertyStorageItem;
    property    Items[Index:Integer]:TLMDPropertyStorageItem read GetItems;default;
  end;

  //TLMDCustomObjectStorage
  TLMDCustomObjectStorage=class(TLMDFormEventsHook)
  private
    FCompressed: Boolean;
    FRegistryPath: String;
    FRegistryKey: TLMDRegRoot;
    FPropertyStorage : TLMDPropertyStorage;
    procedure SetRegistryPath(const Value: String);
    procedure SetRegistryKey(const Value: TLMDRegRoot);
    procedure SaveToRegistry;
    procedure LoadFromRegistry;
    procedure ClearRegistry;
    procedure ReadBoolean(Reader:TReader);
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure DoOnLoading;override;
    procedure DoOnSaving;override;
    property  Compressed:Boolean read FCompressed write FCompressed default false;
    property  RegistryPath:String read FRegistryPath write SetRegistryPath;
    property  RegistryKey:TLMDRegRoot read FRegistryKey write SetRegistryKey;
    property  Properties:TLMDPropertyStorage read FPropertyStorage write FPropertyStorage;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;
    procedure ClearData;
    procedure Load;
    procedure Save;
    procedure SaveToStream(Stream:TStream);virtual;
    procedure LoadFromStream(Stream:TStream);virtual;
    function  LoadFromFile(const szFileName:String):Boolean;virtual;
    function  SaveToFile(const szFileName:String):Boolean;virtual;
  end;

  //TLMDCustomObjectStorage
  TLMDObjectStorage=class(TLMDCustomObjectStorage)
  published
    property About;
    property Enabled;
    property Properties;
    property Compressed;
    property RegistryPath;
    property RegistryKey;
    property OnLoading;
    property OnSaving;
  end;

implementation
{*********************** TLMDFormEventsHook ***********************************}
{--------------------------- Private ------------------------------------------}
function TLMDFormEventsHook.GetOwnerForm:TForm;
begin
  result:=TForm(Owner);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEventsHook.OwnerFormCreate(Sender:TObject);
begin
  if FEnabled then
    try
      DoOnLoading;
    except
      // eat all Exceptions
    end;
  if Assigned(FOwnerFormCreate) then FOwnerFormCreate(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEventsHook.OwnerFormClose(Sender:TObject; var CanClose:Boolean);
begin
  if Assigned(FOwnerFormClose) then FOwnerFormClose(Sender, CanClose);
  if CanClose and FEnabled then
    try
      RestoreEvents;
    except
      // eat all Exceptions
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEventsHook.OwnerFormDestroy(Sender:TObject);
begin
  if FEnabled and not FHandled then  // for the case not already done after OnCloseQuery
    try
      RestoreEvents;
    except
      // eat all Exceptions
    end;
  if Assigned(FOwnerFormDestroy) then FOwnerFormDestroy(Sender);
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFormEventsHook.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then SetEvents;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEventsHook.SetEvents;
begin
  // Replace Form events with our own ones
  if Assigned(Form) then
    with Form do
      begin
        FOwnerFormClose:=OnCloseQuery;
        OnCloseQuery:=OwnerFormClose;
        FOwnerFormCreate:=OnCreate;
        OnCreate:=OwnerFormCreate;
        FOwnerFormDestroy:=OnDestroy;
        OnDestroy:=OwnerFormDestroy;
        FHandled:=True;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEventsHook.RestoreEvents;
begin
  // replace our Form events with the original ones
  if Assigned(Form) then
    begin
      Form.OnCloseQuery:=FOwnerFormClose;
      Form.OnCreate:=FOwnerFormCreate;
      Form.OnDestroy:=FOwnerFormDestroy;
      FHandled:=True;
      DoOnSaving;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEventsHook.DoOnLoading;
begin
  if Assigned(FOnLoading) then FOnLoading(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormEventsHook.DoOnSaving;
begin
  if Assigned(FOnSaving) then FOnSaving(self);
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFormEventsHook.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FEnabled:=True;
  FHandled:=False;
end;

// helper classes
{*********************** TLMDReader *******************************************}
type
  TLMDOSReader=class(TReader)
  public
    procedure LMDReadProperty;
  end;

{--------------------------- Public -------------------------------------------}
procedure TLMDOSReader.LMDReadProperty;
var
  Component : TComponent;
  szName    : String;
begin
  if Root=nil then exit;
  szName := ReadString;
  if Root.Name=szName then
    Component:=Root
  else
    Component := Root.FindComponent(szName);
  if Component=nil then
    raise EFilerError.Create('Can''t find component '+szName);
  if NextValue<>vaNull then
  begin
    ReadListBegin;
    while not EndOfList do
      ReadProperty(Component);
    ReadListEnd;
  end
  else
    ReadValue;
end;

{*********************** TLMDWriter *******************************************}
type
  TLMDOSWriter=class(TWriter)
  public
    procedure LMDWriteProperty(szComponent,szProperty:String);
  end;

{--------------------------- Public -------------------------------------------}
procedure TLMDOSWriter.LMDWriteProperty(szComponent, szProperty: String);
var
  Component : TComponent;
  I, Count: Integer;
  iPos    : Integer;
  vIdent  : TValueType;
  PropInfo: PPropInfo;
  PropList: PPropList;
begin
  if Root=nil then exit;
  if Root.Name=szComponent then
    Component:=Root
  else
    Component := Root.FindComponent(szComponent);
  if Component=nil then exit;
  Count := GetTypeData(Component.ClassInfo).PropCount;
  if Count > 0 then
  begin

    GetMem(PropList, Count * SizeOf(Pointer));

    try

      GetPropInfos(Component.ClassInfo, PropList);

      for I := 0 to Count - 1 do
      begin
        PropInfo := PropList[I];
        if PropInfo = nil then break;
        if  SameText(String(PropInfo.Name), szProperty) then
        begin
          WriteString(szComponent);
          iPos := Position;
          WriteListBegin;
          WriteProperty(Component, PropInfo);
          WriteListEnd;
          if iPos=Position then
          begin
            vIdent := vaNull;
            Write(Byte(vIdent), SizeOf(vIdent));
          end;
          break;
        end;
      end;
    finally

      FreeMem(PropList, Count * SizeOf(Pointer));

    end;
  end;
end;

{ TLMDPropertyStorageItem }
{------------------------------------------------------------------------------}
constructor TLMDPropertyStorageItem.Create(Collection: TCollection);
begin
  inherited;
  FName := '';
end;

{------------------------------------------------------------------------------}
procedure TLMDPropertyStorageItem.SetComponentName(const Value: String);
begin
  FComponentName := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDPropertyStorageItem.SetName(const Value: String);
begin
  FName := Value;
end;

{ TLMDPropertyStorage }
{------------------------------------------------------------------------------}
function TLMDPropertyStorage.Add: TLMDPropertyStorageItem;
begin
  Result := TLMDPropertyStorageItem(inherited Add);
end;

{------------------------------------------------------------------------------}
constructor TLMDPropertyStorage.Create(AOwner: TPersistent);
begin
  inherited Create({AOwner,}TLMDPropertyStorageItem);
end;

{------------------------------------------------------------------------------}
function TLMDPropertyStorage.FindItem(szComponent, szProperty: String): TLMDPropertyStorageItem;
var
  i : Integer;
begin
  Result := nil;
  for i:=0 to Count-1 do
  begin
    if (Items[i].FComponentName=szComponent) and (Items[i].FName=szProperty) then
    begin
      Result := Items[i];
      break;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDPropertyStorage.GetItems(Index: Integer): TLMDPropertyStorageItem;
begin
  Result := TLMDPropertyStorageItem(inherited Items[Index]);
end;

{*********************** TLMDCustomObjectStorage ******************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDCustomObjectStorage.SetRegistryPath(const Value: String);
begin
  FRegistryPath := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.SetRegistryKey(const Value: TLMDRegRoot);
begin
  FRegistryKey := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.SaveToRegistry;
var
  Reg : TRegistry;
  MS  : TMemoryStream;
begin
  if FRegistryPath='' then exit;
  Reg := TRegistry.Create;
  try
    case FRegistryKey of
      rrCurrentUser : Reg.RootKey := HKEY_CURRENT_USER;
      rrLocalMachine: Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;
    if Reg.OpenKey(ExtractFilePath(FRegistryPath),True) then
    begin
      MS := TMemoryStream.Create;
      try
        SaveToStream(MS);

        Reg.WriteBinaryData(ExtractFileName(FRegistryPath),MS.Memory^,MS.Size);

      finally
        MS.Free;
      end;
    end;
  except
  end;
  Reg.Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.LoadFromRegistry;
var
  Reg : TRegistry;
  MS  : TMemoryStream;
  i   : Integer;
begin
  if FRegistryPath='' then exit;
  Reg := TRegistry.Create;
  try
    case FRegistryKey of
      rrCurrentUser : Reg.RootKey := HKEY_CURRENT_USER;
      rrLocalMachine: Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;
    if Reg.OpenKey(ExtractFilePath(FRegistryPath),False) then
    begin
      MS := TMemoryStream.Create;
      try
        i := Reg.GetDataSize(ExtractFileName(FRegistryPath));
        if i>0 then
        begin
          MS.Size := i;

          Reg.ReadBinaryData(ExtractFileName(FRegistryPath),MS.Memory^,MS.Size);

          LoadFromStream(MS);
        end;
      finally
        MS.Free;
      end;
    end;
  except
  end;
  Reg.Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.ClearRegistry;
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    case FRegistryKey of
      rrCurrentUser : Reg.RootKey := HKEY_CURRENT_USER;
      rrLocalMachine: Reg.RootKey := HKEY_LOCAL_MACHINE;
    end;
    if Reg.OpenKey(ExtractFilePath(FRegistryPath),False) then
    begin
      Reg.DeleteValue(ExtractFileName(FRegistryPath));
    end;
  except
  end;
  Reg.Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.ReadBoolean(Reader:TReader);
begin
  Reader.ReadBoolean;
end;

{------------------------- protected ------------------------------------------}
procedure TLMDCustomObjectStorage.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties( Filer ) ;
  Filer.DefineProperty( 'AutoLoad', ReadBoolean, nil, false );
end;
{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.DoOnLoading;
begin
  inherited DoOnLoading;
  If FEnabled and not (csDesigning in ComponentState) then Load;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.DoOnSaving;
begin
  If FEnabled and not (csDesigning in ComponentState) then Save;
  inherited DoOnSaving;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDCustomObjectStorage.Create(AOwner: TComponent);
begin
  inherited;
  FPropertyStorage := TLMDPropertyStorage.Create(Self);
  FCompressed:=False;
  FRegistryPath := '';
  FRegistryKey  := rrCurrentUser;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomObjectStorage.Destroy;
begin
  FPropertyStorage.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCustomObjectStorage.LoadFromFile(const szFileName: String): Boolean;
var
  FileStream : TFileStream;
begin
  try
    FileStream := TFileStream.Create(szFileName, fmOpenRead or fmShareDenyWrite);
    try
      LoadFromStream(FileStream);
    finally
      FileStream.Free;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.LoadFromStream(Stream: TStream);
var
  Reader : TLMDOSReader;
  ZStream: TLMDDecompressionStream;
begin
  if FCompressed then
    begin
      ZStream := TLMDDecompressionStream.Create(Stream);
      Reader := TLMDOSReader.Create(ZStream,4096);
      try
        Reader.BeginReferences;
        Reader.ReadListBegin;
        Reader.Root := Owner;
        while not Reader.EndOfList do
          Reader.LMDReadProperty;
        Reader.ReadListEnd;
        Reader.FixupReferences;
        Reader.EndReferences;
      finally
        Reader.Free;
        ZStream.Free;
      end;
    end
  else
  begin
      Reader := TLMDOSReader.Create(Stream,4096);
      try
        Reader.BeginReferences;
        Reader.ReadListBegin;
        Reader.Root := Owner;
        while not Reader.EndOfList do
          Reader.LMDReadProperty;
        Reader.ReadListEnd;
        Reader.FixupReferences;
        Reader.EndReferences;
      finally
        Reader.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.SaveToStream(Stream: TStream);
var
  Writer : TLMDOSWriter;
  i      : Integer;
  ZStream: TLMDCompressionStream;
begin
  if FCompressed then
    begin
      ZStream := TLMDCompressionStream.Create(clMax, Stream);
      Writer := TLMDOSWriter.Create(ZStream,4096);
      try
        Writer.Root := Owner;
        Writer.WriteListBegin;
        for i:=0 to FPropertyStorage.Count-1 do
          Writer.LMDWriteProperty(FPropertyStorage[i].FComponentName,FPropertyStorage[i].Name);
        Writer.WriteListEnd;
      finally
        Writer.Free;
        ZStream.Free;
      end;
    end
  else
  begin
      Writer := TLMDOSWriter.Create(Stream,4096);
      try
        Writer.Root := Owner;
        Writer.WriteListBegin;
        for i:=0 to FPropertyStorage.Count-1 do
          Writer.LMDWriteProperty(FPropertyStorage[i].FComponentName,FPropertyStorage[i].Name);
        Writer.WriteListEnd;
      finally
        Writer.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomObjectStorage.SaveToFile(const szFileName: String): Boolean;
var
  FileStream : TFileStream;
begin
  try
    FileStream := TFileStream.Create(szFileName,fmCreate);
    try
      SaveToStream(FileStream);
    finally
      FileStream.Free;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.Load;
begin
  LoadFromRegistry;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.Save;
begin
  SaveToRegistry;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomObjectStorage.ClearData;
begin
  ClearRegistry;
end;

end.
