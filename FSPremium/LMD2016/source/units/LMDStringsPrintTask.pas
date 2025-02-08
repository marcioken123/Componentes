unit LMDStringsPrintTask;
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

LMDStringsPrintTask unit (RS)
-----------------------------------
Base class for all the Print Tasks of printing support package for printing Strings-based controls
(VCL and LMD Edit and Memo controls etc.).

Changes
-------
* Not released yet

###############################################################################}

interface

uses Math, Classes, SysUtils, ComCtrls,
    Windows, Printers, Graphics, Dialogs, Types,
    LMDTypes, LMDCustomComponent, LMDPrinter, LMDDocModel, LMDPrintablePage,
    LMDCustomPrintTask, LMDPageLayout, LMDSimpleDocLayout,
    LMDLayoutRenderPrintTask, LMDDocElementRenderer;

type

  TLMDStringsPrintTask = class(TLMDLayoutRenderPrintTask)
  private
    FFormatOptions: TLMDTextAreaSettings;
    FLines: TLMDStrings;

    procedure SetFormatOptions(const Value: TLMDTextAreaSettings);
    procedure SetLines(const Value: TLMDStrings);
  protected
    procedure CreateLayoutManager; override;
    procedure ConstructDocument; override;
  public
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromRtf(AEdit: TRichEdit);
  published
    property About;
    property Lines: TLMDStrings read FLines write SetLines;
    property FormatOptions: TLMDTextAreaSettings read FFormatOptions write SetFormatOptions;
  end;

implementation
uses LMDStrings, LMDPrintConst;

{ TLMDStringsPrintTask }

procedure TLMDStringsPrintTask.ConstructDocument;
var
  Block: TLMDTextBlock;
begin
  FDocument := TLMDDocument.Create;

  Block := TLMDTextBlock.Create;
  Block.Top := 0;
  Block.Left := 0;

  Assert(FPageWidth<>-1);
  Block.Width := FPageWidth;

  Block.Strings := Self.FLines;
  Block.TextFormat := Self.FFormatOptions;
  Block.IsRTF := Self.FormatOptions.IsRTF;

  FDocument.ChildElements.Add(Block);
end;

constructor TLMDStringsPrintTask.Create(AOwner: TComponent);
begin
  inherited;

  FLines := TLMDMemoryStrings.Create;
  FFormatOptions := TLMDTextAreaSettings.Create;
end;

procedure TLMDStringsPrintTask.CreateLayoutManager;
begin
  FLayout := TLMDSimpleDocLayout.Create;
end;

destructor TLMDStringsPrintTask.Destroy;
begin
  FLines.Free;
  FFormatOptions.Free;

  inherited;
end;

procedure TLMDStringsPrintTask.LoadFromRtf(AEdit: TRichEdit);
begin
  SaveRTFLines(FLines, AEdit);
end;

procedure TLMDStringsPrintTask.SetFormatOptions(
  const Value: TLMDTextAreaSettings);
begin
  FFormatOptions.Assign(Value);
end;

procedure TLMDStringsPrintTask.SetLines(const Value: TLMDStrings);
begin
  if Value=nil then
    raise ELMDPrintPackError.Create(SLMDPrintNilArgument);

  FLines.Assign(Value);
end;

end.
