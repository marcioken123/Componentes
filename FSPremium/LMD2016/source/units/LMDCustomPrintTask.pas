unit LMDCustomPrintTask;
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

LMDCustomPrintTask unit (RS)
-----------------------------------
Base class for all the Print Tasks of printing support package.
Tasks which use page-making and rendering logic from some control (e.g. the Syntax Edit case)
should derive directly from this class. Tasks which use TLMDLayout manager and Renderers
to lay out and render the document should derive from TLMDLayoutRenderPrintTask.

Changes
-------
* Not released yet

###############################################################################}

interface

uses
    Math, Classes, SysUtils, Windows, Printers, Graphics, Dialogs, Types,
    LMDTypes, LMDCustomComponent, LMDPrinter, LMDDocModel,
    LMDDocElementRenderer, LMDPrintConst;

type

  TLMDCustomPrintTask = class(TLMDCustomComponent)
  private
    FPagesPrepared: Boolean;

    FPrinter: TLMDPrinter;

    FRendererProxy: TLMDPrintRendererBase;

    procedure SetPrinter(const Value: TLMDPrinter);

    function  GetUnits: TLMDMeasureUnits;
    procedure SetUnits(const Value: TLMDMeasureUnits);
    function  GetRealUnits: TLMDMeasureUnits;
  protected
    FUtilPrinter: TLMDPrinter;

    procedure CheckPrinterAssigned;
    procedure CheckPagesPrepared;
    procedure CheckPagesNotPrepared;

    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;

    //Base renderer methods
    procedure PreparePagesInternal(APageWidth, APageHeight: Integer;
                                   ACanvas: TCanvas);
                                   virtual; abstract;

    function GetPagesCountInternal(ARange: TLMDPrintOperationRange): integer;
                                   virtual; abstract;

    procedure DrawPageInternal(ARange: TLMDPrintOperationRange; ANum: Integer;
                               APoint: TPoint; ACanvas: TCanvas);
                               virtual; abstract;

    procedure FinalizePagesInternal; virtual; abstract;

    procedure OnUnitsChanged(AOldUnits, ANewUnits: TLMDMeasureUnits); virtual;

    property Units: TLMDMeasureUnits read GetUnits write SetUnits
                                     default unMillimeters;
    property RealUnits: TLMDMeasureUnits read GetRealUnits;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure PreparePages; virtual;
    function  GetPagesCount: Integer; virtual;
    procedure FinalizePages; virtual;

    procedure Print; overload;
    procedure Print(AStart, ACount: Integer); overload;

    procedure ExecPrintPreviewDlg;
    procedure ExecPrintDlg;
    procedure ExecPrintSetupDlg;
    procedure ExecPageSetupDlg;
  published
    property Printer: TLMDPrinter read FPrinter write SetPrinter;
  end;

implementation

type
  TRendererProxy = class(TLMDPrintRendererBase)
  protected
    FParent: TLMDCustomPrintTask;
  public
    constructor Create(AParent: TLMDCustomPrintTask);

    procedure PreparePages(APageWidth, APageHeight: Integer;
                           ACanvas: TCanvas); override;
    procedure FinalizePages; override;
    function  GetPagesCount(ARange: TLMDPrintOperationRange): Integer; override;
    procedure DrawPage(ARange: TLMDPrintOperationRange; ANum: Integer;
                       APoint: TPoint; ACanvas: TCanvas); override;
  end;

{------------------------------------------------------------------------------}

{ TLMDCustomPrintTask }

procedure TLMDCustomPrintTask.CheckPagesNotPrepared;
begin
  if FPagesPrepared then
    raise ELMDPrintPackError.Create(SLMDPrintTaskPagesNotFinalized);
end;

procedure TLMDCustomPrintTask.CheckPagesPrepared;
begin
  if not FPagesPrepared then
    raise ELMDPrintPackError.Create(SLMDPrintTaskPagesNotPrepared);
end;

procedure TLMDCustomPrintTask.CheckPrinterAssigned;
begin
  if FPrinter=nil then
    raise ELMDPrintPackError.Create(SLMDPrinterNotAssigned);
end;

procedure TLMDCustomPrintTask.ExecPageSetupDlg;
begin
  CheckPrinterAssigned;

  FPrinter.ExecPageSetupDlg;
end;

procedure TLMDCustomPrintTask.ExecPrintDlg;
begin
  CheckPrinterAssigned;
  CheckPagesPrepared;

  FPrinter.ExecPrintDlg;
end;

procedure TLMDCustomPrintTask.ExecPrintPreviewDlg;
begin
  CheckPrinterAssigned;
  CheckPagesPrepared;

  FPrinter.ExecPreviewDlg;
end;

procedure TLMDCustomPrintTask.ExecPrintSetupDlg;
begin
  CheckPrinterAssigned;

  FPrinter.ExecPrintSetupDlg;
end;

procedure TLMDCustomPrintTask.FinalizePages;
begin
  CheckPagesPrepared;
  CheckPrinterAssigned;

  FPrinter.FinalizePages;
end;

function TLMDCustomPrintTask.GetPagesCount: Integer;
begin
  CheckPrinterAssigned;
  CheckPagesPrepared;

  Result := FPrinter.GetPagesCount(orAll);
end;

procedure TLMDCustomPrintTask.PreparePages;
begin
  CheckPrinterAssigned;
  CheckPagesNotPrepared;

  FPrinter.PreparePages(FRendererProxy);
end;

procedure TLMDCustomPrintTask.Print(AStart, ACount: Integer);
begin
  CheckPrinterAssigned;
  CheckPagesPrepared;

  FPrinter.PrintPages(orAll, AStart, ACount);
end;

procedure TLMDCustomPrintTask.Print;
begin
  CheckPrinterAssigned;
  CheckPagesPrepared;

  Print(0, GetPagesCount);
end;

procedure TLMDCustomPrintTask.SetPrinter(const Value: TLMDPrinter);
begin
  CheckPagesNotPrepared;

  if FPrinter=Value then
    Exit;

  if FPagesPrepared then
    FinalizePages;

  if FPrinter<>nil then
    FPrinter.RemoveFreeNotification(self);

  FPrinter := Value;

  if FPrinter<>nil then
    FPrinter.FreeNotification(self);
end;

procedure TLMDCustomPrintTask.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (AComponent=FPrinter) and (Operation=opRemove) then
  begin
    if FPagesPrepared then
      FinalizePages;

    FPrinter := nil;
  end;

  inherited;
end;

constructor TLMDCustomPrintTask.Create(AOwner: TComponent);
begin
  inherited;

  FPrinter := nil;
  FPagesPrepared := false;

  FRendererProxy := TRendererProxy.Create(self);

  FUtilPrinter := TLMDPrinter.Create(nil);
end;

destructor TLMDCustomPrintTask.Destroy;
begin
  if FPagesPrepared then
    FinalizePages;

  FRendererProxy.Free;

  SetPrinter(nil);

  FUtilPrinter.Free;
  inherited;
end;

function TLMDCustomPrintTask.GetUnits: TLMDMeasureUnits;
begin
  Result := FUtilPrinter.Units;
end;

procedure TLMDCustomPrintTask.SetUnits(const Value: TLMDMeasureUnits);
var
    old: TLMDMeasureUnits;
begin
  if Units<>Value then
  begin
    Old := FUtilPrinter.RealUnits;
    FUtilPrinter.Units := Value;

    OnUnitsChanged(Old, FUtilPrinter.RealUnits);
  end;
end;

function TLMDCustomPrintTask.GetRealUnits: TLMDMeasureUnits;
begin
  Result := FUtilPrinter.RealUnits;
end;

procedure TLMDCustomPrintTask.OnUnitsChanged(AOldUnits,
  ANewUnits: TLMDMeasureUnits);
begin

end;

{ TRendererProxy }

constructor TRendererProxy.Create(AParent: TLMDCustomPrintTask);
begin
  inherited Create;
  Assert(AParent<>nil);
  FParent := AParent;
end;

procedure TRendererProxy.DrawPage(ARange: TLMDPrintOperationRange;
  ANum: Integer; APoint: TPoint; ACanvas: TCanvas);
begin
  FParent.DrawPageInternal(ARange, ANum, APoint, ACanvas);
end;

procedure TRendererProxy.FinalizePages;
begin
  FParent.FinalizePagesInternal;

  FParent.FPagesPrepared := false;
end;

function TRendererProxy.GetPagesCount(ARange: TLMDPrintOperationRange): Integer;
begin
  Result := FParent.GetPagesCountInternal(ARange);
end;

procedure TRendererProxy.PreparePages(APageWidth, APageHeight: Integer;
  ACanvas: TCanvas);
begin
  FParent.PreparePagesInternal(APageWidth, APageHeight, ACanvas);

  FParent.FPagesPrepared := true;
end;

end.
