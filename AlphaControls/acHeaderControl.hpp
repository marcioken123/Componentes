// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acHeaderControl.pas' rev: 27.00 (Windows)

#ifndef AcheadercontrolHPP
#define AcheadercontrolHPP

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
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acheadercontrol
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsHeaderControl;
class PASCALIMPLEMENTATION TsHeaderControl : public Vcl::Comctrls::THeaderControl
{
	typedef Vcl::Comctrls::THeaderControl inherited;
	
private:
	Scommondata::TsCommonData* FCommonData;
	
protected:
	int CurItem;
	int PressedItem;
	int IndexLeft;
	int IndexRight;
	int IndexAlone;
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TMessage &Message);
	void __fastcall PrepareCache(void);
	void __fastcall PaintItems(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	int __fastcall GetItemUnderMouse(const System::Types::TPoint &p);
	
public:
	__fastcall virtual TsHeaderControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsHeaderControl(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AfterConstruction(void);
	
__published:
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsHeaderControl(HWND ParentWindow) : Vcl::Comctrls::THeaderControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Acheadercontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACHEADERCONTROL)
using namespace Acheadercontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcheadercontrolHPP
