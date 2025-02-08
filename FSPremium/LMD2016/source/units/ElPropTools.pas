unit ElPropTools;
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

ElPropTools unit
----------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, TypInfo, ElIni, ElTools, ElVCLUtils, 
  LMDUnicodeStrings, LMDUnicode;

function HasProperty(Comp : TObject; PropertyName : string) : boolean;
function GetPropertyRecord(Comp : TObject; PropertyName : string) : PPropInfo;

procedure StoreSetProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure StoreFloatProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure StoreObject(Comp : TObject; Storage : TElIniFile);
procedure StoreCollection(Collection : TCollection; Name : string; Storage : TElIniFile);
procedure StoreIntegerProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure StoreEnumProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure StoreStringProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure StoreStringList(Strings : TStrings; Name : string; Storage : TElIniFile);

{$ifdef LMD_UNICODE}
procedure StoreWideStringProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure StoreWideStringList(Strings : TLMDWideStrings; Name : string; Storage : TElIniFile);
{$endif}

procedure LoadSetProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure LoadFloatProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure LoadObject(Comp : TObject; Storage : TElIniFile);
procedure LoadCollection(Collection : TCollection; Name : string; Storage : TElIniFile);
procedure LoadIntegerProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure LoadEnumProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure LoadStringProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure LoadStringList(Strings : TStrings; Name : string; Storage : TElIniFile);

{$ifdef LMD_UNICODE}
procedure LoadWideStringProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
procedure LoadWideStringList(Strings : TLMDWideStrings; Name : string; Storage : TElIniFile);
{$endif}

implementation

procedure LoadSetProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
begin
  LoadIntegerProperty(Comp, Prop, Storage);
end;

procedure LoadFloatProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
var
  X : Extended;
  Stream : TDirectMemoryStream;
  i : integer;
begin
  Stream := TDirectMemoryStream.Create;
  i := SizeOf(X);
  Stream.SetSize(i);
  Storage.ReadBinary('', String(Prop.Name), pchar(Stream.Memory)^, i);
  Stream.ReadBuffer(X, i);
  Stream.Free;
  SetFloatProp(Comp, Prop, X);
end;

function GetPropertyRecord(Comp : TObject; PropertyName : string) : PPropInfo;
var
  i : integer;
  PropCount : Integer;
  PropList : PPropList;
  PPI : PPropInfo;
begin
  PropCount := GetPropList(Comp.ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkSet, tkClass], nil);
  GetMem(PropList, PropCount * sizeof(pointer));
  GetPropList(Comp.ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkSet, tkClass], PropList);
  for i := 0 to PropCount - 1 do // Iterate
  begin
    if Uppercase(String(PropList[i].Name)) = Uppercase(PropertyName) then
    begin
      New(PPI);
      Move(PropList[i]^, PPI^, sizeof(PPI^));
      Result := PPI;
      FreeMem(PropList);
      exit;
    end;
  end; // for
  FreeMem(PropList);
  result := nil;
end;

function HasProperty(Comp : TObject; PropertyName : string) : boolean;
var
  i : integer;
  PropCount : Integer;
  PropList : PPropList;
begin
  PropCount := GetPropList(Comp.ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkSet, tkClass], nil);
  GetMem(PropList, PropCount * sizeof(pointer));
  GetPropList(Comp.ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkSet, tkClass], PropList);
  for i := 0 to PropCount - 1 do // Iterate
  begin
    if Uppercase(String(PropList[i].Name)) = Uppercase(PropertyName) then
    begin
      result := true;
      FreeMem(PropList);
      exit;
    end;
  end; // for
  FreeMem(PropList);
  result := false;
end;

procedure LoadObject(Comp : TObject; Storage : TElIniFile);
var
  i : integer;
  PropCount : Integer;
  PropList : PPropList;
  Obj : TObject;
  FSaveKey : string;
begin
  PropCount := GetPropList(Comp.ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkSet, tkClass], nil);
  GetMem(PropList, PropCount * sizeof(pointer));
  GetPropList(Comp.ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkSet, tkClass], PropList);
  for i := 0 to PropCount - 1 do // Iterate
  begin
    case PropList[i]^.PropType^.Kind of //
      tkString,
        tkLString : LoadStringProperty(Comp, PropList[i], Storage);
      {$ifdef LMD_UNICODE}
      tkWString:
        LoadWideStringProperty(Comp, PropList[i], Storage);
      {$endif}
      tkEnumeration,
        tkInteger : LoadIntegerProperty(Comp, PropList[i], Storage);
      tkSet : LoadSetProperty(Comp, PropList[i], Storage);
      tkFloat : LoadFloatProperty(Comp, PropList[i], Storage);
      tkClass :
        begin
          Obj := TObject(GetOrdProp(Comp, PropList[i]));
          if (Obj <> nil) then
          begin
            if Obj is TStrings then
              LoadStringList(Obj as TStrings, String(PropList[i].Name), Storage)
            {$ifdef LMD_UNICODE}
            else
            if Obj is TLMDWideStrings then
              LoadWideStringList(Obj as TLMDWideStrings, String(PropList[i].Name), Storage)
            {$endif}
            else if Obj is TCollection then
              LoadCollection(Obj as TCollection, String(PropList[i].Name), Storage)
            else
            begin
              FSaveKey := Storage.CurrentKey;
              if Storage.OpenKey(String(PropList[i].Name), false) then LoadObject(Obj as TObject, Storage);
              Storage.OpenKey(FSaveKey, false);
            end;
          end;
        end;
    end; // case
  end; // for
  FreeMem(PropList);
  end;

procedure LoadCollection(Collection : TCollection; Name : string; Storage : TElIniFile);
var
  FSaveKey,
    FSaveKey1 : string;
  i : integer;
begin
  FSaveKey := Storage.CurrentKey;
  if Storage.OpenKey(Name, false) then
  begin
    for i := 0 to Collection.Count - 1 do // Iterate
    begin
      FSaveKey1 := Storage.CurrentKey;
      if Storage.OpenKey('Item' + IntToStr(i), false) then
        LoadObject(Collection.Items[i], Storage);
      Storage.OpenKey(FSaveKey1, false);
    end; // for
  end;
  Storage.OpenKey(FSaveKey, false);
end;

procedure LoadIntegerProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
var
  i : integer;
begin
  Storage.ReadInteger('', String(Prop.Name), GetOrdProp(Comp, Prop), i);
  SetOrdProp(Comp, Prop, i);
end;

procedure LoadEnumProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
begin
  LoadIntegerProperty(Comp, Prop, Storage);
end;

procedure LoadStringProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
var
  S : string;
begin
  Storage.ReadString('', String(Prop.Name), GetStrProp(Comp, Prop), S);
  SetStrProp(Comp, Prop, S);
end;

{$ifdef LMD_UNICODE}
procedure LoadWideStringProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
var
  WS: WideString;
  S: String;
begin
  Storage.ReadString('', String(Prop.Name), GetStrProp(Comp, Prop), S);
  LMDConvertUTF8toUTF16(AnsiString(S), WS, strictConversion, false);
  SetWideStrProp(Comp, Prop, WS);
end;

procedure LoadWideStringList(Strings : TLMDWideStrings; Name : string; Storage : TElIniFile);
begin
  Storage.ReadMultiString('', Name, Strings)
end;
{$endif}

procedure LoadStringList(Strings : TStrings; Name : string; Storage : TElIniFile);
begin
  Storage.ReadMultiString('', Name, Strings);
end;

type
  TFakeSet = set of 0..31;

procedure StoreStringList(Strings : TStrings; Name : string; Storage : TElIniFile);
begin
  Storage.WriteMultiString('', Name, Strings);
end;

procedure StoreObject(Comp : TObject; Storage : TElIniFile);
var
  i : integer;
  PropCount : Integer;
  PropList : PPropList;
  Obj : TObject;
  FSaveKey : string;
//  {$ifdef LMD_UNICODE}
//  S: string;
//  WS: WideString;
//  {$endif}
begin
  PropCount := GetPropList(Comp.ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkWString, tkSet, tkClass], nil);
  GetMem(PropList, PropCount * sizeof(pointer));
  GetPropList(Comp.ClassInfo, [tkInteger, tkEnumeration, tkString, tkLString, tkWString, tkSet, tkClass], PropList);
  for i := 0 to PropCount - 1 do // Iterate
  begin
    case PropList[i]^.PropType^.Kind of //
      tkString,
        tkLString : StoreStringProperty(Comp, PropList[i], Storage);
      tkEnumeration,
        tkInteger : StoreIntegerProperty(Comp, PropList[i], Storage);
      {$ifdef LMD_UNICODE}
      tkWString: StoreWideStringProperty(Comp, PropList[i], Storage);
      {$endif}
      tkSet : StoreSetProperty(Comp, PropList[i], Storage);
      tkFloat : StoreFloatProperty(Comp, PropList[i], Storage);
      tkClass :
        begin
          Obj := TObject(GetOrdProp(Comp, PropList[i]));
          if (Obj <> nil) then
          begin
            if Obj is TStrings then
              StoreStringList(Obj as TStrings, String(PropList[i].Name), Storage)
            else if Obj is TCollection then
              StoreCollection(Obj as TCollection, String(PropList[i].Name), Storage)
            else
            {$ifdef LMD_UNICODE}
            if Obj is TLMDWideStrings then
              StoreWideStringList(Obj as TLMDWideStrings, String(PropList[i].Name), Storage)
            else
            {$endif}
            begin
              FSaveKey := Storage.CurrentKey;
              if Storage.OpenKey(String(PropList[i].Name), true) then StoreObject(Obj as TObject, Storage);
              Storage.OpenKey(FSaveKey, false);
            end;
          end;
        end;
    end; // case
  end; // for
  FreeMem(PropList);
  end;

procedure StoreCollection(Collection : TCollection; Name : string; Storage : TElIniFile);
var
  FSaveKey,
    FSaveKey1 : string;
  i : integer;
begin
  FSaveKey := Storage.CurrentKey;
  if Storage.OpenKey(Name, true) then
  begin
    for i := 0 to Collection.Count - 1 do // Iterate
    begin
      FSaveKey1 := Storage.CurrentKey;
      if Storage.OpenKey('Item' + IntToStr(i), true) then
        StoreObject(Collection.Items[i], Storage);
      Storage.OpenKey(FSaveKey1, false);
    end; // for
  end;
  Storage.OpenKey(FSaveKey, false);
end;

procedure StoreIntegerProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
var
  i : integer;
begin
  i := GetOrdProp(Comp, Prop);
  Storage.WriteInteger('', String(Prop.Name), i);
end;

procedure StoreEnumProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
begin
  StoreIntegerProperty(Comp, Prop, Storage);
end;

procedure StoreStringProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
var
  S : string;
begin
  S := GetStrProp(Comp, Prop);
  Storage.WriteString('', String(Prop.Name), S);
end;

{$ifdef LMD_UNICODE}
procedure StoreWideStringProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
var
  WS: WideString;
  S: AnsiString;
begin
  WS := GetWideStrProp(Comp, Prop);
  LMDConvertUTF16toUTF8(WS, S, strictConversion, false);
  Storage.WriteString('', String(Prop.Name), String(S));
end;

procedure StoreWideStringList(Strings : TLMDWideStrings; Name : string; Storage : TElIniFile);
begin
  Storage.WriteMultiString('', Name, Strings)
end;
{$endif}

procedure StoreSetProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
begin
  StoreIntegerProperty(Comp, Prop, Storage);
end;

procedure StoreFloatProperty(Comp : TObject; Prop : PPropInfo; Storage : TElIniFile);
var
  X : Extended;
  Stream : TDirectMemoryStream;
  begin
  X := GetFloatProp(Comp, Prop);
  Stream := TDirectMemoryStream.Create;
  Stream.WriteBuffer(X, SizeOf(X));
  Storage.WriteBinary('', String(Prop.Name), pchar(Stream.Memory)^, sizeof(X));
  Stream.Free;
  end;

end.
