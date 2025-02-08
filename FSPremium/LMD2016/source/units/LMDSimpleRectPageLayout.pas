unit LMDSimpleRectPageLayout;
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

LMDSimpleRectPageLayout unit (RS)
-----------------------------------
PageLayout implementation for documents which consist of sequential
doc elements, usually generated from one big doc element like a picture,
which can flow over to next pages both downwards and to the right,
but there's only one doc area (e.g. a piece of a picture) per page 

Changes
-------
* Not released yet

###############################################################################}

interface

uses Graphics, Classes, LMDPrinter, LMDDocModel, LMDPrintablePage,
        LMDPageLayout, LMDDocElementRenderer, LMDPrintConst;

type

  TLMDSimpleRectPageLayout = class (TLMDCustomPageLayout)
  protected
    procedure GetElementAreaIndexesByPage(ARenderer: TLMDCustomDocElementRenderer;
                                          APageNum: integer;
                                          out AVertIndex: integer;
                                          out AHorizIndex: integer); override;
  public
    procedure PreparePages(APageWidth, APageHeight: Integer;
                           ACanvas: TCanvas); override;
  end;

implementation

{ TLMDSimpleRectPageLayout }

procedure TLMDSimpleRectPageLayout.GetElementAreaIndexesByPage(
  ARenderer: TLMDCustomDocElementRenderer; APageNum: integer;
  out AVertIndex, AHorizIndex: integer);
var
  LHorizPages: integer;
begin
  //in this simple algorithm we assume that there's only one page area per doc page
  //and numbers of 'horizontally' added pages are equal in each 'row'
  //(e.g. an image is layed out in a rectangular grid)
  AVertIndex := -1;
  AHorizIndex := -1;
  if Length(ARenderer.PageAreas) = 0 then
    raise ELMDPrintPackError.Create(SLMDPrintBadLayout);
  LHorizPages := Length(ARenderer.PageAreas[0]);
  if LHorizPages = 0 then
    raise ELMDPrintPackError.Create(SLMDPrintBadLayout);
  AVertIndex := ((APageNum - ARenderer.StartPageIndex) div LHorizPages) - 1;
  AHorizIndex := ((APageNum - ARenderer.StartPageIndex - 1) mod LHorizPages);
end;

procedure TLMDSimpleRectPageLayout.PreparePages(APageWidth,
  APageHeight: Integer; ACanvas: TCanvas);
var
  i, j: integer;
  LDocElement: TLMDDocElement;
  LRenderer: TLMDCustomDocElementRenderer;
  LPage: TLMDPrintablePage;
begin
  inherited;

  //in this simple algorithm we assume that there's only one doc element
  //in the document (e.g. a picture)
  if Self.Document.ChildElements.Count = 0 then
    Exit;
  LDocElement := TLMDDocElement(Self.Document.ChildElements[0]);
  LRenderer := Self.SelectRendererForDocElement(LDocElement);
  if not Assigned(LRenderer) then
    Exit;
  LRenderer.PageCanvas := ACanvas;
  LRenderer.DocElement := LDocElement;
  LRenderer.StartPageIndex := 0;
  LRenderer.PageWidth := APageWidth;
  LRenderer.PageHeight := APageHeight;
  LRenderer.LayOut;
  if Length(LRenderer.PageAreas) = 0 then
    Exit;

  for j := 0 to Length(LRenderer.PageAreas) - 1 do
  begin
    for i := 0 to Length(LRenderer.PageAreas[j]) - 1 do
    begin
      Self.AddRendererMapping(LRenderer, LRenderer.PageAreas[j][i].DocElements[0]);
      LPage := Self.AddPage;
      LPage.PageAreas.Add(LRenderer.PageAreas[j][i]);
      LRenderer.PageAreas[j][i].Page := LPage;
    end;
  end;
  FPagesPrepared := true;
end;

end.
