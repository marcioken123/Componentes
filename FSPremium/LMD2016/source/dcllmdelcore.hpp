// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dcllmdelcore.dpk' rev: 31.00 (Windows)

#ifndef DcllmdelcoreHPP
#define DcllmdelcoreHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <LMD_RegElCore.hpp>
#include <pLMDElCE.hpp>
#include <pLMDElPE.hpp>
#include <pLMDElFormPers.hpp>
#include <pLMDElImgListEdit.hpp>
#include <pLMDElImgListEditDlg.hpp>
#include <pLMDElItemCol.hpp>
#include <pLMDElItemsProp.hpp>
#include <pLMDElMenuDsgn.hpp>
#include <pLMDElMlCapProp.hpp>
#include <pLMDElSectEdit.hpp>
#include <pLMDElSectProp.hpp>
#include <pLMDElSoundMap.hpp>
#include <pLMDElStrPoolEdit.hpp>
#include <pLMDElStyleImageSelect.hpp>
#include <pLMDElStyleManProp.hpp>
#include <pLMDElHTMLEditorDlg.hpp>
#include <pLMDElXItemCol.hpp>
#include <pLMDElXItemsProp.hpp>
#include <pLMDElXSectEdit.hpp>
#include <pLMDElXSectProp.hpp>
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
#include <Winapi.UxTheme.hpp>	// (rtl)
#include <Vcl.ActnList.hpp>	// (vcl)
#include <System.AnsiStrings.hpp>	// (rtl)
#include <System.Win.ComObj.hpp>	// (rtl)
#include <Winapi.MsCTF.hpp>	// (rtl)
#include <Vcl.GraphUtil.hpp>	// (vcl)
#include <Winapi.ShellAPI.hpp>	// (rtl)
#include <Vcl.Controls.hpp>	// (vcl)
#include <Vcl.StdCtrls.hpp>	// (vcl)
#include <Vcl.Printers.hpp>	// (vcl)
#include <Vcl.Clipbrd.hpp>	// (vcl)
#include <Vcl.ComCtrls.hpp>	// (vcl)
#include <System.HelpIntfs.hpp>	// (rtl)
#include <Vcl.Dialogs.hpp>	// (vcl)
#include <Vcl.ExtCtrls.hpp>	// (vcl)
#include <Vcl.Themes.hpp>	// (vcl)
#include <Vcl.Menus.hpp>	// (vcl)
#include <Winapi.FlatSB.hpp>	// (rtl)
#include <Vcl.Forms.hpp>	// (vcl)
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
#include <LMDSysIn.hpp>	// (lmdrtl)
#include <LMDIniCtrl.hpp>	// (lmdrtl)
#include <LMDShUtils.hpp>	// (lmdrtl)
#include <LMDClass.hpp>	// (lmdrtl)
#include <LMDZCompressUnit.hpp>	// (lmdrtl)
#include <LMDTypes.hpp>	// (lmdrtl)
#include <ElCRC32.hpp>	// (lmdrtelcore)
#include <LMDUtils.hpp>	// (lmdrtl)
#include <ElRegUtils.hpp>	// (lmdrtelcore)
#include <LMDThemes.hpp>	// (lmdrtrtlx)
#include <LMDButtonBase.hpp>	// (lmdrtrtlx)
#include <LMDGraphUtils.hpp>	// (lmdrtrtlx)
#include <ElVCLUtils.hpp>	// (lmdrtelcore)
#include <ElTools.hpp>	// (lmdrtelcore)
#include <ElIni.hpp>	// (lmdrtelcore)
#include <ElHook.hpp>	// (lmdrtelcore)
#include <LMDPNGImage.hpp>	// (lmdrtrtlx)
#include <LMDHookComponent.hpp>	// (lmdrtrtlx)
#include <LMDHTMLUnit.hpp>	// (lmdrtrtlx)
#include <ElStyleMan.hpp>	// (lmdrtelcore)
#include <ElTimers.hpp>	// (lmdrtelcore)
#include <ElToolBar.hpp>	// (lmdrtelcore)
#include <ElMenuBar.hpp>	// (lmdrtelcore)
#include <ElMenus.hpp>	// (lmdrtelcore)
#include <ElPopBtn.hpp>	// (lmdrtelcore)
#include <ElProcessUtils.hpp>	// (lmdrtelcore)
#include <ElSBHook.hpp>	// (lmdrtelcore)
#include <ElSBCtrl.hpp>	// (lmdrtelcore)
#include <ElEdits.hpp>	// (lmdrtelcore)
#include <ElTopmost.hpp>	// (lmdrtelcore)
#include <ElHeader.hpp>	// (lmdrtelcore)
#include <ElScrollBar.hpp>	// (lmdrtelcore)
#include <ElTree.hpp>	// (lmdrtelcore)
#include <ElXTree.hpp>	// (lmdrtelcore)
#include <LMDRegExpr.hpp>	// (lmdrtl)
#include <ElCheckCtl.hpp>	// (lmdrtelcore)
#include <ElCalc.hpp>	// (lmdrtelcore)
#include <Vcl.Grids.hpp>	// (vcl)
#include <LMDDateUtils.hpp>	// (lmdrtl)
#include <ElClock.hpp>	// (lmdrtelcore)
#include <ElCalendar.hpp>	// (lmdrtelcore)
#include <ElDTPick.hpp>	// (lmdrtelcore)
#include <ElClrCmb.hpp>	// (lmdrtelcore)
#include <ElHotKey.hpp>	// (lmdrtelcore)
#include <ElInputDlg.hpp>	// (lmdrtelcore)
#include <ElOneInst.hpp>	// (lmdrtelcore)
#include <ElShellUtils.hpp>	// (lmdrtelcore)
#include <ElFontListBox.hpp>	// (lmdrtelcore)
#include <ElFontCombo.hpp>	// (lmdrtelcore)
#include <ElAdvPanel.hpp>	// (lmdrtelcore)
#include <ElSideBar.hpp>	// (lmdrtelcore)
#include <ElSysHotKey.hpp>	// (lmdrtelcore)
#include <ElTray.hpp>	// (lmdrtelcore)
#include <ElVerInfo.hpp>	// (lmdrtelcore)
#include <ElFolderDlg.hpp>	// (lmdrtelcore)
#include <ElHTMLHint.hpp>	// (lmdrtelcore)
#include <pLMDCst.hpp>	// (dcllmdrtl)
#include <Vcl.Imaging.pngimage.hpp>	// (vclimg)
#include <LMDCont.hpp>	// (lmdrtrtlx)
#include <pLMDActionsData.hpp>	// (dcllmdrtlx)
#include <LMDFormPersistent.hpp>	// (lmdrtrtlx)
#include <LMDExtDialogs.hpp>	// (lmdrtrtlx)
#include <pLMDStdListEditorDlg.hpp>	// (dcllmdrtlx)
#include <pLMDExtImageListEditorDlg.hpp>	// (dcllmdrtlx)
#include <pLMDDsgnCPGetX.hpp>	// (dcllmdrtlx)
#include <ToolWnds.hpp>	// (designide)
#include <ColnEdit.hpp>	// (designide)
#include <LMDDateTime.hpp>	// (lmdrtl)
#include <pLMDCommon.hpp>	// (dcllmdrtl)
#include <pLMDCPGetBase.hpp>	// (dcllmdrtl)

//-- user supplied -----------------------------------------------------------

namespace Dcllmdelcore
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dcllmdelcore */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_DCLLMDELCORE)
using namespace Dcllmdelcore;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DcllmdelcoreHPP
