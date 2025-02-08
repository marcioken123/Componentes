unit LMDMemoryMappedStream;

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

LMDMemoryMappedStream unit - implement the named shared memory (AIH)
-----------------------------------
Description
LMDMemoryMappedStream unit - implement the named shared memory using
descendant of TStream.
The difference from all other TStream descendants: the Size is fixed value
determined in constructor.

ToDo
----

Changes
-------

Release 1.0 (March 2008)
* Initial Release

###############################################################################}

interface
uses
  Classes, LMDTypes, Windows;

type
  {************************* TLMDMemoryMappedStream ***************************}
  TLMDMemoryMappedStream = class(TMemoryStream)
  private
    FMemory: Pointer;
    FPosition: Longint;
    FSize: Longint;
    FHandle: THandle;
  public
    constructor Create(AName: TLMDString; ASize: Longint);
    destructor Destroy(); override;
    function Write(const ABuffer;  ACount: Longint): Longint; {$ifdef LMDCOMP12}override;{$else}  {$endif} {$IFDEF LMDCOMP7}{$IFNDEF LMDCOMP12}override;{$ENDIF}{$ENDIF}
    function Read(var ABuffer ;  ACount: Longint): Longint; {$ifdef LMDCOMP12}override;{$else}{$endif} {$IFDEF LMDCOMP7}{$IFNDEF LMDCOMP12}override;{$ENDIF}{$ENDIF}

    function Seek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64; override;
    property Memory: Pointer read FMemory write FMemory;
    property Position: Longint read FPosition write FPosition;
    procedure SetSize(NewSize: Longint); override;
  end;

implementation

uses SysUtils, Dialogs ;

{*************************** TLMDMemoryMappedStream ***************************}
{---------------------------------- public ------------------------------------}
constructor TLMDMemoryMappedStream.Create(AName: TLMDString; ASize: Longint);

begin
  inherited Create;
  {$IFNDEF LMD_UNICODE}
    FHandle := CreateFileMappingA(INVALID_HANDLE_VALUE, nil,
      PAGE_READWRITE or SEC_NOCACHE or SEC_COMMIT, 0, ASize, PChar(AName));
  {$ELSE}
    FHandle := CreateFileMappingW(INVALID_HANDLE_VALUE, nil,
      PAGE_READWRITE or SEC_NOCACHE or SEC_COMMIT, 0, ASize, PWChar(AName));
    {$ENDIF}

  if GetLastError = ERROR_ALREADY_EXISTS then
    {$IFNDEF LMD_UNICODE}
      FHandle := OpenFileMappingA(FILE_MAP_ALL_ACCESS, false, PChar(AName));
      {$ELSE}
      FHandle := OpenFileMappingW(FILE_MAP_ALL_ACCESS, false, PWChar(AName));
      {$ENDIF}
  if FHandle = 0 then
    Raise Exception.Create('Couldn''t create mapped file');
  FMemory := MapViewOfFile(FHandle, FILE_MAP_ALL_ACCESS, 0, 0, ASize);
  if not Assigned(FMemory) then
    Raise Exception.Create('Couldn''t map view of file');
  FPosition := 0;
  FSize := ASize;
end;

{------------------------------------------------------------------------------}
destructor TLMDMemoryMappedStream.Destroy();
begin
  if Assigned(FMemory) then
    UnmapViewOfFile(FMemory);
  CloseHandle(FHandle);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDMemoryMappedStream.Write(const ABuffer;  ACount: Longint): Longint;
var
  i: Integer;
begin
  Result := 0;
  if ACount <= 0 then
    exit;
  i := FPosition + ACount;
  if FSize < i then
    Raise EOutOfMemory.Create('Couldn''t increase mapped files size');
    System.Move(ABuffer, Pointer(TLMDPtrInt(FMemory) + FPosition)^, ACount);
  FPosition := i;
  Result := ACount;
end;

{------------------------------------------------------------------------------}
function TLMDMemoryMappedStream.Seek(const AOffset: Int64; AOrigin: TSeekOrigin): Int64;
begin
  case AOrigin of
    soBeginning: FPosition := AOffset;
    soCurrent: Inc(FPosition, AOffset);
    soEnd: FPosition := FSize - AOffset;
  end;
  if FPosition > FSize then
    FPosition := FSize
  else
    if FPosition < 0 then FPosition := 0;
  Result := FPosition;
end;

{------------------------------------------------------------------------------}
function TLMDMemoryMappedStream.Read(var ABuffer;  ACount: Longint): Longint;
begin
  Result := 0;
  if ACount <= 0 then
    exit;
  Result := FSize - FPosition;
  if Result > 0 then
  begin
    if Result > ACount then
      Result := ACount;
    System.Move(Pointer(TLMDPtrInt(FMemory) + FPosition)^, ABuffer, ACount);
    Inc(FPosition, Result);
  end;
end;

procedure TLMDMemoryMappedStream.SetSize(NewSize: Longint);
begin
end;

end.
