// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMouseFencer.pas' rev: 31.00 (Windows)

#ifndef LmdmousefencerHPP
#define LmdmousefencerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <LMDMouseBaseCtrl.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmousefencer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMouseFencer;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMouseFencer : public Lmdmousebasectrl::TLMDMouseBaseCtrl
{
	typedef Lmdmousebasectrl::TLMDMouseBaseCtrl inherited;
	
protected:
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual ~TLMDMouseFencer(void);
	bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(const System::Types::TRect &aRect);
	void __fastcall Stop(void);
public:
	/* TLMDMouseBaseCtrl.Create */ inline __fastcall virtual TLMDMouseFencer(System::Classes::TComponent* AOwner) : Lmdmousebasectrl::TLMDMouseBaseCtrl(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmousefencer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMOUSEFENCER)
using namespace Lmdmousefencer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmousefencerHPP
