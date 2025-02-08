unit LMDLayoutRenderPrintTask;
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

LMDLayoutRenderPrintTask unit (RS)
-----------------------------------
Base class for all the Print Tasks of printing support package which use TLMDLayout manager and Renderers
to lay out and render the document (for printing of controls like TMemo, TStringGrid etc.).
Tasks which use page-making and rendering logic from some control (e.g. the Syntax Edit case)
should derive directly from TLMDCustomPrintTask.

Changes
-------
* Not released yet

###############################################################################}

interface

uses Math, Classes, SysUtils,
    Windows, Printers, Graphics, Dialogs, Types,
    LMDCustomComponent, LMDPrinter,
    LMDDocModel, LMDPrintablePage, LMDCustomPrintTask,
    LMDPageLayout, LMDDocElementRenderer;

type
  TLMDLayoutRenderPrintTask = class(TLMDCustomPrintTask)
  protected
    FDocument: TLMDDocument;
    FLayout: TLMDCustomPageLayout;

    FPageWidth, FPageHeight: Integer;
    FCanvas: TCanvas;

    procedure CreateLayoutManager; virtual; abstract;
    procedure ConstructDocument; virtual; abstract;

    procedure PreparePagesInternal(APageWidth, APageHeight: Integer;
                                   ACanvas: TCanvas); override;

    function GetPagesCountInternal(ARange: TLMDPrintOperationRange): integer; override;

    procedure DrawPageInternal(ARange: TLMDPrintOperationRange; ANum: Integer;
                         APoint: TPoint; ACanvas: TCanvas); override;

    procedure FinalizePagesInternal; override;
  end;

implementation

{ TLMDLayoutRenderPrintTask }

procedure TLMDLayoutRenderPrintTask.DrawPageInternal(ARange: TLMDPrintOperationRange;
                                                     ANum: Integer;
                                                     APoint: TPoint;
                                                     ACanvas: TCanvas);
begin
  if Assigned(Self.FLayout) then
    Self.FLayout.DrawPage(ANum, APoint, ACanvas);
end;

procedure TLMDLayoutRenderPrintTask.FinalizePagesInternal;
begin
  FLayout.FinalizePages;

  FreeAndNil(FLayout);
  FreeAndNil(FDocument);

  FPageWidth := -1;
  FPageHeight := -1;
  FCanvas := nil;
end;

function TLMDLayoutRenderPrintTask.GetPagesCountInternal(ARange:
                                                         TLMDPrintOperationRange): integer;
begin
  if ARange=orSelection then //Printing selection is not supported here
    Result := 0
  else if Assigned(Self.FLayout) then
    Result := Self.FLayout.PagesCount
  else
    Result := 1;
end;

procedure TLMDLayoutRenderPrintTask.PreparePagesInternal(APageWidth,
                                                         APageHeight: Integer;
                                                         ACanvas: TCanvas);
begin
  FPageWidth := APageWidth;
  FPageHeight := APageHeight;
  FCanvas := ACanvas;

  ConstructDocument;
  CreateLayoutManager;

  FLayout.Document := Self.FDocument;
  FLayout.PreparePages(APageWidth, APageHeight, ACanvas);
end;

end.
