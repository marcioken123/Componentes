unit LMDMapFile;
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

LMDMapFile unit (EN, AH)
--------------------------
Translate address of exception to unit and line number of source code

ToDo
----

Changes
-------
Release 8.0 (Mart 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Windows, Classes,
  LMDProcs, LMDZLib, LMDRTLConst;

type
  TLMDMapUnit = record
    StartAddr: LongWord;
    Length: LongWord;
    NameIndex: Integer;
    LineNumberBegin: Integer;
    LineNumberEnd: Integer;
  end;

  TLMDMapProc = record
    Addr: LongWord;
    ClassNameIndex: Integer;
    NameIndex: Integer;
  end;

  TLMDMapLine = record
    Addr: LongWord;
    Number: LongWord;
  end;

{ ********************************* TLMDMapFile ****************************** }
  TLMDMapFile = class (TObject)
  private
    FMapLines: array of TLMDMapLine;
    FMapNames: array of String;
    FMapProcs: array of TLMDMapProc;
    FMapUnits: array of TLMDMapUnit;

    FBuffer: TStringList;
    FBufferIndex: Integer;

    constructor Create;
    function FindSegmentBegin(ASegmentName: String; AReset: boolean = true): Boolean;
    function LineIndex(const AAddress: LongWord): Integer;
    function LoadParsedInfo: Boolean;
    function MapFileName: string;
    function MapNameIndex(AName: String): LongWord;
    function ParseAddress(var ALine: String; AStopString: String; var AAddress:
            LongWord; APrefix: char = '$'): Boolean;
    function ParseLineNumbers(var ALine: String; var AType, AStartAddress:
            LongWord; var ALineNumber: LongWord): Boolean;
    function ParseMapFile: Boolean;
    function ParseProcedure(ALine: String; var AType, AStartAddress: LongWord;
            var AProcedureName: String): Boolean;
    procedure ParseProcName(AMapName: String; var AClassName, AProcName:
            String);
    function ParseUnit(ALine: String; var AType, AStartAddress, ALength:
            LongWord; var AUnitName: String): Boolean;
    function ProcedureIndex(const AAddress: LongWord): Integer;
    function SaveParsedInfo: Boolean;
    function UnitIndex(const AAddress: LongWord): Integer;
    procedure SkipBlankLines;
  public
    destructor Destroy; override;
    class function Instance: TLMDMapFile;
    function LineExists(const AAddress: LongWord): Boolean;
    function LineNumber(const AAddress: LongWord): string;
    function LineNumberAsInt(const AAddress: LongWord): Integer;
    function MapFileAddress(const AAddress: Pointer): LongWord;
    function ProcedureExists(const AAddress: LongWord): Boolean;
    function ProcedureName(const AAddress: LongWord): string;
    function UnitExists(const AAddress: LongWord): Boolean;
    function UnitName(const AAddress: LongWord): string;
  end;

implementation
var
  FInstance: TLMDMapFile;

{ ********************************* TLMDMapFile ****************************** }
constructor TLMDMapFile.Create;
begin
  FBuffer := TStringList.Create;
  if ParseMapFile then
    SaveParsedInfo
  else
    LoadParsedInfo;
end;

destructor TLMDMapFile.Destroy;
begin
  FreeAndNil(FBuffer);
  if FInstance = Self then
    FInstance := nil;
  inherited Destroy;
end;

function TLMDMapFile.FindSegmentBegin(ASegmentName: String; AReset: boolean = true): Boolean;
var
  LString: string;
begin
  Result := false;
  if AReset then
    FBufferIndex := 0;
  while FBufferIndex < FBuffer.Count  do
  begin
    LString := FBuffer.Strings[FBufferIndex];
    Inc(FBufferIndex);
    if Pos(ASegmentName, LString) > 0 then
    begin
      SkipBlankLines;
      Result := true;
      break;
    end;
  end;
end;

class function TLMDMapFile.Instance: TLMDMapFile;
begin
  if not Assigned(FInstance) then
    FInstance := TLMDMapFile.Create;
  Result := FInstance;
end;

function TLMDMapFile.LineExists(const AAddress: LongWord): Boolean;
begin
  result := LineIndex(AAddress) > -1;
end;

function TLMDMapFile.LineIndex(const AAddress: LongWord): Integer;
var
  LUnitIndex, i: Integer;
begin
  result := -1;
  LUnitIndex := UnitIndex(AAddress);
  if (LUnitIndex > -1) and  (FMapUnits[LUnitIndex].LineNumberEnd > -1) then
    for i := FMapUnits[LUnitIndex].LineNumberEnd downto FMapUnits[LUnitIndex].LineNumberBegin do
      if FMapLines[i].Addr <= AAddress then
      begin
        result := i;
        break;
      end;
end;

function TLMDMapFile.LineNumberAsInt(const AAddress: LongWord): Integer;
var
  LLineIndex: Integer;
begin
  LLineIndex := LineIndex(AAddress);
  if LLineIndex > -1 then
    result := FMapLines[LLineIndex].Number
  else
    result := -1;
end;

function TLMDMapFile.LineNumber(const AAddress: LongWord): string;
begin
  Result := Format('%d', [LineNumberAsInt(AAddress)]);
end;

function TLMDMapFile.LoadParsedInfo: Boolean;
var
  i, j: Integer;
  LFileName: string;
  LLength, LSize: LongWord;
  LStrLength: byte;
  LStream: TStream;
  LMemStream: TLMDDecompressionStream;
begin
  LStream := nil;
  Result := False;
  if FindResource(HInstance, PChar('LMDDATA'), RT_RCDATA) <> 0 then
  begin
    LStream := TResourceStream.Create(HInstance, PChar('LMDDATA'), RT_RCDATA);
  end
  else
  begin
    LFileName := ChangeFileExt(ParamStr(0), '.lmdmap');
    if not FileExists(LFileName) then
      LStream := TFileStream.Create(LFileName, fmOpenRead);
  end;

  // Map information doesn't exist
  if LStream = nil then
    exit;

  LMemStream := TLMDDecompressionStream.Create(LStream);
  try
    LMemStream.Read(LLength, 4);
    SetLength(FMapUnits, LLength);
    LSize :=  SizeOf(TLMDMapUnit);
    for i := 0 to LLength - 1 do
      LMemStream.Read(FMapUnits[i], LSize);

    LMemStream.Read(LLength, 4);
    SetLength(FMapProcs, LLength);
    LSize :=  SizeOf(TLMDMapProc);
    for i := 0 to LLength - 1 do
      LMemStream.Read(FMapProcs[i], LSize);

    LMemStream.Read(LLength, 4);
    SetLength(FMapLines, LLength);
    LSize :=  SizeOf(TLMDMapLine);
    for i := 0 to LLength - 1 do
      LMemStream.Read(FMapLines[i], LSize);

    LMemStream.Read(LLength, 4);
    SetLength(FMapNames, LLength);
    for i:=0 to LLength - 1 do
    begin
      LMemStream.Read(LStrLength, 1);
      SetLength(FMapNames[i], LStrLength);
      for j := 1 to LStrLength do
        LMemStream.Read(FMapNames[i][j], 1);
    end;
  finally
    LStream.Free;
    LMemStream.Free;
  end;
  result := true;
end;

function TLMDMapFile.MapFileAddress(const AAddress: Pointer): LongWord;

  const
    CodeBase = $1000;

begin
  result := LongWord(AAddress) - GetModuleHandle(nil) - CodeBase;
end;

function TLMDMapFile.MapFileName: string;
begin
  result := ChangeFileExt(ParamStr(0), '.map');
end;

function TLMDMapFile.MapNameIndex(AName: String): LongWord;
var
  i: Integer;
begin
  for i:=0 to Length(FMapNames) - 1 do
    if FMapNames[i]=AName then
      break;
  if i >= Length(FMapNames) then
  begin
    SetLength(FMapNames, Length(FMapNames) + 1);
    FMapNames[Length(FMapNames) - 1] := AName;
    result := Length(FMapNames) - 1;
  end
  else
    result := i;
end;

function TLMDMapFile.ParseAddress(var ALine: String; AStopString: String; var
        AAddress: LongWord; APrefix: char = '$'): Boolean;
var
  LPos: Integer;
  LInteger: Integer;
begin
  result := false;
  LPos := Pos(AStopString, ALine);
  if (LPos > 0) and TryStrToInt(APrefix+Trim(Copy(ALine, 1, LPos - 1)), LInteger) then
  begin
    AAddress := LInteger;
    Delete(ALine, 1, LPos + Length(AStopString) - 1);
    result := true;
  end;
end;

function TLMDMapFile.ParseLineNumbers(var ALine: String; var AType,
        AStartAddress: LongWord; var ALineNumber: LongWord): Boolean;
var
  LInteger: Integer;
begin
  result := false;
  ALine := Trim(ALine);
  if ParseAddress(ALine, ' ', ALineNumber, '0') then
    if ParseAddress(ALine, ':', AType) then
      if ParseAddress(ALine, ' ', AStartAddress) then
        result := true
      else
        if TryStrToInt('$' + ALine, LInteger) then
        begin
          AStartAddress := LInteger;
          ALine := '';
          result := true;
        end;
end;

function TLMDMapFile.ParseMapFile: Boolean;
const
  LengthInc = 100;
  SegmentNameUnits = 'Detailed map of segments';
  SegmentNameProcs = 'Publics by Value';
  SegmentNameLines = 'Line numbers for ';

var
  LLine, LUnitName, LProcedureName, LClassName: String;
  LType, LStartAddress, LLineNumber, LLength: LongWord;
  i, LUnitIndex: integer;

begin
  if not FileExists(MapFileName) then
  begin
    result := false;
    Exit;
  end;

  FBuffer.LoadFromFile(MapFileName);

  if FindSegmentBegin(SegmentNameUnits) then
  begin
    i := 0;
    SetLength(FMapUnits, 0);
    while FBufferIndex < FBuffer.Count do
    begin
      LLine := FBuffer.Strings[FBufferIndex];
      if LLine = '' then
        break;
      if ParseUnit(LLine, LType, LStartAddress, LLength, LUnitName) and (LType = 1) then
      begin
        if i >= Length(FMapUnits) then
          SetLength(FMapUnits, Length(FMapUnits) + LengthInc);
        FMapUnits[i].StartAddr := LStartAddress;
        FMapUnits[i].Length := LLength;
        FMapUnits[i].NameIndex := MapNameIndex(LUnitName);
        FMapUnits[i].LineNumberBegin := -1;
        FMapUnits[i].LineNumberEnd := -1;
        Inc(i);
      end;
      Inc(FBufferIndex);
    end;
    SetLength(FMapUnits, i);
  end;

  if FindSegmentBegin(SegmentNameProcs) then
  begin
    i := 0;
    SetLength(FMapProcs, 0);
    while FBufferIndex < FBuffer.Count do
    begin
      LLine := FBuffer.Strings[FBufferIndex];
      if LLine = '' then
        break;
      if ParseProcedure(LLine, LType, LStartAddress, LProcedureName) and (LType = 1) then
      begin
        if i >= Length(FMapProcs) then
          SetLength(FMapProcs, Length(FMapProcs) + LengthInc);
        FMapProcs[i].Addr := LStartAddress;
        ParseProcName(LProcedureName, LClassName, LProcedureName);
        if LClassName='' then
          FMapProcs[i].ClassNameIndex := -1
        else
          FMapProcs[i].ClassNameIndex := MapNameIndex(LClassName);
        FMapProcs[i].NameIndex := MapNameIndex(LProcedureName);
        Inc(i);
      end;
      Inc(FBufferIndex);
    end;
    SetLength(FMapProcs, i);
  end;

  i := 0;

  SetLength(FMapLines, 0);
  for LUnitIndex := 0 to Length(FMapUnits) - 1 do
  begin
    LUnitName := FMapNames[FMapUnits[LUnitIndex].NameIndex];
    if FindSegmentBegin(SegmentNameLines + LUnitName) then
    begin
      FMapUnits[LUnitIndex].LineNumberBegin := i;
      while FBufferIndex < FBuffer.Count do
      begin
        LLine := FBuffer.Strings[FBufferIndex];
        if LLine = '' then
          break;
        while LLine <> '' do
        begin
          if ParseLineNumbers(LLine, LType, LStartAddress, LLineNumber) and
             (LType = 1) then
          begin
            if i >= Length(FMapLines) then
              SetLength(FMapLines, Length(FMapLines) + LengthInc);
            FMapLines[i].Addr := LStartAddress;
            FMapLines[i].Number := LLineNumber;
            Inc(i);
          end;
        end;
        FMapUnits[LUnitIndex].LineNumberEnd := i - 1;
        Inc(FBufferIndex);
      end;
    end;
  end;
  SetLength(FMapLines, i);
  Result := true;
end;

function TLMDMapFile.ParseProcedure(ALine: String; var AType, AStartAddress:
        LongWord; var AProcedureName: String): Boolean;
begin
  result := false;
  if ParseAddress(ALine, ':', AType) then
    if ParseAddress(ALine, ' ', AStartAddress) then
    begin
      AProcedureName := Trim(ALine);
      result := true;
    end;
end;

procedure TLMDMapFile.ParseProcName(AMapName: String; var AClassName,
        AProcName: String);
var
  LPos: Integer;
begin
  LPos := Pos('.',AMapName);
  if LPos > 0 then
  begin
    AClassName := Copy(AMapName, 1, LPos - 1);
    AProcName := Copy(AMapName, LPos + 1, Length(AMapName));
  end
  else
  begin
    AClassName := '';
    AProcName := AMapName;
  end;
end;

function TLMDMapFile.ParseUnit(ALine: String; var AType, AStartAddress,
        ALength: LongWord; var AUnitName: String): Boolean;
var
  LPos: Integer;
begin
  result := false;
  if ParseAddress(ALine, ':', AType) then
    if ParseAddress(ALine, ' ', AStartAddress) then
      if ParseAddress(ALine, ' ', ALength) then
      begin
        LPos := Pos('M=', ALine);
        if LPos > 0 then
        begin
          Delete(ALine, 1 ,LPos + 1);
          AUnitName := Copy(ALine, 1, Pos(' ', ALine) - 1);
          result := true;
        end;
      end;
end;

function TLMDMapFile.ProcedureExists(const AAddress: LongWord): Boolean;
begin
  result := ProcedureIndex(AAddress) > -1;
end;

function TLMDMapFile.ProcedureIndex(const AAddress: LongWord): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := Length(FMapProcs) - 1 downto 0 do
    if (FMapProcs[i].Addr <= AAddress) then
    begin
      result := i;
      break;
    end;
end;

function TLMDMapFile.ProcedureName(const AAddress: LongWord): string;
var
  LProcIndex: Integer;
begin
  LProcIndex := ProcedureIndex(AAddress);
  if LProcIndex > -1 then
  begin
    if FMapProcs[LProcIndex].ClassNameIndex > -1 then
      result := FMapNames[FMapProcs[LProcIndex].ClassNameIndex] + '.' +
                FMapNames[FMapProcs[LProcIndex].NameIndex]
    else
      result := FMapNames[FMapProcs[LProcIndex].NameIndex]
  end
  else
    result := SUnableToFind;
end;

function TLMDMapFile.SaveParsedInfo: Boolean;
var
  i, j: Integer;
  FileName: string;
  LSize, LLength: LongWord;
  LStrLength: Byte;
  LStream: TFileStream;
  LMemStream: TLMDCompressionStream;
begin
  Result := true;
  try
    FileName := ChangeFileExt(ParamStr(0), '.lmdmap');
    LStream := TFileStream.Create(FileName, fmCreate);
    LMemStream := TLMDCompressionStream.Create(clDefault, LStream);
    try
      LLength := Length(FMapUnits);
      LSize :=  SizeOf(TLMDMapUnit);
      LMemStream.Write(LLength, 4);
      for i := 0 to LLength - 1 do
        LMemStream.Write(FMapUnits[i], LSize);

      LLength := Length(FMapProcs);
      LSize :=  SizeOf(TLMDMapProc);
      LMemStream.Write(LLength, 4);
      for i := 0 to LLength - 1 do
        LMemStream.Write(FMapProcs[i], LSize);

      LLength := Length(FMapLines);
      LSize :=  SizeOf(TLMDMapLine);
      LMemStream.Write(LLength, 4);
      for i := 0 to LLength - 1 do
        LMemStream.Write(FMapLines[i], LSize);

      LLength := Length(FMapNames);
      LMemStream.Write(LLength, 4);
      for i:=0 to LLength - 1 do
      begin
        LStrLength := Length(FMapNames[i]);
        LMemStream.Write(LStrLength, 1);
        for j := 1 to LStrLength do
          LMemStream.Write(FMapNames[i][j], 1);
      end;
    finally
      LMemStream.Free;
      LStream.Free;
    end;
  except
    Result := false;
  end;
end;

function TLMDMapFile.UnitExists(const AAddress: LongWord): Boolean;
begin
  Result := UnitIndex(AAddress) > -1;
end;

function TLMDMapFile.UnitIndex(const AAddress: LongWord): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to Length(FMapUnits) - 1 do
    if (AAddress >= FMapUnits[i].StartAddr) and
       (AAddress <= FMapUnits[i].StartAddr + FMapUnits[i].Length) then
    begin
      result := i;
      break;
    end;
end;

function TLMDMapFile.UnitName(const AAddress: LongWord): string;
var
  LUnitIndex: Integer;
begin
  LUnitIndex := UnitIndex(AAddress);
  if LUnitIndex > -1 then
    result := FMapNames[FMapUnits[LUnitIndex].NameIndex]
  else
    result := SUnableToFind;
end;

procedure TLMDMapFile.SkipBlankLines;
begin
  while FBufferIndex < FBuffer.Count do
    if FBuffer.Strings[FBufferIndex] = '' then
      Inc(FBufferIndex)
    else
      Break;
end;

begin
  FInstance := nil;

end.
