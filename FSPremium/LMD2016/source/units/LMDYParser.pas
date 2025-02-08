unit LMDYParser;
{$I LMDCmps.inc}

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

LMDYParser unit (DD)
----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Variants, LMDSearchConsts;

const
     yymaxdepth = 1024;  (* default stack size of parser *)
     nl = #10;  (* newline character *)
     max_chars = 2048;
     max_matches = 1024;
     max_rules   = 256;

     NULL_VAR = $80000000;
     MAX_PARAMS = 15;

     TooManyRules = 'too many rules';
     MatchStackOverflow = 'match stack overflow';
     AtLine = 'at line';
     InputBufferOverflow = 'input buffer overflow';
     FatalError = 'Fatal error';
     UnexpectedEOFInsideComment = 'Unexpected EOF inside comment';
     YyparseStackOverflow = 'yyparse stack overflow';
     StateMsg = 'state';
     CharMsg = 'char';
     SyntaxError = 'syntax error';
     ErrorRecoveryPopsState = 'error recovery pops state';
     Uncovers = 'uncovers';
     ErrorRecoveryFailsAbort = 'error recovery fails ... abort';
     ErrorRecoveryDiscardsChar = 'error recovery discards char';
     ReduceMsg = 'reduce';

type

  //YYSType = Integer;
  (* default value type, may be redefined in Yacc output file *)
  YYSFlag = ( yyfnone, yyfaccept, yyfabort, yyferror );

  PVariantArray = ^TVariantArray;
  {$ifdef LMDX86}
  TVariantArray = array[0..MaxListSize - 1] of Variant;
  {$else}
  TVariantArray = array[0..(MaxListSize div 2) - 1] of Variant;
  {$endif}
  TSegment = class
  private
    FList      : PVariantArray;
    FCount     : Integer;
    FCapacity  : Integer;
    procedure  SetCode( Index : Integer; Value : Variant);
    function   GetCode( Index : Integer ) : Variant;
    procedure  SetLastCode(Value : Variant);
    function   GetLastCode: Variant;
    procedure  SetCount(const Value: Integer);
    procedure  SetCapacity(const Value: Integer);
    procedure  Grow; virtual;
  public
    Data        : TObject;
    lRes        : Longint;
    property     Codes[Index:Integer] : Variant read GetCode write SetCode;
    property     Code : Variant read GetLastCode write SetLastCode;
    property     Count : Integer read FCount write SetCount;
    property     Capacity: Integer read FCapacity write SetCapacity;

    constructor  Create;
    destructor   Destroy;override;
    procedure    Clear;
    procedure    AddCodes(const Values : array of Variant );
    procedure    AddSegment( Seg : TSegment );virtual;
    procedure    AddCode( Value : Variant );

    procedure    Delete( Index : Integer );
    function     Pop:Variant;
    function     Load( Reader : TReader):Boolean;
    function     Save( Writer : TWriter):Boolean;
    function     ParamsCount:Integer;
    function     GetParam(Index: Integer; Def : Variant): Variant;
  end;

  TYStream = class
  public
    yylineno, yycolno : Integer;     (* current input position *)
    procedure fatal ( msg : String );virtual;abstract;
    function  get_char : Char;virtual;abstract;
    procedure unget_char ( c : Char );virtual;abstract;
    procedure put_char   ( c : Char );virtual;abstract;
    procedure yyclear;virtual;abstract;
    function  yywrap : Boolean;virtual;
    procedure message ( msg : String );virtual;abstract;
  end;

  TYConStream = class(TYStream)
  protected
    bufptr : Integer;
    buf    : array [1..max_chars] of Char;
    yyinput, yyoutput : Text;        (* input and output file *)
    yyline            : String;      (* current input line *)
    public
    constructor Create;
    destructor  Destroy; override;
    procedure   fatal ( msg : String );override;
    function    get_char : Char;override;
    procedure   unget_char ( c : Char );override;
    procedure   put_char   ( c : Char );override;
    procedure   yyclear;override;
    procedure   message ( msg : String );override;
  end;

  TYVCLStream = class(TYStream)
  public
    aInStream , aOutStream : TMemoryStream;
    constructor Create;
    destructor  Destroy; override;
    procedure LoadFromStrings( aStrings: TStrings );
    procedure SaveToStrings( aStrings: TStrings );
    procedure fatal ( msg : String );override;
    function  get_char : Char;override;
    procedure unget_char ( c : Char );override;
    procedure put_char   ( c : Char );override;
    procedure yyclear;override;
    function  yywrap : Boolean;override;
    procedure message ( msg : String );override;
  end;

  TYLex    = class
  protected
    FYStream   : TYStream;
    yystext            : String;
    yysstate, yylstate : Integer;
    yymatches          : Integer;
    yystack            : array [1..max_matches] of Integer;
    yypos              : array [1..max_rules] of Integer;
    yysleng            : Integer;

  public
    yytext     : String;      (* matched text (should be considered r/o) *)
    yystate    : Integer; (* current state of lexical analyzer *)
    yyactchar  : Char;    (* current character *)
    yylastchar : Char;    (* last matched character (#0 if none) *)
    yyrule     : Integer; (* matched rule *)
    yyreject   : Boolean; (* current match rejected? *)
    yydone     : Boolean; (* yylex return value set? *)
    yyretval   : Integer; (* yylex return value *)

    constructor Create( aYStream : TYStream );
    function    yylex : Integer;virtual;abstract;
    function    GetTextLen:Byte;
    procedure echo;virtual;  (* echoes the current match to the output stream *)
    procedure yymore;virtual;  (* append the next match to the current one *)
    procedure yyless ( n : Integer );virtual;  (* truncate yytext to size n and return the remaining characters to the
                                       input stream *)
    procedure reject;virtual;  (* reject the current match and execute the next one *)
    procedure returnn( n : Integer );virtual;
    procedure returnc(c : Char ); virtual;  (* sets the return value of yylex *)
    procedure start ( state : Integer );virtual;  (* puts the lexical analyzer in the given start state; state=0 denotes
             the default start state, other values are user-defined *)
    function  yywrap : Boolean;virtual;
    procedure yynew;  (* starts next match; initializes state information of the lexical
                      analyzer *)
    procedure yyscan; (* gets next character from the input stream and updates yytext and
                      yyactchar accordingly *)
    procedure yymark ( n : Integer );  (* marks position for rule no. n *)
    procedure yymatch ( n : Integer );  (* declares a match for rule number n *)
    function  yyfind ( var n : Integer ) : Boolean;
   (* finds the last match and the corresponding marked position and adjusts
     the matched string accordingly; returns:
     - true if a rule has been matched, false otherwise
     - n: the number of the matched rule *)
    function  yydefault : Boolean;  (* executes the default action (copy character); returns true unless
                                    at end-of-file *)
    procedure yyclear; (* reinitializes state information after lexical analysis has been
                        finished *)
    procedure fatal ( msg : String );
    function  get_char : Char;
    procedure unget_char ( c : Char );
    procedure put_char   ( c : Char );
    procedure message ( msg : String );
    function  GetYYlvalPonter: TObject; virtual; abstract;

    property  yyleng : Byte read GetTextLen;
  end;

  TYParser = class(TPersistent)
  protected
    FYLex : TYLex;
    function yylex   : Integer; virtual;
    function yyparse : Integer; virtual; abstract;
    public
    CodeSeg   : TSegment;
    DataSeg   : TSegment;
    Stack     : TSegment;
    FErrorProc: TNotifyEvent;
    yychar    : Integer; (* current lookahead character *)
    yynerrs   : Integer; (* current number of syntax errors reported by the parser*)
    yydebug   : Boolean; (* set to true to enable debugging output of parser *)
    yyflag    : YYSFlag;
    yyerrflag : Integer;

    procedure yyerror ( msg : String );virtual; (* error message printing routine used by the parser *)
    procedure yyclearin;virtual;(* delete the current lookahead token *)
    procedure yyaccept;virtual; (* trigger accept action of the parser; yyparse accepts returning 0, as if
                        it reached end of input *)
    procedure yyabort;virtual;  (* like yyaccept, but causes parser to return with value 1, as if an
                        unrecoverable syntax error had been encountered *)
    procedure yyerrlab;virtual; (* causes error recovery to be started, as if a syntax error had been
                        encountered *)
    procedure yyerrok;virtual; (* when in error mode, resets the parser to its normal mode of
                        operation *)
    constructor Create( aYLex : TYLex);
    destructor  Destroy;override;
    function    Getyylineno : Integer;
    function    Getyycolno : Integer;
    property    yylineno : Integer read Getyylineno;
    property    yycolno : Integer read Getyycolno;
  published
    property YLex : TYLex read FYLex write FYLex default nil;
  end;

implementation

function  TSegment.Pop;
begin
  Result := Code;
  Delete(Count-1);
end;

procedure  TSegment.SetLastCode(Value : Variant);
begin
  Codes[Count-1] := Value;
end;

function   TSegment.GetLastCode: Variant;
begin
  Result := Codes[Count-1];
end;

procedure  TSegment.SetCode( Index : Integer; Value : Variant);
begin
  if (Index>=0) and (Index<Count) then
    FList^[Index] := Value;
    end;

function   TSegment.GetCode( Index : Integer ) : Variant;
begin
  if (Index>=0) and (Index<Count) then
    Result := FList^[Index];
    end;

procedure TSegment.Delete(Index : Integer);
begin
  if (Index < 0) or (Index >= FCount) then exit;
  VarClear(FList^[Index]);
  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index],
      (FCount - Index) * SizeOf(Variant));
    end;

function     TSegment.ParamsCount:Integer;
var
  i : Integer;
begin
  Result := -1;
  for i:=Count-1 downto 0 do
    if (VarType(Codes[i])=varInteger) and (Codes[i]=NULL_VAR) then
    begin
      Result := Count-i-1;
      exit;
    end;
  if Result>MAX_PARAMS then
    Result := -1;
end;

function     TSegment.GetParam(Index: Integer; Def : Variant): Variant;
var
  i : Integer;
begin
  i:=ParamsCount;
  Result := def;
  if (Index>i) or (Index<=0) then exit;
  Result := Codes[Count-1-(i-Index)];
end;

constructor  TSegment.Create;
begin
  inherited Create;
  FCount := 0;
  FList  := nil;
  Data := nil;
  lRes := 0;
end;

destructor   TSegment.Destroy;
begin
  Clear;
  if Data<>nil then Data.Free;
  inherited Destroy;
end;

procedure    TSegment.Clear;
begin
  SetCount(0);
  SetCapacity(0);
end;

// todo: remove const
procedure    TSegment.AddCodes(const Values : array of Variant );
var
  H, L, i : Integer;
begin
  H := High(values);
  L := Low(values);
  for i:=L to H do AddCode(Values[i]);
end;

procedure    TSegment.AddSegment( Seg : TSegment );
var
  i : Integer;
begin
  for i:=0 to Seg.Count-1 do
    AddCode(Seg.Codes[i]);
end;

{ TYStream }

function  TYStream.yywrap : Boolean;
begin
  Result := True;
end;

{ TYLex }

constructor TYLex.Create( aYStream : TYStream );
begin
  inherited Create;
  FYStream := aYStream;
end;

function    TYLex.GetTextLen:Byte;
begin
  Result :=  Length(yytext);
end;

procedure TYLex.echo;
  var i : Integer;
  begin
    for i := 1 to yyleng do
      put_char(yytext[i])
  end(*echo*);

procedure TYLex.yymore;
  begin
    yystext := yytext;
  end(*yymore*);

procedure TYLex.yyless ( n : Integer );
  var i : Integer;
  begin
    for i := yyleng downto n+1 do
      unget_char(yytext[i]);
    SetLength(yytext, n);
  end(*yyless*);

procedure TYLex.reject;
  var i : Integer;
  begin
    yyreject := true;
    for i := yyleng+1 to yysleng do
      yytext := yytext+get_char;
    dec(yymatches);
  end(*reject*);

procedure TYLex.returnn ( n : Integer );
  begin
    yyretval := n;
    yydone := true;
  end(*return*);

procedure TYLex.returnc ( c : Char );
begin
  yyretval := ord(c);
  yydone := true;
end(*returnc*);

procedure TYLex.start ( state : Integer );
  begin
    yysstate := state;
  end(*start*);

(* yywrap: *)

function TYLex.yywrap : Boolean;
  begin
    if FYStream<>nil then
      FYStream.yywrap;
    yywrap := true;
  end(*yywrap*);

(* Internal routines: *)

procedure TYLex.yynew;
  begin
    if yylastchar<>#0 then
      if yylastchar=nl then
        yylstate := 1
      else
        yylstate := 0;
    yystate := yysstate+yylstate;
    yytext  := yystext;
    yystext := '';
    yymatches := 0;
    yydone := false;
  end(*yynew*);

procedure TYLex.yyscan;
  begin
    yyactchar := get_char;
    yytext := yytext + yyactChar;
  end(*yyscan*);

procedure TYLex.yymark ( n : Integer );
  begin
    if n>max_rules then fatal(TooManyRules);
    yypos[n] := yyleng;
  end(*yymark*);

procedure TYLex.yymatch ( n : Integer );
  begin
    inc(yymatches);
    if yymatches>max_matches then fatal(MatchStackOverflow);
    yystack[yymatches] := n;
  end(*yymatch*);

function TYLex.yyfind ( var n : Integer ) : Boolean;
  begin
    yyreject := false;
    while (yymatches>0) and (yypos[yystack[yymatches]]=0) do
      dec(yymatches);
    if yymatches>0 then
      begin
        yysleng := yyleng;
        n       := yystack[yymatches];
        yyless(yypos[n]);
        yypos[n] := 0;
        if yyleng>0 then
          yylastchar := yytext[yyleng]
        else
          yylastchar := #0;
        yyfind := true;
      end
    else
      begin
        yyless(0);
        yylastchar := #0;
        yyfind := false;
      end
  end(*yyfind*);

function TYLex.yydefault : Boolean;
  begin
    yyreject := false;
    yyactchar := get_char;
    if yyactchar<>#0 then
      begin
        put_char(yyactchar);
        yydefault := true;
      end
    else
      begin
        yylstate := 1;
        yydefault := false;
      end;
    yylastchar := yyactchar;
  end(*yydefault*);

procedure TYLex.yyclear;
  begin
    if FYStream<>nil then
      FYStream.yyclear;
    yysstate := 0;
    yylstate := 1;
    yylastchar := #0;
    yytext := '';
    yystext := '';
  end(*yyclear*);

procedure TYLex.fatal ( msg : String );
begin
  if FYStream<>nil then
    FYStream.fatal(msg);
end;

function  TYLex.get_char : Char;

begin
  if FYStream<>nil then
    Result := FYStream.get_char
  else
    Result := #0;
end;

procedure TYLex.unget_char ( c : Char );

begin
  if FYStream<>nil then
    FYStream.unget_char(c);
end;

procedure TYLex.put_char   ( c : Char );

begin
  if FYStream<>nil then
    FYStream.put_char(c);
end;

procedure TYLex.message ( msg : String );
begin
  if FYStream<>nil then
    FYStream.message(msg);
end;

{ TYParser }

function    TYParser.Getyylineno : Integer;
begin
  Result := 0;
  if FYLex<>nil then
    if FYLex.FYStream<>nil then
      Result := FYLex.FYStream.yylineno;
end;

function    TYParser.Getyycolno : Integer;
begin
  Result := 0;
  if FYLex<>nil then
    if FYLex.FYStream<>nil then
      Result := FYLex.FYStream.yycolno;
end;

function TYParser.yylex   : Integer;
begin
  if FYLex<>nil then
    Result := FYLex.yylex
  else
    Result := 0;
end;

constructor TYParser.Create;
begin
  inherited Create;
  CodeSeg   := TSegment.Create;
  DataSeg   := TSegment.Create;
  Stack     := TSegment.Create;
  FErrorProc := nil;
  FYLex := aYLex;
end;

destructor  TYParser.Destroy;
begin
  CodeSeg.Free;
  DataSeg.Free;
  Stack.Free;
  inherited;
end;

procedure TYParser.yyerror ( msg : String );
  begin
    if FYLex<>nil then
    begin
      begin
        FYLex.message(msg + ' ' + AtLine + ' ' + IntToStr(yylineno+1));
        if Assigned(FErrorProc) then
          FErrorProc(Self);
      end;
    end;
  end(*yyerrmsg*);

procedure TYParser.yyclearin;
  begin
    yychar := -1;
  end(*yyclearin*);

procedure TYParser.yyaccept;
  begin
    yyflag := yyfaccept;
  end(*yyaccept*);

procedure TYParser.yyabort;
  begin
    yyflag := yyfabort;
  end(*yyabort*);

procedure TYParser.yyerrlab;
  begin
    yyflag := yyferror;
  end(*yyerrlab*);

procedure TYParser.yyerrok;
  begin
    yyerrflag := 0;
  end(*yyerrork*);

{ TYConLexLib }

function TYConStream.get_char : Char;

  var i : Integer;
  begin
    if (bufptr=0) and not eof(yyinput) then
      begin
        readln(yyinput, yyline);
        inc(yylineno); yycolno := 1;
        buf[1] := nl;
        for i := 1 to length(yyline) do
          buf[i+1] := yyline[length(yyline)-i+1];
        inc(bufptr, length(yyline)+1);
      end;
    if bufptr>0 then
      begin
        get_char := buf[bufptr];
        dec(bufptr);
        inc(yycolno);
      end
    else
      get_char := #0;
  end(*get_char*);

procedure TYConStream.unget_char(c : Char );

  begin
    if bufptr=max_chars then fatal(InputBufferOverflow);
    inc(bufptr);
    dec(yycolno);
    buf[bufptr] := c;
  end(*unget_char*);

procedure TYConStream.put_char ( c : Char );

  begin
    if c=#0 then
      { ignore }
    else if c=nl then
      writeln(yyoutput)
    else
      write(yyoutput, c)
  end(*put_char*);

constructor TYConStream.Create;
begin
  inherited Create;
  assign(yyinput, '');
  assign(yyoutput, '');
  reset(yyinput); rewrite(yyoutput);
  yylineno := 0;
  bufptr := 0;
end;

destructor TYConStream.Destroy;
begin
  close(yyinput); close(yyoutput);
  inherited Destroy;
end;

procedure TYConStream.fatal ( msg : String );
begin
  writeln(FatalError + ': ', msg);
  halt(1);
end(*fatal*);

procedure TYConStream.message ( msg : String );
begin
  writeln(msg);
end;

procedure TYConStream.yyclear;
begin
  bufptr := 0;
end;

{ TYVCLStream }

constructor TYVCLStream.Create;
begin
  inherited Create;
  aInStream  := TMemoryStream.Create;
  aOutStream := TMemoryStream.Create;
  yylineno := 0;
  yycolno := 0;
end;

destructor  TYVCLStream.Destroy;
begin
  aInStream.Free;
  aOutStream.Free;
  inherited Destroy;
end;

procedure TYVCLStream.fatal ( msg : String );
begin
  Message(msg);
end;

function  TYVCLStream.get_char : Char;

begin
 aInStream.Read( Result, sizeof(Result));
 if Result = nl then
 begin
   inc(yylineno);
   yycolno := 0;
 end
 else
   inc(yycolno);
end;

procedure TYVCLStream.unget_char ( c : Char );

begin
  aInStream.Seek(-sizeof(Char), soFromCurrent);
  if c=nl then dec(yylineno);
  dec(yycolno);
end;

procedure TYVCLStream.put_char   ( c : Char );

begin
  aOutStream.Write(c, sizeof(c));
end;

procedure TYVCLStream.yyclear;
begin
//  aInStream.Seek(0, 0);
  aInStream.Clear;
end;

function  TYVCLStream.yywrap : Boolean;
begin
//  aInStream.Clear;
  Result := True;
end;

procedure TYVCLStream.message ( msg : String );
begin
  msg := msg+nl;
  aOutStream.WriteBuffer(msg[1], Length(msg));
end;

procedure TYVCLStream.LoadFromStrings( aStrings: TStrings );
var
  i, j : Integer;
  c    : Char;
  begin
  aInStream.Clear;
  aInStream.Position := 0;

  for i:=0 to aStrings.Count-1 do
  begin
    for j:=1 to Length(aStrings[i]) do
    begin
      c := aStrings[i][j];
      aInStream.Write(c, sizeof(C));
    end;
    c := nl;
    aInStream.Write(c, sizeof(C));
  end;
  c := nl;
  aInStream.Write(c, sizeof(C));
  c := #0;
  aInStream.Write(c, sizeof(C));
  aInStream.Write(c, sizeof(C));
  aInStream.Position := 0;
end;

procedure TYVCLStream.SaveToStrings( aStrings: TStrings );
begin
  aInStream.Position := 0;
  aStrings.LoadFromStream( aOutStream );
end;

function     TSegment.Load( Reader : TReader):Boolean;
var
  V : TValueType;
begin
  Result := False;
  try
    Clear;
    with Reader do
    begin
      ReadListBegin;
      while not EndOfList do
      begin
        V := NextValue;
        case V of
          vaExtended:
            AddCode(ReadFloat);

          vaString:
            AddCode(ReadString);

          vaInt8, vaInt16, vaInt32:
            AddCode(ReadInteger);

        end;
      end;
      ReadListend;
    end;
    Result := True;
  except
  end;
end;

function     TSegment.Save( Writer : TWriter):Boolean;
var
  i : Integer;
  V : Variant;
begin
  Result := False;
  try
    with Writer do
    begin
        WriteListBegin;
        for i:=0 to Count-1 do
        begin
          VarClear(V);
          V := Codes[i];
          case VarType(V) of
            varString:
              WriteString(V);

            varInteger,varSmallint:
              WriteInteger(V);

            varSingle, varDouble, varDate, varCurrency:
              WriteFloat(V);

            else
              raise Exception.Create('');
            end
        end;
        WriteListEnd;
    end;
    Result := True;
  except
  end;
end;

procedure TSegment.SetCount(const Value: Integer);
var
  i : Integer;
begin
  if (Value < 0) or (Value > MaxListSize) then exit;
  if Value > FCapacity then SetCapacity(Value);
  if Value > FCount then
    FillChar(FList^[FCount], (Value - FCount) * SizeOf(Variant), 0);
    for i:=Value to FCount-1 do
    VarClear(FList^[i]);
    FCount := Value;
end;

procedure TSegment.SetCapacity(const Value: Integer);
begin
  if (Value < FCount) or (Value > MaxListSize) then exit;
  if Value <> FCapacity then
  begin
   ReallocMem(FList, Value * SizeOf(Variant));
    if Value>FCount then
      FillChar(FList^[FCount], (Value - FCount) * SizeOf(Variant), 0);
   FCapacity := Value;
  end;
end;

procedure TSegment.AddCode(Value: Variant);
begin
  if FCount = FCapacity then Grow;
  FList^[FCount] := Value;
  Inc(FCount);
end;

procedure TSegment.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 128 then Delta := FCapacity div 4 else
    if FCapacity > 16 then Delta := 32 else
      Delta := 8;
  SetCapacity(FCapacity + Delta);
end;

end.
