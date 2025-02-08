unit ElIni;
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

ElIni unit
----------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
 Types,
  Windows,
  Registry,
  Graphics,
  SysUtils,
  Classes,

  ElCRC32,
  ElRegUtils,
  ElComponent,
  ElTools,
  ElVCLUtils, // ElMemoryManager

  LMDProcs,
  LMDTypes,
  LMDDebugUnit,
  LMDSysIn,
  LMDStrings,
  LMDFiles,
  {$ifdef LMD_UNICODE}
  LMDUnicode,
  LMDUnicodeStrings,
  {$endif}
  LMDObjectList;

type

  TElValueType = (evtUnknown, evtBoolean, evtInt, evtString, evtMultiString,
      evtBinary, evtDouble{, evtColor});

  TElValueData = record
    case ValueType : TElValueType of
      evtUnknown : ();
      evtBoolean : (BoolValue : boolean);
      evtInt : (IntValue : integer);
      evtString : (StrValue : pchar);
      evtMultiString : (MStrValue : TStringList);
      evtBinary : (DataValue : pointer; DataLength: integer);
      evtDouble : (DoubleValue : double);
      //evtColor  : (ColorValue : TColor);
  end;

  PELValueData = ^TElValueData;
  {:
  }
  EElIniError = class (Exception)
  end;

  {:
  }
  TElIniEntry = class (TObject)
  private
    //FDestroyed: Boolean;
    FChildren: TLMDObjectList;
    FIsKey: Boolean;
    FParent: TElIniEntry;
    FValueData: TElValueData;
    FValueName: string;
    FNameHash : LongInt;
    function GetSubCount: Integer;
    procedure OnValueDelete(Sender : TObject; var Data : pointer);
    procedure SetParent(Value: TElIniEntry);
  protected
    constructor Create;
    function GetValue(Name : string): TElIniEntry;
    procedure SetValueName(const Value: string);
    property Parent: TElIniEntry read FParent write SetParent;
  public
    destructor Destroy; override;
    procedure Invalidate;
    property IsKey: Boolean read FIsKey;
    property SubCount: Integer read GetSubCount;
    property ValueName: string read FValueName write SetValueName;
  end;

  TElIniFile = class(TElComponent)
  private
    FOnBeforeLoad : TNotifyEvent;
    FOnAfterSave  : TNotifyEvent;
    FOnBeforeSave : TNotifyEvent;
    FOnAfterLoad  : TNotifyEvent;
    FBinaryMode: Boolean;
    FComment: String;
    FCurEntry: TElIniEntry;
    FCurrentKey: String;
    FDelimiter: Char;
    FDivChar: Char;
    FLazyWrite: Boolean;
    FModified: Boolean;
    FPath: TLMDString;
    FRegistry: TRegistry;
    FRegRoot : HKEY;
    FUseRegistry: Boolean;
    FRoot: TElIniEntry;
    FSimple: Boolean;
    FWarningMessage: String;
    function GetRegRoot: TRegRootType;
    procedure SetCurrentKey(const newValue: String);
    procedure SetDelimiter(newValue: Char);
    procedure SetLazyWrite(newValue: Boolean);
    procedure SetPath(newValue: TLMDString);
    procedure SetSimple(newValue: Boolean);
    procedure SetRegRoot(newValue: TRegRootType);
    procedure SetUseRegistry(newValue: Boolean);
    procedure IntLoadKey(SL : TStringList; CurLine : integer);
    procedure IntLoadBinKey(F : TStream);
    procedure IntSaveKey(F : TStream; KeyName : string; KeyEntry : TElIniEntry);
    procedure IntSaveBinKey(F : TStream; KeyName : string; KeyEntry : TElIniEntry);
  protected
    FTrimSpaces: Boolean;
    function GetValueEntry(Key : string; ValueName : string): TElIniEntry;
        virtual;
    procedure ParseLine(S : string; var Name, Value : string; var HasName :
        boolean); virtual;
    procedure TriggerBeforeSaveEvent; virtual;
    procedure TriggerAfterLoadEvent; virtual;
    procedure TriggerBeforeLoadEvent; virtual;
    procedure TriggerAfterSaveEvent; virtual;
    public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function Clear: Boolean;
    function ClearKey(Key : string): Boolean; virtual;
    function CreateValue(Key, ValueName : string): TElIniEntry;
    function Delete(Key, ValueName : string): Boolean;
    function EnumSubKeys(Key : string; Strings : TStrings): Boolean;
    function EnumValues(Key : string; Strings : TStrings): Boolean;
    function FullKey(Key : string): String;
    function GetValueType(Key, ValueName : string): TElValueType;
    function KeyExists(Key : string): Boolean;
    procedure LoadFromStream(Stream : TStream{$IFDEF LMDCOMP12}; Encoding: TEncoding = nil{$ENDIF});
    procedure SaveToStream(Stream : TStream{$IFDEF LMDCOMP12}; Encoding: TEncoding = nil{$ENDIF});
    function Load: Boolean;
    procedure Loaded; override;
    function MoveEntry(Key, ValueName, NewKey : string): Boolean;
    function OpenKey(Key : string; CanCreate : boolean): Boolean;
    function OwnKey(Key : string): String;
    function ParentKey(Key : string): String;
    function ReadBinary(Key : string; ValueName : string; var Buffer; var
        BufferLen : integer): Boolean;
    function ReadBool(Key : string; ValueName : string; DefValue : boolean; var
        Value : boolean): Boolean;
    function ReadDouble(Key : string; ValueName : string; DefValue : Double; var
        Value : Double): Boolean;
    function ReadInteger(Key : string; ValueName : string; DefValue : integer;
        var Value : integer): Boolean;
    function ReadMultiString(Key : string; ValueName : string; Strings :
        TStrings): Boolean; overload;
    {$ifndef LMD_NATIVEUNICODE}
    {$ifdef LMD_UNICODE}
    function ReadMultiString(Key : string; ValueName : string; Strings :
        TLMDStrings): Boolean; overload;
    {$endif}
    {$endif}
    function ReadObject(Key : string; AnObject : TPersistent): Boolean;
    function ReadString(Key : string; ValueName : string; DefValue : string;
        var Value : string): Boolean;
    {$ifdef LMD_UNICODE}
    function ReadWideString(Key : string; ValueName : string;
      DefValue : WideString; var Value: WideString): Boolean;
    {$endif}
    function ReadColor(Key : string; ValueName : string; DefValue : TColor;
        var Value : TColor): Boolean;
    function ReadRect(Key : string; ValueName : string; DefValue : TRect;
        var Value : TRect): Boolean;
    function RenameKey(Key, NewName : string): Boolean; virtual;
    function RenameValue(Key, ValueName, NewName : string): Boolean; virtual;
    function Save: Boolean;
    procedure SetValueType(Key, ValueName : string; NewType : TElValueType);
        virtual;
    function SubKeysCount(Key : string): Integer;
    function ValueExists(Key : string; ValueName : string): Boolean;
    function ValuesCount(Key : string): Integer;
    function WriteBinary(Key : string; ValueName : string; var Buffer;
        BufferLen : integer): Boolean;
    function WriteBool(Key : string; ValueName : string; Value : boolean):
        Boolean;
    function WriteDouble(Key : string; ValueName : string; Value : Double):
        Boolean;
    function WriteInteger(Key : string; ValueName : string; Value : integer):
        Boolean;
    function WriteMultiString(Key : string; ValueName : string; Strings :
        TStrings): Boolean;  overload;
    {$IFNDEF LMD_NATIVEUNICODE}
    {$ifdef LMD_UNICODE}
    function WriteMultiString(Key : string; ValueName : string; Strings :
        TLMDStrings): Boolean;  overload;
    {$endif}
    {$endif}
    function WriteObject(Key : string; AnObject : TPersistent): Boolean;
    function WriteString(Key : string; ValueName : string; Value : string):
        Boolean;
    {$ifdef LMD_UNICODE}
    function WriteWideString(Key : string; ValueName : string;
      Value : WideString): Boolean;
    {$endif}
    function WriteColor(Key : string; ValueName : string; Value : TColor):
        Boolean;
    function WriteRect(Key : string; ValueName : string; Value : TRect):
        Boolean;
    function CopyValue(Key, ValueName: string; DestKey : string): Boolean;
    property CurrentKey: String read FCurrentKey write SetCurrentKey;
    property Modified: Boolean read FModified;
  published
    property BinaryMode : Boolean read FBinaryMode write FBinaryMode;
    property Comment: String read FComment write FComment;
    property Delimiter: Char read FDelimiter write SetDelimiter;
    property DivChar: Char read FDivChar write FDivChar default '=';
    property LazyWrite: Boolean read FLazyWrite write SetLazyWrite default True;
    property Path: TLMDString read FPath write SetPath;
    property Simple: Boolean read FSimple write SetSimple default False;
    property RegRoot: TRegRootType read GetRegRoot write SetRegRoot;
    property UseRegistry: Boolean read FUseRegistry write SetUseRegistry default False;
    property WarningMessage: String read FWarningMessage write FWarningMessage;
    property OnBeforeSave: TNotifyEvent read FOnBeforeSave write FOnBeforeSave;
    property OnAfterLoad: TNotifyEvent read FOnAfterLoad write FOnAfterLoad;
    property OnBeforeLoad: TNotifyEvent read FOnBeforeLoad write FOnBeforeLoad;
    property OnAfterSave: TNotifyEvent read FOnAfterSave write FOnAfterSave;
    property TrimSpaces: Boolean read FTrimSpaces write FTrimSpaces;
  end;

  function Data2Str(Buffer: pointer; BufLen: integer): string;
  function Str2Data(S: string; var Buffer: pointer; var BufLen: integer): boolean;

  implementation

uses
  TypInfo,
  ElObjList;

function ExtractStr(var S: string; SPos, SLen: integer): string;
begin
  Result := Copy(S, SPos, SLen);
  Delete(S, SPos, SLen);
end;

function Data2Str(Buffer: pointer; BufLen: integer): string;
var
  p: PByteArr;
  i: integer;
begin
  P := PByteArr(Buffer);
  Result := '454C ' + IntToHex(BufLen, 1) + ' ';
  for i := 0 to BufLen - 1 do
    Result := Result + IntToHex(P[i], 2) + ' ';
end;

function Str2Data(S: string; var Buffer: pointer; var BufLen: integer): boolean;
var
  p: PByteArr;
  i, j: integer;
  S1: string;
  b: Boolean;
begin
  Result := false;
  BufLen := -1;
  Buffer := nil;
  if pos('454C', S) <> 1 then exit;
  Delete(S, 1, 5);
  S1 := ExtractStr(S, 1, Pos(' ', S) - 1);
  Delete(S, 1, 1);
  if S1 = '' then exit;

  try
    j := LMDAnsiH2D(S1);
  except
    exit;
  end;
  ElMemoryManager.GetMem(Buffer, j);
  BufLen := j;
  p := PByteArr(Buffer);
  try
    for i := 0 to J - 1 do
    begin
      if Pos(#32, S) > 0 then
      begin
        S1 := ExtractStr(S, 1, Pos(#32, S) - 1);
        delete(S, 1, 1);
        b := False;
      end
      else
      begin
        S1 := S;
        b := true;
      end;
      P[i] := LMDAnsiH2D(S1);
      if b and (i < j - 1) then break;
    end;
    Result := i >= j;
  except
    Result := False;
  end;
end;


procedure GetWideStrProp(Instance: TObject; PropInfo: PPropInfo; var Value: WideString);
begin

  Value := TypInfo.GetWideStrProp(Instance, PropInfo);

end;

procedure SetWideStrProp(Instance: TObject; PropInfo: PPropInfo;
  const Value: WideString);
begin

  TypInfo.SetWideStrProp(Instance, PropInfo, Value);

end;

{
********************************* TElIniEntry **********************************
}
constructor TElIniEntry.Create;
begin
  inherited;
  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('new: TElIniEntry.Create: ' +IntToStr(DWORD(Self)));
  {$ENDIF}

  FChildren := TLMDObjectList.Create;
  FChildren.OnDelete := OnValueDelete;
end;

destructor TElIniEntry.Destroy;
begin
  {if FDestroyed then
    exit;
  FDestroyed := True;{}
  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('run: TElIniEntry.Destroy: ' +IntToStr(DWORD(Self)));
  {$ENDIF}
  FreeAndNil(FChildren);
  inherited;
  {$IFDEF LMD_DEBUGMESSAGES}
  LMDDebug('end: TElIniEntry.Destroy: ' +IntToStr(DWORD(Self)));
  {$ENDIF}
end;

function TElIniEntry.GetSubCount: Integer;
begin
  result := FChildren.Count;
end;

function TElIniEntry.GetValue(Name : string): TElIniEntry;
var
  i: Integer;
  Hash : LongInt;
  Child : TElIniEntry;
begin
  result := nil;
  Name := Trim(Uppercase(Name));
  Hash := CRCStr(Name);
  for i := 0 to FChildren.Count - 1 do
  begin
    Child := TElIniEntry(FChildren[i]);
    if (Child<>nil) and (Hash = Child.FNameHash) then
      if Trim(Uppercase(Child.ValueName)) = Name then
      begin
        result := Child;
        exit;
      end;
  end;
end;

procedure TElIniEntry.Invalidate;
begin
  if FValueData.ValueType = evtString then
  begin
    if FValueData.StrValue <> nil then
    begin
      FreeMem(FValueData.StrValue);
      FValueData.StrValue := nil;
    end;
  end
  else if FValueData.ValueType = evtMultiString then
  begin
    FValueData.MStrValue.Free;
    FValueData.MStrValue := nil;
  end
  else if FValueData.ValueType = evtBinary then
  begin
    FreeMem(FValueData.DataValue);
    FValueData.DataValue := nil;
  end;
  FValueData.ValueType := evtUnknown;
end;

procedure TElIniEntry.OnValueDelete(Sender : TObject; var Data : pointer);
var
  Entry: TElIniEntry;
begin
  Entry := TElIniEntry(Data);
  if Assigned(Entry) then
    Entry.Invalidate;
  Data := nil;
  Entry.Free;
end;

procedure TElIniEntry.SetParent(Value: TElIniEntry);
begin
  if FParent <> nil then
  begin
    FParent.FChildren[FParent.FChildren.IndexOf(Self)] := nil;
    FParent.FChildren.Remove(nil);
  end;
  FParent := value;
  if Value <> nil then FParent.FChildren.Add(Self);
end;

procedure TElIniEntry.SetValueName(const Value: string);
begin
  FValueName := Value;
  FNameHash := CRCStr(Trim(Uppercase(Value)));
end;

{:
}
{
********************************** TElIniFile **********************************
}
constructor TElIniFile.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FWarningMessage := 'Automatically generated file. DO NOT MODIFY!!!';
  FRoot := TElIniEntry.Create;
  FDelimiter := '\';
  FCurrentKey := FDelimiter;
  FCurEntry := FRoot;
  FLazyWrite := True;
  FComment := ';';
  FDivChar := '=';
  FRegRoot := HKEY_CURRENT_USER;
end;

destructor TElIniFile.Destroy;
begin
  try
    if FLazyWrite and FModified then
      Save;
  except
    on E : Exception do ;
  end;
  FCurEntry := FRoot;
  if Assigned(FRoot) and Assigned(FRoot.FChildren) then
    FRoot.FChildren.Clear;
  FreeAndNil(FRoot);
  UseRegistry := false;
  FCurEntry := nil;
  inherited Destroy;
end;

function TElIniFile.Clear: Boolean;
begin

  if FUseRegistry then
    raise EElIniError.Create(
        'Clearing the whole registry is not allowed. Use ClearKey instead.')
  else

  begin
    if Assigned(FRoot) and Assigned(FRoot.FChildren) then
    begin
      {$IFDEF LMD_DEBUGMESSAGES}
      LMDDebug('RUN: TElIniFile.Clear FChildren:' +IntToStr(DWORD(FRoot.FChildren)));
      {$endif}
      try
        FRoot.FChildren.Clear;
      except
      end;
      {$IFDEF LMD_DEBUGMESSAGES}
      LMDDebug('END: TElIniFile.Clear FChildren:' +IntToStr(DWORD(FRoot.FChildren)));
      {$endif}
    end;
    FCurrentKey := FDelimiter;
    FCurEntry := FRoot;
    FModified := true;
    result := true;
  end;
end;

function TElIniFile.ClearKey(Key : string): Boolean;
var
  E: TElIniEntry;
  List: TStringList;
  FOldKey: String;
  i: Integer;
  begin
  result := false;
  if FUseRegistry then
  begin
    FOldKey := FCurrentKey;
    if OpenKey(Key, false) then
    begin
      List := TStringList.Create;
      EnumSubKeys('', List);
      for i := 0 to List.Count - 1 do
        Delete(Key + FDelimiter + List[i], '');
      List.Clear;
      EnumValues('', List);
      for i := 0 to List.Count - 1 do
        Delete('', List[i]);
      List.Free;
      result := true;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  E := GetValueEntry(Key, '');
  if (E <> nil) and (E.FIsKey) then
  begin
    E.FChildren.Clear;
    if not FLazyWrite then Save;
    result := true;
    FModified := true;
  end;
end;

function TElIniFile.CreateValue(Key, ValueName : string): TElIniEntry;
var
  S: String;
  E: TElIniEntry;
begin
  if FUseRegistry then raise EElIniError.Create(
      'CreateValue method is not available when using registry.');
  S := CurrentKey;
  result := nil;
  if OpenKey(Key, true) then
  begin
    E := GetValueEntry(Key, ValueName);
    if E = nil then
    begin
      E := TElIniEntry.Create;
      E.ValueName := ValueName;
      E.Parent := FCurEntry;
    end
    else
      E.Invalidate;
    result := E;
    FModified := true;
    E.FValueData.ValueType := evtUnknown;
  end;
  OpenKey(S, false);
end;

function TElIniFile.Delete(Key, ValueName : string): Boolean;
var
  E: TElIniEntry;
  FOldKey: String;
  S: String;
  begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    if ValueName = '' then
    begin
      Key := FullKey(Key);
      S := Key;
      if FPath <> '' then
      begin
        if (FPath <> '\') or ((Length(S) = 0) or (S[1] <> '\')) then S := FPath
            + S;
      end;
      if LMDSIWindowsNT then ClearKey(Key);
      result := FRegistry.DeleteKey(S);
      Delete(ParentKey(Key), OwnKey(Key));
    end
    else
    begin
      if OpenKey(Key, false) then
        result := FRegistry.DeleteValue(ValueName)
      else
        result := false;
      OpenKey(FOldKey, false);
    end;
    exit;
  end;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) and (E <> FRoot) then
  begin
    if FCurEntry = E then
    begin
      FCurEntry := E.FParent;
      FCurrentKey := Copy(FCurrentKey, 1, LMDAnsiLastPos(FDelimiter, FCurrentKey) - 1);
    end;
    E.FParent.FChildren.Remove(E);
    result := true;
    FModified := true;
  end
  else
    result := false;
end;

function TElIniFile.EnumSubKeys(Key : string; Strings : TStrings): Boolean;
var
  i: Integer;
  S: String;
begin
  if FUseRegistry then
  begin
    S := FCurrentKey;
    if OpenKey(Key, true) then
    begin
      result := true;
      FRegistry.GetKeyNames(Strings);
    end
    else
      result := false;
    OpenKey(S, false);
    exit;
  end;
  S := FCurrentKey;
  result := false;
  if OpenKey(Key, true) then
  begin
    Strings.Clear;
    for i := 0 to FCurEntry.FChildren.Count - 1 do
      if (TElIniEntry(FCurEntry.FChildren[i]).FIsKey) then
        Strings.Add(TElIniEntry(FCurEntry.FChildren[i]).ValueName);
    result := true;
  end;
  OpenKey(S, false);
end;

function TElIniFile.EnumValues(Key : string; Strings : TStrings): Boolean;
var
  i: Integer;
  S: String;
begin
  if FUseRegistry then
  begin
    S := FCurrentKey;
    if OpenKey(Key, true) then
    begin
      result := true;
      FRegistry.GetValueNames(Strings);
      i := 0;
      while i < Strings.Count do
        if KeyExists(Strings[i]) then
          Strings.Delete(i)
        else
          inc(i);
    end
    else
      result := false;
    OpenKey(S, false);
    exit;
  end;
  S := FCurrentKey;
  result := false;
  if OpenKey(Key, true) then
  begin
    Strings.Clear;
    for i := 0 to FCurEntry.FChildren.Count - 1 do
      if (not (TElIniEntry(FCurEntry.FChildren[i]).FIsKey)) then
        Strings.Add(TElIniEntry(FCurEntry.FChildren[i]).ValueName);
    result := true;
  end;
  OpenKey(S, false);
end;

function TElIniFile.FullKey(Key : string): String;
begin
  if (Length(Key) = 0) or (Key[1] <> FDelimiter) then
    if FCurrentKey = FDelimiter then
      Key := FDelimiter + Key
    else
      Key := FCurrentKey + FDelimiter + Key;
  if Key[Length(Key)] = FDelimiter then
    System.Delete(Key, Length(Key), 1);
    result := Key;
end;

function TElIniFile.GetRegRoot: TRegRootType;
begin
  if FRegRoot = HKEY_LOCAL_MACHINE then
    Result := rrtHKEY_LOCAL_MACHINE
  else if FRegRoot = HKEY_USERS then
    Result := rrtHKEY_USERS
  else if FRegRoot = HKEY_CURRENT_USER then
    Result := rrtHKEY_CURRENT_USER
  else if FRegRoot = HKEY_CLASSES_ROOT then
    Result := rrtHKEY_CLASSES_ROOT
  else if FRegRoot = HKEY_CURRENT_CONFIG then
    Result := rrtHKEY_CURRENT_CONFIG
  else
    Result := rrtHKEY_CURRENT_USER;
end;

function TElIniFile.GetValueEntry(Key : string; ValueName : string):
    TElIniEntry;
var
  S: String;
begin
  if FUseRegistry then raise EElIniError.Create(
      'GetValueEntry method is not available when using registry.');
  S := CurrentKey;
  result := nil;
  if OpenKey(Key, false) then
  begin
    if Length(ValueName) > 0 then
      result := FCurEntry.GetValue(ValueName)
    else
      if FUseRegistry then
        if Length(ValueName) = 0 then
          result := FCurEntry.GetValue(ValueName)
        else
          Result := nil
      else
        if FCurEntry <> FRoot then
           result := FCurEntry;
  end;
  OpenKey(S, false);
end;

function TElIniFile.GetValueType(Key, ValueName : string): TElValueType;
var
  E: TElIniEntry;
  i: DWORD;
  FOldKey: String;
  begin
  if FUseRegistry then
  begin
    FOldKey := FCurrentKey;
    if ValueName = '' then
    begin
      ValueName := OwnKey(Key);
      Key := ParentKey(Key);
    end;
    if OpenKey(Key, false) then
    begin
      if RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil, @i, nil, nil) = ERROR_SUCCESS then
      begin
        case i of //
      REG_BINARY : result := evtBinary;
          REG_SZ,
            REG_EXPAND_SZ : result := evtString;
          REG_DWORD : result := evtInt;
          REG_MULTI_SZ : result := evtMultiString;
        else
          result := evtUnknown;
        end; // case
      end
      else
        result := evtUnknown;
    end
    else
      result := evtUnknown;
    OpenKey(FOldKey, false);
    exit;
  end;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) then
    result := E.FValueData.ValueType
  else
    result := evtUnknown;
end;

function TElIniFile.KeyExists(Key : string): Boolean;
var
  S: String;
begin
  S := CurrentKey;
  result := OpenKey(Key, false);
  OpenKey(S, false);
end;

procedure TElIniFile.IntLoadBinKey(F : TStream);
var
   S : String;
   i : integer;
    E,
    KE : TElIniEntry;
    KEN : string;
    b : boolean;
    SkipValues : boolean;
    VT : TElValueType;
begin
  KE := FRoot;
  SkipValues := false;
  while F.Position < F.Size do
  begin
    F.ReadBuffer(b, sizeof(b));
    LMDAnsiReadStringFromStream(F, S);
    if b then
    begin
      if (Length(S) > 0) and (S[1] <> (FDelimiter)) then
        S := FDelimiter + S;
      if not OpenKey(S, true) then
      begin
        SkipValues := true;
        Continue;
      end;
      KEN := S;
      KE := FCurEntry;
      OpenKey(FDelimiter, false);
    end else
    begin
      E := GetValueEntry(KEN, S);
      F.ReadBuffer(VT, sizeof(VT));
      F.ReadBuffer(i, sizeof(i));
      if SkipValues then
      begin
        F.Seek(i, soFromCurrent);
        Continue;
      end;
      if E <> nil then
      begin
        if (VT = evtMultiString) xor (E.FValueData.ValueType = evtMultiString) then
        begin
          if (VT = evtMultiString) then
          begin
            E.FValueData.ValueType := evtMultiString;
            E.FValueData.MStrValue := TStringList.Create;
          end else
            E.Invalidate;
        end;
      end
      else
      begin
        E := TElIniEntry.Create;
        E.ValueName := S;
        E.Parent := KE;
      end;
      E.FValueData.ValueType := VT;
      case VT of
        evtBoolean:
          F.ReadBuffer(E.FValueData.BoolValue, sizeof(E.FValueData.BoolValue));
        evtDouble:
          F.ReadBuffer(E.FValueData.DoubleValue, sizeof(E.FValueData.DoubleValue));
        evtInt:
          F.ReadBuffer(E.FValueData.IntValue, sizeof(E.FValueData.IntValue));
        evtString:
          begin
            LMDAnsiReadStringFromStream(F, S);
            GetMem(E.FValueData.StrValue, (length(S) + 1) * SizeOf(Char));
            StrPLCopy(E.FValueData.StrValue, S, Length(S));
            end;
        evtMultiString:
          begin
            if E.FValueData.MStrValue = nil then
              E.FValueData.MStrValue := TStringList.Create;
            if i > 0 then
            begin
              while i > 0 do
              begin
                LMDAnsiReadStringFromStream(F, S);
                E.FValueData.MStrValue.Add(S);
                dec(i, sizeof(integer) + Length(S));
              end;
            end;
          end;
        evtBinary:
          begin
            F.ReadBuffer(E.FValueData.DataLength, sizeof(E.FValueData.DataLength));
            GetMem(E.FValueData.DataValue, E.FValueData.DataLength);
            F.ReadBuffer(PChar(E.FValueData.DataValue)^, E.FValueData.DataLength);
            end;
      end; // case
    end; // else
  end;

end;

procedure TElIniFile.IntLoadKey(SL : TStringList; CurLine : integer);
var
  S : string;
  E, KE : TElIniEntry;
  KEN   : string;
  ValueName,
    Value : string;
  i, j,
  k, l    : integer;
  b, eos  : boolean;
  d       : double;
  SkipValues : boolean;
begin
  j := 0;
  KE := FRoot;
  KEN := FDelimiter;
  eos := false;
  SkipValues := false;
  while not eos do
  begin
    inc(j);
    if SL.Count <= CurLine then
       exit
    else
    begin
      S := SL[CurLine];
      if TrimSpaces then
        S := Trim(S);
      inc(CurLine);
    end;
    if (Length(S) = 0) or ((Length(FComment) > 0) and (Pos(FComment, S) = 1)) then
      Continue;
    if S[1] = '[' then
    begin
      SkipValues := false;
      i := Pos(';', S);
      if i > 0 then // remove possible comments
      begin
        System.Delete(S, i, MaxInt);
        S := TrimRight(S);
      end;
      if S[Length(S)] = ']' then
        S := FDelimiter + Copy(S, 2, Length(S) - 2)
      else
      begin
        if Length(S) > 0 then
          S[1] := FDelimiter;
      end;
      if (S <> FCurrentKey) and (not OpenKey(S, true)) then
      begin
        SkipValues := true;
        Continue;
      end;
      KEN := S;
      KE := FCurEntry;
      OpenKey(FDelimiter, false);
    end
    else
    if not SkipValues then
    begin
      ParseLine(S, ValueName, Value, b);
      if not b then
      begin
        Value := ValueName;
        ValueName := '#' + IntToStr(J);
      end;
      i := -1;
      if ValueName[Length(ValueName)] = ']' then
      begin
        l := Pos('[', ValueName);
        i := StrToIntDef(Copy(ValueName, l + 1, Pos(']', ValueName) - l - 1), -1);
        ValueName := Copy(ValueName, 1, l - 1);
      end;
      E := GetValueEntry(KEN, ValueName);
      if E <> nil then
      begin
        if (i = -1) or (E.FValueData.ValueType <> evtMultiString) then
            E.Invalidate;
        if i <> -1 then
        begin
          if E.FValueData.ValueType <> evtMultiString then
          begin
            E.FValueData.ValueType := evtMultiString;
            E.FValueData.MStrValue := TStringList.Create;
          end;
        end;
      end
      else
      if Length(ValueName) = 0 then
        Continue
      else
      begin
        E := TElIniEntry.Create;
        E.ValueName := ValueName;
        E.Parent := KE;
      end;
        // MultiString
      if i <> -1 then
      begin
        if E.FValueData.ValueType <> evtMultiString then
        begin
          E.FValueData.ValueType := evtMultiString;
          E.FValueData.MStrValue := TStringList.Create;
        end;
        E.FValueData.MStrValue.Add(Value);
        Continue;
      end;
      // boolean
      if (UpperCase(Value) = 'FALSE') or (UpperCase(Value) = 'TRUE') then
      begin
        E.FValueData.ValueType := evtBoolean;
        if UpperCase(Value) = 'TRUE' then
          E.FValueData.BoolValue := true
        else
          E.FValueData.BoolValue := false;
        Continue;
      end;
      // integer
      val(Value, i, k);
      if (k = 0) and ((IntToStr(i) = Value) or ('0x' + IntToHex(i, 1) = Value) or ('$' + IntToHex(i, 1) = Value)) then
      begin
        E.FValueData.ValueType := evtInt;
        E.FValueData.IntValue := i;
        Continue;
      end;

      // Float
      D := 0;
      ValFloat(Value, D, k);
      if (k = 0) and (StrFloat(D) = Value) then
      begin
        E.FValueData.ValueType := evtDouble;
        E.FValueData.DoubleValue := D;
        Continue;
      end;

      // binary
      if Pos('454C', Value) = 1 then
      begin
        E.FValueData.ValueType := evtBinary;
        Str2Data(Value, E.FValueData.DataValue, E.FValueData.DataLength);
        Continue;
      end;
      // string
      E.FValueData.ValueType := evtString;
      GetMem(E.FValueData.StrValue, (Length(Value) + 1 ) * SizeOf(Char));
      StrPLCopy(E.FValueData.StrValue, Value, Length(Value));
      end;
  end;
end;

procedure TElIniFile.LoadFromStream(Stream : TStream{$IFDEF LMDCOMP12}; Encoding: TEncoding = nil{$ENDIF});
var
  SL : TStringList;
  i  : integer;
begin
  if FUseRegistry then exit;
  TriggerBeforeLoadEvent;
  try
    FRoot.FChildren.Clear;
    FCurrentKey := FDelimiter;
    FCurEntry := FRoot;
    if FBinaryMode then
       IntLoadBinKey(Stream)
    else
    begin
      SL := TStringList.Create;
      try
        {$ifdef LMDCOMP12}
        if not Assigned(Encoding) then
          Encoding := TEncoding.UTF8;
        {$else}
        LMDReadBOM(Stream);
        {$endif}
        SL.LoadFromStream(Stream{$IFDEF LMDCOMP12}, Encoding{$ENDIF});
        i := 0;
        IntLoadKey(SL, i);
      finally
        SL.Free;
      end;
    end;
  finally
    TriggerAfterLoadEvent;
  end;
end;

function TElIniFile.Load: Boolean;
var
  F : TStream;
  SL: TStringList;
  LBuffer: PAnsiChar;
  n: Int64;
begin
  result := false;
  F := nil;
  LBuffer := nil;
  if FUseRegistry then exit;
  TriggerBeforeLoadEvent;
  if FPath = '' then        //this check moved here from Loaded method
    exit;                   //so that Path could be set in OnBeforeLoad event
  // F := nil;
  try
    FRoot.FChildren.Clear;
    FCurrentKey := FDelimiter;
    FCurEntry := FRoot;
    if FileExists(FPath) then
      F := TLMDFileStream.Create(FPath, fmOpenRead or fmShareDenyWrite)
    else
      F := TLMDFileStream.Create(FPath, fmCreate or fmShareDenyWrite);
    if FBinaryMode then
    begin
      IntLoadBinKey(F);
    end
    else
    begin
      SL := TStringList.Create;
      SL.Clear;
      try
//        SL.LoadFromFile(FPath);
        n := F.Size;
        GetMem(LBuffer, n + 1);
        FillChar(LBuffer^, n + 1, 0);
        F.Read(LBuffer^, n);
//        SL.Text := LBuffer;
        SL.Text := String(PAnsiChar(LBuffer));
        IntLoadKey(SL, 0);
      finally
        FreeMem(LBuffer);
        SL.Free;
      end;
    end;
    result := true;
  finally
    if Assigned(F) then
      F.Free;
    TriggerAfterLoadEvent;
  end;
end;

procedure TElIniFile.Loaded;
begin
  inherited;
  if {(FPath <> '') and} (not FUseRegistry) then //VB: FPath check moved to Load method
  try                                            //so that Path could be set in
    Load;                                        //OnBeforeLoad event
  except
  end;
end;

function TElIniFile.MoveEntry(Key, ValueName, NewKey : string): Boolean;
var
  S: String;
  E: TElIniEntry;
  E1: TElIniEntry;
begin
  if FUseRegistry then raise EElIniError.Create(
      'MoveEntry method is not available when using registry.');
  S := CurrentKey;
  result := false;
  if OpenKey(Key, false) then
  begin
    E := FCurEntry.GetValue(ValueName);
    if (E <> nil) then
    begin
      E1 := Self.GetValueEntry(NewKey, '');
      E.Parent := E1; // this will remove the entry from the old parent's children list
                      // and add it to the new parent's children list
      result := true;
    end;
  end;
  OpenKey(S, false);
end;

function TElIniFile.OpenKey(Key : string; CanCreate : boolean): Boolean;
var
  S: String;
  CE: TElIniEntry;
  i: Integer;
  FSaveKey: String;
  LPath: TLMDString;
begin
  if (Key = '') or (Uppercase(Key) = Uppercase(FCurrentKey)) then
  begin
    if FUseRegistry then
    begin
      if pos(FPath, FCurrentKey) = 0 then
        LPath := FPath + FCurrentKey
      else
        LPath := FPath;
      if (Length(LPath) > 0) and (LPath[Length(LPath)] = '\') then
        System.Delete(LPath, Length(LPath), 1);
        if (Length(LPath) = 0) then LPath := '\';
      if LPath[1] <> '\' then LPath := '\' + LPath;
      FRegistry.OpenKey(LPath, false);
    end;
    result := true;
    exit;
  end;
  result := false;
  if FUseRegistry then
  begin
    if (Key[1] <> '\') then
    begin
      if FCurrentKey[length(FCurrentKey)] <> '\' then
        Key := FCurrentKey + '\' + Key
      else
        Key := FCurrentKey + Key;
    end;
    if Key[Length(Key)] = '\' then
      System.Delete(Key, Length(Key), 1);
      if (FPath[Length(FPath)] = '\') and (Length(Key) > 0) and (Key[1] = '\')
        then System.Delete(Key, 1, 1);
    FSaveKey := FRegistry.CurrentPath;
    FRegistry.CloseKey;
    if FUseRegistry and (pos(FPath, Key) > 0) then
    begin
      system.delete(Key, 1, length(FPath)+pos(FPath, Key) - 1);
      end;
    result := FRegistry.OpenKey(FPath + Key, CanCreate);
    if not Result then FRegistry.OpenKey(FSaveKey, true);
    FCurrentKey := FRegistry.CurrentPath;
    if (Length(FCurrentKey) = 0) or (FCurrentKey[1] <> '\') then FCurrentKey :=
        '\' + FCurrentKey;
    if Pos(FPath, FCurrentKey) = 1 then
      System.Delete(FCurrentKey, 1, Length(FPath));
      if (Length(FCurrentKey) = 0) then FCurrentKey := '\';
    exit;
  end;
  // In simple mode
  if FSimple then
  begin
    if Length(Key) = 0 then
      result := true
    else
    begin
      FCurEntry := FRoot;
      FCurrentKey := FDelimiter;
      if Key[1] = FDelimiter then
        System.Delete(Key, 1, 1);
      CE := FRoot.GetValue(Key);
      if CE <> nil then
      begin
        FCurEntry := CE;
        FCurrentKey := FDElimiter + Key;
        result := true;
      end
      else if CanCreate then
      begin
        CE := TElIniEntry.Create;
        CE.FIsKey := true;
        CE.ValueName := Key;
        CE.Parent := FRoot;
        FModified := true;
        FCurEntry := CE;
        FCurrentKey := FDElimiter + Key;
        result := true;
      end;
    end;
    exit;
  end;

  // in standard mode
  if Length(Key) > 0 then
  begin
    if Key[1] = FDelimiter then // starting from root
    begin
      FCurEntry := FRoot;
      FCurrentKey := FDelimiter;
      CE := FRoot;
      System.Delete(Key, 1, 1);
    end
    else
    begin // starting from current
      CE := FCurEntry;
      if FCurrentKey <> '\' then
        FCurrentKey := FCurrentKey + FDelimiter;
    end;
    if Length(Key) = 0 then
    begin
      result := true;
      exit;
    end;
    if Key[length(Key)] = FDelimiter then
      SetLength(Key, Length(Key) - 1);
    while true do
    begin
      i := Pos(FDelimiter, Key);
      if i > 0 then
      begin
        S := Copy(Key, 1, i - 1);
        if Length(S) = 0 then
        begin // we can't allow empty names
          result := false;
          exit;
        end;
        System.Delete(Key, 1, i)
        ;
      end
      else
      begin
        S := Key;
        SetLength(Key, 0);
      end;
      CE := CE.GetValue(S);
      if (CE = nil) then
      begin
        if not CanCreate then
          exit;
        FCurrentKey := FCurrentKey + S + FDelimiter;
        CE := TElIniEntry.Create;
        CE.FIsKey := true;
        CE.ValueName := S;
        CE.Parent := FCurEntry;
        FModified := true;
      end
      else
      begin
        if (not CE.FIsKey) then
        begin
          if CanCreate then
          begin
            CE.FIsKey := true;
            FModified := true;
            FCurrentKey := FCurrentKey + S + FDelimiter;
          end
          else
            exit;
        end
        else
          FCurrentKey := FCurrentKey + S + FDelimiter;
      end;
      FCurEntry := CE;
      if Length(Key) = 0 then break;
    end;
    if (length(FCurrentKey) > 1) and
       (FCurrentKey[length(FCurrentKey)] = FDelimiter) then
      SetLength(FCurrentKey, length(FCurrentKey) - 1);
  end;
  result := true;

end;

function TElIniFile.OwnKey(Key : string): String;
begin
  Key := FullKey(Key);
  if LMDAnsiLastPos(FDelimiter, Key) = 0 then
    Result := Key
  else
    Result := Copy(Key, LMDAnsiLastPos(FDelimiter, Key) + 1, Length(Key));
end;

function TElIniFile.ParentKey(Key : string): String;
begin
  Key := FullKey(Key);
  if LMDAnsiLastPos(FDelimiter, Key) = 0 then
    Result := FDelimiter
  else
    Result := Copy(Key, 1, LMDAnsiLastPos(FDelimiter, Key) - 1);
end;

procedure TElIniFile.ParseLine(S : string; var Name, Value : string; var HasName :  boolean);
var
  i: Integer;
  b: Boolean;
  IV: Boolean;
  begin
  b := false;
  iv := false;
  Name := '';
  Value := '';
  for i := 1 to Length(S) do
  begin
    if b then
    begin
      if s[i] = '"' then
        b := false;
      if iv then
        Value := Value + s[i]
      else
        Name := Name + s[i];
    end
    else
    begin
      if s[i] = '"' then
        b := true;
      if (Length(FComment) > 0) and (StrLComp(PChar(FComment), @s[i], Length(FComment)) = 0) then
      break
      else
      if (s[i] = FDivChar) and (not iv) then
        iv := true
      else
      if iv then
        Value := Value + s[i]
      else
        Name := Name + s[i];
    end;
  end;
  if TrimSpaces then
  begin
    Value := Trim(Value);
    Name := Trim(Name);
  end;
  HasName := iv;
end;

function TElIniFile.ReadBinary(Key : string; ValueName : string; var Buffer;
    var BufferLen : integer): Boolean;
var
  E: TElIniEntry;
  FOldKey: String;
  i, j: Integer;
  begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    {if ValueName = '' then
    begin
      ValueName := OwnKey(Key);
      Key := ParentKey(Key);
    end;}
    if OpenKey(Key, false) then
    begin
      if RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil, @j, nil, @i)
      = ERROR_SUCCESS then
      begin
        if (j = REG_BINARY) then
        result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil,
              nil, @Char(Buffer), @BufferLen) = ERROR_SUCCESS;
         end;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  result := false;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) and (E.FValueData.ValueType = evtBinary) then
  begin
    if BufferLen < E.FValueData.DataLength then
      BufferLen := E.FValueData.DataLength
    else
    begin
      Move(PChar(E.FValueData.DataValue)^, Buffer, E.FValueData.DataLength);
      BufferLen := E.FValueData.DataLength;
      result := true;
    end;
  end;
end;

function TElIniFile.ReadBool(Key : string; ValueName : string; DefValue :
    boolean; var Value : boolean): Boolean;
var
  E: TElIniEntry;
  FOldKey: String;
  i,
  j: Integer;
  begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    Value := DefValue;
    {if ValueName = '' then
    begin
      ValueName := OwnKey(Key);
      Key := ParentKey(Key);
    end;}
    if OpenKey(Key, false) then
    begin
      if RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil, @j, nil,
          @i) = ERROR_SUCCESS then
      begin
        if (j = REG_DWORD) and (i = 4) then
        begin
          result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil,
              nil, @j, @i) = ERROR_SUCCESS;
          Value := (j <> 0);
        end;
      end;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  result := false;
  Value := DefValue;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) then
  begin
    if (E.FValueData.ValueType = evtBoolean) then
    begin
      Value := E.FValueData.BoolValue;
      result := true;
    end
    else if (E.FValueData.ValueType = evtInt) then
    begin
      Value := (E.FValueData.IntValue <> 0);
      result := true;
    end
  end;
end;

function TElIniFile.ReadInteger(Key : string; ValueName : string; DefValue :
    integer; var Value : integer): Boolean;
var
  E: TElIniEntry;
  i,
  j: Integer;
  FOldKey: String;

  begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    Value := DefValue;
    {if ValueName = '' then
    begin
      ValueName := OwnKey(Key);
      Key := ParentKey(Key);
    end;}
    if OpenKey(Key, false) then
    begin
      if RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil, @j, nil,
          @i) = ERROR_SUCCESS then
      begin
        if (j = REG_DWORD) and (i = 4) then
          result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil,
              nil, @Value, @i) = ERROR_SUCCESS;
          end;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  result := false;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) then
  begin
    if (E.FValueData.ValueType = evtBoolean) then
    begin
      Value := Integer(E.FValueData.BoolValue);
      result := true;
    end
    else
    if (E.FValueData.ValueType = evtDouble) then
    begin
      Value := Round(E.FValueData.DoubleValue);
      result := true;
    end else
    if (E.FValueData.ValueType = evtInt) then
    begin
      Value := E.FValueData.IntValue;
      result := true;
    end else
    if (E.FValueData.ValueType = evtString) then
    begin
      val(E.FValueData.StrValue, Value, i);
      if i > 0 then Value := DefValue;
    end
    else
      Value := DefValue;
  end
  else
    Value := DefValue;
end;

function TElIniFile.ReadMultiString(Key : string; ValueName : string; Strings:
    TStrings): Boolean;
var
  E: TElIniEntry;
  FOldKey: String;
  zz, i, j: Integer;
  S: String;

begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    {if ValueName = '' then
    begin
      ValueName := OwnKey(Key);
      Key := ParentKey(Key);
    end;}
    if OpenKey(Key, false) then
    begin
      if RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil, @j, nil,
          @i) = ERROR_SUCCESS then
      begin
        if (j = REG_MULTI_SZ) then
        begin
          SetLength(S, i); // set string size
          result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil,
              nil, PByte(S), @i) = ERROR_SUCCESS;
          zz := Pos(#0#0, S); //REG_MULTI_SZ terminates with double zero VB March 2009
          if zz > 0 then
            System.Delete(S, zz, Length(S) - zz + 1);
          while true do
            if not LMDAnsiReplace(S, #0, #13#10) then break;
          //  System.Delete(S, Length(S) - 1, 2); // remove the last CRLF //VB March 2009
          Strings.Text := S;
        end;
      end;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  result := false;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) then
  begin
    if (E.FValueData.ValueType = evtMultiString) then
    begin
      Strings.Assign(E.FValueData.MStrValue);
      result := true;
    end
    else
    if (E.FValueData.ValueType = evtString) then
    begin
      Strings.Text := StrPas(E.FValueData.StrValue);
      result := true;
    end
  end;
end;

{$ifndef LMD_NATIVEUNICODE}
{$ifdef LMD_UNICODE}
function TElIniFile.ReadMultiString(Key : string; ValueName : string; Strings :
    TLMDStrings): Boolean;
var
  E: TElIniEntry;
  FOldKey: String;
  i: Integer;
  j: Integer;
  S: String;
  begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    {if ValueName = '' then
    begin
      ValueName := OwnKey(Key);
      Key := ParentKey(Key);
    end;}
    if OpenKey(Key, false) then
    begin
      if RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil, @j, nil,
          @i) = ERROR_SUCCESS then
      begin
        if (j = REG_MULTI_SZ) then
        begin
          SetLength(S, i); // set string size
          result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil,
              nil, PByte(S), @i) = ERROR_SUCCESS;
          if Pos(#0, S) = Length(S) then System.Delete(S, Length(S), 1);
          while true do
            if not LMDAnsiReplace(S, #0, #13#10) then break;
          System.Delete(S, Length(S) - 2, 2); // remove the last CRLF
          Strings.Text := S;
        end;
      end;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  result := false;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) then
  begin
    if (E.FValueData.ValueType = evtMultiString) then
    begin
      Strings.Assign(E.FValueData.MStrValue);
      result := true;
    end
    else
    if (E.FValueData.ValueType = evtString) then
    begin
      Strings.Text := StrPas(E.FValueData.StrValue);
      result := true;
    end
  end;
end;
{$ENDIF}
{$ENDIF}

function TElIniFile.ReadObject(Key : string; AnObject : TPersistent): Boolean;
var
  i: Integer;
  FSaveKey: String;
  PropName: ShortString;
  j: Integer;
  PropCount: Integer;
  PropList: PPropList;
  ExtValue: Extended;
  S: String;
  Obj: TObject;
  {$ifdef LMD_UNICODE}
  WS: WideString;
  WSDef: WideString;
  {$endif}
  procedure ReadCollection(Path : String; Obj : TCollection);
  var
    CI  : TCollectionItem;
    SL  : TStringList;
    j   : integer;
  begin
    SL := TStringList.Create;
    try
      if EnumSubKeys(Path, SL) then
      begin
        for j := 0 to SL.Count - 1 do
        begin
          CI := Obj.Add;
          ReadObject(SL[j], CI);
        end;
      end;
    finally
      SL.Free;
    end;
  end;

  procedure ReadObjectList(Path : String; Obj : TElObjectList);
  var
    OI  : TElObjectListItem;
    SL  : TStringList;
    j   : integer;
    S   : String;
  begin
    SL := TStringList.Create;
    try
      if EnumSubKeys(Path, SL) then
      begin
        try
          for j := 0 to SL.Count - 1 do
          begin
            if Obj.Count <= j then break;
            OI := Obj.Items[j];
            if OI <> nil then
            begin
              S := CurrentKey + FDelimiter + SL[j];
              OI.BeforeLoad(Self, S);
              ReadObject(S, OI);
              OI.AfterLoad(Self, S);
            end;
          end;
        except
          on E : Exception do ;
        end;
      end;
    finally
      SL.Free;
    end;
  end;

begin
  result := false;
  FSaveKey := CurrentKey;
  if OpenKey(Key, false) then
  begin
    {if AnObject is TCollection then
    begin
      ReadCollection(Key, TCollection(AnObject));
    end else
    }
    begin
      PropCount := GetPropList(AnObject.ClassInfo, [tkInteger, tkFloat, tkChar,
        tkWChar, {!}tkWString, tkClass, tkEnumeration, tkString, tkLString], nil);
      GetMem(PropList, PropCount * sizeof(pointer));
      try
        GetPropList(AnObject.ClassInfo, [tkInteger, tkFloat, tkClass, tkChar,
            tkWChar, {!}tkWString, tkEnumeration, tkString, tkLString], PropList);
      for i := 0 to PropCount - 1 do
        begin
          PropName := PropList[i]^.Name;
          if (PropList[i]^.SetProc = nil) and (PropList[i]^.PropType^.Kind <> tkClass) then
             continue;
          case PropList[i]^.PropType^.Kind of
          tkFloat:
              begin
                j := 0;
                ReadBinary('', String(PropName), ExtValue, j);
                if j = sizeof(Extended) then
                begin
                  ReadBinary('', String(PropName), ExtValue, j);
                  SetFloatProp(AnObject, PropList[i], ExtValue);
                end;
              end;
            tkString, tkLString:
              begin
                ReadString('', String(PropName), GetStrProp(AnObject, PropList[i]), S);
                SetStrProp(AnObject, PropList[i], S);
              end;
            {$ifdef LMD_UNICODE}
            tkWString:
              begin
                //if ValueExists('', PropName) then
                //begin
                GetWideStrProp(AnObject, PropList[i], WSDef);
                ReadWideString('', String(PropName), WSDef, WS);
                SetWideStrProp(AnObject, PropList[i], WS);
                //end;
              end;
            {$endif}
            tkEnumeration,
              tkInteger,
              tkChar,
              tkWChar:
              begin
                ReadInteger('', String(PropName), GetOrdProp(AnObject, PropList[i]), J);
                SetOrdProp(AnObject, PropList[i], J);
              end;

            tkClass:
              begin
                Obj := TObject(Pointer(GetOrdProp(AnObject, PropList[i])));
                if Obj <> nil then
                begin
                  if Obj is TStrings then
                     ReadMultiString('', String(PropName), TStrings(Obj))
                  else
                  if Obj is TPersistent then
                     ReadObject(String(PropName), TPersistent(Obj));
                end;
              end;
          end;
        end;
        if AnObject is TCollection then
           ReadCollection('', TCollection(AnObject))
        else
        if AnObject is TElObjectList then
        begin
          TElObjectList(AnObject).BeforeLoad(Self, CurrentKey);
          ReadObjectList('', TElObjectList(AnObject));
          TElObjectList(AnObject).AfterLoad(Self, CurrentKey);
        end;
      finally
        FreeMem(PropList);
        end;
    end;
    result := true;
  end;
  OpenKey(FSaveKey, true);
end;

function TElIniFile.ReadRect(Key : string; ValueName : string; DefValue : TRect;
        var Value : TRect): Boolean;
var S : String;
begin
  Result := ReadString(Key, ValueName,LMDAnsiRectToString(DefValue), S);
  Value := LMDAnsiStringToRect(S);
end;

function TElIniFile.ReadColor(Key : string; ValueName : string; DefValue : TColor; var Value : TColor): Boolean;
var S, S1 : String;
    r,g,b : byte;
    j     : integer;
begin
  result := ReadString(Key, ValueName, ColorToString(DefValue), S);
  Value := DefValue;
  If pos('.', S) > 0 then
  begin
    S1 := Copy(S, 1, pos('.', S) - 1);
    System.Delete(S, 1, pos('.', S));
    val(S1, r, j);
    if j > 0 then
    begin
      result := false;
      exit;
    end;
    S1 := Copy(S, 1, pos('.', S) - 1);
    System.Delete(S, 1, pos('.', S));
    val(S1, g, j);
    if j > 0 then
    begin
      result := false;
      exit;
    end;
    S1 := S;
    val(S1, b, j);
    if j > 0 then
    begin
      result := false;
      exit;
    end;
    Value := r or (g shl 8) or (b shl 16);
  end else
  begin
    if (Length(S) > 0) and (S[1] = '#') then
      System.Delete(S, 1, 1);
      Value := StringToColor(S);
  end;
end;

function TElIniFile.ReadString(Key : string; ValueName : string; DefValue :
    string; var Value : string): Boolean;
var
  E: TElIniEntry;
  FOldKey: String;
  i: Integer;
  j: Integer;
  p: Pointer;
  P1: PChar;
begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    Value := DefValue;
    {if ValueName = '' then
    begin
      ValueName := OwnKey(Key);
      Key := ParentKey(Key);
    end;}
    if OpenKey(Key, false) then
    begin
      if RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil, @j, nil,
          @i) = ERROR_SUCCESS then
      begin
        if ((j = REG_SZ) or (j = REG_EXPAND_SZ)) then
        begin
          if i = 1 then
          begin
            Value := '';
            result := true;
          end
          else
          begin
            GetMem(P1, i);
            result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName),
                nil, nil, PByte(P1), @i) = ERROR_SUCCESS;
            Value := StrPas(P1);
            FreeMem(P1);
            end;
        end
        else if (j = REG_MULTI_SZ) then
        begin
          if i = 1 then
          begin
            Value := '';
            result := true;
          end
          else
          begin
//            SetLength(Value, i + 1); // set string Size
            Value := LMDAnsiMakeString(i + 1, #0);
            p1 := PChar(Value);
            result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName),
                nil, nil, PByte(P1), @i) = ERROR_SUCCESS;
            while true do
              if not LMDAnsiReplace(Value, #0, #13#10) then break;
            System.Delete(Value, Length(Value) - 3, 4); // remove the last CRLF
          end;
        end
        else if j = REG_DWORD then
        begin
          result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil,
              nil, @J, @i) = ERROR_SUCCESS;
          Value := IntToStr(J);
        end
        else if j = REG_BINARY then
        begin
        GetMem(P, i);
          result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil,
              nil, P, @i) = ERROR_SUCCESS;
          if result then Value := Data2Str(p, i);
          FreeMem(P);
        end;
      end;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  result := false;
  Value := DefValue;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) then
  begin
    if (E.FValueData.ValueType = evtMultiString) then
    begin
      Value := E.FValueData.MStrValue.Text;
      result := true;
    end
    else if (E.FValueData.ValueType = evtString) then
    begin
      Value := StrPas(E.FValueData.StrValue);
      result := true;
    end
    else if E.FValueData.ValueType = evtInt then
    begin
      Value := IntToStr(E.FValueData.IntValue);
      result := true;
    end
    else if E.FValueData.ValueType = evtDouble then
    begin
      Value := FloatToStr(E.FValueData.DoubleValue);
      result := true;
    end
    else if E.FValueData.ValueType = evtBoolean then
    begin
      if E.FValueData.BoolValue then
        Value := 'true'
      else
        Value := 'false';
      result := true;
    end
    else if E.FValueData.ValueType = evtBinary then
    begin
      Value := Data2Str(E.FValueData.DataValue, E.FValueData.DataLength);
      result := true;
    end
  end;
end;

function TElIniFile.RenameKey(Key, NewName : string): Boolean;

var
  E: TElIniEntry;
begin
  if FUseRegistry then raise EElIniError.Create(
      'Key can not be renamed when using registry.');
  result := false;
  E := GetValueEntry(Key, '');
  if (E <> nil) and (E <> FRoot) then
  begin
    if KeyExists(Copy(Key, 1, LMDAnsiLastPos(FDelimiter, Key) - 1) + NewName) or (Pos(
        FDelimiter, NewName) <> 0) then exit;
    E.ValueName := NewName;
    result := true;
    FModified := true;
  end;
end;

function TElIniFile.RenameValue(Key, ValueName, NewName : string): Boolean;
var
  E: TElIniEntry;
  FOldKey: String;
  begin
  if FUseRegistry then
  begin
    FOldKey := FCurrentKey;
    result := false;
    if OpenKey(Key, false) then
    try
      FRegistry.RenameValue(ValueName, NewName);
      result := true;
    except
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) and (E <> FRoot)
    and (GetValueEntry(Key, NewName) = nil)
    and (Pos(FDelimiter, NewName) = 0) then
  begin
    E.ValueName := NewName;
    result := true;
    FModified := true;
  end
  else
    result := false;
end;

const
    BoolValues : array[boolean] of string = ('false', 'true');
  const
    IntValues : array[boolean] of char = ('0', '1');

procedure TElIniFile.IntSaveBinKey(F : TStream; KeyName : string; KeyEntry : TElIniEntry);
var b : boolean;
    i,
    j,
    k : integer;
    E : TElIniEntry;
begin
  b := true;
  F.WriteBuffer(b, sizeof(b));
  LMDAnsiWriteStringToStream(F, KeyName);
  for i := 0 to KeyEntry.FChildren.Count - 1 do
  begin
    E := TElIniEntry(KeyEntry.FChildren[i]);
    if E.FValueData.ValueType = evtUnknown then Continue;
    b := false;
    F.WriteBuffer(b, sizeof(b));
    LMDAnsiWriteStringToStream(F, E.ValueName);
    F.WriteBuffer(E.FValueData.ValueType, sizeof(E.FValueData.ValueType));
    case E.FValueData.ValueType of
      evtBoolean:
        j := sizeof(boolean);
      evtDouble:
        j := sizeof(double);
      evtInt:
        j := sizeof(integer);
      evtString:
        j := sizeof(integer) + StrLen(E.FValueData.StrValue);
        evtMultiString:
        begin
          j := 0;
          for k := 0 to E.FValueData.MStrValue.Count - 1 do
            j := j + sizeof(integer) + Length(E.FValueData.MStrValue[k]);
        end;
      evtBinary:
        j := sizeof(integer) + E.FValueData.DataLength;
      end;

    F.WriteBuffer(j, sizeof(j));
    case E.FValueData.ValueType of
      evtBoolean:
        F.WriteBuffer(E.FValueData.BoolValue, sizeof(E.FValueData.BoolValue));
      evtDouble:
        F.WriteBuffer(E.FValueData.DoubleValue, sizeof(E.FValueData.DoubleValue));
      evtInt:
        F.WriteBuffer(E.FValueData.IntValue, sizeof(E.FValueData.IntValue));
      evtString:
        LMDAnsiWriteStringToStream(F, StrPas(E.FValueData.StrValue));
        evtMultiString:
        begin
          for k := 0 to E.FValueData.MStrValue.Count - 1 do
            LMDAnsiWriteStringToStream(F, E.FValueData.MStrValue[k]);
        end;
      evtBinary:
        begin
          F.WriteBuffer(E.FValueData.DataLength, sizeof(E.FValueData.DataLength));
          F.WriteBuffer(PChar(E.FValueData.DataValue)^, E.FValueData.DataLength);
          end;
    end;
  end; // for
  for i := 0 to KeyEntry.FChildren.Count - 1 do
  begin
    E := TElIniEntry(KeyEntry.FChildren[i]);
    if E.FIsKey then
      if KeyName <> '' then
        IntSaveBinKey(F, KeyName + FDelimiter + E.ValueName, E)
      else
        IntSaveBinKey(F, E.ValueName, E);
  end; // for
end;

procedure TElIniFile.IntSaveKey(F : TStream; KeyName : string; KeyEntry : TElIniEntry);
var
  i,
  j : integer;
  E : TElIniEntry;
  S : string;
begin
  if KeyName <> '' then
  begin
    AnsiWriteTextToStream(F, '');
    AnsiWriteTextToStream(F, '[' + KeyName + ']');
  end;
  for i := 0 to KeyEntry.FChildren.Count - 1 do
  begin
    E := TElIniEntry(KeyEntry.FChildren[i]);
    if (Length(E.ValueName) > 0) and (E.ValueName[1] <> '#') then
      S := E.ValueName + FDivChar
    else
      S := '';
    case E.FValueData.ValueType of
      evtUnknown :
        begin
        end;
      evtDouble:
        begin
          S := S + StrFloat(E.FValueData.DoubleValue);
          AnsiWriteTextToStream(F, S);
        end;
      evtInt :
        begin
          S := S + IntToStr(E.FValueData.IntValue);
          AnsiWriteTextToStream(F, S);
        end;
      evtBoolean :
        begin
          if FSimple then
            S := S + IntValues[E.FValueData.BoolValue]
          else
            S := S + BoolValues[E.FValueData.BoolValue];
          AnsiWriteTextToStream(F, S);
        end;
      evtString :
        begin
          S := S + StrPas(E.FValueData.StrValue);
          AnsiWriteTextToStream(F, S);
        end;
      evtMultiString :
        begin
          for j := 0 to E.FValueData.MStrValue.Count - 1 do
          begin
            S := E.ValueName + '[' + IntToStr(j) + ']' + FDivChar +
                E.FValueData.MStrValue[j];
            AnsiWriteTextToStream(F, S);
          end;
        end;
      evtBinary :
        begin
          S := S + Data2Str(E.FValueData.DataValue,
              E.FValueData.DataLength);
          AnsiWriteTextToStream(F, S);
        end;
    end; // case
  end; // for
  for i := 0 to KeyEntry.FChildren.Count - 1 do
  begin
    E := TElIniEntry(KeyEntry.FChildren[i]);
    if E.FIsKey then
      if KeyName <> '' then
        IntSaveKey(F, KeyName + FDelimiter + E.ValueName, E)
      else
        IntSaveKey(F, E.ValueName, E);
  end; // for
end; // procedure

procedure TElIniFile.SaveToStream(Stream : TStream{$IFDEF LMDCOMP12}; Encoding: TEncoding = nil{$ENDIF});
{$ifdef LMDCOMP12}
var
  LEncoding: TEncoding;
  LBuffer: TBytes;
{$endif}
begin
  if FUseRegistry then exit;
  TriggerBeforeSaveEvent;
  try
    if FBinaryMode then
    begin
      IntSaveBinKey(Stream, '', FRoot);
    end else
    begin
      {$ifdef LMDCOMP12}
      if not Assigned(Encoding) then
        LEncoding := TEncoding.UTF8
      else
        LEncoding := Encoding;
      LBuffer := LEncoding.GetPreamble;
      Stream.Write(LBuffer[0], Length(LBuffer));
      {$else}
      LMDWriteBOM(Stream, bomUTF8);
      {$endif}
      if FWarningMessage <> '' then
        AnsiWriteTextToStream(Stream, FComment + FWarningMessage);
      IntSaveKey(Stream, '', FRoot);
    end;
  finally
    TriggerAfterSaveEvent;
  end;
end;

type
  THackFileStream = class(TLMDFileStream);

function TElIniFile.Save: Boolean;
var
  F : TStream;
begin
  result := false;
  //F := nil;
  TriggerBeforeSaveEvent;
  try
    if FUseRegistry or (FPath = '') then exit;
    F := TLMDFileStream.Create(FPath, fmCreate or fmShareDenyWrite);
    try
      if Self.FBinaryMode then
      begin
        IntSaveBinKey(F, '', FRoot);
      end else
      begin
        if FWarningMessage <> '' then
          AnsiWriteTextToStream(F, FComment + FWarningMessage);
        IntSaveKey(F, '', FRoot);
      end;
      FModified := false;
      result := true;
      FlushFileBuffers(THackFileStream(F).Handle);
      finally
      F.Free;
    end;
  finally
    TriggerAfterSaveEvent;
  end;
end;

procedure TElIniFile.SetCurrentKey(const newValue: String);
begin
  if (FCurrentKey <> newValue) then OpenKey(newValue, true);
end;

procedure TElIniFile.SetDelimiter(newValue: Char);
begin
  if (FDelimiter <> newValue) then
  begin
    if FUseRegistry and (newValue <> '\') then raise EElIniError.Create(
        'Changing delimiter is not available when using registry.');
    FDelimiter := newValue;
    if FCurEntry = FRoot then FCurrentKey := FDelimiter;
    if not LazyWrite then Save;
  end; {if}
end;

procedure TElIniFile.SetLazyWrite(newValue: Boolean);
begin
  if (FLazyWrite <> newValue) then
  begin
    FLazyWrite := newValue;
    if FUseRegistry then
      FRegistry.LazyWrite := newValue;
    end;
end;

procedure TElIniFile.SetPath(newValue: TLMDString);
begin
  if (FPath <> newValue) then
  begin
    if FUseRegistry then
    begin
//      FSavePath := FPath;
      if (Length(NewValue) > 0) and (newValue[Length(newValue)] = '\') then
          System.Delete(newValue, Length(newValue), 1);
          if (Length(newValue) = 0) then newValue := '\';
      if newValue[1] <> '\' then newValue := '\' + newValue;
      if FRegistry.OpenKey(newValue, true) then FPath := newValue;
    end
    else
    FPath := newValue;
  end;
end;

procedure TElIniFile.SetRegRoot(newValue: TRegRootType);
begin
  if (RegRoot <> newValue) then
  begin
    case newValue of
      rrtHKEY_LOCAL_MACHINE : FRegRoot := HKEY_LOCAL_MACHINE;
      rrtHKEY_USERS : FRegRoot := HKEY_USERS;
      rrtHKEY_CURRENT_USER : FRegRoot := HKEY_CURRENT_USER;
      rrtHKEY_CLASSES_ROOT : FRegRoot := HKEY_CLASSES_ROOT;
      rrtHKEY_CURRENT_CONFIG : FRegRoot := HKEY_CURRENT_CONFIG;
    end;
    if Assigned(FRegistry) then FRegistry.RootKey := FRegRoot;
  end; {if}
end;

procedure TElIniFile.SetSimple(newValue: Boolean);
var
//  TPBuf: array[1..MAX_PATH + 1] of char;
//  TPBuf1: array[1..MAX_PATH + 1] of char;
  TFName: String;
  RN: String;
  TD: Char;
begin
  if (FSimple <> newValue)
  and (not FUseRegistry)
  then
  begin
    TFName := ElTools.GetTempFile('');
    RN := FPath;
    FPath := TFName;
    Save;
    FSimple := NewValue;
    if FSimple then
    begin
      TD := FDelimiter;
      FDelimiter := #0;
      Load;
      FDelimiter := TD;
    end
    else
      Load;
    FPath := RN;
    DeleteFile(TFName);
  end; {if}
end;

procedure TElIniFile.SetUseRegistry(newValue: Boolean);
begin
  if (FUseRegistry <> newValue) then
  begin
    if newValue then
    begin
      FRegistry := TRegistry.Create;
      FRegistry.RootKey := FRegRoot;
      if FPath = '' then FPath := '\SOFTWARE';
      FRegistry.OpenKey(FPath + FCurrentKey, true);
    end
    else
    begin
      FRegistry.Free;
      FRegistry := nil;
    end;
    FUseRegistry := newValue;
  end; {if}
end;

procedure TElIniFile.SetValueType(Key, ValueName : string; NewType :
    TElValueType);
var
  E: TElIniEntry;
begin
  if FUseRegistry then raise EElIniError.Create(
      'SetValueType method is not available when using registry.');
  E := CreateValue(Key, ValueName);
  if E <> nil then
  begin
    E.Invalidate;
    E.FValueData.ValueType := NewType;
    if NewType = evtMultiString then E.FValueData.MStrValue :=
        TStringList.Create;
  end;
  FModified := true;
end;

function TElIniFile.SubKeysCount(Key : string): Integer;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  if EnumSubKeys(Key, SL) then
    result := SL.Count
  else
    result := -1;
  SL.Free;
end;

function TElIniFile.ValueExists(Key : string; ValueName : string): Boolean;
var
  S: String;
  E: TElIniEntry;
begin
  if FUseRegistry then
  begin
    result := false;
    S := CurrentKey;
    if OpenKey(Key, false) then result := FRegistry.ValueExists(ValueName);
    OpenKey(S, false);
    exit;
  end;
  S := CurrentKey;
  result := false;
  if OpenKey(Key, false) then
  begin
    E := FCurEntry.GetValue(ValueName);
    if (E <> nil) and (not E.FIsKey) then result := true;
  end;
  OpenKey(S, false);
end;

function TElIniFile.ValuesCount(Key : string): Integer;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  if EnumValues(Key, SL) then
    result := SL.Count
  else
    result := -1;
  SL.Free;
end;

function TElIniFile.WriteBinary(Key : string; ValueName : string; var Buffer;
    BufferLen : integer): Boolean;
var
  S: String;
  E: TElIniEntry;

  FOldKey: String;
begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    if OpenKey(Key, true) then
    result := RegSetValueEx(FRegistry.CurrentKey, PChar(ValueName), 0,
          REG_BINARY, @Char(Buffer), BufferLen) = ERROR_SUCCESS;
    OpenKey(FOldKey, false);
    exit;
  end;
  S := FCurrentKey;
  result := false;
  if FSimple then exit;
  if not OpenKey(Key, true) then
  begin
    OpenKey(S, false);
    exit;
  end;
  E := CreateValue('', ValueName);
  E.FValueData.ValueType := evtBinary;
  GetMem(E.FValueData.DataValue, BufferLen);
  Move(Buffer, PChar(E.FValueData.DataValue)^, BufferLen);
  E.FValueData.DataLength := BufferLen;
  result := true;
  FModified := true;
  if not FLazyWrite then Save;
  OpenKey(S, false);
end;

function TElIniFile.WriteBool(Key : string; ValueName : string; Value :
    boolean): Boolean;
var
  S: String;
  E: TElIniEntry;

  FOldKey: String;
  i: Integer;
  begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    if OpenKey(Key, true) then
    begin
      if Value then
        i := 1
      else
        i := 0;
      result := RegSetValueEx(FRegistry.CurrentKey, PChar(ValueName), 0,
          REG_DWORD, @i, 4) = ERROR_SUCCESS;
      end;
    OpenKey(FOldKey, false);
    exit;
  end;
  S := FCurrentKey;
  result := false;
  if FSimple then exit;
  if not OpenKey(Key, true) then
  begin
    OpenKey(S, false);
    exit;
  end;
  E := CreateValue('', ValueName);
  E.FValueData.ValueType := evtBoolean;
  E.FValueData.BoolValue := Value;
  result := true;
  FModified := true;
  if not FLazyWrite then Save;
  OpenKey(S, false);
end;

function TElIniFile.WriteInteger(Key : string; ValueName : string; Value :
    integer): Boolean;
var
  S: String;
  E: TElIniEntry;

  FOldKey: String;
  begin
  Result := false;
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    if OpenKey(Key, true) then
    result := RegSetValueEx(FRegistry.CurrentKey, PChar(ValueName), 0,
          REG_DWORD, @Value, 4) = ERROR_SUCCESS;
    OpenKey(FOldKey, false);
    exit;
  end;
  S := FCurrentKey;
  if not OpenKey(Key, true) then
  begin
    OpenKey(S, false);
    exit;
  end;
  E := CreateValue('', ValueName);
  E.FValueData.ValueType := evtInt;
  E.FValueData.IntValue := Value;
  Result := true;
  FModified := true;
  if not FLazyWrite then Save;
  OpenKey(S, false);
end;

function TElIniFile.WriteMultiString(Key : string; ValueName : string; Strings
    : TStrings): Boolean;
var
  S: String;
  E: TElIniEntry;
  FOldKey: String;
  {$IFDEF LMD_UNICODE}
  WS, WVName: WideString;
  {$ENDIF}
begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    if OpenKey(Key, true) then
    begin
      S := Strings.Text;
      S := S+#0+#0;
      while true do
        if not LMDAnsiReplace(S, #13#10, #0) then break;
      {$IFDEF LMD_UNICODE}
      WVName := WideString(ValueName);
      WS := WideString(S);
      result := RegSetValueExW(FRegistry.CurrentKey, PWideChar(WVName), 0,
          REG_MULTI_SZ, PWideChar(WS), Length(WS)*2) = ERROR_SUCCESS;
      {$ELSE}
      result := RegSetValueExA(FRegistry.CurrentKey, PChar(ValueName), 0,
          REG_MULTI_SZ, PAnsiChar(S), Length(S)) = ERROR_SUCCESS;
      {$ENDIF}
      end;
    OpenKey(FOldKey, false);
    exit;
  end;
  S := FCurrentKey;
  result := false;
  if FSimple then exit;
  if not OpenKey(Key, true) then
  begin
    OpenKey(S, false);
    exit;
  end;
  E := CreateValue('', ValueName);
  E.FValueData.ValueType := evtMultiString;
  E.FValueData.MStrValue := TStringList.Create;
  E.FValueData.MStrValue.Assign(Strings);
  result := true;
  FModified := true;
  if not FLazyWrite then Save;
  OpenKey(S, false);
end;

{$IFNDEF LMD_NATIVEUNICODE}
{$ifdef LMD_UNICODE}
function TElIniFile.WriteMultiString(Key : string; ValueName : string; Strings
    : TLMDStrings): Boolean;
var
  S: WideString;
  E: TElIniEntry;

  FOldKey: String;

begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    if OpenKey(Key, true) then
    begin
      S := Strings.Text;
      while true do
        if not LMDWideReplace(S, #13#10, #0) then break;
      result := RegSetValueEx(FRegistry.CurrentKey, PChar(ValueName), 0,
          REG_MULTI_SZ, PWideChar(S), Length(S) + 1) = ERROR_SUCCESS;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  S := FCurrentKey;
  result := false;
  if FSimple then exit;
  if not OpenKey(Key, true) then
  begin
    OpenKey(S, false);
    exit;
  end;
  E := CreateValue('', ValueName);
  E.FValueData.ValueType := evtMultiString;
  E.FValueData.MStrValue := TStringList.Create;
  E.FValueData.MStrValue.Assign(Strings);
  result := true;
  FModified := true;
  if not FLazyWrite then Save;
  OpenKey(S, false);
end;
{$endif}
{$ENDIF}

function TElIniFile.WriteObject(Key : string; AnObject : TPersistent): Boolean;
var
  i: Integer;
  // S: string;
  FSaveKey: String;
  PropName: ShortString;
  PropCount: Integer;
  PropList: PPropList;
  ExtValue: Extended;
  Obj: TObject;
  CI: TCollectionItem;
  {$ifdef LMD_UNICODE}
  WS: WideString;
  {$endif}
  procedure WriteCollection(Path : String; Obj : TCollection);
  var j : integer;
  begin
    for j := 0 to Obj.Count - 1 do
    begin
      CI := Obj.Items[j];
      WriteObject(Path + 'Item{' + IntToStr(j) + '}', CI);
    end;
  end;

  procedure WriteObjectList(Path : String; Obj : TElObjectList);
  var i,j : integer;
      OI  : TElObjectListItem;
      S   : String;
  begin
    i := 0;
    for j := 0 to Obj.Count - 1 do
    begin
      OI := Obj.Items[j];
      if OI <> nil then
      begin
        S := Path + 'Item{' + IntToStr(i) + '}';
        TElObjectListItem(OI).BeforeSave(Self, S);
        WriteObject(S, OI);
        if Obj is TElHeteroObjectList then
           WriteString(S, 'ClsNm',
                       OI.ClassName);
        TElObjectListItem(OI).AfterSave(Self, S);
        inc(i);
      end;
    end;
  end;

begin
  result := false;
  FSaveKey := CurrentKey;
  if OpenKey(Key, true) then
  begin
    {
    if AnObject is TCollection then
    begin
      WriteCollection(Key, TCollection(AnObject));
      result := true;
    end else
    }
    begin
      PropCount := GetPropList(AnObject.ClassInfo, [tkInteger, tkFloat, tkChar,
        tkWChar, {!}tkWString, tkClass, tkEnumeration, tkString, tkLString], nil);
      GetMem(PropList, PropCount * sizeof(pointer));
      try
        GetPropList(AnObject.ClassInfo, [tkInteger, tkFloat, tkChar, tkWChar,
            {!}tkWString, tkClass, tkEnumeration, tkString, tkLString], PropList);
      for i := 0 to PropCount - 1 do
        begin
          PropName := PropList[i]^.Name;
          case PropList[i]^.PropType^.Kind of
          tkFloat:
              begin
                ExtValue := GetFloatProp(AnObject, PropList[i]);
                WriteBinary('', String(PropName), ExtValue, sizeof(ExtValue));
              end;
            tkString, tkLString:
                WriteString('', String(PropName), GetStrProp(AnObject, PropList[i]));
            {$ifdef LMD_UNICODE}
            tkWString:
              begin
                //WS := GetStrProp(AnObject, PropList[i]);
                GetWideStrProp(AnObject, PropList[I], WS);
                //if WS = '' then
                //  Continue;
                WriteWideString('', String(PropName), WS);
                end;
            {$endif}
            tkEnumeration,
              tkInteger,
              tkChar, tkWChar :
                WriteInteger('', String(PropName), GetOrdProp(AnObject, PropList[i]));
            tkClass:
              begin
                Obj := TObject(Pointer(GetOrdProp(AnObject, PropList[i])));
                if Obj <> nil then
                begin
                  if Obj is TStrings then
                     WriteMultiString('', String(PropName), TStrings(Obj))
                  else
                  if Obj is TPersistent then
                     WriteObject(String(PropName), TPersistent(Obj));
                end;
              end;
          end;
        end;
        if AnObject is TCollection then
           WriteCollection('', TCollection(AnObject))
        else
        if AnObject is TElObjectList then
        begin
          TElObjectList(AnObject).BeforeSave(Self, CurrentKey);
          WriteObjectList('', TElObjectList(AnObject));
          TElObjectList(AnObject).AfterSave(Self, CurrentKey);
        end;
      finally
        FreeMem(PropList);
        end;
      result := true;
    end;
    FModified := true;
  end;
  OpenKey(FSaveKey, true);
end;

function TElIniFile.WriteRect(Key : string; ValueName : string; Value : TRect): Boolean;
begin
  result := WriteString(Key, ValueName, LMDAnsiRectToString(Value));
end;

function TElIniFile.WriteColor(Key : string; ValueName : string; Value : TColor): Boolean;
var S : String;
begin
  S := ColorToString(Value);
  result := WriteString(Key, ValueName, S);
end;

function TElIniFile.WriteString(Key : string; ValueName : string; Value :
    string): Boolean;
var
  S: String;
  E: TElIniEntry;

  FOldKey: String;
begin
  Result := false;
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    if OpenKey(Key, true) then
    result := RegSetValueEx(FRegistry.CurrentKey, PChar(ValueName), 0, REG_SZ,
          PChar(Value), (Length(Value) + 1 ) * SizeOf(Char)) = ERROR_SUCCESS;
    OpenKey(FOldKey, false);
    exit;
  end;
  S := FCurrentKey;
  if not OpenKey(Key, true) then
  begin
    OpenKey(S, false);
    exit;
  end;
  E := CreateValue('', ValueName);
  E.FValueData.ValueType := evtString;
  GetMem(E.FValueData.StrValue, (Length(Value) + 1) * SizeOf(Char));
  StrPLCopy(E.FValueData.StrValue, Value, Length(Value));
  result := true;
  FModified := true;
  if not FLazyWrite then Save;
  OpenKey(S, false);
end;

procedure TElIniFile.TriggerBeforeSaveEvent;
{ Triggers the OnBeforeSave event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnBeforeSave)) then
    FOnBeforeSave(Self);
end;  { TriggerBeforeSaveEvent }

procedure TElIniFile.TriggerAfterLoadEvent;
begin
  if (assigned(FOnAfterLoad)) then
    FOnAfterLoad(Self);
end;  { TriggerAfterLoadEvent }

procedure TElIniFile.TriggerBeforeLoadEvent;
begin
  if (assigned(FOnBeforeLoad)) then
    FOnBeforeLoad(Self);
end;  { TriggerBeforeLoadEvent }

procedure TElIniFile.TriggerAfterSaveEvent;
begin
  if (assigned(FOnAfterSave)) then
    FOnAfterSave(Self);
end;  { TriggerAfterSaveEvent }

function TElIniFile.ReadDouble(Key : string; ValueName : string; DefValue :
    Double; var Value : Double): Boolean;
var
  E: TElIniEntry;
  FOldKey: String;
  i, j: Integer;
  ev: Extended;
  dsep: Char;
begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    result := false;
    Value := DefValue;
    if OpenKey(Key, false) then
    begin
      if RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil, @j, nil,
          @i) = ERROR_SUCCESS then
      begin
        if (j = REG_BINARY) and (i = sizeof(double)) then
        result := RegQueryValueEx(FRegistry.CurrentKey, PChar(ValueName), nil,
              nil, @Value, @i) = ERROR_SUCCESS;
        end;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  result := false;
  E := GetValueEntry(Key, ValueName);
  if (E <> nil) then
  begin
    if (E.FValueData.ValueType = evtDouble) then
    begin
      Value := E.FValueData.DoubleValue;
      result := true;
    end
    else
    if (E.FValueData.ValueType = evtInt) then
    begin
      Value := E.FValueData.IntValue;
      result := true;
    end
    else
    if (E.FValueData.ValueType = evtString) then
    begin
      // YB: Customer reports that long doubles are not parsed. I've changed
      // the code to use standard Delphi TryStrToFloat function  instead of LMD
      // ValFloat.
      // Sample ini file:
      //   [MainKey]
      //   Var1=0.0021046446945
      //   Var2=0.0022946446945
      //   Var3=9.9E-14

      dsep := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
      {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator := '.';
      try
        if TryStrToFloat(E.FValueData.StrValue, ev) then
        begin
          Value := ev;
          Result := True;
        end
        else
          Value := DefValue;
      finally
        {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator := dsep;
      end;

      // Old code:
      //  ValFloat(E.FValueData.StrValue, Value, i);
      //  if i = 0 then
      //    Result := True
      //  else
      //    Value := DefValue;
    end
    else
      Value := DefValue;
  end
  else
    Value := DefValue;
end;

function TElIniFile.WriteDouble(Key : string; ValueName : string; Value :
    Double): Boolean;
var
  S: String;
  E: TElIniEntry;

  FOldKey: String;
  begin
  if FUseRegistry then
  begin
    FOldKey := CurrentKey;
    Result := False;
    if OpenKey(Key, true) then
    begin
    Result := RegSetValueEx(FRegistry.CurrentKey, PChar(ValueName), 0,
          REG_BINARY, @Value, sizeof(Value)) = ERROR_SUCCESS;
    end;
    OpenKey(FOldKey, false);
    exit;
  end;
  S := FCurrentKey;
  result := false;
  if not OpenKey(Key, true) then
  begin
    OpenKey(S, false);
    exit;
  end;
  E := CreateValue('', ValueName);
  E.FValueData.ValueType := evtDouble;
  E.FValueData.DoubleValue := Value;
  result := true;
  FModified := true;
  if not FLazyWrite then Save;
  OpenKey(S, false);
end;

{$ifdef LMD_UNICODE}

function TElIniFile.ReadWideString(Key, ValueName: string;
  DefValue: WideString; var Value: WideString): Boolean;
var
  S: String;
begin
  if ValueExists(Key, ValueName) then
  begin
    result := ReadString(Key, ValueName, '', S);
    if Result then
    begin
      if LMDConvertUTF8toUTF16(AnsiString(S), Value, strictConversion, false) <> conversionOK then
        Value := S;
    end
    else
      Value := DefValue;
  end
  else
  begin
    Result := false;
    Value := DefValue;
  end;
end;
{$ENDIF}

{$ifdef LMD_UNICODE}
function TElIniFile.WriteWideString(Key, ValueName: string;
  Value: WideString): Boolean;
var
  S: AnsiString;
begin
  LMDConvertUTF16toUTF8(Value, S, strictConversion, false);
  result := WriteString(Key, ValueName, String(S));
end;
{$endif}

function TElIniFile.CopyValue(Key, ValueName: string; DestKey : string):
    Boolean;
var vt: TElValueType;
    b : boolean;
    i : integer;
    dv: double;
    s : string;
    SL: TStringList;
    p : pointer;
    FOldKey : string;
begin
  FOldKey := CurrentKey;
  result := false;
  if OpenKey(Key, true) then
  begin
    vt := GetValueType('', ValueName);
    case vt of
      evtUnknown : ;
      evtBoolean :
        begin
          if ReadBool('', ValueName, false, b) then
            result := WriteBool(DestKey, ValueName, b);
        end;
      evtInt :
        begin
          if ReadInteger('', ValueName, 0, i) then
            result := WriteInteger(DestKey, ValueName, i);
        end;
      evtDouble :
        begin
          if ReadDouble('', ValueName, 0, dv) then
            result := WriteDouble(DestKey, ValueName, dv);
        end;
      evtString :
        begin
          if ReadString('', ValueName, '', s) then
            result := WriteString(DestKey, ValueName, s);
        end;
      evtMultiString:
        begin
          SL := TStringList.Create;
          if ReadMultiString('', ValueName, SL) then
            result := WriteMultiString(DestKey, ValueName, SL);
        end;
      evtBinary :
        begin
          i := -1;
          ReadBinary('', ValueName, p, i);
          if i > -1 then
          begin
            GetMem(P, i);
            if ReadBinary('', ValueName, PChar(p)^, i) then
            begin
              Result := WriteBinary(DestKey, ValueName, i, SizeOf(i));
              Result := Result and WriteBinary(DestKey, ValueName, PChar(p)^, i);
              end;
            FreeMem(p);
            end;
        end;
    end;
  end;
  OpenKey(FOldKey, false);
end;

end.
