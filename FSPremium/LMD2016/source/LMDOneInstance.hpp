// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDOneInstance.pas' rev: 31.00 (Windows)

#ifndef LmdoneinstanceHPP
#define LmdoneinstanceHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdoneinstance
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDOneInstance;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDOneInstanceMode : unsigned char { oiActivateOnly, oiDefaultMessage, oiCustom };

class PASCALIMPLEMENTATION TLMDOneInstance : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDOneInstanceMode FMode;
	bool FEnabled;
	System::Classes::TNotifyEvent FCustomEvent;
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDOneInstance(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDOneInstance(void);
	
__published:
	__property About = {default=0};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property TLMDOneInstanceMode Mode = {read=FMode, write=FMode, default=0};
	__property System::Classes::TNotifyEvent OnCustom = {read=FCustomEvent, write=FCustomEvent};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdoneinstance */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDONEINSTANCE)
using namespace Lmdoneinstance;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdoneinstanceHPP
