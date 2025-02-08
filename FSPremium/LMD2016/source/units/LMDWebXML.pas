unit LMDWebXML;
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

LMDWebXML unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  SysUtils,Classes;

type
  TLMDXMLTags = class;
  UTF8String = type string;
  { **************************TLMDXMLTag**************************** }
  TLMDXMLTag     = class(TCollectionItem)
  private
    FName: string;
    FSubTags: TLMDXMLTags;
    FAttributes: TStringList;
    FText: string;
    FExAttributes: TStringList;
    procedure SetAttributes(const Value: TStringList);
    procedure SetName(const Value: string);
    procedure SetSubTags(const Value: TLMDXMLTags);
    procedure SetText(const Value: string);
    procedure SetExAttributes(const Value: TStringList);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure  Assign(Source: TPersistent); override;
  published
    property Name: string read FName write SetName;
    property Text: string read FText write SetText;
    property ExAttributes:TStringList read FExAttributes write SetExAttributes;
    property Attributes: TStringList read FAttributes write SetAttributes;
    property SubTags: TLMDXMLTags read FSubTags write SetSubTags;
  end;

  { **************************TLMDXMLTags**************************** }
  TLMDXMLTags = class(TCollection)
  private
    function GetItems(Index: integer): TLMDXMLTag;
  public
    constructor Create;
    function Add: TLMDXMLTag;
    function FindByName(const szName:String;bMatchCase:Boolean=false;
      bFindInSubTree:Boolean=false):TLMDXMLTag;
    property Items[Index: integer]: TLMDXMLTag read GetItems; default;
  end;
implementation

{ **************************TLMDXMLTag**************************** }

{-----------------------------------------------------------------------------}
procedure TLMDXMLTag.Assign(Source: TPersistent);
begin
  if Source is TLMDXMLTag then
  begin
    with TLMDXMLTag(Source) do
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

constructor TLMDXMLTag.Create(Collection: TCollection);
begin
  inherited;
  FAttributes := TStringList.Create;
  FSubTags    := TLMDXMLTags.Create;
  FExAttributes   := TStringList.Create;
end;

{-----------------------------------------------------------------------------}
destructor TLMDXMLTag.Destroy;
begin
  FAttributes.Free;
  FExAttributes.Free;
  FSubTags.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLTag.SetAttributes(const Value: TStringList);
begin
  FAttributes.Assign(Value);
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLTag.SetExAttributes(const Value: TStringList);
begin
  FExAttributes.Assign(Value);
end;

procedure TLMDXMLTag.SetName(const Value: string);
begin
  FName := Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLTag.SetSubTags(const Value: TLMDXMLTags);
begin
  FSubTags.Assign(Value);
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLTag.SetText(const Value: string);
begin
  FText := Value;
end;

{ **************************TLMDXMLTags**************************** }

{-----------------------------------------------------------------------------}
function TLMDXMLTags.Add: TLMDXMLTag;
begin
  Result := TLMDXMLTag(inherited Add);
end;

{-----------------------------------------------------------------------------}
constructor TLMDXMLTags.Create;
begin
  inherited Create(TLMDXMLTag);
end;

{-----------------------------------------------------------------------------}
function TLMDXMLTags.FindByName(const szName: String;bMatchCase:Boolean;
  bFindInSubTree: Boolean): TLMDXMLTag;
var
  i : Integer;
  function Cmp(S1,S2:String):Boolean;
  begin
    if bMatchCase then
      Result := S1=S2
    else
      Result := AnsiSameText(S1, S2);
  end;
begin
  Result := nil;
  for i:=0 to Count-1 do
    if Cmp(Items[i].Name,szName) then
    begin
      Result := Items[i];
      break;
    end;
  if (Result=nil) and bFindInSubTree then
    for i:=0 to Count-1 do
    begin
      Result := Items[i].SubTags.FindByName(szName,bMatchCase,True);
      if Result<>nil then
        break;
    end;
end;

{-----------------------------------------------------------------------------}
function TLMDXMLTags.GetItems(Index: integer): TLMDXMLTag;
begin
  Result := TLMDXMLTag(inherited Items[Index]);
end;
end.
