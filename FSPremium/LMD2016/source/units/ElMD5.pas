unit ElMD5;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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

ElHintWnd unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

{====================================================}
{   Copyright (c) 1996 Greg Carter,                  }
{                      gregc@cryptocard.com          }
{                                                    }
{====================================================}

{*****************************************************************************
 UNIT: MD5Unit
 Description:  This unit contains an Object Pascal Object which can be used to
               perform an MD5 Hashing of byte array, file, or Pascal String. An
               MD5 Hashing or Message Digest is a 'finger print' of the
               input. This is 100% PASCAL!!!

               "It is conjectured that it is computationally infeasible
               to produce two messages having the same message digest"....
               "The MD5 algorithm is intended for digital signature
               applications, where a large file must be "compressed" in a
               secure manner before being encrypted with a private (secret) key
               under a public-key cryptosystem such as RSA." R. Rivest
               RfC: 1321, RSA Data Security, Inc. April 1992

 The MD5 Algorithm was produced by RSA Data Security Inc.(See LEGAL)
 -----------------------------------------------------------------------------
 Code Author:  Greg Carter, gregc@cryptocard.com
 Organization: CRYPTOCard Corporation, info@cryptocard.com
               R&D Division, Carleton Place, ON, CANADA, K7C 3T2
               1-613-253-3152 Voice, 1-613-253-4685 Fax.
 Date of V.1:  Jan. 3 1996.

 Compatibility & Testing with BP7.0: Anne Marcel Roorda, garfield@xs4all.nl
 -----------------------------------------------------------------------------}
 {Useage:  Below is typical usage(for File)of the MD5 Object, Follow these steps:
        Step 1: Declare and Create a New TCrMD5 object.  This can be done by
                'Drag N Drop' a TCrMD5 off the Delphi Tool Pallet,
                or explicitly in code.
        Step 2: Set the InputType.
        Step 3: Point to the input(InputString, InputFilePath, pInputArray).
        Step 4: Point to the output Array(pOutputArray).
        Step 5: Call the MD5_Hash procedure.
                Your Done!

Example
procedure Tcryptfrm.Button1Click(Sender: TObject);
var
 md5hash: TCrMD5;                  (* Step 1a *)
 outarray: array[0..15] of char;
 InputFile: File;
 startTime: LongInt;
begin
 md5hash := TCrMD5.Create(Self);   (* Step 1b *)
 try
  If OpenDialog1.Execute then
  begin
    md5hash.InputType := SourceFile;  (* Step 2 *)
    md5hash.InputFilePath := OpenDialog1.FileName; (* Step 3 *)
    md5hash.pOutputArray := @outarray;             (* Step 4 *)
    startTime := timeGetTime;
    md5hash.MD5_Hash;                              (* Step 5 *)
    LEDLabel1.Caption := IntToStr(timeGetTime - startTime);
    Label2.Caption := StrPas(outarray);     (* Do something with output *)
  end;(* if *)
 finally
  md5hash.free;
 end;
end;
{-----------------------------------------------------------------------------}
{LEGAL:        The algorithm was placed into the public domain, hence requires
               no license or runtime fees.  However this code is copyright by
               CRYPTOCard.  CRYPTOCard grants anyone who may wish to use, modify
               or redistribute this code privileges to do so, provided the user
               agrees to the following three(3) rules:

               1)Any Applications, (ie exes which make use of this
               Object...), for-profit or non-profit,
               must acknowledge the author of this Object(ie.
               MD5 Implementation provided by Greg Carter, CRYPTOCard
               Corporation) somewhere in the accompanying Application
               documentation(ie AboutBox, HelpFile, readme...).  NO runtime
               or licensing fees are required!

               2)Any Developer Component(ie Delphi Component, Visual Basic VBX,
               DLL) derived from this software must acknowledge that it is
               derived from "MD5 Object Pascal Implementation Originated by
               Greg Carter, CRYPTOCard Corporation 1996". Also all efforts should
               be made to point out any changes from the original.
               !!!!!Further, any Developer Components based on this code
               *MAY NOT* be sold for profit.  This Object was placed into the
               public domain, and therefore any derived components should
               also.!!!!!

               3)CRYPTOCard Corporation makes no representations concerning this
               software or the suitability of this software for any particular
               purpose. It is provided "as is" without express or implied
               warranty of any kind. CRYPTOCard accepts no liability from any
               loss or damage as a result of using this software.

CRYPTOCard Corporation is in no way affiliated with RSA Data Security Inc.
The MD5 Algorithm was produced by RSA Data Security Inc.
-----------------------------------------------------------------------------
Why Use this instead of a freely available C DLL?

The goal was to provide a number of Encryption/Hash implementations in Object
Pascal, so that the Pascal Developer has considerably more freedom.  These
Implementations are geared toward the PC(Intel) Microsoft Windows developer,
who will be using Borland's New 32bit developement environment(Delphi32).  The
code generated by this new compiler is considerablely faster then 16bit versions.
And should provide the Developer with faster implementations then those using
C DLLs.
-----------------------------------------------------------------------------
NOTES: Version 1 does not contain any cross-platform considerations.  If trying
       to use this code on a Big Endian style processor you will need to write
       additional code to reorder the bytes.
------------------------------------------------------------------------------
Revised:  00/00/00 BY: ******* Reason: ******
------------------------------------------------------------------------------
}
{Declare the compiler defines}
{------Changeable compiler switches-----------------------------------}
{$A+Word align variables }
{$F+   Force Far calls }
{$K+   Use smart callbacks
{$N+   Allow coprocessor instructions }
{$P+Open parameters enabled }
{$S+   Stack checking }
{$T-@ operator is NOT typed }
{$U-Non Pentium safe FDIV }
{$Z-   No automatic word-sized enumerations}
{$H+Huge Strings}

{$RANGECHECKS OFF}
{$Q-}

{---------------------------------------------------------------------}

{$DEFINE MD5ONLY}

interface
uses SysUtils,

     Windows,

     Classes,
     ElVCLUtils;

{An enumerated typt which tells the object what type the input to the cipher is}
type
  TSourceType = (SourceFile, SourceByteArray, SourceString, SourceAnsiString,
                 SourceWideString);

type
  ULONG32 = record
    LoWord16 : WORD;
    HiWord16 : WORD;
  end;

  PULONG32 = ^ULONG32;
  PLong = ^LongInt;

  hashDigest = record
    A : DWORD;
    B : DWORD;
    C : DWORD;
    D : DWORD;
  end; {hashArray}

  PTR_Hash = ^hashDigest;

  TCrMD5 = class
  private
 { Private declarations }

    FType : TSourceType; {Source type, whether its a file or ByteArray, or
                                            a Pascal String}
    FInputFilePath : string; {Full Path to Input File}
    // ToDo Alex

    FInputArray : PByte; {Point to input array}
    FOutputDigest : PTR_Hash; {output MD5 Digest}

    FInputString : string; {Input String}
    FInputAnsiString: AnsiString;
    FInputWideString: WideString;
    FSourceLength : LongInt; {input length in BYTES}
    FActiveBlock : array[0..15] of DWORD; {the 64Byte block being transformed}
    FAA, FBB, FCC, FDD : DWORD;
    FA, FB, FC, FD: DWORD;

  {FA..FDD are used during Step 4, the transform.  I made them part of the
   Object to cut down on time used to pass variables.}
  {FF, GG, HH, II are used in Step 4, the transform}
    procedure FF(var a, b, c, d, x : DWORD; s : BYTE; ac : DWORD);
    procedure GG(var a, b, c, d, x : DWORD; s : BYTE; ac : DWORD);
    procedure HH(var a, b, c, d, x : DWORD; s : BYTE; ac : DWORD);
    procedure II(var a, b, c, d, x : DWORD; s : BYTE; ac : DWORD);
    protected
    { Protected declarations }
  public
    { Public declarations }
  {Initialize is used in Step 3, this fills FA..FD with init. values
   and points FpA..FpD to FA..FD}
    procedure MD5_Initialize;
  {this is where all the magic happens}
    procedure MD5_Transform;
    procedure MD5_Finish;
    procedure MD5_Hash_Bytes;
{  Procedure MD5_Hash_String;(Pascal Style strings???)}
    procedure MD5_Hash_File;
  {This procedure sends the data 64Bytes at a time to MD5_Transform}
    procedure MD5_Hash;

    property pInputArray : PByte read FInputArray write FInputArray;
    property pOutputArray : PTR_Hash read FOutputDigest write FOutputDigest; {!!See FOutputArray}

    property InputType : TSourceType read FType write FType;
    property InputFilePath : string read FInputFilePath write FInputFilePath;
    property InputString : string read FInputString write FInputString;
    property InputAnsiString : AnsiString read FInputAnsiString write FInputAnsiString;
    property InputWideString : WideString read FInputWideString write FInputWideString;
    property InputLength : LongInt read FSourceLength write FSourceLength;
  end; {TCrMD5}

const
{Constants for MD5Transform routine.}
  S11 = 7;
  S12 = 12;
  S13 = 17;
  S14 = 22;
  S21 = 5;
  S22 = 9;
  S23 = 14;
  S24 = 20;
  S31 = 4;
  S32 = 11;
  S33 = 16;
  S34 = 23;
  S41 = 6;
  S42 = 10;
  S43 = 15;
  S44 = 21;

implementation

{This will only work on an intel}
{$WARNINGS off}
function ROL(A: Longint; Amount : BYTE) : Longint;
begin
  {$ifdef LMDX64}
  Result := (Result shl Amount) or (Result shr (SizeOf(A) - Amount)); // ROL Amount
  {$else}
  asm
   mov cl, Amount
   mov eax, a
   rol eax, cl
   mov result, eax
  end;
  {$endif}
end;
{$WARNINGS on}

procedure TCrMD5.MD5_Initialize;
begin
  FA := $67452301;
  FB := $EFCDAB89;
  FC := $98BADCFE;
  FD := $10325476;
end; {MD5_Initialize}

procedure TCrMD5.FF;
{Purpose:  Round 1 of the Transform.
           Equivalent to a = b + ((a + F(b,c,d) + x + ac) <<< s)
           Where F(b,c,d) = b And c Or Not(b) And d
}
var core : dword;
begin
  core := ((b and c) or (not (b) and (d)));
  core := core + a;
  core := core + x;
  core := core + ac;
  a := core;
  a := ROL(a, s);
  Inc(a, b);
end; {FF}

procedure TCrMD5.GG;
{Purpose:  Round 2 of the Transform.
           Equivalent to a = b + ((a + G(b,c,d) + x + ac) <<< s)
           Where G(b,c,d) = b And d Or c Not d
}
begin
  a := a + ((b and d) or (c and (not d))) + x + ac;
  a := ROL(a, s);
  Inc(a, b);
end; {GG}

procedure TCrMD5.HH;
{Purpose:  Round 3 of the Transform.
           Equivalent to a = b + ((a + H(b,c,d) + x + ac) <<< s)
           Where H(b,c,d) = b Xor c Xor d
}
begin
  a := a + (b xor c xor d) + x + ac;
  a := ROL(a, s);
  a := b + a;
end; {HH}

procedure TCrMD5.II;
{Purpose:  Round 4 of the Transform.
           Equivalent to a = b + ((a + I(b,c,d) + x + ac) <<< s)
           Where I(b,c,d) = C Xor (b Or Not(d))
}
begin
  a := a + (c xor (b or (not d))) + x + ac;
  a := ROL(a, s);
  a := b + a;
end; {II}

procedure TCrMD5.MD5_Transform;

{Purpose:  Perform Step 4 of the algorithm.  This is where all the important
           stuff happens.  This performs the rounds on a 64Byte Block.  This
           procedure should be called in a loop until all input data has been
           transformed.
}

begin
  FAA := FA;
  FBB := FB;
  FCC := FC;
  FDD := FD;

  { Round 1 }
  FF(FA, FB, FC, FD, FActiveBlock[0], S11, $D76AA478); { 1 }
  FF(FD, FA, FB, FC, FActiveBlock[1], S12, $E8C7B756); { 2 }
  FF(FC, FD, FA, FB, FActiveBlock[2], S13, $242070DB); { 3 }
  FF(FB, FC, FD, FA, FActiveBlock[3], S14, $C1BDCEEE); { 4 }
  FF(FA, FB, FC, FD, FActiveBlock[4], S11, $F57C0FAF); { 5 }
  FF(FD, FA, FB, FC, FActiveBlock[5], S12, $4787C62A); { 6 }
  FF(FC, FD, FA, FB, FActiveBlock[6], S13, $A8304613); { 7 }
  FF(FB, FC, FD, FA, FActiveBlock[7], S14, $FD469501); { 8 }
  FF(FA, FB, FC, FD, FActiveBlock[8], S11, $698098D8); { 9 }
  FF(FD, FA, FB, FC, FActiveBlock[9], S12, $8B44F7AF); { 10 }
  FF(FC, FD, FA, FB, FActiveBlock[10], S13, $FFFF5BB1); { 11 }
  FF(FB, FC, FD, FA, FActiveBlock[11], S14, $895CD7BE); { 12 }
  FF(FA, FB, FC, FD, FActiveBlock[12], S11, $6B901122); { 13 }
  FF(FD, FA, FB, FC, FActiveBlock[13], S12, $FD987193); { 14 }
  FF(FC, FD, FA, FB, FActiveBlock[14], S13, $A679438E); { 15 }
  FF(FB, FC, FD, FA, FActiveBlock[15], S14, $49B40821); { 16 }

 { Round 2 }
  GG(FA, FB, FC, FD, FActiveBlock[1], S21, $F61E2562); { 17 }
  GG(FD, FA, FB, FC, FActiveBlock[6], S22, $C040B340); { 18 }
  GG(FC, FD, FA, FB, FActiveBlock[11], S23, $265E5A51); { 19 }
  GG(FB, FC, FD, FA, FActiveBlock[0], S24, $E9B6C7AA); { 20 }
  GG(FA, FB, FC, FD, FActiveBlock[5], S21, $D62F105D); { 21 }
  GG(FD, FA, FB, FC, FActiveBlock[10], S22, $2441453); { 22 }
  GG(FC, FD, FA, FB, FActiveBlock[15], S23, $D8A1E681); { 23 }
  GG(FB, FC, FD, FA, FActiveBlock[4], S24, $E7D3FBC8); { 24 }
  GG(FA, FB, FC, FD, FActiveBlock[9], S21, $21E1CDE6); { 25 }
  GG(FD, FA, FB, FC, FActiveBlock[14], S22, $C33707D6); { 26 }
  GG(FC, FD, FA, FB, FActiveBlock[3], S23, $F4D50D87); { 27 }
  GG(FB, FC, FD, FA, FActiveBlock[8], S24, $455A14ED); { 28 }
  GG(FA, FB, FC, FD, FActiveBlock[13], S21, $A9E3E905); { 29 }
  GG(FD, FA, FB, FC, FActiveBlock[2], S22, $FCEFA3F8); { 30 }
  GG(FC, FD, FA, FB, FActiveBlock[7], S23, $676F02D9); { 31 }
  GG(FB, FC, FD, FA, FActiveBlock[12], S24, $8D2A4C8A); { 32 }

  { Round 3 }
  HH(FA, FB, FC, FD, FActiveBlock[5], S31, $FFFA3942); { 33 }
  HH(FD, FA, FB, FC, FActiveBlock[8], S32, $8771F681); { 34 }
  HH(FC, FD, FA, FB, FActiveBlock[11], S33, $6D9D6122); { 35 }
  HH(FB, FC, FD, FA, FActiveBlock[14], S34, $FDE5380C); { 36 }
  HH(FA, FB, FC, FD, FActiveBlock[1], S31, $A4BEEA44); { 37 }
  HH(FD, FA, FB, FC, FActiveBlock[4], S32, $4BDECFA9); { 38 }
  HH(FC, FD, FA, FB, FActiveBlock[7], S33, $F6BB4B60); { 39 }
  HH(FB, FC, FD, FA, FActiveBlock[10], S34, $BEBFBC70); { 40 }
  HH(FA, FB, FC, FD, FActiveBlock[13], S31, $289B7EC6); { 41 }
  HH(FD, FA, FB, FC, FActiveBlock[0], S32, $EAA127FA); { 42 }
  HH(FC, FD, FA, FB, FActiveBlock[3], S33, $D4EF3085); { 43 }
  HH(FB, FC, FD, FA, FActiveBlock[6], S34, $4881D05); { 44 }
  HH(FA, FB, FC, FD, FActiveBlock[9], S31, $D9D4D039); { 45 }
  HH(FD, FA, FB, FC, FActiveBlock[12], S32, $E6DB99E5); { 46 }
  HH(FC, FD, FA, FB, FActiveBlock[15], S33, $1FA27CF8); { 47 }
  HH(FB, FC, FD, FA, FActiveBlock[2], S34, $C4AC5665); { 48 }

  { Round 4 }
  II(FA, FB, FC, FD, FActiveBlock[0], S41, $F4292244); { 49 }
  II(FD, FA, FB, FC, FActiveBlock[7], S42, $432AFF97); { 50 }
  II(FC, FD, FA, FB, FActiveBlock[14], S43, $AB9423A7); { 51 }
  II(FB, FC, FD, FA, FActiveBlock[5], S44, $FC93A039); { 52 }
  II(FA, FB, FC, FD, FActiveBlock[12], S41, $655B59C3); { 53 }
  II(FD, FA, FB, FC, FActiveBlock[3], S42, $8F0CCC92); { 54 }
  II(FC, FD, FA, FB, FActiveBlock[10], S43, $FFEFF47D); { 55 }
  II(FB, FC, FD, FA, FActiveBlock[1], S44, $85845DD1); { 56 }
  II(FA, FB, FC, FD, FActiveBlock[8], S41, $6FA87E4F); { 57 }
  II(FD, FA, FB, FC, FActiveBlock[15], S42, $FE2CE6E0); { 58 }
  II(FC, FD, FA, FB, FActiveBlock[6], S43, $A3014314); { 59 }
  II(FB, FC, FD, FA, FActiveBlock[13], S44, $4E0811A1); { 60 }
  II(FA, FB, FC, FD, FActiveBlock[4], S41, $F7537E82); { 61 }
  II(FD, FA, FB, FC, FActiveBlock[11], S42, $BD3AF235); { 62 }
  II(FC, FD, FA, FB, FActiveBlock[2], S43, $2AD7D2BB); { 63 }
  II(FB, FC, FD, FA, FActiveBlock[9], S44, $EB86D391); { 64 }

  Inc(FA, FAA);
  Inc(FB, FBB);
  Inc(FC, FCC);
  Inc(FD, FDD);
  { Zeroize sensitive information}
  FillChar(FActiveBlock, SizeOf(FActiveBlock), #0);
end; {TCrMD5.MD5_Transform}

procedure TCrMD5.MD5_Hash;
begin
  MD5_Initialize;
  case FType of
    SourceFile :
      begin
        MD5_Hash_File;
      end; {SourceFile}
    SourceByteArray :
      begin
        MD5_Hash_Bytes;
      end; {SourceByteArray}
    SourceString:
      begin
        if FInputString <> '' then
          FInputArray := PByte(@FInputString[1])
        else
          FInputArray := nil;
        FSourceLength := Length(FInputString) * SizeOf(Char);
        MD5_Hash_Bytes;
      end; {SourceString}
    SourceAnsiString:
      begin
        if FInputAnsiString <> '' then
          FInputArray := PByte(@FInputAnsiString[1])
        else
          FInputArray := nil;
        FSourceLength := Length(FInputAnsiString) * SizeOf(AnsiChar);
        MD5_Hash_Bytes;
      end; {SourceAnsiString}
    SourceWideString:
      begin
        if FInputWideString <> '' then
          FInputArray := PByte(@FInputWideString[1])
        else
          FInputArray := nil;
        FSourceLength := Length(FInputWideString) * SizeOf(WideChar);
        MD5_Hash_Bytes;
      end; {SourceAnsiString}
  end; {case}
  MD5_Finish;
end; {TCrMD5.MD5_Hash}

procedure TCrMD5.MD5_Hash_Bytes;
type
  TBuffer = array[0..0] of Byte;
  PBuffer = ^TBuffer;
var
  SttBuf: array[0..1024] of Byte;
  DynBuf: array of Byte;
  P: PBuffer;
  Count64 : Comp;
  index : longInt;
  SrcLen : Integer;
begin
  if FSourceLength + 64 < SizeOf(SttBuf) then
  begin
    FillMemory(@SttBuf, sizeof(SttBuf), 0);
    P := @SttBuf[0];
  end
  else
  begin
    SetLength(DynBuf, FSourceLength + 64);
    P := @DynBuf[0];
  end;

  SrcLen := FSourceLength;
  Move(FInputArray^, P^, SrcLen);
  Count64 := SrcLen * 8; {Save the Length(in bits) before padding}
  P[SrcLen] := $80; {Must always pad with at least a '1'}
  inc(SrcLen);

  while (SrcLen mod 64) <> 56 do
  begin
    P[SrcLen] := 0;
    Inc(SrcLen);
  end;
  Move(Count64, P[SrcLen], SizeOf(Count64) {This better be 64bits});
  index := 0;
  Inc(SrcLen, 8);
  repeat
    MoveMemory(@FActiveBlock, @P[Index], 64);

    MD5_Transform;
    Inc(Index, 64);
  until Index = SrcLen;
end; {TCrMD5.Hash_Bytes}

procedure TCrMD5.MD5_Hash_File;
var
  Buffer : array[0..4159] of BYTE;
  InputFile : file;
  Count64 : Comp;
  DoneFile : Boolean;
  Index : LongInt;
  NumRead : integer;
begin
  DoneFile := False;
  AssignFile(InputFile, FInputFilePath);

  FillMemory(@Buffer, sizeof(Buffer), 0);

  Reset(InputFile, 1);
  Count64 := 0;
  repeat
    BlockRead(InputFile, Buffer, 4096, NumRead);
    Count64 := Count64 + NumRead;
    if NumRead <> 4096 {reached end of file} then
    begin
      Buffer[NumRead] := $80;
      Inc(NumRead);
      while (NumRead mod 64) <> 56 do
      begin
        Buffer[NumRead] := 0;
        Inc(NumRead);
      end;
      Count64 := Count64 * 8;
      Move(Count64, Buffer[NumRead], 8);
      Inc(NumRead, 8);
      DoneFile := True;
    end;
    Index := 0;
    repeat
      Move(Buffer[Index], FActiveBlock, 64);
     {Flip bytes here on a Mac(I think)}

      MD5_Transform;
      Inc(Index, 64);
    until Index = NumRead;
  until DoneFile;

  CloseFile(InputFile);
end; {TCrMD5.MD5_Hash_File}

procedure TCrMD5.MD5_Finish;

begin
  FOutputDigest^.A := FA;
  FOutputDigest^.B := FB;
  FOutputDigest^.C := FC;
  FOutputDigest^.D := FD;
end;

end.
