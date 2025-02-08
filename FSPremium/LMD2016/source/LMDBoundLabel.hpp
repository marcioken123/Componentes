// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBoundLabel.pas' rev: 31.00 (Windows)

#ifndef LmdboundlabelHPP
#define LmdboundlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBase.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdboundlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBoundLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBoundLabel : public Lmdcustomsimplelabel::TLMDCustomSimpleLabel
{
	typedef Lmdcustomsimplelabel::TLMDCustomSimpleLabel inherited;
	
private:
	int __fastcall GetTop(void);
	int __fastcall GetLeft(void);
	int __fastcall GetWidth(void);
	int __fastcall GetHeight(void);
	HIDESBASE void __fastcall SetWidth(const int Value);
	HIDESBASE void __fastcall SetHeight(const int Value);
	bool __fastcall IsNotParent(void);
	System::Uitypes::TAnchors __fastcall GetAnchors(void);
	Vcl::Controls::TSizeConstraints* __fastcall GetConstraints(void);
	
public:
	virtual void __fastcall CorrectBounds(void);
	__fastcall virtual TLMDBoundLabel(System::Classes::TComponent* AOwner);
	
__published:
	__property Alignment = {default=3};
	__property Caption = {default=0};
	__property FocusControl = {stored=IsNotParent};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property int Left = {read=GetLeft, nodefault};
	__property int Top = {read=GetTop, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
	__property System::Uitypes::TAnchors Anchors = {read=GetAnchors, nodefault};
	__property Vcl::Controls::TSizeConstraints* Constraints = {read=GetConstraints};
public:
	/* TLMDCustomSimpleLabel.Destroy */ inline __fastcall virtual ~TLMDBoundLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdboundlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBOUNDLABEL)
using namespace Lmdboundlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdboundlabelHPP
