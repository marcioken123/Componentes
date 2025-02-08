// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dcllmdcore.dpk' rev: 31.00 (Windows)

#ifndef DcllmdcoreHPP
#define DcllmdcoreHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <LMD_RegCore.hpp>
#include <LMD_RegCoreEditors.hpp>
#include <pLMDCPGetCore.hpp>
#include <pLMDBevelEditorDlg.hpp>
#include <pLMDBitmapEffectEditorDlg.hpp>
#include <pLMDBitmapStyleEditorDlg.hpp>
#include <pLMDButtonLayoutEditorDlg.hpp>
#include <pLMDCECore.hpp>
#include <pLMDDateTimeFormatEditorDlg.hpp>
#include <pLMDExDsgnOIEnh.hpp>
#include <pLMDFillObjectEditorDlg.hpp>
#include <pLMDFontFXEditorDlg.hpp>
#include <pLMDGlyphTextLayoutEditorDlg.hpp>
#include <pLMDGradientEditorDlg.hpp>
#include <pLMDMaskEditorDlg.hpp>
#include <pLMDPeCore.hpp>
#include <pLMDSmallBarEditorDlg.hpp>
#include <pLMDStatusBarEditorDlg.hpp>
#include <pLMDStringsEditorDlg.hpp>
#include <pLMDTransparentEditorDlg.hpp>
#include <pLMDToolBarEditorDlg.hpp>
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
#include <IDEMessages.hpp>	// (designide)
#include <Vcl.CaptionedDockTree.hpp>	// (vcl)
#include <Vcl.DockTabSet.hpp>	// (vcl)
#include <PercentageDockTree.hpp>	// (designide)
#include <BrandingAPI.hpp>	// (designide)
#include <Vcl.ExtDlgs.hpp>	// (vcl)
#include <Winapi.Mapi.hpp>	// (rtl)
#include <Vcl.ExtActns.hpp>	// (vcl)
#include <Vcl.ActnMenus.hpp>	// (vclactnband)
#include <Vcl.ActnMan.hpp>	// (vclactnband)
#include <Vcl.PlatformDefaultStyleActnCtrls.hpp>	// (vclactnband)
#include <BaseDock.hpp>	// (designide)
#include <DeskUtil.hpp>	// (designide)
#include <DeskForm.hpp>	// (designide)
#include <DockForm.hpp>	// (designide)
#include <Xml.Win.msxmldom.hpp>	// (xmlrtl)
#include <Xml.xmldom.hpp>	// (xmlrtl)
#include <ToolsAPI.hpp>	// (designide)
#include <Proxies.hpp>	// (designide)
#include <DesignEditors.hpp>	// (designide)
#include <Vcl.Grids.hpp>	// (vcl)
#include <System.Devices.hpp>	// (rtl)
#include <Vcl.AxCtrls.hpp>	// (vcl)
#include <Vcl.AppEvnts.hpp>	// (vcl)
#include <TreeIntf.hpp>	// (designide)
#include <TopLevels.hpp>	// (designide)
#include <StFilSys.hpp>	// (designide)
#include <IDEHelp.hpp>	// (designide)
#include <ComponentDesigner.hpp>	// (designide)
#include <VCLEditors.hpp>	// (designide)
#include <LMDUnicode.hpp>	// (lmdrtl)
#include <LMDIniCtrl.hpp>	// (lmdrtl)
#include <LMDShUtils.hpp>	// (lmdrtl)
#include <LMDClass.hpp>	// (lmdrtl)
#include <LMDTypes.hpp>	// (lmdrtl)
#include <LMDZCompressUnit.hpp>	// (lmdrtl)
#include <LMDSysIn.hpp>	// (lmdrtl)
#include <LMDButtonBase.hpp>	// (lmdrtrtlx)
#include <LMDUtils.hpp>	// (lmdrtl)
#include <LMDThemes.hpp>	// (lmdrtrtlx)
#include <LMDGraphUtils.hpp>	// (lmdrtrtlx)
#include <LMDCont.hpp>	// (lmdrtrtlx)
#include <LMDPNGImage.hpp>	// (lmdrtrtlx)
#include <LMDCFCSettingObject.hpp>	// (lmdrtrtlx)
#include <LMDCFCStateObject.hpp>	// (lmdrtrtlx)
#include <LMDStyleMan.hpp>	// (lmdrtrtlx)
#include <LMDGlyph.hpp>	// (lmdrtrtlx)
#include <LMDCustomStatusBar.hpp>	// (lmdrtrtlx)
#include <LMDHookComponent.hpp>	// (lmdrtrtlx)
#include <LMDHTMLUnit.hpp>	// (lmdrtrtlx)
#include <LMDTimeFormat.hpp>	// (lmdrtcore)
#include <LMDComboBoxExt.hpp>	// (lmdrtcore)
#include <LMDSplt.hpp>	// (lmdrtcore)
#include <LMDPageControl.hpp>	// (lmdrtcore)
#include <LMDOneInstance.hpp>	// (lmdrtcore)
#include <LMDTrayIcon.hpp>	// (lmdrtcore)
#include <LMDCustomShapeHint.hpp>	// (lmdrtcore)
#include <ToolWnds.hpp>	// (designide)
#include <ColnEdit.hpp>	// (designide)
#include <LMDDateTime.hpp>	// (lmdrtl)
#include <pLMDCst.hpp>	// (dcllmdrtl)
#include <pLMDCPGetBase.hpp>	// (dcllmdrtl)
#include <pLMDCommon.hpp>	// (dcllmdrtl)
#include <pLMDGlobalEditors.hpp>	// (dcllmdrtl)
#include <pLMDCEBase.hpp>	// (dcllmdrtlx)
#include <LMDDwmApi.hpp>	// (lmdrtrtlx)
#include <Vcl.Imaging.pngimage.hpp>	// (vclimg)
#include <pLMDActionsData.hpp>	// (dcllmdrtlx)
#include <LMDFormPersistent.hpp>	// (lmdrtrtlx)
#include <LMDExtDialogs.hpp>	// (lmdrtrtlx)
#include <pLMDStdListEditorDlg.hpp>	// (dcllmdrtlx)
#include <pLMDExtImageListEditorDlg.hpp>	// (dcllmdrtlx)
#include <pLMDDsgnCPGetX.hpp>	// (dcllmdrtlx)
#include <LMDRegExpr.hpp>	// (lmdrtl)
#include <pLMDOIEnh.hpp>	// (dcllmdrtl)

//-- user supplied -----------------------------------------------------------

namespace Dcllmdcore
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dcllmdcore */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_DCLLMDCORE)
using namespace Dcllmdcore;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DcllmdcoreHPP
