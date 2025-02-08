// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBack.pas' rev: 31.00 (Windows)

#ifndef LmdbackHPP
#define LmdbackHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <LMDCustomFormFill.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdback
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBack;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBack : public Lmdcustomformfill::TLMDCustomFormFill
{
	typedef Lmdcustomformfill::TLMDCustomFormFill inherited;
	
protected:
	virtual bool __fastcall PaintClientArea(HDC DC);
	
__published:
	__property About = {default=0};
	__property DefaultFill = {default=1};
	__property Enabled = {default=1};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property PaintMode = {default=1};
public:
	/* TLMDCustomFormFill.Create */ inline __fastcall virtual TLMDBack(System::Classes::TComponent* AOwner) : Lmdcustomformfill::TLMDCustomFormFill(AOwner) { }
	/* TLMDCustomFormFill.Destroy */ inline __fastcall virtual ~TLMDBack(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdback */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBACK)
using namespace Lmdback;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbackHPP
