unit LMDHTMLObjectUnit;
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

LMDHTMLObjectUnit unit (DD)
---------------------------

Changes
-------
Release 2010R2 (October 2010)
[+] Added options to download css and script files

Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDWebHTMLLex, LMDWebLex;

type

  TLMDHTMLLinkType = (LT_NONE, LT_HREF, LT_IMAGE, LT_BODY, LT_FRAME, LT_CLASS,
                      LT_LINK, LT_SCRIPT);

  { **************************TLMDHTMLObject**************************** }
  TLMDHTMLObject = class;

  { **************************TLMDHTMLLink**************************** }
  TLMDHTMLLink = class(TCollectionItem)
  private
    FClassCode: string;
    FCodeBase: string;
    FURL: string;
    FSourcePos: integer;
    FLinkType: TLMDHTMLLinkType;
    FLocal: boolean;
    FLocalFile: string;
    procedure SetURL(const Value: string);
    procedure SeTLMDHTMLLinkType(const Value: TLMDHTMLLinkType);
    function GetURL: string;
    function GetWebURL: string;
    procedure SetClassCode(const Value: string);
    procedure SetCodeBase(const Value: string);
    function GetWebURLOnly: string;
  public
    procedure Read(Reader: TReader);
    procedure Write(Writer: TWriter);
    constructor Create(Collection: TCollection); override;
    property WebURL: string read GetWebURL;
    property WebURLOnly: string read GetWebURLOnly;
  published
    property LinkType: TLMDHTMLLinkType read FLinkType write SeTLMDHTMLLinkType;
    property URL: string read GetURL write SetURL;
    property SourcePos: integer read FSourcePos write FSourcePos;
    property Local: boolean read FLocal write FLocal;
    property LocalFile: string read FLocalFile write FLocalFile;
    property ClassCode: string read FClassCode write SetClassCode;
    property CodeBase: string read FCodeBase write SetCodeBase;
  end;

  { **************************TLMDHTMLLinks**************************** }
  TLMDHTMLLinks = class(TCollection)
  private
    FHTMLObject: TLMDHTMLObject;
    function GetLink(Index: integer): TLMDHTMLLink;
    function GetIndexOf(URL: string): integer;
    function GetIndexOfWeb(URL: string): integer;
  public
    procedure Read(Reader: TReader);
    procedure Write(Writer: TWriter);
    constructor Create(HTMLObject: TLMDHTMLObject);
    function Add: TLMDHTMLLink;
    property IndexOf[URL: string]: integer read GetIndexOf;
    property IndexOfWeb[URL: string]: integer read GetIndexOfWeb;
    property Link[Index: integer]: TLMDHTMLLink read GetLink; default;
  end;

  { **************************TLMDHTMLItem**************************** }
  TLMDHTMLItem = class(TCollectionItem)
  private
    FiType: integer;
    FValue: string;
    FName: string;
    procedure SetiType(const Value: integer);
    procedure SetName(const Value: string);
    procedure SetValue(const Value: string);
  published
    property Name: string read FName write SetName;
    property iType: integer read FiType write SetiType;
    property Value: string read FValue write SetValue;
  end;

  { **************************TLMDHTMLItems**************************** }
  TLMDHTMLItems = class(TCollection)
  private
    function GetItems(Index: integer): TLMDHTMLItem;
  public
    constructor Create;
    function Add: TLMDHTMLItem;
    function FindByName(Name: string): TLMDHTMLItem;
    property Items[Index: integer]: TLMDHTMLItem read GetItems; default;
  end;
  TLMDLinkConversion = (lcNone, lcOnline, lcOffline);

  { **************************TLMDHTMLObject**************************** }
  TLMDHTMLObject = class(TPersistent)
  private
    FHTML: string;
    FLinks: TLMDHTMLLinks;
    FBaseURL: string;
    FLocalURL: string;
    FTitle: string;
    FLinkConversion: TLMDLinkConversion;
    FItems: TLMDHTMLItems;
    procedure SetLinks(const Value: TLMDHTMLLinks);
    procedure SetHTML(const Value: string);
    function GetHTML: string;
    procedure SetTitle(const Value: string);
    procedure SeTLMDLinkConversion(const Value: TLMDLinkConversion);
    procedure SetItems(const Value: TLMDHTMLItems);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Read(Reader: TReader);
    procedure Write(Writer: TWriter);
    property HTML: string read GetHTML write SetHTML;
    property BaseURL: string read FBaseURL write FBaseURL;
    property LocalURL: string read FLocalURL write FLocalURL;
  published
    property Title: string read FTitle write SetTitle;
    property HTMLPrototype: string read FHTML write FHTML;
    property Links: TLMDHTMLLinks read FLinks write SetLinks;
    property Items: TLMDHTMLItems read FItems write SetItems;
    property LinkConversion: TLMDLinkConversion read FLinkConversion write
      SeTLMDLinkConversion;
  end;

implementation

uses
  Windows, SysUtils, WinInet,
  LMDStringsSupport, LMDFSSupport, LMDProcs;
  {-----------------------------------------------------------------------------}

function ProcessString(const Value: string): string;
var
  i: integer;
begin
  Result:= '';
  for i:= 1 to Length(Value) do
    if not (AnsiChar(Value[i]) in ['''', '"', #4, #1]) then
      Result:= Result + Value[i];
end;

{ **************************TLMDHTMLObject**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDHTMLObject.Clear;
begin
  FTitle:= '';
  FHTML:= '';
  HTMLPrototype:= '';
  FLinks.Clear;
end;

{-----------------------------------------------------------------------------}

constructor TLMDHTMLObject.Create;
begin
  inherited;
  FHTML:= '';
  FLinks:= TLMDHTMLLinks.Create(Self);
  FItems:= TLMDHTMLItems.Create;
  FBaseURL:= '';
  FLocalURL:= '';
  FLinkConversion:= lcOffline;
end;

{-----------------------------------------------------------------------------}

destructor TLMDHTMLObject.Destroy;
begin
  FItems.Free;
  FLinks.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}

function ListSort(Item1, Item2: Pointer): integer;
begin
  Result:= TLMDHTMLLink(Item1).SourcePos - TLMDHTMLLink(Item2).SourcePos;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLObject.GetHTML: string;
var
  i: integer;
  iPos: integer;
  SL: TList;
begin
  Result:= '';
  SL:= TList.Create;
  for i:= 0 to Links.Count - 1 do
    begin
      SL.Add(Links[i]);
    end;
  SL.Sort(ListSort);
  iPos:= 1;
  for i:= 0 to SL.Count - 1 do
    begin
      if TLMDHTMLLink(SL[i]).LinkType = LT_CLASS then
        Result:= Result + Copy(FHTML, iPos, TLMDHTMLLink(SL[i]).SourcePos - iPos)
          + TLMDHTMLLink(SL[i]).ClassCode
      else
        Result:= Result + Copy(FHTML, iPos, TLMDHTMLLink(SL[i]).SourcePos - iPos)
          + TLMDHTMLLink(SL[i]).URL;
      iPos:= TLMDHTMLLink(SL[i]).SourcePos;
    end;
  Result:= Result + Copy(FHTML, iPos, Length(FHTML) - iPos + 1);
  SL.Free;
end;

{-----------------------------------------------------------------------------}

function  int_ReadByte(Reader: TReader): integer;
var
  B: byte;
begin

  Reader.Read(B, sizeof(B));

  Result := B;
end;

procedure int_WriteByte(Writer: TWriter; B: byte);
begin
  Writer.Write(B, sizeof(B));
end;

procedure TLMDHTMLObject.Read(Reader: TReader);
begin
  with Reader do
    begin
      FTitle:= ReadString;
      FHTML:= ReadString;
      FLinkConversion := TLMDLinkConversion(int_ReadByte(Reader));
//      Read(FLinkConversion, sizeof(LinkConversion));
      FLinks.Read(Reader);
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLObject.SetHTML(const Value: string);
var
  HParser: TLMDWebHTMLLex;
  MS: TMemoryStream;
  T: TLMDWebToken;
  Link: TLMDHTMLLink;
  Item: TLMDHTMLItem;
  iPos: integer;
  iCorrect: integer;
  i: integer;
  i1, i2: integer;
  iTitle: integer;
  iTokenPos: integer;

  function AddPrototype(const TokenString: string; TokenCharPos: integer): integer;
  begin
    with HParser do
      begin
        FHTML:= FHTML + Copy(Value, iPos, TokenCharPos - iPos+1);
        Inc(iCorrect, Length(TokenString));
        Result:= Length(FHTML)+1;
        iPos:= Result + iCorrect;
      end;
  end;

var
  TokenText: string;
  TagToken: TLMDWebTagToken;
begin
  Clear;
  HParser:= TLMDWebHTMLLex.Create;
  MS:= TMemoryStream.Create;

  try
    LMDWebStringToStream(MS, Value);
    MS.Position := 0;
    FHTML:= '';
    iPos:= 1;
    iCorrect:= 0;
    iTitle:= 0;
    with HParser do
      while True do
        begin
          Item:= nil;
          iTokenPos:= MS.Position;
          T:= HParser.GetToken(MS);
          case T.TokenType of
            ttEOF:
              begin
                T.Free;
                break;
              end;
            ttTAG:
              begin
                TagToken := (T as TLMDWebTagToken);
                TokenText := TagToken.TokenText;
                if SameText(TokenText, 'TITLE') then
                  begin
                    iTitle:= MS.Position;
                  end
                else
                if SameText(TokenText, '/TITLE') then
                  begin
                    if iTitle <> 0 then
                      FTitle:= Copy(Value, iTitle + 1, iTokenPos - iTitle);
                  end
                else
                if SameText(TokenText, 'A') then
                  begin
                    Link:= FLinks.Add;
                    Link.LinkType:= LT_HREF;
                    Link.URL:= TagToken.Attributes.Values['HREF'];
                    if TagToken.Attributes.IndexOfName('HREF') >= 0 then
                      Link.SourcePos:= AddPrototype(
                          TagToken.Attributes.Values['HREF'],
                          TagToken.Position['HREF']);
                  end
                else
                if SameText(TokenText, 'IMG') then
                  begin
                    Link:= FLinks.Add;
                    Link.LinkType:= LT_IMAGE;
                    Link.URL:= TagToken.Attributes.Values['SRC'];
                    if TagToken.Attributes.IndexOfName('SRC') >= 0 then
                      Link.SourcePos:= AddPrototype(
                        TagToken.Attributes.Values['SRC'],
                        TagToken.Position['SRC']);
                  end
                else
                if SameText(TokenText, 'SCRIPT') then
                  begin
                    if TagToken.Attributes.IndexOfName('SRC') >= 0 then
                    begin
                      Link:= FLinks.Add;
                      Link.LinkType:= LT_SCRIPT;
                      Link.URL:= TagToken.Attributes.Values['SRC'];
                      Link.SourcePos:= AddPrototype(
                        TagToken.Attributes.Values['SRC'],
                        TagToken.Position['SRC']);
                    end;
                  end
                else
                if SameText(TokenText, 'LINK') then
                  begin
                    Link:= FLinks.Add;
                    Link.LinkType:= LT_LINK;
                    Link.URL:= TagToken.Attributes.Values['HREF'];
                    if TagToken.Attributes.IndexOfName('HREF') >= 0 then
                      Link.SourcePos:= AddPrototype(
                        TagToken.Attributes.Values['HREF'],
                        TagToken.Position['HREF']);
                  end
                else
                if SameText(TokenText, 'FRAME') then
                  begin
                    Link:= FLinks.Add;
                    Link.LinkType:= LT_FRAME;
                    Link.URL:= TagToken.Attributes.Values['SRC'];
                    if TagToken.Attributes.IndexOfName('SRC') >= 0 then
                      Link.SourcePos:= AddPrototype(
                        TagToken.Attributes.Values['SRC'],
                        TagToken.Position['SRC']);
                  end
                else
                if SameText(TokenText, 'BODY') then
                  begin
                    Link:= FLinks.Add;
                    Link.LinkType:= LT_BODY;
                    Link.URL:= TagToken.Attributes.Values['BACKGROUND'];
                    if TagToken.Attributes.IndexOfName('BACKGROUND') >= 0 then
                      Link.SourcePos:= AddPrototype(
                        TagToken.Attributes.Values['BACKGROUND'],
                        TagToken.Position['BACKGROUND']);
                  end
                else
                if SameText(TokenText, 'APPLET') then
                  begin
                    Link:= FLinks.Add;
                    Link.LinkType:= LT_CLASS;
                    Link.CodeBase:= TagToken.Attributes.Values['CODEBASE'];
                    Link.ClassCode:= TagToken.Attributes.Values['CODE'];
                    Link.URL:= Link.CodeBase + Link.ClassCode;
                    i1:= TagToken.Attributes.IndexOfName('CODEBASE');
                    if i1 >= 0 then
                      i1:= TagToken.Position['CODEBASE'];
                    i2:= TagToken.Attributes.IndexOfName('CODE');
                    if i2 >= 0 then
                      i2:= TagToken.Position['CODE'];
                    if i1 > i2 then
                      begin
                        if i2 >= 0 then
                          Link.SourcePos:= AddPrototype(
                            TagToken.Attributes.Values['CODE'],
                            TagToken.Position['CODE']);
                        if i1 >= 0 then
                          begin
                            with FLinks.Add do
                              begin
                                LinkType:= LT_NONE;
                                URL:= Link.CodeBase;
                                SourcePos:= AddPrototype(
                                  TagToken.Attributes.Values['CODEBASE'],
                                  TagToken.Position['CODEBASE']);
                                ;
                                Local:= True;
                                LocalFile:= Link.CodeBase;
                              end;
                          end;
                      end
                    else
                      begin
                        if i1 >= 0 then
                          begin
                            with FLinks.Add do
                              begin
                                LinkType:= LT_NONE;
                                URL:= Link.CodeBase;
                                SourcePos:= AddPrototype(
                                  TagToken.Attributes.Values['CODEBASE'],
                                  TagToken.Position['CODEBASE']);
                                ;
                                Local:= True;
                                LocalFile:= Link.CodeBase;
                              end;
                          end;
                        if i2 >= 0 then
                          Link.SourcePos:= AddPrototype(
                            TagToken.Attributes.Values['CODE'],
                            TagToken.Position['CODE']);
                      end
                  end
                else
                if SameText(TokenText, 'INPUT') then
                  begin
                    Item:= FItems.Add;
                  end;
                if Item <> nil then
                  begin
                    if TagToken.Attributes.IndexOfName('NAME') >= 0
                      then
                      begin
                        Item.Name:= ProcessString(
                          TagToken.Attributes.Values['NAME']);
                      end;
                    if TagToken.Attributes.IndexOfName('VALUE') >= 0 then
                      begin
                        Item.Value:= ProcessString(
                          TagToken.Attributes.Values['VALUE']);
                      end;
                  end;
              end;
          end;
          T.Free;
        end;
    FHTML:= FHTML + Copy(Value, iPos, Length(Value) - iPos + 1);
    i:= 0;
    while i < Links.Count do
      begin
        if Links[i].FSourcePos > 0 then
          Inc(i)
        else
          Links[i].Free;
      end;
  finally
    MS.Free;
    HParser.Free;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLObject.SetItems(const Value: TLMDHTMLItems);
begin
  FItems:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLObject.SeTLMDLinkConversion(const Value: TLMDLinkConversion);
begin
  FLinkConversion:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLObject.SetLinks(const Value: TLMDHTMLLinks);
begin
  FLinks.Assign(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLObject.SetTitle(const Value: string);
begin
  FTitle:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLObject.Write(Writer: TWriter);
begin
  with Writer do
    begin
      WriteString(FTitle);
      WriteString(FHTML);
      int_WriteByte(Writer, byte(FLinkConversion));
//      Write(FLinkConversion, sizeof(FLinkConversion));
      FLinks.Write(Writer);
    end;
end;

{ **************************TLMDHTMLLink**************************** }
{-----------------------------------------------------------------------------}

constructor TLMDHTMLLink.Create(Collection: TCollection);
begin
  inherited;
  FLocal:= False;
  FLocalFile:= '';
  FClassCode:= '';
  FCodeBase:= '';
  FSourcePos:= -1;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLLink.GetURL: string;
var
  szBaseURL: string;
  szURL: string;
  i: integer;
begin
  if TLMDHTMLLinks(Collection).FHTMLObject.LinkConversion = lcNone then
    Result:= FURL
  else
    if FLocal and (TLMDHTMLLinks(Collection).FHTMLObject.LinkConversion =
      lcOffline) then
      begin
        Result:= FLocalFile;
        szBaseURL:= TLMDHTMLLinks(Collection).FHTMLObject.FLocalURL;
        szURL:= FLocalFile;
        if ExtractFileDrive(UpperCase(szBaseURL)) =
          ExtractFileDrive(UpperCase(szURL)) then
          begin
            Result:= ExtractRelativePath(szBaseURL, szURL);
            i:= Pos('#', FURL);
            if i > 0 then
              Result:= Result + Copy(FURL, i, Length(FURL) - i + 1);
          end;
      end
    else
      begin
        Result:= GetWebURL;
      end;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLLink.GetWebURL: string;
var
  szBaseURL: string;

  Buffer: array[1..1024] of char;

  iCount: DWORD;
begin
  Result:= FURL;
  szBaseURL:= TLMDHTMLLinks(Collection).FHTMLObject.FBaseURL;
  iCount:= 1024;

  if InternetCombineUrl(int_Ref(szBaseURL), int_Ref(FURL), @Buffer[1], iCount,
    ICU_BROWSER_MODE) then
    begin
      Result:= StrPas(PChar(@Buffer[1]));
      Result:= LMDWebDeleteBackSlash(Result);
    end;

end;

{-----------------------------------------------------------------------------}

function TLMDHTMLLink.GetWebURLOnly: string;
begin
  Result:= LMDWebGetWebFileURL(WebURL);
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLLink.Read(Reader: TReader);
begin
  with Reader do
    begin
      FLinkType := TLMDHTMLLinkType(int_ReadByte(Reader));
//      Read(FLinkType, sizeof(LinkType));
      Read(FSourcePos, sizeof(SourcePos));
      FURL:= ReadString;
      FLocal:= ReadBoolean;
      FLocalFile:= ReadString;
      FClassCode:= ReadString;
      FCodeBase:= ReadString;
    end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLLink.SetClassCode(const Value: string);
begin
  FClassCode:= ProcessString(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLLink.SetCodeBase(const Value: string);
begin
  FCodeBase:= ProcessString(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLLink.SeTLMDHTMLLinkType(const Value: TLMDHTMLLinkType);
begin
  FLinkType:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLLink.SetURL(const Value: string);
begin
  FURL:= ProcessString(Value);
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLLink.Write(Writer: TWriter);
begin
  with Writer do
    begin
      int_WriteByte(Writer, byte(FLinkType));
//      Write(FLinkType, sizeof(LinkType));
      Write(FSourcePos, sizeof(SourcePos));
      WriteString(FURL);
      WriteBoolean(FLocal);
      WriteString(FLocalFile);
      WriteString(FClassCode);
      WriteString(FCodeBase);
    end;
end;

{ **************************TLMDHTMLLinks**************************** }

{-----------------------------------------------------------------------------}

function TLMDHTMLLinks.Add: TLMDHTMLLink;
begin
  Result:= TLMDHTMLLink(inherited Add);
end;

{-----------------------------------------------------------------------------}

constructor TLMDHTMLLinks.Create;
begin
  inherited Create(TLMDHTMLLink);
  FHTMLObject:= HTMLObject;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLLinks.GetIndexOf(URL: string): integer;
var
  i: integer;
begin
  Result:= -1;
  for i:= 0 to Count - 1 do
    if Link[i].URL = URL then
      begin
        Result:= i;
        break;
      end;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLLinks.GetIndexOfWeb(URL: string): integer;
var
  i: integer;
begin
  Result:= -1;
  for i:= 0 to Count - 1 do
    if Link[i].WebURLOnly = URL then
      begin
        Result:= i;
        break;
      end;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLLinks.GetLink(Index: integer): TLMDHTMLLink;
begin
  Result:= TLMDHTMLLink(inherited Items[Index]);
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLLinks.Read(Reader: TReader);
begin
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    Add.Read(Reader);
  Reader.ReadListEnd;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLLinks.Write(Writer: TWriter);
var
  i: integer;
begin
  Writer.WriteListBegin;
  for i:= 0 to Count - 1 do
    Link[i].Write(Writer);
  Writer.WriteListEnd;
end;

{ **************************TLMDHTMLItem**************************** }

{-----------------------------------------------------------------------------}

procedure TLMDHTMLItem.SetiType(const Value: integer);
begin
  FiType:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLItem.SetName(const Value: string);
begin
  FName:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLItem.SetValue(const Value: string);
begin
  FValue:= Value;
end;

{ **************************TLMDHTMLItems**************************** }

{-----------------------------------------------------------------------------}

function TLMDHTMLItems.Add: TLMDHTMLItem;
begin
  Result:= TLMDHTMLItem(inherited Add);
end;

{-----------------------------------------------------------------------------}

constructor TLMDHTMLItems.Create;
begin
  inherited Create(TLMDHTMLItem);
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLItems.FindByName(Name: string): TLMDHTMLItem;
var
  i: integer;
begin
  Result:= nil;
  Name:= UpperCase(Name);
  for i:= 0 to Count - 1 do
    if UpperCase(Items[i].FName) = Name then
      begin
        Result:= Items[i];
        break;
      end;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLItems.GetItems(Index: integer): TLMDHTMLItem;
begin
  Result:= TLMDHTMLItem(inherited Items[Index]);
end;

end.
