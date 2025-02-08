Unit LMDMathParser;
{$i lmdcmps.inc}

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

LMDMathParser unit (AH)
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

Interface

uses
  Classes, SysUtils, Math, Variants,
  LMDList, LMDUnicode, LMDTypes;

type
  ELMDMathException = class(Exception);

  TLMDMathErrorEvent = procedure(Sender: TObject; AError: String) of object;

  TTokenType = (DELIMITER, NUMBER, VARIABLE, COMMAND, CHARS, NONE);

  TLMDArgument = class(TPersistent)
  private
    FError: Integer;
    FName: TLMDString;
  public
    constructor Create(AName: TLMDString);
    procedure AssignValue(AValue: Variant); virtual; abstract;
    function IsValid: Boolean;
    property Name: TLMDString read FName;
  end;

  TLMDIntegerArgument = class(TLMDArgument)
  protected
    FValue: Integer;
  public
    procedure AssignValue(AValue: Variant); override;
    property Value: Integer read FValue;
  end;

  TLMDFloatArgument = class(TLMDArgument)
  protected
    FValue: Extended;
  public
    procedure AssignValue(AValue: Variant); override;
    property Value: Extended read FValue;
  end;

  TLMDStringArgument = class(TLMDArgument)
  protected
    FValue: TLMDString;
  public
    procedure AssignValue(AValue: Variant); override;
    property Value: TLMDString read FValue;
  end;

  TLMDArgumentList = class(TList)
  private
    function GetArg(Index: Integer): TLMDArgument;
    procedure PutArg(Index: Integer; const Value: TLMDArgument);
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    property Arguments[Index: Integer]: TLMDArgument read GetArg write PutArg; default;
  end;

  TLMDFunction = class(TPersistent)
  protected
    FName: TLMDString;
    FResult: Variant;
    FArgumentList: TLMDArgumentList;
    function Get(Index: Integer): TLMDArgument;
    function GetArgumentCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; virtual; abstract;
    property Name: TLMDString read FName;
    property ArgumentCount: Integer read GetArgumentCount;
    property Arguments[Index: Integer]: TLMDArgument read Get; default;
    property Result: Variant read FResult;
  end;

  TLMDSinFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDLogFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDCosFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDTanFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDCotFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDACosFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDASinFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDLnFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDLog10Function = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDATanFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDExpFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDPowerFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDSqrtFunction = class(TLMDFunction)
  public
    constructor Create;
    procedure Execute; override;
  end;

  TLMDFunctionList = class(TList)
  private
    FCaption: TLMDString;
  protected
    function GetFunction(Index: Integer): TLMDFunction;
    procedure PutFunction(Index: Integer; const Value: TLMDFunction);
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    function LookUpFunction(AName: TLMDString): TLMDFunction;
    property Caption: TLMDString read FCaption write FCaption;
    property Functions[Index: Integer]: TLMDFunction read GetFunction write PutFunction; default;
  end;

  TLMDMathFunctionList = class(TLMDFunctionList)
  public
    constructor Create;
    //destructor Destroy; override;
  end;

  TLMDFunctionListGroups = class(TList)
  private
    function GetList(Index: Integer): TLMDFunctionList;
    procedure PutList(Index: Integer; const Value: TLMDFunctionList);
  protected 
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    function LookUpFunction(AName: TLMDString): TLMDFunction;
    property FunctionLists[Index: Integer]: TLMDFunctionList read GetList write PutList; default;
  end;

  TLMDMathParser = class(TPersistent)
  private
    procedure SetExpr(const Value: TLMDString);
  protected
    FCommand: TLMDFunction;
    FExpr: TLMDString;
    Prog: Integer;
    Token: TLMDString;
    TokType: TTokenType;
    FVariables: TStrings;
    FFunctionListGroups: TLMDFunctionListGroups;
    FArgumentDelimiters: TLMDString;
    FOnParseError: TLMDMathErrorEvent;

    function EvalExp: Extended;
    function IsAlpha(c: TLMDChar): Boolean;
    function IsDelimiter(c: TLMDChar): Boolean;
    function IsDigit(c: TLMDChar): Boolean;
    function IsSpace(c: TLMDChar): Boolean;
    function IsQuote(c: TLMDChar): Boolean;
    function GetResult: Variant;
    function LookUp(S: String): TLMDFunction;
    procedure Atom(var Res: Extended);
    procedure EvalExp2(var Res: Extended);
    procedure EvalExp3(var Res: Extended);
    procedure EvalExp4(var Res: Extended);
    procedure EvalExp5(var Res: Extended);
    procedure EvalExp6(var Res: Extended);
    procedure GetToken;
    procedure PutBack;
    procedure SError(Num: Byte);
    procedure SetVariables(const Value:TStrings);
  public
    constructor Create; overload;
    constructor Create(const AExpr: string); overload;
    destructor Destroy; override;
    property Expression: TLMDString read FExpr Write SetExpr;
    property Result: Variant read GetResult;
    property FunctionListGroups: TLMDFunctionListGroups read FFunctionListGroups write FFunctionListGroups;
    property Variables: TStrings read FVariables Write SetVariables;
    property ArgumentDelimiters: TLMDString read FArgumentDelimiters write FArgumentDelimiters;
    property OnParseError: TLMDMathErrorEvent read FOnParseError write FOnParseError;
  end;

const
  CArgumentDelimiters = ',;';

implementation
uses
  LMDConst;

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

Constructor TLMDMathParser.Create;
begin
  inherited;
  Prog := 1;
  FExpr := '';
  Token := '';
  TokType := NONE;

  FVariables := TStringList.Create;

  FFunctionListGroups := TLMDFunctionListGroups.Create;
  //FFunctionListGroups.AutoClearObjects := true;

  FFunctionListGroups.Add(TLMDMathFunctionList.Create);
end;

constructor TLMDMathParser.Create(const AExpr: string);
begin
  Create;
  FExpr := AExpr;
end;

procedure TLMDMathParser.SetExpr(const Value: TLMDString);
begin
  FExpr := Value;
  Prog := 1;
end;

Procedure TLMDMathParser.EvalExp2;
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

Procedure TLMDMathParser.EvalExp3;
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

Procedure TLMDMathParser.EvalExp4;
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

Procedure TLMDMathParser.EvalExp5;
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

Procedure TLMDMathParser.EvalExp6;
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

Procedure TLMDMathParser.Atom;
var
  Code, i: integer;
  temp: Extended;
  LOld: TLMDFunction;
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

Procedure TLMDMathParser.GetToken;
begin
  TokType := NONE;
  Token := '';

  if FExpr <> '' then
  begin
    while (Prog <= Length(FExpr))
      and IsSpace(FExpr[Prog]) do
      inc(Prog);

    if not (Prog <= Length(FExpr)) then Exit;

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
        While (Prog <= Length(FExpr)) and
          (not IsDelimiter(FExpr[Prog])) do
        begin
          if Prog <= Length(FExpr) then
            Token := Token + FExpr[Prog];
          Inc(Prog);
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
        While (Prog <= Length(FExpr)) and
          (not IsDelimiter(FExpr[Prog])) do
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
        While (Prog <= Length(FExpr)) and
          (not IsQuote(FExpr[Prog])) do
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

Procedure TLMDMathParser.SError;
const
  ErrCount = 5;
begin
  if Assigned(OnParseError) then
  begin
    case Num of
    0: OnParseError(nil, IDS_SyntaxError);
    1: OnParseError(nil, IDS_CloseBracketExpected);
    2: OnParseError(nil, IDS_ExpressionEmpty);
    3: OnParseError(nil, IDS_OpenBracketExpected);
    4: OnParseError(nil, IDS_InvalidArgument);
    end;
  end
  else
    case Num of
    0: raise ELMDMathException.Create(IDS_SyntaxError);
    1: raise ELMDMathException.Create(IDS_CloseBracketExpected);
    2: raise ELMDMathException.Create(IDS_ExpressionEmpty);
    3: raise ELMDMathException.Create(IDS_OpenBracketExpected);
    4: raise ELMDMathException.Create(IDS_InvalidArgument);
    end;
end;

Procedure TLMDMathParser.PutBack;
begin
  Dec(Prog,Length(Token));
  Token := '';
end;

function TLMDMathParser.IsSpace(c: TLMDChar): boolean;
begin
  Result := Boolean(AnsiChar(c) in [' ', #9]);
end;

Function TLMDMathParser.IsDelimiter;
begin
  Result := Boolean(Pos(c, FArgumentDelimiters) <> 0) or Boolean(AnsiChar(c) in ['+', '-', '*', '/', '^', '!', '=', '(', ')', #10, #13, #9, #0, #32]);
end;

Function TLMDMathParser.IsAlpha;
begin
  Result := Boolean(AnsiChar(c) in ['A'..'Z', 'a'..'z']);
end;

Function TLMDMathParser.IsDigit;
begin
  IsDigit := Boolean(AnsiChar(c) in ['0'..'9']);
end;

function TLMDMathParser.IsQuote(c: TLMDChar): Boolean;
begin
  IsQuote := Boolean(AnsiChar(c) in [#39, '"']);
end;

Function TLMDMathParser.LookUp;
begin
  Result := FFunctionListGroups.LookUpFunction(S);
end;

function TLMDMathParser.EvalExp;
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

Destructor TLMDMathParser.Destroy;
begin
  FVariables.Free;
  FVariables := nil;
  FFunctionListGroups.Free;
  FFunctionListGroups := nil;
  inherited;
end;

function TLMDMathParser.GetResult: Variant;
begin
  Result := EvalExp;
  Prog := 1;
end;

procedure TLMDMathParser.SetVariables(const Value: TStrings);
begin
  if FVariables.Text <> Value.Text then
    FVariables.Text := Value.Text;
end;

{ TLMDFunction }

constructor TLMDFunction.Create;
begin
  inherited;
  FArgumentList := TLMDArgumentList.Create;
end;

destructor TLMDFunction.Destroy;
begin
  inherited;
  FArgumentList.Free;
end;

function TLMDFunction.Get(Index: Integer): TLMDArgument;
begin
  Result := TLMDArgument(FArgumentList.Items[Index]);
end;

function TLMDFunction.GetArgumentCount: Integer;
begin
  Result := FArgumentList.Count;
end;

{ TLMDIntegerArgument }

procedure TLMDIntegerArgument.AssignValue(AValue: Variant);
begin
  FError := 0;
  try
    FValue := StrToInt(AValue);
  except
    FError := -1;
  end;
end;

{ TLMDFloatArgumnet }

procedure TLMDFloatArgument.AssignValue(AValue: Variant);
begin
  FError := 0;
  try
    FValue := StrToFloat(AValue);
  except
    FError := -1;
  end;
end;

{ TLMDStringArgument }

procedure TLMDStringArgument.AssignValue(AValue: Variant);
begin
  FError := 0;
  try
    FValue := AValue;
  except
    FError := -1;
  end;
end;

{ TLMDArgument }

constructor TLMDArgument.Create(AName: TLMDString);
begin
  inherited Create;
  FName := AName;
end;

function TLMDArgument.IsValid: boolean;
begin
  Result := (FError = 0);
end;

function TLMDFunctionList.GetFunction(Index: Integer): TLMDFunction;
begin
  Result := TLMDFunction(Self.Items[Index]);
end;

function TLMDFunctionList.LookUpFunction(AName: TLMDString): TLMDFunction;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Self.Count - 1 do
    if (UpperCase(TLMDFunction(Self.Items[i]).Name) = UpperCase(AName)) then
    begin
      Result := TLMDFunction(Self.Items[i]);
      break;
    end;
end;

procedure TLMDFunctionList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;
  if Action = lnDeleted then
     if Assigned(Ptr) then TLMDFunction(Ptr).Free;
end;

procedure TLMDFunctionList.PutFunction(Index: Integer; const Value: TLMDFunction);
begin
  Self.Items[Index] := Value;
end;

{ TLMDFunctionListGroups }

function TLMDFunctionListGroups.GetList(Index: Integer): TLMDFunctionList;
begin
  Result := TLMDFunctionList(Self.Items[Index]);
end;

function TLMDFunctionListGroups.LookUpFunction(AName: TLMDString): TLMDFunction;
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

procedure TLMDFunctionListGroups.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;
  if Action = lnDeleted then
     if Assigned(Ptr) then TLMDFunctionList(Ptr).Free;
end;

procedure TLMDFunctionListGroups.PutList(Index: Integer; const Value: TLMDFunctionList);
begin
  Self.Items[Index] := Value;
end;

{ TLMDArgumentList }

function TLMDArgumentList.GetArg(Index: Integer): TLMDArgument;
begin
  Result := TLMDArgument(Self.Items[Index]);
end;

procedure TLMDArgumentList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;
  if Action = lnDeleted then
    if Assigned(Ptr) then TLMDArgument(Ptr).Free;
end;

procedure TLMDArgumentList.PutArg(Index: Integer; const Value: TLMDArgument);
begin
  Self.Items[Index] := Value;
end;

{ TLMDSinFunction }

constructor TLMDSinFunction.Create;
begin
  inherited;
  FName := SSin;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDSinFunction.Execute;
begin
  FResult := Sin(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDLogFunction }

constructor TLMDLogFunction.Create;
begin
  inherited;
  FName := SLog;
  FArgumentList.Add(TLMDFloatArgument.Create('Base'));
  FArgumentList.Add(TLMDFloatArgument.Create('Number'));
end;

procedure TLMDLogFunction.Execute;
begin
  FResult := LogN(TLMDFloatArgument(Arguments[0]).Value, TLMDFloatArgument(Arguments[1]).Value);
end;

{ TLMDCosFunction }

constructor TLMDCosFunction.Create;
begin
  inherited;
  FName := SCos;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDCosFunction.Execute;
begin
  FResult := Cos(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDTanFunction }

constructor TLMDTanFunction.Create;
begin
  inherited;
  FName := STan;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDTanFunction.Execute;
begin
  FResult := Tan(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDCotFunction }

constructor TLMDCotFunction.Create;
begin
  inherited;
  FName := SCot;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDCotFunction.Execute;
begin
  FResult := Cot(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDACosFunction }

constructor TLMDACosFunction.Create;
begin
  inherited;
  FName := SArccos;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDACosFunction.Execute;
begin
  FResult := ArcCos(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDASinFunction }

constructor TLMDASinFunction.Create;
begin
  inherited;
  FName := SArcsin;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDASinFunction.Execute;
begin
  FResult := ArcSin(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDLnFunction }

constructor TLMDLnFunction.Create;
begin
  inherited;
  FName := SLn;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDLnFunction.Execute;
begin
  FResult := Ln(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDLog10Function }

constructor TLMDLog10Function.Create;
begin
  inherited;
  FName := SLog10;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDLog10Function.Execute;
begin
  FResult := Log10(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDATanFunction }

constructor TLMDATanFunction.Create;
begin
  inherited;
  FName := SArcTan;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDATanFunction.Execute;
begin
  FResult := ArcTan(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDExpFunction }

constructor TLMDExpFunction.Create;
begin
  inherited;
  FName := SExp;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDExpFunction.Execute;
begin
  FResult := Exp(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDPowerFunction }

constructor TLMDPowerFunction.Create;
begin
  inherited;
  FName := SPower;
  FArgumentList.Add(TLMDFloatArgument.Create('Base'));
  FArgumentList.Add(TLMDFloatArgument.Create('Power'));
end;

procedure TLMDPowerFunction.Execute;
begin
  FResult := Power(TLMDFloatArgument(Arguments[0]).Value, TLMDFloatArgument(Arguments[1]).Value);
end;

{ TLMDPowerFunction }

constructor TLMDSqrtFunction.Create;
begin
  inherited;
  FName := SSqrt;
  FArgumentList.Add(TLMDFloatArgument.Create('X'));
end;

procedure TLMDSqrtFunction.Execute;
begin
  FResult := Sqrt(TLMDFloatArgument(Arguments[0]).Value);
end;

{ TLMDMathFunctionList }

constructor TLMDMathFunctionList.Create;
begin
  inherited;
  //AutoClearObjects := true;
  FCaption := IDS_MathFunctions;
  Add(TLMDSinFunction.Create);
  Add(TLMDLogFunction.Create);
  Add(TLMDCosFunction.Create);
  Add(TLMDTanFunction.Create);
  Add(TLMDCotFunction.Create);
  Add(TLMDACosFunction.Create);
  Add(TLMDASinFunction.Create);
  Add(TLMDLnFunction.Create);
  Add(TLMDLog10Function.Create);
  Add(TLMDATanFunction.Create);
  Add(TLMDExpFunction.Create);
  Add(TLMDExpFunction.Create);
  Add(TLMDPowerFunction.Create);
  Add(TLMDSqrtFunction.Create);
end;

end.
