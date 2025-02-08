unit LMDUnicodeStrings;
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

LMDUnicodeStrings unit ()
-------------------------

Changes
-------
Release 2010 (August 2009)
[+] Added option to save TLMDWideStrings as UTF16, UTF8, UTF7

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Consts, RTLConsts;

{$IFDEF LMD_NATIVEUNICODE}

type
  {$HPPEMIT 'typedef Classes::TStrings TLMDWideStrings;'}
  {$EXTERNALSYM TLMDWideStrings}
  TLMDWideStrings    = TStrings;
  {$HPPEMIT 'typedef Classes::TStringList TLMDWideStringList;'}
  {$EXTERNALSYM TLMDWideStringList}
  TLMDWideStringList = TStringList;

{$ELSE}

type
  TLMDStringsUnicodeFormat = (sufUTF16BE, sufUTF16LE, sufUTF8, sufUTF7);

  TLMDWideStrings = class;

  {$ifdef LMDCOMP9}
  TLMDWideStringEnumerator = class
  private
    FIndex: Integer;
    FStrings: TLMDWideStrings;
  public
    constructor Create(AStrings: TLMDWideStrings);
    function GetCurrent: string; inline;
    function MoveNext: Boolean;
    property Current: string read GetCurrent;
  end;
  {$endif}

  TLMDWideStrings = class(TPersistent)
  private
    FUpdateCount: Integer;
    FSaveUnicode: Boolean;
    FStoreBOM: Boolean;
    FSaved : boolean;
    FLineBreak: WideString;
    FUnicodeFormat: TLMDStringsUnicodeFormat;

    function GetCommaText: WideString;
    function GetName(Index: Integer): WideString;
    function GetValue(const Name: WideString): WideString;
    procedure SetCommaText(Value: WideString);
    procedure SetValue(const Name, Value: WideString);
    procedure StrSwapByteOrder(Str: PWideChar);
  protected
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
    procedure DefineProperties(Filer: TFiler); override;
    procedure Error(const Msg: string; Data: Integer); overload;
    function Get(Index: Integer): WideString; virtual; abstract;
    function GetCapacity: Integer; virtual;
    function GetCount: Integer; virtual; abstract;
    function GetObject(Index: Integer): TObject; virtual;
    function GetTextStr: WideString; virtual;
    procedure Put(Index: Integer; const S: WideString); virtual;
    procedure PutObject(Index: Integer; AObject: TObject); virtual;
    procedure SetCapacity(NewCapacity: Integer); virtual;
    procedure SetTextStr(const Value: WideString); virtual;
    procedure SetUpdateState(Updating: Boolean); virtual;
    function CompareStrings(const S1, S2: WideString): Integer; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const S: WideString): Integer; virtual;
    function AddObject(const S: WideString; AObject: TObject): Integer; virtual;
    procedure AddStrings(Strings: TLMDWideStrings); virtual;
    procedure Append(const S: WideString);
    procedure AssignTo(Dest: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure Clear; virtual; abstract;
    procedure Delete(Index: Integer); virtual; abstract;
    procedure EndUpdate;
    {$ifdef LMDCOMP9}
    function GetEnumerator: TLMDWideStringEnumerator;
    {$endif}
    function Equals(Strings: TLMDWideStrings): Boolean; {$ifdef LMDCOMP12}reintroduce;{$endif}
    procedure Exchange(Index1, Index2: Integer); virtual;
    function GetText: PWideChar; virtual;
    function IndexOf(const S: WideString): Integer; virtual;
    function IndexOfName(const Name: WideString): Integer; virtual;
    function IndexOfObject(AObject: TObject): Integer;
    procedure Insert(Index: Integer; const S: WideString); virtual; abstract;
    procedure InsertObject(Index: Integer; const S: WideString; AObject: TObject);
    procedure LoadFromFile(const FileName: WideString); virtual;
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure Move(CurIndex, NewIndex: Integer); virtual;
    procedure SaveToFile(const FileName: WideString); virtual;
    procedure SaveToStream(Stream: TStream); virtual;
    procedure SetText(Text: PWideChar); virtual;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property CommaText: WideString read GetCommaText write SetCommaText;
    property Count: Integer read GetCount;
    property Names[Index: Integer]: WideString read GetName;
    property Objects[Index: Integer]: TObject read GetObject write PutObject;
    property SaveUnicode: Boolean read FSaveUnicode write FSaveUnicode;
    property UnicodeFormat: TLMDStringsUnicodeFormat read FUnicodeFormat write FUnicodeFormat default sufUTF16LE;
    property StoreBOM: Boolean read FStoreBOM write FStoreBOM;
    property Strings[Index: Integer]: WideString read Get write Put; default;
    property Text: WideString read GetTextStr write SetTextStr;
    property Values[const Name: WideString]: WideString read GetValue write  SetValue;
    property LineBreak: WideString read FLineBreak write FLineBreak;
  end;

  TLMDWideStringList = class;

  PWideStringItem = ^TWideStringItem;
  TWideStringItem = record
    FString: WideString;
    FObject: TObject;
  end;

  PWideStringItemList = ^TWideStringItemList;
  TWideStringItemList = array[0..MaxListSize] of TWideStringItem;
  TLMDWideStringListSortCompare = function(List: TLMDWideStringList;
                                           Index1, Index2: Integer): Integer;

  TLMDWideStringList = class(TLMDWideStrings)
  private
    FDuplicates: TDuplicates;
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    FSorted: Boolean;
    FCapacity: Integer;
    FCount: Integer;
    FCaseSensitive: Boolean;
    FList: PWideStringItemList;
    FDelimiter: Char;
    FStrictDelimiter: boolean;
    FQuoteChar: Char;

    procedure ExchangeItems(Index1, Index2: Integer);
    procedure Grow;
    procedure QuickSort(L, R: Integer; SCompare: TLMDWideStringListSortCompare);
    function GetDelimiter: Char;
    function GetStrictDelimiter: boolean;
    procedure SetDelimiter(const Value: Char);
    procedure SetStrictDelimiter(const Value: boolean);
    function GetDelimitedText: string;
    procedure SetDelimitedText(const Value: string);
    function GetQuoteChar: Char;
    procedure SetQuoteChar(const Value: Char);
  protected
    procedure SetSorted(Value: Boolean); virtual;
    procedure Changed; virtual;
    procedure Changing; virtual;
    function Get(Index: Integer): WideString; override;
    function GetCapacity: Integer; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure InsertItem(Index: Integer; const S: WideString; AObject: TObject); virtual;
    procedure Put(Index: Integer; const S: WideString); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetCapacity(NewCapacity: Integer); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetCaseSensitive(Value: Boolean); virtual;
    function CompareStrings(const S1, S2: WideString): Integer; override;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const S: WideString): Integer; override;
    procedure Clear; override;
    procedure CustomSort(Compare: TLMDWideStringListSortCompare); virtual;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    function Find(const S: WideString; var Index: Integer): Boolean; virtual;
    function IndexOf(const S: WideString): Integer; override;
    procedure Insert(Index: Integer; const S: WideString); override;
    procedure Sort; virtual;
    property CaseSensitive: Boolean read FCaseSensitive write SetCaseSensitive default True;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
    property Sorted: Boolean read FSorted write SetSorted;
    property Delimiter: Char read GetDelimiter write SetDelimiter;
    property DelimitedText: string read GetDelimitedText write SetDelimitedText;
    property StrictDelimiter: boolean read GetStrictDelimiter write SetStrictDelimiter;
    property QuoteChar: Char read GetQuoteChar write SetQuoteChar;
  end;

{$ENDIF} // ELSE NATIVEUNICODE

  TLMDWideStringArrayStr = {$IFDEF LMD_NATIVEUNICODE}string{$ELSE}WideString{$ENDIF};
  TLMDWideStringArray = class(TLMDWideStrings)
  private
    FStoreAssociatedData : Boolean;
    FDuplicates : TDuplicates;
    FSorted : Boolean;
    FOnChanging : TNotifyEvent;
    FOnChange : TNotifyEvent;
    FArray : TObject;
    FUpdateCount : integer;
    procedure OnItemDelete(Sender : TObject; Item : Pointer);
    procedure SetSorted(newValue : Boolean);
    procedure ExchangeItems(Index1, Index2: Integer);
  protected
    procedure QuickSort(L, R: Integer); virtual;
    procedure Changed; virtual;
    procedure Changing; virtual;
    procedure TriggerChangingEvent; virtual;
    procedure TriggerChangeEvent; virtual;
    procedure InsertItem(Index: Integer; const S: TLMDWideStringArrayStr); virtual;
    function Get(Index: Integer): TLMDWideStringArrayStr; override;
    function GetCount: Integer; override;
    function  GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: TLMDWideStringArrayStr); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure PutStringEntry(Index: Integer; const S : TLMDWideStringArrayStr; AObject: TObject); virtual;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    procedure Clear; override;

    function Add(const S: TLMDWideStringArrayStr): Integer; override;
    function AddStringEntry(const S: TLMDWideStringArrayStr; AObject: TObject): Integer; virtual;

    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: TLMDWideStringArrayStr); override;
    function IndexOf(const S: TLMDWideStringArrayStr): Integer; override;
    function Find(const S: TLMDWideStringArrayStr; var Index: Integer): Boolean; virtual;
    procedure Sort; virtual;
    procedure Exchange(Index1, Index2: Integer); override;

    procedure SaveToBinaryStream(Stream: TStream); virtual;
    procedure LoadFromBinaryStream(Stream: TStream); virtual;

    constructor Create;
    destructor Destroy; override;

    property Duplicates : TDuplicates read FDuplicates write FDuplicates;
    property Sorted : Boolean read FSorted write SetSorted;
  published
    property OnChanging : TNotifyEvent read FOnChanging write FOnChanging;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property StoreAssociatedData : Boolean read FStoreAssociatedData write FStoreAssociatedData;
  end;

implementation

uses
  LMDTypes, LMDFiles, LMDArray, LMDUnicode, LMDProcs, LMDStrings;

type
  PElWideStringItem = ^TLMDWideStringItem;
  TLMDWideStringItem = record
    FString: PWideChar;
    FObject: TObject;
  end;

{$IFNDEF LMD_NATIVEUNICODE}
function NextChar(P: PChar): PChar;
begin
  Result := P;
  if (Result <> nil) then
    while (Result^ <> #0) do
      Inc(Result);
end;


function TLMDWideStrings.CompareStrings(const S1, S2: WideString): Integer;
begin
  Result := LMDWideCompareStr(S1, S2);
end;

constructor TLMDWideStrings.Create;
begin
  inherited Create;
  FUnicodeFormat := sufUTF16LE;
  case DefaultTextLineBreakStyle of
    tlbsLF:   FLineBreak := #10;
    tlbsCRLF: FLineBreak := #13+#10;
  else
    Assert(false);
  end;
end;

destructor TLMDWideStrings.Destroy;
begin
  inherited Destroy;
end;

function TLMDWideStrings.Add(const S: WideString): Integer;
begin
  Result := GetCount;
  Insert(Result, S);
end;

function TLMDWideStrings.AddObject(const S: WideString; AObject: TObject):
    Integer;
begin
  Result := Add(S);
  if Result >=0 then
    PutObject(Result, AObject);
end;

procedure TLMDWideStrings.AddStrings(Strings: TLMDWideStrings);
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Strings.Count - 1 do
      AddObject(Strings[I], Strings.Objects[I]);
  finally
    EndUpdate;
  end;
end;

procedure TLMDWideStrings.Append(const S: WideString);
begin
  Add(S);
end;

procedure TLMDWideStrings.Assign(Source: TPersistent);
var i : integer;
begin
  if Source is TLMDWideStrings then
  begin
    BeginUpdate;
    try
      Clear;
      AddStrings(TLMDWideStrings(Source));
    finally
      EndUpdate;
    end;
    Exit;
  end
  else
  if Source is TStrings then
  begin
    BeginUpdate;
    try
      Clear;

      for i := 0 to TStrings(Source).Count - 1 do
        AddObject(TStrings(Source)[i], TStrings(Source).Objects[i]);
    finally
      EndUpdate;
    end;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TLMDWideStrings.BeginUpdate;
begin
  if FUpdateCount = 0 then
    SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TLMDWideStrings.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then
    begin
      Result := True;
      if Filer.Ancestor is TStrings then
        Result := not Equals(TLMDWideStrings(Filer.Ancestor))
    end
    else Result := Count > 0;
  end;

begin
  inherited;
  Filer.DefineProperty('Strings', ReadData, WriteData, DoWrite);
end;

procedure TLMDWideStrings.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    SetUpdateState(False);
end;

{$ifdef LMDCOMP9}
function TLMDWideStrings.GetEnumerator: TLMDWideStringEnumerator;
begin
  Result := TLMDWideStringEnumerator.Create(Self);
end;
{$endif}

function TLMDWideStrings.Equals(Strings: TLMDWideStrings): Boolean;
var
  I, LCount: Integer;
begin
  Result := False;
  LCount := GetCount;
  if LCount <> Strings.GetCount then
    exit;
  for I := 0 to LCount - 1 do
    if Get(I) <> Strings.Get(I) then
      exit;
  Result := True;
end;

procedure TLMDWideStrings.Error(const Msg: string; Data: Integer);

  function ReturnAddr: Pointer;
  asm
          MOV     EAX,[EBP+4]
  end;

begin
  raise EStringListError.CreateFmt(Msg, [Data])  at ReturnAddr ;
end;

procedure TLMDWideStrings.Exchange(Index1, Index2: Integer);
var
  TempObject: TObject;
  TempString: WideString;
begin
  BeginUpdate;
  try
    TempString := Strings[Index1];
    TempObject := Objects[Index1];
    Strings[Index1] := Strings[Index2];
    Objects[Index1] := Objects[Index2];
    Strings[Index2] := TempString;
    Objects[Index2] := TempObject;
  finally
    EndUpdate;
  end;
end;

function TLMDWideStrings.GetCapacity: Integer;
begin  // descendants may optionally override/replace this default implementation
  Result := Count;
end;

function TLMDWideStrings.GetCommaText: WideString;
var
  S: WideString;
  P: PWideChar;
  I, LCount: Integer;
begin
  LCount := GetCount;
  if (LCount = 1) and (Get(0) = '') then
    Result := '""'
  else
  begin
    Result := '';
    for I := 0 to LCount - 1 do
    begin
      S := Get(I);
      P := PWideChar(S);
        {$IFDEF LMDCOMP12}
        while not CharInSet(P^, [#0..' ', '"', ',']) do
        {$ELSE}
        while not (P^ in [WideChar(#0)..WideChar(' '), WideChar('"'), WideChar(',')]) do
        {$ENDIF}
          Inc(P);
        if (P^ <> WideChar(#0)) then
          S := LMDWideQuotedStr(S, '"');
      Result := Result + S + ',';
    end;
    System.Delete(Result, Length(Result), 1);
    end;
end;

function TLMDWideStrings.GetName(Index: Integer): WideString;
var
  P: PWideChar;
  begin
  Result := Get(Index);
  P := LMDWideStrScan(PWideChar(Result), '=');
  if Assigned(P) then
    SetLength(Result, P - PWideChar(Result))
  else
    SetLength(Result, 0);
end;

function TLMDWideStrings.IndexOfName(const Name: WideString): Integer;
var
  P: Integer;
  I: Integer;
  S: WideString;
begin
  for I := 0 to GetCount - 1 do
  begin
    S := Get(I);
    P := Pos('=', S);
    if (P <> 0) and (CompareStrings(Copy(S, 1, P - 1), Name) = 0) then
    begin
      Result := I;
      exit;
    end;
  end;
  Result := -1;
end;

function TLMDWideStrings.GetObject(Index: Integer): TObject;
begin
  Result := nil;
end;

function TLMDWideStrings.GetText: PWideChar;

var S : WideString;
    l : integer;

begin
  S := GetTextStr;
  l := (Length(S) + 1) * sizeof(WideChar);
  GetMem(Result, l);
  System.Move(S[1], Result[1], l);
end;

function TLMDWideStrings.GetTextStr: WideString;
var
  I, J, L, Size, LCount: Integer;
  P: PWideChar;
  S: WideString;
begin
  LCount := GetCount;
  Size := 0;

  for I := 0 to LCount - 1 do
  begin
    if I<>LCount-1 then
      Inc(Size, Length(Get(I)) + Length(FLineBreak))
    else
      Inc(Size, Length(Get(I)));
  end;

  SetLength(Result, Size);

  P := PWideChar(Result);
  for I := 0 to LCount - 1 do
  begin
    S := Get(I);
    L := Length(S);
    if L <> 0 then
    begin
      LMDWideMove(S[1], P^, L);
      Inc(P, L);
    end;

    if I<>LCount-1 then
    begin
      for J := 1 to Length(FLineBreak) do
      begin
        P^ := FLineBreak[J];
        Inc(P);
      end;
    end;
  end;
end;

function TLMDWideStrings.GetValue(const Name: WideString): WideString;
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if I >= 0 then
    Result := Copy(Get(I), Length(Name) + 2, MaxInt shr 1)
  else
    Result := '';
end;

function TLMDWideStrings.IndexOf(const S: WideString): Integer;
begin
  for Result := 0 to GetCount - 1 do
    if CompareStrings(Get(Result), S) = 0 then
      Exit;
  Result := -1;
end;

function TLMDWideStrings.IndexOfObject(AObject: TObject): Integer;
begin
  for Result := 0 to GetCount - 1 do
    if GetObject(Result) = AObject then Exit;
  Result := -1;
end;

procedure TLMDWideStrings.InsertObject(Index: Integer; const S: WideString; AObject: TObject);
begin
  Insert(Index, S);
  PutObject(Index, AObject);
end;

procedure TLMDWideStrings.LoadFromFile(const FileName: WideString);
var
  Stream: TStream;
begin
  Stream := TLMDFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TLMDWideStrings.StrSwapByteOrder(Str: PWideChar);
// exchanges in each character of the given string the low order and high order
// byte to go from LSB to MSB and vice versa.
// EDX contains address of string

asm
         PUSHF
         PUSH ESI
         PUSH EDI
         MOV ESI, EDX
         MOV EDI, ESI
         XOR EAX, EAX  // clear high order byte to be able to use 32bit operand below
         CLD
@@1:     LODSW
         OR EAX, EAX
         JZ @@2
         XCHG AL, AH
         STOSW
         JMP @@1

@@2:     POP EDI
         POP ESI
         POPF
end;

procedure TLMDWideStrings.LoadFromStream(Stream: TStream);
var
  Size: Integer;
  WS: WideString;
  S : AnsiString;
  LBomLen: Integer;
  LBom: TLMDBOM;
begin
  BeginUpdate;
  try
    Clear;

    Size := Stream.Size - Stream.Position;

    if Size < 0 then
      raise Exception.Create('Invalid string header read from the stream');
    if Size = 0 then
      exit;

    // Trying to read BOM mark
    LBom := LMDReadBOMEx(Stream, LBomLen);
    if not (LBom in [bomNone, bomUTF7]) then
      dec(Size, LBomLen);

    if SaveUnicode then
    begin
      // If bom not found - force to use uset defined format
      if LBom = bomNone then
        LBom := TLMDBom(Ord(FUnicodeFormat) + 3);

      if (LBom = bomUTF16BE) or (LBom = bomUTF16LE) then
      begin
        SetLength(WS, Size div 2);
        Stream.Read(PWideChar(WS)^, Size);
        if LBom = bomUTF16BE then
          StrSwapByteOrder(PWideChar(WS));
        SetTextStr(WS);
      end;
      if (LBom = bomUTF8) then
      begin
        SetString(S, nil, Size);
        Stream.Read(Pointer(S)^, Size);
        SetTextStr(LMDConvertUTF8String(S));
      end;
      if (LBom = bomUTF7) then
      begin
        SetString(S, nil, Size);
        Stream.Read(Pointer(S)^, Size);
        SetTextStr(LMDConvertUTF7ToUTF16(S));
      end;
    end
    else
    begin
      SetString(S, nil, Size);
      Stream.Read(Pointer(S)^, Size);
      SetTextStr(WideString(S));
    end;
  finally
    EndUpdate;
  end;
end;

procedure TLMDWideStrings.Move(CurIndex, NewIndex: Integer);
var
  TempObject: TObject;
  TempString: WideString;
begin
  if CurIndex <> NewIndex then
  begin
    BeginUpdate;
    try
      TempString := Get(CurIndex);
      TempObject := GetObject(CurIndex);
      {vAd: ??? need memory optimize.}
      {Possible only in descendants with overloaded method }
      Delete(CurIndex);
      InsertObject(NewIndex, TempString, TempObject);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TLMDWideStrings.Put(Index: Integer; const S: WideString);
var
  TempObject: TObject;
begin
  TempObject := GetObject(Index);
  Delete(Index);
  InsertObject(Index, S, TempObject);
end;

procedure TLMDWideStrings.PutObject(Index: Integer; AObject: TObject);
begin
end;

procedure TLMDWideStrings.ReadData(Reader: TReader);
var i : integer;
    P : PWideChar;
     C : PAnsiChar;
    {$ifdef LMD_UNICODE}
    s : AnsiString;
    {$endif}
    rv: TValueType;
    {$ifdef LMD_UNICODE}
    ws : WideString;
    {$endif}
begin
  Reader.ReadListBegin;
  BeginUpdate;
  try
    Clear;
    while not Reader.EndOfList do
    begin
      rv := Reader.ReadValue;
      if not (Integer(rv) in [ Integer(vaString), Integer(vaLString),
                      18{vaWString},
                      20{vaUTF8String}]
      ) then
        raise EReadError.Create('Error while reading LMDWide strings list');
      if (rv = vaWString) then
      begin
        Reader.Read(i, SizeOf(Integer));
        if i=0 then
        begin
          Add('');
          Continue;
        end;
        GetMem(P, (i + 1) * sizeof(WideChar));
          Reader.Read(P^, (i) * sizeof(WideChar));
          P[i] := #0;
          Add(LMDWideStrPas(P));
          FreeMem(P);
        end
      else
      {$ifdef LMD_UNICODE}
      if (rv = TValueType(20) ){vaUTF8String} then
      begin
        Reader.Read(i, SizeOf(Integer));
        if i=0 then
        begin
          Add('');
          Continue;
        end;
        GetMem(C, i + 1);
          Reader.Read(C^, i);
          C[i] := #0;
          S := StrPas(C);
          LMDConvertUTF8ToUTF16(S, WS, strictConversion, false);
          FreeMem(C);
        Add(WS);
      end
      else
      {$endif}
      begin
        i := 0;
        if rv = vaLString then
          Reader.Read(i, SizeOf(Integer))
        else
          Reader.Read(i, SizeOf(Byte));
        GetMem(C, i + 1);
          Reader.Read(C^, i);
          C[i] := #0;
          Add(WideString(StrPas(C)));
          FreeMem(C);
        end;
    end;
  finally
    EndUpdate;
  end;
  Reader.ReadListEnd;
end;

procedure TLMDWideStrings.SaveToFile(const FileName: WideString);
var
  Stream: TStream;
  FOldStoreBOM: Boolean;
begin
  // Always save to file with BOM
  FOldStoreBOM := FStoreBOM;
  FStoreBOM := True;
  Stream := TLMDFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
    FStoreBOM := FOldStoreBOM;
  end;
end;

procedure TLMDWideStrings.SaveToStream(Stream: TStream);
var
  SA: AnsiString;
  SW, BOM: WideString;
//  Allowed: Boolean;
//  Run: PWideChar;
begin
  // The application can decide in which format to save the content.
  // If FSaveUnicode is False then all strings are saved in standard ANSI format
  // which is also loadable by TStrings but you should be aware that all Unicode
  // strings are then converted to ANSI based on the current system locale.
  // An extra event is supplied to ask the user about the potential loss of information
  // when converting Unicode to ANSI strings.
  SW := GetTextStr;
  FSaved := False; // be pessimistic

//  if Allowed then
  begin
    // only save if allowed
    if FSaveUnicode then
    begin
      if StoreBOM then
      begin
        case FUnicodeFormat of
          sufUTF16LE: LMDWriteBOM(Stream, bomUTF16LE);
          sufUTF16BE: LMDWriteBOM(Stream, bomUTF16BE);
        end;
      end
      else
        BOM := '';

      case FUnicodeFormat of
        sufUTF7:
        begin
          SA := LMDConvertUTF16ToUTF7(SW, false, StoreBOM);
          // SW has already been filled
          if Length(SA)>0 then
            Stream.WriteBuffer(PAnsiChar(SA)^, Length(SA));
        end;
        sufUTF8:
        begin
          LMDConvertUTF16ToUTF8(SW, SA, strictConversion, StoreBOM);
          // SA has already been filled
          if Length(SA)>0 then
            Stream.WriteBuffer(PAnsiChar(SA)^, Length(SA));
        end;
        sufUTF16LE, sufUTF16BE:
        begin
          // SW has already been filled
          if UnicodeFormat = sufUTF16BE then
            StrSwapByteOrder(PWideChar(SW));
          if Length(SW)>0 then
            Stream.WriteBuffer(PWideChar(SW)^, 2 * Length(SW));
        end;
      end;
      end
    else
    if Length (SW)>0 then
    begin
      // implicit conversion to ANSI
      SA := AnsiString(SW);
      Stream.WriteBuffer(PAnsiChar(SA)^, Length(SA));
      end;
    FSaved := True;
  end;
end;

procedure TLMDWideStrings.SetCapacity(NewCapacity: Integer);
begin
  // do nothing - descendants may optionally implement this method
end;

procedure TLMDWideStrings.SetCommaText(Value: WideString);
  var
   P, P1: PWideChar;
   S: WideString;
  begin
  BeginUpdate;
  try
    Clear;
    if Length(Value)=0 then
      exit;
    P := PWideChar(Value);
      {$IFDEF LMDCOMP12}
      while not CharInSet(P^, [#1..' ']) do
      {$ELSE}
      while P^ in [Widechar(#1)..Widechar(' ')] do
      {$ENDIF}
        inc(P);
      while P^ <> #0 do
      begin
        if P^ = '"' then
          S := LMDWideExtractQuotedStr(P, '"')
        else
        begin
          P1 := P;
          while (P^ > ' ') and (P^ <> ',') do Inc(P);
          SetString(S, P1, P - P1);
        end;
        Add(S);
        {$IFDEF LMDCOMP12}
        while not CharInSet(P^, [#1..' ']) do
        {$ELSE}
        while P^ in [Widechar(#1)..Widechar(' ')] do
        {$ENDIF}
          Inc(P);
        if P^ = ',' then
          repeat
            Inc(P);
          until {$IFDEF LMDCOMP12}not CharInSet(P^, [#1..' ']);{$ELSE}
                                  not (Char(P^) in [#1..' ']); {$ENDIF}
      end;
    finally
    EndUpdate;
  end;
end;

procedure TLMDWideStrings.SetText(Text: PWideChar);
begin
  SetTextStr(Text);
end;

procedure TLMDWideStrings.SetTextStr(const Value: WideString);
var
  P, Start: PWideChar;
  S: WideString;
begin
  BeginUpdate;
  try
    Clear;
    if Length(Value)=0 then
      exit;
    P := PWideChar(Value);
    if P <> nil then
    begin
      while P^ <> #0 do
      begin
        Start := P;
        while not ((P^ = #0) or (P^ = #13) or (P^ = #10)) do
          Inc(P);
        LMDWideSetString(S, Start, P - Start);
        Add(S);
        if P^ = #13 then Inc(P);
        if P^ = #10 then Inc(P);
      end;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TLMDWideStrings.SetUpdateState(Updating: Boolean);
begin
end;

procedure TLMDWideStrings.SetValue(const Name, Value: WideString);
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if Value <> '' then
  begin
    if I < 0 then I := Add('');
    Put(I, Name + '=' + Value);
  end else
  begin
    if I >= 0 then Delete(I);
  end;
end;

procedure TLMDWideStrings.WriteData(Writer: TWriter);
var
  I,
  L : Integer;
  J : TValueType;
  W : WideString;
begin
  Writer.WriteListBegin;
  for I := 0 to Count - 1 do
  begin
    J := TValueType(18);//vaWString;
    Writer.Write(J, sizeof(TValueType));
    W := Get(I);
    L := Length(W);
    Writer.Write(L, sizeof(L));
    Writer.Write(W[1], Length(W) * sizeof(WideChar));
    end;
  Writer.WriteListEnd;
end;

procedure TLMDWideStrings.AssignTo(Dest: TPersistent);
var
  i : integer;
  OldLineBreak: WideString;
begin
  if Dest is TLMDWideStrings then
  begin
    Dest.Assign(Self)
  end
  else
  if Dest is TStrings then
  begin
    OldLineBreak := FLineBreak;
    case DefaultTextLineBreakStyle of
      tlbsLF:   FLineBreak := #10;
      tlbsCRLF: FLineBreak := #13+#10;
    else
      Assert(false);
    end;
    TStrings(Dest).BeginUpdate;
    try
      TStrings(Dest).Text := Text;
      for i := 0 to Count - 1 do
      begin
        if TStrings(Dest).Count < Count then
          TStrings(Dest).Add('');
        TStrings(Dest).Objects[i] := Objects[i];
      end;
    finally
      TStrings(Dest).EndUpdate;
      FLineBreak := OldLineBreak;
    end;
    exit;
  end
  else
    inherited;
end;

constructor TLMDWideStringList.Create;
begin
  inherited;
  FStoreBOM := true;
  FCaseSensitive := False;
end;

destructor TLMDWideStringList.Destroy;
begin
  FOnChange := nil;
  FOnChanging := nil;
  inherited Destroy;
  if FCount <> 0 then
    Finalize(FList^[0], FCount);
    FCount := 0;
  SetCapacity(0);
end;

function TLMDWideStringList.Add(const S: WideString): Integer;
begin
  if not Sorted then
    Result := FCount
  else
    if Find(S, Result) then
      case Duplicates of
        dupIgnore:
        begin
          Result := -2; // Error code for dups
          Exit;
        end;
        dupError: Error(SDuplicateString, 0);
      end;
  InsertItem(Result, S, nil);
end;

procedure TLMDWideStringList.Changed;
begin
  if (FUpdateCount = 0) and Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TLMDWideStringList.Changing;
begin
  if (FUpdateCount = 0) and Assigned(FOnChanging) then
    FOnChanging(Self);
end;

procedure TLMDWideStringList.Clear;
begin
  if FCount <> 0 then
  begin
    Changing;
    Finalize(FList^[0], FCount);
    FCount := 0;
    SetCapacity(0);
    Changed;
  end;
end;

function TLMDWideStringList.CompareStrings(const S1, S2: WideString): Integer;
begin
  if CaseSensitive then
    Result := LMDWideCompareText(S1, S2)
  else
    Result := LMDWideCompareStr(LMDUnicodeUpper(S1), LMDUnicodeUpper(S2));
end;

procedure TLMDWideStringList.CustomSort(Compare: TLMDWideStringListSortCompare);
begin
  if not Sorted and (FCount > 1) then
  begin
    Changing;
    QuickSort(0, FCount - 1, Compare);
    Changed;
  end;
end;

procedure TLMDWideStringList.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  Changing;
  Finalize(FList^[Index]);
  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index],
        (FCount - Index) * SizeOf(TStringItem));
    Changed;
end;

procedure TLMDWideStringList.Exchange(Index1, Index2: Integer);
begin
  if (Index1 < 0) or (Index1 >= FCount) then Error(SListIndexError, Index1);
  if (Index2 < 0) or (Index2 >= FCount) then Error(SListIndexError, Index2);
  Changing;
  ExchangeItems(Index1, Index2);
  Changed;
end;

procedure TLMDWideStringList.ExchangeItems(Index1, Index2: Integer);
var
  Temp: TLMDPtrInt;
  Item1, Item2: PWideStringItem;
begin
  Item1 := @FList^[Index1];
  Item2 := @FList^[Index2];
  Temp := TLMDPtrInt(Item1^.FString);
  TLMDPtrInt(Item1^.FString) := TLMDPtrInt(Item2^.FString);
  TLMDPtrInt(Item2^.FString) := Temp;
  Temp := TLMDPtrInt(Item1^.FObject);
  TLMDPtrInt(Item1^.FObject) := TLMDPtrInt(Item2^.FObject);
  TLMDPtrInt(Item2^.FObject) := Temp;
end;

function TLMDWideStringList.Find(const S: WideString; var Index: Integer):Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := LMDWideCompareText(FList[I].FString, S);
    if C < 0 then
      L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

function TLMDWideStringList.Get(Index: Integer): WideString;
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  Result := FList[Index].FString;
end;

function TLMDWideStringList.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

function TLMDWideStringList.GetCount: Integer;
begin
  Result := FCount;
end;

function TLMDWideStringList.GetDelimitedText: string;
var
  S: string;
  P: PChar;
  I, Count: Integer;
  LDelimiters: TSysCharSet;
begin
  Count := GetCount;
  if (Count = 1) and (Get(0) = '') then
    Result := QuoteChar + QuoteChar
  else
  begin
    Result := '';
    LDelimiters := [AnsiChar(#0), AnsiChar(QuoteChar), AnsiChar(Delimiter)];
    if not StrictDelimiter then
      LDelimiters := LDelimiters + [AnsiChar(#1)..AnsiChar(' ')];
    for I := 0 to Count - 1 do
    begin
      S := Get(I);
      P := PChar(S);
      while not (P^ in LDelimiters) do
        P := NextChar(P);
      if (P^ <> #0) then S := AnsiQuotedStr(S, QuoteChar);
      Result := Result + S + Delimiter;
    end;
    System.Delete(Result, Length(Result), 1);
  end;
end;

function TLMDWideStringList.GetDelimiter: Char;
begin
  result := FDelimiter;
end;

function TLMDWideStringList.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  Result := FList[Index].FObject;
end;

function TLMDWideStringList.GetQuoteChar: Char;
begin
  result := FQuoteChar;
end;

function TLMDWideStringList.GetStrictDelimiter: boolean;
begin
  result := FStrictDelimiter;
end;

procedure TLMDWideStringList.Grow;
 var Delta: Integer;
begin
  if FCapacity > 64 then Delta := FCapacity div 4 else
    if FCapacity > 8 then Delta := 16 else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

function TLMDWideStringList.IndexOf(const S: WideString): Integer;
begin
  if not Sorted then
    Result := inherited IndexOf(S)
  else
  if not Find(S, Result) then
    Result := -1;
end;

procedure TLMDWideStringList.Insert(Index: Integer; const S: WideString);
begin
  if Sorted then Error(SSortedListError, 0);
  if (Index < 0) or (Index > FCount) then
    Error(SListIndexError, Index);
  InsertItem(Index, S, nil);
end;

procedure TLMDWideStringList.InsertItem(Index: Integer; const S: WideString; AObject: TObject);
begin
  Changing;
  if FCount = FCapacity then
    Grow;
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1],
        (FCount - Index) * SizeOf(TStringItem));
    with FList[Index] do
  begin
    Pointer(FString) := nil;
    FObject := AObject;
    FString := S;
  end;
  Inc(FCount);
  Changed;
end;

procedure TLMDWideStringList.Put(Index: Integer; const S: WideString);
begin
  if Sorted then
    Error(SSortedListError, 0);
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  Changing;
  FList[Index].FString := S;
  Changed;
end;

procedure TLMDWideStringList.PutObject(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (Index >= FCount) then
    Error(SListIndexError, Index);
  Changing;
  FList[Index].FObject := AObject;
  Changed;
end;

procedure TLMDWideStringList.QuickSort(L, R: Integer; SCompare: TLMDWideStringListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure TLMDWideStringList.SetCapacity(NewCapacity: Integer);
begin
  ReallocMem(FList, NewCapacity * SizeOf(TStringItem));
  FCapacity := NewCapacity;
end;

procedure TLMDWideStringList.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    if Value then Sort;
    FSorted := Value;
  end;
end;

procedure TLMDWideStringList.SetStrictDelimiter(const Value: boolean);
begin
  FStrictDelimiter := Value;
end;

procedure TLMDWideStringList.SetCaseSensitive(Value: Boolean);
begin
  if Value <> FCaseSensitive then
  begin
    FCaseSensitive := Value;
    if Sorted then Sort;
  end;
end;

procedure TLMDWideStringList.SetDelimitedText(const Value: string);
var
  P, P1: PChar;
  S: string;
begin
  BeginUpdate;
  try
    Clear;
    P := PChar(Value);
    if not StrictDelimiter then
      while (P^ in [#1..' ']) do
        P := NextChar(P);
    while P^ <> #0 do
    begin
      if P^ = QuoteChar then
        S := AnsiExtractQuotedStr(P, QuoteChar)
      else
      begin
        P1 := P;
        while ((not FStrictDelimiter and (P^ > ' ')) or
              (FStrictDelimiter and (P^ <> #0))) and (P^ <> Delimiter) do
          P := NextChar(P);
        SetString(S, P1, P - P1);
      end;
      Add(S);
      if not FStrictDelimiter then
        while (P^ in [#1..' ']) do
          P := NextChar(P);

      if P^ = Delimiter then
      begin
        P1 := P;
        if NextChar(P1)^ = #0 then
          Add('');
        repeat
          P := NextChar(P);
        until not (not FStrictDelimiter and (P^ in [#1..' ']));
      end;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TLMDWideStringList.SetDelimiter(const Value: Char);
begin
  FDelimiter := Value;
end;

procedure TLMDWideStringList.SetQuoteChar(const Value: Char);
begin
  FQuoteChar := Value;
end;

procedure TLMDWideStringList.SetUpdateState(Updating: Boolean);
begin
  if Updating then Changing else Changed;
end;

function StringListWideCompare(List: TLMDWideStringList;
  Index1, Index2: Integer): Integer;
begin
  Result := LMDWideCompareText(List.FList[Index1].FString,
                               List.FList[Index2].FString);
end;

function StringListUnsensedWideCompare(List: TLMDWideStringList;
  Index1, Index2: Integer): Integer;
begin
  Result := LMDWideCompareText(LMDUnicodeUpper(List.FList[Index1].FString),
                               LMDUnicodeUpper(List.FList[Index2].FString));
end;

procedure TLMDWideStringList.Sort;
begin
  if CaseSensitive then
    CustomSort(StringListWideCompare)
  else
    CustomSort(StringListUnsensedWideCompare);
end;

{$ifdef LMDCOMP9}
{ TLMDWideStringEnumerator }
constructor TLMDWideStringEnumerator.Create(AStrings: TLMDWideStrings);
begin
  inherited Create;
  FIndex := -1;
  FStrings := AStrings;
end;

function TLMDWideStringEnumerator.GetCurrent: string;
begin
  Result := FStrings[FIndex];
end;

function TLMDWideStringEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FStrings.Count - 1;
  if Result then
    Inc(FIndex);
end;
{$endif}

{$ENDIF} // IFNDEF NATIVEUNICIODE

constructor TLMDWideStringArray.Create;
begin
  inherited;
  FArray := TLMDArray.Create;
  TLMDArray(FArray).OnDelete := OnItemDelete;
  end;

destructor TLMDWideStringArray.Destroy;
begin
  FArray.Free;
  inherited;
end;

function TLMDWideStringArray.Add(const S: TLMDWideStringArrayStr): Integer;
begin
  if not Sorted then
    Result := TLMDArray(FArray).Count
  else
    if Find(S, Result) then
      case Duplicates of
        dupIgnore: Exit;
        dupError: Error(SDuplicateString, 0);
      end;
  InsertItem(Result, S);
end;

function TLMDWideStringArray.AddStringEntry(const S: TLMDWideStringArrayStr; AObject:
    TObject): Integer;
var
  Item :PElWideStringItem;
begin
  Changing;
  New(Item);
    GetMem(Item.FString, (Length(S) + 1) * sizeof(WideChar));
    LMDWideStrPCopy(Item.FString, S);
    Item.FObject := AObject;
    Result := TLMDArray(FArray).Count;
    TLMDArray(FArray).Insert(result, Item);
  Changed;
end;

procedure TLMDWideStringArray.Changed;
begin
  if (FUpdateCount = 0) and Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TLMDWideStringArray.Changing;
begin
  if (FUpdateCount = 0) and Assigned(FOnChanging) then
    FOnChanging(Self);
end;

procedure TLMDWideStringArray.Clear;
begin
  if TLMDArray(FArray).Count <> 0 then
  begin
    Changing;
    TLMDArray(FArray).Clear;
    Changed;
  end;
end;

procedure TLMDWideStringArray.Delete(Index: Integer);
begin
  Changing;
  TLMDArray(FArray).Delete(Index);
  Changed;
end;

procedure TLMDWideStringArray.Exchange(Index1, Index2: Integer);
begin
  if (Index1 < 0) then
    Error(SListIndexError, Index1);
  if (Index2 < 0) then
    Error(SListIndexError, Index2);
  Changing;
  ExchangeItems(Index1, Index2);
  Changed;
end;

procedure TLMDWideStringArray.ExchangeItems(Index1, Index2: Integer);
begin
  TLMDArray(FArray).Exchange(Index1, Index2);
end;

function TLMDWideStringArray.Find(const S: TLMDWideStringArrayStr; var Index: Integer):
    Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := TLMDArray(FArray).Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := LMDWideStrComp(PElWideStringItem(TLMDArray(FArray)[I]).FString, PWideChar(S));
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

function TLMDWideStringArray.Get(Index: Integer): TLMDWideStringArrayStr;
var
  Item : PElWideStringItem;
  begin
  if (Index < 0) then
    Error(SListIndexError, Index);
  Item := PElWideStringItem(TLMDArray(FArray)[Index]);
    if Item = nil then
      Result := ''
    else
      Result := LMDWideStrPas(Item.FString);
  end;

function TLMDWideStringArray.GetCount: Integer;
begin
  result := TLMDArray(FArray).Count;
end;

function TLMDWideStringArray.GetObject(Index: Integer): TObject;
var
  Item : PElWideStringItem;
  begin
  if (Index < 0) then
    Error(SListIndexError, Index);
  Item := PElWideStringItem(TLMDArray(FArray)[Index]);
    if Item = nil then
      Result := nil
    else
      Result := Item.FObject;
  end;

function TLMDWideStringArray.IndexOf(const S: TLMDWideStringArrayStr): Integer;
begin
  if not Sorted then
    Result := inherited IndexOf(S)
  else
    if not Find(S, Result) then Result := -1;
end;

procedure TLMDWideStringArray.Insert(Index: Integer; const S: TLMDWideStringArrayStr);
begin
  if Sorted then
    Error(SSortedListError, 0);
  if (Index < 0) then
    Error(SListIndexError, Index);
  InsertItem(Index, S);
end;

procedure TLMDWideStringArray.InsertItem(Index: Integer; const S: TLMDWideStringArrayStr);
var
  Item : PElWideStringItem;
begin
  Changing;
  New(Item);
    GetMem(Item.FString, (Length(S) + 1) * sizeof(WideChar));
    LMDWideStrPCopy(Item.FString, S);
    Item.FObject := nil;
    TLMDArray(FArray).Insert(Index, Item);
  Changed;
end;

procedure TLMDWideStringArray.LoadFromBinaryStream(Stream: TStream);
var i , j : integer;
    S     : WideString;
    O     : TObject;
    fos,
    fss   : boolean;
    begin
  Changing;
  Stream.ReadBuffer(j, sizeof(j));
  Stream.ReadBuffer(fss, sizeof(fss));
  fos := Sorted;
  Sorted := false;
  for i := 0 to j - 1 do    // Iterate
  begin
    LMDWideReadStringFromStream(Stream, S);
    if fss then
      Stream.ReadBuffer(O, sizeof(O))
      else
      O := nil;
    AddStringEntry(S, O);
  end;    // for
  FSorted := fos;
  Changed;
end;

procedure TLMDWideStringArray.OnItemDelete(Sender : TObject; Item : Pointer);
var AR : PElWideStringItem;
begin
  if Item <> nil then
  begin
    AR := PElWideStringItem(Item);
    if AR.FString <> nil then
      FreeMem(AR.FString);
    Dispose(AR);
    // Memory leak ???
    //FreeMem(AR);
  end;
end;

procedure TLMDWideStringArray.Put(Index: Integer; const S: TLMDWideStringArrayStr);
var
    OV   : PWideChar;
    Item : PElWideStringItem;
begin
   if Sorted then Error(SSortedListError, 0);
  if (Index < 0) then Error(SListIndexError, Index);
  Changing;
  if TLMDArray(FArray).Count <= Index then
  begin
    New(Item);
      GetMem(Item.FString, (Length(S) + 1) * sizeof(WideChar));
      LMDWideStrPCopy(Item.FString, S);
      Item.FObject := nil;
      TLMDArray(FArray)[Index] := Item;
    end
  else
  begin
    OV := PElWideStringItem(TLMDArray(FArray)[Index]).FString;
      if OV <> nil then
        FreeMem(OV);
      if Length(S) = 0 then
        PElWideStringItem(TLMDArray(FArray)[Index]).FString := nil
      else
      begin
        GetMem(PElWideStringItem(TLMDArray(FArray)[Index]).FString,
               (Length(S) + 1)  * sizeof(WideChar));
        LMDWideStrPCopy(PElWideStringItem(TLMDArray(FArray)[Index]).FString, S);
      end;
    end;
  Changed;
end;

procedure TLMDWideStringArray.PutObject(Index: Integer; AObject: TObject);

begin
  if (Index < 0) then Error(SListIndexError, Index);
  Changing;
  PElWideStringItem(TLMDArray(FArray)[Index]).FObject := AObject;
  Changed;
end;

procedure TLMDWideStringArray.PutStringEntry(Index: Integer; const S :
    TLMDWideStringArrayStr; AObject: TObject);
var
    OV   : PWideChar;
    Item : PElWideStringItem;
begin
  if Sorted then Error(SSortedListError, 0);
  if (Index < 0) then Error(SListIndexError, Index);
  Changing;
  if TLMDArray(FArray).Count <= Index then
  begin
      New(Item);
      GetMem(Item.FString, (Length(S) + 1)  * sizeof(WideChar));
      LMDWideStrPCopy(Item.FString, S);
      Item.FObject := AObject;
      TLMDArray(FArray)[Index] := Item;
  end
  else
  begin
      OV := PElWideStringItem(TLMDArray(FArray)[Index]).FString;
      if OV <> nil then
        FreeMem(OV);
      if Length(S) = 0 then
        PElWideStringItem(TLMDArray(FArray)[Index]).FString := nil
      else
      begin
        GetMem(PElWideStringItem(TLMDArray(FArray)[Index]).FString,
               (Length(S) + 1) * sizeof(WideChar));
        LMDWideStrPCopy(PElWideStringItem(TLMDArray(FArray)[Index]).FString, S);
      end;
      PElWideStringItem(TLMDArray(FArray)[Index]).FObject := AObject;
  end;
  Changed;
end;

procedure TLMDWideStringArray.QuickSort(L, R: Integer);
var
  I, J: Integer;
  P: PWideChar;
  begin
  repeat
    I := L;
    J := R;
    P := PElWideStringItem(TLMDArray(FArray)[(L + R) shr 1]).FString;
    repeat
      while LMDWideStrComp(PElWideStringItem(TLMDArray(FArray)[I]).FString, P) < 0 do Inc(I);
      while LMDWideStrComp(PElWideStringItem(TLMDArray(FArray)[J]).FString, P) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TLMDWideStringArray.SaveToBinaryStream(Stream: TStream);
var i, j : integer;
    S    : WideString;
    O    : TObject;
begin
  j := TLMDArray(FArray).Count;
  Stream.WriteBuffer(FStoreAssociatedData, sizeof(FStoreAssociatedData));
  Stream.WriteBuffer(j, sizeof(j));
  for i := 0 to j - 1 do    // Iterate
  begin
    S := Get(i);
    LMDWideWriteStringToStream(Stream, S);
    if FStoreAssociatedData then
    begin
      O := GetObject(i);
      Stream.WriteBuffer(TLMDPtrInt(O), sizeof(TLMDPtrInt));
    end;
  end;    // for
end;

procedure TLMDWideStringArray.SetSorted(newValue : Boolean);
begin
  if (FSorted <> newValue) then
  begin
    if newValue then
      Sort;
    FSorted := newValue;
  end;  { if }
end;  { SetSorted }

procedure TLMDWideStringArray.SetUpdateState(Updating: Boolean);
begin
  if Updating then
    Changing
  else
    Changed;
end;

procedure TLMDWideStringArray.Sort;
begin
  if not Sorted and (TLMDArray(FArray).Count > 1) then
  begin
    Changing;
    QuickSort(0, TLMDArray(FArray).Count - 1);
    Changed;
  end;
end;

procedure TLMDWideStringArray.TriggerChangeEvent;
begin
  if (assigned(FOnChange)) then
    FOnChange(Self);
end;  { TriggerChangeEvent }

procedure TLMDWideStringArray.TriggerChangingEvent;
begin
  if (assigned(FOnChanging)) then
    FOnChanging(Self);
end;  { TriggerChangingEvent }

end.
