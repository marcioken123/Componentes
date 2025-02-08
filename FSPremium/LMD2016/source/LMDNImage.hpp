// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDNImage.pas' rev: 31.00 (Windows)

#ifndef LmdnimageHPP
#define LmdnimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomNImage.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdnimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDNImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDNImage : public Lmdcustomnimage::TLMDCustomNImage
{
	typedef Lmdcustomnimage::TLMDCustomNImage inherited;
	
__published:
	__property Bitmap;
	__property Control;
public:
	/* TLMDCustomNImage.Create */ inline __fastcall virtual TLMDNImage(System::Classes::TComponent* AOwner) : Lmdcustomnimage::TLMDCustomNImage(AOwner) { }
	/* TLMDCustomNImage.Destroy */ inline __fastcall virtual ~TLMDNImage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdnimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDNIMAGE)
using namespace Lmdnimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdnimageHPP
