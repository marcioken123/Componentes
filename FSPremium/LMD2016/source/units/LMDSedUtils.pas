unit LMDSedUtils;
{$I LMDCmps.inc}
{$IFDEF LMD_DEBUG} {$R+} {$ENDIF}

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

LMDSedUtils unit (VT)
---------------------
This unit contains the utilities for LMD-Tools Syntax Edit packages.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}
interface

uses
  Classes, Controls, Windows, Graphics, LMDTypes, LMDProcs, LMDStrings,
  SysUtils, LMDArrayUtils {$IFDEF LMDCOMP16},UITypes{$ENDIF};

type
  {******************************** TLMDCharSeq *******************************}

  TLMDCharSeq = class
  private
    FBoundGap:   Integer;
    FBufferSize: Integer;

    function  GetChar(AIdx: Integer): TLMDChar;
  protected
    FCount:       Integer;
    FBufferStart: Integer;
    FBufferEnd:   Integer;
    FBuffer:      TLMDCharArray;

    procedure ResetBuffer;
    procedure FillBuffer(ABufferStart, ABufferEnd: Integer); virtual; abstract;

    constructor Create(ABufSize: Integer);
  public
    procedure AssureIdx(AIdx: Integer);

    property Count: Integer read FCount;
    property Chars[AIdx: Integer]: TLMDChar read GetChar; default;
    property BufferStart: Integer read FBufferStart;
    property BufferEnd: Integer read FBufferEnd;
    property Buffer: TLMDCharArray read FBuffer;
  end;

  {******************************* TSeqFromString *****************************}

  TLMDSeqFromString = class(TLMDCharSeq)
  protected
    FArr: TLMDCharArray;

    procedure FillBuffer(ABufferStart, ABufferEnd: Integer); override;
  public
    constructor Create(const AStr: TLMDString);

    procedure Reset(const AStr: TLMDString); overload;
    procedure Reset(AChar: TLMDChar; ACount: Integer); overload;
  end;

  TLMDSegment = record
    Start: Integer;
    Count: Integer;
    Source: TLMDCharSeq;
  end;

  TLMDSedIntConv = record
    Key1: Integer;
    Key2: Integer;

    Data:  Integer;
  end;

  TLMDSedIntConvArray = array of TLMDSedIntConv;
  TLMDSedIntConversionCache = class
  public
    FKeys: TLMDSedIntConvArray;
    FKeyCount: Integer;
  private
    FMaxCount: Integer;

    function AddByKeyLow(AKey1, AKey2, AData: Integer; ByKey1: Boolean): Integer;

    //Returns:
    //The index (i) of pair, where:
    //  FKeys1[i] > AKey1
    //
    //i := [0...FKeyCount]
    //
    //AKey1Res = FKeys1[i], if i<FKeyCount, AKey1Res = -1, if i=FKeyCount
    //AKey2Res = ....
    function FindUpperByKeyLow(AKey: Integer;
                               ByKey1: Boolean;
                               out AKey1Res: Integer;
                               out AKey2Res: Integer): Integer;

    function FindNearestByKeyLow(AKey: Integer;
                                 ByKey1: Boolean;
                                 out AKey1Res: Integer;
                                 out AKey2Res: Integer;
                                 out AData: Integer): Integer;

    procedure InvalidateFromKeyLow(AKey: Integer; ByKey1: Boolean);
  public
    constructor Create(AMaxCount: Integer);

    //Assertion:
    //In keys:
    // [K1_1] >= [K1_2] >= [K1_3] >= [K1_4] >= [K1_5] >= [K1_6]  => FKeys1 array
    // [K2_1] >= [K2_2] >= [K2_3] >= [K2_4] >= [K2_5] >= [K2_6]  => FKeys2 array
    //
    // For i:=0 to FKeyCount-2 do
    //    Assert((FKeys1[i] <= FKeys1[i+1]) AND (FKeys2[i] <= FKeys2[i+1]);
    //
    //All pairs [Key1, AKeys2] grows congruently
    function AddByKey1(AKey1, AKey2, Data: Integer): Integer;
    function AddByKey2(AKey1, AKey2, Data: Integer): Integer;

    function FindNearestByKey1(AKey1: Integer;
                               out AKey1Res: Integer;
                               out AKey2Res: Integer;
                               out AData: Integer): Integer;

    function FindNearestByKey2(AKey2: Integer;
                               out AKey1Res: Integer;
                               out AKey2Res: Integer;
                               out AData: Integer): Integer;

    //Invalidates the cache from FKeys1[idx] >= AKey1
    procedure InvalidateFromKey1(AKey1: Integer);

    //Invalidates the cache from FKeys2[idx] >= AKey2
    procedure InvalidateFromKey2(AKey2: Integer);

    property Count: Integer read FKeyCount;
  end;

{****************************** Global utilities ******************************}

// Conversion, copy utilites.
function LMDSegFromString(const AStr: TLMDString): TLMDSegment;
function LMDSeqFromString(const AStr: TLMDString): TLMDCharSeq;

procedure LMDSegFree(var ASeg: TLMDSegment);

function LMDSeqFromPtr(const APtr: PLMDChar; ACount: Integer): TLMDCharSeq;
procedure LMDSegCopyToPtr(const ASrc: TLMDSegment; ADst: PLMDChar);

procedure LMDSegCopyToArray(const ASrc: TLMDSegment; var ADst: TLMDCharArray; ADstIdx: Integer);

function LMDSegToString(const ASeg: TLMDSegment): TLMDString;
function LMDSeqToString(const ASeq: TLMDCharSeq): TLMDString;

// Search, creation.
function LMDSegIsValid(const ASeg: TLMDSegment): Boolean;
function LMDSegIsBad(const ASeg: TLMDSegment): Boolean;
function LMDBadSegment: TLMDSegment;

function LMDSegAt(AIdx: Integer; const ASeg: TLMDSegment): TLMDChar;
function LMDSegEnd(const ASeg: TLMDSegment): Integer; // Returns position 'after
                                                   // last char' of segment.
function LMDSegment(AStart: Integer; ALength: Integer;
                    const ASource: TLMDCharSeq): TLMDSegment; overload;
function LMDSegment(const ASource: TLMDCharSeq): TLMDSegment; overload;

function LMDSeqPos(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
                   AOffset: Integer; AMaxCount: Integer = -1): Integer;
function LMDSeqPosBack(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
                       AOffset: Integer; AMaxCount: Integer=-1): Integer;

function LMDSeqPosCI(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
                     AOffset: Integer; AMaxCount: Integer = -1): Integer;

function LMDSeqPosBackCI(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
                         AOffset: Integer; AMaxCount: Integer=-1): Integer;

function LMDSeqPosOneOfGen(const ASearchSet: TLMDString;
                           const ASeq: TLMDCharSeq;
                           AOffset, AMaxCount: Integer;
                           Back, NotOf: Boolean): Integer;

function LMDSeqPosOneOf(const SearchSet: TLMDString; const Seq: TLMDCharSeq;
                        Offset: Integer; MaxCount: Integer = -1): Integer;

function LMDSeqPosOneNotOf(const SearchSet: TLMDString; const Seq: TLMDCharSeq;
                           Offset: Integer; MaxCount: Integer = -1): Integer;

function LMDSeqPosOneOfBack(const SearchSet: TLMDString; const Seq: TLMDCharSeq;
                            Offset: Integer; MaxCount: Integer = -1): Integer;

function LMDSeqPosOneNotOfBack(const SearchSet: TLMDString; const Seq: TLMDCharSeq;
                               Offset: Integer; MaxCount: Integer = -1): Integer;


// Unicode canvas.
function  LMDSedTextExtent(ACanvas: TCanvas; const Text: TLMDSegment): TSize; overload;
function  LMDSedTextExtent(ACanvas: TCanvas; const Text: TLMDString): TSize; overload;

procedure LMDSedAssignFont(ADest, ASrc: TFont; ACharset: TFontCharset);
procedure LMDGetDialogFont(AResult: TFont);

function  LMDSedTextWidth (ACanvas: TCanvas; const Text: TLMDSegment): Integer;  overload;
function  LMDSedTextWidth (ACanvas: TCanvas; const Text: TLMDString): Integer; overload;
function  LMDSedCharWidth (ACanvas: TCanvas; AChar: TLMDChar): Integer;

procedure LMDSedTextRect(ACnvHandle: THandle; const Rect: TRect; X, Y: Integer;
                         PText: PLMDChar; ACnt: Integer;
                         ATransparent: Boolean); overload;

procedure LMDSedTextRect(ACanvas: TCanvas; const Rect: TRect; X, Y: Integer;
                         const AStr: TLMDString); overload;

// Other unicode.
function  LMDCanGetClipboardText: Boolean;
procedure LMDGetClipboardText(out Res: TLMDString; out IsRectBlock: Boolean);
procedure LMDSetClipboardText(const ASeg: TLMDSegment; ARectBlock: Boolean);

// Other.
function  LMDBadPoint: TPoint;
function  LMDIsBadPoint(APt: TPoint): Boolean;
function  LMDPointsEqual(P1, P2: TPoint): Boolean;
function  LMDMsecsToTime(AMs: Cardinal): TDateTime;

//Internal functions - not documentable
procedure SedInvalidateRect(AHandle: THandle; ARect: TRect);
function  SedGetResourceImage(const AName: string): TBitmap;

function  MakeIntHash(AKey: Integer): Integer;

function  MakeStrHash(const AKey: TLMDString; AStart, ACount: Integer;
                      AIgnoreCase: Boolean = False): Integer;

function  MakeSeqHash(ASeq: TLMDCharSeq;
                      AStart, ACount: Integer;
                      AIgnoreCase: Boolean = False): Integer;

function  StrToColorHtml(const AStr: TLMDString; var Color: TColor): Boolean;
function  ColorToStrHtml(AColor: TColor): TLMDString;

function  GetNewArrLength(ANewCount, AOldLn: Integer): Integer;

function  SedGetFontScreenSize(AFont: TFont): TSize;
function  SedGetFontSize(AFont: TFont; ACanvas: TCanvas): TSize; overload;
procedure SedGetFontSize(AFont: TFont; ADC: HDC;
                         out AverWidth, MaxWidth, Height: Integer); overload;

implementation

uses
  Math, ImgList, LMDRTLConst, LMDSedConst, LMDHashTable,
  Clipbrd, Dialogs;

{$R LMDSyntaxPack.res}

{$IFDEF LMDDEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

type
  TSegFromPtr = class(TLMDCharSeq)
  private
    FPtr: PLMDChar;
  protected
    procedure FillBuffer(ABufferStart, ABufferEnd: Integer); override;
  public
    constructor Create(APtr: PLMDChar; ACount: Integer);
  end;

  TMyClipboard = class(TClipboard)
  end;

var
  CF_RECT_BLOCK: Cardinal;
{******************************* TLMDCharSeq **********************************}
{------------------------------------------------------------------------------}

constructor TLMDCharSeq.Create(ABufSize: Integer);
begin
  inherited Create;

  FCount := 0;
  FBufferStart := -1;
  FBufferEnd := 0;

  FBufferSize := ABufSize;
  FBoundGap := 5;
  SetLength(FBuffer, ABufSize);
end;

{------------------------------------------------------------------------------}

procedure TLMDCharSeq.ResetBuffer;
begin
  FBufferStart := -1;
  FBufferEnd   := -1;
end;

{------------------------------------------------------------------------------}

procedure TLMDCharSeq.AssureIdx(AIdx: Integer);
begin
  if (AIdx<BufferStart) or (AIdx>=BufferEnd) then
  begin
    Assert((AIdx>=0) and (AIdx<FCount));

    if AIdx>=BufferEnd then
    begin
      FBufferStart := AIdx - FBoundGap;
      FBufferEnd := BufferStart + FBufferSize;
    end
    else
    begin
      FBufferEnd := AIdx + FBoundGap + 1;
      FBufferStart := BufferEnd - FBufferSize;
    end;

    if FBufferStart < 0 then
    begin
      FBufferStart := 0;

      FBufferEnd := BufferStart + FBufferSize;
      if BufferEnd>FCount then
        FBufferEnd := FCount;
    end;

    if FBufferEnd > FCount then
    begin
      FBufferEnd := FCount;

      FBufferStart := FBufferEnd - FBufferSize;
      if FBufferStart < 0 then
        FBufferStart := 0;
    end;
    Assert((AIdx >= BufferStart) and (AIdx < BufferEnd));
    FillBuffer(BufferStart, BufferEnd);
  end;
end;

{------------------------------------------------------------------------------}

function  TLMDCharSeq.GetChar(AIdx: Integer): TLMDChar;
begin
  AssureIdx(AIdx);
  Result := Buffer[AIdx - BufferStart];
end;

{******************************* TSegFromPtr **********************************}
{------------------------------------------------------------------------------}

constructor TSegFromPtr.Create(APtr: PLMDChar; ACount: Integer);
begin
  inherited Create(256);
  FPtr := APtr;
  FCount := ACount;
end;

{------------------------------------------------------------------------------}

procedure TSegFromPtr.FillBuffer(ABufferStart, ABufferEnd: Integer);
var
  Bytes: Integer; Ptr: PLMDChar;
begin
  Bytes := (ABufferEnd-ABufferStart) * Sizeof(TLMDChar);

  Ptr := FPtr+ABufferStart;
  System.Move(Ptr^, Buffer[0], Bytes);
end;

{******************************* TSeqFromString *******************************}
{------------------------------------------------------------------------------}

constructor TLMDSeqFromString.Create(const AStr: TLMDString);
begin
  inherited Create(256);

  Reset(AStr);
end;

{------------------------------------------------------------------------------}

procedure TLMDSeqFromString.Reset(const AStr: TLMDString);
var
   NewSz: Integer;
begin
  FCount := Length(AStr);

  NewSz := GetNewArrLength(FCount, Length(FArr));
  if NewSz <> -1 then
    SetLength(FArr, NewSz);

  LMDCharArrayCopy(AStr, 1, FArr, 0, FCount);
  ResetBuffer;
end;

{------------------------------------------------------------------------------}

procedure TLMDSeqFromString.Reset(AChar: TLMDChar; ACount: Integer);
var
  i, NewSz: Integer;
begin
  FCount := ACount;

  NewSz := GetNewArrLength(FCount, Length(FArr));
  if NewSz<>-1 then
    SetLength(FArr, NewSz);

  for i := 0 to FCount - 1 do
    FArr[i] := AChar;

  ResetBuffer;
end;

{------------------------------------------------------------------------------}

procedure TLMDSeqFromString.FillBuffer(ABufferStart, ABufferEnd: Integer);
begin
  System.Move(FArr[ABufferStart], Buffer[0], (ABufferEnd-ABufferStart)*Sizeof(TLMDChar));
end;

{********************************** Globals ***********************************}
{------------------------------------------------------------------------------}
function LMDSeqFromPtr(const APtr: PLMDChar; ACount: Integer): TLMDCharSeq;
begin
  Result := TSegFromPtr.Create(APtr, ACount);
end;

{------------------------------------------------------------------------------}

procedure LMDSegCopyToPtr(const ASrc: TLMDSegment; ADst: PLMDChar);
var
  i, start, last: Integer;
begin
  if not LMDSegIsValid(ASrc) then
    raise EInvalidArgument.Create(SLMDBadSegment);

  start := ASrc.Start;
  last := start + ASrc.Count - 1;

  for i := start to last do
  begin
    ADst^ := ASrc.Source[i];
    Inc(ADst)
  end;

  ADst^ := #0;
end;

{------------------------------------------------------------------------------}

procedure LMDSegFree(var ASeg: TLMDSegment);
begin
  ASeg.Source.Free;
  ASeg.Source := nil;
  ASeg.Start := -1;
  ASeg.Count := 0;
end;

{------------------------------------------------------------------------------}

function LMDSegFromString(const AStr: TLMDString): TLMDSegment;
begin
  Result := LMDSegment(0, Length(AStr), TLMDSeqFromString.Create(AStr));
end;

{------------------------------------------------------------------------------}

function LMDSeqFromString(const AStr: TLMDString): TLMDCharSeq;
begin
  Result := TLMDSeqFromString.Create(AStr);
end;

{------------------------------------------------------------------------------}

function LMDSegIsValid(const ASeg: TLMDSegment): Boolean;
var
  SEnd: Integer;
begin
  SEnd := ASeg.Start + ASeg.Count;

  Result := (ASeg.Source<>nil) and
            (SEnd>=ASeg.Start) and
            ((ASeg.Source.Count=0) or LMDInRange(ASeg.Start, 0,
                                                 ASeg.Source.Count)) and
            (LMDInRange(SEnd, 0, ASeg.Source.Count))
end;

{------------------------------------------------------------------------------}

function LMDSegToString(const ASeg: TLMDSegment): TLMDString;
var
  i: Integer;
  arr: TLMDCharArray;
begin
  SetLength(arr, ASeg.Count);
  for i := 0 to ASeg.Count - 1 do
    arr[i] := LMDSegAt(i, ASeg);

  Result := LMDCharArrayToString(arr, 0, ASeg.Count);
end;

{------------------------------------------------------------------------------}

function LMDSeqToString(const ASeq: TLMDCharSeq): TLMDString;
begin
  Result := LMDSegToString(LMDSegment(0, ASeq.Count, ASeq));
end;

{------------------------------------------------------------------------------}

function LMDSegAt(AIdx: Integer; const ASeg: TLMDSegment): TLMDChar;
begin
  Result := ASeg.Source[ASeg.Start + AIdx];
end;

{------------------------------------------------------------------------------}

function LMDSegEnd(const ASeg: TLMDSegment): Integer;
begin
  Result := ASeg.Start+ASeg.Count-1;
end;

{------------------------------------------------------------------------------}

function LMDSegment(AStart: Integer; ALength: Integer;
  const ASource: TLMDCharSeq): TLMDSegment;
begin
  Result.Start := AStart; Result.Count := ALength; Result.Source := ASource;
end;

{------------------------------------------------------------------------------}

function LMDSegment(const ASource: TLMDCharSeq): TLMDSegment; overload;
begin
  Result.Start := 0; Result.Count := ASource.Count; Result.Source := ASource;
end;

{------------------------------------------------------------------------------}

procedure LMDSegCopyToArray(const ASrc: TLMDSegment;
                         var ADst: TLMDCharArray;
                         ADstIdx: Integer);
var
  i, start, last: Integer;
begin
  start := ASrc.Start;
  last := ASrc.Count - 1;

  for i := 0 to last do
    ADst[i+ADstIdx] := ASrc.Source[start + i];
end;

{------------------------------------------------------------------------------}

function SeqPosGen(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
  AOffset, AMaxCount: Integer; CaseIns: Boolean): Integer;
var
  Ch, C1, C2: TLMDChar;
  I, J:       Integer;
  LSubStrLen, LStrLen: Integer;
begin
  if not LMDInRange(AOffset, 0, ASeq.Count) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AOffset]);

  if AMaxCount<>-1 then
    if not LMDInRange(AMaxCount, 0, ASeq.Count-AOffset) then
      raise EInvalidArgument.CreateFmt(SLMDInvalidCount, [AMaxCount]);

  Result := -1;

  LSubStrLen := Length(ASubStr);
  if AMaxCount=-1 then
    LStrLen := ASeq.Count
  else
    LStrLen := AOffset + AMaxCount;

  if (LStrLen = 0) or (LSubStrLen = 0) then
    Exit;

  Ch := ASubStr[1];
  if CaseIns then
    Ch := LMDLowerCaseChar(Ch);

  for I := AOffset to LStrLen - LSubStrLen do
  begin
    C1 := ASeq[I];
    if CaseIns then
      C1 := LMDLowerCaseChar(C1);

    if C1 = Ch then
      for J := 1 to LSubStrLen do
      begin
        C1 := ASeq[I + J - 1];
        C2 := ASubStr[J];
        if CaseIns then
        begin
          C1 := LMDLowerCaseChar(C1);
          C2 := LMDLowerCaseChar(C2);
        end;

        if C1 <> C2 then
          Break
        else
          if J = LSubStrLen then
          begin
            Result := I;
            Exit;
          end;
      end;
  end;
end;

{------------------------------------------------------------------------------}

function SeqPosBackGen(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
  AOffset: Integer; AMaxCount: Integer; CaseIns: Boolean): Integer;
var
  Ch, C1, C2: TLMDChar;
  I, J: Integer;
  SubLn, StrLn: Integer;
begin
  Result := -1;

  if not LMDInRange(AOffset, -1, ASeq.Count-1) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AOffset]);

  if AMaxCount<>-1 then
    if not LMDInRange(AMaxCount, 0, AOffset) then
      raise EInvalidArgument.CreateFmt(SLMDInvalidCount, [AMaxCount]);

  SubLn := Length(ASubStr);
  StrLn := ASeq.Count;

  if (StrLn = 0) or (SubLn = 0) then
    Exit;

  if AMaxCount=-1 then
    AMaxCount := AOffset;

  Ch := ASubStr[SubLn];
  if CaseIns then
    Ch := LMDLowerCaseChar(Ch);

  for I := AOffset downto SubLn-1 do
  begin
    if AOffset-I>AMaxCount then
      Exit
    else
    begin
      C1 := ASeq[I];
      if CaseIns then
        C1 := LMDLowerCaseChar(C1);

      if C1 = Ch then
      begin
        if SubLn=1 then
          Result := I
        else
        begin
          for J := 1 to SubLn-1 do
          begin
            C1 := ASeq[I - J];
            C2 := ASubStr[SubLn - J];
            if CaseIns then
            begin
              C1 := LMDLowerCaseChar(C1);
              C2 := LMDLowerCaseChar(C2);
            end;

            if C1 <> C2 then
            begin
              Result := -1;
              Break;
            end
            else if J = SubLn-1 then
            begin
              Result := I - J;
              Break;
            end;
          end;
        end;

        if Result<>-1 then
          Exit;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function LMDSeqPos(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
  AOffset, AMaxCount: Integer): Integer;
begin
  Result := SeqPosGen(ASubStr, ASeq, AOffset, AMaxCount, False);
end;

{------------------------------------------------------------------------------}

function LMDSeqPosBack(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
  AOffset: Integer; AMaxCount: Integer): Integer;
begin
  Result := SeqPosBackGen(ASubStr, ASeq, AOffset, AMaxCount, False);
end;

{------------------------------------------------------------------------------}

function LMDSeqPosCI(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
  AOffset: Integer; AMaxCount: Integer = -1): Integer;
begin
  Result := SeqPosGen(ASubStr, ASeq, AOffset, AMaxCount, True);
end;

{------------------------------------------------------------------------------}

function LMDSeqPosBackCI(const ASubStr: TLMDString; const ASeq: TLMDCharSeq;
  AOffset: Integer; AMaxCount: Integer=-1): Integer;
begin
  Result := SeqPosBackGen(ASubStr, ASeq, AOffset, AMaxCount, True);
end;

{------------------------------------------------------------------------------}

function LMDSeqPosOneOfGen(const ASearchSet: TLMDString;
  const ASeq: TLMDCharSeq; AOffset, AMaxCount: Integer; Back,
  NotOf: Boolean): Integer;
var
  I, J, Mc, Add: Integer;
  SetLen, PosE: Integer;
  Ch: TLMDChar;
begin
  if not LMDInRange(AOffset, 0, ASeq.Count) then
    raise EInvalidArgument.CreateFmt(SLMDIndexOutOfBounds, [AOffset]);

  if AMaxCount<>-1 then
  begin
    if Back then
      Mc := AOffset + 1
    else
      Mc := ASeq.Count-AOffset;

    if not LMDInRange(AMaxCount, 0, Mc) then
      raise EInvalidArgument.CreateFmt(SLMDInvalidCount, [AMaxCount]);
  end;

  Result := -1;

  SetLen := Length(ASearchSet);
  if SetLen = 0 then
    Exit;

  if AMaxCount=-1 then
  begin
    if Back then
      PosE := -1
    else
      PosE := ASeq.Count
  end
  else
  begin
    if Back then
      PosE := AOffset - AMaxCount
    else
      PosE := AOffset + AMaxCount
  end;

  if Back then
    Add := -1
  else
    Add := 1;

  I := AOffset;
  while I<>PosE do
  begin
    J := 1;
    Ch := ASeq[I];

    while (J<=SetLen) and (Ch <> ASearchSet[J]) do
      Inc(J);

    if ((J>SetLen) and NotOf) or ((J<=SetLen) and (not NotOf)) then
    begin
      Result := I;
      Exit;
    end;

    I := I + Add;
  end
end;

{------------------------------------------------------------------------------}

function LMDSeqPosOneOf(const SearchSet: TLMDString; const Seq: TLMDCharSeq;
  Offset, MaxCount: Integer): Integer;
begin
  Result := LMDSeqPosOneOfGen(SearchSet, Seq, Offset, MaxCount,
                           False, False)
end;

{------------------------------------------------------------------------------}

function LMDSeqPosOneNotOf(const SearchSet: TLMDString; const Seq: TLMDCharSeq;
  Offset, MaxCount: Integer): Integer;
begin
  Result := LMDSeqPosOneOfGen(SearchSet, Seq, Offset, MaxCount,
                           False, True)
end;

{------------------------------------------------------------------------------}

function LMDSeqPosOneOfBack(const SearchSet: TLMDString; const Seq: TLMDCharSeq;
  Offset: Integer; MaxCount: Integer = -1): Integer;
begin
  Result := LMDSeqPosOneOfGen(SearchSet, Seq, Offset, MaxCount,
                           True, False)
end;

{------------------------------------------------------------------------------}

function LMDSeqPosOneNotOfBack(const SearchSet: TLMDString; const Seq: TLMDCharSeq;
  Offset: Integer; MaxCount: Integer = -1): Integer;
begin
  Result := LMDSeqPosOneOfGen(SearchSet, Seq, Offset, MaxCount,
                              True, True)
end;

{------------------------------------------------------------------------------}

function LMDBadSegment: TLMDSegment;
begin
  Result := LMDSegment(-1, 0, nil);
end;

{------------------------------------------------------------------------------}

function LMDSegIsBad(const ASeg: TLMDSegment): Boolean;
begin
  Result := (ASeg.Start < 0) or (ASeg.Source=nil);
end;

{------------------------------------------------------------------------------}

procedure SedInvalidateRect(AHandle: THandle; ARect: TRect);
begin
  Windows.InvalidateRect(AHandle, @ARect, True)
end;

{------------------------------------------------------------------------------}
procedure SedGetFontSize(AFont: TFont; ADC: HDC;
                         out AverWidth, MaxWidth, Height: Integer);
var
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  SaveFont := SelectObject(ADC, AFont.Handle);
  GetTextMetrics(ADC, Metrics);

  Height := Metrics.tmHeight + Metrics.tmExternalLeading;

  AverWidth := Metrics.tmAveCharWidth;
  MaxWidth := Metrics.tmMaxCharWidth;

  SelectObject(ADC, SaveFont);
end;

function  SedGetFontSizeGen(AFont: TFont; ADC: HDC): TSize;
var
    dummy, cx, cy: Integer;
begin
  SedGetFontSize(AFont, ADC, cx, dummy, cy);
  Result.cx := cx;
  Result.cy := cy;
end;

{------------------------------------------------------------------------------}

function  SedGetFontScreenSize(AFont: TFont): TSize;
var
  DC: HDC;
begin
  DC := GetDC(0);

  try
    Result := SedGetFontSizeGen(AFont, DC);
  finally
    ReleaseDC(0, DC);
  end;
end;

{------------------------------------------------------------------------------}

function  SedGetFontSize(AFont: TFont; ACanvas: TCanvas): TSize;
begin
  Result := SedGetFontSizeGen(AFont, ACanvas.Handle);
end;

{------------------------------------------------------------------------------}

function LMDSedTextExtent(ACanvas: TCanvas; const Text: TLMDSegment): TSize;
begin
  Result := LMDSedTextExtent(ACanvas, LMDSegToString(Text));
end;

{------------------------------------------------------------------------------}

function LMDSedTextWidth(ACanvas: TCanvas; const Text: TLMDSegment): Integer;
begin
  Result := LMDSedTextExtent(ACanvas, Text).cX;
end;

{------------------------------------------------------------------------------}

function  LMDSedTextWidth (ACanvas: TCanvas; const Text: TLMDString): Integer;
begin
  Result := LMDSedTextExtent(ACanvas, Text).cX;
end;

{------------------------------------------------------------------------------}

function  LMDSedCharWidth(ACanvas: TCanvas; AChar: TLMDChar): Integer;
var
    sz: TSize;
begin
  sz.cx := 0; sz.cy := 0;

{$IFDEF LMD_UNICODE}
  Windows.GetTextExtentPoint32W(ACanvas.Handle, @AChar, 1, sz);
{$ELSE}
  Windows.GetTextExtentPoint32(ACanvas.Handle, @AChar, 1, sz);
{$ENDIF}

  Result := sz.cx;
end;

{------------------------------------------------------------------------------}

function LMDSedTextExtent(ACanvas: TCanvas; const Text: TLMDString): TSize;
begin
{$IFNDEF _LMD_UNICODEIMPL}
  Result := ACanvas.TextExtent(Text);
{$ELSE}
  Windows.GetTextExtentPoint32W(ACanvas.Handle, PWideChar(Text), Length(Text), Result);
{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure LMDSedAssignFont(ADest, ASrc: TFont; ACharset: TFontCharset);
begin
  if ADest.Name <> ASrc.Name then
    ADest.Name := ASrc.Name;

  if ADest.Charset <> ACharset then
    ADest.Charset := ACharset;

  if ADest.Color <> ASrc.Color then
    ADest.Color := ASrc.Color;

  if ADest.Pitch <> ASrc.Pitch then
    ADest.Pitch := ASrc.Pitch;

  if ADest.PixelsPerInch <> ASrc.PixelsPerInch then
    ADest.PixelsPerInch := ASrc.PixelsPerInch;

  if ADest.Size <> ASrc.Size then
    ADest.Size := ASrc.Size;

  if ADest.Style <> ASrc.Style then
    ADest.Style := ASrc.Style;
end;

{------------------------------------------------------------------------------}

procedure LMDGetDialogFont(AResult: TFont);
var
  ncm: NONCLIENTMETRICS;
  fnt: HFONT;
begin
  ncm.cbSize := SizeOf(ncm);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @ncm, 0) then
    fnt := CreateFontIndirect(ncm.lfMessageFont)
  else
    fnt := GetStockObject(SYSTEM_FONT);
  AResult.Handle := fnt;
end;

{------------------------------------------------------------------------------}

procedure LMDSedTextRect(ACnvHandle: THandle; const Rect: TRect; X, Y: Integer;
                         PText: PLMDChar; ACnt: Integer;
                         ATransparent: Boolean);
var
  Options: Integer;
begin
  Options := 0;
  if not ATransparent then
    Options := Options or ETO_OPAQUE;

{$IFDEF _LMD_UNICODEIMPL}
  Windows.ExtTextOutW(ACnvHandle, X, Y, Options, @Rect, PText, ACnt, nil);
{$ELSE}
  Windows.ExtTextOut(ACnvHandle, X, Y, Options, @Rect, PText, ACnt, nil);
{$ENDIF}
end;

{------------------------------------------------------------------------------}

procedure LMDSedTextRect(ACanvas: TCanvas; const Rect: TRect; X, Y: Integer;
                         const AStr: TLMDString);
begin
  LMDSedTextRect(ACanvas.Handle, Rect, X, Y, PLMDChar(AStr), Length(AStr), false);
end;

{------------------------------------------------------------------------------}
{$IFNDEF _LMD_UNICODEIMPL}

function  LMDCanGetClipboardText: Boolean;
begin
{$ifdef LMD_UNICODE}
  result := Clipboard.HasFormat(CF_TEXT) or
            Clipboard.HasFormat(CF_UNICODETEXT);
{$else}
  result := Clipboard.HasFormat(CF_TEXT);
{$endif}
end;

{------------------------------------------------------------------------------}

procedure LMDGetClipboardText(out Res: TLMDString; out IsRectBlock: Boolean);
var
  Clip: TMyClipboard;
begin
  Clip := TMyClipboard.Create;
  try
    IsRectBlock := Clip.HasFormat(CF_RECT_BLOCK);
    Res := Clip.AsText;
  finally
    Clip.Free;
  end;
end;

procedure LMDSetClipboardTextLow(const AStr: TLMDString; ARectBlock: Boolean);
var
  Clip: TMyClipboard;
  dummy: string;
begin
  if Length(AStr) = 0 then
    Exit;

  Clip := TMyClipboard.Create;
  try
    Clip.Open;

    if ARectBlock then
    begin
      dummy := ' ';
      Clip.SetBuffer(CF_RECT_BLOCK, PChar(dummy)^, 2 * SizeOf(char));
    end;

    Clip.AsText := AStr;
  finally
    Clip.Close;
    Clip.Free;
  end;
end;

{------------------------------------------------------------------------------}
{$ELSE} // _LMD_UNICODEIMPL

function  LMDCanGetClipboardText: Boolean;
begin
  result := Clipboard.HasFormat(CF_UNICODETEXT) or
            Clipboard.HasFormat(CF_TEXT);
end;

procedure LMDGetClipboardText(out Res: TLMDString; out IsRectBlock: Boolean);
var
  Mem: HGLOBAL;
  P: PByte;
  PC: PAnsiChar;
begin
  Res := '';

  IsRectBlock := Clipboard.HasFormat(CF_RECT_BLOCK);

  if Clipboard.HasFormat(CF_UNICODETEXT) then
  begin
    Mem := Clipboard.GetAsHandle(CF_UNICODETEXT);
    try
      if Mem <> 0 then
        Res := PWideChar(GlobalLock(Mem));
    finally
      if Mem <> 0 then
        GlobalUnlock(Mem);
    end;
  end
  else
  begin
    Mem := Clipboard.GetAsHandle(CF_TEXT);
    try
      if Mem <> 0 then
      begin
        P := GlobalLock(Mem);
        PC := PAnsiChar(P);
        Res := {$IFDEF LMDCOMP12}TLMDString{$ENDIF}(PC);
      end
    finally
      if Mem <> 0 then
        GlobalUnlock(Mem);
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure LMDSetClipboardTextLow(const AStr: TLMDString; ARectBlock: Boolean);
var
  AnsiStr: AnsiString;
  SLen: Integer;
  Clip: TMyClipboard;
  dummy: string;
begin
  SLen := Length(AStr);
  if SLen = 0 then
    Exit;

  dummy := ' ';
  Clip := TMyClipboard.Create;
  Clip.Open;
  try
    Clip.Clear;

    // set ANSI text only on Win9X, WinNT automatically creates ANSI from Unicode
    if Win32Platform <> VER_PLATFORM_WIN32_NT then
    begin
      AnsiStr := {$IFDEF LMDCOMP12}AnsiString{$ENDIF}(AStr);

      Clip.SetBuffer(CF_TEXT, PAnsiChar(AnsiStr)^, (SLen + 1) * sizeof(AnsiChar));
    end;

    Clip.SetBuffer(CF_UNICODETEXT, PLMDChar(AStr)^, (SLen + 1) * sizeof(TLMDChar));

    if ARectBlock then
      Clip.SetBuffer(CF_RECT_BLOCK, PChar(dummy)^, (Length(Dummy) + 1) * sizeof(Char));
  finally
    Clip.Close;
    Clip.Free;
  end;
end;

{$ENDIF} // _LMD_UNICODEIMPL
{------------------------------------------------------------------------------}

procedure LMDSetClipboardText(const ASeg: TLMDSegment; ARectBlock: Boolean);
begin
  LMDSetClipboardTextLow(LMDSegToString(ASeg), ARectBlock)
end;

{------------------------------------------------------------------------------}

function  MakeIntHash(AKey: Integer): Integer;
begin
  Result := AKey;
  Result := Result + (not (Result shl 9));
  Result := Result xor (Result shr 14);
  Result := Result + (Result shl 4);
  Result := Result xor (Result shr 10);
end;

{------------------------------------------------------------------------------}

function MakeStrHash(const AKey: TLMDString; AStart, ACount: Integer;
  AIgnoreCase: Boolean): Integer;
const
  NoOverMask: Cardinal = $07FFFFFF; //Upper five bites are 0
var
  i, ie, old: Integer; c: TLMDChar;
begin
  Result := 0;
  ie := AStart+ACount-1;

  for i := AStart to ie do
  begin
    old := Result;
    Result := Result and NoOverMask;

    if AIgnoreCase then
      c := LMDUpperCaseChar(AKey[i])
    else
      c := AKey[i];

    Result := ((Result shL 5) - old) + Ord(c);
  end;
end;

{------------------------------------------------------------------------------}

function MakeSeqHash(ASeq: TLMDCharSeq; AStart, ACount: Integer;
  AIgnoreCase: Boolean = False): Integer;
const
  NoOverMask: Cardinal = $07FFFFFF; //Upper five bites are 0
var
  i, st, ie, eend, old: Integer; c: TLMDChar;
begin
  Result := 0;
  eend := AStart+ACount;

  if AStart<>eend then
    repeat
      ASeq.AssureIdx(AStart);

      st := AStart-ASeq.BufferStart;
      ie := Min(eend, ASeq.BufferEnd)-ASeq.BufferStart-1;

      for i := st to ie do
      begin
        old := Result;
        Result := Result and NoOverMask;

        c := ASeq.Buffer[i];
        if AIgnoreCase then
          c := LMDUpperCaseChar(c);

        Result := ((Result shL 5) - old) + Ord(c);
      end;

      Inc(AStart, ie-st+1);
    until AStart=eend;
end;

{------------------------------------------------------------------------------}

function StrToColorHtml(const AStr: TLMDString; var Color: TColor): Boolean;
var
  res: Integer;
  s, s1:   string;
begin
  res := 0;
  Result := False;

  s := AStr;
  s := Trim(AStr);
  if Length(s)=0 then
    Exit;

  if s[1]='#' then
  begin
    s[1] := '$';
    if Length(s) < 7 then
      Insert(StringOfChar('0', 7-Length(s)), s, 2);

    Result := (Length(s)=7) and (StrToIntDef(s, -1)<>-1);
    if Result  then
    begin
      s1 := '$' + Copy(s, 6, 2) + Copy(s, 4, 2) + Copy(s, 2, 2);
      res := StringToColor(s1);
    end;
  end
  else
    Result := IdentToColor('cl'+s, res);

  if Result then
    Color := TColor(res);
end;

{------------------------------------------------------------------------------}

function ColorToStrHtml(AColor: TColor): TLMDString;
var
  tmpRGB : TColorRef;
begin
  tmpRGB := ColorToRGB(AColor) ;
  Result:=Format('#%.2x%.2x%.2x',
                 [GetRValue(tmpRGB),
                  GetGValue(tmpRGB),
                  GetBValue(tmpRGB)]);

end;
{------------------------------------------------------------------------------}

function LMDBadPoint: TPoint;
begin
  Result.X := -1;
  Result.Y := -1
end;

{------------------------------------------------------------------------------}

function LMDIsBadPoint(APt: TPoint): Boolean;
begin
  Result := (APt.X=-1) and (APt.Y=-1)
end;

{------------------------------------------------------------------------------}

function SedGetResourceImage(const AName: string): TBitmap;
begin
  Result := TBitmap.Create;
  try
    Result.LoadFromResourceName(HInstance, AName);

    Result.Transparent := True;
  except
    Result.Free;
    raise;
  end;
end;

{------------------------------------------------------------------------------}

function GetNewArrLength(ANewCount, AOldLn: Integer): Integer;
begin
  if (ANewCount>AOldLn) or (ANewCount*4 < AOldLn) then
    Result := ((ANewCount+1)*3) div 2
  else
    Result := -1;
end;

{------------------------------------------------------------------------------}

function LMDPointsEqual(P1, P2: TPoint): Boolean;
begin
  Result := (P1.X=P2.X) and (P1.Y=P2.Y);
end;

{ ---------------------------------------------------------------------------- }

function  LMDMsecsToTime(AMs: Cardinal): TDateTime;
const FS_ = 1000; FM_ = FS_*60; FH_ = FM_ * 60; FD_ = FH_ * 24;
var
    H, M, S, MS: Integer;
begin
  H := (AMs mod FD_) div FH_;
  M := (AMs mod FH_) div FM_;
  S := (AMs mod FM_) div FS_;
  MS := AMs mod FS_;

  Result := EncodeTime(H, M, S, MS);
end;

{ TLMDIntConversionCache }

function TLMDSedIntConversionCache.AddByKey1(AKey1, AKey2, Data: Integer): Integer;
begin
  Result := AddByKeyLow(AKey1, AKey2, Data, true);
end;

function TLMDSedIntConversionCache.AddByKey2(AKey1, AKey2, Data: Integer): Integer;
begin
  Result := AddByKeyLow(AKey1, AKey2, Data, false);
end;

function TLMDSedIntConversionCache.AddByKeyLow(AKey1, AKey2, AData: Integer;
                                               ByKey1: Boolean): Integer;
var
    i, Key, Key1, Key2, dummy: Integer;
    Replace: Boolean;
    Cnt: Integer;
    Leq: Boolean;
begin
  if ByKey1 then
    Key := AKey1
  else
    Key := AKey2;

  i := FindNearestByKeyLow(Key, ByKey1, Key1, Key2, dummy);

  Replace := FKeyCount=FMaxCount;
  if ByKey1 then
    Replace := Replace or ((i<>-1) and (Key1=Key))
  else
    Replace := Replace or ((i<>-1) and (Key2=Key));

  if not Replace then
  begin
    if ByKey1 then
      Leq := (i=-1) or (Key1 <= Key)
    else
      Leq := (i=-1) or (Key2 <= Key);

    if Leq then
      Inc(i);

    Inc(FKeyCount);
    if FKeyCount > Length(FKeys) then
      SetLength(FKeys, (FKeyCount * 3) div 2);

    if i <> FKeyCount-1 then
    begin
      Cnt := FKeyCount-i-1;

      System.Move(FKeys[i], FKeys[i+1], Cnt * Sizeof(TLMDSedIntConv));
    end;
  end;

  FKeys[i].Key1 := AKey1;
  FKeys[i].Key2 := AKey2;
  FKeys[i].Data := AData;

  Result := i;
end;

constructor TLMDSedIntConversionCache.Create(AMaxCount: Integer);
begin
  inherited Create;

  Assert(AMaxCount>0);

  SetLength(FKeys, 0);
  FKeyCount := 0;
  FMaxCount := AMaxCount;
end;

function TLMDSedIntConversionCache.FindNearestByKey1(AKey1: Integer;
                                                     out AKey1Res,
                                                     AKey2Res,
                                                     AData: Integer): Integer;
begin
  Result := FindNearestByKeyLow(AKey1, true, AKey1Res, AKey2Res, AData);
end;

function TLMDSedIntConversionCache.FindNearestByKey2(AKey2: Integer;
                                                     out AKey1Res,
                                                     AKey2Res,
                                                     AData: Integer): Integer;
begin
  Result := FindNearestByKeyLow(AKey2, false, AKey1Res, AKey2Res, AData);
end;

function TLMDSedIntConversionCache.FindNearestByKeyLow(AKey: Integer;
                                                       ByKey1: Boolean;
                                                       out AKey1Res,
                                                       AKey2Res,
                                                       AData: Integer): Integer;
var
    L, R, i: Integer;
begin
  i := FindUpperByKeyLow(AKey, ByKey1, AKey1Res, AKey2Res);

  if i = FKeyCount then
    Result := i-1
  else if i=0 then
    Result := i
  else
  begin
    if ByKey1 then
    begin
      L := FKeys[i-1].Key1;
      R := FKeys[i].Key1;
    end
    else
    begin
      L := FKeys[i-1].Key2;
      R := FKeys[i].Key2;
    end;

    if (AKey-L) > (R-AKey) then
      Result := i
    else
      Result := i - 1;
  end;

  if Result <> -1 then
  begin
    AKey1Res := FKeys[Result].Key1;
    AKey2Res := FKeys[Result].Key2;
    AData    := FKeys[Result].Data;
  end;
end;

function TLMDSedIntConversionCache.FindUpperByKeyLow(AKey: Integer;
                                                     ByKey1: Boolean;
                                                     out AKey1Res,
                                                         AKey2Res: Integer): Integer;
var
    S, E, M: Integer;
begin
  S := 0;
  E := FKeyCount;

  if ByKey1 then
  begin
    while S<>E do
    begin
      M := (S + E) div 2;

      if FKeys[M].Key1 > AKey then
        E := M
      else
        S := M + 1;
    end;
  end
  else
  begin
    while S<>E do
    begin
      M := (S + E) div 2;

      if FKeys[M].Key2 > AKey then
        E := M
      else
        S := M + 1;
    end;
  end;

  Result := S;
end;

procedure TLMDSedIntConversionCache.InvalidateFromKey1(AKey1: Integer);
begin
  InvalidateFromKeyLow(AKey1, true);
end;

procedure TLMDSedIntConversionCache.InvalidateFromKey2(AKey2: Integer);
begin
  InvalidateFromKeyLow(AKey2, false);
end;

procedure TLMDSedIntConversionCache.InvalidateFromKeyLow(AKey: Integer;
                                                         ByKey1: Boolean);
var
    i, dummy: Integer;
begin
  i := FindUpperByKeyLow(AKey-1, ByKey1, dummy, dummy);
  FKeyCount := i;
end;

{ ---------------------------------------------------------------------------- }

initialization
{$IFDEF LMDDEBUGTRACE}
  {$I C1.INC}
{$ENDIF}
  CF_RECT_BLOCK := RegisterClipboardFormat('LMD Syntax Editor Rect block');

end.
