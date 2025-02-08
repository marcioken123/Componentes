// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextShapeHint.pas' rev: 31.00 (Windows)

#ifndef LmdtextshapehintHPP
#define LmdtextshapehintHPP

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
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <LMD3DCaption.hpp>
#include <LMDTextObject.hpp>
#include <LMDText.hpp>
#include <LMDCustomShapeHint.hpp>
#include <LMDShapeHint.hpp>
#include <LMDCustomHint.hpp>
#include <LMDNativeHint.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDGradient.hpp>
#include <LMDShadow.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextshapehint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextShapeHintWindow;
class DELPHICLASS TLMDTextShapeHint;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextShapeHintWindow : public Lmdcustomshapehint::TLMDShapeHintWindow
{
	typedef Lmdcustomshapehint::TLMDShapeHintWindow inherited;
	
protected:
	virtual void __fastcall DrawTextTo(Vcl::Graphics::TCanvas* Canvas, Lmdtypes::TLMDString ACaption, const System::Types::TRect &TextRect);
	virtual void __fastcall GetTextSize(Lmdtypes::TLMDString Caption, System::Types::TRect &aRect);
	
public:
	HIDESBASE TLMDTextShapeHint* __fastcall HintControl(void);
public:
	/* TLMDShapeHintWindow.Create */ inline __fastcall virtual TLMDTextShapeHintWindow(System::Classes::TComponent* AOwner) : Lmdcustomshapehint::TLMDShapeHintWindow(AOwner) { }
	/* TLMDShapeHintWindow.Destroy */ inline __fastcall virtual ~TLMDTextShapeHintWindow(void) { }
	
public:
	/* TLMDBaseHintWindow.CreateCustom */ inline __fastcall TLMDTextShapeHintWindow(System::Classes::TComponent* AOwner, Lmdnativehint::TLMDBaseHint* AHintControl) : Lmdcustomshapehint::TLMDShapeHintWindow(AOwner, AHintControl) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextShapeHintWindow(HWND ParentWindow) : Lmdcustomshapehint::TLMDShapeHintWindow(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDTextShapeHint : public Lmdcustomshapehint::TLMDCustomShapeHint
{
	typedef Lmdcustomshapehint::TLMDCustomShapeHint inherited;
	
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
	__fastcall virtual TLMDTextShapeHint(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTextShapeHint(void);
	
__published:
	__property Enabled = {default=1};
	__property DefaultIcon = {default=2};
	__property DefaultTitle = {default=0};
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
	__property Lmdtext::TLMDGraphicErrorEvent OnGraphicError = {read=FOnGraphicError, write=FOnGraphicError};
	__property Distance = {default=1};
	__property Gradient;
	__property NoseLength = {default=25};
	__property NoseWidth = {default=25};
	__property NoseAngleWidth = {default=25};
	__property Options;
	__property Position = {default=1};
	__property RoundRectWidth = {default=18};
	__property Shadow;
	__property Style = {default=4};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TitleFont3D;
	__property UseGradient = {default=0};
	__property UseSystemShadow = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextshapehint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTSHAPEHINT)
using namespace Lmdtextshapehint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextshapehintHPP
