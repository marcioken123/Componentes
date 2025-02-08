unit LMDDBFReader;
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

LMDDBFReader unit (VO)
----------------------

Read DBF table description

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, SysUtils, Controls;

type
  TLMDDBFFieldType = (ftChar, ftNumber, ftBoolean, ftMemo, ftDate, ftFloat, ftPattern);

  { ******************************* TLMDDBFFieldDef ************************** }
  TLMDDBFFieldDef = class(TCollectionItem)
  private
    FFieldName : string;
    FFieldType : TLMDDBFFieldType;
    FFieldOffset : LongInt;
    FFieldSize : word;
  public
    constructor Create(Collection: TCollection); override;
    procedure Load(aStream: TStream);
    procedure Save(aStream: TStream);
    property FieldName : string read FFieldName write FFieldName;
    property FieldType : TLMDDBFFieldType read FFieldType write FFieldType;
    property FieldOffset : LongInt read FFieldOffset write FFieldOffset;
    property FieldSize : word read FFieldSize write FFieldSize;
  end;

  { ******************************* TLMDDBFFieldDefs ************************* }
  TLMDDBFFieldDefs = class(TCollection)
  private
    function GetItem(Index : LongInt) : TLMDDBFFieldDef;
  public
    constructor Create;
    function Add : TLMDDBFFieldDef;
    property Item[index : LongInt] : TLMDDBFFieldDef read GetItem ; default;
  end;

  { ******************************* TLMDDBFHeader *************************** }
  TLMDDBFHeader = class
  private
    FVersion            : byte;
    FModified           : TDate;
    FRecordCount        : LongInt;
    FFirstRecordOffset  : word;
    FRecordSize         : word;
    FCDXPresent         : boolean;
    FFieldDefs          : TLMDDBFFieldDefs;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Load(aStream: TStream);
    procedure Save(aStream: TStream);
    property Version : byte read FVersion write FVersion;
    property Modified : TDate read FModified write FModified;
    property RecordCount : LongInt read FRecordCount write FRecordCount;
    property FirstRecordOffset : word read FFirstRecordOffset write FFirstRecordOffset;
    property RecordSize : word read FRecordSize write FRecordSize;
    property CDXPresent : boolean read FCDXPresent write FCDXPresent;
    property FieldDefs : TLMDDBFFieldDefs read FFieldDefs;
  end;

  { ******************************* TLMDDBF ********************************** }
  TLMDDBF = class
  private
    FStream : TStream;
    FHeader : TLMDDBFHeader;
    FRecord : LongInt;
  public
    constructor Create(aStream : TStream);
    destructor Destroy; override;
    function Eof : boolean;
    function Bof : boolean;
    procedure MoveFirst;
    procedure MoveLast;
    procedure MoveNext;
    procedure MovePrev;
    procedure ReadField(FieldNo : LongInt; var Buffer; Count: Longint);
    function ReadFieldAsString(FieldNo : LongInt) : string;
    property Header : TLMDDBFHeader read FHeader;
  end;

implementation

{ ********************************* TLMDDBFFieldDef ************************** }
{---------------------------------- PUBLIC ------------------------------------}

constructor TLMDDBFFieldDef.Create(Collection: TCollection);
begin
  inherited;
  FFieldName := 'Field';
  FFieldType := ftChar;
  FFieldOffset := 0;
  FFieldSize := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFFieldDef.Load(aStream: TStream);
var
  tmpChar : char;
  begin
  SetString(FFieldName, nil, 11);
  aStream.ReadBuffer(PChar(FFieldName)^, 11);
  aStream.ReadBuffer(tmpChar, 1);
  case tmpChar of
   'C' : FFieldType := ftChar;
   'N' : FFieldType := ftNumber;
   'L' : FFieldType := ftBoolean;
   'M' : FFieldType := ftMemo;
   'D' : FFieldType := ftDate;
   'F' : FFieldType := ftFloat;
   'P' : FFieldType := ftPattern;
  end;

  aStream.Position := aStream.Position + 4;
  FFieldOffset := 0;
  aStream.ReadBuffer(FFieldSize, 2);
  aStream.Position := aStream.Position + 14;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFFieldDef.Save(aStream: TStream);
var
  tmpChar : char;
  I  : LongInt;
  tmpByte : byte;
  tmpStr : string;
  begin
  SetString(tmpStr, nil, 11);
  tmpStr := copy(FFieldName, 1, Length(FFieldName));
  aStream.WriteBuffer(PChar(tmpStr)^,11);
  case FFieldType of
    ftChar : tmpChar := 'C';
    ftNumber : tmpChar := 'N';
    ftBoolean : tmpChar := 'L';
    ftMemo : tmpChar := 'M';
    ftDate : tmpChar := 'D';
    ftFloat : tmpChar := 'F';
    ftPattern : tmpChar := 'P';
  else
    tmpChar := 'C';
  end;
  aStream.WriteBuffer(tmpChar, 1);
  tmpByte := 0;
  for I := 12 to 15 do
    aStream.WriteBuffer(tmpByte, 1);
  aStream.WriteBuffer(FFieldSize, 2);
  for I := 18 to 31 do
    aStream.WriteBuffer(tmpByte, 1);
end;

{ ********************************* TLMDDBFFieldDefs ************************* }
{------------------------------------------------------------------------------}

function TLMDDBFFieldDefs.GetItem(Index : LongInt) : TLMDDBFFieldDef;
begin
  result := TLMDDBFFieldDef(inherited GetItem(Index));
end;

{---------------------------------- PUBLIC ------------------------------------}

constructor TLMDDBFFieldDefs.Create;
begin
  inherited Create(TLMDDBFFieldDef);
end;

{------------------------------------------------------------------------------}

function TLMDDBFFieldDefs.Add : TLMDDBFFieldDef;
begin
  result := TLMDDBFFieldDef(inherited Add);
end;

{ ********************************* TLMDDBFHeader **************************** }
{---------------------------------- PUBLIC ------------------------------------}

constructor TLMDDBFHeader.Create;
begin
  inherited Create;
  FFieldDefs := TLMDDBFFieldDefs.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDDBFHeader.Destroy;
begin
  FFieldDefs.Clear;
  FFieldDefs.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFHeader.Load(aStream: TStream);
var
  tmpByte               : byte;
  lYear, lMonth,  lDay  : word;
  tmpPosition           : LongInt;
  tmpOffset             : LongInt;
  tmpFieldDef           : TLMDDBFFieldDef;
begin
  aStream.Position := 0;

  if (aStream.Size > 32) then
    begin
      aStream.ReadBuffer(FVersion, 1);

      aStream.ReadBuffer(tmpByte, 1);
      lYear := tmpByte+1900;

      aStream.ReadBuffer(tmpByte, 1);
      lMonth := tmpByte;

      aStream.ReadBuffer(tmpByte, 1);
      lDay := tmpByte;

      FModified := EncodeDate(lYear, lMonth, lDay);

      aStream.ReadBuffer(FRecordCount, 4);

      aStream.ReadBuffer(FFirstRecordOffset, 2);

      aStream.ReadBuffer(FRecordSize, 2);

      aStream.Position := 28;

      aStream.ReadBuffer(tmpByte, 1);
      FCDXPresent := boolean(tmpByte);
    end;
  if ((aStream.Size > FFirstRecordOffset) and (FFirstRecordOffset <> 0)) then
    begin
      tmpPosition := 32;
      aStream.ReadBuffer(tmpByte, 1);
      tmpOffset := 1;
      while ((aStream.Position < aStream.Size) and (tmpByte <> 13)) do
        begin
          aStream.Position := tmpPosition;
          tmpFieldDef := FFieldDefs.Add;
          tmpFieldDef.Load(aStream);
          tmpFieldDef.FieldOffset := tmpOffset;
          tmpOffset := tmpOffset + tmpFieldDef.FieldSize;
          tmpPosition := aStream.Position;
          aStream.ReadBuffer(tmpByte, 1);
        end;
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBFHeader.Save(aStream: TStream);
var
  tmpByte : byte;
  tmpYear,  tmpMonth, tmpDay : word;
  I : LongInt;
begin
  aStream.Position := 0;
  aStream.WriteBuffer(FVersion, 1);

  DecodeDate(FModified, tmpYear, tmpMonth, tmpDay);
  tmpByte := tmpYear - 1900;
  aStream.WriteBuffer(tmpByte, 1);
  tmpByte := tmpMonth;
  aStream.WriteBuffer(tmpByte, 1);
  tmpByte := tmpDay;
  aStream.WriteBuffer(tmpByte, 1);
  aStream.WriteBuffer(FRecordCount, 4);
  aStream.WriteBuffer(FFirstRecordOffset, 2);
  aStream.WriteBuffer(FRecordSize, 2);
  tmpByte := 0;
  for I := 12 to 27 do
    aStream.WriteBuffer(tmpByte, 1);
  aStream.WriteBuffer(tmpByte, 1);
  for I := 29 to 31 do
    aStream.WriteBuffer(tmpByte, 1);
  for I := 0 to FFieldDefs.Count-1 do
    FFieldDefs[I].Save(aStream);
  tmpByte := 13;
  aStream.WriteBuffer(tmpByte, 1);
end;

{ ******************************* TLMDDBF ************************************ }
{------------------------------------------------------------------------------}
{---------------------------------- PUBLIC ------------------------------------}

constructor TLMDDBF.Create(aStream : TStream);
begin
  inherited Create;
  FStream := aStream;
  FHeader := TLMDDBFHeader.Create;
  FHeader.Load(FStream);
  MoveFirst;
end;

{------------------------------------------------------------------------------}

destructor TLMDDBF.Destroy;
begin
  FHeader.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

function TLMDDBF.Eof : boolean;
begin
  result := (FRecord = FHeader.RecordCount);
end;

{------------------------------------------------------------------------------}

function TLMDDBF.Bof : boolean;
begin
  result := (FRecord = 0);
end;

{------------------------------------------------------------------------------}

procedure TLMDDBF.MoveFirst;
begin
  FRecord := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBF.MoveLast;
begin
  FRecord := FHeader.RecordCount;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBF.MoveNext;
begin
  if (FRecord < FHeader.RecordCount) then Inc(FRecord);
end;

{------------------------------------------------------------------------------}

procedure TLMDDBF.MovePrev;
begin
  if FRecord > 0 then Dec(FRecord);
end;

{------------------------------------------------------------------------------}

procedure TLMDDBF.ReadField(FieldNo : LongInt; var Buffer; Count: Longint);

var
  tmpOffset : LongInt;
begin
  tmpOffset := FHeader.FFirstRecordOffset +
    FRecord*FHeader.RecordSize + FHeader.FieldDefs[FieldNo].FieldOffset;
  if FStream.Size < (tmpOffset + FHeader.FieldDefs[FieldNo].FFieldSize) then
    exit;
  FStream.Seek(tmpOffset, soFromBeginning);
  FStream.ReadBuffer(Buffer, Count);
end;

{------------------------------------------------------------------------------}

function TLMDDBF.ReadFieldAsString(FieldNo : LongInt) : string;
var
  tmpOffset : LongInt;
  tmpDateRec : record
    dYear : word;
    dMonth : byte;
    dDay : byte;
  end;
  tmpByte : byte;
  tmpStr    : string;
  begin
  result := '';
  tmpOffset := FHeader.FFirstRecordOffset +
    FRecord*FHeader.RecordSize + FHeader.FieldDefs[FieldNo].FieldOffset;
  if FStream.Size < (tmpOffset + FHeader.FieldDefs[FieldNo].FFieldSize) then
    exit;
  FStream.Seek(tmpOffset, soFromBeginning);
  case FHeader.FieldDefs[FieldNo].FFieldType of
    ftChar, ftNumber :
      begin
        SetString(tmpStr, nil, FHeader.FieldDefs[FieldNo].FieldSize+1);
        FStream.Read(PChar(tmpStr)^, FHeader.FieldDefs[FieldNo].FieldSize);
        result := Copy(tmpStr, 1, Length(tmpStr)-1);
        end;
    ftBoolean :
      begin
        FStream.Read(tmpByte,1);
        if tmpByte = 0 then
          result := 'False'
        else
          result := 'True';
      end;
    ftDate :
      begin
        FStream.Read(tmpDateRec, Sizeof(tmpDateRec));
        result := IntToStr(tmpDateRec.dDay)+'.'+IntToStr(tmpDateRec.dMonth)+'.'+IntToStr(tmpDateRec.dYear);
      end;
  end;
end;

end.
