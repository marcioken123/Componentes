// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShadowFill.pas' rev: 31.00 (Windows)

#ifndef LmdshadowfillHPP
#define LmdshadowfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshadowfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShadowFill;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShadowFillStyle : unsigned char { sfNone, sfShadow, sfFullShadow };

class PASCALIMPLEMENTATION TLMDShadowFill : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	System::Uitypes::TColor FShadowColor;
	Vcl::Graphics::TBitmap* FBrushBitmap;
	TLMDShadowFillStyle FFillMode;
	HIDESBASE void __fastcall SetColor(System::Uitypes::TColor aColor);
	void __fastcall SetShadowMode(TLMDShadowFillStyle aValue);
	
protected:
	virtual bool __fastcall GetEmpty(void);
	
public:
	__fastcall virtual TLMDShadowFill(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShadowFill(void);
	virtual void __fastcall Paint(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Bevel;
	__property ParentShowHint = {default=1};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=SetColor, default=0};
	__property ShowHint;
	__property TLMDShadowFillStyle Style = {read=FFillMode, write=SetShadowMode, default=1};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property Constraints;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshadowfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHADOWFILL)
using namespace Lmdshadowfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshadowfillHPP
