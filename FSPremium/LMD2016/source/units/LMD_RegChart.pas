unit LMD_RegChart;
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

_LMDChart_Reg LMD Chart Pack registration unit
----------------------------------------------
LMD Chart Pack registration unit

Changes
-------
Release 1.0 (July 2006)
 - Initial Release

-------
Series-based chart data model support added (24-June-2007) - Series components

###############################################################################}
interface

uses
  Classes,
  DesignIntf, DesignEditors, VCLEditors,
  LMDChart, LMDChartCTAreaLine, LMDChartCTAreaLine3D, LMDChartCTBar, LMDChartCTPie2D,
  LMDChartCTColumn, LMDChartCTColumn3D, LMDChartCTBar3D, LMDChartCTAreaSpline,
  LMDChartCTAreaSpline3D, LMDChartCTDoughnut, LMDChartSeries, LMDChartCTLine, 
  LMDChartPrintTask,
  pLMDCommon, pLMDAlignmentEditor, pLMDMarginsEditor, pLMDChartCE, pLMDChartSeriesEditor;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LMD Chart',  [TLMDChart,

                                    TLMDChartSeries,

                                    TLMDChartPrintTask, 

                                    TLMDChartCTColumn,
                                    TLMDChartCTBar,
                                    TLMDChartCTAreaLine,
                                    TLMDChartCTPie2D,
                                    TLMDChartCTColumn3D,
                                    TLMDChartCTBar3D,
                                    TLMDChartCTAreaLine3D,
                                    TLMDChartCTAreaSpline,
                                    TLMDChartCTDoughnut,
                                    TLMDChartCTAreaSpline3D,
                                    TLMDChartCTLine]);

  RegisterComponentEditor(TLMDChart, TLMDChartComponentEditor);                                    
  RegisterComponentEditor(TLMDChartSeries, TLMDChartSeriesEditor);

  // register only when DesignEditors and Actions should be installed
  if leoInstallDesignEditorControls in LMDTOOLSEDITOROPTIONS then
    begin
      RegisterComponents('LMD EditorCtrls', [TLMDAlignmentEditor]);
      RegisterComponents('LMD EditorCtrls', [TLMDMarginsEditor]);
    end;
end;

end.
