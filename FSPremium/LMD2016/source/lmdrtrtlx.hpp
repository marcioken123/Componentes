// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'lmdrtrtlx.dpk' rev: 31.00 (Windows)

#ifndef LmdrtrtlxHPP
#define LmdrtrtlxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <intfLMDBackGround.hpp>
#include <intfLMDControlPosSize.hpp>
#include <intfLMDFaceController.hpp>
#include <intfLMDFaceControllerEditable.hpp>
#include <intfLMDFaceControllerPressable.hpp>
#include <intfLMDFileDialog.hpp>
#include <LMDActnList.hpp>
#include <LMDStdActns.hpp>
#include <LMDApplicationCtrl.hpp>
#include <LMD3DCaption.hpp>
#include <LMDAlphaObject.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseController.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseMRUList.hpp>
#include <LMDBevel.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBitmapList.hpp>
#include <LMDBmp.hpp>
#include <LMDBrowseDlg.hpp>
#include <LMDButtonBase.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDCabSupport.hpp>
#include <LMDCFCSettingObject.hpp>
#include <LMDCFCStateObject.hpp>
#include <LMDCompareValidator.hpp>
#include <LMDCont.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDControl.hpp>
#include <LMDControlErrorProvider.hpp>
#include <LMDConversion.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomStatusBar.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDDateTimeRangeValidator.hpp>
#include <LMDDwmApi.hpp>
#include <LMDErrorProvider.hpp>
#include <LMDErrorProvidersGroup.hpp>
#include <LMDExtDialogs.hpp>
#include <LMDFaceController.hpp>
#include <LMDFigures.hpp>
#include <LMDFillers.hpp>
#include <LMDFormPersistent.hpp>
#include <LMDForms.hpp>
#include <LMDFillObject.hpp>
#include <LMDFloatRangeValidator.hpp>
#include <LMDFMDrop.hpp>
#include <LMDFormVista.hpp>
#include <LMDFXCaption.hpp>
#include <LMDGenericList.hpp>
#include <LMDGlyph.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDGradient.hpp>
#include <LMDGradientFrames.hpp>
#include <LMDGraph.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraphicList.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDHookComponent.hpp>
#include <LMDIconErrorProvider.hpp>
#include <LMDInPlaceErrorProvider.hpp>
#include <LMDImageList.hpp>
#include <LMDImageListConnector.hpp>
#include <LMDInteropServices.hpp>
#include <LMDIntRangeValidator.hpp>
#include <LMDMessageBoxErrorProvider.hpp>
#include <LMDNativeHint.hpp>
#include <LMDPNGImage.hpp>
#include <LMDPNGImageFilters.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDRangeValidator.hpp>
#include <LMDRegExpValidator.hpp>
#include <LMDRequiredFieldValidator.hpp>
#include <LMDRTLXConst.hpp>
#include <LMDShapeFill.hpp>
#include <LMDStreamUtils.hpp>
#include <LMDStringList.hpp>
#include <LMDStringRangeValidator.hpp>
#include <LMDStyleMan.hpp>
#include <LMDWave.hpp>
#include <LMDWaveList.hpp>
#include <LMDVistaDialogs.hpp>
#include <LMDTaskDialog.hpp>
#include <LMDTaskDialogTemplate.hpp>
#include <LMDTaskDialogButtonDsgn.hpp>
#include <LMDTaskDialogDsgn.hpp>
#include <LMDTaskDlg.hpp>
#include <LMDThemes.hpp>
#include <LMDUnicodeCtrls.hpp>
#include <LMDUnicodeDialogs.hpp>
#include <LMDVldBase.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDUsp10.hpp>
#include <LMDDropdownForm.hpp>
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
#include <LMDUnicode.hpp>	// (lmdrtl)
#include <LMDSysIn.hpp>	// (lmdrtl)
#include <LMDIniCtrl.hpp>	// (lmdrtl)
#include <LMDShUtils.hpp>	// (lmdrtl)
#include <LMDClass.hpp>	// (lmdrtl)
#include <LMDZCompressUnit.hpp>	// (lmdrtl)
#include <LMDTypes.hpp>	// (lmdrtl)
#include <LMDUtils.hpp>	// (lmdrtl)
#include <Vcl.Buttons.hpp>	// (vcl)
#include <LMDRegExpr.hpp>	// (lmdrtl)

//-- user supplied -----------------------------------------------------------

namespace Lmdrtrtlx
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtrtlx */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTRTLX)
using namespace Lmdrtrtlx;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtrtlxHPP
