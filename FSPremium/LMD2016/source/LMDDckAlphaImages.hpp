// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDckAlphaImages.pas' rev: 31.00 (Windows)

#ifndef LmddckalphaimagesHPP
#define LmddckalphaimagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ImgList.hpp>
#include <System.ImageList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddckalphaimages
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAlphaImageList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAlphaImageList : public Vcl::Controls::TImageList
{
	typedef Vcl::Controls::TImageList inherited;
	
protected:
	virtual void __fastcall DoDraw(int Index, Vcl::Graphics::TCanvas* Canvas, int X, int Y, unsigned Style, bool Enabled = true);
	
public:
	__fastcall virtual TLMDAlphaImageList(System::Classes::TComponent* AOwner);
	void __fastcall AddAsDisabled(TLMDAlphaImageList* ASource);
	
__published:
	__property ColorDepth = {default=6};
public:
	/* TCustomImageList.CreateSize */ inline __fastcall TLMDAlphaImageList(int AWidth, int AHeight) : Vcl::Controls::TImageList(AWidth, AHeight) { }
	/* TCustomImageList.Destroy */ inline __fastcall virtual ~TLMDAlphaImageList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddckalphaimages */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDCKALPHAIMAGES)
using namespace Lmddckalphaimages;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddckalphaimagesHPP
