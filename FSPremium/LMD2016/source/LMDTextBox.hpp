// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextBox.pas' rev: 31.00 (Windows)

#ifndef LmdtextboxHPP
#define LmdtextboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <LMDText.hpp>
#include <LMDWriter.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextBox;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextBox : public Lmdtext::TLMDParsedTextList
{
	typedef Lmdtext::TLMDParsedTextList inherited;
	
private:
	int FBorder;
	
protected:
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDTextBox(Lmdtext::TLMDParsedTextList* aParent, int aBorder);
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual Lmdtext::TLMDBaseText* __fastcall Clone(void);
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	__property int Border = {read=FBorder, write=FBorder, nodefault};
public:
	/* TLMDParsedTextList.Destroy */ inline __fastcall virtual ~TLMDTextBox(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTBOX)
using namespace Lmdtextbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextboxHPP
