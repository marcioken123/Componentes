// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextRadioButton.pas' rev: 31.00 (Windows)

#ifndef LmdtextradiobuttonHPP
#define LmdtextradiobuttonHPP

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
#include <LMDTextObject.hpp>
#include <LMDText.hpp>
#include <LMDRadioButton.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDGraph.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextradiobutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextRadioButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextRadioButton : public Lmdradiobutton::TLMDRadioButton
{
	typedef Lmdradiobutton::TLMDRadioButton inherited;
	
private:
	Lmdtextobject::TLMDTextObject* FText;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	void __fastcall SetTextObject(Lmdtextobject::TLMDTextObject* aValue);
	
protected:
	virtual void __fastcall DoTxtChange(System::TObject* Sender);
	virtual System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	virtual void __fastcall DrawFace(Vcl::Graphics::TCanvas* aCanvas, const System::UnicodeString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aDest, Vcl::Graphics::TCanvas* srcCanvas, System::Types::TRect &srcRect, Vcl::Graphics::TCanvas* aMaskCanvas, System::Uitypes::TColor TransColor, Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout, bool MultiLine, bool Accel, bool Transparent, Lmdgraph::TLMDDrawTextStyles ExtFlags, int flags);
	
public:
	__fastcall virtual TLMDTextRadioButton(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextRadioButton(void);
	
__published:
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextRadioButton(HWND ParentWindow) : Lmdradiobutton::TLMDRadioButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextradiobutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTRADIOBUTTON)
using namespace Lmdtextradiobutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextradiobuttonHPP
