unit LMDUnicode;
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

LMDUnicode  unit ()
-------------------

Changes
-------
Release 10
[+] Added UTF7 BOM

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, LMDRTLConst;

{************************* OS Unicode support testing *************************}

function LMDIsUnicodePlatform: Boolean;

{******************************* UTF8 Support *********************************}

type
  UTF32  = Longword;
  UTF16  = Word;
  UTF8   = Byte;

  pUTF32 = ^UTF32;
  pUTF16 = ^UTF16;
  pUTF8  = ^UTF8;

type
  TLMDUnicodeCategory = (ukLu,    // Letter, Uppercase
                         ukLl,    // Letter, Lowercase
                         ukLt,    // Letter, Titlecase
                         ukLm,    // Letter, Modifier
                         ukLo,    // Letter, Other
                         ukMn,    // Mark, Non-Spacing
                         ukMc,    // Mark, Spacing Combining
                         ukMe,    // Mark, Enclosing
                         ukNd,    // Number, Decimal
                         ukNl,    // Number, Letter
                         ukNo,    // Number, Other
                         ukPc,    // Punctuation, Connector
                         ukPd,    // Punctuation, Dash
                         ukPs,    // Punctuation, Open
                         ukPe,    // Punctuation, Close
                         ukPi,    // Punctuation, Initial quote
                         ukPf,    // Punctuation, Final quote
                         ukPo,    // Punctuation, Other
                         ukSm,    // Symbol, Math
                         ukSc,    // Symbol, Currency
                         ukSk,    // Symbol, Modifier
                         ukSo,    // Symbol, Other
                         ukZs,    // Separator, Space
                         ukZl,    // Separator, Line
                         ukZp,    // Separator, Paragraph
                         ukCc,    // Other, Control
                         ukCf,    // Other, Format
                         ukCs,    // Other, Surrogate
                         ukCo,    // Other, Private Use
                         ukCn);   // Other, Not Assigned

  TLMDUnicodeCategories = set of TLMDUnicodeCategory;

  ConversionFlags = (strictConversion,  // = 0
                     lenientConversion);

  ConversionResult = (conversionOK,     // Conversion successful.
                      sourceExhausted,  // Partial character in source, but hit end.
                      targetExhausted,  // Insuff room in target for conversion.
                      sourceIllegal);   // Source sequence is illegal/malformed.

function LMDConvertUTF16toUTF8(const source: WideString;
                               var target: AnsiString;
                               flags: ConversionFlags;
                               BOM: Boolean): ConversionResult;
function LMDConvertUTF8toUTF16(const source: AnsiString;
                               var target: WideString;
                               flags: ConversionFlags;
                               BOM: Boolean): ConversionResult;

function LMDConvertUTF8String(const Source: AnsiString): WideString;
function LMDGetTrailingBytesUTF8(AByte: byte): integer;
function LMDIsLegalUTF8Sequence(const source: AnsiString;
                                 sourcelen: Cardinal): Boolean;

{******************************* UTF7 Support *********************************}
function LMDConvertUTF16ToUTF7(ASrc: WideString;
                               const AEncodeOptionalChars: Boolean = False;
                               const ABOM: Boolean = False): AnsiString;
function LMDConvertUTF7ToUTF16(const ASrc: AnsiString; ARemoveBom: Boolean = True): WideString;
function LMDTryConvertUTF7ToUTF16(const ASrc: AnsiString; var ADest: WideString; ARemoveBom: Boolean = True): Boolean;

{************************* Upper/Lower conversions ****************************}

function LMDUnicodeUpper(const S: WideString): WideString;
function LMDUnicodeLower(const S: WideString): WideString;

function LMDUnicodeUpperChar(C: WideChar): WideChar;
function LMDUnicodeLowerChar(C: WideChar): WideChar;

{***************************** Common utilities *******************************}

type
  TWideReplaceFlags = set of (wrfReplaceAll, wrfIgnoreCase);

function LMDWideGetCharCategory(AChar: WideChar): TLMDUnicodeCategory;
function LMDWideCompareText(const S1, S2: WideString): Integer;
function LMDWideSameText(const S1, S2: WideString): Boolean;
function LMDWideCompareStr(const S1, S2: WideString): Integer;
function LMDWideSameStr(const S1, S2: WideString): Boolean;
function LMDWideMakeString(FLen: Integer; const Seq: WideString): WideString;
function LMDWideStringDup(const S: WideString): PWideChar;
function LMDWideStringReplace(const S, OldPattern, NewPattern: WideString;
                               Flags: TWideReplaceFlags): WideString;
function LMDWideGetCharRangeString(FirstChar, LastChar: WideChar): WideString;
function LMDWideGetStringOf(Char: WideChar; Len: Cardinal): WideString;

{***************************** String scanning ********************************}

function  LMDWideStrScan(const Str: PWideChar; AChr: WideChar): PWideChar; assembler;
function  LMDWideStrRScan(const Str: PWideChar; AChr: WideChar): PWideChar; assembler;

{***************************** Quotes handling ********************************}

function  LMDWideQuotedStr(const S: WideString; Quote: WideChar): WideString;
function  LMDWideExtractQuotedStr(var Src: PWideChar; Quote: WideChar): WideString;

{*********************** String Sizing/Moving/Copying *************************}

procedure LMDWideSetString(var S: WideString; Buffer: PWideChar; Len: Integer);
function  LMDWideStrCopy(Target: PWideChar; Source: PWideChar): PWideChar;
function  LMDWideStrPCopy(Target: PWideChar; const Source: WideString): PWideChar;
function  LMDWideStrComp(const S1, S2: PWideChar): Integer; assembler;
function  LMDWideStrLComp(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
function  LMDWideStrLen(const Str: PWideChar): Cardinal;
function  LMDWideStrPas(const Source: PWideChar): WideString;
procedure LMDWideMove(const Source; var Dest; Count: Integer);
function  LMDWideStrMove(Dest: PWideChar; const Source: PWideChar;
                         Count: Cardinal): PWideChar;
function  LMDWideStrECopy(Dest: PWideChar; const Source: PWideChar): PWideChar;
function  LMDWideStrLCopy(Dest: PWideChar; const Source: PWideChar;
                          MaxLen: Cardinal): PWideChar;
function  LMDWideStrLCat(Dest: PWideChar; const Source: PWideChar;
                         MaxLen: Cardinal): PWideChar;
function  LMDWideStrCat(Dest: PWideChar; const Source: PWideChar): PWideChar;

{*************************** Dynamic string utilities *************************}
// from ElStrUtils
function LMDWidePos(const Substr, S : WideString) : integer;
procedure LMDWideDelete(var S : WideString; SPos, SLen : integer);
procedure LMDWideInsert(Text : WideString; var S : WideString; SPos : integer);

procedure LMDFillWord(var X; Count: Integer; Value: Word);
procedure LMDFillWideChar(var X; Count: Integer; Value: WideChar);

function  LMDWideStrAlloc(Size: Cardinal): PWideChar;
function  LMDWideStrBufSize(const Str: PWideChar): Cardinal;
function  LMDWideStrNew(const Str: PWideChar): PWideChar;
procedure LMDWideStrDispose(Str: PWideChar);
function  LMDWideLastChar(const S: WideString): PWideChar;
function  LMDWideStrPos(const Str1,
                        Str2: PWideChar): PWideChar; assembler;
function  LMDWideStrEnd(const Str: PWideChar): PWideChar; assembler;

{***************************** File path delimiters ***************************}

const
  LMDPathDelimiters     = string('/\');
  LMDWidePathDelimiters = WideString('/\');

function  LMDIsWideDelimiter(const Delimiters, S: WideString;
                             Index: Integer): Boolean;
function  LMDIsWidePathDelimiter(const S: WideString; Index: Integer): Boolean;

{****************************** Windows related *******************************}

function  LMDWideGetShortHint(const Hint: WideString): WideString;
function  LMDCreateUnicodeHintString(const Value: WideString): string;
function  LMDWMCharToUnicode(AC: Char): WideChar;

{******************************************************************************}
function  LMDKeyToUnicode(const Key: String): WideString;

implementation

uses
  Windows, Consts, Math;

{Unicode data tables}
{------------------------------------------------------------------------------}

const
  LMD_CHAR_KIND_FIRST_TABLE: array [0..255] of Cardinal = (
    0, 256, 512, 768, 1024, 1280, 1536, 1792, 2048, 2304, 2560, 2816,
    3072, 3328, 3584, 3840, 4096, 4352, 4608, 4864, 5120, 5376, 5632,
    5888, 6144, 6400, 2048, 2048, 2048, 6656, 6912, 7168, 7424, 7680,
    7936, 8192, 8448, 8704, 8960, 9216, 9472, 9728, 7936, 9984, 2048,
    2048, 10240, 10496, 10752, 11008, 11264, 9472, 11520, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    11776, 11520, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 12032, 5376, 5376, 5376,
    5376, 12288, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 11520,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 12544,
    12800, 2048, 2048, 13056, 12800, 2048, 2048, 13312, 13568, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048, 2048,
    13824, 5376, 14080, 14336, 5376, 14592, 14848, 15104
);

const
  LMD_CHAR_KIND_SECOND_TABLE: array[0..15360 - 1] of TLMDUnicodeCategory = (
    ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc,
    ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc,
    ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukZs,
    ukPo, ukPo, ukPo, ukSc, ukPo, ukPo, ukPo, ukPs, ukPe, ukPo, ukSm,
    ukPo, ukPd, ukPo, ukPo, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukPo, ukPo, ukSm, ukSm, ukSm, ukPo, ukPo, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukPs, ukPo, ukPe, ukSk, ukPc, ukSk, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukPs, ukSm, ukPe, ukSm, ukCc, ukCc, ukCc, ukCc, ukCc,
    ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc,
    ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukCc,
    ukCc, ukCc, ukCc, ukCc, ukCc, ukCc, ukZs, ukPo, ukSc, ukSc, ukSc,
    ukSc, ukSo, ukSo, ukSk, ukSo, ukLl, ukPi, ukSm, ukCf, ukSo, ukSk,
    ukSo, ukSm, ukNo, ukNo, ukSk, ukLl, ukSo, ukPo, ukSk, ukNo, ukLl,
    ukPf, ukNo, ukNo, ukNo, ukPo, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukSm, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukSm, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLl, ukLl,
    ukLu, ukLu, ukLl, ukLu, ukLl, ukLu, ukLu, ukLl, ukLu, ukLu, ukLu,
    ukLl, ukLl, ukLu, ukLu, ukLu, ukLu, ukLl, ukLu, ukLu, ukLl, ukLu,
    ukLu, ukLu, ukLl, ukLl, ukLl, ukLu, ukLu, ukLl, ukLu, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLu, ukLl, ukLu, ukLl, ukLl, ukLu,
    ukLl, ukLu, ukLu, ukLl, ukLu, ukLu, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLu, ukLl, ukLl, ukLo, ukLu, ukLl, ukLl, ukLl, ukLo, ukLo, ukLo,
    ukLo, ukLu, ukLt, ukLl, ukLu, ukLt, ukLl, ukLu, ukLt, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLl, ukLu, ukLt, ukLl, ukLu, ukLl, ukLu, ukLu, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLl, ukLl, ukLl, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLm, ukLm, ukLm, ukLm, ukLm,
    ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm,
    ukLm, ukLm, ukSk, ukSk, ukSk, ukSk, ukLm, ukLm, ukLm, ukLm, ukLm,
    ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukSk, ukSk, ukSk, ukSk,
    ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukLm,
    ukLm, ukLm, ukLm, ukLm, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk,
    ukSk, ukSk, ukLm, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk,
    ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukSk, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukCn, ukCn, ukCn, ukCn, ukSk, ukSk, ukCn, ukCn, ukCn, ukCn, ukLm,
    ukCn, ukCn, ukCn, ukPo, ukCn, ukCn, ukCn, ukCn, ukCn, ukSk, ukSk,
    ukLu, ukPo, ukLu, ukLu, ukLu, ukCn, ukLu, ukCn, ukLu, ukLu, ukLl,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukCn, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukCn, ukLl, ukLl, ukLu,
    ukLu, ukLu, ukLl, ukLl, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLu, ukLl, ukSm, ukLu, ukLl, ukLu, ukLu, ukLl, ukCn, ukCn, ukCn,
    ukCn, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukSo,
    ukMn, ukMn, ukMn, ukMn, ukCn, ukMe, ukMe, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukCn,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukCn, ukCn, ukLu, ukLl, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukCn, ukCn, ukLm, ukPo, ukPo, ukPo, ukPo, ukPo,
    ukPo, ukCn, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukCn, ukPo, ukPd,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukCn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukCn, ukMn, ukMn, ukMn, ukPo, ukMn, ukPo, ukMn,
    ukMn, ukPo, ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukLo, ukLo, ukLo, ukPo, ukPo, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCf, ukCf, ukCf, ukCf,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukPo, ukPo, ukSo,
    ukSo, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukPo, ukCn, ukCn, ukCn, ukPo, ukCn, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukLm, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukPo, ukPo, ukPo, ukPo, ukLo, ukLo, ukMn, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukPo,
    ukLo, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukCf, ukMe, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukLm, ukLm, ukMn, ukMn, ukSo, ukMn,
    ukMn, ukMn, ukMn, ukLo, ukLo, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukLo, ukLo, ukLo, ukSo, ukSo, ukLo, ukPo,
    ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo,
    ukPo, ukPo, ukCn, ukCf, ukLo, ukMn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukCn, ukCn, ukLo,
    ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMn, ukMn, ukMc, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukMn,
    ukLo, ukMc, ukMc, ukMc, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMc, ukMc, ukMc, ukMc, ukMn, ukCn, ukCn, ukLo, ukMn, ukMn,
    ukMn, ukMn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukMn, ukMn, ukPo, ukPo, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukPo, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukMn, ukMc, ukMc, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukCn, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukCn, ukCn, ukCn,
    ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukMn, ukLo, ukMc, ukMc, ukMc,
    ukMn, ukMn, ukMn, ukMn, ukCn, ukCn, ukMc, ukMc, ukCn, ukCn, ukMc,
    ukMc, ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukMc, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo,
    ukMn, ukMn, ukCn, ukCn, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukLo, ukLo, ukSc, ukSc, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukSo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMn, ukMn,
    ukMc, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn,
    ukCn, ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukLo, ukLo, ukCn, ukLo, ukLo, ukCn, ukLo, ukLo,
    ukCn, ukCn, ukMn, ukCn, ukMc, ukMc, ukMc, ukMn, ukMn, ukCn, ukCn,
    ukCn, ukCn, ukMn, ukMn, ukCn, ukCn, ukMn, ukMn, ukMn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukMn,
    ukMn, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukMn, ukMn, ukMc, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo,
    ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukMn, ukLo,
    ukMc, ukMc, ukMc, ukMn, ukMn, ukMn, ukMn, ukMn, ukCn, ukMn, ukMn,
    ukMc, ukCn, ukMc, ukMc, ukMn, ukCn, ukCn, ukLo, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukLo, ukLo, ukMn, ukMn, ukCn, ukCn, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukCn, ukSc, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukMn, ukMc, ukMc, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukCn, ukCn, ukMn, ukLo, ukMc, ukMn, ukMc, ukMn,
    ukMn, ukMn, ukCn, ukCn, ukCn, ukMc, ukMc, ukCn, ukCn, ukMc, ukMc,
    ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMn, ukMc,
    ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukCn,
    ukCn, ukCn, ukCn, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukSo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMn, ukLo,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukLo,
    ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukLo,
    ukLo, ukCn, ukLo, ukCn, ukLo, ukLo, ukCn, ukCn, ukCn, ukLo, ukLo,
    ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukCn,
    ukCn, ukCn, ukCn, ukMc, ukMc, ukMn, ukMc, ukMc, ukCn, ukCn, ukCn,
    ukMc, ukMc, ukMc, ukCn, ukMc, ukMc, ukMc, ukMn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMc, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNo, ukNo,
    ukNo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSc, ukSo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukMc, ukMc, ukMc, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukCn, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukMn,
    ukMn, ukMn, ukMc, ukMc, ukMc, ukMc, ukCn, ukMn, ukMn, ukMn, ukCn,
    ukMn, ukMn, ukMn, ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukMn, ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukMc, ukMc, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukCn, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukCn, ukMn, ukLo, ukMc, ukMn, ukMc, ukMc, ukMc,
    ukMc, ukMc, ukCn, ukMn, ukMc, ukMc, ukCn, ukMc, ukMc, ukMn, ukMn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMc, ukMc, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukCn, ukLo, ukLo, ukCn, ukCn,
    ukCn, ukCn, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMc, ukMc, ukCn,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo,
    ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukCn, ukCn, ukMc, ukMc, ukMc, ukMn, ukMn, ukMn, ukCn, ukCn, ukMc,
    ukMc, ukMc, ukCn, ukMc, ukMc, ukMc, ukMn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukMc, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukMc, ukMc, ukCn, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukCn, ukCn,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukMn,
    ukCn, ukCn, ukCn, ukCn, ukMc, ukMc, ukMc, ukMn, ukMn, ukMn, ukCn,
    ukMn, ukCn, ukMc, ukMc, ukMc, ukMc, ukMc, ukMc, ukMc, ukMc, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMc, ukMc, ukPo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukMn, ukLo, ukLo, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukCn, ukCn, ukCn, ukCn, ukSc, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLm, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukPo, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukPo, ukPo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukCn, ukLo, ukCn,
    ukCn, ukLo, ukLo, ukCn, ukLo, ukCn, ukCn, ukLo, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukCn, ukLo, ukCn,
    ukLo, ukCn, ukCn, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukMn,
    ukLo, ukLo, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukCn, ukMn, ukMn,
    ukLo, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLm, ukCn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukCn, ukCn, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukCn, ukCn, ukLo, ukLo,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukLo, ukSo, ukSo, ukSo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo,
    ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukMn, ukMn, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukSo, ukMn,
    ukSo, ukMn, ukSo, ukMn, ukPs, ukPe, ukPs, ukPe, ukMc, ukMc, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMc, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukPo, ukMn, ukMn, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukCn, ukCn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukCn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukCn, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukMn, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn, ukSo,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukCn, ukLo, ukLo, ukCn, ukMc, ukMn, ukMn, ukMn, ukMn, ukMc, ukMn,
    ukCn, ukCn, ukCn, ukMn, ukMn, ukMc, ukMn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukMc, ukMc, ukMn, ukMn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukCn, ukCn, ukPo, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo,
    ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukCn, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukCn,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukPo,
    ukPo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukZs, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukPs, ukPe, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukPo, ukPo, ukPo, ukNl, ukNl, ukNl, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukMn,
    ukMn, ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukMn, ukMn,
    ukMn, ukPo, ukPo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukMn, ukMn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukCn, ukMn, ukMn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCf, ukCf, ukMc, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMc, ukMc, ukMc, ukMc, ukMc,
    ukMc, ukMc, ukMc, ukMn, ukMc, ukMc, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukPo, ukPo, ukPo, ukLm, ukPo,
    ukPo, ukPo, ukSc, ukLo, ukMn, ukCn, ukCn, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukPo, ukPo, ukPo, ukPo, ukPo,
    ukPo, ukPd, ukPo, ukPo, ukPo, ukPo, ukMn, ukMn, ukMn, ukZs, ukCn,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLm, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukMn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukMn, ukMn, ukMn,
    ukMc, ukMc, ukMc, ukMc, ukMn, ukMn, ukMc, ukMc, ukMc, ukCn, ukCn,
    ukCn, ukCn, ukMc, ukMc, ukMn, ukMc, ukMc, ukMc, ukMc, ukMc, ukMc,
    ukMn, ukMn, ukMn, ukCn, ukCn, ukCn, ukCn, ukSo, ukCn, ukCn, ukCn,
    ukPo, ukPo, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm,
    ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm,
    ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm,
    ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm,
    ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm, ukLm,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukCn, ukCn, ukCn, ukCn, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl,
    ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu, ukLl, ukLu,
    ukLl, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukCn, ukCn, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukCn, ukCn, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukCn, ukCn, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukCn, ukCn, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukCn, ukLu, ukCn, ukLu,
    ukCn, ukLu, ukCn, ukLu, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukCn, ukCn, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLt, ukLt, ukLt, ukLt, ukLt, ukLt, ukLt, ukLt, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLt, ukLt, ukLt, ukLt, ukLt, ukLt,
    ukLt, ukLt, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLt,
    ukLt, ukLt, ukLt, ukLt, ukLt, ukLt, ukLt, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukCn, ukLl, ukLl, ukLu, ukLu, ukLu, ukLu, ukLt, ukSk, ukLl,
    ukSk, ukSk, ukSk, ukLl, ukLl, ukLl, ukCn, ukLl, ukLl, ukLu, ukLu,
    ukLu, ukLu, ukLt, ukSk, ukSk, ukSk, ukLl, ukLl, ukLl, ukLl, ukCn,
    ukCn, ukLl, ukLl, ukLu, ukLu, ukLu, ukLu, ukCn, ukSk, ukSk, ukSk,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukSk, ukSk, ukSk, ukCn, ukCn, ukLl, ukLl, ukLl, ukCn,
    ukLl, ukLl, ukLu, ukLu, ukLu, ukLu, ukLt, ukSk, ukSk, ukCn, ukZs,
    ukZs, ukZs, ukZs, ukZs, ukZs, ukZs, ukZs, ukZs, ukZs, ukZs, ukZs,
    ukCf, ukCf, ukCf, ukCf, ukPd, ukPd, ukPd, ukPd, ukPd, ukPd, ukPo,
    ukPo, ukPi, ukPf, ukPs, ukPi, ukPi, ukPf, ukPs, ukPi, ukPo, ukPo,
    ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukZl, ukZp, ukCf, ukCf, ukCf,
    ukCf, ukCf, ukZs, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo,
    ukPo, ukPi, ukPf, ukPo, ukPo, ukPo, ukPo, ukPc, ukPc, ukPo, ukPo,
    ukPo, ukSm, ukPs, ukPe, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo, ukPo,
    ukPo, ukPo, ukPo, ukPo, ukSm, ukPo, ukPc, ukCn, ukCn, ukPo, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukZs, ukCf, ukCf, ukCf, ukCf,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCf, ukCf, ukCf, ukCf, ukCf,
    ukCf, ukNo, ukLl, ukCn, ukCn, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukSm, ukSm, ukSm, ukPs, ukPe, ukLl, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukSm, ukSm, ukSm, ukPs, ukPe, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukSc, ukSc, ukSc, ukSc, ukSc, ukSc,
    ukSc, ukSc, ukSc, ukSc, ukSc, ukSc, ukSc, ukSc, ukSc, ukSc, ukSc,
    ukSc, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMe, ukMe, ukMe, ukMe, ukMn, ukMe, ukMe, ukMe, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukSo, ukSo, ukLu, ukSo, ukSo, ukSo, ukSo, ukLu, ukSo,
    ukSo, ukLl, ukLu, ukLu, ukLu, ukLl, ukLl, ukLu, ukLu, ukLu, ukLl,
    ukSo, ukLu, ukSo, ukSo, ukSo, ukLu, ukLu, ukLu, ukLu, ukLu, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukLu, ukSo, ukLu, ukSo, ukLu, ukSo,
    ukLu, ukLu, ukLu, ukLu, ukSo, ukLl, ukLu, ukLu, ukSo, ukLu, ukLl,
    ukLo, ukLo, ukLo, ukLo, ukLl, ukSo, ukSo, ukCn, ukLl, ukLu, ukLu,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukLu, ukLl, ukLl, ukLl, ukLl, ukSo,
    ukSm, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNl,
    ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl,
    ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl,
    ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl,
    ukNl, ukNl, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukSm, ukSm, ukSm, ukSm, ukSm, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSm, ukSm, ukSo, ukSo, ukSo, ukSo, ukSm, ukSo, ukSo,
    ukSm, ukSo, ukSo, ukSm, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSm, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSm,
    ukSm, ukSo, ukSo, ukSm, ukSo, ukSm, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSm, ukSm, ukSm, ukSm, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSm, ukSm, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukPs, ukPe, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSm, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukPs, ukPe, ukPo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSm,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSm, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSm, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukCn, ukCn, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukSo, ukSo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukSo,
    ukSo, ukSo, ukSo, ukCn, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukSo, ukCn,
    ukSo, ukSo, ukSo, ukSo, ukCn, ukCn, ukCn, ukSo, ukCn, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe,
    ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukSo, ukCn, ukCn, ukCn, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukPs, ukPe, ukPs,
    ukPe, ukPs, ukPe, ukCn, ukCn, ukCn, ukCn, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe,
    ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs,
    ukPe, ukPs, ukPe, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukPs, ukPe, ukPs, ukPe, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm, ukSm,
    ukSm, ukSm, ukSm, ukPs, ukPe, ukSm, ukSm, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukCn, ukCn, ukCn, ukCn, ukZs, ukPo, ukPo, ukPo, ukSo, ukLm,
    ukLo, ukNl, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs,
    ukPe, ukSo, ukSo, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe,
    ukPd, ukPs, ukPe, ukPe, ukSo, ukNl, ukNl, ukNl, ukNl, ukNl, ukNl,
    ukNl, ukNl, ukNl, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukPd, ukLm,
    ukLm, ukLm, ukLm, ukLm, ukSo, ukSo, ukNl, ukNl, ukNl, ukLm, ukLo,
    ukPo, ukSo, ukSo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukCn, ukMn, ukMn, ukSk, ukSk, ukLm, ukLm, ukLo,
    ukPd, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukPc, ukLm, ukLm, ukLm, ukLo, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukSo, ukSo,
    ukNo, ukNo, ukNo, ukNo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukSo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukSo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo, ukNo,
    ukNo, ukNo, ukNo, ukNo, ukNo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukCn, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn,
    ukCn, ukCn, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo, ukSo,
    ukSo, ukSo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCs, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCs, ukCs, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCs, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCs, ukCo, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo,
    ukMn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukSm, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo,
    ukCn, ukLo, ukLo, ukCn, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukPs, ukPe, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukSc, ukSo, ukCn, ukCn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn, ukMn,
    ukMn, ukMn, ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukMn, ukMn, ukMn,
    ukMn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn,
    ukCn, ukCn, ukPo, ukPd, ukPd, ukPc, ukPc, ukPs, ukPe, ukPs, ukPe,
    ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs, ukPe, ukPs,
    ukPe, ukPo, ukPo, ukPs, ukPe, ukPo, ukPo, ukPo, ukPo, ukPc, ukPc,
    ukPc, ukPo, ukPo, ukPo, ukCn, ukPo, ukPo, ukPo, ukPo, ukPd, ukPs,
    ukPe, ukPs, ukPe, ukPs, ukPe, ukPo, ukPo, ukPo, ukSm, ukPd, ukSm,
    ukSm, ukSm, ukCn, ukPo, ukSc, ukPo, ukPo, ukCn, ukCn, ukCn, ukCn,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn,
    ukCf, ukCn, ukPo, ukPo, ukPo, ukSc, ukPo, ukPo, ukPo, ukPs, ukPe,
    ukPo, ukSm, ukPo, ukPd, ukPo, ukPo, ukNd, ukNd, ukNd, ukNd, ukNd,
    ukNd, ukNd, ukNd, ukNd, ukNd, ukPo, ukPo, ukSm, ukSm, ukSm, ukPo,
    ukPo, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu, ukLu,
    ukLu, ukLu, ukLu, ukLu, ukLu, ukPs, ukPo, ukPe, ukSk, ukPc, ukSk,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl, ukLl,
    ukLl, ukLl, ukLl, ukLl, ukPs, ukSm, ukPe, ukSm, ukPs, ukPe, ukPo,
    ukPs, ukPe, ukPo, ukPc, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLm, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLm, ukLm, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukCn, ukLo, ukLo, ukLo,
    ukLo, ukLo, ukLo, ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo,
    ukCn, ukCn, ukLo, ukLo, ukLo, ukLo, ukLo, ukLo, ukCn, ukCn, ukLo,
    ukLo, ukLo, ukCn, ukCn, ukCn, ukSc, ukSc, ukSm, ukSk, ukSo, ukSc,
    ukSc, ukCn, ukSo, ukSm, ukSm, ukSm, ukSm, ukSo, ukSo, ukCn, ukCn,
    ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCn, ukCf, ukCf, ukCf,
    ukSo, ukSo, ukCn, ukCn);

const
  UNI_REPLACEMENT_CHAR: UTF32   = $0000FFFD;
  UNI_MAX_BMP: UTF32            = $0000FFFF;
  UNI_MAX_UTF16: UTF32          = $0010FFFF;
  UNI_MAX_UTF32: UTF32          = $7FFFFFFF;
  halfShift: Integer            = 10; // Used for shifting by 10 bits.
  halfBase: UTF32               = $0010000;
  halfMask: UTF32               = $3FF;
  UNI_SUR_HIGH_START: UTF32     = $0D800;
  UNI_SUR_HIGH_END: UTF32       = $0DBFF;
  UNI_SUR_LOW_START: UTF32      = $0DC00;
  UNI_SUR_LOW_END: UTF32        = $0DFFF;

  {
    Index into the table below with the first Byte of a UTF-8 sequence to
    get the number of trailing bytes that are supposed to follow it.
  }
  trailingBytesForUTF8: array[0..255] of Byte = (
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5
    );

  {
    Magic values subtracted from a buffer value during UTF8 conversion.
    This table contains as many values as there might be trailing bytes
    in a UTF-8 sequence.
  }
  offsetsFromUTF8: array[0..5] of UTF32 = ($00000000, $00003080, $000E2080,
    $03C82080, $0FA082080, $82082080);
  {
    Once the bits are split out into bytes of UTF-8, this is a mask OR-ed
    into the first Byte, depending on how many bytes follow.  There are
    as many entries in this table as there are UTF-8 sequence types.
    (I.e., one Byte sequence, two Byte... six Byte sequence.)
  }
  firstByteMark: array[0..6] of UTF8 = ($00, $00, $0C0, $0E0, $0F0, $0F8, $0FC);

{------------------------------------------------------------------------------}

type
  PArr     = ^TByteArr;
  TByteArr = array[0..$7FFFFFFE] of Byte;

{------------------------------------------------------------------------------}

const
  CFT_COMMON          = 1;
  CFT_SIMPLE          = 2;
  CFT_FULL            = 4;
  CFT_SPECIAL         = 8;
  CFT_MAXTYPE         = CFT_COMMON + CFT_SIMPLE + CFT_FULL + CFT_SPECIAL;
  max_trans           = 816;
  ms_unicode: Boolean = False;
  doti: Boolean       = True;

{------------------------------------------------------------------------------}

type
  w3arr = array[1..3] of WideChar;
  tr = record
    fl: Byte;
    lc: WideChar;
    uc: w3arr;
  end;

{------------------------------------------------------------------------------}

const
  rcc: array[1..max_trans] of tr = (
    (fl: CFT_COMMON; lc: #$0041; uc: (#$0061, #0, #0)),
    (fl: CFT_COMMON; lc: #$0042; uc: (#$0062, #0, #0)),
    (fl: CFT_COMMON; lc: #$0043; uc: (#$0063, #0, #0)),
    (fl: CFT_COMMON; lc: #$0044; uc: (#$0064, #0, #0)),
    (fl: CFT_COMMON; lc: #$0045; uc: (#$0065, #0, #0)),
    (fl: CFT_COMMON; lc: #$0046; uc: (#$0066, #0, #0)),
    (fl: CFT_COMMON; lc: #$0047; uc: (#$0067, #0, #0)),
    (fl: CFT_COMMON; lc: #$0048; uc: (#$0068, #0, #0)),
    (fl: CFT_COMMON; lc: #$0049; uc: (#$0069, #0, #0)),
    (fl: CFT_COMMON; lc: #$004A; uc: (#$006A, #0, #0)),
    (fl: CFT_COMMON; lc: #$004B; uc: (#$006B, #0, #0)),
    (fl: CFT_COMMON; lc: #$004C; uc: (#$006C, #0, #0)),
    (fl: CFT_COMMON; lc: #$004D; uc: (#$006D, #0, #0)),
    (fl: CFT_COMMON; lc: #$004E; uc: (#$006E, #0, #0)),
    (fl: CFT_COMMON; lc: #$004F; uc: (#$006F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0050; uc: (#$0070, #0, #0)),
    (fl: CFT_COMMON; lc: #$0051; uc: (#$0071, #0, #0)),
    (fl: CFT_COMMON; lc: #$0052; uc: (#$0072, #0, #0)),
    (fl: CFT_COMMON; lc: #$0053; uc: (#$0073, #0, #0)),
    (fl: CFT_COMMON; lc: #$0054; uc: (#$0074, #0, #0)),
    (fl: CFT_COMMON; lc: #$0055; uc: (#$0075, #0, #0)),
    (fl: CFT_COMMON; lc: #$0056; uc: (#$0076, #0, #0)),
    (fl: CFT_COMMON; lc: #$0057; uc: (#$0077, #0, #0)),
    (fl: CFT_COMMON; lc: #$0058; uc: (#$0078, #0, #0)),
    (fl: CFT_COMMON; lc: #$0059; uc: (#$0079, #0, #0)),
    (fl: CFT_COMMON; lc: #$005A; uc: (#$007A, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C0; uc: (#$00E0, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C1; uc: (#$00E1, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C2; uc: (#$00E2, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C3; uc: (#$00E3, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C4; uc: (#$00E4, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C5; uc: (#$00E5, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C6; uc: (#$00E6, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C7; uc: (#$00E7, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C8; uc: (#$00E8, #0, #0)),
    (fl: CFT_COMMON; lc: #$00C9; uc: (#$00E9, #0, #0)),
    (fl: CFT_COMMON; lc: #$00CA; uc: (#$00EA, #0, #0)),
    (fl: CFT_COMMON; lc: #$00CB; uc: (#$00EB, #0, #0)),
    (fl: CFT_COMMON; lc: #$00CC; uc: (#$00EC, #0, #0)),
    (fl: CFT_COMMON; lc: #$00CD; uc: (#$00ED, #0, #0)),
    (fl: CFT_COMMON; lc: #$00CE; uc: (#$00EE, #0, #0)),
    (fl: CFT_COMMON; lc: #$00CF; uc: (#$00EF, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D0; uc: (#$00F0, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D1; uc: (#$00F1, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D2; uc: (#$00F2, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D3; uc: (#$00F3, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D4; uc: (#$00F4, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D5; uc: (#$00F5, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D6; uc: (#$00F6, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D8; uc: (#$00F8, #0, #0)),
    (fl: CFT_COMMON; lc: #$00D9; uc: (#$00F9, #0, #0)),
    (fl: CFT_COMMON; lc: #$00DA; uc: (#$00FA, #0, #0)),
    (fl: CFT_COMMON; lc: #$00DB; uc: (#$00FB, #0, #0)),
    (fl: CFT_COMMON; lc: #$00DC; uc: (#$00FC, #0, #0)),
    (fl: CFT_COMMON; lc: #$00DD; uc: (#$00FD, #0, #0)),
    (fl: CFT_COMMON; lc: #$00DE; uc: (#$00FE, #0, #0)),
    (fl: CFT_FULL;   lc: #$00DF; uc: (#$0073, #$0073, #0)),
    (fl: CFT_COMMON; lc: #$0100; uc: (#$0101, #0, #0)),
    (fl: CFT_COMMON; lc: #$0102; uc: (#$0103, #0, #0)),
    (fl: CFT_COMMON; lc: #$0104; uc: (#$0105, #0, #0)),
    (fl: CFT_COMMON; lc: #$0106; uc: (#$0107, #0, #0)),
    (fl: CFT_COMMON; lc: #$0108; uc: (#$0109, #0, #0)),
    (fl: CFT_COMMON; lc: #$010A; uc: (#$010B, #0, #0)),
    (fl: CFT_COMMON; lc: #$010C; uc: (#$010D, #0, #0)),
    (fl: CFT_COMMON; lc: #$010E; uc: (#$010F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0110; uc: (#$0111, #0, #0)),
    (fl: CFT_COMMON; lc: #$0112; uc: (#$0113, #0, #0)),
    (fl: CFT_COMMON; lc: #$0114; uc: (#$0115, #0, #0)),
    (fl: CFT_COMMON; lc: #$0116; uc: (#$0117, #0, #0)),
    (fl: CFT_COMMON; lc: #$0118; uc: (#$0119, #0, #0)),
    (fl: CFT_COMMON; lc: #$011A; uc: (#$011B, #0, #0)),
    (fl: CFT_COMMON; lc: #$011C; uc: (#$011D, #0, #0)),
    (fl: CFT_COMMON; lc: #$011E; uc: (#$011F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0120; uc: (#$0121, #0, #0)),
    (fl: CFT_COMMON; lc: #$0122; uc: (#$0123, #0, #0)),
    (fl: CFT_COMMON; lc: #$0124; uc: (#$0125, #0, #0)),
    (fl: CFT_COMMON; lc: #$0126; uc: (#$0127, #0, #0)),
    (fl: CFT_COMMON; lc: #$0128; uc: (#$0129, #0, #0)),
    (fl: CFT_COMMON; lc: #$012A; uc: (#$012B, #0, #0)),
    (fl: CFT_COMMON; lc: #$012C; uc: (#$012D, #0, #0)),
    (fl: CFT_COMMON; lc: #$012E; uc: (#$012F, #0, #0)),
    (fl: CFT_SPECIAL; lc: #$0130; uc: (#$0069, #0, #0)),
    (fl: CFT_SPECIAL; lc: #$0131; uc: (#$0131, #0, #0)),
    (fl: CFT_COMMON; lc: #$0132; uc: (#$0133, #0, #0)),
    (fl: CFT_COMMON; lc: #$0134; uc: (#$0135, #0, #0)),
    (fl: CFT_COMMON; lc: #$0136; uc: (#$0137, #0, #0)),
    (fl: CFT_COMMON; lc: #$0139; uc: (#$013A, #0, #0)),
    (fl: CFT_COMMON; lc: #$013B; uc: (#$013C, #0, #0)),
    (fl: CFT_COMMON; lc: #$013D; uc: (#$013E, #0, #0)),
    (fl: CFT_COMMON; lc: #$013F; uc: (#$0140, #0, #0)),
    (fl: CFT_COMMON; lc: #$0141; uc: (#$0142, #0, #0)),
    (fl: CFT_COMMON; lc: #$0143; uc: (#$0144, #0, #0)),
    (fl: CFT_COMMON; lc: #$0145; uc: (#$0146, #0, #0)),
    (fl: CFT_COMMON; lc: #$0147; uc: (#$0148, #0, #0)),
    (fl: CFT_FULL;   lc: #$0149; uc: (#$02BC, #$006E, #0)),
    (fl: CFT_COMMON; lc: #$014A; uc: (#$014B, #0, #0)),
    (fl: CFT_COMMON; lc: #$014C; uc: (#$014D, #0, #0)),
    (fl: CFT_COMMON; lc: #$014E; uc: (#$014F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0150; uc: (#$0151, #0, #0)),
    (fl: CFT_COMMON; lc: #$0152; uc: (#$0153, #0, #0)),
    (fl: CFT_COMMON; lc: #$0154; uc: (#$0155, #0, #0)),
    (fl: CFT_COMMON; lc: #$0156; uc: (#$0157, #0, #0)),
    (fl: CFT_COMMON; lc: #$0158; uc: (#$0159, #0, #0)),
    (fl: CFT_COMMON; lc: #$015A; uc: (#$015B, #0, #0)),
    (fl: CFT_COMMON; lc: #$015C; uc: (#$015D, #0, #0)),
    (fl: CFT_COMMON; lc: #$015E; uc: (#$015F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0160; uc: (#$0161, #0, #0)),
    (fl: CFT_COMMON; lc: #$0162; uc: (#$0163, #0, #0)),
    (fl: CFT_COMMON; lc: #$0164; uc: (#$0165, #0, #0)),
    (fl: CFT_COMMON; lc: #$0166; uc: (#$0167, #0, #0)),
    (fl: CFT_COMMON; lc: #$0168; uc: (#$0169, #0, #0)),
    (fl: CFT_COMMON; lc: #$016A; uc: (#$016B, #0, #0)),
    (fl: CFT_COMMON; lc: #$016C; uc: (#$016D, #0, #0)),
    (fl: CFT_COMMON; lc: #$016E; uc: (#$016F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0170; uc: (#$0171, #0, #0)),
    (fl: CFT_COMMON; lc: #$0172; uc: (#$0173, #0, #0)),
    (fl: CFT_COMMON; lc: #$0174; uc: (#$0175, #0, #0)),
    (fl: CFT_COMMON; lc: #$0176; uc: (#$0177, #0, #0)),
    (fl: CFT_COMMON; lc: #$0178; uc: (#$00FF, #0, #0)),
    (fl: CFT_COMMON; lc: #$0179; uc: (#$017A, #0, #0)),
    (fl: CFT_COMMON; lc: #$017B; uc: (#$017C, #0, #0)),
    (fl: CFT_COMMON; lc: #$017D; uc: (#$017E, #0, #0)),
    (fl: CFT_COMMON; lc: #$017F; uc: (#$0073, #0, #0)),
    (fl: CFT_COMMON; lc: #$0181; uc: (#$0253, #0, #0)),
    (fl: CFT_COMMON; lc: #$0182; uc: (#$0183, #0, #0)),
    (fl: CFT_COMMON; lc: #$0184; uc: (#$0185, #0, #0)),
    (fl: CFT_COMMON; lc: #$0186; uc: (#$0254, #0, #0)),
    (fl: CFT_COMMON; lc: #$0187; uc: (#$0188, #0, #0)),
    (fl: CFT_COMMON; lc: #$0189; uc: (#$0256, #0, #0)),
    (fl: CFT_COMMON; lc: #$018A; uc: (#$0257, #0, #0)),
    (fl: CFT_COMMON; lc: #$018B; uc: (#$018C, #0, #0)),
    (fl: CFT_COMMON; lc: #$018E; uc: (#$01DD, #0, #0)),
    (fl: CFT_COMMON; lc: #$018F; uc: (#$0259, #0, #0)),
    (fl: CFT_COMMON; lc: #$0190; uc: (#$025B, #0, #0)),
    (fl: CFT_COMMON; lc: #$0191; uc: (#$0192, #0, #0)),
    (fl: CFT_COMMON; lc: #$0193; uc: (#$0260, #0, #0)),
    (fl: CFT_COMMON; lc: #$0194; uc: (#$0263, #0, #0)),
    (fl: CFT_COMMON; lc: #$0196; uc: (#$0269, #0, #0)),
    (fl: CFT_COMMON; lc: #$0197; uc: (#$0268, #0, #0)),
    (fl: CFT_COMMON; lc: #$0198; uc: (#$0199, #0, #0)),
    (fl: CFT_COMMON; lc: #$019C; uc: (#$026F, #0, #0)),
    (fl: CFT_COMMON; lc: #$019D; uc: (#$0272, #0, #0)),
    (fl: CFT_COMMON; lc: #$019F; uc: (#$0275, #0, #0)),
    (fl: CFT_COMMON; lc: #$01A0; uc: (#$01A1, #0, #0)),
    (fl: CFT_COMMON; lc: #$01A2; uc: (#$01A3, #0, #0)),
    (fl: CFT_COMMON; lc: #$01A4; uc: (#$01A5, #0, #0)),
    (fl: CFT_COMMON; lc: #$01A6; uc: (#$0280, #0, #0)),
    (fl: CFT_COMMON; lc: #$01A7; uc: (#$01A8, #0, #0)),
    (fl: CFT_COMMON; lc: #$01A9; uc: (#$0283, #0, #0)),
    (fl: CFT_COMMON; lc: #$01AC; uc: (#$01AD, #0, #0)),
    (fl: CFT_COMMON; lc: #$01AE; uc: (#$0288, #0, #0)),
    (fl: CFT_COMMON; lc: #$01AF; uc: (#$01B0, #0, #0)),
    (fl: CFT_COMMON; lc: #$01B1; uc: (#$028A, #0, #0)),
    (fl: CFT_COMMON; lc: #$01B2; uc: (#$028B, #0, #0)),
    (fl: CFT_COMMON; lc: #$01B3; uc: (#$01B4, #0, #0)),
    (fl: CFT_COMMON; lc: #$01B5; uc: (#$01B6, #0, #0)),
    (fl: CFT_COMMON; lc: #$01B7; uc: (#$0292, #0, #0)),
    (fl: CFT_COMMON; lc: #$01B8; uc: (#$01B9, #0, #0)),
    (fl: CFT_COMMON; lc: #$01BC; uc: (#$01BD, #0, #0)),
    (fl: CFT_COMMON; lc: #$01C4; uc: (#$01C6, #0, #0)),
    (fl: CFT_COMMON; lc: #$01C5; uc: (#$01C6, #0, #0)),
    (fl: CFT_COMMON; lc: #$01C7; uc: (#$01C9, #0, #0)),
    (fl: CFT_COMMON; lc: #$01C8; uc: (#$01C9, #0, #0)),
    (fl: CFT_COMMON; lc: #$01CA; uc: (#$01CC, #0, #0)),
    (fl: CFT_COMMON; lc: #$01CB; uc: (#$01CC, #0, #0)),
    (fl: CFT_COMMON; lc: #$01CD; uc: (#$01CE, #0, #0)),
    (fl: CFT_COMMON; lc: #$01CF; uc: (#$01D0, #0, #0)),
    (fl: CFT_COMMON; lc: #$01D1; uc: (#$01D2, #0, #0)),
    (fl: CFT_COMMON; lc: #$01D3; uc: (#$01D4, #0, #0)),
    (fl: CFT_COMMON; lc: #$01D5; uc: (#$01D6, #0, #0)),
    (fl: CFT_COMMON; lc: #$01D7; uc: (#$01D8, #0, #0)),
    (fl: CFT_COMMON; lc: #$01D9; uc: (#$01DA, #0, #0)),
    (fl: CFT_COMMON; lc: #$01DB; uc: (#$01DC, #0, #0)),
    (fl: CFT_COMMON; lc: #$01DE; uc: (#$01DF, #0, #0)),
    (fl: CFT_COMMON; lc: #$01E0; uc: (#$01E1, #0, #0)),
    (fl: CFT_COMMON; lc: #$01E2; uc: (#$01E3, #0, #0)),
    (fl: CFT_COMMON; lc: #$01E4; uc: (#$01E5, #0, #0)),
    (fl: CFT_COMMON; lc: #$01E6; uc: (#$01E7, #0, #0)),
    (fl: CFT_COMMON; lc: #$01E8; uc: (#$01E9, #0, #0)),
    (fl: CFT_COMMON; lc: #$01EA; uc: (#$01EB, #0, #0)),
    (fl: CFT_COMMON; lc: #$01EC; uc: (#$01ED, #0, #0)),
    (fl: CFT_COMMON; lc: #$01EE; uc: (#$01EF, #0, #0)),
    (fl: CFT_FULL;   lc: #$01F0; uc: (#$006A, #$030C, #0)),
    (fl: CFT_COMMON; lc: #$01F1; uc: (#$01F3, #0, #0)),
    (fl: CFT_COMMON; lc: #$01F2; uc: (#$01F3, #0, #0)),
    (fl: CFT_COMMON; lc: #$01F4; uc: (#$01F5, #0, #0)),
    (fl: CFT_COMMON; lc: #$01F6; uc: (#$0195, #0, #0)),
    (fl: CFT_COMMON; lc: #$01F7; uc: (#$01BF, #0, #0)),
    (fl: CFT_COMMON; lc: #$01F8; uc: (#$01F9, #0, #0)),
    (fl: CFT_COMMON; lc: #$01FA; uc: (#$01FB, #0, #0)),
    (fl: CFT_COMMON; lc: #$01FC; uc: (#$01FD, #0, #0)),
    (fl: CFT_COMMON; lc: #$01FE; uc: (#$01FF, #0, #0)),
    (fl: CFT_COMMON; lc: #$0200; uc: (#$0201, #0, #0)),
    (fl: CFT_COMMON; lc: #$0202; uc: (#$0203, #0, #0)),
    (fl: CFT_COMMON; lc: #$0204; uc: (#$0205, #0, #0)),
    (fl: CFT_COMMON; lc: #$0206; uc: (#$0207, #0, #0)),
    (fl: CFT_COMMON; lc: #$0208; uc: (#$0209, #0, #0)),
    (fl: CFT_COMMON; lc: #$020A; uc: (#$020B, #0, #0)),
    (fl: CFT_COMMON; lc: #$020C; uc: (#$020D, #0, #0)),
    (fl: CFT_COMMON; lc: #$020E; uc: (#$020F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0210; uc: (#$0211, #0, #0)),
    (fl: CFT_COMMON; lc: #$0212; uc: (#$0213, #0, #0)),
    (fl: CFT_COMMON; lc: #$0214; uc: (#$0215, #0, #0)),
    (fl: CFT_COMMON; lc: #$0216; uc: (#$0217, #0, #0)),
    (fl: CFT_COMMON; lc: #$0218; uc: (#$0219, #0, #0)),
    (fl: CFT_COMMON; lc: #$021A; uc: (#$021B, #0, #0)),
    (fl: CFT_COMMON; lc: #$021C; uc: (#$021D, #0, #0)),
    (fl: CFT_COMMON; lc: #$021E; uc: (#$021F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0222; uc: (#$0223, #0, #0)),
    (fl: CFT_COMMON; lc: #$0224; uc: (#$0225, #0, #0)),
    (fl: CFT_COMMON; lc: #$0226; uc: (#$0227, #0, #0)),
    (fl: CFT_COMMON; lc: #$0228; uc: (#$0229, #0, #0)),
    (fl: CFT_COMMON; lc: #$022A; uc: (#$022B, #0, #0)),
    (fl: CFT_COMMON; lc: #$022C; uc: (#$022D, #0, #0)),
    (fl: CFT_COMMON; lc: #$022E; uc: (#$022F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0230; uc: (#$0231, #0, #0)),
    (fl: CFT_COMMON; lc: #$0232; uc: (#$0233, #0, #0)),
    (fl: CFT_COMMON; lc: #$0386; uc: (#$03AC, #0, #0)),
    (fl: CFT_COMMON; lc: #$0388; uc: (#$03AD, #0, #0)),
    (fl: CFT_COMMON; lc: #$0389; uc: (#$03AE, #0, #0)),
    (fl: CFT_COMMON; lc: #$038A; uc: (#$03AF, #0, #0)),
    (fl: CFT_COMMON; lc: #$038C; uc: (#$03CC, #0, #0)),
    (fl: CFT_COMMON; lc: #$038E; uc: (#$03CD, #0, #0)),
    (fl: CFT_COMMON; lc: #$038F; uc: (#$03CE, #0, #0)),
    (fl: CFT_FULL; lc: #$0390; uc: (#$03B9, #$0308, #$0301)),
    (fl: CFT_COMMON; lc: #$0391; uc: (#$03B1, #0, #0)),
    (fl: CFT_COMMON; lc: #$0392; uc: (#$03B2, #0, #0)),
    (fl: CFT_COMMON; lc: #$0393; uc: (#$03B3, #0, #0)),
    (fl: CFT_COMMON; lc: #$0394; uc: (#$03B4, #0, #0)),
    (fl: CFT_COMMON; lc: #$0395; uc: (#$03B5, #0, #0)),
    (fl: CFT_COMMON; lc: #$0396; uc: (#$03B6, #0, #0)),
    (fl: CFT_COMMON; lc: #$0397; uc: (#$03B7, #0, #0)),
    (fl: CFT_COMMON; lc: #$0398; uc: (#$03B8, #0, #0)),
    (fl: CFT_COMMON; lc: #$0399; uc: (#$03B9, #0, #0)),
    (fl: CFT_COMMON; lc: #$0345; uc: (#$03B9, #0, #0)),
    (fl: CFT_COMMON; lc: #$0399; uc: (#$0345, #0, #0)),
    (fl: CFT_COMMON; lc: #$039A; uc: (#$03BA, #0, #0)),
    (fl: CFT_COMMON; lc: #$039B; uc: (#$03BB, #0, #0)),
    (fl: CFT_COMMON; lc: #$039C; uc: (#$03BC, #0, #0)),
    (fl: CFT_COMMON; lc: #$00B5; uc: (#$03BC, #0, #0)),
    (fl: CFT_COMMON; lc: #$039C; uc: (#$00B5, #0, #0)),
    (fl: CFT_COMMON; lc: #$039D; uc: (#$03BD, #0, #0)),
    (fl: CFT_COMMON; lc: #$039E; uc: (#$03BE, #0, #0)),
    (fl: CFT_COMMON; lc: #$039F; uc: (#$03BF, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A0; uc: (#$03C0, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A1; uc: (#$03C1, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A3; uc: (#$03C3, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A4; uc: (#$03C4, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A5; uc: (#$03C5, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A6; uc: (#$03C6, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A7; uc: (#$03C7, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A8; uc: (#$03C8, #0, #0)),
    (fl: CFT_COMMON; lc: #$03A9; uc: (#$03C9, #0, #0)),
    (fl: CFT_COMMON; lc: #$03AA; uc: (#$03CA, #0, #0)),
    (fl: CFT_COMMON; lc: #$03AB; uc: (#$03CB, #0, #0)),
    (fl: CFT_FULL; lc: #$03B0; uc: (#$03C5, #$0308, #$0301)),
    (fl: CFT_COMMON; lc: #$03C2; uc: (#$03C3, #0, #0)),
    (fl: CFT_COMMON; lc: #$03D0; uc: (#$03B2, #0, #0)),
    (fl: CFT_COMMON; lc: #$03D1; uc: (#$03B8, #0, #0)),
    (fl: CFT_COMMON; lc: #$03D5; uc: (#$03C6, #0, #0)),
    (fl: CFT_COMMON; lc: #$03D6; uc: (#$03C0, #0, #0)),
    (fl: CFT_COMMON; lc: #$03DA; uc: (#$03DB, #0, #0)),
    (fl: CFT_COMMON; lc: #$03DC; uc: (#$03DD, #0, #0)),
    (fl: CFT_COMMON; lc: #$03DE; uc: (#$03DF, #0, #0)),
    (fl: CFT_COMMON; lc: #$03E0; uc: (#$03E1, #0, #0)),
    (fl: CFT_COMMON; lc: #$03E2; uc: (#$03E3, #0, #0)),
    (fl: CFT_COMMON; lc: #$03E4; uc: (#$03E5, #0, #0)),
    (fl: CFT_COMMON; lc: #$03E6; uc: (#$03E7, #0, #0)),
    (fl: CFT_COMMON; lc: #$03E8; uc: (#$03E9, #0, #0)),
    (fl: CFT_COMMON; lc: #$03EA; uc: (#$03EB, #0, #0)),
    (fl: CFT_COMMON; lc: #$03EC; uc: (#$03ED, #0, #0)),
    (fl: CFT_COMMON; lc: #$03EE; uc: (#$03EF, #0, #0)),
    (fl: CFT_COMMON; lc: #$03F0; uc: (#$03BA, #0, #0)),
    (fl: CFT_COMMON; lc: #$03F1; uc: (#$03C1, #0, #0)),
    (fl: CFT_COMMON; lc: #$03F2; uc: (#$03C3, #0, #0)),
    (fl: CFT_COMMON; lc: #$03F4; uc: (#$03B8, #0, #0)),
    (fl: CFT_COMMON; lc: #$03F5; uc: (#$03B5, #0, #0)),
    (fl: CFT_COMMON; lc: #$0400; uc: (#$0450, #0, #0)),
    (fl: CFT_COMMON; lc: #$0401; uc: (#$0451, #0, #0)),
    (fl: CFT_COMMON; lc: #$0402; uc: (#$0452, #0, #0)),
    (fl: CFT_COMMON; lc: #$0403; uc: (#$0453, #0, #0)),
    (fl: CFT_COMMON; lc: #$0404; uc: (#$0454, #0, #0)),
    (fl: CFT_COMMON; lc: #$0405; uc: (#$0455, #0, #0)),
    (fl: CFT_COMMON; lc: #$0406; uc: (#$0456, #0, #0)),
    (fl: CFT_COMMON; lc: #$0407; uc: (#$0457, #0, #0)),
    (fl: CFT_COMMON; lc: #$0408; uc: (#$0458, #0, #0)),
    (fl: CFT_COMMON; lc: #$0409; uc: (#$0459, #0, #0)),
    (fl: CFT_COMMON; lc: #$040A; uc: (#$045A, #0, #0)),
    (fl: CFT_COMMON; lc: #$040B; uc: (#$045B, #0, #0)),
    (fl: CFT_COMMON; lc: #$040C; uc: (#$045C, #0, #0)),
    (fl: CFT_COMMON; lc: #$040D; uc: (#$045D, #0, #0)),
    (fl: CFT_COMMON; lc: #$040E; uc: (#$045E, #0, #0)),
    (fl: CFT_COMMON; lc: #$040F; uc: (#$045F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0410; uc: (#$0430, #0, #0)),
    (fl: CFT_COMMON; lc: #$0411; uc: (#$0431, #0, #0)),
    (fl: CFT_COMMON; lc: #$0412; uc: (#$0432, #0, #0)),
    (fl: CFT_COMMON; lc: #$0413; uc: (#$0433, #0, #0)),
    (fl: CFT_COMMON; lc: #$0414; uc: (#$0434, #0, #0)),
    (fl: CFT_COMMON; lc: #$0415; uc: (#$0435, #0, #0)),
    (fl: CFT_COMMON; lc: #$0416; uc: (#$0436, #0, #0)),
    (fl: CFT_COMMON; lc: #$0417; uc: (#$0437, #0, #0)),
    (fl: CFT_COMMON; lc: #$0418; uc: (#$0438, #0, #0)),
    (fl: CFT_COMMON; lc: #$0419; uc: (#$0439, #0, #0)),
    (fl: CFT_COMMON; lc: #$041A; uc: (#$043A, #0, #0)),
    (fl: CFT_COMMON; lc: #$041B; uc: (#$043B, #0, #0)),
    (fl: CFT_COMMON; lc: #$041C; uc: (#$043C, #0, #0)),
    (fl: CFT_COMMON; lc: #$041D; uc: (#$043D, #0, #0)),
    (fl: CFT_COMMON; lc: #$041E; uc: (#$043E, #0, #0)),
    (fl: CFT_COMMON; lc: #$041F; uc: (#$043F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0420; uc: (#$0440, #0, #0)),
    (fl: CFT_COMMON; lc: #$0421; uc: (#$0441, #0, #0)),
    (fl: CFT_COMMON; lc: #$0422; uc: (#$0442, #0, #0)),
    (fl: CFT_COMMON; lc: #$0423; uc: (#$0443, #0, #0)),
    (fl: CFT_COMMON; lc: #$0424; uc: (#$0444, #0, #0)),
    (fl: CFT_COMMON; lc: #$0425; uc: (#$0445, #0, #0)),
    (fl: CFT_COMMON; lc: #$0426; uc: (#$0446, #0, #0)),
    (fl: CFT_COMMON; lc: #$0427; uc: (#$0447, #0, #0)),
    (fl: CFT_COMMON; lc: #$0428; uc: (#$0448, #0, #0)),
    (fl: CFT_COMMON; lc: #$0429; uc: (#$0449, #0, #0)),
    (fl: CFT_COMMON; lc: #$042A; uc: (#$044A, #0, #0)),
    (fl: CFT_COMMON; lc: #$042B; uc: (#$044B, #0, #0)),
    (fl: CFT_COMMON; lc: #$042C; uc: (#$044C, #0, #0)),
    (fl: CFT_COMMON; lc: #$042D; uc: (#$044D, #0, #0)),
    (fl: CFT_COMMON; lc: #$042E; uc: (#$044E, #0, #0)),
    (fl: CFT_COMMON; lc: #$042F; uc: (#$044F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0460; uc: (#$0461, #0, #0)),
    (fl: CFT_COMMON; lc: #$0462; uc: (#$0463, #0, #0)),
    (fl: CFT_COMMON; lc: #$0464; uc: (#$0465, #0, #0)),
    (fl: CFT_COMMON; lc: #$0466; uc: (#$0467, #0, #0)),
    (fl: CFT_COMMON; lc: #$0468; uc: (#$0469, #0, #0)),
    (fl: CFT_COMMON; lc: #$046A; uc: (#$046B, #0, #0)),
    (fl: CFT_COMMON; lc: #$046C; uc: (#$046D, #0, #0)),
    (fl: CFT_COMMON; lc: #$046E; uc: (#$046F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0470; uc: (#$0471, #0, #0)),
    (fl: CFT_COMMON; lc: #$0472; uc: (#$0473, #0, #0)),
    (fl: CFT_COMMON; lc: #$0474; uc: (#$0475, #0, #0)),
    (fl: CFT_COMMON; lc: #$0476; uc: (#$0477, #0, #0)),
    (fl: CFT_COMMON; lc: #$0478; uc: (#$0479, #0, #0)),
    (fl: CFT_COMMON; lc: #$047A; uc: (#$047B, #0, #0)),
    (fl: CFT_COMMON; lc: #$047C; uc: (#$047D, #0, #0)),
    (fl: CFT_COMMON; lc: #$047E; uc: (#$047F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0480; uc: (#$0481, #0, #0)),
    (fl: CFT_COMMON; lc: #$048C; uc: (#$048D, #0, #0)),
    (fl: CFT_COMMON; lc: #$048E; uc: (#$048F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0490; uc: (#$0491, #0, #0)),
    (fl: CFT_COMMON; lc: #$0492; uc: (#$0493, #0, #0)),
    (fl: CFT_COMMON; lc: #$0494; uc: (#$0495, #0, #0)),
    (fl: CFT_COMMON; lc: #$0496; uc: (#$0497, #0, #0)),
    (fl: CFT_COMMON; lc: #$0498; uc: (#$0499, #0, #0)),
    (fl: CFT_COMMON; lc: #$049A; uc: (#$049B, #0, #0)),
    (fl: CFT_COMMON; lc: #$049C; uc: (#$049D, #0, #0)),
    (fl: CFT_COMMON; lc: #$049E; uc: (#$049F, #0, #0)),
    (fl: CFT_COMMON; lc: #$04A0; uc: (#$04A1, #0, #0)),
    (fl: CFT_COMMON; lc: #$04A2; uc: (#$04A3, #0, #0)),
    (fl: CFT_COMMON; lc: #$04A4; uc: (#$04A5, #0, #0)),
    (fl: CFT_COMMON; lc: #$04A6; uc: (#$04A7, #0, #0)),
    (fl: CFT_COMMON; lc: #$04A8; uc: (#$04A9, #0, #0)),
    (fl: CFT_COMMON; lc: #$04AA; uc: (#$04AB, #0, #0)),
    (fl: CFT_COMMON; lc: #$04AC; uc: (#$04AD, #0, #0)),
    (fl: CFT_COMMON; lc: #$04AE; uc: (#$04AF, #0, #0)),
    (fl: CFT_COMMON; lc: #$04B0; uc: (#$04B1, #0, #0)),
    (fl: CFT_COMMON; lc: #$04B2; uc: (#$04B3, #0, #0)),
    (fl: CFT_COMMON; lc: #$04B4; uc: (#$04B5, #0, #0)),
    (fl: CFT_COMMON; lc: #$04B6; uc: (#$04B7, #0, #0)),
    (fl: CFT_COMMON; lc: #$04B8; uc: (#$04B9, #0, #0)),
    (fl: CFT_COMMON; lc: #$04BA; uc: (#$04BB, #0, #0)),
    (fl: CFT_COMMON; lc: #$04BC; uc: (#$04BD, #0, #0)),
    (fl: CFT_COMMON; lc: #$04BE; uc: (#$04BF, #0, #0)),
    (fl: CFT_COMMON; lc: #$04C1; uc: (#$04C2, #0, #0)),
    (fl: CFT_COMMON; lc: #$04C3; uc: (#$04C4, #0, #0)),
    (fl: CFT_COMMON; lc: #$04C7; uc: (#$04C8, #0, #0)),
    (fl: CFT_COMMON; lc: #$04CB; uc: (#$04CC, #0, #0)),
    (fl: CFT_COMMON; lc: #$04D0; uc: (#$04D1, #0, #0)),
    (fl: CFT_COMMON; lc: #$04D2; uc: (#$04D3, #0, #0)),
    (fl: CFT_COMMON; lc: #$04D4; uc: (#$04D5, #0, #0)),
    (fl: CFT_COMMON; lc: #$04D6; uc: (#$04D7, #0, #0)),
    (fl: CFT_COMMON; lc: #$04D8; uc: (#$04D9, #0, #0)),
    (fl: CFT_COMMON; lc: #$04DA; uc: (#$04DB, #0, #0)),
    (fl: CFT_COMMON; lc: #$04DC; uc: (#$04DD, #0, #0)),
    (fl: CFT_COMMON; lc: #$04DE; uc: (#$04DF, #0, #0)),
    (fl: CFT_COMMON; lc: #$04E0; uc: (#$04E1, #0, #0)),
    (fl: CFT_COMMON; lc: #$04E2; uc: (#$04E3, #0, #0)),
    (fl: CFT_COMMON; lc: #$04E4; uc: (#$04E5, #0, #0)),
    (fl: CFT_COMMON; lc: #$04E6; uc: (#$04E7, #0, #0)),
    (fl: CFT_COMMON; lc: #$04E8; uc: (#$04E9, #0, #0)),
    (fl: CFT_COMMON; lc: #$04EA; uc: (#$04EB, #0, #0)),
    (fl: CFT_COMMON; lc: #$04EC; uc: (#$04ED, #0, #0)),
    (fl: CFT_COMMON; lc: #$04EE; uc: (#$04EF, #0, #0)),
    (fl: CFT_COMMON; lc: #$04F0; uc: (#$04F1, #0, #0)),
    (fl: CFT_COMMON; lc: #$04F2; uc: (#$04F3, #0, #0)),
    (fl: CFT_COMMON; lc: #$04F4; uc: (#$04F5, #0, #0)),
    (fl: CFT_COMMON; lc: #$04F8; uc: (#$04F9, #0, #0)),
    (fl: CFT_COMMON; lc: #$0531; uc: (#$0561, #0, #0)),
    (fl: CFT_COMMON; lc: #$0532; uc: (#$0562, #0, #0)),
    (fl: CFT_COMMON; lc: #$0533; uc: (#$0563, #0, #0)),
    (fl: CFT_COMMON; lc: #$0534; uc: (#$0564, #0, #0)),
    (fl: CFT_COMMON; lc: #$0535; uc: (#$0565, #0, #0)),
    (fl: CFT_COMMON; lc: #$0536; uc: (#$0566, #0, #0)),
    (fl: CFT_COMMON; lc: #$0537; uc: (#$0567, #0, #0)),
    (fl: CFT_COMMON; lc: #$0538; uc: (#$0568, #0, #0)),
    (fl: CFT_COMMON; lc: #$0539; uc: (#$0569, #0, #0)),
    (fl: CFT_COMMON; lc: #$053A; uc: (#$056A, #0, #0)),
    (fl: CFT_COMMON; lc: #$053B; uc: (#$056B, #0, #0)),
    (fl: CFT_COMMON; lc: #$053C; uc: (#$056C, #0, #0)),
    (fl: CFT_COMMON; lc: #$053D; uc: (#$056D, #0, #0)),
    (fl: CFT_COMMON; lc: #$053E; uc: (#$056E, #0, #0)),
    (fl: CFT_COMMON; lc: #$053F; uc: (#$056F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0540; uc: (#$0570, #0, #0)),
    (fl: CFT_COMMON; lc: #$0541; uc: (#$0571, #0, #0)),
    (fl: CFT_COMMON; lc: #$0542; uc: (#$0572, #0, #0)),
    (fl: CFT_COMMON; lc: #$0543; uc: (#$0573, #0, #0)),
    (fl: CFT_COMMON; lc: #$0544; uc: (#$0574, #0, #0)),
    (fl: CFT_COMMON; lc: #$0545; uc: (#$0575, #0, #0)),
    (fl: CFT_COMMON; lc: #$0546; uc: (#$0576, #0, #0)),
    (fl: CFT_COMMON; lc: #$0547; uc: (#$0577, #0, #0)),
    (fl: CFT_COMMON; lc: #$0548; uc: (#$0578, #0, #0)),
    (fl: CFT_COMMON; lc: #$0549; uc: (#$0579, #0, #0)),
    (fl: CFT_COMMON; lc: #$054A; uc: (#$057A, #0, #0)),
    (fl: CFT_COMMON; lc: #$054B; uc: (#$057B, #0, #0)),
    (fl: CFT_COMMON; lc: #$054C; uc: (#$057C, #0, #0)),
    (fl: CFT_COMMON; lc: #$054D; uc: (#$057D, #0, #0)),
    (fl: CFT_COMMON; lc: #$054E; uc: (#$057E, #0, #0)),
    (fl: CFT_COMMON; lc: #$054F; uc: (#$057F, #0, #0)),
    (fl: CFT_COMMON; lc: #$0550; uc: (#$0580, #0, #0)),
    (fl: CFT_COMMON; lc: #$0551; uc: (#$0581, #0, #0)),
    (fl: CFT_COMMON; lc: #$0552; uc: (#$0582, #0, #0)),
    (fl: CFT_COMMON; lc: #$0553; uc: (#$0583, #0, #0)),
    (fl: CFT_COMMON; lc: #$0554; uc: (#$0584, #0, #0)),
    (fl: CFT_COMMON; lc: #$0555; uc: (#$0585, #0, #0)),
    (fl: CFT_COMMON; lc: #$0556; uc: (#$0586, #0, #0)),
    (fl: CFT_FULL; lc: #$0587; uc: (#$0565, #$0582, #0)),
    (fl: CFT_COMMON; lc: #$1E00; uc: (#$1E01, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E02; uc: (#$1E03, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E04; uc: (#$1E05, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E06; uc: (#$1E07, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E08; uc: (#$1E09, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E0A; uc: (#$1E0B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E0C; uc: (#$1E0D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E0E; uc: (#$1E0F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E10; uc: (#$1E11, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E12; uc: (#$1E13, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E14; uc: (#$1E15, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E16; uc: (#$1E17, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E18; uc: (#$1E19, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E1A; uc: (#$1E1B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E1C; uc: (#$1E1D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E1E; uc: (#$1E1F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E20; uc: (#$1E21, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E22; uc: (#$1E23, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E24; uc: (#$1E25, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E26; uc: (#$1E27, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E28; uc: (#$1E29, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E2A; uc: (#$1E2B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E2C; uc: (#$1E2D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E2E; uc: (#$1E2F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E30; uc: (#$1E31, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E32; uc: (#$1E33, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E34; uc: (#$1E35, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E36; uc: (#$1E37, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E38; uc: (#$1E39, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E3A; uc: (#$1E3B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E3C; uc: (#$1E3D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E3E; uc: (#$1E3F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E40; uc: (#$1E41, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E42; uc: (#$1E43, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E44; uc: (#$1E45, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E46; uc: (#$1E47, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E48; uc: (#$1E49, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E4A; uc: (#$1E4B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E4C; uc: (#$1E4D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E4E; uc: (#$1E4F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E50; uc: (#$1E51, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E52; uc: (#$1E53, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E54; uc: (#$1E55, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E56; uc: (#$1E57, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E58; uc: (#$1E59, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E5A; uc: (#$1E5B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E5C; uc: (#$1E5D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E5E; uc: (#$1E5F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E60; uc: (#$1E61, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E62; uc: (#$1E63, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E64; uc: (#$1E65, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E66; uc: (#$1E67, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E68; uc: (#$1E69, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E6A; uc: (#$1E6B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E6C; uc: (#$1E6D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E6E; uc: (#$1E6F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E70; uc: (#$1E71, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E72; uc: (#$1E73, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E74; uc: (#$1E75, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E76; uc: (#$1E77, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E78; uc: (#$1E79, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E7A; uc: (#$1E7B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E7C; uc: (#$1E7D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E7E; uc: (#$1E7F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E80; uc: (#$1E81, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E82; uc: (#$1E83, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E84; uc: (#$1E85, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E86; uc: (#$1E87, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E88; uc: (#$1E89, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E8A; uc: (#$1E8B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E8C; uc: (#$1E8D, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E8E; uc: (#$1E8F, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E90; uc: (#$1E91, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E92; uc: (#$1E93, #0, #0)),
    (fl: CFT_COMMON; lc: #$1E94; uc: (#$1E95, #0, #0)),
    (fl: CFT_FULL; lc: #$1E96; uc: (#$0068, #$0331, #0)),
    (fl: CFT_FULL; lc: #$1E97; uc: (#$0074, #$0308, #0)),
    (fl: CFT_FULL; lc: #$1E98; uc: (#$0077, #$030A, #0)),
    (fl: CFT_FULL; lc: #$1E99; uc: (#$0079, #$030A, #0)),
    (fl: CFT_FULL; lc: #$1E9A; uc: (#$0061, #$02BE, #0)),
    (fl: CFT_COMMON; lc: #$1E9B; uc: (#$1E61, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EA0; uc: (#$1EA1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EA2; uc: (#$1EA3, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EA4; uc: (#$1EA5, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EA6; uc: (#$1EA7, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EA8; uc: (#$1EA9, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EAA; uc: (#$1EAB, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EAC; uc: (#$1EAD, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EAE; uc: (#$1EAF, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EB0; uc: (#$1EB1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EB2; uc: (#$1EB3, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EB4; uc: (#$1EB5, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EB6; uc: (#$1EB7, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EB8; uc: (#$1EB9, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EBA; uc: (#$1EBB, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EBC; uc: (#$1EBD, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EBE; uc: (#$1EBF, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EC0; uc: (#$1EC1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EC2; uc: (#$1EC3, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EC4; uc: (#$1EC5, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EC6; uc: (#$1EC7, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EC8; uc: (#$1EC9, #0, #0)),
    (fl: CFT_COMMON; lc: #$1ECA; uc: (#$1ECB, #0, #0)),
    (fl: CFT_COMMON; lc: #$1ECC; uc: (#$1ECD, #0, #0)),
    (fl: CFT_COMMON; lc: #$1ECE; uc: (#$1ECF, #0, #0)),
    (fl: CFT_COMMON; lc: #$1ED0; uc: (#$1ED1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1ED2; uc: (#$1ED3, #0, #0)),
    (fl: CFT_COMMON; lc: #$1ED4; uc: (#$1ED5, #0, #0)),
    (fl: CFT_COMMON; lc: #$1ED6; uc: (#$1ED7, #0, #0)),
    (fl: CFT_COMMON; lc: #$1ED8; uc: (#$1ED9, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EDA; uc: (#$1EDB, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EDC; uc: (#$1EDD, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EDE; uc: (#$1EDF, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EE0; uc: (#$1EE1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EE2; uc: (#$1EE3, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EE4; uc: (#$1EE5, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EE6; uc: (#$1EE7, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EE8; uc: (#$1EE9, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EEA; uc: (#$1EEB, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EEC; uc: (#$1EED, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EEE; uc: (#$1EEF, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EF0; uc: (#$1EF1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EF2; uc: (#$1EF3, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EF4; uc: (#$1EF5, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EF6; uc: (#$1EF7, #0, #0)),
    (fl: CFT_COMMON; lc: #$1EF8; uc: (#$1EF9, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F08; uc: (#$1F00, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F09; uc: (#$1F01, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F0A; uc: (#$1F02, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F0B; uc: (#$1F03, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F0C; uc: (#$1F04, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F0D; uc: (#$1F05, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F0E; uc: (#$1F06, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F0F; uc: (#$1F07, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F18; uc: (#$1F10, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F19; uc: (#$1F11, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F1A; uc: (#$1F12, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F1B; uc: (#$1F13, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F1C; uc: (#$1F14, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F1D; uc: (#$1F15, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F28; uc: (#$1F20, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F29; uc: (#$1F21, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F2A; uc: (#$1F22, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F2B; uc: (#$1F23, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F2C; uc: (#$1F24, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F2D; uc: (#$1F25, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F2E; uc: (#$1F26, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F2F; uc: (#$1F27, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F38; uc: (#$1F30, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F39; uc: (#$1F31, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F3A; uc: (#$1F32, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F3B; uc: (#$1F33, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F3C; uc: (#$1F34, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F3D; uc: (#$1F35, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F3E; uc: (#$1F36, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F3F; uc: (#$1F37, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F48; uc: (#$1F40, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F49; uc: (#$1F41, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F4A; uc: (#$1F42, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F4B; uc: (#$1F43, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F4C; uc: (#$1F44, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F4D; uc: (#$1F45, #0, #0)),
    (fl: CFT_FULL; lc: #$1F50; uc: (#$03C5, #$0313, #0)),
    (fl: CFT_FULL; lc: #$1F52; uc: (#$03C5, #$0313, #$0300)),
    (fl: CFT_FULL; lc: #$1F54; uc: (#$03C5, #$0313, #$0301)),
    (fl: CFT_FULL; lc: #$1F56; uc: (#$03C5, #$0313, #$0342)),
    (fl: CFT_COMMON; lc: #$1F59; uc: (#$1F51, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F5B; uc: (#$1F53, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F5D; uc: (#$1F55, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F5F; uc: (#$1F57, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F68; uc: (#$1F60, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F69; uc: (#$1F61, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F6A; uc: (#$1F62, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F6B; uc: (#$1F63, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F6C; uc: (#$1F64, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F6D; uc: (#$1F65, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F6E; uc: (#$1F66, #0, #0)),
    (fl: CFT_COMMON; lc: #$1F6F; uc: (#$1F67, #0, #0)),
    (fl: CFT_FULL; lc: #$1F80; uc: (#$1F00, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F81; uc: (#$1F01, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F82; uc: (#$1F02, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F83; uc: (#$1F03, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F84; uc: (#$1F04, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F85; uc: (#$1F05, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F86; uc: (#$1F06, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F87; uc: (#$1F07, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F88; uc: (#$1F00, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F88; uc: (#$1F80, #0, #0)),
    (fl: CFT_FULL; lc: #$1F89; uc: (#$1F01, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F89; uc: (#$1F81, #0, #0)),
    (fl: CFT_FULL; lc: #$1F8A; uc: (#$1F02, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F8A; uc: (#$1F82, #0, #0)),
    (fl: CFT_FULL; lc: #$1F8B; uc: (#$1F03, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F8B; uc: (#$1F83, #0, #0)),
    (fl: CFT_FULL; lc: #$1F8C; uc: (#$1F04, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F8C; uc: (#$1F84, #0, #0)),
    (fl: CFT_FULL; lc: #$1F8D; uc: (#$1F05, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F8D; uc: (#$1F85, #0, #0)),
    (fl: CFT_FULL; lc: #$1F8E; uc: (#$1F06, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F8E; uc: (#$1F86, #0, #0)),
    (fl: CFT_FULL; lc: #$1F8F; uc: (#$1F07, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F8F; uc: (#$1F87, #0, #0)),
    (fl: CFT_FULL; lc: #$1F90; uc: (#$1F20, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F91; uc: (#$1F21, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F92; uc: (#$1F22, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F93; uc: (#$1F23, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F94; uc: (#$1F24, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F95; uc: (#$1F25, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F96; uc: (#$1F26, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F97; uc: (#$1F27, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1F98; uc: (#$1F20, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F98; uc: (#$1F90, #0, #0)),
    (fl: CFT_FULL; lc: #$1F99; uc: (#$1F21, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F99; uc: (#$1F91, #0, #0)),
    (fl: CFT_FULL; lc: #$1F9A; uc: (#$1F22, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F9A; uc: (#$1F92, #0, #0)),
    (fl: CFT_FULL; lc: #$1F9B; uc: (#$1F23, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F9B; uc: (#$1F93, #0, #0)),
    (fl: CFT_FULL; lc: #$1F9C; uc: (#$1F24, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F9C; uc: (#$1F94, #0, #0)),
    (fl: CFT_FULL; lc: #$1F9D; uc: (#$1F25, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F9D; uc: (#$1F95, #0, #0)),
    (fl: CFT_FULL; lc: #$1F9E; uc: (#$1F26, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F9E; uc: (#$1F96, #0, #0)),
    (fl: CFT_FULL; lc: #$1F9F; uc: (#$1F27, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1F9F; uc: (#$1F97, #0, #0)),
    (fl: CFT_FULL; lc: #$1FA0; uc: (#$1F60, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FA1; uc: (#$1F61, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FA2; uc: (#$1F62, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FA3; uc: (#$1F63, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FA4; uc: (#$1F64, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FA5; uc: (#$1F65, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FA6; uc: (#$1F66, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FA7; uc: (#$1F67, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FA8; uc: (#$1F60, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FA8; uc: (#$1FA0, #0, #0)),
    (fl: CFT_FULL; lc: #$1FA9; uc: (#$1F61, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FA9; uc: (#$1FA1, #0, #0)),
    (fl: CFT_FULL; lc: #$1FAA; uc: (#$1F62, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FAA; uc: (#$1FA2, #0, #0)),
    (fl: CFT_FULL; lc: #$1FAB; uc: (#$1F63, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FAB; uc: (#$1FA3, #0, #0)),
    (fl: CFT_FULL; lc: #$1FAC; uc: (#$1F64, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FAC; uc: (#$1FA4, #0, #0)),
    (fl: CFT_FULL; lc: #$1FAD; uc: (#$1F65, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FAD; uc: (#$1FA5, #0, #0)),
    (fl: CFT_FULL; lc: #$1FAE; uc: (#$1F66, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FAE; uc: (#$1FA6, #0, #0)),
    (fl: CFT_FULL; lc: #$1FAF; uc: (#$1F67, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FAF; uc: (#$1FA7, #0, #0)),
    (fl: CFT_FULL; lc: #$1FB2; uc: (#$1F70, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FB3; uc: (#$03B1, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FB4; uc: (#$03AC, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FB6; uc: (#$03B1, #$0342, #0)),
    (fl: CFT_FULL; lc: #$1FB7; uc: (#$03B1, #$0342, #$03B9)),
    (fl: CFT_COMMON; lc: #$1FB8; uc: (#$1FB0, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FB9; uc: (#$1FB1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FBA; uc: (#$1F70, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FBB; uc: (#$1F71, #0, #0)),
    (fl: CFT_FULL; lc: #$1FBC; uc: (#$03B1, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FBC; uc: (#$1FB3, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FBE; uc: (#$03B9, #0, #0)),
    (fl: CFT_FULL; lc: #$1FC2; uc: (#$1F74, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FC3; uc: (#$03B7, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FC4; uc: (#$03AE, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FC6; uc: (#$03B7, #$0342, #0)),
    (fl: CFT_FULL; lc: #$1FC7; uc: (#$03B7, #$0342, #$03B9)),
    (fl: CFT_COMMON; lc: #$1FC8; uc: (#$1F72, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FC9; uc: (#$1F73, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FCA; uc: (#$1F74, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FCB; uc: (#$1F75, #0, #0)),
    (fl: CFT_FULL; lc: #$1FCC; uc: (#$03B7, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FCC; uc: (#$1FC3, #0, #0)),
    (fl: CFT_FULL; lc: #$1FD2; uc: (#$03B9, #$0308, #$0300)),
    (fl: CFT_FULL; lc: #$1FD3; uc: (#$03B9, #$0308, #$0301)),
    (fl: CFT_FULL; lc: #$1FD6; uc: (#$03B9, #$0342, #0)),
    (fl: CFT_FULL; lc: #$1FD7; uc: (#$03B9, #$0308, #$0342)),
    (fl: CFT_COMMON; lc: #$1FD8; uc: (#$1FD0, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FD9; uc: (#$1FD1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FDA; uc: (#$1F76, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FDB; uc: (#$1F77, #0, #0)),
    (fl: CFT_FULL; lc: #$1FE2; uc: (#$03C5, #$0308, #$0300)),
    (fl: CFT_FULL; lc: #$1FE3; uc: (#$03C5, #$0308, #$0301)),
    (fl: CFT_FULL; lc: #$1FE4; uc: (#$03C1, #$0313, #0)),
    (fl: CFT_FULL; lc: #$1FE6; uc: (#$03C5, #$0342, #0)),
    (fl: CFT_FULL; lc: #$1FE7; uc: (#$03C5, #$0308, #$0342)),
    (fl: CFT_COMMON; lc: #$1FE8; uc: (#$1FE0, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FE9; uc: (#$1FE1, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FEA; uc: (#$1F7A, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FEB; uc: (#$1F7B, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FEC; uc: (#$1FE5, #0, #0)),
    (fl: CFT_FULL; lc: #$1FF2; uc: (#$1F7C, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FF3; uc: (#$03C9, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FF4; uc: (#$03CE, #$03B9, #0)),
    (fl: CFT_FULL; lc: #$1FF6; uc: (#$03C9, #$0342, #0)),
    (fl: CFT_FULL; lc: #$1FF7; uc: (#$03C9, #$0342, #$03B9)),
    (fl: CFT_COMMON; lc: #$1FF8; uc: (#$1F78, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FF9; uc: (#$1F79, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FFA; uc: (#$1F7C, #0, #0)),
    (fl: CFT_COMMON; lc: #$1FFB; uc: (#$1F7D, #0, #0)),
    (fl: CFT_FULL; lc: #$1FFC; uc: (#$03C9, #$03B9, #0)),
    (fl: CFT_SIMPLE; lc: #$1FFC; uc: (#$1FF3, #0, #0)),
    (fl: CFT_COMMON; lc: #$2126; uc: (#$03C9, #0, #0)),
    (fl: CFT_COMMON; lc: #$212A; uc: (#$006B, #0, #0)),
    (fl: CFT_COMMON; lc: #$212B; uc: (#$00E5, #0, #0)),
    (fl: CFT_COMMON; lc: #$2160; uc: (#$2170, #0, #0)),
    (fl: CFT_COMMON; lc: #$2161; uc: (#$2171, #0, #0)),
    (fl: CFT_COMMON; lc: #$2162; uc: (#$2172, #0, #0)),
    (fl: CFT_COMMON; lc: #$2163; uc: (#$2173, #0, #0)),
    (fl: CFT_COMMON; lc: #$2164; uc: (#$2174, #0, #0)),
    (fl: CFT_COMMON; lc: #$2165; uc: (#$2175, #0, #0)),
    (fl: CFT_COMMON; lc: #$2166; uc: (#$2176, #0, #0)),
    (fl: CFT_COMMON; lc: #$2167; uc: (#$2177, #0, #0)),
    (fl: CFT_COMMON; lc: #$2168; uc: (#$2178, #0, #0)),
    (fl: CFT_COMMON; lc: #$2169; uc: (#$2179, #0, #0)),
    (fl: CFT_COMMON; lc: #$216A; uc: (#$217A, #0, #0)),
    (fl: CFT_COMMON; lc: #$216B; uc: (#$217B, #0, #0)),
    (fl: CFT_COMMON; lc: #$216C; uc: (#$217C, #0, #0)),
    (fl: CFT_COMMON; lc: #$216D; uc: (#$217D, #0, #0)),
    (fl: CFT_COMMON; lc: #$216E; uc: (#$217E, #0, #0)),
    (fl: CFT_COMMON; lc: #$216F; uc: (#$217F, #0, #0)),
    (fl: CFT_COMMON; lc: #$24B6; uc: (#$24D0, #0, #0)),
    (fl: CFT_COMMON; lc: #$24B7; uc: (#$24D1, #0, #0)),
    (fl: CFT_COMMON; lc: #$24B8; uc: (#$24D2, #0, #0)),
    (fl: CFT_COMMON; lc: #$24B9; uc: (#$24D3, #0, #0)),
    (fl: CFT_COMMON; lc: #$24BA; uc: (#$24D4, #0, #0)),
    (fl: CFT_COMMON; lc: #$24BB; uc: (#$24D5, #0, #0)),
    (fl: CFT_COMMON; lc: #$24BC; uc: (#$24D6, #0, #0)),
    (fl: CFT_COMMON; lc: #$24BD; uc: (#$24D7, #0, #0)),
    (fl: CFT_COMMON; lc: #$24BE; uc: (#$24D8, #0, #0)),
    (fl: CFT_COMMON; lc: #$24BF; uc: (#$24D9, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C0; uc: (#$24DA, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C1; uc: (#$24DB, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C2; uc: (#$24DC, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C3; uc: (#$24DD, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C4; uc: (#$24DE, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C5; uc: (#$24DF, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C6; uc: (#$24E0, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C7; uc: (#$24E1, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C8; uc: (#$24E2, #0, #0)),
    (fl: CFT_COMMON; lc: #$24C9; uc: (#$24E3, #0, #0)),
    (fl: CFT_COMMON; lc: #$24CA; uc: (#$24E4, #0, #0)),
    (fl: CFT_COMMON; lc: #$24CB; uc: (#$24E5, #0, #0)),
    (fl: CFT_COMMON; lc: #$24CC; uc: (#$24E6, #0, #0)),
    (fl: CFT_COMMON; lc: #$24CD; uc: (#$24E7, #0, #0)),
    (fl: CFT_COMMON; lc: #$24CE; uc: (#$24E8, #0, #0)),
    (fl: CFT_COMMON; lc: #$24CF; uc: (#$24E9, #0, #0)),
    (fl: CFT_FULL; lc: #$FB00; uc: (#$0066, #$0066, #0)),
    (fl: CFT_FULL; lc: #$FB01; uc: (#$0066, #$0069, #0)),
    (fl: CFT_FULL; lc: #$FB02; uc: (#$0066, #$006C, #0)),
    (fl: CFT_FULL; lc: #$FB03; uc: (#$0066, #$0066, #$0069)),
    (fl: CFT_FULL; lc: #$FB04; uc: (#$0066, #$0066, #$006C)),
    (fl: CFT_FULL; lc: #$FB05; uc: (#$0073, #$0074, #0)),
    (fl: CFT_FULL; lc: #$FB06; uc: (#$0073, #$0074, #0)),
    (fl: CFT_FULL; lc: #$FB13; uc: (#$0574, #$0576, #0)),
    (fl: CFT_FULL; lc: #$FB14; uc: (#$0574, #$0565, #0)),
    (fl: CFT_FULL; lc: #$FB15; uc: (#$0574, #$056B, #0)),
    (fl: CFT_FULL; lc: #$FB16; uc: (#$057E, #$0576, #0)),
    (fl: CFT_FULL; lc: #$FB17; uc: (#$0574, #$056D, #0)),
    (fl: CFT_COMMON; lc: #$FF21; uc: (#$FF41, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF22; uc: (#$FF42, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF23; uc: (#$FF43, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF24; uc: (#$FF44, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF25; uc: (#$FF45, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF26; uc: (#$FF46, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF27; uc: (#$FF47, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF28; uc: (#$FF48, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF29; uc: (#$FF49, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF2A; uc: (#$FF4A, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF2B; uc: (#$FF4B, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF2C; uc: (#$FF4C, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF2D; uc: (#$FF4D, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF2E; uc: (#$FF4E, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF2F; uc: (#$FF4F, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF30; uc: (#$FF50, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF31; uc: (#$FF51, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF32; uc: (#$FF52, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF33; uc: (#$FF53, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF34; uc: (#$FF54, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF35; uc: (#$FF55, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF36; uc: (#$FF56, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF37; uc: (#$FF57, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF38; uc: (#$FF58, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF39; uc: (#$FF59, #0, #0)),
    (fl: CFT_COMMON; lc: #$FF3A; uc: (#$FF5A, #0, #0))
    );

{------------------------------------------------------------------------------}

  max_wtr = 673;
  wtr: array[1..max_wtr * 2] of WideChar = (
    #$0041, #$0061,
    #$0042, #$0062,
    #$0043, #$0063,
    #$0044, #$0064,
    #$0045, #$0065,
    #$0046, #$0066,
    #$0047, #$0067,
    #$0048, #$0068,
    #$0049, #$0069,
    #$004A, #$006A,
    #$004B, #$006B,
    #$004C, #$006C,
    #$004D, #$006D,
    #$004E, #$006E,
    #$004F, #$006F,
    #$0050, #$0070,
    #$0051, #$0071,
    #$0052, #$0072,
    #$0053, #$0073,
    #$0054, #$0074,
    #$0055, #$0075,
    #$0056, #$0076,
    #$0057, #$0077,
    #$0058, #$0078,
    #$0059, #$0079,
    #$005A, #$007A,
    #$00C0, #$00E0,
    #$00C1, #$00E1,
    #$00C2, #$00E2,
    #$00C3, #$00E3,
    #$00C4, #$00E4,
    #$00C5, #$00E5,
    #$00C6, #$00E6,
    #$00C7, #$00E7,
    #$00C8, #$00E8,
    #$00C9, #$00E9,
    #$00CA, #$00EA,
    #$00CB, #$00EB,
    #$00CC, #$00EC,
    #$00CD, #$00ED,
    #$00CE, #$00EE,
    #$00CF, #$00EF,
    #$00D0, #$00F0,
    #$00D1, #$00F1,
    #$00D2, #$00F2,
    #$00D3, #$00F3,
    #$00D4, #$00F4,
    #$00D5, #$00F5,
    #$00D6, #$00F6,
    #$00D8, #$00F8,
    #$00D9, #$00F9,
    #$00DA, #$00FA,
    #$00DB, #$00FB,
    #$00DC, #$00FC,
    #$00DD, #$00FD,
    #$00DE, #$00FE,
    #$0100, #$0101,
    #$0102, #$0103,
    #$0104, #$0105,
    #$0106, #$0107,
    #$0108, #$0109,
    #$010A, #$010B,
    #$010C, #$010D,
    #$010E, #$010F,
    #$0110, #$0111,
    #$0112, #$0113,
    #$0114, #$0115,
    #$0116, #$0117,
    #$0118, #$0119,
    #$011A, #$011B,
    #$011C, #$011D,
    #$011E, #$011F,
    #$0120, #$0121,
    #$0122, #$0123,
    #$0124, #$0125,
    #$0126, #$0127,
    #$0128, #$0129,
    #$012A, #$012B,
    #$012C, #$012D,
    #$012E, #$012F,
    #$0132, #$0133,
    #$0134, #$0135,
    #$0136, #$0137,
    #$0139, #$013A,
    #$013B, #$013C,
    #$013D, #$013E,
    #$013F, #$0140,
    #$0141, #$0142,
    #$0143, #$0144,
    #$0145, #$0146,
    #$0147, #$0148,
    #$014A, #$014B,
    #$014C, #$014D,
    #$014E, #$014F,
    #$0150, #$0151,
    #$0152, #$0153,
    #$0154, #$0155,
    #$0156, #$0157,
    #$0158, #$0159,
    #$015A, #$015B,
    #$015C, #$015D,
    #$015E, #$015F,
    #$0160, #$0161,
    #$0162, #$0163,
    #$0164, #$0165,
    #$0166, #$0167,
    #$0168, #$0169,
    #$016A, #$016B,
    #$016C, #$016D,
    #$016E, #$016F,
    #$0170, #$0171,
    #$0172, #$0173,
    #$0174, #$0175,
    #$0176, #$0177,
    #$0178, #$00FF,
    #$0179, #$017A,
    #$017B, #$017C,
    #$017D, #$017E,
    #$0181, #$0253,
    #$0182, #$0183,
    #$0184, #$0185,
    #$0186, #$0254,
    #$0187, #$0188,
    #$0189, #$0256,
    #$018A, #$0257,
    #$018B, #$018C,
    #$018E, #$01DD,
    #$018F, #$0259,
    #$0190, #$025B,
    #$0191, #$0192,
    #$0193, #$0260,
    #$0194, #$0263,
    #$0196, #$0269,
    #$0197, #$0268,
    #$0198, #$0199,
    #$019C, #$026F,
    #$019D, #$0272,
    #$019F, #$0275,
    #$01A0, #$01A1,
    #$01A2, #$01A3,
    #$01A4, #$01A5,
    #$01A7, #$01A8,
    #$01A9, #$0283,
    #$01AC, #$01AD,
    #$01AE, #$0288,
    #$01AF, #$01B0,
    #$01B1, #$028A,
    #$01B2, #$028B,
    #$01B3, #$01B4,
    #$01B5, #$01B6,
    #$01B7, #$0292,
    #$01B8, #$01B9,
    #$01BC, #$01BD,
    #$01C4, #$01C6,
    #$01C7, #$01C9,
    #$01CA, #$01CC,
    #$01CD, #$01CE,
    #$01CF, #$01D0,
    #$01D1, #$01D2,
    #$01D3, #$01D4,
    #$01D5, #$01D6,
    #$01D7, #$01D8,
    #$01D9, #$01DA,
    #$01DB, #$01DC,
    #$01DE, #$01DF,
    #$01E0, #$01E1,
    #$01E2, #$01E3,
    #$01E4, #$01E5,
    #$01E6, #$01E7,
    #$01E8, #$01E9,
    #$01EA, #$01EB,
    #$01EC, #$01ED,
    #$01EE, #$01EF,
    #$01F1, #$01F3,
    #$01F4, #$01F5,
    #$01FA, #$01FB,
    #$01FC, #$01FD,
    #$01FE, #$01FF,
    #$0200, #$0201,
    #$0202, #$0203,
    #$0204, #$0205,
    #$0206, #$0207,
    #$0208, #$0209,
    #$020A, #$020B,
    #$020C, #$020D,
    #$020E, #$020F,
    #$0210, #$0211,
    #$0212, #$0213,
    #$0214, #$0215,
    #$0216, #$0217,
    #$0386, #$03AC,
    #$0388, #$03AD,
    #$0389, #$03AE,
    #$038A, #$03AF,
    #$038C, #$03CC,
    #$038E, #$03CD,
    #$038F, #$03CE,
    #$0391, #$03B1,
    #$0392, #$03B2,
    #$0393, #$03B3,
    #$0394, #$03B4,
    #$0395, #$03B5,
    #$0396, #$03B6,
    #$0397, #$03B7,
    #$0398, #$03B8,
    #$0399, #$03B9,
    #$039A, #$03BA,
    #$039B, #$03BB,
    #$039C, #$03BC,
    #$039D, #$03BD,
    #$039E, #$03BE,
    #$039F, #$03BF,
    #$03A0, #$03C0,
    #$03A1, #$03C1,
    #$03A3, #$03C3,
    #$03A4, #$03C4,
    #$03A5, #$03C5,
    #$03A6, #$03C6,
    #$03A7, #$03C7,
    #$03A8, #$03C8,
    #$03A9, #$03C9,
    #$03AA, #$03CA,
    #$03AB, #$03CB,
    #$03E2, #$03E3,
    #$03E4, #$03E5,
    #$03E6, #$03E7,
    #$03E8, #$03E9,
    #$03EA, #$03EB,
    #$03EC, #$03ED,
    #$03EE, #$03EF,
    #$0401, #$0451,
    #$0402, #$0452,
    #$0403, #$0453,
    #$0404, #$0454,
    #$0405, #$0455,
    #$0406, #$0456,
    #$0407, #$0457,
    #$0408, #$0458,
    #$0409, #$0459,
    #$040A, #$045A,
    #$040B, #$045B,
    #$040C, #$045C,
    #$040E, #$045E,
    #$040F, #$045F,
    #$0410, #$0430,
    #$0411, #$0431,
    #$0412, #$0432,
    #$0413, #$0433,
    #$0414, #$0434,
    #$0415, #$0435,
    #$0416, #$0436,
    #$0417, #$0437,
    #$0418, #$0438,
    #$0419, #$0439,
    #$041A, #$043A,
    #$041B, #$043B,
    #$041C, #$043C,
    #$041D, #$043D,
    #$041E, #$043E,
    #$041F, #$043F,
    #$0420, #$0440,
    #$0421, #$0441,
    #$0422, #$0442,
    #$0423, #$0443,
    #$0424, #$0444,
    #$0425, #$0445,
    #$0426, #$0446,
    #$0427, #$0447,
    #$0428, #$0448,
    #$0429, #$0449,
    #$042A, #$044A,
    #$042B, #$044B,
    #$042C, #$044C,
    #$042D, #$044D,
    #$042E, #$044E,
    #$042F, #$044F,
    #$0460, #$0461,
    #$0462, #$0463,
    #$0464, #$0465,
    #$0466, #$0467,
    #$0468, #$0469,
    #$046A, #$046B,
    #$046C, #$046D,
    #$046E, #$046F,
    #$0470, #$0471,
    #$0472, #$0473,
    #$0474, #$0475,
    #$0476, #$0477,
    #$0478, #$0479,
    #$047A, #$047B,
    #$047C, #$047D,
    #$047E, #$047F,
    #$0480, #$0481,
    #$0490, #$0491,
    #$0492, #$0493,
    #$0494, #$0495,
    #$0496, #$0497,
    #$0498, #$0499,
    #$049A, #$049B,
    #$049C, #$049D,
    #$049E, #$049F,
    #$04A0, #$04A1,
    #$04A2, #$04A3,
    #$04A4, #$04A5,
    #$04A6, #$04A7,
    #$04A8, #$04A9,
    #$04AA, #$04AB,
    #$04AC, #$04AD,
    #$04AE, #$04AF,
    #$04B0, #$04B1,
    #$04B2, #$04B3,
    #$04B4, #$04B5,
    #$04B6, #$04B7,
    #$04B8, #$04B9,
    #$04BA, #$04BB,
    #$04BC, #$04BD,
    #$04BE, #$04BF,
    #$04C1, #$04C2,
    #$04C3, #$04C4,
    #$04C7, #$04C8,
    #$04CB, #$04CC,
    #$04D0, #$04D1,
    #$04D2, #$04D3,
    #$04D4, #$04D5,
    #$04D6, #$04D7,
    #$04D8, #$04D9,
    #$04DA, #$04DB,
    #$04DC, #$04DD,
    #$04DE, #$04DF,
    #$04E0, #$04E1,
    #$04E2, #$04E3,
    #$04E4, #$04E5,
    #$04E6, #$04E7,
    #$04E8, #$04E9,
    #$04EA, #$04EB,
    #$04EE, #$04EF,
    #$04F0, #$04F1,
    #$04F2, #$04F3,
    #$04F4, #$04F5,
    #$04F8, #$04F9,
    #$0531, #$0561,
    #$0532, #$0562,
    #$0533, #$0563,
    #$0534, #$0564,
    #$0535, #$0565,
    #$0536, #$0566,
    #$0537, #$0567,
    #$0538, #$0568,
    #$0539, #$0569,
    #$053A, #$056A,
    #$053B, #$056B,
    #$053C, #$056C,
    #$053D, #$056D,
    #$053E, #$056E,
    #$053F, #$056F,
    #$0540, #$0570,
    #$0541, #$0571,
    #$0542, #$0572,
    #$0543, #$0573,
    #$0544, #$0574,
    #$0545, #$0575,
    #$0546, #$0576,
    #$0547, #$0577,
    #$0548, #$0578,
    #$0549, #$0579,
    #$054A, #$057A,
    #$054B, #$057B,
    #$054C, #$057C,
    #$054D, #$057D,
    #$054E, #$057E,
    #$054F, #$057F,
    #$0550, #$0580,
    #$0551, #$0581,
    #$0552, #$0582,
    #$0553, #$0583,
    #$0554, #$0584,
    #$0555, #$0585,
    #$0556, #$0586,
    #$10A0, #$10D0,
    #$10A1, #$10D1,
    #$10A2, #$10D2,
    #$10A3, #$10D3,
    #$10A4, #$10D4,
    #$10A5, #$10D5,
    #$10A6, #$10D6,
    #$10A7, #$10D7,
    #$10A8, #$10D8,
    #$10A9, #$10D9,
    #$10AA, #$10DA,
    #$10AB, #$10DB,
    #$10AC, #$10DC,
    #$10AD, #$10DD,
    #$10AE, #$10DE,
    #$10AF, #$10DF,
    #$10B0, #$10E0,
    #$10B1, #$10E1,
    #$10B2, #$10E2,
    #$10B3, #$10E3,
    #$10B4, #$10E4,
    #$10B5, #$10E5,
    #$10B6, #$10E6,
    #$10B7, #$10E7,
    #$10B8, #$10E8,
    #$10B9, #$10E9,
    #$10BA, #$10EA,
    #$10BB, #$10EB,
    #$10BC, #$10EC,
    #$10BD, #$10ED,
    #$10BE, #$10EE,
    #$10BF, #$10EF,
    #$10C0, #$10F0,
    #$10C1, #$10F1,
    #$10C2, #$10F2,
    #$10C3, #$10F3,
    #$10C4, #$10F4,
    #$10C5, #$10F5,
    #$1E00, #$1E01,
    #$1E02, #$1E03,
    #$1E04, #$1E05,
    #$1E06, #$1E07,
    #$1E08, #$1E09,
    #$1E0A, #$1E0B,
    #$1E0C, #$1E0D,
    #$1E0E, #$1E0F,
    #$1E10, #$1E11,
    #$1E12, #$1E13,
    #$1E14, #$1E15,
    #$1E16, #$1E17,
    #$1E18, #$1E19,
    #$1E1A, #$1E1B,
    #$1E1C, #$1E1D,
    #$1E1E, #$1E1F,
    #$1E20, #$1E21,
    #$1E22, #$1E23,
    #$1E24, #$1E25,
    #$1E26, #$1E27,
    #$1E28, #$1E29,
    #$1E2A, #$1E2B,
    #$1E2C, #$1E2D,
    #$1E2E, #$1E2F,
    #$1E30, #$1E31,
    #$1E32, #$1E33,
    #$1E34, #$1E35,
    #$1E36, #$1E37,
    #$1E38, #$1E39,
    #$1E3A, #$1E3B,
    #$1E3C, #$1E3D,
    #$1E3E, #$1E3F,
    #$1E40, #$1E41,
    #$1E42, #$1E43,
    #$1E44, #$1E45,
    #$1E46, #$1E47,
    #$1E48, #$1E49,
    #$1E4A, #$1E4B,
    #$1E4C, #$1E4D,
    #$1E4E, #$1E4F,
    #$1E50, #$1E51,
    #$1E52, #$1E53,
    #$1E54, #$1E55,
    #$1E56, #$1E57,
    #$1E58, #$1E59,
    #$1E5A, #$1E5B,
    #$1E5C, #$1E5D,
    #$1E5E, #$1E5F,
    #$1E60, #$1E61,
    #$1E62, #$1E63,
    #$1E64, #$1E65,
    #$1E66, #$1E67,
    #$1E68, #$1E69,
    #$1E6A, #$1E6B,
    #$1E6C, #$1E6D,
    #$1E6E, #$1E6F,
    #$1E70, #$1E71,
    #$1E72, #$1E73,
    #$1E74, #$1E75,
    #$1E76, #$1E77,
    #$1E78, #$1E79,
    #$1E7A, #$1E7B,
    #$1E7C, #$1E7D,
    #$1E7E, #$1E7F,
    #$1E80, #$1E81,
    #$1E82, #$1E83,
    #$1E84, #$1E85,
    #$1E86, #$1E87,
    #$1E88, #$1E89,
    #$1E8A, #$1E8B,
    #$1E8C, #$1E8D,
    #$1E8E, #$1E8F,
    #$1E90, #$1E91,
    #$1E92, #$1E93,
    #$1E94, #$1E95,
    #$1EA0, #$1EA1,
    #$1EA2, #$1EA3,
    #$1EA4, #$1EA5,
    #$1EA6, #$1EA7,
    #$1EA8, #$1EA9,
    #$1EAA, #$1EAB,
    #$1EAC, #$1EAD,
    #$1EAE, #$1EAF,
    #$1EB0, #$1EB1,
    #$1EB2, #$1EB3,
    #$1EB4, #$1EB5,
    #$1EB6, #$1EB7,
    #$1EB8, #$1EB9,
    #$1EBA, #$1EBB,
    #$1EBC, #$1EBD,
    #$1EBE, #$1EBF,
    #$1EC0, #$1EC1,
    #$1EC2, #$1EC3,
    #$1EC4, #$1EC5,
    #$1EC6, #$1EC7,
    #$1EC8, #$1EC9,
    #$1ECA, #$1ECB,
    #$1ECC, #$1ECD,
    #$1ECE, #$1ECF,
    #$1ED0, #$1ED1,
    #$1ED2, #$1ED3,
    #$1ED4, #$1ED5,
    #$1ED6, #$1ED7,
    #$1ED8, #$1ED9,
    #$1EDA, #$1EDB,
    #$1EDC, #$1EDD,
    #$1EDE, #$1EDF,
    #$1EE0, #$1EE1,
    #$1EE2, #$1EE3,
    #$1EE4, #$1EE5,
    #$1EE6, #$1EE7,
    #$1EE8, #$1EE9,
    #$1EEA, #$1EEB,
    #$1EEC, #$1EED,
    #$1EEE, #$1EEF,
    #$1EF0, #$1EF1,
    #$1EF2, #$1EF3,
    #$1EF4, #$1EF5,
    #$1EF6, #$1EF7,
    #$1EF8, #$1EF9,
    #$1F08, #$1F00,
    #$1F09, #$1F01,
    #$1F0A, #$1F02,
    #$1F0B, #$1F03,
    #$1F0C, #$1F04,
    #$1F0D, #$1F05,
    #$1F0E, #$1F06,
    #$1F0F, #$1F07,
    #$1F18, #$1F10,
    #$1F19, #$1F11,
    #$1F1A, #$1F12,
    #$1F1B, #$1F13,
    #$1F1C, #$1F14,
    #$1F1D, #$1F15,
    #$1F28, #$1F20,
    #$1F29, #$1F21,
    #$1F2A, #$1F22,
    #$1F2B, #$1F23,
    #$1F2C, #$1F24,
    #$1F2D, #$1F25,
    #$1F2E, #$1F26,
    #$1F2F, #$1F27,
    #$1F38, #$1F30,
    #$1F39, #$1F31,
    #$1F3A, #$1F32,
    #$1F3B, #$1F33,
    #$1F3C, #$1F34,
    #$1F3D, #$1F35,
    #$1F3E, #$1F36,
    #$1F3F, #$1F37,
    #$1F48, #$1F40,
    #$1F49, #$1F41,
    #$1F4A, #$1F42,
    #$1F4B, #$1F43,
    #$1F4C, #$1F44,
    #$1F4D, #$1F45,
    #$1F59, #$1F51,
    #$1F5B, #$1F53,
    #$1F5D, #$1F55,
    #$1F5F, #$1F57,
    #$1F68, #$1F60,
    #$1F69, #$1F61,
    #$1F6A, #$1F62,
    #$1F6B, #$1F63,
    #$1F6C, #$1F64,
    #$1F6D, #$1F65,
    #$1F6E, #$1F66,
    #$1F6F, #$1F67,
    #$1FB8, #$1FB0,
    #$1FB9, #$1FB1,
    #$1FBA, #$1F70,
    #$1FBB, #$1F71,
    #$1FC8, #$1F72,
    #$1FC9, #$1F73,
    #$1FCA, #$1F74,
    #$1FCB, #$1F75,
    #$1FD8, #$1FD0,
    #$1FD9, #$1FD1,
    #$1FDA, #$1F76,
    #$1FDB, #$1F77,
    #$1FE8, #$1FE0,
    #$1FE9, #$1FE1,
    #$1FEA, #$1F7A,
    #$1FEB, #$1F7B,
    #$1FEC, #$1FE5,
    #$1FF8, #$1F78,
    #$1FF9, #$1F79,
    #$1FFA, #$1F7C,
    #$1FFB, #$1F7D,
    #$2160, #$2170,
    #$2161, #$2171,
    #$2162, #$2172,
    #$2163, #$2173,
    #$2164, #$2174,
    #$2165, #$2175,
    #$2166, #$2176,
    #$2167, #$2177,
    #$2168, #$2178,
    #$2169, #$2179,
    #$216A, #$217A,
    #$216B, #$217B,
    #$216C, #$217C,
    #$216D, #$217D,
    #$216E, #$217E,
    #$216F, #$217F,
    #$24B6, #$24D0,
    #$24B7, #$24D1,
    #$24B8, #$24D2,
    #$24B9, #$24D3,
    #$24BA, #$24D4,
    #$24BB, #$24D5,
    #$24BC, #$24D6,
    #$24BD, #$24D7,
    #$24BE, #$24D8,
    #$24BF, #$24D9,
    #$24C0, #$24DA,
    #$24C1, #$24DB,
    #$24C2, #$24DC,
    #$24C3, #$24DD,
    #$24C4, #$24DE,
    #$24C5, #$24DF,
    #$24C6, #$24E0,
    #$24C7, #$24E1,
    #$24C8, #$24E2,
    #$24C9, #$24E3,
    #$24CA, #$24E4,
    #$24CB, #$24E5,
    #$24CC, #$24E6,
    #$24CD, #$24E7,
    #$24CE, #$24E8,
    #$24CF, #$24E9,
    #$FF21, #$FF41,
    #$FF22, #$FF42,
    #$FF23, #$FF43,
    #$FF24, #$FF44,
    #$FF25, #$FF45,
    #$FF26, #$FF46,
    #$FF27, #$FF47,
    #$FF28, #$FF48,
    #$FF29, #$FF49,
    #$FF2A, #$FF4A,
    #$FF2B, #$FF4B,
    #$FF2C, #$FF4C,
    #$FF2D, #$FF4D,
    #$FF2E, #$FF4E,
    #$FF2F, #$FF4F,
    #$FF30, #$FF50,
    #$FF31, #$FF51,
    #$FF32, #$FF52,
    #$FF33, #$FF53,
    #$FF34, #$FF54,
    #$FF35, #$FF55,
    #$FF36, #$FF56,
    #$FF37, #$FF57,
    #$FF38, #$FF58,
    #$FF39, #$FF59,
    #$FF3A, #$FF5A
  );

{------------------------------------------------------------------------------}
type
  TLMDUTF7EncoderState = (uesDirect, uesOptional, uesFull);

{------------------------------------------------------------------------------}
const
  CBase64Chars: array[0..64] of AnsiChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
                                           'abcdefghijklmnopqrstuvwxyz' +
                                           '0123456789+/';
  // 0 - DirectChar, 1 - Optional, 2 - Full encode
  CEncoderStates: array[0..127] of byte =
                     (2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 2, 2, // 00 - 0F
                      2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, // 10 - 1F
                      0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, // 20 - 2F
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, // 30 - 3F
                      1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 40 - 4F
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, // 50 - 5F
                      1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 60 - 6F
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2);// 70 - 7F

{Common}
{------------------------------------------------------------------------------}

function LMDIsUnicodePlatform: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT);
  end;

{------------------------------------------------------------------------------}

{WideString external utils}
{------------------------------------------------------------------------------}

const
  oleaut = 'oleaut32.dll';

{------------------------------------------------------------------------------}
{$EXTERNALSYM SysAllocStringLen}
function SysAllocStringLen(P: PWideChar; Len: Integer): PWideChar; stdcall; external oleaut name 'SysAllocStringLen';
{$EXTERNALSYM SysFreeString}
procedure SysFreeString(S: PWideChar); stdcall; external oleaut name 'SysFreeString';
{$EXTERNALSYM SysStringLen}
function SysStringLen(S: PWideChar): Integer; stdcall; external oleaut name 'SysStringLen';

 // CLR

{Wide upper/lower conversions}
{------------------------------------------------------------------------------}

 // Compiles under CLR, but then exe
              // doesn't link (dccill.exe fails).

var
  UpperToLowerList: array of array of Integer;
  bUpperToLowerListSetup: Boolean = False;

  LowerToUpperList: array of array of Integer;
  bLowerToUpperListSetup: Boolean = False;

{------------------------------------------------------------------------------}
function checkstr(const s: WideString; x: Integer; const l: w3arr): Integer;
begin
  Result := 0;
  if x > Length(s) then
    exit;
  if s[x] <> l[1] then
    exit;
  inc(x);
  if l[2] = #0 then begin
    Result := 1;
    exit;
  end;
  if x > Length(s) then
    exit;
  if s[x] <> l[2] then
    exit;
  inc(x);
  if l[3] = #0 then begin
    Result := 2;
    exit;
  end;
  if x > Length(s) then
    exit;
  if s[x] <> l[3] then
    exit;
  Result := 3;
end;

{------------------------------------------------------------------------------}
function GetrccIndex(wChar: WideChar; d: Boolean; b: Byte): Integer;
var
  i: Integer;
  j: Integer;
begin
  if not d then begin
    if bUpperToLowerListSetup = False then begin
      bUpperToLowerListSetup := True;
      SetLength(UpperToLowerList, CFT_MAXTYPE + 1);
      for j := 0 to CFT_MAXTYPE do
        SetLength(UpperToLowerList[j], 65536);

      for j := 0 to CFT_MAXTYPE do begin
        for i := 1 to max_trans do
          if UpperToLowerList[j, Ord(rcc[i].lc)] = 0 then
            if (j and rcc[i].fl) <> 0 then
              UpperToLowerList[j, Ord(rcc[i].lc)] := i;
      end;
    end;
    Result := UpperToLowerList[b, Ord(wChar)];
  end
  else begin
    if bLowerToUpperListSetup = False then begin
      bLowerToUpperListSetup := True;
      SetLength(LowerToUpperList, CFT_MAXTYPE + 1);
      for j := 0 to CFT_MAXTYPE do
        SetLength(LowerToUpperList[j], 65536);

      for j := 0 to CFT_MAXTYPE do begin
        for i := 1 to max_trans do
          if LowerToUpperList[j, Ord(rcc[i].uc[1])] = 0 then
            if (j and rcc[i].fl) <> 0 then
              LowerToUpperList[j, Ord(rcc[i].uc[1])] := i;
      end;
    end;
    Result := LowerToUpperList[b, Ord(wChar)];
  end;
end;

{------------------------------------------------------------------------------}
function uni_trans(s: WideString; d: Boolean; b: Byte): WideString;
var
  i, x, z: Integer;
begin
  x := 1;
  while x <= Length(s) do begin
    if not ms_unicode then begin
      i := GetrccIndex(s[x], d, b);
      if i > 0 then begin
        if (b and rcc[i].fl) <> 0 then begin
          if not d then begin
            if s[x] = rcc[i].lc then begin
              s[x] := rcc[i].uc[1];
              if rcc[i].uc[2] <> #0 then begin
                insert(rcc[i].uc[2], s, x + 1);
                inc(x);
              end;
              if rcc[i].uc[3] <> #0 then begin
                insert(rcc[i].uc[3], s, x + 1);
                inc(x);
              end;
            end;
          end
          else begin
            z := checkstr(s, x, rcc[i].uc);
            if z > 0 then begin
              delete(s, x, z - 1);
              s[x] := rcc[i].lc;
            end;
          end;
        end;
      end;
    end
    else begin
      i := 0;
      while i < max_wtr do begin
        if d then begin
          if wtr[i * 2 + 1] = s[x] then
            s[x] := wtr[i * 2 + 2];
        end
        else begin
          if wtr[i * 2 + 2] = s[x] then
            s[x] := wtr[i * 2 + 1];
        end;
        inc(i);
      end;
    end;
    inc(x);
  end;
  Result := s;
end;

function uni_trans_char(c: WideChar; d: Boolean): WideChar;
var
  i: Integer; b: Byte;
begin
  b := CFT_COMMON + CFT_SIMPLE;
  if doti then
    b := b + CFT_SPECIAL;

  if not ms_unicode then begin
    i := GetrccIndex(c, d, b);
    if i > 0 then begin
      if (b and rcc[i].fl) <> 0 then begin
        if not d then begin
          if c = rcc[i].lc then begin
            c := rcc[i].uc[1]
          end;
        end
        else begin
          if c = rcc[i].uc[1] then begin
            c := rcc[i].lc
          end;
        end;
      end;
    end;
  end
  else begin
    i := 0;
    while i < max_wtr do begin
      if d then begin
        if wtr[i * 2 + 1] = c then
        begin
          c := wtr[i * 2 + 2];
          Break
        end;
      end
      else begin
        if wtr[i * 2 + 2] = c then
        begin
          c := wtr[i * 2 + 1];
          Break
        end;
      end;
      inc(i);
    end;
  end;
  Result := c;
end;

{------------------------------------------------------------------------------}
function uni2uppers(const s: WideString): WideString;
var
  b: Byte;
begin
  b := CFT_COMMON + CFT_SIMPLE;
  if doti then
    b := b + CFT_SPECIAL;
  Result := uni_trans(s, True, b);
end;

{------------------------------------------------------------------------------}
function uni2lowers(const s: WideString): WideString;
var
  b: Byte;
begin
  b := CFT_COMMON + CFT_SIMPLE;
  if doti then
    b := b + CFT_SPECIAL;
  Result := uni_trans(s, False, b);
end;

 // CLR

{------------------------------------------------------------------------------}

procedure WStrError;
begin
  OutOfMemoryError;
end;

{------------------------------------------------------------------------------}
function IsLegalUTF8(const source: AnsiString; length: Cardinal): Boolean;
var
  a: UTF8;
  src: ansistring;
  i: Cardinal;
begin
  src := source;
  i := 1 + length;
  Result := False;
  if (length < 1) or (length > 4) then
    exit;
  { Everything else falls through when "True"... }
  if length = 4 then begin
    dec(i);
    a := UTF8(src[i]);
    if (a < $80) or (a > $BF) then
      exit;
  end;
  if length >= 3 then begin
    dec(i);
    a := UTF8(src[i]);
    if (a < $80) or (a > $BF) then
      exit;
  end;
  if length >= 2 then begin
    dec(i);
    a := UTF8(src[i]);
    if (a > $BF) or
      ((UTF8(source[1]) = $0E0) and (a < $0A0)) or
      ((UTF8(source[1]) = $0F0) and (a < $90)) or
      ((UTF8(source[1]) = $0F4) and (a > $8F)) or
      (a < $80) then
      exit;
  end;
  if length >= 1 then
    if ((UTF8(source[1]) >= $80) and (UTF8(source[1]) < $0C2)) or (UTF8(source[1]) > $0F4) then
      exit;
  Result := True;
end;

{------------------------------------------------------------------------------}
function LMDConvertUTF16toUTF8(const source: WideString;
  var target: AnsiString;
  flags: ConversionFlags;
  BOM: Boolean): ConversionResult;
const
  byteMask: UTF32 = $0BF;
  byteMark: UTF32 = $80;
  UTF8BOM: AnsiString = AnsiChar($EF) + AnsiChar($BB) + AnsiChar($BF);
var
  ch, ch2: UTF32;
  bytesToWrite: word;
  i, sourcelen: Integer;
  ts: AnsiString;
begin
  Result := conversionOK;
  target := '';
  i := 1;
  sourcelen := length(source) + i;
  while i < sourcelen do begin
    // bytesToWrite := 0;
    ch := UTF32(source[i]);
    inc(i);
    { If we have a surrogate pair, convert to UTF32 first }
    if ((ch >= UNI_SUR_HIGH_START) and (ch <= UNI_SUR_HIGH_END) and (i < sourcelen)) then begin
      ch2 := UTF32(source[i]);
      if ((ch2 >= UNI_SUR_LOW_START) and (ch2 <= UNI_SUR_LOW_END)) then begin
        ch := ((ch - UNI_SUR_HIGH_START) shl halfShift) + (ch2 - UNI_SUR_LOW_START) + halfBase;
        inc(i);
      end
      else
        if (flags = strictConversion) then { it's an unpaired high surrogate } begin
          Result := sourceIllegal;
          Break;
        end;
    end
    else
      if ((flags = strictConversion) and ((ch >= UNI_SUR_LOW_START) and (ch <= UNI_SUR_LOW_END))) then begin
        Result := sourceIllegal;
        Break;
      end;
    { Figure out how many bytes the Result will require }
    if ch < UTF32($80) then
      bytesToWrite := 1
    else
      if ch < UTF32($800) then
        bytesToWrite := 2
      else
        if ch < UTF32($10000) then
          bytesToWrite := 3
        else
          if ch < UTF32($200000) then
            bytesToWrite := 4
          else begin
            bytesToWrite := 2;
            ch := UNI_REPLACEMENT_CHAR;
          end;

    { note: everything falls through. }
    ts := '';
    if bytesToWrite = 4 then begin
      ts := AnsiChar((ch or byteMark) and byteMask);
      ch := ch shr 6
    end;
    if bytesToWrite >= 3 then begin
      ts := AnsiChar((ch or byteMark) and byteMask) + ts;
      ch := ch shr 6
    end;
    if bytesToWrite >= 2 then begin
      ts := AnsiChar((ch or byteMark) and byteMask) + ts;
      ch := ch shr 6
    end;
    if bytesToWrite >= 1 then begin
      ts := AnsiChar(ch or firstByteMark[bytesToWrite]) + ts;
    end;
    target := target + ts;
  end;
  if BOM and (Pos(UTF8BOM, target) <> 1) then
    target := UTF8BOM + target;
end;

{------------------------------------------------------------------------------}
function LMDConvertUTF8toUTF16(const source: AnsiString;
  var target: WideString;
  flags: ConversionFlags;
  BOM: Boolean): ConversionResult;
var
  ch: UTF32;
  extraBytesToRead: word;
  i, sourcelen: Integer;
begin
  Result := conversionOK;
  i := 1;
  sourcelen := length(source) + i;
  target := '';

  while i < sourcelen do begin
    ch := 0;
    extraBytesToRead := trailingBytesForUTF8[UTF8(source[i])];
    if (i + extraBytesToRead) >= sourcelen then begin
      Result := sourceExhausted;
      Break;
    end;
    { Do this check whether lenient or strict }
    if (not isLegalUTF8(copy(source, i, extraBytesToRead + 1), extraBytesToRead + 1)) then begin
      Result := sourceIllegal;
      Break;
    end;
    { The cases all fall through.}
    if extraBytesToRead = 3 then begin
      ch := ch + UTF32(source[i]);
      inc(i);
      ch := ch shl 6;
    end;
    if (extraBytesToRead >= 2) and (extraBytesToRead < 4) then begin
      ch := ch + UTF32(source[i]);
      inc(i);
      ch := ch shl 6;
    end;
    if (extraBytesToRead >= 1) and (extraBytesToRead < 4) then begin
      ch := ch + UTF32(source[i]);
      inc(i);
      ch := ch shl 6;
    end;
    if (* (extraBytesToRead >= 0) and *)(extraBytesToRead < 4) then begin
      ch := ch + UTF32(source[i]);
      inc(i);
    end;
    ch := ch - offsetsFromUTF8[extraBytesToRead];
    if (ch <= UNI_MAX_BMP) then { Target is a character <= 0xFFFF } begin
      if ((flags = strictConversion) and ((ch >= UNI_SUR_HIGH_START) and (ch <= UNI_SUR_LOW_END))) then begin
        Result := sourceIllegal;
        Break;
      end
      else
        target := target + WideChar(ch); { normal case }
    end
    else
      if (ch > UNI_MAX_UTF16) then begin
        if (flags = strictConversion) then begin
          Result := sourceIllegal;
          i := i - extraBytesToRead;
        end
        else
          target := target + WideChar(UNI_REPLACEMENT_CHAR);
      end
      else
        { target is a character in range 0xFFFF - 0x10FFFF. } begin
        ch := ch - halfBase;
        target := target + WideChar((ch shr halfShift) + UNI_SUR_HIGH_START) +
          WideChar((ch and halfMask) + UNI_SUR_LOW_START);
      end;
  end;
  if BOM and (Ord(target[1]) <> $FEFF) then
    target := WideChar($FEFF) + target;
end;

{------------------------------------------------------------------------------}
function LMDConvertUTF8String(const Source: AnsiString): WideString;
const
  UTF8BOM: AnsiString = AnsiChar($EF) + AnsiChar($BB) + AnsiChar($BF);
begin
  if Copy(Source, 1, 3) = UTF8BOM then
  begin
    if LMDConvertUTF8ToUTF16(Source, Result, strictConversion, False) = sourceIllegal then
      Result := WideString(Source)
    else
      if (Length(Result) > 1) and (Result[1] = WideChar($FEFF)) then
        Delete(Result, 1, 1);
  end
  else
    Result := WideString(Source);
end;

{------------------------------------------------------------------------------}
function LMDGetTrailingBytesUTF8(AByte: byte): integer;
begin
  Result := trailingBytesForUTF8[AByte];
end;

{------------------------------------------------------------------------------}
function LMDIsLegalUTF8Sequence(const source: AnsiString; sourcelen: Cardinal): Boolean;
var
  length: Cardinal;
begin
  length := trailingBytesForUTF8[Byte(source[1])] + 1;
  if length > sourcelen then
    Result := False
  else
    Result := isLegalUTF8(source, length);
end;

{------------------------------------------------------------------------------}
function LMDConvertUTF16ToUTF7(ASrc: WideString;
                               const AEncodeOptionalChars: Boolean = False;
                               const ABOM: Boolean = False): AnsiString;
var
  i: integer;
  LCode: LongWord;
  LBits: Integer;
  LTail: LongWord;
  LTailLen: Integer;
  LState: TLMDUTF7EncoderState;

  function IsTailEmpty: boolean;
  begin
    Result := (LTail = 0) and (LTailLen = 0);
  end;

begin
  Result := '';
  LTail := 0;
  LTailLen := 0;
  i := 1;

  if ABOM then
    ASrc := WideChar($FEFF) + ASrc;

  while i <= Length(ASrc) do
  begin
    if ASrc[i] > #127 then
      LState := uesFull
    else
      LState := TLMDUTF7EncoderState(CEncoderStates[ord(ASrc[i])]);

    if LState = uesOptional then
    begin
      if AEncodeOptionalChars then
        LState := uesFull
      else
        LState := uesDirect;
    end;

    case LState of
    uesDirect:
      begin
        if not IsTailEmpty then
        begin
          if LTailLen > 0 then
            Result := Result + CBase64Chars[(LTail shl (6 - LTailLen)) and $3F];
          Result := Result + '-'; // utf7 stream end marker
          LTail := 0;
          LTailLen := 0;
        end;

        Result := Result + AnsiChar(ASrc[i]);
        if ASrc[i] = '+' then // Escape '+' symbol
          Result := Result + '-';
      end;

    uesFull:
      begin
        if IsTailEmpty then
          Result := Result + '+'; // utf7 stream start marker
        LCode := LongWord(LongWord(ASrc[i]) or (LTail shl 16));
        LBits := 10 + LTailLen;
        while LBits >= 0 do
        begin
          Result := Result + CBase64Chars[(LCode shr LBits) and $3F];
          Dec(LBits, 6);
        end;
        LTail := LCode;
        LTailLen := LBits + 6;
      end;
    end;
    Inc(i);
  end;
  if not IsTailEmpty then
  begin
    if LTailLen > 0 then
      Result := Result + CBase64Chars[(LTail shl (6 - LTailLen)) and $3F];
    Result := Result + '-';
  end;
end;


function LMDTryConvertUTF7ToUTF16(const ASrc: AnsiString; var ADest: WideString; ARemoveBom: Boolean = True): Boolean;
  function GetBase64Code(AChar: AnsiChar): Integer;
  begin
    case AChar of
      'A'..'Z': Result := LongWord(AChar) - Ord('A');
      'a'..'z': Result := LongWord(AChar) - Ord('a') + 26;
      '0'..'9': Result := LongWord(AChar) - Ord('0') + 52;
      '+': Result := 62;
      '/': Result := 63;
    else
      Result := -1;
    end;
  end;

var
  LBits: Integer;
  LIsEncode: boolean;
  i: Integer;
  LCharCode: Integer;
  LEncBeginPos: Integer;
  LValue: LongWord;
begin
  LIsEncode := False;
  LBits := 0;
  LValue := 0;
  Result := True;
  LEncBeginPos := 0;
  ADest := '';
  i := 1;
  while i <= Length(ASrc) do
  begin
    if (ASrc[i] = '+') and (not LIsEncode) then
    begin
      LIsEncode := True;
      Inc(i);
      LEncBeginPos := i;
      LBits := 0;
      LValue := 0;
      Continue;
    end;

    if (ASrc[i] = '-') and (LIsEncode) then
    begin
      LIsEncode := False;
      if LEncBeginPos = i then
        ADest := ADest + '+';
      Inc(i);
      Continue;
    end;

    if not LIsEncode then
      ADest := ADest + WideChar(ASrc[i]);

    if LIsEncode then
    begin
      LCharCode := GetBase64Code(ASrc[i]);
      if LCharCode >= 0 then
      begin
        LValue := (LValue shl 6) or LongWord(LCharCode);
        Inc(LBits, 6);
        if LBits >= 16 then
        begin
          Dec(LBits, 16);
          ADest := ADest + WideChar((LValue shr LBits) and $FFFF);
        end;
      end;
    end;
    Inc(i);
  end;
  if ARemoveBom then
  begin
    if Pos(WideChar($FEFF), ADest) = 1 then
      Delete(ADest, 1, 1)
    else
      Result := false;
  end;
end;

{------------------------------------------------------------------------------}
function LMDConvertUTF7ToUTF16(const ASrc: AnsiString; ARemoveBom: Boolean = True): WideString;
begin
  LMDTryConvertUTF7ToUTF16(ASrc, Result, ARemoveBom);
end;

{------------------------------------------------------------------------------}
function LMDUnicodeUpperChar(C: WideChar): WideChar;
begin
  Result := uni_trans_char(C, true)
end;

{------------------------------------------------------------------------------}
function LMDUnicodeLowerChar(C: WideChar): WideChar;
begin
  Result := uni_trans_char(C, false)
  end;

{------------------------------------------------------------------------------}
function LMDUnicodeUpper(const S: WideString): WideString;
begin
  Result := S;
  if Result <> '' then
    Result := uni2uppers(Result);
  end;

{------------------------------------------------------------------------------}
function LMDUnicodeLower(const S: WideString): WideString;
begin
  Result := S;
  if Result <> '' then
    Result := uni2lowers(Result);
  end;

{------------------------------------------------------------------------------}
function LMDWideGetCharCategory(AChar: WideChar): TLMDUnicodeCategory;
begin
  result := LMD_CHAR_KIND_SECOND_TABLE[LMD_CHAR_KIND_FIRST_TABLE [Ord(AChar) ShR 8] + (Ord(AChar) AND $FF)];
end;

{------------------------------------------------------------------------------}
function LMDWideCompareText(const S1, S2: WideString): Integer;

var
  P1, P2: PWideChar;
begin
  Result := 0;
  P1 := @S1[1];
  P2 := @S2[1];
  while (P1^ <> #0) and (P2^ <> #0) and (P2^ = P1^) do
  begin
    Inc(P1);
    Inc(P2);
  end;
  if P1^ = P2^ then
    Result := 0
  else
    if P1^ < P2^ then
      Result := -1
    else
      if P1^ > P2^ then
        Result := 1;
end;

{------------------------------------------------------------------------------}
function LMDWideSameText(const S1, S2: WideString): Boolean;
begin

  Result := LMDWideCompareText(LMDUnicodeUpper(S1), LMDUnicodeUpper(S2)) = 0;

end;

{------------------------------------------------------------------------------}
function LMDWideCompareStr(const S1, S2: WideString): Integer;

var
  P1, P2: PWideChar;
  P: PWideChar;
  S: WideString;
begin
  S := LMDWideGetStringOf(#0, 1);
  P := PWideChar(S);
  P1 := PWideChar(S1);
  if not Assigned(P1) then
    P1 := P;
  P2 := PWideChar(S2);
  if not Assigned(P2) then
    P2 := P;
  Result := LMDWideStrComp(P1, P2);
end;

{------------------------------------------------------------------------------}
function LMDWideSameStr(const S1, S2: WideString): Boolean;
begin
  Result := (LMDWideCompareStr(S1, S2) = 0);
end;

{------------------------------------------------------------------------------}
function LMDWideMakeString(FLen: Integer; const Seq: WideString): WideString;

var
  i: Integer;
begin
  SetLength(Result, FLen * Length(Seq));
  for i := 0 to FLen - 1 do
    Move(Seq[1], Result[Length(Seq) * i + 1], Length(Seq) * SizeOf(WideChar));
end;

{------------------------------------------------------------------------------}

function LMDWideStringDup(const S: WideString): PWideChar;
var
  i: Integer;
begin
  i := (Length(S) + 1) * SizeOf(WideChar);
  GetMem(Result, i);
  Move(S[1], Result[1], i);
end;

{------------------------------------------------------------------------------}
function LMDWideStringReplace(const S, OldPattern, NewPattern: WideString;
  Flags: TWideReplaceFlags): WideString;

var
  SearchStr, Patt, NewStr: WideString;
  Offset: Integer;
begin
  if wrfIgnoreCase in Flags then begin
    SearchStr := LMDUnicodeUpper(S);
    Patt := LMDUnicodeUpper(OldPattern);
  end
  else begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), Length(NewStr));
    if not (wrfReplaceAll in Flags) then begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), Length(SearchStr));
  end;
end;

{------------------------------------------------------------------------------}
function LMDWideGetCharRangeString(FirstChar, LastChar: WideChar): WideString;
var
  I: Integer;
  T: WideChar;
begin
  if LastChar < FirstChar then begin
    T := FirstChar;
    FirstChar := LastChar;
    LastChar := T;
  end;
  I := 1;
  SetLength(Result, Ord(LastChar) - Ord(FirstChar) + 1);
  for T := FirstChar to LastChar do begin
    Result[I] := T;
    Inc(I);
  end;
end;

{------------------------------------------------------------------------------}
function LMDWideGetStringOf(Char: WideChar; Len: Cardinal): WideString;

begin
  SetLength(Result, Len);
  if Len > 0 then begin
    LMDFillWideChar(Result[1], Len, Char);
  end;
end;

{------------------------------------------------------------------------------}

function LMDWideStrScan(const Str: PWideChar; AChr: WideChar): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        PUSH    EAX
        MOV     EDI,Str
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASW
        NOT     ECX
        POP     EDI
        MOV     AX, AChr
        REPNE   SCASW
        MOV     EAX,0
        JNE     @@1
        MOV     EAX, EDI
        DEC     EAX
        DEC     EAX
@@1:    POP     EDI
end;
{$ELSE}
begin
  Result := StrScan(Str, AChr);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrRScan(const Str: PWideChar; AChr: WideChar): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        MOV     EDI,Str
        MOV     ECX,0FFFFFFFFH
        XOR     AX,AX
        REPNE   SCASW
        NOT     ECX
        STD
        DEC     EDI
        DEC     EDI
        MOV     AX,AChr
        REPNE   SCASW
        MOV     EAX,0
        JNE     @@1
        MOV     EAX,EDI
        INC     EAX
        INC     EAX
@@1:    CLD
        POP     EDI
end;
{$ELSE}
begin
  Result := StrRScan(Str, AChr);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

function LMDWideQuotedStr(const S: WideString; Quote: WideChar): WideString;
var
  P, Src, Dest: PWideChar;
  AddCount: Integer;
begin
  AddCount := 0;
  P := LMDWideStrScan(PWideChar(S), Quote);
  while Assigned(P) do begin
    Inc(P);
    Inc(AddCount);
    P := LMDWideStrScan(P, Quote);
  end;

  if AddCount = 0 then
    Result := Quote + S + Quote
  else begin
    SetLength(Result, Length(S) + AddCount + 2);
    Dest := PWideChar(Result);
    Dest^ := Quote;
    Inc(Dest);
    Src := PWideChar(S);
    P := LMDWideStrScan(Src, Quote);
    repeat
      Inc(P);
      LMDWideMove(Src^, Dest^, P - Src);
      Inc(Dest, P - Src);
      Dest^ := Quote;
      Inc(Dest);
      Src := P;
      P := LMDWideStrScan(Src, Quote);
    until not Assigned(P);
    P := LMDWideStrEnd(Src);
    LMDWideMove(Src^, Dest^, P - Src);
    Inc(Dest, P - Src);
    Dest^ := Quote;
  end;
end;

{------------------------------------------------------------------------------}

function LMDWideExtractQuotedStr(var Src: PWideChar; Quote: WideChar): WideString;
var
  P, Dest: PWideChar;
  DropCount: Integer;
begin
  Result := '';
  if (Src = nil) or (Src^ <> Quote) then
    Exit;
  Inc(Src);
  DropCount := 1;
  P := Src;
  Src := LMDWideStrScan(Src, Quote);
  while Src <> nil do {// count adjacent pairs of quote chars} begin
    Inc(Src);
    if Src^ <> Quote then
      Break;
    Inc(Src);
    Inc(DropCount);
    Src := LMDWideStrScan(Src, Quote);
  end;
  if Src = nil then
    Src := LMDWideStrEnd(P);
  if ((Src - P) <= 1) then
    Exit;
  if DropCount = 1 then begin
    LMDWideSetString(Result, P, Src - P - 1);
  end
  else begin
    SetLength(Result, Src - P - DropCount);
    Dest := PWideChar(Result);
    Src := LMDWideStrScan(P, Quote);
    while Src <> nil do begin
      Inc(Src);
      if Src^ <> Quote then
        Break;
      Move(P^, Dest^, Src - P + SizeOf(WideChar) * 2);
      Inc(Dest, Src - P);
      Inc(Src);
      P := Src;
      Src := LMDWideStrScan(Src, Quote);
    end;
    if Src = nil then
      Src := LMDWideStrEnd(P);
    Move(P^, Dest^, Src - P + SizeOf(WideChar));
  end;
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

procedure LMDWideSetString(var S: WideString; Buffer: PWideChar; Len: Integer);
begin
  SetLength(S, Len);
  if Len > 0 then begin
    if Assigned(Buffer) then
      LMDWideMove(Buffer^, S[1], Len)
    else
      LMDFillWideChar(S[1], Len, #0);
  end;
end;

{------------------------------------------------------------------------------}

function LMDWideStrCopy(Target: PWideChar; Source: PWideChar): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        PUSH    ESI
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     ECX,0FFFFFFFFH
        XOR     AX,AX
        REPNE   SCASW
        NOT     ECX
        MOV     EDI,ESI
        MOV     ESI,EDX
        MOV     EDX,ECX
        MOV     EAX,EDI
        SHR     ECX,1
        REP     MOVSD
        MOV     ECX,EDX
        AND     ECX,1
        REP     MOVSW
        POP     ESI
        POP     EDI
end;
{$ELSE}
begin
  Result := StrCopy(Target, Source);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrPCopy(Target: PWideChar;
  const Source: WideString): PWideChar;
begin
  Result := LMDWideStrLCopy(Target, PWideChar(Source), Length(Source));
end;

{------------------------------------------------------------------------------}

function LMDWideStrComp(const S1, S2: PWideChar): Integer; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        PUSH    ESI
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASW
        NOT     ECX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSW
        MOV     AX,[ESI-2]
        MOV     DX,[EDI-2]
        SUB     EAX,EDX
        POP     ESI
        POP     EDI
end;
{$ELSE}
begin
  Result := StrComp(S1, S2);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrLComp(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     EBX,ECX
        XOR     EAX,EAX
        OR      ECX,ECX
        JE      @@1
        REPNE   SCASW
        SUB     EBX,ECX
        MOV     ECX,EBX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSW
        MOV     AX,[ESI-2]
        MOV     DX,[EDI-2]
        SUB     EAX,EDX
@@1:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ELSE}
begin
  Result := StrLComp(Str1, Str2, MaxLen);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrLen(const Str: PWideChar): Cardinal; assembler;
{$IFDEF LMDX86}
asm
        MOV     EDX,EDI
        MOV     EDI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     AX,AX
        REPNE   SCASW
        MOV     EAX,0FFFFFFFEH
        SUB     EAX,ECX
        MOV     EDI,EDX
end;
{$ELSE}
begin
  Result := StrLen(Str);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrPas(const Source: PWideChar): WideString;
{$ifndef LMD_NATIVEUNICODE}
var
  l: Integer;
{$endif}
begin
  {$ifdef LMD_NATIVEUNICODE}
  Result := Source;
  {$else}
  if Source = nil then
    Result := WideString('')
  else
  begin
    l := LMDWideStrLen(Source);
    SetLength(Result, l);
    LMDWideMove(Source[0], Result[1], l);
  end;
  {$endif}
end;

{------------------------------------------------------------------------------}

procedure LMDWideMove(const Source; var Dest; Count: Integer); assembler;
{$IFDEF LMDX86}
asm
{     ->EAX     Pointer to source       }
{       EDX     Pointer to destination  }
{       ECX     Count In Words          }

        PUSH    ESI
        PUSH    EDI
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     EDX,ECX
        CMP     EDI,ESI
        JA      @@1
        JE      @@2
        SHR     ECX,1
        REP     MOVSD
        MOV     ECX,EDX
        AND     ECX,1
        REP     MOVSW
        JMP     @@2
@@1:    LEA     ESI,[ESI+ECX*2-2]
        LEA     EDI,[EDI+ECX*2-2]
        AND     ECX,1
        STD
        REP     MOVSW
        DEC     ESI
        DEC     EDI
        MOV     ECX,EDX
        DEC     ESI
        DEC     EDI
        SHR     ECX,1
        REP     MOVSD
        CLD
@@2:    POP     EDI
        POP     ESI
end;
{$ELSE}
begin
  Move(Source, Dest, Count * 2);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrMove(Dest: PWideChar; const Source: PWideChar; Count: Cardinal): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        PUSH    ESI
        PUSH    EDI
        MOV     ESI,EDX
        MOV     EDI,EAX
        MOV     EDX,ECX
        CMP     EDI,ESI
        JA      @@1
        JE      @@2
        SHR     ECX,1
        REP     MOVSD
        MOV     ECX,EDX
        AND     ECX,1
        REP     MOVSW
        JMP     @@2
@@1:    LEA     ESI,[ESI+ECX*2-2]
        LEA     EDI,[EDI+ECX*2-2]
        AND     ECX,1
        STD
        REP     MOVSW
        DEC     ESI
        DEC     EDI
        MOV     ECX,EDX
        DEC     ESI
        DEC     EDI
        SHR     ECX,1
        REP     MOVSD
        CLD
@@2:    POP     EDI
        POP     ESI
end;
{$ELSE}
begin
  Result := StrMove(Dest, Source, Count);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrECopy(Dest: PWideChar; const Source: PWideChar): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        PUSH    ESI
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     ECX,0FFFFFFFFH
        XOR     AX,AX
        REPNE   SCASW
        NOT     ECX
        MOV     EDI,ESI
        MOV     ESI,EDX
        MOV     EDX,ECX
        SHR     ECX,1
        REP     MOVSD
        MOV     ECX,EDX
        AND     ECX,1
        REP     MOVSW
        LEA     EAX,[EDI-2]
        POP     ESI
        POP     EDI
end;
{$ELSE}
begin
  Result := StrECopy(Dest, Source);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrLCopy(Dest: PWideChar; const Source: PWideChar; MaxLen: Cardinal): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     EBX,ECX
        XOR     AX,AX
        TEST    ECX,ECX
        JZ      @@1
        REPNE   SCASW
        JNE     @@1
        INC     ECX
@@1:    SUB     EBX,ECX
        MOV     EDI,ESI
        MOV     ESI,EDX
        MOV     EDX,EDI
        MOV     ECX,EBX
        SHR     ECX,1
        REP     MOVSD
        MOV     ECX,EBX
        AND     ECX,1
        REP     MOVSW
        STOSW
        MOV     EAX,EDX
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ELSE}
begin
  Result := StrLCopy(Dest, Source, MaxLen);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrLCat(Dest: PWideChar; const Source: PWideChar; MaxLen: Cardinal): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,Dest
        MOV     EBX,MaxLen
        MOV     ESI,Source
        SHL     EBX, 1
        CALL    LMDWideStrEnd
        MOV     ECX,EDI
        ADD     ECX,EBX
        SUB     ECX,EAX
        JBE     @@1
        SHR     ECX, 1
        MOV     EDX,ESI
        CALL    LMDWideStrLCopy
@@1:    MOV     EAX,EDI
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ELSE}
begin
  Result := StrLCat(Dest, Source, MaxLen);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrCat(Dest: PWideChar; const Source: PWideChar): PWideChar;
begin
  LMDWideStrCopy(LMDWideStrEnd(Dest), Source);
  Result := Dest;
end;

{------------------------------------------------------------------------------}

function LMDWideStrAlloc(Size: Cardinal): PWideChar;
{$IFDEF LMDX86}
asm
        TEST    EAX,EAX
        JE      @@1
        PUSH    EAX
        PUSH    0
        CALL    SysAllocStringLen
        TEST    EAX,EAX
        JE      WStrError
@@1:
end;
{$ELSE}
begin
  Result := StrAlloc(Size);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrBufSize(const Str: PWideChar): Cardinal;
begin
  Result := SysStringLen(Str);
end;

{------------------------------------------------------------------------------}

function LMDWideStrNew(const Str: PWideChar): PWideChar;
var
  Size: Cardinal;
begin
  if Str = nil then
    Result := nil
  else begin
    Size   := LMDWideStrLen(Str) + 1;
    Result := LMDWideStrMove(LMDWideStrAlloc(Size), Str, Size);
  end;
end;

{------------------------------------------------------------------------------}

procedure LMDWideStrDispose(Str: PWideChar);
begin
  if not Assigned(Str) then
    SysFreeString(Str);
end;

{------------------------------------------------------------------------------}

function LMDWideLastChar(const S: WideString): PWideChar;
var
  LastWord: Integer;
begin
  LastWord := Length(S);
  if LastWord > 0 then begin
    Result := @S[LastWord];
  end
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}

procedure LMDFillWord(var X; Count: Integer; Value: Word); assembler;
{$IFDEF LMDX86}
asm
{     ->EAX     Pointer to destination  }
{       EDX     count   }
{       CX      value   }

        PUSH    EDI

        MOV     EDI,EAX { Point EDI to destination              }

        MOV     EAX,ECX { Fill EAX with value repeated 2 times  }
        SHL     EAX,16
        MOV     AX,CX

        MOV     ECX,EDX
        SAR     ECX,1
        JS      @@exit

        REP     STOSD   { Fill count DIV 2 dwords       }

        MOV     ECX,EDX
        AND     ECX,1
        REP     STOSW   { Fill count MOD 2 bytes        }

@@exit:
        POP     EDI
end;
{$ELSE}
begin
  FillChar(X, Count * 2, Value);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

procedure LMDFillWideChar(var X; Count: Integer; Value: WideChar); assembler;
{$IFDEF LMDX86}
asm
{     ->EAX     Pointer to destination  }
{       EDX     count   }
{       CX      value   }

        PUSH    EDI

        MOV     EDI,EAX { Point EDI to destination              }

        MOV     EAX,ECX { Fill EAX with value repeated 2 times  }
        SHL     EAX,16
        MOV     AX,CX

        MOV     ECX,EDX
        SAR     ECX,1
        JS      @@exit

        REP     STOSD   { Fill count DIV 2 dwords       }

        MOV     ECX,EDX
        AND     ECX,1
        REP     STOSW   { Fill count MOD 2 words        }

@@exit:
        POP     EDI
end;
{$ELSE}
var
  c, eof: PWideChar;
begin
  c   := PWideChar(@X);
  eof := c + Count;

  while c <> eof do
  begin
    c^ := Value;
    Inc(c);
  end;
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrPos(const Str1, Str2: PWideChar): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        OR      EAX,EAX
        JE      @@2
        OR      EDX,EDX
        JE      @@2
        MOV     EBX,EAX
        MOV     EDI,EDX
        XOR     AX,AX
        MOV     ECX,0FFFFFFFFH
        REPNE   SCASW
        NOT     ECX
        DEC     ECX
        JE      @@2
        MOV     ESI,ECX
        MOV     EDI,EBX
        MOV     ECX,0FFFFFFFFH
        REPNE   SCASW
        NOT     ECX
        SUB     ECX,ESI
        JBE     @@2
        MOV     EDI,EBX
        LEA     EBX,[ESI-1]
@@1:    MOV     ESI,EDX
        LODSW
        REPNE   SCASW
        JNE     @@2
        MOV     EAX,ECX
        PUSH    EDI
        MOV     ECX,EBX
        REPE    CMPSW
        POP     EDI
        MOV     ECX,EAX
        JNE     @@1
        LEA     EAX,[EDI-2]
        JMP     @@3
@@2:    XOR     EAX,EAX
@@3:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ELSE}
begin
  Result := StrPos(Str1, Str2);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

function LMDWideStrEnd(const Str: PWideChar): PWideChar; assembler;
{$IFDEF LMDX86}
asm
        MOV     EDX,EDI
        MOV     EDI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     AX,AX
        REPNE   SCASW
        LEA     EAX,[EDI - 2]
        MOV     EDI,EDX
end;
{$ELSE}
begin
  Result := StrEnd(Str);
end;
{$ENDIF}

{------------------------------------------------------------------------------}
function LMDIsWideDelimiter(const Delimiters, S: WideString;
  Index: Integer): Boolean;
begin
  Result := False;
  if (Index <= 0) or (Index > Length(S)) then
    exit;

  Result := LMDWideStrScan(PWideChar(Delimiters), S[Index]) <> nil;

end;

{------------------------------------------------------------------------------}
function LMDWidePos(const Substr, S: WideString): Integer;

 var P: PWideChar;

begin

  Result := 0;
  P := LMDWideStrPos(PWideChar(S), PWideChar(SubStr));
  if P <> nil then
    Result := P - PWideChar(S) + 1;

end;
{------------------------------------------------------------------------------}
procedure LMDWideInsert(Text : WideString; var S : WideString; SPos : integer);
begin
  System.Insert(Text, S, SPos);
  end;
{------------------------------------------------------------------------------}
procedure LMDWideDelete(var S : WideString; SPos, SLen : integer);
begin
  System.Delete(S, SPos, SLen);
  end;
{------------------------------------------------------------------------------}
function LMDIsWidePathDelimiter(const S: WideString;
  Index: Integer): Boolean;
begin
  Result := LMDIsWideDelimiter(LMDWidePathDelimiters, S, Index);
end;

{------------------------------------------------------------------------------}
function LMDWideGetShortHint(const Hint: WideString): WideString;
var
  I: Integer;
begin
  I := Pos('|', Hint);
  if I = 0 then
    Result := Hint else
    Result := Copy(Hint, 1, I - 1);
end;

{------------------------------------------------------------------------------}
function LMDCreateUnicodeHintString(const Value: WideString): string;

var
  S: string;
  l: Integer;
  T: WideChar;
begin
  Result := '';
  if Length(Value) > 0 then begin
    S := Value;
    l := Length(Value) * 2;
    SetLength(S, l + 4);
    S[Length(Value) + 1] := #0;

    Move(Value[1], S[1], Length(Value) * 2);
    T := #0;
    Move(T, S[l + 1], SizeOf(T));
    T := #$FFFF;
    Move(T, S[l + 3], SizeOf(T));
    Result := S;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWMCharToUnicode(AC: Char): WideChar;
var
  LBuf: array[0..5] of Char;
  LLocale: Integer;
begin
  GetLocaleInfo(GetKeyboardLayout(0) and $FFFF, LOCALE_IDefaultAnsiCodePage,
                LBuf, SizeOf(LBuf));
  LLocale := StrToIntDef(LBuf, GetACP);
  MultiByteToWideChar(LLocale, MB_USEGLYPHCHARS, @AC, 1, @Result, 1);
end;

{------------------------------------------------------------------------------}
function LMDKeyToUnicode(const Key: String): WideString;
var KeyboardCodePage: integer;
    Buf: String;
    lAKey: AnsiString;
    LenBuf: Integer;
    LenRes: integer;
    Locale: LCID;
    // const LOCALE_IDEFAULTANSICODEPAGE     = $00001004;
begin
  // Get right locale
  Locale := GetKeyboardLayout(0) and $FFFF;
  LenBuf := GetLocaleInfo(Locale, LOCALE_IDEFAULTANSICODEPAGE, nil, 0);
  SetLength(Buf, LenBuf);
  GetLocaleInfo(Locale, LOCALE_IDEFAULTANSICODEPAGE, PChar(Buf), LenBuf);
  KeyboardCodePage := StrToIntDef(Buf, GetACP);

  // Get length of result string
  lAKey := AnsiString(Key);
  LenRes := MultiByteToWideChar(KeyboardCodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS, PAnsiChar(lAKey),
    Length(lAKey), nil, 0);
  SetLength(Result, LenRes);

  MultiByteToWideChar(KeyboardCodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS, PAnsiChar(lAKey),
    Length(lAKey), PWideChar(Result), LenRes);
end;

end.
