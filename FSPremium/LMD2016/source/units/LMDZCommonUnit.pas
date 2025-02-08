unit LMDZCommonUnit;
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

LMDZCommonUnit unit - ZLib interface (AH)
-----------------------------------------
General routines and types.
Used with EldoS permission.

Changes
-------
Release 8.0 (July 2006)
 - Initial Release

###############################################################################}
(*

  Pascal port:

            EldoS SecureBlackbox Library

      Copyright (c) 2002-2007 EldoS Corporation
           http://www.secureblackbox.com


  Oiriginal source code:

  Copyright (C) 1995-2005 Jean-loup Gailly and Mark Adler

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

  Jean-loup Gailly        Mark Adler
  jloup@gzip.org          madler@alumni.caltech.edu


  The data format used by the zlib library is described by RFCs (Request for
  Comments) 1950 to 1952 in the files http://www.ietf.org/rfc/rfc1950.txt
  (zlib format), rfc1951.txt (deflate format) and rfc1952.txt (gzip format).
*)

interface

uses
  SysUtils,
  Windows,
  LMDTypes;

const
  //ENOUGH = 1440;
  //MAXD = 154;
  ENOUGH = 2048; // zlib 1.2.3 update
  MAXD = 592;
  LENGTH_CODES = 29;
    // number of length codes, not counting the special END_BLOCK code
  LITERALS = 256; //number of literal bytes 0..255
  L_CODES = (LITERALS + 1 + LENGTH_CODES);
    // number of Literal or Length codes, including the END_BLOCK code
  HEAP_SIZE = (2 * L_CODES + 1); // maximum heap size
  D_CODES = 30; // number of distance codes
  BL_CODES = 19; // number of codes used to transfer the bit lengths
  MAX_BITS = 15; // All codes must not exceed MAX_BITS bits

  ZLIB_VERSION = '1.2.3';
  ZLIB_VERNUM = $1220;

  Z_NO_FLUSH = 0;
  Z_PARTIAL_FLUSH = 1; // will be removed, use Z_SYNC_FLUSH instead
  Z_SYNC_FLUSH = 2;
  Z_FULL_FLUSH = 3;
  Z_FINISH = 4;
  Z_BLOCK = 5;

  Z_OK = 0;
  Z_STREAM_END = 1;
  Z_NEED_DICT = 2;
  Z_STREAM_ERROR = -2;
  Z_DATA_ERROR = -3;
  Z_MEM_ERROR = -4;
  Z_BUF_ERROR = -5;
  Z_VERSION_ERROR = -6;
  Z_NULL = nil; // for initializing zalloc, zfree, opaque
  MAX_PTR = 10; // 10*64K = 640K
  MAX_WBITS = 15;
  Z_RLE = 3;
  Z_FIXED = 4;
  Z_DEFLATED = 8;
    // The deflate compression method (the only one supported in this version)

  PRESET_DICT = $20; // preset dictionary flag in zlib header

type
  ct_data_s = packed record
    case Integer of
      0: (Freq, Dad: Integer);
      1: (Code, Len: Integer);
  end;
  ct_data =  ct_data_s;

  PtrInt = TLMDPtrInt;
  PtrUInt = TLMDPtrUInt; // to avoid warnings about sign/unsign types
  //Additional types for C++ compatibility
  Arrayfff = array[0..$FFF] of byte;
  ArrayPtr = ^Arrayfff;
  ArrayWord = array[0..$FFFF] of Word;
  ArrayWordPtr = ^ArrayWord;
  ArrayInt = array[0..$FFFF] of Integer;
  ArrayIntPtr = ^ArrayInt;
  ArrayuInt = array[0..$FFFF] of Cardinal {=uInt};
  ArrayuIntPtr = ^ArrayuInt;
  ArrayCt = array[0..$FFFF] of ct_data;
  ArrayCtPtr = ^ArrayCt;
  {ct_array = array of ct_data;
 ct_arrayPtr = ^ct_array;   }

  Bytef = ArrayPtr; //array of byte;
  PBytef = ^Bytef;
  ulg = uLong;
  ush = Word;
  PosSh = ush;
  Posf = ArrayWordPtr;
  {$externalsym long}
  long = Longint;
  IPos = uInt; // It OS-depends
  Intf = ArrayIntPtr; //array of integer;
  uch = byte;
  uchf = ArrayPtr; //array of byte;
  ushf = ArrayWordPtr; //array {[0..$ffff]} of ush;
  uIntf = ArrayuIntPtr; //array of uInt;
  Bytefp = ^Bytef; // for uncompress module
  {$externalsym unsigned}
  unsigned = uInt; // It OS-depends
  uLongf = ArrayuIntPtr; //array of uLong;

  voidpf = procedure;
 {alloc_func = function (var opaque :voidpf; var items :uInt; var size :uInt) :voidpf;
 free_func =  procedure (var opaque :voidpf; var address :Bytef);}
  TAlloc = function(AppData: Pointer; Items, Size: Integer): Pointer; register;
  TFree = procedure(AppData, Block: Pointer); register;
  // Internal structure.  Ignore.
  PZStreamRec = ^TZStreamRec;
  TZStreamRec = packed record
  next_in: PAnsiChar; // next input byte
    avail_in: Integer; // number of bytes available at next_in
    total_in: Integer; // total nb of input bytes read so far

    next_out: PAnsiChar; // next output byte should be put here
    avail_out: Integer; // remaining free space at next_out
    total_out: Integer; // total nb of bytes output so far

    msg: PAnsiChar; // last error message, NULL if no error
    internal: Pointer; // not visible by applications
    zalloc: TAlloc; // used to allocate the internal state
    zfree: TFree; // used to free the internal state
    AppData: Pointer; // private data object passed to zalloc and zfree
    data_type: Integer; // best guess about the data type: ascii or binary
    adler: Cardinal; // adler32 value of the uncompressed data
    reserved: Integer; // reserved for future use
  end;
  static_tree_desc_s =  record
    static_tree: ArrayCtPtr; // static tree or NULL
    extra_bits: intf; // extra bits for each code or NULL
    extra_base: integer; // base index for extra_bits
    elems: integer; // max number of elements in the tree
    max_length: integer; // max bit length for the codes
  end;

  static_tree_desc =  static_tree_desc_s;

  tree_desc_s =  record
    dyn_tree: ArrayCtPtr; // the dynamic tree
    max_code: integer; // largest code with non zero frequency
    stat_desc: static_tree_desc; // the corresponding static tree
  end;

  tree_desc =  tree_desc_s;
  ptr_table_s =  record
    org_ptr: Pointer; //voidpf;val1
    new_ptr: Pointer; //voidpf;val1
    end;
  ptr_table =  ptr_table_s;

var
  table: array[0..MAX_PTR] of ptr_table;
{* This table is used to remember the original form of pointers
 * to large buffers (64K). Such pointers are normalized with a zero offset.
 * Since MSDOS is not a preemptive multitasking OS, this table is not
 * protected from concurrent access. This hack doesn't work anyway on
 * a protected system like OS/2. Use Microsoft C instead.}

//Export functions translated(ported) from MS VC++

function adler32(adler: uLong; buf: Pointer; len: uInt): Cardinal;
function zlibAllocMem(AppData: Pointer; Items, Size: Integer): Pointer; register;
procedure zlibFreeMem(AppData, Block: Pointer); register;
function CCheck(code: Integer): Integer;
procedure LMDMemCpy(dest, source: Pointer; count: Integer); cdecl;

implementation

const
  BASE = 65521;// by II : 80521;
  NMAX = 5552;

procedure LMDMemCpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

function adler32(adler: uLong; buf: Pointer; len: uInt): Cardinal;
var
  s1, s2: Cardinal;
  k: uInt;
  procedure DO16;
    procedure DO8(i: byte);
      procedure DO4(i: byte);
        procedure DO2(i: byte);
          procedure DO1(i: byte);
          begin
            s1 := s1 + ArrayPtr(buf)[i];
            s2 := s2 + s1;
          end;
        begin
          DO1(i);
          DO1(i + 1);
        end;
      begin
        DO2(i);
        DO2(i + 2);
      end;
    begin
      DO4(i);
      DO4(i + 4);
    end;
  begin
    DO8(0);
    DO8(8);
  end;

begin
  s1 := adler and $FFFF;
  s2 := (adler shr 16) and $FFFF;

  if (buf = nil) then
  begin
    result := 1;
    exit;
  end;

  while (len > 0) do
  begin
    if len < NMAX then
      k := len
    else
      k := NMAX;
    len := len - k;
    while (k >= 16) do
    begin
      DO16;
      buf := Pointer(PtrUInt(buf) + Cardinal(16));
      Dec(k, 16);
    end;

    if k <> 0 then
      repeat
        s1 := s1 + Byte(buf^);
        buf := Pointer(PtrUInt(buf) + Cardinal(1));
        s2 := s2 + s1;
        Dec(k);
      until (not (k <> 0));
    s1 := s1 mod BASE;
    s2 := s2 mod BASE;
  end;
  result := (s2 shl 16) or s1;
end;

function zlibAllocMem(AppData: Pointer; Items, Size: Integer): Pointer; register;

begin
// GetMem(Result, Items * Size);
  Result := AllocMem(Items * Size);
  end;

procedure zlibFreeMem(AppData, Block: Pointer); register;

begin
  FreeMem(Block);
  end;

function CCheck(code: Integer): Integer;
begin
  Result := code;
  if code < 0 then
    raise Exception.Create('Compression error ' + IntToStr(Code));
end;

end.
