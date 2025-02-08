// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwclearbuttongroup.pas' rev: 6.00

#ifndef wwclearbuttongroupHPP
#define wwclearbuttongroupHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Wwcommon.hpp>	// Pascal unit
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

namespace Wwclearbuttongroup
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwCustomTransparentGroupBox;
class PASCALIMPLEMENTATION TwwCustomTransparentGroupBox : public Stdctrls::TCustomGroupBox 
{
	typedef Stdctrls::TCustomGroupBox inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	
protected:
	bool FTransparent;
	bool FInEraseBkGnd;
	virtual void __fastcall CreateWnd(void);
	void __fastcall ClipChildren(bool Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual bool __fastcall IsTransparent(void);
	
public:
	Variant BasePatch;
	__fastcall virtual TwwCustomTransparentGroupBox(Classes::TComponent* AOwner);
	virtual void __fastcall Invalidate(void);
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TwwCustomTransparentGroupBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwCustomTransparentGroupBox(HWND ParentWindow) : Stdctrls::TCustomGroupBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwclearbuttongroup)

}	/* namespace Wwclearbuttongroup */
using namespace Wwclearbuttongroup;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwclearbuttongroup
