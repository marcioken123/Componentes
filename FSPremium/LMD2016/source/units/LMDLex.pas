unit LMDLex;
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

LMDLex unit (VO)
----------------

Base lexical analyser

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes;

type

  TLMDTokenType = (ttEOF, ttBAD, ttTEXT, ttTAG, ttTERM);

  TCharSet = set of AnsiChar;

  TLMDTokenClass = class of TLMDToken;

  { ********************************* TLMDToken ********************************}
  TLMDToken = class(TObject)
  protected
    FTokenType: TLMDTokenType;
  public
    constructor Create; virtual;
    function Clone : TLMDToken; virtual;
    property TokenType: TLMDTokenType read FTokenType write FTokenType;
  end;

  { ****************************** TLMDEofToken ********************************}
  TLMDEofToken = class(TLMDToken)
  public
    constructor Create; override;
    function Clone : TLMDToken; override;
  end;

  { ****************************** TLMDBADToken ********************************}
  TLMDBADToken = class(TLMDToken)
  public
    constructor Create; override;
    function Clone : TLMDToken; override;
  end;

  { ****************************** TLMDTextToken ******************************}
  TLMDTextToken = class(TLMDToken)
  private
    FTokenText: string;
  public
    {$WARNINGS OFF}
    constructor Create(const aTokenText: string); overload; virtual;
    constructor Create; overload; override;
    function Clone : TLMDToken; override;
    property TokenText: string read FTokenText write FTokenText;
  end;

  { ****************************** TLMDTagToken ********************************}
  TLMDTagToken = class(TLMDTextToken)
  private
    FAttributes: TStringList;
  protected
    function GetPosition(const aAttrName: String): LongInt;
    procedure SetPosition(const aAttrName: String; aValue: LongInt);
  public
    constructor Create(const aTokenText: string); override;
    constructor Create; override;
    destructor Destroy; override;
    function Clone : TLMDToken; override;
    function GetAttr(const aName: string; var aRes: string): Boolean;
    property Attributes: TStringList read FAttributes;
    property Position[const aAttrName: String]: Integer read GetPosition write SetPosition;
  end;

  { ****************************** TLMDLex **********************************}
  TLMDLex = class(TObject)
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
    function GetToken(aStream: TStream): TLMDToken; virtual; abstract;
    procedure SkipSpaces(aStream: TStream);
  end;

  TLMDLexClass = class of TLMDLex;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
  Windows,
  dialogs;
  {$I C2.INC}
{$ENDIF}

{ ****************************** TLMDToken ***********************************}
{-----------------------------------------------------------------------------}

constructor TLMDToken.Create;
begin
  inherited Create;
end;

function TLMDToken.Clone : TLMDToken;
begin
  Result:= TLMDTokenClass(ClassType).Create;
end;

{ ****************************** TLMDTagToken ********************************}
{-----------------------------------------------------------------------------}

constructor TLMDTagToken.Create(const aTokenText: string);
begin
  inherited Create(aTokenText);
  FAttributes:= TStringList.Create;
  FTokenType:= ttTAG;
end;

{-----------------------------------------------------------------------------}

constructor TLMDTagToken.Create;
begin
  inherited Create;
  FAttributes:= TStringList.Create;
  FTokenType:= ttTAG;
end;

{-----------------------------------------------------------------------------}

destructor TLMDTagToken.Destroy;
begin
  FAttributes.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDTagToken.Clone : TLMDToken;
begin
  Result := inherited Clone;
  TLMDTagToken(Result).Attributes.Assign(FAttributes);
end;

{-----------------------------------------------------------------------------}

function TLMDTagToken.GetAttr(const aName: string; var aRes: string): Boolean;
begin
  aRes := Attributes.Values[aName];
  Result := (aRes <> '');
end;

{ ********************************* TLMDEofToken *****************************}
{-----------------------------------------------------------------------------}

constructor TLMDEofToken.Create;
begin
  inherited;
  TokenType:= ttEOF;
end;

{-----------------------------------------------------------------------------}

function TLMDEofToken.Clone : TLMDToken;
begin
  Result := inherited Clone;
end;

{ ********************************* TLMDBADToken *****************************}
{-----------------------------------------------------------------------------}

constructor TLMDBADToken.Create;
begin
  inherited;
  TokenType:= ttBAD;
end;

{-----------------------------------------------------------------------------}

function TLMDBADToken.Clone : TLMDToken;
begin
  Result := inherited Clone;
end;

{ ********************************* TLMDTextToken ****************************}
{-----------------------------------------------------------------------------}

constructor TLMDTextToken.Create(const aTokenText: string);
begin
  inherited Create;
  FTokenType:= ttTEXT;
  FTokenText:= aTokenText;
end;

{-----------------------------------------------------------------------------}

constructor TLMDTextToken.Create;
begin
  inherited Create;
  FTokenType:= ttTEXT;
  FTokenText:= '';
end;

{-----------------------------------------------------------------------------}

function TLMDTextToken.Clone : TLMDToken;
begin
  Result := inherited Clone;
  TLMDTextToken(Result).TokenText := FTokenText;
end;

{ ****************************** TLMDLex **********************************}
{-----------------------------------------------------------------------------}

function TLMDLex.GetSpaceChars: TCharSet;
begin
  Result:= [' ', #9, #10, #13]
end;

{-----------------------------------------------------------------------------}
(*function TLMDLex.GetBracketChars: TCharSet;
begin Result:= [ '[', '(', '{', '<', ')', '}', ')', ']'] end; *)

{-----------------------------------------------------------------------------}

function TLMDLex.GetQuoteChars: TCharSet;
begin
  Result:= ['''', '"']
end;

{-----------------------------------------------------------------------------}

function TLMDLex.GetDelimChars: TCharSet;
begin
  Result:= {[ '&', '<', '=']  + } GetSpaceChars
end;

{-----------------------------------------------------------------------------}

function TLMDLex.GetNextChar(aStream: TStream): Char;
begin
  aStream.Read(Result, SizeOf(Char));
end;

{-----------------------------------------------------------------------------}

procedure TLMDLex.SkipSpaces(aStream: TStream);
var
  ch : Char;
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

procedure TLMDLex.BackChar(aStream: TStream);
begin
  aStream.Position := aStream.Position - SizeOf(Char);
end;

{-----------------------------------------------------------------------------}

function TLMDLex.GetWord(aStream: TStream; aDelims: TCharSet): string;
var
  C: Char;
  SS: integer;
  Dlm: TCharSet;
begin
  C:= #0;
  Result:= '';
  Dlm := aDelims + GetSpaceChars;
  SS := aStream.Size;
  repeat
    if C <> #0 then
      Result:= Result + C;
    C:= GetNextChar(aStream);
  until (C in Dlm) or (aStream.Position >= SS);
  if (aStream.Position < SS) or (C in aDelims + GetSpaceChars) then
    BackChar(aStream)
  else
    if C <> #0 then
      Result:= Result + C;
end;

{-----------------------------------------------------------------------------}

function TLMDLex.GetString(aStream: TStream; aDelims: TCharSet): string;
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
constructor TLMDLex.Create;
begin
  inherited;
  end;

{-----------------------------------------------------------------------------}
function TLMDLex.IsEof(aStream : TStream) : boolean;
begin result := (aStream.Position  >= aStream.Size); end;

procedure TLMDTagToken.SetPosition(const aAttrName: String; aValue: LongInt);
var
  i: integer;
begin
  if  Assigned(FAttributes) then
    begin
      i := FAttributes.IndexOfName(aAttrName);
      if i >= 0 then
        FAttributes.Objects[i]:= Pointer(aValue);
        end;
end;

function TLMDTagToken.GetPosition(const aAttrName: String): LongInt;
var
  i: integer;
begin
  Result := -1;
  if  Assigned(FAttributes) then
    begin
      i := FAttributes.IndexOfName(aAttrName);
      if  i >= 0  then
        Result:= LongInt(FAttributes.Objects[i]);
    end;
//  Result:= LongInt(FAttributes.Objects[FAttributes.IndexOfName(aAttrName)]);
end;
{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}
end.
