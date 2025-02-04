// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acCoolBar.pas' rev: 27.00 (Windows)

#ifndef AccoolbarHPP
#define AccoolbarHPP

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
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Accoolbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsCoolBar;
class PASCALIMPLEMENTATION TsCoolBar : public Vcl::Comctrls::TCoolBar
{
	typedef Vcl::Comctrls::TCoolBar inherited;
	
private:
	int FGripIndex;
	System::UnicodeString FGripsection;
	int FGripTexture;
	Scommondata::TsCommonData* FCommonData;
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Message);
	void __fastcall ACPaint(HDC DC = (HDC)(0x0), bool SendUpdated = true);
	bool __fastcall PrepareCache(void);
	HIDESBASE int __fastcall GetCaptionSize(Vcl::Comctrls::TCoolBand* Band);
	HIDESBASE int __fastcall GetCaptionFontHeight(void);
	int __fastcall GetGripSize(Vcl::Comctrls::TCoolBand* Band);
	void __fastcall UpdateGripIndex(void);
	
public:
	__fastcall virtual TsCoolBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsCoolBar(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCoolBar(HWND ParentWindow) : Vcl::Comctrls::TCoolBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Accoolbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACCOOLBAR)
using namespace Accoolbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AccoolbarHPP
