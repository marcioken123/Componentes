// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'lmdrtchart.dpk' rev: 31.00 (Windows)

#ifndef LmdrtchartHPP
#define LmdrtchartHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChart.hpp>
#include <LMDChartArea.hpp>
#include <LMDChartAxis.hpp>
#include <LMDChartScaleBreak.hpp>
#include <LMDChartBackground.hpp>
#include <LMDChartCTAreaLine3D.hpp>
#include <LMDChartCTAreaLine.hpp>
#include <LMDChartCTAreaSpline3D.hpp>
#include <LMDChartCTAreaSpline.hpp>
#include <LMDChartCTBar3D.hpp>
#include <LMDChartCTBar.hpp>
#include <LMDChartCTColumn3D.hpp>
#include <LMDChartCTColumn.hpp>
#include <LMDChartCTDoughnut.hpp>
#include <LMDChartCTPie2D.hpp>
#include <LMDChartData.hpp>
#include <LMDChartFont.hpp>
#include <LMDChartLabel.hpp>
#include <LMDChartLegend.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartTitleBox.hpp>
#include <LMDChartTypes.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartValuesBase.hpp>
#include <LMDChartValues.hpp>
#include <LMDChartValuesCollection.hpp>
#include <LMDChartSeries.hpp>
#include <LMDChartSeriesCollection.hpp>
#include <LMDChartSource.hpp>
#include <LMDChartRectangular2DCT.hpp>
#include <LMDChartCTLine.hpp>
#include <LMDChartPrintTask.hpp>
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
#include <Vcl.Imaging.jpeg.hpp>	// (vclimg)
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
#include <LMDXML.hpp>	// (lmdrtl)
#include <LMDThemes.hpp>	// (lmdrtrtlx)
#include <LMDButtonBase.hpp>	// (lmdrtrtlx)
#include <LMDUtils.hpp>	// (lmdrtl)
#include <LMDGraphUtils.hpp>	// (lmdrtrtlx)
#include <LMDPNGImage.hpp>	// (lmdrtrtlx)
#include <LMDCont.hpp>	// (lmdrtrtlx)
#include <LMDCFCSettingObject.hpp>	// (lmdrtrtlx)
#include <LMDCFCStateObject.hpp>	// (lmdrtrtlx)
#include <LMDStyleMan.hpp>	// (lmdrtrtlx)
#include <Vcl.Buttons.hpp>	// (vcl)
#include <LMDPrintTemplateEditDlg.hpp>	// (lmdrtprint)
#include <LMDPrintPageDialog.hpp>	// (lmdrtprint)
#include <LMDPrintResModule.hpp>	// (lmdrtprint)
#include <LMDPrintToolBar.hpp>	// (lmdrtprint)
#include <LMDCustomStatusBar.hpp>	// (lmdrtrtlx)
#include <LMDPrinter.hpp>	// (lmdrtprint)

//-- user supplied -----------------------------------------------------------

namespace Lmdrtchart
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtchart */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTCHART)
using namespace Lmdrtchart;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtchartHPP
