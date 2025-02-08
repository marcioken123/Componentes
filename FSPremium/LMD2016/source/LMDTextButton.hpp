// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextButton.pas' rev: 31.00 (Windows)

#ifndef LmdtextbuttonHPP
#define LmdtextbuttonHPP

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
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomButton.hpp>
#include <LMDText.hpp>
#include <LMDTextObject.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextButton : public Lmdcustombutton::TLMDCustomButton
{
	typedef Lmdcustombutton::TLMDCustomButton inherited;
	
private:
	Lmdtextobject::TLMDTextObject* FText;
	bool FWordWrap;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	void __fastcall SetTextObject(Lmdtextobject::TLMDTextObject* aValue);
	HIDESBASE MESSAGE void __fastcall CMTEXTCHANGED(Winapi::Messages::TMessage &Msg);
	
protected:
	virtual System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	virtual void __fastcall DrawCaptionAndGlyph(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, int flags);
	void __fastcall DoTxtChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDTextButton(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextButton(void);
	virtual void __fastcall Loaded(void);
	
__published:
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property DropDownMenu;
	__property DropDownIndent = {default=0};
	__property DropDownRight = {default=0};
	__property OnDropDown;
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextButton(HWND ParentWindow) : Lmdcustombutton::TLMDCustomButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTBUTTON)
using namespace Lmdtextbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextbuttonHPP
