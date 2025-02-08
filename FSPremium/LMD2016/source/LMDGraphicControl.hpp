// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGraphicControl.pas' rev: 31.00 (Windows)

#ifndef LmdgraphiccontrolHPP
#define LmdgraphiccontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDBase.hpp>
#include <LMDBevel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgraphiccontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGraphicControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGraphicControl : public Lmdbasegraphiccontrol::TLMDBaseGraphicControl
{
	typedef Lmdbasegraphiccontrol::TLMDBaseGraphicControl inherited;
	
private:
	Lmdbevel::TLMDBevel* FBevel;
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	
protected:
	int __fastcall BevelExt(void);
	int __fastcall DblBevelExt(void);
	System::Types::TRect __fastcall BeveledRect(void);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDGraphicControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGraphicControl(void);
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdgraphiccontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRAPHICCONTROL)
using namespace Lmdgraphiccontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgraphiccontrolHPP
