unit LMD_RegPrint;
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

_LMD_RegPrint unit (RM)
-----------------------

Changes
-------
Release 1.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors, 
  Classes, Dialogs, Controls, SysUtils,
  LMDPrintPreviewDlg, LMDStringsPrintTask, LMDImagePrintTask, LMDControlPrintTasks;

procedure Register;

implementation

uses
  LMDPrinter, LMDPrintPreviewPanel, LMDPrintStatusBar, LMDPrintToolBar,
  LMDPrintPageDialog, LMDMlGen, pLMDCEX, pLMDCommon, pLMDPrintPE;

procedure Register; {==========================================================}
begin
  RegisterComponents('LMD Print', [TLMDMLGen,
                                   TLMDPrinter,
                                   TLMDPrintPreviewPanel,
                                   TLMDPrintStatusBar,
                                   TLMDPrintToolBar,
                                   TLMDPrintPageSetupDialog,
                                   TLMDPrintDialog,
                                   TLMDPrinterSetupDialog,
                                   TLMDPrintPreviewDialog,
                                   TLMDStringsPrintTask,
                                   TLMDImagePrintTask,
                                   TLMDEditPrintTask,
                                   TLMDStringGridPrintTask,
                                   TLMDListViewPrintTask]);

  RegisterComponentEditor(TLMDPrinter, TLMDPrinterEditor);
  RegisterPropertyEditor(TypeInfo(TStrings), TLMDPageTemplateBlock, 'Template', TLMDPrintTemplateProperty);
end;

end.
