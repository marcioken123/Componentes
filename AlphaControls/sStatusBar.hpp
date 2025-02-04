// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sStatusBar.pas' rev: 27.00 (Windows)

#ifndef SstatusbarHPP
#define SstatusbarHPP

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
#include <sConst.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sstatusbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsStatusBar;
class PASCALIMPLEMENTATION TsStatusBar : public Vcl::Comctrls::TStatusBar
{
	typedef Vcl::Comctrls::TStatusBar inherited;
	
private:
	Scommondata::TsCommonData* FCommonData;
	
protected:
	void __fastcall PaintGrip(void);
	void __fastcall PaintPanels(void);
	int __fastcall PanelOffset(int k);
	HIDESBASE void __fastcall DrawPanel(Vcl::Comctrls::TStatusPanel* Panel, const System::Types::TRect &Rect);
	void __fastcall InternalDrawPanel(Vcl::Comctrls::TStatusPanel* Panel, const System::UnicodeString Text, const System::Types::TRect &Rect);
	void __fastcall DoDrawText(const System::UnicodeString Text, System::Types::TRect &Rect, int Flags);
	bool __fastcall PrepareCache(void);
	void __fastcall OurPaintHandler(HDC MsgDC);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall PaintWindow(HDC DC);
	
public:
	__fastcall virtual TsStatusBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsStatusBar(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AfterConstruction(void);
	
__published:
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsStatusBar(HWND ParentWindow) : Vcl::Comctrls::TStatusBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sstatusbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSTATUSBAR)
using namespace Sstatusbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SstatusbarHPP
