// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'lmdrttoolsdb.dpk' rev: 31.00 (Windows)

#ifndef LmdrttoolsdbHPP
#define LmdrttoolsdbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <LMDDBBase.hpp>
#include <LMDBookmarkCont.hpp>
#include <LMDBookmarkList.hpp>
#include <LMDCSV2DBImport.hpp>
#include <LMDCSVImport.hpp>
#include <LMDDBBtn.hpp>
#include <LMDDBCal.hpp>
#include <LMDDBCalculatorComboBox.hpp>
#include <LMDDBCalendarComboBox.hpp>
#include <LMDDBCheckBox.hpp>
#include <LMDDBCheckGroup.hpp>
#include <LMDDBColorComboBox.hpp>
#include <LMDDBConst.hpp>
#include <LMDDBEdit.hpp>
#include <LMDDBEditDBLookup.hpp>
#include <LMDDBExport.hpp>
#include <LMDDBExtSpinEdit.hpp>
#include <LMDDBFieldComboBox.hpp>
#include <LMDDBGlyphInfoLabel.hpp>
#include <LMDDBGraphicLabel.hpp>
#include <LMDDBImageComboBox.hpp>
#include <LMDDBImageListBox.hpp>
#include <LMDDBInformationLabel.hpp>
#include <LMDDBLabel.hpp>
#include <LMDDBHTMLLabel.hpp>
#include <LMDDBLabelFill.hpp>
#include <LMDDBLEDLabel.hpp>
#include <LMDDBLight.hpp>
#include <LMDDBListComboBox.hpp>
#include <LMDDBLookupCtrls.hpp>
#include <LMDDBMaskEdit.hpp>
#include <LMDDBMemo.hpp>
#include <LMDDBNImage.hpp>
#include <LMDDBProgress.hpp>
#include <LMDDBProgressFill.hpp>
#include <LMDDBRadioButton.hpp>
#include <LMDDBRadioGroup.hpp>
#include <LMDDBRestoreGrid.hpp>
#include <LMDDBShapeControl.hpp>
#include <LMDDBSimpleLabel.hpp>
#include <LMDDBSpeedButton.hpp>
#include <LMDDBSpinEdit.hpp>
#include <LMDDBSwitch.hpp>
#include <LMDDBTrackBar.hpp>
#include <LMDDBTreeComboBox.hpp>
#include <LMDEditDBLookup.hpp>
#include <LMDImport.hpp>
#include <Winapi.Windows.hpp>	// (rtl)
#include <Winapi.PsAPI.hpp>	// (rtl)
#include <System.Character.hpp>	// (rtl)
#include <System.Internal.ExcUtils.hpp>	// (rtl)
#include <System.SysUtils.hpp>	// (rtl)
#include <System.VarUtils.hpp>	// (rtl)
#include <System.Variants.hpp>	// (rtl)
#include <System.Rtti.hpp>	// (rtl)
#include <System.TypInfo.hpp>	// (rtl)
#include <System.Math.hpp>	// (rtl)
#include <System.Generics.Defaults.hpp>	// (rtl)
#include <System.Classes.hpp>	// (rtl)
#include <System.TimeSpan.hpp>	// (rtl)
#include <System.DateUtils.hpp>	// (rtl)
#include <Data.SqlTimSt.hpp>	// (dbrtl)
#include <Data.FmtBcd.hpp>	// (dbrtl)
#include <Data.DB.hpp>	// (dbrtl)
#include <System.IOUtils.hpp>	// (rtl)
#include <System.Win.Registry.hpp>	// (rtl)
#include <Vcl.Graphics.hpp>	// (vcl)
#include <System.Actions.hpp>	// (rtl)
#include <Vcl.ActnList.hpp>	// (vcl)
#include <System.HelpIntfs.hpp>	// (rtl)
#include <System.SyncObjs.hpp>	// (rtl)
#include <Winapi.UxTheme.hpp>	// (rtl)
#include <Vcl.GraphUtil.hpp>	// (vcl)
#include <Vcl.StdCtrls.hpp>	// (vcl)
#include <Winapi.ShellAPI.hpp>	// (rtl)
#include <Vcl.Printers.hpp>	// (vcl)
#include <Vcl.Clipbrd.hpp>	// (vcl)
#include <Vcl.ComCtrls.hpp>	// (vcl)
#include <Vcl.Dialogs.hpp>	// (vcl)
#include <Vcl.ExtCtrls.hpp>	// (vcl)
#include <Vcl.Themes.hpp>	// (vcl)
#include <System.AnsiStrings.hpp>	// (rtl)
#include <System.Win.ComObj.hpp>	// (rtl)
#include <Winapi.FlatSB.hpp>	// (rtl)
#include <Vcl.Forms.hpp>	// (vcl)
#include <Vcl.Menus.hpp>	// (vcl)
#include <Winapi.MsCTF.hpp>	// (rtl)
#include <Vcl.Controls.hpp>	// (vcl)
#include <Vcl.Buttons.hpp>	// (vcl)
#include <Vcl.DBLogDlg.hpp>	// (vcldb)
#include <Vcl.DBPWDlg.hpp>	// (vcldb)
#include <Vcl.DBCtrls.hpp>	// (vcldb)
#include <LMDUnicode.hpp>	// (lmdrtl)
#include <LMDSysIn.hpp>	// (lmdrtl)
#include <LMDIniCtrl.hpp>	// (lmdrtl)
#include <LMDShUtils.hpp>	// (lmdrtl)
#include <LMDClass.hpp>	// (lmdrtl)
#include <LMDZCompressUnit.hpp>	// (lmdrtl)
#include <LMDTypes.hpp>	// (lmdrtl)
#include <LMDButtonBase.hpp>	// (lmdrtrtlx)
#include <LMDUtils.hpp>	// (lmdrtl)
#include <LMDThemes.hpp>	// (lmdrtrtlx)
#include <LMDGraphUtils.hpp>	// (lmdrtrtlx)
#include <LMDGlyph.hpp>	// (lmdrtrtlx)
#include <LMDCont.hpp>	// (lmdrtrtlx)
#include <LMDPNGImage.hpp>	// (lmdrtrtlx)
#include <LMDCFCSettingObject.hpp>	// (lmdrtrtlx)
#include <LMDCFCStateObject.hpp>	// (lmdrtrtlx)
#include <LMDStyleMan.hpp>	// (lmdrtrtlx)
#include <LMDDateUtils.hpp>	// (lmdrtl)
#include <LMDCustomStatusBar.hpp>	// (lmdrtrtlx)
#include <LMDTimeFormat.hpp>	// (lmdrtcore)
#include <LMDHookComponent.hpp>	// (lmdrtrtlx)
#include <LMDHTMLUnit.hpp>	// (lmdrtrtlx)
#include <LMDLED.hpp>	// (lmdrttools)
#include <LMDComboBoxExt.hpp>	// (lmdrtcore)

//-- user supplied -----------------------------------------------------------

namespace Lmdrttoolsdb
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrttoolsdb */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTTOOLSDB)
using namespace Lmdrttoolsdb;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrttoolsdbHPP
