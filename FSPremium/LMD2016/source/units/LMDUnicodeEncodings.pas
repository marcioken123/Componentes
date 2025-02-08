unit LMDUnicodeEncodings;
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

LMDUnicodeEncodings unit (TLMDEncoding class for conversion between encodings)
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, LMDTypes ;

type
  ELMDEncodingError = class(Exception);

  TLMDNamedEncoding = (neACP, neOEMCP, neASCII,
                       neUTF7, neUTF8,
                       neUTF16LE, neUTF16BE,
                       neUTF32LE, neUTF32BE,
                       neUndefined);

  TLMDEncodingDescr = record
    Names: array of string;
    NamedCode: TLMDNamedEncoding;
    CodePage: Integer;
    Description: string;
  end;

  TLMDEncodingDescrArray = array of TLMDEncodingDescr;

  TLMDEncodingDetect = record
    PreambleUsed: Boolean;
    CodePage: Integer;
    Detected: Boolean;
  end;

  TLMDEncoding = class
  protected
    FName: string;
    FCodePage: Integer;
    FNamedEncoding: TLMDNamedEncoding;
    FDescription: string;
    FPreamble: TLMDByteArray;

    procedure CheckByteRange(const Arr: TLMDByteArray;
                             AStart, ACount: Integer);
    procedure CheckCharRange(const Arr: TLMDWideCharArray;
                             AStart, ACount: Integer);

    procedure CheckByteIdx(const Arr: TLMDByteArray;
                           AStart: Integer;
                           AForAppend: Boolean);
    procedure CheckCharIdx(const Arr: TLMDWideCharArray;
                           AStart: Integer;
                           AForAppend: Boolean);

    constructor Create(ACodePage: Integer; ANamed: TLMDNamedEncoding;
                       const AName: string; const ADescr: string);

    class function IsUCS(ACodePage: Integer): Boolean;
    function ReadUCS(ADest: TLMDWideCharArray;
                     ADestStart: Integer;
                     const ASrc: TLMDByteArray;
                     ASrcStart, ASrcCount: Integer): Integer;
    function WriteUCS(ADest: TLMDByteArray;
                      ADestStart: Integer;
                      const ASrc: TLMDWideCharArray;
                      ASrcStart, ASrcCount: Integer): Integer;
    function UCSReadCount(ASrcCount: Integer): Integer;
    function UCSWriteCount(ASrcCount: Integer): Integer;

    function SkipPreamble(const Arr: TLMDByteArray;
                          AStart, ACount: Integer): Integer; virtual;

    function WritePreamble(Arr: TLMDByteArray;
                           AStart, ACount: Integer): Integer; virtual;

    function ReadBufferLow(var ADest: TLMDWideCharArray;
                           ADestStart: Integer;
                           const ASrc: TLMDByteArray;
                           ASrcStart, ASrcCount: Integer;
                           ADoRealloc: Boolean): Integer;
                           virtual;

    function   WriteBufferLow(const ASrc: TLMDWideCharArray;
                              ASrcStart, ASrcCount: Integer;
                              var ADest: TLMDByteArray;
                              ADestStart: Integer;
                              AUsePreamble: Boolean;
                              ADoRealloc: Boolean): Integer;
                              virtual;

    class function NamedFromCode(ACodePage: Integer): TLMDNamedEncoding;

    class function TryDetectUTFEncoding(AStream: TStream): TLMDEncodingDetect;
  public
    class function GetEncoding(AName: string): TLMDEncoding; overload;
    class function GetEncoding(ACodePage: Integer): TLMDEncoding; overload;
    class function GetEncoding(ANamed: TLMDNamedEncoding): TLMDEncoding; overload;

    class function GetDescriptions(AValidOnly: Boolean): TLMDEncodingDescrArray;
    class function IsEncodingValid(ACodePage: Integer): Boolean;
    class function IsUnicodeEncoding(ACodePage: Integer): Boolean;

    class function TryDetectEncoding(AStream: TStream): TLMDEncodingDetect;
                                     overload;

    class function TryDetectEncoding(ABfr: TLMDByteArray;
                                     AStart, ACount: Integer): TLMDEncodingDetect;
                                     overload;

    class function TryDetectEncoding(AFileName: TLMDString): TLMDEncodingDetect;
                                     overload;

    function   GetRequiredWideCharBufferSize(const ASrc: TLMDByteArray;
                                             ASrcStart,
                                             ASrcCount: Integer): Integer;
                                             overload; virtual;

    function   GetRequiredWideCharBufferSize(const ASrc: TLMDByteArray): Integer;
                                             overload;

    function   GetRequiredByteBufferSize(const ASrc: TLMDWideCharArray;
                                         ASrcStart, ASrcCount: Integer;
                                         AUsePreamble: Boolean): Integer;
                                         overload; virtual;

    function   GetRequiredByteBufferSize(const ASrc: TLMDWideCharArray;
                                         AUsePreamble: Boolean): Integer;
                                         overload;

    function   StartsFromMyPreamble(const Arr: TLMDByteArray;
                                    AStart, ACount: Integer): Boolean;

    function   HavePreamble: Boolean;
    function   PreambleCount: Integer; virtual;
    function   GetPreamble: TLMDByteArray; virtual;

    function   ReadBuffer(var ADest: TLMDWideCharArray;
                          ADestStart: Integer;
                          const ASrc: TLMDByteArray;
                          ASrcStart, ASrcCount: Integer): Integer;
                          overload;

    function   ReadBuffer(var ADest: TLMDWideCharArray;
                          const ASrc: TLMDByteArray): Integer;  overload;

    function   ReadBufferCheck(ADest: TLMDWideCharArray;
                               ADestStart: Integer;
                               const ASrc: TLMDByteArray;
                               ASrcStart, ASrcCount: Integer): Integer;
                               overload;

    function   ReadBufferCheck(ADest: TLMDWideCharArray;
                               const ASrc: TLMDByteArray): Integer; overload;

    function   ReadStream(var ADest: TLMDWideCharArray;
                          ADestStart: Integer;
                          ASrcStream: TStream;
                          ASrcCount:  Integer): Integer; overload; virtual;

    function   ReadStream(var ADest: TLMDWideCharArray;
                          ASrcStream: TStream): Integer; overload;

    function   WriteStream(const ASrc: TLMDWideCharArray;
                           ASrcStart, ASrcCount: Integer;
                           ADestStream: TStream;
                           AUsePreamble: Boolean): Integer; overload; virtual;

    function   WriteStream(const ASrc: TLMDWideCharArray;
                           ADestStream: TStream;
                           AUsePreamble: Boolean): Integer; overload;

    function   WriteBuffer(const ASrc: TLMDWideCharArray;
                           ASrcStart, ASrcCount: Integer;
                           var ADest: TLMDByteArray;
                           ADestStart: Integer;
                           AUsePreamble: Boolean): Integer;
                           overload;

    function   WriteBuffer(const ASrc: TLMDWideCharArray;
                           var ADest: TLMDByteArray;
                           AUsePreamble: Boolean): Integer; overload;

    function   WriteBufferCheck(const ASrc: TLMDWideCharArray;
                                ASrcStart, ASrcCount: Integer;
                                ADest: TLMDByteArray;
                                ADestStart: Integer;
                                AUsePreamble: Boolean): Integer;
                                overload;

    function   WriteBufferCheck(const ASrc: TLMDWideCharArray;
                                ADest: TLMDByteArray;
                                AUsePreamble: Boolean): Integer;
                                overload;

    property CodePage: Integer read FCodePage;
    property Name: string read FName;
    property Description: string read FDescription;
    property NamedEncoding: TLMDNamedEncoding read FNamedEncoding;
  end;

implementation

uses
  Math, LMDRTLConst, LMDStrings, Windows
  ;

var
  EncDescrsCount: Integer;

  EncodingDescrs: TLMDEncodingDescrArray;

  Preamble_UTF8:    TLMDByteArray;
  Preamble_UTF16LE: TLMDByteArray;
  Preamble_UTF16BE: TLMDByteArray;
  Preamble_UTF32BE: TLMDByteArray;
  Preamble_UTF32LE: TLMDByteArray;

const
  NamedEncodingCodes: array[Low(TLMDNamedEncoding)..
                            High(TLMDNamedEncoding)] of Integer =
  (CP_ACP, CP_OEMCP, 20127, CP_UTF7, CP_UTF8, 1200, 1201,
   12000, 12001,
   CP_ACP);

  MaxPreambleCount = 4;

  BytesToWCharFlags = 0;

{ TLMDEncoding }

function StrToIntMy(const AStr: string): Integer;
begin
  Result := StrToInt(AStr);
end;

function StrToIntMyDef(const AStr: string; ADef: Integer): Integer;
begin
  Result := StrToIntDef(AStr, ADef);
end;

function GetName(AIdx: Integer): string;
begin
  Assert((AIdx>=0) and (AIdx < EncDescrsCount));
  Assert(Length(EncodingDescrs[AIdx].Names)>0);

  Result := EncodingDescrs[AIdx].Names[0];
end;

function GetDescr(AIdx: Integer): string;
begin
  Assert((AIdx>=0) and (AIdx < EncDescrsCount));

  Result := EncodingDescrs[AIdx].Description;
end;

function GetCode(AIdx: Integer): Integer;
begin
  Assert((AIdx>=0) and (AIdx < EncDescrsCount));

  Result := EncodingDescrs[AIdx].CodePage;
end;

function ConversionErr: string;
begin
  Result := 'Unknown';
  case GetLastError of
    ERROR_INSUFFICIENT_BUFFER: Result := 'ERROR_INSUFFICIENT_BUFFER';
    ERROR_INVALID_FLAGS: Result := 'ERROR_INVALID_FLAGS';
    ERROR_INVALID_PARAMETER: Result := 'ERROR_INVALID_PARAMETER';
    ERROR_NO_UNICODE_TRANSLATION: Result := 'ERROR_NO_UNICODE_TRANSLATION';
  end;
end;

class function TLMDEncoding.GetEncoding(AName: string): TLMDEncoding;
var
    i, j: Integer;
    idx: Integer;
    Cp: Integer;
    Name: string;
begin
  AName := LMDTrim(AName);

  idx := -1;

  for j := 0 to EncDescrsCount-1 do
  begin
    for i := 0 to Length(EncodingDescrs[j].Names) - 1 do
    begin
      Name := EncodingDescrs[j].Names[i];

      if (Name=AName) or (LMDUpperCase(AName)=Name) then
      begin
        idx := j;
        Break;
      end;
    end;

    if idx<>-1 then
      Break;
  end;

  if idx<>-1 then
  begin
    Cp := GetCode(idx);
    Result := TLMDEncoding.Create(Cp, NamedFromCode(Cp),
                                  GetName(idx), GetDescr(idx));
  end
  else
  begin
    Cp := StrToIntMyDef(AName, -1);
    if Cp=-1 then
      raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingBadName, [AName])
    else
      Result := TLMDEncoding.Create(Cp, NamedFromCode(Cp),
                                    AName, 'Undefined');
  end;
end;

procedure TLMDEncoding.CheckByteIdx(const Arr: TLMDByteArray;
                                    AStart: Integer;
                                    AForAppend: Boolean);
begin
  if (AStart<0) or (AStart>=Length(Arr)) then
    if not (AForAppend and (AStart=Length(Arr))) then
      raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingBadIndex, [AStart]);
end;

procedure TLMDEncoding.CheckByteRange(const Arr: TLMDByteArray; AStart,
  ACount: Integer);
var
    AEnd: Integer;
begin
  AEnd := AStart+ACount-1;

  if (AStart<0) or (AStart>=Length(Arr)) then
    raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingBadRange, [AStart, AEnd]);

  if (AEnd<0) or (AEnd>=Length(Arr)) then
    raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingBadRange, [AStart, AEnd]);
end;

procedure TLMDEncoding.CheckCharIdx(const Arr: TLMDWideCharArray;
                                    AStart: Integer;
                                    AForAppend: Boolean);
begin
  if (AStart<0) or (AStart>=Length(Arr)) then
    if not (AForAppend and (AStart=Length(Arr))) then
      raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingBadIndex, [AStart]);
end;

procedure TLMDEncoding.CheckCharRange(const Arr: TLMDWideCharArray; AStart,
  ACount: Integer);
var
    AEnd: Integer;
begin
  AEnd := AStart+ACount-1;

  if (AStart<0) or (AStart>=Length(Arr)) then
    raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingBadRange, [AStart, AEnd]);

  if (AEnd<0) or (AEnd>=Length(Arr)) then
    raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingBadRange, [AStart, AEnd]);
end;

constructor TLMDEncoding.Create(ACodePage: Integer; ANamed: TLMDNamedEncoding;
                                const AName: string; const ADescr: string);
begin
  inherited Create;

  FCodePage := ACodePage;
  FNamedEncoding := ANamed;
  FName := AName;
  FDescription := ADescr;

  case FNamedEncoding of
    neUTF8:
      FPreamble := Copy(Preamble_UTF8, 0, Length(Preamble_UTF8));

    neUTF16LE:
      FPreamble := Copy(Preamble_UTF16LE, 0, Length(Preamble_UTF16LE));

    neUTF16BE:
      FPreamble := Copy(Preamble_UTF16BE, 0, Length(Preamble_UTF16BE));

    neUTF32BE:
      FPreamble := Copy(Preamble_UTF32BE, 0, Length(Preamble_UTF32BE));

    neUTF32LE:
      FPreamble := Copy(Preamble_UTF32LE, 0, Length(Preamble_UTF32LE));

  else
    SetLength(FPreamble, 0);
  end;
end;

class function TLMDEncoding.GetDescriptions(AValidOnly: Boolean): TLMDEncodingDescrArray;
var
    i, ii: Integer;
    CP: Integer;
begin
  SetLength(Result, EncDescrsCount);

  ii := 0;
  for i := 0 to EncDescrsCount - 1 do
  begin
    CP := GetCode(i);
    if AValidOnly and (not IsEncodingValid(CP)) then
        Continue;

    Result[ii] := EncodingDescrs[i];
    Result[ii].Names := Copy(EncodingDescrs[i].Names, 0,
                             Length(EncodingDescrs[i].Names));

    Inc(ii);
  end;

  SetLength(Result, ii);
end;

class function TLMDEncoding.GetEncoding(ANamed: TLMDNamedEncoding): TLMDEncoding;
begin
  Result := GetEncoding(NamedEncodingCodes[ANamed]);
end;

function TLMDEncoding.GetPreamble: TLMDByteArray;
begin
  Result := Copy(FPreamble, 0, PreambleCount);
end;

class function TLMDEncoding.GetEncoding(ACodePage: Integer): TLMDEncoding;
var
    i: Integer;
    idx: Integer;
begin
  idx := -1;
  for i := 0 to EncDescrsCount-1 do
  begin
    if GetCode(i)=ACodePage then
    begin
      idx := i;
      break;
    end;
  end;

  if idx<>-1 then
    Result := TLMDEncoding.Create(ACodePage, NamedFromCode(ACodePage),
                                  GetName(i), GetDescr(i))
  else
    Result := TLMDEncoding.Create(ACodePage, neUndefined,
                                  'Undefined', 'Undefined');
end;

function TLMDEncoding.GetRequiredByteBufferSize(const ASrc: TLMDWideCharArray;
                                                AUsePreamble: Boolean): Integer;
begin
  Result := GetRequiredByteBufferSize(ASrc, 0, Length(ASrc), AUsePreamble);
end;

function TLMDEncoding.GetRequiredByteBufferSize(const ASrc: TLMDWideCharArray;
                                                ASrcStart,
                                                ASrcCount: Integer;
                                                AUsePreamble: Boolean): Integer;
begin
  Result := 0;
  if ASrcCount=0 then
    Exit;

  CheckCharRange(ASrc, ASrcStart, ASrcCount);

  if IsUCS(FCodePage) then
    Result := UCSWriteCount(ASrcCount)
  else
    Result := WideCharToMultiByte(FCodePage, 0,
                                  @ASrc[ASrcStart], ASrcCount, nil, 0,
                                  nil, nil);

  if Result=0 then
  begin
    raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingConversionError,
                                      [ConversionErr]);
  end;

  if AUsePreamble then
    Result := Result + PreambleCount;
end;

function TLMDEncoding.GetRequiredWideCharBufferSize(const ASrc: TLMDByteArray): Integer;
begin
  Result := GetRequiredWideCharBufferSize(ASrc, 0, Length(ASrc));
end;

function TLMDEncoding.HavePreamble: Boolean;
begin
  Result := PreambleCount > 0;
end;

class function TLMDEncoding.IsEncodingValid(ACodePage: Integer): Boolean;

var
  Arr: array[0..0] of WideChar;
  Res: Integer;

begin
  Result := IsUCS(ACodePage);
  if Result then
    Exit;

  Arr[0] := LMDSpace;
  Res := WideCharToMultiByte(ACodePage, 0, @Arr[0], 1, nil, 0, nil, nil);
  Result := Res > 0;

end;

class function TLMDEncoding.IsUCS(ACodePage: Integer): Boolean;
begin
  Result := false;

  case ACodePage of
    1200, 1201, 12000, 12001: Result := true;
  end;
end;

class function TLMDEncoding.IsUnicodeEncoding(ACodePage: Integer): Boolean;
  const UnicodePages: array[0..5] of TLMDNamedEncoding =
            (neUTF7, neUTF8, neUTF16LE, neUTF16BE, neUTF32LE, neUTF32BE);
var
    i: Integer;
begin
  for i := Low(UnicodePages) to High(UnicodePages) do
  begin
    Result := ACodePage = NamedEncodingCodes[UnicodePages[i]];
    if Result then
      Break;
  end;
end;

class function TLMDEncoding.NamedFromCode(ACodePage: Integer): TLMDNamedEncoding;
var
    Nm: TLMDNamedEncoding;
begin
  Result := neUndefined;

  for Nm := Low(Nm) to High(Nm) do
    if NamedEncodingCodes[Nm]=ACodePage then
    begin
      Result := Nm;
      Break;
    end;
end;

function TLMDEncoding.PreambleCount: Integer;
begin
  Result := Length(FPreamble);
end;

function TLMDEncoding.GetRequiredWideCharBufferSize(const ASrc: TLMDByteArray;
                                                    ASrcStart,
                                                    ASrcCount: Integer): Integer;
var
    OldSrc: Integer;
begin
  Result := 0;
  if ASrcCount=0 then
    Exit;

  CheckByteRange(ASrc, ASrcStart, ASrcCount);

  OldSrc := ASrcStart;
  ASrcStart := SkipPreamble(ASrc, ASrcStart, ASrcCount);
  ASrcCount := ASrcCount - (OldSrc - ASrcStart);

  if IsUCS(FCodePage) then
    Result := UCSReadCount(ASrcCount)
  else
    Result := MultiByteToWideChar(FCodePage, BytesToWCharFlags,
                                  @ASrc[ASrcStart], ASrcCount,
                                  nil, 0)+1;

  if Result=0 then
    raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingConversionError,
                                      [ConversionErr]);

end;

function TLMDEncoding.ReadBuffer(var ADest: TLMDWideCharArray;
                                 const ASrc: TLMDByteArray): Integer;
begin
  Result := ReadBuffer(ADest, 0, ASrc, 0, Length(ASrc));
end;

function TLMDEncoding.ReadBuffer(var ADest: TLMDWideCharArray;
                                 ADestStart: Integer;
                                 const ASrc: TLMDByteArray;
                                 ASrcStart, ASrcCount: Integer): Integer;
begin
  Result := ReadBufferLow(ADest, ADestStart, ASrc,
                          ASrcStart, ASrcCount, true);
end;

function TLMDEncoding.ReadBufferCheck(ADest: TLMDWideCharArray;
                                      ADestStart: Integer;
                                      const ASrc: TLMDByteArray;
                                      ASrcStart, ASrcCount: Integer): Integer;
begin
  Result := ReadBufferLow(ADest, ADestStart, ASrc,
                          ASrcStart, ASrcCount, false);
end;

function TLMDEncoding.ReadBufferCheck(ADest: TLMDWideCharArray;
                                      const ASrc: TLMDByteArray): Integer;
begin
  Result := ReadBufferCheck(ADest, 0, ASrc, 0, Length(ASrc));
end;

function TLMDEncoding.ReadBufferLow(var ADest: TLMDWideCharArray;
                                    ADestStart: Integer;
                                    const ASrc: TLMDByteArray;
                                    ASrcStart, ASrcCount: Integer;
                                    ADoRealloc: Boolean): Integer;
var
    Len: Integer;
    OldSrc: Integer;
begin
  Result := 0;
  if ASrcCount=0 then
    Exit;

  CheckCharIdx(ADest, ADestStart, true);
  CheckByteRange(ASrc, ASrcStart, ASrcCount );

  OldSrc := ASrcStart;
  ASrcStart := SkipPreamble(ASrc, ASrcStart, ASrcCount);
  ASrcCount := ASrcCount - (ASrcStart - OldSrc);

  Len := GetRequiredWideCharBufferSize(ASrc, ASrcStart, ASrcCount);

  if Length(ADest) < ADestStart + Len then
  begin
    if ADoRealloc then
      SetLength(ADest, ADestStart + Len)
    else
      raise ELMDEncodingError.Create(SLMDRtlEncodingInsufficientBuffer);
  end;

  if IsUCS(FCodePage) then
    Result := ReadUCS(ADest, ADestStart, ASrc, ASrcStart, ASrcCount)
  else
    Result := MultiByteToWideChar(FCodePage, BytesToWCharFlags,
                                  @ASrc[ASrcStart], ASrcCount,
                                  @ADest[ADestStart], Len);

  if Result=0 then
    raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingConversionError,
                                      [ConversionErr]);

end;

function TLMDEncoding.ReadStream(var ADest: TLMDWideCharArray;
                                 ASrcStream: TStream): Integer;
begin
  Result := ReadStream(ADest, 0, ASrcStream,
                       ASrcStream.Size - ASrcStream.Position);
end;

function TLMDEncoding.ReadUCS(ADest: TLMDWideCharArray; ADestStart: Integer;
                              const ASrc: TLMDByteArray;
                              ASrcStart, ASrcCount: Integer): Integer;
var
    i: Integer;
    dvd: Integer;
    BE: Boolean;
    base: Integer;
begin
  case FCodePage of
    1200, 1201: dvd := 2;
    12000, 12001: dvd := 4;
  else
    dvd := 0;
    Assert(false);
  end;

  case FCodePage of
    1200, 12000: BE := false;
    1201, 12001: BE := true;
  else
    BE := false;
    Assert(false);
  end;

  for i := 0 to (ASrcCount div dvd) - 1 do
  begin
    base := ASrcStart+i*dvd;
    if BE then
      ADest[i+ADestStart] := WideChar( ASrc[base+dvd-1] or
                                       (ASrc[base+dvd-2] shl 8) )
    else
      ADest[i+ADestStart] := WideChar(ASrc[base] or (ASrc[base+1] shl 8));
  end;

  Result := ASrcCount div dvd;
end;

function TLMDEncoding.SkipPreamble(const Arr: TLMDByteArray;
                                       AStart, ACount: Integer): Integer;
begin
  Result := AStart;

  if StartsFromMyPreamble(Arr, AStart, ACount) then
    Inc(Result, PreambleCount);
end;

function TLMDEncoding.StartsFromMyPreamble(const Arr: TLMDByteArray; AStart,
  ACount: Integer): Boolean;
var
    i: Integer;
begin
  Result := (PreambleCount>0) and (ACount >= PreambleCount);

  if Result then
    for i := 0 to PreambleCount - 1 do
      if Arr[AStart+i]<>FPreamble[i] then
      begin
        Result := false;
        Break;
      end;
end;

class function TLMDEncoding.TryDetectEncoding(ABfr: TLMDByteArray;
                                              AStart, ACount: Integer):
                                              TLMDEncodingDetect;
var
    Check: array[Low(TLMDNamedEncoding) .. High(TLMDNamedEncoding)]
           of Boolean;

    CheckArr: array[Low(TLMDNamedEncoding) .. High(TLMDNamedEncoding)]
              of TLMDByteArray;

    i: Integer;
    E: TLMDNamedEncoding;
    FoundE: TLMDNamedEncoding;
    DoCheck: Boolean;
begin
  for E := Low(Check) to High(Check) do
    Check[E] := false;

  Check[neUTF8] := true;
  CheckArr[neUTF8] := Preamble_UTF8;

  Check[neUTF16LE] := true;
  CheckArr[neUTF16LE] := Preamble_UTF16LE;

  Check[neUTF16BE] := true;
  CheckArr[neUTF16BE] := Preamble_UTF16BE;

  Check[neUTF32LE] := true;
  CheckArr[neUTF32LE] := Preamble_UTF32LE;

  Check[neUTF32BE] := true;
  CheckArr[neUTF32BE] := Preamble_UTF32BE;

  FoundE := neUndefined;

  for i := AStart to AStart+ACount-1 do
  begin
    DoCheck := false;

    for E := Low(Check) to High(Check) do
      if Check[E] then
      begin
        if ABfr[i] <> CheckArr[E][i-AStart] then
          Check[E] := false
        else if (i-AStart) = (Length(CheckArr[E])-1) then
        begin
          FoundE := E;
          DoCheck := false;
          Break;
        end
        else
          DoCheck := true;
      end;

    if not DoCheck then
      Break;
  end;

  Result.Detected := FoundE <> neUndefined;

  if Result.Detected then
  begin
    Result.CodePage := NamedEncodingCodes[FoundE];
    Result.PreambleUsed := true;
  end;
end;

class function TLMDEncoding.TryDetectEncoding(AFileName: TLMDString):
                                              TLMDEncodingDetect;
var
    Stream: TFileStream;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead);
  try
    Result := TryDetectEncoding(Stream);
  finally
    Stream.Free;
  end;
end;

function TLMDEncoding.UCSReadCount(ASrcCount: Integer): Integer;
begin
  case FCodePage of
    1200, 1201: Result := ASrcCount div 2;
    12000, 12001: Result := ASrcCount div 4;
  else
    Assert(false);
    Result := -1;
  end;
end;

function TLMDEncoding.UCSWriteCount(ASrcCount: Integer): Integer;
begin
  case FCodePage of
    1200, 1201: Result := ASrcCount * 2;
    12000, 12001: Result := ASrcCount * 4;
  else
    Assert(false);
    Result := -1;
  end;
end;

class function TLMDEncoding.TryDetectUTFEncoding(AStream: TStream): TLMDEncodingDetect;

function IsUTF8Stream: Boolean;

const BufCnt = 1024;
var
  i: Int64;
  c: Integer;
  b: Byte;
  Size: Integer;

  Buf: array [0..BufCnt] of Byte;
  BufIdx: Integer;

function NextByte: Byte;
begin
  if BufIdx = BufCnt then
  begin
    AStream.Read(Buf, BufCnt);
    BufIdx := 0;
  end;

  Result := Buf[BufIdx];
  Inc(BufIdx);
end;

var
    AnsiOnly: Boolean;
begin
  BufIdx := BufCnt;
  Size := AStream.Size;
  Result := Size > 0;
  AnsiOnly := true;

  i := 0;
  while (i < Size) do
  begin
    // get the length if the current UTF-8 character
    b := NextByte;

    //UTF8CharLength
    // First Byte: 0xxxxxxx
    if ((b and $80) = $00) then
      c := 1
    // First Byte: 110yyyyy
    else if ((b and $E0) = $C0) then
      c := 2
    // First Byte: 1110zzzz
    else if ((b and $F0) = $E0) then
      c := 3
    // First Byte: 11110uuu
    else if ((b and $F8) = $F0) then
      c := 4
    // not valid, return the error value
    else
      c := -1;

    AnsiOnly := AnsiOnly and (c <= 1);

    // check if it's valid and fits into ASize
    if ((c >= 1) and (c <= 4) and
       ((i + c - 1) < Size))
    then
    begin
      inc(i, c);

      // if it's a multi-byte character, check the trail bytes
      while (c > 1) do
      begin
        b := NextByte;

        if (b and $C0) <> $80 then //not UTF8IsTrailChar
                                   //trail bytes have this form: 10xxxxxx
        begin
          Result := false;
          Break;
        end
        else
          dec(c);
      end;
    end
    else
    begin
      Result := false;
    end;

    if not Result then
      Break;
  end;

  AStream.Position := 0;
  Result := Result and (not AnsiOnly);
end;

begin
  if IsUTF8Stream then
  begin
    Result.Detected := true;
    Result.PreambleUsed := false;
    Result.CodePage := CP_UTF8;
  end
  else
  begin
    Result.Detected := false;
    Result.PreambleUsed := false;
    Result.CodePage := 0;
  end;
end;

class function TLMDEncoding.TryDetectEncoding(AStream: TStream): TLMDEncodingDetect;
var
    Bfr: TLMDByteArray;
begin
  SetLength(Bfr, Min(MaxPreambleCount, AStream.Size - AStream.Position));

  AStream.ReadBuffer(Bfr[0], Length(Bfr));

  AStream.Position := AStream.Position - Length(Bfr);

  Result := TryDetectEncoding(Bfr, 0, Length(Bfr));

  if not Result.Detected then
    Result := TryDetectUTFEncoding(AStream);
end;

function TLMDEncoding.ReadStream(var ADest: TLMDWideCharArray;
                                 ADestStart: Integer;
                                 ASrcStream: TStream;
                                 ASrcCount: Integer): Integer;
var

    Buffer: TLMDByteArray;

begin
  Result := 0;
  if ASrcCount=0 then
    Exit;

  CheckCharIdx(ADest, ADestStart, true);

  SetLength(Buffer,
            Min(ASrcCount,
                ASrcStream.Size - ASrcStream.Position));

  ASrcStream.ReadBuffer(Buffer[0], Length(Buffer));
  Result := ReadBuffer(ADest, ADestStart, Buffer, 0, Length(Buffer));
end;

function TLMDEncoding.WriteBuffer(const ASrc: TLMDWideCharArray;
                                  var ADest: TLMDByteArray;
                                  AUsePreamble: Boolean): Integer;
begin
  Result := WriteBuffer(ASrc, 0, Length(ASrc), ADest, 0, AUsePreamble);
end;

function TLMDEncoding.WriteBufferCheck(const ASrc: TLMDWideCharArray;
  ADest: TLMDByteArray; AUsePreamble: Boolean): Integer;
begin
  Result := WriteBufferCheck(ASrc, 0, Length(ASrc), ADest, 0, AUsePreamble);
end;

function TLMDEncoding.WriteBuffer(const ASrc: TLMDWideCharArray;
                                  ASrcStart, ASrcCount: Integer;
                                  var ADest: TLMDByteArray;
                                  ADestStart: Integer;
                                  AUsePreamble: Boolean): Integer;
begin
  Result := WriteBufferLow(ASrc, ASrcStart, ASrcCount, ADest,
                           ADestStart, AUsePreamble, true);
end;

function TLMDEncoding.WriteBufferCheck(const ASrc: TLMDWideCharArray;
                                       ASrcStart, ASrcCount: Integer;
                                       ADest: TLMDByteArray;
                                       ADestStart: Integer;
                                       AUsePreamble: Boolean): Integer;
begin
  Result := WriteBufferLow(ASrc, ASrcStart, ASrcCount, ADest,
                           ADestStart, AUsePreamble, false);
end;

function TLMDEncoding.WriteBufferLow(const ASrc: TLMDWideCharArray;
                                     ASrcStart, ASrcCount: Integer;
                                     var ADest: TLMDByteArray;
                                     ADestStart: Integer;
                                     AUsePreamble,
                                     ADoRealloc: Boolean): Integer;
var
    Len: Integer;

{$IFDEF MYBIGDEBUG}
    Src2:  TLMDWideCharArray;
    DS2: Integer;
    L2: Integer;
    i: Integer;
{$ENDIF}
begin
{$IFDEF MYBIGDEBUG}
  DS2 := ADestStart;
{$ENDIF}

  Result := 0;
  if ASrcCount=0 then
    Exit;

  CheckCharRange(ASrc, ASrcStart, ASrcCount);
  CheckByteIdx(ADest, ADestStart, true);

  Len := GetRequiredByteBufferSize(ASrc, ASrcStart, ASrcCount, AUsePreamble);

  if Length(ADest) < ADestStart + Len then
  begin
    if ADoRealloc then
      SetLength(ADest, ADestStart + Len)
    else
      raise ELMDEncodingError.Create(SLMDRtlEncodingInsufficientBuffer);
  end;

  if AUsePreamble then
    ADestStart := ADestStart + WritePreamble(ADest, ADestStart, Len);

  if IsUCS(FCodePage) then
    Result := WriteUCS(ADest, ADestStart, ASrc, ASrcStart, ASrcCount)
  else
    Result := WideCharToMultiByte(FCodePage, 0,
                                  @ASrc[ASrcStart], ASrcCount,
                                  @ADest[ADestStart], Len,
                                  nil, nil);

  if Result=0 then
    raise ELMDEncodingError.CreateFmt(SLMDRtlEncodingConversionError,
                                      [ConversionErr]);

  if AUsePreamble then
    Result := Result + PreambleCount;

{$IFDEF MYBIGDEBUG}
  L2 := ReadBufferLow(Src2, 0, ADest, DS2, Result, true);

  Assert(L2=Length(ASrc));
  for i := 0 to L2 - 1 do
    Assert(Src2[i]=ASrc[ASrcStart+i]);
{$ENDIF}
end;

function TLMDEncoding.WritePreamble(Arr: TLMDByteArray; AStart,
  ACount: Integer): Integer;
var
    i: Integer;
begin
  CheckByteRange(Arr, AStart, Max(PreambleCount, ACount));

  for i := 0 to PreambleCount - 1 do
    Arr[AStart+i] := FPreamble[i];

  Result := PreambleCount;
end;

function TLMDEncoding.WriteStream(const ASrc: TLMDWideCharArray;
                                  ADestStream: TStream;
                                  AUsePreamble: Boolean): Integer;
begin
  Result := WriteStream(ASrc, 0, Length(ASrc), ADestStream, AUsePreamble);
end;

function TLMDEncoding.WriteUCS(ADest: TLMDByteArray; ADestStart: Integer;
                               const ASrc: TLMDWideCharArray;
                               ASrcStart, ASrcCount: Integer): Integer;
const HiMask = $FF00; LoMask = $00FF;
var
    i: Integer;
    mlt: Integer;
    BE: Boolean;
    base: Integer;
    Ch: WideChar;
    Code: Integer;
begin
  case FCodePage of
    1200,   1201: mlt := 2;
    12000, 12001: mlt := 4;
  else
    mlt := 0;
    Assert(false);
  end;

  case FCodePage of
    1200, 12000: BE := false;
    1201, 12001: BE := true;
  else
    BE := false;
    Assert(false);
  end;

  for i := 0 to ASrcCount - 1 do
  begin
    Ch := ASrc[i+ASrcStart];
    Code := Ord(Ch);

    base := ADestStart+i*mlt;
    if BE then
    begin
      // [Hi][Lo]
      if mlt=4 then
      begin
        ADest[base] := 0;
        ADest[base+1] := 0;
      end;

      ADest[base+mlt-2] := Byte((Code and HiMask) shr 8);
      ADest[base+mlt-1] := Byte( Code and LoMask);
    end
    else
    begin
      // [Hi][Lo]
      ADest[base]   := Byte( Code and LoMask);
      ADest[base+1] := Byte((Code and HiMask) shr 8);

      if mlt=4 then
      begin
        ADest[base+2] := 0;
        ADest[base+3] := 0;
      end;
    end;
  end;

  Result := ASrcCount * mlt;
end;

function TLMDEncoding.WriteStream(const ASrc: TLMDWideCharArray;
                                  ASrcStart, ASrcCount: Integer;
                                  ADestStream: TStream;
                                  AUsePreamble: Boolean): Integer;
var

    Buffer: TLMDByteArray;

begin
  Result := 0;
  if ASrcCount=0 then
    Exit;

  CheckCharRange(ASrc, ASrcStart, ASrcCount);

  SetLength(Buffer, 0);
  WriteBuffer(ASrc, ASrcStart, ASrcCount, Buffer, 0, AUsePreamble);

  ADestStream.WriteBuffer(Buffer[0], Length(Buffer));

  Result := Length(Buffer);
end;

{ ---------------------------------------------------------------------------- }

var
    InitS: string;

procedure InitDescrs;
const Sep = '  ###  ';
var
    i: Integer;

function NextStr: string;
var
    ii: Integer;
begin
  if i<Length(InitS) then
  begin
    ii := LMDPosEx(Sep, InitS, i);
    Result := Copy(InitS, i, ii-i);
    i := ii+Length(Sep);
  end
  else
    Result := '';
end;

function AddItem: Integer;
var
    L: Integer;

begin
  L := Length(EncodingDescrs);
  SetLength(EncodingDescrs, L+1);
  Result := L;
end;

var
    S: string;
    Code: Integer;
    Name, NameExpr: string;
    Descr: string;
    idx: Integer;
    jOld, j, L: Integer;
begin
  i := 1;
  while true do
  begin
    S := NextStr;
    if S='' then
      Break;

    Code := StrToIntMy(S);

    NameExpr := NextStr;
    Assert(NameExpr<>'');

    Descr := NextStr;
    Assert(Descr<>'');

    idx := AddItem;
    EncodingDescrs[idx].CodePage := Code;
    EncodingDescrs[idx].Description := Descr;

    jOld := 0;
    repeat
      j := LMDPosEx('|', NameExpr, jOld+1);
      if j=0 then
        j := Length(NameExpr)+1;

      Name := Copy(NameExpr, jOld+1, j-jOld-1);

      jOld := j;

      L := Length(EncodingDescrs[idx].Names);
      SetLength(EncodingDescrs[idx].Names, L+1);
      EncodingDescrs[idx].Names[L] := Name;
    until j = Length(NameExpr)+1;

  end;
end;

initialization
  InitS :=
  '0  ###  System|CP_ACP|ACP  ###  System codepage  ###  '+
  '1  ###  OEM|CP_OEMCP|OEMCP  ###  System OEM codepage  ###  '+
  '65001  ###  utf-8|utf8  ###  Unicode (UTF-8)  ###  '+
  '1200  ###  utf-16|utf16|utf16LE|UTF-16-LE|UTF-16LE  ###  Unicode  ###  '+
  '1201  ###  unicodeFFFE|utf16BE|UTF-16-BE|UTF-16BE  ###  Unicode (Big-Endian)  ###  '+
  '65000  ###  utf-7|utf7  ###  Unicode (UTF-7)  ###  '+
  '65005  ###  utf-32|utf32|utf32LE|UTF-32-LE|UTF-32LE  ###  Unicode (UTF-32)  ###  '+
  '65006  ###  utf32BE|UTF-32-BE|UTF-32BE  ###  Unicode (UTF-32 Big-Endian)  ###  '+

  '20127  ###  ASCII|us-ascii  ###  US-ASCII  ###  '+
  '437  ###  IBM437  ###  OEM United States  ###  '+
  '500  ###  IBM500  ###  IBM EBCDIC (International)  ###  '+

  '1250  ###  windows-1250  ###  Central European (Windows)  ###  '+
  '852  ###  ibm852  ###  Central European (DOS)  ###  '+
  '28592  ###  iso-8859-2  ###  Central European (ISO)  ###  '+

  '1252  ###  Windows-1252  ###  Western European (Windows)  ###  '+
  '850  ###  ibm850  ###  Western European (DOS)  ###  '+
  '28591  ###  iso-8859-1  ###  Western European (ISO)  ###  '+

  '20924  ###  IBM00924  ###  IBM Latin-1  ###  '+
  '1047  ###  IBM01047  ###  IBM Latin-1  ###  '+
  '870  ###  IBM870  ###  IBM EBCDIC (Multilingual Latin-2)  ###  '+
  '28593  ###  iso-8859-3  ###  Latin 3 (ISO)  ###  '+
  '28605  ###  iso-8859-15  ###  Latin 9 (ISO)  ###  '+

  '1251  ###  windows-1251  ###  Cyrillic (Windows)  ###  '+
  '866  ###  cp866  ###  Cyrillic (DOS)  ###  '+
  '855  ###  IBM855  ###  OEM Cyrillic  ###  '+
  '858  ###  IBM00858  ###  OEM Multilingual Latin I  ###  '+
  '20866  ###  koi8-r  ###  Cyrillic (KOI8-R)  ###  '+
  '21866  ###  koi8-u  ###  Cyrillic (KOI8-U)  ###  '+
  '28595  ###  iso-8859-5  ###  Cyrillic (ISO)  ###  '+
  '21025  ###  cp1025  ###  IBM EBCDIC (Cyrillic Serbian-Bulgarian)  ###  '+

  '1253  ###  windows-1253  ###  Greek (Windows)  ###  '+
  '869  ###  ibm869  ###  Greek, Modern (DOS)  ###  '+
  '737  ###  ibm737  ###  Greek (DOS)  ###  '+
  '28597  ###  iso-8859-7  ###  Greek (ISO)  ###  '+
  '875  ###  cp875  ###  IBM EBCDIC (Greek Modern)  ###  '+

  '37  ###  IBM037  ###  IBM EBCDIC (US-Canada)  ###  '+
  '708  ###  ASMO-708  ###  Arabic (ASMO 708)  ###  '+
  '720  ###  DOS-720  ###  Arabic (DOS)  ###  '+
  '775  ###  ibm775  ###  Baltic (DOS)  ###  '+
  '857  ###  ibm857  ###  Turkish (DOS)  ###  '+
  '860  ###  IBM860  ###  Portuguese (DOS)  ###  '+
  '861  ###  ibm861  ###  Icelandic (DOS)  ###  '+
  '862  ###  DOS-862  ###  Hebrew (DOS)  ###  '+
  '863  ###  IBM863  ###  French Canadian (DOS)  ###  '+
  '864  ###  IBM864  ###  Arabic (864)  ###  '+
  '865  ###  IBM865  ###  Nordic (DOS)  ###  '+
  '874  ###  windows-874  ###  Thai (Windows)  ###  '+
  '932  ###  shift_jis  ###  Japanese (Shift-JIS)  ###  '+
  '936  ###  gb2312  ###  Chinese Simplified (GB2312)  ###  '+
  '949  ###  ks_c_5601-1987  ###  Korean  ###  '+
  '950  ###  big5  ###  Chinese Traditional (Big5)  ###  '+
  '1026  ###  IBM1026  ###  IBM EBCDIC (Turkish Latin-5)  ###  '+
  '1140  ###  IBM01140  ###  IBM EBCDIC (US-Canada-Euro)  ###  '+
  '1141  ###  IBM01141  ###  IBM EBCDIC (Germany-Euro)  ###  '+
  '1142  ###  IBM01142  ###  IBM EBCDIC (Denmark-Norway-Euro)  ###  '+
  '1143  ###  IBM01143  ###  IBM EBCDIC (Finland-Sweden-Euro)  ###  '+
  '1144  ###  IBM01144  ###  IBM EBCDIC (Italy-Euro)  ###  '+
  '1145  ###  IBM01145  ###  IBM EBCDIC (Spain-Euro)  ###  '+
  '1146  ###  IBM01146  ###  IBM EBCDIC (UK-Euro)  ###  '+
  '1147  ###  IBM01147  ###  IBM EBCDIC (France-Euro)  ###  '+
  '1148  ###  IBM01148  ###  IBM EBCDIC (International-Euro)  ###  '+
  '1149  ###  IBM01149  ###  IBM EBCDIC (Icelandic-Euro)  ###  '+
  '1254  ###  windows-1254  ###  Turkish (Windows)  ###  '+
  '1255  ###  windows-1255  ###  Hebrew (Windows)  ###  '+
  '1256  ###  windows-1256  ###  Arabic (Windows)  ###  '+
  '1257  ###  windows-1257  ###  Baltic (Windows)  ###  '+
  '1258  ###  windows-1258  ###  Vietnamese (Windows)  ###  '+
  '1361  ###  Johab  ###  Korean (Johab)  ###  '+
  '10000  ###  macintosh  ###  Western European (Mac)  ###  '+
  '10001  ###  x-mac-japanese  ###  Japanese (Mac)  ###  '+
  '10002  ###  x-mac-chinesetrad  ###  Chinese Traditional (Mac)  ###  '+
  '10003  ###  x-mac-korean  ###  Korean (Mac)  ###  '+
  '10004  ###  x-mac-arabic  ###  Arabic (Mac)  ###  '+
  '10005  ###  x-mac-hebrew  ###  Hebrew (Mac)  ###  '+
  '10006  ###  x-mac-greek  ###  Greek (Mac)  ###  '+
  '10007  ###  x-mac-cyrillic  ###  Cyrillic (Mac)  ###  '+
  '10008  ###  x-mac-chinesesimp  ###  Chinese Simplified (Mac)  ###  '+
  '10010  ###  x-mac-romanian  ###  Romanian (Mac)  ###  '+
  '10017  ###  x-mac-ukrainian  ###  Ukrainian (Mac)  ###  '+
  '10021  ###  x-mac-thai  ###  Thai (Mac)  ###  '+
  '10029  ###  x-mac-ce  ###  Central European (Mac)  ###  '+
  '10079  ###  x-mac-icelandic  ###  Icelandic (Mac)  ###  '+
  '10081  ###  x-mac-turkish  ###  Turkish (Mac)  ###  '+
  '10082  ###  x-mac-croatian  ###  Croatian (Mac)  ###  '+
  '20000  ###  x-Chinese-CNS  ###  Chinese Traditional (CNS)  ###  '+
  '20001  ###  x-cp20001  ###  TCA Taiwan  ###  '+
  '20002  ###  x-Chinese-Eten  ###  Chinese Traditional (Eten)  ###  '+
  '20003  ###  x-cp20003  ###  IBM5550 Taiwan  ###  '+
  '20004  ###  x-cp20004  ###  TeleText Taiwan  ###  '+
  '20005  ###  x-cp20005  ###  Wang Taiwan  ###  '+
  '20105  ###  x-IA5  ###  Western European (IA5)  ###  '+
  '20106  ###  x-IA5-German  ###  German (IA5)  ###  '+
  '20107  ###  x-IA5-Swedish  ###  Swedish (IA5)  ###  '+
  '20108  ###  x-IA5-Norwegian  ###  Norwegian (IA5)  ###  '+
  '20261  ###  x-cp20261  ###  T.61  ###  '+
  '20269  ###  x-cp20269  ###  ISO-6937  ###  '+
  '20273  ###  IBM273  ###  IBM EBCDIC (Germany)  ###  '+
  '20277  ###  IBM277  ###  IBM EBCDIC (Denmark-Norway)  ###  '+
  '20278  ###  IBM278  ###  IBM EBCDIC (Finland-Sweden)  ###  '+
  '20280  ###  IBM280  ###  IBM EBCDIC (Italy)  ###  '+
  '20284  ###  IBM284  ###  IBM EBCDIC (Spain)  ###  '+
  '20285  ###  IBM285  ###  IBM EBCDIC (UK)  ###  '+
  '20290  ###  IBM290  ###  IBM EBCDIC (Japanese katakana)  ###  '+
  '20297  ###  IBM297  ###  IBM EBCDIC (France)  ###  '+
  '20420  ###  IBM420  ###  IBM EBCDIC (Arabic)  ###  '+
  '20423  ###  IBM423  ###  IBM EBCDIC (Greek)  ###  '+
  '20424  ###  IBM424  ###  IBM EBCDIC (Hebrew)  ###  '+
  '20833  ###  x-EBCDIC-KoreanExtended  ###  IBM EBCDIC (Korean Extended)  ###  '+
  '20838  ###  IBM-Thai  ###  IBM EBCDIC (Thai)  ###  '+
  '20871  ###  IBM871  ###  IBM EBCDIC (Icelandic)  ###  '+
  '20880  ###  IBM880  ###  IBM EBCDIC (Cyrillic Russian)  ###  '+
  '20905  ###  IBM905  ###  IBM EBCDIC (Turkish)  ###  '+
  '20932  ###  EUC-JP  ###  Japanese (JIS 0208-1990 and 0212-1990)  ###  '+
  '20936  ###  x-cp20936  ###  Chinese Simplified (GB2312-80)  ###  '+
  '20949  ###  x-cp20949  ###  Korean Wansung  ###  '+
  '28594  ###  iso-8859-4  ###  Baltic (ISO)  ###  '+
  '28596  ###  iso-8859-6  ###  Arabic (ISO)  ###  '+
  '28598  ###  iso-8859-8  ###  Hebrew (ISO-Visual)  ###  '+
  '28599  ###  iso-8859-9  ###  Turkish (ISO)  ###  '+
  '28603  ###  iso-8859-13  ###  Estonian (ISO)  ###  '+
  '29001  ###  x-Europa  ###  Europa  ###  '+
  '38598  ###  iso-8859-8-i  ###  Hebrew (ISO-Logical)  ###  '+
  '50220  ###  iso-2022-jp  ###  Japanese (JIS)  ###  '+
  '50221  ###  csISO2022JP  ###  Japanese (JIS-Allow 1 byte Kana)  ###  '+
  '50222  ###  iso-2022-jp  ###  Japanese (JIS-Allow 1 byte Kana - SO/SI)  ###  '+
  '50225  ###  iso-2022-kr  ###  Korean (ISO)  ###  '+
  '50227  ###  x-cp50227  ###  Chinese Simplified (ISO-2022)  ###  '+
  '51932  ###  euc-jp  ###  Japanese (EUC)  ###  '+
  '51936  ###  EUC-CN  ###  Chinese Simplified (EUC)  ###  '+
  '51949  ###  euc-kr  ###  Korean (EUC)  ###  '+
  '52936  ###  hz-gb-2312  ###  Chinese Simplified (HZ)  ###  '+
  '54936  ###  GB18030  ###  Chinese Simplified (GB18030)  ###  '+
  '57002  ###  x-iscii-de  ###  ISCII Devanagari  ###  '+
  '57003  ###  x-iscii-be  ###  ISCII Bengali  ###  '+
  '57004  ###  x-iscii-ta  ###  ISCII Tamil  ###  '+
  '57005  ###  x-iscii-te  ###  ISCII Telugu  ###  '+
  '57006  ###  x-iscii-as  ###  ISCII Assamese  ###  '+
  '57007  ###  x-iscii-or  ###  ISCII Oriya  ###  '+
  '57008  ###  x-iscii-ka  ###  ISCII Kannada  ###  '+
  '57009  ###  x-iscii-ma  ###  ISCII Malayalam  ###  '+
  '57010  ###  x-iscii-gu  ###  ISCII Gujarati  ###  '+
  '57011  ###  x-iscii-pa  ###  ISCII Punjabi  ###  ';

  InitDescrs;
  EncDescrsCount := Length(EncodingDescrs);

  SetLength(Preamble_UTF8, 3);
  Preamble_UTF8[0] := $EF;
  Preamble_UTF8[1] := $BB;
  Preamble_UTF8[2] := $BF;

  SetLength(Preamble_UTF16LE, 2);
  Preamble_UTF16LE[0] := $FF;
  Preamble_UTF16LE[1] := $FE;

  SetLength(Preamble_UTF16BE, 2);
  Preamble_UTF16BE[0] := $FE;
  Preamble_UTF16BE[1] := $FF;

  SetLength(Preamble_UTF32LE, 4);
  Preamble_UTF32LE[0] := $FF;
  Preamble_UTF32LE[1] := $FE;
  Preamble_UTF32LE[2] := $0;
  Preamble_UTF32LE[3] := $0;

  SetLength(Preamble_UTF32BE, 4);
  Preamble_UTF32BE[0] := $0;
  Preamble_UTF32BE[1] := $0;
  Preamble_UTF32BE[2] := $FE;
  Preamble_UTF32BE[3] := $FF;
end.
