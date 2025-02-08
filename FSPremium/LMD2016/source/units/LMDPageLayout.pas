unit LMDPageLayout;
{$I lmdcmps.inc}

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

LMDPageLayout unit (RS)
-----------------------------------
PageLayout is a page-making manager which lays document elements out to logical pages
(LMDPrintablePage instances) thus generating the printer-ready version of the document;
uses appropriate _renderers_ for document elements.

Changes
-------
* Not released yet

###############################################################################}

interface

uses
  Windows, Classes, Graphics, LMDPrinter, LMDDocModel,
  LMDPrintablePage, LMDDocElementRenderer;

type

  TLMDCustomPageLayout = class (TPersistent)
  private
    FDocument: TLMDDocument;

    function GetPage(Index: integer): TLMDPrintablePage;
  protected
    FPagesPrepared: Boolean;

    FPages: array of TLMDPrintablePage;
    FRendererMappings: TList;
    FCurY: Integer;

    FPageWidth, FPageHeight: Integer;
    FCanvas: TCanvas;

    function AddPage: TLMDPrintablePage;

    procedure AddRendererMapping(ARenderer: TLMDCustomDocElementRenderer; ADocElement: TLMDDocElement);
    function SelectRendererForDocElement(ADocElement: TLMDDocElement):
                                        TLMDCustomDocElementRenderer; virtual;
    function GetRendererForDocElement(ADocElement: TLMDDocElement):
                                      TLMDCustomDocElementRenderer; virtual;

    procedure GetElementAreaIndexesByPage(ARenderer: TLMDCustomDocElementRenderer;
                                          APageNum: integer;
                                          out AVertIndex: integer;
                                          out AHorizIndex: integer);
                                          virtual; abstract;

    procedure ReleasePages;
    procedure ReleaseRenderers;

    procedure CheckPagesPrepared;
    procedure CheckPagesNotPrepared;
  public
    constructor Create;
    destructor Destroy; override;

    procedure PreparePages(APageWidth, APageHeight: Integer;
                           ACanvas: TCanvas); virtual;

    function  GetPagesCount: Integer;

    procedure DrawPage(ANum: Integer; APoint: TPoint; ACanvas: TCanvas); virtual;

    procedure FinalizePages; virtual;

    property Page[Index: integer]: TLMDPrintablePage read GetPage;
  published
    property PagesCount: Integer read GetPagesCount;
    property Document: TLMDDocument read FDocument write FDocument;
  end;

  TLMDDocElementRendererMapping = class
  private
    FRenderer: TLMDCustomDocElementRenderer;
    FDocElement: TLMDDocElement;
  public
    property DocElement: TLMDDocElement read FDocElement write FDocElement;
    property Renderer: TLMDCustomDocElementRenderer read FRenderer write FRenderer;
  end;

implementation

{ TLMDCustomPageLayout }

function TLMDCustomPageLayout.AddPage: TLMDPrintablePage;
begin
  Result := TLMDPrintablePage.Create;
  Result.PageNumber := Length(Self.FPages) + 1;

  SetLength(Self.FPages, Result.PageNumber);
  Self.FPages[Result.PageNumber - 1] := Result;

  FCurY := 0;
end;

procedure TLMDCustomPageLayout.AddRendererMapping(
  ARenderer: TLMDCustomDocElementRenderer; ADocElement: TLMDDocElement);
var
  LRendererMapping: TLMDDocElementRendererMapping;
begin
  LRendererMapping := TLMDDocElementRendererMapping.Create;
  LRendererMapping.Renderer := ARenderer;
  LRendererMapping.DocElement := ADocElement;
  Self.FRendererMappings.Add(LRendererMapping);
end;

procedure TLMDCustomPageLayout.CheckPagesNotPrepared;
begin
  Assert(not FPagesPrepared);
end;

procedure TLMDCustomPageLayout.CheckPagesPrepared;
begin
  Assert(FPagesPrepared);
end;

constructor TLMDCustomPageLayout.Create;
begin
  inherited;

  FPagesPrepared := false;

  Self.FRendererMappings := TList.Create;
end;

destructor TLMDCustomPageLayout.Destroy;
begin
  Self.ReleasePages;
  Self.ReleaseRenderers;
  Self.FRendererMappings.Free;

  inherited;
end;

procedure TLMDCustomPageLayout.DrawPage(ANum: Integer; APoint: TPoint;
                                        ACanvas: TCanvas);
var
  i, LVertIndex, LHorizIndex: integer;
  found: boolean;
  LPage: TLMDPrintablePage;
  LRenderer: TLMDCustomDocElementRenderer;
begin
  CheckPagesPrepared;

  found := false;
  i := 0;

  while (not found) and (i < Self.PagesCount) do
  begin
    //in Syntax Edit print pack version page numbers start from 0, here - from 1
    found := Self.Page[i].PageNumber = ANum + 1;
    if not found then
      Inc(i);
  end;

  if found then
  begin
    LPage := Self.Page[i];
    for i := 0 to LPage.PageAreas.Count - 1 do
    begin
      LRenderer := Self.GetRendererForDocElement(TLMDPageArea(LPage.PageAreas[i]).DocElements[0]);

      LRenderer.PageCanvas := ACanvas;
      Self.GetElementAreaIndexesByPage(LRenderer, ANum + 1, LVertIndex, LHorizIndex);
      LRenderer.DrawArea(APoint, LVertIndex, LHorizIndex);
    end;
  end;
end;

procedure TLMDCustomPageLayout.FinalizePages;
begin
  CheckPagesPrepared;

  Self.ReleasePages;
  Self.ReleaseRenderers;

  FPageWidth := -1;
  FPageHeight := -1;
  FCanvas := nil;

  FPagesPrepared := false;
end;

function TLMDCustomPageLayout.GetPage(Index: integer): TLMDPrintablePage;
begin
  CheckPagesPrepared;

  Result := Self.FPages[Index];
end;

function TLMDCustomPageLayout.GetPagesCount: integer;
begin
  CheckPagesPrepared;

  Result := Length(Self.FPages);
end;

function TLMDCustomPageLayout.GetRendererForDocElement(
  ADocElement: TLMDDocElement): TLMDCustomDocElementRenderer;
var
  i: integer;
  found: boolean;
begin
  Result := nil;
  if Assigned(Self.FRendererMappings) and (Self.FRendererMappings.Count > 0) then
  begin
    i := 0;
    found := false;
    while (i < Self.FRendererMappings.Count) and (not found) do
    begin
      found := TLMDDocElementRendererMapping(Self.FRendererMappings[i]).DocElement = ADocElement;
      if not found then
        Inc(i);
    end;
    if found then
      Result := TLMDDocElementRendererMapping(Self.FRendererMappings[i]).Renderer;
  end;
end;

procedure TLMDCustomPageLayout.PreparePages(APageWidth, APageHeight: Integer;
                                            ACanvas: TCanvas);
begin
  CheckPagesNotPrepared;

  FPageWidth := APageWidth;
  FPageHeight := APageHeight;
  FCanvas := ACanvas;
end;

procedure TLMDCustomPageLayout.ReleasePages;
var
  i: integer;
begin
  for i := 0 to Length(Self.FPages) - 1 do
    TLMDPrintablePage(Self.FPages[i]).Free;

  SetLength(Self.FPages, 0);
end;

procedure TLMDCustomPageLayout.ReleaseRenderers;
var
  i, j: integer;
  Rend: TLMDCustomDocElementRenderer;
  Map, Map2: TLMDDocElementRendererMapping;
  Maps: TList;
begin
  Maps := Self.FRendererMappings;

  for i := 0 to Maps.Count - 1 do
  begin
    Map := TLMDDocElementRendererMapping(Maps[i]);

    Rend := Map.Renderer;
    for j := i to Maps.Count - 1 do
    begin
      Map2 := TLMDDocElementRendererMapping(Maps[j]);

      if Map2.Renderer=Rend then
        Map2.Renderer := nil;
    end;

    Rend.Free;
    Map.Free;
  end;

  Self.FRendererMappings.Clear;
end;

function TLMDCustomPageLayout.SelectRendererForDocElement(
  ADocElement: TLMDDocElement): TLMDCustomDocElementRenderer;
begin
    Result := nil;
    if ADocElement is TLMDTextBlock then
      Result := TLMDTextBlockRenderer.Create
    else if ADocElement is TLMDDocTable then
      Result := TLMDTableRenderer.Create
    else if ADocElement is TLMDDocImage then
      Result := TLMDDocImageRenderer.Create
    else
      Assert(false);
end;

end.
