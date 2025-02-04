// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sDefaults.pas' rev: 27.00 (Windows)

#ifndef SdefaultsHPP
#define SdefaultsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sdefaults
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TacThirdPartyTypes : unsigned char { tpEdit, tpButton, tpBitBtn, tpCheckBox, tpComboBox, tpGrid, tpGroupBox, tpListView, tpPanel, tpTreeView, tpwwEdit, tpGridEh, tpVirtualTree, tpPageControl, tpTabControl, tpToolBar, tpStatusBar, tpSpeedButton, tpScrollControl, tpUpDownBtn, tpScrollBar, tpStaticText, tpNativePaint };

typedef System::StaticArray<System::UnicodeString, 23> Sdefaults__1;

typedef System::StaticArray<System::UnicodeString, 23> Sdefaults__2;

//-- var, const, procedure ---------------------------------------------------
static const TacThirdPartyTypes acLastSupportedType = (TacThirdPartyTypes)(22);
static const System::WideChar sl_Third_Edit = (System::WideChar)(0x20);
static const System::WideChar sl_Third_Panel = (System::WideChar)(0x20);
#define sl_Third_Button L"TButton"
static const System::WideChar sl_Third_BitBtn = (System::WideChar)(0x20);
static const System::WideChar sl_Third_CheckBox = (System::WideChar)(0x20);
static const System::WideChar sl_Third_GroupBox = (System::WideChar)(0x20);
static const System::WideChar sl_Third_Grid = (System::WideChar)(0x20);
static const System::WideChar sl_Third_TreeView = (System::WideChar)(0x20);
static const System::WideChar sl_Third_ComboBox = (System::WideChar)(0x20);
static const System::WideChar sl_Third_ListView = (System::WideChar)(0x20);
static const System::WideChar sl_Third_WWEdit = (System::WideChar)(0x20);
static const System::WideChar sl_Third_GridEH = (System::WideChar)(0x20);
static const System::WideChar sl_Third_VirtualTree = (System::WideChar)(0x20);
static const System::WideChar sl_Third_PageControl = (System::WideChar)(0x20);
static const System::WideChar sl_Third_TabControl = (System::WideChar)(0x20);
static const System::WideChar sl_Third_ToolBar = (System::WideChar)(0x20);
static const System::WideChar sl_Third_StatusBar = (System::WideChar)(0x20);
static const System::WideChar sl_Third_SpeedButton = (System::WideChar)(0x20);
static const System::WideChar sl_Third_ScrollControl = (System::WideChar)(0x20);
static const System::WideChar sl_Third_UpDownBtn = (System::WideChar)(0x20);
static const System::WideChar sl_Third_ScrollBar = (System::WideChar)(0x20);
static const System::WideChar sl_Third_WebBrowser = (System::WideChar)(0x20);
static const System::WideChar sl_Third_StaticText = (System::WideChar)(0x20);
static const System::WideChar sl_Third_NativePaint = (System::WideChar)(0x20);
extern DELPHI_PACKAGE Sdefaults__1 acThirdNames;
extern DELPHI_PACKAGE Sdefaults__2 acThirdCaptions;
#define DefSkinsDir L"c:\\Skins"
#define DefDisabledGlyphKind (System::Set<Sconst::Sconst__3, Sconst::Sconst__3::dgBlended, Sconst::Sconst__3::dgGrayed>() << Sconst::Sconst__3::dgBlended )
#define DefDisabledKind (System::Set<Sconst::Sconst__4, Sconst::Sconst__4::dkBlended, Sconst::Sconst__4::dkGrayed>() << Sconst::Sconst__4::dkBlended )
static const bool DefMakeSkinMenu = false;
#define DefWeekends (System::Set<System::Uitypes::TCalDayOfWeek, System::Uitypes::TCalDayOfWeek::dowMonday, System::Uitypes::TCalDayOfWeek::dowLocaleDefault>() << System::Uitypes::TCalDayOfWeek::dowSunday )
extern DELPHI_PACKAGE bool ACPngFirst;
extern DELPHI_PACKAGE double DefDisabledBlend;
extern DELPHI_PACKAGE int DefDisabledSaturation;
}	/* namespace Sdefaults */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SDEFAULTS)
using namespace Sdefaults;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SdefaultsHPP
