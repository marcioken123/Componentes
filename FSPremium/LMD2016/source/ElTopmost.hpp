// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTopmost.pas' rev: 31.00 (Windows)

#ifndef EltopmostHPP
#define EltopmostHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <LMDDebugUnit.hpp>
#include <ElComponent.hpp>
#include <ElHook.hpp>
#include <LMDUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltopmost
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTopmost;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElTopmost : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	bool FTopMost;
	Elhook::TElHook* FHook;
	void __fastcall OnHook(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall OnAfterHook(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall SetTopMost(bool newValue);
	void __fastcall UpdateTopmost(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TElTopmost(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTopmost(void);
	
__published:
	__property bool TopMost = {read=FTopMost, write=SetTopMost, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltopmost */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTOPMOST)
using namespace Eltopmost;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltopmostHPP
