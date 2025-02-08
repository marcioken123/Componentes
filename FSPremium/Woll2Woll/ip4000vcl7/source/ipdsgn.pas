unit ipdsgn;
{
//
// Description : Picture Mask Design Time Access
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
}
interface

uses classes, registry, inifiles;

Procedure wwOpenPictureIni;
Procedure wwClosePictureIni;
Function wwIniGetPictureDescription(Mask: string): string;
Procedure wwVerifyPictureKeyValue(var Key, Value: string);

Function IniPict: TIniFile;

implementation

var Ini: TIniFile;
//var
//    inicount: integer;

Function IniPict: TIniFile;
begin
   if ini=nil then wwOpenPictureIni;
   result:= ini;
end;

procedure wwVerifyPictureKeyValue(var Key, Value: string);
var i: integer;
    tempValue: string;
begin
   for i:= 1 to length(Key) do
     if (ord(key[i])<32) or (key[i]='=') then key[i]:= ' ';
   tempValue:= '';

   for i:= 1 to length(Value) do
      if not (ord(Value[i])<32) or (Value[i]='=') then tempValue:= tempValue + Value[i];
   Value:= tempValue;
end;


Function wwIniGetPictureDescription(Mask: string): string;
var i: integer;
    masks: TStringList;
begin
   masks:= TStringList.create;
   iniPict.ReadSectionValues('Picture Masks', masks);
   result:= '';
   for i:= 0 to masks.count-1 do
   begin
      if masks.Values[masks.Names[i]] = Mask then
      begin
         result:= masks.Names[i];
      end;
   end;
   masks.free;
end;

Procedure wwOpenPictureIni;
const DefaultINI = 'InfoPowerMasks.ini';
var ipreg: TRegIniFile;
    FileName: string;
begin
   if ini<>nil then exit;

   ipreg := TRegIniFile.create('');
   FileName:= ipreg.ReadString('\Software\Woll2Woll\InfoPower', 'Masks IniFile', DefaultINI);
   if FileName='' then FileName:=DefaultIni;
   ipreg.free;
   ini:= TIniFile.create(FileName);
end;

Procedure wwClosePictureIni;
begin
{  dec(inicount);
  if inicount<=0 then
  begin
     inipict.free;
     inipict:= nil;
  end
  else }
  ini.UpdateFile;
end;

initialization
finalization
   ini.Free;
end.
