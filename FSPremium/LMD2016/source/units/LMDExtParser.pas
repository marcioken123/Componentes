unit LMDExtParser;
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

LMDExtParser unit (VO)
----------------------

Make preparsing and store results in TLMDTokenBand 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  classes, LMDParser, LMDLex, LMDBand, LMDText;

type

  TLMDEntryStage = (esOpenTag, esCloseTag,
                    esData, esDataCancel, esDataSuccess,
                    esElementSuccess, esElementFail,
                    esRollBack);

  TLMDParseFunc = function : boolean of object;
  TLMDParseAction = procedure(var aParsedText : TLMDParsedTextList; aStage : TLMDEntryStage) of object;

  { ******************************* TLMDExtParser **************************** }
  TLMDExtParser = class (TLMDParser)
  private
    FBand               : TLMDTokenBand;
    function GetPos : LongInt;
    procedure SetPos(value : LongInt);
    procedure TranslateRepeat;
    procedure TranslateBaseFont;
    procedure ApplyVariables(aToken : TLMDToken);
    function  TokenIs(aValue: TLMDTokenType): Boolean;
  protected
    FGraphicErrorEvent : TLMDGraphicErrorEvent;
    FGetVariable : TLMDGetVariableEvent;
    FEmbdControlCreated : TLMDEmbdControlEvent;
    FRepeatEvent : TLMDRepeatEvent;
    procedure Clear;
    procedure LoadFromStream(aStream : TStream);
  public
    constructor Create; override;
    destructor Destroy; override;
    function  Tag(const aName : string) : boolean;
    function  TokenText : string;
    function  TokenIsText : boolean;
    function  TokenIsTag : boolean;
    function  TokenAsTag : TLMDTagToken;
    function  ValidToken : boolean;
    function  Token : TLMDToken;
    procedure AddTag(const aName : string);
    procedure RemoveTag;
    procedure NextToken;
    procedure PrevToken;
    property Position : LongInt read GetPos write SetPos;
  end;

implementation

uses
  Windows, Sysutils;

{ ********************************* TLMDExtParser **************************** }
{------------------------------------------------------------------------------}

function TLMDExtParser.GetPos : LongInt;
begin Result := FBand.Pos end;

{------------------------------------------------------------------------------}

procedure TLMDExtParser.SetPos(value : LongInt);
begin FBand.Pos := value end;

{ ********************************* PROTECTED ******************************** }

procedure TLMDExtParser.Clear;
begin FBand.Clear end;

{------------------------------------------------------------------------------}

procedure TLMDExtParser.LoadFromStream(aStream : TStream);
var
  T : TLMDToken;
  S : string;
  lOpenSpace  : boolean;
  lCloseSpace : boolean;
begin
  FBand.Clear;
//  Lex.SkipSpaces(aStream);
  T := Lex.GetToken(aStream);
  while T.TokenType <> ttEof do
  begin
    case T.TokenType of
      ttBAD  : T.Free;
      ttTag  : begin
        if (Copy(TLMDTagToken(T).TokenText, 1, 2) = '~~') then
          FBand.Add(TLMDTextToken.Create(TLMDTagToken(T).TokenText))
        else FBand.Add(T);
      end;
      ttText :
      begin
        S := '';
        lCloseSpace := False;
        lOpenSpace := False;
        repeat
          S := S + TLMDTextToken(T).TokenText;
          T.Free;
          T := Lex.GetToken(aStream);
        until T.TokenType <> ttText;
          if S[1] = ' ' then lOpenSpace := True;
          if S[Length(S)] = ' ' then lCloseSpace := True;
          S := TrimLeft(TrimRight(S));
          if (S = '') and lOpenSpace then
          begin
            FBand.Add(TLMDTextToken.Create(' '));
            continue;
          end;
          if (S = '') then Continue;
          if lOpenSpace then S := ' ' + S;
          if lCloseSpace then S := S + ' ';
        FBand.Add(TLMDTextToken.Create(S));
        continue;
      end;
    end; {case}
//    Lex.SkipSpaces(aStream);
    T := Lex.GetToken(aStream);
  end; {while}
  FBand.Add(T);
  TranslateRepeat;
  TranslateBaseFont;
  FBand.First;
  FBand.Prev;
end;

{------------------------------------------------------------------------------}

function  TLMDExtParser.TokenIs(aValue: TLMDTokenType): Boolean;
var
  C: TLMDToken;
begin
  Result := False;
  C := Token;

  if not Assigned(C) then
    System.Exit;

  if FBand.Current.TokenType = aValue then
    Result := True;
end;

{------------------------------------------------------------------------------}

function TLMDExtParser.TokenIsText : boolean;
begin
  Result := TokenIs(ttText);
end;

{------------------------------------------------------------------------------}

function TLMDExtParser.TokenIsTag : boolean;
begin
  Result := TokenIs(ttTag);
end;

{------------------------------------------------------------------------------}

function TLMDExtParser.TokenText : string;
var
  C: TLMDToken;
begin
  Result := '';
  C := Token;

//  if not Assigned(C) then
//    Exit;
  if (C is TLMDTextToken) then
    Result := TLMDTextToken(C).TokenText;
end;

{------------------------------------------------------------------------------}

function TLMDExtParser.TokenAsTag : TLMDTagToken;
begin
  Result := TLMDTagToken(FBand.Current);
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDExtParser.Create;
begin
  inherited Create;
  FBand := TLMDTokenBand.Create;
end;

{------------------------------------------------------------------------------}

destructor TLMDExtParser.Destroy;
begin
  Clear;
  FBand.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

function TLMDExtParser.Tag(const aName : string) : boolean;
begin
  Result := False;
  if not TokenIsTag then Exit;
  if AnsiSameText(aName, TokenText) then Result := True;
  end;

{------------------------------------------------------------------------------}

procedure TLMDExtParser.AddTag(const aName : string);
begin FBand.Insert(TLMDTagToken.Create(aName)) end;

{------------------------------------------------------------------------------}

procedure TLMDExtParser.RemoveTag;
begin FBand.Remove end;

{------------------------------------------------------------------------------}

procedure TLMDExtParser.NextToken;
begin
  FBand.Next
end;

{------------------------------------------------------------------------------}

procedure TLMDExtParser.PrevToken;
begin
  FBand.Prev;
end;

{------------------------------------------------------------------------------}

function  TLMDExtParser.ValidToken : boolean;
var
  C: TLMDToken;
begin
  Result := False;
  C := Token;
  if not Assigned(C) then Exit;
  if C.TokenType = ttEOF then Exit;
  Result := True;
end;

{------------------------------------------------------------------------------}

function  TLMDExtParser.Token : TLMDToken;
begin  Result := FBand.Current end;

procedure TLMDExtParser.TranslateRepeat;
var
  I, J, tmp     : LongInt;
  RepCount      : LongInt;
  StartPos      : LongInt;
  EndPos        : LongInt;
  EntCount      : LongInt;
  TmpList       : TList;

  function RepeatOpen(aToken : TLMDToken; var aCount : LongInt) : boolean;
  var
    strVal        : string;
    E             : LongInt;
  begin
    Result := False;
    if (aToken = nil) then Exit;
    if (aToken.TokenType = ttTag) and
       SameText(TLMDTextToken(aToken).TokenText, 'REPEAT')
    then begin
      if (TLMDTagToken(aToken).Attributes.Values['COUNT'] <> '') then
        if IsVariable(TLMDTagToken(aToken).Attributes.Values['COUNT']) then
          strVal := GetVariable(Self,  TLMDTagToken(aToken).Attributes.Values['COUNT'],
            FGetVariable)
        else  strVal := TLMDTagToken(aToken).Attributes.Values['COUNT'];
      Val(strVal, aCount, E);
      if E <> 0 then aCount := 1;
      Result := True;
    end;
  end;

  function RepeatClose(aToken : TLMDToken) : boolean;
  begin
    Result := False;
    if (aToken = nil) then Exit;
    if (aToken.TokenType = ttTag) and
       SameText(TLMDTextToken(aToken).TokenText, '/REPEAT') then
      Result := True;
  end;

begin
  TmpList := TList.Create;
  try
    FBand.First;
    while not FBand.Eof do
      begin
        for I := 0 to TmpList.Count-1 do
          if assigned(TmpList[I]) then
            TLMDToken(TmpList[I]).Free;
        TmpList.Clear;
        if RepeatOpen(FBand.Current, RepCount)then
          begin
            FBand.Remove;
            StartPos := FBand.Pos;
            EndPos   := StartPos;
            EntCount := 0;
            while (not FBand.Eof) and (not (RepeatClose(FBand.Current) and (EntCount = 0))) do
              begin
                TmpList.Add(FBand.Current.Clone);
                if RepeatOpen(FBand.Current, j) then Inc(EntCount);
                if RepeatClose(FBand.Current) then Dec(EntCount);
                Inc(EndPos);
                FBand.Next;
              end;
            if not FBand.Eof then FBand.Remove;
            Dec(EndPos);

            if assigned(FRepeatEvent) then FRepeatEvent(Self, 0);

            EntCount := 0;
            for I := StartPos to EndPos-1 do
              begin
                if RepeatOpen(FBand[I], j) then Inc(EntCount);
                if RepeatClose(FBand[I]) then Dec(EntCount);
                if EntCount = 0 then ApplyVariables(FBand[I]);
              end;

            for I := 1 to RepCount-1 do
              begin
                if assigned(FRepeatEvent) then FRepeatEvent(Self, I);
                for J := 0 to TmpList.Count-1 do
                  begin
                    FBand.Insert(TLMDToken(TmpList[j]).Clone);
                    FBand.Next;
                  end;
                StartPos := EndPos;
                EndPos := EndPos + TmpList.Count;

                EntCount := 0;
                for J := StartPos to EndPos-1 do
                  begin
                    if RepeatOpen(FBand[J], tmp) then Inc(EntCount);
                    if RepeatClose(FBand[J]) then Dec(EntCount);
                    if EntCount = 0 then ApplyVariables(FBand[J]);
                  end;
              end;

            FBand.First;
          end;
        FBand.Next;
      end;
  finally
    for I := 0 to TmpList.Count-1 do
       TObject(TmpList[I]).Free;
    TmpList.Free;
  end;
end;

procedure TLMDExtParser.TranslateBaseFont;
var
  C: TLMDToken;
begin
  FBand.First;
  while not FBand.Eof do
    begin
      C := FBand.Current;
      if assigned(C) then
        if C.TokenType = ttTag then
          if SameText(TLMDTagToken(C).TokenText, '/BASEFONT') then
            begin
              TLMDTagToken(C).TokenText := 'CLOSEBASEFONT';
              TLMDTagToken(C).Attributes.Clear;
            end;
      FBand.Next;
    end;
end;

procedure TLMDExtParser.ApplyVariables(aToken : TLMDToken);
var
  I             : LongInt;
  TagToken      : TLMDTagToken;
  TextToken     : TLMDTextToken;
  VarName       : string;
begin
  if (aToken = nil) then Exit;

  if (aToken is TLMDTagToken) then
    begin
      TagToken := TLMDTagToken(aToken);
      for I := 0 to TagToken.Attributes.Count -1  do
        begin
          VarName := TagToken.Attributes.Names[I];
          if IsVariable(TagToken.Attributes.Values[VarName]) then
            TagToken.Attributes.Values[VarName] :=
              GetVariable(Self, TagToken.Attributes.Values[VarName], FGetVariable);
        end;
    end
  else if (aToken is TLMDTextToken) then
    begin
      TextToken := TLMDTextToken(aToken);
      if IsVariable(TextToken.TokenText) then
        TextToken.TokenText := GetVariable(Self, TextToken.TokenText, FGetVariable);
    end;
end;

end.
