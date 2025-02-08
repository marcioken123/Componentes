unit ElCRC32;

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

ElCRC32 unit
------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
    Types,
    Consts;

function CRC32(crc : longint; const c : byte) : longint;

function CRCBuffer(InitialCRC : longint; Buffer : Pointer; BufLen : integer) : Longint;

function CRCStr(Str : string) : longint;

implementation

const
  CRC32_POLYNOMIAL = $EDB88320;

var
  Ccitt32Table : array[0..255] of longint;

function CRCBuffer(InitialCRC : longint; Buffer : Pointer; BufLen : integer) : Longint;
var
  c, i : integer;
  P : PByte;
begin
  c := InitialCRC;
  P := PByte(Buffer);
  for i := 0 to BufLen -1 do    { Iterate }
  begin
    c := crc32(c, P^);
    //P := PChar(j);
    Inc(P);
  end;    { for }
  result := c;
end;

function CrcStr(Str : string) : longint;
var
  i, l, c : integer;
begin
  l := length(Str);
  c := 0;
  for i := 1 to l do
    c := crc32(c, byte(str[i]));
  result := c;
end;

function crc32(crc : longint; const c : byte) : longint;
begin
  crc32 := (((crc shr 8) and $00FFFFFF) xor (Ccitt32Table[(crc xor c) and $FF]));
end;

{$R-}
procedure BuildCRCTable;
var
  i, j, value : DWORD;
begin
  for i := 0 to 255 do
  begin
    value := i;
    for j := 8 downto 1 do
    begin
      if ((value and 1) <> 0) then
        value := (value shr 1) xor CRC32_POLYNOMIAL
      else
        value := value shr 1;
    end;
    Ccitt32Table[i] := value;
  end
end;
{$R+}

initialization
  BuildCRCTable;
end.
