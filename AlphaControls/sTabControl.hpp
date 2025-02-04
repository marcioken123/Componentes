// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sTabControl.pas' rev: 27.00 (Windows)

#ifndef StabcontrolHPP
#define StabcontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Winapi.CommCtrl.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Stabcontrol
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsTabControl;
class PASCALIMPLEMENTATION TsTabControl : public Vcl::Comctrls::TTabControl
{
	typedef Vcl::Comctrls::TTabControl inherited;
	
protected:
	Acsbutils::TacSpinWnd* BtnSW;
	int CurItem;
	Scommondata::TsCommonData* FCommonData;
	System::UnicodeString ChangedSkinSection;
	System::Types::TRect __fastcall GetClRect(void);
	System::Types::TRect __fastcall TabsRect(void);
	int __fastcall TabRow(int TabIndex);
	void __fastcall CheckUpDown(void);
	
public:
	System::Types::TRect __fastcall PageRect(void);
	System::Types::TRect __fastcall SkinTabRect(int Index, bool Active);
	int __fastcall GetTabUnderMouse(const System::Types::TPoint &p);
	void __fastcall DrawSkinTabs(const Sconst::TCacheInfo &CI);
	void __fastcall DrawSkinTab(int Index, int State, Vcl::Graphics::TBitmap* Bmp, const System::Types::TPoint &OffsetPoint)/* overload */;
	void __fastcall DrawSkinTab(int Index, int State, HDC DC)/* overload */;
	void __fastcall RepaintTab(int i, int State, HDC TabDC = (HDC)(0x0));
	void __fastcall AC_WMPaint(Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AfterConstruction(void);
	__fastcall virtual TsTabControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsTabControl(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsTabControl(HWND ParentWindow) : Vcl::Comctrls::TTabControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Stabcontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_STABCONTROL)
using namespace Stabcontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// StabcontrolHPP
