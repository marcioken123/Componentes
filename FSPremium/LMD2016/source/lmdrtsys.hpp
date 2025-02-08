// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'lmdrtsys.dpk' rev: 31.00 (Windows)

#ifndef LmdrtsysHPP
#define LmdrtsysHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// (rtl)
#include <SysInit.hpp>
#include <LMDSysWindowsObject.hpp>
#include <LMDSysDisplayObject.hpp>
#include <LMDSysDrive.hpp>
#include <LMDSysDriveObject.hpp>
#include <LMDSysKeyboard.hpp>
#include <LMDSysKeyboardObject.hpp>
#include <LMDSysLocaleObject.hpp>
#include <LMDSysLog.hpp>
#include <LMDSysMemoryObject.hpp>
#include <LMDSysMouse.hpp>
#include <LMDSysMouseObject.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysPlusObject.hpp>
#include <LMDSysPowerStatusObject.hpp>
#include <LMDSysPrinterInfo.hpp>
#include <LMDSysProcessorObject.hpp>
#include <LMDSysScreenSaverObject.hpp>
#include <LMDSysSystemInfo.hpp>
#include <LMDSysTimeZoneObject.hpp>
#include <LMDSysWallpaperObject.hpp>
#include <LMDSysDisplay.hpp>
#include <LMDSysLocale.hpp>
#include <LMDSysMemory.hpp>
#include <LMDSysPowerStatus.hpp>
#include <LMDSysTimeZone.hpp>
#include <LMDSysWindows.hpp>
#include <LMDSysPrinters.hpp>
#include <LMDSysProcessor.hpp>
#include <LMDSysUninstallInfo.hpp>
#include <LMDSysUninstall.hpp>
#include <LMDSysFontInfo.hpp>
#include <LMDSysFonts.hpp>
#include <LMDSysMultimediaObject.hpp>
#include <LMDSysMultimedia.hpp>
#include <LMDSysFileAssocInfo.hpp>
#include <LMDSysInternetObject.hpp>
#include <LMDSysInternet.hpp>
#include <LMDSysFileAssoc.hpp>
#include <LMDSysLogStrings.hpp>
#include <LMDSysModemInfo.hpp>
#include <LMDSysModem.hpp>
#include <LMDSysNetworkObject.hpp>
#include <LMDSysNetwork.hpp>
#include <LMDSysConst.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysInfoTreeView.hpp>
#include <LMDSysPropertyDesc.hpp>
#include <LMDSysInfoListView.hpp>
#include <LMDSysDriveInfo.hpp>
#include <LMDSysEventLog.hpp>
#include <LMDSysNetworkEnumerator.hpp>
#include <LMDSysTreeView.hpp>
#include <LMDSysNetTreeView.hpp>
#include <LMDSysEventListView.hpp>
#include <LMDSysStrsDlg.hpp>
#include <LMDSysInfoProcs.hpp>
#include <LMDSysEventLogDetailsForm.hpp>
#include <LMDSysService.hpp>
#include <LMDSysServiceInfo.hpp>
#include <LMDSysServiceObject.hpp>
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
#include <LMDButtonBase.hpp>	// (lmdrtrtlx)
#include <LMDUtils.hpp>	// (lmdrtl)
#include <LMDGraphUtils.hpp>	// (lmdrtrtlx)
#include <LMDThemes.hpp>	// (lmdrtrtlx)
#include <Vcl.Buttons.hpp>	// (vcl)

//-- user supplied -----------------------------------------------------------

namespace Lmdrtsys
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtsys */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTSYS)
using namespace Lmdrtsys;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtsysHPP
