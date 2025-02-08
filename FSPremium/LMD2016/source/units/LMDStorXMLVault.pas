unit LMDStorXMLVault;
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

LMDStorXMLVault unit (VO)
------------------------

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Classes, SysUtils, Graphics, TypInfo, Controls, Windows, Types, LMDTypes,
     LMDUnicode, LMDStorBase, LMDStorCommon, LMDStorXMLSupport,
     LMDStorPropertiesStorage;

const
  MaxXMLStringLength = 900;

type
  // helper class
  TXMLCrackWriter = class(TWriter)
  public
  end;

  {-------------------  Class TLMDStorCustomXMLVault --------------------------}
  TLMDStorCustomXMLVault = class(TLMDAbstractStorageVault)
  private
    FHeader: string;
    FFooter: string;
    FMainTag: string;
    Parsed: Boolean;
    FNormalizeSeparators: boolean;
    procedure SetHeader(const Value: string);
    procedure SetFooter(const Value: string);
    procedure SetMainTag(const Value: string);
    function CurrentActiveSection: string;
    function GetTag(const Section: string): TLMDStorXMLTag;
    procedure WriteSimpleProperty(const Section, Ident, PropType, PropValue: string);
    procedure ReadSimpleProperty(const Section, Ident: string; var PropType, PropValue: string);
    procedure LoadComponent(Tag: TLMDStorXMLTag; Writer: TXMLCrackWriter);
    procedure SaveObject(Stream: TStream; Section, szType: string);
    procedure WriteEssence(const Section, Ident, szType:string; Instance: TPersistent);
    function ReadEssence(const Section, Ident, szType: string;Instance: TPersistent): TPersistent;
    function IsCustomFooter: Boolean;
    function IsCustomHeader: Boolean;
    function IsCustomMainTag: Boolean;
    procedure WriteData(Tag: TLMDStorXMLTag; Name, szType: string;
                        const Data ; DataSize: Integer);
  protected
    XML: TLMDStorXML;
    BinaryState: Boolean;
    function Extension: String; override;
    function Normalize(v: string):string;
    procedure FileChanged; override;
    property Header: string read FHeader write SetHeader stored IsCustomHeader;
    property Footer: string read FFooter write SetFooter stored IsCustomFooter;
    property MainTag: string read FMainTag write SetMainTag stored IsCustomMainTag;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save(Stream: TMemoryStream); override;
    procedure Load(Stream: TMemoryStream); override;
    procedure Open; override;
    procedure Close; override;
    procedure Update; override;
    procedure Delete;
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
    procedure DeleteKeyEx(const Section, Ident, Attribute: string);
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
    procedure WriteFont(const Section, Ident: string; Instance: TFont); override;
    function ReadFont(const Section, Ident: string; Instance: TFont): TFont; override;
    procedure WriteInteger(const Section, Ident: string; Value: LongInt);override;
    function ReadInteger(const Section, Ident: string; Default: LongInt):LongInt; override;
    procedure WriteInt64(const Section, Ident: string; Value: Int64); override;
    function ReadInt64(const Section, Ident: string; Default: Int64): Int64; override;
    procedure WritePoint(const Section, Ident: string; Value: TPoint); override;
    function ReadPoint(const Section, Ident: string; Default: TPoint): TPoint; override;
    procedure WriteRect(const Section, Ident: string; Value: TRect); override;
    function ReadRect(const Section, Ident: string; Default: TRect): TRect; override;
    procedure WriteString(const Section, Ident: string; Value: string); override;
    function ReadString(const Section, Ident: string; Default: string): string; override;
    procedure WriteStrings(const Section, Ident: string; Value: TStrings); override;
    procedure ReadStrings(const Section, Ident: string; Value: TStrings); override;
    procedure WriteTime(const Section, Ident: string; Value: TDateTime); override;
    function ReadTime(const Section, Ident: string; Default: TDateTime): TDateTime; override;
    procedure ReadSection (const Section: String; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;             
    property NormalizeSeparators: boolean read FNormalizeSeparators write FNormalizeSeparators;
  end;

  {-------------------  Class TLMDStorXMLVault --------------------------------}
  TLMDStorXMLVault = class(TLMDStorCustomXMLVault)
  published
    property BinaryStream;
    property FileName;
    property FilePrefix;
    property AppDataPath;
    property AppDataCommon;
    property Encrypted;        
    property Header;
    property Footer;
    property MainTag;
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
    property StorageCryptor;
    property Sections;
    property ActiveSection;
    property ActiveSectionIndex;
    property AutoUpdate;
    property NormalizeSeparators default false;
  end;

implementation

uses
  LMDStrings, LMDStorConsts;

const
  LMD_DATA_TAG = 'LMDStorageData';

// helper functions
{------------------------------------------------------------------------------}
function GetAttribute(Attributes: TStrings; Attribute: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Attributes.Count - 1 do
    if Pos(Attribute + '=', Attributes[i]) = 1 then
      Result := copy(Attributes[i], Length(Attribute) + 2,
        Length(Attributes[i]) - Length(Attribute) - 1);
  // Delete quotes 
  if (Length(Result) > 0) and (Result[1] = '"') then
   Result := copy(Result, 2, Length(Result) - 1);
  if (Length(Result) > 0) and (Result[Length(Result)] = '"') then
   Result := copy(Result, 1, Length(Result) - 1);
end;

{------------------------------------------------------------------------------}
function GetItemAttr(Attributes: TStrings): Integer;
var
  szTMP: string;
begin
  szTMP := GetAttribute(Attributes, 'Item');
  if trim(szTMP) = '' then Result := -1 else
    Result := StrToIntDef(szTMP, 0);
end;

{------------------------------------------------------------------------------}
function GetTypeAttr(Attributes: TStrings): string;
begin
  Result := GetAttribute(Attributes, 'Type');
end;

{------------------------------------------------------------------------------}
function GetHexText(Stream: TMemoryStream): string;

begin
  Result := '';
  SetLength(Result, (Stream.Size - Stream.Position) * 2);
  if Length(Result) > 0 then
    begin
    Stream.Position := 0;
      BinToHex(Pointer(TLMDPtrInt(Stream.Memory) + Stream.Position), PChar(Result),
        Stream.Size - Stream.Position);
    end;
end;

{------------------------------------------------------------------------------}
function GetCount(Attributes: TStrings): Integer;
var
  szTMP: string;
begin
  szTMP := GetAttribute(Attributes, 'Count');
  Result := StrToIntDef(szTMP, 0);
end;

{********************* TXMLCrackWriter ****************************************}
{------------------------- Public ---------------------------------------------}

{********************* TLMDStorCustomXMLVault *********************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorCustomXMLVault.SetHeader(const Value: string);
begin
  if FHeader <> Value then
  begin
    FHeader := Value;
    XML.Header := FHeader;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.SetFooter(const Value: string);
begin
  if FFooter <> Value then
    begin
      FFooter := Value;
      XML.Footer := FFooter;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.SetMainTag(const Value: string);
begin
  if FMainTag <> Value then
    begin
      FMainTag := Value;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.IsCustomFooter:Boolean;
begin
  result := FFooter<>IDS_STOR_DEFAULTXMLFOOTER;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.IsCustomHeader:Boolean;
begin
  result := FHeader<>IDS_STOR_DEFAULTXMLHEADER;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.IsCustomMainTag:Boolean;
begin
  result := FMainTag<>LMD_DATA_TAG;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteData(Tag: TLMDStorXMLTag; Name, szType: string;
  const Data; DataSize: Integer);
var
  Stream, MS: TMemoryStream;
  HT: string;
  q: TLMDStorXMLTag;
  Count: Integer;
begin
  MS := TMemoryStream.Create;
  Stream := TMemoryStream.Create;
  try
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
    if Stream.Size > MaxXMLStringLength div 2 then
      begin
        while Count * MaxXMLStringLength div 2 <= Stream.Size do
          begin
            MS.Clear;
            if Stream.Size < Stream.Position + MaxXMLStringLength div 2 then
              MS.CopyFrom(Stream, Stream.Size - Stream.Position)
            else
              MS.CopyFrom(Stream, MaxXMLStringLength div 2);
          MS.Seek(0, soFromBeginning);
          HT := GetHexText(MS);
            q := Tag.SubTags.Add;
            q.Name := Name;
            q.Attribute['Type']:=szType;
            q.Attribute['Item']:=IntToStr(Count);
            q.Text := HT;
            Count := Count + 1;
          end;
          Tag.Attribute['Count']:=IntToStr(Count);
      end else
      begin
        q := Tag.SubTags.Add;
        q.Name := Name;
        q.Attribute['Type']:= szType;
        q.Attribute['Item']:='0';
        q.Text := GetHexText(Stream);
      end;
  finally
    FreeAndNil(MS);
    FreeAndNil(Stream);
  end;
end;

{------------------------- Protected ------------------------------------------}
function TLMDStorCustomXMLVault.Extension: String;
begin
  Result := 'xml';
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.FileChanged;
begin
  inherited;
  Parsed := false;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.CurrentActiveSection: string;
begin
  Result := ActiveSection;
  if Trim(Result) = '' then Result := 'DATA';
  ReplaceChar(Result, ' ', '_');
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.GetTag(const Section: string): TLMDStorXMLTag;
var
  i: integer;
begin
  Result := nil;
  Open;
  if XML.XMLTags.Count = 0 then exit;
  for i := 0 to XML.XMLTags[0].SubTags.Count - 1 do
    if XML.XMLTags[0].SubTags[i].Name = Section then
      begin
        Result := XML.XMLTags[0].SubTags[i];
        break;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteSimpleProperty(const Section, Ident,
  PropType, PropValue: string);
var
  q, n: TLMDStorXMLTag;
  TS: String;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if XML.XMLTags.Count = 0 then
    begin
      n := XML.XMLTags.Add;
      n.Name := FMainTag;
    end;
  if not Assigned(q) then q := XML.XMLTags[0].SubTags.Add;
  q.Name := TS;

  DeleteKeyEx(TS, Ident, 'Type="' + PropType + '"');

  n := q.SubTags.Add;
  n.Name := Ident;
  n.Attribute['Type']:=PropType;
  n.Text := PropValue;
  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.ReadSimpleProperty(const Section,
  Ident: string; var PropType, PropValue: string);
var
  i: integer;
  q: TLMDStorXMLTag;
  TS: string;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if Assigned(q) then for i := 0 to q.SubTags.Count - 1 do
      if trim(q.SubTags[i].Name) = trim(Ident) then
        begin
          PropType := GetTypeAttr(q.SubTags[i].Attributes);
          PropValue := q.SubTags[i].Text;
          break;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteEssence(const Section, Ident, szType:
  string; Instance: TPersistent);
var
  q, n: TLMDStorXMLTag;
  MS: TMemoryStream;
  Writer: TLMDOSWriter;
  TS: string;
begin
  if not Assigned(Instance) then exit;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if XML.XMLTags.Count = 0 then
    begin
      n := XML.XMLTags.Add;
      n.Name := FMainTag;
    end;
  if not Assigned(q) then q := XML.XMLTags[0].SubTags.Add;
  q.Name := TS;

  DeleteKeyEx(TS, Ident, 'Type="' + szType + '"');

  MS := TMemoryStream.Create;

  Writer := TLMDOSWriter.Create(MS, 4096);
  try
    Writer.WriteListBegin;
    Writer.LMDWriteObject(Instance, Ident);
    Writer.WriteListEnd;
  finally
    Writer.Free;
  end;

  SaveObject(MS, TS, szType);
  FreeAndNil(MS);

  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadEssence(const Section, Ident, szType:
  string; Instance: TPersistent): TPersistent;
var
  q: TLMDStorXMLTag;
  i: integer;
  Writer: TXMLCrackWriter;
  TS: string;
  MS: TMemoryStream;
  Reader: TLMDOSReader;
begin
  Open;

  Result := nil;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if Assigned(q) then for i := 0 to q.SubTags.Count - 1 do
      if ((trim(q.SubTags[i].Name) = trim(Ident)) and
        (trim(GetTypeAttr(q.SubTags[i].Attributes)) = szType)) then
        begin

          MS := TMemoryStream.Create;
          Writer := TXMLCrackWriter.Create(MS, 4096);
          try
            Writer.WriteListBegin;
            LoadComponent(q.SubTags[i], Writer);
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
            while not Reader.EndOfList do Reader.LMDReadObject(Instance);
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

procedure TLMDStorCustomXMLVault.LoadComponent(Tag: TLMDStorXMLTag;
 Writer: TXMLCrackWriter);
var
  MS: TMemoryStream;
  Stream: TMemoryStream;
  lText: string;

  function GetText(Tag: TLMDStorXMLTag; Name: string): string;
  var
    i, j, k, max: integer;
  begin
    Result := '';
    max := -1;
    for i := 0 to Tag.SubTags.Count - 1 do
      if Tag.SubTags.Items[i].Name = Name  then
        begin
          k := GetItemAttr(Tag.SubTags.Items[i].Attributes);
          if k > max then max := k;
          Result := Tag.SubTags.Items[i].Text;
        end;
    if max > -1 then
      begin
        Result := '';
        for i := 0 to max do
          for j := 0 to Tag.SubTags.Count - 1 do
            if ((Tag.SubTags.Items[j].Name = Name) and
              (GetItemAttr(Tag.SubTags.Items[j].Attributes) = i)) then
              begin
                Result := Result + Tag.SubTags.Items[j].Text;
              end;
      end;
  end;

  function HexToStream(HexText: AnsiString; Value: TStream): Integer;
  var
    Stream : TMemoryStream;
    Pos : Integer;
  begin
    if HexText <> '' then
      begin
        if Value is TMemoryStream then
          Stream := TMemoryStream(Value)
        else
          Stream := TMemoryStream.Create;
        try
          Pos := Stream.Position;
          Stream.SetSize(Stream.Size + Length(HexText) div 2);
          HexToBin(PAnsiChar(@HexText[1]), Pointer(TLMDPtrInt(Stream.Memory) + Stream.Position), Length(HexText) div 2);
          Stream.Position := Pos;
          if Value <> Stream then
            Value.CopyFrom(Stream, Length(HexText) div 2);
          Result := Stream.Size - Pos;
        finally
          if Value <> Stream then Stream.Free;
        end;
      end
    else
      Result := 0;
  end;

  procedure ConvertValue(Prop, ParentTag: TLMDStorXMLTag; bKey: Boolean);
  var
    szTmp, szTmp1: string;
    szWTmp: WideString;
    i, j: Integer;
    SL: TStringList;
    szType: string;
  begin
    szType := GetTypeAttr(Prop.Attributes);
    if bKey then
      begin
        if szType = 'List' then
          begin
          Writer.WriteValue(vaList);
          for i := 0 to Prop.SubTags.Count - 1 do
              if Prop.SubTags.Items[i].SubTags.Count > 0 then
                begin
                  ConvertValue(Prop.SubTags.Items[i], Prop, True);
                end;

            for i := 0 to Prop.SubTags.Count - 1 do
              if Prop.SubTags.Items[i].SubTags.Count = 0 then
                begin
                  ConvertValue(Prop.SubTags.Items[i], Prop, False);
                end;

            Writer.WriteListEnd;
          end else
          if szType = 'Collection' then
            begin
             Writer.WriteValue(vaCollection);
             SL := TStringList.Create;
              try
                for i := 0 to Prop.SubTags.Count - 1 do
                  if Prop.SubTags.Items[i].SubTags.Count = 0 then
                    begin
                      if GetItemAttr(Prop.SubTags.Items[i].Attributes) <= 0 then
                      begin
                        Writer.WriteStr(AnsiString(Prop.SubTags.Items[i].Name));
                        ConvertValue(Prop.SubTags.Items[i], Prop, False);
                      end;
                    end;

                for i := 0 to Prop.SubTags.Count - 1 do
                  if Prop.SubTags.Items[i].SubTags.Count > 0 then
                    begin
                      Writer.WriteListBegin;
                      for j := 0 to Prop.SubTags.Items[i].SubTags.Count - 1 do
                        if Prop.SubTags.Items[i].SubTags.Items[j].SubTags.Count > 0 then begin
                          if GetItemAttr(Prop.SubTags.Items[i].Attributes) <= 0 then
                          begin
                            Writer.WriteStr(AnsiString(Prop.SubTags.Items[i].SubTags.Items[j].Name));
                            ConvertValue(Prop.SubTags.Items[i].SubTags.Items[j], Prop.SubTags.Items[i], True);
                          end;
                        end;

                      for j := 0 to Prop.SubTags.Items[i].SubTags.Count - 1 do
                        if Prop.SubTags.Items[i].SubTags.Items[j].SubTags.Count = 0 then
                          if GetTypeAttr(Prop.SubTags.Items[i].SubTags.Items[j].Attributes) <>
                            'Collection' then
                            begin
                              if GetItemAttr(Prop.SubTags.Items[i].Attributes) <= 0 then
                              begin
                                Writer.WriteStr(AnsiString(Prop.SubTags.Items[i].SubTags.Items[j].Name));
                                ConvertValue(Prop.SubTags.Items[i].SubTags.Items[j], Prop.SubTags.Items[i], False);
                              end;
                            end;
                      Writer.WriteListEnd;
                    end;
              finally
                SL.Free;
              end;
              Writer.WriteListEnd;
            end;
      end
    else
      begin
        lText := Prop.Text;
        if (szType = 'Extended') or (szType = 'Single') or (szType = 'Currency')
          and NormalizeSeparators then
          lText := LMDAnsiReplaceChar(lText, '.', {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator);

        if szType = 'Integer' then
          Writer.WriteInteger(DecryptInteger(StrToInt(lText))) else
          if szType = 'Extended' then
            Writer.WriteFloat(StrToFloat(lText)) else
            if szType = 'Single' then
              Writer.WriteSingle(StrToFloat(lText)) else
              if szType = 'Currency' then
                Writer.WriteCurrency(StrToCurr(lText)) else
                if szType = 'Date' then
                  Writer.WriteDate(StrToDate(lText)) else
                  if szType = 'String' then
                    Writer.WriteString(DecryptString(GetText(ParentTag, Prop.Name))) else
                    if szType = 'Identifier' then
                    Writer.WriteIdent(Prop.Text)
                    else
                    if szType = 'WideString' then
                        begin
                          szTmp := GetText(ParentTag, Prop.Name);
                          if not LMDTryConvertUTF7ToUTF16(AnsiString(szTmp), szWTmp, True) then
                            szWTmp := Base64Decode(AnsiString(szTmp));
                          Writer.WriteWideString(szWTmp);
                        end
                        else if szType = 'Binary' then
                          begin
                            MS := TMemoryStream.Create;
                            Stream := TMemoryStream.Create;
                            try
                              szTMP := GetText(ParentTag, Prop.Name);
                              HexToStream(AnsiString(szTMP), MS);

                              if CompressedStream then
                              begin
                                MS.Seek(0, soFromBeginning);
                                Stream.CopyFrom(MS, MS.Size);
                                MS.Clear;
                                Stream.Seek(0, soFromBeginning);
                                LMDStorLoadCompressedStream(Stream, MS);
                              end;

                              i := MS.Size;

                              MS.Seek(0, soFromBeginning);
                              Writer.WriteValue(vaBinary);
                              Writer.Write(i, sizeof(i));
                              Writer.Write(MS.memory^, MS.Size);
                            finally
                              FreeAndNil(MS);
                              FreeAndNil(Stream);
                            end;
                          end else
                          if szType = 'Set' then
                            begin
                             Writer.WriteValue(vaSet);
                             szTmp := Prop.Text;
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
                                  Writer.WriteStr(AnsiString(szTmp))
                                end;
                              Writer.WriteStr('');
                            end;
      end;
  end;

var
  i, iCount: Integer;

begin
  if Assigned(Tag) then begin
//    Skip := True;
    Writer.WriteString(Tag.Name);
    Writer.WriteListBegin;

    iCount := 0;
    for i := 0 to Tag.SubTags.Count - 1 do
      if (Tag.SubTags.Items[i].SubTags.Count > 0)
        or(GetTypeAttr(Tag.SubTags.Items[i].Attributes)='List')
        or(GetTypeAttr(Tag.SubTags.Items[i].Attributes)='Collection')
      then
        begin
          if GetItemAttr(Tag.SubTags.Items[i].Attributes) <= 0 then
          begin
            Writer.WriteStr(AnsiString(Tag.SubTags.Items[i].Name));
            ConvertValue(Tag.SubTags.Items[i], Tag, True);
          end;
          iCount := iCount + 1;
        end;

    for i := 0 to Tag.SubTags.Count - 1 do
      if (Tag.SubTags.Items[i].SubTags.Count = 0)
       and (GetItemAttr(Tag.SubTags.Items[i].Attributes) <= 0)
       and (GetTypeAttr(Tag.SubTags.Items[i].Attributes)<>'List')
       and (GetTypeAttr(Tag.SubTags.Items[i].Attributes)<>'Collection')
       then
        begin
          if GetItemAttr(Tag.SubTags.Items[i].Attributes) <= 0 then
          begin
            Writer.WriteStr(AnsiString(Tag.SubTags.Items[i].Name));
            ConvertValue(Tag.SubTags.Items[i], Tag, False);
          end;
          iCount := iCount + 1;
        end;

    Writer.WriteListEnd;
    if iCount = 0 then
      begin
      Writer.WriteValue(vaNull);
      end
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.SaveObject(Stream: TStream; Section,
 szType: string);
var
  Count: Int64;
  Reader: TReader;
  PropName: string;
  Level: Integer;
  q, n: TLMDStorXMLTag;
  CompName: string;
  TS: String;

  procedure ConvertValue(Tag: TLMDStorXMLTag);
  var
    I, L: Integer;
    S, S1: string;
    W: WideString;
    p: PChar;
    CP, CP1: string;
    q: TLMDStorXMLTag;
  begin
    Level := Level + 1;
    case Reader.NextValue of
      vaList:
        begin
          Reader.ReadValue;
          CP := PropName;

          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='List';

          i := 1;
          while not Reader.EndOfList do
            begin
              PropName := 'value' + IntToStr(i);
              Inc(i);
              ConvertValue(q);
            end;
          Reader.ReadListEnd;
        end;
      vaInt8, vaInt16, vaInt32:
        begin
          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='Integer';
          q.Text := IntToStr(EncryptInteger(Reader.ReadInteger));
        end;

      vaExtended:
        begin
          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='Extended';
          s := FloatToStr(Reader.ReadFloat);
          if NormalizeSeparators then
            s:= Normalize(s);
          q.Text := s;
        end;

      vaSingle:
        begin
          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='Single';
          s := FloatToStr(Reader.ReadSingle);
          if NormalizeSeparators then
            s:= Normalize(s);
          q.Text := s;
        end;

      vaCurrency:
        begin
          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='Currency';
          s := CurrToStr(Reader.ReadCurrency);
          if NormalizeSeparators then
            s:= Normalize(s);
          q.Text := s;
        end;

      vaDate:
        begin
          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='Date';
          q.Text := DateToStr(Reader.ReadDate);
        end;

      vaWString, vaUTF8String:
        begin
          W := Reader.ReadWideString;
          S := string(LMDConvertUTF16ToUTF7(W, false, true));
          L := Length(S);
          if L > 512 then
            begin
              Count := 0;
              while Count * MaxXMLStringLength div 2 <= Length(S) do
                begin
                  if Length(S) < ((Count + 1) * MaxXMLStringLength div 2) then
                    begin
                      q := Tag.SubTags.Add;
                      q.Name := PropName;
                      q.Attribute['Item']:=IntToStr(Count);
                      q.Attribute['Type']:='WideString';
                      q.Text := Copy(S, Count * MaxXMLStringLength div 2,
                        Length(S) - Count * MaxXMLStringLength div 2 + 1);
                    end else
                    begin
                      q := Tag.SubTags.Add;
                      q.Name := PropName;
                      q.Attribute['Item']:=IntToStr(Count);
                      q.Attribute['Type']:='WideString';
                      q.Text := Copy(S, Count * MaxXMLStringLength div 2,
                        MaxXMLStringLength div 2);
                    end;
                  Count := Count + 1;
                end;
            end
          else
            begin
              q := Tag.SubTags.Add;
              q.Name := PropName;
              q.Attribute['Type']:='WideString';
              q.Text := S;
            end;
        end;

      vaString, vaLString:
        begin
          S := Reader.ReadString;
          S := EncryptString(S);
          L := Length(S);
          if L > 512 then
            begin
              Count := 0;
              while Count * MaxXMLStringLength div 2 <=
                Length(S) do
                begin
                  if Length(S) < ((Count + 1) * MaxXMLStringLength div 2) then
                    begin
                      q := Tag.SubTags.Add;
                      q.Name := PropName;
                      q.Attribute['Item']:=IntToStr(Count);
                      q.Attribute['Type']:='String';
                      q.Text := Copy(S, Count * MaxXMLStringLength div 2,
                        Length(S) - Count * MaxXMLStringLength div 2 + 1);
                    end else
                    begin
                      q := Tag.SubTags.Add;
                      q.Name := PropName;
                      q.Attribute['Item']:=IntToStr(Count) ;
                      q.Attribute['Type']:='String';
                      q.Text := Copy(S, Count * MaxXMLStringLength div 2,
                        MaxXMLStringLength div 2);
                    end;
                  Count := Count + 1;
                end;
            end
          else
            begin
              q := Tag.SubTags.Add;
              q.Name := PropName;
              q.Attribute['Type']:='String';
              q.Text := S;
            end;
        end;

      vaIdent, vaFalse, vaTrue, vaNil, vaNull:
        begin
          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='Identifier';
          q.Text := Reader.ReadIdent;
        end;

      vaBinary:
        begin
          Reader.ReadValue;
          Reader.Read(L, SizeOf(L));
          p := AllocMem(L);
          if (p <> nil) then
          try
            Reader.Read(PChar(p)[0], L);
            WriteData(Tag, PropName, 'Binary', p^, L);
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
          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='Set';
          q.Text := S1;
        end;

      vaCollection:
        begin
          Reader.ReadValue;
          CP := PropName;
          q := Tag.SubTags.Add;
          q.Name := PropName;
          q.Attribute['Type']:='Collection';
          i := 1;
          while not Reader.EndOfList do
            begin
              Level := Level + 1;
              PropName := 'item' + IntToStr(i);
              inc(i);
              if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
                begin
                  ConvertValue(q);
                end;
              Reader.CheckValue(vaList);
              q := Tag.SubTags.Add;
              q.Name := PropName;
              q.Attribute['Type']:='CollectionItem';
              CP1 := PropName;
              while not Reader.EndOfList do begin
                PropName := Reader.ReadStr;
                ConvertValue(Tag);
              end;
              Reader.ReadListEnd;
              PropName := CP1;
              Level := Level - 1;
            end;
          Reader.ReadListEnd;
          PropName := CP;
        end;
    end;
    Level := Level - 1;
  end;

  procedure ConvertComponent(Tag: TLMDStorXMLTag);
  begin
    Level := 2;
    if Reader.NextValue <> vaNull then
      begin
        Reader.ReadListBegin;
        while not Reader.EndOfList do begin
          PropName := Reader.ReadStr; // save for error reporting
          ConvertValue(Tag);
        end;
        Reader.ReadListEnd;
      end;
  end;

begin
  Open;

  Stream.Seek(0, soFromBeginning);

  if XML.XMLTags.Count = 0 then
    begin
      q := XML.XMLTags.Add;
      q.Name := FMainTag;
      if AutoUpdate then Update;
    end;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if not Assigned(q) then q := XML.XMLTags[0].SubTags.Add;
  q.Name := TS;
  Reader := TReader.Create(Stream, 4096);
  try
    Reader.ReadListBegin;
    CompName := Reader.ReadString;
    n := q.SubTags.Add;
    n.Name := CompName;
    n.Attribute['Type']:=szType;
    while not Reader.EndOfList do
     ConvertComponent(n);
    Reader.ReadListEnd;
  finally
    Reader.Free;
  end;
  if AutoUpdate then Update;
end;

{------------------------- Public----------------------------------------------}
constructor TLMDStorCustomXMLVault.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMainTag:=LMD_DATA_TAG;
  XML := TLMDStorXML.Create;
  Parsed := False;
  XML.Encoding := 'UTF-8';
  Header := IDS_STOR_DEFAULTXMLHEADER;
  Footer := IDS_STOR_DEFAULTXMLFOOTER;
  BinaryState := False;
  FNormalizeSeparators := false;
end;

{------------------------------------------------------------------------------}
destructor TLMDStorCustomXMLVault.Destroy;
begin
  FreeAndNil(XML);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.Save(Stream: TMemoryStream);
var
  MS: TMemoryStream;
  Count: Int64;
  Reader: TReader;
  PropName: string;
  Level: Integer;
  q, st, q1: TLMDStorXMLTag;

  function GetUniqueKey(Tag: TLMDStorXMLTag; Key, PropType: string):
   TLMDStorXMLTag;
  var
    Found, Multy: Boolean;
    i: integer;
    q: TLMDStorXMLTag;
  begin
    Result := nil;
    if XML.XMLTags.Count = 0 then
      begin
        q := XML.XMLTags.Add;
        q.Name := FMainTag;
      end;
    q := GetTag(CurrentActiveSection);
    if not Assigned(q) then q := XML.XMLTags[0].SubTags.Add;
    q.Name := CurrentActiveSection;

    Found := False;
    Multy := False;

    for i := 0 to Tag.SubTags.Count - 1 do
      if Tag.SubTags[i].Name = Key then
        begin
          if Found then
            begin
              Multy := True;
            end;
          Found := True;
        end;

    i := 0;
    if Multy then while i < Tag.SubTags.Count do
        begin
          if Tag.SubTags[i].Name = Key then Tag.SubTags[i].Free else i := i + 1;
        end;

    Found := False;

    if not Multy then
      for i := 0 to Tag.SubTags.Count - 1 do
        if Tag.SubTags[i].Name = Key then
          begin
            if GetTypeAttr(Tag.SubTags[i].Attributes) = PropType then Found := True;
            Result := Tag.SubTags[i];
            break;
          end;

    if not Found and Assigned(Result) then
      FreeAndNil(Result);

    if not Assigned(Result) then
      begin
        Result := Tag.SubTags.Add;
        Result.Name := Key;
        Result.Attribute['Type']:=PropType;
        if AutoUpdate then Update;
      end;
  end;

  procedure RemoveKey(Tag: TLMDStorXMLTag; Key: string);
  var
    i: Integer;
  begin
    i := 0;
    while i < Tag.SubTags.Count do
      begin
        if Tag.SubTags[i].Name = Key then Tag.SubTags[i].Free else i := i + 1;
      end;
  end;

  procedure ConvertValue(Tag: TLMDStorXMLTag);
  var
    I, L: Integer;
    S, S1: string;
    W: WideString;
    p: PChar;
    CP, CP1: string;
    q, q1, m: TLMDStorXMLTag;
  begin
    Level := Level + 1;
    case Reader.NextValue of
      vaList:
        begin
          Reader.ReadValue;
          CP := PropName;

          q := GetUniqueKey(Tag, PropName, 'List');
          q.SubTags.Clear;
          q.Name := PropName;
          q.Attribute['Type']:='List';

          i := 1;
          while not Reader.EndOfList do
            begin
              PropName := 'value' + IntToStr(i);
              Inc(i);
              ConvertValue(q);
            end;
          Reader.ReadListEnd;
        end;
      vaInt8, vaInt16, vaInt32:
        begin
          q := GetUniqueKey(Tag, PropName, 'Integer');
          q.Text := IntToStr(EncryptInteger(Reader.ReadInteger));
        end;

      vaExtended:
        begin
          q := GetUniqueKey(Tag, PropName, 'Extended');
          s := FloatToStr(Reader.ReadFloat);
          if NormalizeSeparators then
            s:= Normalize(s);
          q.Text := s;
        end;

      vaSingle:
        begin
          q := GetUniqueKey(Tag, PropName, 'Single');
          s := FloatToStr(Reader.ReadSingle);
          if NormalizeSeparators then
            s:= Normalize(s);
          q.Text := s;
        end;

      vaCurrency:
        begin
          q := GetUniqueKey(Tag, PropName, 'Currency');
          s := CurrToStr(Reader.ReadCurrency);
          if NormalizeSeparators then
            s:= Normalize(s);
          q.Text := s;
        end;

      vaDate:
        begin
          q := GetUniqueKey(Tag, PropName, 'Date');
          q.Text := DateToStr(Reader.ReadDate);
        end;

      vaWString, vaUTF8String:
        begin
          W := Reader.ReadWideString;
          S := string(LMDConvertUTF16ToUTF7(W, false, true));
          L := Length(S);
          if L > 512 then
            begin
              Count := 0;
              q1 := nil;
              RemoveKey(Tag, PropName);
              while Count * MaxXMLStringLength div 2 <= Length(S) do
                begin
                  if Length(S) < ((Count + 1) * MaxXMLStringLength div 2) then
                    begin
                      q := Tag.SubTags.Add;
                      q.Name := PropName;
                      q.Attribute['Item']:=IntToStr(Count);
                      q.Attribute['Type']:='WideString';
                      q.Text := Copy(S, Count * MaxXMLStringLength div 2,
                        Length(S) - Count * MaxXMLStringLength div 2 + 1);
                    end else
                    begin
                      q := Tag.SubTags.Add;
                      q.Name := PropName;
                      q.Attribute['Item']:=IntToStr(Count);
                      q.Attribute['Type']:='WideString';
                      q.Text := Copy(S, Count * MaxXMLStringLength div 2,
                        MaxXMLStringLength div 2);
                    end;
                  if Count = 0 then q1 := q;
                  Count := Count + 1;
                end;
              if Assigned(q1) then
               q1.Attribute['Count']:=IntToStr(Count - 1);
            end
          else
            begin
              q := GetUniqueKey(Tag, PropName, 'WideString');
              q.Text := S;
            end;
        end;

      vaString, vaLString:
        begin
          S := Reader.ReadString;
          S := EncryptString(S);
          L := Length(S);
          if L > 512 then
            begin
              Count := 0;
              q1 := nil;
              RemoveKey(Tag, PropName);
              while Count * MaxXMLStringLength div 2 <=
                Length(S) do
                begin
                  if Length(S) < ((Count + 1) * MaxXMLStringLength div 2) then
                    begin
                      q := Tag.SubTags.Add;
                      q.Name := PropName;
                      q.Attribute['Item']:=IntToStr(Count);
                      q.Attribute['Type']:='String';
                      q.Text := Copy(S, Count * MaxXMLStringLength div 2,
                        Length(S) - Count * MaxXMLStringLength div 2 + 1);
                    end else
                    begin
                      q := Tag.SubTags.Add;
                      q.Name := PropName;
                      q.Attribute['Item']:=IntToStr(Count);
                      q.Attribute['Type']:='String';
                      q.Text := Copy(S, Count * MaxXMLStringLength div 2,
                        MaxXMLStringLength div 2);
                    end;
                  if Count = 0 then q1 := q;
                  Count := Count + 1;
                end;
              if Assigned(q1) then
               q1.Attribute['Count']:=IntToStr(Count - 1);              
            end
          else
            begin
              q := GetUniqueKey(Tag, PropName, 'String');
              q.Text := S;
            end;
        end;

      vaIdent, vaFalse, vaTrue, vaNil, vaNull:
        begin
          q := GetUniqueKey(Tag, PropName, 'Identifier');
          q.Text := Reader.ReadIdent;
        end;

      vaBinary:
        begin
          Reader.ReadValue;
          Reader.Read(L, SizeOf(L));
          p := AllocMem(L);
          if (p <> nil) then
          try
            Reader.Read(PChar(p)[0], L);
            RemoveKey(Tag, PropName);
            WriteData(Tag, PropName, 'Binary', p^, L);
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
          q := GetUniqueKey(Tag, PropName, 'Set');
          q.SubTags.Clear;
          q.Text := S1;
        end;

      vaCollection:
        begin
          Reader.ReadValue;
          CP := PropName;
          q := GetUniqueKey(Tag, PropName, 'Collection');
          q.SubTags.Clear;
          i := 1;
          while not Reader.EndOfList do
            begin
              Level := Level + 1;
              PropName := 'item' + IntToStr(i);
              inc(i);
              if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
                begin
                  ConvertValue(q);
                end;
              Reader.CheckValue(vaList);
              m := GetUniqueKey(q, PropName, 'CollectionItem');
              CP1 := PropName;
              while not Reader.EndOfList do
                begin
                  PropName := Reader.ReadStr;
                  ConvertValue(m);
                end;
              Reader.ReadListEnd;
              PropName := CP1;
              Level := Level - 1;
            end;
          Reader.ReadListEnd;
          PropName := CP;
        end;
    end;
    Level := Level - 1;
  end;

  procedure ConvertComponent(Tag: TLMDStorXMLTag);
  var
    CompName: string;
    q, n: TLMDStorXMLTag;
    i: integer;
  begin
    Level := 2;
    CompName := Reader.ReadString;
    q := nil;

    n := GetTag(CurrentActiveSection);
    if Assigned(n) then
      for i := 0 to n.SubTags.Count - 1 do
        if n.SubTags[i].Name = CompName then
          begin
            q := n.SubTags[i];
            break;
          end;

    if not Assigned(q) then
      begin
        q := Tag.SubTags.Add;
        q.Attribute['Type']:='Component';
      end;

    q.Name := CompName;

    if Reader.NextValue <> vaNull then
      begin
        Reader.ReadListBegin;
        while not Reader.EndOfList do
          begin
            PropName := Reader.ReadStr;
            ConvertValue(q);
          end;
        Reader.ReadListEnd;
      end;
  end;

begin
  inherited Save(Stream);
  Open;

  DoOnSaveStream(self, Stream);

  Stream.Seek(0, soFromBeginning);

  if BinaryStream then
    begin
      if XML.XMLTags.Count = 0 then
        begin
          q := XML.XMLTags.Add;
          q.Name := FMainTag;
        end;
      q := GetTag(CurrentActiveSection);
      if not Assigned(q) then q := XML.XMLTags[0].SubTags.Add;
      q.Name := CurrentActiveSection;

      DeleteKey(CurrentActiveSection, 'DATA');

      MS := TMemoryStream.Create;
      try
        Count := 0;
        q1 := nil;
        while Count * MaxXMLStringLength div 2 <= Stream.Size do
          begin
            MS.Clear;
            if Stream.Size < Stream.Position + MaxXMLStringLength div 2 then
              MS.CopyFrom(Stream, Stream.Size - Stream.Position)
            else
              MS.CopyFrom(Stream, MaxXMLStringLength div 2);
          MS.Seek(0, soFromBeginning);
          st := q.SubTags.Add;
            st.Name := 'DATA';
            st.Attribute['Type']:='Binary';
            st.Attribute['Item']:=IntToStr(Count);
            st.Text := GetHexText(MS);
            if Count = 0 then q1 := st;
            Count := Count + 1;
          end;
      finally
        FreeAndNil(MS);
      end;
      if Assigned(q1) then q1.Attribute['Count']:=IntToStr(Count);
    end
  else
    begin
      if XML.XMLTags.Count = 0 then
        begin
          q := XML.XMLTags.Add;
          q.Name := FMainTag;
          if AutoUpdate then Update;
        end;

      q := GetTag(CurrentActiveSection);
      if not Assigned(q) then q := XML.XMLTags[0].SubTags.Add;
      q.Name := CurrentActiveSection;

      Reader := TReader.Create(Stream, 4096);
      try
        Reader.ReadListBegin;
        while not Reader.EndOfList do
          begin
            ConvertComponent(q);
          end;
        Reader.ReadListEnd;
      finally
        Reader.Free;
      end;
    end;
  Close;
end;

{------------------------------------------------------------------------------}

procedure TLMDStorCustomXMLVault.Load(Stream: TMemoryStream);
var
  q, m: TLMDStorXMLTag;
  i, j, Count: integer;
  Writer: TXMLCrackWriter;
  MS: TMemoryStream;
  Text: string;
begin
  if not FileExists(DataFile) then exit;
  FIsLoading := true;
  Open;
  m := nil;
  if BinaryStream then
    begin
      for i := 0 to XML.XMLTags.Count - 1 do
        if XML.XMLTags.Items[i].Name = FMainTag then
          begin
            m := XML.XMLTags.Items[i];
            break;
          end;
      if not Assigned(m) then raise
        Exception.create('Data not be found!');

      q := GetTag(CurrentActiveSection);
      if not Assigned(q) then raise
        Exception.create('Data not be found!');

      Count := 0;
      for i := 0 to q.SubTags.Count - 1 do
        if ((q.SubTags.Items[i].Name = 'DATA') and
          (GetItemAttr(q.SubTags.Items[i].Attributes) = 0)) then
          begin
            Count := GetCount(q.SubTags.Items[i].Attributes);
            break;
          end;

      MS := TMemoryStream.Create;
      try
        for i := 0 to Count - 1 do
          for j := 0 to q.SubTags.Count - 1 do
            if ((q.SubTags[j].Name = 'DATA')
              and (GetItemAttr(q.SubTags[j].Attributes) = i)
              and (GetTypeAttr(q.SubTags[j].Attributes) = 'Binary')) then
              begin
                Text := q.SubTags.Items[j].Text;
                MS.Clear;
                MS.SetSize(Length(Text) div 2);
                HexToBin(PChar(Text), PChar(Integer(MS.Memory)), Length(Text) div 2);
                Stream.CopyFrom(MS, Length(Text) div 2);
              end;
      finally
        FreeAndNil(MS);
      end;
    end else
    begin
      Writer := TXMLCrackWriter.Create(Stream, 4096);
      try
        Writer.WriteListBegin;

        m := nil;
        for i := 0 to XML.XMLTags.Count - 1 do
          if XML.XMLTags.Items[i].Name = FMainTag then
            begin
              m := XML.XMLTags.Items[i];
              break;
            end;

        if Assigned(m) then begin
          q := GetTag(CurrentActiveSection);
          if Assigned(q) then begin
            for i := 0 to q.SubTags.Count - 1 do
              if GetTypeAttr(q.SubTags.Items[i].Attributes) = 'Component' then
                LoadComponent(q.SubTags[i], Writer);

          end;
          Writer.WriteListEnd;
        end;
      finally
        Writer.Free;
      end;
    end;
  DoOnLoadStream(self, Stream);
  inherited Load(Stream);
  FIsLoading := false;  
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.Open;
var
  TS: TStrings;
  i: integer;
  FS: TFileStream;
  MS, Stream: TMemoryStream;
begin
  try
    if Parsed then exit;
    DoOnBeforeOpen(self);

    TS := TStringList.Create;
    try
      if FileExists(DataFile) then
      begin
        if BinaryState then
        begin
          FS := TFileStream.Create(DataFile, fmOpenRead);
          MS := TMemoryStream.Create;
          Stream := TMemoryStream.Create;
          try
            FS.Seek(0, soFromBeginning);
            MS.CopyFrom(FS, FS.Size);

            if CompressedStream then
            begin
              MS.Seek(0, soFromBeginning);
              Stream.CopyFrom(MS, MS.Size);
              MS.Clear;
              Stream.Seek(0, soFromBeginning);
              LMDStorLoadCompressedStream(Stream, MS);
            end;

            if Assigned(FStorageCryptor) and (MS.Size > 0) and Encrypted then
              FStorageCryptor.Decrypt(MS);
            MS.Seek(0, soFromBeginning);
            TS.LoadFromStream(MS);
          finally
            FreeAndNil(MS);
            FreeAndNil(FS);
            FreeAndNil(Stream);
          end;
        end
        else
          TS.LoadFromFile(DataFile);
      end;
    finally
      XML.Parse(TS.Text);
      FreeAndNil(TS);
    end;

    Parsed := True;

    Sections.Clear;
    if XML.XMLTags.Count > 0 then
      for i := 0 to XML.XMLTags[0].SubTags.Count - 1 do
        Sections.Add(XML.XMLTags[0].SubTags[i].Name);
    DoOnAfterOpen(self);
  except
    if FileExists(DataFile) then
      SysUtils.DeleteFile(DataFile);
    raise;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.Close;
var
  lCanUpdate: boolean;
begin
  DoOnBeforeClose(self);
  lCanUpdate := true;
  DoOnUpdateBeforeCloseEvent(Self, lCanUpdate);
  if lCanUpdate then
    Update;
  XML.Clear;
  Parsed := False;
  DoOnAfterClose(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.Update;
var
  TS: TStrings;
  FS: TFileStream;
  Stream, MS: TMemoryStream;
begin
  if BinaryState then
  begin
    TS := TStringList.Create;
    FS := TFileStream.Create(DataFile, fmCreate);
    Stream := TMemoryStream.Create;
    try
      XML.SaveToStrings(TS);
      TS.SaveToStream(Stream);

      if Encrypted and Assigned(FStorageCryptor) then FStorageCryptor.Encrypt(Stream);

      if CompressedStream then
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
      Stream.Seek(0, soFromBeginning);
      FS.CopyFrom(Stream, Stream.Size);
    finally
      FreeAndNil(TS);
      FreeAndNil(FS);
      FreeAndNil(Stream);
    end;
  end
  else
   XML.SaveToFile(DataFile);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.Delete;
var
  i: integer;
begin
  if FileExists(DataFile) then SysUtils.DeleteFile(DataFile);  // VB restore when remove windows from uses
  for i := 0 to Sections.Count - 1 do
   DoOnSectionDelete(self, Sections[i]);
  Sections.Clear;
  XML.Clear;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.KeyExists(const Key: string;
  Section: string = ''): Boolean;
var
  i: integer;
  q: TLMDStorXMLTag;
  TS: string;
begin
  Open;
  Result := false;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if Assigned(q) then for i := 0 to q.SubTags.Count - 1 do
      if q.SubTags[i].Name = Key then
        begin
          Result := True;
          break;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.ReadKeys(Strings: TStrings;
  Section: string = '');
var
  TS, Attr: string;
  q: TLMDStorXMLTag;
  i, j: integer;
begin
  Open;
  if not Assigned(Strings) then exit;
  Strings.Clear;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if Assigned(q) then for i := 0 to q.SubTags.Count - 1 do
      begin
        Attr := '';
        for j := 0 to q.SubTags[i].Attributes.Count - 1 do
          Attr := Attr + q.SubTags[i].Attributes[j] + ' ';
        Attr := Trim(Attr);
        if Attr <> '' then Attr := ' ' + Attr;
        Strings.Add(q.SubTags[i].Name + Attr + '=' + q.SubTags[i].Text);
      end;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.KeyCount(Section: string = ''): Integer;
var
  TS: string;
  q: TLMDStorXMLTag;
begin
  Result := 0;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if Assigned(q) then Result := q.SubTags.Count;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.SectionExists(const Section: string): Boolean;
var
  i: integer;
begin
  Result := false;
  Open;
  if XML.XMLTags.Count = 0 then exit;
  for i := 0 to XML.XMLTags[0].SubTags.Count - 1 do
    if XML.XMLTags[0].SubTags[i].Name = Section then
      begin
        Result := True;
        break;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.AddSection(const Section: string);
var
  q: TLMDStorXMLTag;
begin
  Open;
  if SectionExists(Section) then exit;
  if XML.XMLTags.Count = 0 then
    begin
      q := XML.XMLTags.Add;
      q.Name := FMainTag;
    end;
  q := XML.XMLTags[0].SubTags.Add;
  q.Name := Section;
  Sections.Add(Section);
  DoOnSectionAdd(self, Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.RenameSection(const OldName, NewName: string):
  Boolean;
var
  g: TLMDStorXMLTag;
begin
  Result := False;
  Open;
  if not SectionExists(OldName) then exit;
  g := GetTag(oldName);
  g.Name := NewName;
  Sections[Sections.IndexOf(OldName)] := NewName;  
  if AutoUpdate then Update;
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.RemoveSection(const Section: string): Boolean;
var
  g: TLMDStorXMLTag;
begin
  Result := False;
  Open;
  if not SectionExists(Section) then exit;
  g := GetTag(Section);
  if not Assigned(g) then exit;
  g.Free;
  if AutoUpdate then Update;
  Result := True;
  Sections.Delete(Sections.IndexOf(Section));
  DoOnSectionDelete(self, Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.DeleteSection(const Section: string): Boolean;
begin
  Result := RemoveSection(Section);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ClearSection(const Section: string): Boolean;
var
  g: TLMDStorXMLTag;
  TS: String;
begin
  Result := False;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  if not SectionExists(TS) then exit;
  g := GetTag(TS);
  if not Assigned(g) then exit;
  g.SubTags.Clear;
  if AutoUpdate then Update;
  Result := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.DeleteKey(const Section, Ident: string);
var
  q: TLMDStorXMLTag;
  i: integer;
  TS: String;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  i := 0;
  if Assigned(q) then while i < q.SubTags.Count do
      if q.SubTags[i].Name = Ident then q.SubTags[i].Free else i := i + 1;
  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.DeleteKeyEx(const Section, Ident,
  Attribute: string);
var
  q: TLMDStorXMLTag;
  i: integer;

  function ExistAttribute(Attributes: TStrings): Boolean;
  var
    i: integer;
  begin
    Result := False;
    for i := 0 to Attributes.Count - 1 do
      if DelChar(Attributes[i], '"') = DelChar(Attribute, '"') then
        begin
          Result := True;
          break;
        end;
  end;

begin
  Open;
  q := GetTag(Section);
  i := 0;
  if Assigned(q) then while i < q.SubTags.Count do
      if (q.SubTags[i].Name = Ident) and ExistAttribute(q.SubTags[i].Attributes) then
        q.SubTags[i].Free
      else
        i := i + 1;
  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteBool(const Section, Ident: string;
  Value: Boolean);
var
  BS: String;
begin
  if Value then BS := '-1' else BS := '0';
  WriteSimpleProperty(Section, Ident, 'Identifier', BS);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadBool(const Section,
  Ident: string; Default: Boolean): Boolean;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Identifier' then Result := PropValue = '-1';
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteColor(const Section, Ident: string;
  Value: TColor);
begin
  WriteSimpleProperty(Section, Ident, 'Color', ColorToString(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadColor(const Section, Ident: string;
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
procedure TLMDStorCustomXMLVault.WriteComponent(const Instance: TComponent;
  const Section: string = '');
var
  q, n: TLMDStorXMLTag;
  MS: TMemoryStream;
  Writer: TLMDOSWriter;
  TS: string;
  CustomRoot : TComponent;
begin
  if not Assigned(Instance) then exit;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if XML.XMLTags.Count = 0 then
    begin
      n := XML.XMLTags.Add;
      n.Name := FMainTag;
    end;
  if not Assigned(q) then q := XML.XMLTags[0].SubTags.Add;
  q.Name := TS;

  DeleteKeyEx(TS, Instance.Name, 'Type="Component"');

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

  SaveObject(MS, TS, 'Component');
  FreeAndNil(MS);

  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadComponent(const Section: string;
  Instance: TComponent): TComponent;
var
  q: TLMDStorXMLTag;
  i: integer;
  Writer: TXMLCrackWriter;
  TS: string;
  MS: TMemoryStream;
  Reader: TLMDOSReader;
  CustomRoot : TComponent;
begin
  Open;

  Result := nil;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if Assigned(q) then for i := 0 to q.SubTags.Count - 1 do
      if ((trim(q.SubTags[i].Name) = trim(Instance.Name)) and
        (trim(GetTypeAttr(q.SubTags[i].Attributes)) = 'Component')) then
        begin

          MS := TMemoryStream.Create;
          Writer := TXMLCrackWriter.Create(MS, 4096);
          try
            Writer.WriteListBegin;
            LoadComponent(q.SubTags[i], Writer);
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
procedure TLMDStorCustomXMLVault.WriteDate(const Section, Ident: string;
  Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'Date', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadDate(const Section, Ident: string;
  Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Date' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteDateTime(const Section, Ident: string;
  Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'DateTime', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadDateTime(const Section, Ident: string;
  Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'DateTime' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteFloat(const Section, Ident: string;
  Value: Double);
var
  lVal: string;
begin
  lVal := FloatToStr(Value);
  if NormalizeSeparators then
    lVal := Normalize(lVal);
  WriteSimpleProperty(Section, Ident, 'Float', lVal);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadFloat(const Section, Ident: string;
  Default: Double): Double;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if NormalizeSeparators then
    PropValue := LMDAnsiReplaceChar(PropValue, '.', {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator);
  if PropType = 'Float' then Result := StrToFloat(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteObject(const Section, Ident: string;
  Instance: TPersistent);
begin
  WriteEssence(Section, Ident, 'Object', Instance);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadObject(const Section, Ident: string;
  Instance: TPersistent): TPersistent;
begin
  Result := ReadEssence(Section, Ident, 'Object', Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteFont(const Section, Ident: string;
  Instance: TFont);
begin
  WriteEssence(Section, Ident, 'Font', Instance);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadFont(const Section, Ident: string;
  Instance: TFont): TFont;
begin
  Result := Instance;
  ReadEssence(Section, Ident, 'Font', Instance);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteInteger(const Section, Ident: string;
  Value: LongInt);
begin
  WriteSimpleProperty(Section, Ident, 'Integer',
   IntToStr(EncryptInteger(Value)));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadInteger(const Section, Ident: string;
  Default: LongInt): LongInt;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Integer' then Result := DecryptInteger(StrToInt(PropValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteInt64(const Section, Ident: string;
  Value: Int64);
begin
  WriteSimpleProperty(Section, Ident, 'Int64', IntToStr(EncryptInteger(Value)));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadInt64(const Section, Ident: string;
  Default: Int64): Int64;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Int64' then Result := DecryptInteger(StrToInt64(PropValue));
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WritePoint(const Section, Ident: string;
  Value: TPoint);
begin
  WriteSimpleProperty(Section, Ident, 'Point',
    IntToStr(Value.X) + '.' + IntToStr(Value.Y));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadPoint(const Section, Ident: string;
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
procedure TLMDStorCustomXMLVault.WriteRect(const Section, Ident: string;
  Value: TRect);
begin
  WriteSimpleProperty(Section, Ident, 'Rect',
    IntToStr(Value.Left) + '.' + IntToStr(Value.Top) + '.' +
    IntToStr(Value.Right) + '.' + IntToStr(Value.Bottom));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadRect(const Section, Ident: string;
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
procedure TLMDStorCustomXMLVault.WriteString(const Section, Ident: string;
  Value: string);
begin
  WriteSimpleProperty(Section, Ident, 'String', EncryptString(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadString(const Section, Ident: string;
  Default: string): string;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'String' then Result := DecryptString(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteStrings(const Section, Ident: string;
 Value: TStrings);
var
  q, n, g, r: TLMDStorXMLTag;
  i, L, Count: integer;
  S, TS: String;
begin
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if XML.XMLTags.Count = 0 then
    begin
      n := XML.XMLTags.Add;
      n.Name := FMainTag;
    end;
  if not Assigned(q) then q := XML.XMLTags[0].SubTags.Add;

  q.Name := TS;

  DeleteKeyEx(Section, Ident, 'Type="Strings"');

  n := q.SubTags.Add;
  n.Name := Ident;
  n.Attribute['Type']:='Strings';
  n.Attribute['Count']:=IntToStr(Value.Count);  

  for i := 0 to Value.Count - 1 do
    begin
      S := Value[i];
      L := Length(S);
      if L > 512 then
        begin
          g := n.SubTags.Add;
          g.Name := 'String';
          g.Attribute['Item']:=IntToStr(i);
          Count := 0;
          while Count * MaxXMLStringLength div 2 <=
            Length(S) do
            begin
              if Length(S) < ((Count + 1) * MaxXMLStringLength div 2) then
                begin
                  r := g.SubTags.Add;
                  r.Name := 'SubString';
                  r.Attribute['Item']:=IntToStr(Count);
                  r.Text := Copy(S, Count * MaxXMLStringLength div 2,
                    Length(S) - Count * MaxXMLStringLength div 2 + 1);
                end else
                begin
                  r := g.SubTags.Add;
                  r.Name := 'SubString';
                  r.Attribute['Item']:=IntToStr(Count);
                  r.Text := Copy(S, Count * MaxXMLStringLength div 2,
                    MaxXMLStringLength div 2);
                end;
              Count := Count + 1;
            end;
          g.Attribute['Count']:=IntToStr(Count);            
        end
      else
        begin
          g := n.SubTags.Add;
          g.Name := 'String';
          g.Text := S;
          g.Attribute['Item']:=IntToStr(i);
        end;
    end;

  if AutoUpdate then Update;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.ReadStrings(const Section, Ident: string;
 Value: TStrings);
var
  i, j, n, f, k, count: integer;
  q, s, d: TLMDStorXMLTag;
  TS: string;
begin
  Value.Clear;
  Open;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  Count := 0;
  s := nil;
  if Assigned(q) then for i := 0 to q.SubTags.Count - 1 do
      if (trim(q.SubTags[i].Name) = trim(Ident)) and
       (GetTypeAttr(q.SubTags[i].Attributes) = 'Strings') then
        begin
          s := q.SubTags[i];
          Count := GetCount(s.Attributes);
          break;
        end;
  if Assigned(s) then
    for i := 0 to Count - 1 do
     for j := 0 to s.SubTags.Count - 1 do
      if GetItemAttr(s.SubTags[j].Attributes) = i then
        begin
          n := GetCount(s.SubTags[j].Attributes);
          if n = 0 then Value.Add(s.SubTags[j].Text) else
            begin
              d := s.SubTags[j];
              for f := 0 to n - 1 do
               for k := 0 to d.SubTags.Count - 1 do
                if (GetItemAttr(d.SubTags[k].Attributes) = f) and
                 (d.SubTags[k].Name = 'SubString') then
                  TS := TS + d.SubTags[k].Text;
              Value.Add(TS);
            end;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.WriteTime(const Section, Ident: string;
 Value: TDateTime);
begin
  WriteSimpleProperty(Section, Ident, 'Time', DateTimeToStr(Value));
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.ReadTime(const Section, Ident: string;
 Default: TDateTime): TDateTime;
var
  PropType, PropValue: string;
begin
  Result := Default;
  ReadSimpleProperty(Section, Ident, PropType, PropValue);
  if PropType = 'Time' then Result := StrToDateTime(PropValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.ReadSection (const Section: String; Strings:
 TStrings);
var
  i: integer;
  TS: String;
  q: TLMDStorXMLTag;
begin
  Open;              
  Strings.Clear;
  if Section <> '' then TS := Section else TS := CurrentActiveSection;
  q := GetTag(TS);
  if Assigned(q) then for i := 0 to q.SubTags.Count - 1 do
  Strings.Add(q.SubTags[i].Name);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorCustomXMLVault.ReadSections(Strings: TStrings);
var
  i: integer;
begin
  Open;
  Strings.Clear;
  if XML.XMLTags.Count = 0 then exit;
  for i := 0 to XML.XMLTags[0].SubTags.Count - 1 do
   Strings.Add(XML.XMLTags[0].SubTags[i].Name);
end;

{------------------------------------------------------------------------------}
function TLMDStorCustomXMLVault.Normalize(v: string): string;
var
  i: integer;
begin
  result := v;
  result := LMDAnsiReplaceChar(result, {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, '.');
  for i := length(result) downto 1 do
    if result[i] = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator then System.Delete(result, i, 1);
end;

end.
