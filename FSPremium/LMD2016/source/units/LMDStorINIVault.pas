unit LMDStorINIVault;
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

LMDStorINIVault unit (VO)
------------------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Types, Classes, INIFiles, Graphics, Windows,
  LMDUnicode, LMDStorBase, LMDStorCommon, LMDStorPropertiesStorage;

Const
  MaxINIStringLength = 900;

type
  // helper class
  TIniCrackWriter = class(TWriter);

  {-------------------  Class TLMDStorCustomXMLVault --------------------------}
  TLMDStorCustomINIVault = class(TLMDAbstractStorageVault)
  private
    INI: TMemIniFile;
    function CurrentActiveSection: string;
    procedure LoadComponent(Name, szObject: String; Writer: TIniCrackWriter);
    procedure WriteSimpleProperty(const Section, Ident, PropType,
      PropValue: string);
    procedure ReadSimpleProperty(const Section, Ident: string; var PropType,
      PropValue: string);
    procedure WriteEssence(const Section, Ident, szObj, szType:
      string; Instance: TPersistent);
    function ReadEssence(const Section, Ident, szObj: string;
      Instance: TPersistent): TPersistent;
    procedure SaveObject(Stream: TStream; Section, szObj, szType: string);
  protected
    function Extension: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save(Stream: TMemoryStream); override;
    procedure Load(Stream: TMemoryStream); override;
    procedure Clear;
    procedure Open; override;
    procedure Close; override;
    procedure Update; override;
    function KeyExists(const Key: string; Section: string = ''): Boolean;
      override;
    function SectionExists(const Section: string): Boolean; override;
    procedure DeleteKey(const Section, Ident: string); override;
    procedure DeleteKeyEx(const Section, Ident, szObj, szType: string);
    procedure AddSection(const Section: string); override;
    function RenameSection(const OldName, NewName: string): Boolean; override;
    function RemoveSection(const Section: string): Boolean; override;
    function DeleteSection(const Section: string): Boolean; override;
    function ClearSection(const Section: string): Boolean; override;
    procedure ReadKeys(Strings: TStrings; Section: string = ''); override;
    function KeyCount(Section: string = ''): Integer; override;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); override;
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
      override;
    procedure WriteColor(const Section, Ident: string; Value: TColor); override;
    function ReadColor(const Section, Ident: string; Default: TColor): TColor;
      override;
    procedure WriteObject(const Section, Ident: string; Instance: TPersistent);
      override;
    function ReadObject(const Section, Ident: string; Instance: TPersistent):
      TPersistent; override;
    procedure WriteComponent(const Instance: TComponent;
      const Section: string = ''); override;
    function ReadComponent(const Section: string; Instance: TComponent):
      TComponent; override;
    procedure WriteDate(const Section, Ident: string; Value: TDateTime);
     override;
    function ReadDate(const Section, Ident: string; Default: TDateTime):
     TDateTime; override;
    procedure WriteStrings(const Section, Ident: string; Value: TStrings);
      override;
    procedure ReadStrings(const Section, Ident: string; Value: TStrings);
      override;
    procedure WriteDateTime(const Section, Ident: string; Value: TDateTime);
      override;
    function ReadDateTime(const Section, Ident: string; Default: TDateTime):
      TDateTime; override;
    procedure WriteFloat(const Section, Ident: string; Value: Double);
      override;
    function ReadFloat(const Section, Ident: string; Default: Double):
      Double; override;
    procedure WriteFont(const Section, Ident: string; Instance: TFont);
      override;
    function ReadFont(const Section, Ident: string; Instance: TFont): TFont;
      override;
    procedure WriteInteger(const Section, Ident: string; Value: LongInt);
      override;
    function ReadInteger(const Section, Ident: string; Default: LongInt):
      LongInt; override;
    procedure WriteInt64(const Section, Ident: string; Value: Int64); override;
    function ReadInt64(const Section, Ident: string; Default: Int64): Int64;
      override;
    procedure WritePoint(const Section, Ident: string; Value: TPoint); override;
    function ReadPoint(const Section, Ident: string; Default: TPoint): TPoint;
      override;
    procedure WriteRect(const Section, Ident: string; Value: TRect); override;
    function ReadRect(const Section, Ident: string; Default: TRect): TRect;
      override;
    procedure WriteString(const Section, Ident: string; Value: string);
      override;
    function ReadString(const Section, Ident: string; Default: string): string;
      override;
    procedure WriteTime(const Section, Ident: string; Value: TDateTime);
     override;
    function ReadTime(const Section, Ident: string; Default: TDateTime):
     TDateTime; override;
    procedure ReadSection (const Section: String; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
  end;

  TLMDStorINIVault = class(TLMDStorCustomINIVault)
  published
    property BinaryStream;
    property FileName;
    property FilePrefix default ppWindows;
    property AppDataPath;
    property AppDataCommon;
    property Encrypted;
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
    property OnCustomRootRead;
    property OnCustomRootWrite;
    property OnUpdateBeforeClose;
    property Sections;
    property ActiveSection;
    property ActiveSectionIndex;
    property StorageCryptor;
    property AutoUpdate;
  end;

implementation

uses
  Math, SysUtils;

// helper functions
function ReplaceDot(Value: String): String;
begin
  Result := Value;
  ReplaceChar(Result, '.', '|');
end;

function UniqueItem(Item: String; List: TStrings): boolean;
var
  i, m: integer;
begin
  m := 0;
  for i := 0 to List.Count - 1 do if List[i] = Item then m := m + 1;
  result := m < 2;
end;

procedure ClearList(List: TStrings);
var
  i: integer;
begin
  if List.Count = 0 then exit;
  i := 0;
  while i < List.Count do
    if (UniqueItem(List[i], List) and (trim(List[i]) <> ''))
     then i := i + 1 else List.Delete(i);
end;

{********************* TLMDStorCustomINIVault *********************************}
{------------------------- Private --------------------------------------------}
function TLMDStorCustomINIVault.CurrentActiveSection: string;
begin
  Result := ActiveSection;
  if Trim(Result) = '' then Result := 'DATA';
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.LoadComponent(Name, szObject: String;
 Writer: TIniCrackWriter);
var
  SL: TStrings;
  KeyList, NotKeyList: TStrings;
  i, iCount: Integer;
  TS: String;
  CP: String;

  function GetType(PropertyName: String; var szObj: String): String;
  var
    TL: TStrings;
    i: integer;
  begin
    TL := TStringList.Create;
    try
      INI.ReadSection(CurrentActiveSection, TL);
      for i := 0 to TL.Count - 1 do
        if Pos(PropertyName + '@', TL[i]) > 0 then
          begin
            result := ExtractWord(3, TL[i], ['@']);
            szObj  := ExtractWord(2, TL[i], ['@']);
          end;
    finally
      FreeAndNil(TL);
    end;
  end;

  procedure GetComponentList(CompName: String;
   List, KeyList, NotKeyList: TStrings);
  var
    i: integer;
    LS: string;
  begin
    KeyList.Clear;
    NotKeyList.Clear;

    i := 0;

    while i < List.Count do
     if pos(CompName, List[i]) = 1 then
      i := i + 1 else List.Delete(i);

    for i := 0 to List.Count - 1 do
    begin
      LS := List[i];
//      ReplaceChar(LS, '|', '.');
      LS := copy(LS, length(CompName) + 2, length(LS) - length(CompName));
      if pos('@', LS) > 0 then
        LS := copy(LS, 1, pos('@', LS) - 1);
      if pos('.', LS) > 0 then
        KeyList.Add(copy(LS, 1, pos('.', LS) - 1))
      else
        NotKeyList.Add(LS);
      List[i] := LS;
    end;

    ClearList(KeyList);
    ClearList(NotKeyList);
  end;

//  procedure ConvertProperty(PropName: String; bKey: Boolean); forward;

  procedure ConvertValue(PropName: String; bKey: Boolean);
  var
    MS: TMemoryStream;
    Stream: TMemoryStream;
    szTmp, szTmp1, szTmp2 : String;
    szWTmp: WideString;
    p:  PAnsiChar ;
    i, j: Integer;
    SL, SL1: TStringList;
    CP1, CP2: String;
    l : Longint;
    szType: String;
    szObj: String;
    KeyList, NotKeyList: TStrings;
    KeyListIn, NotKeyListIn: TStrings;
  begin
    KeyList := nil;
    NotKeyList := nil;
    SL := nil;

    if bKey then
    begin
      KeyList := TStringList.Create;
      NotKeyList := TStringList.Create;
      SL := TStringList.Create;
      INI.ReadSection(TS, SL);
      GetComponentList(CP + '.' + PropName, SL, KeyList, NotKeyList);
      case PropName[1] of
        '<':
          begin
          Writer.WriteValue(vaList);
          for i := 0 to KeyList.Count - 1 do
              ConvertValue(KeyList[i], True);

            CP1 := CP;
            CP := CP + '.' + PropName;
            for i := 0 to NotKeyList.Count - 1 do
              if NotKeyList[i]<>'Empty' then
                ConvertValue(NotKeyList[i], False);

            CP := CP1;
            Writer.WriteListEnd;
          end;
       '[':
          begin
          Writer.WriteValue(vaCollection);
          for i := 0 to NotKeyList.Count - 1 do
                begin
                  // ConvertProperty(NotKeyList[i], False);
                  szTmp2 := NotKeyList[i];
                  ReplaceChar(szTmp2, '|', '.');
                  Writer.WriteStr(AnsiString(szTmp2));
                  ConvertValue(szTmp2, False);
                end;

              CP1 := CP;
              for i := 0 to KeyList.Count - 1 do
                begin
                  CP := CP1 + '.' + PropName + '.' + KeyList[i];
                  SL1 := TStringList.Create;
                  INI.ReadSection(TS, SL1);
                  KeyListIn := TStringList.Create;
                  NotKeyListIn := TStringList.Create;
                  GetComponentList(CP, SL1, KeyListIn, NotKeyListIn);

                  try
                    Writer.WriteListBegin;
                    CP2 := CP;
                    for j := 0 to KeyListIn.Count - 1 do
                      begin
                        //ConvertProperty(KeyListIn[j], True);
                        szTmp2 := KeyListIn[j];
                        szTmp2 := Copy(szTmp2, 2, Length(szTmp2) - 2);
                        ReplaceChar(szTmp2, '|', '.');
                        Writer.WriteStr(AnsiString(szTmp2));
                        ConvertValue(KeyListIn[j], bKey);
                      end;
                    CP := CP2;

                    for j := 0 to NotKeyListIn.Count - 1 do
                      begin
                        //ConvertProperty(NotKeyListIn[j], False);
                        szTmp2 := NotKeyListIn[j];
                        ReplaceChar(szTmp2, '|', '.');
                        Writer.WriteStr(AnsiString(szTmp2));
                        ConvertValue(szTmp2, False);
                      end;
                    Writer.WriteListEnd;
                  finally
                    SL1.Free;
                    FreeAndNil(KeyListIn);
                    FreeAndNil(NotKeyListIn);
                  end;
                end;
              CP := CP1;
            Writer.WriteListEnd;
          end;
      end;
    end
    else
    begin
      PropName := ReplaceDot(PropName);
      szType := GetType(CP + '.' + PropName, szObj);
      if szType = 'Integer' then
          begin
            szTmp := INI.ReadString(TS, CP + '.' + PropName + '@' + szObj + '@'
             + szType + '@0', '');
            Writer.WriteInteger(DecryptInteger(StrToInt(szTmp)));
          end

       else if szType = 'Binary' then
          begin
            MS := TMemoryStream.Create;
            Stream := TMemoryStream.Create;
            MS.Clear;
            if INI.ValueExists(TS, CP + '.' + PropName + '@' + szObj +
             '@Binary@0') then
            begin
              INI.ReadBinaryStream(TS, CP + '.' + PropName + '@' + szObj +
               '@Binary@0', MS);
              i := 1;
              while INI.ValueExists(TS, CP + '.' + PropName + '@' + szObj +
               '@Binary@' + IntToStr(i)) do
                begin
                MS.Seek(0,soFromEnd);
                INI.ReadBinaryStream(TS, CP + '.' + PropName + '@' + szObj +
                   '@Binary@' + IntToStr(i), MS);
                  i := i + 1;
                end;
            end;

            if CompressedStream then
            begin
            MS.Seek(0, soFromBeginning);
            Stream.CopyFrom(MS, MS.Size);
              MS.Clear;
            Stream.Seek(0, soFromBeginning);
            LMDStorLoadCompressedStream(Stream, MS);
            end;
          MS.Seek(0, soFromBeginning);
          i := MS.Size;
          p := AllocMem(i);
          try
            MS.Read(p^, i);
              case p[0] of
            'S':
                begin
                SetLength(szTmp, i - 1);
                  szTmp := DecryptString(szTmp);
                  Move(p[1], szTmp[1], i - 1);
                  Writer.WriteString(szTmp);
                end;
//                'W':
//                  begin
//                    SetLength(szWTmp,(i-1) div 2);
//                    Move(p[1],szWTmp[1],i-1);
//                    Writer.WriteWideString(szWTmp);
//                  end;
              'E':
                begin
            Writer.WriteFloat(PDouble(Addr(p[1]))^);
            end;
              'D':
                begin
            Writer.WriteDate(PDouble(Addr(p[1]))^);
            end;
              'G':
                begin
                Writer.WriteSingle(PSingle(Addr(p[1]))^);
                end;
              'B':
                begin
               Writer.WriteValue(vaBinary);
               l := i - 1;
                 Writer.Write(l, sizeof(l));
               Writer.Write((p + 1)^, l);
               end;
              'C':
                begin
//2DO - Currency from 2nd (p[1]) byte
//                  Writer.WriteCurrency(Currency.FromBytes(p));
                end;
              else
                begin
               Writer.WriteValue(vaBinary);
               l := i - 1;
                  Writer.Write(l, sizeof(l));
            Writer.Write(p^, l);
            end;
              end;
            finally
            FreeMemory(p);
            end;
            FreeAndNil(MS);
            FreeAndNil(Stream);
          end
        else if szType = 'String' then
          begin
            if INI.ValueExists(TS, CP + '.' + PropName + '@' + szObj +
             '@String@0') then
              begin
                szTMP := INI.ReadString(TS, CP + '.' + PropName + '@' + szObj +
                 '@String@0', '');
                i := 1;
                while INI.ValueExists(TS, CP + '.' + PropName + '@' + szObj +
                 '@String@' + IntToStr(i)) do
                  begin
                    szTMP := szTMP + INI.ReadString(TS, CP + '.' + PropName +
                     '@' + szObj + '@String@' + IntToStr(i), '');
                    i := i + 1;
                  end;
            end;
            szTmp := DecryptString(szTmp);
            Writer.WriteString(szTmp);
          end else

        if szType = 'WideString' then
          begin
            if INI.ValueExists(TS, CP + '.' + PropName + '@' + szObj +
             '@WideString@0') then
              begin
                szTMP := INI.ReadString(TS, CP + '.' + PropName + '@' + szObj +
                 '@WideString@0', '');
                i := 1;
                while INI.ValueExists(TS, CP + '.' + PropName + '@' + szObj +
                 '@WideString@' + IntToStr(i)) do
                  begin
                    szTMP := szTMP + INI.ReadString(TS, CP + '.' + PropName +
                     '@' + szObj + '@WideString@' + IntToStr(i), '');
                    i := i + 1;
                  end;
              end;
              if not LMDTryConvertUTF7ToUTF16(AnsiString(szTmp), szWTmp, True) then
                szWTmp := Base64Decode(AnsiString(szTmp));
              Writer.WriteWideString(szWTmp);
          end else

        if szType = 'Identifier' then
        begin
          szTmp := INI.ReadString(TS, CP + '.' + PropName + '@' + szObj +
           '@Identifier@0', '');
          Writer.WriteIdent(szTmp);
        end else
        if szType = 'Set' then
        begin
          szTmp := INI.ReadString(TS, CP + '.' + PropName + '@' + szObj +
           '@Set@0', '');
               Writer.WriteValue(vaSet);
               if Length(szTmp) > 0 then
            begin
              i := Pos(' ', szTmp);
              if i > 0 then
                while i > 0 do
                  begin
                    szTmp1 := Copy(szTmp, 1, i - 1);
                    if szTmp1 <> '' then
                      Writer.WriteStr(AnsiString(szTmp1));
                    szTmp := Copy(szTmp, i + 1, $FFFF);
                    i := Pos(' ', szTmp);
                  end
              else
                Writer.WriteStr(AnsiString(szTmp))
            end;
          Writer.WriteStr('');
        end;
    end;
    FreeAndNil(KeyList);
    FreeAndNil(NotKeyList);
    FreeAndNil(SL);
  end;

  procedure ConvertProperty(PropName: String; bKey: Boolean);
  var
    szTmp: String;
  begin
    if bKey then
    begin
      szTmp := PropName;
      szTmp := Copy(szTmp, 2, Length(szTmp) - 2);
      ReplaceChar(szTmp, '|', '.');
      Writer.WriteStr(AnsiString(szTmp));
      ConvertValue(PropName, bKey);
    end
    else
    begin
      ReplaceChar(PropName, '|', '.');
      Writer.WriteStr(AnsiString(PropName));
      ConvertValue(PropName, bKey);
    end;
  end;

begin
  CP := Name;
  TS := CurrentActiveSection;
  KeyList := TStringList.Create;
  NotKeyList := TStringList.Create;

  Writer.WriteString(Name);
  SL := TStringList.Create;
  INI.ReadSection(TS, SL);

  if trim(szObject) = '' then szObject := 'Component';

  i := 0;
  while i < SL.Count do
    if (ExtractWord(2, SL[i], ['@']) = szObject) then
     i := i + 1 else SL.Delete(i);

  GetComponentList(CP, SL, KeyList, NotKeyList);

  try
    iCount := KeyList.Count;
    Writer.WriteListBegin;
    for i := 0 to KeyList.Count - 1 do
      ConvertProperty(KeyList[i], True);

    iCount := iCount + NotKeyList.Count;
    for i := 0 to NotKeyList.Count - 1 do
      ConvertProperty(NotKeyList[i], False);

    Writer.WriteListEnd;
    if iCount = 0 then
      begin
      Writer.WriteValue(vaNull);
      end
  finally
    FreeAndNil(SL);
    FreeAndNil(KeyList);
    FreeAndNil(NotKeyList);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteSimpleProperty(const Section, Ident,
 PropType, PropValue: string);
var
  TS: String;
  L, Count: Integer;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;

  DeleteKeyEx(TS, Ident, 'Simple', PropType);

  L := Length(PropValue);
  if L > MaxINIStringLength then
    begin
      Count := 0;
      while Count * MaxINIStringLength div 2 <= Length(PropValue) do
        begin
          if Length(PropValue) < ((Count + 1) * MaxINIStringLength div 2)
           then
            INI.WriteString(TS, Ident + '@Simple@' + PropType + '@' +
             IntToStr(Count), Copy(PropValue, Count *
              MaxINIStringLength div 2,
               Length(PropValue) - Count * MaxINIStringLength div 2 + 1))
          else
            INI.WriteString(TS, Ident + '@Simple@' + PropType + '@' +
             IntToStr(Count), Copy(PropValue, Count *
              MaxINIStringLength div 2, MaxINIStringLength div 2));
          Count := Count + 1;
        end;
    end
    else INI.WriteString(TS, Ident + '@Simple@' + PropType + '@0', PropValue);
  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.ReadSimpleProperty(const Section,
  Ident: string; var PropType, PropValue: string);
var
  i: integer;
  TS: string;
  TL: TStrings;
begin
  Open;
  PropValue := '';
  if Section <> '' then TS := Section else TS := CurrentActiveSection;

  TL := TStringList.Create;
  try
    INI.ReadSection(TS, TL);
    for i := 0 to TL.Count - 1 do
     if (ExtractWord(1, TL[i], ['@']) = Ident) and
        (ExtractWord(2, TL[i], ['@']) = 'Simple') then
       begin
         PropType := ExtractWord(3, TL[i], ['@']);
         break;
       end;
  finally
    FreeAndNil(TL);
  end;

  i := 0;
  while INI.ValueExists(TS, Ident + '@Simple@' + PropType + '@' + IntToStr(i))
   do
    begin
     PropValue := PropValue + INI.ReadString(TS, Ident + '@Simple@' + PropType +
      '@' + IntToStr(i), PropValue);
     i := i + 1;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteEssence(const Section, Ident, szObj,
 szType: string; Instance: TPersistent);
var
  MS: TMemoryStream;
  Writer: TLMDOSWriter;
  TS: string;
begin
  if not Assigned(Instance) then exit;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;

  DeleteKeyEx(TS, Ident, szObj, szType);

  MS := TMemoryStream.Create;

  Writer := TLMDOSWriter.Create(MS, 4096);
  try
    Writer.WriteListBegin;
    Writer.LMDWriteObject(Instance, Ident);
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;

  SaveObject(MS, TS, szObj, szType);
  FreeAndNil(MS);

  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadEssence(const Section, Ident, szObj:
  string; Instance: TPersistent): TPersistent;
var
  Writer: TIniCrackWriter;
  TS: string;
  MS: TMemoryStream;
  Reader: TLMDOSReader;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;

  MS := TMemoryStream.Create;
  Writer := TIniCrackWriter.Create(MS, 4096);
  try
    Writer.WriteListBegin;
    LoadComponent(Ident, szObj, Writer);
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;

  MS.Seek(0, soFromBeginning);

  Reader := TLMDOSReader.Create(MS, 4096);
  try
    Reader.BeginReferences;
    Reader.ReadListBegin;
    Reader.Root := Owner;
    //TS := Reader.ReadString;
    while not Reader.EndOfList do
      Reader.LMDReadObject(Instance);
    Reader.ReadListEnd;
    Reader.FixupReferences;
    Reader.EndReferences;
  finally
    Reader.Free;
  end;
  Result := Instance;
end;

{------------------------- Protected ------------------------------------------}
function TLMDStorCustomINIVault.Extension: String;
begin
  Result := 'ini';
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.SaveObject(Stream: TStream; Section, szObj,
 szType: string);
var
  Count: Int64;
  Reader: TReader;
  CompName: String;
  PropName: string;
  TS: String;

  procedure WriteData(Name, szType: String; const Data ; DataSize: Integer);
  var
    Stream, MS: TMemoryStream;
  begin
    MS := TMemoryStream.Create;
    Stream := TMemoryStream.Create;
    try
      Stream.Write(szType[1], Length(szType));
      Stream.Write(Data, DataSize);

      if CompressedStream then
      begin
      Stream.Seek(0, soFromBeginning);
      MS.CopyFrom(Stream, Stream.Size);
        Stream.Clear;
      MS.Seek(0, soFromBeginning);
      LMDStorSaveCompressedStream(MS, Stream, MS.Size);
      end;
    Stream.Seek(0, soFromBeginning);
    Count := 0;
      if Stream.Size > MaxINIStringLength div 2 then
        begin
          while Count * MaxINIStringLength div 2 <= Stream.Size do
            begin
              MS.Clear;
              if Stream.Size < Stream.Position + MaxINIStringLength div 2 then
                MS.CopyFrom(Stream, Stream.Size - Stream.Position)
              else
                MS.CopyFrom(Stream, MaxINIStringLength div 2);
            MS.Seek(0, soFromBeginning);
            INI.WriteBinaryStream(TS, '' + Name + '@' + szObj + '@Binary@' +
               IntToStr(Count),
               MS);
              Count := Count + 1;
            end;
        end else
         INI.WriteBinaryStream(TS, Name + '@' + szObj + '@Binary@0', Stream);
    finally
      FreeAndNil(MS);
      FreeAndNil(Stream);
    end;

  end;

//  procedure ConvertProperty; forward;

  procedure ConvertValue;
  var
    I, L: Integer;
    S, S1: string;
    W: WideString;
    p: PChar;
    tmpDbl : Double;
    tmpSingle : Single;
    tmpCur : Currency;
    Count: Integer;
  begin
    case Reader.NextValue of
      vaList:
        begin
          Reader.ReadValue;
          S1 := CompName;  //VB may 2005
          CompName := CompName + '.<' + ReplaceDot(PropName) + '>';
          i := 1;
          while INI.ValueExists(TS, CompName + '.value' + IntToStr(i) + '@' +
           szObj + '@String@0') do
          begin
            DeleteKeyEx(TS, CompName + '.value' + IntToStr(i), 'Component', 'String');
            Inc(i);
          end;
          i := 1;
          while not Reader.EndOfList do
            begin
              PropName := 'value' + IntToStr(i);
              Inc(i);
              ConvertValue;
            end;
          Reader.ReadListEnd;
          CompName := S1;  //VB may 2005
        end;
      vaInt8, vaInt16, vaInt32:
        INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
         '@' + szObj + '@Integer@0',
          IntToStr(EncryptInteger(Reader.ReadInteger)));

      vaExtended:
        begin
          tmpDbl := Reader.ReadFloat;
          WriteData(CompName + '.' + ReplaceDot(PropName), 'E',   (tmpDbl),
            sizeof(tmpDbl));
        end;

      vaSingle:
        begin
          tmpSingle := Reader.ReadSingle;
          WriteData(CompName + '.' + ReplaceDot(PropName), 'G', (tmpSingle),
           sizeof(tmpSingle));
        end;

      vaCurrency:
        begin
          tmpCur := Reader.ReadCurrency;
          WriteData(CompName + '.' + ReplaceDot(PropName), 'C', (tmpCur),
           sizeof(tmpCur));
        end;

      vaDate:
        begin
          tmpDbl := Reader.ReadDate;
          WriteData(CompName + '.' + ReplaceDot(PropName), 'D', (tmpDbl),
           sizeof(tmpDbl));
        end;

      vaWString, vaUTF8String:
        begin
          W := Reader.ReadWideString;
          S := string(LMDConvertUTF16ToUTF7(W, false, true));
          L := Length(S);

          if L > MaxINIStringLength then
          begin
            Count := 0;
            while Count * MaxINIStringLength div 2 <= Length(S) do
              begin
                if Length(S) < ((Count + 1) * MaxINIStringLength div 2)
                 then
                  begin
                    S1 := Copy(S, Count * MaxINIStringLength div 2,
                       Length(S) - Count * MaxINIStringLength div 2 + 1);
                    INI.WriteString(TS, CompName + '.' +
                     ReplaceDot(PropName) + '@' + szObj + '@WideString@' +
                      IntToStr(Count), S1);
                  end
                  else
                  begin
                    if Count = 0 then
                     S1 := Copy(S, Count * MaxINIStringLength div 2,
                      MaxINIStringLength div 2 - 1) else
                     S1 := Copy(S, Count * MaxINIStringLength div 2,
                      MaxINIStringLength div 2);
                    INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
                     '@' + szObj + '@WideString@' + IntToStr(Count), S1);
                  end;
                Count := Count + 1;
              end;
          end
          else
            INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
             '@' + szObj + '@WideString@0', S);
        end;
      vaString, vaLString:
        begin
          S := Reader.ReadString;
          S := EncryptString(S);
          L := Length(S);
          if L > MaxINIStringLength then
            begin
              Count := 0;
              while Count * MaxINIStringLength div 2 <= Length(S) do
                begin
                  if Length(S) < ((Count + 1) * MaxINIStringLength div 2)
                   then
                    INI.WriteString(TS, CompName + '.' +
                     ReplaceDot(PropName) + '@' + szObj + '@String@' +
                      IntToStr(Count), Copy(S, Count *
                      MaxINIStringLength div 2,
                       Length(S) - Count * MaxINIStringLength div 2 + 1))
                  else
                    INI.WriteString(TS, CompName + '.' +
                     ReplaceDot(PropName) + '@' + szObj + '@String@' +
                      IntToStr(Count), Copy(S, Count *
                       MaxINIStringLength div 2, MaxINIStringLength div 2));
                  Count := Count + 1;
                end;
            end
            else
              INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
               '@' + szObj + '@String@0', S);
        end;

        vaIdent, vaFalse, vaTrue, vaNil, vaNull:
          INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
           '@' + szObj + '@Identifier@0', Reader.ReadIdent);

        vaBinary:
          begin
            Reader.ReadValue;
            Reader.Read(L, SizeOf(L));
            if L > 0 then begin
            P := AllocMem(L);
            try
              Reader.Read(p^, L);
              WriteData(CompName + '.' + ReplaceDot(PropName), 'B', p, L);
              finally
              FreeMem(P, L);
              end;
            end;
          end;

        vaSet:
          begin
            Reader.ReadValue;
            S1 := '';
            I := 0;
            while True do
              begin
                S := Reader.ReadStr;
                if S = '' then Break;
                if I > 0 then S1 := S1+' ';
                S1 := S1+S;
                Inc(I);
              end;
              INI.WriteString(TS, CompName + '.' +
               ReplaceDot(PropName) + '@' + szObj + '@Set@0', S1);
          end;

      vaCollection:
        begin
          Reader.ReadValue;
          S1 := CompName;
          CompName := CompName + '.[' + ReplaceDot(PropName) + ']';
          i := 1;
          // Todo: delete old collection
          S := CompName;
          while not Reader.EndOfList do
            begin
              PropName := 'item' + IntToStr(i);
              inc(i);
              if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
                ConvertValue;
              Reader.CheckValue(vaList);
              CompName := S + '.' + ReplaceDot(PropName);
              while not Reader.EndOfList do
                begin
                  //ConvertProperty;
                  PropName := Reader.ReadStr;  // save for error reporting
                  ConvertValue;
                end;
              Reader.ReadListEnd;
            end;
          Reader.ReadListEnd;
          CompName := S1;
        end;
    end;
  end;

{
  procedure ConvertProperty;
  begin

  end;
}
  procedure ConvertComponent;
  begin
    if Reader.NextValue <> vaNull then
      begin
        Reader.ReadListBegin;
        while not Reader.EndOfList do
          begin
            //ConvertProperty;
            PropName := Reader.ReadStr;  // save for error reporting
            ConvertValue;
          end;
        Reader.ReadListEnd;
      end;
  end;

begin
  Open;
  TS := Section;

  Stream.Seek(0, soFromBeginning);

  Reader := TReader.Create(Stream, 4096);
  try
    Reader.ReadListBegin;
    CompName := Reader.ReadString;
    while not Reader.EndOfList do ConvertComponent;
    Reader.ReadListEnd;
  finally
    Reader.Free;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorCustomINIVault.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FilePrefix := ppWindows;
//  Open;
end;

{------------------------------------------------------------------------------}
destructor TLMDStorCustomINIVault.Destroy;
begin
  Close;
  if Assigned(INI) then FreeAndNil(INI);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.Save(Stream: TMemoryStream);
var
  MS: TMemoryStream;
  Count: Int64;
  Reader: TReader;
  CompName: String;
  PropName: string;
  TS: String;

  procedure WriteData(Name, szType: AnsiString; const Data ; DataSize: Integer);
  var
    Stream, MS: TMemoryStream;
  begin
    MS := TMemoryStream.Create;
    Stream := TMemoryStream.Create;
    try
      Stream.Write(szType[1], Length(szType));
      Stream.Write(Data, DataSize);

      if CompressedStream then
      begin
      Stream.Seek(0, soFromBeginning);
      MS.CopyFrom(Stream, Stream.Size);
        Stream.Clear;
      MS.Seek(0, soFromBeginning);
      LMDStorSaveCompressedStream(MS, Stream, MS.Size);
      end;

    Stream.Seek(0, soFromBeginning);
    Count := 0;
      if Stream.Size > MaxINIStringLength div 2 then
        begin
          while Count * MaxINIStringLength div 2 <= Stream.Size do
            begin
              MS.Clear;
              if Stream.Size < Stream.Position + MaxINIStringLength div 2 then
                MS.CopyFrom(Stream, Stream.Size - Stream.Position)
              else
                MS.CopyFrom(Stream, MaxINIStringLength div 2);
            MS.Seek(0, soFromBeginning);
            INI.WriteBinaryStream(TS, '' + String(Name) + '@Component@Binary@' +
               IntToStr(Count),
               MS);
              Count := Count + 1;
            end;
        end else
         INI.WriteBinaryStream(TS, String(Name) + '@Component@Binary@0', Stream);
    finally
      FreeAndNil(MS);
      FreeAndNil(Stream);
    end;

  end;

  procedure ConvertValue;
  var
    I, L: Integer;
    S, S1: string;
    W: WideString;
    p: PAnsichar;
    tmpDbl : Double;
    tmpSingle : Single;
    tmpCur : Currency;
    Count: Integer;
    SS: TStrings;
    NV : TValueType;
  begin
    NV := Reader.NextValue;
    case NV of
      vaList:
        begin
          Reader.ReadValue;
          CompName := CompName + '.<' + ReplaceDot(PropName) + '>';
          i := 1;
          while INI.ValueExists(TS, CompName + '.value' + IntToStr(i) + '@Component@String@0') do
          begin
            DeleteKeyEx(TS, CompName + '.value' + IntToStr(i), 'Component', 'String');
            Inc(i);
          end;
          if INI.ValueExists(TS, CompName + '.Empty@Component@String@0') then
            DeleteKeyEx(TS, CompName + '.Empty@', 'Component', 'String');
          i := 1;
          if Reader.EndOfList then
            INI.WriteString(TS, CompName + '.Empty@Component@String@0', '')
          else
          while not Reader.EndOfList do
            begin
              PropName := 'value' + IntToStr(i);
              Inc(i);
              ConvertValue;
            end;
          Reader.ReadListEnd;
        end;

      vaInt8, vaInt16, vaInt32:
        INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
         '@Component@Integer@0',
          IntToStr(EncryptInteger(Reader.ReadInteger)));

      vaExtended:
        begin
          tmpDbl := Reader.ReadFloat;
          WriteData(AnsiString(CompName + '.' + ReplaceDot(PropName)), 'E', (tmpDbl),
           sizeof(tmpDbl));
        end;

      vaSingle:
        begin
          tmpSingle := Reader.ReadSingle;
          WriteData(AnsiString(CompName + '.' + ReplaceDot(PropName)), 'G', (tmpSingle),
           sizeof(tmpSingle));
        end;

      vaCurrency:
        begin
          tmpCur := Reader.ReadCurrency;
          WriteData(AnsiString(CompName + '.' + ReplaceDot(PropName)), 'C', (tmpCur),
           sizeof(tmpCur));
        end;

      vaDate:
        begin
          tmpDbl := Reader.ReadDate;
          WriteData(AnsiString(CompName + '.' + ReplaceDot(PropName)), 'D', (tmpDbl),
           sizeof(tmpDbl));
        end;

      vaWString, vaUTF8String:
        begin
          W := Reader.ReadWideString;
          S := string(LMDConvertUTF16ToUTF7(W, false, true));
          L := Length(S);

          if L > MaxINIStringLength then
          begin
            Count := 0;
            while Count * MaxINIStringLength div 2 <= Length(S) do
              begin
                if Length(S) < ((Count + 1) * MaxINIStringLength div 2)
                 then
                  begin
                    S1 := Copy(S, Count *
                      MaxINIStringLength div 2,
                       Length(S) - Count * MaxINIStringLength div 2 + 1);
                    INI.WriteString(TS, CompName + '.' +
                     ReplaceDot(PropName) + '@Component@WideString@' +
                      IntToStr(Count), S1);
                  end
                  else
                  begin
                    if Count = 0 then
                     S1 := Copy(S, Count * MaxINIStringLength div 2,
                      MaxINIStringLength div 2 - 1) else
                     S1 := Copy(S, Count * MaxINIStringLength div 2,
                      MaxINIStringLength div 2);
                    INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
                     '@Component@WideString@' + IntToStr(Count), S1);
                  end;
                Count := Count + 1;
              end;
          end
          else
            INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
             '@Component@WideString@0', S);
        end;
      vaString, vaLString:
        begin
          S := Reader.ReadString;
          S := EncryptString(S);
          L := Length(S);
          if L > MaxINIStringLength then
            begin
              Count := 0;
              while Count * MaxINIStringLength div 2 <= Length(S) do
                begin
                  if Length(S) < ((Count + 1) * MaxINIStringLength div 2)
                   then
                    INI.WriteString(TS, CompName + '.' +
                     ReplaceDot(PropName) + '@Component@String@' +
                      IntToStr(Count), Copy(S, Count *
                      MaxINIStringLength div 2,
                       Length(S) - Count * MaxINIStringLength div 2 + 1))
                  else
                    INI.WriteString(TS, CompName + '.' +
                     ReplaceDot(PropName) + '@Component@String@' +
                      IntToStr(Count), Copy(S, Count *
                       MaxINIStringLength div 2, MaxINIStringLength div 2));
                  Count := Count + 1;
                end;
            end
            else
              INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
               '@Component@String@0', S);
        end;

        vaIdent, vaFalse, vaTrue, vaNil, vaNull:
          INI.WriteString(TS, CompName + '.' + ReplaceDot(PropName) +
           '@Component@Identifier@0', Reader.ReadIdent);

        vaBinary:
          begin
            Reader.ReadValue;
            Reader.Read(L, SizeOf(L));
            if L <> 0 then begin
            P := AllocMem(L);
            try
              Reader.Read(p^, L);
                WriteData(AnsiString(CompName + '.' + ReplaceDot(PropName)), 'B', p^, L);
              finally
              FreeMem(P, L);
              end;
            end;
          end;

        vaSet:
          begin
            Reader.ReadValue;
            S1 := '';
            I := 0;
            while True do
              begin
                S := Reader.ReadStr;
                if S = '' then Break;
                if I > 0 then S1 := S1+' ';
                S1 := S1+S;
                Inc(I);
              end;
              INI.WriteString(TS, CompName + '.' +
               ReplaceDot(PropName) + '@Component@Set@0', S1);
          end;

      vaCollection:
        begin
          Reader.ReadValue;
          S1 := CompName;
          CompName := CompName + '.[' + ReplaceDot(PropName) + ']';
          // Delete old collection
          SS := TStringList.Create;
          try
            INI.ReadSection(TS, SS);
            for i := 0 to SS.Count - 1 do
            begin
              if Pos(CompName, SS[i]) > 0 then
               INI.DeleteKey(TS, SS[i]);
            end;
          finally
            FreeAndNil(SS);
          end;
          i := 1;
          S := CompName;
          while not Reader.EndOfList do
            begin
              PropName := 'item' + IntToStr(i);
              inc(i);
              if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
                ConvertValue;
              Reader.CheckValue(vaList);
              CompName := S + '.' + ReplaceDot(PropName);
              while not Reader.EndOfList do
                begin
                  PropName := Reader.ReadStr;  // save for error reporting
                  ConvertValue;
                end;
              Reader.ReadListEnd;
            end;
          Reader.ReadListEnd;
          CompName := S1;
        end;
    end;
  end;

  procedure ConvertComponent;
  begin
    CompName := Reader.ReadString;
    if Reader.NextValue <> vaNull then
      begin
        Reader.ReadListBegin;
        while not Reader.EndOfList do
          begin
            PropName := Reader.ReadStr;  // save for error reporting
            ConvertValue;
          end;
        Reader.ReadListEnd;
      end;
  end;

begin
  inherited Save(Stream);
  Close;
  Open;
  TS := CurrentActiveSection;
  DoOnSaveStream(self, Stream);

  Stream.Seek(0, soFromBeginning);

  if BinaryStream then
    begin
      DeleteKey(TS, 'DATA');
      MS := TMemoryStream.Create;
      try
        Count := 0;
        while Count * MaxINIStringLength div 2 <= Stream.Size do
          begin
            MS.Clear;
            if Stream.Size < Stream.Position + MaxINIStringLength div 2 then
              MS.CopyFrom(Stream, Stream.Size - Stream.Position)
            else
              MS.CopyFrom(Stream, MaxINIStringLength div 2);
            MS.Seek(0, soFromBeginning);
            INI.WriteBinaryStream(TS, 'DATA@Component@Binary@' +
               IntToStr(Count), MS);
              if AutoUpdate then Update;
            Count := Count + 1;
          end;
      finally
        FreeAndNil(MS);
      end;
    end
    else
    begin
      Reader := TReader.Create(Stream, 4096);
      try
        Reader.ReadListBegin;
        while not Reader.EndOfList do ConvertComponent;
        Reader.ReadListEnd;
      finally
        Reader.Free;
      end;
    end;
  Close;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.Load(Stream: TMemoryStream);
var
  i, Count: Integer;
  MS: TMemoryStream;
  Writer: TIniCrackWriter;
  SL: TStringList;
  TS: String;
begin
  FIsLoading := true;
  Close;
  Open;
  TS := CurrentActiveSection;
  if INI.SectionExists(TS) then
  begin
    if BinaryStream then
      begin
        Count := 0;
        while INI.ValueExists(TS, 'DATA@Component@Binary@' + IntToStr(Count)) do
          Count := Count + 1;
        MS := TMemoryStream.Create;
        try
          for i := 0 to Count - 1 do
            begin
              MS.Clear;
              INI.ReadBinaryStream(TS, 'DATA@Component@Binary@' + IntToStr(i),
               MS);
            MS.Seek(0, soFromBeginning);
            Stream.CopyFrom(MS, MS.Size);
            end;
        finally
          MS.Free;
        end;
      end
      else
      begin
        Writer := TIniCrackWriter.Create(Stream, 4096);
        try
          Writer.WriteListBegin;
          SL := TStringList.Create;
          try
            INI.ReadSection(TS, SL);

            i := 0;
            while i < SL.Count do
              if ExtractWord(2, SL[i], ['@']) = 'Component'
               then i := i + 1 else SL.Delete(i);

            for i := 0 to SL.Count - 1 do
              SL[i] := copy(SL[i], 1, pos('.', SL[i]) - 1);
            ClearList(SL);
            for i := 0 to SL.Count - 1 do
             LoadComponent(SL[i], 'Component', Writer);
          finally
            SL.Free;
          end;
          Writer.WriteListEnd;
        finally
          Writer.Free;
        end;
      end;
    DoOnLoadStream(self, Stream);
  end;
  inherited Load(Stream);
  FIsLoading := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.Clear;
begin
  if Assigned(INI) then
    INI.EraseSection(CurrentActiveSection);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.Open;
begin
  DoOnBeforeOpen(self);
  if not Assigned(INI) then
    begin
      INI := TMemIniFile.Create(DataFile);
      Sections.Clear;
      INI.ReadSections(Sections);
    end;
  DoOnAfterOpen(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.Close;
var
  lCanUpdate: boolean;
begin
  DoOnBeforeClose(self);
  if Assigned(INI) then
    begin
      lCanUpdate := true;
      DoOnUpdateBeforeCloseEvent(Self, lCanUpdate);
      if lCanUpdate then
        Update;
      FreeAndNil(INI);
    end;
  DoOnAfterClose(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.Update;
begin
  INI.UpdateFile;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.KeyExists(const Key: string;
  Section: string = ''): Boolean;
var
  i, PP, PS: integer;
  TS: string;
  TL: TStrings;
begin
  Open;
  Result := false;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  TL := TStringList.Create;
  try
    INI.ReadSection(TS, TL);
    for i := 0 to TL.Count - 1 do
      begin
        //Ps := pos('@', TL[i]);
        PS := Pos('.', TL[i]);
        PP := Pos('@', TL[i]);
        if PP < PS then PS := PP;
        Result := Copy(TL[i], 1, PS - 1) = Trim(Key);
        if Result then Break;
        //if copy(TL[i], Ps + 1, Length(TL[i]) - Ps) = Trim(Key) then
        //  begin
        //    Result := True;
        //    break;
        //  end;
      end;
  finally
    FreeAndNil(TL);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.SectionExists(const Section: string): Boolean;
begin
  Open;
  Result := INI.SectionExists(Section);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.DeleteKey(const Section, Ident: string);
var
  i: integer;
  TS: String;
  TL: TStrings;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  TL := TStringList.Create;
  try
    INI.ReadSection(TS, TL);
    for i := 0 to TL.Count - 1 do
      if Pos(Ident + '@', TL[i]) > 0 then INI.DeleteKey(TS, TL[i]);
  finally
    FreeAndNil(TL);
  end;
  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.DeleteKeyEx(const Section, Ident,
 szObj, szType: string);
var
  i: integer;
  TL: TStrings;
  TS: String;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  TL := TStringList.Create;
  try
    INI.ReadSection(TS, TL);
    for i := 0 to TL.Count - 1 do
    if szType <> '' then
      begin
       if (ExtractWord(1, TL[i], ['@']) = Ident) and
          (ExtractWord(2, TL[i], ['@']) = szObj) and
          (ExtractWord(3, TL[i], ['@']) = szType) then
       INI.DeleteKey(TS, TL[i]);
      end else
      begin
       if (ExtractWord(1, TL[i], ['@']) = Ident) and
          (ExtractWord(2, TL[i], ['@']) = szObj) then
       INI.DeleteKey(TS, TL[i]);
      end;
  finally
    FreeAndNil(TL);
  end;
  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.AddSection(const Section: string);
begin
  Open;
  if SectionExists(Section) then exit;
  INI.WriteString(Section, 'dummy', 'dummy');
  INI.DeleteKey(Section, 'dummy');
  Sections.Add(Section);
  DoOnSectionAdd(self, Section);
  if AutoUpdate then Update;
end;

(*
{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.RenameSection(const OldName, NewName: string):
  Boolean;
var
  TL: TStrings;
  i: integer;
begin
  Result := False;
  Open;
  Sections.Clear;
  INI.ReadSections(Sections);
  if not SectionExists(OldName) then exit;
  i := Sections.IndexOf(OldName);
  Sections[i] := NewName;
  TL := TStringList.Create;
  try
    INI.ReadSectionValues(OldName, TL);
    DeleteSection(OldName);
    TL.Insert(0, '[' + NewName + ']');
    INI.SetStrings(TL);
  finally
    FreeAndNil(TL);
  end;
  if AutoUpdate then Update;
  Result := True;
end;
*)
{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.RenameSection(const OldName, NewName: string):
  Boolean;
var
  SL,TL: TStrings;
      i: integer;
      s: string;
begin
  Result := False;
  Open;
  Sections.Clear;
  INI.ReadSections(Sections);
  if not SectionExists(OldName) then exit;
  TL := TStringList.Create;
  SL := TStringList.Create;
  try
    for i := 0 to  Sections.Count - 1 do
      begin
        INI.ReadSectionValues(Sections[i], SL);
        if Sections[i]=OldName then
          s := NewName
        else
          s := Sections[i];
        SL.Insert(0, '[' + s + ']');
        TL.AddStrings(SL);
        TL.Add('');
      end;
    DeleteSection(OldName);
    INI.SetStrings(TL);
    if ActiveSection = OldName then
      ActiveSection := NewName;
  finally
    FreeAndNil(TL);
    FreeAndNil(SL);
  end;
  if AutoUpdate then Update;
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.RemoveSection(const Section: string): Boolean;
var
  i:integer;
begin
  Result := False;
  Open;
  if not SectionExists(Section) then exit;
  INI.EraseSection(Section);
  DoOnSectionDelete(self, Section);
  if AutoUpdate then Update;
  i:=Sections.IndexOf(Section);
  if i>=0 then
    Sections.Delete(i);
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.DeleteSection(const Section: string): Boolean;
begin
  Result := RemoveSection(Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ClearSection(const Section: string): Boolean;
var
  TS: String;
begin
  Result := False;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  if not SectionExists(TS) then exit;
  INI.EraseSection(TS);
  if AutoUpdate then Update;
  Result := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.ReadKeys(Strings: TStrings;
  Section: string = '');
var
  TS: string;
begin
  Open;
  if not Assigned(Strings) then exit;
  Strings.Clear;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  INI.ReadSection(TS, Strings);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.KeyCount(Section: string = ''): Integer;
var
  TS: string;
  TL: TStringList;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  TL := TStringList.Create;
  try
    INI.ReadSection(TS, TL);
    Result := TL.Count;
  finally
    FreeAndNil(TL);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteBool(const Section, Ident: string;
  Value: Boolean);
var
  BS: String;
begin
  if Value then BS := '-1' else BS := '0';
  WriteSimpleProperty(Section, Ident, 'Identifier', BS);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadBool(const Section,
  Ident: string; Default: Boolean): Boolean;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Identifier' then Result := PropValue = '-1';
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteColor(const Section, Ident: string;
  Value: TColor);
begin
  WriteSimpleProperty(Section, Ident, 'Color', ColorToString(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadColor(const Section, Ident: string;
  Default: TColor): TColor;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if (PropType = 'Color') or
     (PropType = 'Integer') or
     (PropType = 'Identifier') then Result := StringToColor(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteObject(const Section, Ident: string;
  Instance: TPersistent);
begin
  WriteEssence(Section, Ident, 'Object', 'Object', Instance);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadObject(const Section, Ident: string;
  Instance: TPersistent): TPersistent;
begin
  Result := Instance;
  ReadEssence(Section, Ident, 'Object', Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteComponent(const Instance: TComponent;
  const Section: string = '');
var
  MS: TMemoryStream;
  Writer: TLMDOSWriter;
  TS: string;
  CustomRoot: TComponent;
begin
  if not Assigned(Instance) then exit;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;

  DeleteKeyEx(TS, Instance.Name, 'Component', '');

  MS := TMemoryStream.Create;

  Writer := TLMDOSWriter.Create(MS, 4096);
  try
    CustomRoot := Instance;
    DoCustomRootWrite(Instance, CustomRoot);
    Writer.Root := CustomRoot;
    Writer.WriteListBegin;
    Writer.LMDWriteComponent(Instance);
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;

  SaveObject(MS, TS, 'Component', 'Component');
  FreeAndNil(MS);

  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadComponent(const Section: string;
  Instance: TComponent): TComponent;
var
  Writer: TIniCrackWriter;
  TS: string;
  MS: TMemoryStream;
  Reader: TLMDOSReader;
  CustomRoot: TComponent;
begin
  Open;

  if Section <> '' then TS := Section else TS := CurrentActiveSection;

  MS := TMemoryStream.Create;
  Writer := TIniCrackWriter.Create(MS, 4096);
  try
    Writer.WriteListBegin;
    LoadComponent(Instance.Name, 'Component', Writer);
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;

  MS.Seek(0, soFromBeginning);

  Reader := TLMDOSReader.Create(MS, 4096);
  try
    Reader.BeginReferences;
    Reader.ReadListBegin;
    CustomRoot := Instance;
    DoCustomRootRead(Instance, CustomRoot);
    Reader.Root := CustomRoot;
    while not Reader.EndOfList do Reader.LMDReadProperty;
    Reader.ReadListEnd;
    Reader.FixupReferences;
    Reader.EndReferences;
  finally
    Reader.Free;
  end;
  Result := Instance;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteDate(const Section, Ident: string;
  Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'Date', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadDate(const Section, Ident: string;
  Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Date' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteStrings(const Section, Ident: string;
 Value: TStrings);
var
  TS: String;
  i, L, Count: integer;
  S: String;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;

  DeleteKeyEx(TS, Ident, 'Strings', '');

  for i := 0 to Value.Count - 1 do
    begin
      S := Value[i];
      L := Length(S);
      if L > 512 then
        begin
          Count := 0;
          while Count * MaxINIStringLength div 2 <=
            Length(S) do
            begin
              if Length(S) < ((Count + 1) * MaxINIStringLength div 2) then
                begin
                  INI.WriteString(TS, Ident + '@Strings@Substring' +
                   IntToStr(i) + '@' + IntToStr(Count), Copy(S, Count *
                    MaxINIStringLength div 2, Length(S) - Count *
                     MaxINIStringLength div 2 + 1));
                end else
                begin
                  INI.WriteString(TS, Ident + '@Strings@Substring' +
                   IntToStr(i) + '@' + IntToStr(Count), Copy(S, Count *
                    MaxINIStringLength div 2, MaxINIStringLength div 2));
                end;
              Count := Count + 1;
            end;
        end
      else
        INI.WriteString(TS, Ident + '@Strings@Substring' + IntToStr(i) + '@0',
         S);
    end;

  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.ReadStrings(const Section, Ident: string;
 Value: TStrings);
var
  Count, SS: integer;
  TS, TL, TK: string;
begin
  Value.Clear;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  Count := 0;
  while INI.ValueExists(TS, Ident + '@Strings@Substring' +
   IntToStr(Count) + '@0') do
    begin
      TK := '';
      SS := 0;
      TL := Ident + '@Strings@Substring' + IntToStr(Count) + '@';
      while INI.ValueExists(TS, TL + IntToStr(SS)) do
        begin
          TK := TK + INI.ReadString(TS, TL + IntToStr(SS), '');
          SS := SS + 1;
        end;
      Value.Add(TK);
      Count := Count + 1;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteDateTime(const Section, Ident: string;
  Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'DateTime', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadDateTime(const Section, Ident: string;
  Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'DateTime' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteFloat(const Section, Ident: string;
  Value: Double);
begin
  WriteSimpleProperty(Section, Ident, 'Float', FloatToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadFloat(const Section, Ident: string;
  Default: Double): Double;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Float' then Result := StrToFloat(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteFont(const Section, Ident: string;
  Instance: TFont);
begin
  WriteEssence(Section, Ident, 'Font', 'Font', Instance);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadFont(const Section, Ident: string;
  Instance: TFont): TFont;
begin
  Result := Instance;
  ReadEssence(Section, Ident, 'Font', Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteInteger(const Section, Ident: string;
  Value: LongInt);
begin
  WriteSimpleProperty(Section, Ident, 'Integer',
   IntToStr(EncryptInteger(Value)));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadInteger(const Section, Ident: string;
  Default: LongInt): LongInt;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Integer' then Result := DecryptInteger(StrToInt(PropValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteInt64(const Section, Ident: string;
  Value: Int64);
begin
  WriteSimpleProperty(Section, Ident, 'Int64', IntToStr(EncryptInteger(Value)));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadInt64(const Section, Ident: string;
  Default: Int64): Int64;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Int64' then Result := DecryptInteger(StrToInt64(PropValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WritePoint(const Section, Ident: string;
  Value: TPoint);
begin
  WriteSimpleProperty(Section, Ident, 'Point',
    IntToStr(Value.X) + '.' + IntToStr(Value.Y));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadPoint(const Section, Ident: string;
  Default: TPoint): TPoint;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if (PropType = 'Int64') and (pos('.', PropValue) > 1) and
    (pos('.', PropValue) < length(PropValue)) then
    begin
      Result.X := StrToInt(copy(PropValue, 1, pos('.', PropValue) - 1));
      Result.Y := StrToInt(copy(PropValue, pos('.', PropValue) + 1,
        length(PropValue) - pos('.', PropValue)));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteRect(const Section, Ident: string;
  Value: TRect);
begin
  WriteSimpleProperty(Section, Ident, 'Rect',
    IntToStr(Value.Left) + '.' + IntToStr(Value.Top) + '.' +
    IntToStr(Value.Right) + '.' + IntToStr(Value.Bottom));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadRect(const Section, Ident: string;
  Default: TRect): TRect;
var
  PropType, PropValue, TS: string;
  Position: Integer;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if (PropType = 'Rect') then
    begin
      TS := PropValue;

      Position := Pos('.', TS);
      if Position > 0 then
        begin
          Result.Left := StrToInt(copy(TS, 1, Position - 1));
          TS := copy(TS, Position + 1, length(TS) - Position);
        end else exit;

      Position := Pos('.', TS);
      if Position > 0 then
        begin
          Result.Top := StrToInt(copy(TS, 1, Position - 1));
          TS := copy(TS, Position + 1, length(TS) - Position);
        end else exit;

      Position := Pos('.', TS);
      if Position > 0 then
        begin
          Result.Right := StrToInt(copy(TS, 1, Position - 1));
          TS := copy(TS, Position + 1, length(TS) - Position);
        end else exit;

      Result.Bottom := StrToInt(TS);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteString(const Section, Ident: string;
  Value: string);
begin
  WriteSimpleProperty(Section, Ident, 'String', EncryptString(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadString(const Section, Ident: string;
  Default: string): string;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'String' then Result := DecryptString(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.WriteTime(const Section, Ident: string;
 Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'Time', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomINIVault.ReadTime(const Section, Ident: string;
 Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Time' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.ReadSection (const Section: String; Strings:
 TStrings);
var
  TS: String;
begin
  Open;
  Strings.Clear;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  INI.ReadSection(TS, Strings);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomINIVault.ReadSections(Strings: TStrings);
begin
  Open;
  Strings.Clear;
  INI.ReadSections(Strings);
end;

end.
