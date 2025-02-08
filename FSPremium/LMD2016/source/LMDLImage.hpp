// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLImage.pas' rev: 31.00 (Windows)

#ifndef LmdlimageHPP
#define LmdlimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomLImage.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseImage.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGraph.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLImage : public Lmdcustomlimage::TLMDCustomLImage
{
	typedef Lmdcustomlimage::TLMDCustomLImage inherited;
	
protected:
	virtual void __fastcall Paint(void);
	
__published:
	__property ForceTransparent = {index=0, default=0};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property SilentMove = {index=1, default=0};
	__property Style = {default=0};
	__property Transparent = {default=1};
public:
	/* TLMDCustomLImage.Create */ inline __fastcall virtual TLMDLImage(System::Classes::TComponent* AOwner) : Lmdcustomlimage::TLMDCustomLImage(AOwner) { }
	/* TLMDCustomLImage.Destroy */ inline __fastcall virtual ~TLMDLImage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLIMAGE)
using namespace Lmdlimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlimageHPP
