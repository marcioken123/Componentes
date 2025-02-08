// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSwitch.pas' rev: 31.00 (Windows)

#ifndef LmdswitchHPP
#define LmdswitchHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomSwitch.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.Classes.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdswitch
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSwitch;
class DELPHICLASS TLMDWSwitch;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSwitch : public Lmdcustomswitch::TLMDCustomSwitch
{
	typedef Lmdcustomswitch::TLMDCustomSwitch inherited;
	
__published:
	__property Checked = {default=0};
public:
	/* TLMDCustomSwitch.Create */ inline __fastcall virtual TLMDSwitch(System::Classes::TComponent* AOwner) : Lmdcustomswitch::TLMDCustomSwitch(AOwner) { }
	/* TLMDCustomSwitch.Destroy */ inline __fastcall virtual ~TLMDSwitch(void) { }
	
};


class PASCALIMPLEMENTATION TLMDWSwitch : public Lmdcustomswitch::TLMDWCustomSwitch
{
	typedef Lmdcustomswitch::TLMDWCustomSwitch inherited;
	
__published:
	__property Checked = {default=0};
	__property TabOrder = {default=-1};
public:
	/* TLMDWCustomSwitch.Create */ inline __fastcall virtual TLMDWSwitch(System::Classes::TComponent* AOwner) : Lmdcustomswitch::TLMDWCustomSwitch(AOwner) { }
	/* TLMDWCustomSwitch.Destroy */ inline __fastcall virtual ~TLMDWSwitch(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDWSwitch(HWND ParentWindow) : Lmdcustomswitch::TLMDWCustomSwitch(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdswitch */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSWITCH)
using namespace Lmdswitch;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdswitchHPP
