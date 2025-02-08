unit LMDWebLex;
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

LMDWebLex unit (VO)
--------------------
Base lexical analyser

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils;

type

  TLMDWebTokenType = (ttEOF, ttBAD, ttTEXT, ttTAG, ttTERM);

  TCharSet = TSysCharSet;//set of Char;

  TLMDWebTokenClass = class of TLMDWebToken;

  { ********************************* TLMDToken ********************************}
  TLMDWebToken = class
  protected
    FTokenType: TLMDWebTokenType;
  public
    constructor Create; virtual;
    function Clone : TLMDWebToken; virtual;
    property TokenType: TLMDWebTokenType read FTokenType write FTokenType;
  end;

  { ****************************** TLMDEofToken ********************************}
  TLMDWebEofToken = class(TLMDWebToken)
    constructor Create; override;
    function Clone : TLMDWebToken; override;
  end;

  { ****************************** TLMDBADToken ********************************}
  TLMDWebBADToken = class(TLMDWebToken)
    constructor Create; override;
    function Clone : TLMDWebToken; override;
  end;

  { ****************************** TLMDTextToken ******************************}
  TLMDWebTextToken = class(TLMDWebToken)
  private
    FTokenText: string;
  public
    {$WARNINGS OFF}
    constructor Create(aTokenText: string); overload; virtual;
    constructor Create; overload; override;
    function Clone : TLMDWebToken; override;
    property TokenText: string read FTokenText write FTokenText;
  end;

  { ****************************** TLMDTagToken ********************************}
  TLMDWebTagToken = class(TLMDWebTextToken)
    FAttributes: TStringList;
  protected
    function GetPosition(aAttrName: String): LongInt;
    procedure SetPosition(aAttrName: String; aValue: LongInt);
  public
    constructor Create(aTokenText: string); override;
    constructor Create; override;
    destructor Destroy; override;
    function Clone : TLMDWebToken; override;
    property Attributes: TStringList read FAttributes;
    property Position[aAttrName: String]: Integer read GetPosition write SetPosition;
  end;

  { ****************************** TLMDLex **********************************}
  TLMDWebLex = class
  protected
    {    function GetBracketChars: TCharSet; virtual; }
    function GetDelimChars: TCharSet; virtual;
    function GetQuoteChars: TCharSet; virtual;
    function GetSpaceChars: TCharSet; virtual;

    function IsEof(aStream : TStream) : boolean;

    procedure BackChar(aStream: TStream);
    function GetNextChar(aStream: TStream): Char;
    function GetWord(aStream: TStream; aDelims: TCharSet): string;
    function GetString(aStream: TStream; aDelims: TCharSet): string;
  public
    constructor Create; virtual;
    function GetToken(aStream: TStream): TLMDWebToken; virtual; abstract;
    procedure SkipSpaces(aStream: TStream);
  end;

  TLMDWebLexClass = class of TLMDWebLex;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
  dialogs, Windows;
  {$I C2.INC}
{$ENDIF}

{ ****************************** TLMDToken ***********************************}
{-----------------------------------------------------------------------------}

constructor TLMDWebToken.Create;
begin
  inherited Create;
end;

function TLMDWebToken.Clone : TLMDWebToken;
begin
  Result:= TLMDWebTokenClass(ClassType).Create;
end;

{ ****************************** TLMDTagToken ********************************}
{-----------------------------------------------------------------------------}

constructor TLMDWebTagToken.Create(aTokenText: string);
begin
  inherited Create(aTokenText);
  FAttributes:= TStringList.Create;
  FTokenType:= ttTAG;
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebTagToken.Create;
begin
  inherited Create;
  FAttributes:= TStringList.Create;
  FTokenType:= ttTAG;
end;

{-----------------------------------------------------------------------------}

destructor TLMDWebTagToken.Destroy;
begin
  FAttributes.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDWebTagToken.Clone: TLMDWebToken;
begin
  Result := inherited Clone;
  TLMDWebTagToken(Result).Attributes.Assign(FAttributes);
end;

{ ********************************* TLMDEofToken *****************************}
{-----------------------------------------------------------------------------}

constructor TLMDWebEofToken.Create;
begin
  inherited;
  TokenType:= ttEOF;
end;

{-----------------------------------------------------------------------------}

function TLMDWebEofToken.Clone: TLMDWebToken;
begin
  Result := inherited Clone;
end;

{ ********************************* TLMDBADToken *****************************}
{-----------------------------------------------------------------------------}

constructor TLMDWebBADToken.Create;
begin
  inherited;
  TokenType:= ttBAD;
end;

{-----------------------------------------------------------------------------}

function TLMDWebBADToken.Clone: TLMDWebToken;
begin
  Result := inherited Clone;
end;

{ ********************************* TLMDWebTextToken *************************}
{-----------------------------------------------------------------------------}

constructor TLMDWebTextToken.Create(aTokenText: string);
begin
  inherited Create;
  FTokenType:= ttTEXT;
  FTokenText:= aTokenText;
end;

{-----------------------------------------------------------------------------}

constructor TLMDWebTextToken.Create;
begin
  inherited Create;
  FTokenType:= ttTEXT;
  FTokenText:= '';
end;

{-----------------------------------------------------------------------------}

function TLMDWebTextToken.Clone: TLMDWebToken;
begin
  Result := inherited Clone;
  TLMDWebTextToken(Result).TokenText := FTokenText;
end;

{ ****************************** TLMDWebLex **********************************}
{-----------------------------------------------------------------------------}

function TLMDWebLex.GetSpaceChars: TCharSet;
begin
  Result:= [' ', #9, #10, #13]
end;

{-----------------------------------------------------------------------------}
(*function TLMDLex.GetBracketChars: TCharSet;
begin Result:= [ '[', '(', '{', '<', ')', '}', ')', ']'] end; *)

{-----------------------------------------------------------------------------}

function TLMDWebLex.GetQuoteChars: TCharSet;
begin
  Result:= ['''', '"']
end;

{-----------------------------------------------------------------------------}

function TLMDWebLex.GetDelimChars: TCharSet;
begin
  Result:= {[ '&', '<', '=']  + } GetSpaceChars
end;

{-----------------------------------------------------------------------------}

function TLMDWebLex.GetNextChar(aStream: TStream): Char;
begin
  aStream.Read(Result, SizeOf(Char));
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebLex.SkipSpaces(aStream: TStream);
var
  ch : char;
begin
  if aStream.Position < aStream.Size then
  repeat
    ch := GetNextChar(aStream);
    if not (ch in GetSpaceChars) then
      begin
        BackChar(aStream);
        Exit;
      end;
    if aStream.Position >= aStream.Size then
      Exit;
  until False;
end;

{-----------------------------------------------------------------------------}

procedure TLMDWebLex.BackChar(aStream: TStream);
begin
  aStream.Position:= aStream.Position - SizeOf(Char);
end;

{-----------------------------------------------------------------------------}

function TLMDWebLex.GetWord(aStream: TStream; aDelims: TCharSet): string;
var
  C: Char;
begin
  C:= #0;
  Result:= '';
  repeat
    if C <> #0 then
      Result:= Result + C;
    C:= GetNextChar(aStream);
  until (C in aDelims + GetSpaceChars) or (aStream.Position >= aStream.Size);
  if (aStream.Position < aStream.Size) or (C in aDelims + GetSpaceChars) then
    BackChar(aStream)
  else
    if C <> #0 then
      Result:= Result + C;
end;

{-----------------------------------------------------------------------------}

function TLMDWebLex.GetString(aStream: TStream; aDelims: TCharSet): string;
var
  C, C1: Char;
begin
  Result:= '';
  C:= GetNextChar(aStream);
  if C in GetQuoteChars then // quoted text
    begin
      C1:= C;
      C:= #0;
      repeat
        if C <> #0 then
          Result:= Result + C;
        C:= GetNextChar(aStream);
      until (C = C1) or (aStream.Position >= aStream.Size) or (C = #13) or (C =
        #10);
    end
  else
    begin // no quotes
      BackChar(aStream);
      Result:= GetWord(aStream, aDelims);
    end;
end;

{-----------------------------------------------------------------------------}
constructor TLMDWebLex.Create;
begin
  inherited;
end;

{-----------------------------------------------------------------------------}
function TLMDWebLex.IsEof(aStream : TStream) : boolean;
begin result := (aStream.Position  >= aStream.Size); end;

procedure TLMDWebTagToken.SetPosition(aAttrName: String; aValue: LongInt);
begin
  if FAttributes.IndexOfName(aAttrName) >= 0 then
    FAttributes.Objects[FAttributes.IndexOfName(aAttrName)]:= TObject(aValue);
end;

function TLMDWebTagToken.GetPosition(aAttrName: String): LongInt;
begin
  Result:= LongInt(FAttributes.Objects[FAttributes.IndexOfName(aAttrName)]);
end;
{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.

