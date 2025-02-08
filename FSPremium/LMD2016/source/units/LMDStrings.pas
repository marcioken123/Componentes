unit LMDStrings;
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

LMDStrings unit (RM, JH, AH, YB)
--------------------------------
String routines

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Graphics, Types, SysUtils, LMDRTLConst, LMDTypes, LMDUnicode,
  LMDUnicodeStrings {$IFDEF LMDCOMP17},UITypes{$ENDIF};

{Common utilities}
{------------------------------------------------------------------------------}
const
  LMDAnsiSpace = #32;
  LMDWideSpace = WideChar(#32);
  LMDSpace     = TLMDChar(#32);

  LMDAnsiTab   = #9;
  LMDWideTab   = WideChar(#9);
  LMDTab       = TLMDChar(#9);

  LMDAnsiCR    = #13;
  LMDWideCR    = WideChar(#13);
  LMDCR        = TLMDChar(#13);

  LMDAnsiLF    = #10;
  LMDWideLF    = WideChar(#10);
  LMDLF        = TLMDChar(#10);

  LMDAnsiFF    = #12;
  LMDWideFF    = WideChar(#12);
  LMDFF        = TLMDChar(#12);

  LMDAnsiBEL    = #7;
  LMDWideBEL    = WideChar(#7);
  LMDBEL        = TLMDChar(#7);

  LMDAnsiBS    = #8;
  LMDWideBS    = WideChar(#8);
  LMDBS        = TLMDChar(#8);

  LMDAnsiESCAPE    = #27;
  LMDWideESCAPE    = WideChar(#27);
  LMDESCAPE        = TLMDChar(#27);

  LMDAnsiCRLF  = #13#10;
  LMDWideCRLF  = WideString(#13#10);

  //This code kills Delphi5 in at compilation something like: S := 'bebe' + LMDCRLF;
  //   LMDCRLF = TLMDString(#13#10);
  //Instead, we should write:
  {$ifdef LMD_UNICODE}
    LMDCRLF = #13#10;
  {$else}
    LMDCRLF = #13#10;
  {$endif}

type
  TLMDStringsProxy = class(TStrings)
  private
    FOrigin: TLMDStrings;
  protected
    function  Get(Index: Integer): String; override;
    procedure Put(Index: Integer; const S: String); override;
    function  GetCount: Integer; override;
    function  GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AOrigin: TLMDStrings);

    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: String); override;
    property  Origin: TLMDStrings read FOrigin;
  end;

  TLMDAnsiStringsProxy = class(TLMDStrings)
  private
    FOrigin: TStrings;
  protected
    function  Get(Index: Integer): TLMDBaseString; override;
    procedure Put(Index: Integer; const S: TLMDBaseString); override;
    function  GetCount: Integer; override;
    function  GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AOrigin: TStrings);

    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: TLMDBaseString); override;
    property  Origin: TStrings read FOrigin;
  end;

  TLMDStringHashNode = class
  private
    FKey:   TLMDString;
    FValue: TLMDString;
    FData:  TObject;
    FNext:  TLMDStringHashNode;
  public
    property Key: TLMDString read FKey;
    property Value: TLMDString read FValue;
    property Data: TObject read FData;
  end;

  TLMDStringHashNodeArray = array of TLMDStringHashNode;
  TLMDStringHashIterator  = record
    CurrentNode:   TLMDStringHashNode;
    InternalIndex: Integer;
  end;

  TLMDStringHashTable = class
  private
    FItems:      TLMDStringHashNodeArray;
    FIndexMask:  Integer;
    FCount:      Integer;
    FOwnItems:   Boolean;

    procedure Grow(AOldLength: Integer);
    procedure Rehash(AOldLength: Integer);
    procedure InsertItem(AItem: TLMDStringHashNode);
    procedure CheckNotOwnItems;
  public
    constructor Create(AOwnItems: Boolean = false);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(const AKey: TLMDString;
                  const AValue: TLMDString;
                  AObj: TObject); overload;
    procedure Add(const AKey: TLMDString;
                  const AValue: TLMDString); overload;
    procedure SetOrAdd(const AKey: TLMDString;
                       const AValue: TLMDString;
                       AObj: TObject); overload;
    procedure SetOrAdd(const AKey: TLMDString;
                       const AValue: TLMDString); overload;

    function  Remove(const AKey: TLMDString): Boolean;
    function  Find(const AKey: TLMDString): TLMDString; overload;
    function  Find(const AKey: TLMDString;
                   var Obj: TObject): TLMDString; overload;
    function  FindNode(const AKey: TLMDString): TLMDStringHashNode; overload;

    function  HasKey(const AKey: TLMDString): Boolean;

    function  IteratorMoveFirst(var Iter: TLMDStringHashIterator): Boolean;
    function  IteratorMoveNext(var Iter: TLMDStringHashIterator): Boolean;

    procedure Assign(AValue: TLMDStringHashTable);
    procedure Merge(AValue: TLMDStringHashTable);
    function  Clone: TLMDStringHashTable;

    property Count: Integer read FCount;
    property OwnItems: Boolean read FOwnItems;
  end;

{$IFDEF LMDCOMP12}function LMDAnsiMakeString(FLen: Integer; Seq : String) : String; overload;{$ENDIF}
function LMDAnsiMakeString(FLen: Integer; Seq : AnsiString) : AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiUpperChar(c: Char): Char; overload;{$ENDIF}
function  LMDAnsiUpperChar(c: AnsiChar): AnsiChar;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiIsSpace(c:  Char): Boolean; overload;{$ENDIF}
function  LMDAnsiIsSpace(c:  AnsiChar): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiIsAlphaNumeric(c: Char): Boolean; overload;{$ENDIF}
function  LMDAnsiIsAlphaNumeric(c: AnsiChar): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiIsAlpha(c: Char): Boolean; overload;{$ENDIF}
function  LMDAnsiIsAlpha(c: AnsiChar): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiIsNumeric(c: Char): Boolean; overload;{$ENDIF}
function  LMDAnsiIsNumeric(c: AnsiChar): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiIsNumericStr(s: String): Boolean; overload;{$ENDIF}
function  LMDAnsiIsNumericStr(s: AnsiString): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}

function LMDIsCharAlpha(c: TLMDChar): boolean;
function LMDIsCharAlphaNumeric(c: TLMDChar): boolean;
function LMDIsCharUpper(c: TLMDChar): boolean;
function LMDIsCharLower(c: TLMDChar): boolean;

{$IFDEF LMDCOMP12}function  LMDAnsiAddCharL(const aValue: String; i: Integer; c: Char): String; overload;{$ENDIF}
function  LMDAnsiAddCharL(const aValue: AnsiString; i: Integer; c: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideAddCharL(const aValue: WideString; i: Integer; c: WideChar): WideString;
function  LMDAddCharL(const aValue: TLMDString; i: Integer; c: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiAddCharR(const aValue: String; i: Integer; c: Char): String; overload;{$ENDIF}
function  LMDAnsiAddCharR(const aValue: AnsiString; i: Integer; c: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideAddCharR(const aValue: WideString; i: Integer; c: WideChar): WideString;
function  LMDAddCharR(const aValue: TLMDString; i: Integer; c: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiAddSpaceL(const aValue: String; i: Integer): String; overload;{$ENDIF}
function  LMDAnsiAddSpaceL(const aValue: AnsiString; i: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideAddSpaceL(const aValue: WideString; i: Integer): WideString;
function  LMDAddSpaceL(const aValue: TLMDString; i: Integer): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiAddSpaceR(const aValue: String; i: Integer): String; overload;{$ENDIF}
function  LMDAnsiAddSpaceR(const aValue: AnsiString; i: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideAddSpaceR(const aValue: WideString; i: Integer): WideString;
function  LMDAddSpaceR(const aValue: TLMDString; i: Integer): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiAddZeroL(const aValue: String; i: Integer): String; overload;{$ENDIF}
function  LMDAnsiAddZeroL(const aValue: AnsiString; i: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideAddZeroL(const aValue: WideString; i: Integer): WideString;
function  LMDAddZeroL(const aValue: TLMDString; i: Integer): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiAddZeroR(const aValue: String; i: Integer): String; overload;{$ENDIF}
function  LMDAnsiAddZeroR(const aValue: AnsiString; i: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideAddZeroR(const aValue: WideString; i: Integer): WideString;
function  LMDAddZeroR(const aValue: TLMDString; i: Integer): TLMDString;

{$ifdef LMDCOMP12}function LMDAnsiCodeInt(const X: array of LongInt; delimiter: Char): String; overload;{$ENDIF}
function  LMDAnsiCodeInt(const X: array of LongInt; delimiter: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideCodeInt(const X: array of LongInt; delimiter: WideChar): WideString;
function  LMDCodeInt(const X: array of LongInt; delimiter: TLMDChar): TLMDString;

{$IFDEF LMD_NATIVEUNICODE}function LMDAnsiCodeString(const X: array of String; delimiter: Char): String; overload;{$ENDIF}
function  LMDAnsiCodeString(const X: array of AnsiString; delimiter: AnsiChar): AnsiString; {$IFDEF LMD_NATIVEUNICODE} overload; {$ENDIF}
function  LMDWideCodeString(const X: array of WideString; delimiter: WideChar): WideString;
function  LMDCodeString(const X: array of TLMDString; delimiter: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiGetCodedCount(const aValue: String; delimiter: Char): Integer; overload;{$ENDIF}
function  LMDAnsiGetCodedCount(const aValue: AnsiString; delimiter: AnsiChar): Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideGetCodedCount(const aValue: WideString; delimiter: WideChar): Integer;
function  LMDGetCodedCount(const aValue: TLMDString; delimiter: TLMDChar): Integer;

{$IFDEF LMDCOMP12}function LMDAnsiIfThen(const AExpression: Boolean; const ATrue, AFalse: String): String; overload;{$ENDIF}
function LMDAnsiIfThen(const AExpression: Boolean; const ATrue, AFalse: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function LMDWideIfThen(const AExpression: Boolean; const ATrue, AFalse: WideString): WideString;
function LMDIfThen(const AExpression: Boolean; const ATrue, AFalse: TLMDString): TLMDString;

procedure LMDAnsiSetCodedString(var aValue : String; const partStr : String; delimiter: Char; index: Integer);
procedure LMDWideSetCodedString(var aValue : WideString; const partStr : WideString; delimiter: WideChar; index: Integer);
procedure LMDSetCodedString(var aValue : TLMDString; const partStr : TLMDString;
                            delimiter: TLMDChar; index: Integer);

{$IFDEF LMDCOMP12}function  LMDAnsiGetCodedInt(const aValue: String; delimiter: Char; index: Integer): LongInt; overload;{$ENDIF}
function  LMDAnsiGetCodedInt(const aValue: AnsiString; delimiter: AnsiChar; index: Integer): LongInt;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideGetCodedInt(const aValue: WideString; delimiter: WideChar;
                             index: Integer): LongInt;
function  LMDGetCodedInt(const aValue: TLMDString; delimiter: TLMDChar;
                         index: Integer): LongInt;

{$IFDEF LMDCOMP12}function  LMDAnsiGetCodedString(const aValue: String; delimiter: Char; index: Integer): String; overload;{$ENDIF}
function  LMDAnsiGetCodedString(const aValue: AnsiString; delimiter: AnsiChar; index: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideGetCodedString(const aValue: WideString; delimiter: WideChar;
                                index: Integer): WideString;
function  LMDGetCodedString(const aValue: TLMDString; delimiter: TLMDChar;
                            index: Integer): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiCount(const aValue: String; const search: Char): Integer; overload;{$ENDIF}
function  LMDAnsiCount(const aValue: AnsiString; const search: AnsiChar): Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideCount(const aValue: WideString; const search: WideChar): Integer;
function  LMDCount(const aValue: TLMDString; const search: TLMDChar): Integer;

{$IFDEF LMDCOMP12}function  LMDAnsiBackPos(c: Char; const s: String) : Integer; overload;{$ENDIF}
function  LMDAnsiBackPos(c: AnsiChar; const s: AnsiString) : Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideBackPos(c: WideChar; const s: WideString) : Integer;
function  LMDBackPos(c: TLMDChar; const s: TLMDString) : Integer;

{$IFDEF LMDCOMP12}function  LMDAnsiEmpty(const aValue: String): Boolean; overload;{$ENDIF}
function  LMDAnsiEmpty(const aValue: AnsiString): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideEmpty(const aValue: WideString): Boolean;
function  LMDEmpty(const aValue: TLMDString): Boolean;

{$IFDEF LMDCOMP12}function  LMDAnsiFillString(i: Integer; w: Char): String; overload;{$ENDIF}
function  LMDAnsiFillString(i: Integer; w: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideFillString(i: Integer; w: WideChar): WideString;
function  LMDFillString(i: Integer; w: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiCenterString(const S: String; Len: Integer): String; overload;{$ENDIF}
function  LMDAnsiCenterString(const S: AnsiString; Len: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideCenterString(const S: WideString; Len: Integer): WideString;
function  LMDCenterString(const S: TLMDString; Len: Integer): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiMakeSpace(i: Cardinal): String; overload;{$ENDIF}
function  LMDAnsiMakeSpace(i: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideMakeSpace(i: Integer): WideString;
function  LMDMakeSpace(i: Integer): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiSlashRemove(const aValue: String): String; overload;{$ENDIF}
function  LMDAnsiSlashRemove(const aValue: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideSlashRemove(const aValue: WideString): WideString;
function  LMDSlashRemove(const aValue: TLMDString): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiSlashAdd(const aValue: String): String; overload;{$ENDIF}
function  LMDAnsiSlashAdd(const aValue: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideSlashAdd(const aValue: WideString): WideString;
function  LMDSlashAdd(const aValue: TLMDString): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiReplaceChar(const aValue: String; toReplace, Replace: Char): String; overload;{$ENDIF}
function  LMDAnsiReplaceChar(const aValue: AnsiString; toReplace, Replace: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideReplaceChar(const aValue: WideString; toReplace,
                             Replace: WideChar): WideString;
function  LMDReplaceChar(const aValue: TLMDString; toReplace,
                         Replace: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiTrimL(const aValue: String): String; overload;{$ENDIF}
function  LMDAnsiTrimL(const aValue: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideTrimL(const aValue: WideString): WideString;
function  LMDTrimL(const aValue: TLMDString): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiTrimR(const aValue: String): String; overload;{$ENDIF}
function  LMDAnsiTrimR(const aValue: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideTrimR(const aValue: WideString): WideString;
function  LMDTrimR(const aValue: TLMDString): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiTrim(const aValue: String): String; overload;{$ENDIF}
function  LMDAnsiTrim(const aValue: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideTrim(const aValue: WideString): WideString;
function  LMDTrim(const aValue: TLMDString): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiGetFirstString(const aValue: String; delimiter: Char): String; overload;{$ENDIF}
function  LMDAnsiGetFirstString(const aValue: AnsiString; delimiter: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideGetFirstString(const aValue: WideString; delimiter: WideChar): WideString;
function  LMDGetFirstString(const aValue: TLMDString; delimiter: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiGetLastString(const aValue: String; delimiter: Char): String; overload;{$ENDIF}
function  LMDAnsiGetLastString(const aValue: AnsiString; delimiter: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideGetLastString(const aValue: WideString; delimiter: WideChar): WideString;
function  LMDGetLastString(const aValue: TLMDString; delimiter: TLMDChar): TLMDString;

function  LMDAnsiGetSecondString(const aValue: String; delimiter: Char): String; overload;
function  LMDWideGetSecondString(const aValue: WideString; delimiter: WideChar): WideString;
function  LMDGetSecondString(const aValue: TLMDString; delimiter: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiGetRightTrimmedString(const aValue: String; delimiter: Char): String; overload;{$ENDIF}
function  LMDAnsiGetRightTrimmedString(const aValue: AnsiString; delimiter: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideGetRightTrimmedString(const aValue: WideString; delimiter: WideChar): WideString;
function  LMDGetRightTrimmedString(const aValue: TLMDString; delimiter: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiAddDelimiter(s: String; delimiter: Char): String; overload;{$ENDIF}
function  LMDAnsiAddDelimiter(s: AnsiString; delimiter: AnsiChar): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideAddDelimiter(s: WideString; delimiter: WideChar): WideString;
function  LMDAddDelimiter(s: TLMDString; delimiter: TLMDChar): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiScanToNumber(const aValue: String) : Integer; overload;{$ENDIF}
function  LMDAnsiScanToNumber(const aValue: AnsiString) : Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideScanToNumber(const aValue: WideString) : Integer;
function  LMDScanToNumber(const aValue: TLMDString) : Integer;

procedure LMDSetString(var aValue: TLMDString; buff: PLMDChar; len: Integer);
function  LMDStrLen(AStr: PLMDChar): Integer;

function LMDCheckWildCardMask(aMask, aStr: TLMDString): boolean;

function LMDCharArrayToString(const Arr: TLMDCharArray; AStart, ACount: Integer): TLMDString;

{Simple Encryption Routines}
{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function  LMDAnsiEncode(const aValue: String; Key: DWord): String; overload;{$ENDIF}
function  LMDAnsiEncode(const aValue: AnsiString; Key: DWord): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiDecode(const aValue: String; Key: DWord): String; overload;{$ENDIF}
function  LMDAnsiDecode(const aValue: AnsiString; Key: DWord): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiEncode64(const aValue: String): String; overload;{$ENDIF}
function  LMDAnsiEncode64(const aValue: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
{$IFDEF LMDCOMP12}function  LMDAnsiDecode64(const aValue: String): String; overload;{$ENDIF}
function  LMDAnsiDecode64(const aValue: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}

{Conversion Routines}
{------------------------------------------------------------------------------}
procedure LMDAnsiStringToFont(const aValue: String; aFont: TFont);
function  LMDAnsiStringToPoint(const aValue: String): TPoint;
function  LMDAnsiStringToRect(const aValue: String): TRect;
function  LMDAnsiFontToString(aFont: TFont): String;
function  LMDAnsiPointToString(const aValue: TPoint): String;
function  LMDAnsiRectToString(const aValue: TRect): String;

{StringList related routines}
{------------------------------------------------------------------------------}
function  LMDAnsiRemoveEmptyLines(list: TStrings): Boolean;
function  LMDWideRemoveEmptyLines(list: TLMDWideStrings): Boolean;
function  LMDRemoveEmptyLines(list: TLMDStrings): Boolean;

procedure LMDAnsiParseToStrList(const w: String; const delimiter: Char; list: TStrings); overload;
procedure LMDWideParseToStrList(const w: WideString; const delimiter: WideChar; list: TLMDWideStrings);
procedure LMDParseToStrList(const w: TLMDString; const delimiter: TLMDChar;
                            list: TLMDStrings);

procedure LMDAnsiGetDivider(dest: TStrings; const aValue: LongInt);
procedure LMDWideGetDivider(dest: TLMDWideStrings; const aValue: LongInt);
procedure LMDGetDivider(dest: TLMDStrings; const aValue: LongInt);

{Advanced AnsiString routines}
{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function  LMDAnsiPosEx(const substr, s: String; Index: Integer): Integer; overload;{$ENDIF}
function  LMDAnsiPosEx(const substr, s: AnsiString; Index: Integer): Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWidePosEx(const substr, s: WideString; Index: Integer): Integer;
function  LMDPosEx(const substr, s: TLMDString; Index: Integer): Integer;

{$IFDEF LMDCOMP12}function  LMDAnsiReplaceStr(const S, Srch, Replace: String): String; overload;{$ENDIF}
function  LMDAnsiReplaceStr(const S, Srch, Replace: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideReplaceStr(const S, Srch, Replace: WideString): WideString;
function  LMDReplaceStr(const S, Srch, Replace: TLMDString): TLMDString;

{8.0}
{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function  LMDAnsiWriteStringToStream(S: TStream; const Str: String): Boolean; overload;{$ENDIF}
function  LMDAnsiWriteStringToStream(S: TStream; const Str: AnsiString): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideWriteStringToStream(S: TStream; const Str: WideString): Boolean;
function  LMDWriteStringToStream(S: TStream; const Str: TLMDString): Boolean;

{$IFDEF LMDCOMP12}function  LMDAnsiReadStringFromStream(S: TStream; var Str: String): Boolean; overload;{$ENDIF}
function  LMDAnsiReadStringFromStream(S: TStream; var Str: AnsiString): Boolean;  {$IFDEF LMDCOMP12} overload;{$ENDIF}
function  LMDWideReadStringFromStream(S: TStream; var Str: WideString): Boolean;
function  LMDReadStringFromStream(S: TStream; var Str: TLMDString): Boolean;

{$IFDEF LMDCOMP12}function  LMDAnsiH2D(const S: String): Integer; overload;{$ENDIF}
function  LMDAnsiH2D(const S: AnsiString): Integer; {$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideH2D(const S: WideString): Integer;
function  LMDH2D(const S: TLMDString): Integer;

{$IFDEF LMDCOMP12}function  LMDAnsiH2DDef(const S: String; Def: Integer): Integer; overload;{$ENDIF}
function  LMDAnsiH2DDef(const S: AnsiString; Def: Integer): Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideH2DDef(const S: WideString; Def: Integer): Integer;
function  LMDH2DDef(const S: TLMDString; Def: Integer): Integer;

{$IFDEF LMDCOMP12}function  LMDAnsiStrStartsWith(Source, Seq: PChar ): Boolean; overload;{$ENDIF}
function  LMDAnsiStrStartsWith(Source, Seq: PAnsiChar ): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideStrStartsWith(Source, Seq: PWideChar
                               ): Boolean;
function  LMDStrStartsWith(Source, Seq: PLMDChar
                           ): Boolean;

{$IFDEF LMDCOMP12}function  LMDAnsiContainsAt(const Source: String; Index: Integer; const Seq: String): Boolean; overload;{$ENDIF}
function  LMDAnsiContainsAt(const Source: AnsiString; Index: Integer; const Seq: AnsiString): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideContainsAt(const Source: WideString; Index: Integer;
                            const Seq: WideString): Boolean;
function  LMDContainsAt(const Source: TLMDString; Index: Integer;
                        const Seq: TLMDString): Boolean;

{$IFDEF LMDCOMP12}function  LMDAnsiLastPos(const SubStr, Strn: String): Integer; overload;{$ENDIF}
function  LMDAnsiLastPos(const SubStr, Strn: AnsiString): Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideLastPos(const SubStr, Strn: WideString): Integer;
function  LMDLastPos(const SubStr, Strn: TLMDString): Integer;

{$IFDEF LMDCOMP12}function  LMDAnsiExtractStr(var S: String; SPos, SLen: Integer): String; overload;{$ENDIF}
function  LMDAnsiExtractStr(var S: AnsiString; SPos, SLen: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideExtractStr(var S: WideString; SPos, SLen: Integer): WideString;
function  LMDExtractStr(var S: TLMDString; SPos, SLen: Integer): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiUpperCase(const Str: String): String; overload;{$ENDIF}
function  LMDAnsiUpperCase(const Str: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideUpperCase(const Str: WideString): WideString;
function  LMDUpperCase(const Str: TLMDString): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiLowerCase(const Str: String): String; overload;{$ENDIF}
function  LMDAnsiLowerCase(const Str: AnsiString): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideLowerCase(const Str: WideString): WideString;
function  LMDLowerCase(const Str: TLMDString): TLMDString;

{$IFDEF LMDCOMP12}function  LMDAnsiUpperCaseChar(C: Char): Char; overload;{$ENDIF}
function  LMDAnsiUpperCaseChar(C: AnsiChar): AnsiChar;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideUpperCaseChar(C: WideChar): WideChar;
function  LMDUpperCaseChar(C: TLMDChar): TLMDChar;

{$IFDEF LMDCOMP12}function  LMDAnsiLowerCaseChar(C: Char): Char; overload;{$ENDIF}
function  LMDAnsiLowerCaseChar(C: AnsiChar): AnsiChar;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideLowerCaseChar(C: WideChar): WideChar;
function  LMDLowerCaseChar(C: TLMDChar): TLMDChar;

{$IFDEF LMDCOMP12}function  LMDAnsiStringToStream(const Str: String; Stream: TStream): Integer; overload;{$ENDIF}
function  LMDAnsiStringToStream(const Str: AnsiString; Stream: TStream): Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideStringToStream(const Str: WideString; Stream: TStream): Integer;
function  LMDStringToStream(const Str: TLMDString; Stream: TStream): Integer;

{$IFDEF LMDCOMP12}function  LMDAnsiStreamToString(Stream: TStream; Size: Int64): String; overload;{$ENDIF}
function  LMDAnsiStreamToString(Stream: TStream; Size: Integer): AnsiString;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function  LMDWideStreamToString(Stream: TStream; Size: Integer): WideString;
function  LMDStreamToString(Stream: TStream; Size: Integer): TLMDString;

function LMDSameText(const S1, S2: TLMDString): Boolean;
{$IFDEF LMDCOMP12}function LMDAnsiSameText(const Str1, Str2: String): Boolean; overload;{$ENDIF}
function LMDAnsiSameText(const Str1, Str2: AnsiString): Boolean;{$IFDEF LMDCOMP12} overload; {$ENDIF}

function LMDCompareStr(const S1, S2: TLMDString): Integer;
{$IFDEF LMDCOMP12}function LMDAnsiCompareStr(const S1, S2: String): Integer; overload;{$ENDIF}
function LMDAnsiCompareStr(const S1, S2: AnsiString): Integer;{$IFDEF LMDCOMP12} overload; {$ENDIF}
function LMDWideCompareStr(const S1, S2: WideString): Integer;

{$ifdef LMDCOMP12}
function LMDAnsiCharInSet(const AChar: Char; ASet: TSysCharSet): Boolean; overload; inline;
{$else}
 {$endif}
function LMDAnsiCharInSet(const AChar: AnsiChar; ASet: TSysCharSet): Boolean; {$ifdef LMDCOMP12} overload; {$else}{$endif} {$ifdef LMD_INLINE}inline;{$endif}
function LMDWideCharInSet(const AChar: WideChar; ASet: TSysCharSet): Boolean; {$ifdef LMD_INLINE}inline;{$endif}
function LMDCharInSet(const AChar: TLMDChar; ASet: TSysCharSet): Boolean; {$ifdef LMD_INLINE}inline;{$endif}

{AnsiString routines from ElStrUtils}
{------------------------------------------------------------------------------}
function LMDPrettyStrToCurr(const Value: String): Currency;
function LMDAnsiReplace(var Str: String; SourceString, DestString: String): boolean;
function LMDWideReplace(var Str: WideString; const SourceString, DestString: WideString): Boolean;
function LMDIntToStrFmt(value: integer): String;

implementation

uses
  {$ifdef LMDCOMP12}
  AnsiStrings,
  {$endif}
  Math, LMDHashTable, LMDProcs, LMDClass;

type
  TStringsAccess    = class(TStrings);
  TLMDStringsAccess = class(TLMDStrings);

{****************************** TLMDStringsProxy ******************************}
{------------------------------------------------------------------------------}
function TLMDStringsProxy.Get(Index: Integer): String;
begin
  Result := FOrigin[Index];
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsProxy.Put(Index: Integer; const S: String);
begin
  FOrigin[Index] := S;
end;

{------------------------------------------------------------------------------}
function TLMDStringsProxy.GetCount: Integer;
begin
  Result := FOrigin.Count;
end;

{------------------------------------------------------------------------------}
function TLMDStringsProxy.GetObject(Index: Integer): TObject;
begin
  Result := FOrigin.Objects[Index];
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsProxy.PutObject(Index: Integer; AObject: TObject);
begin
  FOrigin.Objects[Index] := AObject;
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsProxy.SetUpdateState(Updating: Boolean);
begin
  TStringsAccess(FOrigin).SetUpdateState(Updating);
  end;

{------------------------------------------------------------------------------}
constructor TLMDStringsProxy.Create(AOrigin: TLMDStrings);
begin
  inherited Create;
  FOrigin := AOrigin;
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsProxy.Clear;
begin
  FOrigin.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsProxy.Delete(Index: Integer);
begin
  FOrigin.Delete(Index);
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsProxy.Insert(Index: Integer; const S: String);
begin
  FOrigin.Insert(Index, S);
end;

{**************************** TLMDAnsiStringsProxy ****************************}
{------------------------------------------------------------------------------}
function TLMDAnsiStringsProxy.Get(Index: Integer): TLMDBaseString;
begin
  Result := FOrigin[Index];
end;

{------------------------------------------------------------------------------}
procedure TLMDAnsiStringsProxy.Put(Index: Integer; const S: TLMDBaseString);
begin
  FOrigin[Index] := S;
end;

{------------------------------------------------------------------------------}
function TLMDAnsiStringsProxy.GetCount: Integer;
begin
  Result := FOrigin.Count;
end;

{------------------------------------------------------------------------------}
function TLMDAnsiStringsProxy.GetObject(Index: Integer): TObject;
begin
  Result := FOrigin.Objects[Index];
end;

{------------------------------------------------------------------------------}
procedure TLMDAnsiStringsProxy.PutObject(Index: Integer; AObject: TObject);
begin
  FOrigin.Objects[Index] := AObject;
end;

{------------------------------------------------------------------------------}
procedure TLMDAnsiStringsProxy.SetUpdateState(Updating: Boolean);
begin
  TLMDStringsAccess(FOrigin).SetUpdateState(Updating);
  end;

{------------------------------------------------------------------------------}
constructor TLMDAnsiStringsProxy.Create(AOrigin: TStrings);
begin
  inherited Create;
  FOrigin := AOrigin;
end;

{------------------------------------------------------------------------------}
procedure TLMDAnsiStringsProxy.Clear;
begin
  FOrigin.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDAnsiStringsProxy.Delete(Index: Integer);
begin
  FOrigin.Delete(Index);
end;

{------------------------------------------------------------------------------}
procedure TLMDAnsiStringsProxy.Insert(Index: Integer; const S: TLMDBaseString);
begin
  FOrigin.Insert(Index, S);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiUpperChar(c: Char): Char;
begin
  Result := LMDWideUpperCaseChar(c);
end;
{$ENDIF}
function LMDAnsiUpperChar(c: AnsiChar): AnsiChar;
begin
  Result := C;
  if  not LMDAnsiIsSpace(C) then
  CharUpperBuff(@Result, 1);
  end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiIsSpace(c:  Char): Boolean;
begin
  Result := LMDWideGetCharCategory(c) in [ukZs, ukMc];
end;
{$ENDIF}
function LMDAnsiIsSpace(c:  AnsiChar): Boolean;
begin
  Result := (Ord(c) in [Ord('!'),Ord('"'),Ord('#'),Ord('$'),Ord('%'),Ord('&'),
                        Ord(''''),Ord('('),Ord(')'), Ord('*'),Ord('+'),Ord(','),
                        Ord('-'),Ord('.'),Ord('/'),Ord(':'),Ord(';'),Ord('<'),
                        Ord('='),Ord('>'),Ord('?'),Ord('@'),Ord('['),Ord('\'),
                        Ord(']'),Ord('^'),Ord('`'), Ord('{'),Ord('|'),Ord('}'),
                        Ord('¦')]) or (Ord(c) <= 32);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function  LMDAnsiIsAlphaNumeric(c: Char): Boolean;
begin
  result := IsCharAlphaNumericW(c);
end;
{$ENDIF}
function  LMDAnsiIsAlphaNumeric(c: AnsiChar): Boolean;
begin
  result := IsCharAlphaNumericA(c);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function  LMDAnsiIsAlpha(c:  Char): Boolean;
begin
  result := IsCharAlphaW(c)
end;
{$ENDIF}
function  LMDAnsiIsAlpha(c:  AnsiChar): Boolean;
begin
  result := IsCharAlphaA(c)
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function  LMDAnsiIsNumeric(c:  Char): Boolean;
begin
  result := (not IsCharAlphaW(c)) and IsCharAlphaNumericW(c)
end;
{$ENDIF}
function  LMDAnsiIsNumeric(c:  AnsiChar): Boolean;
begin
  result := (not IsCharAlphaA(c)) and IsCharAlphaNumericA(c)
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiIsNumericStr(s: String): Boolean;
var
  i: integer;
begin
  Result := false;
  for i := 1 to Length(S) do
    if IsCharAlphaW(s[i]) and (not IsCharAlphaNumericW(s[i])) then
      exit;
  Result := true;
end;
{$ENDIF}
function LMDAnsiIsNumericStr(s: AnsiString): Boolean;
var
  i: integer;
begin
  Result := false;
  for i := 1 to Length(S) do
    if IsCharAlphaA(s[i]) and (not IsCharAlphaNumericA(s[i])) then
      exit;
  Result := true;
end;

{------------------------------------------------------------------------------}
function LMDIsCharAlpha(c: TLMDChar): boolean;
begin
  {$IFDEF LMD_UNICODE}
  result := IsCharAlphaW(c);
  {$ELSE}
  result := IsCharAlphaA(c);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDIsCharAlphaNumeric(c: TLMDChar): boolean;
begin
  {$IFDEF LMD_UNICODE}
  result := IsCharAlphaNumericW(c);
  {$ELSE}
  result := IsCharAlphaNumericA(c);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDIsCharUpper(c: TLMDChar): boolean;
begin
  {$IFDEF LMD_UNICODE}
  result := IsCharUpperW(c);
  {$ELSE}
  result := IsCharUpperA(c);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDIsCharLower(c: TLMDChar): boolean;
begin
  {$IFDEF LMD_UNICODE}
  result := IsCharLowerW(c);
  {$ELSE}
  result := IsCharLowerA(c);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiAddCharL(const aValue: String; i: Integer; c: Char): String;
begin
  Result := LMDWideAddCharL(aValue, i, c);
end;
{$ENDIF}
function LMDAnsiAddCharL(const aValue: AnsiString; i: Integer; c: AnsiChar): AnsiString;
begin
  Result:=LMDAnsiFillstring(i-Length(aValue), c)+aValue;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiAddCharR(const aValue: String; i: Integer; c: Char): String;
begin
  Result := LMDWideAddCharR(aValue, i, c);
end;
{$ENDIF}
function LMDAnsiAddCharR(const aValue: AnsiString; i: Integer; c: AnsiChar): AnsiString;
begin
  Result:=aValue+LMDAnsiFillstring(i-Length(aValue), c);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiAddSpaceL(const aValue: String; i: Integer): String;
begin
  Result := LMDWideAddSpaceL(aValue, i);
end;
{$ENDIF}
function LMDAnsiAddSpaceL(const aValue: AnsiString; i: Integer): AnsiString;
begin
  Result:=LMDAnsiAddCharL(aValue, i, #32);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiAddSpaceR(const aValue: String; i: Integer): String;
begin
  Result := LMDWideAddSpaceR(aValue, i);
end;
{$ENDIF}
function LMDAnsiAddSpaceR(const aValue: AnsiString; i: Integer): AnsiString;
begin
  Result:=LMDAnsiAddCharR(aValue, i, #32);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiAddZeroL(const aValue: String; i: Integer): String;
begin
  Result := LMDWideAddZeroL(aValue, i);
end;
{$ENDIF}
function LMDAnsiAddZeroL(const aValue: AnsiString; i: Integer): AnsiString;
begin
  Result:=LMDAnsiAddCharL(aValue, i, #48);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiAddZeroR(const aValue: String; i: Integer): String;
begin
  Result := LMDWideAddZeroR(aValue, i);
end;
{$ENDIF}
function LMDAnsiAddZeroR(const aValue: AnsiString; i: Integer): AnsiString;
begin
  Result:=LMDAnsiAddCharR(aValue, i, #48);
end;

{------------------------------------------------------------------------------}
{$ifdef LMD_NATIVEUNICODE}
{------------------------------------------------------------------------------}
function LMDAnsiCodeString(const X: array of String; delimiter: Char): String;
var
  i: Integer;
begin
  Result:=X[0];
  if SizeOf(x)>1 then
    for i:=1 to High(X) do Result:=Result+delimiter+X[i];
end;
{$endif}
{------------------------------------------------------------------------------}
function LMDAnsiCodeString(const X: array of AnsiString; delimiter: AnsiChar): AnsiString;
var
  i: Integer;
begin
  Result := X[0];
  if SizeOf(x) > 1 then
    for i := 1 to High(X) do
      Result := Result + delimiter + X[i];
end;

{$ifdef LMDCOMP12}
{------------------------------------------------------------------------------}
function LMDAnsiCodeInt(const X: array of LongInt; delimiter: Char): String;
begin
  Result := LMDWideCodeInt(X, delimiter);
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function LMDAnsiCodeInt(const X: array of LongInt; delimiter: AnsiChar): AnsiString;
var
  i: Integer;
begin
  Result := AnsiString(IntToStr(X[0]));
  if SizeOf(x) > 1 then
    for i:=1 to High(X) do
      Result := Result + delimiter + AnsiString(IntToStr(X[i]));
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiGetCodedCount(const aValue: String; delimiter: Char): Integer;
begin
  Result := LMDWideGetCodedCount(aValue, delimiter);
end;
{$ENDIF}
function LMDAnsiGetCodedCount(const aValue: AnsiString; delimiter: AnsiChar): Integer;
var
  i: Integer;
  tmp: AnsiString;
begin

  Result:=0;
  i:=Pos(delimiter, aValue);
  if i=0 then
    begin
      if (Length(aValue)>0) then Result:=1;
      exit;
    end;

  Result:=1;
  tmp:=aValue;
  while i<>0 do
    begin
      tmp[i]:=chr(0);
      i:=Pos(delimiter, tmp);
      inc(Result);
    end;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiGetCodedInt(const aValue: String; delimiter: Char; index: Integer): LongInt;
begin
  Result := LMDWideGetCodedInt(aValue, delimiter, index);
end;
{$ENDIF}
function LMDAnsiGetCodedInt(const aValue: AnsiString; delimiter: AnsiChar; index: Integer): LongInt;
var
  tmp: AnsiString;
begin
  tmp := LMDAnsiGetCodedString(aValue, delimiter, index);
  if tmp = '' then
    Result := -1
  else
    Result := StrToInt(String(tmp));
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiGetCodedString(const aValue: String; delimiter: Char; index: Integer): String;
begin
  Result := LMDWideGetCodedString(aValue, delimiter, index);
end;
{$ENDIF}
function LMDAnsiGetCodedString(const aValue: AnsiString; delimiter: AnsiChar; index: Integer): AnsiString;
var
  i, last, counter: Integer;
  tmp: AnsiString;
begin
  Result:='';
  i:=Pos(delimiter, aValue);
  if index=0 then
    begin
      //get whole AnsiString if only onew is set or get first columns AnsiString
      if (i=0) then Result:=aValue else Result:=copy(aValue, 1,i-1);
      exit;
    end;
  //we want to access an index > 0 but there's no delimiter =>
  //column's AnsiString not available
  if i=0 then exit;

  Counter:=0;
  tmp:=aValue;
  while i<>0 do
    begin
      tmp[i]:=chr(0);
      last:=i+1;
      i:=Pos(delimiter, tmp);
      inc(Counter);
      if Counter=Index then
        begin
          if i=0 then i:=Length(aValue)+1;
          Result:=Copy(aValue, last, i-last);
          exit;
        end;
    end;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiIfThen(const AExpression: Boolean; const ATrue, AFalse: String): String;
begin
  Result := LMDWideIfThen(AExpression,ATrue, AFalse);
end;
{$ENDIF}
function LMDAnsiIfThen(const AExpression: Boolean; const ATrue, AFalse: AnsiString): AnsiString;
begin
  if AExpression then
    Result := ATrue
  else
    Result := AFalse;
end;

{------------------------------------------------------------------------------}
function LMDWideIfThen(const AExpression: Boolean; const ATrue, AFalse: WideString): WideString;
begin
  if AExpression then
    Result := ATrue
  else
    Result := AFalse;
end;

{------------------------------------------------------------------------------}
function LMDIfThen(const AExpression: Boolean; const ATrue, AFalse: TLMDString): TLMDString;
begin
  if AExpression then
    Result := ATrue
  else
    Result := AFalse;
end;

{------------------------------------------------------------------------------}
procedure LMDAnsiSetCodedString(var aValue : String; const partStr : String; delimiter: Char; index: Integer);
var
  i : Integer;

  leftChar,
  rightChar,
  replaceChars,
  delim         : Integer;

begin
  // possible values for aValue
  //    aValue : := empty | item | { item delim } | aValue aValue

  // index is a zero based index value

  // s := aValue;  //backup aValue

  delim := 0; //no left delimiter (no delim in aValue at all, index = 0)
  leftChar := 1; //set counter on first AnsiChar of aValue

  //let's lookout for the delimiter, identifiying the str to be replaced
  while (delim < index) and (leftChar <= Length(aValue)) do
    begin
      if aValue[leftChar] = delimiter then
        inc(delim);
      inc(leftChar);
    end;
  //leftChar is set on first AnsiChar to be replaced

  //lets start the search for the right delimiter on the left AnsiChar
  rightChar := leftChar;
  while (delim < index+1) and (rightChar <= Length(aValue)) do
    begin
      if aValue[rightChar] = delimiter then
        inc(delim);
      inc(rightChar);
    end;

  //we need to correct the rightChar here for one special case
  // something delimiter soemthing delimiter i
  // i = rightChar, that's one too high
  if (rightChar <>  leftChar) and (aValue[rightChar-1] = delimiter) then
     dec (rightChar);

  //right AnsiChar should now be on the last AnsiChar of the AnsiString to be replaced

  {

        '' left, right = 1
        'a' left = 2, right = 2
        'aa' left = 3, right = 3
        'a|' left = 3, right = 3
        'a|b' left =  3, right = 4
        'a|b|' left = 3, right = 5
        'aa|'
        '|b'
        '|b|'
        '|bb'
        'aa|bb' left  = 4, right = 6
        '|bb|'
        'aa|bb|'
        '|'
        '||'

  }

  //now we have to check leftChar and rightChar

  //check whether we have to less delimiters
  if index > delim then
    begin
      //add delimiters if needed -> otherwise whis loop will do nothing
      for i := index-1 downTo delim do
        aValue := aValue + delimiter;

      //let's move left and right AnsiChar by the inserted delimiters ...
      inc (leftChar, index-delim);
      inc (rightChar, index-delim);
    end;
  //now we are sure that we have enough delimiters for doing the job

  //let's calc the amount of chars to be replaced
  replaceChars := rightChar - leftChar;

  //remove any chars which we have to replace
  Delete (aValue, leftChar, replaceChars);

  //insert the new AnsiString at the approviate position
  Insert (partStr, aValue, leftChar);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiCount(const aValue: String; const search: Char): Integer;
begin
  Result := LMDWideCount(aValue,search);
end;
{$ENDIF}
function LMDAnsiCount(const aValue: AnsiString; const search: AnsiChar): Integer;
var
  Start, TextEnd : PAnsiChar;
  begin
  Result:=0;
  if Length(aValue) <> 0 then
    begin
      Start := Pointer(aValue);
      TextEnd := Start + Length (aValue);
      //start < TextEnd; Result = 0
      while Start < TextEnd do
        begin
          //start < TextEnd
          if Start^ = search then inc(Result);
          inc(Start);
          //start = start + 1; start <= TextEnd
        end;
      //start = TextEnd; Result = #search
    end;
  end;

//the function LMDBackPos returns the position in the AnsiString where
//the specified character c occurs LAST
{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiBackPos(c: Char; const s: String) : Integer;
begin
  Result := LMDWideBackPos(c,s);
end;
{$ENDIF}
function LMDAnsiBackPos(c: AnsiChar; const s: AnsiString) : Integer;
var
  Source, SourceEnd : PAnsiChar;
  begin
  Result := 0;
  Source := Pointer(s);
  SourceEnd := Source + Length (s);
  while (SourceEnd > Source) and (SourceEnd^ <> c) do
    //SourceEnd-1 >= Source
    dec (SourceEnd);
  if SourceEnd^ = c then
    Result := SourceEnd - Source + 1;
 end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiEmpty(const aValue: String): Boolean;
begin
  Result := LMDWideEmpty(aValue);
end;
{$ENDIF}
function LMDAnsiEmpty(const aValue: AnsiString): Boolean;
var
  Start, TextEnd : PChar;
  begin
  Result:=True;
  if Length(aValue)=0 then exit;
  Start := Pointer (aValue);
  TextEnd := Start + Length (aValue);
  while Start < TextEnd do
    if Start^ = ' ' then inc(Start) else
      begin
        Result:= False;
        exit;
      end;
  end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiFillString(i: Integer; w: Char): String;
begin
  Result := LMDWideFillString(i, w);
end;
{$ENDIF}
function LMDAnsiFillString(i: Integer; w: AnsiChar): AnsiString;

begin
  if i > 0 then
  begin
    SetLength(Result, i);
    FillChar(Result[1], Length(Result), w);
    end
  else
    Result:='';
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiCenterString(const S: String; Len: Integer): String;
begin
  Result := LMDWideCenterString(S, Len);
end;
{$ENDIF}
function LMDAnsiCenterString(const S: AnsiString; Len: Integer): AnsiString;
begin
  if length(S) < Len then
    begin
      Result:= LMDAnsiFillString((Len div 2) - (length(S) div 2), AnsiChar(' ')) + S;
      Result:= Result + LMDAnsiFillString(Len - length(Result), AnsiChar(' '));
    end
  else
    Result:= S;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiTrimL(const aValue: String): String;
begin
  Result := LMDWideTrimL(aValue);
end;
{$ENDIF}
function LMDAnsiTrimL(const aValue: AnsiString): AnsiString;
begin
  Result := TrimLeft(aValue);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiTrimR(const aValue: String): String;
begin
  Result := LMDWideTrimR(aValue);
end;
{$ENDIF}
function LMDAnsiTrimR(const aValue: AnsiString): AnsiString;
begin
  Result:=TrimRight(aValue);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiTrim(const aValue: String): String;
begin
  Result := LMDWideTrim(aValue);
end;
{$ENDIF}
function LMDAnsiTrim(const aValue: AnsiString): AnsiString;
begin
  Result:=Trim(aValue);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiGetFirstString(const aValue: String; delimiter: Char): String;
begin
  Result := LMDWideGetFirstString(aValue, delimiter);
end;
{$ENDIF}
function LMDAnsiGetFirstString(const aValue: AnsiString; delimiter: AnsiChar): AnsiString;
var
  p: Integer;
begin
  p:=Pos(Delimiter, aValue);
  if p=0 then Result:=aValue else Result:=Copy(aValue, 1, Pred(p));
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiGetLastString(const aValue: String; delimiter: Char): String;
begin
  Result := LMDWideGetLastString(aValue, delimiter);
end;
{$ENDIF}
function LMDAnsiGetLastString(const aValue: AnsiString; delimiter: AnsiChar): AnsiString;
var
  p: Integer;
begin
  p:=LastDelimiter(Delimiter, aValue);
  if p=0 then Result:=aValue else Result:=Copy(aValue, Succ(p), Length(aValue));
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiGetRightTrimmedString(const aValue: String; delimiter: Char): String;
begin
  Result := LMDWideGetRightTrimmedString(aValue, delimiter);
end;
{$ENDIF}
function LMDAnsiGetRightTrimmedString(const aValue: AnsiString; delimiter: AnsiChar): AnsiString;
var
  p: Integer;
begin
  p:=LastDelimiter(Delimiter, aValue);
  if p=0 then Result:=aValue else Result:=Copy(aValue, 1, Pred(p));
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiAddDelimiter(s: String; delimiter: Char): String;
begin
  Result := LMDWideAddDelimiter(s, delimiter);
end;
{$ENDIF}
function LMDAnsiAddDelimiter(s: AnsiString; delimiter: AnsiChar): AnsiString;
begin
  if s <> '' then
    Result := s + delimiter
  else
    Result := s;
end;

{------------------------------------------------------------------------------}
function LMDAnsiGetSecondString(const aValue: String; delimiter: Char): String;
var
  p: Integer;
begin
  p:=Pos(Delimiter, aValue);
  if p=0 then Result:=aValue else Result:=Copy(aValue, Succ(p),
                                               length(aValue));
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiReplaceChar(const aValue: String; toReplace, Replace: Char): String;
begin
  Result := LMDWideReplaceChar(aValue, toReplace, Replace);
end;
{$ENDIF}
function LMDAnsiReplaceChar(const aValue: AnsiString; toReplace, Replace: AnsiChar): AnsiString;
var
  i: Integer;
begin
  Result:=aValue;
  for i:=1 to Length(Result) do
    if Result[i]=toReplace then Result[i]:=Replace;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiMakeSpace(i: Cardinal): String;
begin
  Result := LMDWideMakeSpace(i);
end;
{$ENDIF}
function LMDAnsiMakeSpace(i: Integer): AnsiString;
begin
  Result := LMDAnsiFillString(i, AnsiChar(' '));
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiSlashAdd(const aValue: String): String;
begin
  Result := LMDWideSlashAdd(aValue);
end;
{$ENDIF}
function LMDAnsiSlashAdd(const aValue: AnsiString): AnsiString;
begin
  Result:=aValue;
  if LMDAnsiEmpty(Result) or (Result[length(Result)]<>'\') then Result:=Result+'\';
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiSlashRemove(const aValue: String): String;
begin
  Result := LMDWideSlashRemove(aValue);
end;
{$ENDIF}
function LMDAnsiSlashRemove(const aValue: AnsiString): AnsiString;
begin
  Result:=aValue;
  if LMDAnsiEmpty(aValue) then exit;
  if Result[length(Result)]='\' then
    Result:=copy(Result,1,length(Result)-1);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiScanToNumber(const aValue: String) : Integer;
begin
  Result := LMDWideScanToNumber(aValue);
end;
{$ENDIF}
function LMDAnsiScanToNumber(const aValue: AnsiString) : Integer;
begin
  Result := 1;
  while (Result <= Length(aValue))
    and not (Ord(aValue[Result]) in [Ord('0')..Ord('9')]) do
    begin
      if (AnsiChar(aValue[Result]) in LeadBytes) then  //for non western locales
        inc (Result);
      inc (Result);
    end;
  if Result > Length(aValue) then
    Result := 0;
end;

{Simple encryption routines}
{******************************************************************************}
const
  LMDCR1=52845;
  LMDCR2=22719;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiEncode(const aValue: String; Key: DWord): String;
begin
  // TODO Alex: write unciode version of this function
  Result := String(LMDAnsiEncode(AnsiString(aValue), Key));
end;
{$ENDIF}
function LMDAnsiEncode(const aValue: AnsiString; Key: DWord): AnsiString;
var
  i: Integer;
begin
  SetLength(Result, Length(aValue));
  for i:=1 to Length(aValue) do
    begin
      Result[i] := AnsiChar(Byte(aValue[i]) xor (Key shr 8));
      key := (Byte(Result[i])+Key)*LMDCR1+LMDCR2;
    end;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiDecode(const aValue: String; Key: DWord): String;
begin
  Result := String(LMDAnsiDecode(AnsiString(aValue), Key));
end;
{$ENDIF}
function LMDAnsiDecode(const aValue: AnsiString; Key: DWord): AnsiString;
var
  i: Integer;
begin
  SetLength(Result, Length(aValue));
  for i:=1 to Length(aValue) do
    begin
      Result[i]:=AnsiChar(Byte(aValue[i]) xor (Key shr 8));
      Key:=(Byte(aValue[i])+Key)*LMDCR1+LMDCR2;
    end;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiEncode64(const aValue: String): String;
begin
  Result := String(LMDAnsiEncode64(AnsiString(aValue)));
end;
{$ENDIF}
function LMDAnsiEncode64(const aValue: AnsiString): AnsiString;
var
  i, j: Integer;
  s: AnsiString;
begin
  Result := AnsiString(IntToStr(length(aValue))) + ':';
  s := aValue + Copy(AnsiString('  '), 1, 2 - (length(aValue) - 1) mod 3);
  for i:=0 to (length(s) - 1) div 3 do
  begin
    j := Ord(s[i * 3 + 1]) shl 16 + Ord(s[i * 3 + 2]) shl 8 + Ord(s[i * 3 + 3]);
    Result := Result + AnsiChar(48 + j shr 18) + AnsiChar(48 + (j shr 12) and 63)
                     + AnsiChar(48 + (j shr 6) and 63) + AnsiChar(48 + j and 63);
  end;
End;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiDecode64(const aValue: String): String;
begin
  Result := String(LMDAnsiDecode64(AnsiString(aValue)));
end;
{$ENDIF}
function LMDAnsiDecode64(const aValue: AnsiString): AnsiString;
var
  i,j: Integer;
  s: AnsiString;
begin
  s := Copy(aValue, LMDAnsiPosEx(AnsiString(':'), aValue, 1) + 1, length(aValue));
  for i:=0 to (length(s)-1) div 4 do
    begin
      j := (Ord(s[i*4+1])-48) shl 18 + (Ord(s[i*4+2])-48) shl 12+
           (Ord(s[i*4+3])-48) shl 6+(Ord(s[i*4+4])-48);
      Result:=Result+AnsiChar(j shr 16)+AnsiChar((j shr 8)and 255)+AnsiChar(j and 255);
    end;
  Result := Copy(Result, 1, StrToInt(String(Copy(aValue, 1, Pos(':', String(aValue)) - 1))));
end;

{Conversion routines}
{******************************************************************************}
{------------------------------------------------------------------------------}
function LMDAnsiStringToRect(const aValue: String): TRect;
var
  aList: TStrings;
begin
  Result := Rect(0,0,0,0);
  aList:=TStringList.Create;
  with Result do
    try
      LMDAnsiParseToStrList(aValue, IDS_DEFAULTDELIMITER , aList);
      if aList.Count<>4 then
        exit
      else
        Result:=Rect(StrToIntDef(aList[0],0), StrToIntDef(aList[1],0),
                     StrToIntDef(aList[2],0), StrToIntDef(aList[3],0));
    finally
      aList.Free;
    end;
end;

{------------------------------------------------------------------------------}
function LMDAnsiStringToPoint(const aValue: String): TPoint;
var
  i,j: Integer;

begin
  Result:=Point(0,0);
  i:=pos(IDS_DEFAULTDELIMITER, aValue);
  j:=Length(aValue);
  if (i>0) and (j>i) then
    begin
      Result.X:=StrToIntDef(LMDAnsiTrim(Copy(aValue, 1, i-1)), 0);
      Result.Y:=StrToIntDef(LMDAnsiTrim(Copy(aValue, i+1, j-i)), 0);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDAnsiStringToFont(const aValue: String; aFont: TFont);
var
  aList: TStrings;

  function TestBool(i: Integer): Boolean;
  begin
    Result:=Boolean(StrToInt(aList[i]));
  end;

begin
  aList:=TStringList.Create;
  with aFont do
    try
      LMDAnsiParseToStrList(aValue, IDS_DEFAULTDELIMITER , aList);
      if aList.Count<>7 then exit;
      Name:=aList[0];
      Size:=StrToIntDef(aList[1], 10);
      Color:=StringToColor(aList[2]);
      Style:=[];
      if TestBool(3) then Style:=Style+[fsBold];
      if TestBool(4) then Style:=Style+[fsItalic];
      if TestBool(5) then Style:=Style+[fsUnderLine];
      if TestBool(6) then Style:=Style+[fsStrikeOut];
    finally
      aList.Free;
    end;
end;

{------------------------------------------------------------------------------}
function LMDAnsiFontToString(aFont: TFont): String;

  function BoolStr(aValue: Boolean): String;
  begin
    Result := IntToStr(Ord(aValue));
  end;

begin
  with aFont do
    Result := LMDAnsiCodeString([Name, IntToStr(Size), ColorToString(Color),
    BoolStr(fsBold in Style),
                                BoolStr(fsItalic in Style),
                                BoolStr(fsUnderLine in Style),
                                BoolStr(fsStrikeOut in Style)],
                                IDS_DEFAULTDELIMITER);
end;

{------------------------------------------------------------------------------}
function LMDAnsiPointToString(const aValue: TPoint): String;
begin
  with aValue do
    Result:=Format('%d'+IDS_DEFAULTDELIMITER+'%d', [x, y]);
end;

{------------------------------------------------------------------------------}
function LMDAnsiRectToString(const aValue: TRect): String;
begin
  with aValue do
    Result := LMDAnsiCodeInt([Left, Top, Right, Bottom], IDS_DEFAULTDELIMITER);
end;

{StringList related routines}
{------------------------------------------------------------------------------}
function LMDAnsiRemoveEmptyLines(list: TStrings): Boolean;
var
  i: Integer;
begin
  Result:=False;
  if not Assigned(list) then exit;
  list.BeginUpdate;
  try
    for i:=list.Count-1 downto 0 do
      if LMDAnsiTrim(list[i])='' then
        list.Delete (i);
  finally
    list.EndUpdate;
    Result:=True;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDAnsiParseToStrList(const w: String; const delimiter: Char; list: TStrings);
var

  source, runner, endstr : PChar;

begin
  if (list=nil) or (w='') then exit;
  list.clear;
  //new seperation -> will not return empty strings, should be faster
  source := Pointer(w);
  runner := source;
  endstr := source + Length(w);
  while runner < endstr do
    begin
      if runner^ = delimiter then
        begin
          list.add(copy(w,source - Pointer(w) + 1, runner - source));
          source := runner;
          inc(source);
        end;
      inc(runner);
      if (runner = endstr) then
        begin
          dec(runner);
          if runner^ <> delimiter then
            list.add(copy(w,source - Pointer(w) + 1,
                          runner - source + 1)); //+1 because of dec(runner)
          inc(runner);
        end;
    end;
  end;

{------------------------------------------------------------------------------}
procedure LMDAnsiGetDivider(dest: TStrings; const aValue: LongInt);
var
  i, w: Integer;
  st: AnsiString;
  tmp: TStringList;
begin
  if dest=nil then exit;
  dest.Clear;

  tmp := TStringList.Create;
  try
    tmp.sorted:=True;
    tmp.duplicates:=dupIgnore;

    For i:=1 to (aValue div 2) do
      if (aValue mod i)=0 then
        begin
          w:=aValue div i;
          st := AnsiString(inttostr(i));
          tmp.add(String(LMDAnsiMakeSpace(6-length(st))+st));
          st := AnsiString(inttostr(w));
          tmp.add(String(LMDAnsiMakeSpace(6-length(st))+st));
          if i>=w then Break;
        end;

    for i:=0 to tmp.count-1 do
      dest.Add(LMDAnsiTrimL(tmp[i]));
  finally
    tmp.Free;
  end;
end;

type
   StrRec = record
     allocSiz: Longint;
     refCnt:   Longint;
     length:   Longint;
   end;

const
   skew = SizeOf(StrRec);

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiPosEx(const substr, s: String; Index: Integer): Integer;
begin
  Result := LMDWidePosEx(substr, s, Index);
end;
{$ENDIF}
function LMDAnsiPosEx(const substr, s: AnsiString; Index: Integer): Integer;
{$ifdef LMDX86}
asm
{     ->EAX     Pointer to substr               }
{       EDX     Pointer to AnsiString               }
{     <-EAX     Position of substr in s or 0    }

        TEST    EAX,EAX
        JE      @@noWork

        TEST    EDX,EDX
        JE      @@stringEmpty

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI

        MOV     ESI,substr                      { Point ESI to substr           }
        MOV     EDI,s                           { Point EDI to s                }
        MOV     EBX,Index
        DEC     EBX

        MOV     ECX,[EDI-skew].StrRec.length    { ECX = Length(s)               }
        SUB     ECX,EBX

        ADD     EDI,EBX
        PUSH    EBX
        PUSH    EDI                             { remember s position to calculate index        }

        MOV     EDX,[ESI-skew].StrRec.length    { EDX = Length(substr)          }

        DEC     EDX                             { EDX = Length(substr) - 1              }
        JS      @@fail                          { < 0 ? return 0                        }
        MOV     AL,[ESI]                        { AL = first AnsiChar of substr             }
        INC     ESI                             { Point ESI to 2'nd AnsiChar of substr      }

        SUB     ECX,EDX                         { #positions in s to look at    }
                                                { = Length(s) - Length(substr) + 1      }
        JLE     @@fail
@@loop:
        REPNE   SCASB
        JNE     @@fail
        MOV     EBX,ECX                         { save outer loop counter               }
        PUSH    ESI                             { save outer loop substr pointer        }
        PUSH    EDI                             { save outer loop s pointer             }

        MOV     ECX,EDX
        REPE    CMPSB
        POP     EDI                             { restore outer loop s pointer  }
        POP     ESI                             { restore outer loop substr pointer     }
        JE      @@found
        MOV     ECX,EBX                         { restore outer loop counter    }
        JMP     @@loop

@@fail:
        POP     EDX                             { get rid of saved s pointer    }
        POP     EBX
        XOR     EAX,EAX
        JMP     @@exit

@@stringEmpty:
        XOR     EAX,EAX
        JMP     @@noWork

@@found:
        POP     EDX                             { restore pointer to first AnsiChar of s    }
        POP     EBX
        MOV     EAX,EDI                         { EDI points of AnsiChar after match        }
        SUB     EAX,EDX                         { the difference is the correct index   }
        ADD     EAX,EBX
@@exit:
        POP     EDI
        POP     ESI
        POP     EBX
@@noWork:
end;
{$else}
begin
  Result := PosEx(substr, s, Index);
end;
{$endif}

{-----------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiReplaceStr(const S, Srch, Replace: String): String;
begin
  Result := LMDWideReplaceStr(S, Srch, Replace);
end;
{$ENDIF}
function LMDAnsiReplaceStr(const S, Srch, Replace: AnsiString): AnsiString;
var
  I,iPos,iInc: Integer;
  Source: AnsiString;
begin
  Result:= '';
  if S='' then exit;
  Source:= UpperCase(S);
  iPos  := 1;
  iInc  := Length(Srch);
  repeat
    I:= LMDAnsiPosEx(UpperCase(Srch), Source,iPos);
    if I > 0 then
      begin
        Result:= Result + Copy(S, iPos, I-iPos) + Replace;
      end
    else
      Result:= Result + Copy(S, iPos, Length(S)-iPos+1);
    iPos := I+iInc;
  until I <= 0;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiStringToStream(const Str: String; Stream: TStream): Integer;
begin
  Result := LMDWideStringToStream(Str, Stream);
end;
{$ENDIF}
function LMDAnsiStringToStream(const Str: AnsiString; Stream: TStream): Integer;
begin
  Result := Stream.Write(PAnsiChar(Str)^, Length(Str));
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiStreamToString(Stream: TStream; Size: Int64): String;
begin
  Result := LMDWideStreamToString(Stream, Size);
end;
{$ENDIF}
function LMDAnsiStreamToString(Stream: TStream; Size: Integer): AnsiString;

begin
  SetLength(Result, Size);
  Stream.Read(PAnsiChar(Result)^, Size);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiWriteStringToStream(S: TStream; const Str: String): Boolean;
begin
  Result := LMDWideWriteStringToStream(S, Str);
end;
{$ENDIF}
function LMDAnsiWriteStringToStream(S: TStream; const Str: AnsiString): Boolean;
var
  i: Integer;
  begin
  i := Length(Str);
  try
    S.WriteBuffer(i, SizeOf(Integer));

    if i > 0 then
    S.WriteBuffer(Str[1], i);
    Result := True;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}
function LMDAnsiReadStringFromStream(S: TStream; var Str: String): Boolean;
var
  LS: WideString;
begin
  Result := LMDWideReadStringFromStream(S, LS);
  Str := LS;
end;
{$endif}

function  LMDAnsiReadStringFromStream(S: TStream; var Str: AnsiString): Boolean;
var
  i: Integer;
  SS: AnsiString;
  begin
  i := Length(Str);
  try
    S.ReadBuffer(i, SizeOf(Integer));
    if i < 0 then
      raise Exception.Create('Invalid AnsiString header read from the stream');
    if i = 0 then
      Str := ''
    else
    begin
      SetLength(SS, i);
      S.ReadBuffer(SS[1], i);
      Str := SS;
      end;
    Result := True;
  except
    Result := False;
  end;
end;

{$IFDEF LMDCOMP12}
function  LMDAnsiH2D(const S: String): Integer; overload;
begin
  Result := LMDAnsiH2D(AnsiString(S));
end;
{$ENDIF}

{------------------------------------------------------------------------------}
function LMDAnsiH2D(const S: AnsiString): Integer;
var
  i:   Integer;
  n:   Boolean;
  c:   AnsiChar;
  tmp: AnsiString;
begin
  Result := 0;
  tmp    := S;

  if Pos('$', String(tmp)) = 1 then
    Delete(tmp, 1, 1);
  tmp := Trim(tmp);
  if Length(tmp) = 0 then
    raise EConvertError.CreateFmt(SLMDInvalidInteger, [S]);
  n := False;
  if tmp[1] = '-' then n := True;
  if (tmp[1] = '-') or (tmp[1] = '+') then
    Delete(tmp, 1, 1);
  if Length(tmp) = 0 then
    raise EConvertError.CreateFmt(SLMDInvalidInteger, [S]);

  for i := 1 to Length(tmp) do
  begin
    c := AnsiChar(tmp[i]);
    if Ord(c) in [Ord('0')..Ord('9')] then
      Result := Result shl 4 + Ord(c) - Ord('0')
    else
    begin
      c := UpCase(c);
      if Ord(c) in [Ord('A')..Ord('F')] then
        Result := Result shl 4 + Ord(c) - Ord('A') + 10
      else
        raise EConvertError.CreateFmt(SLMDInvalidInteger, [S]);
    end;
  end;
  if n then
    Result := -Result;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiH2DDef(const S: String; Def: Integer): Integer;
begin
  Result := LMDWideH2DDef(S, Def);
end;
{$ENDIF}
function LMDAnsiH2DDef(const S: AnsiString; Def: Integer): Integer;
begin
  try
    Result := LMDAnsiH2D(S);
  except
    Result := Def;
  end;
end;

{------------------------------------------------------------------------------}

{$IFDEF LMDCOMP12}function LMDAnsiStrStartsWith(Source: PChar; Seq: PChar): Boolean;
begin
  Result := LMDWideStrStartsWith(Source, Seq);
end;
{$ENDIF}
function LMDAnsiStrStartsWith(Source: PAnsiChar; Seq: PAnsiChar): Boolean;
begin
  if Assigned(Seq) then
  begin
    Result := False;
    if not Assigned(Source) then
      exit;
    while Seq^ <> #0 do
    begin
      if Source^ <> Seq^ then
        exit;
      Inc(Source);
      Inc(Seq);
    end;
  end;
  Result := True;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiContainsAt(const Source: String; Index: Integer; const Seq: String): Boolean;
begin
  Result := LMDWideContainsAt(Source, Index,Seq);
end;
{$ENDIF}
function LMDAnsiContainsAt(const Source: AnsiString; Index: Integer; const Seq: AnsiString): Boolean;
begin
  Result := (Index > 0) and (Index <= Length(Source))
    and LMDAnsiStrStartsWith(PAnsiChar(Source) + Index - 1, PAnsiChar(Seq));
    end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiLastPos(const SubStr, Strn: String): Integer;
begin
  Result := LMDWideLastPos(SubStr, Strn);
end;
{$ENDIF}
function LMDAnsiLastPos(const SubStr, Strn: AnsiString): Integer;
var
    i,
    j,
    ls, // total length of substring
    ld // length of AnsiString
    : Integer;
begin
  Result := 0;
  ls := Length(SubStr);
  ld := Length(Strn);
  if (ls > ld) or (ls = 0) or (ld = 0) then exit;
  for i := ld downto ls do
  begin
    j := ls;
    while j >= 1 do
    begin
      if Strn[i - ls + j] <> SubStr[j] then Break;
      dec(j);
    end;
    if j = 0 then
    begin
      Result := i - ls + 1;
      exit;
    end;
  end;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiExtractStr(var S: String; SPos, SLen: Integer): String;
var
  LS: WideString;
begin
  LS := S;
  Result := LMDWideExtractStr(LS, SPos, SLen);
  S := LS;
end;
{$ENDIF}
function LMDAnsiExtractStr(var S: AnsiString; SPos, SLen: Integer): AnsiString;
begin
  Result := Copy(S, SPos, SLen);
  Delete(S, SPos, SLen);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiUpperCase(const Str: String): String;
begin
  Result := LMDWideUpperCase(Str);
end;
{$ENDIF}
function LMDAnsiUpperCase(const Str: AnsiString): AnsiString;
begin
  Result := AnsiUpperCase(Str);
  end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiLowerCase(const Str: String): String;
begin
  Result := LMDWideLowerCase(Str);
end;
{$ENDIF}
function LMDAnsiLowerCase(const Str: AnsiString): AnsiString;
begin
  Result := AnsiLowerCase(Str);
  end;

{------------------------------------------------------------------------------}
function LMDWideAddCharL(const aValue: WideString; i: Integer;
  c: WideChar): WideString;
begin
  Result:=LMDWideFillString(i-Length(aValue), c)+aValue;
end;

{------------------------------------------------------------------------------}
function LMDWideAddCharR(const aValue: WideString; i: Integer;
  c: WideChar): WideString;
begin
  Result:=aValue+LMDWideFillString(i-Length(aValue), c);
end;

{------------------------------------------------------------------------------}
function LMDWideAddSpaceL(const aValue: WideString; i: Integer): WideString;
begin
  Result:=LMDWideAddCharL(aValue, i, #32);
end;

{------------------------------------------------------------------------------}
function LMDWideAddSpaceR(const aValue: WideString; i: Integer): WideString;
begin
  Result:=LMDWideAddCharR(aValue, i, #32);
end;

{------------------------------------------------------------------------------}
function LMDWideAddZeroL(const aValue: WideString; i: Integer): WideString;
begin
  Result:=LMDWideAddCharL(aValue, i, #48);
end;

{------------------------------------------------------------------------------}
function LMDWideAddZeroR(const aValue: WideString; i: Integer): WideString;
begin
  Result:=LMDWideAddCharR(aValue, i, #48);
end;

{------------------------------------------------------------------------------}
function LMDWideCodeInt(const X: array of LongInt;
  delimiter: WideChar): WideString;
var
  i: Integer;
begin
  Result := IntToStr(X[0]);
  if SizeOf(x) > 1 then
    for i:=1 to High(X) do
      Result := Result + delimiter + IntToStr(X[i]);
end;

{------------------------------------------------------------------------------}
function LMDWideCodeString(const X: array of WideString; delimiter: WideChar): WideString;
var
  i: Integer;
begin
  Result:=X[0];
  if SizeOf(x)>1 then
    for i:=1 to High(X) do Result:=Result+delimiter+X[i];
end;

{------------------------------------------------------------------------------}
function LMDWideGetCodedCount(const aValue: WideString;
  delimiter: WideChar): Integer;
var
  i:   Integer;
  tmp: WideString;
begin
  Result:=0;
  i:=Pos(delimiter, aValue);
  if i=0 then
    begin
      if (Length(aValue)>0) then Result:=1;
      exit;
    end;

  Result:=1;
  tmp:=aValue;
  while i<>0 do
    begin
      tmp[i]:=chr(0);
      i:=Pos(delimiter, tmp);
      inc(Result);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDWideSetCodedString(var aValue : WideString;
  const partStr : WideString; delimiter: WideChar; index: Integer);
var
  i : Integer;

  leftChar,
  rightChar,
  replaceChars,
  delim: Integer;

begin
  // possible values for aValue
  //    aValue : := empty | item | { item delim } | aValue aValue

  // index is a zero based index value

  // s := aValue;  //backup aValue

  delim := 0; //no left delimiter (no delim in aValue at all, index = 0)
  leftChar := 1; //set counter on first AnsiChar of aValue

  //let's lookout for the delimiter, identifiying the str to be replaced
  while (delim < index) and (leftChar <= Length(aValue)) do
    begin
      if aValue[leftChar] = delimiter then
        inc(delim);
      inc(leftChar);
    end;
  //leftChar is set on first AnsiChar to be replaced

  //lets start the search for the right delimiter on the left AnsiChar
  rightChar := leftChar;
  while (delim < index+1) and (rightChar <= Length(aValue)) do
    begin
      if aValue[rightChar] = delimiter then
        inc(delim);
      inc(rightChar);
    end;

  //we need to correct the rightChar here for one special case
  // something delimiter soemthing delimiter i
  // i = rightChar, that's one too high
  if (rightChar <>  leftChar) and (aValue[rightChar-1] = delimiter) then
     dec (rightChar);

  //right AnsiChar should now be on the last AnsiChar of the AnsiString to be replaced

  {

        '' left, right = 1
        'a' left = 2, right = 2
        'aa' left = 3, right = 3
        'a|' left = 3, right = 3
        'a|b' left =  3, right = 4
        'a|b|' left = 3, right = 5
        'aa|'
        '|b'
        '|b|'
        '|bb'
        'aa|bb' left  = 4, right = 6
        '|bb|'
        'aa|bb|'
        '|'
        '||'

  }

  //now we have to check leftChar and rightChar

  //check whether we have to less delimiters
  if index > delim then
    begin
      //add delimiters if needed -> otherwise whis loop will do nothing
      for i := index-1 downTo delim do
        aValue := aValue + delimiter;

      //let's move left and right AnsiChar by the inserted delimiters ...
      inc (leftChar, index-delim);
      inc (rightChar, index-delim);
    end;
  //now we are sure that we have enough delimiters for doing the job

  //let's calc the amount of chars to be replaced
  replaceChars := rightChar - leftChar;

  //remove any chars which we have to replace
  Delete (aValue, leftChar, replaceChars);

  //insert the new AnsiString at the approviate position
  Insert (partStr, aValue, leftChar);
end;

{------------------------------------------------------------------------------}
function LMDWideGetCodedInt(const aValue: WideString; delimiter: WideChar;
  index: Integer): LongInt;
var
  tmp: WideString;
begin
  tmp := LMDWideGetCodedString(aValue, delimiter, index);

  if tmp = '' then
    Result := -1
  else
    Result := StrToInt(tmp);
end;

{------------------------------------------------------------------------------}
function LMDWideGetCodedString(const aValue: WideString; delimiter: WideChar;
  index: Integer): WideString;
var
  i, last, counter: Integer;
  tmp: WideString;
begin
  Result:='';
  i:=Pos(delimiter, aValue);
  if index=0 then
    begin
      //get whole AnsiString if only onew is set or get first columns AnsiString
      if (i=0) then Result:=aValue else Result:=copy(aValue, 1,i-1);
      exit;
    end;
  //we want to access an index > 0 but there's no delimiter =>
  //column's AnsiString not available
  if i=0 then exit;

  Counter:=0;
  tmp:=aValue;
  while i<>0 do
    begin
      tmp[i]:=#0;
      last:=i+1;
      i:=Pos(delimiter, tmp);
      inc(Counter);
      if Counter=Index then
        begin
          if i=0 then i:=Length(aValue)+1;
          Result:=Copy(aValue, last, i-last);
          exit;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function LMDWideCount(const aValue: WideString;
  const search: WideChar): Integer;
var
  Start, TextEnd : PWideChar;
  begin
  Result:=0;
  if Length(aValue)<>0 then
    begin
      Start := Pointer(aValue);
      TextEnd := Start + Length (aValue);
      //start < TextEnd; Result = 0
      while Start < TextEnd do
        begin
          //start < TextEnd
          if Start^=search then inc(Result);
          inc(Start);
          //start = start + 1; start <= TextEnd
        end;
      //start = TextEnd; Result = #search
    end;
  end;

{------------------------------------------------------------------------------}
function LMDWideBackPos(c: WideChar; const s: WideString): Integer;
var
  l, i: integer;
begin
  Result := 0;
  l := Length(s);
  if l > 0 then
    for i := Length(s) downto 1 do
      if s[i] = c then
        begin
          Result := i;
          break;
        end;
end;

{------------------------------------------------------------------------------}
function LMDWideEmpty(const aValue: WideString): Boolean;

var
  Start, TextEnd : PWideChar;

begin
  Result := True;
  if Length(aValue)=0 then
    exit;

  Start := Pointer(aValue);
  TextEnd := Start + Length(aValue);
  while Start < TextEnd do
    if Start^ = ' ' then inc(Start) else
      begin
        Result:= False;
        exit;
      end;
  end;

{------------------------------------------------------------------------------}
function LMDWideFillString(i: Integer; w: WideChar): WideString;
begin
  if i > 0 then
  begin
    SetLength(Result, i);
    LMDFillWideChar(Result[1], Length(Result), w);
  end
  else
    Result := '';
end;

{------------------------------------------------------------------------------}
function LMDWideCenterString(const S: WideString; Len: Integer): WideString;
begin
  if length(S) < Len then
    begin
      Result:= LMDWideFillString((Len div 2) - (length(S) div 2), ' ') + S;
      Result:= Result + LMDWideFillString(Len - length(Result), ' ');
    end
  else
    Result:= S;
end;

{------------------------------------------------------------------------------}
function LMDWideMakeSpace(i: Integer): WideString;
begin
  Result:=LMDWideFillString(i, #32);
end;

{------------------------------------------------------------------------------}
function LMDWideSlashRemove(const aValue: WideString): WideString;
begin
  Result:=aValue;
  if LMDWideEmpty(aValue) then
    exit;
  if Result[length(Result)]='\' then
    Result:=copy(Result,1,length(Result)-1);
end;

{------------------------------------------------------------------------------}
function LMDWideSlashAdd(const aValue: WideString): WideString;
begin
  Result:=aValue;
  if LMDWideEmpty(Result) or (Result[length(Result)]<>'\') then
    Result:=Result+'\';
end;

{------------------------------------------------------------------------------}
function LMDWideReplaceChar(const aValue: WideString; toReplace,
  Replace: WideChar): WideString;
var
  i: Integer;
begin
  Result:=aValue;
  for i:=1 to Length(Result) do
    if Result[i]=toReplace then Result[i]:=Replace;
end;

{------------------------------------------------------------------------------}
function LMDWideTrimL(const aValue: WideString): WideString;
var
  I, L: Integer;
begin
  L := Length(aValue);
  I := 1;
  while (I <= L) and (aValue[I] <= ' ') do
    Inc(I);
  Result := Copy(aValue, I, Maxint);
end;

{------------------------------------------------------------------------------}
function LMDWideTrimR(const aValue: WideString): WideString;
var
  I: Integer;
begin
  I := Length(aValue);
  while (I > 0) and (aValue[I] <= ' ') do
    Dec(I);
  Result := Copy(aValue, 1, I);
end;

{------------------------------------------------------------------------------}
function LMDWideTrim(const aValue: WideString): WideString;
var
  I, L: Integer;
begin
  L := Length(aValue);
  I := 1;
  while (I <= L) and (aValue[I] <= ' ') do
    Inc(I);
  if I > L then
    Result := ''
  else begin
    while aValue[L] <= ' ' do
      Dec(L);
    Result := Copy(aValue, I, L - I + 1);
  end;
end;

{------------------------------------------------------------------------------}
function LMDWideGetFirstString(const aValue: WideString;
  delimiter: WideChar): WideString;
var
  p: Integer;
begin
  p:=Pos(Delimiter, aValue);
  if p=0 then
    Result:=aValue
  else
    Result:=Copy(aValue, 1, Pred(p));
end;

{------------------------------------------------------------------------------}
function LMDWideGetLastString(const aValue: WideString;
  delimiter: WideChar): WideString;
var
  p: Integer;
begin
  p:=LMDWideBackPos(Delimiter, aValue);
  if p=0 then
    Result:=aValue
  else
    Result:=Copy(aValue, Succ(p), Length(aValue));
end;

{------------------------------------------------------------------------------}
function LMDWideGetSecondString(const aValue: WideString;
  delimiter: WideChar): WideString;
var
  p: Integer;
begin
  p:=Pos(Delimiter, aValue);
  if p=0 then
    Result:=aValue
  else
    Result:=Copy(aValue, Succ(p), length(aValue));
end;

{------------------------------------------------------------------------------}
function LMDWideGetRightTrimmedString(const aValue: WideString;
  delimiter: WideChar): WideString;
var
  p: Integer;
begin
  p:=LMDWideBackPos(Delimiter, aValue);
  if p=0 then
    Result:=aValue
  else
    Result:=Copy(aValue, 1, Pred(p));
end;

{------------------------------------------------------------------------------}
function LMDWideAddDelimiter(s: WideString; delimiter: WideChar): WideString;
begin
  if s <> '' then
    Result := s + delimiter
  else
    Result := s;
end;

{------------------------------------------------------------------------------}
function LMDWideScanToNumber(const aValue: WideString) : Integer;
begin
  Result := 1;
  while (Result <= Length(aValue))
    and not (Ord(aValue[Result]) in [Ord('0')..Ord('9')]) do
    begin
      if (Ord(aValue[Result]) <= 256) and
         (AnsiChar(aValue[Result]) in LeadBytes) then  //for non western locales
        inc (Result);
      inc (Result);
    end;
  if Result > Length(aValue) then
    Result := 0;
end;

{------------------------------------------------------------------------------}
function LMDWideRemoveEmptyLines(list: TLMDWideStrings): Boolean;
var
  i: Integer;
begin
  Result:=False;
  if not Assigned(list) then exit;
  list.BeginUpdate;
  try
    for i:=list.Count-1 downto 0 do
      if LMDWideTrim(list[i])='' then
        list.Delete (i);
  finally
    list.EndUpdate;
    Result:=True;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDWideParseToStrList(const w: WideString;
  const delimiter: WideChar; list: TLMDWideStrings);
var

  source, runner, endstr : PWideChar;

begin
  if (list=nil) or (w='') then exit;
  list.clear;
  //new seperation -> will not return empty strings, should be faster
  source := Pointer(w);
  runner := source;
  endstr := source + Length(w);

  while runner < endstr do
    begin
      if runner^ = delimiter then
        begin
          list.add(Copy(w,source - Pointer(w) + 1, runner - source));
          source := runner;
          inc(source);
        end;
      inc(runner);
      if (runner = endstr) then
        begin
          dec(runner);
          if runner^ <> delimiter then
            list.add(Copy(w,source - Pointer(w) + 1,
                          runner - source + 1)); //+1 because of dec(runner)
          inc(runner);
        end;
    end;
  end;

{------------------------------------------------------------------------------}
procedure LMDWideGetDivider(dest: TLMDWideStrings; const aValue: LongInt);
var
  i, w: Integer;
  st: WideString;
  tmp: TLMDWideStringList;
begin
  if dest=nil then exit;
  dest.Clear;

  tmp := TLMDWideStringList.Create;
  try
    tmp.sorted:=True;
    tmp.duplicates:=dupIgnore;

    For i:=1 to (aValue div 2) do
      if (aValue mod i)=0 then
        begin
          w:=aValue div i;
          st:=inttostr(i);
          tmp.add(LMDWideMakeSpace(6-length(st))+st);
          st:=inttostr(w);
          tmp.add(LMDWideMakeSpace(6-length(st))+st);
          if i>=w then Break;
        end;

    for i:=0 to tmp.count-1 do
      dest.Add(LMDWideTrimL(tmp[i]));
  finally
    tmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWidePosEx(const substr, s: WideString; Index: Integer): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Index = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Index;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWideReplaceStr(const S, Srch, Replace: WideString): WideString;
var
  I,iPos,iInc: Integer;
  Source: WideString;
begin
  Result:= '';
  if S='' then exit;

  Source:= LMDWideUpperCase(S);
  iPos  := 1;
  iInc  := Length(Srch);
  repeat
    I:= LMDWidePosEx(LMDWideUpperCase(Srch), Source, iPos);
    if I > 0 then
    begin
      Result:= Result + Copy(S, iPos, I-iPos) + Replace;
    end
    else
      Result:= Result + Copy(S, iPos, Length(S)-iPos+1);
    iPos := I+iInc;
  until I <= 0;
end;

{------------------------------------------------------------------------------}
function LMDWideWriteStringToStream(S: TStream; const Str: WideString): Boolean;
var
  i: Integer;
begin
  try
    i := Length(Str);
    S.WriteBuffer(i, SizeOf(Integer));
    if i > 0 then
      S.WriteBuffer(Str[1], i * SizeOf(WideChar));

    Result := True;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWideReadStringFromStream(S: TStream; var Str: WideString): Boolean;
var
  i: Integer;
  SS: WideString;
begin
  i := Length(Str);
  try
    S.ReadBuffer(i, SizeOf(Integer));
    if i < 0 then
      raise Exception.Create('Invalid AnsiString header read from the stream');
    if i = 0 then
      Str := ''
    else
    begin
      SetLength(SS, i);
      S.ReadBuffer(SS[1], i * SizeOf(WideChar));
      Str := SS;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWideH2D(const S: WideString): Integer;
begin
  Result := LMDAnsiH2D(S);
end;

{------------------------------------------------------------------------------}
function LMDWideH2DDef(const S: WideString; Def: Integer): Integer;
begin
  try
    Result := LMDWideH2D(S);
  except
    Result := Def;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWideStrStartsWith(Source, Seq: PWideChar
                              ): Boolean;
begin
  if Assigned(Seq) then
  begin
    Result := False;
    if not Assigned(Source) then
      exit;
    while Seq^ <> #0 do
    begin
      if Source^ <> Seq^ then
        exit;
      Inc(Source);
      Inc(Seq);
    end;
  end;
  Result := True;
  end;

{------------------------------------------------------------------------------}
function LMDWideContainsAt(const Source: WideString; Index: Integer;
  const Seq: WideString): Boolean;
begin
  Result := (Index > 0) and (Index <= Length(Source))
    and LMDWideStrStartsWith(PWideChar(Source) + Index - 1, PWideChar(Seq));
  end;

{------------------------------------------------------------------------------}
function LMDWideLastPos(const SubStr, Strn: WideString): Integer;

var
    i,
    j,
    ls, // total length of substring
    ld // length of AnsiString
    : Integer;
begin
  Result := 0;
  ls := Length(SubStr);
  ld := Length(Strn);
  if (ls > ld) or (ls = 0) or (ld = 0) then exit;
  for i := ld downto ls do
  begin
    j := ls;
    while j >= 1 do
    begin
      if Strn[i - ls + j] <> SubStr[j] then Break;
      dec(j);
    end;
    if j = 0 then
    begin
      Result := i - ls + 1;
      exit;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function LMDWideExtractStr(var S: WideString; SPos, SLen: Integer): WideString;
begin
  Result := Copy(S, SPos, SLen);
  Delete(S, SPos, SLen);
end;

{------------------------------------------------------------------------------}
function LMDWideUpperCase(const Str: WideString): WideString;
begin
  Result := LMDUnicodeUpper(Str);
  end;

{------------------------------------------------------------------------------}
function LMDWideLowerCase(const Str: WideString): WideString;
begin
  Result := LMDUnicodeLower(Str);
  end;

{------------------------------------------------------------------------------}
function LMDWideStringToStream(const Str: WideString; Stream: TStream): Integer;

begin
  Result := Stream.Write(PWideChar(Str)^, Length(Str) * SizeOf(WideChar));
end;

{------------------------------------------------------------------------------}
function LMDWideStreamToString(Stream: TStream; Size: Integer): WideString;

begin
  SetLength(Result, Size);
  Stream.Read(PWideChar(Result)^, Size * SizeOf(WideChar));
  end;

{------------------------------------------------------------------------------}
function LMDAddCharL(const aValue: TLMDString; i: Integer; c: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideAddCharL(AValue, i, c);
  {$ELSE}
  Result := LMDAnsiAddCharL(AValue, i, c);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDAddCharR(const aValue: TLMDString; i: Integer;
  c: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideAddCharR(aValue, i, c);
  {$ELSE}
  Result := LMDAnsiAddCharR(aValue, i, c);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDAddSpaceL(const aValue: TLMDString; i: Integer): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideAddSpaceL(aValue, i);
  {$ELSE}
  Result := LMDAnsiAddSpaceL(aValue, i);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDAddSpaceR(const aValue: TLMDString; i: Integer): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideAddSpaceR(aValue, i);
  {$ELSE}
  Result := LMDAnsiAddSpaceR(aValue, i);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDAddZeroL(const aValue: TLMDString; i: Integer): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideAddZeroL(aValue, i);
  {$ELSE}
  Result := LMDAnsiAddZeroL(aValue, i);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDAddZeroR(const aValue: TLMDString; i: Integer): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideAddZeroR(aValue, i);
  {$ELSE}
  Result := LMDAnsiAddZeroR(aValue, i);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDCodeInt(const X: array of LongInt; delimiter: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideCodeInt(X, delimiter);
  {$ELSE}
  Result := LMDAnsiCodeInt(X, delimiter);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDCodeString(const X: array of TLMDString; delimiter: TLMDChar): TLMDString;
var
{$ifdef LMD_UNICODE}
  LHelper: array of WideString;
{$else}
  LHelper: array of AnsiString;
{$endif}
  i: integer;
begin
  SetLength(LHelper, Length(X));
  for i := Low(X) to High(X) do
    LHelper[i] := X[i];
  {$IFDEF LMD_UNICODE}
  Result := LMDWideCodeString(LHelper, delimiter);
  {$ELSE}
  Result := LMDAnsiCodeString(LHelper, delimiter);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDGetCodedCount(const aValue: TLMDString;
  delimiter: TLMDChar): Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideGetCodedCount(aValue, delimiter);
  {$ELSE}
  Result := LMDAnsiGetCodedCount(aValue, delimiter);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure LMDSetCodedString(var aValue : TLMDString; const partStr: TLMDString;
  delimiter: TLMDChar; index: Integer);
var
{$ifdef LMD_UNICODE}
  LHelper: WideString;
{$else}
  LHelper: AnsiString;
{$endif}
begin
  LHelper := aValue;
  {$IFDEF LMD_UNICODE}
  LMDWideSetCodedString(LHelper, partStr, delimiter, index);
  {$ELSE}
  LMDAnsiSetCodedString(LHelper, partStr, delimiter, index);
  {$ENDIF}
  aValue := LHelper;
end;

{------------------------------------------------------------------------------}
function LMDGetCodedInt(const aValue: TLMDString; delimiter: TLMDChar;
  index: Integer): LongInt;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideGetCodedInt(aValue, delimiter, index);
  {$ELSE}
  Result := LMDAnsiGetCodedInt(aValue, delimiter, index);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDGetCodedString(const aValue: TLMDString; delimiter: TLMDChar;
  index: Integer): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideGetCodedString(aValue, delimiter, index);
  {$ELSE}
  Result := LMDAnsiGetCodedString(aValue, delimiter, index);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDCount(const aValue: TLMDString; const search: TLMDChar): Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideCount(aValue, search);
  {$ELSE}
  Result := LMDAnsiCount(aValue, search);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDBackPos(c: TLMDChar; const s: TLMDString) : Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideBackPos(c, s);
  {$ELSE}
  Result := LMDAnsiBackPos(c, s);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDEmpty(const aValue: TLMDString): Boolean;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideEmpty(aValue);
  {$ELSE}
  Result := LMDAnsiEmpty(aValue);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDFillString(i: Integer; w: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideFillString(i, w);
  {$ELSE}
  Result := LMDAnsiFillString(i, w);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDCenterString(const S: TLMDString; Len: Integer): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideCenterString(S, Len);
  {$ELSE}
  Result := LMDAnsiCenterString(S, Len);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDMakeSpace(i: Integer): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideMakeSpace(i);
  {$ELSE}
  Result := LMDAnsiMakeSpace(i);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDSlashRemove(const aValue: TLMDString): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideSlashRemove(aValue);
  {$ELSE}
  Result := LMDAnsiSlashRemove(aValue);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDSlashAdd(const aValue: TLMDString): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideSlashAdd(aValue);
  {$ELSE}
  Result := LMDAnsiSlashAdd(aValue);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDReplaceChar(const aValue: TLMDString; toReplace,
  Replace: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideReplaceChar(aValue, toReplace, Replace);
  {$ELSE}
  Result := LMDAnsiReplaceChar(aValue, toReplace, Replace);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDTrimL(const aValue: TLMDString): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideTrimL(aValue);
  {$ELSE}
  Result := LMDAnsiTrimL(aValue);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDTrimR(const aValue: TLMDString): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideTrimR(aValue);
  {$ELSE}
  Result := LMDAnsiTrimR(aValue);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDTrim(const aValue: TLMDString): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideTrim(aValue);
  {$ELSE}
  Result := LMDAnsiTrim(aValue);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDGetFirstString(const aValue: TLMDString;
  delimiter: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideGetFirstString(aValue, delimiter);
  {$ELSE}
  Result := LMDAnsiGetFirstString(aValue, delimiter);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDGetLastString(const aValue: TLMDString;
  delimiter: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideGetLastString(aValue, delimiter);
  {$ELSE}
  Result := LMDAnsiGetLastString(aValue, delimiter);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDGetSecondString(const aValue: TLMDString;
  delimiter: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideGetSecondString(aValue, delimiter);
  {$ELSE}
  Result := LMDAnsiGetSecondString(aValue, delimiter);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDGetRightTrimmedString(const aValue: TLMDString;
  delimiter: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideGetRightTrimmedString(aValue, delimiter);
  {$ELSE}
  Result := LMDAnsiGetRightTrimmedString(aValue, delimiter);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDAddDelimiter(s: TLMDString; delimiter: TLMDChar): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideAddDelimiter(s, delimiter);
  {$ELSE}
  Result := LMDAnsiAddDelimiter(s, delimiter);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDScanToNumber(const aValue: TLMDString) : Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideScanToNumber(aValue);
  {$ELSE}
  Result := LMDAnsiScanToNumber(aValue);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

procedure LMDSetString(var aValue: TLMDString; buff: PLMDChar; len: Integer);
var
{$ifdef LMD_UNICODE}
  LHelper: WideString;
{$else}
  LHelper: AnsiString;
{$endif}
begin
  LHelper := aValue;
  {$IFDEF LMD_UNICODE}
  LMDWideSetString(LHelper, buff, len);
  {$ELSE}
  SetString(LHelper, buff, len);
  {$ENDIF}
  aValue := LHelper;
end;

function  LMDStrLen(AStr: PLMDChar): Integer;
begin
  {$IFDEF LMD_UNICODE}
  result := LMDWideStrLen(AStr);
  {$ELSE}
  result := StrLen(AStr);
  {$ENDIF}
end;

function LMDCheckWildCardMask(aMask, aStr: TLMDString): boolean;
var
  i, l : integer;
  asterisk_begin, asterisk_end: boolean;
  lSearch, s: TLMDString;
begin
  l := length(aMask);
  result := true;
  if l = 0 then
    exit;
  asterisk_begin := aMask[1] = '*';
  asterisk_end := aMask[l] = '*';
  lSearch := LMDUpperCase(aMask);
  if asterisk_begin or asterisk_end then
    repeat
      i := Pos('*', lSearch);
      if i > 0 then
        Delete(lSearch, i, 1);
    until i = 0;
  l := Length(lSearch);
  if l = 0 then
    exit;
  s := LMDUpperCase(aStr);
  if asterisk_begin and asterisk_end then
    result := Pos(lSearch, s) > 0
  else
    if asterisk_end and not asterisk_begin then
      result := Copy(s, 1, l) = lSearch
    else
      if asterisk_begin then
        result := Copy(s, length(s) - l + 1, l) = lSearch
      else
        result := (s = lSearch);
end;

function LMDCharArrayToString(const Arr: TLMDCharArray; AStart, ACount: Integer): TLMDString;
begin
  if ACount<>0 then
  begin
    LMDSetString(Result, @Arr[AStart], ACount)
  end
  else
    Result := '';
end;

{------------------------------------------------------------------------------}
function LMDRemoveEmptyLines(list: TLMDStrings): Boolean;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideRemoveEmptyLines(list);
  {$ELSE}
  Result := LMDAnsiRemoveEmptyLines(list);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure LMDParseToStrList(const w: TLMDString; const delimiter: TLMDChar;
  list: TLMDStrings);
begin
  {$IFDEF LMD_UNICODE}
  LMDWideParseToStrList(w, delimiter, list);
  {$ELSE}
  LMDAnsiParseToStrList(w, delimiter, list);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure LMDGetDivider(dest: TLMDStrings; const aValue: LongInt);
begin
  {$IFDEF LMD_UNICODE}
  LMDWideGetDivider(dest, aValue);
  {$ELSE}
  LMDAnsiGetDivider(dest, aValue);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDPosEx(const substr, s: TLMDString; Index: Integer): Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWidePosEx(substr, s, Index);
  {$ELSE}
  Result := LMDAnsiPosEx(substr, s, Index);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDReplaceStr(const S, Srch, Replace: TLMDString): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideReplaceStr(S, Srch, Replace);
  {$ELSE}
  Result := LMDAnsiReplaceStr(S, Srch, Replace);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDWriteStringToStream(S: TStream; const Str: TLMDString): Boolean;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideWriteStringToStream(S, Str);
  {$ELSE}
  Result := LMDAnsiWriteStringToStream(S, Str);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDReadStringFromStream(S: TStream; var Str: TLMDString): Boolean;
var
{$ifdef LMD_UNICODE}
  LHelper: WideString;
{$else}
  LHelper: AnsiString;
{$endif}
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideReadStringFromStream(S, LHelper);
  {$ELSE}
  Result := LMDAnsiReadStringFromStream(S, LHelper);
  {$ENDIF}
  Str := LHelper;
end;

{------------------------------------------------------------------------------}
function LMDH2D(const S: TLMDString): Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideH2D(S);
  {$ELSE}
  Result := LMDAnsiH2D(S);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDH2DDef(const S: TLMDString; Def: Integer): Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideH2DDef(S, Def);
  {$ELSE}
  Result := LMDAnsiH2DDef(S, Def);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

function LMDStrStartsWith(Source, Seq: PLMDChar): Boolean;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideStrStartsWith(Source, Seq);
  {$ELSE}
  Result := LMDAnsiStrStartsWith(Source, Seq);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
function LMDContainsAt(const Source: TLMDString; Index: Integer;
  const Seq: TLMDString): Boolean;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideContainsAt(Source, Index, Seq);
  {$ELSE}
  Result := LMDAnsiContainsAt(Source, Index, Seq);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDLastPos(const SubStr, Strn: TLMDString): Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideLastPos(SubStr, Strn);
  {$ELSE}
  Result := LMDAnsiLastPos(SubStr, Strn);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDExtractStr(var S: TLMDString; SPos, SLen: Integer): TLMDString;
var
{$ifdef LMD_UNICODE}
  LHelper: WideString;
{$else}
  LHelper: AnsiString;
{$endif}
begin
  LHelper := S;
  {$IFDEF LMD_UNICODE}
  Result := LMDWideExtractStr(LHelper, SPos, SLen);
  {$ELSE}
  Result := LMDAnsiExtractStr(LHelper, SPos, SLen);
  {$ENDIF}
  S := LHelper;
end;

{------------------------------------------------------------------------------}
function LMDUpperCase(const Str: TLMDString): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideUpperCase(Str);
  {$ELSE}
  Result := LMDAnsiUpperCase(Str);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDLowerCase(const Str: TLMDString): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideLowerCase(Str);
  {$ELSE}
  Result := LMDAnsiLowerCase(Str);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function  LMDAnsiUpperCaseChar(C: Char): Char;
begin
  Result := LMDWideUpperCaseChar(C);
end;
{$ENDIF}
function  LMDAnsiUpperCaseChar(C: AnsiChar): AnsiChar;
begin
  Result := C;
  CharUpperBuff(@Result, 1);
end;

{$IFDEF LMDCOMP12}function  LMDAnsiLowerCaseChar(C: Char): Char;
begin
  Result := LMDWideLowerCaseChar(C);
end;
{$ENDIF}
function  LMDAnsiLowerCaseChar(C: AnsiChar): AnsiChar;
begin
  Result := C;
  CharLowerBuff(@Result, 1);
end;

function  LMDWideUpperCaseChar(C: WideChar): WideChar;
begin
  Result := LMDUnicodeUpperChar(C);
end;

function LMDWideLowerCaseChar(C: WideChar): WideChar;
begin
  Result := LMDUnicodeLowerChar(C);
end;

function  LMDUpperCaseChar(C: TLMDChar): TLMDChar;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideUpperCaseChar(C);
  {$ELSE}
  Result := LMDAnsiUpperCaseChar(C);
  {$ENDIF}
end;

function  LMDLowerCaseChar(C: TLMDChar): TLMDChar;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideLowerCaseChar(C);
  {$ELSE}
  Result := LMDAnsiLowerCaseChar(C);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDStringToStream(const Str: TLMDString; Stream: TStream): Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideStringToStream(Str, Stream);
  {$ELSE}
  Result := LMDAnsiStringToStream(Str, Stream);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDStreamToString(Stream: TStream; Size: Integer): TLMDString;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideStreamToString(Stream, Size);
  {$ELSE}
  Result := LMDAnsiStreamToString(Stream, Size);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
function LMDSameText(const S1, S2: TLMDString): Boolean;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideSameText(S1, S2);
  {$ELSE}
  Result := SameText(S1, S2);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP12}function LMDAnsiSameText(const Str1, Str2: String): Boolean;
begin
  Result := LMDWideSameText(Str1, Str2);
end;
{$ENDIF}
function LMDAnsiSameText(const Str1, Str2: AnsiString): Boolean;
begin

  Result := AnsiSameText(Str1, Str2);

end;

function LMDCompareStr(const S1, S2: TLMDString): Integer;
begin
  {$IFDEF LMD_UNICODE}
  Result := LMDWideCompareStr(S1, S2);
  {$ELSE}
  Result := LMDAnsiCompareStr(S1, S2);
  {$ENDIF}
end;

{$IFDEF LMDCOMP12}function LMDAnsiCompareStr(const S1, S2: String): Integer;
begin
  Result := LMDWideCompareStr(S1, S2);
end;
{$ENDIF}
function LMDAnsiCompareStr(const S1, S2: AnsiString): Integer;
begin
  Result := AnsiCompareStr(S1, S2);
end;

function LMDWideCompareStr(const S1, S2: WideString): Integer;
begin
  Result := LMDUnicode.LMDWideCompareStr(S1, S2);
end;

{$IFDEF LMDCOMP12}function LMDAnsiMakeString(FLen: Integer; Seq : String): String;
begin
  Result := LMDWideMakeString(FLen, Seq);
end;
{$ENDIF}
function LMDAnsiMakeString(FLen: Integer; Seq : AnsiString): AnsiString;
 begin
  if Length(Seq) = 1 then
    Result := StringOfChar(Seq[1], FLen)
  else
  begin
    SetLength(Result, FLen * Length(Seq));
    for FLen := FLen-1 DownTo 0 do
      Move(Seq[1], Result[Length(Seq) * FLen + 1], Length(Seq));
      end;
end;

{$ifdef LMDCOMP12}
function LMDAnsiCharInSet(const AChar: Char; ASet: TSysCharSet): Boolean;
begin
  Result := (Ord(AChar) < 256) and (AnsiChar(AChar) in ASet);
end;
{$else}
 {$endif}

function LMDAnsiCharInSet(const AChar: AnsiChar; ASet: TSysCharSet): Boolean;
begin
  Result := AChar in ASet;
end;

function LMDWideCharInSet(const AChar: WideChar; ASet: TSysCharSet): Boolean;
begin
  Result := (Ord(AChar) < 256) and (AnsiChar(AChar) in ASet);
end;

function LMDCharInSet(const AChar: TLMDChar; ASet: TSysCharSet): Boolean;
begin
  {$ifdef LMD_UNICODE}
  Result := (Ord(AChar) < 256) and (AnsiChar(AChar) in ASet);
  {$else}
  Result := AChar in ASet;
  {$endif}
end;

function LMDPrettyStrToCurr(const Value: String): Currency;
const
  OneStepMultiplicator = 0.1;
var
  I: Cardinal;
  CurrNegFormatted: Boolean;
  Digit: Currency;
  FractPartMultiplicator: Currency;
  Ch: Char;
  CurrSymbolPosition: Cardinal;
  Len: Cardinal;
  DigitsFound: Boolean;
begin
  Result := 0.0;
  if Value <> '' then
  begin
    CurrNegFormatted := False;
    DigitsFound := False;
    FractPartMultiplicator := 0.0;
    if {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyString  <> '' then
    begin
      CurrSymbolPosition := Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyString, Value);
    end
    else
    begin
      CurrSymbolPosition := 0;
    end;
    I := 1;
    Len := Length(Value);
    while I <= Len do
    begin
      if I = CurrSymbolPosition then
      begin
        // skip currency symbol(s)
        if DigitsFound and CurrNegFormatted then Break;
        Inc(I, Length({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyString));
        Continue;
      end;
      Ch := Value[I];
      case Ch of
        '0'..'9':
          begin
          // next digit found
            DigitsFound := True;
            Digit := Cardinal(Ord(Ch) - Ord('0'));
            if FractPartMultiplicator > 0.0 then
            begin
              Digit := Digit * FractPartMultiplicator;
              FractPartMultiplicator := FractPartMultiplicator *
                OneStepMultiplicator;
              Result := Result + Digit;
            end
            else
            begin
              Result := (Result * 10) + Digit;
            end;
          end;
        '-', '(':
          begin
            CurrNegFormatted := True;
            if DigitsFound then Break;
          end;
//        '.', ',':
//          begin
//            DigitsFound := True;
//            if FractPartMultiplicator > 0.0 then
//            begin
//              Break;
//            end;
//            FractPartMultiplicator := OneStepMultiplicator;
//          end;
      else
        begin
          if Ch <> {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator then
          begin
            if Ch = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator then
            begin
              DigitsFound := True;
              if FractPartMultiplicator > 0.0 then
              begin
                Break;
              end;
              FractPartMultiplicator := OneStepMultiplicator;
            end
            else
            begin
              if Ch > #32 then
              begin
                Break;
              end;
            end;
          end;
        end;
      end;//of: case Ch
      Inc(I);
    end;//of: while I <= Len
    if CurrNegFormatted then
    begin
      Result := -Result;
    end;
  end;//of: if Value <> ''
end;

function LMDAnsiReplace(var Str: String; SourceString, DestString: String): boolean;
var
  i: integer;
begin
  i := pos(SourceString, Str);
  if i = 0 then
  begin
    Result := false;
    exit;
  end;
  Delete(Str, i, Length(SourceString));
  if Length(DestString)>0 then
    Insert(DestString, Str, i);
  Result := true;
end;

function LMDWideReplace(var Str: WideString; const SourceString, DestString:
    WideString): Boolean;
var
  i: integer;
begin
  i := LMDWidePos(SourceString, Str);
  if i = 0 then
  begin
    Result := false;
    exit;
  end;
  LMDWideDelete(Str, i, Length(SourceString));
  LMDWideInsert(DestString, Str, i);
  Result := true;
end;

function LMDIntToStrFmt(value: integer): String;
var
  S: String;
  sl,
   i,
   j,
   k: integer;
   b: boolean;
  begin
  S := IntToStr(Value);
  sl := Length(S);
  if AnsiChar(S[1]) in ['-', '+'] then
  begin
    dec(sl);
    if sl > 3 then
    begin
      k := sl + sl div 3 + 1;
      b := SL mod 3 = 0;
      if b then
        dec(k);
    end
    else
      k := sl + 1;
    inc(sl);
    SetLength(Result, k);
    Result[1] := S[1];
    i := 2;
  end
  else
  begin
    if sl > 3 then
    begin
      k := sl + sl div 3;
      b := SL mod 3 = 0;
      if b then
        dec(k);
    end
    else
      k := sl;
    SetLength(Result, k);
    i := 1;
  end;
  k := i;
  for j := i to sl do
  begin
    if (sl > 3 + (i - 1)) and
      ((sl - j + 1) mod 3 = 0) and (j > i) then
    begin
      Result[k] := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator;
      inc(k);
    end;
    Result[k] := S[j];
    inc(k);
  end;
  end;

{ TLMDStringHashTable }

procedure TLMDStringHashTable.Add(const AKey: TLMDString;
                                  const AValue: TLMDString;
                                  AObj: TObject);
var
  oldlen: Integer;
  item: TLMDStringHashNode;
begin
  oldlen := Length(FItems);
  if FCount = oldlen then
  begin
    Grow(oldlen);
    Rehash(oldlen);
  end;

  item := TLMDStringHashNode.Create;

  item.FValue := AValue;
  item.FKey := AKey;
  item.FData := AObj;
  item.FNext := nil;

  InsertItem(item);
  Inc(FCount);
end;

procedure TLMDStringHashTable.Add(const AKey, AValue: TLMDString);
begin
  Add(AKey, AValue, nil);
end;

procedure TLMDStringHashTable.Assign(AValue: TLMDStringHashTable);
var
    NewItems: TLMDStringHashNodeArray;
    Iter, MyIter: TLMDStringHashIterator;
    Ok: Boolean;
    MyNode, Node, tmp: TLMDStringHashNode;
begin
  if AValue.FOwnItems then
    raise EInvalidArgument.Create(SLMDRtlHashTableArgShouldNotOwnData);

  SetLength(NewItems, Length(AValue.FItems));

  Ok := IteratorMoveFirst(MyIter);

  if AValue.IteratorMoveFirst(Iter) then
    repeat
      if Ok then
      begin
        MyNode := MyIter.CurrentNode;
        if FOwnItems then
          MyNode.Data.Free;

        Ok := IteratorMoveNext(MyIter);
      end
      else
        MyNode := TLMDStringHashNode.Create;

      Node := Iter.CurrentNode;

      MyNode.FKey := Node.FKey;
      MyNode.FValue := Node.FValue;
      MyNode.FData := Node.FData;
      MyNode.FNext := nil;

      if NewItems[Iter.InternalIndex]<>nil then
        MyNode.FNext := NewItems[Iter.InternalIndex];

      NewItems[Iter.InternalIndex] := MyNode;
    until not AValue.IteratorMoveNext(Iter);

  while Ok do
  begin
    tmp := MyIter.CurrentNode;
    Ok := IteratorMoveNext(MyIter);

    if FOwnItems then
      tmp.Data.Free;
    tmp.Free;
  end;

  FItems := NewItems;
  FCount := AValue.FCount;
  FIndexMask := AValue.FIndexMask;
end;

procedure TLMDStringHashTable.CheckNotOwnItems;
begin
  if FOwnItems then
    raise Exception.Create(SLMDRtlHashTableShouldNotOwnData);
end;

procedure TLMDStringHashTable.Clear;
var
  i:         Integer;
  cur, tmp: TLMDStringHashNode;
begin
  for i := 0 to High(FItems) do
  begin
    cur       := FItems[i];
    FItems[i] := nil;

    while cur<>nil do
    begin
      if FOwnItems then
        cur.Data.Free;

      tmp := cur;
      cur := cur.FNext;

      tmp.Free;
    end;
  end;

  SetLength(FItems, 0);
  FIndexMask := 0;
  FCount     := 0;
end;

function TLMDStringHashTable.Clone: TLMDStringHashTable;
begin
  CheckNotOwnItems;

  Result := TLMDStringHashTable.Create(false);
  Result.Assign(self);
end;

constructor TLMDStringHashTable.Create(AOwnItems: Boolean);
begin
  inherited Create;

  FOwnItems := AOwnItems;
end;

destructor TLMDStringHashTable.Destroy;
begin
  Clear;

  inherited;
end;

function TLMDStringHashTable.Find(const AKey: TLMDString): TLMDString;
var
    Dummy: TObject;
begin
  Result := Find(AKey, Dummy);
end;

function TLMDStringHashTable.Find(const AKey: TLMDString;
                                  var Obj: TObject): TLMDString;
var
  res: TLMDStringHashNode;
begin
  res := FindNode(AKey);
  if res<>nil then
  begin
    Result := res.FValue;
    Obj := res.FData;
  end
  else
  begin
    Result := '';
    Obj := nil;
  end;
end;

function TLMDStringHashTable.FindNode(const AKey: TLMDString): TLMDStringHashNode;
var
  idx:             Integer;
  cur:             TLMDStringHashNode;
begin
  Result := nil;

  if FIndexMask = 0 then
    Exit;

  idx  := TLMDHashTable.StrHash(AKey) and FIndexMask;
  cur  := FItems[idx];

  while cur<>nil do
  begin
    if cur.FKey=AKey then
    begin
      Result := cur;
      Break;
    end;

    cur  := cur.FNext;
  end;
end;

procedure TLMDStringHashTable.Grow(AOldLength: Integer);
begin
  if AOldLength = 0 then
    SetLength(FItems, 4)
  else
    SetLength(FItems, AOldLength * 2);

  FIndexMask := High(FItems);
end;

function TLMDStringHashTable.HasKey(const AKey: TLMDString): Boolean;
begin
  Result := FindNode(AKey)<>nil;
end;

procedure TLMDStringHashTable.InsertItem(AItem: TLMDStringHashNode);
var
  idx: Integer;
  old: TLMDStringHashNode;
begin
  idx := TLMDHashTable.StrHash(AItem.FKey) and FIndexMask;

  if FItems[idx] = nil then
    FItems[idx] := AItem
  else
  begin
    old := FItems[idx];
    FItems[idx] := AItem;
    AItem.FNext := old;
  end;
end;

function TLMDStringHashTable.IteratorMoveFirst(var Iter: TLMDStringHashIterator): Boolean;
begin
  Iter.InternalIndex := -1;
  Iter.CurrentNode := nil;
  Result := IteratorMoveNext(Iter);
end;

function TLMDStringHashTable.IteratorMoveNext(var Iter: TLMDStringHashIterator): Boolean;
var
    L: Integer;
begin
  if (Iter.CurrentNode=nil) or (Iter.CurrentNode.FNext=nil) then
  begin
    L := Length(FItems);
    if Iter.InternalIndex < L then
      repeat
        Inc(Iter.InternalIndex);
      until (Iter.InternalIndex=L) or (FItems[Iter.InternalIndex]<>nil);

    Result := Iter.InternalIndex < L;

    if Result then
      Iter.CurrentNode := FItems[Iter.InternalIndex]
    else
      Iter.CurrentNode := nil;
  end
  else
  begin
    Iter.CurrentNode := Iter.CurrentNode.FNext;
    Result := true;
  end;
end;

procedure TLMDStringHashTable.Merge(AValue: TLMDStringHashTable);
var
    Iter: TLMDStringHashIterator;
    Node: TLMDStringHashNode;
begin
  if AValue.FOwnItems then
    raise EInvalidArgument.Create(SLMDRtlHashTableArgShouldNotOwnData);

  if AValue.IteratorMoveFirst(Iter) then
    repeat
      Node := Iter.CurrentNode;
      SetOrAdd(Node.Key, Node.Value, Node.Data);
    until not AValue.IteratorMoveNext(Iter);
end;

procedure TLMDStringHashTable.Rehash(AOldLength: Integer);
var
  i:         Integer;
  cur, next: TLMDStringHashNode;
begin
  for i := AOldLength - 1 downto 0 do // More effective to go backward.
  begin
    cur       := FItems[i];
    FItems[i] := nil;

    while cur<>nil do
    begin
      next := cur.FNext;

      cur.FNext := nil;
      InsertItem(cur);

      cur := next;
    end;
  end;
end;

function TLMDStringHashTable.Remove(const AKey: TLMDString): Boolean;
var
  idx:             Integer;
  prev, cur, next:  TLMDStringHashNode;
begin
  if FIndexMask = 0 then
  begin
    Result := False;
    Exit;
  end;

  idx  := TLMDHashTable.StrHash(AKey) and FIndexMask;
  cur  := FItems[idx];
  prev := nil;

  while cur<>nil do
  begin
    next := cur.FNext;

    if cur.FKey=AKey then
    begin
      if prev = nil then
        FItems[idx] := next
      else
        prev.FNext := next;

      if FOwnItems then
        cur.Data.Free;

      cur.Free;

      Dec(FCount);
      Result := True;
      Exit;
    end;

    prev := cur;
    cur  := next;
  end;

  Result := False;
end;

procedure TLMDStringHashTable.SetOrAdd(const AKey, AValue: TLMDString;
                                       AObj: TObject);
var
    Node: TLMDStringHashNode;
begin
  Node := FindNode(AKey);
  if Node<>nil then
  begin
    Node.FValue := AValue;

    if FOwnItems then
      Node.FData.Free;

    Node.FData := AObj;
  end
  else
    Add(AKey, AValue, AObj);
end;

procedure TLMDStringHashTable.SetOrAdd(const AKey, AValue: TLMDString);
begin
  SetOrAdd(AKey, AValue, nil);
end;

end.
