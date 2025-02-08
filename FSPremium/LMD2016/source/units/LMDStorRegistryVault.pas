unit LMDStorRegistryVault;
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

LMDStorRegistryVault unit (VO)
------------------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Classes, SysUtils, Registry, Windows, Graphics, TypInfo,
     LMDUnicode, LMDStorBase, LMDStorCommon, LMDStorPropertiesStorage;

type
  TLMDStorRegRoot = (rrCurrentUser, rrLocalMachine);

  // helper class
  TCrackWriter = class(TWriter)
  public
  end;

  {-------------------  Class TLMDStorCustomRegistryVault ---------------------}
  TLMDStorCustomRegistryVault = class(TLMDAbstractStorageVault)
  private
    FRegistryRoot: TLMDStorRegRoot;
    FRegistryKey: string;
    Reg: TRegistry;
    procedure SetRegistryRoot(const Value: TLMDStorRegRoot);
    procedure SetRegistryKey(const Value: string);
    function CurrentActiveSection: string;
    function GetType(Value: string): string;
    procedure WriteSimpleProperty(const Section, Ident, PropType,
      PropValue: string);
    procedure ReadSimpleProperty(const Section, Ident: string; var PropType,
      PropValue: string);
    procedure LoadComponent(CompName: string; Writer: TCrackWriter);
    procedure SaveObject(Stream: TStream; szType: string);
    procedure WriteEssence(const Section, Ident, szType:
      string; Instance: TPersistent);
    function ReadEssence(const Section, Ident, szType: string;
      Instance: TPersistent): TPersistent;
  protected
    function Extension: String; override;
    property RegistryRoot: TLMDStorRegRoot read FRegistryRoot write SetRegistryRoot default rrCurrentUser;
    property RegistryKey: string read FRegistryKey write SetRegistryKey;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save(Stream: TMemoryStream); override;
    procedure Load(Stream: TMemoryStream); override;
    procedure Open; override;
    procedure Delete;
    procedure DeleteKey(const Section, Ident: string); override;
    procedure DeleteKeyEx(const Section, Ident, szType: string);
    function KeyExists(const Key: string; Section: string = ''): Boolean;
      override;
    function SectionExists(const Section: string): Boolean; override;
    procedure Close; override;
    procedure Update; override;
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
    procedure WriteStrings(const Section, Ident: string; Value: TStrings);
      override;
    procedure ReadStrings(const Section, Ident: string; Value: TStrings);
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
    procedure ReadSection(const Section: String; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
  end;

  {-------------------  Class TLMDStorRegistryVault ---------------------------}
  TLMDStorRegistryVault = class(TLMDStorCustomRegistryVault)
  published
    property Encrypted;  
    property BinaryStream;  
    property RegistryRoot;
    property RegistryKey;
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
    property StorageCryptor;
    property Sections;
    property ActiveSection;
    property ActiveSectionIndex;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
   dialogs;
  {$I C2.INC}
{$ENDIF}

Type
// helper classes
  {-------------------  Class TLMDOSReader ------------------------------------}
  TLMDOSReader = class(TReader)
  public
    procedure LMDReadProperty;
    procedure LMDReadObject(Instance: TPersistent);
  end;

{********************* TLMDOSReader *******************************************}
{------------------------- Public ---------------------------------------------}
procedure TLMDOSReader.LMDReadProperty;
var
  Component: TComponent;
  szName: string;
begin
  if Root = nil then exit;
  szName := ReadString;
  if Root.Name = szName then
    Component := Root
  else
    Component := Root.FindComponent(szName);
  if Component = nil then
    raise EFilerError.Create('Can''t find component ' + szName);
  if NextValue <> vaNull then
    begin
      ReadListBegin;
      while not EndOfList do
        ReadProperty(Component);
      ReadListEnd;
    end
  else
    ReadValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDOSReader.LMDReadObject(Instance: TPersistent);
begin
  if NextValue <> vaNull then
    begin
      ReadListBegin;
      while not EndOfList do
        ReadProperty(Instance);
      ReadListEnd;
    end
  else
    ReadValue;
end;

type
  {-------------------  Class TLMDOSWriter ------------------------------------}
  TLMDOSWriter = class(TWriter)
  public
    procedure LMDWriteComponent(Component: TComponent);
    procedure LMDWriteObject(Value: TPersistent; Ident: string);
  end;

{********************* TLMDOSWriter *******************************************}
{------------------------- Public ---------------------------------------------}
procedure TLMDOSWriter.LMDWriteComponent(Component: TComponent);
var
  I, Count: Integer;
  iPos: Integer;

  PropInfo: PPropInfo;
  PropList: PPropList;

begin
  if Component = nil then exit;
  WriteString(Component.Name);
  Count := GetTypeData(Component.ClassInfo).PropCount;
  if Count > 0 then
    begin
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(Component.ClassInfo,PropList);
        for I := 0 to Count - 1 do
          begin
            PropInfo := PropList[I];
            if PropInfo = nil then break;
            iPos := Position;
            WriteListBegin;
            WriteProperty(Component, PropInfo);
            WriteListEnd;
            if iPos = Position then
              begin
                WriteValue(vaNull);
              end;
          end;
      finally
      FreeMem(PropList, Count * SizeOf(Pointer));
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDOSWriter.LMDWriteObject(Value: TPersistent; Ident: string);
var
  I, Count: Integer;
  iPos: Integer;

  PropInfo: PPropInfo;
  PropList: PPropList;

begin
  if Value = nil then exit;
  WriteString(Ident);
  Count := GetTypeData(Value.ClassInfo).PropCount;
  if Count > 0 then
    begin
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(Value.ClassInfo,PropList);
        for I := 0 to Count - 1 do
          begin
            PropInfo := PropList[I];
            if PropInfo = nil then break;
            iPos := Position;
            WriteListBegin;
            WriteProperty(Value, PropInfo);
            WriteListEnd;
            if iPos = Position then
              begin
                WriteValue(vaNull);
              end;
          end;
      finally
      FreeMem(PropList, Count * SizeOf(Pointer));
      end;
    end;
end;

{********************* TCrackWriter *******************************************}
{------------------------- Public ---------------------------------------------}

{********************* TLMDStorCustomRegistryVault ****************************}
{------------------------- Private --------------------------------------------}
function TLMDStorCustomRegistryVault.Extension: String;
begin
  Result := '';
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.SetRegistryRoot(const Value: TLMDStorRegRoot);
begin
  FRegistryRoot := Value;
  if FRegistryRoot = rrCurrentUser then
    Reg.RootKey := HKEY_CURRENT_USER
  else
    Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey(FRegistryKey, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.SetRegistryKey(const Value: string);
var
  TS: string;
begin
  TS := Value;
  if Length(TS) > 0 then if TS[1] <> '\' then TS := '\' + TS;
  if TS <> FRegistryKey then
    begin
      FRegistryKey := TS;
      Reg.OpenKey(FRegistryKey, True);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.CurrentActiveSection: string;
begin
  Result := ActiveSection;
  if Length(Result) > 0 then if Result[1] <> '\' then Result := '\' + Result;
  if Trim(Result) = '' then Result := '\DATA';
  Result := FRegistryKey + Result;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.GetType(Value: string): string;
var
  TS: string;
begin
  Result := '';
  if Reg.ValueExists(Value + '@Type') then
    Result := Reg.ReadString(Value + '@Type') else
    begin
      TS := '\' + Reg.CurrentPath;
      if Reg.OpenKey(Value, False) then
        Result := Reg.ReadString('');
      Reg.OpenKey(TS, False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteSimpleProperty(const Section, Ident,
  PropType, PropValue: string);
var
  TS: string;
begin
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  DeleteKeyEx(TS, Ident, PropType);
  Open;
  Reg.OpenKey(TS, True);
  Reg.WriteString(Ident, PropValue);
  Reg.WriteString(Ident + '@Type', PropType);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.ReadSimpleProperty(const Section, Ident:
  string; var PropType, PropValue: string);
var
  TS: string;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  if Reg.OpenKey(TS, False) then
    begin
      PropType := Reg.ReadString(Ident + '@Type');
      PropValue := Reg.ReadString(Ident);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.LoadComponent(CompName: string;
 Writer: TCrackWriter);
var
  CP: string;
  SL: TStringList;
  i, iCount: Integer;

  procedure ConvertValue(PropName: string; bKey: Boolean);
  var
    szTmp, szTmp1: string;
    szWTmp: WideString;
    p: PAnsiChar;
    i, j: Integer;
    CP, CP1: string;
    SL, SL1: TStringList;
    l: Longint;
  begin
    if bKey then
      begin
        CP := '\' + Reg.CurrentPath;
        if Reg.OpenKey(PropName, False) then
          begin
            case PropName[1] of
              '<':
                begin
               Writer.WriteValue(vaList);
               SL := TStringList.Create;
                  Reg.GetKeyNames(SL);
                  try
                    for i := 0 to SL.Count - 1 do
                      begin
                        ConvertValue(SL[i], True);
                      end;

                    Reg.GetValueNames(SL);
                    for i := 0 to SL.Count - 1 do
                      begin
                        ConvertValue(SL[i], False);
                      end;
                  finally
                    SL.Free;
                  end;
                  Writer.WriteListEnd;
                end;
              '[':
                begin
               Writer.WriteValue(vaCollection);
               SL := TStringList.Create;
                  try
                    Reg.GetValueNames(SL);
                    for i := 0 to SL.Count - 1 do
                      begin
                        // ConvertProperty(SL[i], False);
                        Writer.WriteStr(AnsiString(SL[i]));
                        ConvertValue(SL[i], False);
                      end;

                    Reg.GetKeyNames(SL);
                    for i := 0 to SL.Count - 1 do
                      begin
                        CP1 := '\' + Reg.CurrentPath;
                        if Reg.OpenKey(SL[i], False) then
                          begin
                            SL1 := TStringList.Create;
                            Reg.GetKeyNames(SL1);
                            try
                              Writer.WriteListBegin;
                              for j := 0 to SL1.Count - 1 do
                                begin
                                  //ConvertProperty(SL1[j], True);
                                  szTmp := PropName;
                                  szTmp := Copy(szTmp, 2, Length(szTmp) - 2);
                                  Writer.WriteStr(AnsiString(szTmp));
                                  ConvertValue(PropName, bKey);
                                end;

                              Reg.GetValueNames(SL1);
                              for j := 0 to SL1.Count - 1 do
                                begin
                                  // ConvertProperty(SL1[j], False);
                                  Writer.WriteStr(AnsiString(SL1[j]));
                                  ConvertValue(SL1[j], False);
                                end;
                              Writer.WriteListEnd;
                            finally
                              SL1.Free;
                            end;
                          end;
                        Reg.OpenKey(CP1, False);
                      end;
                  finally
                    SL.Free;
                  end;
                  Writer.WriteListEnd;
                end;
            end;
          end;
        Reg.OpenKey(Cp, False);
      end
    else
      begin
        case Reg.GetDataType(PropName) of
          rdInteger:
            Writer.WriteInteger(DecryptInteger(Reg.ReadInteger(PropName)));

          rdBinary:
            begin
              i := Reg.GetDataSize(PropName);
            p := AllocMem(i);
            try
              Reg.ReadBinaryData(PropName, p^, i);
              case char(p[0]) of
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
                    Writer.Write((@p[1])^, l);
                    end;
                  'C':
                    begin
             Writer.WriteCurrency(PCurrency(Addr(p[1]))^);
             end;
                end;
              finally
              FreeMemory(p);
              end;
            end;

          rdString:
            begin
              szTmp := Reg.ReadString(PropName);
              if Length(szTmp) > 0 then
                begin
                  case szTmp[1] of
                    '''':
                      begin
                        szTmp := Copy(szTmp, 2, Length(szTmp) - 2);
                        szTmp := DecryptString(szTmp);
                        Writer.WriteString(szTmp);
                      end;
                    '(':
                      begin
                        szTmp := Copy(szTmp, 2, Length(szTmp) - 2);
                      Writer.WriteIdent(szTmp);
                      end;
                    '[':
                      begin
                        szTmp := Copy(szTmp, 2, Length(szTmp) - 2);
                      Writer.WriteValue(vaSet);
                      if Length(szTmp) > 0 then
                          begin
                            i := Pos(' ', szTmp);
                            while i > 0 do
                              begin
                                szTmp1 := Copy(szTmp, 1, i - 1);
                                if szTmp1 <> '' then
                                  Writer.WriteStr(AnsiString(szTmp1));
                                szTmp := Copy(szTmp, i + 1, $FFFF);
                                i := Pos(' ', szTmp);
                              end;
                            Writer.WriteStr(AnsiString(szTmp));
                          end;
                        Writer.WriteStr('');
                      end;
                    '/':
                      begin
                        szTmp := Copy(szTmp, 2, Length(szTmp) - 2);
                        if not LMDTryConvertUTF7ToUTF16(AnsiString(szTmp), szWTmp, True) then
                          szWTmp := Base64Decode(AnsiString(szTmp));
                        Writer.WriteWideString(szWTmp);
                      end;
                  end;
                end;
            end;
        end;
      end;
  end;

  procedure ConvertProperty(PropName: string; bKey: Boolean);
  var
    szTmp: string;
  begin
    if bKey then
      begin
        szTmp := PropName;
        szTmp := Copy(szTmp, 2, Length(szTmp) - 2);
        Writer.WriteStr(AnsiString(szTmp));
        ConvertValue(PropName, bKey);
      end
    else
      begin
        Writer.WriteStr(AnsiString(PropName));
        ConvertValue(PropName, bKey);
      end;
  end;

begin
  CP := '\' + Reg.CurrentPath;
  if Reg.OpenKey(CompName, False) then
    begin
      Writer.WriteString(CompName);
      SL := TStringList.Create;
      Reg.GetKeyNames(SL);
      try
        iCount := SL.Count;
        Writer.WriteListBegin;
        for i := 0 to SL.Count - 1 do
          begin
            ConvertProperty(SL[i], True);
          end;

        Reg.GetValueNames(SL);
        if (SL.Count > 0) and (trim(SL[0]) = '') then SL.Delete(0);
        iCount := iCount + SL.Count;
        for i := 0 to SL.Count - 1 do
          begin
            ConvertProperty(SL[i], False);
          end;

        Writer.WriteListEnd;
        if iCount = 0 then
          begin
      Writer.WriteValue(vaNull);
      end
      finally
        SL.Free;
      end;
    end;
  Reg.OpenKey(CP, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.SaveObject(Stream: TStream;
 szType: string);
var
  CompName: string;
  Reader: TReader;
  PropName, TS: string;

 procedure WriteData(Name, szType: string; const Data; DataSize: Integer);
  var
    p: pchar;
  begin
    p := AllocMem(Length(szType) + DataSize);
    try
      Move(szType[1], p^, Length(szType));
      Move(Data, p[Length(szType)], DataSize);
      Reg.WriteBinaryData(Name, p^, Length(szType) + DataSize);
    finally
      FreeMemory(p);
    end;
  end;

  procedure ConvertValue;
  var
    I, L: Integer;
    S, S1: string;
    W: WideString;
    p: pchar;
    CP, CP1: string;
    tmpDbl: Double;
    tmpSingle: Single;
    tmpCur: Currency;
  begin
    case Reader.NextValue of
      vaList:
        begin
          Reader.ReadValue;
          CP := '\' + Reg.CurrentPath;
          Reg.DeleteKey('<' + PropName + '>');
          Reg.OpenKey('<' + PropName + '>', True);
          i := 1;
          while not Reader.EndOfList do
            begin
              PropName := 'value' + IntToStr(i);
              Inc(i);
              ConvertValue;
            end;
          Reader.ReadListEnd;
          Reg.OpenKey(CP, False);
        end;
      vaInt8, vaInt16, vaInt32:
        Reg.WriteInteger(PropName, EncryptInteger(Reader.ReadInteger));

      vaExtended:
        begin
          tmpDbl := Reader.ReadFloat;
          WriteData(PropName, 'E', (tmpDbl), sizeof(tmpDbl));
        end;

      vaSingle:
        begin
          tmpSingle := Reader.ReadSingle;
          WriteData(PropName, 'G', (tmpSingle), sizeof(tmpSingle));
        end;

      vaCurrency:
        begin
          tmpCur := Reader.ReadCurrency;
          WriteData(PropName, 'C', (tmpCur), sizeof(tmpCur));
        end;

      vaDate:
        begin
          tmpDbl := Reader.ReadDate;
          WriteData(PropName, 'D', (tmpDbl), sizeof(tmpDbl));
        end;

      vaWString, vaUTF8String:
        begin
          W := Reader.ReadWideString;
          S := '/' + string(LMDConvertUTF16ToUTF7(W, false, true)) + '/';
          Reg.WriteString(PropName, S);
        end;

      vaString, vaLString:
        begin
          S := Reader.ReadString;
          S := EncryptString(S);
          L := Length(S);
          if L > 512 then
            begin
              S := 'S' + S;
              Reg.WriteBinaryData(PropName,  S[1], L + 1);
            end
          else
            Reg.WriteString(PropName, '''' + S + '''');
        end;

      vaIdent, vaFalse, vaTrue, vaNil, vaNull:
        Reg.WriteString(PropName, '(' + Reader.ReadIdent + ')');

      vaBinary:
        begin
          Reader.ReadValue;
          Reader.Read(L, SizeOf(L));
          p := AllocMem(L + 1);
          if (L>0) then
          try
            PChar(p)[0] := 'B';
            Reader.Read(PChar(p)[1], L);
            Reg.WriteBinaryData(PropName, p^, L + 1);
          finally
            FreeMem(p);
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
              if I > 0 then S1 := S1 + ' ';
              S1 := S1 + S;
              Inc(I);
            end;
          Reg.WriteString(PropName, '[' + S1 + ']');
        end;

      vaCollection:
        begin
          Reader.ReadValue;
          CP := '\' + Reg.CurrentPath;
          Reg.DeleteKey('[' + PropName + ']');
          Reg.OpenKey('[' + PropName + ']', True);
          i := 1;
          while not Reader.EndOfList do
            begin
              PropName := 'item' + IntToStr(i);
              inc(i);
              if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
                begin
                  ConvertValue;
                end;
              Reader.CheckValue(vaList);
              CP1 := '\' + Reg.CurrentPath;
              Reg.OpenKey(PropName, True);
              while not Reader.EndOfList do
                begin
                  // ConvertProperty;  < Not working under D8. Replaced.
                  PropName := Reader.ReadStr; // save for error reporting
                  ConvertValue;
                end;
              Reader.ReadListEnd;
              Reg.OpenKey(CP1, False);
            end;
          Reader.ReadListEnd;
          Reg.OpenKey(CP, False);
        end;
    end;
  end;

  procedure ConvertComponent;
  var
    CP: string;
  begin
    CP := '\' + Reg.CurrentPath;
    Reg.OpenKey(CompName, True);
    Reg.WriteString('', szType);
    if Reader.NextValue <> vaNull then
      begin
        Reader.ReadListBegin;
        while not Reader.EndOfList do
          begin
            // ConvertProperty;
            PropName := Reader.ReadStr; // save for error reporting
            ConvertValue;
          end;
        Reader.ReadListEnd;
      end;
    Reg.OpenKey(CP, False);
  end;

begin
  TS := CurrentActiveSection;

  Stream.Seek(0, soFromBeginning);

  Reader := TReader.Create(Stream, 4096);
  try
    Reader.ReadListBegin;
    CompName := Reader.ReadString;
    while not Reader.EndOfList do
      ConvertComponent;
    Reader.ReadListEnd;
  finally
    Reader.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteEssence(const Section, Ident, szType:
  string; Instance: TPersistent);
var
  MS: TMemoryStream;
  Writer: TLMDOSWriter;
  TS: string;
begin
  if not Assigned(Instance) then exit;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  DeleteKeyEx(TS, Ident, szType);
  Open;
  Reg.OpenKey(TS, True);

  MS := TMemoryStream.Create;
  Writer := TLMDOSWriter.Create(MS, 4096);
  try
    Writer.WriteListBegin;
    Writer.LMDWriteObject(Instance, Ident);
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;

  SaveObject(MS, szType);
  FreeAndNil(MS);

  Update;
end;

function TLMDStorCustomRegistryVault.ReadEssence(const Section, Ident, szType:
 string; Instance: TPersistent): TPersistent;
var
  Writer: TCrackWriter;
  TS: string;
  MS: TMemoryStream;
  Reader: TLMDOSReader;
begin
  Open;

  Result := nil;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  Reg.OpenKey(TS, False);
  if GetType(Ident) <> szType then exit;

  MS := TMemoryStream.Create;
  Writer := TCrackWriter.Create(MS, 4096);
  try
    Writer.WriteListBegin;
    LoadComponent(Ident, Writer);
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
    Reader.ReadString;
    while not Reader.EndOfList do Reader.LMDReadObject(Instance);
    Reader.ReadListEnd;
    Reader.FixupReferences;
    Reader.EndReferences;
  finally
    Reader.Free;
  end;
  Result := Instance;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorCustomRegistryVault.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Reg := TRegistry.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDStorCustomRegistryVault.Destroy;
begin
  FreeAndNil(Reg);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.Save(Stream: TMemoryStream);
var
  MS: TMemoryStream;
  Reader: TReader;
  PropName, TS: string;
  procedure WriteData(Name, szType: String; const Data; DataSize: Integer);
  var
    p: PAnsiChar;
  begin
    p := AllocMem(Length(szType) + DataSize);
    try
      Move(AnsiString(szType)[1], p^, Length(szType));
      Move(Data, p[Length(szType)], DataSize);
      Reg.WriteBinaryData(Name, p^, Length(szType) + DataSize);
    finally
      FreeMemory(p);
    end;
  end;
  //  procedure ConvertProperty; forward;

  procedure ConvertValue;
  var
    I, L: Integer;
    S, S1: string;
    W: WideString;
    p: PAnsiChar;
    CP, CP1: string;
    tmpDbl: Double;
    tmpSingle: Single;
    tmpCur: Currency;
    NV : TValueType;
  begin
    NV := Reader.NextValue;
    case NV of
      vaList:
        begin
          Reader.ReadValue;
          CP := '\' + Reg.CurrentPath;
          Reg.DeleteKey('<' + PropName + '>');
          Reg.OpenKey('<' + PropName + '>', True);
          i := 1;
          while not Reader.EndOfList do
            begin
              PropName := 'value' + IntToStr(i);
              Inc(i);
              ConvertValue;
            end;
          Reader.ReadListEnd;
          Reg.OpenKey(CP, False);
        end;

      vaInt8, vaInt16, vaInt32:
        Reg.WriteInteger(PropName, EncryptInteger(Reader.ReadInteger));

      vaExtended:
        begin
          tmpDbl := Reader.ReadFloat;
          WriteData(PropName, 'E', (tmpDbl), sizeof(tmpDbl));
        end;

      vaSingle:
        begin
          tmpSingle := Reader.ReadSingle;
          WriteData(PropName, 'G', (tmpSingle), sizeof(tmpSingle));
        end;

      vaCurrency:
        begin
          tmpCur := Reader.ReadCurrency;
          WriteData(PropName, 'C', (tmpCur), sizeof(tmpCur));
        end;

      vaDate:
        begin
          tmpDbl := Reader.ReadDate;
          WriteData(PropName, 'D', (tmpDbl), sizeof(tmpDbl));
        end;

      vaWString, vaUTF8String:
        begin
          W := Reader.ReadWideString;
          S := '/' + string(LMDConvertUTF16ToUTF7(W, false, true)) + '/';
          Reg.WriteString(PropName, S);
        end;

      vaString, vaLString:
        begin
          S := Reader.ReadString;
          S := EncryptString(S);
          L := Length(S);
          if L > 512 then
            begin
              S := 'S' + S;
              Reg.WriteBinaryData(PropName,  S[1], L + 1);
            end
          else
            Reg.WriteString(PropName, '''' + S + '''');
        end;

      vaIdent, vaFalse, vaTrue, vaNil, vaNull:
        Reg.WriteString(PropName, '(' + Reader.ReadIdent + ')');

      vaBinary:
        begin
          Reader.ReadValue;
          Reader.Read(L, SizeOf(L));
          p := AllocMem(L + 1);
          if (L>0) then
          try
            PAnsiChar(p)[0] := 'B';
            Reader.Read(PAnsiChar(p)[1], L);
            Reg.WriteBinaryData(PropName, p^, L + 1);
          finally
            FreeMem(p);
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
              if I > 0 then S1 := S1 + ' ';
              S1 := S1 + S;
              Inc(I);
            end;
          Reg.WriteString(PropName, '[' + S1 + ']');
        end;

      vaCollection:
        begin
          Reader.ReadValue;
          CP := '\' + Reg.CurrentPath;
          Reg.DeleteKey('[' + PropName + ']');
          Reg.OpenKey('[' + PropName + ']', True);
          i := 1;
          while not Reader.EndOfList do
            begin
              PropName := 'item' + IntToStr(i);
              inc(i);
              if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
                begin
                  ConvertValue;
                end;
              Reader.CheckValue(vaList);
              CP1 := '\' + Reg.CurrentPath;
              Reg.OpenKey(PropName, True);
              while not Reader.EndOfList do
                begin
                  //ConvertProperty;
                  PropName := Reader.ReadStr; // save for error reporting
                  ConvertValue;
                end;
              Reader.ReadListEnd;
              Reg.OpenKey(CP1, False);
            end;
          Reader.ReadListEnd;
          Reg.OpenKey(CP, False);
        end;
    end;
  end;

  procedure ConvertComponent;
  var
    CompName: string;
    CP: string;
  begin
    CompName := Reader.ReadString;
    CP := '\' + Reg.CurrentPath;
    Reg.OpenKey(CompName, True);
    Reg.WriteString('', 'Component');
    if Reader.NextValue <> vaNull then
      begin
        Reader.ReadListBegin;
        while not Reader.EndOfList do
          begin
            PropName := Reader.ReadStr; // save for error reporting
            ConvertValue;
          end;
        Reader.ReadListEnd;
      end;
    Reg.OpenKey(CP, False);
  end;

begin
  inherited Save(Stream);
  Open;
  TS := CurrentActiveSection;
  if Reg.OpenKey(TS, True) then
    begin
      DeleteKey(TS, 'DATA');
      DoOnSaveStream(self, Stream);
    Stream.Seek(0, soFromBeginning);
    if BinaryStream then
        begin
          MS := TMemoryStream.Create;
          try
            MS.CopyFrom(Stream, Stream.Size);
            Reg.WriteBinaryData('DATA', MS.Memory^, MS.Size);
            Reg.WriteString('DATA@Type', 'Binary');
          finally
            MS.Free;
          end;
        end
      else
        begin
          Reader := TReader.Create(Stream, 4096);
          try
            Reader.ReadListBegin;
            while not Reader.EndOfList do
              ConvertComponent;
            Reader.ReadListEnd;
          finally
            Reader.Free;
          end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.Load(Stream: TMemoryStream);
var
  MS: TMemoryStream;
  Writer: TCrackWriter;
  SL: TStringList;
  i: Integer;
  TS: string;
begin
  FIsLoading := true;
  Open;
  TS := CurrentActiveSection;
  if Reg.OpenKey(TS, False) then
    begin
      if BinaryStream then
        begin
          MS := TMemoryStream.Create;
          try
            MS.Size := Reg.GetDataSize('DATA');
            if (MS.Size > 0) and (GetType('DATA') = 'Binary') then
              begin
            Reg.ReadBinaryData('DATA', MS.Memory^, MS.Size);
                MS.Seek(0, soFromBeginning);
            Stream.CopyFrom(MS, MS.Size);
              end;
          finally
            MS.Free;
          end;
        end
      else
        begin
          Writer := TCrackWriter.Create(Stream, 4096);
          try
            Writer.WriteListBegin;
            SL := TStringList.Create;
            try
              Reg.GetKeyNames(SL);
              for i := 0 to SL.Count - 1 do
                if GetType(SL[i]) = 'Component' then
                  LoadComponent(SL[i], Writer);
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
procedure TLMDStorCustomRegistryVault.Open;
begin
  if trim(FRegistryKey) = '' then raise
    EFilerError.Create('RegistryKey property not assign');
  DoOnBeforeOpen(self);
  if FRegistryRoot = rrCurrentUser then
    Reg.RootKey := HKEY_CURRENT_USER
  else
    Reg.RootKey := HKEY_LOCAL_MACHINE;
  try
    Reg.OpenKey(FRegistryKey, True);
  except
    Reg.OpenKey(FRegistryKey, False);
  end;

  Sections.Clear;
  Reg.GetKeyNames(Sections);
  DoOnAfterOpen(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.Delete;
var
  i: integer;
begin
  Open;
  Reg.DeleteKey(FRegistryKey);
  for i := 0 to Sections.Count - 1 do
   DoOnSectionDelete(self, Sections[i]);
  Sections.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.DeleteKey(const Section, Ident: string);
var
  TS: string;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  Reg.OpenKey(TS, False);
  if Reg.KeyExists(Ident) then Reg.DeleteKey(Ident);
  if Reg.ValueExists(Ident) then Reg.DeleteValue(Ident);
  if Reg.ValueExists(Ident + '@Type') then Reg.DeleteValue(Ident + '@Type');
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.DeleteKeyEx(const Section, Ident,
  szType: string);
var
  TS: string;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  Reg.OpenKey(TS, False);
  if (Reg.KeyExists(Ident)) and (GetType(Ident) = szType) then
    Reg.DeleteKey(Ident);
  if (Reg.ValueExists(Ident)) and (GetType(Ident) = szType) then
    begin
      Reg.DeleteValue(Ident);
      if Reg.ValueExists(Ident + '@Type') then Reg.DeleteValue(Ident + '@Type');
    end;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.KeyExists(const Key: string;
  Section: string = ''): Boolean;
var
  TS: string;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  Reg.OpenKey(TS, False);
  Result := Reg.KeyExists(Key) or Reg.ValueExists(Key);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.SectionExists(const Section: string):
  Boolean;
begin
  Open;
  Result := Reg.KeyExists(Section);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.Close;
begin
  DoOnBeforeClose(self);
  Reg.CloseKey;
  DoOnAfterClose(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.Update;
begin
// none
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.AddSection(const Section: string);
begin
  Open;
  if SectionExists(Section) then exit;
  Reg.OpenKey(Section, True);
  Sections.Add(Section);
  DoOnSectionAdd(self, Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.RenameSection(const OldName,
  NewName: string): Boolean;
begin
  Open;
  Result := SectionExists(OldName);
  Reg.MoveKey(OldName, NewName, True);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.RemoveSection(const Section: string):
  Boolean;
begin
  Open;
  Result := Reg.DeleteKey(Section);
  Sections.Delete(Sections.IndexOf(Section));
  DoOnSectionDelete(self, Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.DeleteSection(const Section: string):
  Boolean;
begin
  Result := RemoveSection(Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ClearSection(const Section: string):
  Boolean;
begin
  Result := False;
  Open;
  if not SectionExists(Section) then exit;
  Reg.DeleteKey(Section);
  Reg.CreateKey(Section);
  Result := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.ReadKeys(Strings: TStrings;
  Section: string = '');
var
  i: integer;
  TS: string;
  TSL: TStrings;
begin
  Open;
  if not Assigned(Strings) then exit;
  Strings.Clear;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  Reg.OpenKey(TS, False);
  TSL := TStringList.Create;
  try
    Reg.GetValueNames(TSL);
    Reg.GetKeyNames(Strings);
    for i := 0 to Strings.Count - 1 do
      begin
        TS := '\' + Reg.CurrentPath;
        Reg.OpenKey(Strings[i], False);
        Strings[i] := Strings[i] + '=' + Reg.ReadString('');
        Reg.OpenKey(TS, False);
      end;
    for i := TSL.Count - 1 downto 0 do
      Strings.Insert(0, TSL[i] + '=' + Reg.ReadString(TSL[i]));
  finally
    FreeAndNil(TSL);
  end
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.KeyCount(Section: string = ''): Integer;
var
  TSL: TStrings;
  TS: string;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  Reg.OpenKey(TS, False);
  TSL := TStringList.Create;
  try
    Reg.GetValueNames(TSL);
    Result := TSL.Count;
    TSL.Clear;
    Reg.GetKeyNames(TSL);
    Result := Result + TSL.Count;
  finally
    FreeAndNil(TSL);
  end
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteBool(const Section, Ident: string;
  Value: Boolean);
var
  BS: String;
begin
  if Value then BS := '-1' else BS := '0';
  WriteSimpleProperty(Section, Ident, 'Identifier', BS);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadBool(const Section,
  Ident: string; Default: Boolean): Boolean;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Identifier' then Result := PropValue = '-1';
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteColor(const Section, Ident: string;
  Value: TColor);
begin
  WriteSimpleProperty(Section, Ident, 'Color', ColorToString(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadColor(const Section, Ident: string;
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
procedure TLMDStorCustomRegistryVault.WriteObject(const Section, Ident: string;
 Instance: TPersistent);
begin
  WriteEssence(Section, Ident, 'Object', Instance);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadObject(const Section, Ident: string;
 Instance: TPersistent): TPersistent;
begin
  Result := Instance;
  ReadEssence(Section, Ident, 'Object', Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteComponent(const Instance: TComponent;
  const Section: string = '');
var
  MS: TMemoryStream;
  Writer: TLMDOSWriter;
  TS: string;
  CustomRoot : TComponent;
begin
  if not Assigned(Instance) then exit;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;

  DeleteKeyEx(TS, Instance.Name, 'Component');
  Open;
  Reg.OpenKey(TS, True);

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

  SaveObject(MS, 'Component');
  FreeAndNil(MS);

  Update;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadComponent(const Section: string;
 Instance: TComponent): TComponent;
var
  Writer : TCrackWriter;
  TS : string;
  MS : TMemoryStream;
  Reader : TLMDOSReader;
  CustomRoot : TComponent;
begin
  Open;

  Result := nil;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  Reg.OpenKey(TS, False);
  if GetType(Instance.Name) = 'Component' then
    begin

      MS := TMemoryStream.Create;
      Writer := TCrackWriter.Create(MS, 4096);
      try
        Writer.WriteListBegin;
        LoadComponent(Instance.Name, Writer);
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
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteDate(const Section, Ident: string;
  Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'Date', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadDate(const Section, Ident: string;
  Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Date' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteDateTime(const Section, Ident:
 string; Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'DateTime', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadDateTime(const Section, Ident: string;
  Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'DateTime' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteFloat(const Section, Ident: string;
 Value: Double);
begin
  WriteSimpleProperty(Section, Ident, 'Float', FloatToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadFloat(const Section, Ident: string;
  Default: Double): Double;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Float' then Result := StrToFloat(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteFont(const Section, Ident: string;
  Instance: TFont);
begin
  WriteEssence(Section, Ident, 'Font', Instance);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadFont(const Section, Ident: string;
  Instance: TFont): TFont;
begin
  Result := Instance;
  ReadEssence(Section, Ident, 'Font', Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteInteger(const Section, Ident: string;
  Value: LongInt);
begin
  WriteSimpleProperty(Section, Ident, 'Integer',
   IntToStr(EncryptInteger(Value)));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadInteger(const Section, Ident: string;
  Default: LongInt): LongInt;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Integer' then Result := DecryptInteger(StrToInt(PropValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteInt64(const Section, Ident: string;
  Value: Int64);
begin
  WriteSimpleProperty(Section, Ident, 'Int64',
   IntToStr(EncryptInteger(Value)));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadInt64(const Section, Ident: string;
  Default: Int64): Int64;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Int64' then Result := DecryptInteger(StrToInt64(PropValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteStrings(const Section, Ident: string;
 Value: TStrings);
var
  TS: string;
  i: integer;
begin
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  DeleteKeyEx(TS, Ident, 'Strings');
  Open;
  Reg.OpenKey(TS, True);
  Reg.OpenKey(Ident, True);
  Reg.WriteString('', 'Strings');
  Reg.WriteString('Count', IntToStr(Value.Count));
  for i := 0 to Value.Count - 1 do
   Reg.WriteString('Item@' + IntToStr(i), Value[i]);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.ReadStrings(const Section, Ident: string;
 Value: TStrings);
var
  TS: String;
  Count, i: Integer;
begin
  Open;
  Value.Clear;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  if Reg.OpenKey(TS + '\' + Ident, False) and (Reg.ReadString('') = 'Strings')
   then
    begin
      Count := StrToInt(Reg.ReadString('Count'));
      if Count > 0 then for i := 0 to Count - 1 do
       Value.Add(Reg.ReadString('Item@' + IntToStr(i)));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WritePoint(const Section, Ident: string;
  Value: TPoint);
begin
  WriteSimpleProperty(Section, Ident, 'Point',
    IntToStr(Value.X) + '.' + IntToStr(Value.Y));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadPoint(const Section, Ident: string;
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
procedure TLMDStorCustomRegistryVault.WriteRect(const Section, Ident: string;
  Value: TRect);
begin
  WriteSimpleProperty(Section, Ident, 'Rect',
    IntToStr(Value.Left) + '.' + IntToStr(Value.Top) + '.' +
    IntToStr(Value.Right) + '.' + IntToStr(Value.Bottom));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadRect(const Section, Ident: string;
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
procedure TLMDStorCustomRegistryVault.WriteString(const Section, Ident: string;
  Value: String);
begin
  WriteSimpleProperty(Section, Ident, 'String', EncryptString(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadString(const Section, Ident: string;
  Default: String): String;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'String' then Result := DecryptString(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.WriteTime(const Section, Ident: string;
 Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'Time', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomRegistryVault.ReadTime(const Section, Ident: string;
 Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Time' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.ReadSection (const Section: String;
 Strings: TStrings);
var
  TS: String;
  TL: TStrings;
begin
  Open;
  Strings.Clear;
  TL := TStringList.Create;
  try
    if Section <> '' then TS := Section else TS := CurrentActiveSection;
    if Reg.OpenKey(TS, False) then
      begin
        Reg.GetKeyNames(TL);
        Strings.AddStrings(TL);
        TL.Clear;
        Reg.GetValueNames(TL);
        Strings.AddStrings(TL);
      end;
  finally
    FreeAndNil(TL);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomRegistryVault.ReadSections(Strings: TStrings);
begin
  Open;
  Strings.Clear;
  Reg.GetKeyNames(Strings);
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}

end.
