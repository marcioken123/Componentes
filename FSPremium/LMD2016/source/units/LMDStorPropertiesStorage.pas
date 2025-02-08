unit LMDStorPropertiesStorage;
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

LMDStorPropertiesStorage unit (VO)
---------------------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Forms, TypInfo, Consts, Variants,
  LMDStorBase, LMDStorFormHook, LMDStorCommon;

const
  cComplexPropDelimiter: string = '/';

type
  {------------------- Class TLMDPropertiesComponentEditor --------------------}
  TLMDStorPropertyStorageItem = class(TCollectionItem)
  private
    FPropertyName: string;
    FComponentName: string;
    procedure SetPropertyName(const Value: string);
    procedure SetComponentName(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
  published
    property PropertyName: string read FPropertyName write SetPropertyName;
    property ComponentName: string read FComponentName write SetComponentName;
  end;

  {------------------- Class TLMDStorPropertyStorageItems ---------------------}
  TLMDStorPropertyStorageItems = class(TCollection)
  private
    function GetItems(Index: Integer): TLMDStorPropertyStorageItem;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TLMDStorPropertyStorageItem;
    function FindItem(szComponent, szProperty: string):
     TLMDStorPropertyStorageItem;
    property Items[Index: Integer]:
     TLMDStorPropertyStorageItem read GetItems; default;
  end;

  {-------------------- Class TLMDStorCustomProperty --------------------------}
  TLMDStorCustomProperty = class(TCollectionItem)
  private
    FName: string;
    FValue: Variant;
    procedure SetName(const Value: string);
    procedure SetValue(const Value: Variant);
  public
    constructor Create(Collection: TCollection); override;
  published
    property Name: string read FName write SetName;
    property Value: Variant read FValue write SetValue;
  end;

  {-------------------- Class TLMDStorCustomProperties ------------------------}
  TLMDStorCustomProperties = class(TOwnedCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TLMDStorCustomProperty;
  protected
    function GetOwner: TPersistent; reintroduce;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TLMDStorCustomProperty;
    function FindItem(Name: string): TLMDStorCustomProperty;
    property Items[Index: Integer]: TLMDStorCustomProperty
     read GetItems; default;
  end;

  {-------------------- Class TLMDStorCustomPropertiesStorage -----------------}
  TLMDNotFoundEventNotify = procedure(Sender: TObject; const CompName: string;
    var RaiseException: Boolean) of object;

  TLMDStorCustomPropertiesStorage = class(TLMDStorFormHook)
  private
    FOnNoStorageData : TNotifyEvent;
    FOnLoadData      : TLMDStorStreamEvent;
    FOnSaveData      : TLMDStorStreamEvent;
    FID              : Integer;
    FOnNotFound      : TLMDNotFoundEventNotify;
    FComplexPropDelimiter: string;
    procedure SetStorageVault(const Value: TLMDAbstractStorageVault);
    procedure ComponentNotFound(Sender: TObject; const CompName: string; var RaiseException: Boolean);
    function GetComplexPropDelimiter: string;
    procedure SetComplexPropDelimiter(const Value: string);
  protected
    FPropertyStorage: TLMDStorPropertyStorageItems;
    FStorageVault: TLMDAbstractStorageVault;
    FCustomProperties: TLMDStorCustomProperties;
    FEnabled: Boolean;
    FAutoLoad: Boolean;
    FAutoSave: Boolean;
    FSkipNotFoundComponents: Boolean;
    function IsPropListEmpty: boolean; virtual;
    procedure OwnerFormCreate(Sender: TObject); override;
    procedure OwnerFormDestroy(Sender: TObject); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoOnLoading; override;
    procedure DoOnSaving; override;
    procedure DoOnLoadData(Sender: TObject; var Stream: TMemoryStream); dynamic;
    procedure DoOnSaveData(Sender: TObject; var Stream: TMemoryStream); dynamic;
    property Properties: TLMDStorPropertyStorageItems read FPropertyStorage write FPropertyStorage;
    property StorageVault: TLMDAbstractStorageVault read FStorageVault write SetStorageVault;
    property CustomProperties: TLMDStorCustomProperties read FCustomProperties write FCustomProperties;
    property Enabled: Boolean read FEnabled write FEnabled  default true;
    property AutoLoad: Boolean read FAutoLoad write FAutoLoad default true;
    property AutoSave: Boolean read FAutoSave write FAutoSave  default true;
    property ComplexPropDelimiter: string read GetComplexPropDelimiter write SetComplexPropDelimiter;
    property OnLoadData: TLMDStorStreamEvent read FOnLoadData write FOnLoadData;
    property OnSaveData: TLMDStorStreamEvent read FOnSaveData write FOnSaveData;
    property OnNoStorageData: TNotifyEvent read FOnNoStorageData write FOnNoStorageData;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveToStream(Stream: TStream); virtual;
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure Save; virtual;
    procedure Load; virtual;
    property ID: Integer read FID;
    property SkipNotFoundComponents: Boolean read FSkipNotFoundComponents write FSkipNotFoundComponents;
    property OnNotFound : TLMDNotFoundEventNotify read FOnNotFound write FOnNotFound;
  end;

  {-------------------- Class TLMDStorPropertiesStorage -----------------------}
  TLMDStorPropertiesStorage = class(TLMDStorCustomPropertiesStorage)
  published
    property Properties;
    property Enabled;
    property CustomProperties;
    property ComplexPropDelimiter;
    property StorageVault;
    property SkipNotFoundComponents;
    property AutoLoad;
    property AutoSave;
    property OnLoading;
    property OnSaving;
    property OnLoadData;
    property OnSaveData;
    property OnNotFound;
  end;

implementation

uses
  SysUtils, Comctrls, Controls

{$IFDEF LMD_DEBUGTRACE}
  , Windows, Dialogs;
  {$I C2.INC}
{$ELSE};{$ENDIF}

// helper functions
function GetItem(szProperty: String): Integer;
var
  s, e: integer;
begin
  Result := -1;
  s := pos('(', szProperty);
  e := pos(')', szProperty);
  if (s = 0) or (e = 0) or (e < s) then exit;
  Result := StrToInt(copy(szProperty, s + 1, e - s - 1));
end;

function LMDFindComponent(Root: TComponent; name: string): TComponent;
var
  I, J : integer;
  n1 : string;
begin
  n1 := copy(name, 1, pos('.', name + '.') - 1);
  if Root.name = n1 then
    Result := Root
  else
    Result := Root.FindComponent(n1);

  if not assigned(Result) then
    for i := 0 to Screen.FormCount - 1 do
      if Screen.Forms[i].Name = n1 then
      begin
        result := LMDFindComponent(Screen.Forms[i],
          copy(name, pos('.', name + '.') + 1, length(name)));
        break;
      end
      else
        if n1 <> name then
        begin
          result := LMDFindComponent(result,
            copy(name, pos('.', name + '.') + 1, length(name)));
        end else begin
          J := 0;
          while (J < Screen.Forms[i].ComponentCount) and (Result = nil) do
          begin
            if Screen.Forms[i].Components[J] is TFrame then
              Result := Screen.Forms[i].Components[J].FindComponent(name);
            Inc(J);
          end;
        end;
end;

// helper classes
{********************* TLMDOSReader *******************************************}
type
  TLMDOSReader = class(TReader)
  private
    FSkipNotFoundComponents : Boolean;
    FDataFound              : Boolean;
    FOnNotFound             : TLMDNotFoundEventNotify;
    FComplexPropDelimiter   : string;
    function ClearObject(AObject: TObject):boolean;
  protected
    procedure DoNotFound(const CompName: string; var RaiseException: Boolean);
  public
    procedure LMDReadProperty;
    procedure LMDReadComplexProperty(Chain: String);
    property OnNotFound : TLMDNotFoundEventNotify read FOnNotFound write FOnNotFound;
  end;

{------------------------------------------------------------------------------}
procedure TLMDOSReader.LMDReadProperty;
var
  Component: TComponent;
  szName: string;
  RaiseException : Boolean;
begin
  if Root = nil then exit;
  szName := ReadString;
  if Pos(FComplexPropDelimiter, szName) > 0 then
    LMDReadComplexProperty(szName)
  else
  begin
    if Root.Name = szName then
      Component := Root
    else
      Component := LMDFindComponent(Root, szName);
    if Component = nil then
      begin
        RaiseException := not FSkipNotFoundComponents;
        DoNotFound(szName, RaiseException);
        if RaiseException then
          raise EFilerError.Create('Can''t find component ' + szName);
      end;  
    if Component <> nil then
    begin
      if NextValue <> vaNull then
        begin
          ReadListBegin;
          while not EndOfList do
            begin
              if ClearObject(Component) then
                ReadProperty(Component);
              FDataFound := True;
            end;
          ReadListEnd;
        end
      else
        ReadValue;
    end else
    if FSkipNotFoundComponents then
    begin
      ReadListBegin;
      while not EndOfList do
        SkipProperty;
      ReadListEnd;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDOSReader.LMDReadComplexProperty(Chain: String);
var
  Component: TComponent;
  AObject: TPersistent;
  TSOst, TSTek, szRoot, szChain: string;
  i: integer;
begin
  if Root = nil then exit;
  i := Pos(FComplexPropDelimiter, Chain);
  if i = 0 then exit;

  szRoot := copy(Chain, 1, i - 1);
  szChain := copy(Chain, i + 1, length(Chain) - i);

  if Root.Name = szRoot then
    Component := Root
  else
    Component := Root.FindComponent(szRoot);
  if Component = nil then
    raise EFilerError.Create('Can''t find component ' + szRoot);

  AObject := Component;

  TSOst := szChain;
  i := Pos(FComplexPropDelimiter, TSOst);
  if i > 0 then
  begin
    while TSOst <> '' do
    begin
      i := Pos(FComplexPropDelimiter, TSOst);
      if i > 0 then
      begin
        TSTek := copy(TSOst, 1, i - 1);
        TSost := copy(TSOst, i + 1, length(TSOst) - i);
      end else
      begin
        TSTek := TSost;
        TSost := '';
      end;
      if (Pos('(', TSTek) > 0) and (AObject is TCollection) then
        AObject := TCollection(AObject).Items[GetItem(TSTek)] else
        AObject := TPersistent(GetObjectProp(AObject, TSTek));
    end;
  end else
  begin
    if Pos('(', TSOst) > 0 then
     AObject := TCollection(aObject).Items[GetItem(TSOst)]
    else
     AObject := TPersistent(GetObjectProp(aObject, TSOst));
  end;

  if NextValue <> vaNull then
    begin
      ReadListBegin;
      while not EndOfList do begin
        if ClearObject(AObject) then
          ReadProperty(AObject);
      End;
      ReadListEnd;
    end
  else
    ReadValue;
end;

{------------------------------------------------------------------------------}
function TLMDOSReader.ClearObject(AObject: TObject):boolean;
var
  PropPos: longint;
  PropName: string;

  PropInfo: PPropInfo;

  PropObj: TObject;
begin
  PropPos := Position;
  PropName := ReadStr;
  PropName := Copy(PropName, 1, pos('.', PropName + '.') - 1);
  PropInfo := GetPropInfo(AObject, PropName);
  if (PropInfo<>nil) and
  (PropInfo.PropType^.Kind=tkClass)
  then 
    begin
      PropObj:=GetObjectProp(AObject, PropInfo);
      if (PropObj is TCollection)  then 
        (PropObj as TCollection).Clear;
      if (PropObj is TListItems)  then 
        (PropObj as TListItems).Clear;
      if (PropObj is TStrings)  then  
        (PropObj as TStrings).Clear;
      if (PropObj is TList)  then 
        (PropObj as TList).Clear;
      if (PropObj is TTreeNodes)  then 
        (PropObj as TTreeNodes).Clear;
    End;

  if NextValue in [vaList,vaCollection] then
    ReadValue;
    Result := NOT EndOfList; // Object not empty
  if result then
    Position := PropPos  // Read object
  else
    ReadListEnd;
End;

{------------------------------------------------------------------------------}
procedure TLMDOSReader.DoNotFound(const CompName: string; var RaiseException: Boolean);
begin
  if Assigned(FOnNotFound) then FOnNotFound(Self, CompName, RaiseException);
end;

{********************* TLMDOSWriter *******************************************}
type
  TLMDOSWriter = class(TWriter)
  public
    FSkipNotFoundComponents: Boolean;
    FComplexPropDelimiter: string;
    procedure LMDWriteProperty(szComponent, szProperty: string); virtual;
    procedure LMDWriteComplexProperty(szComponent, szChain: string);
    procedure ForceWriteProperty(Instance: TPersistent; PropInfo: TPropInfo); virtual;//unsafe;
    procedure DefineProperty(const Name: string;
      ReadData: TReaderProc; WriteData: TWriterProc;
      HasData: Boolean); override;
  end;

{------------------------------------------------------------------------------}
procedure TLMDOSWriter.LMDWriteProperty(szComponent, szProperty: string);
var
  Component: TComponent;

  PropInfo : PPropInfo;

  iPos: Integer;
begin
  Component := LMDFindComponent(Root, szComponent);
  if not assigned(Component) then
  begin
    if not FSkipNotFoundComponents then
       raise EFilerError.Create('Component '#39+szComponent+#39' not found.');
    exit;
  end;
  PropInfo := GetPropInfo(Component, szProperty);
  if not assigned(PropInfo) then
  begin
    if not FSkipNotFoundComponents then
       raise EFilerError.Create('Property '#39+szComponent+'.'+szProperty+#39' not exists.');
    exit;
  end;
  WriteString(szComponent);
  iPos := Position;
  WriteListBegin;

  ForceWriteProperty(Component, PropInfo^);

  WriteListEnd;
  if iPos = Position then
  begin
    WriteValue(vaNull)
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDOSWriter.ForceWriteProperty(Instance: TPersistent; PropInfo:
  TPropInfo);
var

  PropType: PTypeInfo;

  vMetod: TMethod;
  vIdent: string;
  IntToIdent: TIntToIdent;
  I: Integer;

  procedure WriteObjectProp;
  var
    vObject: TObject;
    ComponentValue: string;
    PropPos:longint;

    function GetComponentValue(Component: TComponent): string;
    begin
      if Component.Owner = LookupRoot then
        Result := Component.Name
      else if Component = LookupRoot then
        Result := 'Owner' { Do not translate }
      else if (Component.Owner <> nil) and (Component.Owner.Name <> '') and
        (Component.Name <> '') then
        Result := Component.Owner.Name + '.' + Component.Name
      else if Component.Name <> '' then
        Result := Component.Name + '.Owner' { Do not translate }
      else
        Result := '';
    end;
    begin

    vObject := TObject(GetOrdProp(Instance, @PropInfo));

    if (vObject = nil) then
    begin
      WritePropName(String(PropInfo.Name));
      WriteValue(vaNil);
    end
    else
    if vObject is TPersistent then
      if vObject is TComponent then
      begin
        ComponentValue := GetComponentValue(TComponent(vObject));
        WritePropName(String(PropInfo.Name));
        if ComponentValue <> '' then
          WriteIdent(ComponentValue)
        else
          WriteValue(vaNil);
        end
      else 
      if (vObject is TStrings)and((vObject as TStrings).Count=0) then begin
        // For empty TStrings. It cann read empty list, but can not write
        FlushBuffer;
        WriteStr(PropInfo.Name+'.Strings'); { Do not translate }
        WriteListBegin;
        WriteListEnd;
      end
      else begin
        PropPos:=Position;

        WriteProperty(Instance,@PropInfo);

        // If object not writed, insert empty one for custom reading
        if (PropPos=Position)and(
//          (vObject is TStrings) or
          (vObject is TCollection) or
          (vObject is TListItems) or
          (vObject is TList) or
          (vObject is TTreeNodes))
        then Begin
           WritePropName(String(PropInfo.Name));
           WriteListBegin;
           WriteListEnd;
        End;
      End;
  end;

begin

  PropType := PropInfo.PropType^;
  if PropType.Kind <> tkClass then

    WritePropName(String(PropInfo.Name));

  case PropType.Kind of

    tkInteger:
      begin
      IntToIdent := FindIntToIdent(PropInfo.PropType);
      if Assigned(IntToIdent) and IntToIdent(
        GetOrdProp(Instance, @PropInfo), vIdent) then
          WriteIdent(vIdent)
        else
          WriteInteger(GetOrdProp(Instance, @PropInfo));
      end;

    tkSet:
      begin
        WriteValue(vaSet);
        for I := 0 to SizeOf(Longint) * 8 - 1 do
          if (GetOrdProp(Instance, @PropInfo) shr I)and $1 <>0 then
            WriteStr(AnsiString(GetEnumName(GetTypeData(PropType).CompType^, I)));
        WriteStr('');
      end;
      tkEnumeration: WriteIdent(GetEnumName(PropType, GetOrdProp(Instance, @PropInfo)));
    tkChar: WriteChar(Chr(GetOrdProp(Instance, @PropInfo)));
    tkFloat: WriteFloat(GetFloatProp(Instance, @PropInfo));
    {$ifdef LMDCOMP12}
    tkUString,
    {$endif}
    tkString,
    tkLString,
    tkWString: WriteString(GetStrProp(Instance, @PropInfo));
    tkVariant: WriteVariant(GetVariantProp(Instance, @PropInfo));
    tkInt64: WriteInteger(GetInt64Prop(Instance, @PropInfo));
    tkMethod:
      begin
        vMetod := GetMethodProp(Instance, @PropInfo);
        if vMetod.Code = nil then
          WriteValue(vaNil)
        else
          WriteIdent(LookupRoot.MethodName(vMetod.Code));
      end;
    tkClass:
      begin
        WriteObjectProp;
      end;
  end;
end;

procedure TLMDOSWriter.DefineProperty(const Name: string;
  ReadData: TReaderProc; WriteData: TWriterProc; HasData: Boolean);
begin
  if {HasData and }Assigned(WriteData) then
  begin
    WritePropName(Name);
    WriteData(Self);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDOSWriter.LMDWriteComplexProperty(szComponent, szChain: string);
var
  Component: TComponent;
  TSTek, TSOst: string;
  AObject: TPersistent;
  i: integer;

  procedure WriteProp(aObject: TPersistent; szComponent, szProperty, szPropChain: string);

    function TrimLastPath(Chain: string): string;
    begin
      Result := Chain;
      if Result = '' then
        exit;
      if Pos(FComplexPropDelimiter, Chain) = 0 then
        exit;
      while Result[length(Result)] <> FComplexPropDelimiter do
        SetLength(Result, Length(Result) - 1);
      SetLength(Result, Length(Result) - 1);
    end;

  var
    i: integer;

    PropInfo: PPropInfo;
    PropList: PPropList;

    iPos: Integer;
    Count: Integer;
  begin
    Count := GetTypeData(aObject.ClassInfo).PropCount;
    if Count > 0 then
    begin

      GetMem(PropList, Count * SizeOf(Pointer));

      try

        GetPropInfos(aObject.ClassInfo, PropList);

        for I := 0 to Count - 1 do
        begin
          PropInfo := PropList[I];
          if PropInfo = nil then
            break;
          if String(PropInfo.Name) = TSTek then
          begin
            WriteString(szComponent + FComplexPropDelimiter + TrimLastPath(szPropChain));
            iPos := Position;
            WriteListBegin;
            ForceWriteProperty(aObject, PropInfo^);
            if iPos = Position then
            begin
              WriteValue(vaNull)
            end;
            WriteListEnd;
            break;
          end;
        end;
      finally
        FreeMem(PropList, Count * SizeOf(Pointer));
      end;
    end;
  end;

begin
  if Root = nil then
    exit;
  if Root.Name = szComponent then
    Component := Root
  else
    Component := Root.FindComponent(szComponent);
  if Component = nil then
    exit;

  AObject := Component;

  TSOst := szChain;
  i := Pos(FComplexPropDelimiter, TSOst);
  if i > 0 then
  begin
    repeat
      i := Pos(FComplexPropDelimiter, TSOst);
      TSTek := copy(TSOst, 1, i - 1);
      TSost := copy(TSOst, i + 1, length(TSOst) - i);
      if Pos('(', TSTek) > 0 then
        AObject := TCollection(aObject).Items[GetItem(TSTek)]
      else
        AObject := TPersistent(GetObjectProp(aObject, TSTek));
      i := Pos(FComplexPropDelimiter, TSOst);
    until i = 0;
    TSTek := TSOst;
    TSOst := szChain;
  end
  else
  begin
    TSTek := szChain;
    TSOst := szChain;
  end;

  WriteProp(aObject, szComponent, TSTek, TSOst);
end;

{********************* TLMDStorPropertyStorageItem ****************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorPropertyStorageItem.SetPropertyName(const Value: string);
begin
  FPropertyName := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorPropertyStorageItem.SetComponentName(const Value: string);
begin
  FComponentName := Value;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorPropertyStorageItem.Create(Collection: TCollection);
begin
  inherited;
  FPropertyName := '';
end;

{********************* TLMDStorPropertyStorageItems ***************************}
{------------------------- Private --------------------------------------------}
function TLMDStorPropertyStorageItems.GetItems(Index: Integer):
 TLMDStorPropertyStorageItem;
begin
  Result := TLMDStorPropertyStorageItem(inherited Items[Index]);
end;

{------------------------- Public --------------------------------------------}
constructor TLMDStorPropertyStorageItems.Create(AOwner: TPersistent);
begin
  inherited Create({AOwner,} TLMDStorPropertyStorageItem);
end;

{------------------------------------------------------------------------------}
function TLMDStorPropertyStorageItems.Add: TLMDStorPropertyStorageItem;
begin
  Result := TLMDStorPropertyStorageItem(inherited Add);
end;

{------------------------------------------------------------------------------}
function TLMDStorPropertyStorageItems.FindItem(szComponent, szProperty: string):
  TLMDStorPropertyStorageItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    begin
      if (Items[i].FComponentName = szComponent) and
        (Items[i].FPropertyName = szProperty) then begin
          Result := Items[i];
          break;
        end;
    end;
end;

{********************* TLMDStorCustomProperty *********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorCustomProperty.SetName(const Value: string);
begin
  FName := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomProperty.SetValue(const Value: Variant);
begin
  FValue:=Value;
//  VarCopy(FValue, Value);
end;

{------------------------- Public --------------------------------------------}
constructor TLMDStorCustomProperty.Create(Collection: TCollection);
begin
  inherited;
  FName := '';
  VarClear(FValue);
end;

{********************* TLMDStorCustomProperties *******************************}
{------------------------- Private --------------------------------------------}
function TLMDStorCustomProperties.GetItems(Index: Integer):
 TLMDStorCustomProperty;
begin
  Result := TLMDStorCustomProperty(inherited Items[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomProperties.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorCustomProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TLMDStorCustomProperty);
  FOwner := AOwner;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomProperties.Add: TLMDStorCustomProperty;
begin
  Result := TLMDStorCustomProperty(inherited Add);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomProperties.FindItem(Name: string):
  TLMDStorCustomProperty;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    begin
      if Items[i].FName = Name then begin
          Result := Items[i];
          break;
        end;
    end;
end;

{********************* TLMDStorCustomPropertiesStorage ************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.SetStorageVault(const Value: TLMDAbstractStorageVault);
begin
  if FStorageVault <> Value then
    begin
      if FStorageVault<>nil then
        FStorageVault.RemoveFreeNotification(Self);
      FStorageVault := Value;
      if FStorageVault<> nil then
        FStorageVault.FreeNotification(Self);
    end;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.OwnerFormCreate(Sender: TObject);
begin
  inherited OwnerFormCreate(Sender);
  if AutoLoad then Load;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.OwnerFormDestroy(Sender: TObject);
begin
  if AutoSave then Save;
  inherited OwnerFormDestroy(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent <> nil) then
    if (AComponent = FStorageVault) then
      begin
//        if AutoSave then Save;
      StorageVault := nil;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.DoOnLoading;
begin
  inherited DoOnLoading;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.DoOnSaving;
begin
  inherited DoOnSaving;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.DoOnLoadData(Sender: TObject; var Stream: TMemoryStream);
begin
  if Assigned(OnLoadData) then OnLoadData(Sender, Stream);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.DoOnSaveData(Sender: TObject; var Stream: TMemoryStream);
begin
  if Assigned(OnSaveData) then OnSaveData(Sender, Stream);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorCustomPropertiesStorage.Create(AOwner: TComponent);
var
  i: Integer;
  b: Boolean;
  OwnerForm: TForm;
begin
  inherited;
  FComplexPropDelimiter := cComplexPropDelimiter;
  FPropertyStorage := TLMDStorPropertyStorageItems.Create(self);
  FCustomProperties := TLMDStorCustomProperties.Create(self);
  FEnabled := True;
  FAutoLoad := True;
  FAutoSave := True;
  FSkipNotFoundComponents := False;

  OwnerForm := TForm(aOwner);
  Randomize;
  FID := Random($7FFFFFF);

  b := True;
  while b do
  begin
    b := False;
    for i := 0 to OwnerForm.ComponentCount - 1 do
      if (OwnerForm.Components[i].ClassName = ClassName) and
       (OwnerForm.Components[i].Name <> Name) and
        (TLMDStorCustomPropertiesStorage(OwnerForm.Components[i]).ID = FID) then
      begin
        b := True;
        FID := Random($7FFFFFF);
        break;
      end;
  end;
end;

{------------------------------------------------------------------------------}
destructor TLMDStorCustomPropertiesStorage.Destroy;
begin
  FreeAndNil(FPropertyStorage);
  FreeAndNil(FCustomProperties);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.SaveToStream(Stream: TStream);
var
  Writer: TLMDOSWriter;
  i: Integer;
begin
  Writer := TLMDOSWriter.Create(Stream, 4096);
  try
    Writer.FSkipNotFoundComponents := FSkipNotFoundComponents; 
    Writer.FComplexPropDelimiter := FComplexPropDelimiter;
    Writer.Root := Owner;
    Writer.WriteListBegin;
    for i := 0 to FPropertyStorage.Count - 1 do
     if Pos(FComplexPropDelimiter, FPropertyStorage[i].PropertyName) > 0 then
      Writer.LMDWriteComplexProperty(FPropertyStorage[i].FComponentName,
        FPropertyStorage[i].PropertyName)
     else
      Writer.LMDWriteProperty(FPropertyStorage[i].FComponentName,
        FPropertyStorage[i].PropertyName);
    if CustomProperties.Count > 0 then
      Writer.LMDWriteProperty(Self.Name, 'CustomProperties');
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.LoadFromStream(Stream: TStream);
var
  Reader: TLMDOSReader;
begin
  Reader := TLMDOSReader.Create(Stream, 4096);
  Reader.FComplexPropDelimiter := FComplexPropDelimiter;
  try
    Reader.FSkipNotFoundComponents := FSkipNotFoundComponents;
    Reader.FDataFound := False;
    Reader.OnNotFound := ComponentNotFound;
    Reader.BeginReferences;
    Reader.ReadListBegin;
    Reader.Root := Owner;
    while not Reader.EndOfList do
      Reader.LMDReadProperty;
    Reader.ReadListEnd;
    Reader.FixupReferences;
    Reader.EndReferences;
//    if not Reader.FDataFound and Assigned(OnNoStorageData) then
//     OnNoStorageData(Self);
  finally
    Reader.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.ComponentNotFound(Sender: TObject;
  const CompName: string; var RaiseException: Boolean);
begin
  if Assigned(FOnNotFound) then FOnNotFound(Self, CompName, RaiseException);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.Save;
var
  MS: TMemoryStream;
begin
  if (FStorageVault <> nil) and FEnabled and
    ((Properties.Count > 0) or (CustomProperties.Count > 0)) then
    begin
      DoOnSaving;
      MS := TMemoryStream.Create;
      try
        SaveToStream(MS);
        MS.Seek(0, soFromBeginning);
        DoOnSaveData(self, MS);
        FStorageVault.Save(MS);
      finally
        MS.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.Load;
var
  MS: TMemoryStream;
begin
  if (FStorageVault <> nil) and FEnabled and not IsPropListEmpty then
    begin
      DoOnLoading;
      MS := TMemoryStream.Create;
      try
        FStorageVault.Load(MS);
        DoOnLoadData(self, MS);
        MS.Seek(0, soFromBeginning);
        if MS.Size > 0 then
          LoadFromStream(MS)
        else
          if Assigned(OnNoStorageData) then OnNoStorageData(Self);
      finally
        MS.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomPropertiesStorage.IsPropListEmpty: boolean;
begin
  result := (Properties.Count <= 0) and (CustomProperties.Count <= 0);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomPropertiesStorage.GetComplexPropDelimiter: string;
begin
  result := FComplexPropDelimiter;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomPropertiesStorage.SetComplexPropDelimiter(
  const Value: string);
begin
  FComplexPropDelimiter := Value;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.

