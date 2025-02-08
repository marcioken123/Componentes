unit LMDWebXMLParser;
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

LMDWebXMLParser unit (DD)
-------------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDWebXML;

type

  { **************************TLMDXMLParser**************************** }
  {$M+}
  TLMDXMLParser = class
  private
    FXMLTags: TLMDXMLTags;
    FEncoding: string;
    procedure SetXMLTags(const Value: TLMDXMLTags);
    procedure SetEncoding(const Value: string);
  protected
    function Encode(const szString: string): string; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Parse(const XML: string);
  published
    property XMLTags: TLMDXMLTags read FXMLTags write SetXMLTags;
    property Encoding: string read FEncoding write SetEncoding;
  end;
  {$M-}

function Utf8Decode(const S: UTF8String): WideString;
function Utf8ToAnsi(const S: UTF8String): string;

implementation

uses
  Classes, SysUtils,

  LMDWebHTMLLex, LMDWebLex, LMDFSSupport;

{ **************************TLMDXMLParser**************************** }

{-----------------------------------------------------------------------------}
constructor TLMDXMLParser.Create;
begin
  inherited;
  FXMLTags := TLMDXMLTags.Create;
end;

{-----------------------------------------------------------------------------}
destructor TLMDXMLParser.Destroy;
begin
  FXMLTags.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}
function TLMDXMLParser.Encode(const szString: string): string;
begin
  if FEncoding = 'UTF-8' then
    Result := utf8toAnsi(szString)
  else
    Result := szString;
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLParser.Parse(const XML: string);
var
  Lex:   TLMDWebHTMLLex;
  MS:    TMemoryStream;
  T:     TLMDWebToken;
  Item:  TLMDXMLTag;
  Tags:  TLMDXMLTags;
  Stack: TList;
begin
  FEncoding := '';
  FXMLTags.Clear;
  Tags  := FXMLTags;
  Lex   := TLMDWebHTMLLex.Create;
  MS    := TMemoryStream.Create;
  Stack := TList.Create;
  try
    Item    := nil;
    LMDWebStringToStream(MS, XML);
    MS.Position := 0;

    with Lex do
    begin
      while True do
      begin
        T := Lex.GetToken(MS);
        case T.TokenType of
          ttEOF:
            begin
              T.Free;
              break;
            end;
          ttTAG:
          begin
            if TLMDWebTagToken(T).TokenText <> '' then
              case TLMDWebTagToken(T).TokenText[1] of
                '?':
                begin
                  if UpperCase(TLMDWebTagToken(T).TokenText) = '?XML' then
                  begin
                    FEncoding := TLMDWebTagToken(T).Attributes.Values['ENCODING'];
                  end;
                end;
                '!':
                begin
                  if Copy(TLMDWebTagToken(T).TokenText, 1,3)<>'!--' then
                  begin
                    if Item<>nil then
                      Item.ExAttributes.Add(TLMDWebTagToken(T).TokenText);
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
                      Item := TLMDXMLTag(Stack[Stack.Count - 1]);
                      Stack.Delete(Stack.Count - 1);
                      Tags := TLMDXMLTags(Item.Collection);
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
                    Name       := Encode(TLMDWebTagToken(T).TokenText);
                    Attributes := TLMDWebTagToken(T).Attributes;
                  end;
                end;
              end;
          end;
          ttTEXT:
          begin
            if Item <> nil then
              Item.Text := Item.Text + Encode(TLMDWebTextToken(T).TokenText);
          end;
        end;
      end;
    end;
  finally
    Stack.Free;
    Lex.Free;
    MS.Free;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLParser.SetEncoding(const Value: string);
begin
  FEncoding := Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLParser.SetXMLTags(const Value: TLMDXMLTags);
begin
  FXMLTags.Assign(Value);
end;

{-----------------------------------------------------------------------------}

function Utf8ToUnicode(Dest: PWideChar; MaxDestChars: cardinal; Source: PChar; SourceBytes: cardinal): cardinal;
var
  i, Count: cardinal;
  c:        byte;
  wc:       cardinal;
begin
  if Source = nil then
  begin
    Result := 0;
    Exit;
  end;
  Result := cardinal(-1);
  Count  := 0;
  i      := 0;
  if Dest <> nil then
  begin
    while (i < SourceBytes) and (Count < MaxDestChars) do
    begin
      wc := cardinal(Source[i]);
      Inc(i);
      if (wc and $80) <> 0 then
      begin
        wc := wc and $3F;
        if i > SourceBytes then Exit;           // incomplete multibyte char
        if (wc and $20) <> 0 then
        begin
          c := byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then  Exit;     // malformed trail byte or out of range char
          if i > SourceBytes then Exit;         // incomplete multibyte char
          wc := (wc shl 6) or (c and $3F);
        end;
        c := byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte
        Dest[Count] := widechar((wc shl 6) or (c and $3F));
      end
      else
        Dest[Count] := widechar(wc);
      Inc(Count);
    end;
    if Count >= MaxDestChars then Count := MaxDestChars - 1;
    Dest[Count] := #0;
  end
  else
  begin
    while (i <= SourceBytes) do
    begin
      c := byte(Source[i]);
      Inc(i);
      if (c and $80) <> 0 then
      begin
        if (c and $F0) = $F0 then Exit;  // too many bytes for UCS2
        if (c and $40) = 0 then Exit;    // malformed lead byte
        if i > SourceBytes then Exit;         // incomplete multibyte char
        if (byte(Source[i]) and $C0) <> $80 then Exit;  // malformed trail byte
        Inc(i);
        if i > SourceBytes then Exit;         // incomplete multibyte char
        if ((c and $20) <> 0) and ((byte(Source[i]) and $C0) <> $80) then Exit; // malformed trail byte
        Inc(i);
      end;
      Inc(Count);
    end;
  end;
  Result := Count + 1;
end;

{-----------------------------------------------------------------------------}
function Utf8Decode(const S: UTF8String): WideString;
var
  L:    integer;
  Temp: widestring;
begin
  Result := '';
  if S = '' then Exit;
  SetLength(Temp, Length(S));
  L := Utf8ToUnicode(PWideChar(Temp), Length(Temp) + 1, PChar(S), Length(S));
  if L > 0 then
    SetLength(Temp, L - 1)
  else
    Temp := '';
  Result := Temp;
end;

{-----------------------------------------------------------------------------}
function Utf8ToAnsi(const S: UTF8String): string;
begin
  Result := Utf8Decode(S);
end;
end.
