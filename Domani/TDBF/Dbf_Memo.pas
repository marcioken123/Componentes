unit Dbf_Memo;

interface

{$I Dbf_Common.inc}

uses
  Classes,
  Dbf_PgFile,
  Dbf_Common;

type

//====================================================================
  TMemoFile = class(TPagedFile)
  protected
    FDbfVersion: xBaseVersion;
    FMemoRecordSize: Integer;
    FOpened: Boolean;
    FBuffer: PChar;
  protected
    function  GetBlockLen: Integer; virtual; abstract;
    function  GetMemoSize: Integer; virtual; abstract;
    function  GetNextFreeBlock: Integer; virtual; abstract;
    procedure SetNextFreeBlock(BlockNo: Integer); virtual; abstract;
    procedure SetBlockLen(BlockLen: Integer); virtual; abstract;
  public
    constructor Create(AFileName: string);
    destructor Destroy; override;

    procedure Open;
    procedure Close;

    procedure ReadMemo(BlockNo: Integer; DestStream: TStream);
    procedure WriteMemo(var BlockNo: Integer; ReadSize: Integer; Src: TStream);

    property DbfVersion: xBaseVersion read FDbfVersion write FDbfVersion;
    property MemoRecordSize: Integer read FMemoRecordSize write FMemoRecordSize;
  end;

  TFoxProMemoFile = class(TMemoFile)
  protected
    function  GetBlockLen: Integer; override;
    function  GetMemoSize: Integer; override;
    function  GetNextFreeBlock: Integer; override;
    procedure SetNextFreeBlock(BlockNo: Integer); override;
    procedure SetBlockLen(BlockLen: Integer); override;
  end;

  TDbaseMemoFile = class(TMemoFile)
  protected
    function  GetBlockLen: Integer; override;
    function  GetMemoSize: Integer; override;
    function  GetNextFreeBlock: Integer; override;
    procedure SetNextFreeBlock(BlockNo: Integer); override;
    procedure SetBlockLen(BlockLen: Integer); override;
  end;

  PInteger = ^Integer;

implementation

uses
  SysUtils;

//====================================================================
//=== Memo and binary fields support
//====================================================================
type

  PDbtHdr = ^rDbtHdr;
  rDbtHdr = record
    NextBlock : Longint;
    Dummy     : array [4..7] of Byte;
    DbfFile   : array [0..7] of Byte;   // 8..15
    bVer      : Byte;                   // 16
    Dummy2    : array [17..19] of Byte;
    BlockLen  : Word;                   // 20..21
    Dummy3    : array [22..511] of Byte;
  end;

  PFptHdr = ^rFptHdr;
  rFptHdr = record
    NextBlock : Longint;
    Dummy     : array [4..5] of Byte;
    BlockLen  : Word;                   // 20..21
    Dummy3    : array [8..511] of Byte;
  end;

  PBlockHdr = ^rBlockHdr;
  rBlockHdr = record
    MemoType  : Cardinal;
    MemoSize  : Cardinal;
  end;


//==========================================================
//============ Dbtfile
//==========================================================
constructor TMemoFile.Create(AFileName: string);
begin
  // init vars
  FBuffer := nil;
  FOpened := false;

  // call inherited
  inherited Create(AFileName);
end;

destructor TMemoFile.Destroy;
begin
  // close file
  Close;

  // call ancestor
  inherited;
end;

procedure TMemoFile.Open;
begin
  if not FOpened then
  begin
    // memo pages count start from begining of file!
    PageOffsetByHeader := false;

    // open physical file
    OpenFile;

    // read header
    HeaderSize := 512;

    // determine version
    if FDbfVersion = xBaseIII then
      PDbtHdr(Header).bVer := 3;
    VirtualLocks := false;

    if FileCreated or (HeaderSize = 0) then
    begin
      if (FMemoRecordSize = 0) or (FMemoRecordSize > HeaderSize) then
        SetNextFreeBlock(1)
      else
        SetNextFreeBlock(HeaderSize div FMemoRecordSize);
      SetBlockLen(FMemoRecordSize);
      WriteHeader;
    end;

    RecordSize := GetBlockLen;
    // checking for right blocksize not needed for foxpro?
    if FDbfVersion <> xFoxPro then
    begin
      // mod 128 <> 0 <-> and 0x7F <> 0
      if (RecordSize = 0) or ((RecordSize and $7F) <> 0) then
      begin
        SetBlockLen(512);
        RecordSize := 512;
        WriteHeader;
      end;
    end;

    // get memory for temporary buffer
    GetMem(FBuffer, RecordSize+2);
    FBuffer[RecordSize] := #0;
    FBuffer[RecordSize+1] := #0;

    // now open
    FOpened := true;
  end;
end;

procedure TMemoFile.Close;
begin
  if FOpened then
  begin
    // close physical file
    CloseFile;

    // free mem
    if FBuffer <> nil then
      FreeMemAndNil(Pointer(FBuffer));

    // now closed
    FOpened := false;
  end;
end;

procedure TMemoFile.ReadMemo(BlockNo: Integer; DestStream: TStream);
var
  bytesLeft,numBytes,dataStart: Integer;
  done: Boolean;
  lastc: char;
  endMemo: PChar;
begin
  // clear dest
  DestStream.Position := 0;
  DestStream.Size := 0;
  // no block to read?
  if (BlockNo<=0) or (RecordSize=0) then
    exit;
  // read first block
  if ReadRecord(BlockNo, @FBuffer[0]) = 0 then
  begin
    // EOF reached?
    exit;
  end;
  bytesLeft := GetMemoSize;
  // bytesLeft <> -1 -> memo size is known (FoxPro, dBase4)
  // bytesLeft =  -1 -> memo size unknown (dBase3)
  if bytesLeft <> -1 then
  begin
    dataStart := 8;
    while bytesLeft > 0 do
    begin
      // get number of bytes to be read
      numBytes := bytesLeft;
      // too much for this block?
      if numBytes > RecordSize - dataStart then
        numBytes := RecordSize - dataStart;
      // read block to stream
      DestStream.Write(FBuffer[dataStart], numBytes);
      // numBytes done
      dec(bytesLeft, numBytes);
      // still need to read bytes?
      if bytesLeft > 0 then
      begin
        // read next block
        inc(BlockNo);
        dataStart := 0;
        ReadRecord(BlockNo, @FBuffer[0]);
      end;
    end;
  end else begin
    // dbase III memo
    done := false;
    repeat
      // scan for EOF
      endMemo := MemScan(FBuffer, $1A, RecordSize);
      // EOF found?
      if endMemo <> nil then
      begin
        // really EOF?
        if (endMemo-FBuffer < RecordSize - 1) and ((endMemo[1] = #$1A) or (endMemo[1] = #0)) then
        begin
          // yes, EOF found
          done := true;
          numBytes := endMemo - FBuffer;
        end else begin
          // no, fake
          numBytes := RecordSize;
        end;
      end else begin
        numBytes := RecordSize;
      end;
      // write to stream
      DestStream.Write(FBuffer[0], numBytes);
{
      for i := 0 to RecordSize-2 do
      begin
        if (FBuffer[i]=#$1A) and (FBuffer[i+1]=#$1A) then
        begin
          if i>0 then
            DestStream.Write(FBuffer[0], i);
          done := true;
          break;
        end;
      end;
}
      if not done then
      begin
{
        DestStream.Write(FBuffer[0], 512);
}
        lastc := FBuffer[RecordSize-1];
        inc(BlockNo);
        if ReadRecord(BlockNo, @FBuffer[0]) > 0 then
        begin
          // check if immediate terminator at begin of block
          done := (lastc = #$1A) and ((FBuffer[0] = #$1A) or (FBuffer[0] = #0));
          // if so, written one character too much
          if done then
            DestStream.Size := DestStream.Size - 1;
        end else begin
          // error while reading, stop
          done := true;
        end;
      end;
    until done;
  end;
end;

procedure TMemoFile.WriteMemo(var BlockNo: Integer; ReadSize: Integer; Src: TStream);
var
  bytesBefore: Integer;
  bytesAfter: Integer;
  totsize: Integer;
  read: Integer;
  append: Boolean;
  tmpRecNo: Integer;
begin
  // if no data to write, then don't create new block
  if Src.Size = 0 then
  begin
    BlockNo := 0;
  end else begin
    if FDbfVersion >= xBaseIV then      // dBase4 or FoxPro type
    begin
      bytesBefore := SizeOf(rBlockHdr);
      bytesAfter := 0;
    end else begin                      // dBase3 type
      bytesBefore := 0;
      bytesAfter := 2;
    end;
//    if ((bytesBefore + Src.Size + bytesAfter + PDbtHdr(Header).BlockLen-1) div PDbtHdr(Header).BlockLen)
//        <= ((ReadSize + PDbtHdr(Header).BlockLen-1) div PDbtHdr(Header).BlockLen) then
    if ((bytesBefore + Src.Size + bytesAfter + RecordSize-1) div RecordSize)
        <= ((ReadSize + RecordSize-1) div RecordSize) then
    begin
      append := false;
    end else begin
      append := true;
      // modifying header -> lock memo header
      LockPage(0, true);
      BlockNo := GetNextFreeBlock;
      if BlockNo = 0 then
      begin
        SetNextFreeBlock(1);
        BlockNo := 1;
      end;
    end;
    tmpRecNo := BlockNo;
    Src.Position := 0;
    FillChar(FBuffer[0], RecordSize, ' ');
    if bytesBefore=8 then
    begin
      totsize := Src.Size + bytesBefore + bytesAfter;
      if FDbfVersion <> xFoxPro then
      begin
        PBlockHdr(FBuffer).MemoType := $0008FFFF;
        PBlockHdr(FBuffer).MemoSize := totsize;
      end else begin
        PBlockHdr(FBuffer).MemoType := $01000000;
        PBlockHdr(FBuffer).MemoSize := SwapInt(Src.Size);
      end;
    end;
    repeat
      // read bytes, don't overwrite header
      read := Src.Read(FBuffer[bytesBefore], RecordSize{PDbtHdr(Header).BlockLen}-bytesBefore);
      // end of input data reached ? check if need to write block terminators
      while (read < RecordSize - bytesBefore) and (bytesAfter > 0) do
      begin
        FBuffer[read] := #$1A;
        Inc(read);
        Dec(bytesAfter);
      end;
      // have we read anything that is to be written?
      if read > 0 then
      begin
        // clear any unused space
        FillChar(FBuffer[bytesBefore+read], RecordSize-read-bytesBefore, ' ');
        // write to disk
        WriteRecord(tmpRecNo, @FBuffer[0]);
        Inc(tmpRecNo);
      end else break;
      // first block read, second block can start at beginning
      bytesBefore := 0;
    until false;

    if append then
    begin
      SetNextFreeBlock(tmpRecNo);
      WriteHeader;
      UnlockPage(0);
    end;
  end;
end;

// ------------------------------------------------------------------
// dBase specific helper routines
// ------------------------------------------------------------------

function  TDbaseMemoFile.GetBlockLen: Integer;
begin
  // Can you tell me why the header of dbase3 memo contains 1024 and is 512 ?
  // answer: it is not a valid field in memo db3 header
  if FDbfVersion = xBaseIII then
    Result := 512
  else
    Result := PDbtHdr(Header).BlockLen;
end;

function  TDbaseMemoFile.GetMemoSize: Integer;
begin
  // dBase4 memofiles contain small 'header'
  if PInteger(@FBuffer[0])^ = $0008FFFF then
    Result := PBlockHdr(FBuffer).MemoSize-8
  else
    Result := -1;
end;

function  TDbaseMemoFile.GetNextFreeBlock: Integer;
begin
  Result := PDbtHdr(Header).NextBlock;
end;

procedure TDbaseMemoFile.SetNextFreeBlock(BlockNo: Integer);
begin
  PDbtHdr(Header).NextBlock := BlockNo;
end;

procedure TDbaseMemoFile.SetBlockLen(BlockLen: Integer);
begin
  PDbtHdr(Header).BlockLen := BlockLen;
end;

// ------------------------------------------------------------------
// FoxPro specific helper routines
// ------------------------------------------------------------------

function  TFoxProMemoFile.GetBlockLen: Integer;
begin
  Result := Swap(PFptHdr(Header).BlockLen);
end;

function  TFoxProMemoFile.GetMemoSize: Integer;
begin
  Result := SwapInt(PBlockHdr(FBuffer).MemoSize);
end;

function  TFoxProMemoFile.GetNextFreeBlock: Integer;
begin
  Result := SwapInt(PFptHdr(Header).NextBlock);
end;

procedure TFoxProMemoFile.SetNextFreeBlock(BlockNo: Integer);
begin
  PFptHdr(Header).NextBlock := SwapInt(BlockNo);
end;

procedure TFoxProMemoFile.SetBlockLen(BlockLen: Integer);
begin
  PFptHdr(Header).BlockLen := Swap(BlockLen);
end;



end.
