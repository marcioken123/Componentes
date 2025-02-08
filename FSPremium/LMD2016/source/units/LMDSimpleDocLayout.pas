unit LMDSimpleDocLayout;
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

LMDSimpleDocLayout unit (RS)
-----------------------------------
PageLayout implementation for simple documents which consist of sequential
doc elements, one below another, which can flow over to next pages
only downwards (not to the right)  

Changes
-------
* Not released yet

###############################################################################}

interface

uses Graphics, Classes, LMDPrinter, LMDDocModel, LMDPrintablePage,
        LMDPageLayout, LMDDocElementRenderer;

type

  TLMDSimpleDocLayout = class (TLMDCustomPageLayout)
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

uses SysUtils;

{ TLMDSimpleDocLayout }

procedure TLMDSimpleDocLayout.GetElementAreaIndexesByPage(
  ARenderer: TLMDCustomDocElementRenderer; APageNum: integer;
  out AVertIndex, AHorizIndex: integer);
begin
  //mapping of page numbers to page area indexes is very simple in this layout
  AHorizIndex := 0;
  if (Length(ARenderer.PageAreas) > 1) and
     (APageNum >= ARenderer.StartPageIndex)
  then
    AVertIndex := APageNum - 1 - ARenderer.StartPageIndex
  else
    AVertIndex := 0;
end;

procedure TLMDSimpleDocLayout.PreparePages(APageWidth, APageHeight: Integer;
                                           ACanvas: TCanvas);
var
  i, j, k: integer;
  Elem: TLMDDocElement;
  Rend: TLMDCustomDocElementRenderer;
  Page: TLMDPrintablePage;
  LastArea: TLMDPageArea;
begin
  inherited;

  FCurY := 0;

  Rend := nil;
  Page := Self.AddPage;

  for i := 0 to Self.Document.ChildElements.Count - 1 do
  begin
    Elem := TLMDDocElement(Self.Document.ChildElements[i]);

    Elem.Top := FCurY;

    if Elem is TLMDTextBlock then
      Rend := TLMDTextBlockRenderer.Create
    else if Elem is TLMDDocTable then
      Rend := TLMDTableRenderer.Create
    else if Elem is TLMDDocImage then
      Rend := TLMDDocImageRenderer.Create
    else if Elem is TLMDVertPlaceholder then
    begin
      FCurY := FCurY + Elem.Height;
      Continue;
    end
    else
      Assert(false);

    if FCurY > FPageHeight+Elem.Height then
      Self.AddPage;

    Rend.PageCanvas := ACanvas;
    Rend.DocElement := Elem;
    Rend.StartPageIndex := Page.PageNumber - 1;
    Rend.PageWidth := APageWidth;
    Rend.PageHeight := APageHeight;

    Rend.LayOut;
    if Length(Rend.PageAreas) = 0 then
    begin
      FreeAndNil(Rend);

      Continue;
    end;

    LastArea := Rend.PageAreas[Length(Rend.PageAreas) - 1][0];

    FCurY := LastArea.Area.Bottom;

    //in this simplest layout algorithm we assume
    //that each area of the current doc element is on a separate page
    //and all the areas are sequenced downwards only (not to the right),
    //so we use only VertIndex (HorizIndex is always 0)
    for j := 0 to Length(Rend.PageAreas) - 1 do
    begin
      for k := 0 to Rend.PageAreas[j][0].DocElementsCount - 1 do
        Self.AddRendererMapping(Rend, Rend.PageAreas[j][0].DocElements[k]);

      if j > 0 then //it's a new page required for the current doc element
        Page := Self.AddPage;

      Page.PageAreas.Add(Rend.PageAreas[j][0]);
      Rend.PageAreas[j][0].Page := Page;
    end;
  end;

  FPagesPrepared := true;
end;

end.
