unit LMDZLib;
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

LMDZLib unit - ZLib interface (AH)
----------------------------------
TStream successors for compress/decompress content of streams

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, LMDTypes, LMDRTLConst;

type
  TLMDCustomZlibStream = class(TStream)
  private
    FStrm: TStream;
    FStrmPos: Integer;
    FOnProgress: TNotifyEvent;
    FZRec: Pointer;
    FBuffer: array [Word] of AnsiChar;
  protected
    procedure Progress(Sender: TObject); dynamic;
    property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;
  public
    constructor Create(Strm: TStream);
    destructor Destroy; override;
  end;

  TLMDCompressionLevel = (clNone, clFastest, clDefault, clMax);

  TLMDCompressionStream = class(TLMDCustomZlibStream)
  private
    function GetCompressionRate: Single;
  public
    constructor Create(CompressionLevel: TLMDCompressionLevel; Dest: TStream);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    property CompressionRate: Single read GetCompressionRate;
    property OnProgress;
  end;

  TLMDDecompressionStream = class(TLMDCustomZlibStream)
  public
    constructor Create(Source: TStream);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    property OnProgress;
  end;

implementation

uses
  SysUtils, LMDZCommonUnit, LMDZCompressUnit, LMDZUncompressUnit;

{******************* Object TLMDCustomZlibStream ******************************}
{----------------------- public -----------------------------------------------}
constructor TLMDCustomZlibStream.Create(Strm: TStream);
var
  zrec: PZStreamRec;
begin
  inherited Create;
  FStrm := Strm;
  FStrmPos := Strm.Position;

  New(zrec);
  zrec.zalloc := zlibAllocMem;
  zrec.zfree  := zlibFreeMem;
  FZRec       := zrec;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomZlibStream.Destroy;
var
  zrec: PZStreamRec;
begin
  zrec := FZRec;
  Dispose(zrec);
  inherited;
end;

procedure TLMDCustomZlibStream.Progress(Sender: TObject);
begin
  if Assigned(FOnProgress) then FOnProgress(Sender);
end;

{******************* Object TLMDCompressionStream *****************************}
{----------------------- public -----------------------------------------------}
constructor TLMDCompressionStream.Create(CompressionLevel: TLMDCompressionLevel;
  Dest: TStream);
const
  Levels: array [TLMDCompressionLevel] of ShortInt =
    (Z_NO_COMPRESSION, Z_BEST_SPEED, Z_DEFAULT_COMPRESSION, Z_BEST_COMPRESSION);
begin
  inherited Create(Dest);
  PZStreamRec(FZRec).next_out := FBuffer;
  PZStreamRec(FZRec).avail_out := Length(FBuffer);
  CCheck(deflateInit_(PZStreamRec(FZRec)^, Levels[CompressionLevel], zlib_version, sizeof(PZStreamRec(FZRec)^)));
end;

{------------------------------------------------------------------------------}
destructor TLMDCompressionStream.Destroy;
begin
  PZStreamRec(FZRec).next_in := nil;
  PZStreamRec(FZRec).avail_in := 0;
  try
    if FStrm.Position <> FStrmPos then
      FStrm.Position := FStrmPos;
    while (CCheck(deflate(PZStreamRec(FZRec)^, Z_FINISH)) <> Z_STREAM_END) and (PZStreamRec(FZRec).avail_out = 0) do
      begin
        FStrm.WriteBuffer(FBuffer, Length(FBuffer));
        PZStreamRec(FZRec).next_out := FBuffer;
        PZStreamRec(FZRec).avail_out := Length(FBuffer);
      end;
    if PZStreamRec(FZRec).avail_out < Length(FBuffer) then
      FStrm.WriteBuffer(FBuffer, Length(FBuffer) - PZStreamRec(FZRec).avail_out);
  finally
    deflateEnd(PZStreamRec(FZRec)^);
  end;
  inherited Destroy;
end;

function TLMDCompressionStream.Read(var Buffer; Count: Longint): Longint;

begin
  raise Exception.Create(SZLibInvalidStreamOp);
end;

function TLMDCompressionStream.Write(const Buffer; Count: Longint): Longint;

begin
  PZStreamRec(FZRec).next_in := @Buffer;
  PZStreamRec(FZRec).avail_in := Count;
  if FStrm.Position <> FStrmPos then
    FStrm.Position := FStrmPos;
  while (PZStreamRec(FZRec).avail_in > 0) do
    begin
      CCheck(deflate(PZStreamRec(FZRec)^, 0));
      if PZStreamRec(FZRec).avail_out = 0 then
        begin
          FStrm.WriteBuffer(FBuffer, Length(FBuffer));
          PZStreamRec(FZRec).next_out := FBuffer;
          PZStreamRec(FZRec).avail_out := Length(FBuffer);
          FStrmPos := FStrm.Position;
          Progress(Self);
        end;
    end;
  Result := Count;
end;

{------------------------------------------------------------------------------}

function TLMDCompressionStream.Seek(Offset: Longint; Origin: Word): Longint;

begin
  if (Offset = 0) and (Origin = soFromCurrent) then
    Result := PZStreamRec(FZRec).total_in
  else
    raise Exception.Create(SZLibInvalidStreamOp);
end;

{------------------------------------------------------------------------------}
function TLMDCompressionStream.GetCompressionRate: Single;
begin
  if PZStreamRec(FZRec).total_in = 0 then
    Result := 0
  else
    Result := (1.0 - (PZStreamRec(FZRec).total_out / PZStreamRec(FZRec).total_in)) * 100.0;
end;

{******************* Object TLMDDecompressionStream ***************************}
{----------------------- public -----------------------------------------------}
constructor TLMDDecompressionStream.Create(Source: TStream);
begin
  inherited Create(Source);
  PZStreamRec(FZRec).next_in := FBuffer;
  PZStreamRec(FZRec).avail_in := 0;
  CCheck(inflateInit_(PZStreamRec(FZRec)^, zlib_version, sizeof(PZStreamRec(FZRec)^)));
end;

{------------------------------------------------------------------------------}
destructor TLMDDecompressionStream.Destroy;
begin
  FStrm.Seek(-PZStreamRec(FZRec).avail_in, soFromCurrent);
  inflateEnd(PZStreamRec(FZRec)^);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

function TLMDDecompressionStream.Read(var Buffer; Count: Longint): Longint;

begin
  PZStreamRec(FZRec).next_out := @Buffer;
  PZStreamRec(FZRec).avail_out := Count;
  if FStrm.Position <> FStrmPos then FStrm.Position := FStrmPos;
  while (PZStreamRec(FZRec).avail_out > 0) do
    begin
      if PZStreamRec(FZRec).avail_in = 0 then
        begin
          PZStreamRec(FZRec).avail_in := FStrm.Read(FBuffer, Length(FBuffer));
          if PZStreamRec(FZRec).avail_in = 0 then
            begin
              Result := Count - PZStreamRec(FZRec).avail_out;
              Exit;
            end;
          PZStreamRec(FZRec).next_in := FBuffer;
          FStrmPos := FStrm.Position;
          Progress(Self);
        end;
      CCheck(inflate(PZStreamRec(FZRec)^, 0));
    end;
  Result := Count;
end;

{------------------------------------------------------------------------------}

function TLMDDecompressionStream.Write(const Buffer; Count: Longint): Longint;

begin
  raise Exception.Create(SZLibInvalidStreamOp);
end;

{------------------------------------------------------------------------------}

function TLMDDecompressionStream.Seek(Offset: Longint; Origin: Word): Longint;

var
  I: Integer;
  LOffset: Integer;
  Buf: array [0..4095] of Char;
  begin
  if (Offset = 0) and (Origin = soFromBeginning) then
    begin
      CCheck(inflateReset(PZStreamRec(FZRec)^));
      PZStreamRec(FZRec).next_in := FBuffer;
      PZStreamRec(FZRec).avail_in := 0;
      FStrm.Position := 0;
      FStrmPos := 0;
    end
  else if ( (Offset >= 0) and (Origin = soFromCurrent)) or
          ( ((Offset - PZStreamRec(FZRec).total_out) > 0) and (Origin = soFromBeginning)) then
    begin
      LOffset := Offset;
      if Origin = soFromBeginning then
        Dec(LOffset, PZStreamRec(FZRec).total_out);
      if LOffset > 0 then
      begin
        for I := 1 to LOffset div Length(Buf) do
          ReadBuffer(Buf, Length(Buf));
        ReadBuffer(Buf, LOffset mod Length(Buf));
      end;
    end
  else
    raise Exception.Create(SZLibInvalidStreamOp);
  Result := PZStreamRec(FZRec).total_out;
end;

end.
