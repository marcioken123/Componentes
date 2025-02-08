// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dcllmdtools.dpk' rev: 31.00 (Windows)

#ifndef DcllmdtoolsHPP
#define DcllmdtoolsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <LMD_RegMain.hpp>
#include <LMD_RegMainEditors.hpp>
#include <pLMDCPGetMain.hpp>
#include <pLMDCstMain.hpp>
#include <pLMDCEMain.hpp>
#include <pLMDPeMain.hpp>
#include <pLMDRegOS.hpp>
#include <pLMD3DEffectEditorDlg.hpp>
#include <pLMDBmpRegionEditorDlg.hpp>
#include <pLMDButtonBarEditorDlg.hpp>
#include <pLMDCaptionEditorDlg.hpp>
#include <pLMDDlgBtnEditorDlg.hpp>
#include <pLMDFilterPropertyEditorDlg.hpp>
#include <pLMDGraphicLabelEditorDlg.hpp>
#include <pLMDHideNonVC.hpp>
#include <pLMDLEDEditorDlg.hpp>
#include <pLMDLightEditorDlg.hpp>
#include <pLMDMMButtonFaceEditorDlg.hpp>
#include <pLMDOSPropForm.hpp>
#include <pLMDPointListEditorDlg.hpp>
#include <pLMDSendKeyEditorDlg.hpp>
#include <pLMDShadowEditorDlg.hpp>
#include <pLMDShapeEditorDlg.hpp>
#include <pLMDSimpleBevelEditorDlg.hpp>
#include <pLMDStyleManProp.hpp>
#include <pLMDTeethEditorDlg.hpp>
#include <pLMDVldRegExpEditor.hpp>
#include <pLMDDateListEditorDlg.hpp>
#include <pLMDControlFaceEditorDlg.hpp>
#include <pLMDControlFaceEditorDlgAddState.hpp>
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
#include <System.Actions.hpp>	// (rtl)
#include <System.TimeSpan.hpp>	// (rtl)
#include <System.DateUtils.hpp>	// (rtl)
#include <System.IOUtils.hpp>	// (rtl)
#include <System.Win.Registry.hpp>	// (rtl)
#include <Vcl.Graphics.hpp>	// (vcl)
#include <System.SyncObjs.hpp>	// (rtl)
#include <System.AnsiStrings.hpp>	// (rtl)
#include <System.Win.ComObj.hpp>	// (rtl)
#include <Winapi.MsCTF.hpp>	// (rtl)
#include <Winapi.UxTheme.hpp>	// (rtl)
#include <Vcl.GraphUtil.hpp>	// (vcl)
#include <Vcl.StdCtrls.hpp>	// (vcl)
#include <Winapi.ShellAPI.hpp>	// (rtl)
#include <Vcl.Printers.hpp>	// (vcl)
#include <Vcl.Clipbrd.hpp>	// (vcl)
#include <Vcl.ComCtrls.hpp>	// (vcl)
#include <System.HelpIntfs.hpp>	// (rtl)
#include <Vcl.Dialogs.hpp>	// (vcl)
#include <Vcl.ExtCtrls.hpp>	// (vcl)
#include <Vcl.Themes.hpp>	// (vcl)
#include <Vcl.Controls.hpp>	// (vcl)
#include <Vcl.Menus.hpp>	// (vcl)
#include <Winapi.FlatSB.hpp>	// (rtl)
#include <Vcl.Forms.hpp>	// (vcl)
#include <Vcl.ActnList.hpp>	// (vcl)
#include <IDEMessages.hpp>	// (designide)
#include <Vcl.CaptionedDockTree.hpp>	// (vcl)
#include <Vcl.DockTabSet.hpp>	// (vcl)
#include <PercentageDockTree.hpp>	// (designide)
#include <BrandingAPI.hpp>	// (designide)
#include <Vcl.Buttons.hpp>	// (vcl)
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
#include <LMDThemes.hpp>	// (lmdrtrtlx)
#include <LMDButtonBase.hpp>	// (lmdrtrtlx)
#include <LMDUtils.hpp>	// (lmdrtl)
#include <LMDGraphUtils.hpp>	// (lmdrtrtlx)
#include <LMDPNGImage.hpp>	// (lmdrtrtlx)
#include <LMDCont.hpp>	// (lmdrtrtlx)
#include <LMDCFCSettingObject.hpp>	// (lmdrtrtlx)
#include <LMDCFCStateObject.hpp>	// (lmdrtrtlx)
#include <LMDStyleMan.hpp>	// (lmdrtrtlx)
#include <LMDLED.hpp>	// (lmdrttools)
#include <LMDDateTime.hpp>	// (lmdrtl)
#include <LMDButtonBar.hpp>	// (lmdrttools)
#include <LMDGlyph.hpp>	// (lmdrtrtlx)
#include <LMDDateUtils.hpp>	// (lmdrtl)
#include <LMDNoteBook.hpp>	// (lmdrttools)
#include <LMDPageControl.hpp>	// (lmdrtcore)
#include <LMDCaptionPanelGroup.hpp>	// (lmdrttools)
#include <LMDCaptionPanel.hpp>	// (lmdrttools)
#include <LMDSplt.hpp>	// (lmdrtcore)
#include <LMDCustomStatusBar.hpp>	// (lmdrtrtlx)
#include <LMDTimeFormat.hpp>	// (lmdrtcore)
#include <LMDAssist.hpp>	// (lmdrttools)
#include <LMDDwmApi.hpp>	// (lmdrtrtlx)
#include <LMDDlgEx.hpp>	// (lmdrttools)
#include <LMDFormPersistent.hpp>	// (lmdrtrtlx)
#include <LMDHookComponent.hpp>	// (lmdrtrtlx)
#include <LMDHTMLUnit.hpp>	// (lmdrtrtlx)
#include <LMDHTMLComboBox.hpp>	// (lmdrtcore)
#include <LMDHeaderListComboBox.hpp>	// (lmdrttools)
#include <LMDRegExpr.hpp>	// (lmdrtl)
#include <LMDCustomShapeHint.hpp>	// (lmdrtcore)
#include <Vcl.Grids.hpp>	// (vcl)
#include <LMDPrintTemplateEditDlg.hpp>	// (lmdrtprint)
#include <LMDPrintPageDialog.hpp>	// (lmdrtprint)
#include <LMDPrintResModule.hpp>	// (lmdrtprint)
#include <LMDPrintToolBar.hpp>	// (lmdrtprint)
#include <LMDPrinter.hpp>	// (lmdrtprint)
#include <LMDControlPrintTasks.hpp>	// (lmdrtprint)
#include <pLMDCst.hpp>	// (dcllmdrtl)
#include <pLMDCPGetBase.hpp>	// (dcllmdrtl)
#include <pLMDCommon.hpp>	// (dcllmdrtl)
#include <ToolWnds.hpp>	// (designide)
#include <ColnEdit.hpp>	// (designide)
#include <pLMDGlobalEditors.hpp>	// (dcllmdrtl)
#include <pLMDCEBase.hpp>	// (dcllmdrtlx)
#include <Vcl.Imaging.pngimage.hpp>	// (vclimg)
#include <pLMDActionsData.hpp>	// (dcllmdrtlx)
#include <LMDExtDialogs.hpp>	// (lmdrtrtlx)
#include <pLMDStdListEditorDlg.hpp>	// (dcllmdrtlx)
#include <pLMDExtImageListEditorDlg.hpp>	// (dcllmdrtlx)
#include <pLMDDsgnCPGetX.hpp>	// (dcllmdrtlx)
#include <pLMDToolBarEditorDlg.hpp>	// (dcllmdcore)
#include <pLMDPeCore.hpp>	// (dcllmdcore)
#include <pLMDCECore.hpp>	// (dcllmdcore)
#include <pLMDOIEnh.hpp>	// (dcllmdrtl)

//-- user supplied -----------------------------------------------------------

namespace Dcllmdtools
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dcllmdtools */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_DCLLMDTOOLS)
using namespace Dcllmdtools;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DcllmdtoolsHPP
