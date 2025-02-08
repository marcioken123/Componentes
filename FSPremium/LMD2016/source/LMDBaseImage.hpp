// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseImage.pas' rev: 31.00 (Windows)

#ifndef LmdbaseimageHPP
#define LmdbaseimageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbaseimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBaseImage : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	bool FQuickDraw;
	Lmdgraph::TLMDBitmapStyle FStyle;
	void __fastcall SetQuickDraw(bool aValue);
	void __fastcall SetStyle(Lmdgraph::TLMDBitmapStyle aValue);
	
protected:
	virtual bool __fastcall CorrectBounds(void);
	void __fastcall AddStyleFlags(System::Word &Flags);
	__property Lmdgraph::TLMDBitmapStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool QuickDraw = {read=FQuickDraw, write=SetQuickDraw, default=1};
	
public:
	__fastcall virtual TLMDBaseImage(System::Classes::TComponent* AOwner);
	
__published:
	__property About = {default=0};
public:
	/* TLMDGraphicControl.Destroy */ inline __fastcall virtual ~TLMDBaseImage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbaseimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASEIMAGE)
using namespace Lmdbaseimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbaseimageHPP
