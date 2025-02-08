// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomGlyphLabel.pas' rev: 31.00 (Windows)

#ifndef LmdcustomglyphlabelHPP
#define LmdcustomglyphlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraph.hpp>
#include <LMDBevel.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomglyphlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomGlyphLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomGlyphLabel : public Lmdbaselabel::TLMDBaseLabel
{
	typedef Lmdbaselabel::TLMDBaseLabel inherited;
	
private:
	Lmdglyphtextlayout::TLMDGlyphTextLayout* FGlyphTextLayout;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	Lmdbevel::TLMDBevel* FBevel;
	System::Byte FGlyphNumber;
	System::Byte FGlyphColumn;
	void __fastcall SetGlyphText(Lmdglyphtextlayout::TLMDGlyphTextLayout* aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetGlyphColumn(const System::Byte Value);
	void __fastcall SetGlyphNumber(const System::Byte Value);
	
protected:
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	virtual bool __fastcall GetStatusControl(void);
	virtual void __fastcall Paint(void);
	__property System::Byte GlyphNumber = {read=FGlyphNumber, write=SetGlyphNumber, default=1};
	__property System::Byte GlyphColumn = {read=FGlyphColumn, write=SetGlyphColumn, default=0};
	
public:
	__fastcall virtual TLMDCustomGlyphLabel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomGlyphLabel(void);
	virtual void __fastcall CorrectBounds(void);
	__property Lmdglyphtextlayout::TLMDGlyphTextLayout* Alignment = {read=FGlyphTextLayout, write=SetGlyphText};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomglyphlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMGLYPHLABEL)
using namespace Lmdcustomglyphlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomglyphlabelHPP
