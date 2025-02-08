unit LMDStorXMLSupport;
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

LMDStorXMLSupport unit (VO)
--------------------------

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils,
  LMDStorCommon;

type
  TLMDStorXMLTags = class;

  {-------------------- Class TLMDXMLStorTag ----------------------------------}
  TLMDStorXMLTag = class(TCollectionItem)
  private
    FName: string;
    FSubTags: TLMDStorXMLTags;
    FAttributes: TStringList;
    FText: string;
    FExAttributes: TStringList;
    procedure SetAttributes(const Value: TStringList);
    procedure SetName(const Value: string);
    procedure SetSubTags(const Value: TLMDStorXMLTags);
    procedure SetText(const Value: string);
    procedure SetExAttributes(const Value: TStringList);
    function GetAttribute(Name: string): string;
    procedure SetAttribute(Name: string; const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure  Assign(Source: TPersistent); override;
    procedure  SetQuotes;
    property Attribute[Name:string]:string read GetAttribute write SetAttribute;
  published
    property Name: string read FName write SetName;
    property Text: string read FText write SetText;
    property ExAttributes: TStringList read FExAttributes write SetExAttributes;
    property Attributes: TStringList read FAttributes write SetAttributes;
    property SubTags: TLMDStorXMLTags read FSubTags write SetSubTags;
  end;

  {-------------------- Class TLMDXMLStorTags ---------------------------------}
  TLMDStorXMLTags = class(TCollection)
  private
    function GetItems(Index: integer): TLMDStorXMLTag;
  public
    constructor Create;
    function Add: TLMDStorXMLTag;
    function FindByName(szName: String; bMatchCase: Boolean = false;
     bFindInSubTree: Boolean = false): TLMDStorXMLTag;
    property Items[Index: integer]: TLMDStorXMLTag read GetItems; default;
  end;

  {-------------------- Class TLMDStorXML -------------------------------------}
  TLMDStorXML = class
  private
    FXMLTags: TLMDStorXMLTags;
    FEncoding: string;
    FHeader: String;
    FFooter: String;
    procedure SetXMLStorTags(const Value: TLMDStorXMLTags);
    procedure SetEncoding(const Value: string);
    procedure SaveTag(Tag: TLMDStorXMLTag; List: TStrings; Level: Integer);
  protected
    function Encode(szString: string): string; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Parse(XML: String);
    procedure SaveToStrings(TS: TSTrings);
    procedure SaveToFile(FileName: String);
    procedure Clear;
//  published - Class should derived from TPersistant for published
    property XMLTags: TLMDStorXMLTags read FXMLTags write SetXMLStorTags;
    property Encoding: string read FEncoding write SetEncoding;
    property Header: String read FHeader write FHeader;
    property Footer: String read FFooter write FFooter;
  end;

{$WARNINGS OFF}
  TLMDStorCharSet = set of Char;
{$WARNINGS ON}
  TLMDStorTokenType = (ttEOF, ttBAD, ttTEXT, ttTAG, ttTERM);
  TLMDStorTokenClass = class of TLMDStorToken;

  {-------------------- Class TLMDStorToken -----------------------------------}
  TLMDStorToken = class
  protected
    FTokenType: TLMDStorTokenType;
  public
    constructor Create; virtual;
    function Clone: TLMDStorToken; virtual;
    property TokenType: TLMDStorTokenType read FTokenType write FTokenType;
  end;

  {-------------------- Class TLMDStorLex -------------------------------------}
  TLMDStorLex = class
  protected
    function GetDelimChars: TLMDStorCharSet; virtual;
    function GetQuoteChars: TLMDStorCharSet; virtual;
    function GetSpaceChars: TLMDStorCharSet; virtual;

    function IsEof(aStream : TStream) : boolean;

    procedure BackChar(aStream: TStream);
    function GetNextChar(aStream: TStream): Char;
    function GetWord(aStream: TStream; aDelims: TLMDStorCharSet): string;
    function GetString(aStream: TStream; aDelims: TLMDStorCharSet): string;
  public
    constructor Create; virtual;
    function GetToken(aStream: TStream): TLMDStorToken; virtual; abstract;
    procedure SkipSpaces(aStream: TStream);
  end;

  {-------------------- Class TLMDStorEofToken --------------------------------}
  TLMDStorEofToken = class(TLMDStorToken)
    constructor Create; override;
    function Clone : TLMDStorToken; override;
  end;

  {-------------------- Class TLMDStorHTMLLex ---------------------------------}
  TLMDStorHTMLLex = class(TLMDStorLex)
  protected
    function GetDelimChars: TLMDStorCharSet; override;
  public
    function GetToken(aStream: TStream): TLMDStorToken; override;
  end;

  {-------------------- Class TLMDStorTextToken -------------------------------}
  TLMDStorTextToken = class(TLMDStorToken)
  private
    FTokenText: string;
  public
    {$WARNINGS OFF}
    constructor Create(aTokenText: string); overload; virtual;
    constructor Create; overload; override;
    function Clone : TLMDStorToken; override;
    property TokenText: string read FTokenText write FTokenText;
  end;

  {-------------------- Class TLMDStorTagToken --------------------------------}
  TLMDStorTagToken = class(TLMDStorTextToken)
    FAttributes: TStringList;
  protected
    function GetPosition(aAttrName: String): LongInt;
    procedure SetPosition(aAttrName: String; aValue: LongInt);
  public
    constructor Create(aTokenText: string); override;
    constructor Create; override;
    destructor Destroy; override;
    function Clone : TLMDStorToken; override;
    property Attributes: TStringList read FAttributes;
    property Position[aAttrName: String]: Integer read GetPosition
     write SetPosition;
  end;

implementation

// helper functions
{------------------------------------------------------------------------------}
function SetOffset(Level: Integer): String;
var
  i : integer;
begin
  Result := '';
  for i := 0 to Level * 8 - 1 do
    Result := Result + ' ';
end;

{------------------------------------------------------------------------------}
function SetQuotesForAttribute(Attribute: String): String;
var
  position: integer;
  Key, Value: String;
begin
  Result := Attribute;
  position := pos('=', Attribute);
  if position = 0 then exit;
  Key := copy(Attribute, 1, position - 1);
  if position = length(Attribute) then Value := '' else
   Value := copy(Attribute, position + 1, length(Attribute) - position);
  if (Length(Value) > 0) and (Value[1] <> '"') then Value := '"' + Value;
  if (Length(Value) > 0) and (Value[Length(Value)] <> '"') then Value := Value + '"';
  Result := Key + '=' + Value;
end;

{------------------------------------------------------------------------------}
function GetAttributes(Tag: TLMDStorXMLTag): String;
var
  i: integer;
begin
  Result := ' ';
  for i := 0 to Tag.Attributes.Count - 1 do
   Result := Result + SetQuotesForAttribute(Tag.Attributes[i]) + ' ';
  Result := Trim(Result);
  if Length(Result) > 0 then Result := ' ' + Result;
end;

{********************* TLMDStorXMLTag *****************************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorXMLTag.SetAttributes(const Value: TStringList);
begin
  FAttributes.Assign(Value);
  SetQuotes;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXMLTag.SetName(const Value: string);
begin
  FName := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXMLTag.SetSubTags(const Value: TLMDStorXMLTags);
begin
  FSubTags.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXMLTag.SetText(const Value: string);
begin
  FText := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXMLTag.SetExAttributes(const Value: TStringList);
begin
  FExAttributes.Assign(Value);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorXMLTag.Create(Collection: TCollection);
begin
  inherited;
  FAttributes   := TStringList.Create;
  FSubTags      := TLMDStorXMLTags.Create;
  FExAttributes := TStringList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDStorXMLTag.Destroy;
begin
  FAttributes.Free;
  FExAttributes.Free;
  FSubTags.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXMLTag.Assign(Source: TPersistent);
begin
  if Source is TLMDStorXMLTag then
  begin
    with TLMDStorXMLTag(Source) do
    begin
      Self.FName := FName;
      Self.FText := FText;
      Self.ExAttributes := ExAttributes;
      Self.Attributes := Attributes;
      Self.SubTags := SubTags;
    end;
  end
  else
    inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDStorXMLTag.SetQuotes;
var i:integer;
begin
  for i:=0 to FAttributes.count-1 do
    FAttributes[i]:=SetQuotesForAttribute(FAttributes[i]);
end;

{********************* TLMDXMLStorTags ****************************************}
{------------------------- Private --------------------------------------------}
function TLMDStorXMLTags.GetItems(Index: integer): TLMDStorXMLTag;
begin
  Result := TLMDStorXMLTag(inherited Items[Index]);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorXMLTags.Create;
begin
  inherited Create(TLMDStorXMLTag);
end;

{-----------------------------------------------------------------------------}
function TLMDStorXMLTags.Add: TLMDStorXMLTag;
begin
  Result := TLMDStorXMLTag(inherited Add);
end;

{-----------------------------------------------------------------------------}
function TLMDStorXMLTags.FindByName(szName: String; bMatchCase: Boolean;
  bFindInSubTree: Boolean): TLMDStorXMLTag;
var
  i: Integer;
  function Cmp(S1, S2: String): Boolean;
  begin
    if bMatchCase then
      Result := S1 = S2
    else
      Result := UpperCase(S1) = UpperCase(S2);
  end;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Cmp(Items[i].Name, szName) then
    begin
      Result := Items[i];
      break;
    end;
  if (Result = nil) and bFindInSubTree then
    for i := 0 to Count - 1 do
    begin
      Result := Items[i].SubTags.FindByName(szName, bMatchCase, True);
      if Result <> nil then
        break;
    end;
end;

{********************* TLMDStorXML ********************************************}
{------------------------- Private --------------------------------------------}
procedure TLMDStorXML.SetXMLStorTags(const Value: TLMDStorXMLTags);
begin
  FXMLTags.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXML.SetEncoding(const Value: string);
begin
  FEncoding := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXML.SaveTag(Tag: TLMDStorXMLTag; List: TStrings; Level: Integer);
var
  i: integer;
begin
  if trim(Tag.Name) = '' then exit;
  if Tag.SubTags.Count > 0 then
  begin
    List.Add(SetOffset(Level) + '<' + Tag.Name + GetAttributes(Tag) + '>'
     + Tag.Text);
    for i := 0 to Tag.SubTags.Count - 1 do
     SaveTag(Tag.SubTags[i], List, Level + 1);
    List.Add(SetOffset(Level) + '</' + Tag.Name + '>');
  end else
    List.Add(SetOffset(Level) + '<' + Tag.Name + GetAttributes(Tag) + '>' +
     Tag.Text + '</' + Tag.Name + '>');
end;

{------------------------- Protected ------------------------------------------}
function TLMDStorXML.Encode(szString: string): string;
begin
  if FEncoding = 'UTF-8' then
    Result := utf8toAnsi(szString)
  else
  Result := szString;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorXML.Create;
begin
  inherited;
  FXMLTags := TLMDStorXMLTags.Create;
end;

{-----------------------------------------------------------------------------}
destructor TLMDStorXML.Destroy;
begin
  FXMLTags.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}
procedure TLMDStorXML.Parse(XML: String);
var
  Lex:   TLMDStorHTMLLex;
  MS:    TMemoryStream;
  T:     TLMDStorToken;
  Item:  TLMDStorXMLTag;
  Tags:  TLMDStorXMLTags;
  Stack: TList;
begin
  FEncoding := '';
  FXMLTags.Clear;
  Tags  := FXMLTags;
  Lex   := TLMDStorHTMLLex.Create;
  MS    := TMemoryStream.Create;
  Stack := TList.Create;
  try
    Item    := nil;
    MS.Size := Length(XML) * SizeOf(Char);
    // implicit convert String to AnsiString for D2009
    Move(XML[1], MS.Memory^, MS.Size);
    with Lex do
    begin
      while True do
      begin
        T := Lex.GetToken(MS);
        case T.TokenType of
          ttEOF: break;
          ttTAG:
          begin
            if TLMDStorTagToken(T).TokenText <> '' then
              case TLMDStorTagToken(T).TokenText[1] of
                '?':
                begin
                  if UpperCase(TLMDStorTagToken(T).TokenText) = '?XML' then
                  begin
                    FEncoding := TLMDStorTagToken(T).Attributes.Values['ENCODING'];
                  end;
                end;
                '!':
                begin
                  if Copy(TLMDStorTagToken(T).TokenText, 1,3) <> '!--' then
                  begin
                    if Item<>nil then
                      Item.ExAttributes.Add(TLMDStorTagToken(T).TokenText);
                  end;
                end;
                '/':
                begin
                  if Item <> nil then
                  begin
                    if Stack.Count = 0 then
                    begin
                      Item := nil;
                      Tags := FXMLTags;
                    end
                    else
                    begin
                      Item := TLMDStorXMLTag(Stack[Stack.Count - 1]);
                      Stack.Delete(Stack.Count - 1);
                      Tags := TLMDStorXMLTags(Item.Collection);
                      Item.SetQuotes;
                    end;
                  end;
                end;
                else
                begin
                  if Item <> nil then
                  begin
                    Stack.Add(Item);
                    Tags := Item.SubTags;
                  end;
                  Item := Tags.Add;
                  with Item do
                  begin
                    Name       := Encode(TLMDStorTagToken(T).TokenText);
                    Attributes := TLMDStorTagToken(T).Attributes;
                    SetQuotes;
                  end;
                end;
              end;
          end;
          ttTEXT:
          begin
            if Item <> nil then
              Item.Text := Item.Text + Encode(TLMDStorTextToken(T).TokenText);
          end;
        end;
        FreeAndNil(T);
      end;
    end;
  finally
    if T<>nil then
      FreeAndNil(T);
    Stack.Free;
    Lex.Free;
    MS.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXML.SaveToStrings(TS: TSTrings);
var
  i: integer;
begin
  if not Assigned(TS) then exit;
  TS.Clear;
  if Trim(Header) <> '' then
  begin
    TS.Add(Header);
    TS.Add('');
  end;
  for i := 0 to XMLTags.Count - 1 do SaveTag(XMLTags[i], TS, 0);
  if Trim(Footer) <> '' then
  begin
    TS.Add('');
    TS.Add(Footer);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXML.SaveToFile(FileName: String);
var
  TS: TStrings;
begin
  TS := TStringList.Create;
  try
    SaveToStrings(TS);
  finally
    TS.SaveToFile(FileName);
    FreeAndNil(TS);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorXML.Clear;
begin
  XMLTags.Clear;
end;

{ ****************************** TLMDStorToken ********************************}
{------------------------- Public ---------------------------------------------}
constructor TLMDStorToken.Create;
begin
  inherited Create;
end;

{------------------------------------------------------------------------------}
function TLMDStorToken.Clone : TLMDStorToken;
begin
  Result:= TLMDStorTokenClass(ClassType).Create;
end;

{ ****************************** TLMDStorLex **********************************}
{------------------------- Protected ------------------------------------------}
function TLMDStorLex.GetDelimChars: TLMDStorCharSet;
begin
  Result:= {[ '&', '<', '=']  + } GetSpaceChars
end;

{-----------------------------------------------------------------------------}
function TLMDStorLex.GetQuoteChars: TLMDStorCharSet;
begin
  Result := ['''', '"']
end;

{-----------------------------------------------------------------------------}
function TLMDStorLex.GetSpaceChars: TLMDStorCharSet;
begin
  Result := [' ', #9, #10, #13]
end;

{------------------------------------------------------------------------------}
function TLMDStorLex.IsEof(aStream: TStream): boolean;
begin
  result := (aStream.Position >= aStream.Size);
end;

{-----------------------------------------------------------------------------}
procedure TLMDStorLex.BackChar(aStream: TStream);
begin
  aStream.Position := aStream.Position - sizeof(char);
end;

{-----------------------------------------------------------------------------}
function TLMDStorLex.GetNextChar(aStream: TStream): Char;
begin
  aStream.Read(Result, sizeof(char));
end;

{-----------------------------------------------------------------------------}
function TLMDStorLex.GetWord(aStream: TStream; aDelims: TLMDStorCharSet): string;
var
  C: Char;
begin
  C := #0;
  Result := '';
  repeat
    if C <> #0 then
      Result := Result + C;
    C := GetNextChar(aStream);
  until (C in aDelims + GetSpaceChars) or (aStream.Position >= aStream.Size);
  if (aStream.Position < aStream.Size) or (C in aDelims + GetSpaceChars) then
    BackChar(aStream)
  else
    if C <> #0 then
      Result := Result + C;
end;

{-----------------------------------------------------------------------------}

function TLMDStorLex.GetString(aStream: TStream; aDelims: TLMDStorCharSet): string;
var
  C, C1: Char;
begin
  Result := '';
  C:= GetNextChar(aStream);
  if C in GetQuoteChars then // quoted text
    begin
      C1 := C;
      C := #0;
      repeat
        if C <> #0 then
          Result := Result + C;
        C := GetNextChar(aStream);
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
constructor TLMDStorLex.Create;
begin
  inherited;
end;

{-----------------------------------------------------------------------------}
procedure TLMDStorLex.SkipSpaces(aStream: TStream);
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

{ ****************************** TLMDStorEofToken *****************************}
{------------------------- Protected ------------------------------------------}
constructor TLMDStorEofToken.Create;
begin
  inherited;
  TokenType := ttEOF;
end;

{-----------------------------------------------------------------------------}
function TLMDStorEofToken.Clone: TLMDStorToken;
begin
  Result := inherited Clone;
end;

{ ****************************** TLMDStorHTMLLex ******************************}
{------------------------------------------------------------------------------}
function TLMDStorHTMLLex.GetDelimChars: TLMDStorCharSet;
begin
  Result := ['<', '=', '>'] + GetSpaceChars
end;

{------------------------- Public ---------------------------------------------}
function TLMDStorHTMLLex.GetToken(aStream: TStream): TLMDStorToken;
var
  C: Char;
  S: string;
  avPos: LongInt;
begin
  if aStream.Position >= aStream.Size then
    begin
      Result:= TLMDStorEofToken.Create;
      exit;
    end;
  C := GetNextChar(aStream);
  if C in GetSpaceChars then
    begin
      BackChar(aStream);
      SkipSpaces(aStream);
      Result := TLMDStorTextToken.Create(' ');
      exit;
    end;

  // Check TAG
  if C = '<' then // Tag started
    begin
      S := GetWord(aStream, [{'<',}'>'] + GetQuoteChars);
      if S = '' then // check close tag
        begin
          C := GetNextChar(aStream);
          if C = '/' then
            S := '/' + GetWord(aStream, [{'<',}'>'] + GetQuoteChars);
        end;
      // Check EOF
      if aStream.Position >= aStream.Size then
        begin
          Result := TLMDStorEofToken.Create;
          exit;
        end;

      if Copy(S, 1, 3) = '!--' then // comments
        begin
          S:= Copy(S, 4, length(S));
          Result := TLMDStorTagToken.Create('!--');
          if Pos('--', S) <> 0 then
            begin
              if GetNextChar(aStream) = '>' then
                begin
                  exit;
                end
              else
                BackChar(aStream);
            end;
          S := '   ';
          repeat
            S := S + GetNextChar(aStream);
          until (Pos('-->',S) <> 0) or (aStream.Position >= aStream.Size);
          TLMDStorTagToken(Result).Attributes.Add(Copy(S, 1, Length(S) - 1));
          exit;
        end;

      Result := TLMDStorTagToken.Create(S);
      repeat
        //Parse TAG Attributes
        SkipSpaces(aStream);
        if aStream.Position >= aStream.Size then
          exit;
        C := GetNextChar(aStream);
        if C = '>' then
          exit;
        BackChar(aStream);
        S := GetString(aStream, ['=', '>']); // Get ATTR name
        SkipSpaces(aStream);
        if aStream.Position >= aStream.Size then
          exit;
        C := GetNextChar(aStream);
        if C = '>' then
          exit;
        if C <> '=' then
          begin
            BackChar(aStream);
            continue; // BAD
          end;
        SkipSpaces(aStream);
        if aStream.Position >= aStream.Size then
          exit;
        C := GetNextChar(aStream);
        if (C  in [ '''', '"']) then
          avPos := aStream.Position
        else
          avPos := aStream.Position+1;
        BackChar(aStream);
        (Result as TLMDStorTagToken).Attributes.Values[S]:=
          GetString(aStream, ['>']); // Get ATTR value
        TLMDStorTagToken(Result).Position[S] := avPos;
      until false;
    end
  else
    begin
      BackChar(aStream);
      S := GetWord(aStream, ['<' {, '>'}] { + GetQuoteChars});
      if S <> '' then
        Result := TLMDStorTextToken.Create(S)
      else
        Result := GetToken(aStream);
    end;
end;

{ ****************************** TLMDStorTextToken ****************************}
{------------------------- Public ---------------------------------------------}
constructor TLMDStorTextToken.Create(aTokenText: string);
begin
  inherited Create;
  FTokenType := ttTEXT;
  FTokenText := aTokenText;
end;

{-----------------------------------------------------------------------------}
constructor TLMDStorTextToken.Create;
begin
  inherited Create;
  FTokenType := ttTEXT;
  FTokenText := '';
end;

{-----------------------------------------------------------------------------}
function TLMDStorTextToken.Clone: TLMDStorToken;
begin
  Result := inherited Clone;
  TLMDStorTextToken(Result).TokenText := FTokenText;
end;

{ ****************************** TLMDStorTagToken *****************************}
{------------------------- Protected ------------------------------------------}
function TLMDStorTagToken.GetPosition(aAttrName: String): LongInt;
begin
  Result:= LongInt(FAttributes.Objects[FAttributes.IndexOfName(aAttrName)]);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorTagToken.SetPosition(aAttrName: String; aValue: LongInt);
begin
  if FAttributes.IndexOfName(aAttrName) >= 0 then
    FAttributes.Objects[FAttributes.IndexOfName(aAttrName)] := TObject(aValue);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDStorTagToken.Create(aTokenText: string);
begin
  inherited Create(aTokenText);
  FAttributes := TStringList.Create;
  FTokenType := ttTAG;
end;

{------------------------------------------------------------------------------}
constructor TLMDStorTagToken.Create;
begin
  inherited Create;
  FAttributes := TStringList.Create;
  FAttributes.Sorted := True;
  FAttributes.Duplicates := dupIgnore;
  FTokenType := ttTAG;
end;

{-----------------------------------------------------------------------------}
destructor TLMDStorTagToken.Destroy;
begin
  FAttributes.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}
function TLMDStorTagToken.Clone: TLMDStorToken;
begin
  Result := inherited Clone;
  TLMDStorTagToken(Result).Attributes.Assign(FAttributes);
end;

{-----------------------------------------------------------------------------}
function TLMDStorXMLTag.GetAttribute(Name: string): string;
begin
  Result := FAttributes.Values[Name];
end;

{-----------------------------------------------------------------------------}
procedure TLMDStorXMLTag.SetAttribute(Name: string; const Value: string);
var
  s : string;
begin
  s := Value;
  if (Length(s) > 0) and (s[1] <> '"') then
    s := '"' + s;
  if (Length(s) > 0) and (s[Length(s)] <> '"') then
    s := s + '"';
  FAttributes.Values[Name] := s;
end;

end.
