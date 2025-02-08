// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGlobalHotKey.pas' rev: 31.00 (Windows)

#ifndef LmdglobalhotkeyHPP
#define LmdglobalhotkeyHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdglobalhotkey
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGlobalHotKey;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGlobalHotKey : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FActive;
	System::Word FAtom;
	System::Classes::TShortCut FGlobalKey;
	Vcl::Controls::TKeyEvent FOnKeyDown;
	HWND FWndHandle;
	void __fastcall SetEnabled(bool aValue);
	void __fastcall SetHotKey(System::Classes::TShortCut aValue);
	void __fastcall NewWndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDGlobalHotKey(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGlobalHotKey(void);
	
__published:
	__property About = {default=0};
	__property bool Active = {read=FActive, write=SetEnabled, default=1};
	__property System::Classes::TShortCut HotKey = {read=FGlobalKey, write=SetHotKey, nodefault};
	__property Vcl::Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdglobalhotkey */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGLOBALHOTKEY)
using namespace Lmdglobalhotkey;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdglobalhotkeyHPP
