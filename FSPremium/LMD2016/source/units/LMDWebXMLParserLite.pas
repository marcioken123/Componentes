unit LMDWebXMLParserLite;
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

LMDWebXMLParserLite unit (DD)
-----------------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDWebXML;

type

  { **************************TLMDXMLParserLite**************************** }
  {$M+}
  TLMDXMLParserLite = class
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

implementation

uses

  SysUtils, Classes, LMDWebLex,
  LMDWebHTMLLex, LMDFSSupport;

{ **************************TLMDXMLParserLite**************************** }

{-----------------------------------------------------------------------------}
constructor TLMDXMLParserLite.Create;
begin
  inherited;
  FXMLTags := TLMDXMLTags.Create;
end;

{-----------------------------------------------------------------------------}
destructor TLMDXMLParserLite.Destroy;
begin
  FXMLTags.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}
function TLMDXMLParserLite.Encode(const szString: string): string;
begin
  if FEncoding = 'UTF-8' then
    Result := String(Utf8Encode(szString))
  else
    Result := szString;
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLParserLite.Parse(const XML: string);
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
                  if SameText(TLMDWebTagToken(T).TokenText, '?XML') then
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
procedure TLMDXMLParserLite.SetEncoding(const Value: string);
begin
  FEncoding := Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLParserLite.SetXMLTags(const Value: TLMDXMLTags);
begin
  FXMLTags.Assign(Value);
end;

end.
