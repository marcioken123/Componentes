// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwclearpanel.pas' rev: 6.00

#ifndef wwclearpanelHPP
#define wwclearpanelHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ExtCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <CommCtrl.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwclearpanel
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwCustomTransparentPanel;
class PASCALIMPLEMENTATION TwwCustomTransparentPanel : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	
protected:
	bool FTransparent;
	bool FInEraseBkGnd;
	void __fastcall ClipChildren(bool Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual bool __fastcall IsTransparent(void);
	
public:
	Variant BasePatch;
	__fastcall virtual TwwCustomTransparentPanel(Classes::TComponent* AOwner);
	virtual void __fastcall Invalidate(void);
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TwwCustomTransparentPanel(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwCustomTransparentPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TfcTransparentPanel;
class PASCALIMPLEMENTATION TfcTransparentPanel : public TwwCustomTransparentPanel 
{
	typedef TwwCustomTransparentPanel inherited;
	
__published:
	__property Align  = {default=0};
	__property BevelInner  = {default=0};
	__property BevelOuter  = {default=2};
	__property BevelWidth  = {default=1};
	__property BorderStyle  = {default=0};
	__property BorderWidth  = {default=0};
	__property Color  = {default=-16777201};
	__property Transparent  = {default=0};
public:
	#pragma option push -w-inl
	/* TwwCustomTransparentPanel.Create */ inline __fastcall virtual TfcTransparentPanel(Classes::TComponent* AOwner) : TwwCustomTransparentPanel(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfcTransparentPanel(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfcTransparentPanel(HWND ParentWindow) : TwwCustomTransparentPanel(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwclearpanel)

}	/* namespace Wwclearpanel */
using namespace Wwclearpanel;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwclearpanel
