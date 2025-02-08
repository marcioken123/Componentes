unit LMDNewsAdapters;
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

LMDNewsAdapters unit (AIH)
--------------------
Download and parsing news feeds

Changes
-------
Release 1.0 (May 2008)
 - Initial Release

###############################################################################}

interface

uses 
  Classes, LMDXML, LMDUnicodeEncodings;

type
  {******************************** TLMDNewEntry ******************************}
  TLMDNewsEntry = class
  private
    FTitle: WideString;
    FPubDate: TDateTime;
    FLink: WideString;
    FContent: WideString;
    FContentType: WideString;
    FAuthor: WideString;
    FImage: Integer;
  public
    property Title: WideString read FTitle write FTitle;
    property PubDate: TDateTime read FPubDate write FPubDate;
    property Link: WideString read FLink write FLink;
    property Content: WideString read FContent write FContent;
    property ContentType: WideString read FContentType write FContentType;
    property Author: WideString read FAuthor write FAuthor;
    property Image: Integer read FImage write FImage;  
  end;
  {************************* TLMDNewsCollection *******************************}  
  TLMDNewsCollection = class
  private
    FTitle: WideString;
    FLink: WideString;
    FPubDate: TDateTime;
    FDescription: WideString;
    FItems: TList;
    function GetItem(AIndex: Integer): TLMDNewsEntry;
    procedure SetItem(AIndex: Integer; const AEntry: TLMDNewsEntry);
  public
    constructor Create;
    destructor Destroy(); override;
    function Add(): TLMDNewsEntry;
    function Count(): Integer;
    property Title: WideString read FTitle write FTitle;
    property Link: WideString read FLink write FLink;
    property PubDate: TDateTime read FPubDate write FPubDate;
    property Description: WideString read FDescription write FDescription;
    property Items[Index: Integer]: TLMDNewsEntry read GetItem write SetItem;   
  end;

  {************************* TLMDNewsReaderAdapter ****************************}
  TLMDNewsReaderAdapter = class
  private
    FXMLDocument: ILMDXmlDocument;
    FEncoder: TLMDEncoding;
    procedure SetXMLDocument(ADocument: ILMDXmlDocument);
    function Decode(AString: UTF8String): WideString;
  public
    function Parse(): TLMDNewsCollection; virtual; abstract;
    property XMLDocument: ILMDXmlDocument read FXMLDocument write SetXMLDocument;
  end;

  {************************** TLMDNewsReaderAdapterATOM ***********************}
  TLMDNewsReaderAdapterATOM = class(TLMDNewsReaderAdapter)
  public
    function Parse(): TLMDNewsCollection; override;
  end;

  {************************** TLMDNewsReaderAdapterRSS09 **********************}
  TLMDNewsReaderAdapterRSS09 = class(TLMDNewsReaderAdapter)
  public
    function Parse(): TLMDNewsCollection; override;
  end;

  {************************** TLMDNewsReaderAdapterRSS10 **********************}
  TLMDNewsReaderAdapterRSS10 = class(TLMDNewsReaderAdapter)
  public
    function Parse(): TLMDNewsCollection; override;
  end;

  {************************** TLMDNewsReaderAdapterRSS20 **********************}
  TLMDNewsReaderAdapterRSS20 = class(TLMDNewsReaderAdapter)
  public
    function Parse(): TLMDNewsCollection; override;
  end;

  {************************* TLMDNewsReaderAdapterLMDNEWS *********************}
  TLMDNewsReaderAdapterLMDNEWS = class(TLMDNewsReaderAdapter)
  public
    function Parse(): TLMDNewsCollection; override;
  end;

  {************************* TLMDNewsAdapterFactory ***************************}
  TLMDNewsAdapterFactory = class
  public
    class function GetAdapter(const AXMLDocument: WideString): TLMDNewsReaderAdapter;
  end;
implementation

uses 
  Windows, SysUtils, LMDTypes, LMDUnicode, LMDStrings, LMDDateTime;

function LMDRFC822StrToDateTime(const ADate: String): TDateTime;
var
  LDate: TLMDDateTime;
begin
  LDate := TLMDDateTime.Create;
  try
    LDate.DateRFC822 := ADate;
    Result := LDate.DateTimeValue;
  finally
    LDate.Free;
  end;
end;

function LMDW3CSTRToDateTime(const ADate: String): TDateTime;
var
  LDate: TLMDDateTime;
begin
  LDate := TLMDDateTime.Create;
  try
    LDate.DateISO8601 := ADate;
    Result := LDate.DateTimeValue;
  finally
    LDate.Free;
  end;
end;

// <!-- the temporary functional
function GetElementByTagName2(AElement: ILMDXmlElement; ATagName: WideString): ILMDXmlElement;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AElement.ChildNodes.Count - 1 do
    if AElement.ChildNodes.Item[i].NodeName = ATagName then
    begin
      Result := AElement.ChildNodes.Item[i].AsElement;
      exit
    end;
end;

function ConvStr(AString: WideString; AEncoding: String): WideString;
begin
  Result := AString;
  if LMDAnsiUpperCase(AEncoding) = 'UTF-8' then
    Result := UTF8Decode(AnsiString(AString));
end;
// -->

{*************************** TLMDNewsCollection *******************************}
{-------------------------------- private -------------------------------------}
function TLMDNewsCollection.GetItem;
begin
  Result :=  TLMDNewsEntry(FItems.Items[AIndex]);
end;

{------------------------------------------------------------------------------}
procedure TLMDNewsCollection.SetItem;
begin
  FItems[AIndex] := AEntry;
end;

{-------------------------------- public --------------------------------------}
constructor TLMDNewsCollection.Create;
begin
  inherited;
  FItems := TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDNewsCollection.Destroy();
begin
  FItems.Free;
end;

{------------------------------------------------------------------------------}
function TLMDNewsCollection.Add(): TLMDNewsEntry;
begin
  Result := TLMDNewsEntry.Create;
  FItems.Add(Result);
end;

{------------------------------------------------------------------------------}
function TLMDNewsCollection.Count(): Integer;
begin
  Result := FItems.Count;
end;

{************************** TLMDNewsAdapterFactory ****************************}
{-------------------------------- private -------------------------------------}
class function TLMDNewsAdapterFactory.GetAdapter(const AXMLDocument: WideString): TLMDNewsReaderAdapter;
var
  LXMLDoc: ILMDXmlDocument;
begin
  Result := nil;
  LXMLDoc := LMDLoadXmlDocumentFromXML(AXMLDocument);
  if LXMLDoc.DocumentElement.GetAttr('xmlns', '') = 'http://www.w3.org/2005/Atom' then
    Result := TLMDNewsReaderAdapterATOM.Create;
  if LXMLDoc.DocumentElement.GetAttr('xmlns', '') = 'http://purl.org/rss/1.0/' then
    Result := TLMDNewsReaderAdapterRSS10.Create;
  if LXMLDoc.DocumentElement.GetAttr('version', '') = '2.0' then
    Result := TLMDNewsReaderAdapterRSS20.Create;
  if LXMLDoc.DocumentElement.GetAttr('xmlns', '') = 'http://my.netscape.com/rdf/simple/0.9/' then
    Result := TLMDNewsReaderAdapterRSS09.Create;
  if LXMLDoc.DocumentElement.FindElement('newstree', '', '') <> nil then
    Result := TLMDNewsReaderAdapterLMDNEWS.Create;
  if Assigned(Result) then
    Result.XMLDocument := LXMLDoc;
end;

{************************** TLMDNewsReaderAdapter *****************************}
{--------------------------------- private ------------------------------------}
procedure TLMDNewsReaderAdapter.SetXMLDocument(ADocument: ILMDXmlDocument);
var
  LEncoding: string;
begin
  FXMLDocument := ADocument;
  if FXMLDocument.ChildNodes[0].AsProcessingInstruction = nil
    then exit;
  LEncoding := LowerCase(FXMLDocument.ChildNodes[0].AsProcessingInstruction.GetAttr('encoding'));
  if LEncoding = '' then
    FreeAndNil(FEncoder)
  else
    FEncoder := TLMDEncoding.GetEncoding(LEncoding);
end;

{------------------------------------------------------------------------------}
function TLMDNewsReaderAdapter.Decode(AString: UTF8String): WideString;
var
  lWideCharArray: TLMDWideCharArray;
  i: Integer;
begin
  if Assigned(FEncoder) then
  begin
    FEncoder.ReadBuffer(lWideCharArray, TLMDByteArray(AString));
    Result := '';
    for i := 0 to Length(lWideCharArray) - 1 do
      Result := Result + lWideCharArray[i];
  end;
end;

{************************ TLMDNewsReaderAdapterATOM ***************************}
{--------------------------------- public -------------------------------------}
function TLMDNewsReaderAdapterATOM.Parse(): TLMDNewsCollection;
var
  LXMLEntryElement, LElement: ILMDXmlElement;
  i: Integer;
  LEntry: TLMDNewsEntry;
  LAuthor: WideString;
  LNodeList: ILMDXmlNodeList;
//  LEncoding: string;
begin
  Result := TLMDNewsCollection.Create();
  LElement := FXMLDocument.DocumentElement.FindElement('title', '', '');
  if Assigned(LElement) then
    if LElement.ChildNodes.Count > 0 then
      Result.Title := Decode(UTF8String(LElement.ChildNodes.Item[0].Text));

  LElement := FXMLDocument.DocumentElement.FindElement('link', 'rel', 'self');
  if Assigned(LElement) then 
      Result.Link := LElement.GetAttr('href', '');

  LElement := FXMLDocument.DocumentElement.FindElement('author', '', '');
  if Assigned(LElement) then
  begin
    LElement := LElement.FindElement('name', '', '');
    if Assigned(LElement) then
      LAuthor := Decode(UTF8String(LElement.Text));
  end;

  LElement := FXMLDocument.DocumentElement.FindElement('updated', '', '');
  if Assigned(LElement) then
    if LElement.ChildNodes.Count > 0 then
      Result.PubDate := LMDW3CSTRToDateTime(LElement.ChildNodes.Item[0].Text);

  Result.Description := Result.Title;

  LNodeList := FXMLDocument.DocumentElement.GetElementsByTagName('entry');

  for i := 0 to LNodeList.Count - 1 do
  begin
    LElement := LNodeList.Item[i].AsElement;
    LEntry := Result.Add;
    LXMLEntryElement := LElement.FindElement('title', '', '');
    if Assigned(LXMLEntryElement) then
      if LXMLEntryElement.ChildNodes.Count > 0 then
        LEntry.Title := Decode(UTF8String(LXMLEntryElement.ChildNodes.Item[0].Text));

    LXMLEntryElement := LElement.FindElement('content', '', '');
    if Assigned(LXMLEntryElement) then
      if LXMLEntryElement.ChildNodes.Count > 0 then
        LEntry.Content := Decode(UTF8String(LXMLEntryElement.ChildNodes.Item[0].Text));

    LEntry.ContentType := LXMLEntryElement.GetAttr('type', 'text');

    LXMLEntryElement := LElement.FindElement('link', 'rel', 'self');
    if Assigned(LXMLEntryElement) then
      LEntry.Link := LXMLEntryElement.GetAttr('href', '');

    LXMLEntryElement := LElement.FindElement('published', '', '');
    if Assigned(LXMLEntryElement) then
      if LXMLEntryElement.ChildNodes.Count > 0 then
        LEntry.PubDate := LMDW3CSTRToDateTime(LXMLEntryElement.ChildNodes.Item[0].Text);
    LEntry.Author := LAuthor;
  end;
end;

{************************** TLMDNewsReaderAdapterRSS20 ************************}
{------------------------------- public ---------------------------------------}
function TLMDNewsReaderAdapterRSS20.Parse(): TLMDNewsCollection;
var
  LElement, LItem, LRoot: ILMDXmlElement;
  LEncoding: string;
  i: Integer;
  LNewsEntry: TLMDNewsEntry;
  LNodeList: ILMDXmlNodeList;
begin
  Result := TLMDNewsCollection.Create;
  LEncoding := FXMLDocument.ChildNodes[0].AsProcessingInstruction.GetAttr('encoding');
  if FXMLDocument.DocumentElement.ChildNodes.Count > 0 then
  begin
    LRoot := FXMLDocument.DocumentElement.ChildNodes[0].AsElement;
    LElement := LRoot.FindElement('title', '', '');
    if Assigned(LElement) then
      if LElement.ChildNodes.Count > 0 then
        Result.Title := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);

    LElement := LRoot.FindElement('link', '', '');
    if Assigned(LElement) then
      if LElement.ChildNodes.Count > 0 then
        Result.Link := LElement.ChildNodes.Item[0].Text;

    LElement := LRoot.FindElement('description', '', '');
    if Assigned(LElement) then
      if LElement.ChildNodes.Count > 0 then
        Result.Description := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);

    LElement := LRoot.FindElement('pubDate', '', '');
    if Assigned(LElement) then
      if LElement.ChildNodes.Count > 0 then
        Result.PubDate := LMDRFC822StrToDateTime(LElement.ChildNodes.Item[0].Text);

    LNodeList := LRoot.GetElementsByTagName('item');
    for i := 0 to LNodeList.Count - 1 do
    begin
      LItem := LNodeList.Item[i].AsElement;
      LNewsEntry := Result.Add;

      LElement := LItem.FindElement('title', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          LNewsEntry.Title := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);

      LElement := LItem.FindElement('description', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          LNewsEntry.Content := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);

      LElement := LItem.FindElement('author', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          LNewsEntry.Author := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);

      LElement := LItem.FindElement('link', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          LNewsEntry.Link := LElement.ChildNodes.Item[0].Text;

      LElement := LItem.FindElement('pubDate', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          LNewsEntry.PubDate := LMDRFC822StrToDateTime(LElement.ChildNodes.Item[0].Text);

    end;
  end;
end;

{************************** TLMDNewsReaderAdapterRSS10 ************************}
{------------------------------- public ---------------------------------------}
function TLMDNewsReaderAdapterRSS10.Parse(): TLMDNewsCollection;
var
  i: Integer;
  LRoot, LElement: ILMDXmlElement;
  LEncoding: string;
  LNewsEntry: TLMDNewsEntry;
  LNodeList: ILMDXmlNodeList;
begin
  Result := TLMDNewsCollection.Create;
  LEncoding := FXMLDocument.ChildNodes[0].GetAttr('encoding');
  if FXMLDocument.DocumentElement.ChildNodes.Count > 0 then
  begin
    LRoot := FXMLDocument.DocumentElement.FindElement('channel', '', '');
    if Assigned(LRoot) then
    begin
      LElement := LRoot.FindElement('title', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          Result.Title := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);

      LElement := LRoot.FindElement('link', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          Result.Link := LElement.ChildNodes.Item[0].Text;

      LElement := LRoot.FindElement('description', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          Result.Description := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);
    end;
    LNodeList := FXMLDocument.DocumentElement.GetElementsByTagName('item'); 

    for i := 0 to LNodeList.Count - 1 do
    begin
      LRoot := LNodeList.Item[i].AsElement;
      LNewsEntry := Result.Add;
      LElement := LRoot.FindElement('title', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          LNewsEntry.Title := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);
      LElement := LRoot.FindElement('link', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          LNewsEntry.Link := LElement.ChildNodes.Item[0].Text;

      LElement := LRoot.FindElement('description', '', '');
      if Assigned(LElement) then
        if LElement.ChildNodes.Count > 0 then
          LNewsEntry.Content := ConvStr(LElement.ChildNodes.Item[0].Text, LEncoding);
    end;
  end;
end;

{*************************** TLMDNewsReaderAdapterRSS09 ***********************}
{-------------------------------- public --------------------------------------}
function TLMDNewsReaderAdapterRSS09.Parse(): TLMDNewsCollection;
var
  LChannel, LItem,
  LElement: ILMDXmlElement;
  LNewsEntry: TLMDNewsEntry;
  i: Integer;
  LNodeList: ILMDXmlNodeList;
begin
  Result := TLMDNewsCollection.Create;
  LChannel := FXMLDocument.DocumentElement.FindElement('channel', '', '');

  LElement := LChannel.FindElement('title', '', '');
  if Assigned(LElement) then
    if LElement.ChildNodes.Count > 0 then
      Result.Title := LElement.ChildNodes.Item[0].Text;
  LElement := LChannel.FindElement('link', '', '');
  if Assigned(LElement) then
    if LElement.ChildNodes.Count > 0 then
      Result.Link := LElement.ChildNodes.Item[0].Text;

  LElement := LChannel.FindElement('description', '', '');
  if Assigned(LElement) then
    if LElement.ChildNodes.Count > 0 then
      Result.Description := LElement.ChildNodes.Item[0].Text;

  LNodeList := FXMLDocument.DocumentElement.GetElementsByTagName('item'); 

  for i := 0 to LNodeList.Count - 1 do
  begin
    LItem := LNodeList.Item[i].AsElement;
    LNewsEntry := Result.Add;

    LElement := LItem.FindElement('title', '', '');
    if Assigned(LElement) then
      if LElement.ChildNodes.Count > 0 then
        LNewsEntry.Title := LElement.ChildNodes.Item[0].Text;

    LElement := LItem.FindElement('link', '', '');
    if Assigned(LElement) then
      if LElement.ChildNodes.Count > 0 then
        LNewsEntry.Link := LElement.ChildNodes.Item[0].Text;
  end;
end;

{************************** TLMDNewsReaderAdapterLMDNEWS **********************}
{-------------------------------- public --------------------------------------}
function TLMDNewsReaderAdapterLMDNEWS.Parse(): TLMDNewsCollection;
var
  LRoot,
  LElement,
  LItem: ILMDXmlElement;
  i, j: Integer;
  LNewsEntry: TLMDNewsEntry;
  LEncoding: string;
  LDateTime: TDateTime;
begin
  Result := TLMDNewsCollection.Create;
  LEncoding := FXMLDocument.ChildNodes[0].GetAttr('encoding');
  LRoot := FXMLDocument.DocumentElement.FindElement('newstree', '', '');
  LDateTime := Now;
  if Assigned(LRoot) then
    if LRoot.ChildNodes.Count > 0 then
    begin
      Result.Title := LRoot.ChildNodes.Item[0].Text;
      if LRoot.ChildNodes.Count > 1 then
        for i := 1 to LRoot.ChildNodes.Count - 1 do
        begin
          LElement := LRoot.ChildNodes.Item[i].AsElement;
          Result.Link := LElement.GetAttr('URL');

          for j := 0 to LElement.ChildNodes.Count - 1 do
          begin
            LItem := LElement.ChildNodes.Item[j].AsElement;
            if LElement.ChildNodes.Item[j].NodeType = LMD_NODE_CDATA_SECTION then
              LDateTime := StrToDateTime(LElement.ChildNodes.Item[j].AsCDataSection.Values['']);

            if Assigned(LItem) then
            begin
              LNewsEntry := Result.Add;
              LNewsEntry.PubDate := LDateTime;
              LNewsEntry.Link := LItem.GetAttr('URL');
              if LItem.ChildNodes.Count > 0 then
                LNewsEntry.Title := ConvStr(LItem.ChildNodes.Item[0].Text, LEncoding);
              LNewsEntry.Content := LNewsEntry.Title;
              Result.PubDate := LDateTime;
            end
          end;
        end;
    end;
end;
end.
