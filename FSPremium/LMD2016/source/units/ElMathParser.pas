unit ElMathParser;
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

LMD MathParser (AH, VB)
-----------------------
Math expression parser with customazible list of math functions.

Changes
-------
Release 6.0 (May 2007)
  Released

Fixes for 5.0 (Dec 2005) (VB)
  ArgumentDelimiters changed to ','
  - Sqrt function implementation added
  - SetVariables method added
  - Arguments index fixed

###############################################################################}

Interface

uses
  Classes,SysUtils, Math, LMDTypes,
  StrUtils, Variants, 
  LMDElConst, LMDObjectList, LMDUnicodeStrings;

type
  EElMathException = class(Exception);

  TElMathParserErrorEvent = procedure(Sender: TObject; AError: String) of object;

  TTokenType = (DELIMITER, NUMBER, VARIABLE, COMMAND, CHARS, NONE);

  TElArgument = class(TPersistent)
  private
    FError: Integer;
    FName: TLMDString;
  public
    constructor Create(AName: TLMDString);
    procedure AssignValue(AValue: Variant); virtual; abstract;
    function IsValid: Boolean;
    property Name: TLMDString read FName;
  end;

  TElIntegerArgument = class(TElArgument)
  protected
    FValue: Integer;
  public
    procedure AssignValue(AValue: Variant); override;
    property Value: Integer read FValue;
  end;

  TElFloatArgument = class(TElArgument)
  protected
    FValue: Extended;
  public
    procedure AssignValue(AValue: Variant); override;
    property Value: Extended read FValue;
  end;

  TElStringArgument = class(TElArgument)
  protected
    FValue: TLMDString;
  public
    procedure AssignValue(AValue: Variant); override;
    property Value: TLMDString read FValue;
  end;

  TElArgumentList = class(TLMDObjectList)
  private
    function GetArg(Index: Integer): TElArgument;
    procedure PutArg(Index: Integer; const Value: TElArgument);
  public
    property Arguments[Index: Integer]: TElArgument read GetArg write PutArg; default;
  end;

  TElFunction = class(TPersistent)
  protected
    FName: TLMDString;
    FResult: Variant;
    FArgumentList: TElArgumentList;
    function Get(Index: Integer): TElArgument;
    function GetArgumentCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; virtual; abstract;
    property Name: TLMDString read FName;
    property ArgumentCount: Integer read GetArgumentCount;
    property Arguments[Index: Integer]: TElArgument read Get; default;
    property Result: Variant read FResult;
  end;

  TElSinFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElLogFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElCosFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElTanFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElCotFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElACosFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElASinFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElLnFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElLog10Function = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElATanFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElExpFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElPowerFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElSqrtFunction = class(TElFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TElFunctionList = class(TLMDObjectList)
  private
    FCaption: TLMDString;
  protected
    function GetFunction(Index: Integer): TElFunction;
    procedure PutFunction(Index: Integer; const Value: TElFunction);
  public
    function LookUpFunction(AName: TLMDString): TElFunction;
    property Caption: TLMDString read FCaption write FCaption;
    property Functions[Index: Integer]: TElFunction read GetFunction write PutFunction; default;
  end;

  TElMathFunctionList = class(TElFunctionList)
  public
    constructor Create;
  end;

  TElFunctionListGroups = class(TLMDObjectList)
  private
    function GetList(Index: Integer): TElFunctionList;
    procedure PutList(Index: Integer; const Value: TElFunctionList);
  public
    function LookUpFunction(AName: TLMDString): TElFunction;
    property FunctionLists[Index: Integer]: TElFunctionList read GetList write PutList; default;
  end;

  TElMathParser = class(TPersistent)
  private
    procedure SetExpr(const Value: TLMDString);
  protected
    FCommand: TElFunction;
    FExpr: TLMDString;
    Prog: Integer;
    Token: TLMDString;
    TokType: TTokenType;
    FVariables: TLMDStrings;
    FFunctionListGroups: TElFunctionListGroups;
    FArgumentDelimiters: TLMDString;
    FOnParseError: TElMathParserErrorEvent;

    function EvalExp: Extended;
    function IsAlpha(c: TLMDChar): Boolean;
    function IsDelimiter(c: TLMDChar): Boolean;
    function IsDigit(c: TLMDChar): Boolean;
    function IsSpace(c: TLMDChar): Boolean;
    function IsQuote(c: TLMDChar): Boolean;
    function GetResult: Variant;
    function LookUp(S: String): TElFunction;
    procedure Atom(var Res: Extended);
    procedure EvalExp2(var Res: Extended);
    procedure EvalExp3(var Res: Extended);
    procedure EvalExp4(var Res: Extended);
    procedure EvalExp5(var Res: Extended);
    procedure EvalExp6(var Res: Extended);
    procedure GetToken;
    procedure PutBack;
    procedure SError(Num: Byte);
    procedure SetVariables(const Value:TLMDStrings);
  public
    constructor Create; overload;
    constructor Create(const AExpr: string); overload;
    destructor Destroy; override;
    property Expression: TLMDString read FExpr Write SetExpr;
    property Result: Variant read GetResult;
    property FunctionListGroups: TElFunctionListGroups read FFunctionListGroups write FFunctionListGroups;
    property Variables: TLMDStrings read FVariables Write SetVariables;
    property ArgumentDelimiters: TLMDString read FArgumentDelimiters write FArgumentDelimiters;
    property OnParseError: TElMathParserErrorEvent read FOnParseError write FOnParseError;
  end;

const
  CArgumentDelimiters = ';';

implementation

const
  SSin = 'SIN';
  SCos = 'COS';
  STan = 'TAN';
  SArccos = 'ACOS';
  SArcsin = 'ASIN';
  SExp = 'EXP';
  SLn = 'LN';
  SLog = 'LOG';
  SLog10 = 'LOG10';
  SSqrt = 'SQRT';
  SPower = 'POWER';
  SArctan = 'ATAN';
  SCot = 'COT';

Constructor TElMathParser.Create;
begin
  inherited;
  Prog := 1;
  FExpr := '';
  Token := '';
  TokType := NONE;

  FVariables := TLMDMemoryStrings.Create;
  FArgumentDelimiters := CArgumentDelimiters;

  FFunctionListGroups := TElFunctionListGroups.Create;
  FFunctionListGroups.AutoClearObjects := true;
  FFunctionListGroups.Add(TElMathFunctionList.Create);
end;

constructor TElMathParser.Create(const AExpr: string);
begin
  Create;
  FExpr := AExpr;
end;

procedure TElMathParser.SetExpr(const Value: TLMDString);
begin
  FExpr := Value;
  Prog := 1;
end;

Procedure TElMathParser.EvalExp2;
var
  Op: TLMDChar;
  tmp: Extended;
begin
  EvalExp3(Res);
  if Length(Token) > 0 then
  begin
    Op := Token[1];
    while ((Op = '+') or (Op = '-')) do
    begin
      GetToken;
      EvalExp3(Tmp);
      case Op of
      '+': Res := Res + Tmp;
      '-': Res := Res - Tmp;
      end;
      if Length(Token) > 0 then
        Op := Token[1]
      else
        Op := #0;
    end;
  end;
end;

Procedure TElMathParser.EvalExp3;
var
  Op: TLMDChar;
  tmp:Extended;
begin
  EvalExp4(Res);
  if Length(Token) > 0 then
  begin
    Op := Token[1];
    while ((Op = '*') or (Op = '/')) do
    begin
      GetToken;
      EvalExp4(Tmp);
      case Op of
        '*': Res := Res * Tmp;
        '/': Res := Res / Tmp;
      end;
      if Length(Token) > 0 then
        Op := Token[1]
      else
        Op := #0;
    end;
  end;
end;

Procedure TElMathParser.EvalExp4;
var
   Op: TLMDChar;
   tmp: Extended;
begin
 EvalExp5(Res);
 if Length(Token) > 0 then
 begin
   Op := Token[1];
   if Op = '^' then
   begin
     GetToken;
     EvalExp5(Tmp);
     Res := Power(Res,Tmp);
   end;
 end;
end;

Procedure TElMathParser.EvalExp5;
var
  Op: TLMDChar;
begin
  Op := #0;
  if ((TokType = DELIMITER) and ((Token = '+') or (Token = '-') or (Token = '!'))) then
  begin
    Op := Token[1];
    GetToken;
  end;
  EvalExp6(Res);
  case Op of
    '-': Res := -Res;
  end;
end;

Procedure TElMathParser.EvalExp6;
begin
 if Token = '(' then
 begin
   GetToken;
   EvalExp2(Res);
   if Token <> ')' then SError(1);
   GetToken;
 end
 else
   Atom(Res);
end;

Procedure TElMathParser.Atom;
var
  Code, i: integer;
  temp: Extended;
  LOld: TElFunction;
begin
 Case TokType of

 VARIABLE:
   begin
     try
       Res := StrToFloat(Variables.Values[Token]);
     except
       SError(0);
     end;
     GetToken;
   end;

 COMMAND:
   begin
     GetToken;

     if Token <> '(' then
       SError(3);

     for i := 0 to FCommand.ArgumentCount - 1 do
     begin
       LOld := FCommand;
       GetToken;
       EvalExp2(Temp);

       FCommand := LOld;

       if (i < FCommand.ArgumentCount - 1) then
       begin
         if Pos(Token, FArgumentDelimiters) = 0 then
           SError(4);
       end
       else
       begin
         if Token <> ')' then
           SError(1);
       end;

       FCommand.Arguments[i].AssignValue(Temp);
     end;

     GetToken;

     FCommand.Execute;
     Res := FCommand.Result;
   end;

 NUMBER:
   begin
     Code := 0;
     try
       Res := StrToFloat(Token);
     except
       Code := 1;
     end;
     if Code <> 0 then
       SError(0);
     GetToken;
   end;
 end;
end;

Procedure TElMathParser.GetToken;
begin
  TokType := NONE;
  Token := '';

  if Prog > Length(FExpr) then
    exit;

  if FExpr <> '' then
  begin
    while IsSpace(FExpr[Prog]) do
      inc(Prog);

    if IsDelimiter(FExpr[Prog]) then
    begin
      TokType := DELIMITER;
      if Prog <= Length(FExpr) then
        Token := Token + FExpr[Prog];
      Inc(Prog);
    end
    else
    begin
      if IsAlpha(FExpr[Prog]) then
      begin
        While not IsDelimiter(FExpr[Prog]) do
        begin
          Token := Token + FExpr[Prog];
          Inc(Prog);
          if Prog > Length(FExpr) then
            break;
        end;
        FCommand := LookUp(Token);
        if Assigned(FCommand) then
          TokType := COMMAND
        else
          TokType := VARIABLE;
      end
      else
      if IsDigit(FExpr[Prog]) then
      begin
        While not IsDelimiter(FExpr[Prog]) do
        begin
          if Prog <= Length(FExpr) then
            Token := Token + FExpr[Prog];
          Inc(Prog);
        end;
        TokType := NUMBER;
      end
      else
      if IsQuote(FExpr[Prog]) then
      begin
        Inc(Prog);
        While not IsQuote(FExpr[Prog]) do
        begin
          if Prog <= Length(FExpr) then
            Token := Token + FExpr[Prog];
          Inc(Prog);
        end;
        Inc(Prog);
        TokType := CHARS;
      end;
    end;
  end;
end;

Procedure TElMathParser.SError;
const
  ErrCount = 5;
begin
  if Assigned(OnParseError) then
  begin
    case Num of
    0: OnParseError(nil, SLMDSyntaxError);
    1: OnParseError(nil, SLMDCloseBracketExpected);
    2: OnParseError(nil, SLMDExpressionEmpty);
    3: OnParseError(nil, SLMDOpenBracketExpected);
    4: OnParseError(nil, SLMDInvalidArgument);
    end;
  end
  else
    case Num of
    0: raise EElMathException.Create(SLMDSyntaxError);
    1: raise EElMathException.Create(SLMDCloseBracketExpected);
    2: raise EElMathException.Create(SLMDExpressionEmpty);
    3: raise EElMathException.Create(SLMDOpenBracketExpected);
    4: raise EElMathException.Create(SLMDInvalidArgument);
    end;
end;

Procedure TElMathParser.PutBack;
begin
  Dec(Prog,Length(Token));
  Token := '';
end;

function TElMathParser.IsSpace(c: TLMDChar): boolean;
begin
  Result := Boolean(AnsiChar(c) in [' ', #9]);
end;

Function TElMathParser.IsDelimiter;
begin
  Result := Boolean(Pos(c, FArgumentDelimiters) <> 0) or Boolean(AnsiChar(c) in ['+', '-', '*', '/', '^', '!', '=', '(', ')', #10, #13, #9, #0, #32]);
end;

Function TElMathParser.IsAlpha;
begin
  Result := Boolean(AnsiChar(c) in ['A'..'Z', 'a'..'z']);
end;

Function TElMathParser.IsDigit;
begin
  IsDigit := Boolean(AnsiChar(c) in ['0'..'9']);
end;

function TElMathParser.IsQuote(c: TLMDChar): Boolean;
begin
  IsQuote := Boolean(AnsiChar(c) in [#39, '"']);
end;

Function TElMathParser.LookUp;
begin
  Result := FFunctionListGroups.LookUpFunction(S);
end;

function TElMathParser.EvalExp;
begin
  GetToken;
  if Token = '' then
  begin
    SError(2);
    exit;
  end;
  EvalExp2(Result);
  EvalExp := Result;
end;

Destructor TElMathParser.Destroy;
begin
  FVariables.Free;
  FFunctionListGroups.Free;
end;

function TElMathParser.GetResult: Variant;
begin
  Result := EvalExp;
  Prog := 1;
end;

procedure TElMathParser.SetVariables(const Value: TLMDStrings);
begin
  if FVariables.Text <> Value.Text then
    FVariables.Text := Value.Text;
end;

{ TElFunction }

constructor TElFunction.Create;
begin
  inherited;
  FArgumentList := TElArgumentList.Create;
  FArgumentList.AutoClearObjects := True;
end;

destructor TElFunction.Destroy;
begin
  inherited;
  FArgumentList.Free;
end;

function TElFunction.Get(Index: Integer): TElArgument;
begin
  Result := TElArgument(FArgumentList.Items[Index]);
end;

function TElFunction.GetArgumentCount: Integer;
begin
  Result := FArgumentList.Count;
end;

{ TElIntegerArgument }

procedure TElIntegerArgument.AssignValue(AValue: Variant);
begin
  FError := 0;
  try
    FValue := StrToInt(AValue);
  except
    FError := -1;
  end;
end;

{ TElFloatArgumnet }

procedure TElFloatArgument.AssignValue(AValue: Variant);
begin
  FError := 0;
  try
    FValue := StrToFloat(AValue);
  except
    FError := -1;
  end;
end;

{ TElStringArgument }

procedure TElStringArgument.AssignValue(AValue: Variant);
begin
  FError := 0;
  try
    FValue := AValue;
  except
    FError := -1;
  end;
end;

{ TElArgument }

constructor TElArgument.Create(AName: TLMDString);
begin
  inherited Create;
  FName := AName;
end;

function TElArgument.IsValid: boolean;
begin
  Result := (FError = 0);
end;

{ TElFunctionList }

function TElFunctionList.GetFunction(Index: Integer): TElFunction;
begin
  Result := TElFunction(FList[Index]);
end;

function TElFunctionList.LookUpFunction(AName: TLMDString): TElFunction;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to FCount - 1 do
    if (UpperCase(TElFunction(FList[i]).Name) = UpperCase(AName)) then
    begin
      Result := TElFunction(FList[i]);
      break;
    end;
end;

procedure TElFunctionList.PutFunction(Index: Integer; const Value: TElFunction);
begin
  FList[Index] := Value;
end;

{ TElFunctionListGroups }

function TElFunctionListGroups.GetList(Index: Integer): TElFunctionList;
begin
  Result := TElFunctionList(FList[Index]);
end;

function TElFunctionListGroups.LookUpFunction(AName: TLMDString): TElFunction;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1  do
  begin
    Result := (FunctionLists[i].LookUpFunction(AName));
    if Assigned(Result) then
      break;
  end;
end;

procedure TElFunctionListGroups.PutList(Index: Integer; const Value: TElFunctionList);
begin
  FList[Index] := Value;
end;

{ TElArgumentList }

function TElArgumentList.GetArg(Index: Integer): TElArgument;
begin
  Result := TElArgument(FList[Index]);
end;

procedure TElArgumentList.PutArg(Index: Integer; const Value: TElArgument);
begin
  FList[Index] := Value;
end;

{ TElSinFunction }

constructor TElSinFunction.Create;
begin
  inherited;
  FName := SSin;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElSinFunction.Execute;
begin
  FResult := Sin(TElFloatArgument(Arguments[0]).Value);
end;

{ TElLogFunction }

constructor TElLogFunction.Create;
begin
  inherited;
  FName := SLog;
  FArgumentList.Add(TElFloatArgument.Create('Base'));
  FArgumentList.Add(TElFloatArgument.Create('Number'));
end;

procedure TElLogFunction.Execute;
begin
  FResult := LogN(TElFloatArgument(Arguments[0]).Value, TElFloatArgument(Arguments[1]).Value);
end;

{ TElCosFunction }

constructor TElCosFunction.Create;
begin
  inherited;
  FName := SCos;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElCosFunction.Execute;
begin
  FResult := Cos(TElFloatArgument(Arguments[0]).Value);
end;

{ TElTanFunction }

constructor TElTanFunction.Create;
begin
  inherited;
  FName := STan;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElTanFunction.Execute;
begin
  FResult := Tan(TElFloatArgument(Arguments[0]).Value);
end;

{ TElCotFunction }

constructor TElCotFunction.Create;
begin
  inherited;
  FName := SCot;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElCotFunction.Execute;
begin

  FResult := Cot(TElFloatArgument(Arguments[0]).Value);

end;

{ TElACosFunction }

constructor TElACosFunction.Create;
begin
  inherited;
  FName := SArccos;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElACosFunction.Execute;
begin
  FResult := ArcCos(TElFloatArgument(Arguments[0]).Value);
end;

{ TElASinFunction }

constructor TElASinFunction.Create;
begin
  inherited;
  FName := SArcsin;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElASinFunction.Execute;
begin
  FResult := ArcSin(TElFloatArgument(Arguments[0]).Value);
end;

{ TElLnFunction }

constructor TElLnFunction.Create;
begin
  inherited;
  FName := SLn;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElLnFunction.Execute;
begin
  FResult := Ln(TElFloatArgument(Arguments[0]).Value);
end;

{ TElLog10Function }

constructor TElLog10Function.Create;
begin
  inherited;
  FName := SLog10;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElLog10Function.Execute;
begin
  FResult := Log10(TElFloatArgument(Arguments[0]).Value);
end;

{ TElATanFunction }

constructor TElATanFunction.Create;
begin
  inherited;
  FName := SArcTan;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElATanFunction.Execute;
begin
  FResult := ArcTan(TElFloatArgument(Arguments[0]).Value);
end;

{ TElExpFunction }

constructor TElExpFunction.Create;
begin
  inherited;
  FName := SExp;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElExpFunction.Execute;
begin
  FResult := Exp(TElFloatArgument(Arguments[0]).Value);
end;

{ TElPowerFunction }

constructor TElPowerFunction.Create;
begin
  inherited;
  FName := SPower;
  FArgumentList.Add(TElFloatArgument.Create('Base'));
  FArgumentList.Add(TElFloatArgument.Create('Power'));
end;

procedure TElPowerFunction.Execute;
begin
  FResult := Power(TElFloatArgument(Arguments[0]).Value, TElFloatArgument(Arguments[1]).Value);
end;

{ TElPowerFunction }

constructor TElSqrtFunction.Create;
begin
  inherited;
  FName := SSqrt;
  FArgumentList.Add(TElFloatArgument.Create('X'));
end;

procedure TElSqrtFunction.Execute;
begin
  FResult := Sqrt(TElFloatArgument(Arguments[0]).Value);
end;

{ TElMathFunctionList }

constructor TElMathFunctionList.Create;
begin
  inherited Create;
  AutoClearObjects := true;
  FCaption := SLMDMathFunctions;
  Add(TElSinFunction.Create);
  Add(TElLogFunction.Create);
  Add(TElCosFunction.Create);
  Add(TElTanFunction.Create);
  Add(TElCotFunction.Create);
  Add(TElACosFunction.Create);
  Add(TElASinFunction.Create);
  Add(TElLnFunction.Create);
  Add(TElLog10Function.Create);
  Add(TElATanFunction.Create);
  Add(TElExpFunction.Create);
  Add(TElExpFunction.Create);
  Add(TElPowerFunction.Create);
  Add(TElSqrtFunction.Create);
end;

end.
