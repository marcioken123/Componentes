unit LMDPrintPreviewDlg;
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

LMDPrintPreviewDlg unit (RM)
----------------------------
Predefined Preview Dialog

Changes
-------
Release 8.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Math, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDPrintToolBar, LMDControl, LMDCustomComponent, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomStatusBar, LMDPrintStatusBar, LMDPrintPreviewPanel, LMDPrinter,
  LMDCustomPrintTask, LMDPrintConst, LMDPrintPageDialog, ExtCtrls;

type
  TLMDPrintPreviewForm = class(TForm)
    LMDPrintStatusBar1: TLMDPrintStatusBar;
    pp: TLMDPrintPreviewPanel;
    LMDPrintToolBar1: TLMDPrintToolBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  protected
  public
  end;

  TLMDPrintPreviewDialog = class(TLMDPrintBaseDialog)
  private
    FPreviewDlg: TForm;
    function GetLMDPrinter: TLMDPrinter;
    procedure SetLMDPrinter(APrinter: TLMDPrinter);
  protected
    function DoExecute(ParentWnd: HWND): Boolean; override;
    procedure DoClose; override;
    procedure DoShow; override;
  public
    constructor Create (AOwner: TComponent); override;

    procedure ShowModal;

    function  GetDialogForm: TForm;
  published
    property Printer: TLMDPrinter read GetLMDPrinter write SetLMDPrinter;
  end;

  procedure LMDPrintExecPreviewDlg(APrintHelper: TLMDPrinterHelper);

implementation
{$R *.dfm}

procedure LMDPrintExecPreviewDlg(APrintHelper: TLMDPrinterHelper);
begin
  with TLMDPrintPreviewForm.Create(nil) do
  try
    pp.PrinterHelper := APrintHelper;
    ShowModal;
  finally
    pp.PrinterHelper := nil;
    Free;
  end;
end;

procedure TLMDPrintPreviewForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_ESCAPE) and (not (csDesigning in ComponentState)) then
  begin
    ModalResult := mrOk;
    Close;
  end;
end;

{----------------------------------------------------------------------------}

constructor TLMDPrintPreviewDialog.Create(AOwner: TComponent);
begin
  inherited;

  Self.FPreviewDlg := nil;
end;

procedure TLMDPrintPreviewDialog.DoClose;
begin
  inherited;

  FreeAndNil(FPreviewDlg);
end;

function TLMDPrintPreviewDialog.DoExecute(ParentWnd: HWND): Boolean;
var
  res: Integer;
begin
  CheckPrinterSet;

  Assert(FPreviewDlg<>nil);
  TLMDPrintPreviewForm(FPreviewDlg).pp.PrinterHelper := GetLMDPrinter.PrinterHelper;
  try
    res := FPreviewDlg.ShowModal;
  finally
    TLMDPrintPreviewForm(FPreviewDlg).pp.PrinterHelper := nil;
  end;

  Result := res<>mrCancel;
end;

procedure TLMDPrintPreviewDialog.DoShow;
begin
  FPreviewDlg := TLMDPrintPreviewForm.Create(nil);

  inherited;
end;

function TLMDPrintPreviewDialog.GetLMDPrinter: TLMDPrinter;
begin
  Result := FPrinter as TLMDPrinter;
end;

function TLMDPrintPreviewDialog.GetDialogForm: TForm;
begin
  Result := FPreviewDlg;
end;

procedure TLMDPrintPreviewDialog.SetLMDPrinter(APrinter: TLMDPrinter);
begin
  inherited SetPrinter(APrinter);
end;

procedure TLMDPrintPreviewDialog.ShowModal;
begin
  inherited Execute{$IFDEF LMDCOMP9}(0){$ENDIF};
end;

end.
