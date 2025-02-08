// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'lmdrteldb.dpk' rev: 31.00 (Windows)

#ifndef LmdrteldbHPP
#define LmdrteldbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <ElDBBoxes.hpp>
#include <ElDBBtnEdit.hpp>
#include <LMDElDBConst.hpp>
#include <ElDBCtrls.hpp>
#include <ElDBCurrEdit.hpp>
#include <ElDBDTPick.hpp>
#include <ElDBHTMLView.hpp>
#include <ElDBInspector.hpp>
#include <ElDBLbl.hpp>
#include <ElDBLookupCtrls.hpp>
#include <ElDBSpin.hpp>
#include <ElDBTree.hpp>
#include <ElDBTreeEditors.hpp>
#include <ElDBTreeGrids.hpp>
#include <ElDBTreeNavigator.hpp>
#include <ElDBWideComboBox.hpp>
#include <ElDBWideLookupComboGrid.hpp>
#include <ElDBWideLookupControls.hpp>
#include <ElDBXTree.hpp>
#include <ElDBXTreeGrids.hpp>
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
#include <LMDGraphUtils.hpp>	// (lmdrtrtlx)
#include <LMDThemes.hpp>	// (lmdrtrtlx)
#include <LMDPNGImage.hpp>	// (lmdrtrtlx)
#include <LMDHookComponent.hpp>	// (lmdrtrtlx)
#include <LMDHTMLUnit.hpp>	// (lmdrtrtlx)
#include <ElVCLUtils.hpp>	// (lmdrtelcore)
#include <ElCRC32.hpp>	// (lmdrtelcore)
#include <ElRegUtils.hpp>	// (lmdrtelcore)
#include <ElTools.hpp>	// (lmdrtelcore)
#include <ElIni.hpp>	// (lmdrtelcore)
#include <ElStyleMan.hpp>	// (lmdrtelcore)
#include <ElHook.hpp>	// (lmdrtelcore)
#include <ElTimers.hpp>	// (lmdrtelcore)
#include <ElMenuBar.hpp>	// (lmdrtelcore)
#include <ElMenus.hpp>	// (lmdrtelcore)
#include <ElPopBtn.hpp>	// (lmdrtelcore)
#include <ElToolBar.hpp>	// (lmdrtelcore)
#include <ElCheckCtl.hpp>	// (lmdrtelcore)
#include <ElTopmost.hpp>	// (lmdrtelcore)
#include <ElProcessUtils.hpp>	// (lmdrtelcore)
#include <ElSBHook.hpp>	// (lmdrtelcore)
#include <ElSBCtrl.hpp>	// (lmdrtelcore)
#include <ElEdits.hpp>	// (lmdrtelcore)
#include <ElCalc.hpp>	// (lmdrtelcore)
#include <Vcl.Grids.hpp>	// (vcl)
#include <LMDDateUtils.hpp>	// (lmdrtl)
#include <ElClock.hpp>	// (lmdrtelcore)
#include <ElCalendar.hpp>	// (lmdrtelcore)
#include <ElDTPick.hpp>	// (lmdrtelcore)
#include <ElHeader.hpp>	// (lmdrtelcore)
#include <ElScrollBar.hpp>	// (lmdrtelcore)
#include <ElTree.hpp>	// (lmdrtelcore)
#include <ElClrCmb.hpp>	// (lmdrtelcore)
#include <ElXTree.hpp>	// (lmdrtelcore)
#include <Vcl.ExtDlgs.hpp>	// (vcl)
#include <ElInspector.hpp>	// (lmdrtelpro)

//-- user supplied -----------------------------------------------------------

namespace Lmdrteldb
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrteldb */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTELDB)
using namespace Lmdrteldb;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrteldbHPP
