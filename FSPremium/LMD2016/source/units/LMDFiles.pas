unit LMDFiles;
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

LMDFiles unit (YB)
---------------------------
String routines

Changes
-------
Release 8.0 (December 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, SysUtils, Types, LMDRTLConst, LMDTypes, LMDProcs;

type
  TLMDFileStream = class(THandleStream)
  public
    constructor Create(const FileName: TLMDString; Mode: Word); overload;
    constructor Create(const FileName: TLMDString; Mode: Word; Rights: Cardinal); overload;
    destructor Destroy; override;
  end;

function LMDFileOpen(const FileName: TLMDString; Mode: LongWord): THandle;
function LMDFileCreate(const FileName: TLMDString): THandle;
function LMDReadBOMEx(const AStream: TStream; var ABomLen: Integer; ARestorePos: Boolean = False): TLMDBOM;
function LMDReadBOM(const AStream: TStream; ARestorePos: Boolean = False): TLMDBOM;
procedure LMDWriteBOM(const AStream: TStream; const ABOM: TLMDBOM);
function LMDFileAge(const FileName: TLMDString): Integer;
function LMDFileExists(const FileName: TLMDString): Boolean;

implementation

const
  CUTF32BE: array[0..3] of byte = ($00, $00, $FE, $FF);
  CUTF32LE: array[0..3] of byte = ($FF, $FE, $00, $00);
  CUTF16BE: array[0..1] of byte = ($FE, $FF);
  CUTF16LE: array[0..1] of byte = ($FF, $FE);
  CUTF8: array[0..2] of byte = ($EF, $BB, $BF);
  CUTF7: array[0..2] of byte = ($2B, $2F, $76);
  CMaxLen = 4;

constructor TLMDFileStream.Create(const FileName: TLMDString; Mode: Word);
begin
  Create(Filename, Mode, 0);
end;

constructor TLMDFileStream.Create(const FileName: TLMDString; Mode: Word;
  Rights: Cardinal);
begin
  if (Mode and fmCreate) = fmCreate then
  begin
    inherited Create(LMDFileCreate(FileName));
    {$ifdef LMDCOMP12}
    if Handle = INVALID_HANDLE_VALUE then
    {$else}
    if Handle < 0 then
    {$endif}
      raise EFCreateError.CreateResFmt(@SLMDFCreateError, [FileName]);
  end
  else
  begin
    inherited Create(LMDFileOpen(FileName, Mode));
    {$ifdef LMDCOMP12}
    if Handle = INVALID_HANDLE_VALUE then
    {$else}
    if Handle < 0 then
    {$endif}
      raise EFOpenError.CreateResFmt(@SLMDFOpenError, [FileName]);
  end;
end;

destructor TLMDFileStream.Destroy;
begin
  {$ifdef LMDCOMP12}
  if Handle <> INVALID_HANDLE_VALUE then
  {$else}
  if Handle >= 0 then
  {$endif}
    FileClose(Handle);
  inherited;
end;

function LMDFileOpen(const FileName: TLMDString; Mode: LongWord): THandle;
const
  AccessMode: array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
begin
  Result := INVALID_HANDLE_VALUE;
  if ((Mode and 3) <= fmOpenReadWrite) and (((Mode and $F0) shr 4) <= fmShareDenyNone) then
  {$IFDEF LMD_UNICODE}
    Result := CreateFileW(PWideChar(FileName), AccessMode[Mode and 3],
      ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  {$ELSE}
    Result := Windows.CreateFile(PChar(FileName), AccessMode[Mode and 3],
      ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  {$ENDIF}
end;

function LMDFileCreate(const FileName: TLMDString): THandle;
begin
  {$IFDEF LMD_UNICODE}
  Result := CreateFileW(PWideChar(FileName), GENERIC_READ or GENERIC_WRITE, 0,
    nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  {$ELSE}
  Result := Windows.CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0,
    nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  {$ENDIF}
end;

function LMDReadBOMEx(const AStream: TStream; var ABomLen: Integer; ARestorePos: Boolean = False): TLMDBOM;
var
  LBuf: array[0..CMaxLen - 1] of byte;
begin
  Result := bomNone;
  ABomLen := 0;
  if Assigned(AStream) then
  begin
    AStream.Read(LBuf, Length(LBuf));
    if CompareMem(@LBuf, @CUTF32BE, Length(CUTF32BE)) then
    begin
      Result := bomUTF32BE;
      ABomLen := Length(CUTF32BE);
    end;
    if CompareMem(@LBuf, @CUTF32LE, Length(CUTF32LE)) then
    begin
      Result := bomUTF32LE;
      ABomLen := Length(CUTF32LE);
    end;
    if CompareMem(@LBuf, @CUTF16BE, Length(CUTF16BE)) then
    begin
      Result := bomUTF16BE;
      ABomLen := Length(CUTF16BE);
    end;
    if CompareMem(@LBuf, @CUTF16LE, Length(CUTF16LE)) then
    begin
      Result := bomUTF16LE;
      ABomLen := Length(CUTF16LE);
    end;
    if CompareMem(@LBuf, @CUTF8, Length(CUTF8)) then
    begin
      Result := bomUTF8;
      ABomLen := Length(CUTF8);
    end;
    if CompareMem(@LBuf, @CUTF7, Length(CUTF7)) then
    begin
      Result := bomUTF7;
      ABomLen := Length(CUTF7);
    end;
    AStream.Seek(-(Length(LBuf) - ABomLen), soFromCurrent);
    if ARestorePos or (Result = bomNone) or (Result = bomUTF7) then
      AStream.Seek(-ABomLen, soFromCurrent);
  end;
end;

function LMDReadBOM(const AStream: TStream; ARestorePos: Boolean = False): TLMDBOM;
var
  LLen: Integer;
begin
  Result := LMDReadBOMEx(AStream, LLen, ARestorePos);
end;

procedure LMDWriteBOM(const AStream: TStream; const ABOM: TLMDBOM);
begin
  if Assigned(AStream) then
  begin
    case ABOM of
      bomUTF32BE:
        AStream.Write(CUTF32BE, Length(CUTF32BE));
      bomUTF32LE:
        AStream.Write(CUTF32LE, Length(CUTF32LE));
      bomUTF16BE:
        AStream.Write(CUTF16BE, Length(CUTF16BE));
      bomUTF16LE:
        AStream.Write(CUTF16LE, Length(CUTF16LE));
      bomUTF8:
        AStream.Write(CUTF8, Length(CUTF8));
      bomUTF7: ;
        // Nothing to do here.
    end;
  end;
end;

function LMDFileAge(const FileName: TLMDString): Integer;
var
  Handle: THandle;
  {$ifdef LMD_UNICODE}
  FindData: TWin32FindDataW;
  {$else}
  FindData: TWin32FindData;
  {$endif}
  LocalFileTime: TFileTime;
begin
  {$ifdef LMD_UNICODE}
  Handle := Windows.FindFirstFileW(PWideChar(FileName), FindData);
  {$else}
  Handle := Windows.FindFirstFile(PChar(FileName), FindData);
  {$endif}
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(Handle);
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFileTime);
      if FileTimeToDosDateTime(LocalFileTime, LongRec(Result).Hi,
        LongRec(Result).Lo) then Exit;
    end;
  end;
  Result := -1;
end;

function LMDFileExists(const FileName: TLMDString): Boolean;
begin
  Result := LMDFileAge(FileName) <> -1;
end;

end.
