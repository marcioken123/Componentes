// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextHint.pas' rev: 31.00 (Windows)

#ifndef LmdtexthintHPP
#define LmdtexthintHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTextObject.hpp>
#include <LMDText.hpp>
#include <LMDCustomHint.hpp>
#include <LMDHint.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDNativeHint.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtexthint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextHintWindow;
class DELPHICLASS TLMDTextHint;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextHintWindow : public Lmdcustomhint::TLMDCustomHintWindow
{
	typedef Lmdcustomhint::TLMDCustomHintWindow inherited;
	
protected:
	virtual void __fastcall DrawTextTo(Vcl::Graphics::TCanvas* Canvas, System::UnicodeString Caption, const System::Types::TRect &TextRect);
	virtual void __fastcall GetTextSize(System::UnicodeString Caption, System::Types::TRect &aRect);
	HIDESBASE TLMDTextHint* __fastcall HintControl(void);
public:
	/* TLMDCustomHintWindow.Create */ inline __fastcall virtual TLMDTextHintWindow(System::Classes::TComponent* AOwner) : Lmdcustomhint::TLMDCustomHintWindow(AOwner) { }
	
public:
	/* TLMDBaseHintWindow.CreateCustom */ inline __fastcall TLMDTextHintWindow(System::Classes::TComponent* AOwner, Lmdnativehint::TLMDBaseHint* AHintControl) : Lmdcustomhint::TLMDCustomHintWindow(AOwner, AHintControl) { }
	/* TLMDBaseHintWindow.Destroy */ inline __fastcall virtual ~TLMDTextHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextHintWindow(HWND ParentWindow) : Lmdcustomhint::TLMDCustomHintWindow(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDTextHint : public Lmdcustomhint::TLMDCustomHint
{
	typedef Lmdcustomhint::TLMDCustomHint inherited;
	
private:
	Lmdtextobject::TLMDTextObject* FText;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	Lmdtext::TLMDGraphicErrorEvent FOnGraphicError;
	void __fastcall SetTextObject(Lmdtextobject::TLMDTextObject* aValue);
	
protected:
	virtual Vcl::Controls::THintWindowClass __fastcall GetHintClass(void);
	void __fastcall DoGraphicError(System::TObject* Sender, Vcl::Graphics::TPicture* aPicture, const System::UnicodeString aFileName, int aImageIndex);
	System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	
public:
	__fastcall virtual TLMDTextHint(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTextHint(void);
	
__published:
	__property About = {default=0};
	__property Bevel;
	__property Color = {default=-16777192};
	__property Enabled = {default=1};
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
	__property Lmdtext::TLMDGraphicErrorEvent OnGraphicError = {read=FOnGraphicError, write=FOnGraphicError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtexthint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTHINT)
using namespace Lmdtexthint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtexthintHPP
