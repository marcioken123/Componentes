unit ElRegUtils;
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

ElRegUtils unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, LMDTypes;

type
  TRegRootType = (rrtUnknown, rrtHKEY_CLASSES_ROOT, rrtHKEY_CURRENT_USER,
                  rrtHKEY_LOCAL_MACHINE, rrtHKEY_USERS, rrtHKEY_CURRENT_CONFIG);
  TRegRoots = set of TRegRootType;

function OpenRegKey (const ComputerName : string; RT : TRegRootType;
  const KeyName : string; var KeyRes: HKey): Boolean;
function IsValidKeyName(Name : Ansistring) : boolean;

function RootTypeToHandle(RT : TRegRootType) : HKey;
function RootTypeName(RT : TRegRootType) : string;
function RootTypeShortName(RT : TRegRootType) : string;
function ValueTypeToString(VT : Integer) : string;

function NameToRootType(const Name : string) : TRegRootType;

function KeyHasSubKeys0(Key: HKey; const KeyName : string) : boolean;
function KeyHasSubKeys(const ComputerName : string; RT : TRegRootType;
  const KeyName : string) : boolean;
function KeyHasValue(const ComputerName : string; RT : TRegRootType;
  const KeyName : string; const ValueName : string;
  var Exists : boolean) : boolean;
function KeyGetClassName(const ComputerName : string; RT : TRegRootType;
  const KeyName : string; var ClassName : string) : boolean;

function KeyDelete(const ComputerName : string; RT : TRegRootType;
  const KeyName : string) : boolean;
function KeyClear(const ComputerName : string; RT : TRegRootType;
  const KeyName : string) : boolean;
function KeyCreateSubKey(const ComputerName : string; RT : TRegRootType;
  const KeyName, SubKeyName, NewClassName : string) : boolean;
function KeySetValue(const ComputerName : string; RT : TRegRootType;
  const KeyName, ValueName : string; ValueType : integer; Value : Pointer;
  ValueSize : integer) : boolean;
function KeyDeleteValue(const ComputerName : string; RT : TRegRootType;
  const KeyName, ValueName : string) : boolean;
function KeyRenameValue(const ComputerName : string; RT : TRegRootType;
  const KeyName, ValueName, NewName : string) : boolean;

function KeyEnumSubKeys0(Key: HKey; const KeyName : string;
                         SL : TStringList) : boolean;
function KeyEnumSubKeys(const ComputerName : string; RT : TRegRootType;
  const KeyName : string; SL : TStringList) : boolean;

function KeyEnumValues(const ComputerName : string; RT : TRegRootType;
  const KeyName : string; SL : TStringList) : boolean;
function KeyGetValueInfo(const ComputerName : string; RT : TRegRootType;
  const KeyName : string; const ValueName : string;
  var ValueType : DWORD; var ValueString : string (*; var ValueSize : integer *)) : boolean;

function CopyKey(const OldComputerName, NewComputerName : string;
  OldRT, NewRT : TRegRootType;  const OldKeyName, NewKeyName : string) : boolean;

function GetLastRegError : string;

implementation
uses
  SysUtils, 
  LMDStrings, LMDSysIn, LMDUtils, LMDProcs;

var
  fListError: TStringList = nil;

{-----------}

function GetLastRegError : string;
begin
  if  fListError <> nil then
  begin
    Result := fListError.Text;
    fListError.Free;
    fListError := nil;
  end
  else
    Result := '';
end;

{-----------}

procedure AddError (const ErrMsg: string);
begin
  if fListError = nil then
  begin
    fListError := TStringList.Create;
    fListError.Duplicates := dupIgnore;
  end;
  fListError.Add(ErrMsg);
end;

{-----------}

procedure SetLastRegError;
var
  i : integer;
  Buf : array[0..2048] of char;
  begin
  i := GetLastError;
  if i <> ERROR_SUCCESS then
  begin
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil, i, 0, Buf, sizeof (Buf), nil);
    AddError (StrPas(Buf));
    end;
end;

function IsValidKeyName(Name: Ansistring) : boolean;
var
  i : integer;
begin
  result := true;
  for i := 1 to Length(Name) do // Iterate
  begin
    if (not (Name[i] in [#32..#127])) or (Name[i] in ['*', '?']) then
    begin
      result := false;
      break;
    end;
  end; // for
end;
{
function GetLastRegError : string;
begin
  result := fLastRegError;
  fLastRegError := '';
end;

procedure SetLastRegError;
var
  i : integer;
  Buf : array[0..2048] of char;
begin
  i := GetLastError;
  if i <> ERROR_SUCCESS then
  begin
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil, i, 0, Buf,
                        sizeof (Buf), nil);
    fLastRegError := StrPas(Buf);
  end;
end;
}
function KeyClear(const ComputerName : string; RT : TRegRootType;
  const KeyName : string) : boolean;
var
  SL : TStringList;
  i : integer;
begin
  SL := TStringList.Create;
  if KeyEnumSubKeys(ComputerName, RT, KeyName, SL) then
  begin
    result := true;
    for i := 0 to SL.Count - 1 do // Iterate
    begin
      if not KeyDelete(ComputerName, RT, KeyName + '\' + SL[i]) then
      begin
        result := false;
        break;
      end;
    end; // for
  end
  else
    result := false;
  SL.Free;
end;

function KeyHasValue(const ComputerName : string; RT : TRegRootType;
  const KeyName : string; const ValueName : string; var Exists : boolean) : boolean;
var
  P : PChar;
  RK, LK, SK : HKEY;
  begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_QUERY_VALUE, SK) = ERROR_SUCCESS) then
    begin
      if Length(ValueName) = 0 then
        P := nil
      else
        P := Int_Ref(ValueName);

      Exists := RegQueryValueEx(SK, P, nil, nil, nil, nil) = ERROR_SUCCESS;
      result := true;
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeyRenameValue(const ComputerName : string; RT : TRegRootType;
  const KeyName, ValueName, NewName : string) : boolean;
var
  P : PChar;
  RK, LK, SK : HKEY;
  Value : Pointer;
  ValueSize : DWORD;
  ValueType : DWORD;
begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_ref(KeyName), 0, KEY_SET_VALUE or KEY_QUERY_VALUE, SK) = ERROR_SUCCESS) then
    begin
      if Length(NewName) = 0 then
        P := nil
      else
        P := Int_Ref(NewName);
      if RegQueryValueEx(SK, P, nil, @ValueType, nil, @ValueSize) = ERROR_SUCCESS then
        AddError ('Value name already exists')
      else
      begin
        if Length(ValueName) = 0 then
          P := nil
        else
          P := Int_Ref(ValueName);
        if RegQueryValueEx(SK, P, nil, @ValueType, nil, @ValueSize) = ERROR_SUCCESS then
        begin
          GetMem(Value, ValueSize);
          if RegQueryValueEx(SK, P, nil, @ValueType, Value, @ValueSize) = ERROR_SUCCESS then
          begin
            if Length(NewName) = 0 then
              P := nil
            else
              P := Int_Ref(NewName);
            if RegSetValueEx(SK, P, 0, ValueType, Value, ValueSize) = ERROR_SUCCESS then
            begin
              if Length(ValueName) = 0 then
                P := nil
              else
                P := Int_Ref(ValueName);
              if RegDeleteValue(SK, P) = ERROR_SUCCESS then
                result := true
              else
              begin
                SetLastRegError;
                if Length(NewName) = 0 then
                  P := nil
                else
                  P := Int_Ref(NewName);
                RegDeleteValue(SK, P);
              end;
            end
            else
              SetLastRegError;
          end;
          FreeMem(Value);
          end
        else
          SetLastRegError;
      end;
      //if RegDeleteValue(SK, P) = ERROR_SUCCESS then result := true else SetLastRegError;
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeyDeleteValue(const ComputerName : string; RT : TRegRootType;
                const KeyName, ValueName : string) : boolean;
var
  P : PChar;
  RK,
    LK,
    SK : HKEY;
begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_WRITE, SK) = ERROR_SUCCESS) then
    begin
      if Length(ValueName) = 0 then
        P := nil
      else
        P := Int_Ref(ValueName);
      if RegDeleteValue(SK, P) = ERROR_SUCCESS then
        result := true
      else
        SetLastRegError;
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeySetValue(const ComputerName : string; RT : TRegRootType;
                const KeyName, ValueName : string;
                ValueType : integer; Value : Pointer;
                ValueSize : integer) : boolean;
var
  P : PChar;
  RK,
    LK,
    SK : HKEY;
begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_WRITE, SK) = ERROR_SUCCESS) then
    begin
      if Length(ValueName) = 0 then
        P := nil
      else
        P := Int_Ref(ValueName);
      if RegSetValueEx(SK, P, 0, ValueType, Value, ValueSize) = ERROR_SUCCESS then
        result := true
      else
        SetLastRegError;
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeyCreateSubKey(const ComputerName : string; RT : TRegRootType;
                const KeyName, SubKeyName, NewClassName : string) : boolean;
var
  P : PChar;
  RK,
    LK,
    NK,
    SK : HKEY;
  Dispos : DWORD;
begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_WRITE, SK) = ERROR_SUCCESS) then
    begin
      if Length(NewClassName) <> 0 then
        P := Int_Ref(NewClassName)
      else
        P := nil;
      if RegCreateKeyEx(SK, Int_Ref(SubKeyName), 0, P, 0, KEY_WRITE, nil, NK, @Dispos) = ERROR_SUCCESS then
      begin
        RegCloseKey(NK);
        result := true;
      end
      else
        SetLastRegError;
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeyDelete(const ComputerName : string; RT : TRegRootType;
                const KeyName : string) : boolean;
var
  P : PChar;
  RK,
    LK,
    SK : HKEY;
  Ps, S : string;

begin
  result := false;
  if (not LMDSIWindowsNT) or (KeyClear(ComputerName, RT, KeyName)) then
  begin
    if Length(ComputerName) <> 0 then
      P := Int_Ref(ComputerName)
    else
      P := nil;
    if Pos('\', KeyName) = 0 then
    begin
      Ps := RootTypeName(RT);
      S := KeyName;
    end
    else
    begin
      Ps := Copy(KeyName, 1, LMDLastPos('\', KeyName) - 1);
      S := Copy(KeyName, LMDLastPos('\', KeyName) + 1, Length(KeyName));
    end;
    LK := RootTypeToHandle(RT);
    if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
    begin
      SK := RootTypeToHandle(NameToRootType(Ps));
      if SK <> HKEY(-1) then SK := RK;
      if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(Ps), 0, KEY_WRITE, SK) = ERROR_SUCCESS) then
      begin
        result := RegDeleteKey(SK, Int_Ref(S)) = ERROR_SUCCESS;
        SetLastRegError;
        if NameToRootType(KeyName) = rrtUnknown then RegCloseKey(SK);
      end
      else
        SetLastRegError;
      RegCloseKey(RK);
    end
    else
      SetLastRegError;
  end
  else
    SetLastRegError;
end;

function CopyKey(const OldComputerName, NewComputerName : string;
  OldRT, NewRT : TRegRootType;
  const OldKeyName, NewKeyName : string) : boolean;
var
  OldP,
  NewP : PChar;
  OldRK,
  OldLK,
  OldSK,
  NewRK,
  NewLK,
  NewSK,
  HKeyRes : HKEY;
  MaxKeyLen,
  CLLen,
  i, KeyCount : Dword;
  S : string;
  Len : DWORD;
  SL : TStringList;
  ClassName : string;
  ValueType,
  Dispos : Dword;
  DataBuf : Pointer;
  ClNameLen: DWORD;

begin
  try
    result := true;
    if Length(OldComputerName) <> 0 then
      OldP := Int_Ref(OldComputerName)
    else
      OldP := nil;

    OldLK := RootTypeToHandle(OldRT);
    if RegConnectRegistry(OldP, OldLK, OldRK) <> ERROR_SUCCESS then
      raise Exception.Create('');

    OldSK := RootTypeToHandle(NameToRootType(OldKeyName));
    if OldSK <> HKEY(-1) then
      OldSK := OldRK;

    if (OldSK = HKEY(-1)) and (RegOpenKeyEx(OldRK, Int_Ref(OldKeyName), 0, KEY_READ, OldSK) <> ERROR_SUCCESS) then
      raise Exception.Create('');

    if Length(NewComputerName) <> 0 then
      NewP := Int_Ref(NewComputerName)
    else
      NewP := nil;
    NewLK := RootTypeToHandle(NewRT);

    if RegConnectRegistry(NewP, NewLK, NewRK) <> ERROR_SUCCESS then
      raise Exception.Create('');

    NewSK := RootTypeToHandle(NameToRootType(NewKeyName));
    if NewSK <> HKEY(-1) then
      NewSK := NewRK;

    if RegQueryInfoKey(OldSK, nil, @CLNameLen, nil, nil, nil, nil, nil, nil, nil, nil, nil) <> ERROR_SUCCESS then
    raise Exception.Create('');

    SetLength(ClassName, ClNameLen + 1);
    if RegQueryInfoKey(OldSK, Int_Ref(ClassName), @ClNameLen, nil, nil, nil, nil, nil, nil, nil, nil, nil) <> ERROR_SUCCESS then
    raise Exception.Create('');

    if (NewSK = HKEY(-1)) and (RegCreateKeyEx(NewRK, Int_Ref(NewKeyName), 0, Int_Ref(ClassName), 0, KEY_WRITE,  nil, NewSK, @Dispos) <> ERROR_SUCCESS) then
      raise Exception.Create('');

    SL := nil;
    try
      SL := TStringList.Create;
      ClNameLen := 0;

      if RegQueryInfoKey(OldSK, nil, nil, nil, @KeyCount, @MaxKeyLen, @CLNameLen, nil, nil, nil, nil, nil) <> ERROR_SUCCESS then
      raise Exception.Create('');

      SetLength(S, MaxKeyLen + 1);
      SetLength(ClassName, ClNameLen + 1);

      for I := 0 to KeyCount - 1 do
      begin
        Len := MaxKeyLen + 1;
        CLLen := CLNameLen + 1;
        if RegEnumKeyEx(OldSK, I, Int_Ref(S), Len, nil, Int_Ref(ClassName), @CLLen, nil) <> ERROR_SUCCESS then
        raise Exception.Create('');

        if RegCreateKeyEx(NewSK, Int_Ref(S), 0, Int_Ref(ClassName), 0, KEY_WRITE, nil, HKeyRes, @Dispos) <>ERROR_SUCCESS then
          raise Exception.Create('');

        CopyKey(OldComputerName, NewComputerName, OldRT, NewRT, OldKeyName + '\' + StrPas(Int_Ref(S)), NewKeyName + '\' + StrPas(Int_Ref(S)));
        RegCloseKey(HKeyRes);
      end;

      if RegQueryInfoKey(OldSK, nil, nil, nil, nil, nil, nil, @KeyCount, @MaxKeyLen, nil, nil, nil) <> ERROR_SUCCESS then
      raise Exception.Create('');

      SetLength(S, MaxKeyLen + 1);
      for I := 0 to KeyCount - 1 do
      begin
        Len := MaxKeyLen + 1;
        if RegEnumValue(OldSK, I, Int_Ref(S), Len, nil, @ValueType, nil, @CLLen) <>ERROR_SUCCESS then
        raise Exception.Create('');

        GetMem(DataBuf, CLLen);
        Len := MaxKeyLen + 1;
        RegEnumValue(OldSK, I, Int_Ref(S), Len, nil, @ValueType, PByte(DataBuf), @CLLen);
        RegSetValueEx(NewSK, Int_Ref(S), 0, ValueType, DataBuf, CLLen);
        FreeMem(DataBuf);
        end;
    finally
      SL.Free;
    end;

    if NameToRootType(NewKeyName) = rrtUnknown then
      RegCloseKey(NewSK);

    if NameToRootType(OldKeyName) = rrtUnknown then
      RegCloseKey(OldSK);

    RegCloseKey(OldRK);
  except
    on E : Exception do
    begin
      SetLastRegError;
      result := false;
    end;
  end;
end;

function KeyGetClassName(const ComputerName : string; RT : TRegRootType;
  const KeyName : string; var ClassName : string) : boolean;
var
  P : PChar;
  RK, LK,
    SK : HKEY;
  MaxKeyLen : DWORD;
  S : string;
  begin
  result := false;
  ClassName := '';
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS, SK) = ERROR_SUCCESS) then
    begin
      if RegQueryInfoKey(SK, nil, @MaxKeyLen, nil, nil, nil, nil, nil, nil, nil, nil, nil) = ERROR_SUCCESS then
      begin
        SetLength(S, MaxKeyLen + 1);
        if RegQueryInfoKey(SK, Int_Ref(S), @MaxKeyLen, nil, nil, nil, nil, nil, nil, nil, nil, nil) = ERROR_SUCCESS then
        begin
          ClassName := S;
          result := true;
        end
        else
          SetLastRegError;
      end
      else
        SetLastRegError;
      if NameToRootType(KeyName) = rrtUnknown then RegCloseKey(SK);
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeyEnumValues(const ComputerName : string; RT : TRegRootType;
                const KeyName : string; SL : TStringList) : boolean;
var
  P : PChar;
  RK, LK,
    SK : HKEY;
  MaxKeyLen : DWORD;
  i: integer;
  KeyCount : DWORD;
  S : string;
  Len: dword;

begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_QUERY_VALUE, SK) = ERROR_SUCCESS) then
    begin
      if RegQueryInfoKey(SK, nil, nil, nil, nil, nil, nil, @KeyCount, @MaxKeyLen, nil, nil, nil) = ERROR_SUCCESS then
      begin
        SetLength(S, MaxKeyLen + 1);
        result := true;
        for I := 0 to KeyCount - 1 do
        begin
          Len := MaxKeyLen + 1;
          if RegEnumValue(SK, I, PChar(S), Len, nil, nil, nil, nil) <> ERROR_SUCCESS then
          begin
            result := false;
            SetLastRegError;
            break;
          end;
          SL.Add(PChar(S));
          end;
      end
      else
        SetLastRegError;
      if NameToRootType(KeyName) = rrtUnknown then RegCloseKey(SK);
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeyGetValueInfo;
var
  P : PChar;
  RK,
    LK,
    SK : HKEY;
  BufLen : DWORD;
  Buf : PByte;
  begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_QUERY_VALUE, SK) = ERROR_SUCCESS) then
    begin
      if Length(ValueName) = 0 then
        P := nil
      else
        P := Int_Ref(ValueName);
      if RegQueryValueEx(SK, P, nil, nil, nil, @BufLen) = ERROR_SUCCESS then
      begin
        GetMem(Buf, BufLen);
        if RegQueryValueEx(SK, P, nil, @ValueType, Buf, @BufLen) = ERROR_SUCCESS then
        begin
          if (ValueType = REG_SZ) or (ValueType = REG_EXPAND_SZ) then
            ValueString := StrPas(PChar(Buf))
            else if ValueType = REG_DWORD then
            ValueString := IntToStr(PInteger(Buf)^)
            else if ValueType = REG_MULTI_SZ then
          begin
            SetLength(ValueString, BufLen);
            MoveMemory(Int_Ref(ValueString), Buf, BufLen);
            ValueString := LMDReplaceStr(ValueString, #0, #13#10);
            Delete(ValueString, Length(ValueString) - 3, 4);
          end
          else
          begin
            ValueString := LMDDataToStr(Buf, BufLen);
            Delete(ValueString, 1, Pos(' ', ValueString));
            Delete(ValueString, 1, Pos(' ', ValueString));
          end;
          result := true;
        end;
        FreeMem(Buf);
        end
      else
        SetLastRegError;
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeyEnumSubKeys(const ComputerName : string; RT : TRegRootType;
                const KeyName : string; SL : TStringList) : boolean;
var
  P : PChar;
  RK, LK,
    SK : HKEY;
  MaxKeyLen : DWORD;
  KeyCount : DWORD;
  S : string;
  i, Len : DWORD;
  begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS, SK) = ERROR_SUCCESS) then
    begin
      if RegQueryInfoKey(SK, nil, nil, nil, @KeyCount, @MaxKeyLen, nil, nil, nil, nil, nil, nil) = ERROR_SUCCESS then
      begin
        SetLength(S, MaxKeyLen + 1);
        result := true;
        for I := 0 to KeyCount - 1 do
        begin
          Len := MaxKeyLen + 1;
          if RegEnumKeyEx(SK, I, Int_Ref(S), Len, nil, nil, nil, nil) <> ERROR_SUCCESS then
          begin
            result := false;
            SetLastRegError;
            break;
          end;
          SL.Add(Int_Ref(S));
          end;
      end
      else
        SetLastRegError;
      if NameToRootType(KeyName) = rrtUnknown then RegCloseKey(SK);
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function KeyHasSubKeys(const ComputerName : string; RT : TRegRootType;
                const KeyName : string) : boolean;
var
  P : PChar;
  RK, LK, SK : HKEY;
  i: integer;
  KeyCount : DWORD;
  begin
  result := false;
  if Length(ComputerName) <> 0 then
    P := Int_Ref(ComputerName)
  else
    P := nil;
  LK := RootTypeToHandle(RT);
  if RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));
    if SK <> HKEY(-1) then SK := RK;
    if (SK <> HKEY(-1)) or (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS, SK) = ERROR_SUCCESS) then
    begin
      i := RegQueryInfoKey(SK, nil, nil, nil, @KeyCount, nil, nil, nil, nil, nil, nil, nil);
      if i = ERROR_SUCCESS then result := KeyCount > 0;
      if NameToRootType(KeyName) = rrtUnknown then RegCloseKey(SK);
    end
    else
      SetLastRegError;
    RegCloseKey(RK);
  end
  else
    SetLastRegError;
end;

function NameToRootType;
begin
  if Name = 'HKEY_LOCAL_MACHINE' then
    result := rrtHKEY_LOCAL_MACHINE
  else if Name = 'HKEY_USERS' then
    result := rrtHKEY_USERS
  else if Name = 'HKEY_CURRENT_USER' then
    result := rrtHKEY_CURRENT_USER
  else if Name = 'HKEY_CLASSES_ROOT' then
    result := rrtHKEY_CLASSES_ROOT
  else if Name = 'HKEY_CURRENT_CONFIG' then
    result := rrtHKEY_CURRENT_CONFIG
  else
    result := rrtUnknown;
end;

function RootTypeName;
begin
  case RT of
    rrtHKEY_LOCAL_MACHINE : result := 'HKEY_LOCAL_MACHINE';
    rrtHKEY_USERS : result := 'HKEY_USERS';
    rrtHKEY_CURRENT_USER : result := 'HKEY_CURRENT_USER';
    rrtHKEY_CLASSES_ROOT : result := 'HKEY_CLASSES_ROOT';
    rrtHKEY_CURRENT_CONFIG : result := 'HKEY_CURRENT_CONFIG';
  else
    result := '';
  end;
end;

function RootTypeShortName(RT : TRegRootType) : string;
begin
  case RT of
    rrtHKEY_LOCAL_MACHINE:  Result := 'HKLM';
    rrtHKEY_USERS:          Result := 'HKEY_USERS';
    rrtHKEY_CURRENT_USER:   Result := 'HKCU';
    rrtHKEY_CLASSES_ROOT:   Result := 'HKCR';
    rrtHKEY_CURRENT_CONFIG: Result := 'HKCC';
  else
    Result := '';
  end;
end;

{-----------}

function ValueTypeToString(VT : Integer) : string;
begin
  case VT of
    REG_BINARY : result := 'REG_BINARY';
    REG_SZ : result := 'REG_SZ';
    REG_MULTI_SZ : result := 'REG_MULTI_SZ';
    REG_EXPAND_SZ : result := 'REG_EXPAND_SZ';
    REG_DWORD : result := 'REG_DWORD';
    REG_NONE : result := 'REG_NONE';
    REG_LINK : result := 'REG_LINK';
    REG_RESOURCE_LIST : result := 'REG_RESOURCE_LIST';
    REG_DWORD_BIG_ENDIAN : result := 'REG_DWORD_BIG_ENDIAN';
  else
    result := 'REG_NONE';
  end;
end;

function RootTypeToHandle;
begin
  case RT of
    rrtHKEY_LOCAL_MACHINE : result := HKEY_LOCAL_MACHINE;
    rrtHKEY_USERS : result := HKEY_USERS;
    rrtHKEY_CURRENT_USER : result := HKEY_CURRENT_USER;
    rrtHKEY_CLASSES_ROOT : result := HKEY_CLASSES_ROOT;
    rrtHKEY_CURRENT_CONFIG : result := HKEY_CURRENT_CONFIG;
  else
    result := HKEY(-1);
  end;
end;

function KeyHasSubKeys0(Key: HKey; const KeyName : string) : boolean;
var
  SK: HKey;
  KeyCount: DWORD;
  begin
  Result := FALSE;

  if  RegOpenKeyEx(Key, Int_Ref(KeyName), 0,
      KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS, SK) = ERROR_SUCCESS then
  begin
    try
      if  RegQueryInfoKey(SK, nil, nil, nil, @KeyCount, nil,
            nil, nil, nil, nil, nil, nil) = ERROR_SUCCESS then
      Result := (KeyCount > 0);
    finally
      RegCloseKey(SK);
    end;
  end;
end;
{-----------}

function KeyEnumSubKeys0(Key: HKey; const KeyName : string;
                         SL : TStringList) : boolean;
var
  SK : HKEY;
  i: integer;
  MaxKeyLen, KeyCount : DWORD;
  S : string;
  Len: dword;
  begin
  Result := FALSE;

  if  Trim (KeyName) = ''   then  SK := Key;

  if  (SK = Key)
      OR (RegOpenKeyEx(Key, Int_Ref(KeyName), 0, KEY_QUERY_VALUE
              or KEY_ENUMERATE_SUB_KEYS, SK) = ERROR_SUCCESS) then
  begin
    try
      if RegQueryInfoKey(SK, nil, nil, nil, @KeyCount, @MaxKeyLen,
                  nil, nil, nil, nil, nil, nil) = ERROR_SUCCESS then
      begin
        SetLength(S, MaxKeyLen + 1);
        Result := TRUE;
        dec (KeyCount);

        for i := 0 to KeyCount do
        begin
          Len := MaxKeyLen + 1;
          if  RegEnumKeyEx(SK, I, Int_Ref(S), Len, nil, nil,
                          nil, nil) <> ERROR_SUCCESS          then
          begin
            Result := FALSE;
            SetLastRegError;
            break;
          end;
          SL.Add(Int_Ref(S));
          end;
      end
      else
        SetLastRegError;

    finally
      if  (Key <> SK)     then  RegCloseKey(SK);
    end;
  end
  else
     SetLastRegError;
end;
{-----------}

function OpenRegKey (const ComputerName : string; RT : TRegRootType;
                     const KeyName : string; var KeyRes: HKey): Boolean;
var
  P : PChar;
  RK, LK,
    SK : HKEY;
begin
  Result := false;

  if Length(ComputerName) <> 0 then   P := Int_Ref(ComputerName)
  else                                P := nil;

  LK := RootTypeToHandle(RT);

  if  RegConnectRegistry(P, LK, RK) = ERROR_SUCCESS then
  begin
    SK := RootTypeToHandle(NameToRootType(KeyName));

    if SK <> HKEY(-1) then SK := RK;

    if  (SK <> HKEY(-1)) or
        (RegOpenKeyEx(RK, Int_Ref(KeyName), 0, KEY_QUERY_VALUE or
                KEY_ENUMERATE_SUB_KEYS, SK) = ERROR_SUCCESS) then
    begin
      Result := TRUE;
      KeyRes := SK;
    end;

    RegCloseKey(RK);
  end;
end;
{-----------}

initialization

finalization

  if (fListError <> nil) then
  begin
    fListError.Free;
    fListError := nil;
  end;

end.
