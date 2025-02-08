// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomPanel.pas' rev: 31.00 (Windows)

#ifndef LmdcustompanelHPP
#define LmdcustompanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDCustomControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustompanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomPanel : public Lmdcustomcontrol::TLMDCustomControl
{
	typedef Lmdcustomcontrol::TLMDCustomControl inherited;
	
private:
	bool FLocked;
	HIDESBASE MESSAGE void __fastcall WMMOVE(Winapi::Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	
protected:
	System::Uitypes::TColor __fastcall GetThemedBkColor(void);
	virtual System::Uitypes::TColor __fastcall GetBackColor(void);
	__property Color = {default=-16777201};
	__property bool Locked = {read=FLocked, write=FLocked, default=0};
	__property ParentColor = {default=0};
	
public:
	__fastcall virtual TLMDCustomPanel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomPanel(void);
	virtual bool __fastcall BackBitmapCheck(void);
	virtual Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	virtual System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	virtual bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags = (System::Word)(0x0));
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomPanel(HWND ParentWindow) : Lmdcustomcontrol::TLMDCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustompanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMPANEL)
using namespace Lmdcustompanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustompanelHPP
