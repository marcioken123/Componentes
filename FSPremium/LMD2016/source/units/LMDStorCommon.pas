unit LMDStorCommon;
{$I LMDCmps.inc}
interface

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

LMDStorCommon unit (VO)
-----------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

uses
  SysUtils, Classes, TypInfo, Windows{$IFDEF LMD_DEBUGTRACE},dialogs{$ENDIF};

type
  TCharSet = TSysCharSet;
  UTF8String = type string;
  PUTF8String = ^UTF8String;

  // helper classes

  { ********************** Class TLMDOSWriter ******************************** }
  TLMDOSWriter = class(TWriter)
  public
    procedure LMDWriteComponent(Component: TComponent);
    procedure LMDWriteObject(Value: TPersistent; Ident: string);
  end;

  { **********************  Class TLMDOSReader ******************************* }
  TLMDOSReader = class(TReader)
  public
    procedure LMDReadProperty;
    procedure LMDReadObject(Instance: TPersistent);
  end;

  { ********************** TSafeWord ***************************************** }
  TSafeWord = class
  private
    function GetLo: Byte;
    function GetHi: Byte;
  public
    Value : Word;
    property Lo: Byte read GetLo;
    property Hi: Byte read GetHi;
  end;

function ReplaceChar(var S: string; ChOld, ChNew: Char): Integer;
function DelChar(const S: string; Ch: Char = ' '): string;
function WordPosition(const N: Integer; const S: string;
 const WordDelims: TCharSet): Integer;
function ExtractWord(N: Integer; const S: string; const WordDelims: TCharSet): string;
function Base64Encode(Buf: AnsiString): AnsiString;
function Base64Decode(B64: AnsiString): String;
procedure CreateDirs(szDir: String);

const
  FLAG_Copied = $80;
  MaxBufferSize = 32767;
  MaxBufferIndex = MaxBufferSize + 14;
  FLAG_Compress = $40;

type
  TBufferSize = 0..MaxBufferSize;
  TBufferIndex = 0..MaxBufferIndex;

  TABuffer = array [TBufferIndex] of Byte;
  LZTable = array [0..4095] of Word;

  PBuffer = ^TABuffer;
  PLZTable = ^LZTable;

procedure LMDStorLoadCompressedStream(src, target: TStream);
procedure LMDStorSaveCompressedStream(src, target: TStream; size: LongInt);

function LMDLZRWCompress(var Source, Dest: TABuffer; SourceSize: TBufferSize): TBufferSize;
function LMDLZRWDecompress(var Source, Dest: TABuffer; Size: TBufferSize): TBufferSize;

implementation
uses
  LMDStrings;
{------------------------------------------------------------------------------}
function ReplaceChar(var S: string; ChOld, ChNew: Char): Integer;
{$ifdef LMDX86}
asm
        PUSH    EBX
        PUSH    ESI
        MOV     EBX,ECX
        MOV     ESI,EDX
        CALL    UniqueString
        TEST    EAX,EAX
        JE      @@qt
        MOV     ECX,EBX
        MOV     EDX,ESI
        MOV     EBX,[EAX-4]
        TEST    EBX,EBX
        JE      @@zq
        LEA     ESI,[EAX-1]
        XOR     EAX,EAX
@@lp:   CMP     DL,BYTE PTR [ESI+EBX]
        JE      @@fn
        DEC     EBX
        JNE     @@lp
        POP     ESI
        POP     EBX
        RET
@@fn:   MOV     BYTE PTR [ESI+EBX],CL
        INC     EAX
        DEC     EBX
        JNE     @@lp
        POP     ESI
        POP     EBX
        RET
@@zq:   XOR     EAX,EAX
@@qt:   POP     ESI
        POP     EBX
end;
{$else}
begin
  S := LMDReplaceChar(S, chNew, chOld);
  Result := 0;
end;
{$endif}

{------------------------------------------------------------------------------}
function DelChar(const S: string; Ch: Char = ' '): string;
begin
  Result := StringReplace(S, Ch, '', [rfReplaceAll]);
end;

(*function DelChar(const S: string; Ch: Char = ' '): string;
asm
        PUSH    ESI
        PUSH    EBX
        PUSH    EDI
        MOV     ESI,ECX
        TEST    EAX,EAX
        JE      @@qt
        MOV     ECX,[EAX-4]
        TEST    ECX,ECX
        JE      @@qt
        MOV     EBX,EAX
        MOV     EDI,EDX
        XOR     EDX,EDX
        MOV     EAX,ESI
        CALL    System.@LStrFromPCharLen
        MOV     EDX,EDI
        MOV     ECX,[EBX-4]
        MOV     EDI,[ESI]
@@lp:   MOV     AL,BYTE PTR [EBX]
        CMP     DL,AL
        JE      @@nx
        MOV     BYTE PTR [EDI],AL
        INC     EDI
@@nx:   INC     EBX
        DEC     ECX
        JNE     @@lp
        MOV     EAX,[ESI]
        MOV     BYTE PTR [EDI],0
        SUB     EDI,EAX
        JE      @@qt
        MOV     [EAX-4],EDI
        POP     EDI
        POP     EBX
        POP     ESI
        RET
@@qt:   MOV     EAX,ESI
        CALL    System.@LStrClr
        POP     EDI
        POP     EBX
        POP     ESI
end;
*)

const
  Base64Code: ansistring
                = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                + 'abcdefghijklmnopqrstuvwxyz'
                + '0123456789+/';
  Pad           = '=';

{------------------------------------------------------------------------------}
function WordPosition(const N: Integer; const S: string;
  const WordDelims: TCharSet): Integer;
var
  Count, I: Integer;
begin
  Result := 0;
  Count := 0;
  I := 1;
  while (I <= Length(S)) and (Count <> N) do begin
    {skip over delimiters}
    while (I <= Length(S)) and (AnsiChar(S[I]) in WordDelims) do Inc(I);
    {if we're not beyond end of S, we're at the start of a word}
    if I <= Length(S) then Inc(Count);
    {if not finished, find the end of the current word}
    if Count <> N then
      while (I <= Length(S)) and not (AnsiChar(S[I]) in WordDelims) do Inc(I)
    else Result := I;
  end;
end;

{------------------------------------------------------------------------------}
function ExtractWord(N: Integer; const S: string;
  const WordDelims: TCharSet): string;
var
  I: Integer;
  Len: Integer;
begin
  Result := '';
  Len := 0;
  I := WordPosition(N, S, WordDelims);
  if I <> 0 then
    {find the end of the current word}
    while (I <= Length(S)) and not(AnsiChar(S[I]) in WordDelims) do begin
      {add the I'th character to result}
      Inc(Len);
      SetLength(Result, Len);
      Result[Len] := S[I];
      Inc(I);
    end;
  SetLength(Result, Len);
end;

type
  EBase64Error = Exception;

{------------------------------------------------------------------------------}
function Base64Encode(Buf: AnsiString): AnsiString;
var
  i             : integer;
  x1, x2, x3, x4: byte;
  PadCount      : integer;
begin
  PadCount := 0;

 // we need at least 3 input bytes...
  while length( Buf ) < 3 do
  begin
    Buf := Buf + #0;
    inc(PadCount);
  end;

 // ...and all input must be an even multiple of 3
  while (length(Buf) mod 3) <> 0 do
  begin
    Buf := Buf + #0; // if not, zero padding is added
    inc(PadCount);
  end;

  Result := '';
  i := 1;

 // process 3-byte blocks or 24 bits
  while i <= length(Buf) - 2 do
  begin
    // each 3 input bytes are transformed into 4 index values
    // in the range of  0..63, by taking 6 bits each step

    // 6 high bytes of first char
    x1 := ( Ord( Buf[i] ) shr 2 ) and $3F;

    // 2 low bytes of first char + 4 high bytes of second char
    x2 := ( ( Ord( Buf[i] ) shl 4 ) and $3F )
      or Ord( Buf[i + 1] ) shr 4;

    // 4 low bytes of second char + 2 high bytes of third char
    x3 := ( ( Ord( Buf[i + 1] ) shl 2 ) and $3F )
      or Ord( Buf[i + 2] ) shr 6;

    // 6 low bytes of third char
    x4 := Ord( Buf[i + 2] ) and $3F;

    // the index values point into the code array
    Result := Result
      + Base64Code[x1 + 1]
      + Base64Code[x2 + 1]
      + Base64Code[x3 + 1]
      + Base64Code[x4 + 1];
    inc( i, 3 );
  end;

 // if needed, finish by forcing padding chars ('=')
 // at end of string
  if PadCount > 0 then
    for i := Length(Result) downto 1 do
    begin
      Result[i] := Pad;
      dec( PadCount );
      if PadCount = 0 then BREAK;
    end;

end;

{------------------------------------------------------------------------------}
function Char2IDx(c: ansichar): byte;
var
  i : integer;
begin
  for i := 1 to Length(Base64Code) do
    if Base64Code[i] = c then
    begin
      Result := pred(i);
      EXIT;
    end;
  Result := Ord(Pad);
end;

{------------------------------------------------------------------------------}
function Base64Decode(B64: AnsiString): String;
var
  i, PadCount : integer;
  Block : AnsiString;
  x1, x2, x3 : byte;
begin

  // input _must_ be at least 4 chars long,
  // or multiple of 4 chars
  if (Length(B64) < 4) or (Length(B64) mod 4 <> 0) then
    raise EBase64Error.Create( 'Base64ToStr: illegal input length!' );
  //
    PadCount := 0;
  i := Length(B64);
  // count padding chars, if any
  while (B64[i] = Pad)
  and (i > 0) do
  begin
    inc(PadCount);
    dec(i);
  end;
  //
  Result := '';
  i := 1;
  SetLength(Block, 3);
  while i <= Length(B64) - 3 do
  begin
    // reverse process of above
    x1 := ( Char2Idx( B64[i] ) shl 2 ) or ( Char2IDx( B64[i + 1] ) shr 4 );
    Result := Result + Chr( x1 );
    x2 := ( Char2Idx( B64[i + 1] ) shl 4 ) or ( Char2IDx( B64[i + 2] ) shr 2 );
    Result := Result + Chr( x2 );
    x3 := ( Char2Idx( B64[i + 2] ) shl 6 ) or ( Char2IDx( B64[i + 3] ) );
    Result := Result + Chr( x3 );
    inc( i, 4 );
  end;

  // delete padding, if any
  while PadCount > 0 do
  begin
    Delete( Result, Length( Result ) - (sizeof(char) - 1), sizeof(char));
    dec( PadCount );
  end;
end;

{------------------------------------------------------------------------------}
procedure CreateDirs(szDir: String);
var
  szTmp   : String;
  iPos    : Integer;
begin
  if Length(szDir) > 0 then
   if szDir[Length(szDir)] <> '\' then szDir := szDir + '\';
  iPos := LMDAnsiPosEx('\', szDir, 4);
  while iPos > 0 do
  begin
    szTmp := Copy(szDir, 1, iPos);
    CreateDir(szTmp);
    iPos := LMDAnsiPosEx('\', szDir, iPos + 1);
  end;
end;

{********************* TLMDOSWriter *******************************************}
{------------------------- Public ---------------------------------------------}
procedure TLMDOSWriter.LMDWriteComponent(Component: TComponent);

var
  I, Count: Integer;
  iPos: Integer;
  vIdent: TValueType;
  PropInfo: PPropInfo;
  PropList: PPropList;
begin
  if Component = nil then exit;
  WriteString(Component.Name);
  Count := GetTypeData(Component.ClassInfo)^.PropCount;
  if Count > 0 then
    begin
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(Component.ClassInfo, PropList);
        for I := 0 to Count - 1 do
          begin
            PropInfo := PropList^[I];
            if PropInfo = nil then break;
            iPos := Position;
            WriteListBegin;
            WriteProperty(Component, PropInfo);
            WriteListEnd;
            if iPos = Position then
              begin
                vIdent := vaNull;
                Write(vIdent, sizeof(vIdent));
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
  vIdent: TValueType;
  PropInfo: PPropInfo;
  PropList: PPropList;
begin
  if Value = nil then exit;
  WriteString(Ident);
  Count := GetTypeData(Value.ClassInfo)^.PropCount;
  if Count > 0 then
    begin
      PropList := AllocMem(Count * SizeOf(Pointer));
      try
        GetPropInfos(Value.ClassInfo, PropList);
        for I := 0 to Count - 1 do
          begin
            PropInfo := PropList^[I];
            if PropInfo = nil then break;
            iPos := Position;
            WriteListBegin;
            WriteProperty(Value, PropInfo);
            WriteListEnd;
            if iPos = Position then
              begin
                vIdent := vaNull;
                Write(vIdent, sizeof(vIdent));
              end;
          end;
      finally
        FreeMem(PropList, Count * SizeOf(Pointer));
      end;
    end;
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
    raise EReadError.Create('Can''t find component ' + szName);
  if NextValue <> Classes.TValueType(vaNull) then
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
var
  szName: String;
begin
  if Root = nil then exit;
  szName := ReadString;
  if NextValue <> Classes.TValueType(vaNull) then
    begin
      ReadListBegin;
      while not EndOfList do
        ReadProperty(Instance);
      ReadListEnd;
    end
  else
    ReadValue;
end;

{ ************************ class TSafeWord *********************************** }
{ ---------------------------- private --------------------------------------- }
function TSafeWord.GetLo: Byte;
begin
  Result := Value and $FF;
end;

{ ---------------------------------------------------------------------------- }
function TSafeWord.GetHi: Byte;
begin
  Result := Value shr 8;
end;

{------------------------------------------------------------------------------}
procedure LMDStorLoadCompressedStream(src, target: TStream);
var
  c, s, srcsize: LongInt;
  bi, bo: TABuffer;
begin
  src.Read(srcSize, SizeOf(srcSize));
  while srcSize > 0 do
    begin
      src.Read(c, SizeOf(c));
      src.ReadBuffer(bi, c);
      s := LMDLZRWDecompress(bi, bo, c);
      target.WriteBuffer(bo, s);
      Dec(srcSize, c + sizeof(c));
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDStorSaveCompressedStream(src, target: TStream; size: LongInt);
var
  bi, bo: TABuffer;
  oldPos, newpos, c, r, s: LongInt;
begin
  c := 0;
  oldPos := target.Position;
  target.Position := oldpos + sizeof(c);
  while Size > 0 do
    begin
      r := src.Read(bi, MaxBufferSize);
      s := LMDLZRWCompress(bi, bo, r);
      target.Write(s, SizeOf(s));
      target.WriteBuffer(bo, s);
      Inc(c, s + SizeOf(s));
      Dec(Size, r);
  end;
  newpos := target.Position;
  target.Position := oldPos;
  target.Write(c, SizeOf(c));
  target.Position := newPos;
end;

{$R-}
{------------------------------------------------------------------------------}
function LMDLZRWCompress(var Source, Dest: TABuffer; SourceSize: TBufferSize): TBufferSize;
var
  Hash: LZTable;
  Key, Bit, Size, Command, i: Word;
  X, Y, Z, Pos: TBufferIndex;
  SHelper : TSafeWord;

  function FindMatch(var Source: TABuffer; X: TBufferIndex; SourceSize: TBufferSize;
               var Hash: LZTable; var iSize: WORD; var Pos: TBufferIndex): Boolean;
    var
      TmpHash: SmallInt;
      HashValue: Word;

    begin
      HashValue := (40543 * ((((Source[X] shl 4) xor Source[X + 1]) shl 4) xor
        Source[X + 2]) SHR 4) AND $0FFF;
      result := false;
      TmpHash := Hash[HashValue];
      if (TmpHash <> -1) and (X - TmpHash < 4096) then
        begin
          pos := TmpHash;
          iSize := 0;
          while((iSize < 18) and (Source[X + iSize] = Source[Pos + iSize]) and
            (X + iSize < SourceSize)) do Inc(iSize);
          result := (iSize >= 3)
        end;
      Hash[HashValue] := X
    end;

begin

  FillChar(Hash, SizeOf(LZTable), $FF);

  SHelper := TSafeWord.Create;
  try
    Dest[0] := FLAG_Compress;
    X := 0;
    Y := 3;
    Z := 1;
    Bit := 0;
    Command := 0;

    while (X < SourceSize) and (Y <= SourceSize) do
      begin
        if (Bit > 15) then
          begin
            SHelper.Value := Command;
            Dest[Z] := SHelper.Hi;
            Dest[Z+1] := SHelper.Lo;

            Z := Y;
            Bit := 0;
            Inc(Y, 2)
          end;

        Size := 1;
        while ((Source[X] = Source[X + Size]) and (Size < $FFF) and
          (X + Size < SourceSize)) do Inc(Size);

        if (Size >= 16) then
          begin
            Dest[Y] := 0;

            SHelper.Value := Size - 16;
            Dest[Y + 1] := SHelper.Hi;
            Dest[Y + 2] := SHelper.Lo;
            Dest[Y + 3] := Source[X];
            Inc(Y, 4);
            Inc(X, Size);
            Command := (Command shl 1) + 1;
          end
        else
          if (FindMatch(Source, X, SourceSize, Hash, Size, Pos)) then
            begin
              Key := ((X - Pos) shl 4) + (Size - 3);

              SHelper.Value := Key;
              Dest[Y] := SHelper.Hi;
              Dest[Y + 1] := SHelper.Lo;
              Inc(Y, 2);
              Inc(X, Size);
              Command := (Command SHL 1) + 1
            end
          else
            begin
              Dest[Y] := Source[X];
              Inc(Y);
              Inc(X);
              Command := Command shl 1
            end;
        Inc(Bit);
      end;

    Command := Command shl (16 - Bit);

    SHelper.Value := Command;
    Dest[Z] := SHelper.Hi;
    Dest[Z + 1] := SHelper.Lo;
    if (Y > SourceSize) then
      begin
        for i:=1 to SourceSize do
          Dest[i]:=Source[i-1];

        Dest[0] := FLAG_Copied;
        Y := Succ(SourceSize)
      end;
    Result := Y;
  finally
    SHelper.Free;
  end;
end;

{------------------------------------------------------------------------------}
function LMDLZRWDecompress(var Source, Dest: TABuffer; Size: TBufferSize): TBufferSize;
var
  X, Y, SaveY, Pos: TBufferIndex;
  BSize, K, Command: Word;
  Bit: Byte;

begin
  SaveY := 0;
  if (Source[0] = FLAG_Copied) then
    begin
      for y := 1 to Pred(Size) do
        begin
          Dest[Pred(Y)] := Source[Y];
          SaveY := Y;
        end;
       Y := SaveY;
    end
  else
    begin
      y := 0;
      X := 3;
      Command := (Source[1] SHL 8) + Source[2];
      Bit := 16;
      while (X < Size) do
        begin
          if (Bit = 0) then
            begin
              Command := (Source[X] shl 8) + Source[X + 1];
              Bit := 16;
              Inc(X, 2)
            end;
          if ((Command and $8000) = 0) then
            begin
              Dest[Y] := Source[X];
              inc(X);
              inc(Y)
            end
          else
            begin
              Pos := ((Source[X] shl 4) + (Source[X + 1] shr 4));
              if (Pos = 0) then
                begin
                  BSize := (Source[X + 1] shl 8) + Source[X + 2] + 15;
                  for k := 0 to BSize do
                    Dest[Y + K] := Source[X + 3];
                  Inc(X, 4);
                  Inc(Y, BSize + 1)
                end
            else
              begin
                BSize := (Source[X + 1] and $0F) + 2;
                for k := 0 to BSize do
                  Dest[Y + K] := Dest[Y - Pos + K];
                Inc(X, 2);
                Inc(Y, BSize + 1)
              end;
        end;
      Command := Command shl 1;
      Dec(Bit);
    end;
  end;
  result := y
end;

{$IFDEF LMD_DEBUGTRACE}
  {.$I C2.INC}

initialization
  {.$I C3.INC}
{$ENDIF}

end.
