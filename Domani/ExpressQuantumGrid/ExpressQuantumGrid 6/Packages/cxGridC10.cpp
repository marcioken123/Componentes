//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxGridC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxExportC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxExtEditorsC10.bpi");
USEPACKAGE("cxPageControlC10.bpi");
USEUNIT("cxGridStrs.pas");
USEFORMNS("cxFilterDialog.pas", Cxfilterdialog, cxFilterDialog);
USEUNIT("cxDBExtLookupComboBox.pas");
USEUNIT("cxGrid.pas");
USEUNIT("cxGridChartView.pas");
USEUNIT("cxGridBandedTableView.pas");
USEUNIT("cxGridCardView.pas");
USEUNIT("cxGridCommon.pas");
USEUNIT("cxGridCustomTableView.pas");
USEUNIT("cxGridCustomView.pas");
USEUNIT("cxGridDBChartView.pas");
USEUNIT("cxGridDBBandedTableView.pas");
USEUNIT("cxGridDBCardView.pas");
USEUNIT("cxGridDBDataDefinitions.pas");
USEUNIT("cxGridRows.pas");
USEUNIT("cxGridDBTableView.pas");
USEUNIT("cxGridDetailsSite.pas");
USEUNIT("cxGridLevel.pas");
USEUNIT("cxGridExportLink.pas");
USEUNIT("cxGridTableView.pas");
USEUNIT("cxGridFilterHelpers.pas");
USEUNIT("cxGridCustomPopUpMenu.pas");
USEUNIT("cxGridFooterPopupMenuItems.pas");
USEUNIT("cxGridHeaderPopupMenuItems.pas");
USEUNIT("cxGridGroupRowPopupMenuItems.pas");
USEUNIT("cxGridMenuOperations.pas");
USEUNIT("cxGridPopUpMenu.pas");
USEUNIT("cxGridStdPopUpMenu.pas");
USEUNIT("cxGridUIBandedTableHelper.pas");
USEUNIT("cxGridUICardHelper.pas");
USEUNIT("cxGridUICustomTableHelper.pas");
USEUNIT("cxGridUIHelper.pas");
USEUNIT("cxGridUITableHelper.pas");
USEUNIT("cxGridPopupMenuConsts.pas");
USEUNIT("cxGridStyleSheetsPreview.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
