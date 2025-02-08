// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMousePositioner.pas' rev: 31.00 (Windows)

#ifndef LmdmousepositionerHPP
#define LmdmousepositionerHPP

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
#include <LMDMouseBaseCtrl.hpp>
#include <LMDGraph.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmousepositioner
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMousePositioner;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMousePositioner : public Lmdmousebasectrl::TLMDMouseBaseCtrl
{
	typedef Lmdmousebasectrl::TLMDMouseBaseCtrl inherited;
	
private:
	Lmdgraph::TLMDAlignment FPosition;
	System::Types::TPoint __fastcall GetAutoPosition(const System::Types::TRect &aRect);
	void __fastcall SetPosition(Lmdgraph::TLMDAlignment aValue);
	
protected:
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDMousePositioner(System::Classes::TComponent* AOwner);
	bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(int X, int Y);
	
__published:
	__property Lmdgraph::TLMDAlignment Position = {read=FPosition, write=SetPosition, default=4};
public:
	/* TLMDMouseBaseCtrl.Destroy */ inline __fastcall virtual ~TLMDMousePositioner(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmousepositioner */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMOUSEPOSITIONER)
using namespace Lmdmousepositioner;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmousepositionerHPP
