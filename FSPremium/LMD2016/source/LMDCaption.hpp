// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCaption.pas' rev: 31.00 (Windows)

#ifndef LmdcaptionHPP
#define LmdcaptionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraph.hpp>
#include <LMDFXCaption.hpp>
#include <LMDObject.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcaption
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCaption;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCaption : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdgraph::TLMDAlignment FAlignment;
	Vcl::Controls::TCaption FCaption;
	Vcl::Graphics::TFont* FFont;
	Lmdfxcaption::TLMDFxCaption* FFontFx;
	bool FMultiLine;
	bool FDefault;
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	void __fastcall SetCaption(Vcl::Controls::TCaption aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetFontFx(Lmdfxcaption::TLMDFxCaption* aValue);
	void __fastcall SetMultiLine(bool aValue);
	
protected:
	void __fastcall InitAttributes(void);
	void __fastcall FontChanged(System::TObject* Sender);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCaption(System::Classes::TPersistent* Owner);
	__fastcall TLMDCaption(System::UnicodeString aValue, System::UnicodeString aFontName, int aFontSize, System::Uitypes::TColor aFontColor, System::Classes::TNotifyEvent aNotify);
	__fastcall virtual ~TLMDCaption(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	void __fastcall DrawCaption(Vcl::Graphics::TCanvas* aCanvas, System::UnicodeString aCaption, const System::Types::TRect &aRect, Lmdgraph::TLMDDrawTextStyles extflags, System::Uitypes::TColor BackColor, int pos);
	__property bool Default = {read=FDefault, write=FDefault, nodefault};
	
__published:
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=4};
	__property Vcl::Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Lmdfxcaption::TLMDFxCaption* FontFX = {read=FFontFx, write=SetFontFx};
	__property bool MultiLine = {read=FMultiLine, write=SetMultiLine, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcaption */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCAPTION)
using namespace Lmdcaption;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcaptionHPP
