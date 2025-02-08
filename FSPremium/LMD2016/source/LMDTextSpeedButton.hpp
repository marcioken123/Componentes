// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextSpeedButton.pas' rev: 31.00 (Windows)

#ifndef LmdtextspeedbuttonHPP
#define LmdtextspeedbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDButtonBase.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDTextObject.hpp>
#include <LMDText.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextspeedbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextSpeedButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextSpeedButton : public Lmdcustomspeedbutton::TLMDCustomSpeedButton
{
	typedef Lmdcustomspeedbutton::TLMDCustomSpeedButton inherited;
	
private:
	Lmdtextobject::TLMDTextObject* FText;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	void __fastcall SetTextObject(Lmdtextobject::TLMDTextObject* aValue);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall DrawGlyphAndText(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	virtual System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	void __fastcall DoTxtChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDTextSpeedButton(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextSpeedButton(void);
	virtual void __fastcall Loaded(void);
	
__published:
	__property Align = {default=0};
	__property ButtonStyle = {default=1};
	__property AllowAllUp = {default=0};
	__property GroupIndex = {default=0};
	__property MultiLine = {default=0};
	__property Pressed = {default=0};
	__property DropDownCombo = {default=0};
	__property DropDownComboWidth = {default=12};
	__property DropDownMenu;
	__property DropDownIndent = {default=0};
	__property DropDownRight = {default=0};
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextspeedbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTSPEEDBUTTON)
using namespace Lmdtextspeedbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextspeedbuttonHPP
